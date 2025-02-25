Return-Path: <linux-kernel+bounces-531656-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B6663A4433A
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 15:43:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7FE73176ACC
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 14:41:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF7AB26BD87;
	Tue, 25 Feb 2025 14:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rYladAF9"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16F8F269B01;
	Tue, 25 Feb 2025 14:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740494327; cv=none; b=ARfHKOmySnkeFCsn2Ej+1YZPkRdH6LfDUE3dSY2Uc3X163X44a5cBHI9lfPQ9sIQIryXB8aCHspXcl+IP6fyAM8/AugqiKU6icBtnxnmGcXd+T2Ph17Kl2kecudvrEUCaTJJYrWkJYQyWSRtwvcqlkjp/LFBJMvrXOxWZVqoxO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740494327; c=relaxed/simple;
	bh=Rz8PyDQA7tXQDOwd3OcOnJOQh/8GiQQJF7d9jpHgyAA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KOC7tvUkrsc7aed5sSLhtdX/LfPEcIQf6Ygi4MBgTFh+LpMwfqQmE8i3YddPoFFyKnSgNt45QSYbiIwYJWLT+kaFfKgKTj8M0j80gc9NgXu9Is0wscgaKLfvdOJuHuUbGRLe3eoJTzq2DL5ktAZQ/W75qHCEwTPSIi95WXsA4aw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rYladAF9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51061C4CEDD;
	Tue, 25 Feb 2025 14:38:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740494326;
	bh=Rz8PyDQA7tXQDOwd3OcOnJOQh/8GiQQJF7d9jpHgyAA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rYladAF9gO1vtePJOw2dqv8gzam05iG1iItdHJGdTrhVI12hyWIiqopep7rg/CQUg
	 kNN8DI66uDg+rHaCYD5cVMMEyl33RnDMnT+oz8cR7QBRgkerJ2PPWWGUoIPcP3s58q
	 GpPAJ/jmSWjDWLN3v2Mf+wdfKUefQbKn76f53YH/4oVFhQ6fd/tcayyjTpRTaKFMsE
	 4LKNs+5L77UTMV/AjXsZQbG1t3Xc71wUbmGCwlLuA/QQVr1KOiGjYJCT430a9XZmJu
	 TZ1o8uULZHiBrIQWBy1VrF3+dm2Q3J+gYptx2PjIYj7DakL1UG8Q18coas5vLxOau2
	 gkOgPfx1iF98Q==
Date: Tue, 25 Feb 2025 08:38:44 -0600
From: Rob Herring <robh@kernel.org>
To: Zijun Hu <zijun_hu@icloud.com>
Cc: Saravana Kannan <saravanak@google.com>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, Zijun Hu <quic_zijuhu@quicinc.com>
Subject: Re: [PATCH 3/5] of: Correct property name comparison in
 __of_add_property()
Message-ID: <20250225143844.GA2279028-robh@kernel.org>
References: <20250224-of_bugfix-v1-0-03640ae8c3a6@quicinc.com>
 <20250224-of_bugfix-v1-3-03640ae8c3a6@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250224-of_bugfix-v1-3-03640ae8c3a6@quicinc.com>

On Mon, Feb 24, 2025 at 10:27:59PM +0800, Zijun Hu wrote:
> From: Zijun Hu <quic_zijuhu@quicinc.com>
> 
> __of_add_property() compares property name by strcmp(), and that is
> improper for SPARC which wants strcasecmp().

Except that 'name' is the nodename (usually, with a few rare 
exceptions). Sparc node names are case sensitive, so strcmp was correct. 

My hope is to get rid of case insensitive comparisions, so if nothing 
cares that we're doing a case sensitive comparision, I want to keep 
that. 

I also want to get rid of storing both 'name' as a property and 
device_node.name. The name property is an ABI issue though if no one is 
looking, then it's not an ABI issue. Also, we should be able to generate 
device_node.name from device_node.full_name. There's still a bunch of 
direct users of device_node.name which have to be fixed. Mostly in clock 
drivers from what I remember.

> Fix by using dedicated property name comparison macro of_prop_cmp().
> 
> Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
> ---
>  drivers/of/base.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/of/base.c b/drivers/of/base.c
> index 001ff6ce4abf85c07f13649d5a9f691f549a8ccc..c810014957e81171675b63f25eaabe391cc903e4 100644
> --- a/drivers/of/base.c
> +++ b/drivers/of/base.c
> @@ -1651,7 +1651,7 @@ int __of_add_property(struct device_node *np, struct property *prop)
>  	prop->next = NULL;
>  	next = &np->properties;
>  	while (*next) {
> -		if (strcmp(prop->name, (*next)->name) == 0) {
> +		if (of_prop_cmp(prop->name, (*next)->name) == 0) {
>  			/* duplicate ! don't insert it */
>  			rc = -EEXIST;
>  			goto out_unlock;
> 
> -- 
> 2.34.1
> 

