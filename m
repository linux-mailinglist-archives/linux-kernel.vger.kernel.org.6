Return-Path: <linux-kernel+bounces-406162-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D13599C5B9C
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 16:15:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 887FA1F2334E
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 15:15:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E18E32003CA;
	Tue, 12 Nov 2024 15:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="yRPrsOW+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45D451FF056;
	Tue, 12 Nov 2024 15:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731424461; cv=none; b=JhL4zMVr/CyBAowL8IsSNo+eptLEveAPThPN4dLei/gA3RiJuuPJbR9M0+pU6LJRpAM2FWZHrlb5n0bgJIkwwbPbZRqRPQVN8xP6IxR4WkYpOLy+dYvJsN9B5gVPqeAaCHuDhuoRS7qnt2GwNlwSFgeAsV553dufziVFQ2cvGp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731424461; c=relaxed/simple;
	bh=BOt1n5cNm6RK271T1p/QXRcLB6NfdzPBBt9542rWDio=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oJV3xjCjeVtMmKjLwo/cSWq9jbyVzQpqdCXvK/5KO/+dyXZfjmfKwy5jDPFm2FAw3jCHH3/wjxJJONLdPZ2G1fWe7irfy7gxNWqXx5nKo5qoZ8cpXh82gwf2CWlExYAFlKOOcUzpyeNqUM9gq86PrBmjUrLLFDUtBt7JXpMK3JM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=yRPrsOW+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B31FC4CED5;
	Tue, 12 Nov 2024 15:14:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1731424460;
	bh=BOt1n5cNm6RK271T1p/QXRcLB6NfdzPBBt9542rWDio=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=yRPrsOW+s8DkCgtkwh0SepWEkAvGYzR3m+gROrG44hIJo13pj3EGK1XKL4vs5XULg
	 ReGEGIruZVP7OkDQIl1QwHbBtHbAXDIIjrjZ3/KJ4SIdAqaz3lpskSjwilTxc/OlZH
	 MTTAhLUFv0pPsa+KyWbkQwyQpHtLRQ5aGYTONIjw=
Date: Tue, 12 Nov 2024 16:14:17 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Sabyrzhan Tasbolatov <snovitoll@gmail.com>
Cc: linux-usb@vger.kernel.org, andreyknvl@gmail.com,
	stern@rowland.harvard.edu, b-liu@ti.com, johan@kernel.org,
	oneukum@suse.com, linux-kernel@vger.kernel.org,
	usb-storage@lists.one-eyed-alien.net
Subject: Re: [PATCH] drivers/usb: refactor min(), max() with min_t(), max_t()
Message-ID: <2024111251-spill-hatchback-72da@gregkh>
References: <20241112150437.3508388-1-snovitoll@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241112150437.3508388-1-snovitoll@gmail.com>

On Tue, Nov 12, 2024 at 08:04:37PM +0500, Sabyrzhan Tasbolatov wrote:
> Scanned the current drivers/usb code with `max\(.*\(` and `min\(.*\(`
> regexp queries to find casting inside of min() and max() which
> may lead to subtle bugs or even security vulnerabilities,
> especially if negative values are involved.
> 
> Let's refactor to min_t() and max_t() specifying the data type
> to ensure it's applicable for the both compareable arguments.
> It should address potential type promotion issues and improves type safety.
> 
> Signed-off-by: Sabyrzhan Tasbolatov <snovitoll@gmail.com>
> ---
>  drivers/usb/core/config.c                    |  2 +-
>  drivers/usb/gadget/composite.c               | 12 ++++++------
>  drivers/usb/gadget/configfs.c                |  2 +-
>  drivers/usb/gadget/function/f_fs.c           |  6 +++---
>  drivers/usb/gadget/function/f_mass_storage.c |  8 ++++----
>  drivers/usb/gadget/function/uvc_video.c      |  4 ++--
>  drivers/usb/gadget/legacy/raw_gadget.c       |  4 ++--
>  drivers/usb/gadget/udc/omap_udc.c            |  4 ++--
>  drivers/usb/gadget/usbstring.c               |  2 +-
>  drivers/usb/host/ehci-hcd.c                  |  2 +-
>  drivers/usb/host/oxu210hp-hcd.c              |  4 ++--
>  drivers/usb/host/r8a66597-hcd.c              |  2 +-
>  drivers/usb/misc/usbtest.c                   |  3 ++-
>  drivers/usb/mon/mon_bin.c                    |  2 +-
>  drivers/usb/musb/musb_core.c                 |  2 +-
>  drivers/usb/musb/musb_gadget_ep0.c           |  2 +-
>  drivers/usb/musb/musb_host.c                 |  5 ++---
>  drivers/usb/serial/io_edgeport.c             |  2 +-
>  drivers/usb/serial/sierra.c                  |  2 +-
>  drivers/usb/storage/sddr09.c                 |  4 ++--
>  drivers/usb/storage/sddr55.c                 |  8 ++++----
>  21 files changed, 41 insertions(+), 41 deletions(-)

Can you break these up to at least "one per drivers/usb/*" subdirectory
to make it easier to review and apply?

thanks,

greg k-h

