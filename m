Return-Path: <linux-kernel+bounces-531664-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BFA2AA44361
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 15:47:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9B2733B9E7E
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 14:43:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78B6E268FFD;
	Tue, 25 Feb 2025 14:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Or8u3HQW"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7A3D26E14A;
	Tue, 25 Feb 2025 14:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740494470; cv=none; b=jFTiIgUtIld6uNnFvKgih+j38esUKdEcadOWWCRJaNA2lAbetfvkklBVC8vBrxRbtEcu+gMvp63/S2bZ2Kki3s3hjHZv95dxdZXRiUnCzm6jatYYyRzjqwB0vIXs0UeXfHfIjYrLd0tJrNPtXfRNF4092i25J4NRygVZ1kWxI9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740494470; c=relaxed/simple;
	bh=fuXxncSLK5f15Hi8wT05D2Nn2vs8fYrA0hNkeAgTZe8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pErZ5pyrAnb1B2FcxHa0sl1zLd7IvbZ5GM9iBdOEbgSNk1iBgNzh319mqHBdE24oZVSncCfHZABP1qFox3oQYTj/ZSA/GuMg77uReYA3hIhbZG9FsOQoaAr1eJG1c8qjIgpb0TXAIooA8UvcSswLKbh0GB+PF+RczZehsJNhKm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Or8u3HQW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88ED7C4CEEA;
	Tue, 25 Feb 2025 14:41:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740494470;
	bh=fuXxncSLK5f15Hi8wT05D2Nn2vs8fYrA0hNkeAgTZe8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Or8u3HQWM2ffhboBsKRKwKUL2Xt9T4cln+f0faKG7MeifMVc6D35OI3hMNXqCfq8i
	 NvsX7dRkJPNAePyotp+cBqnIqSnKM9TjLpLE/i7Xrz9FM0FppZFjr5GWkSqkvm4gLI
	 mnuWxF/+ezTAhC5JCEQV8/PU/LpWqxz2czVL5yPkho0uio6ux3X7GUqgVlCQoQhinz
	 oSq3pIbXS3Q+qRMw5c/yVuiUKW+F1f8b0kWapqrzZKYOG07g3o8BMwjSc+Fp3B1d0C
	 jj2xBr73jt3gRMQc7VVE+kq+E0lCOXbBOifZfOXfPW+vnYDnB4zQo5a+5iQmIHIF8O
	 Zne+RmgLFniZg==
Date: Tue, 25 Feb 2025 08:41:08 -0600
From: Rob Herring <robh@kernel.org>
To: Zijun Hu <zijun_hu@icloud.com>
Cc: Saravana Kannan <saravanak@google.com>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, Zijun Hu <quic_zijuhu@quicinc.com>
Subject: Re: [PATCH 4/5] of: Do not change property state under
 __of_add_property() failure
Message-ID: <20250225144108.GB2279028-robh@kernel.org>
References: <20250224-of_bugfix-v1-0-03640ae8c3a6@quicinc.com>
 <20250224-of_bugfix-v1-4-03640ae8c3a6@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250224-of_bugfix-v1-4-03640ae8c3a6@quicinc.com>

On Mon, Feb 24, 2025 at 10:28:00PM +0800, Zijun Hu wrote:
> From: Zijun Hu <quic_zijuhu@quicinc.com>
> 
> Do not remove the property from list @np->deadprops if
> __of_add_property() encounters -EEXIST failure.

A property can never be on both np->deadprops and np->props.

> 
> Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
> ---
>  drivers/of/base.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/of/base.c b/drivers/of/base.c
> index c810014957e81171675b63f25eaabe391cc903e4..47cae6e48a48a7e1312c25fc5267bcf39102bbe9 100644
> --- a/drivers/of/base.c
> +++ b/drivers/of/base.c
> @@ -1646,9 +1646,6 @@ int __of_add_property(struct device_node *np, struct property *prop)
>  
>  	raw_spin_lock_irqsave(&devtree_lock, flags);
>  
> -	__of_remove_property_from_list(&np->deadprops, prop);
> -
> -	prop->next = NULL;
>  	next = &np->properties;
>  	while (*next) {
>  		if (of_prop_cmp(prop->name, (*next)->name) == 0) {
> @@ -1660,6 +1657,9 @@ int __of_add_property(struct device_node *np, struct property *prop)
>  	}
>  	*next = prop;
>  
> +	__of_remove_property_from_list(&np->deadprops, prop);
> +	prop->next = NULL;
> +
>  out_unlock:
>  	raw_spin_unlock_irqrestore(&devtree_lock, flags);
>  	if (rc)
> 
> -- 
> 2.34.1
> 

