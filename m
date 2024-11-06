Return-Path: <linux-kernel+bounces-398592-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 91DEE9BF338
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 17:28:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C3C161C22411
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 16:28:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 593A9205E3C;
	Wed,  6 Nov 2024 16:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Da0uDUFw"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B57B41DE2DE;
	Wed,  6 Nov 2024 16:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730910510; cv=none; b=Bt7LWb5nnSvGOb19FLq/Q6PsWaGXNX8ZOAmwqQPmrNo7gBX7NVwlq5oNjWsBnjgT1oxpQRefoItEtiKgQvIw4zjbTHGLCfopGUi4jPDA96Yyf3G4JMwSzCK45DSGMDkLOXM3XCeIuVu3vVGEqYoWgvq8Ya8fo/K6+TZ+qoo9YOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730910510; c=relaxed/simple;
	bh=K93WdYbDgTx/94luKwl0YfI3oWNLt1EyBuNBG3lpW1U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sUwTCv6OQ1Dhtno846Jguor1pPriukNwjtLLln53H62A1W88/zq2oZt4O1y2L0WxidIadZ/LYzqgopQPbElovT0CuVrD4ccqKYreQJ33ud70Pz0GpnUpJWFrtqHbtwxsSezCEOEGbsoLPBAio09NiW8ZtHbj6gbUiM/wHG4vCc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Da0uDUFw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40468C4CEC6;
	Wed,  6 Nov 2024 16:28:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730910510;
	bh=K93WdYbDgTx/94luKwl0YfI3oWNLt1EyBuNBG3lpW1U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Da0uDUFwAyIKo743Wt+np6hNV6B0VEA8f8RJOOQ/3aSzAb8yv74+YM0exF8UbUXoF
	 OWCa/TVtsZ/0ryieZjXw3hq+9SLqrbp0CQtGvhd+NyRtbU65owhQreU/6pbudXy28k
	 NZ6pGurJS1U3DASPF4+KIQBOh1EdUmWdGHm/eQSB/s2zHJb9gPagi11oQRbNfPhcEA
	 uOZQwQ2c34uPr6jTWsg2slNEh39Kre7c55kJgslp7guWeCUJl2KV1m6tHWBBA8ONP7
	 lUn50+ZVZGzZ9fpHNMYcMYmrRKnUKe3g1RjZ2vDmXgK7OUkO+MHBbcrlSxF7vqVfBN
	 FGbgQnp0qhs3Q==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1t8itT-000000008AN-0VKP;
	Wed, 06 Nov 2024 17:28:31 +0100
Date: Wed, 6 Nov 2024 17:28:31 +0100
From: Johan Hovold <johan@kernel.org>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-usb <linux-usb@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	=?utf-8?Q?Micha=C5=82?= Pecio <michal.pecio@gmail.com>
Subject: Re: [PATCH v3] USB: serial: pl2303: account for deficits of clones
Message-ID: <ZyuZL7CGLqe3J_ck@hovoldconsulting.com>
References: <b555ae8e-67a1-4dd3-804c-6db5a82b0625@siemens.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b555ae8e-67a1-4dd3-804c-6db5a82b0625@siemens.com>

On Thu, Sep 12, 2024 at 10:37:39AM +0200, Jan Kiszka wrote:
> From: Jan Kiszka <jan.kiszka@siemens.com>
> 
> There are apparently incomplete clones of the HXD type chip in use.
> Those return -EPIPE on GET_LINE_REQUEST and BREAK_REQUEST. Avoid
> flooding the kernel log with those errors. Detect them during startup
> and then use the line_settings cache instead of GET_LINE_REQUEST. Signal
> missing break support via -ENOTTY.
> 
> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> ---
> 
> Changes in v3:
>  - use quirks field instead of new type (suggested by Michal)

>  #define PL2303_QUIRK_UART_STATE_IDX0		BIT(0)
>  #define PL2303_QUIRK_LEGACY			BIT(1)
>  #define PL2303_QUIRK_ENDPOINT_HACK		BIT(2)
> +#define PL2304_QUIRK_NO_BREAK_GETLINE		BIT(3)

I believe you meant to use a "PL2303" prefix here as well.

> +static bool pl2303_is_hxd_clone(struct usb_serial *serial)
> +{
> +	struct usb_device *udev = serial->dev;
> +	unsigned char *buf;
> +	int ret;
> +
> +	buf = kmalloc(7, GFP_KERNEL);
> +	if (!buf) {
> +		dev_err(&serial->interface->dev,
> +			"could not check for clone type, not enough memory\n");

And there's no need to log out-of-memory errors (e.g. which would
already have been logged by allocator).

> +		return false;
> +	}
> +
> +	ret = usb_control_msg(udev, usb_rcvctrlpipe(udev, 0),
> +			      GET_LINE_REQUEST, GET_LINE_REQUEST_TYPE,
> +			      0, 0, buf, 7, 100);
> +
> +	kfree(buf);
> +
> +	return ret == -EPIPE;
> +}

I fixed up the above when applying. Looks nice and clean otherwise.

Thanks.

Johan

