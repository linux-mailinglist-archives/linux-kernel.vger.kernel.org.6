Return-Path: <linux-kernel+bounces-525328-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2725CA3EE9E
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 09:24:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D47647ADC1D
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 08:19:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADDFA200127;
	Fri, 21 Feb 2025 08:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="qWAGniIU"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14D2D1FCFF8
	for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 08:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740126011; cv=none; b=qVLfr9VfFqjvCC2J1F/S6+kTbvFH7JffyiuvdtsfsjWck1kzubwdwLpq/ZWEkxFGA0iQlqmNpotQk7V7jrOqcFdgOCElzvXCH8hPoRPjmaVDfxLvmj87Ues4kMPrO6zC82PGLlRa0cd3reCOiAWhlYhFXGe/vq6BHu7MWNoeT1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740126011; c=relaxed/simple;
	bh=8/XYAeXk6tcuCdvVMOoCiyFi4x2vZEWADUzi7WoP5Tk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Wau3bUGa+ZTTA3i5MxwcNkJvc85tIv2TX/ABqwep4BqXhTnzR+8GSYg9tPwiWjG0uuvxVuCnOHcmxrAq9ku/v36cUY60Em7+VTfpXQdzXx8Wu7oHrokW5mMOZ6QH7BzI0OqW/m83YYy0QE+JZQi9tRp2U65wFU0kfWSfVFMRlAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=qWAGniIU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 201E9C4CEDD;
	Fri, 21 Feb 2025 08:20:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1740126010;
	bh=8/XYAeXk6tcuCdvVMOoCiyFi4x2vZEWADUzi7WoP5Tk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qWAGniIUpK2w0E7FKZ5o1ScG/pKZGgDXfyOJWc6yF0dCt8ZxmBApvQs2XPpQGl3Y2
	 zHof1R+tqqhYH54ioy8pa2plQ/etD6TZrkKbYf1SZNcxen2dPe02BJlf8r95Hj3Nfd
	 QkbsBqD4KdN33obfuXFHlzuFh14/v32yAbjN47tA=
Date: Fri, 21 Feb 2025 09:20:07 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: xiaopeitux@foxmail.com
Cc: broonie@kernel.org, linux-kernel@vger.kernel.org,
	Pei Xiao <xiaopei01@kylinos.cn>, kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] driver core: device.h: fix incorrect type in return
 expression
Message-ID: <2025022106-parmesan-nutmeg-b502@gregkh>
References: <tencent_06B4B908579B884FEE392A1448602FAC9307@qq.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tencent_06B4B908579B884FEE392A1448602FAC9307@qq.com>

On Wed, Jan 22, 2025 at 03:35:03PM +0800, xiaopeitux@foxmail.com wrote:
> From: Pei Xiao <xiaopei01@kylinos.cn>
> 
> sparse warnings:
> 	sparse: incorrect type in return expression, expected void
> [noderef] __iomem *, got void *
> 
> Fix sparse warnings by use IOMEM_ERR_PTR
> 
> Fixes: da7c07b10838 ("driver core: Provide stubs for !IOMEM builds")
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202501221439.YoPUrrqD-lkp@intel.com/
> Signed-off-by: Pei Xiao <xiaopei01@kylinos.cn>
> ---
>  include/linux/device.h | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/include/linux/device.h b/include/linux/device.h
> index 667cb6db9019..d76c31b9f9b9 100644
> --- a/include/linux/device.h
> +++ b/include/linux/device.h
> @@ -378,14 +378,14 @@ static inline
>  void __iomem *devm_ioremap_resource(struct device *dev,
>  				    const struct resource *res)
>  {
> -	return ERR_PTR(-EINVAL);
> +	return IOMEM_ERR_PTR(-EINVAL);
>  }
>  
>  static inline
>  void __iomem *devm_ioremap_resource_wc(struct device *dev,
>  				       const struct resource *res)
>  {
> -	return ERR_PTR(-EINVAL);
> +	return IOMEM_ERR_PTR(-EINVAL);
>  }
>  
>  static inline
> @@ -393,7 +393,7 @@ void __iomem *devm_of_iomap(struct device *dev,
>  			    struct device_node *node, int index,
>  			    resource_size_t *size)
>  {
> -	return ERR_PTR(-EINVAL);
> +	return IOMEM_ERR_PTR(-EINVAL);
>  }
>  
>  #endif
> -- 
> 2.25.1

As the 0-day bot points out, this breaks the build all over the place,
so I'm going to drop it from my trees.  Please test-build your code with
the targets that it reported having problems with before submitting it
again.

thanks,

greg k-h

