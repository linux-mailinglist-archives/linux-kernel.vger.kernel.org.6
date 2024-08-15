Return-Path: <linux-kernel+bounces-288230-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 969EA9537A9
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 17:53:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C860C1C254FB
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 15:53:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFF211B1509;
	Thu, 15 Aug 2024 15:53:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="LVfdIiA+"
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43ED31B1417
	for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2024 15:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723737220; cv=none; b=FU2IRSqhLpCbtC8UY3IX6n0ggAvzjkRrimTJBGEQaXiSRz1DHB0kKWMvc7gFarwVrh+g5knwY3BfNKWgGsbybe3JJ/aeMSnb6Ddi8zfmLxA+n/f+LB4BgVGBIHV9YHEI3+199fq0d7x4VXci7vFGIG1oA2ilrsYRB5I8n8i7fH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723737220; c=relaxed/simple;
	bh=AZmB4KQjYVPTh/aZQ/7s8sXUMF65fWMG6B2GFw71RUE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=N+uswf5GYMWV4JOfRXhs2NWyjyXZ26m6zV8R/gfvY7M3Yrh20BKn/LYy9PiLYyvEM1KvzDw3SN7ktGpMy3d896dm4aLeDyl5nFWPV6fHAiQQwOnBMFxgMLmi3BpN/0mPz0tElF6xqvr2MsWD5MTcQ73GgxExYvre9d6P1S9/+1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=LVfdIiA+; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5ba482282d3so1378249a12.2
        for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2024 08:53:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1723737216; x=1724342016; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AZmB4KQjYVPTh/aZQ/7s8sXUMF65fWMG6B2GFw71RUE=;
        b=LVfdIiA+DzYBPhVujQrmTt3TPhkMePHa4QoRiaSoFD61RVflGXi5yw/tWi/jQdwosb
         0FjySU6+w7VvEnXJLWxnjPLarndBip0C+dAwhdJBDAim2B33BHO2WMTcbMdi49mHpS4/
         NcqnnClR/KPJx/Oaos8fuyqyLxKKe3FFq/ZcBAMnYv5LZc/MotV3tVUb1i8zU0Ncc1xO
         HD4Y+ux8yRDJSnXSR92/uunoMMd4JfHPghSTgrD1c/zeD9NMM93KLe9fvRtl9Lk5+R5L
         MWPpt0eNtg+uM0/KbXrKjsDYntKW3YUnIzwNrVX/5KQO5qGGFPWeP8u8ibacE2dlkXP7
         c2qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723737216; x=1724342016;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AZmB4KQjYVPTh/aZQ/7s8sXUMF65fWMG6B2GFw71RUE=;
        b=cCnZ7iVNUUChK13pDKO4YyfodIrt+K6oFHyL68Lxx2sNJ/o5CnYt2x2LbNrWZKKDDI
         5rVetUwK9NABMWyg2RHmeAW4SDzaLZ7OiSKZvLjPd4JTxFGWNLhbtbvgv8jVoJkdgubd
         qKiGvUQzJLKxKdKZ5UUE+LDjK0597nzbXUMcjJ4PSYZoNvP11qODtpCdtMnJdmO5zLyd
         naqx+1J5oYKmkZ3NAPtaePdwQYgjV4nPkTiUOsdKkmyXZEOySVFwrS3LxX4OVcwi2yr5
         URSqSF4oasft1SxAb11Cu4ib2u13s6J83Vd/OZaXt2UtgoyR5KsuiDhCkEyY257j/x7l
         rIZg==
X-Forwarded-Encrypted: i=1; AJvYcCVYORgpzExN9rTnMTUr4U829u6hWqlMBFjT+26Zhf655ZmQPF/X/c8aP2obOyNUvGzcph8Elmzit4H5yjOuOf6v4+8aZgWexPEktLmF
X-Gm-Message-State: AOJu0YyUwNwYrvVHnSO87EVA40EV9nrUn0usWCKSr8+LGvtdzq+RnKY1
	0Mh+/ugnYR1cuJy0lBxPEJpKC4hDCqnajgOczlRQ1RgD5+zpU8uBa/jK3AkLu0745yLP8LgfOIt
	2m487tjVnbTlZ6Whru2415x3gFvDGQCkTU0JOpw==
X-Google-Smtp-Source: AGHT+IHxkHjdR0Bka34b01bTPscZFfcYjGFbrkKYDNQXiZxcTVLGsR5lN4i7dy7DFgSmdQDBor8i7crc3gu1aYqT9FA=
X-Received: by 2002:a05:6402:27c9:b0:5b4:cd20:f13c with SMTP id
 4fb4d7f45d1cf-5bea1c73ea6mr4137542a12.16.1723737215796; Thu, 15 Aug 2024
 08:53:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240814145642.344485-1-emil.renner.berthing@canonical.com>
 <87jzgjnh9z.ffs@tglx> <CAJM55Z8WERQgs=QMyFGWvAHOpwcnOAudBqovaEuDudPSXCvL5Q@mail.gmail.com>
 <87ttfmm2ns.ffs@tglx> <CAJM55Z88H635Crc-Aeq+K0qcAk7NC89WVTAFdXDd2aQKQ7QmEg@mail.gmail.com>
 <CAJM55Z_qQX7n8tAeOFqrAH1BFjA9vaWA8rtsPG2BcKmiO88m=Q@mail.gmail.com>
 <87plqalyd4.ffs@tglx> <686d61c4-e7ac-4dca-a7fd-decdd72e84d9@sifive.com>
 <CAK9=C2VHfPnYx8gMjodJNLu9+yR4KvuPXeQZiyZcbu1Mvze-0Q@mail.gmail.com> <7902c26a-d719-45ad-85d5-61ce6bbc9459@sifive.com>
In-Reply-To: <7902c26a-d719-45ad-85d5-61ce6bbc9459@sifive.com>
From: Anup Patel <apatel@ventanamicro.com>
Date: Thu, 15 Aug 2024 21:23:23 +0530
Message-ID: <CAK9=C2W1dNx5D9dUCDA1-iTGbPQz_utEjzcmOOaoPCHw_sSPpA@mail.gmail.com>
Subject: Re: [PATCH v1 0/9] Fix Allwinner D1 boot regression
To: Samuel Holland <samuel.holland@sifive.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, 
	Emil Renner Berthing <emil.renner.berthing@canonical.com>, linux-kernel@vger.kernel.org, 
	linux-riscv@lists.infradead.org, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Daniel Lezcano <daniel.lezcano@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 15, 2024 at 8:33=E2=80=AFPM Samuel Holland
<samuel.holland@sifive.com> wrote:
>
> Hi Anup,
>
> On 2024-08-15 9:30 AM, Anup Patel wrote:
> > On Thu, Aug 15, 2024 at 7:02=E2=80=AFPM Samuel Holland
> > <samuel.holland@sifive.com> wrote:
> >>> Yes. So the riscv timer is not working on this thing or it stops
> >>> somehow.
> >>
> >> That's correct. With the (firmware) devicetree that Emil is using, the=
 OpenSBI
> >> firmware does not have a timer device, so it does not expose the (opti=
onal[1])
> >> SBI time extension, and sbi_set_timer() does nothing.
> >
> > OpenSBI uses platform specific M-mode timer (mtime and mtimecmp) to
> > provide SBI time extension to Linux.
> >
> > The RISC-V privileged specification (v1.10 or higher) requires platform=
 to
> > provide a M-mode timer (mtime and mtimecmp).
> >
> > This platform not having any M-mode timer is yet another RISC-V spec
> > violation by this platform.
>
> You've misunderstood here. Allwinner D1 (T-HEAD C906) _does_ have an M-mo=
de
> timer (a CLINT). It is just omitted from devicetree that Emil happens to =
be
> using, so OpenSBI isn't using it.
>
> Currently OpenSBI allows the system to boot without a timer device, and t=
he SBI
> specification does not mandate the time extension. If consensus is that e=
ither
> of these should change, that's fine, but currently I see nothing in eithe=
r the
> privileged spec nor the SBI spec that guarantees the availability of some=
 timer
> to the kernel in S-mode.
>

The SBI time is certainly optional hence OpenSBI does not hang or crash if
it can't provide SBI time to supervisor software.

My comment is from the RISC-V privileged spec perspective:

1) Priv v1.10 says "Platforms provide a real-time counter, exposed as a
memory-mapped machine-mode register, mtime." in section "3.1.15 Machine
Timer Registers (mtime and mtimecmp)".

2) Similar statement in Priv v1.11 section "3.1.10 Machine Timer Registers
(mtime and mtimecmp)"

3) Similar statement in Priv v1.12 section "3.2.1 Machine Timer Registers
(mtime and mtimecmp)"

But since the M-mode timer was omitted from the DT, I think the DT was
always incomplete from the M-mode perspective.

Regards,
Anup

