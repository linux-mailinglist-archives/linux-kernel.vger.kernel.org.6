Return-Path: <linux-kernel+bounces-514837-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 35A7EA35C5B
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 12:20:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EDB8016E294
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 11:20:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 117ED263C7C;
	Fri, 14 Feb 2025 11:19:57 +0000 (UTC)
Received: from mail78-59.sinamail.sina.com.cn (mail78-59.sinamail.sina.com.cn [219.142.78.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3770522D793
	for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 11:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=219.142.78.59
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739531996; cv=none; b=N39A6GzIfu3YLNIbeV7vJs2KYPtuzErBO9RMTdsjlQdcYWXe1MH5RtK3rJ20VVAYr+t900YZWhbr28Szr2W9+GO/ViERkpgebbGKjohrcoiOjZq2omg6tM682EOM5dcwv56M1/jQ8pJZY5H35N7CG3vduvh1IDnT2kpXv4pDc/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739531996; c=relaxed/simple;
	bh=kCiaoqVGMtRRyZ3Plxx+d8Hk0iILnb50XoSXLMuk5Vw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uw0JEnIyw90wkyqFobjyqfpGTD18aUiFVWe0W6LdoK/37e589R1nQRtta+xrPvUVKZQ4BLKko2LWVIEeeFDL0Xv85ZB6EwY7NZKVrkMAGNxDriMJmPLxAyZ16GndftpAzi11iciwCJ0xxCPHCCoWnc+Xe9vN008hPGYCzhtHNgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; arc=none smtp.client-ip=219.142.78.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([116.24.10.141])
	by sina.com (10.185.250.24) with ESMTP
	id 67AF26C80000540B; Fri, 14 Feb 2025 19:19:39 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 82597310748366
X-SMAIL-UIID: 056145AE50A7447B9E880A924A6E2B12-20250214-191939-1
From: Hillf Danton <hdanton@sina.com>
To: syzbot <syzbot+d9890527385ab9767e03@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [netfs?] WARNING: refcount bug in netfs_put_subrequest
Date: Fri, 14 Feb 2025 19:19:25 +0800
Message-ID: <20250214111926.2252-1-hdanton@sina.com>
In-Reply-To: <67aee51d.050a0220.21dd3.002f.GAE@google.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, 13 Feb 2025 22:39:25 -0800
> syzbot found the following issue on:
> 
> HEAD commit:    69b54314c975 Merge tag 'kbuild-fixes-v6.14' of git://git.k..
> git tree:       upstream
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=13aafdf8580000

#syz test upstream   master

--- x/fs/netfs/read_collect.c
+++ y/fs/netfs/read_collect.c
@@ -289,6 +289,10 @@ reassess:
 		/* Remove if completely consumed. */
 		stream->source = front->source;
 		spin_lock(&rreq->lock);
+		if (front != stream->front) {
+			spin_unlock(&rreq->lock);
+			goto reassess;
+		}
 
 		remove = front;
 		trace_netfs_sreq(front, netfs_sreq_trace_discard);
--

