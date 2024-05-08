Return-Path: <linux-kernel+bounces-172590-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AFACB8BF40E
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 03:25:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E40BCB21305
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 01:25:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F419A8F68;
	Wed,  8 May 2024 01:25:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="N27i5ZAW"
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 747D08BE7
	for <linux-kernel@vger.kernel.org>; Wed,  8 May 2024 01:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715131500; cv=none; b=o9WulNp0QjLA/T2xul0aUP/aszkq/SxOm09LqJiliiMedpWlEpr+6PAMOgdRw+bn6mjcCD7YIGZln8z1zu50tHqovlmmUWcDqWd06vTjanC6xZIhvGzroyRzDopZ3T3BKTFCIRmyZaeNpoVMbnoPWvSOJKil93kPzVOxH+Eh2Y0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715131500; c=relaxed/simple;
	bh=zeogVsJrho8qDV1JQGMwDiQiX7yUyyHMWiodEJaTABI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dScO7IC6K+GHC9oikuZ7FvpNE0875lasLz3Cl3FY9a4VT+GgxJ+Q9wo8Zs1xZCu8wQTwCWlPBiXfTwLWuJeCvFLb7ogtnNiAtQNV7E6W58+ucLCfc7GXL9mS59IjMuc2xEtihtuTCGlRZHUqbYoVQvNgljQpeqohN0HIV/XLsiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=N27i5ZAW; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-6f4178aec15so3270676b3a.0
        for <linux-kernel@vger.kernel.org>; Tue, 07 May 2024 18:24:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1715131498; x=1715736298; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=IhsVJPabx4zntlcqdXyDkSXBtwoq5OQdKJovK8JOcUw=;
        b=N27i5ZAWAUnaRbIteZPPe5oWq3XRknM1V5IwqIqelb0aWTNHxVwqzZsPae2K3Qg43H
         tSgZJk3ABYKYFXvOyn+v5MXpGLKSPySeA4xqgIKKk3ah70HwyMc5syabl5mbc4q23/ZM
         ArtjK0mZ8jYL6xiN0TQrTRthxCC4+6ehDSnaV94w+rhxCZ0Pr1OHs4tDjENh1uErz51v
         dVa4qajfGhrRemZwUp7hD3IMzPwzJCjGKKSjKS9Dk10V7iZrzkg/u1pmpTsqQQakbxx1
         LwpfDBPx/1IB4HgJvuaocerxOOSQL2WinDjT0tpW6wlhBTQZMUqapnmkfCd5jcKJ5F23
         2ZQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715131498; x=1715736298;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IhsVJPabx4zntlcqdXyDkSXBtwoq5OQdKJovK8JOcUw=;
        b=qrnIirikQxfklAMFQSRGre89LDC1aMqDEU4xEkfUqbtCX/D41mJrGUiLgJw598+lZp
         deDl/gmsKDst+ybjlPw0FoPbzt9SXK1R9zgHR8NstnDyBetdhcdvEUoTjCFwTIwX9Cgz
         z3zDTUapFSn2DxA8+B90px2wtPXoV6CphcpA+fvFSLkDVIbzT/qqkBFCzFYrqztEvflY
         8ZdrYsIBOEZO/65qq3vJW3xgYSFWEnHh1nZiiAoiwJHppF4Vu6M6Fh3thOZ8NRGV5Yvf
         srI3JV+kkXcUnYqnODhgAnieKdv4Th/4pBrORfuUAgI9IezBW/AhtI+poRYBbWYhpy6r
         dUIQ==
X-Forwarded-Encrypted: i=1; AJvYcCXum1ng1Ig+GjbWDbq4QUMEXf1wQbfXwrvTulKG7x9BJup4kpVTZ7Vbp3pB62MzzzOKZX8qJBDgG7jM1jgaL2djH+BmdLwjXcprzA35
X-Gm-Message-State: AOJu0Yz5DQ9Ya8VEe+GJFIQ6TK/nDE6i8sme/qR4lgZEpMKqc+c/3MPc
	muOxbHhJw/xh8T9daOPMbFbOfG3tbkd3Cyrf/eLjjeBbsMnGU/4nlPhK/n7kBXstr2oNuNJa7dG
	Z
X-Google-Smtp-Source: AGHT+IGxrKToRQGeaQOwoFRE1tTJUZMCY6maIjnf3I2s/xOfXSlGbLBrlOsT6whlD51sZanOujXO3g==
X-Received: by 2002:a05:6a20:7f9d:b0:1ad:7e4d:2ea6 with SMTP id adf61e73a8af0-1afc8d39d69mr1707444637.20.1715131497690;
        Tue, 07 May 2024 18:24:57 -0700 (PDT)
Received: from ghost ([2601:647:5700:6860:cc75:5174:3d13:7280])
        by smtp.gmail.com with ESMTPSA id y9-20020a17090a1f4900b002b15a672805sm191510pjy.23.2024.05.07.18.24.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 May 2024 18:24:57 -0700 (PDT)
Date: Tue, 7 May 2024 18:24:55 -0700
From: Charlie Jenkins <charlie@rivosinc.com>
To: Jessica Clarke <jrtc27@jrtc27.com>
Cc: Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Conor Dooley <conor.dooley@microchip.com>,
	Song Liu <song@kernel.org>, Xi Wang <xi.wang@gmail.com>,
	=?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@rivosinc.com>,
	=?iso-8859-1?Q?Cl=E9ment_L=E9ger?= <cleger@rivosinc.com>,
	linux-riscv <linux-riscv@lists.infradead.org>,
	LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 4/8] riscv: Add PLATFORM_MAY_SUPPORT_RISCV_ISA_SVPBMT
 Kconfig option
Message-ID: <ZjrUZ9y45zL7yqex@ghost>
References: <20240506-compile_kernel_with_extensions-v1-0-5c25c134c097@rivosinc.com>
 <20240506-compile_kernel_with_extensions-v1-4-5c25c134c097@rivosinc.com>
 <11F5B269-05DD-448E-9F85-878E84A5654F@jrtc27.com>
 <ZjqRcsheypWX14yy@ghost>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZjqRcsheypWX14yy@ghost>

On Tue, May 07, 2024 at 01:39:14PM -0700, Charlie Jenkins wrote:
> On Tue, May 07, 2024 at 06:40:52AM +0100, Jessica Clarke wrote:
> > On 7 May 2024, at 02:40, Charlie Jenkins <charlie@rivosinc.com> wrote:
> > > 
> > > Svpbmt would not benefit from having PLATFORM_SUPPORTS_RISCV_ISA_SVPBMT
> > > so just rename RISCV_ISA_SVPBMT to PLATFORM_MAY_SUPPORT_RISCV_ISA_SVPBMT
> > > and move the definition to Kconfig.isa.
> > > 
> > > Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
> > > ---
> > > arch/riscv/Kconfig     | 17 -----------------
> > > arch/riscv/Kconfig.isa | 17 +++++++++++++++++
> > > 2 files changed, 17 insertions(+), 17 deletions(-)
> > > 
> > > diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> > > index 9c3a4347953b..22303a3ab59e 100644
> > > --- a/arch/riscv/Kconfig
> > > +++ b/arch/riscv/Kconfig
> > > @@ -484,23 +484,6 @@ config RISCV_ALTERNATIVE_EARLY
> > > help
> > >  Allows early patching of the kernel for special errata
> > > 
> > > -config RISCV_ISA_SVPBMT
> > > - bool "Svpbmt extension support for supervisor mode page-based memory types"
> > > - depends on 64BIT && MMU
> > > - depends on RISCV_ALTERNATIVE
> > > - default y
> > > - help
> > > -   Add support for the Svpbmt ISA-extension (Supervisor-mode:
> > > -   page-based memory types) in the kernel when it is detected at boot.
> > > -
> > > -   The memory type for a page contains a combination of attributes
> > > -   that indicate the cacheability, idempotency, and ordering
> > > -   properties for access to that page.
> > > -
> > > -   The Svpbmt extension is only available on 64-bit cpus.
> > > -
> > > -   If you don't know what to do here, say Y.
> > > -
> > > config TOOLCHAIN_HAS_ZBB
> > > bool
> > > default y
> > > diff --git a/arch/riscv/Kconfig.isa b/arch/riscv/Kconfig.isa
> > > index 37585bcd763e..50e217dc5719 100644
> > > --- a/arch/riscv/Kconfig.isa
> > > +++ b/arch/riscv/Kconfig.isa
> > > @@ -168,3 +168,20 @@ config PLATFORM_SUPPORTS_RISCV_ISA_SVNAPOT
> > >  not support Svnapot.
> > > 
> > > endchoice
> > > +
> > > +config RISCV_ISA_SVPBMT
> > 
> > Hi Charlie,
> > Despite the subject and body you haven’t renamed it in this patch?
> 
> I didn't do a good job at explaining exactly what's happening here. The
> config option "PLATFORM_MAY_SUPPORT_RISCV_ISA_SVPBMT" most closely
> follows the semantics of what "RISCV_ISA_SVPBMT" previously was. This
> patch changes "RISCV_ISA_SVPBMT" to mean that either
> PLATFORM_MAY_SUPPORT_RISCV_ISA_SVPBMT or
> PLATFORM_SUPPORTS_RISCV_ISA_SVNAPOT was selected.

Disregard what I said... I was thinking about the other extensions and
forgot this one was different. Thank you for pointing this out! I need
to change this description to just say that the definition moved to
Kconfig.isa.

- Charlie

> 
> - Charlie
> 
> > 
> > Jess
> > 
> > > + bool "Svpbmt extension support for supervisor mode page-based memory types"
> > > + depends on 64BIT && MMU
> > > + depends on RISCV_ALTERNATIVE
> > > + default y
> > > + help
> > > +   Add support for the Svpbmt ISA-extension (Supervisor-mode:
> > > +   page-based memory types) in the kernel when it is detected at boot.
> > > +
> > > +   The memory type for a page contains a combination of attributes
> > > +   that indicate the cacheability, idempotency, and ordering
> > > +   properties for access to that page.
> > > +
> > > +   The Svpbmt extension is only available on 64-bit cpus.
> > > +
> > > +   If you don't know what to do here, say Y.
> > > 
> > > -- 
> > > 2.44.0
> > > 
> > > 
> > > _______________________________________________
> > > linux-riscv mailing list
> > > linux-riscv@lists.infradead.org
> > > http://lists.infradead.org/mailman/listinfo/linux-riscv
> > 

