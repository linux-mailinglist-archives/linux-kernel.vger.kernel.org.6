Return-Path: <linux-kernel+bounces-215588-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1954B9094A9
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jun 2024 01:18:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BC4BE1F218C8
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 23:18:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 833AF190492;
	Fri, 14 Jun 2024 23:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KN0preVS"
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 260AD18F2FF
	for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2024 23:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718406619; cv=none; b=fxy4LofvYwlKf0vd0SVGpG0mL8tGLTe+O8XXoSYcxBfcG+W1Q0cRI4LvFuiPM2x8X0GJgJD0eLnK+8ZDJQI9FHt8Hun1NEyXpkMvcq5jlO4u0ylghMEgqJ6Y3QsB19+C2+9uJvI/rGBExxUUp4zGAQHbBjfHcpY2DdOiSye0V2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718406619; c=relaxed/simple;
	bh=HBZ8c72MkYU8netKasktWfqGShzs0OT54b/QhebpP2k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cdvvpAz6GgOxjxSCCY10hfaM/jjdDa25e/LMmx7c0yDyQn2kKjOE81xIJvsouIYkTKszzqSpWKgZQ67XIlohjUt+Eb5jVncc8foAMHjUC4YBEV1k4M5Fmb1Vwl7eLgIfl9P2bpm/tQaTWQvtkJs+YQDwvf6+bthW5ZK44zAFagY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KN0preVS; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1f6fabe9da3so23509175ad.0
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2024 16:10:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1718406616; x=1719011416; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=MLrLbkLvm0tzY1MpEgPbssfKu8Uj01vCeIVrV1R6cSw=;
        b=KN0preVSUBg8oW44G6gLpUTyabnGj+IwrbB483ZUWb8jirmE32n2xp5Q4nzoaYzPBR
         pjhvSVVB41tgPACvUACPafFHctssUpVZcH/PxLI1bzTkgA/Z73FCC3WRDULPxpgfNw3l
         qY+/9+pNBCx+UvaFKVK/An9xf3CA5+smhOCbYCk3xoE9hXKwC2qUDPr2ajGCJ5zSAvfL
         bEMIx4T3jcwtXRnOCn/IR/G3Bc8xCzYMCH8KmDojGU6qPUAGkDAzytZa7/3ptyQXUfrt
         rLeK8p5Y7u0IQN813j1+lTv3APMYDmkdEXkL87OUXCsSIJ8Mlo6DMPdtTSaamPShm/x/
         jBiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718406616; x=1719011416;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MLrLbkLvm0tzY1MpEgPbssfKu8Uj01vCeIVrV1R6cSw=;
        b=gkoLt1Li7T9O0m6D2sKCvGnIXYCI28VYNybEibiY6Wv5SNYLO1JcAgQ9xll8zA8jKb
         XyfUF6CQZCZ0rhmpqjiiAdAyMLHliCaudLGxmEmgYsTVPWyMYu9jVPP1vmolebpH4Ycd
         6/yZ9L2aljiqEM8hNf5fckUzvDsnpfi95Vq/BqBOqaTER2cuC1Chhptu/XLT1+2O99UK
         SbB7vl44Bf8C8/75UgIYf4cyMw8ffIPYnWW5WUCBtKL1nx7osJGOr1Nbsish43hu1l1a
         Of5WSiasGTQdqbkn1X6RY75BMIM+zN263rnZjrRS5aTo75q6AHKjRXjNSnCmIcflp4lb
         IhPA==
X-Forwarded-Encrypted: i=1; AJvYcCXBGX+Pk+sBifdGpNes5rEXK7KCwZkmgw8/P8iQLkaohY5q2n5bxYCLnY1IuHAALUVEbzsouhEaNWcxC/qwRSXzcWt+4ZXkfXqKIkR5
X-Gm-Message-State: AOJu0YzOKtsRXUXakXl2azMFZzBTbesXPvbHx2TgHYGMpvqOzLxbrN+y
	V5Y6E6kRPpzAQJyI/xNrhmr/ixrgUg0SKid7ZE4CUEPzJubJJRmGQ04Qf9p+Xw==
X-Google-Smtp-Source: AGHT+IFcGsUH/QLxSXoL5wsJjIp8jl2vBep3vY4YHvN9/DueuGnm24AE2rupPbUPlpI7DAnWqNrRNg==
X-Received: by 2002:a17:903:32c9:b0:1f4:7713:8f6 with SMTP id d9443c01a7336-1f8629fb039mr39146585ad.52.1718406615926;
        Fri, 14 Jun 2024 16:10:15 -0700 (PDT)
Received: from google.com (201.215.168.34.bc.googleusercontent.com. [34.168.215.201])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f855f485ccsm37485285ad.279.2024.06.14.16.10.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jun 2024 16:10:15 -0700 (PDT)
Date: Fri, 14 Jun 2024 23:10:12 +0000
From: Carlos Llamas <cmllamas@google.com>
To: John Hubbard <jhubbard@nvidia.com>
Cc: Shuah Khan <shuah@kernel.org>, Mark Brown <broonie@kernel.org>,
	Vincenzo Frascino <vincenzo.frascino@arm.com>,
	Colin Ian King <colin.i.king@gmail.com>,
	Valentin Obst <kernel@valentinobst.de>,
	linux-kselftest@vger.kernel.org,
	LKML <linux-kernel@vger.kernel.org>, llvm@lists.linux.dev,
	Andy Lutomirski <luto@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v2] selftests/vDSO: fix clang build errors and warnings
Message-ID: <ZmzN1CBv5j9YV543@google.com>
References: <20240527211622.290635-1-jhubbard@nvidia.com>
 <ZmiXqOHYaLLX557z@google.com>
 <2461f002-fdd4-4bf5-b797-827069cafc4b@nvidia.com>
 <8a6f384f-02b7-4a0b-90dd-e6843909e8a9@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8a6f384f-02b7-4a0b-90dd-e6843909e8a9@nvidia.com>

On Fri, Jun 14, 2024 at 03:56:01PM -0700, John Hubbard wrote:
> On 6/14/24 3:51 PM, John Hubbard wrote:
> > On 6/11/24 11:30 AM, Carlos Llamas wrote:
> > > On Mon, May 27, 2024 at 02:16:22PM -0700, John Hubbard wrote:
> ...
> > > Reviewed-by: Carlos Llamas <cmllamas@google.com>
> > 
> > Thanks for the review! I have no earthly idea what will happen next.
> > I'd like to hear at least something from the maintainers about their
> > intentions here.
> > 
> 
> In fact, I have two more patches for vDSO (these are separate issues,
> for the Makefile), and I just noticed that there are several accumulated
> Reviewed-by and Tested-by tags on this patch here. So I think the way
> forward is this:
> 
> I'll post a v3, with three patches for vDSO selftests, and the latest
> tags. And let's see how that fares.
> 

Yeap, a resend would have been good. This time it might be best to bring
Andy and Thomas in the loop too.

Cc: Andy Lutomirski <luto@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>

> thanks,
> -- 
> John Hubbard
> NVIDIA
> 

