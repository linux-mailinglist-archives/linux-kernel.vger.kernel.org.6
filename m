Return-Path: <linux-kernel+bounces-367545-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 72FB59A03A6
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 10:06:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 204981F216D8
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 08:06:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4ECB1D279F;
	Wed, 16 Oct 2024 08:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="uljULS18"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F31E1D1E7A;
	Wed, 16 Oct 2024 08:04:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729065865; cv=none; b=MUnM8IR2LOt4KyKZfZz3SjXHXppeCB8EHSA6FDtL1t/2WWKGy2lptQe2RF/L0cDDb7KAUTPft4Fi7v4lCXB1rFfbjKl83BlHtIHVQWD3CLu8+imSIttyPnumswZ6/hTpTJR4BW2pbX4kNzDk+rmJXN80JWCbFG67T17sXxlQDog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729065865; c=relaxed/simple;
	bh=7EFMniMnM4vFAxl54q7U5HgmZAXyzue7bpEMYWTS2JI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=khXdETrBBKnNYKwaJ17vDmh2ou0afOdw4aaenYmO0YitLCch9EQDTybWC1fStjoY1Z+FTzs1Dg+9OT8QlITBLhosGOfH8V/cDgbE2F+9jG+upL1OAEAYGniL8UwPOil3iBjfaTto5WNf2yyXO5jJrZ+oH2++TAV3cBlSKsmR5RI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=uljULS18; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44ACCC4CEC5;
	Wed, 16 Oct 2024 08:04:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1729065864;
	bh=7EFMniMnM4vFAxl54q7U5HgmZAXyzue7bpEMYWTS2JI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uljULS18j1xz+2gy4x+uTXUw7Fr7Jd1k3cyKk9bTh4mntAGfIzlY5EdEXiFyeVvc0
	 CY8RHHtlQibLoMG89mOdENWbAWlsgZv+56EgfZFD9GtzhSMxD3rcl2IBUINq4HIZcH
	 UZkxF+mO4p+EkL10+GpVTM3BXzHzTHQVTPo7WPbI=
Date: Wed, 16 Oct 2024 10:04:21 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: "Everest K.C." <everestkc@everestkc.com.np>
Cc: dpenkler@gmail.com, skhan@linuxfoundation.org,
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2] staging: gpib: Remove a dead condition in if statement
Message-ID: <2024101654-jasmine-ransack-7190@gregkh>
References: <20241016075319.4092-1-everestkc@everestkc.com.np>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241016075319.4092-1-everestkc@everestkc.com.np>

On Wed, Oct 16, 2024 at 01:53:18AM -0600, Everest K.C. wrote:
> The variable `residue` is an unsigned int, also the function
> `fluke_get_dma_residue` returns an unsigned int. The value of
> an unsigned int can only be 0 at minimum.
> The less-than-zero comparison can never be true.
> Fix it by removing the dead condition in the if statement.
> 
> This issue was reported by Coverity Scan.
> Report:
> CID 1600782: (#1 of 1): Macro compares unsigned to 0 (NO_EFFECT)
> unsigned_compare: This less-than-zero comparison of an unsigned value
> is never true. residue < 0U.
> 
> Signed-off-by: Everest K.C. <everestkc@everestkc.com.np>
> ---
> V1 -> V2: - Fixed typo of comparison in changelog
>           - Removed Fixes tag 
> 
>  drivers/staging/gpib/eastwood/fluke_gpib.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/gpib/eastwood/fluke_gpib.c b/drivers/staging/gpib/eastwood/fluke_gpib.c
> index f9f149db222d..51b4f9891a34 100644
> --- a/drivers/staging/gpib/eastwood/fluke_gpib.c
> +++ b/drivers/staging/gpib/eastwood/fluke_gpib.c
> @@ -644,7 +644,7 @@ static int fluke_dma_read(gpib_board_t *board, uint8_t *buffer,
>  	 */
>  	usleep_range(10, 15);
>  	residue = fluke_get_dma_residue(e_priv->dma_channel, dma_cookie);
> -	if (WARN_ON_ONCE(residue > length || residue < 0))
> +	if (WARN_ON_ONCE(residue > length))

No, this is incorrect, now we never notice is the call to
fluke_get_dma_residue() has failed.  Please fix that bug instead (hint,
Covertity is giving you a pointer to where something might be wrong, but
this change is NOT how to fix it.)

thanks,

greg k-h

