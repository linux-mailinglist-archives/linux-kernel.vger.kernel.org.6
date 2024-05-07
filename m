Return-Path: <linux-kernel+bounces-172155-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2373E8BEE33
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 22:39:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8E9C11F26CAB
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 20:39:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37C3D1DFC7;
	Tue,  7 May 2024 20:39:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="XeS3GgW5"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7D4218733D
	for <linux-kernel@vger.kernel.org>; Tue,  7 May 2024 20:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715114359; cv=none; b=SNeb6vH6emCWH9XETfZ81VpzjYZJmgLeToobeSY5IHOKZN3G+eXQV3Ci2DKr76nd6hf7TAPyd9JKSSAgSDKp34R6s9I5zRLuAt6+tZuid6DG0/sEwQOVEyBg3WesolZUTKAfQP0dS2wkaClspZscKO9Nu9X3XmQPJfTth17v4u0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715114359; c=relaxed/simple;
	bh=383F+B/So0zUEEzqfWAsEPnMck3050d94Nvbj674P58=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BIBPF33+lZwZAHlH15nuXCGl5q9fP/YCMDMGT+wZ4Pfaj/BqCR3vuWwK+52yts84cv3PefYOcCXEq8nferz/9lKiabCBsfut6yM4IVHi6OlmXriW1zJWDcgRPSPk890VdZELqGWCtG9lELG8823gE7Tw77R4QY+ELZrDiHK/I4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=XeS3GgW5; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1ee38966529so1130065ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 07 May 2024 13:39:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1715114357; x=1715719157; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=VhSbRGfOoucduAp+aZ4PaB9wtbK5SWAr+iQfIgYf3GI=;
        b=XeS3GgW55IFh0agZBbst0RmoEdS0aMXZ3Pzbkfn+ZI3+sZsNcN0NYoeI15K+ppJNTY
         BRp8ieU/BE2bNy6S58NfXBOhh9J/hBvNZF6XxBJnlkRHGG6W/JMCNevULZoiOUNuv216
         6soCeojcwhM+ginWoOmJZeHZcklKwwJ/52XKGqAcSnbZm20LooSuX08Ji+xse/wh9ff3
         2Vczo5ctU3OGH0H49ukdHYVAzmd0tpxTS4aU2wSVXEjG+ejmBPEHYhqH4r2mBZNjDsnk
         GSViuF8e3/Odd7LLN5cGPqg4oJRyUruSjw64MsTteu532Yqdf2fbrYI18Wzq9Tw3roi1
         L2ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715114357; x=1715719157;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VhSbRGfOoucduAp+aZ4PaB9wtbK5SWAr+iQfIgYf3GI=;
        b=G0IRkUGSMCs0wH/Gyscg6CWQtrmnqTHD/Zm58510ohxxYOh1M4qObQw0N0hfPydQYi
         N+7zIWm6iGmj49qN15If4eujXnwnpTCiGopvZ42NFsTc3rmtHvpZ1UhcEWr2zOrOeF4w
         Uu3ROhnh6GkKjZ2JLgfIgRULk9cMJaAqv0AJK7eo22DZP1r+t4q8P9LriVAQxwZKp0lm
         cWjaxQkFfrtwTrEwx4Zi5WwsF+f4k2D5KScYqmNym6An4jDQ6LarO15e2d/X9ZY9VaHe
         WfG2+IOaa9K/MWYXgXapz18cyTxCCUPRS4VJnJ5SzJB7ADHaovhS5o33zyv3AYqjcN4M
         EToQ==
X-Forwarded-Encrypted: i=1; AJvYcCX2BC3hDFU44ZQWEqFKphjTydmiZR/QqhATIW61aZcWvglCs8gDRdYrFlEdR15SKHCPDgCqeRiFHQujHl7lc4jw0neNF5tFfCC/7X4U
X-Gm-Message-State: AOJu0YzWs2Sehty1a0NCFhwJCJ1Kbq7J7QGLBR7DpxOPot6idmVnnG2Z
	B1pCfiGJ3IQ37ttQ9nDPoihceqmkmxc894jM/7DQfhGQWLUsFaYaW8ZtJmcmR3k=
X-Google-Smtp-Source: AGHT+IFaHdYG2nvp7SaQ4FsUul9QNBAlcLxFzSiFnUIkb2lOpFzVgTdqsoLSQiA01QLQ4FwSV8633A==
X-Received: by 2002:a17:902:e885:b0:1eb:101d:bf53 with SMTP id d9443c01a7336-1ee62f6693dmr56811175ad.1.1715114357069;
        Tue, 07 May 2024 13:39:17 -0700 (PDT)
Received: from ghost ([2601:647:5700:6860:9de1:32f1:3d81:10c7])
        by smtp.gmail.com with ESMTPSA id jb20-20020a170903259400b001dd88a5dc47sm10448619plb.290.2024.05.07.13.39.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 May 2024 13:39:16 -0700 (PDT)
Date: Tue, 7 May 2024 13:39:14 -0700
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
Message-ID: <ZjqRcsheypWX14yy@ghost>
References: <20240506-compile_kernel_with_extensions-v1-0-5c25c134c097@rivosinc.com>
 <20240506-compile_kernel_with_extensions-v1-4-5c25c134c097@rivosinc.com>
 <11F5B269-05DD-448E-9F85-878E84A5654F@jrtc27.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <11F5B269-05DD-448E-9F85-878E84A5654F@jrtc27.com>

On Tue, May 07, 2024 at 06:40:52AM +0100, Jessica Clarke wrote:
> On 7 May 2024, at 02:40, Charlie Jenkins <charlie@rivosinc.com> wrote:
> > 
> > Svpbmt would not benefit from having PLATFORM_SUPPORTS_RISCV_ISA_SVPBMT
> > so just rename RISCV_ISA_SVPBMT to PLATFORM_MAY_SUPPORT_RISCV_ISA_SVPBMT
> > and move the definition to Kconfig.isa.
> > 
> > Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
> > ---
> > arch/riscv/Kconfig     | 17 -----------------
> > arch/riscv/Kconfig.isa | 17 +++++++++++++++++
> > 2 files changed, 17 insertions(+), 17 deletions(-)
> > 
> > diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> > index 9c3a4347953b..22303a3ab59e 100644
> > --- a/arch/riscv/Kconfig
> > +++ b/arch/riscv/Kconfig
> > @@ -484,23 +484,6 @@ config RISCV_ALTERNATIVE_EARLY
> > help
> >  Allows early patching of the kernel for special errata
> > 
> > -config RISCV_ISA_SVPBMT
> > - bool "Svpbmt extension support for supervisor mode page-based memory types"
> > - depends on 64BIT && MMU
> > - depends on RISCV_ALTERNATIVE
> > - default y
> > - help
> > -   Add support for the Svpbmt ISA-extension (Supervisor-mode:
> > -   page-based memory types) in the kernel when it is detected at boot.
> > -
> > -   The memory type for a page contains a combination of attributes
> > -   that indicate the cacheability, idempotency, and ordering
> > -   properties for access to that page.
> > -
> > -   The Svpbmt extension is only available on 64-bit cpus.
> > -
> > -   If you don't know what to do here, say Y.
> > -
> > config TOOLCHAIN_HAS_ZBB
> > bool
> > default y
> > diff --git a/arch/riscv/Kconfig.isa b/arch/riscv/Kconfig.isa
> > index 37585bcd763e..50e217dc5719 100644
> > --- a/arch/riscv/Kconfig.isa
> > +++ b/arch/riscv/Kconfig.isa
> > @@ -168,3 +168,20 @@ config PLATFORM_SUPPORTS_RISCV_ISA_SVNAPOT
> >  not support Svnapot.
> > 
> > endchoice
> > +
> > +config RISCV_ISA_SVPBMT
> 
> Hi Charlie,
> Despite the subject and body you haven’t renamed it in this patch?

I didn't do a good job at explaining exactly what's happening here. The
config option "PLATFORM_MAY_SUPPORT_RISCV_ISA_SVPBMT" most closely
follows the semantics of what "RISCV_ISA_SVPBMT" previously was. This
patch changes "RISCV_ISA_SVPBMT" to mean that either
PLATFORM_MAY_SUPPORT_RISCV_ISA_SVPBMT or
PLATFORM_SUPPORTS_RISCV_ISA_SVNAPOT was selected.

- Charlie

> 
> Jess
> 
> > + bool "Svpbmt extension support for supervisor mode page-based memory types"
> > + depends on 64BIT && MMU
> > + depends on RISCV_ALTERNATIVE
> > + default y
> > + help
> > +   Add support for the Svpbmt ISA-extension (Supervisor-mode:
> > +   page-based memory types) in the kernel when it is detected at boot.
> > +
> > +   The memory type for a page contains a combination of attributes
> > +   that indicate the cacheability, idempotency, and ordering
> > +   properties for access to that page.
> > +
> > +   The Svpbmt extension is only available on 64-bit cpus.
> > +
> > +   If you don't know what to do here, say Y.
> > 
> > -- 
> > 2.44.0
> > 
> > 
> > _______________________________________________
> > linux-riscv mailing list
> > linux-riscv@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-riscv
> 

