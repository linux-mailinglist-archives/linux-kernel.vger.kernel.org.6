Return-Path: <linux-kernel+bounces-449044-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0208C9F48F3
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 11:33:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 489561678FC
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 10:33:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A06FE1E0DB0;
	Tue, 17 Dec 2024 10:33:48 +0000 (UTC)
Received: from mail115-76.sinamail.sina.com.cn (mail115-76.sinamail.sina.com.cn [218.30.115.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFA361D5CFD
	for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2024 10:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=218.30.115.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734431628; cv=none; b=h3ORDHUL+Nvf6Mhc00cJG8wxgRB+VRNQdphV1AHSfbjLZGuUuUtAD57itTc7FVmNs/ppz5Fu/MlCuN6rTOgJXSDEXbdQcHjHU+00NboxMBYFogxN+CO6jomwG3eqS0bMzF2b0r3nCv9jGHvzMyF3eZJ3uTG4qsugh6Su5bpTiAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734431628; c=relaxed/simple;
	bh=MVCAZuOwLya1jdzSAEEq1H1F3q4QH9kw2z/DMiFFPYY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oSiBipHa5F9YOLovtmzfJeDzSgmyzbOmfyChbl1CGtCQx5PCpWmYmQQilKEGncH0ldKjWzXbAb2uWMfn4nGy/g4QDzCQInqKnupzjnbeRnL7w23Si1i+iJCSTt3errM1jHU2h/z6op6RcwaXjwSgYOq/1P3brONQcgzZ9Vw7BEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; arc=none smtp.client-ip=218.30.115.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([113.118.70.172])
	by sina.com (10.185.250.22) with ESMTP
	id 676152F000003381; Tue, 17 Dec 2024 18:31:15 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 1732467602696
X-SMAIL-UIID: BBA5687D96D940A399423D5BC1F64706-20241217-183115-1
From: Hillf Danton <hdanton@sina.com>
To: syzbot <syzbot+c2e074db555379260750@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [mm?] general protection fault in find_lock_task_mm
Date: Tue, 17 Dec 2024 18:31:04 +0800
Message-ID: <20241217103105.151-1-hdanton@sina.com>
In-Reply-To: <67607c8c.050a0220.37aaf.013a.GAE@google.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, 16 Dec 2024 11:16:28 -0800
> syzbot found the following issue on:
> 
> HEAD commit:    231825b2e1ff Revert "unicode: Don't special case ignorable..
> git tree:       upstream
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=102844f8580000

#syz test

--- x/mm/oom_kill.c
+++ y/mm/oom_kill.c
@@ -137,7 +137,10 @@ struct task_struct *find_lock_task_mm(st
 	rcu_read_lock();
 
 	for_each_thread(p, t) {
+		if (!tryget_task_struct(t))
+			continue;
 		task_lock(t);
+		put_task_struct(t);
 		if (likely(t->mm))
 			goto found;
 		task_unlock(t);
--

