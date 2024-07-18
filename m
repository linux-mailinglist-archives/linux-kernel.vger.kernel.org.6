Return-Path: <linux-kernel+bounces-256271-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A99D934BC9
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 12:38:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 98DFF1F23E51
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 10:38:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2101512C54D;
	Thu, 18 Jul 2024 10:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AyDWb7dc"
Received: from mail-vs1-f51.google.com (mail-vs1-f51.google.com [209.85.217.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F9D8757FD
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2024 10:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721299128; cv=none; b=YwxCsZUV1d8WO7Uqwau4i+YaWPCdaTnFE6zHN16dioeCydGBKKM+2iKEw/uYiU68S4EcQrtMxpA6p+/FB3LHxQXY1ehFw5WW1kSINRa2CeigyJIdyja806XupItUpdHXjRFiWRLH7ZTfde41EfNkGUzGDfGR4s3YhC/oa8M8+4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721299128; c=relaxed/simple;
	bh=2tmwJlhR1Wfi7Q9NdjSeYRRqYjuP3qeE9l7HqVIkQFc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ka8+gkvvCF23IjSW9qRVRPL7NxbQFpgmoeoRNm/5Kbjgu5MsrwS/DMW20/AZYiNxvakBjDeGCXQIbbqVrmNq0ZbJ27nC/eoR6WtdI/SPsIkXYua0NUaISlz1ObApUmXJtEiB+FRHAK8o6BhgWr0yNByPyNjb+y5s+ygFs7+7tzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=AyDWb7dc; arc=none smtp.client-ip=209.85.217.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-vs1-f51.google.com with SMTP id ada2fe7eead31-48fefaf11f9so215441137.1
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2024 03:38:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1721299125; x=1721903925; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=b86cIiTag/D6+MRxZijhKiaNV9RKluj5rIh+Hf3ZPgE=;
        b=AyDWb7dc0h2Yw5U/fz+PHHczW8JMseR01I5rRO/T0MqaKBolAQrjdrHTkq4ffBHetc
         PN7LgvIS6ppvx486agrICRvLzKy416AOLKLevcIiAwB2m5szt5vGZe8YKpAJgbofBhtf
         iiAzL90wk3CCfvIej2yPU3URox39VFMY0hV+6a7zfWjoIwypuBgvg9AO83oYtSq+1rTu
         w4GjfmBPbZjDTliMW91h2NamzXCbCoNpG8APfUBSzgSKO9K9E5MCEZMfTDVntnGc28yv
         BA3XifKKpRZPq+mqnklU3LrUEAUlFabJWeBuyqlFkplWzJQJX/YPWZJqB0PDfvhgbxVy
         g6Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721299125; x=1721903925;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=b86cIiTag/D6+MRxZijhKiaNV9RKluj5rIh+Hf3ZPgE=;
        b=i4Iw5Rda5CAk2DcMEf1scEiswwUG1BIRC03S4bFgWUq5a0v9R6VA7LMsRYCb+vv7e1
         V+yLQr5WSL2UJ/ymvlR1eGaFArgXXC3hldz5pThA+L5DGvs9jO3DIRbriwx3bTH9i1u3
         YWPoO7a6wznNk+NsvmOpvduXX4G8bMiAvq6tPjRhLo1UGOmqpY9GwIosshKAmzXIxoo5
         +Js9H6QtNscHWgheICjlphlRLM89YZ3AReJp1TLOEiAMI69PhEmXZhmVoxLQXO5BmpN0
         uqxvQ69wuCx8NM6DRw8Vyfp8OFFEaCEx9afUIJ95dE7kjBlIz8o1q10dgTkXps2ASTWR
         /OqA==
X-Forwarded-Encrypted: i=1; AJvYcCU8tnsFmOGP8A0/nnvKoQAWZLDuD46PiU7ECBIxrC8Qs5AuGY+49TncZXo337NISJtKjyi5+3XNM/qi/iOMSbmfTimfIRMB91PSpeNC
X-Gm-Message-State: AOJu0YyzP2IOj53LJu7fN7/m0AIs7uFDlzPKeOCzTMUseQQaBYaiAdvh
	cxxncfi0LXnLGFc//H/GY7uYxq3ej/KSWiakipr68JXNTFtWX4H+WQ6/4h+YLH3077q0XjoRi8j
	OGzrPBvgo+q6FGLte9rMPg/+S6B5HsyRrQZHL
X-Google-Smtp-Source: AGHT+IHTs4lcw5d7jz7YAnmB7NRpCcJPtf93z8Dm6wDouQL7/xcfSGyoEUjFd6PWBOaxn6YkafOZrTK7FeMy0ERbV6A=
X-Received: by 2002:a05:6102:3e02:b0:48f:8d1a:ff8c with SMTP id
 ada2fe7eead31-49159731b59mr5745714137.3.1721299124343; Thu, 18 Jul 2024
 03:38:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <000000000000381fbb061d81bd85@google.com>
In-Reply-To: <000000000000381fbb061d81bd85@google.com>
From: Marco Elver <elver@google.com>
Date: Thu, 18 Jul 2024 12:38:05 +0200
Message-ID: <CANpmjNPzw1=_VDfMDskrKWiabLV1aZVC1VeThLZTDn=qWMUsZQ@mail.gmail.com>
Subject: Re: [syzbot] [kernel?] KCSAN: data-race in kobject_put /
 kobject_uevent_env (2)
To: syzbot <syzbot+0ac8e4da6d5cfcc7743e@syzkaller.appspotmail.com>
Cc: gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, 
	rafael@kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

On Thu, 18 Jul 2024 at 10:55, syzbot
<syzbot+0ac8e4da6d5cfcc7743e@syzkaller.appspotmail.com> wrote:
>
> Hello,
>
> syzbot found the following issue on:
>
> HEAD commit:    d67978318827 Merge tag 'x86_cpu_for_v6.11_rc1' of git://gi..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=11af145e980000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=ca8f4e92a17047ec
> dashboard link: https://syzkaller.appspot.com/bug?extid=0ac8e4da6d5cfcc7743e
> compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
>
> Unfortunately, I don't have any reproducer for this issue yet.
>
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/1f219d0a9994/disk-d6797831.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/91aed26b830f/vmlinux-d6797831.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/c7e753e56950/bzImage-d6797831.xz
>
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+0ac8e4da6d5cfcc7743e@syzkaller.appspotmail.com
>
> llcp: llcp_sock_recvmsg: Recv datagram failed state 3 -6 0
> ==================================================================
> BUG: KCSAN: data-race in kobject_put / kobject_uevent_env
>
> read-write to 0xffff888139ddec54 of 1 bytes by task 22621 on cpu 0:
>  kobject_uevent_env+0x4e/0x550 lib/kobject_uevent.c:476
>  kobject_uevent+0x1c/0x30 lib/kobject_uevent.c:641
>  device_del+0x6fa/0x780 drivers/base/core.c:3886
>  nfc_unregister_device+0x114/0x130 net/nfc/core.c:1183
>  nci_unregister_device+0x14c/0x160 net/nfc/nci/core.c:1312
>  virtual_ncidev_close+0x30/0x50 drivers/nfc/virtual_ncidev.c:172
>  __fput+0x192/0x6f0 fs/file_table.c:422
>  ____fput+0x15/0x20 fs/file_table.c:450
>  task_work_run+0x13a/0x1a0 kernel/task_work.c:180
>  resume_user_mode_work include/linux/resume_user_mode.h:50 [inline]
>  exit_to_user_mode_loop kernel/entry/common.c:114 [inline]
>  exit_to_user_mode_prepare include/linux/entry-common.h:328 [inline]
>  __syscall_exit_to_user_mode_work kernel/entry/common.c:207 [inline]
>  syscall_exit_to_user_mode+0xbe/0x130 kernel/entry/common.c:218
>  do_syscall_64+0xd6/0x1c0 arch/x86/entry/common.c:89
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
>
> read to 0xffff888139ddec54 of 1 bytes by task 22615 on cpu 1:
>  kobject_put+0x25/0x180 lib/kobject.c:733
>  put_device+0x1f/0x30 drivers/base/core.c:3787
>  nfc_put_device net/nfc/nfc.h:103 [inline]
>  nfc_llcp_local_put+0x87/0xb0 net/nfc/llcp_core.c:196
>  nfc_llcp_sock_free net/nfc/llcp_sock.c:1021 [inline]
>  llcp_sock_destruct+0x14d/0x1a0 net/nfc/llcp_sock.c:966
>  __sk_destruct+0x3d/0x440 net/core/sock.c:2175
>  sk_destruct net/core/sock.c:2223 [inline]
>  __sk_free+0x284/0x2d0 net/core/sock.c:2234
>  sk_free+0x39/0x70 net/core/sock.c:2245
>  sock_put include/net/sock.h:1879 [inline]
>  llcp_sock_release+0x38f/0x3d0 net/nfc/llcp_sock.c:646
>  __sock_release net/socket.c:659 [inline]
>  sock_close+0x68/0x150 net/socket.c:1421
>  __fput+0x192/0x6f0 fs/file_table.c:422
>  ____fput+0x15/0x20 fs/file_table.c:450
>  task_work_run+0x13a/0x1a0 kernel/task_work.c:180
>  resume_user_mode_work include/linux/resume_user_mode.h:50 [inline]
>  exit_to_user_mode_loop kernel/entry/common.c:114 [inline]
>  exit_to_user_mode_prepare include/linux/entry-common.h:328 [inline]
>  __syscall_exit_to_user_mode_work kernel/entry/common.c:207 [inline]
>  syscall_exit_to_user_mode+0xbe/0x130 kernel/entry/common.c:218
>  do_syscall_64+0xd6/0x1c0 arch/x86/entry/common.c:89
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
>
> value changed: 0x07 -> 0x0d
>
> Reported by Kernel Concurrency Sanitizer on:
> CPU: 1 PID: 22615 Comm: syz.0.6322 Tainted: G        W          6.10.0-syzkaller-01155-gd67978318827 #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/07/2024
> ==================================================================

The two racing accesses here (on bitfield variables
kobj->state_remove_uevent_sent, kobj->state_initialized) are in the
same bitfield. There's no guarantee (by the compiler) that while the
bitfield is being updated the bit at kobj->state_initialized will
remain non-zero, and therefore the WARN in kobject_put() could be
triggered. This appears benign, unless of course someone set
panic_on_warn.

More generally, if the bitfield is updated concurrently, it's very
likely that one of the updates would be lost.

Just my initial observation.

