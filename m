Return-Path: <linux-kernel+bounces-536939-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13935A48645
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 18:10:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 994EB17824C
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 17:02:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 551051DDC29;
	Thu, 27 Feb 2025 17:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rosenzweig.io header.i=@rosenzweig.io header.b="jYgTgyQa"
Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com [91.218.175.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2F601CAA96
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 17:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740675740; cv=none; b=lR1nZeSmo6GxDz8lMUPpEVKiBLaMcSwagBU3FrBEIi0zHJ80VsOhhhMoMoXXb68RbV4A/ytyDz4IMZezvSzLWx/HBrR4VF/sfaCIwbj0dxcEOtOhxnRMvcumnaRvuNn72MmAWqRx5VVFTAWfEMIydthGlX2RYhf94qUWD8hJFuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740675740; c=relaxed/simple;
	bh=MUFbVFjIYZLhtsooeA7GWuQyzlkwwMGqWPqMOQNcnSc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FuapvmzBb7Ljn85+ZT0hcgDQVprHEZEO1pT5Hu9TQTEYloRosEb0iqjBVEfOWjc/yffZXuN8+PVLGyUzwIFEnDLzQny1UVdBJ1NJgWr1Icusifb0n7mC/YhAo6Y6qPdaFj3HcErZLHLlfZ0Un/dd7ikFkkYI76KazT5NdVgy9mw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=rosenzweig.io; spf=pass smtp.mailfrom=rosenzweig.io; dkim=pass (2048-bit key) header.d=rosenzweig.io header.i=@rosenzweig.io header.b=jYgTgyQa; arc=none smtp.client-ip=91.218.175.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=rosenzweig.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rosenzweig.io
Date: Thu, 27 Feb 2025 12:02:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rosenzweig.io;
	s=key1; t=1740675736;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=buScLni0fJpq/olYSYs/TP5v5AMqPIGM9l8uVS6GTbk=;
	b=jYgTgyQatW2/J5YgV8UCLIUrdXMporvBsRM4196W2rfF289Fk2/Fo4JOKsXSBEwxsHD4Sf
	Mi0suq3ARv+pa1DunsrhOHKtSWRaKeBTK+UgaRt3cgCDDk/HhsWQTkI1OVWM+CDgh5mKYN
	HOlYj17+N+3DA6LbkE8AmChqAivD9n73e4EY23o4GoSzEU9mLNbvqv2fk1PVTh3q10oaTd
	mWilusDemTDcY1gqTUHcmmcPS2ePcoYQAdzXYG3QrJkJ0RYqZOj5/rp/Hfr3kLMm/4o8bq
	6ctgtfJJHAQ1CHalr99fAEPA+kFirTjIlrx4PsnMJ+/2Cy8DEVuDlLkWEV0fig==
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Alyssa Rosenzweig <alyssa@rosenzweig.io>
To: fnkl.kernel@gmail.com
Cc: Sven Peter <sven@svenpeter.dev>, Janne Grunau <j@jannau.net>,
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>, asahi@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, Hector Martin <marcan@marcan.st>
Subject: Re: [PATCH 1/2] iommu: apple-dart: Increase MAX_DARTS_PER_DEVICE to 3
Message-ID: <Z8Cak9VdyUIedOsV@blossom>
References: <20250227-isp-dart-v1-0-161e91ef4f46@gmail.com>
 <20250227-isp-dart-v1-1-161e91ef4f46@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250227-isp-dart-v1-1-161e91ef4f46@gmail.com>
X-Migadu-Flow: FLOW_OUT

Reviewed-by: Alyssa Rosenzweig <alyssa@rosenzweig.io>

Le Thu , Feb 27, 2025 at 05:56:03PM +0100, Sasha Finkelstein via B4 Relay a écrit :
> From: Hector Martin <marcan@marcan.st>
> 
> ISP needs this.
> 
> Signed-off-by: Hector Martin <marcan@marcan.st>
> Signed-off-by: Sasha Finkelstein <fnkl.kernel@gmail.com>
> ---
>  drivers/iommu/apple-dart.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/apple-dart.c b/drivers/iommu/apple-dart.c
> index 95ba3caeb40177901086076416874b9905a1f40a..edb2fb22333506d7c64ad1b6321df00ebfd07747 100644
> --- a/drivers/iommu/apple-dart.c
> +++ b/drivers/iommu/apple-dart.c
> @@ -36,7 +36,7 @@
>  
>  #define DART_MAX_STREAMS 256
>  #define DART_MAX_TTBR 4
> -#define MAX_DARTS_PER_DEVICE 2
> +#define MAX_DARTS_PER_DEVICE 3
>  
>  /* Common registers */
>  
> 
> -- 
> 2.48.1
> 
> 

