Return-Path: <linux-kernel+bounces-312974-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D3DBC969E85
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 14:59:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 90862286336
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 12:59:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0918B1CA6A7;
	Tue,  3 Sep 2024 12:59:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="QcRJepMt"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 663E31CA6B3;
	Tue,  3 Sep 2024 12:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725368374; cv=none; b=KxNDr4UhC3Hu6BPnUa5lSpAq0cA6k1Z//Rao0d1C6biDw0PncW6qzTKtSMvUUH/SjHT++RcJt5+IOma3BozBP12u0T5bWd+upXFHuAZuqUcmqt9hD3DEpZnC5oVhEI3SBLNCQG54hH4TCcV5D+oEJZUWHMjrE2b1pF6zMXHFvdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725368374; c=relaxed/simple;
	bh=BAEngeHpyYeVwByip4L+Bpi9Z3pek2v9P47Zvac5BR4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e2SzMwLohSpbG7Aktvlvm4ACBk+1MJD3XYRqusyMoejRsJ+/gVgKC0tRUr0pRTUJB9JtZt0PiyoSzVPnnwdXAhQec79eAboPkWxnW98hGPkHMmpbCl/2b+TBHt2bcDLFhMXGAXRiX3Mt5C7anHkvj5OONtBrVuI8xbtx2wnrRPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=QcRJepMt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78EC9C4CEC4;
	Tue,  3 Sep 2024 12:59:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1725368373;
	bh=BAEngeHpyYeVwByip4L+Bpi9Z3pek2v9P47Zvac5BR4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QcRJepMtKQrKRnONPQ/45L6oAjJgdUuT7hiHKmNR82jx9u+NEDsvxitgKi6sQeryY
	 dGR4rPV3K1b41GzcbaLoZ+m4ROf0TyYn0/4+OvX9nybA3vUOED5SjEZbMdadANGzPk
	 6akYv5wnXWgUB4+FsNG9ft4SBDOBV3sl5quz+/1c=
Date: Tue, 3 Sep 2024 14:59:31 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: tangbin <tangbin@cmss.chinamobile.com>
Cc: neal_liu@aspeedtech.com, joel@jms.id.au, andrew@codeconstruct.com.au,
	linux-aspeed@lists.ozlabs.org, linux-usb@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usb: gadget: aspeed_udc: use the defined variable to
 simplify code
Message-ID: <2024090325-thud-penalty-0283@gregkh>
References: <20240903123152.6980-1-tangbin@cmss.chinamobile.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240903123152.6980-1-tangbin@cmss.chinamobile.com>

On Tue, Sep 03, 2024 at 08:31:52PM +0800, tangbin wrote:
> Use the defined variable 'dev' to make the code cleaner.
> 
> Signed-off-by: tangbin <tangbin@cmss.chinamobile.com>

Please use your full name, not your email alias.

> ---
>  drivers/usb/gadget/udc/aspeed_udc.c | 26 +++++++++++++-------------
>  1 file changed, 13 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/usb/gadget/udc/aspeed_udc.c b/drivers/usb/gadget/udc/aspeed_udc.c
> index f4781e611..702d4806c 100644
> --- a/drivers/usb/gadget/udc/aspeed_udc.c
> +++ b/drivers/usb/gadget/udc/aspeed_udc.c
> @@ -1479,7 +1479,7 @@ static int ast_udc_probe(struct platform_device *pdev)
>  	struct ast_udc_dev *udc;
>  	int rc;
>  
> -	udc = devm_kzalloc(&pdev->dev, sizeof(struct ast_udc_dev), GFP_KERNEL);
> +	udc = devm_kzalloc(dev, sizeof(struct ast_udc_dev), GFP_KERNEL);

<snip>

I see the goal, but unless you have this hardware and can test this
change out, I'm going to leave it as-is as nothing should have been
changed here.

sorry,

greg k-h

