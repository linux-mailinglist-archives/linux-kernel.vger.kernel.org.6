Return-Path: <linux-kernel+bounces-229436-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 34C55916F95
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 19:50:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DE2E01F22DAA
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 17:50:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0709D176FDB;
	Tue, 25 Jun 2024 17:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="PHev+RdD"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42C574437A;
	Tue, 25 Jun 2024 17:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719337843; cv=none; b=aCaTZc/QOvMHVtyfETMXDmEvQfcj8/E9z4QltyUaNaqGhJ/KYaSSZe8Uh7NSVbAaljH316rnqEjhxzrVh3G++WARumzM+srjr+ZOSqHE6MxpLQ3NUS8DRoS2Ljov6/eTwuDPFnD9UO212ov15eAm+fKG0quYCYyzKSsIhLZ/RfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719337843; c=relaxed/simple;
	bh=nKGtI5DQAQbPa7PCl4AKkwhGC8y1ysgMGXwp2yijK6A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ds6QckiEyqBT1VzC47DY/E4tPQtfXiv7GdEKfZYScbYLgxj4HUAvRgmlZQZjoijms89AvjWpVDlRBtLyxjrNGKsaf6D9E3/lbMimx0LCW8JnkqoiN2VRIJ12ue1ZpjJBC7NJQ4JAgJ+472zXMqO8Nl6g2/vF2Is7VkrF6SGqsXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=PHev+RdD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE7FAC32781;
	Tue, 25 Jun 2024 17:50:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1719337843;
	bh=nKGtI5DQAQbPa7PCl4AKkwhGC8y1ysgMGXwp2yijK6A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PHev+RdD5y9FD5ePcNmPMUlFhH4xKI8lpOzBLbm2gA73CtrfC6Vzc9Wnzwe6N+JP7
	 QtfzqjK3HnX0l6YONdoILBiYCY/MisWejYm1mpH3QbwunWHiJhr1yC99OxX3LPLBM/
	 BZtkVXvFqh8wNYlcA2rz0TiA1gVnXxYYqkncRRcw=
Date: Tue, 25 Jun 2024 19:50:47 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Lizhe <sensor1010@163.com>
Cc: stern@rowland.harvard.edu, hgajjar@de.adit-jv.com,
	stanley_chang@realtek.com, ricardo.canuelo@collabora.com,
	johan+linaro@kernel.org, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] USB: hub:no need to obtain usb device
Message-ID: <2024062539-follow-drank-66b4@gregkh>
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

How was this tested?

