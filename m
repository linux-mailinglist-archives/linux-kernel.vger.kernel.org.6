Return-Path: <linux-kernel+bounces-538950-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C127A49F22
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 17:42:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 248BC18855DB
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 16:42:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01BE1272934;
	Fri, 28 Feb 2025 16:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rosenzweig.io header.i=@rosenzweig.io header.b="cFIiO50c"
Received: from out-180.mta0.migadu.com (out-180.mta0.migadu.com [91.218.175.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D99981A5BA4
	for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 16:42:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740760932; cv=none; b=Kv/ar4D3UajWY9hSVQ2WNF65S4rbOOk8zcNPzolOVu41EaT/GUe1EUpzNjfTaBf/0Ra5BcuGGL00Rd6fArZuiJNUrzHTIEVaD7EHQZONlHps58L3JeJ4COtNnNJljRZOz6591nje0Ct6E7PR0pXI4bWkz6zJ6+SdQ9LhcK1IjyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740760932; c=relaxed/simple;
	bh=pn4KrWIyZwichxtIzcTnNK4W+4Y/6Co5uDlQdZSWWBE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HXjiQDLZvnI6gjl7zIkNdaGmjDxMkx8m5yqUssH/iZG6ggICI7WrbD1o9RXo9ytARve+rIxZYbjvgr9cJPROAEsnrGj1aMYPAsi3uy7T1WxrBI9oYXppWQvEmeQNTGjnOudZIe1JQj1GELaGu8tXyb/VIIoTgvTsotPyIjPdKfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=rosenzweig.io; spf=pass smtp.mailfrom=rosenzweig.io; dkim=pass (2048-bit key) header.d=rosenzweig.io header.i=@rosenzweig.io header.b=cFIiO50c; arc=none smtp.client-ip=91.218.175.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=rosenzweig.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rosenzweig.io
Date: Fri, 28 Feb 2025 11:42:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rosenzweig.io;
	s=key1; t=1740760926;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mFbK6atugzTD7yJD9m3zV6BCGNJwyUhEcjietF557HM=;
	b=cFIiO50ccNdoysTiPbKL6pEs59H43/JNspVbtHpwph8CQ5GCWccO/7y0yPIisAmHTcotJf
	KLUDDl/niDtXPGMEdKc49Oo4KijPpig9Ybn1NFHRv6sv9f2LxI/4bJTq9qMbGfl5mpZvi1
	ZQRcGPY4vr+cq0YR2r8s/yqOtMs6+pIire8RJVO/VPA+LospNomase0ltI8NVWfojZsp73
	+FeDCA5o2j45RdBg2caiwjdy71LY4IFpXS+42YfaXYtZVJUbEOF/GCCM3gOefGIrQrYWNP
	RDSsn94yDKDPsVIybmcJNd2eIuc+C2ea/BOqwlxtjWIqi8nVW0pD023QdsBMDA==
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Alyssa Rosenzweig <alyssa@rosenzweig.io>
To: fnkl.kernel@gmail.com
Cc: Sven Peter <sven@svenpeter.dev>, Janne Grunau <j@jannau.net>,
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>, asahi@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, Hector Martin <marcan@marcan.st>
Subject: Re: [PATCH v2 2/2] iommu: apple-dart: Allow mismatched bypass support
Message-ID: <Z8HnWdgPNMmCoXtX@blossom>
References: <20250228-isp-dart-v2-0-0ead81a90e2d@gmail.com>
 <20250228-isp-dart-v2-2-0ead81a90e2d@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250228-isp-dart-v2-2-0ead81a90e2d@gmail.com>
X-Migadu-Flow: FLOW_OUT

Reviewed-by: Alyssa Rosenzweig <alyssa@rosenzweig.io>

Le Fri , Feb 28, 2025 at 05:32:08PM +0100, Sasha Finkelstein via B4 Relay a écrit :
> From: Hector Martin <marcan@marcan.st>
> 
> This is needed by ISP, which has DART0 with bypass and DART1/2 without.
> 
> Signed-off-by: Hector Martin <marcan@marcan.st>
> Signed-off-by: Sasha Finkelstein <fnkl.kernel@gmail.com>
> ---
>  drivers/iommu/apple-dart.c | 17 ++++++++++++-----
>  1 file changed, 12 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/iommu/apple-dart.c b/drivers/iommu/apple-dart.c
> index edb2fb22333506d7c64ad1b6321df00ebfd07747..13ccb801f52a4d34f6653f78e92787af7dfed1bc 100644
> --- a/drivers/iommu/apple-dart.c
> +++ b/drivers/iommu/apple-dart.c
> @@ -277,6 +277,9 @@ struct apple_dart_domain {
>   * @streams: streams for this device
>   */
>  struct apple_dart_master_cfg {
> +	/* Intersection of DART capabilitles */
> +	u32 supports_bypass : 1;
> +
>  	struct apple_dart_stream_map stream_maps[MAX_DARTS_PER_DEVICE];
>  };
>  
> @@ -684,7 +687,7 @@ static int apple_dart_attach_dev_identity(struct iommu_domain *domain,
>  	struct apple_dart_stream_map *stream_map;
>  	int i;
>  
> -	if (!cfg->stream_maps[0].dart->supports_bypass)
> +	if (!cfg->supports_bypass)
>  		return -EINVAL;
>  
>  	for_each_stream_map(i, cfg, stream_map)
> @@ -792,20 +795,24 @@ static int apple_dart_of_xlate(struct device *dev,
>  		return -EINVAL;
>  	sid = args->args[0];
>  
> -	if (!cfg)
> +	if (!cfg) {
>  		cfg = kzalloc(sizeof(*cfg), GFP_KERNEL);
> +
> +		/* Will be ANDed with DART capabilities */
> +		cfg->supports_bypass = true;
> +	}
>  	if (!cfg)
>  		return -ENOMEM;
>  	dev_iommu_priv_set(dev, cfg);
>  
>  	cfg_dart = cfg->stream_maps[0].dart;
>  	if (cfg_dart) {
> -		if (cfg_dart->supports_bypass != dart->supports_bypass)
> -			return -EINVAL;
>  		if (cfg_dart->pgsize != dart->pgsize)
>  			return -EINVAL;
>  	}
>  
> +	cfg->supports_bypass &= dart->supports_bypass;
> +
>  	for (i = 0; i < MAX_DARTS_PER_DEVICE; ++i) {
>  		if (cfg->stream_maps[i].dart == dart) {
>  			set_bit(sid, cfg->stream_maps[i].sidmap);
> @@ -945,7 +952,7 @@ static int apple_dart_def_domain_type(struct device *dev)
>  
>  	if (cfg->stream_maps[0].dart->pgsize > PAGE_SIZE)
>  		return IOMMU_DOMAIN_IDENTITY;
> -	if (!cfg->stream_maps[0].dart->supports_bypass)
> +	if (!cfg->supports_bypass)
>  		return IOMMU_DOMAIN_DMA;
>  
>  	return 0;
> 
> -- 
> 2.48.1
> 
> 

