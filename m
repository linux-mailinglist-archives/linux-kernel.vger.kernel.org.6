Return-Path: <linux-kernel+bounces-253664-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 21ACE932481
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 12:58:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6E683B23DB4
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 10:58:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C594F1990B2;
	Tue, 16 Jul 2024 10:58:05 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCF1C1990A1
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2024 10:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721127485; cv=none; b=ZWBxU0ydPJ6OwuTdLlUuWp+oNQknsVZADkufEH2pWe0vuqJ52trH2C73P/Ge8GORl3CkH4DeXjqWw3dMs00QrPs6LE9hngjVwz7yXg8Pt0jCMBXYl6rdv88SBcYczGbnH134VfZVl72d1wkrwk0bzq27HpNanIjxr9ZaR7y5h80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721127485; c=relaxed/simple;
	bh=zdmqtI08we1l9lGlFYXilXsjzQPTsOxdFtZRybi1G5o=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=ke5HX7f1S4o4svTR95F0stl4O1yON0wo3uEamdiC4O6dVMy5AfZiFFp/AAd35M3ETOOS3qeRmYrZ//9hZPqhFBwTHOPWv2xJuHI2vwFdYWQ4BL6cOkRsxtJ6OkYZ6PP/jaYjx+QWquSrjUhGni/LixqlrgUMdWPnhUC+iplxFUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-7fba8d323f9so607693139f.3
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2024 03:58:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721127483; x=1721732283;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6yCz3thZtzmt1dQfyR327BxLJ4ozyZ3l1LgWxrk4lC0=;
        b=XQXVmqLPuWyujkObFNV43CZ67wDQU57hBsijUL9cgmlg0CKoVXXaKeZscERkSDeQWM
         0OnHPSFYOMmWjO/CWqSAVYOfHrYEQI0sT/fYWgM65XfmC1I5uUufm3bjUPOvnVj9HFvL
         HPApAkQiR6+gqpMykOgFEZcxdWodQuRj0byrsDTW5kyGrM3g8/VkJZxmike5/Q/9QI5V
         iDAYem2zS2IMxQuSGv1HLHj6+zpDlEanPqlw1wwq4EJxJuB2BavjZL9TfT4w32bbY6lA
         546i9RhQJYHHVBJca4A1XN0Q4JvG94nmqWATG4t+WOwx83cVDH56B1APR8+81GzRMi0K
         BgmQ==
X-Forwarded-Encrypted: i=1; AJvYcCVQhgVeBSsPGQbNhLSGJJVJ9MCWczwrNV68ti4xZKifwc26GmLJHdRBaWMqT/G+NNIOvRB2V7mqnZ2lF/dF0NCqKbNMK8XXq3aUQ34E
X-Gm-Message-State: AOJu0YzpJumUxZygOwca5Dmv1kAakmPEtt+apPtQRXqMXwvAWFnCiYLV
	C/H4LqH/MajtzaMdAScSicBh3e+8ooUlXWos9A6cVxzkWJe1tsTXGSJDevDzQkfitWef7b0ef1i
	Q5XQwW5RAs2VwW4CMSzd1v2HDU7rj396O7pWBBzURokbMvcp+N/Vh700=
X-Google-Smtp-Source: AGHT+IG7fvadOOREXdRVBr1+chCN5Uzo8EjqHn4TuNZj4MqjplzoYRyGc09uLCJueNOT1iovJsx5tFD8pZ98tq9nQCK8ZX62V7h5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:22ce:b0:4c1:4388:46bb with SMTP id
 8926c6da1cb9f-4c204445765mr124288173.0.1721127483077; Tue, 16 Jul 2024
 03:58:03 -0700 (PDT)
Date: Tue, 16 Jul 2024 03:58:03 -0700
In-Reply-To: <tencent_432CC56D1097C8EA26EC0ECDCC787E6CEC0A@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000003e08de061d5b38a4@google.com>
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
c: 0, bLen: 69, 1, 
------------[ cut here ]------------
UBSAN: shift-out-of-bounds in sound/usb/mixer.c:2060:20
shift exponent 42 is too large for 32-bit type 'int'
CPU: 1 PID: 5170 Comm: kworker/1:5 Not tainted 6.10.0-rc7-syzkaller-00025-ga19ea421490d-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/07/2024
Workqueue: usb_hub_wq hub_event
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:114
 ubsan_epilogue lib/ubsan.c:231 [inline]
 __ubsan_handle_shift_out_of_bounds+0x3c8/0x420 lib/ubsan.c:468
 parse_audio_feature_unit sound/usb/mixer.c:2060 [inline]
 parse_audio_unit+0x2709/0x3f70 sound/usb/mixer.c:2910
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
console output: https://syzkaller.appspot.com/x/log.txt?x=1367bf66980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=b63b35269462a0e0
dashboard link: https://syzkaller.appspot.com/bug?extid=78d5b129a762182225aa
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=12ecf85e980000


