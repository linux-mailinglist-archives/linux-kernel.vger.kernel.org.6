Return-Path: <linux-kernel+bounces-559136-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1133FA5EFE2
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 10:48:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 74D4F3A6A0A
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 09:47:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66B092641E6;
	Thu, 13 Mar 2025 09:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="py1khyo4"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB7FF24EF69;
	Thu, 13 Mar 2025 09:47:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741859245; cv=none; b=WCGfRENCPoHZWHsLFScr/y8pNYkCbl4hFWDyFNGOFcIlD+t+OSmadFcAQnfeOLF6eSdXXbAYHnFCoU3tCpXLGmjwdHyhXPSlvVqU/YCjuIqggUVuhvUv8WjQ8vghxaXnbutBYLd4aYhHGG5Nx3aVqlnv333LCvCmr1NGbMuOJIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741859245; c=relaxed/simple;
	bh=Qup0lTCmW1iNqV8AqsFH1fnQQjom+z+/RUgaV70lD/M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HhBPZvNa0CXN8sdHJSWccGRFX8lSmG6q1tJ4GyG5JpVPVfJPlaOHNcEWtgljkwVgaAwjaV27vGuyeWAcyzJ1DAqNMXupEHfEFjPG0bZuXfB1tAkh1Qs6og7XbRf9tFS3H7PSAcfrYmWf1P/UVLSLYq8CUdr0IHuQILh6MgAVZnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=py1khyo4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF35DC4CEDD;
	Thu, 13 Mar 2025 09:47:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1741859245;
	bh=Qup0lTCmW1iNqV8AqsFH1fnQQjom+z+/RUgaV70lD/M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=py1khyo4coU3MtgwSglyKuz0L+klp+rUNbHCvReBZSA+hP1aIfvH/uIjI/fLRnTBM
	 8hcHrUlpV45h8ompLl6MasTkz+AtMJDu6UY1kK36Qj1K3BrPvWj2/CEsIdJ1F0nICY
	 wUo4Isc0StGtEPorXqbCE8H2XnOryaOTKh1Xo8ok=
Date: Thu, 13 Mar 2025 10:47:22 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Ma Ke <make24@iscas.ac.cn>
Cc: richard@nod.at, chengzhihao1@huawei.com, miquel.raynal@bootlin.com,
	vigneshr@ti.com, logang@deltatee.com, linux-mtd@lists.infradead.org,
	linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] mtd: fix error handling in uif_init()
Message-ID: <2025031334-paving-jolliness-3383@gregkh>
References: <20250313091609.308724-1-make24@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250313091609.308724-1-make24@iscas.ac.cn>

On Thu, Mar 13, 2025 at 05:16:09PM +0800, Ma Ke wrote:
> Once cdev_device_add() failed, we should call put_device() to decrement
> reference count for cleanup. Or it could cause memory leak.
> 
> Found by code review.
> 
> Cc: stable@vger.kernel.org
> Fixes: 493cfaeaa0c9 ("mtd: utilize new cdev_device_add helper function")
> Signed-off-by: Ma Ke <make24@iscas.ac.cn>
> ---
>  drivers/mtd/ubi/build.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/mtd/ubi/build.c b/drivers/mtd/ubi/build.c
> index ef6a22f372f9..ca4c54cf9fd4 100644
> --- a/drivers/mtd/ubi/build.c
> +++ b/drivers/mtd/ubi/build.c
> @@ -486,6 +486,7 @@ static int uif_init(struct ubi_device *ubi)
>  	kill_volumes(ubi);
>  	cdev_device_del(&ubi->cdev, &ubi->dev);
>  out_unreg:
> +	put_device(&ubi->dev);

Oh wow.  No, that's not going to work.

This driver is broken in that there are two different reference counted
structures attempting to manage the same chunk of memory.  Things will
break as your patch here shows.

Please fix this all up to work properly instead, don't think that this
change will actually fix anything :(

thanks,

greg k-h

