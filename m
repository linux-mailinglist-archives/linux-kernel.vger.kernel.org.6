Return-Path: <linux-kernel+bounces-540774-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 220A8A4B4C3
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Mar 2025 21:56:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8DE2416CDCF
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Mar 2025 20:56:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA6AE1EE008;
	Sun,  2 Mar 2025 20:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fpUk4GVI"
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 506963597E
	for <linux-kernel@vger.kernel.org>; Sun,  2 Mar 2025 20:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740949000; cv=none; b=V6RnNfFNmKlN+neU1YVXD7uqgWaiUW7CpSaY7V6Q+Y8+Y7Dgqos3DAlo6Gw6va7FuSUlOd3hkIt6YPVdyZfCmODfq6fbL1IlxEixE7dfdgdD8yfeGq4p8NZlhlxZvafNgNGAm+nj8Nebo4L+ez6zNIfLszGDAVgV2LWaocmk63Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740949000; c=relaxed/simple;
	bh=uvhHeCdumuHTc4mF/u6hb+vdPZ0/fgTzFp9TOge6ZdA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SDBT5pLYaEaUpQRPAC5gPxc6Ciro6HChWBsdcri7u8TIwiABJEwRoMYZnjEcry9qzKE5Ak1bYKYalC8+CaFhk46IOe1eNqFWc208u5ZOZtzFgbFIqGMbSWn1+YBrhjLLpMr9TDHnYQC79SViS8W7a4zHj9ARDuVp3YJKC6GVmFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fpUk4GVI; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-5439a6179a7so3957914e87.1
        for <linux-kernel@vger.kernel.org>; Sun, 02 Mar 2025 12:56:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740948996; x=1741553796; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=zLsT88oXeeVZfrOT3B/KnIDbhBLXb80bdw1QlRErsxg=;
        b=fpUk4GVIh6woYINxjZt6PwPx32+wnjR2dztc7qJf2IT009e+OVooYBqQUN/KWPWcGN
         18Nflr9QDN3mEIEiJu3JszT7qbuvTQM9UzKJZjQgXC5MDNSENlEC6K5X83KaISZ9mp1G
         g2v4j7slJOBAlO4On2KHVEgWtVzgEcr21FJCYT43HhPngFSCSR5YGiO0r6tJ5eLARgsz
         z65T5w+Q4kyPXNLqahFz+jPiqlMFMRksRnE2p21KNH3VgKgQHBB7XKAnmQV38VgbeGej
         gkTJ4+XciVCTwvgJjRWsQhH0I4Vz5MtMgkFQ1jnZ5vu+wlATUMoi4F3HH7M7gJrJhT2J
         Z57g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740948996; x=1741553796;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zLsT88oXeeVZfrOT3B/KnIDbhBLXb80bdw1QlRErsxg=;
        b=TEyVvAJHarVU8QSLFb1gXAO2ehydF7HEV4AuoazfUAXvimINKOcpjpZYyVt3alyfZw
         Ln1+6HY6zlUF/WfgKihd38CV/HXeVvX9rPZqU6XJy8OKQ1hD0qLkwqQjvvZ6SkVKSXAD
         VMJJJt2t8URStnno2lqiwbQwswzUvUvxcOCsaOvo8UZsWI67iqQrgMBpjXJ9aeM7+9Pt
         49CN6EKnDX6o/rTObXa3w2noA9TCqMcOSD6MSAHEWmhdzhqq7kexcdr4lcuDeDQ/bvU3
         Ev8zvjPD1Pk4be/viN+9ZzscEI2xfKB7h4xhNVkklGUtbdVWCkSPg9ckp5LNabnREc1I
         kUvg==
X-Forwarded-Encrypted: i=1; AJvYcCWCNG0u1FjGquhPGxTmyczs4rDQoZwEp4pfb/cSDo/EW3xKR/xHjwC4DBh3Jhx6pSaarmuf1Esn5Xq5RSs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQif3CgQV14Qf28Ut4qFbiq23UteLicP5lWRVQFqOSeryxeNyb
	2fWTi6khsImeRXpaVISrNpyN+kafYQAOnonmYNvQa+CYpwcYNVSLRU7urQISpwBMCuc57zSbY+3
	EIg5mdTnAJVp6397/izmY5fzyg8U=
X-Gm-Gg: ASbGncvMK7o9JzKQLRqbPdSYBIFQ2xCqi+KBv9rz3bmwURuqwC48fd0MhYNH12y/sOr
	yrN30C2iQ5MN4mdA6SlvaQ8vojkM4A1dXtHfyg0mvBlXln+c90BtcVl/d6YslUpui9jIU70W5Br
	ROd/IypDzjQzZp/fbEMltWcwuU
X-Google-Smtp-Source: AGHT+IHHULQ9ONddLm3WW8Qo1+oHWDPkY8Qas3rLDG+OBdLCpUtBuzBqeC26MPKX0gGEDSWMPqUnA8iaJcLBCWILktk=
X-Received: by 2002:a05:6512:4024:b0:549:69c1:fd32 with SMTP id
 2adb3069b0e04-54969c1ff21mr371785e87.20.1740948995902; Sun, 02 Mar 2025
 12:56:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250228123825.2729925-1-ubizjak@gmail.com> <20f1af22-71dc-4d62-9615-03030012222e@intel.com>
In-Reply-To: <20f1af22-71dc-4d62-9615-03030012222e@intel.com>
From: Uros Bizjak <ubizjak@gmail.com>
Date: Sun, 2 Mar 2025 21:56:23 +0100
X-Gm-Features: AQ5f1JqyGwrGVZKoEnmzpmtFZMQW9Q5xIRwPmI0Lg7qKYQWCvrkY2KueVLonDVY
Message-ID: <CAFULd4YBcG45bigHBox2pu+To+Y5BzbRxG+pUr42AVOWSnfKsg@mail.gmail.com>
Subject: Re: [PATCH -tip] x86/locking/atomic: Use asm_inline for atomic
 locking insns
To: Dave Hansen <dave.hansen@intel.com>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, 
	Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, 
	Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>
Content-Type: multipart/mixed; boundary="000000000000793a5b062f62460c"

--000000000000793a5b062f62460c
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 28, 2025 at 5:48=E2=80=AFPM Dave Hansen <dave.hansen@intel.com>=
 wrote:
>
> On 2/28/25 04:35, Uros Bizjak wrote:
> > The code size of the resulting x86_64 defconfig object file increases
> > for 33.264 kbytes, representing 1.2% code size increase:
> >
> >    text    data     bss     dec     hex filename
> > 27450107        4633332  814148 32897587        1f5fa33 vmlinux-old.o
> > 27483371        4633784  814148 32931303        1f67de7 vmlinux-new.o
>
> So, first of all, thank you for including some objective measurement of
> the impact if your patches. It's much appreciated.
>
> But I think the patches need to come with a solid theory of why they're
> good. The minimum bar for that, I think, is *some* kind of actual
> real-world performance test. I'm not picky. Just *something* that spends
> a lot of time in the kernel and ideally where a profile points at some
> of the code you're poking here.
>
> I'm seriously not picky: will-it-scale, lmbench, dbench, kernel
> compiles. *ANYTHING*. *ANY* hardware. Run it on your laptop.
>
> But performance patches need to come with performance *numbers*.

Please find lmbench results from unpatched (fedora.0) and patched
(fedora.1) fedora-41 6.13.5 kernels.

lmbench is from [1]

[1] https://fedora.pkgs.org/41/rpm-sphere-x86_64/lmbench-3.0-0.a9.3.x86_64.=
rpm.html

Some tests show quite different results, but I'd appreciate some help
in interpreting the results. Maybe they show that the price of 33
kbytes is worth the improvement, or they will motivate someone
experienced in kernel benchmarks to benchmark the patch in a more
scientific way.

Thanks,
Uros.

--000000000000793a5b062f62460c
Content-Type: application/x-bzip2; name="results.tar.bz2"
Content-Disposition: attachment; filename="results.tar.bz2"
Content-Transfer-Encoding: base64
Content-ID: <f_m7s4214d0>
X-Attachment-Id: f_m7s4214d0

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
--000000000000793a5b062f62460c--

