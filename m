Return-Path: <linux-kernel+bounces-340971-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A6ECA9879AD
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 21:39:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E982C1F24DA7
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 19:39:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE45F17ADF0;
	Thu, 26 Sep 2024 19:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CGXbESF4"
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08254522A;
	Thu, 26 Sep 2024 19:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727379555; cv=none; b=a4TpYmoZ6+CI2eAVDRliWNjDpDVAmwxvfFYwzknjBvUpVm6wuFZTIYp4DUcwK6Danqgvs1zku7hCtMNqtzGE2NXY0FMt8HAKpGgFL6FJ8Q7qA2euMefi1ESEvSwZji2ldat6vkkTTcdV78AZs7G6Dc8bgwEAr4v39B7PxkQmYRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727379555; c=relaxed/simple;
	bh=OnsHxzsvJUKVagK+k6nkcXv8x+HQNGynu7T7W/6HJZE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=C67hEEfjNVXsHozSjczT3souMdtWJzI4WgiaX6CAU2Kiq0g+NGp0UQDTXUIXR6jg5pRdpcRcLuxy3mWHGPanPvozFnuASUCxBSzLO5YAIaQlu4T6cNPKMbffuCB2F0OQvDptdv77e0ttlAK3PgLhwgmzw6GbqVEJtkyqkx3NA4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CGXbESF4; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-537a399e06dso1910519e87.1;
        Thu, 26 Sep 2024 12:39:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727379551; x=1727984351; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=2MciWzCk1jzFPzsM2tRkc2YYuhGD6BibWAqbbvB9dWk=;
        b=CGXbESF4MFXgk0BBnB0H+RmHlIWjKqtvWeigBcXh0Zw18NqZvyvAE9Mt/EQ7d9nQwD
         EYiw2Any4gd+r+UQRjR2VXluAUQ5I0Qq3i7qftLDjsUURS6Y86N1NSNa0meiov43B+WL
         Q0Cmpy5G2mjP8mxvx2OZdOQqottY2eYBO2fK82CJKhbaEY2dD9or1XBSqSTlur3beOu7
         I3HDv8OIn5M5gVgIycXm/j1J4QXR+Fz23ESFl3+LbTD23LmtdwVQ6aM/cX3aJKFwlYWJ
         BwxL2DYM8CabrdoTl+v+G4O3ncKsVm2utw5jzjjQUt6T+CgRWpvRfpCh14K6OqLomcad
         f22A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727379551; x=1727984351;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2MciWzCk1jzFPzsM2tRkc2YYuhGD6BibWAqbbvB9dWk=;
        b=hivsbwSvPOzMUaiP5L1zfr1+HYvEdPya/jIrr22cGS3OGdILXqKDwGaAHf84Dtqqem
         WrCU7WEuiputHUuqKnn4An6J9/lrx7WWkNlVu1ZmFFETyQdcpYutVfNaicozVbgsI9PB
         zlcyLWk/uOIFYrEAvaNqlF0yipAIUvGhStqdjymqQ8jFM279uCzEE8XAsqA/LfDWNaUD
         dqlJYMpodEEB/ZZC0lCI6LZ0TvKiGSbadWSN4tSBBP2EMa0+/RLGW9Y5mB6eTWfUwcsC
         QMJUc2/DNrarxrlAWCNgyzrJ/I++cwhOD0FMZrt/CKc+o7JHS0YnDwi+/9PTaJxi0CIm
         Vn4g==
X-Forwarded-Encrypted: i=1; AJvYcCWuwX/epTMWObWvE1QW6vYcs/T9oyHSBMS2+eoPZ2cJeIyRHZSFoE6OqwVohWFUy5PWgJbDCka/Tsxv@vger.kernel.org, AJvYcCWzFYeyyOJroBxhPxYX1Tw0PVvAYpbTATrHF7rkmk/6HST+IAPJq/MnwaD8hgH0eQ9JsW42FPdI/LnR9e4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwlZ+93LcHG1UNlRmGbKV6tGAahqzu0mLB0+IIuSMroAiue+G49
	IA1IFrVpxvBrf09jSH7qYltv20Bq6zpiK0s/QQZjtbvvZNjzh7Uc
X-Google-Smtp-Source: AGHT+IGk/ZRClYtyhiAAk712Mp2XmTYm5KTzjo2Jyct5WSiJnsDHZPeSUj7xII5HaYpANtmP3+b9fg==
X-Received: by 2002:a05:6512:6283:b0:530:ea2b:1a92 with SMTP id 2adb3069b0e04-5389fc643abmr517881e87.43.1727379550595;
        Thu, 26 Sep 2024 12:39:10 -0700 (PDT)
Received: from [192.168.216.101] (public-gprs228163.centertel.pl. [31.60.38.132])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a93c29974fcsm30805266b.205.2024.09.26.12.39.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Sep 2024 12:39:10 -0700 (PDT)
Message-ID: <1be4dce841c6e5de076864102aca2e131d1aafe1.camel@gmail.com>
Subject: Re: [PATCH v3] usb: gadget: u_ether: Use __netif_rx() in
 rx_callback()
From: Hubert =?UTF-8?Q?Wi=C5=9Bniewski?= <hubert.wisniewski.25632@gmail.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Ferry Toth	
 <ftoth@exalondelft.nl>, Hardik Gajjar <hgajjar@de.adit-jv.com>, Kees Cook	
 <kees@kernel.org>, Justin Stitt <justinstitt@google.com>, Richard Acayan	
 <mailingradian@gmail.com>, Jeff Johnson <quic_jjohnson@quicinc.com>, 
 "Ricardo B. Marliere"	 <ricardo@marliere.net>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet	 <edumazet@google.com>, Toke
 =?ISO-8859-1?Q?H=F8iland-J=F8rgensen?=	 <toke@redhat.com>,
 linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Thu, 26 Sep 2024 21:39:07 +0200
In-Reply-To: <20240917143618.jPgAwF3M@linutronix.de>
References: <155be9e56e650dd7f7baf1c7e193e1a3d85e7141.camel@gmail.com>
		 <20240917143618.jPgAwF3M@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.0 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2024-09-17 at 16:36 +0200, Sebastian Andrzej Siewior wrote:
> On 2024-09-17 15:56:33 [+0200], Hubert Wi=C5=9Bniewski wrote:
> > netif_rx() now disables bottom halves, which causes the USB gadget to b=
e
> > unable to receive frames if the interface is not brought up quickly eno=
ugh
> > after being created by the driver (a bug confirmed on AM3352 SoC).
> >=20
> > Replacing netif_rx() with __netif_rx() restores the old behavior and fi=
xes
> > the bug. This can be done since rx_callback() is called from the interr=
upt
> > context.
> >=20
> > Fixes: baebdf48c360 ("net: dev: Makes sure netif_rx() can be invoked in=
 any context.")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Hubert Wi=C5=9Bniewski <hubert.wisniewski.25632@gmail.co=
m>
>=20
> Now that I see v3, my v2 question stands.
> This supposed only to disable BH if invoked from from non-interrupt.
> hardirq and softirq should be good. A backtrace would be nice and further
> explanation how this becomes a problem. Also lockdep should complain at
> some point.
>=20
> Sebastian

This lockup seems to occur only on AM335x SoCs. If the interface is brought
up immediately after it is created:

# modprobe g_ether; ip link set usb0 up

it works fine. But if there is some delay:

# modprobe g_ether; sleep 5; ip link set usb0 up

the interface is unable to receive any frames from the USB host (but the
outgoing frames are sent correctly).
This becomes a problem when the g_ether module is loaded early in the boot
process or it is built in, and the interface is configured later (e.g. by
ifupdown).
The same thing happens when using configfs to create and configure an
Ethernet gadget.


I have built the kernel with CONFIG_PROVE_LOCKING=3Dy and got the following
messages upon bringing the interface up:

Backtrace (timestamps stripped):

 WARNING: CPU: 0 PID: 86 at kernel/softirq.c:362 __local_bh_enable_ip+0x118=
/0x198
 CPU: 0 UID: 0 PID: 86 Comm: ip Not tainted 6.11.0 #3
 Hardware name: Generic AM33XX (Flattened Device Tree)
 Call trace:
  unwind_backtrace from show_stack+0x10/0x14
  show_stack from dump_stack_lvl+0x68/0x88
  dump_stack_lvl from __warn+0x70/0x1ac
  __warn from warn_slowpath_fmt+0x12c/0x1c4
  warn_slowpath_fmt from __local_bh_enable_ip+0x118/0x198
  __local_bh_enable_ip from netif_rx+0x118/0x208
  netif_rx from rx_complete+0x140/0x27c
  rx_complete from musb_g_giveback+0xf0/0x1d8
  musb_g_giveback from musb_ep_restart_resume_work+0x8/0x10
  musb_ep_restart_resume_work from musb_gadget_queue+0x1c8/0x498
  musb_gadget_queue from usb_ep_queue+0x38/0x134
  usb_ep_queue from rx_submit+0xdc/0x1cc
  rx_submit from rx_fill+0x7c/0xa0
  rx_fill from eth_start+0x30/0x54
  eth_start from eth_open+0x40/0x80
  eth_open from __dev_open+0xe0/0x174
  __dev_open from __dev_change_flags+0x160/0x1d0
  __dev_change_flags from dev_change_flags+0x1c/0x58
  dev_change_flags from devinet_ioctl+0x6d0/0x884
  devinet_ioctl from inet_ioctl+0x1ac/0x2bc
  inet_ioctl from sock_ioctl+0x2c0/0x3b8
  sock_ioctl from sys_ioctl+0x194/0xf88
  sys_ioctl from ret_fast_syscall+0x0/0x1c
 Exception stack(0xe1485fa8 to 0xe1485ff0)
 5fa0:                   000b3630 00000001 00000003 00008914 be802cd8 be802=
c90
 5fc0: 000b3630 00000001 00000003 00000036 ffffffff ffffffff ffffffff be802=
ed4
 5fe0: 000c74cc be802c80 00028000 b6e7d14c
 irq event stamp: 2581
 hardirqs last  enabled at (2579): [<c13e10cc>] _raw_spin_unlock_irqrestore=
+0x44/0x48
 hardirqs last disabled at (2580): [<c13e0e94>] _raw_spin_lock_irqsave+0x64=
/0x68
 softirqs last  enabled at (2558): [<c0e727b0>] __dev_change_flags+0x7c/0x1=
d0
 softirqs last disabled at (2581): [<c0e68dd8>] netif_rx+0xa4/0x208



Lockdep:

 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D
 WARNING: inconsistent lock state
 6.11.0 #3 Tainted: G        W
 --------------------------------
 inconsistent {IN-HARDIRQ-W} -> {HARDIRQ-ON-W} usage.
 ip/86 [HC0[0]:SC0[0]:HE1:SE1] takes:
 c3e54050 (&musb->lock){?.-.}-{2:2}, at: musb_g_giveback+0xf8/0x1d8
 {IN-HARDIRQ-W} state was registered at:
   lock_acquire+0x108/0x358
   _raw_spin_lock_irqsave+0x4c/0x68
   dsps_interrupt+0x28/0x278
   __handle_irq_event_percpu+0xa0/0x2f4
   handle_irq_event_percpu+0xc/0x40
   handle_irq_event+0x38/0xcc
   handle_level_irq+0xb4/0x13c
   handle_irq_desc+0x1c/0x2c
   generic_handle_arch_irq+0x2c/0x64
   call_with_stack+0x18/0x20
   __irq_svc+0x9c/0xbc
   console_flush_all+0x25c/0x5c0
   console_unlock+0x80/0x114
   vprintk_emit+0x248/0x354
   dev_vprintk_emit+0x110/0x144
   dev_printk_emit+0x28/0x50
   __dev_printk+0x74/0x90
   _dev_warn+0x3c/0x68
   _regulator_get+0x1f8/0x31c
   sdhci_omap_regulator_get_caps+0x8/0x84
   sdhci_omap_probe+0x208/0x788
   platform_probe+0x58/0xb8
   really_probe+0xc4/0x28c
   __driver_probe_device+0x84/0x194
   driver_probe_device+0x30/0xc8
   __device_attach_driver+0xa4/0xe0
   bus_for_each_drv+0x80/0xd0
   __device_attach_async_helper+0xa8/0xdc
   async_run_entry_fn+0x20/0xb4
   process_scheduled_works+0x254/0x6e8
   worker_thread+0x13c/0x340
   kthread+0xf4/0x114
   ret_from_fork+0x14/0x24
 irq event stamp: 2649
 hardirqs last  enabled at (2649): [<c13e10cc>] _raw_spin_unlock_irqrestore=
+0x44/0x48
 hardirqs last disabled at (2648): [<c13e0e94>] _raw_spin_lock_irqsave+0x64=
/0x68
 softirqs last  enabled at (2644): [<c014b410>] handle_softirqs+0x260/0x45c
 softirqs last disabled at (2613): [<c1385f28>] call_with_stack+0x18/0x20

 other info that might help us debug this:
  Possible unsafe locking scenario:

        CPU0
        ----
   lock(&musb->lock);
   <Interrupt>
     lock(&musb->lock);

  *** DEADLOCK ***

 1 lock held by ip/86:
  #0: c1d60ca4 (rtnl_mutex){+.+.}-{3:3}, at: devinet_ioctl+0xc4/0x884

 stack backtrace:
 CPU: 0 UID: 0 PID: 86 Comm: ip Tainted: G        W          6.11.0 #3
 Tainted: [W]=3DWARN
 Hardware name: Generic AM33XX (Flattened Device Tree)
 Call trace:
  unwind_backtrace from show_stack+0x10/0x14
  show_stack from dump_stack_lvl+0x68/0x88
  dump_stack_lvl from mark_lock.part.17+0x3cc/0x440
  mark_lock.part.17 from __lock_acquire+0x44c/0x22b0
  __lock_acquire from lock_acquire+0x108/0x358
  lock_acquire from _raw_spin_lock+0x38/0x48
  _raw_spin_lock from musb_g_giveback+0xf8/0x1d8
  musb_g_giveback from musb_ep_restart_resume_work+0x8/0x10
  musb_ep_restart_resume_work from musb_gadget_queue+0x1c8/0x498
  musb_gadget_queue from usb_ep_queue+0x38/0x134
  usb_ep_queue from rx_submit+0xdc/0x1cc
  rx_submit from rx_fill+0x7c/0xa0
  rx_fill from eth_start+0x30/0x54
  eth_start from eth_open+0x40/0x80
  eth_open from __dev_open+0xe0/0x174
  __dev_open from __dev_change_flags+0x160/0x1d0
  __dev_change_flags from dev_change_flags+0x1c/0x58
  dev_change_flags from devinet_ioctl+0x6d0/0x884
  devinet_ioctl from inet_ioctl+0x1ac/0x2bc
  inet_ioctl from sock_ioctl+0x2c0/0x3b8
  sock_ioctl from sys_ioctl+0x194/0xf88
  sys_ioctl from ret_fast_syscall+0x0/0x1c
 Exception stack(0xe1485fa8 to 0xe1485ff0)
 5fa0:                   000b3630 00000001 00000003 00008914 be802cd8 be802=
c90
 5fc0: 000b3630 00000001 00000003 00000036 ffffffff ffffffff ffffffff be802=
ed4
 5fe0: 000c74cc be802c80 00028000 b6e7d14c



Surprisingly, with the patch I suggested, there is still a backtrace
generated, but without lockdep warning:

 WARNING: CPU: 0 PID: 87 at net/core/dev.c:5207 __netif_rx+0xd4/0x210
 CPU: 0 UID: 0 PID: 87 Comm: ip Not tainted 6.11.0-dirty #4
 Hardware name: Generic AM33XX (Flattened Device Tree)
 Call trace:
  unwind_backtrace from show_stack+0x10/0x14
  show_stack from dump_stack_lvl+0x68/0x88
  dump_stack_lvl from __warn+0x70/0x1ac
  __warn from warn_slowpath_fmt+0x12c/0x1c4
  warn_slowpath_fmt from __netif_rx+0xd4/0x210
  __netif_rx from rx_complete+0x140/0x27c
  rx_complete from musb_g_giveback+0xf0/0x1d8
  musb_g_giveback from musb_ep_restart_resume_work+0x8/0x10
  musb_ep_restart_resume_work from musb_gadget_queue+0x1c8/0x498
  musb_gadget_queue from usb_ep_queue+0x38/0x134
  usb_ep_queue from rx_submit+0xdc/0x1cc
  rx_submit from rx_fill+0x7c/0xa0
  rx_fill from eth_start+0x30/0x54
  eth_start from eth_open+0x40/0x80
  eth_open from __dev_open+0xe0/0x174
  __dev_open from __dev_change_flags+0x160/0x1d0
  __dev_change_flags from dev_change_flags+0x1c/0x58
  dev_change_flags from devinet_ioctl+0x6d0/0x884
  devinet_ioctl from inet_ioctl+0x1ac/0x2bc
  inet_ioctl from sock_ioctl+0x2c0/0x3b8
  sock_ioctl from sys_ioctl+0x194/0xf88
  sys_ioctl from ret_fast_syscall+0x0/0x1c
 Exception stack(0xe148dfa8 to 0xe148dff0)
 dfa0:                   000b3630 00000001 00000003 00008914 be8c8cd8 be8c8=
c90
 dfc0: 000b3630 00000001 00000003 00000036 ffffffff ffffffff ffffffff be8c8=
ed4
 dfe0: 000c74cc be8c8c80 00028000 b6ed614c
 irq event stamp: 2542
 hardirqs last  enabled at (2541): [<c13e10cc>] _raw_spin_unlock_irqrestore=
+0x44/0x48
 hardirqs last disabled at (2542): [<c13e0e94>] _raw_spin_lock_irqsave+0x64=
/0x68
 softirqs last  enabled at (2520): [<c0e727b0>] __dev_change_flags+0x7c/0x1=
d0
 softirqs last disabled at (2518): [<c0e7236c>] dev_set_rx_mode+0x0/0x40



I'm a bit at loss here. The deadlock seems to be unrelated to netif_rx()
(which is not being called in the interrupt context after all), yet
replacing it with __netif_rx() fixes the lockup (though a warning is still
generated, which suggests that the patch does not completely fix the
issue).

--=20
Hubert Wi=C5=9Bniewski <hubert.wisniewski.25632@gmail.com>

