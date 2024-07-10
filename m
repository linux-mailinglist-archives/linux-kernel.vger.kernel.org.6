Return-Path: <linux-kernel+bounces-247681-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DDEA92D2F8
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 15:38:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 072D21F23A90
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 13:38:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53311192B86;
	Wed, 10 Jul 2024 13:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="y7X8EMUg"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98EA612C530
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 13:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720618672; cv=none; b=oLSwUfq/IMzA89M7Wc/sl/7AyAJ/LgK9VjayJ+MY02BwDVZlPXGcFIETy9TX5tHg7Y3CAPkdxBuvueg8GRprUn4R2fOLQp8wajw0d27EdyfoIuDngOwhUPKEx/DL5+nuM2kibzCvgsYd92EQWgoev7SyfQScoYMrNxJszeKvh6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720618672; c=relaxed/simple;
	bh=++gOqx0AOCHPw/QIqgTzJc//pa7fEsdTH3n+2JOdDTg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YZ1elUUE9y4ms4ydnraSwSesicbsWeAy+O5aCLDMuY59/5/N8yiNqXNvhv0Ks+hgYV3bB/Z0sEYMzyia8goNut+g/CzWoUpYnzmk+jc8FJxwhFzBVNvKA8S7WKGlz1SKuApQUps8gyBzq3I/oSNRs3QeEMAjygRUCKi2186D9ck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=y7X8EMUg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC22DC32781;
	Wed, 10 Jul 2024 13:37:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1720618672;
	bh=++gOqx0AOCHPw/QIqgTzJc//pa7fEsdTH3n+2JOdDTg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=y7X8EMUg/89nhrALzuUAgFd7mCazxXozUFEDUeXZwhWMDezVTbSga7NJZp8Sd8z3C
	 PvIZj/hLB0YVvsGYp9SVloyqXCudJUEU507c5XD1oh7CZNI5XIWjfJX5WXI48tkwNv
	 WMji1IYTM+D/CCP5J6I3M/nx3SPCciWeFfNkwL3s=
Date: Wed, 10 Jul 2024 15:37:49 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dio: Have dio_bus_match() callback take a const *
Message-ID: <2024071034-dealer-uncover-0794@gregkh>
References: <20240710074452.2841173-1-geert@linux-m68k.org>
 <2024071031-afterglow-porridge-de26@gregkh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2024071031-afterglow-porridge-de26@gregkh>

On Wed, Jul 10, 2024 at 09:47:47AM +0200, Greg Kroah-Hartman wrote:
> On Wed, Jul 10, 2024 at 09:44:52AM +0200, Geert Uytterhoeven wrote:
> > drivers/dio/dio-driver.c:128:11: error: initialization of ‘int (*)(struct device *, const struct device_driver *)’ from incompatible pointer type ‘int (*)(struct device *, struct device_driver *)’ [-Werror=incompatible-pointer-types]
> >   128 |  .match = dio_bus_match,
> >       |           ^~~~~~~~~~~~~
> > drivers/dio/dio-driver.c:128:11: note: (near initialization for ‘dio_bus_type.match’)
> > 
> > Reported-by: noreply@ellerman.id.au
> > Fixes: d69d804845985c29 ("driver core: have match() callback in struct bus_type take a const *")
> > Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
> > ---
> >  drivers/dio/dio-driver.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/dio/dio-driver.c b/drivers/dio/dio-driver.c
> > index 2d9fa6011945d88b..12fa2d209dab9d3c 100644
> > --- a/drivers/dio/dio-driver.c
> > +++ b/drivers/dio/dio-driver.c
> > @@ -110,10 +110,10 @@ void dio_unregister_driver(struct dio_driver *drv)
> >   *  and 0 if there is no match.
> >   */
> >  
> > -static int dio_bus_match(struct device *dev, struct device_driver *drv)
> > +static int dio_bus_match(struct device *dev, const struct device_driver *drv)
> >  {
> >  	struct dio_dev *d = to_dio_dev(dev);
> > -	struct dio_driver *dio_drv = to_dio_driver(drv);
> > +	const struct dio_driver *dio_drv = to_dio_driver(drv);
> 
> Same here, to_dio_driver() should be changed to use container_of_const()

I've added that to the change when I've merged this to my tree, thanks!

greg k-h

