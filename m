Return-Path: <linux-kernel+bounces-257365-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D9330937914
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 16:18:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 93EDDB22A66
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 14:18:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C9A2145B03;
	Fri, 19 Jul 2024 14:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hHsail1o"
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3570E1459F9
	for <linux-kernel@vger.kernel.org>; Fri, 19 Jul 2024 14:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721398667; cv=none; b=hpEuVOaDm/nvEr9b+MKKjiARD5akyR6uVOfoLppOUAEqDwEJgjTen0bX8St7sA5C4BPIRrVLRczZAIQj5hYMNrfGZ01f5nSEOze9Or9NiigZ0/vDXWKHKpxzRO6ps3dspmwUSe7CS+l+huN5vd0Yl0DZYPY3fx1Pe7xuwZfrv0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721398667; c=relaxed/simple;
	bh=Az+UsAqAJwkvCMdiQaGSuSpQNVXsDjznheL9GDF0c5s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Qba1gW9kAtoqWd0X+09HSczpqIMjH7WIoiU+Oy5LBKM6hPCKHR5ElVkf8u+oFtTauCVZgteR5W09PAMpNus6xM3j1NGYZKA2jZBGpQgJAzrFJ58dtBqkUacMxBW10PLHoZC9lsfBCjAtxAaKeRmgV+9jnCw3af0fK3/KwFvxDm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hHsail1o; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-70af4868d3dso715296b3a.3
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jul 2024 07:17:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721398665; x=1722003465; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rzIrXxd4OTzhQ6j9JNpbeNXo+mLOT8iXvmw4VxrmH2I=;
        b=hHsail1oy+ebfwkyqtUebnifKNjfodX/tMAA7uSEkkB4MCxSPWHcmtwMsV3Eyv1Dei
         RlsjKMth/Ht2+rCbcrJ3iRBNFodI954XjsD+BSO3gGVE9lIU6+thk5NmPERs7ck93D7T
         JkddxT9/msmdFDPzcDYXDWh7pgMuS/AVL3KYONV5oyrdEjbxq1OcAfNmRDKf5bhj5hK1
         v3cxDcq3YpRU48OqjT8nzdM/gKm9LNDK2QqJc5xiEKPzvlwCTbI8+kA2kJDyw2WJDspz
         O0MtEDYWfCCM4O1Vvls0TJyI0Yx/QUxbxpWU3X/Q0NiafZyv4BjUXW9HGFWvgE2jRcq5
         IZdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721398665; x=1722003465;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rzIrXxd4OTzhQ6j9JNpbeNXo+mLOT8iXvmw4VxrmH2I=;
        b=wB9EDHxr6/uezgUnVMYOHKKE2o22aEvVbc6eEsftIK13dh5SHujFOAFE5b1Mmb08d2
         Of/al4fvPmnIL47HezUBNuEiw4wngJk9KxhUclFmrj0y5D0ZGsD/G6ROBUw6u9fCL9nL
         Qfr2XZud7W+xV1R0B8yGf87gqdZdHXZKfr/n7wcpQGZcfbpUZ1TNqIDji7EzBEjMTM/N
         58e/faM8e+Ws0//3KlAXAswFS+oGFyX8YRmMstCFf0U1SodLRLu35P+OOPvseqWqmbOY
         YVDE45on8Vd14Nmk1uzDOUURt+p1srDPUcsnsp1rHzAyDB9pOYxTD88FF2VE1TokyGQS
         KEKw==
X-Forwarded-Encrypted: i=1; AJvYcCVZXsb8J2cM0KXlw0Jl38GjCA478SUkiP0lsY3YY5mdl4NV4OlCaM62o9tFFCjaP4/PJ43BbV9bv2+gXrzn7AHlHhsVVn7OiSDu7MNX
X-Gm-Message-State: AOJu0YzdGacQfy7rXlcx+5Tmu8+C2pwR/kZIZQBxOhgJN+TNsKDu4WWz
	JJOWSNHKXTXREzN1Jsd6iRQ6n1vVemhvuDSDHhpKRrMU49lduxuqRlKhQw==
X-Google-Smtp-Source: AGHT+IHeBT9xaOFtzeEq4GEAk6Ado/fBfBa7U2IRTbvu7dQgTaP64FDMcUnRPI3fjWsx5/QZEyyYsA==
X-Received: by 2002:a05:6a00:99d:b0:706:423b:2ed1 with SMTP id d2e1a72fcca58-70ce4f935fbmr9675543b3a.6.1721398665221;
        Fri, 19 Jul 2024 07:17:45 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70cff4b1d67sm1243284b3a.60.2024.07.19.07.17.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jul 2024 07:17:44 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Fri, 19 Jul 2024 07:17:42 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Nathan Chancellor <nathan@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Arnd Bergmann <arnd@arndb.de>,
	Naresh Kamboju <naresh.kamboju@linaro.org>,
	open list <linux-kernel@vger.kernel.org>,
	lkft-triage@lists.linaro.org,
	Linux Regressions <regressions@lists.linux.dev>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Anders Roxell <anders.roxell@linaro.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: next-20240712: task_work.c:(.text+0xc2): undefined reference to
 `irq_work_queue'
Message-ID: <406ffd29-6f92-48ab-924b-8d4f0973e50a@roeck-us.net>
References: <CA+G9fYv0xfJbt=+STRDu65G-Tq_w9wEH3C0q1ucyoAa7DbWLAQ@mail.gmail.com>
 <e25a690e-6cb9-4e00-ac1d-07cda43b12de@app.fastmail.com>
 <20240712132427.GJ27299@noisy.programming.kicks-ass.net>
 <6494316f-fcf9-4c19-9f3c-f8ad6f0810fa@app.fastmail.com>
 <20240712150333.GN27299@noisy.programming.kicks-ass.net>
 <20240718162527.GA197917@thelio-3990X>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240718162527.GA197917@thelio-3990X>

On Thu, Jul 18, 2024 at 09:25:27AM -0700, Nathan Chancellor wrote:
> On Fri, Jul 12, 2024 at 05:03:33PM +0200, Peter Zijlstra wrote:
> > On Fri, Jul 12, 2024 at 04:11:54PM +0200, Arnd Bergmann wrote:
> > > On Fri, Jul 12, 2024, at 15:24, Peter Zijlstra wrote:
> > > > On Fri, Jul 12, 2024 at 02:28:38PM +0200, Arnd Bergmann wrote:
> > > >> On Fri, Jul 12, 2024, at 14:13, Naresh Kamboju wrote:
> > > >
> > > >> that we may have to always enable IRQ_WORK even on non-SMP
> > > >> kernels now. In practice it is already enabled in most
> > > >> configurations for one reason or another, the the cost is
> > > >> likely very small.
> > > >> 
> > > >> Otherwise checking for CONFIG_HAVE_NMI in the new code might work.
> > > >
> > > > ARM seems to have HAVE_NMI while also being one of the architectures
> > > > that is now failing.
> > > 
> > > Right, in this case we would also need
> > > 
> > > --- a/arch/Kconfig
> > > +++ b/arch/Kconfig
> > > @@ -236,6 +236,7 @@ config HAVE_FUNCTION_ERROR_INJECTION
> > >  
> > >  config HAVE_NMI
> > >         bool
> > > +       select IRQ_WORK
> > >  
> > >  config HAVE_FUNCTION_DESCRIPTORS
> > >         bool
> > 
> > Yeah, that works for me I suppose.
> 
> Was there any conclusion to this thread that I missed? The
> configurations Naresh mentioned in the original post are now broken in
> mainline because the pull request was sent without any solution to this
> issue.
> 
> FWIW, that diff doesn't fix ARCH=powerpc tinyconfig, as it does not have
> CONFIG_HAVE_NMI. kernel/task_work.c is unconditionally built so
> shouldn't IRQ_WORK now be 'default y' (or just eliminated altogether)?
> 

Actually, many tinyconfig builds are now broken.

Example from alpha:

alpha-linux-ld: kernel/task_work.o: in function `task_work_add':
(.text+0x1b4): undefined reference to `irq_work_queue'
alpha-linux-ld: (.text+0x1bc): undefined reference to `irq_work_queue'

alpha does not set "HAVE_NMI". AFAICS task_work.c is always built,
and it now calls irq_work_queue() unconditionally, so unless that
is changed IRQ_WORK is now mandatory and must not just depend on
HAVE_NMI or anything else.

Guenter

