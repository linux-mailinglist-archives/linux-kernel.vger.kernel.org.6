Return-Path: <linux-kernel+bounces-562302-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC9CCA62248
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Mar 2025 00:51:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2D5554212AF
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 23:51:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E41D1F460B;
	Fri, 14 Mar 2025 23:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rosenzweig.io header.i=@rosenzweig.io header.b="NFxeQgAk"
Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com [91.218.175.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0BF0190676
	for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 23:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741996314; cv=none; b=sDnvL8nkPUqKe2CXt2jCzkWOecksswgTyTDTeT4xNPgf5JvVltsDrI9z60KbuGhbdp8wwdZJ2USY0nJcuG6+obxW1Q6ghhp3LNbAI2dOFKT/YNQq0Pri/BDnLISWAnPpER1NuMqI2k9hnfc3QK4PU60MdV6XPnapEcJaCOQ6w1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741996314; c=relaxed/simple;
	bh=p0Pj9tcQG6GfXZFp5IfdT5bVi4hWdGazLlS6zlwcJK0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C72YtEERvYXyCpP7UTpwKaWPe9X1qiC/zoD4bSqOU9ilY8PYj999NZDiK/xXPcsSLW3+0etUemByh5FCv3o/MyNVhEcFyB6Aj2rS4GAP2OdExAO2Bgxwn4/MPsjkQNW0iHssqxcpZKvBttm7cKOrxbwZ2fjfHhB81NxSY0uORpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=rosenzweig.io; spf=pass smtp.mailfrom=rosenzweig.io; dkim=pass (2048-bit key) header.d=rosenzweig.io header.i=@rosenzweig.io header.b=NFxeQgAk; arc=none smtp.client-ip=91.218.175.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=rosenzweig.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rosenzweig.io
Date: Fri, 14 Mar 2025 19:51:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rosenzweig.io;
	s=key1; t=1741996309;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=P0BbUbAG3eg70hP8/1CroK/Kf34mgOD7Ll45eATb+8I=;
	b=NFxeQgAk/R//VsAghYt8xhZSxiEQfPlmN19UgK3B030JQ8DgU2qLncAavMBApOJvK5h5lg
	FUI5N99t4GbrKAlZJktXynUCkOGRuTdDJO+6pTR+vnBMnEg2gyTzcvSnu8Z6AeMVQhUdCe
	G/CygyehVX9vYdfN1LvodihTLRmi16FtkLWVdvudJpaumAGt4A6HbhqFCQ0WA8bXBghD0a
	FaY2zdPIg22BU+zEcb1/4T24fLmnLXnoNfEToknIWMRMU6gDUUQOti7EI4zXgs4O/Y7paf
	zr+w5Yo/Fw2B8LmI1cejA0u0Erz9SM016vXwFJNqetok9RyACi6XuJE+f6ly1w==
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Alyssa Rosenzweig <alyssa@rosenzweig.io>
To: Qasim Ijaz <qasdev00@gmail.com>
Cc: marcan@marcan.st, fnkl.kernel@gmail.com,
	Sven Peter <sven@svenpeter.dev>, Janne Grunau <j@jannau.net>,
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>, asahi@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iommu: apple-dart: fix potential null pointer deref
Message-ID: <Z9TBEAJkOrHIWype@blossom>
References: <20250314230102.11008-1-qasdev00@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250314230102.11008-1-qasdev00@gmail.com>
X-Migadu-Flow: FLOW_OUT

Reviewed-by: Alyssa Rosenzweig <alyssa@rosenzweig.io>

Le Fri , Mar 14, 2025 at 11:01:02PM +0000, Qasim Ijaz a écrit :
> If kzalloc() fails, accessing cfg->supports_bypass causes a null pointer dereference. 
> 
> Fix by checking for NULL immediately after allocation and returning -ENOMEM.
> 
> Fixes: 3bc0102835f6 ("iommu: apple-dart: Allow mismatched bypass support")
> Signed-off-by: Qasim Ijaz <qasdev00@gmail.com>
> ---
>  drivers/iommu/apple-dart.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/iommu/apple-dart.c b/drivers/iommu/apple-dart.c
> index 13ccb801f52a..e13501541fdd 100644
> --- a/drivers/iommu/apple-dart.c
> +++ b/drivers/iommu/apple-dart.c
> @@ -797,12 +797,11 @@ static int apple_dart_of_xlate(struct device *dev,
>  
>  	if (!cfg) {
>  		cfg = kzalloc(sizeof(*cfg), GFP_KERNEL);
> -
> +		if (!cfg)
> +			return -ENOMEM;
>  		/* Will be ANDed with DART capabilities */
>  		cfg->supports_bypass = true;
>  	}
> -	if (!cfg)
> -		return -ENOMEM;
>  	dev_iommu_priv_set(dev, cfg);
>  
>  	cfg_dart = cfg->stream_maps[0].dart;
> -- 
> 2.39.5
> 

