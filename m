Return-Path: <linux-kernel+bounces-245175-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5675492AF4D
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 07:12:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8521A1C215F0
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 05:12:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7769612F5BF;
	Tue,  9 Jul 2024 05:11:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="iYFaE+fd"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79BB6839E4;
	Tue,  9 Jul 2024 05:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720501914; cv=none; b=pljVK14IC47ePbLE+RxeJSSZxdTh21l49TbHKHVTN4bwOS7YaolEHggx9jowVSbViIdR4OTYUESqcvUDGTxw2ezRFWbsKQHpe+b8dv+0hjbALmndbEwgy7vi4zmnok8hwL4wIRHmePiIjTXYZfwmb5M3ojhZOzH3mO85DxJOa0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720501914; c=relaxed/simple;
	bh=7cpn1M8UubDR5oy31LdsuFTSJsPll1C64fA13ivd5kY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uGOM7YM0nwD0z8UdzDr/MaONukX1rudM2Mpcrl7vVx5REY4elng5IjzpnEXNysaYR8OVqR1t8fSD5qZI77Z3zgSJEkYooXkWUHyAHWQ/tIU8lmf4dPFfGOPawvH064VG8PNppHUbp3yA+KVedmYyfCkO4iSOGiS1GbnIbua9+ZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=iYFaE+fd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42A4DC32782;
	Tue,  9 Jul 2024 05:11:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1720501913;
	bh=7cpn1M8UubDR5oy31LdsuFTSJsPll1C64fA13ivd5kY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iYFaE+fdfx3Y8cqJeSB7s0hvcMPY2wLz+74CQSr5Lnh11blVQjuQo9NT/0mQDjK1x
	 AM2ECoymb2bdFehg+TpXybuxj6Bs0g+Kjh7HMOH7AovdFGgXXqokL9teRx1pykzRZw
	 JxHOTzrr90v6rRD/nwYZ39Cb6nKLrJZYv+eXqa8c=
Date: Tue, 9 Jul 2024 07:11:49 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Shivani Gupta <shivani07g@gmail.com>
Cc: laurent.pinchart@ideasonboard.com, mchehab@kernel.org,
	linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
	mathias.nyman@intel.com, linux-usb@vger.kernel.org,
	skhan@linuxfoundation.org, javier.carrasco.cruz@gmail.com
Subject: Re: [PATCH] usb: xhci: Fix compiler warning in xhci.c
Message-ID: <2024070912-tigress-glacier-273d@gregkh>
References: <20240709030604.1347546-1-shivani07g@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240709030604.1347546-1-shivani07g@gmail.com>

On Tue, Jul 09, 2024 at 03:06:04AM +0000, Shivani Gupta wrote:
> Fixes the following compiler warnings by changing the comment syntax
> from "/**" to "/*" in the specified comments:

That's not a normal compiler warning, but rather a documentation builder
warning, right?

> 
> drivers/usb/host/xhci.c:1369: warning: Function parameter or struct member
> 'desc' not described in 'xhci_get_endpoint_index'
> 
> Signed-off-by: Shivani Gupta <shivani07g@gmail.com>
> ---
>  drivers/usb/host/xhci.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/host/xhci.c b/drivers/usb/host/xhci.c
> index 37eb37b0affa..67168661aa52 100644
> --- a/drivers/usb/host/xhci.c
> +++ b/drivers/usb/host/xhci.c
> @@ -1355,7 +1355,7 @@ static void xhci_unmap_urb_for_dma(struct usb_hcd *hcd, struct urb *urb)
>  		usb_hcd_unmap_urb_for_dma(hcd, urb);
>  }
>  
> -/**
> +/*

This feels wrong, why not fix up the kerneldoc instead?

thanks,

greg k-h

