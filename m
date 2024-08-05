Return-Path: <linux-kernel+bounces-275205-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E3E2C9481D2
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 20:39:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9E3352886CA
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 18:39:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9291163AA7;
	Mon,  5 Aug 2024 18:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="bXnClPrm"
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B26415A874
	for <linux-kernel@vger.kernel.org>; Mon,  5 Aug 2024 18:39:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722883143; cv=none; b=RFjx2+inMoTI6NfaY5JCJkCFgwLzWqyBdEpRfmoZ1k/EWjnjn6wi9zjZnsiUnyaC0752AwMnXTx5F50k26lyOm21mFOTlzaR9z6tZYgDgng6FmQ2i1Jd0fNfn4PHujjnMj4kPh/pvl0zG1/5D/RnZ1hoMZZ3TFlriVIeEVK5BDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722883143; c=relaxed/simple;
	bh=Z0fHi9KsdL/dhg3Iq7FZic1Ag2yGSv3KBsY4wPIKoXc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Hyvudz1qKQFWyjfsjSc3EerVbAcyuQJId8y4SVhvtS6xXiW+dz6BJjVFxnyP1+UDM6UIPFfTrkTfDRScGT4vB5LPEQr8TH6YfuVt2u3ifaUulDILyWkzsSlWdSUOofZUuhIh1p1XDsRUXhGeFrFAA9B3Jf20GdirCCDmMNCzfAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=bXnClPrm; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5a2a90243c9so12474249a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 05 Aug 2024 11:39:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1722883140; x=1723487940; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z0fHi9KsdL/dhg3Iq7FZic1Ag2yGSv3KBsY4wPIKoXc=;
        b=bXnClPrm5Vo+8wowLG5mnLFsfE0X3DO6Xn06uYQT4fsbQAlsGbcgfNO+q/WFPYEPZK
         WYwFbNRw/Q0nN/93zpi4xdFi6hZXeMrPVQjPYE6fuBMidBjdEmm5pVbEZhipf3OYSPNl
         FC5kIXBbzlvAtuAuOSUy/zC20f5EQ9e9Xa+oZVhBQ/2QtbbUwaLsFoAEqASeMUsj5Uz5
         u+enWYgzgPIuIilTZLeKpyHe88ejmPzIfI6s3Xvky8PNow5JcJ+G6MGQhtrHbNyEW2DA
         n+R0fTar9ML/DeqYabZgDbczjMqjcVY21PFgRXdmpO6UTZ4fHb8YVXbohC1xk5/gEb2I
         Gpyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722883140; x=1723487940;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z0fHi9KsdL/dhg3Iq7FZic1Ag2yGSv3KBsY4wPIKoXc=;
        b=gWZdVP66lxeFVz8Ii2+Qlicw3L9C2DZJtdoRgkGCMgreiem3+/5gGKf8faCE4zu80r
         KxU/CBuzGNYBtWPZJZGWy3I3muyjY82VKboXGLXWlrNw9I3fGsd2lwAsv99nJat/PRB9
         m6GTQbAlgUeO9FQke6xheOoamtUcLiOCKh316kOGfm7u3GGJtkm9piI6OkU9pTWI4R5k
         I3bmS76UpeMDN98MOWGjmFEkbRdEVt9EN20FkPa/RtkYcW3ii/X96HgFo+hsGfyZBK1B
         F0V4SGYilBhhHdKQdXIJVIfa+IPgOFnlQYqhcf4BreQa6B89N6iHzMBOXXb4LhsbOZDs
         sw7g==
X-Forwarded-Encrypted: i=1; AJvYcCVnaA9iAqka2wXz+jx8aJZhfQi4Gv+GWsFy72SvmP3gwrOR5BIEw649a9G5+K/t8E7vtEitco7QOifQyfYfT+nUY6YaMnF/hJqJ+Flu
X-Gm-Message-State: AOJu0Yx0Tk/O/Fv4q9WG4xCrO0Ay5y7P8riOgSlHwkrepB6ZWhHDZRLH
	0heGPGGDqXiUz4oYM8JoRZAcgPr9dEV1XQhAsdNF/U7zi67sy+tZcwGvUKAvMe1pd6ckFFa5+Gf
	MC9zMvba8SG/VNb5I+VmBSaPrOs/c9SGtiKjonw==
X-Google-Smtp-Source: AGHT+IHGDWiYA4gxxfNGX16WDAPwnIZq8VLG/7+YcSFFrHFbrxAB9lU1euM5kVqthhxJ26B5ZI3RZy5fWZ0Q/yhpQmQ=
X-Received: by 2002:a17:907:7204:b0:a7a:b070:92d1 with SMTP id
 a640c23a62f3a-a7dc517b48dmr937619966b.46.1722883139711; Mon, 05 Aug 2024
 11:38:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240805173816.3722002-1-jesse@rivosinc.com>
In-Reply-To: <20240805173816.3722002-1-jesse@rivosinc.com>
From: Evan Green <evan@rivosinc.com>
Date: Mon, 5 Aug 2024 11:38:23 -0700
Message-ID: <CALs-HstYwwgPAOP22V1A6iTX85eRqRp4b4039pewsDHus_dLgQ@mail.gmail.com>
Subject: Re: [PATCH 1/1] RISC-V: Add parameter to unaligned access speed
To: Jesse Taube <jesse@rivosinc.com>
Cc: linux-riscv@lists.infradead.org, Jonathan Corbet <corbet@lwn.net>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Conor Dooley <conor@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>, 
	Andrew Jones <ajones@ventanamicro.com>, Charlie Jenkins <charlie@rivosinc.com>, 
	Xiao Wang <xiao.w.wang@intel.com>, Andy Chiu <andy.chiu@sifive.com>, 
	Eric Biggers <ebiggers@google.com>, Greentime Hu <greentime.hu@sifive.com>, 
	=?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@rivosinc.com>, 
	Heiko Stuebner <heiko@sntech.de>, Costa Shulyupin <costa.shul@redhat.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Baoquan He <bhe@redhat.com>, 
	Anup Patel <apatel@ventanamicro.com>, Zong Li <zong.li@sifive.com>, 
	Sami Tolvanen <samitolvanen@google.com>, Ben Dooks <ben.dooks@codethink.co.uk>, 
	Alexandre Ghiti <alexghiti@rivosinc.com>, "Gustavo A. R. Silva" <gustavoars@kernel.org>, 
	Erick Archer <erick.archer@gmx.com>, Joel Granados <j.granados@samsung.com>, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 5, 2024 at 10:38=E2=80=AFAM Jesse Taube <jesse@rivosinc.com> wr=
ote:
>
> Add a kernel parameter to the unaligned access speed. This allows
> skiping of the speed tests for unaligned accesses, which often is very
> slow.
>
> Signed-off-by: Jesse Taube <jesse@rivosinc.com>

How come this is a command line parameter rather than a Kconfig
option? I could be wrong, so I'll lay out my rationale and people can
pick it apart if I've got a bad assumption.

I think of commandline parameters as (mostly) something end users
twiddle with, versus kconfig options as something system builders set
up. I'd largely expect end users not to notice two ticks at boot time.
I'd expect its system builders and fleet managers, who know their
hardware and build their kernels optimized for it, are the ones who
would want to shave off this time and go straight to the known answer.
Anecdotally, at ChromeOS we had a strong preference for Kconfig
options, as they were easier to compose and maintain than a loose pile
of commandline arguments.

The commit text doesn't go into the rationale, intended audience, or
expected usage, so maybe my guesses miss the mark on what you're
thinking.
-Evan

