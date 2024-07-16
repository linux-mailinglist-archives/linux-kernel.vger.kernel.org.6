Return-Path: <linux-kernel+bounces-253580-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 48D09932356
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 11:49:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D94EDB23451
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 09:49:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 580E5197531;
	Tue, 16 Jul 2024 09:49:05 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FA8315EA6
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2024 09:49:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721123344; cv=none; b=hm0qd1OqEnTuBTRCuWjI/CVLSnaNJpX+9IUwXgR6lzEaSlbFRQ9Q0XBhk3A2uY9r0Dlzd7vnD38nzJe/dc6XyGo5Cp3PXgyzCO3ythG/PgVqGm7/Q/NuoUJoDBFo0+gLpnys2HZGldsc11PLQI1Lvk52D4MSo1CEmb8xk20IPHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721123344; c=relaxed/simple;
	bh=M7R3ByYWAtQ77jzbA8HobRpqqTRbPBr3GQKhFH7UWRE=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=iyXtkAoqmlhQyANxdYakhKSub22LT0BB+8fUTALS5PKC001Fft1jGn1emcnPNvD6oZoLNkV1gPliaaI0vUNRQyoqH1XwsuZ9t4yeek6si+NXNH3aLMaoeT5qzrkhxDmQoVYeM8O/3TIEQBdS7GAF/QHhMwBwMxPCfqigXuk6Rk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-7f682fb3b16so644463239f.1
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2024 02:49:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721123342; x=1721728142;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NFq5tcnflhHEZpsdeJTSeaik4GMv4dVOKmIS3WsyGQM=;
        b=dD9uY2cdCyvQc6BFygOHERBvG22Xzzdd5Ctd9FOgGOa66PO12FKFQkcLB5Ejs25yG9
         C54FFaYuTqfY7KOq6mzXO+J8+zRGNaT2cewpHKYQ7SZwjOeaGn4UfscqwZ8xP2WYVYyE
         5ZxT6jT9FfN2JorPCOmA2qJxhrFIsVJxthXHFcAkyjOlbBh/tYVOm7oSkseuhzfakb8i
         ypa+s5mwpZTYD2PDiZmmr5Y3tmfSW6jDqd2WKz/LhLt1lRKmgthGdO4ZCVT/jEloNfQl
         ny9w/iS1p0MtLZ3fWFOAtIC0y7cVVzGBFlflwTl3uhwYG6b1VEaZEpp3NkCKKr9ikpLo
         hxFA==
X-Forwarded-Encrypted: i=1; AJvYcCVKHf16aPc8iPBq3WuvAgru0OcxFURoZv4RUV/ae+6/+VrKxS0CGqu2g8gUd5TG4Nppv9q9GbjoMRmX5NRnQde5Slg3dA50or7j2MwW
X-Gm-Message-State: AOJu0YznmLuDjjCp2a8Ar/t8/CaEJvuG4si1DT9ZSNhFAXC9egqOI45J
	TKJtMWlhEZWtbYR4P9WdNYaobvX3nIe/tuBKdYVTuhSZHl8rKZvaMJb6SSo0jlaJ8w1pmQEoxy/
	HeYWnMieRU07Swr1CCW27gjKqzrV1vF0UwGvEysxZUn986GefAkZuhkE=
X-Google-Smtp-Source: AGHT+IERmXxu5I/wlA/JGvjQwk/YRdD/qqYO28UwG7l6NlzGzKwsQ3vR+Zoi9ybyuL2f8E/tniBLSA9LWcpGT5jPd90Kj+QSXJ73
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:22c4:b0:4b9:3703:4adf with SMTP id
 8926c6da1cb9f-4c2048246f2mr115291173.3.1721123342670; Tue, 16 Jul 2024
 02:49:02 -0700 (PDT)
Date: Tue, 16 Jul 2024 02:49:02 -0700
In-Reply-To: <tencent_9FA26F1C2CBD6D889734E986EDE6CDC47A0A@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000074701f061d5a411c@google.com>
Subject: Re: [syzbot] [sound?] [usb?] UBSAN: shift-out-of-bounds in parse_audio_unit
From: syzbot <syzbot+78d5b129a762182225aa@syzkaller.appspotmail.com>
To: eadavis@qq.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
UBSAN: shift-out-of-bounds in parse_audio_unit

usb 1-1: config 1 has 1 interface, different from the descriptor's value: 3
usb 1-1: New USB device found, idVendor=08b7, idProduct=0000, bcdDevice= 0.00
usb 1-1: New USB device strings: Mfr=0, Product=0, SerialNumber=3
usb 1-1: SerialNumber: syz
usb 1-1: 0:2 : does not exist
c: 0, bLen: 69, E, 
------------[ cut here ]------------
UBSAN: shift-out-of-bounds in sound/usb/mixer.c:2060:20
shift exponent 42 is too large for 32-bit type 'int'
CPU: 1 PID: 5219 Comm: kworker/1:3 Not tainted 6.10.0-rc7-syzkaller-00025-ga19ea421490d-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/07/2024
Workqueue: usb_hub_wq hub_event
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:114
 ubsan_epilogue lib/ubsan.c:231 [inline]
 __ubsan_handle_shift_out_of_bounds+0x3c8/0x420 lib/ubsan.c:468
 parse_audio_feature_unit sound/usb/mixer.c:2060 [inline]
 parse_audio_unit+0x270f/0x3f60 sound/usb/mixer.c:2910
 snd_usb_mixer_controls sound/usb/mixer.c:3255 [inline]
 snd_usb_create_mixer+0x1365/0x2fa0 sound/usb/mixer.c:3602
 usb_audio_probe+0x1688/0x2100 sound/usb/card.c:888
 usb_probe_interface+0x645/0xbb0 drivers/usb/core/driver.c:399
 really_probe+0x2b8/0xad0 drivers/base/dd.c:656
 __driver_probe_device+0x1a2/0x390 drivers/base/dd.c:798
 driver_probe_device+0x50/0x430 drivers/base/dd.c:828
 __device_attach_driver+0x2d6/0x530 drivers/base/dd.c:956
 bus_for_each_drv+0x24e/0x2e0 drivers/base/bus.c:457
 __device_attach+0x333/0x520 drivers/base/dd.c:1028
 bus_probe_device+0x189/0x260 drivers/base/bus.c:532
 device_add+0x856/0xbf0 drivers/base/core.c:3679
 usb_set_configuration+0x1976/0x1fb0 drivers/usb/core/message.c:2210
 usb_generic_driver_probe+0x88/0x140 drivers/usb/core/generic.c:254
 usb_probe_device+0x1b8/0x380 drivers/usb/core/driver.c:294
 really_probe+0x2b8/0xad0 drivers/base/dd.c:656
 __driver_probe_device+0x1a2/0x390 drivers/base/dd.c:798
 driver_probe_device+0x50/0x430 drivers/base/dd.c:828
 __device_attach_driver+0x2d6/0x530 drivers/base/dd.c:956
 bus_for_each_drv+0x24e/0x2e0 drivers/base/bus.c:457
 __device_attach+0x333/0x520 drivers/base/dd.c:1028
 bus_probe_device+0x189/0x260 drivers/base/bus.c:532
 device_add+0x856/0xbf0 drivers/base/core.c:3679
 usb_new_device+0x104a/0x19a0 drivers/usb/core/hub.c:2651
 hub_port_connect drivers/usb/core/hub.c:5521 [inline]
 hub_port_connect_change drivers/usb/core/hub.c:5661 [inline]
 port_event drivers/usb/core/hub.c:5821 [inline]
 hub_event+0x2d6a/0x5150 drivers/usb/core/hub.c:5903
 process_one_work kernel/workqueue.c:3248 [inline]
 process_scheduled_works+0xa2c/0x1830 kernel/workqueue.c:3329
 worker_thread+0x86d/0xd50 kernel/workqueue.c:3409
 kthread+0x2f0/0x390 kernel/kthread.c:389
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
---[ end trace ]---


Tested on:

commit:         a19ea421 Merge tag 'platform-drivers-x86-v6.10-6' of g..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=1127894e980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=b63b35269462a0e0
dashboard link: https://syzkaller.appspot.com/bug?extid=78d5b129a762182225aa
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=103c33e1980000


