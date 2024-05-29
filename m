Return-Path: <linux-kernel+bounces-194208-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 272948D3866
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 15:52:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 41C661C24496
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 13:52:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D5821BC2F;
	Wed, 29 May 2024 13:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="ZyeIVmHW"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40C6E18EA8
	for <linux-kernel@vger.kernel.org>; Wed, 29 May 2024 13:52:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716990740; cv=none; b=sDsLeE/G9iGsQR41D4fD/2ExePEPHpdUsfNozSvKkqMUoKrWDCqaAkQze9L9SDmL15uIxXH+HPD8arUYd4aQxPFFGxDIzI8FkU9AzP2t7PgrxoSLY5Z6tgFFcnHBodUg3HNimS4vvvL2fkinqEVeDXLY8PzxbeL6/UkMuXgweHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716990740; c=relaxed/simple;
	bh=scmYIIWiBUtvQ1/aYgr+xepSrRZem2K/QRx8v/oipBg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bFR4liR02oZhoYtyjwMMnzVKedU+KhE3p0SZUls++DY6StB1jcx5vPQ6gPmARz9wdRlUp/vowJqdnWKf73N4QnuGpGeAXMZJOF5TI0KosUEpovgpMECAc6RnLsffVtAkfwUfLJxhCSr5cSjOma5z/CrdvnfQSMA+lHbSpLh7l6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=ZyeIVmHW; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from pendragon.ideasonboard.com (81-175-209-231.bb.dnainternet.fi [81.175.209.231])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id BFDDDB53;
	Wed, 29 May 2024 15:52:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1716990734;
	bh=scmYIIWiBUtvQ1/aYgr+xepSrRZem2K/QRx8v/oipBg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZyeIVmHW8cSGunAdNU9/7blJ1ax6ZQ72xxzu4qjvu5VNVSKL0uFGxNSKF5QKo7U1H
	 7IBrqODJ/X55S+azimJKWoBY3/gPLzIiTTdaRnsSWfapQ4OBfgxb200/zi9m7FhhIb
	 b6LsWkydmckd8ik6kv0IKMYxH0pZ5z8POjYZT48I=
Date: Wed, 29 May 2024 16:52:05 +0300
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: James Clark <james.clark@arm.com>
Cc: coresight@lists.linaro.org, suzuki.poulose@arm.com,
	Mike Leach <mike.leach@linaro.org>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Mathieu Poirier <mathieu.poirier@linaro.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] coresight: Fix ref leak when
 of_coresight_parse_endpoint() fails
Message-ID: <20240529135205.GP1436@pendragon.ideasonboard.com>
References: <20240529133626.90080-1-james.clark@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240529133626.90080-1-james.clark@arm.com>

Hi James,

Thank you for the patch.

On Wed, May 29, 2024 at 02:36:26PM +0100, James Clark wrote:
> of_graph_get_next_endpoint() releases the reference to the previous
> endpoint on each iteration, but when parsing fails the loop exits
> early meaning the last reference is never dropped.
> 
> Fix it by dropping the refcount in the exit condition.

You can add

Reported-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

> Fixes: d375b356e687 ("coresight: Fix support for sparsely populated ports")
> Signed-off-by: James Clark <james.clark@arm.com>

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

One a side note, maybe it would be nice to add a new version of the
for_each_endpoint_of_node() macro that would declare the iterator as a
local variable scoped to the loop, making sure the reference always gets
released when we exit the loop.

And now that I've written that, it sounds we could as well have a
version of the macro that doesn't take a new reference to the iterator.
That may be simpler and less error-prone in the end.

> ---
>  drivers/hwtracing/coresight/coresight-platform.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/hwtracing/coresight/coresight-platform.c b/drivers/hwtracing/coresight/coresight-platform.c
> index 9d550f5697fa..57a009552cc5 100644
> --- a/drivers/hwtracing/coresight/coresight-platform.c
> +++ b/drivers/hwtracing/coresight/coresight-platform.c
> @@ -297,8 +297,10 @@ static int of_get_coresight_platform_data(struct device *dev,
>  			continue;
>  
>  		ret = of_coresight_parse_endpoint(dev, ep, pdata);
> -		if (ret)
> +		if (ret) {
> +			of_node_put(ep);
>  			return ret;
> +		}
>  	}
>  
>  	return 0;

-- 
Regards,

Laurent Pinchart

