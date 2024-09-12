Return-Path: <linux-kernel+bounces-326635-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DD0B1976B1A
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 15:49:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8B6A41F240B6
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 13:49:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F2E21AD256;
	Thu, 12 Sep 2024 13:49:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oJDBqZLO"
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B45F1A76AE
	for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 13:49:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726148952; cv=none; b=ei1OR2QwT8tFDfISjr14ck02vnHTV7wBq7rtkxAG4xXV1RnMCndPs6M7ZQFutOeZYs/9Fx4JM+Uwu8Cuii1x4YeKXNc8CBSv9VxPjwBoq/7k8M3TPq2LKdaOQy8OWCkSu6EmR83FB2Lr60UdO6GbUhs/j6FTjykl4Yfbnqwj6tQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726148952; c=relaxed/simple;
	bh=BeCToDaYapaX3Saa/es3zn7QE7cn2Hm7x6pEwmgVvYw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Mc9UJ+jS2ODcMzBWwpd4EA5TkR5Wlc0aAPDIxNJ4ZtapC6u3cBtIGJ+vefhJIN3ZFAXUFkbKbVdVzWV7ARO/ef8F4q3JCUyrplN1knkp9+d8/aAM4vGG+WLq8SiNRy/LipADqjIVHItHQIvFQYjjDE3PFDk9UMpuTVKs4ykGMr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=oJDBqZLO; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-7db0fb03df5so825597a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 06:49:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1726148950; x=1726753750; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=fUQa4s1nfS6Ak/vMXpFFTKhTCLVYkjsgEZVj84spgpI=;
        b=oJDBqZLORPa6s7CPZ8kjzOvCBiHxkVmO3dImpTanPK4HtxunWWrRvzQwvmnaM5hQmG
         Y6gxAANU7XaHxtMHpK0mrxWmgY+SKJgK6YgAWG+AlCYZteGt7Xtr/M9aYnCoLcwTyeXZ
         9NfS/rLpXV5iglNWMYklCxj3NpMjFh2NYydrwpRaQmgZX4Vk47+l5SfOy4rHDTqcJqNt
         9dnr+rmbQ2vjHKkUZ1TC6nblcPDxY21NKgY5CRgPuybwiiEWJ+ck+6sk+VQSfk+QUZDY
         CFm/T6uj7Mw4xZf2VBtbuOXElQk8WFX+OYzH5aRMdOmTV6v0Q7HXd1bkugARbYQjiDys
         PKoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726148950; x=1726753750;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fUQa4s1nfS6Ak/vMXpFFTKhTCLVYkjsgEZVj84spgpI=;
        b=vhVklxuHP4O4Qmv7vmE1sZLYLn2yLGcXQV5eS05/laIXdKanG/J1dmnhj6kCYLyYxD
         zqPL8RAWRBf2jnbKqvSbkOJAoPuOR1gEEbL07LXpJJ1wn88RwGzQ3IS0Pd4GBslER9Vm
         BHYRYtBbD1l65fiRfSAyde2kQWxdTRYT1pqrkbfx5W+WTcwpH5dKoUh/iAVGrSPjOk1c
         KqkyAGMpI2U/KYGjeJw8yFN4pIFTJMmD41ZtH0/Ri52+Nwg0Qu2vi+IJQl3QihBT7gpK
         bcCA5yDqt4P06eYT7/ES0k/rbtJ8OAxLNkSXpBS6JQDEcVNK2hlkAdH4wrVmI40W4JOR
         cqlQ==
X-Forwarded-Encrypted: i=1; AJvYcCXzD381Y/XPtdrS6Rv2ZrN9RS5WqEbWG4pj157qwFFBIOSNnO+p3WHt4cKjlAB387hYoluIYRYIPfs0pRY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxyUudKBQbI8CiU0buxKlPJ/L9raFtQ9nmHN93QFXcEZO5aj7ZJ
	nV/vjC4bI5h3OtdkExwaOxXGHTQewPivCDYM/NGu28p5cAeREbQ6UNCmR82P30By6FrvtpMcGZh
	vUyEiLLzuMLoQkXiPXh3LJ0mjNIVXaMp/j64IOhoKf34nurbTyTDo
X-Google-Smtp-Source: AGHT+IEPr3PK6becA5u/81rvfWVTB62iUowBdbi297hZYuVMK8UYMPCjcecQcbIV27iiqIRftGBxFzb0qMGGSrE5SgY=
X-Received: by 2002:a05:6a21:b8a:b0:1cf:5c1d:83e2 with SMTP id
 adf61e73a8af0-1cf7624b290mr4425750637.39.1726148949520; Thu, 12 Sep 2024
 06:49:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <000000000000e2058e0621e7a637@google.com> <20240912070121-mutt-send-email-mst@kernel.org>
In-Reply-To: <20240912070121-mutt-send-email-mst@kernel.org>
From: Marco Elver <elver@google.com>
Date: Thu, 12 Sep 2024 15:48:32 +0200
Message-ID: <CANpmjNN+3TwdxkvnFzzeQNOVXq-smqpi+xtkw0j+Pd-BGkrgFw@mail.gmail.com>
Subject: Re: [syzbot] [virt?] KCSAN: data-race in virtqueue_disable_cb /
 vring_interrupt (4)
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: syzbot <syzbot+8a02104389c2e0ef5049@syzkaller.appspotmail.com>, 
	eperezma@redhat.com, jasowang@redhat.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com, virtualization@lists.linux.dev, 
	xuanzhuo@linux.alibaba.com
Content-Type: text/plain; charset="UTF-8"

On Thu, 12 Sept 2024 at 13:03, Michael S. Tsirkin <mst@redhat.com> wrote:
>
> On Thu, Sep 12, 2024 at 01:11:21AM -0700, syzbot wrote:
> > Hello,
> >
> > syzbot found the following issue on:
> >
> > HEAD commit:    7c6a3a65ace7 minmax: reduce min/max macro expansion in ato..
> > git tree:       upstream
> > console output: https://syzkaller.appspot.com/x/log.txt?x=1608e49f980000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=1e7d02549be622b2
> > dashboard link: https://syzkaller.appspot.com/bug?extid=8a02104389c2e0ef5049
> > compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
> >
> > Unfortunately, I don't have any reproducer for this issue yet.
> >
> > Downloadable assets:
> > disk image: https://storage.googleapis.com/syzbot-assets/a1f7496fa21f/disk-7c6a3a65.raw.xz
> > vmlinux: https://storage.googleapis.com/syzbot-assets/f423739e51a9/vmlinux-7c6a3a65.xz
> > kernel image: https://storage.googleapis.com/syzbot-assets/b65a0f38cbd7/bzImage-7c6a3a65.xz
> >
> > IMPORTANT: if you fix the issue, please add the following tag to the commit:
> > Reported-by: syzbot+8a02104389c2e0ef5049@syzkaller.appspotmail.com
> >
> > ==================================================================
> > BUG: KCSAN: data-race in virtqueue_disable_cb / vring_interrupt
> >
> > write to 0xffff88810285ef52 of 1 bytes by interrupt on cpu 0:
> >  vring_interrupt+0x12b/0x180 drivers/virtio/virtio_ring.c:2591
>
>
> Yes, it's racy!
>
> 2589:        /* Just a hint for performance: so it's ok that this can be racy! */
> 2590:        if (vq->event)
> 2591:            vq->event_triggered = true;
>
>
> Question: is there a way to annotate code to tell syzbot it's ok?

In this case, "if (data_race(vq->event))" might be the right choice.

This is a quick guide on which access primitive to use in concurrent
code: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/tools/memory-model/Documentation/access-marking.txt

Thanks,
-- Marco

