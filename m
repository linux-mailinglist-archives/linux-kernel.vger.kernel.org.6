Return-Path: <linux-kernel+bounces-240879-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD0AF92741E
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 12:34:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 337FCB21B57
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 10:34:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A17C1AB8F6;
	Thu,  4 Jul 2024 10:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="G3aEjWzo"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC9BC1D696
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jul 2024 10:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720089243; cv=none; b=LOHiPPfoWKt06FdmXtMD+G8nltipPtR76Kwk9Xcwvv08QkB7Dvsz7wJ2hW4i9jnrApWV+Zmj9ho88rIhvi+0vbYwCjrokLW8852vq4v62Oqs3d7Ub2YBU5wcfD1b32X3a7EtBni6ZGp6xChOH/yAv7c178XOesfEk5U5AaSz0Jg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720089243; c=relaxed/simple;
	bh=tlgHeTEGnTaebG72Wd/ZLhfV63R2WMjcBVQpf2YanPw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UKivfWJGSSYstj3MeDgaa1coaI8UiRKqdlLdiSMOFlBQJRJUiualc4D/28z2FDByGuafbdiITebX7lAW8DSJJn1j/nSv5QZvMAqG0pg6b+IvJ86IWqXwQfgwQNwF6xJwlY4CKjpYEJhWIINarMogmtGb5k+ix3vZRvmSDrxCvwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=G3aEjWzo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3462C3277B;
	Thu,  4 Jul 2024 10:34:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1720089243;
	bh=tlgHeTEGnTaebG72Wd/ZLhfV63R2WMjcBVQpf2YanPw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=G3aEjWzoQ3glkG8qYRolUb4zMA10DTnSGfGMlLOD9ywnSrXQhf/A+A3cjZTGXNxjJ
	 G5iqgvONSyVJt5TXrBHbULsVPlA9olyCAN8aEXIlr+hKE8oy+U5KlVqeJrux9i2YiQ
	 S/1XpMKgQY9VlC7tvoGRPoKKiIWaEnCiwL5CjkPo=
Date: Thu, 4 Jul 2024 12:34:00 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Zijun Hu <quic_zijuhu@quicinc.com>
Cc: linux-kernel@vger.kernel.org, rafael@kernel.org, brgl@bgdev.pl,
	madalin.bucur@nxp.com, davem@davemloft.net,
	andriy.shevchenko@linux.intel.com
Subject: Re: [PATCH v1 4/5] devres: Simplify devm_percpu_match()
 implementation
Message-ID: <2024070424-deplete-dangling-bcc6@gregkh>
References: <1719931914-19035-1-git-send-email-quic_zijuhu@quicinc.com>
 <1719931914-19035-5-git-send-email-quic_zijuhu@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1719931914-19035-5-git-send-email-quic_zijuhu@quicinc.com>

On Tue, Jul 02, 2024 at 10:51:53PM +0800, Zijun Hu wrote:
> Simplify devm_percpu_match() implementation by removing redundant
> conversions.
> 
> Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
> ---
> Previous discussion link:
> https://lore.kernel.org/lkml/1719496036-24642-1-git-send-email-quic_zijuhu@quicinc.com/
> 
> Changes since the original one:
>  - Select the simplier solution
> 
>  drivers/base/devres.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/base/devres.c b/drivers/base/devres.c
> index e9b0d94aeabd..2ad6dacb3472 100644
> --- a/drivers/base/devres.c
> +++ b/drivers/base/devres.c
> @@ -1176,9 +1176,8 @@ static void devm_percpu_release(struct device *dev, void *pdata)
>  
>  static int devm_percpu_match(struct device *dev, void *data, void *p)
>  {
> -	struct devres *devr = container_of(data, struct devres, data);
> -
> -	return *(void **)devr->data == p;
> +	/* @data is already and must be (void *)devr->data */
> +	return *(void **)data == p;

The compiler output should be identical here, right?  And container_of()
enforces the placement so I'd prefer the original here as a comment
isn't going to enforce anything :)

thanks,

greg k-h

