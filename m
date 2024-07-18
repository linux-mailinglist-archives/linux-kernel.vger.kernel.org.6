Return-Path: <linux-kernel+bounces-256572-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D73093506A
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 18:06:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 450EE2826EE
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 16:06:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB2E9144D1F;
	Thu, 18 Jul 2024 16:06:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="WHfyZFP6"
Received: from mail-io1-f50.google.com (mail-io1-f50.google.com [209.85.166.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5D4D140395
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2024 16:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721318772; cv=none; b=ozvXkNUGvmLuSiibGa4GV8Doe9YIIdkdolGIFqIEnRm3+FILrFwTt4ZWLGPVkduP2yU6ezgI2w/Zrf2v83EstQ0cOvn1WMJw6WDGvHqVMLn03h0vyDMC1zXSxF0nMNUCvYF9kI5ogGOZS4CySEHezlG4j3cNOwnYs9A6qO00GlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721318772; c=relaxed/simple;
	bh=44n4cYZ0Q1E+j8qZTmA1s4xcBXqhsiYahsmpu+O2AOo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ngWwzHziTIpqRCDrx/MniZFRxnzOIyX7qi2XUxcknZno4fnnWBJnBLCdIut0y8vsBev6rmL78AbPXE7I7W1nv6IBHbpPWJSLuiPdHc8yLmcQPL8Po1bwXXjN4nb8jbOFOOGhemlqVFlTRAYNA+Z5YlbwkYDC+ONp1Ac8NTOmt8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=WHfyZFP6; arc=none smtp.client-ip=209.85.166.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-io1-f50.google.com with SMTP id ca18e2360f4ac-808a8c90f5bso30099639f.2
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2024 09:06:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1721318770; x=1721923570; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=viUABkBmfTgkqCa/7vhlbq4p5oq9ftTQ0S5SnBOY0Nk=;
        b=WHfyZFP64SaNudMQ4iTCht83En/c9xFwE7WseUsES7dHvk+J1Eo8zrp5kPDICxbTKJ
         tL1CxdMO2l0GUb56AdvTGTisCyo7qoWYz/wFoH38kpm8ecuQI2dRIjuGDG9RtpTl8Sdr
         46SSbr1/5JbmLSzP4bXUhjwYxrLbVh3CXGbi2VvApTUBLb9ICyaEesHmHV1E7WpFRJVB
         3KplswpqsksQoO/4gFDBTiyFMPyRZTIZn3XbfNF2rLYbvR75kgpBSVfq8Hjov0ompmS2
         kvknIrFw1Idx710SVRlUSLU/2jmnqTfo/6+f6bNN44C0y15k9mkLy72q2X02BvGKu8t4
         e1Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721318770; x=1721923570;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=viUABkBmfTgkqCa/7vhlbq4p5oq9ftTQ0S5SnBOY0Nk=;
        b=cFfQpFnjm5RNdGJklI+EivGJ1ySIJh/A7PV1/20DJxQlrU/+rVqdnHFcZJdD8F4kvD
         S2kYi/rW35aEJSauuuA6kFVh/ee7dXfy+yL3rsTisfDCe/ypvwTABaZoZ7Vkw24E0rFp
         1s+CuMt1EATO+mJl5XJ2EL0aa5+tsnlJHESUkX/wbfV9GPjyoh1Km4NY5urPcAU6DVTC
         N1ovxZxHj4rM4graSqpDNDsw2uBvHm+D/DAHZhTGxy340aN49GgCscc4Ndx34iaJZPNQ
         bvKqB8/juCUg2QVChXfB3FH1yYGjrhK5SbbkVjihqVld91sU7LDw7kKbuuyxIjuoHxbD
         ceng==
X-Forwarded-Encrypted: i=1; AJvYcCUp7V+GmpBVritSfSfyQIKj6MjucfI6HWUBdsWx/kcrpOUaOWfsrB/jfVC/OdgvPggqpbCVT0my7ZZ0qK5+Ihy5cYR/SKGZyPwMEPw3
X-Gm-Message-State: AOJu0YyNPEGBOJrcJZWwnYAES6qiryq67TEzClzTWFDyJKIcFS/GNx8U
	icqxLJMd6z8fjclkRPmY9mzFRDOqlX2I68HOksaO/0+ZBI1yqUYkr2hn/iyJh7A=
X-Google-Smtp-Source: AGHT+IFm1MwbtKKQ42pdLPFRWB3QURVJC7xbjJO/hmp2xPNIG+w6wDszyBZqmIMxtUybkHCFqiqGvQ==
X-Received: by 2002:a05:6e02:1e0e:b0:376:4049:69d2 with SMTP id e9e14a558f8ab-3955542a2f1mr76353275ab.6.1721318769739;
        Thu, 18 Jul 2024 09:06:09 -0700 (PDT)
Received: from localhost ([140.82.166.162])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3950b6ad778sm17393005ab.40.2024.07.18.09.06.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jul 2024 09:06:08 -0700 (PDT)
Date: Thu, 18 Jul 2024 11:06:06 -0500
From: Andrew Jones <ajones@ventanamicro.com>
To: Alexandre Ghiti <alex@ghiti.fr>
Cc: Alexandre Ghiti <alexghiti@rivosinc.com>, 
	Jonathan Corbet <corbet@lwn.net>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Conor Dooley <conor@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Andrea Parri <parri.andrea@gmail.com>, 
	Nathan Chancellor <nathan@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>, Waiman Long <longman@redhat.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Arnd Bergmann <arnd@arndb.de>, 
	Leonardo Bras <leobras@redhat.com>, Guo Ren <guoren@kernel.org>, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, linux-arch@vger.kernel.org
Subject: Re: [PATCH v3 03/11] riscv: Implement cmpxchg8/16() using Zabha
Message-ID: <20240718-d583846f09bc103b7eab6b4e@orel>
References: <20240717061957.140712-1-alexghiti@rivosinc.com>
 <20240717061957.140712-4-alexghiti@rivosinc.com>
 <20240717-e7104dac172d9f2cbc25d9c6@orel>
 <fb03939b-502b-410a-85f5-2785b2bd0676@ghiti.fr>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fb03939b-502b-410a-85f5-2785b2bd0676@ghiti.fr>

On Thu, Jul 18, 2024 at 02:50:28PM GMT, Alexandre Ghiti wrote:
...
> > > +									\
> > > +		__asm__ __volatile__ (					\
> > > +			prepend						\
> > > +			"	amocas" cas_sfx " %0, %z2, %1\n"	\
> > > +			append						\
> > > +			: "+&r" (r), "+A" (*(p))			\
> > > +			: "rJ" (n)					\
> > > +			: "memory");					\
> > > +		goto end;						\
> > > +	}								\
> > > +									\
> > > +no_zabha_zacas:;							\
> > unnecessary ;
> 
> 
> Actually it is, it fixes a warning encountered on llvm:
> https://lore.kernel.org/linux-riscv/20240528193110.GA2196855@thelio-3990X/

I'm not complaining about the 'end:' label. That one we need ';' because
there's no following statement and labels must be followed by a statement.
But no_zabha_zacas always has following statements.

Thanks,
drew

