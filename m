Return-Path: <linux-kernel+bounces-203591-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A36148FDD8F
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 05:38:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1653028496E
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 03:38:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 259481DFEB;
	Thu,  6 Jun 2024 03:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IYiDmYng"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3AF219D89B
	for <linux-kernel@vger.kernel.org>; Thu,  6 Jun 2024 03:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717645125; cv=none; b=eLWVHUh+yXpH4Yaf9yuJOhJ2KhUs6un2SxS72qFnlAkKLZFgNRuQ23B/hIZgNehA9AswWc9FNF2Q5AtvAxgVMmRwNZbr0vJXrS+ekjKR96YcC7PNK58kChMx6zqqX6HyGhHorAhRQ/TFBTfuNV+WGfmzqc89xhg5/FOWfKqJ2Rw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717645125; c=relaxed/simple;
	bh=viBMVzMVJzk4djRwu6o8wINRdpBLjvA+yfIALtdxOds=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cMeSb7o36ZVuFuSBwRH5iyaFKAWVn0J4HESmFgWZKp3Tgt6zfSPXUlVHxp+h6u4TQEx//bLxGh5DkwMW3tzRgQRM58jTyYJsKkboEqip6shoH31ZzjcJnC2Tp6MRz2dPzDX78+aYYsYS3SIgqW+R7GLW8J2kjiM8+lY8/qntRlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IYiDmYng; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-42152bb7b81so41335e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jun 2024 20:38:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1717645122; x=1718249922; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n+sCN4gd5xRSv8MbZzfOM4BQL071QPAHGQYJsY8mOBI=;
        b=IYiDmYngqI37l0frb5drurlkjU9+L83ne1UH7tuY/8M0kFQWp63q3E1ZN+aZ92hSG1
         MQSGj0gN4r+Q9uoQfJcCyl0n37O5+jVUcqjpa8cSFSTno1nNfhfhBkxrrNVDM41xSEPD
         fktBpapTey3LdX37MsH8Z+LvstFusNtjHI04crasiyM1uB7dbGrowMMurDOFVgoVP5lm
         jYO2tNMDhkYX7ZkExyXlaT2kf5dX1acWvW6Qxbr7FouFT5S4c8TNlVprxJcLHtQq2MCE
         LpJjCrkcFLlLM/iYLnyrbo+h+nyDg1guSkykw/ZqQpTLyNI+DqEh1+nf6ZsksVMoJOo5
         OrRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717645122; x=1718249922;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n+sCN4gd5xRSv8MbZzfOM4BQL071QPAHGQYJsY8mOBI=;
        b=xOhEZaVeUKnXZnXWbZcqCvvFvQzo1S712apsQ0X7UOouXug8KcpwlZMiqQEl3CQnfi
         twCFtESiGQWwSnIT9QQqCcaxGXud8UUzEZtWuDYkKEcRr3jFb9m5dfAphUg/CqxVF8ZV
         vMt25kFCKCCPY93CtzHReYHAP1jeuLb+aBEENDIWH4GLsosL46P2z9jqNAxBc7jLw6hC
         HaDgOeecCzddDOacQ7ubpVReFRl5IPzSL/4jXpKs1Jmud6OA31n3uVyZemX3BjsPzx4p
         9WemaMHmBLVdQ+3mMyS+TlPIm1vn8U/oEAP0dNj4KJ99aqVujcPiq859dANen9yXQxnU
         N7uQ==
X-Forwarded-Encrypted: i=1; AJvYcCUpfAsTpuoCBxW6qWz2rx5eRkPkjqqZ5olhayjVGYjtTQM/iqoP7HiNSItCA8gloQlVw7S5MNk0Ndd4kHGm5QQTonEomkditCRHbuy2
X-Gm-Message-State: AOJu0YyTkvLBevliztaIGnSRuFzn4JMglqVsgKpg0Q7mY08U0GF8Uz/R
	TO1gS4P6+0+of/wK2myyvQlHXHVGkFgCIMsrpMUm3fo+WllNE/pkJMR7mZCPmQK/ACwZeax5GA9
	PskOoBQMXn3lMUR/Eo9WMNaPrTo1RpOmt6Weh
X-Google-Smtp-Source: AGHT+IED6sI5jxhMT1wmnXVkKvgDEwPtPXeaSABuPbsUuWB+6ngoSn1LlcVFANBPnv+O+WxbFbVMvWEPm1NPGNA5yhc=
X-Received: by 2002:a05:600c:1c09:b0:41a:444b:e1d9 with SMTP id
 5b1f17b1804b1-4215b7a0ae5mr1228175e9.4.1717645121762; Wed, 05 Jun 2024
 20:38:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240508202111.768b7a4d@yea> <20240515224524.1c8befbe@yea>
 <CAOUHufZ-9NmzOKjLedvZFp0=N0LvRZn77qC6k1WXK+NHtKr=0w@mail.gmail.com>
 <CAOUHufZ36rQc8AfLtRv2QrEareysdvbprAEO5XkcG-FeDOxFLA@mail.gmail.com>
 <45fc081c-ee8d-4774-a597-708d2924f812@redhat.com> <87tti6pxxc.fsf@mail.lhotse>
In-Reply-To: <87tti6pxxc.fsf@mail.lhotse>
From: Yu Zhao <yuzhao@google.com>
Date: Wed, 5 Jun 2024 21:38:04 -0600
Message-ID: <CAOUHufacbbpS3ghEwsQ-pObttnQk__xo0vjpGWXNq1i-bsuiGw@mail.gmail.com>
Subject: Re: kswapd0: page allocation failure: order:0, mode:0x820(GFP_ATOMIC),
 nodemask=(null),cpuset=/,mems_allowed=0 (Kernel v6.5.9, 32bit ppc)
To: Michael Ellerman <mpe@ellerman.id.au>, Erhard Furtner <erhard_f@mailbox.org>
Cc: David Hildenbrand <david@redhat.com>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 5, 2024 at 9:12=E2=80=AFPM Michael Ellerman <mpe@ellerman.id.au=
> wrote:
>
> David Hildenbrand <david@redhat.com> writes:
> > On 01.06.24 08:01, Yu Zhao wrote:
> >> On Wed, May 15, 2024 at 4:06=E2=80=AFPM Yu Zhao <yuzhao@google.com> wr=
ote:
> ...
> >>
> >> Your system has 2GB memory and it uses zswap with zsmalloc (which is
> >> good since it can allocate from the highmem zone) and zstd/lzo (which
> >> doesn't matter much). Somehow -- I couldn't figure out why -- it
> >> splits the 2GB into a 0.25GB DMA zone and a 1.75GB highmem zone:
> >>
> >> [    0.000000] Zone ranges:
> >> [    0.000000]   DMA      [mem 0x0000000000000000-0x000000002fffffff]
> >> [    0.000000]   Normal   empty
> >> [    0.000000]   HighMem  [mem 0x0000000030000000-0x000000007fffffff]
> >
> > That's really odd. But we are messing with "PowerMac3,6", so I don't
> > really know what's right or wrong ...
>
> The DMA zone exists because 9739ab7eda45 ("powerpc: enable a 30-bit
> ZONE_DMA for 32-bit pmac") selects it.
>
> It's 768MB (not 0.25GB) because it's clamped at max_low_pfn:

Right. (I meant 0.75GB.)

> #ifdef CONFIG_ZONE_DMA
>         max_zone_pfns[ZONE_DMA] =3D min(max_low_pfn,
>                                       1UL << (zone_dma_bits - PAGE_SHIFT)=
);
> #endif
>
> Which comes eventually from CONFIG_LOWMEM_SIZE, which defaults to 768MB.

I see. I grep'ed VMSPLIT which is used on x86 and arm but apparently
not on powerpc.

> I think it's 768MB because the user:kernel split is 3G:1G, and then the
> kernel needs some of that 1G virtual space for vmalloc/ioremap/highmem,
> so it splits it 768M:256M.
>
> Then ZONE_NORMAL is empty because it is also limited to max_low_pfn:
>
>         max_zone_pfns[ZONE_NORMAL] =3D max_low_pfn;
>
> The rest of RAM is highmem.
>
> So I think that's all behaving as expected, but I don't know 32-bit /
> highmem stuff that well so I could be wrong.

Yes, the three zones work as intended.

Erhard,

Since your system only has 2GB memory, I'd try the 2G:2G split, which
would in theory allow both the kernel and userspace to all memory.

CONFIG_LOWMEM_SIZE_BOOL=3Dy
CONFIG_LOWMEM_SIZE=3D0x7000000

(Michael, please correct me if the above wouldn't work.)

