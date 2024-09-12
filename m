Return-Path: <linux-kernel+bounces-326755-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E0FD976C90
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 16:48:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6021E1C214D9
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 14:48:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30BA21BC9E1;
	Thu, 12 Sep 2024 14:47:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QftcuLJg"
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1176C1BBBDA
	for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 14:47:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726152427; cv=none; b=E1429hOr3PSVSx+2KfF69OPuQPGJv/pbmLeJki6Bbj7Q+nrg3gzHdR1eVL6kcy6+OsWqKs8RBS3Z743xgXLOs7QBqPfEQ751Nyxw/h4S1uuw3h8IGDLtbyfT2kNn4v68YDUEUmiO1IBlsV0RWbS2oGY88Pzl1P7j0cQV/chNvHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726152427; c=relaxed/simple;
	bh=yysFE99Y5Emir5Z8MTpaSYvkaElUuc2VX9lhXX5Tz2Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EdXqHzjVcwjEUWhVHvJh1u1TlC8+AhckioGOmCNcmsEpsxgx60p8D7B1bk4GYJ8vzfhyerX8Nd7K+MsJFbo2vbp1Cy4IW7W9TP0X65O4eXHIrpRY1bYteSDPY7hPUb39BXNlnrDwte1Paj6w9OSjPAbJEN1y+q6MUiaQc18cov0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QftcuLJg; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-7c1324be8easo1550142a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 07:47:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1726152425; x=1726757225; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=O5RqqAQCKLZ7/+gmavvgQDF/zChWWD9gq5CWrMwyiC0=;
        b=QftcuLJg6ZajxMqOR0I0RASUDfXKoP9y+mKfuSQlgJokeMSGcZzJmPeHYxz40mkTKw
         gorXlqEiU1VEVEX/QjQEvTQ1iq+Voj98TBBmGSKFBvWRo3Ad+F44NGqlpEym38UlQTz8
         BL8t98JbjN7dJsYY+AkYbTbGp2N8i9FY3p7n/nIhR5puq8/XE6LK3g5gEw7lAbTTZAob
         kqozQ9GKVflxDvcndyTuK+Z+SL0iw0p0UiyUH74MmZ/PtIheyy0BpoJjR3vL/zgDVIFg
         4szHCxBTfDfiVcky+z1OKoDbGeK+UxSb30R90KA8dTeQ+Mv37UlcRWoSQOAl1vXwiVWb
         2g6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726152425; x=1726757225;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=O5RqqAQCKLZ7/+gmavvgQDF/zChWWD9gq5CWrMwyiC0=;
        b=uKNGUANBLSJrF1nP7f96lkQP9OeJapCVpIzTTl+v/e8y3UqSy4FrdD/UZnZVGLPUIj
         eKhpZ6vPxCFR2InAJl8daXzPWnX0AARMreU10v/FlxGvZVX69WFEq2vnBvUGEph7HExw
         OBH1tzyzjX+fKSZDxL9kRRog88a7Z2thS8Pr9j+UlW+gC85SdtaqQAQlPCW+e+d/nv4j
         yOzbvZeDmwRpE5CMe+hvv1QQLlzev/6sPS18kZZiGmX1Vhlyxkm5SajCg1NQe67w6zgR
         yK8mkMJr4i3d07iU2/ucPmMP+izeDC520KLDJqA62AIMIOQ2fwxKkUnPCfOJ77cDDxqM
         NS3w==
X-Forwarded-Encrypted: i=1; AJvYcCXJ//p07DP7GnrwysFSCfE5lV8fKGR+6TRMFXbXdtik0m4DjlInLbAASN6eUr6fcgkois9TEW1himW0D4c=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2EWmznc2RG+f/5ZhCd7JgvKXYkI9nmvru/VCFuxqlapJgl9bM
	jkHvnlxc4n/2j6IH1Yjr2/DsHrrG9QIa3ouTli7rJj4l8Hra6y5WXws6QKzxOZ7n548zm4gC1FE
	IwiL57XYKjqwikBIAj5DbF/PYf48oJWDGgGYG
X-Google-Smtp-Source: AGHT+IFust92Fikdsqho6imV+PsPdvyXW21u1a9qb23cqJI7Y7HiY2EO8+6cZUItE74mHAq0kFTKlPW6DkWtVMyTj7Y=
X-Received: by 2002:a17:902:e952:b0:205:7007:84fa with SMTP id
 d9443c01a7336-2076e61e31amr46398585ad.28.1726152424882; Thu, 12 Sep 2024
 07:47:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <000000000000e2058e0621e7a637@google.com> <20240912070121-mutt-send-email-mst@kernel.org>
 <CANpmjNN+3TwdxkvnFzzeQNOVXq-smqpi+xtkw0j+Pd-BGkrgFw@mail.gmail.com> <20240912103017-mutt-send-email-mst@kernel.org>
In-Reply-To: <20240912103017-mutt-send-email-mst@kernel.org>
From: Marco Elver <elver@google.com>
Date: Thu, 12 Sep 2024 16:46:28 +0200
Message-ID: <CANpmjNOGpVXXdi61vFJDPB4CHsd3ksotjdQHO6WiVXV2m-aABg@mail.gmail.com>
Subject: Re: [syzbot] [virt?] KCSAN: data-race in virtqueue_disable_cb /
 vring_interrupt (4)
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: syzbot <syzbot+8a02104389c2e0ef5049@syzkaller.appspotmail.com>, 
	eperezma@redhat.com, jasowang@redhat.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com, virtualization@lists.linux.dev, 
	xuanzhuo@linux.alibaba.com
Content-Type: text/plain; charset="UTF-8"

On Thu, 12 Sept 2024 at 16:34, Michael S. Tsirkin <mst@redhat.com> wrote:
>
> On Thu, Sep 12, 2024 at 03:48:32PM +0200, Marco Elver wrote:
> > On Thu, 12 Sept 2024 at 13:03, Michael S. Tsirkin <mst@redhat.com> wrote:
> > >
> > > On Thu, Sep 12, 2024 at 01:11:21AM -0700, syzbot wrote:
> > > > Hello,
> > > >
> > > > syzbot found the following issue on:
> > > >
> > > > HEAD commit:    7c6a3a65ace7 minmax: reduce min/max macro expansion in ato..
> > > > git tree:       upstream
> > > > console output: https://syzkaller.appspot.com/x/log.txt?x=1608e49f980000
> > > > kernel config:  https://syzkaller.appspot.com/x/.config?x=1e7d02549be622b2
> > > > dashboard link: https://syzkaller.appspot.com/bug?extid=8a02104389c2e0ef5049
> > > > compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
> > > >
> > > > Unfortunately, I don't have any reproducer for this issue yet.
> > > >
> > > > Downloadable assets:
> > > > disk image: https://storage.googleapis.com/syzbot-assets/a1f7496fa21f/disk-7c6a3a65.raw.xz
> > > > vmlinux: https://storage.googleapis.com/syzbot-assets/f423739e51a9/vmlinux-7c6a3a65.xz
> > > > kernel image: https://storage.googleapis.com/syzbot-assets/b65a0f38cbd7/bzImage-7c6a3a65.xz
> > > >
> > > > IMPORTANT: if you fix the issue, please add the following tag to the commit:
> > > > Reported-by: syzbot+8a02104389c2e0ef5049@syzkaller.appspotmail.com
> > > >
> > > > ==================================================================
> > > > BUG: KCSAN: data-race in virtqueue_disable_cb / vring_interrupt
> > > >
> > > > write to 0xffff88810285ef52 of 1 bytes by interrupt on cpu 0:
> > > >  vring_interrupt+0x12b/0x180 drivers/virtio/virtio_ring.c:2591
> > >
> > >
> > > Yes, it's racy!
> > >
> > > 2589:        /* Just a hint for performance: so it's ok that this can be racy! */
> > > 2590:        if (vq->event)
> > > 2591:            vq->event_triggered = true;
> > >
> > >
> > > Question: is there a way to annotate code to tell syzbot it's ok?
> >
> > In this case, "if (data_race(vq->event))" might be the right choice.
>
> No, vq->event is not racy.

Oops - yes.

> The race is between a write and a read of event_triggered.
> I think data_race tags a read, it can not tag a write, correct?

data_race() takes an expression, so either read or write can be
enclosed - e.g. "data_race(vq->event_triggered = true);" works as
well.

