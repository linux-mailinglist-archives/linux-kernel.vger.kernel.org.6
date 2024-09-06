Return-Path: <linux-kernel+bounces-319522-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B9C296FDDC
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Sep 2024 00:17:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D522D1F24303
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 22:17:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C953E155A59;
	Fri,  6 Sep 2024 22:17:26 +0000 (UTC)
Received: from mail78-36.sinamail.sina.com.cn (mail78-36.sinamail.sina.com.cn [219.142.78.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 953E31B85D9
	for <linux-kernel@vger.kernel.org>; Fri,  6 Sep 2024 22:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=219.142.78.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725661046; cv=none; b=nL2PUtD7FvVLzYi5w55EErJ+4HBGLmUXLJpxXGggCh/M4XYWo/4ZBTmsmum05R2512B2w0ie1hgMxR5tgedlFnui+tGKBc10KyHTMdg/H2czLupurehzNz+VMpF6AUKNsAPjGQYCv/4i2PJFx8f8ws5KVRCv6SEKBgt9bjpxAss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725661046; c=relaxed/simple;
	bh=CGPUl/gZ50PuyC+ib9ypM0DRXzMScW15aObsCnYi7Xk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Iq4A7zemN+vfNCE/SKB6P/Ft+tIpJeZ5cq5ZObUrmLdt5oG32fqIKW23GC/rvT8/F6b2+UzXmU66ByTSS1koF5p5cIstRpmkqYkmW8Nu7iF14zy3sAb5pJ9pTei1vQ6Znu0BEDIUni4S3keCGClW9L5iN5hvys5xeghtkiGEt3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; arc=none smtp.client-ip=219.142.78.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([113.118.69.150])
	by sina.com (10.185.250.24) with ESMTP
	id 66DB7F640000370A; Fri, 7 Sep 2024 06:17:10 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 9042510748451
X-SMAIL-UIID: 895FC86F443B417787E1DC98DDBA0694-20240907-061710-1
From: Hillf Danton <hdanton@sina.com>
To: syzbot <syzbot+f82b36bffae7ef78b6a7@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [fs?] KASAN: slab-use-after-free Read in lockref_get_not_dead (2)
Date: Sat,  7 Sep 2024 06:16:58 +0800
Message-Id: <20240906221658.2144-1-hdanton@sina.com>
In-Reply-To: <000000000000af47d506216f5b6e@google.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Fri, 06 Sep 2024 01:40:23 -0700
> syzbot found the following issue on:
> 
> HEAD commit:    9b0874286768 Merge branch 'mctp-serial-tx-escapes'
> git tree:       net
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1627ab2b980000

#syz test

--- x/fs/libfs.c
+++ y/fs/libfs.c
@@ -2234,6 +2234,7 @@ int path_from_stashed(struct dentry **st
 	path->dentry = stash_dentry(stashed, dentry);
 	if (path->dentry != dentry)
 		dput(dentry);
+	dget(dentry);
 
 out_path:
 	WARN_ON_ONCE(path->dentry->d_fsdata != stashed);
@@ -2258,5 +2259,6 @@ void stashed_dentry_prune(struct dentry
 	 * already cleared out @dentry and stashed their own
 	 * dentry in there.
 	 */
-	cmpxchg(stashed, dentry, NULL);
+	if (dentry == cmpxchg(stashed, dentry, NULL))
+		dput(dentry);
 }
--

