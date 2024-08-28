Return-Path: <linux-kernel+bounces-305226-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C0F95962B52
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 17:09:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F38771C2231E
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 15:09:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3F201A38D2;
	Wed, 28 Aug 2024 15:08:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pXq2xj7/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC28D1A2C23;
	Wed, 28 Aug 2024 15:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724857709; cv=none; b=tg4HLtjWrl2BIkBX96eJ8VuYBbLcGtuG5BF1vGIaTJwKsD1J3wniziJ57r+qY8XoYjK5QX3gYPWH/N6Sgedb/MLZ79MGz5wOcLePdUYdOctOerAT1NugXIa0XsZj4jnmwWeCBYgWW2Wp225M1Fp/R1HS/l4oT9V7VgC3R7WuscM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724857709; c=relaxed/simple;
	bh=HNg9q2knOB0gBNhBzjELo9+v0eNjNeGoFMlMPrT6gJ0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LfUCQSsTbMLYpYHpnJkqbU11Uc1Ms8rL8tZ3RRU2sZJNfS0lwsB5tiS9Nv5yIXPm2AYbGCppHimSUzhbM438YZthTKn9Y09JXVhOENyTcDCwGXaAx2v3hMCxZRLWaqKdrT4tF1KQM/sJy16KozI8x2TjfP45tYzG3iASeQoWbwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pXq2xj7/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C084C4CEC3;
	Wed, 28 Aug 2024 15:08:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724857708;
	bh=HNg9q2knOB0gBNhBzjELo9+v0eNjNeGoFMlMPrT6gJ0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pXq2xj7/VuSRjB88+C7RBxOLYWcwzBoNrxAbo4uSIohEImw8aVCO3WaaHJXDSP+pY
	 8KFCRPRYtnFISVv3xkQczUhwKLqdkMDR0dcI5lZ7GIhA3Lc5Nwv7GvnucPv9JjqcF0
	 IMqGBPWhI7bnq0MxNjUmaPYxIod32XkdvZIGmVQ2v4KzBCeynOTOz1ydHWbz/nNzw+
	 aeDyviNUSB9/azozaGphFCm1wZu2nQjcSe/PNi6+GuByQdTWoc8G0VGvJKLY58z+2U
	 99dHEYZ+W5oEOZ871q5K3LskoiOu0bNWqbWNWuM9z7qAiG26OzJiU571KOzib60IhW
	 UuVJLyXtEG08g==
Date: Wed, 28 Aug 2024 10:08:26 -0500
From: Rob Herring <robh@kernel.org>
To: Kunwu Chan <kunwu.chan@linux.dev>
Cc: saravanak@google.com, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, Kunwu Chan <chentao@kylinos.cn>
Subject: Re: [PATCH] of/platform: Use dev_is_platform() to identify PCI
 devices
Message-ID: <20240828150826.GA3803566-robh@kernel.org>
References: <20240827094403.166238-1-kunwu.chan@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240827094403.166238-1-kunwu.chan@linux.dev>

On Tue, Aug 27, 2024 at 05:44:02PM +0800, Kunwu Chan wrote:
> From: Kunwu Chan <chentao@kylinos.cn>

Subject - For PCI devices?

> 
> Use dev_is_platform() instead of checking bus type directly.
> 
> Signed-off-by: Kunwu Chan <chentao@kylinos.cn>
> ---
>  drivers/of/platform.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/of/platform.c b/drivers/of/platform.c
> index 86be4dfb9323..3696140bae9e 100644
> --- a/drivers/of/platform.c
> +++ b/drivers/of/platform.c
> @@ -625,7 +625,7 @@ int of_platform_device_destroy(struct device *dev, void *data)
>  	of_node_clear_flag(dev->of_node, OF_POPULATED);
>  	of_node_clear_flag(dev->of_node, OF_POPULATED_BUS);
>  
> -	if (dev->bus == &platform_bus_type)
> +	if (dev_is_platform(dev))
>  		platform_device_unregister(to_platform_device(dev));
>  #ifdef CONFIG_ARM_AMBA
>  	else if (dev->bus == &amba_bustype)

Perhaps to keep things consistent, add a dev_is_amba() and use it here.

> -- 
> 2.41.0
> 

