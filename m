Return-Path: <linux-kernel+bounces-377589-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CAB09AC0F9
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 10:04:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ECDF31F25168
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 08:04:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95245154BEC;
	Wed, 23 Oct 2024 08:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="sPDdRRVO"
Received: from out-180.mta1.migadu.com (out-180.mta1.migadu.com [95.215.58.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C2FD15852F
	for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 08:03:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729670616; cv=none; b=kKVK32YpqfU4azVOMG42f390i/JZdQbuJh4wTdyyvXPQYcEvSMti4yowUVXfacJ6WgKFytPD14lKGRm0UlLeJvjEZzywjezuj54uy8JEt0okH/y94s3thNdLMAFHBnuUoRB9E7G7RSukOnKrIof5D/mgt3zAA6IfInVkRWQ5aII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729670616; c=relaxed/simple;
	bh=UOb+OJTqgQzQWSLcS+b/dyA76TTbkp+2nr+zRq9bXh8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SpsVgynYdK7Kcah8pKKGXENvq6geP98a0ps6FgrJLbwn69VSyAqZWdMVaQX3BWVERxN3473jzfRoE+LcXO0BbvdNO/Mjx4T02Vbuu8esjugzVHi6cGUxlvv5r2L2LyVBL1y5ma3IhMrh35UIYTBO1ejXqySls/fAOlhPZKPY7tw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=sPDdRRVO; arc=none smtp.client-ip=95.215.58.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Wed, 23 Oct 2024 10:03:26 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1729670611;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=teYggURLbUjXgFRHPCAKbw5hoATyYK9evePO5wWpqTA=;
	b=sPDdRRVOK/BRFeylVX6pQb8u2pmD+W6zOscYPoChOie42lXP49yfifD6utdrdabfMJD6V4
	ILpmwG0MzVwevOAjpFVtv/e+tzyt1E4LJ1NH3eQyWpnVns3vSiXEVvScZIGEgqQL0u7J7b
	ihAFQOXn/oScaioOeSTcMl60DNPP1QY=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Andrew Jones <andrew.jones@linux.dev>
To: Raghavendra Rao Ananta <rananta@google.com>
Cc: Subhasish Ghosh <subhasish.ghosh@arm.com>, 
	Joey Gouly <joey.gouly@arm.com>, Oliver Upton <oliver.upton@linux.dev>, 
	Marc Zyngier <maz@kernel.org>, linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, 
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Subject: Re: [kvm-unit-tests PATCH 0/3] Fix arm64 clang errors on fpu tests
Message-ID: <20241023-f6a2a8d9fdea565838175648@orel>
References: <20241022004710.1888067-1-rananta@google.com>
 <20241022-2c60a0bcbb908435aa91d1ff@orel>
 <CAJHc60wraJEBTAj-MCTA4QC6cEikvxfMcFRX8Ook9EVYKQu_Tw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJHc60wraJEBTAj-MCTA4QC6cEikvxfMcFRX8Ook9EVYKQu_Tw@mail.gmail.com>
X-Migadu-Flow: FLOW_OUT

On Tue, Oct 22, 2024 at 01:31:24PM -0700, Raghavendra Rao Ananta wrote:
> Hi Andrew,
> 
> >
> > With clang 18.1.8 (Fedora 18.1.8-1.fc40) I get a bunch of errors like
> > these
> >
> >     arm/fpu.c:281:3: error: instruction requires: fp-armv8
> >
> > I used my cross-clang series[1] and configured with
> >
> >     ./configure --arch=arm64 --cc=clang --cflags='--target=aarch64'
> --cross-prefix=aarch64-linux-gnu-
> >
> > [1]
> https://lore.kernel.org/all/20240911091406.134240-7-andrew.jones@linux.dev/
> >
> > Thanks,
> > drew
> 
> I was able to reproduce the errors by pointing to a newer clang (20) and
> applying your series.
> I think we see the errors because llvm decided to disable loads and stores
> on FP registers with "-mgeneral-regs-only" [1]. Explicitly adding
> ".arch_extension fp" for the fp_reg_{read,write}() helped with the build:
> 
> diff --git a/arm/fpu.c b/arm/fpu.c
> index 6b0411d3..f44ed82a 100644
> --- a/arm/fpu.c
> +++ b/arm/fpu.c
> @@ -38,7 +38,8 @@ static inline bool arch_collect_entropy(uint64_t *random)
>  #define fpu_reg_read(val)                              \
>  ({                                                     \
>         uint64_t *__val = (val);                        \
> -       asm volatile("stp q0, q1, [%0], #32\n\t"        \
> +       asm volatile(".arch_extension fp\n"             \
> +                    "stp q0, q1, [%0], #32\n\t"        \
>                      "stp q2, q3, [%0], #32\n\t"        \
>                      "stp q4, q5, [%0], #32\n\t"        \
>                      "stp q6, q7, [%0], #32\n\t"        \
> @@ -71,7 +72,8 @@ static inline bool arch_collect_entropy(uint64_t *random)
>  #define fpu_reg_write(val)                             \
>  do {                                                   \
>         uint64_t *__val = (val);                        \
> -       asm volatile("ldp q0, q1, [%0], #32\n\t"        \
> +       asm volatile(".arch_extension fp\n"             \
> +                    "ldp q0, q1, [%0], #32\n\t"        \
>                      "ldp q2, q3, [%0], #32\n\t"        \
>                      "ldp q4, q5, [%0], #32\n\t"        \
>                      "ldp q6, q7, [%0], #32\n\t"        \
> 
> If you are fine with this, I can push it as a separate patch in v2.

The fix works for me too. Please post v2.

Thanks,
drew

