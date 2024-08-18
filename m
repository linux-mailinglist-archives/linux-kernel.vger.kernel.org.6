Return-Path: <linux-kernel+bounces-291247-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 01A93955FDA
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 00:20:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A4CA01F211E4
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Aug 2024 22:20:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 225E315534D;
	Sun, 18 Aug 2024 22:20:46 +0000 (UTC)
Received: from mail114-240.sinamail.sina.com.cn (mail114-240.sinamail.sina.com.cn [218.30.114.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB3F4610D
	for <linux-kernel@vger.kernel.org>; Sun, 18 Aug 2024 22:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=218.30.114.240
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724019645; cv=none; b=UYZLF920BLH2dkTi/EO1k24JsfmtKANMnXhidNOzDT3aRR2hZqJAhhGjmPv6m02N0D06gbU3twx9ivPtg6X/nba6LWCw6qFkTJRlZA4/HnvMfp+sPSJARh94hojLZtLgTDcVH58XuEaL7X4FiScgbn/Zi+4nNAwSoH4xyqlHtpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724019645; c=relaxed/simple;
	bh=rAAR+yeCTNSfLNnxeNwHcJ9MlSsded9Vw51h/B810Us=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gmEdwL8RgCzALLOtLD5gq9qjn/tuzMgmas1ixHZiQjlYhC+gPto+OAWI/ZeqXKJR8Jb1GIt12+gOqgS0648nEBVsfgifgoSWfE4qzhTSUBvDM4yYRZxM26Vor/COrb6VhQSMbk1rUx3aBzVOyj5vHp0eNNiaEjQ7MAPOfDEB+nY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; arc=none smtp.client-ip=218.30.114.240
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([113.88.49.232])
	by sina.com (10.185.250.23) with ESMTP
	id 66C2717000004C02; Sun, 19 Aug 2024 06:10:58 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 3227898913247
X-SMAIL-UIID: 46E29DA058EB46E29DBA771D2CB3118F-20240819-061058-1
From: Hillf Danton <hdanton@sina.com>
To: syzbot <syzbot+9fd43bb1ae7b5d9240c3@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [btrfs?] general protection fault in __alloc_workqueue
Date: Mon, 19 Aug 2024 06:10:48 +0800
Message-Id: <20240818221048.813-1-hdanton@sina.com>
In-Reply-To: <000000000000f6f09e061feefd16@google.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sat, 17 Aug 2024 23:06:23 -0700
> syzbot found the following issue on:
> 
> HEAD commit:    367b5c3d53e5 Add linux-next specific files for 20240816
> git tree:       linux-next
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15b868dd980000

#syz test linux-next  367b5c3d53e5

--- x/kernel/workqueue.c
+++ y/kernel/workqueue.c
@@ -5653,6 +5653,7 @@ static struct workqueue_struct *__alloc_
 	wq = kzalloc(wq_size, GFP_KERNEL);
 	if (!wq)
 		return NULL;
+	wq_init_lockdep(wq);
 
 	if (flags & WQ_UNBOUND) {
 		wq->unbound_attrs = alloc_workqueue_attrs();
@@ -5757,10 +5758,6 @@ struct workqueue_struct *alloc_workqueue
 	va_start(args, max_active);
 	wq = __alloc_workqueue(fmt, flags, max_active, args);
 	va_end(args);
-	if (!wq)
-		return NULL;
-
-	wq_init_lockdep(wq);
 
 	return wq;
 }
--

