Return-Path: <linux-kernel+bounces-376185-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0644C9AA146
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 13:42:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC93A28334A
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 11:42:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F25B219C57F;
	Tue, 22 Oct 2024 11:42:49 +0000 (UTC)
Received: from mail115-63.sinamail.sina.com.cn (mail115-63.sinamail.sina.com.cn [218.30.115.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0179199EBB
	for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 11:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=218.30.115.63
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729597369; cv=none; b=Al9vw50DAfp94BsoLvIZM6PfatI80j51kjJvq24IDIFDZ3QKOUwQX8UEqkY+cqmFKsGjxVHDt0uUe/KDKPlwwjWQczpr2KwbZwiVtuQsl+F7/sMh0arcAlR5BFMdBpk1VEL5OuPRfF4bjFGudESnE30CPQNwW7R76FfI/iNA7ew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729597369; c=relaxed/simple;
	bh=fiLvjqiCky4scaYOA6J4GlmocifpCmL/hB2+SAwnFfo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fSEgYBNtUL1raJH4MSg0rf/rz6Pye/dDSNVMvSx2Pmp2bEZrQS+BVbLVVw8MzlrpdtAz01k14wtadyq/rcNmfcd0jaxSp0/RPERvs2dgcqmVCWEitOwT76CphB5+oRaP09J2pJNX7+A+aperHR0Zcu5IiAIDgqHCyBgpsHhbpzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; arc=none smtp.client-ip=218.30.115.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([113.118.70.205])
	by sina.com (10.185.250.22) with ESMTP
	id 67178FA900007C24; Tue, 22 Oct 2024 19:42:37 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 1711477602652
X-SMAIL-UIID: E3EC872BFAA84B73A8990DED069A75CD-20241022-194237-1
From: Hillf Danton <hdanton@sina.com>
To: Oliver Neukum <oneukum@suse.com>
Cc: syzbot <syzbot+f342ea16c9d06d80b585@syzkaller.appspotmail.com>,
	linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org,
	stern@rowland.harvard.edu,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [usb?] INFO: task hung in usb_port_suspend
Date: Tue, 22 Oct 2024 19:42:25 +0800
Message-Id: <20241022114225.2314-1-hdanton@sina.com>
In-Reply-To: <0abd3cbd-0e8a-43b2-8cb0-6556297aa7c9@suse.com>
References: <67153205.050a0220.1e4b4d.0048.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, 21 Oct 2024 10:04:52 +0200 Oliver Neukum <oneukum@suse.com>
> On 20.10.24 18:38, syzbot wrote:
>   
> > INFO: task kworker/0:0:8 blocked for more than 143 seconds.
> >        Not tainted 6.12.0-rc3-syzkaller-00051-g07b887f8236e #0
> > "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> > task:kworker/0:0     state:D stack:24544 pid:8     tgid:8     ppid:2      flags:0x00004000
> > Workqueue: pm pm_runtime_work
> > Call Trace:
> >   <TASK>
> >   context_switch kernel/sched/core.c:5322 [inline]
> >   __schedule+0x105f/0x34b0 kernel/sched/core.c:6682
> >   __schedule_loop kernel/sched/core.c:6759 [inline]
> >   schedule+0xe7/0x350 kernel/sched/core.c:6774
> 
> And this sleeps forever. This must not happen.
> >   usb_kill_urb.part.0+0x1ca/0x250 drivers/usb/core/urb.c:713
> >   usb_kill_urb+0x83/0xa0 drivers/usb/core/urb.c:702
> 
> We are changing our mind, presumably due to a timeout
> >   usb_start_wait_urb+0x255/0x4c0 drivers/usb/core/message.c:65
> 
> We are sending a control message, presumably to enable
> remote wakeup
> >   usb_internal_control_msg drivers/usb/core/message.c:103 [inline]
> >   usb_control_msg+0x327/0x4b0 drivers/usb/core/message.c:154
> >   usb_enable_remote_wakeup drivers/usb/core/hub.c:3365 [inline]
> >   usb_port_suspend+0x339/0xf10 drivers/usb/core/hub.c:3472
> 
> Suspending ...
> >   usb_generic_driver_suspend+0xeb/0x1d0 drivers/usb/core/generic.c:302
> >   usb_suspend_device drivers/usb/core/driver.c:1272 [inline]
> >   usb_suspend_both+0x66d/0x9c0 drivers/usb/core/driver.c:1443
> >   usb_runtime_suspend+0x49/0x180 drivers/usb/core/driver.c:1968
> 
> This very much looks like the HC driver used to run these tests
> can hand in unlink. If that happens there is nothing usbcore
> or a driver can do.
>
A one-line change could survive the reproducer [1].

[1] https://yhbt.net/lore/lkml/67178c80.050a0220.1e4b4d.0075.GAE@google.com/

