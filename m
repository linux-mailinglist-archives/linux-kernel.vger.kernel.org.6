Return-Path: <linux-kernel+bounces-328138-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EDA01977F53
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 14:11:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 84762281A1C
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 12:11:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FE441D933B;
	Fri, 13 Sep 2024 12:11:42 +0000 (UTC)
Received: from mail114-240.sinamail.sina.com.cn (mail114-240.sinamail.sina.com.cn [218.30.114.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C92C01C175F
	for <linux-kernel@vger.kernel.org>; Fri, 13 Sep 2024 12:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=218.30.114.240
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726229502; cv=none; b=GwyC3RiLIqFmP7L5/XpKuzbXK2VPmChx+26T+sPpDN65igAKI9ez8rgOqjDHY+/1mSPNdk5I84ZbJ/C8ILXUzp2RK6Av5O8rrF6nunmzj9pLwoq6slVxLEK2fdtdM6dxGOuIuHEYjAhsX1i932SHQv0lkEtte2btnRsj50UVDlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726229502; c=relaxed/simple;
	bh=ENl4OIXM2il0Gwky2Mxi3ZazpJgg9kt7UZAkWx9UUz4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TRwtScjQ134YpBjBkwEl77yBI7WINBPr+D2dvOFAG3AVAPDBEdIfAS7VM4feDX9xDCat24FQFPackhSsgfPW8ATlWBbIXcOr2kbpFuvIJupV6cwTw+ORyMPC3Xvw2SXyioZp/l+/q0OWoYFBQq6gd/pBvwDOkfEbWoNnsFDKSvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; arc=none smtp.client-ip=218.30.114.240
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([113.118.71.185])
	by sina.com (10.185.250.23) with ESMTP
	id 66E42BE700004E8E; Fri, 13 Sep 2024 20:11:21 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 8650948913435
X-SMAIL-UIID: A0AEF1283A154653AC858FDF16549CDE-20240913-201121-1
From: Hillf Danton <hdanton@sina.com>
To: Frederic Weisbecker <frederic@kernel.org>
Cc: syzbot <syzbot+943d34fa3cf2191e3068@syzkaller.appspotmail.com>,
	linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com,
	Thomas Gleixner <tglx@linutronix.de>,
	Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH] kthread: Unpark only parked kthreads (was Re: [syzbot] [wireguard?] WARNING in kthread_unpark (2))
Date: Fri, 13 Sep 2024 20:11:09 +0800
Message-Id: <20240913121109.289-1-hdanton@sina.com>
In-Reply-To: <ZuGHTBfUlB0qlgn4@localhost.localdomain>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Test Frederic's idea.

#syz test upstream master

--- a/kernel/kthread.c
+++ b/kernel/kthread.c
@@ -623,6 +623,8 @@ void kthread_unpark(struct task_struct *
 {
 	struct kthread *kthread = to_kthread(k);
 
+	if (!test_bit(KTHREAD_SHOULD_PARK, &kthread->flags))
+		return;
 	/*
 	 * Newly created kthread was parked when the CPU was offline.
 	 * The binding was lost and we need to set it again.
--- l/drivers/input/misc/yealink.c
+++ y/drivers/input/misc/yealink.c
@@ -438,7 +438,7 @@ static void urb_irq_callback(struct urb
 
 	yealink_do_idle_tasks(yld);
 
-	if (!yld->shutdown) {
+	if (!yld->shutdown && status != -EPROTO) {
 		ret = usb_submit_urb(yld->urb_ctl, GFP_ATOMIC);
 		if (ret && ret != -EPERM)
 			dev_err(&yld->intf->dev,
@@ -460,13 +460,13 @@ static void urb_ctl_callback(struct urb
 	case CMD_KEYPRESS:
 	case CMD_SCANCODE:
 		/* ask for a response */
-		if (!yld->shutdown)
+		if (!yld->shutdown && status != -EPROTO)
 			ret = usb_submit_urb(yld->urb_irq, GFP_ATOMIC);
 		break;
 	default:
 		/* send new command */
 		yealink_do_idle_tasks(yld);
-		if (!yld->shutdown)
+		if (!yld->shutdown && status != -EPROTO)
 			ret = usb_submit_urb(yld->urb_ctl, GFP_ATOMIC);
 		break;
 	}
--

