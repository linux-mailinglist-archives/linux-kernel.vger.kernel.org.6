Return-Path: <linux-kernel+bounces-532131-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D4D0A4490B
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 18:55:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6B72416E7E6
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 17:53:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC726199FB0;
	Tue, 25 Feb 2025 17:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="Q7YzJwdx"
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ECDD19ADA2
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 17:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740506014; cv=none; b=cezFy3VBj0YUJM7HOmUwyKKXR3uSn2CsiOwZt0AHJMGiUQmWfij3AusFsA3mmdkcXhf0XdPksdNh7iStmroDgl8o4zmngzF7gD+kN4wPYOyWPirvUcb5qIBcqCvgu+kXoT03LiietNZkui25V9bt3B4HZdVKj3PLIZeFnFzSRjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740506014; c=relaxed/simple;
	bh=MH07qjLZ92AfV112Knvo2zI/QK4I2MXbywwIDal1d54=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MukCRhHxyanvmnYHLIw1ZjtBUlkhqKADWuUGsUv9mVSWqvfRHX2473FFv2IiKqw5WWq7yXLIfBZaGc2rVcD06hgY3TGQRCvjCt5PCW7w976wyvwVQpODaWh8n3a/JaYddH5phu49z9eiVL4lQHrbVjVxz1gltp9FSzCeo2rlH6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=Q7YzJwdx; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-2fcce9bb0ecso11507765a91.3
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 09:53:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1740506011; x=1741110811; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=M8ytOcimcOajPMmPbmHJ20XRT2ET7W0PdZC0CAWsNrs=;
        b=Q7YzJwdxpNNGG7rEOi38zlyjQJp7g2wUDGdhHQweNiu8FbOyuXI4yqmlQOyIJDzp9l
         26b4of9HRlLUkYF0tIY6BwM6rVOMjL0bYakUDSmsic5xKO4aZn75GbB8nqJv46FCFkJv
         O7YgbRdYXfqd8JnHi9WhFfaNaXZ05Jm/Xi6H9ZAWMfpSbe5oeX43p+FDwHVqrZfLBvk1
         Q0/fuN7MKXEcAo2Y16bEE3aVKAnNNxuomOLXyzz1Y2ifcdqkgO+5W49AZ61CSp98US4U
         3FyGxgA0s5eIz4/EaYGFYJwpIUGC3BTNTQ3nMTP6kwmrxHSxnRrCy9Bdp5XnpyrcDDqk
         wDBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740506011; x=1741110811;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M8ytOcimcOajPMmPbmHJ20XRT2ET7W0PdZC0CAWsNrs=;
        b=XNEyhcen40uNzJYUGgn2RUC9hriAx3Yg1STLSX30OidV+ZHE+Xq7P7XV2yiEjQKIaA
         86JftSnC3XsmmFcyriobTEN4lF3XXNkOEkjsuqQDABAxqOAu3dp1+Nu0n3LkgW0/nz59
         k1r2+pgVde8pEsq1+T3H201S6IfHlJkJjwRtJLVFQvrSHSjYF+NJDPR/JObzj4PxGnNr
         /dUjg9uqchmSltivqSRTR+duVe4pe1ejti1qprwl41fqfffShlGqATA1u1vF8zJbB1y4
         oo/BS/ShUhNBZ4cy5UedyoD5T8m8rfCszfDwluCeD9l6ULuJeiZjfERehssOpGXd6Qah
         Vdpw==
X-Forwarded-Encrypted: i=1; AJvYcCUb6tC9Ux4d2wr6llfXWoE9ECi3P7TyvXCyRTUKjBwp7NfxhRu71WRgsE6GVHMUNOgwr3b39OGwFYXjJOQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxfZzJnCax2HhM+ERII2J9oekLvkDlfcHSNOHlLkxVBVEc6/mYE
	JaEVvqtwOg/GnBtiW6AkegRSe+xHdy5NtTpT+GA7oI+V/XLzooGexlIGU4juVoU=
X-Gm-Gg: ASbGncsrEZo29bsTjB4ZICSoaXhOnP2vXXftcmQkUwJBh35UXIZALnBVKA4WO/GsxkS
	y/+QMpu7kGaH+okBnzzzRiiQ8FBy0+iohNmqTG6NHGvl8X3ko7ZuUn3+P2IBluWPeKyr/32AUrN
	QJgLeHnfETgjUeARwAMPHSr5wpDcTZ0fK368HPHZeztXBBeTR7x+obfSrwXce14grPo8XBm52RW
	rDowsYL6OUix5gviQJVB2mogpLokVTMbEwkRbnwsTOruPP1UIFE+Vz6NSzcVQ0ATBioK3DIYuYG
	N1jA98dMOhjQ+7yM
X-Google-Smtp-Source: AGHT+IGE1vlRW/ZqwQ5Dzm1smcnQLurLLpTK4sP2+b5ghrhOvAR+GUgf0qQALw30DxM3WGJrzHgVQQ==
X-Received: by 2002:a17:90b:54c7:b0:2f5:63a:44f9 with SMTP id 98e67ed59e1d1-2fe68d065e9mr5651684a91.23.1740506011483;
        Tue, 25 Feb 2025 09:53:31 -0800 (PST)
Received: from ghost ([50.145.13.30])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2fceb10fb43sm8709371a91.35.2025.02.25.09.53.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2025 09:53:30 -0800 (PST)
Date: Tue, 25 Feb 2025 09:53:27 -0800
From: Charlie Jenkins <charlie@rivosinc.com>
To: Alexandre Ghiti <alex@ghiti.fr>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Oleg Nesterov <oleg@redhat.com>,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org
Subject: Re: [PATCH] riscv: tracing: Fix __write_overflow_field in
 ftrace_partial_regs()
Message-ID: <Z74DlyiSS75MrkqS@ghost>
References: <20250224-fix_ftrace_partial_regs-v1-1-54b906417e86@rivosinc.com>
 <b449aacb-f981-4907-af37-1ca5aea83bb4@ghiti.fr>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b449aacb-f981-4907-af37-1ca5aea83bb4@ghiti.fr>

On Tue, Feb 25, 2025 at 09:36:04AM +0100, Alexandre Ghiti wrote:
> Hi Charlie,
> 
> On 25/02/2025 03:42, Charlie Jenkins wrote:
> > The size of &regs->a0 is unknown, causing the error:
> > 
> > ../include/linux/fortify-string.h:571:25: warning: call to
> > '__write_overflow_field' declared with attribute warning: detected write
> > beyond size of field (1st parameter); maybe use struct_group()?
> > [-Wattribute-warning]
> 
> 
> I can't reproduce this warning with gcc and llvm, even when setting by hand
> -Wattribute-warning when compiling bpf_trace.c (which is the user of
> ftrace_partial_regs()).
> 
> Which toolchain did you use?

You need to have the configs:
CONFIG_BPF_SYSCALL=y
CONFIG_FORTIFY_SOURCE=y
CONFIG_FUNCTION_TRACER=y
CONFIG_FPROBE=y
CONFIG_DYNAMIC_FTRACE=y

I used gcc 14.2.0

- Charlie

> 
> Thanks,
> 
> Alex
> 
> 
> > 
> > Fix this by wrapping the required registers in pt_regs with
> > struct_group() and reference the group when doing the offending
> > memcpy().
> > 
> > Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
> > ---
> >   arch/riscv/include/asm/ftrace.h |  2 +-
> >   arch/riscv/include/asm/ptrace.h | 18 ++++++++++--------
> >   2 files changed, 11 insertions(+), 9 deletions(-)
> > 
> > diff --git a/arch/riscv/include/asm/ftrace.h b/arch/riscv/include/asm/ftrace.h
> > index c4721ce44ca474654b37b3d51bc0a63d46bc1eff..ec6db1162021fbf4fa48fc87e7984266040aa7d9 100644
> > --- a/arch/riscv/include/asm/ftrace.h
> > +++ b/arch/riscv/include/asm/ftrace.h
> > @@ -207,7 +207,7 @@ ftrace_partial_regs(const struct ftrace_regs *fregs, struct pt_regs *regs)
> >   {
> >   	struct __arch_ftrace_regs *afregs = arch_ftrace_regs(fregs);
> > -	memcpy(&regs->a0, afregs->args, sizeof(afregs->args));
> > +	memcpy(&regs->a_regs, afregs->args, sizeof(afregs->args));
> >   	regs->epc = afregs->epc;
> >   	regs->ra = afregs->ra;
> >   	regs->sp = afregs->sp;
> > diff --git a/arch/riscv/include/asm/ptrace.h b/arch/riscv/include/asm/ptrace.h
> > index b5b0adcc85c18e15c156de11172a5d7f03ada037..2910231977cb71dac3cc42f2dc32590284204057 100644
> > --- a/arch/riscv/include/asm/ptrace.h
> > +++ b/arch/riscv/include/asm/ptrace.h
> > @@ -23,14 +23,16 @@ struct pt_regs {
> >   	unsigned long t2;
> >   	unsigned long s0;
> >   	unsigned long s1;
> > -	unsigned long a0;
> > -	unsigned long a1;
> > -	unsigned long a2;
> > -	unsigned long a3;
> > -	unsigned long a4;
> > -	unsigned long a5;
> > -	unsigned long a6;
> > -	unsigned long a7;
> > +	struct_group(a_regs,
> > +		unsigned long a0;
> > +		unsigned long a1;
> > +		unsigned long a2;
> > +		unsigned long a3;
> > +		unsigned long a4;
> > +		unsigned long a5;
> > +		unsigned long a6;
> > +		unsigned long a7;
> > +	);
> >   	unsigned long s2;
> >   	unsigned long s3;
> >   	unsigned long s4;
> > 
> > ---
> > base-commit: d082ecbc71e9e0bf49883ee4afd435a77a5101b6
> > change-id: 20250224-fix_ftrace_partial_regs-eddaf4a7e5ed

