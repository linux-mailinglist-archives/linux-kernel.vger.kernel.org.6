Return-Path: <linux-kernel+bounces-229338-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 93559916E89
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 18:53:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 452781F22AB8
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 16:53:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 486AE176AD6;
	Tue, 25 Jun 2024 16:52:25 +0000 (UTC)
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
	by smtp.subspace.kernel.org (Postfix) with SMTP id A8480158A23
	for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 16:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.131.102.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719334344; cv=none; b=YxfwDrer0NyjwV53b7gSWMAv6pjjYIjhGg0CWIoOVP9tie+15QvPo2RbGNa7DZZ6vbyojkkqHMWUyXjuTCWK2gX/5N277jIoexGYbXeUAbyLDXnChOJMQLwD/CB9P77uBZxA3U7+XqasdLxEp+ns8a7ZCSGp5WHQhV8BeaHgBJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719334344; c=relaxed/simple;
	bh=CSkW4GMifJtkp9xz07k19QprzyRVz89dbqnmMWY9NrI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ejB0r1Mp54KV1EZnAMeybcBNfh0ZPYyNqNxamKytpkZ1+un/LMgNpIYm746Ckg9bH4YNVa+G8myz3uBdv03g+v3zqdI5w+L2bVIx615N+KShU73ArR/ruEa1afL3I+8WQFfEqrHTsxw2ObERhYcfcA+XQs7hcrYfAZH+RTLTv7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=rowland.harvard.edu; spf=pass smtp.mailfrom=netrider.rowland.org; arc=none smtp.client-ip=192.131.102.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=netrider.rowland.org
Received: (qmail 672975 invoked by uid 1000); 25 Jun 2024 12:52:21 -0400
Date: Tue, 25 Jun 2024 12:52:21 -0400
From: Alan Stern <stern@rowland.harvard.edu>
To: Lizhe <sensor1010@163.com>
Cc: gregkh@linuxfoundation.org, hgajjar@de.adit-jv.com,
  stanley_chang@realtek.com, ricardo.canuelo@collabora.com,
  johan+linaro@kernel.org, linux-usb@vger.kernel.org,
  linux-kernel@vger.kernel.org
Subject: Re: [PATCH] USB: hub:no need to obtain usb device
Message-ID: <eeb9dfcf-1c60-493e-ac92-40396d0ce7ee@rowland.harvard.edu>
References: <20240625164607.3367-1-sensor1010@163.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240625164607.3367-1-sensor1010@163.com>

On Tue, Jun 25, 2024 at 09:46:07AM -0700, Lizhe wrote:
> the usb device connected to the port has obtained.
> there is no need to obtain it again.
> 
> Signed-off-by: Lizhe <sensor1010@163.com>
> ---
>  drivers/usb/core/hub.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/core/hub.c b/drivers/usb/core/hub.c
> index 4b93c0bd1d4b..f37b991fa86a 100644
> --- a/drivers/usb/core/hub.c
> +++ b/drivers/usb/core/hub.c
> @@ -5358,7 +5358,7 @@ static void hub_port_connect(struct usb_hub *hub, int port1, u16 portstatus,
>  	if (udev) {
>  		if (hcd->usb_phy && !hdev->parent)
>  			usb_phy_notify_disconnect(hcd->usb_phy, udev->speed);
> -		usb_disconnect(&port_dev->child);
> +		usb_disconnect(&udev);
>  	}

This is wrong.  We need to pass the address of port_dev->child, not the 
address of udev.  This is so that usb_disconnect() can set 
port_dev->child to NULL.  Setting udev to NULL instead won't work right.

Alan Stern

