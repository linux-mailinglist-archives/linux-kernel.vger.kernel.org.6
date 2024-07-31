Return-Path: <linux-kernel+bounces-269041-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 19208942CAD
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 13:05:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8432DB22EF1
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 11:05:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B616B1AD3E7;
	Wed, 31 Jul 2024 11:05:30 +0000 (UTC)
Received: from mail115-80.sinamail.sina.com.cn (mail115-80.sinamail.sina.com.cn [218.30.115.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 752DB145FEF
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 11:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=218.30.115.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722423930; cv=none; b=q4XI0WlPTzbQ9yja+s6+XupGKoSQaDB6J+rL5Hns1AS9tsp5H4fl3d5DHRMH+WU3mrgStjV+cRvCSjbDwvlF6/gGzMay1/RP6M5J6u3n6ZSRvODKmS5rVRPnxM4UB2aW1avmjXOukr34/2yOZyOKk/dI3R7I6G5+IenWf4JLzBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722423930; c=relaxed/simple;
	bh=VvGEt5SbCWBDF4LqTHePuTYmBdf3+qKKqzuuP6pw+rY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=q5bxinlynxnR33UjKJWn5JJhH9PQmXckEYGiFlmjDcrUJ0Lmu+9syHN5RGTYkl7FbV6CCMcYM6bkikvmOQrOl+EBRTdOR5d91MmvnUnZojyFuHG6VUw56a5x4KpfD0r7B5GT7prKrknuvvGSN3ckGyT6hS17eVinoLf3XB9NVbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; arc=none smtp.client-ip=218.30.115.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([113.118.69.52])
	by sina.com (10.185.250.23) with ESMTP
	id 66AA1A6600000BC2; Wed, 31 Jul 2024 19:05:13 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 1289078913422
X-SMAIL-UIID: 9FCC5E6F593D4DCF86F85C3034590D91-20240731-190513-1
From: Hillf Danton <hdanton@sina.com>
To: syzbot <syzbot+943d34fa3cf2191e3068@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [wireguard?] WARNING in kthread_unpark (2)
Date: Wed, 31 Jul 2024 19:05:01 +0800
Message-Id: <20240731110501.2425-1-hdanton@sina.com>
In-Reply-To: <000000000000e9a538061e64cae7@google.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, 29 Jul 2024 08:48:30 -0700
> syzbot has found a reproducer for the following issue on:
> 
> HEAD commit:    dc1c8034e31b minmax: simplify min()/max()/clamp() implemen..
> git tree:       upstream
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1022b573980000

#syz test upstream  dc1c8034e31b

--- x/kernel/workqueue.c
+++ y/kernel/workqueue.c
@@ -2679,7 +2679,8 @@ static void worker_attach_to_pool(struct
 		worker->flags |= WORKER_UNBOUND;
 	} else {
 		WARN_ON_ONCE(pool->flags & POOL_BH);
-		kthread_set_per_cpu(worker->task, pool->cpu);
+		if (!worker->rescue_wq)
+			kthread_set_per_cpu(worker->task, pool->cpu);
 	}
 
 	if (worker->rescue_wq)
--- x/drivers/input/misc/yealink.c
+++ y/drivers/input/misc/yealink.c
@@ -438,6 +438,8 @@ static void urb_irq_callback(struct urb
 
 	yealink_do_idle_tasks(yld);
 
+	if (status == -EPROTO)
+		return;
 	if (!yld->shutdown) {
 		ret = usb_submit_urb(yld->urb_ctl, GFP_ATOMIC);
 		if (ret && ret != -EPERM)
@@ -452,9 +454,12 @@ static void urb_ctl_callback(struct urb
 	struct yealink_dev *yld = urb->context;
 	int ret = 0, status = urb->status;
 
-	if (status)
+	if (status) {
 		dev_err(&yld->intf->dev, "%s - urb status %d\n",
 			__func__, status);
+		if (status == -EPROTO)
+			return;
+	}
 
 	switch (yld->ctl_data->cmd) {
 	case CMD_KEYPRESS:
--

