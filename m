Return-Path: <linux-kernel+bounces-304704-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 38E219623BC
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 11:40:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E44D01F25B34
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 09:40:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B2401684A8;
	Wed, 28 Aug 2024 09:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="WJzFa9xn"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4118F14A4D4;
	Wed, 28 Aug 2024 09:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724838002; cv=none; b=DvB1vHd5xxvskk1OR5Ra93EbTOqM59rCzOYSdNC7iKTt7OQkqaTUyn+8Smx8vyJ2nQW3Z3eRVEuDovt8OgDMHIfgGYIFmri0Ea2WyD1S7BXExWu8IeZ2y0z+8lF7blzqaoiUKPV4CAPYZHNfINzFjoFWbmX8FkQzJ7c4WVO7QSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724838002; c=relaxed/simple;
	bh=wVpI6nP9acsc3vI1fdzszPmNqRCsAjXJCl/WXTfbGqs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B5YAnEa5UFhOlD2WZH+NdBqsrd5XmRMWMMrmnR5tyXwKFD1uLeMZPwhcrrfxeGtXuhBeXWJtuI18/rOofkS47IU/tJhssvZj8DX+SUExyy84pBVhDXHlxs3qSLb4xHgu9Lo1eG67lqrPmoH7MOz6x04s8xXDx+/trxDIHYA4XzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=WJzFa9xn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 209D0C98EC0;
	Wed, 28 Aug 2024 09:40:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1724838001;
	bh=wVpI6nP9acsc3vI1fdzszPmNqRCsAjXJCl/WXTfbGqs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WJzFa9xnqWkG0rdz2/1ZFsXuJf71hRxVmHugUak6WEgy57RBKV60YNf6CdOrT4VoJ
	 nJfPUFCYzPQJzDDxgHDSDOr6XU/8SLdblNEQGO1LZPA+x94MZ/yfsF7kwpI+ES50AY
	 Vo+BsGDKZ0NvSjFfvlRNeRnQYmLMz7HMJD3JKtJg=
Date: Wed, 28 Aug 2024 11:39:58 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Selvarasu Ganesan <selvarasu.g@samsung.com>
Cc: stern@rowland.harvard.edu, royluo@google.com, paul@crapouillou.net,
	elder@kernel.org, yuanlinyu@hihonor.com, quic_kriskura@quicinc.com,
	crwulff@gmail.com, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org, jh0801.jung@samsung.com,
	dh10.jung@samsung.com, naushad@samsung.com, akash.m5@samsung.com,
	rc93.raju@samsung.com, taehyun.cho@samsung.com,
	hongpooh.kim@samsung.com, eomji.oh@samsung.com,
	shijie.cai@samsung.com, stable <stable@kernel.org>
Subject: Re: [PATCH] usb: gadget: udc: Add null pointer check for udc in
 gadget_match_driver
Message-ID: <2024082801-dissuade-starlight-e5ad@gregkh>
References: <CGME20240828070538epcas5p2ce9b001afd4588139070d01f0fb2ac37@epcas5p2.samsung.com>
 <20240828070507.2047-1-selvarasu.g@samsung.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240828070507.2047-1-selvarasu.g@samsung.com>

On Wed, Aug 28, 2024 at 12:35:04PM +0530, Selvarasu Ganesan wrote:
> This commit adds a null pointer check for udc in gadget_match_driver to
> prevent the below potential dangling pointer access. The issue arises
> due to continuous USB role switch and simultaneous UDC write operations
> performed by init.rc from user space through configfs.  In these
> scenarios, there was a possibility of usb_udc_release being done before
> gadget_match_driver.
> 
> [27635.233849]  BUG: KASAN: invalid-access in gadget_match_driver+0x40/0x94
> [27635.233871]  Read of size 8 at addr d7ffff8837ead080 by task init/1
> [27635.233881]  Pointer tag: [d7], memory tag: [fe]
> [27635.233888]
> [27635.233917]  Call trace:
> [27635.233923]   dump_backtrace+0xec/0x10c
> [27635.233935]   show_stack+0x18/0x24
> [27635.233944]   dump_stack_lvl+0x50/0x6c
> [27635.233958]   print_report+0x150/0x6b4
> [27635.233977]   kasan_report+0xe8/0x148
> [27635.233985]   __hwasan_load8_noabort+0x88/0x98
> [27635.233995]   gadget_match_driver+0x40/0x94
> [27635.234005]   __driver_attach+0x60/0x304
> [27635.234018]   bus_for_each_dev+0x154/0x1b4
> [27635.234027]   driver_attach+0x34/0x48
> [27635.234036]   bus_add_driver+0x1ec/0x310
> [27635.234045]   driver_register+0xc8/0x1b4
> [27635.234055]   usb_gadget_register_driver_owner+0x7c/0x140
> [27635.234066]   gadget_dev_desc_UDC_store+0x148/0x19c
> [27635.234075]   configfs_write_iter+0x180/0x1e0
> [27635.234087]   vfs_write+0x298/0x3e4
> [27635.234105]   ksys_write+0x88/0x100
> [27635.234115]   __arm64_sys_write+0x44/0x5c
> [27635.234126]   invoke_syscall+0x6c/0x17c
> [27635.234143]   el0_svc_common+0xf8/0x138
> [27635.234154]   do_el0_svc+0x30/0x40
> [27635.234164]   el0_svc+0x38/0x68
> [27635.234174]   el0t_64_sync_handler+0x68/0xbc
> [27635.234184]   el0t_64_sync+0x19c/0x1a0
> 
> Fixes: fc274c1e9973 ("USB: gadget: Add a new bus for gadgets")
> Cc: stable <stable@kernel.org>
> Signed-off-by: Selvarasu Ganesan <selvarasu.g@samsung.com>
> ---
>  drivers/usb/gadget/udc/core.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/gadget/udc/core.c b/drivers/usb/gadget/udc/core.c
> index cf6478f97f4a..77dc0f28ff01 100644
> --- a/drivers/usb/gadget/udc/core.c
> +++ b/drivers/usb/gadget/udc/core.c
> @@ -1338,6 +1338,7 @@ static void usb_udc_release(struct device *dev)
>  	udc = container_of(dev, struct usb_udc, dev);
>  	dev_dbg(dev, "releasing '%s'\n", dev_name(dev));
>  	kfree(udc);
> +	udc = NULL;

That's not ok, as what happens if you race right between freeing it and
accessing it elsewhere?

>  }
>  
>  static const struct attribute_group *usb_udc_attr_groups[];
> @@ -1574,7 +1575,7 @@ static int gadget_match_driver(struct device *dev, const struct device_driver *d
>  			struct usb_gadget_driver, driver);
>  
>  	/* If the driver specifies a udc_name, it must match the UDC's name */
> -	if (driver->udc_name &&
> +	if (driver->udc_name && udc &&

I agree this isn't good, but you just made the window smaller, please
fix this properly.

thanks,

greg k-h

