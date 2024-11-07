Return-Path: <linux-kernel+bounces-399331-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49E3B9BFD8A
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 06:16:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B4636B226E2
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 05:16:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 074C619048F;
	Thu,  7 Nov 2024 05:15:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="CyK0nouC"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F83C7F9;
	Thu,  7 Nov 2024 05:15:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730956555; cv=none; b=QR49Rytmx039pq7Q+WeZqV7LYBLfIidArOOsqQxzI4kB/SP7O7cvzMat9RR9IO//6rgsQoPzuHfy0qb+Xx+zSjbjZJ/HZw7Jl/0XqNr7IIvZ2UMkbsoTDqYe7rKvwymrBDOl3PRtEVj/orzvIey9X+b/1/f+d7O4vszDm+V5KWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730956555; c=relaxed/simple;
	bh=IxVIhL/rpDnd03veYvTvQyL8pLGQx85r3ezZTHyJdbs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bE/a77Pth2bPq9yQ5iYI9wb4FOKFJSyKD6/qJ02qsmvcCgYx/5WOcZ28n0Zl+rTMT4MrSv7OlShoqaoF5UaYGr9DEbdPSdzJp+Q68fG3yH2meCfoVa7UmaAbHD+ZFCTm/TU+FTU91/CXr7MFjxPIkNOPBri41GibErh5Y+taRXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=CyK0nouC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F5F3C4CECE;
	Thu,  7 Nov 2024 05:15:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1730956554;
	bh=IxVIhL/rpDnd03veYvTvQyL8pLGQx85r3ezZTHyJdbs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CyK0nouCK2KMOn2KUnvX9jteidX4UjmBP6QQ44Fa/XSSmZDoo1ObHs/T2LmQzEtEo
	 rW1wQbC+nXmCkr7h/WxbT89tQqWoMRM05aHS0AzifTCPrIKGBN5P6aJJQyU0n6KH71
	 EQWiARu1L7YraKmHMgh0WiJpkp5iVsnFIP2919B0=
Date: Thu, 7 Nov 2024 06:15:36 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Karol Przybylski <karprzy7@gmail.com>
Cc: paul@crapouillou.net, tudor.ambarus@linaro.org, Chris.Wulff@biamp.com,
	david.sands@biamp.com, viro@zeniv.linux.org.uk,
	m.grzeschik@pengutronix.de, peter@korsgaard.com,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	skhan@linuxfoundation.org
Subject: Re: [PATCH] usb: gadget: f_fs: remove unused values and add
 immediate returns
Message-ID: <2024110719-kennel-tiptoeing-3409@gregkh>
References: <20241106183032.80155-1-karprzy7@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241106183032.80155-1-karprzy7@gmail.com>

On Wed, Nov 06, 2024 at 07:30:32PM +0100, Karol Przybylski wrote:
> In case of faulty copy_from_user call inside ffs_epfile_ioctl, error code is
> saved in a variable. However, this variable is later overwritten in every possible
> path, which overshadows initial assignment.
> 
> This patch fixes it by returning the error code immediately and exiting the function.
> 
> Error discovered in coverity scan - CID 1583682
> 
> Signed-off-by: Karol Przybylski <karprzy7@gmail.com>
> ---
>  drivers/usb/gadget/function/f_fs.c | 9 +++------
>  1 file changed, 3 insertions(+), 6 deletions(-)

What commit id does this fix?

How was this change tested?

thanks,

greg k-h

