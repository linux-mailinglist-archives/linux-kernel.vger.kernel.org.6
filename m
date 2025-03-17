Return-Path: <linux-kernel+bounces-563541-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E0518A643CA
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 08:33:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9468C3B2C77
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 07:33:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FBAA21ABCA;
	Mon, 17 Mar 2025 07:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="XHVh/+eD"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6310A1D9A79
	for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 07:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742196829; cv=none; b=P7D0kEk+eRLCrtZIeG7bHQ0d0tYiCyrjgf2TOMP3SkhyR2fjRiHb2fLqbHoi3M49TeLNzFrW3z/EtLWIgim5YIWOb9/lxifqTRWKekEKg9dX7xnsAuRVO2eLJBED056vpDaX9XaKNEY8I+IxporKCgdduEP0dI4pWVIuvgLln6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742196829; c=relaxed/simple;
	bh=amiK0CerV888LbsXt/a1hE8vD46TtUZtSz9iWf0EnFI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FHXSpj7Hvcw270zGNd27ikL0OU5WYRr3fLItIJ98BcfsKxE17Ej2VISMWOL+soQjLZMCotTuxt/iWXQg81oKo8PNdeAAm1+nkazhy6JOV1lWTQ/3c/R5DGTdkF4LkWkrXcW8IsRsGQ7GgVIWkYjgIQdPrXNVLR4vWWXMaIP7S/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=XHVh/+eD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54997C4CEE3;
	Mon, 17 Mar 2025 07:33:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1742196828;
	bh=amiK0CerV888LbsXt/a1hE8vD46TtUZtSz9iWf0EnFI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XHVh/+eDmPGRgIHvqWYvLC912fBoN7CeNq9M3BF8u33Y7yzS3L/Dir7l93ix/hzhe
	 JbXl5k0IGWCRrSl28Nb2mnV8+aEc8lldhGLXzAtxYrsNawyAz8qiCAfXIdDAehlzak
	 DihcbUNjRVGAwuRbxEWsngd1cHynzWR7gjwcrimA=
Date: Mon, 17 Mar 2025 08:32:29 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Raag Jadav <raag.jadav@intel.com>
Cc: giometti@enneenne.com, andriy.shevchenko@linux.intel.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] pps: generators: tio: fix platform_set_drvdata()
Message-ID: <2025031718-ravage-oblong-05e1@gregkh>
References: <20250315133140.1707949-1-raag.jadav@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250315133140.1707949-1-raag.jadav@intel.com>

On Sat, Mar 15, 2025 at 07:01:40PM +0530, Raag Jadav wrote:
> Set driver_data correctly and fix illegal memory access on driver reload.
> 
> Fixes: c89755d1111f ("pps: generators: Add PPS Generator TIO Driver")
> Signed-off-by: Raag Jadav <raag.jadav@intel.com>
> ---
>  drivers/pps/generators/pps_gen_tio.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pps/generators/pps_gen_tio.c b/drivers/pps/generators/pps_gen_tio.c
> index 6c46b46c66cd..6e4a383957d9 100644
> --- a/drivers/pps/generators/pps_gen_tio.c
> +++ b/drivers/pps/generators/pps_gen_tio.c
> @@ -230,7 +230,7 @@ static int pps_gen_tio_probe(struct platform_device *pdev)
>  	hrtimer_init(&tio->timer, CLOCK_REALTIME, HRTIMER_MODE_ABS);
>  	tio->timer.function = hrtimer_callback;
>  	spin_lock_init(&tio->lock);
> -	platform_set_drvdata(pdev, &tio);
> +	platform_set_drvdata(pdev, tio);

What does reload have to do with this?  Either the data pointer is set
to the expected type or not, so that it can work properly, which has
nothing to do with when the device is unbound and then rebound (which is
what I think you mean by reload?)

So I think your changelog needs a lot of work here, as it's not really
explaining what is happening properly.

thanks,

greg k-h

