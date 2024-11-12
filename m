Return-Path: <linux-kernel+bounces-406355-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FECE9C605B
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 19:25:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 068F7B80BD8
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 16:55:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 564A521443B;
	Tue, 12 Nov 2024 16:52:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="DWaBYBdl"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93E3E214430
	for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 16:52:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731430362; cv=none; b=nzHylybBtyL1ZFYPFCXnBv+mdOiWd/7gkJEcT9o9/RZDsLXpmBSkxh3KQq4sKIetV/e90pq0mUOWYybJquNcgN0H8cHVV4VB7OZ5DHs7o6q2zTe24xKV4ZoSEPxUeLtuv79V1pGiMkWsK2UmVrKJlBUwcXn/xzSbYQsymLCF2IA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731430362; c=relaxed/simple;
	bh=BOgjbNWMf/8MyFlxZCsL5AFO06LPIZ0RMdldcg8LW0o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=btO77jjUfuH4THiO0mxiZ73meMjVqPuaKEZOnOWefyMjruH/nMc/yYbJouqw5uyo8sWz8tRIBkvuYugyZVO68HaaU8kAoggJCSt4F7DrHyWLrCpkqzjPZmgod3FSHosIMeC4+L4gaoaQcWzBFBlpIHxhLJDLGlQRNka9dtQrgE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=DWaBYBdl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42477C4CED0;
	Tue, 12 Nov 2024 16:52:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1731430360;
	bh=BOgjbNWMf/8MyFlxZCsL5AFO06LPIZ0RMdldcg8LW0o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DWaBYBdl5xxo1nZIzPWO+zXr5PLe/bLg7yY6xKGR5W6O4F1F4yoRcLo0KluPtnAm/
	 fJ23Zy78ajLx+dZBqF8iz0LRFbdvoYy9P+/3tzY7XzaUaRq3GwSTb34bHBsU0NJOS6
	 HvKT/qiZcvbocebVqznbKNOugMoOCcVJ+LxOIB2c=
Date: Tue, 12 Nov 2024 17:52:37 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Qiu-ji Chen <chenqiuji666@gmail.com>
Cc: rafael@kernel.org, linux-kernel@vger.kernel.org, baijiaju1990@gmail.com
Subject: Re: [PATCH] driver core: Fix concurrency issue in match driver
 interface.
Message-ID: <2024111214-casing-gong-5c78@gregkh>
References: <20241112163041.40083-1-chenqiuji666@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241112163041.40083-1-chenqiuji666@gmail.com>

On Wed, Nov 13, 2024 at 12:30:41AM +0800, Qiu-ji Chen wrote:
> This patch identifies a deeper issue.

I don't understand this sentence, sorry.

> Taking the function
> fsl_mc_bus_match() as an example, since the function is not protected by a
> lock, there is a data race between fsl_mc_bus_match() and
> driver_override_store(). After the check if (mc_dev->driver_override), the
> driver_override field may be set to NULL, but the strcmp() function does
> not perform a NULL pointer check. If a NULL driver_override field is passed
> into strcmp(), it may lead to a null pointer dereference issue. We also
> noticed that in the driver_override_store() function, the function
> driver_set_override() is called, and this function frees the old value
> after storing the new dev value. If a race occurs, a use-after-free (UAF)
> issue could occur in fsl_mc_bus_match().

So shouldn't that be fixed there in the fsl bus code?

> To fix this issue, we examined the interface that calls this function and
> found that fsl_mc_bus_match() is called by the interface drv->bus->match,
> which in turn is called by the function driver_match_device(). We found
> three places where driver_match_device() is called, and the call in
> __driver_attach() is locked. However, since the driver_override_store()
> function is implemented in drivers such as amba, base, cdx, and others,
> this data race issue is quite common. Adding a lock at the lower level
> could conflict with the lock in __driver_attach(), leading to a potential
> deadlock. Therefore, we decided to add locking to the other two calls to
> driver_match_device() to ensure that when the function is called through
> the match interface, dev is protected by a lock throughout the process, and
> its value remains unchanged.

The device is protected from going away, but that doesn't affect the
override string from going away, right?


> 
> Fixes: 49b420a13ff9 ("driver core: check bus->match without holding device lock")
> Signed-off-by: Qiu-ji Chen <chenqiuji666@gmail.com>
> ---
> In 2008, the kernel moved all match checks outside of the lock, and at that
> time, there was no override, so this approach worked. In 2015, one function
> moved the match check into the lock on one of its paths in order to support
> asynchronous device binding, which led to inconsistent behavior. Later,
> some kernel drivers added the driver_override feature to support binding
> specific drivers, and the driver_set_override function was widely used to
> control it. This function uses device_lock to control concurrency. This
> issue is caused by both lower-level drivers and upper-level drivers, so
> I'm not sure if the fixes tag is correct, and I haven't added a cc. I hope
> to discuss this issue with the developers.
> ---
>  drivers/base/bus.c | 16 +++++++++++-----
>  drivers/base/dd.c  |  2 ++
>  2 files changed, 13 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/base/bus.c b/drivers/base/bus.c
> index 657c93c38b0d..78d8c58fc50c 100644
> --- a/drivers/base/bus.c
> +++ b/drivers/base/bus.c
> @@ -261,13 +261,19 @@ static ssize_t bind_store(struct device_driver *drv, const char *buf,
>  	const struct bus_type *bus = bus_get(drv->bus);
>  	struct device *dev;
>  	int err = -ENODEV;
> +	int ret;
>  
>  	dev = bus_find_device_by_name(bus, NULL, buf);
> -	if (dev && driver_match_device(drv, dev)) {
> -		err = device_driver_attach(drv, dev);
> -		if (!err) {
> -			/* success */
> -			err = count;
> +	if (dev) {
> +		device_lock(dev);
> +		ret = driver_match_device(drv, dev);
> +		device_unlock(dev);

Have you tested to make sure this works properly with lockdep enabled?
The driver/device locking is tricky, and adding a lock here feels wrong
as this has to do with manual binding, not the override string.
Shouldn't the string checking perhaps be made more safe by making it a
driver core function instead?

thanks,

greg k-h

