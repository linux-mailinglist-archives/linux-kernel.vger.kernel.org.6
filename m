Return-Path: <linux-kernel+bounces-530734-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B363A437A2
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 09:30:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8930F178C75
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 08:29:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E030260A31;
	Tue, 25 Feb 2025 08:28:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W+3vlCZa"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90F022586CD
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 08:28:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740472128; cv=none; b=uIK71MYieesamx/A28NV+8X68vrstQ5CrNhwe5BAczJjd1vxFuRMIjCVoz+D9jQXdTYP0taZ7q5hxGVur6lFSSy0W0SwT6s1uhGAcCSYrv49zDdUd8wfnd1A3z84xKsbRJQuaRqXA7Hf2EvKPuQN/sXke358kudKwiAao2UGdl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740472128; c=relaxed/simple;
	bh=8vPpJ8olOuwN9lQFG5YAxtDVHtl13Hwmn7GTiIrcqhc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=G2DpaEbPLCkLp20SfP7I+PHfT9bZJ/PJBSkDXOdCJ6WcW94LHOuxmHeiN1FJ/k0eE476FcpEQJ2ulaTfiW0LEwxkZq0htXGSFvkv2IoyHmTZlt1pOutMZlkLkvH5m2HfNbHJZ30nyUmIh9KN9UtUufFz07p2iXSH8LlBzNLlpRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W+3vlCZa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10E4EC4CEDD
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 08:28:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740472128;
	bh=8vPpJ8olOuwN9lQFG5YAxtDVHtl13Hwmn7GTiIrcqhc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=W+3vlCZa9bUAZTxTn/9J71uNJbnotvyK9PmaPGkw4X4oDmLXIMxWqkfsCcSwSLluV
	 Db0FfEvW+SAZXPOywDNfozz7H/frK0a4sToUc9cyCm5/VAuZ+/uGiuR3lr9A7lfGCY
	 qyXUeAX0oNyqtPXG6eDHAyyo0jGeM7qolZiMPt04E3KDkWD7fkZnQWcINq2VcNejEh
	 vxeCel3h2xVc0TK+G5o0zlcuBWI8sDdcnkf5aU0ERlRZAbkwMHPX1cUtjszlMPdL38
	 S1b6ZxUhfwR3IuBuqzMcFMsOubgserxyc4QJoNuO0ut0gfcaSWRY7T92LX05cN3tEJ
	 DLJRIviLFdGoQ==
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-5461dab4bfdso6377350e87.3
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 00:28:47 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVPzioYZB78cEtF4TqOBAkI7cMC0QNS4ReS/6uNNBgX+MJ5vm13qBHTpWJYGr+i7/wc2vd/UBCU4M/6d3g=@vger.kernel.org
X-Gm-Message-State: AOJu0YyW7+iJYoGZr4Koc2hs0qsh4TS579l1kPYFZCQGxTz6zTgk+p9N
	riT3BgzixWzAO6ArBi582BjSJ6OXhd50wXv5mJ1UkQfzJ9aScr0LCVuYoDF/teDCP92zYFm8NUN
	250RMJYnVqxH8+Xns6ev2Y5yi0BE=
X-Google-Smtp-Source: AGHT+IEo2P1y8oZ4sGjozx2IPF/FoxHw0AwPGW5G+13Hqko9jHR6xC99gVXu+gG39GPDa7xUUBqQyzk+N/BNjhsnf4Q=
X-Received: by 2002:a05:6512:ba6:b0:545:8f0:e1a4 with SMTP id
 2adb3069b0e04-54838f5b0c7mr7334086e87.45.1740472126391; Tue, 25 Feb 2025
 00:28:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250224062111.66528-1-kpark3469@gmail.com> <CA+KhAHYujgeC2kAd-vs0N0zwprpeqtD8G-8DpJ0w2RSxzZ5SQw@mail.gmail.com>
In-Reply-To: <CA+KhAHYujgeC2kAd-vs0N0zwprpeqtD8G-8DpJ0w2RSxzZ5SQw@mail.gmail.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Tue, 25 Feb 2025 09:28:35 +0100
X-Gmail-Original-Message-ID: <CAMj1kXH-QmuXGi-5MSEzz7zSpPYWvM2eBPN-NbWF+R=49P2_2g@mail.gmail.com>
X-Gm-Features: AWEUYZmXdqSofSbFbm1Jzg5QlVhvXfgc9GSCI-mItVYgS6fAb-clLZXGzXceAac
Message-ID: <CAMj1kXH-QmuXGi-5MSEzz7zSpPYWvM2eBPN-NbWF+R=49P2_2g@mail.gmail.com>
Subject: Re: [PATCH] arm64: kaslr: consider parange is bigger than linear_region_size
To: Keun-O Park <kpark3469@gmail.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	catalin.marinas@arm.com, will@kernel.org, Keuno Park <keun-o.park@katim.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 25 Feb 2025 at 05:48, Keun-O Park <kpark3469@gmail.com> wrote:
>
> On Mon, Feb 24, 2025 at 10:21=E2=80=AFAM Keun-O Park <kpark3469@gmail.com=
> wrote:
> >
> > From: Keuno Park <keun-o.park@katim.com>
> >
> > On systems using 4KB pages and having 39 VA_BITS, linear_region_size
> > gets 256GiB space. It was observed that some SoCs such as Qualcomm
> > QCM8550 returns 40bits of PA range from MMFR0_EL1. This leads range
> > value to have minus as the variable range is s64, so that all the
> > calculations for randomizing linear address space are skpped.
> > As a result of this, the kernel's linear region is not randomized.
> > For this case, this patch sets the range by calculating memblock
> > DRAM range to randomize the linear region of kernel.
> >
> > Change-Id: Ib29e45f44928937881d514fb87b4cac828b5a3f5
> > Fixes: 97d6786e0669 ("arm64: mm: account for hotplug memory when random=
izing the linear region")
> > Signed-off-by: Keuno Park <keun-o.park@katim.com>
> > ---
> >  arch/arm64/mm/init.c | 5 +++++
> >  1 file changed, 5 insertions(+)
> >
> > diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
> > index 9c0b8d9558fc..2ee657e2d60f 100644
> > --- a/arch/arm64/mm/init.c
> > +++ b/arch/arm64/mm/init.c
> > @@ -290,6 +290,11 @@ void __init arm64_memblock_init(void)
> >                 s64 range =3D linear_region_size -
> >                             BIT(id_aa64mmfr0_parange_to_phys_shift(para=
nge));
> >
> > +               if (range < 0) {
> > +                       range =3D linear_region_size -
> > +                               (memblock_end_of_DRAM() - memblock_star=
t_of_DRAM());
> > +               }
> > +
..
>
> In most cases, the hotplug memory code will be working the same as before=
.

How so? Such memory will usually appear above memblock_end_of_DRAM(),
and due to the randomization, there may not be any space left there.

