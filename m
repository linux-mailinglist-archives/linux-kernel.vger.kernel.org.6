Return-Path: <linux-kernel+bounces-191924-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 100CA8D1621
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 10:19:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B20D91F253B5
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 08:19:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B59A6F079;
	Tue, 28 May 2024 08:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="ISvD7liY"
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18C1613AA32
	for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 08:19:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716884385; cv=none; b=C4n8M9mh7x2yDYLizNff3uf7kZqvLcDQ9X+ZNTg/0b3WIu5+EPsQHT8FzK3IOaiPZZ4FN9IzjHcpPLHSPxaZb0x509t05SMLSZC7l69UU27J6uuGPQon42g9MIqjTdWhgBNctzYJrMBUzbUXySTGOH+9qXbUzlVGg0k3HM8ipz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716884385; c=relaxed/simple;
	bh=APKFV9eb2v+VaT8bLUdlycdrBfJ2rlkBUd7qW2g0UHk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XCHgS6ZOwbDaVElNzFTNUTip2r2IwU7iXLaX60kL3p2DyiAGybo40I5RwWb7r9RPIC4HqDbe/ZIMyDNeFVgWTKrsbshMuoW1GcI27rt4PgcPV9VRkB4HvSP50ValA8n2PKNLAwLVow8UIBU5rwz3w3IpcDsCsBkgaez+bLxL3js=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ISvD7liY; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-6ab9ce64683so3410176d6.0
        for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 01:19:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1716884383; x=1717489183; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=APKFV9eb2v+VaT8bLUdlycdrBfJ2rlkBUd7qW2g0UHk=;
        b=ISvD7liYK1sLfzoTUpCqHA+K/e2a9dfp8hMeBD/sByy7tzypcXcD9vov3UIhnInSSN
         z2PzxiLcOCspIsSqASDG59X6x8JCyVBatdgPYkUzIxsabctzw8UA2pH2HolEAzwFdraC
         NZWwkirqlxr8nyPY3iejFeN8N4d2zASwpuUqHxY4PGzzA4ROG7YdZYVJ7MccGWcmGnnD
         lvkMt/y90mdCpQ12Yi1AlZe0vNvNwFim8B7JPwB4v9Y4r9AdJsY+0VBuEkQWv59vpr/e
         1L2UeYxklQ1LZsOYqsHutTY+XI+kD/P77psBapIMa91iBY7U716xFGEXMFM058GKcM0p
         UB3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716884383; x=1717489183;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=APKFV9eb2v+VaT8bLUdlycdrBfJ2rlkBUd7qW2g0UHk=;
        b=SsQLijwq6Md7Qrox2b3LovclcuCa6GUYKYt0CL7h8Ie0qMQylJzZrzBmY6ccqyx/Cu
         67lgihf3DwZ889yNnvCeoYo9gVAPMMu3WwmYf53LDOFs8QZV/WvSiJ4Vc9F+NbFjoJI2
         FP9ssVC7OElMpQHECBcXTwu/hVWIVJo1DDnticqCMn47F6oi359JjfIcZTGZOKGdGzgH
         Qq7y4MGI71fpudi83imm7p+4H1t5DcmLLM3UKsROVsdT7PbE/RWaeUrw+7rkGjKgAYMo
         4wW4Rkv+ge/KkI9XKwYU2FB0EPmxmD1q28c5h1ZMevys9f8LHwQrqzBB/v758U1Qg/v4
         OY+w==
X-Forwarded-Encrypted: i=1; AJvYcCXPtpUtGTZA/2wPmHyaayqCQGRhdRgsB5N/5FMoaCFEq9kSvrhORvbLdpGOr2aRHwVL3aZlQSiXtfmlZX83Ybyjwz4A/vwsKEmGi102
X-Gm-Message-State: AOJu0YwFDAsw8C7k872N+9qSoNxmQJXQMaXbOtT26HtxUoDY3NqodYvZ
	n8E2pBsbN1H2WkgXHGyg2uG+VCm1//9PFx+L/dl7KNXnPC6wfGrnn7RobPRJGpPibd8ySoitvPa
	b8QMzUpGAouEoeDVxGksVUTZ/k0oZT273Ilvj1B4EzF3l2STlbp/l
X-Google-Smtp-Source: AGHT+IG9kXoWpuC4Ix7V4wPnSa5HxxGbI3O7kucQ+Z4K1uR5nDxN08cLZOYJo2Jd8QQ3aZOHyTkIGsHohuSwHfrZh+0=
X-Received: by 2002:a0c:fe8e:0:b0:6ad:16a5:4842 with SMTP id
 6a1803df08f44-6ad16a54a20mr114449566d6.15.1716884382871; Tue, 28 May 2024
 01:19:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <0000000000009f9447061833d477@google.com> <jgtxdyooy6zyettrj53qi7s7z5fs5zpnwdjm7eqpihwo32lxzx@v2234ezsba4d>
 <CAG_fn=WmDCOXxAzaEJtDYuEY4b3Nq99Z7=1-tmwTx9Ox7BG0AA@mail.gmail.com>
In-Reply-To: <CAG_fn=WmDCOXxAzaEJtDYuEY4b3Nq99Z7=1-tmwTx9Ox7BG0AA@mail.gmail.com>
From: Alexander Potapenko <glider@google.com>
Date: Tue, 28 May 2024 10:19:02 +0200
Message-ID: <CAG_fn=WZ=i2WLAVcLGhXkfm_9CouEf8v9PoLL-zJ0TJZZSXZ6Q@mail.gmail.com>
Subject: Re: [syzbot] [bcachefs?] KMSAN: uninit-value in bch2_extent_update_i_size_sectors
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: syzbot <syzbot+eceea46e8838baeeba67@syzkaller.appspotmail.com>, 
	bfoster@redhat.com, linux-bcachefs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 23, 2024 at 10:15=E2=80=AFAM Alexander Potapenko <glider@google=
com> wrote:
>
> On Thu, May 23, 2024 at 1:49=E2=80=AFAM Kent Overstreet
> <kent.overstreet@linux.dev> wrote:
> >
> > This (and a few others I've looked at) look more likely to be bugs in
> > KMSAN, not bcachefs.
>
> Yeah, this is possible if we are missing some initialization.
>
> >
> > here, the supposedly uninitialized key was read in from disk, so the ke=
y
> > couldn't possibly have been legitimately marked uninitialized.
>
> Am I right that the key is supposed to be initialized before the first
> call of memcpy_u64s_small() (the _lower_ "Uninit was stored to memory
> at:" stack trace)?
> Do you have an idea what code performed the actual load of the data from =
disk?
> If that load was done by some assembly routine, we could've easily
> missed that - in that case we'll need to annotate it to fix the false
> positives.

I thought the initialization here was done by constructing a `struct
bio` in fs/bcachefs/btree_io.c and passing it to
submit_bio()/submit_bio_wait(), but I couldn't see return values of
btree_bounce_alloc() being used in bio_vec elements.
Are there other places that perform disk I/O?

We need something similar to kmsan_handle_dma()
(https://elixir.bootlin.com/linux/latest/source/mm/kmsan/hooks.c#L328),
but for block IO, so that data copied from the device can be marked as
initialized.

