Return-Path: <linux-kernel+bounces-260246-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96A5193A4F6
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 19:31:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 52141283D28
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 17:31:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 779F3157A48;
	Tue, 23 Jul 2024 17:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="vZuXjLX6"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A54BB1E522
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2024 17:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721755872; cv=none; b=GTV1shC4202UiuHsPqRuOCDULDVRtwIA8uYCL3iCyDrqSNsgVlhBg1Lh7do7yhwNopSNKMNw2FX3wS4byjZFnawkWHqYWwEO4nBwR8Ov5mVD5wRp6F+UqLTqWYeZT4Kt+muYrDhpywaEBHp0cx8YdkiiuUt9kfzzQl7hr0zoc0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721755872; c=relaxed/simple;
	bh=RchEBs6oWyvASpMxnye4o/sOzMvDdmRWjspsPJECW5A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OfrSJcxac3WL1oRTUUq339+ZIcq6zLO0uayVUnl7sGDM5ulrpSBWytwvCgScBODZya3PEk4vD+3p7Jhb9VZY5sVt+zpNEFRAVPcFSuI2O/k4EKZHs4bxQ3cFK7SDZxSEq11TWgLEIvIHPq8RfpiJOuI4A+LhV6Hr9YsgV3UlLXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=vZuXjLX6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BF9EC4AF0A;
	Tue, 23 Jul 2024 17:31:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1721755872;
	bh=RchEBs6oWyvASpMxnye4o/sOzMvDdmRWjspsPJECW5A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=vZuXjLX67D2cG1YL8/a7xADBLMCTjdiwP9nnTyKJZcCpUHO82CX7N8A93rkpBSigd
	 HyLcCSmHsouNWr9IUya/ulUCTjqmXe8d2o+Jd/Z7zl+2rCT1VtFtmuLM7rv8K9Kpdi
	 v0hy5N4Rq2m2ZhgVwNMEW8UHfFKAjfvmdYiMfvwo=
Date: Tue, 23 Jul 2024 19:31:09 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Zijun Hu <zijun_hu@icloud.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, linux-kernel@vger.kernel.org,
	Zijun Hu <quic_zijuhu@quicinc.com>
Subject: Re: [PATCH] driver core: bus: Return -EIO instead of 0 when
 show/store invalid bus attribute
Message-ID: <2024072316-yeah-snide-ca28@gregkh>
References: <20240723-bus_fix-v1-1-175f926805dc@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240723-bus_fix-v1-1-175f926805dc@quicinc.com>

On Tue, Jul 23, 2024 at 10:55:43PM +0800, Zijun Hu wrote:
> From: Zijun Hu <quic_zijuhu@quicinc.com>
> 
> Return -EIO instead of 0 when show/store invalid bus attribute as
> class/device/driver/kobject attribute.

Why?  What is this now going to break?  You are changing a user-visable
api that has been this way for 20+ years, how was this tested?

> 
> Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
> ---
>  drivers/base/bus.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/base/bus.c b/drivers/base/bus.c
> index ffea0728b8b2..e84522a90102 100644
> --- a/drivers/base/bus.c
> +++ b/drivers/base/bus.c
> @@ -152,7 +152,7 @@ static ssize_t bus_attr_show(struct kobject *kobj, struct attribute *attr,
>  {
>  	struct bus_attribute *bus_attr = to_bus_attr(attr);
>  	struct subsys_private *subsys_priv = to_subsys_private(kobj);
> -	ssize_t ret = 0;
> +	ssize_t ret = -EIO;
>  
>  	if (bus_attr->show)
>  		ret = bus_attr->show(subsys_priv->bus, buf);
> @@ -164,7 +164,7 @@ static ssize_t bus_attr_store(struct kobject *kobj, struct attribute *attr,
>  {
>  	struct bus_attribute *bus_attr = to_bus_attr(attr);
>  	struct subsys_private *subsys_priv = to_subsys_private(kobj);
> -	ssize_t ret = 0;
> +	ssize_t ret = -EIO;

Why -EIO?  What is wrong with returning an empty string?

I think I know why you picked this but you better document the heck out
of it AND test it very very well first.

thanks,

greg k-h

