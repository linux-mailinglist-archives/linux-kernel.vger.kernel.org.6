Return-Path: <linux-kernel+bounces-348069-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FA6E98E224
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 20:15:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A9981B24114
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 18:15:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 974131DB94E;
	Wed,  2 Oct 2024 18:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="nRpFFCDZ"
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5B3E1DB55C
	for <linux-kernel@vger.kernel.org>; Wed,  2 Oct 2024 18:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727892903; cv=none; b=j3HPtKKF7Bk0RmP2GeRbLgZKk7UTZATa/A6JcZ+WBVoQ59KnvRvY9OqjIQpTARpRtv1L1WxdHSQHenXcsGj4sQpP2JMUitm5GuXOJ5w1zYSgY85KG651lhyOVg2U4nG4iyv4A97XnIT59utWGNsyCIHp8xuRnG2/gtuvuN0Lq4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727892903; c=relaxed/simple;
	bh=2+XADeyE958bOznqf4aVYFB0/TBJLayiu5BscoW/k4A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ac1lrjO6Tt4s5FbpHQr8I5doX8KqMuHJQZErsmWvvQuloRH7WYSUOXsbxaAkZiSaLPaZJtxpqq4uRT6fovCmX6dE5dBrK1OKx0miXV/sTsy39IsaJmC7YlWA/P93fPoPkArjb9sQaLl02Ul9iRoMtxkK6Rvjfc58u4oKV0OeI/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=nRpFFCDZ; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-6cb22e9c6dbso950676d6.1
        for <linux-kernel@vger.kernel.org>; Wed, 02 Oct 2024 11:15:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1727892899; x=1728497699; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7isLwNgAFftRQNI2d6VEiKpImMXN1qIZBDVetXlWrhE=;
        b=nRpFFCDZQJR3G8HthXjhbHBcvJKgUNSl8R0lj8HTCEr2mpB8pXh0ue6EaIwqaHFS4I
         JCHXY0IT9vIkpmyk2jKcvCUDuJdMPr5RmBEgVCyJA8669ucddzdjIWlEhwynGKxpfm3x
         GMuNUNhIfdtTv9Xo+FMFG/aEvxVTl/UOjOBPYrbxRGLyTri55MQHTAQ7sYG+dXDy6fgW
         SOMgynMPhpKwsQr/Z3/wyrtPJ8YtluR+VogPuuyhIfR5HBJ78V4UYk0+K44yh9eeNiHn
         yjdtw4VD95koZZzyQZM/mkhzSSN8M5tkqpcdoPDQvgwWnWZg1QbFKEBBNYTzQBN44ADu
         FOmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727892899; x=1728497699;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7isLwNgAFftRQNI2d6VEiKpImMXN1qIZBDVetXlWrhE=;
        b=J+iNA2+nWWy1uqYlWdW5EaibazRMJCVYpCO6zjdonvgDOQPjCyPTtAJuvDnOmgbW6m
         FTrNQb+1rpCjXjv9kJXKw2nPUjX4/S+wx1RQl6cRE+DzWll3VKWjR5B9JyQPm5pzkYdI
         FPe0tqlfw/eIFQVS+ZEa/YFAiSbICn0xcarteYjqvP3PcHhNCCdTF0hE715U6j9KrtU8
         U5a6u7G4ELbVAU/HfHUphcBUalSBu62TWTUGpf10H83nUN3m+cUzxbJTK02yd0lXtAQX
         ZmkfsF6ef6F3FQwCvmhXjXatr6NBEAtR9Kv46fT5ASA2gjxVDYq5UeC+3M1ZO/txf5WQ
         5uxw==
X-Forwarded-Encrypted: i=1; AJvYcCU65UM8paxspp3I3Cn6HgRW3FgrSpQ5k1KHJ/7QL2hABRMxrTi2OVw6LVdrM2cVQ2bnv9XZK0A/Cr3jcTU=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywnlmmo1DFIz64tcd1lib2OATVDs4Wj9RrAB2cHhK/DLldzN9ye
	tsDYZLKE57y/8arWBxd4E4tut92Gn1Uqk4bx9WqZJ+h4SnP79A14zSndecuFeiQabSVGbdMuMgl
	s
X-Google-Smtp-Source: AGHT+IHUWegeu0iNaiqwi4NU7iIsOUUtFs2eDwht+TlsMdZFGYB/poFQ/SkzzMeLG7BamxI8CD6DlA==
X-Received: by 2002:a0c:e789:0:b0:6cb:904c:478d with SMTP id 6a1803df08f44-6cb904c4f92mr4962396d6.16.1727892899641;
        Wed, 02 Oct 2024 11:14:59 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-128-5.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.128.5])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6cb3b67f247sm63007516d6.107.2024.10.02.11.14.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Oct 2024 11:14:59 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1sw3sI-00A6kq-O6;
	Wed, 02 Oct 2024 15:14:58 -0300
Date: Wed, 2 Oct 2024 15:14:58 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Yang Shi <yang@os.amperecomputing.com>
Cc: nicolinc@nvidia.com, james.morse@arm.com, will@kernel.org,
	robin.murphy@arm.com, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [v2 PATCH] iommu/arm-smmu-v3: Fix L1 stream table index
 calculation for 32-bit sid size
Message-ID: <20241002181458.GK1369530@ziepe.ca>
References: <20241002175514.1165299-1-yang@os.amperecomputing.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241002175514.1165299-1-yang@os.amperecomputing.com>

On Wed, Oct 02, 2024 at 10:55:14AM -0700, Yang Shi wrote:

> Using 64 bit immediate when doing shift can solve the problem.  The
> disassembly after the fix looks like:
>     ldr     w20, [x19, 828] //, smmu_7(D)->sid_bits
>     mov     x0, 1
>     lsl     x0, x0, x20
> 
> There are a couple of problematic places, extracted the shift into a helper.
> 
> [1] https://lore.kernel.org/lkml/d4b53bbb-333a-45b9-9eb0-23ddd0820a14@arm.com/
> Fixes: ce410410f1a7 ("iommu/arm-smmu-v3: Add arm_smmu_strtab_l1/2_idx()")
> Tested-by: James Morse <james.morse@arm.com>
> Signed-off-by: Yang Shi <yang@os.amperecomputing.com>
> ---
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 8 +++++---
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h | 5 +++++
>  2 files changed, 10 insertions(+), 3 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason

