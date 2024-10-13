Return-Path: <linux-kernel+bounces-362849-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D0A5B99B9ED
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Oct 2024 17:16:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8836A1F21A1B
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Oct 2024 15:16:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE922145B22;
	Sun, 13 Oct 2024 15:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="XsQxax/W"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BB311E4BE
	for <linux-kernel@vger.kernel.org>; Sun, 13 Oct 2024 15:16:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728832573; cv=none; b=DXmHfAWPdkafRX4SmsByUoTf4sc4CuAApvgPSdjVrh8z9SaQVA4p3YpRnlkf4Xd+f+uDLsoZATjowzU+6YSykzBVCNh8WrC+7LRu22Z54zk5zjJoEHBwY8YVXw+524MDJ/lt1plQD2r6w/gGzQMTnUV00O0fAxAhlc3z5TvVFKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728832573; c=relaxed/simple;
	bh=LwNQhxVUo6C1sCl1q1TNCHwrJYruJN7+sWF3cLpi/P8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Dt6UGglCrpHXqbNC1iHDKq4/P/oNlAIDqYW1fOx1+Hvhm4fN5lRJWLA2Wszh299bDd46orUHvGL9r9Hpa468QnPn3mHrIW15THMattFkpL7m4SixINIpl8/UrWNPeAzpLzrC3UBImXFG7gljmMZsx+rZpSMuIDXbzMsh+4uPyoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=XsQxax/W; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71FAFC4CEC5;
	Sun, 13 Oct 2024 15:16:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1728832572;
	bh=LwNQhxVUo6C1sCl1q1TNCHwrJYruJN7+sWF3cLpi/P8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XsQxax/WtwkAMY0zSV5grYDW51P8Y5eGCxMDu3U0zM2+4AQ6UC4Uj8MI8crk5qH+n
	 aHjVy0AD8hXimTuSZNMUlCSXZXyq5mXzkIVBmNp8VPOwWHspAX2AhkcpciFO7N8pte
	 g2lonbcjvR4l0RHkBUzPbp2FxfoN8qrI9lxRUGAE=
Date: Sun, 13 Oct 2024 17:16:08 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Charles Han <hanchunchao@inspur.com>
Cc: alexandru.ardelean@analog.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] uio: uio_fsl_elbc_gpcm: Add check devm_kasprintf()
 returned value
Message-ID: <2024101339-femur-juniper-3b77@gregkh>
References: <20240929034223.59209-1-hanchunchao@inspur.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240929034223.59209-1-hanchunchao@inspur.com>

On Sun, Sep 29, 2024 at 11:42:23AM +0800, Charles Han wrote:
> devm_kasprintf() can return a NULL pointer on failure but this
> returned value in uio_fsl_elbc_gpcm_probe() is not checked.
> 
> Fixes: d57801c45f53 ("uio: uio_fsl_elbc_gpcm: use device-managed allocators")
> Signed-off-by: Charles Han <hanchunchao@inspur.com>
> ---
>  drivers/uio/uio_fsl_elbc_gpcm.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/uio/uio_fsl_elbc_gpcm.c b/drivers/uio/uio_fsl_elbc_gpcm.c
> index 496caff66e7e..6378e752f828 100644
> --- a/drivers/uio/uio_fsl_elbc_gpcm.c
> +++ b/drivers/uio/uio_fsl_elbc_gpcm.c
> @@ -384,6 +384,9 @@ static int uio_fsl_elbc_gpcm_probe(struct platform_device *pdev)
>  
>  	/* set all UIO data */
>  	info->mem[0].name = devm_kasprintf(&pdev->dev, GFP_KERNEL, "%pOFn", node);
> +	if (!info->mem[0].name)
> +		return -ENOMEM;

This is wrong, please fix your tools that created such a patch as it now
leaks memory :(


