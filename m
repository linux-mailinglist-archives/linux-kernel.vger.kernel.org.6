Return-Path: <linux-kernel+bounces-223116-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D53C910DF9
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 19:04:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5E71F1C23173
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 17:04:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C6071B3F06;
	Thu, 20 Jun 2024 17:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ravnborg.org header.i=@ravnborg.org header.b="DvXoN3df";
	dkim=permerror (0-bit key) header.d=ravnborg.org header.i=@ravnborg.org header.b="kBoXqgO+"
Received: from mailrelay5-1.pub.mailoutpod3-cph3.one.com (mailrelay5-1.pub.mailoutpod3-cph3.one.com [46.30.211.244])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8208F1AF6A1
	for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2024 17:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.30.211.244
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718903029; cv=none; b=ND2gludMxtCbESsnm4a5JTHzZxv7hM+6kJ6TB9EG/6Z9eevTBRhcBBcL1mdoIUo7qF1tvAJA8ujbrjh7bNLZ75ac8BXY6vCsp1f45lWzrf/pypq39EaQIlotvhbfekpNv/bjrTCXW5GGwiTsUruxg45Lt5+vw7OAvDoIzppgwqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718903029; c=relaxed/simple;
	bh=dadg287lbGaPmJWraIaxZO2tVVWj8bfl9hnAPeOZPZ0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XsE3gZDA8fCbsePJEbqrZlBv0U+lfx8+/Yp5EGyHjZ0Xbwxemq0TjwJt1DYD5QEfiEP9mJI1wGIbQm4p9lRnGfxbEfFBZB2E2EhzfPFDEwYwsWk+/wvs26ADgNUkVwNq8z92J9jshtj2SblsSzMw0YaMxfyObNfRqpSjdEkAmmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ravnborg.org; spf=none smtp.mailfrom=ravnborg.org; dkim=pass (2048-bit key) header.d=ravnborg.org header.i=@ravnborg.org header.b=DvXoN3df; dkim=permerror (0-bit key) header.d=ravnborg.org header.i=@ravnborg.org header.b=kBoXqgO+; arc=none smtp.client-ip=46.30.211.244
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ravnborg.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ravnborg.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=ravnborg.org; s=rsa1;
	h=in-reply-to:content-type:mime-version:references:message-id:subject:cc:to:
	 from:date:from;
	bh=yODHSliSOdGvA36YUaNQLn6aeqU+d5cX1WV7EBvEMn0=;
	b=DvXoN3dfA1Q4PpiiQ5J2PL6TL4TX2iC/Lga8K4MuQdXfR7EpesohBdET5luJpKAQ2xtpnyFotvVv9
	 P0FU+s57as3ta7D05P1nxkaP+4+NmvJ0hyxHciDHnkyiKGevdUheqFoP2UWuDe2zCaQnCIbz6TJ96/
	 rCJc2xeiWZ//NAXoWHYxWYiTwRl2KENsPC51ZJil0ldHYPrs2f7AltkZIpl0Ls8eLgR1kw2yD1NQV8
	 nL9D4u46O9c5OBXKTk4NZozucixTJfmbN7TxaUQSbpiFwZWJ6KxO2TOCKszxAZp8tDHr+NQugYw7wj
	 U08kZKESyI1T/6L5+44yvxmmw5KzZ7g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed;
	d=ravnborg.org; s=ed1;
	h=in-reply-to:content-type:mime-version:references:message-id:subject:cc:to:
	 from:date:from;
	bh=yODHSliSOdGvA36YUaNQLn6aeqU+d5cX1WV7EBvEMn0=;
	b=kBoXqgO+DJM2gDv+5KYqjxCK+4GTkIY8bkN8a+y+PWgLxzqqK1xBmvPmk0mSxdpx1Lv/AcfGAFLRx
	 1N+Rh0ZDQ==
X-HalOne-ID: e22047f2-2f26-11ef-bd94-e973630cf47d
Received: from ravnborg.org (2-105-16-150-cable.dk.customer.tdc.net [2.105.16.150])
	by mailrelay5.pub.mailoutpod3-cph3.one.com (Halon) with ESMTPSA
	id e22047f2-2f26-11ef-bd94-e973630cf47d;
	Thu, 20 Jun 2024 17:02:34 +0000 (UTC)
Date: Thu, 20 Jun 2024 19:02:33 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Manikandan Muralidharan <manikandan.m@microchip.com>
Cc: linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
	Hari.PrasathGE@microchip.com, Dharma.B@microchip.com,
	bbrezillon@kernel.org, nicolas.ferre@microchip.com
Subject: Re: [PATCH] MAINTAINERS: update Microchip's Atmel-HLCDC driver
 maintainers
Message-ID: <20240620170233.GA1091389@ravnborg.org>
References: <20240620095856.777390-1-manikandan.m@microchip.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240620095856.777390-1-manikandan.m@microchip.com>

Hi Manikandan and Dharma.

On Thu, Jun 20, 2024 at 03:28:56PM +0530, Manikandan Muralidharan wrote:
> Drop Sam Ravnborg and Boris Brezillon as they are no longer interested in
> maintaining the drivers. Add myself and Dharma Balasubiramani as the
> Maintainer and co-maintainer for Microchip's Atmel-HLCDC driver.
> Thanks for their work.

Glad you are picking up the ball, good luck and happy hacking!
Acked-by: Sam Ravnborg <sam@ravnborg.org>

Unless you beat me to it I will get the patch applied in a few days.

	Sam


> 
> Signed-off-by: Manikandan Muralidharan <manikandan.m@microchip.com>
> ---
>  MAINTAINERS | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index d1566c647a50..8f2a40285544 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -7290,8 +7290,8 @@ F:	drivers/gpu/drm/ci/xfails/meson*
>  F:	drivers/gpu/drm/meson/
>  
>  DRM DRIVERS FOR ATMEL HLCDC
> -M:	Sam Ravnborg <sam@ravnborg.org>
> -M:	Boris Brezillon <bbrezillon@kernel.org>
> +M:	Manikandan Muralidharan <manikandan.m@microchip.com>
> +M:	Dharma Balasubiramani <dharma.b@microchip.com>
>  L:	dri-devel@lists.freedesktop.org
>  S:	Supported
>  T:	git https://gitlab.freedesktop.org/drm/misc/kernel.git
> -- 
> 2.25.1

