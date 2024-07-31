Return-Path: <linux-kernel+bounces-268569-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 324B5942651
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 08:17:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5C1131C2164E
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 06:17:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6EFD167DB7;
	Wed, 31 Jul 2024 06:17:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="RM/s5+Z+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0445A1494A9;
	Wed, 31 Jul 2024 06:17:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722406622; cv=none; b=QKYrv4NMTQVhm0Psvd0ktx3XB988jCVig/Bme9FMgwk30u26ZrR71klOE8uj+eof5LzvAdg2P4Pw9eSH+eWqJLTYJMS+Aihs931Eppue2ILCMbylsuLV6T21V81ko9yovM5n6nst00X/XMB/ytmTxaeV3jzfppk1i6oxShjiDaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722406622; c=relaxed/simple;
	bh=0W96Fa8R9l+Y4nA9O/2GQNSID1q9+KegWUSXM+5H2zE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CTRb9rtpJyTQfru4bt+6ZE4xxutHJ/hLvTB2jn5q6yADxXpQGkpBUgqJCeZwO0ick+0HDSJX+wv2KCuMM+ltGUF1F1jwYU6mFf2pZVM0J7rvTdSKgOKUcsGOH3BzFDweqQRJmhEa1WrREc3cxx9vLBPGGfpQtO6KLShkG3HULDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=RM/s5+Z+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 186E4C116B1;
	Wed, 31 Jul 2024 06:17:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1722406621;
	bh=0W96Fa8R9l+Y4nA9O/2GQNSID1q9+KegWUSXM+5H2zE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RM/s5+Z++t6S4Z3Vm3XRrye7bQ0F4DM+rxLevnucqQko0aNsJ7r599ZSDKuYSFSvj
	 STuymTMVfzmmE2V6lI5G6EaNelO0UMYnq1x8OFeo6aMQqrBWtwzVi4OdkQ8tTqg7i+
	 KPq03Czl0TXEX9dJIRxrpE2R5wT9wsKHdeui4y0I=
Date: Wed, 31 Jul 2024 08:16:58 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Manjae Cho <manjae.cho@samsung.com>
Cc: linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Improve MAR register definition and usage for rtl8723
Message-ID: <2024073109-abridge-yapping-3db3@gregkh>
References: <CGME20240730155255epcas1p4ab3b5e88d400e2221aa1cf5cf234ea19@epcas1p4.samsung.com>
 <20240730155054.411059-1-manjae.cho@samsung.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240730155054.411059-1-manjae.cho@samsung.com>

On Wed, Jul 31, 2024 at 12:50:54AM +0900, Manjae Cho wrote:
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
> +#define MAR0						REG_MAR		/* Multicast Address Register, Offset 0x0620-0x0623 */

Why redefine this value again?  What is wrong with using it as
"REG_MAR"?  Is this fixing anything or making anything more consistent
somewhere?  It's only used in one place that I can see.

thanks,

greg k-h

