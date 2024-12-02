Return-Path: <linux-kernel+bounces-426976-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 640729DFACA
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 07:38:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E4363B21452
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 06:38:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 997801F8F15;
	Mon,  2 Dec 2024 06:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="zIWtysUB"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E795E33F6;
	Mon,  2 Dec 2024 06:38:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733121495; cv=none; b=YeZ6AGsVf73rofpUTZvmE7q35HWOAr0uSmTinivnSEiDu0q/n38mPsO53wE6m4jccokkL8dbaEtWSu+MKADDbxghmV+EM+t3jV0U4CMXoqmOguxhpf5u5qmqQAIC0fglFPkRyBqRlRr0xS09UU8dpfsNHuOZNqS/gOKaVJj0mE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733121495; c=relaxed/simple;
	bh=hjFPsnjl1TckYY8nwQkI7+uOHoyQgZX9O6/y3kU0jWA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MMpW+HH+VUAjG5t3MXBE7a0GyiMoHPruCqBne2Pd6r10bmoM+2c9o8Zggvq87b+4tqP0j1gl3nFRDkWhsROuZhhDvZam1PlGhFOeIldpQpxFdhZ1q75cJSxT+JRUAI1O+1A0wFKsEVHOB+lr/MHvUELxjC0XBcbocuSW0O/TVy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=zIWtysUB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF249C4CED2;
	Mon,  2 Dec 2024 06:38:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1733121494;
	bh=hjFPsnjl1TckYY8nwQkI7+uOHoyQgZX9O6/y3kU0jWA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=zIWtysUBHgDaA3yE+fJxOQXNLU3uZ1o8fOMjIY0owZ0JWLXHfDBZgSfyAbnIP99v+
	 snPDR4LUh8DDEb2h0ql2hawmBHVfU4h2PrAGcgw3nqfR5pi50ywCivq4lIkNoRgwfg
	 paKMwbLXUZPeviZ7sl5w8+NdXrRDOdNrBbViuh9A=
Date: Mon, 2 Dec 2024 07:38:11 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: xiehongyu1@kylinos.cn
Cc: mathias.nyman@intel.com, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usb: xhci: Add module param for compliance quirk checking
Message-ID: <2024120205-collected-trapezoid-9dde@gregkh>
References: <20241202031855.1319821-1-xiehongyu1@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241202031855.1319821-1-xiehongyu1@kylinos.cn>

On Mon, Dec 02, 2024 at 11:18:55AM +0800, xiehongyu1@kylinos.cn wrote:
> From: Hongyu Xie <xiehongyu1@kylinos.cn>
> 
> In the old way, vendor name and product name need to be put in
> xhci_compliance_mode_recovery_timer_quirk_check, it's not convenient.
> 
> So add two module param for convenience.

Please no.  Module parameters are from the 1990's, they do not scale or
work well anymore, please never add them.

> 
> usage: put xhci-hcd.compliance_vendor=[vendor name]
> xhci-hcd.compliance_product=[product name] in cmdline.
> 
> In Ubuntu you can use "dmidecode -t system" to get vendor name and
> product name.
> 
> Signed-off-by: Hongyu Xie <xiehongyu1@kylinos.cn>
> ---
>  drivers/usb/host/xhci.c | 18 ++++++++++++++++--
>  1 file changed, 16 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/usb/host/xhci.c b/drivers/usb/host/xhci.c
> index 5ebde8cae4fc..2007c27bfaf4 100644
> --- a/drivers/usb/host/xhci.c
> +++ b/drivers/usb/host/xhci.c
> @@ -39,6 +39,14 @@ static unsigned long long quirks;
>  module_param(quirks, ullong, S_IRUGO);
>  MODULE_PARM_DESC(quirks, "Bit flags for quirks to be enabled as default");
>  
> +static char *compliance_product;
> +module_param(compliance_product, charp, 0644);
> +MODULE_PARM_DESC(compliance_product, "Product name for compliance comparison");
> +
> +static char *compliance_vendor;
> +module_param(compliance_vendor, charp, 0644);
> +MODULE_PARM_DESC(compliance_vendor, "Vendor name for compliance comparison");

Also, you have provided no documentation as to why these are needed at
all, so that's not going to work :(

thanks,

greg k-h

