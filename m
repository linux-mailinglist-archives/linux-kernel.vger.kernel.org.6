Return-Path: <linux-kernel+bounces-268542-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B47249425F7
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 07:48:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D77931C237F2
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 05:48:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3199050A6D;
	Wed, 31 Jul 2024 05:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="xdN1B6Su"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BDC7946F;
	Wed, 31 Jul 2024 05:48:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722404896; cv=none; b=Fy18lq6BUCDpJjUQKKJ23CskQdY2145ipl5wX9xuXOreff1K/6Nl16hOg5feEAO2NX8OTPFN8gvlPkuZ6TpUKI43Fd0nb15cF6uQ3tKdPaPjlpwZEFalptC5CsT2jBukdlpWombWWynnNZrAfxZjEmcMj2bJUH27C4wgweiUS40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722404896; c=relaxed/simple;
	bh=OVDhFLVxAiC4od63fOsYZkg8AleEFv4G8P6ZadbWjYA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K/8zA6zmJvsRaSqdHQ1cQ77d4XtGEwIW0U82P5DZLIFmENeBw4Ozu9Xad9Z7xR6luYvHVhUUE24bNVALuWPkdXKbHlVL9rkz30XdnH1qYvqR0kdJ6ihk7GMX15CowGS6EB4bLcEBU3Vso9BbcqWPvJtLLLoAt34zVyp6RvrQ3mU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=xdN1B6Su; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 910F0C32786;
	Wed, 31 Jul 2024 05:48:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1722404895;
	bh=OVDhFLVxAiC4od63fOsYZkg8AleEFv4G8P6ZadbWjYA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=xdN1B6SuG4aCvnTB3w0110DPw+HgQ3lFdkgzjVTzC/e8waPw4tD0GjuxMtJw0yTTY
	 F2Oz1nUtfFMjLaiPwLQhGM088JdeMGsW9J/bsrU1SDRCYmd6T0GQy13NKBmSd452Su
	 SGopbdOwW4vPMwcbHm2SyNsBukG4L3TLtHcaMPlc=
Date: Wed, 31 Jul 2024 07:48:11 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Manjae Cho <manjae.cho@samsung.com>
Cc: linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: rtl8723bs: Improve MAR register definition and
 usage
Message-ID: <2024073158-perfectly-majestic-e730@gregkh>
References: <CGME20240731053636epcas1p45b75f5d5256ba9360feda929d04a0106@epcas1p4.samsung.com>
 <20240731053620.783572-1-manjae.cho@samsung.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240731053620.783572-1-manjae.cho@samsung.com>

On Wed, Jul 31, 2024 at 02:36:21PM +0900, Manjae Cho wrote:
> This patch improves the usage of the MAR register by updating the
> relevant
> macro definitions and ensuring consistent usage across the codebase.
> 
> Signed-off-by: Manjae Cho <manjae.cho@samsung.com>
> 
> ---
>  drivers/staging/rtl8723bs/hal/sdio_halinit.c    | 4 ++--
>  drivers/staging/rtl8723bs/include/hal_com_reg.h | 3 +++
>  2 files changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/staging/rtl8723bs/hal/sdio_halinit.c b/drivers/staging/rtl8723bs/hal/sdio_halinit.c
> index c9cd6578f7f8..9493562c1619 100644
> --- a/drivers/staging/rtl8723bs/hal/sdio_halinit.c
> +++ b/drivers/staging/rtl8723bs/hal/sdio_halinit.c
> @@ -380,8 +380,8 @@ static void _InitWMACSetting(struct adapter *padapter)
>  	rtw_write32(padapter, REG_RCR, pHalData->ReceiveConfig);
>  
>  	/*  Accept all multicast address */
> -	rtw_write32(padapter, REG_MAR, 0xFFFFFFFF);
> -	rtw_write32(padapter, REG_MAR + 4, 0xFFFFFFFF);
> +	rtw_write32(padapter, MAR0, 0xFFFFFFFF);
> +	rtw_write32(padapter, MAR4, 0xFFFFFFFF);
>  
>  	/*  Accept all data frames */
>  	value16 = 0xFFFF;
> diff --git a/drivers/staging/rtl8723bs/include/hal_com_reg.h b/drivers/staging/rtl8723bs/include/hal_com_reg.h
> index 9a02ae69d7a4..baf326d53a46 100644
> --- a/drivers/staging/rtl8723bs/include/hal_com_reg.h
> +++ b/drivers/staging/rtl8723bs/include/hal_com_reg.h
> @@ -151,6 +151,9 @@
>  #define REG_BSSID						0x0618
>  #define REG_MAR							0x0620
>  
> +#define MAR0		REG_MAR		/* Multicast Address Register, Offset 0x0620-0x0623 */
> +#define MAR4		(REG_MAR + 4)	/* Multicast Address Register, Offset 0x0624-0x0627 */
> +
>  #define REG_MAC_SPEC_SIFS				0x063A
>  /*  20100719 Joseph: Hardware register definition change. (HW datasheet v54) */
>  #define REG_RESP_SIFS_CCK				0x063C	/*  [15:8]SIFS_R2T_OFDM, [7:0]SIFS_R2T_CCK */
> -- 
> 2.25.1
> 
> 

Hi,

This is the friendly patch-bot of Greg Kroah-Hartman.  You have sent him
a patch that has triggered this response.  He used to manually respond
to these common problems, but in order to save his sanity (he kept
writing the same thing over and over, yet to different people), I was
created.  Hopefully you will not take offence and will fix the problem
in your patch and resubmit it so that it can be accepted into the Linux
kernel tree.

You are receiving this message because of the following common error(s)
as indicated below:

- This looks like a new version of a previously submitted patch, but you
  did not list below the --- line any changes from the previous version.
  Please read the section entitled "The canonical patch format" in the
  kernel file, Documentation/process/submitting-patches.rst for what
  needs to be done here to properly describe this.

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot

