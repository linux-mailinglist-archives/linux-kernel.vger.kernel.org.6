Return-Path: <linux-kernel+bounces-383717-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 19FC49B1F77
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Oct 2024 18:49:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CD777281084
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Oct 2024 17:49:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFC3716CD35;
	Sun, 27 Oct 2024 17:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="T1ufwHJC"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32A5915EFA1
	for <linux-kernel@vger.kernel.org>; Sun, 27 Oct 2024 17:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730051373; cv=none; b=WyCoWPhp6hm1HUxZG4FZf175LlT1R3OgMEQm4285uDEEM4WMvKH0T8wpr0sL67nfx4E2DKwJdjXo4hNkK6xWIlxeZzKJFB/UQ5a7cCXngQw493omascO81w0NOwNmwf1C18tHVEWvJX15aJcn1s3Oi9g7xzBcH6b6RF16iV99Qo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730051373; c=relaxed/simple;
	bh=ukgW3/cSOhgMOsJ6/qtTV4LpXANuPx6LanujyhVT0mE=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JreJTivaUky/2Zlsi4VzpjWpEc8MgG6pyjiJV8jzynzp4gOyWptKNVqbjQ/f55DOvsSj2pw+X1E/rxt4+bXhzpDTVojcPNromzVSkbeO0YzwaQPDBkDLsvkEaSa+6SkW/eAosZE311gxUR0+c7AodsAKH69xEzh/kYZotaYBmLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=T1ufwHJC; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730051370;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dGyedni/Q8cZq63gutTOp/jBzBAQP+LtDb0Ng1itTDU=;
	b=T1ufwHJCH+WkDUMpVZT3O4znRMp7Q4wNm4ziWOkhm3zWjPQk91I1rszv3he7GLtF6lKSRv
	Bb6UzCXni90riZ2w73HK/R6L2F6Rq5sQck3GwAVnykqyaIRRbCrV4Peqs5cPUAg5XzvMgE
	mI09IlNo6hyIAxQUa3c3KOq5nD/BALU=
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-164-cLEyriD7PVGUfjMIMJJ5Aw-1; Sun, 27 Oct 2024 13:49:28 -0400
X-MC-Unique: cLEyriD7PVGUfjMIMJJ5Aw-1
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-71e467c39a4so4040812b3a.3
        for <linux-kernel@vger.kernel.org>; Sun, 27 Oct 2024 10:49:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730051367; x=1730656167;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dGyedni/Q8cZq63gutTOp/jBzBAQP+LtDb0Ng1itTDU=;
        b=mqKUK0fphXhi/2XlKSLYKuA6IrMAr38wCFnVPVoWYpErZVarXah+3i1JDEnwvH9C5g
         /4h825JcM7pe0Xzk7/oU41mPEU+PcgVTJPcwXYwPM/YWTTlAwOtaPEXLcTM0N7PITCCN
         6vxzwtuJV51p6tEYppz6oCwdNKcu8nlpM2trLA20sPXCjkZny42d2xRMI3i+wA3Asph+
         5/ko0EdUTQThXlZ9yCudCvV/DfzYIOL2KpvOwqp5p/unNYEq0nYHJdOpXQjkPwwpdItf
         xcqC355mxN2FZDiCzwqSN99OmElnXijpXql3a3Pe3w+lvmiUsw2I+7EtYwC1YhW2cH3s
         Habg==
X-Forwarded-Encrypted: i=1; AJvYcCXph6gxPJSewu7HuQKxs7MrKOTLtOksZDF1VZBEUGXxpLgFnTEybWvqonJefitvXEbzRnoJQnbk/24Oeos=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3O2tMQ7tYH5jOKbJKytoxEd634zoGfOToc3OW877/7U1pdt4w
	XRzUA7J8asq2bqsbA/C0ZHYds/bb2a+HwPHh/eGGUlCvy4jv0aVn4xHe9hfG0cBGqu/1AfI9S8F
	fQEFPC2BHhemQk33zFCPr1Dg1JyEwSNAvJkAf7h1c5NZZ/IjfNpBQvr3nYYJMiA56czsxhw==
X-Received: by 2002:a05:6a20:2d27:b0:1d9:d0e:34a4 with SMTP id adf61e73a8af0-1d9a83a96a6mr9858973637.7.1730051367251;
        Sun, 27 Oct 2024 10:49:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHliNezDqPtcffB/0XVsiezr7eb7M3feYcKepm25uR+TB4U3H3PzOWlR5Q1tD1Eu1+kbBgifg==
X-Received: by 2002:a05:6a20:2d27:b0:1d9:d0e:34a4 with SMTP id adf61e73a8af0-1d9a83a96a6mr9858945637.7.1730051366906;
        Sun, 27 Oct 2024 10:49:26 -0700 (PDT)
Received: from treble.attlocal.net ([2600:1700:6e32:6c00::3e])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7edc8696a86sm4369893a12.47.2024.10.27.10.49.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Oct 2024 10:49:26 -0700 (PDT)
From: Josh Poimboeuf <jpoimboe@redhat.com>
X-Google-Original-From: Josh Poimboeuf <jpoimboe@kernel.org>
Date: Sun, 27 Oct 2024 10:49:22 -0700
To: Jens Remus <jremus@linux.ibm.com>
Cc: Peter Zijlstra <peterz@infradead.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ingo Molnar <mingo@kernel.org>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	linux-kernel@vger.kernel.org, Indu Bhagat <indu.bhagat@oracle.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	linux-perf-users@vger.kernel.org, Mark Brown <broonie@kernel.org>,
	linux-toolchains@vger.kernel.org, Jordan Rome <jordalgo@meta.com>,
	Sam James <sam@gentoo.org>, x86@kernel.org,
	Heiko Carstens <hca@linux.ibm.com>,
	Ilya Leoshkevich <iii@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>
Subject: Re: [PATCH v2 03/11] unwind: Introduce SFrame user space unwinding
Message-ID: <20241027174922.cdlkeidvciwlv5an@treble.attlocal.net>
References: <cover.1726268190.git.jpoimboe@kernel.org>
 <ca2e603ae3dcfa3e836162ed8c301fd4d9fd4058.1726268190.git.jpoimboe@kernel.org>
 <c967505c-fbdc-4a46-a5b6-d164fe79e2e3@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <c967505c-fbdc-4a46-a5b6-d164fe79e2e3@linux.ibm.com>

On Wed, Oct 23, 2024 at 03:59:53PM +0200, Jens Remus wrote:
> > +++ b/arch/Kconfig
> > @@ -428,6 +428,9 @@ config HAVE_HARDLOCKUP_DETECTOR_ARCH
> >   config HAVE_USER_UNWIND
> >   	bool
> > +config HAVE_USER_UNWIND_SFRAME
> > +	bool
> 
> I found this unwinder of userspace using SFrame to depend on your generic
> unwinder of userspace framework. Does this warrant to add:

Based on your other suggestion I now have:

config UNWIND_USER
	bool

config HAVE_UNWIND_USER_FP
	bool
	select UNWIND_USER

config HAVE_UNWIND_USER_SFRAME
	bool
	select UNWIND_USER

The arches set HAVE_*, which in turn sets UNWIND_USER.

> > +static int find_fre(struct sframe_section *sec, struct sframe_fde *fde,
> > +		    unsigned long ip, struct user_unwind_frame *frame)
> > +{
> > +	unsigned char fde_type = SFRAME_FUNC_FDE_TYPE(fde->info);
> > +	unsigned char fre_type = SFRAME_FUNC_FRE_TYPE(fde->info);
> > +	s32 fre_ip_off, cfa_off, ra_off, fp_off, ip_off;
> 
> Doesn't fre_ip_off need to be u32 (see also below)? The SFrame format
> specification states the FRE sfre_start_address is either u8, u16, or u32:
> https://sourceware.org/binutils/docs/sframe-spec.html#The-SFrame-FRE-Types

Indeed, I also noticed that.

> > +	SFRAME_GET_USER_UNSIGNED(cfa_off, f, offset_size);
> 
> As far as I know the CFA offset from CFA base register is signed in the
> SFrame file format. See Binutils include/sframe-api.h,
> sframe_fre_get_cfa_offset(). Therefore use SFRAME_GET_USER_SIGNED(). Both
> cfa_off and struct user_unwind_frame cfa_off are already defined as s32.

Good catch.  There's no need to have separate SIGNED/UNSIGNED variants
anyway, I'll simplify that into SFRAME_GET_USER().

> > +++ b/mm/init-mm.c
> > @@ -11,6 +11,7 @@
> >   #include <linux/atomic.h>
> >   #include <linux/user_namespace.h>
> >   #include <linux/iommu.h>
> > +#include <linux/sframe.h>
> >   #include <asm/mmu.h>
> >   #ifndef INIT_MM_CONTEXT
> > @@ -44,7 +45,8 @@ struct mm_struct init_mm = {
> >   #endif
> >   	.user_ns	= &init_user_ns,
> >   	.cpu_bitmap	= CPU_BITS_NONE,
> > -	INIT_MM_CONTEXT(init_mm)
> > +	INIT_MM_CONTEXT(init_mm),
> > +	INIT_MM_SFRAME,
> 
> This does not compile on s390, as INIT_MM_CONTEXT() is defined with a
> trailing comma, leading to two consecutive commas. Already reported by the
> kernel test robot for other architectures.
> Same if INIT_MM_SFRAME expands into nothing there would be two consecutive
> commas.

Yeah, I saw those build errors and I've got that fixed now.

Thanks for the review!

-- 
Josh


