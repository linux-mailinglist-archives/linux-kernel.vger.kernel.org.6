Return-Path: <linux-kernel+bounces-531207-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 085AFA43D80
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 12:26:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C6C87189704E
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 11:25:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03C8A267B75;
	Tue, 25 Feb 2025 11:24:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ktfljMLn"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60DF3266B5E;
	Tue, 25 Feb 2025 11:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740482678; cv=none; b=JckTGdli//hCBaJsq+4QrFnae46l3O1raQBIKraOxrXPUo50hcynkHNDiHqr39QLWjISnDP9Mq1jhLDuC5rnHCC6ZxGb4fXh2hLEkQ7LJ6hr5lmRgHCE6XLp2Jkarrr2A/2/wSRG+edDQXQnV5aCk6NAYunwJd3KstqqNp32OsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740482678; c=relaxed/simple;
	bh=M1WvkfNJ0eZrSf0XE1rECdU/V4VR77kaJon9xnxT7G4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q4IwRmLJdw2rHR3lEDbKSKz+XtKjTCu1mggGXsjCMjkGkFhhwFXouPJqsqtTWp3TyNwHpbuY513wTwReBFHkUg1Rk9Iu0XhYfGsBwcalL8EHYA8nJbThEr9qDYr93IelD8Fa9aB7g5kZZR8DOlOP5uZ+EbW2d+mZZxdseycD01w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ktfljMLn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93B5BC4CEDD;
	Tue, 25 Feb 2025 11:24:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740482677;
	bh=M1WvkfNJ0eZrSf0XE1rECdU/V4VR77kaJon9xnxT7G4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ktfljMLntCvWtURu2w+6ca9SLNjlV71BHVbO3E3vr7yt0VObWQUnA6jiYChVUBLsp
	 B4de/hdUSyedHyU28Or+9UfkLBb/Fn/wn6ef8zSeBTQgvir4CoLvRvTw3zj3dGuTtq
	 M2RP+Rng44Gg7cvZB3DxSCJA3xprFlhVWjb1QlWeKRUwRnpi3BbI8v2P1FN9ZbfuAU
	 2DxV2UauKyIiUkf1huul4xngZTJlKNoFKtLSvWVvBA0N34Fr9vr2rtJWn3zbi3hxhN
	 ZR3RomEpB7HqzO96/OQ1lq9eeHQ+E/K91wkC9bS03/re7/mbsh7PIMLWVHOKDwr2lp
	 oZJoEOokONKcQ==
Date: Tue, 25 Feb 2025 12:24:33 +0100
From: Danilo Krummrich <dakr@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org,
	Kurt Borja <kuurtb@gmail.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH] driver core: faux: only create the device if probe()
 succeeds
Message-ID: <Z72oceZFfJcMAf-D@pollux>
References: <2025022545-unroasted-common-fa0e@gregkh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2025022545-unroasted-common-fa0e@gregkh>

On Tue, Feb 25, 2025 at 07:35:46AM +0100, Greg Kroah-Hartman wrote:
> It's really hard to know if a faux device properly passes the callback
> to probe() without having to poke around in the faux_device structure
> and then clean up.  Instead of having to have every user of the api do
> this logic, just do it in the faux device core itself.
> 
> This makes the use of a custom probe() callback for a faux device much
> simpler overall.
> 
> Suggested-by: Kurt Borja <kuurtb@gmail.com>
> Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> Cc: Danilo Krummrich <dakr@kernel.org>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
>  drivers/base/faux.c |   15 ++++++++++++++-
>  1 file changed, 14 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/base/faux.c b/drivers/base/faux.c
> index 531e9d789ee0..407c1d1aad50 100644
> --- a/drivers/base/faux.c
> +++ b/drivers/base/faux.c
> @@ -102,7 +102,9 @@ static void faux_device_release(struct device *dev)
>   *
>   * Note, when this function is called, the functions specified in struct
>   * faux_ops can be called before the function returns, so be prepared for
> - * everything to be properly initialized before that point in time.
> + * everything to be properly initialized before that point in time.  If the
> + * probe callback (if one is present) does NOT succeed, the creation of the
> + * device will fail and NULL will be returned.
>   *
>   * Return:
>   * * NULL if an error happened with creating the device
> @@ -147,6 +149,17 @@ struct faux_device *faux_device_create_with_groups(const char *name,
>  		return NULL;
>  	}
>  
> +	/*
> +	 * Verify that we did bind the driver to the device (i.e. probe worked),
> +	 * if not, let's fail the creation as trying to guess if probe was
> +	 * successful is almost impossible to determine by the caller.
> +	 */
> +	if (!dev->driver) {

Seems like really_probe() cleans things up properly through
device_unbind_cleanup(), such that dev->driver is guaranteed to be NULL on
failure.

> +		dev_err(dev, "probe did not succeed, tearing down the device\n");
> +		faux_device_destroy(faux_dev);
> +		faux_dev = NULL;

NIT: Maybe return NULL directly (like above) in case a subsequent change adds
more code to the end of this function and does not consider that we fall
through.

Either way,

Reviewed-by: Danilo Krummrich <dakr@kernel.org>

> +	}
> +
>  	return faux_dev;
>  }
>  EXPORT_SYMBOL_GPL(faux_device_create_with_groups);

