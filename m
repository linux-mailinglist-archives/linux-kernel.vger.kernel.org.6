Return-Path: <linux-kernel+bounces-285861-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 974CB951385
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 06:36:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 55AA92842E7
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 04:36:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 403564D8AF;
	Wed, 14 Aug 2024 04:36:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="cigw0PIc"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 810982E3F2;
	Wed, 14 Aug 2024 04:36:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723610195; cv=none; b=l19Km4B29ceYh5vtQvFrr1jzkMGEtMms5zzyYHzm/Blh5PUp7gyNoCf/eaGnCPRoKzR4M5iC1sehevqtMNWl7piMri4OI5ys3isChFADVFQ69vMgat4cfykmHfsataBfi6C8hGCOXC7FFNG86oS0vpK3yJiJB+EnRhPpQaec5i0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723610195; c=relaxed/simple;
	bh=1gKLiJmVORYFYmmR7EKzpQkI4jIayRlrTKeTlqdFdag=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uDuZX2N3RBDHKQiWmm+APzaSHHuZkjqP8U6Q9uWiXe5PcDLOL9WeDrKs1OiiBbCwYHS18ih5talUcmqE+dpo327Uy2KOA5+5C1i0nHFKsJ7RM0XgvD481hR/LtDLuPbCUZkqRp+6aM2I+6FwTdtocN76ZQe8+CrbDmZSZLQjbO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=cigw0PIc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FD38C32786;
	Wed, 14 Aug 2024 04:36:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1723610195;
	bh=1gKLiJmVORYFYmmR7EKzpQkI4jIayRlrTKeTlqdFdag=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cigw0PIcvfNl35Edj1+691X3rWTWKiAfYWQe637X86xb6wnVOqr/6lhh5dYShSMHj
	 pEdO786Z3RnFS+QsjD8Ov+gRSfc2FKNN+Wa/ZdnNyEfO3N2MklhVDjSiH5elZ2rKnx
	 OLci+v+aEdN9RQMluAYYwNLzCy8YeBqFUrjnWgjk=
Date: Wed, 14 Aug 2024 06:36:32 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Liao Chen <liaochen4@huawei.com>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	justin.chen@broadcom.com, alcooperx@gmail.com,
	bcm-kernel-feedback-list@broadcom.com
Subject: Re: [PATCH -next] usb: bdc: fix module autoloading
Message-ID: <2024081423-trapdoor-alabaster-24a7@gregkh>
References: <20240814030443.3876203-1-liaochen4@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240814030443.3876203-1-liaochen4@huawei.com>

On Wed, Aug 14, 2024 at 03:04:43AM +0000, Liao Chen wrote:
> Add MODULE_DEVICE_TABLE(), so modules could be properly autoloaded
> based on the alias from of_device_id table.
> 
> Signed-off-by: Liao Chen <liaochen4@huawei.com>
> ---
>  drivers/usb/gadget/udc/bdc/bdc_core.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/usb/gadget/udc/bdc/bdc_core.c b/drivers/usb/gadget/udc/bdc/bdc_core.c
> index 35a652807fca..5149e2b7f050 100644
> --- a/drivers/usb/gadget/udc/bdc/bdc_core.c
> +++ b/drivers/usb/gadget/udc/bdc/bdc_core.c
> @@ -639,6 +639,7 @@ static const struct of_device_id bdc_of_match[] = {
>  	{ .compatible = "brcm,bdc" },
>  	{ /* sentinel */ }
>  };
> +MODULE_DEVICE_TABLE(of, bdc_of_match);
>  
>  static struct platform_driver bdc_driver = {
>  	.driver		= {
> -- 
> 2.34.1
> 
> 

What commit id does this fix?

