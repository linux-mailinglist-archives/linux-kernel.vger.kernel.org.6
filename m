Return-Path: <linux-kernel+bounces-268685-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 349969427D5
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 09:27:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E775E287BFD
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 07:27:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A4E41A71EA;
	Wed, 31 Jul 2024 07:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="DApxMoqz"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17FA41A4F0A;
	Wed, 31 Jul 2024 07:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722410816; cv=none; b=H9/dGrCXX40DuJkOg6MaB5ZPewyWz8QVzjpARU22qai2Ik9pcZwBNnNg/3H+q1pANqnmhNIsDVpPtcUDywm5+B9Hgw3CJPFui6NVSzCuZMTBe/jiC+uZWqYpMen5q93N/dktpj044OCt1k96RmjZbphfYCUyglzHzw3pN8t2kkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722410816; c=relaxed/simple;
	bh=5XRWduDhYWavZxNmKK0wX/Kee6NU5sU1gTa+6T+740Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NE9ZxLWZhsL2Ap9jXIY13HCvyUXGawSEAJW6FMJEQrQKRkycSJjus1Vn7ThTU010YMJvjmVSC5VRhAuL/6+ZM+NQyHLTlraeSZf4qivdc8LZrnwgcHziMM5cCN8XAcAFKRmQ65kn90XiGWJq6TkTbHl6WCkRRKc1DgdU0ke+ujQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=DApxMoqz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BD37C116B1;
	Wed, 31 Jul 2024 07:26:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1722410815;
	bh=5XRWduDhYWavZxNmKK0wX/Kee6NU5sU1gTa+6T+740Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DApxMoqzqIUwmpA7OVHdZEU2hFmQn0bT7xPaJbSsuVPmawslH5ResYmMqGv42RGYq
	 VU2l7nqHAAu1nx3FETt94UReW7X6hYLDWWwza6cgcLwqlgznWdcuxJMI2IpTFY6HQt
	 L76w8x9YKzGAXdxUNfgudVk3w9qu9bdYje0G/nsw=
Date: Wed, 31 Jul 2024 09:26:51 +0200
From: 'Greg KH' <gregkh@linuxfoundation.org>
To: Manjae Cho <manjae.cho@samsung.com>
Cc: linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Improve MAR register definition and usage for rtl8723
Message-ID: <2024073112-securely-usage-0d8e@gregkh>
References: <CGME20240730155255epcas1p4ab3b5e88d400e2221aa1cf5cf234ea19@epcas1p4.samsung.com>
 <20240730155054.411059-1-manjae.cho@samsung.com>
 <2024073109-abridge-yapping-3db3@gregkh>
 <000001dae316$92e619b0$b8b24d10$@samsung.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000001dae316$92e619b0$b8b24d10$@samsung.com>

On Wed, Jul 31, 2024 at 03:55:05PM +0900, Manjae Cho wrote:
> > On Wed, Jul 31, 2024 at 12:50:54AM +0900, Manjae Cho wrote:
> > > This patch improves the usage of the MAR register by updating the
> > > relevant macro definitions and ensuring consistent usage across the
> > > codebase.
> > >
> > > Signed-off-by: Manjae Cho <manjae.cho@samsung.com>
> > >
> > > ---
> > >  drivers/staging/rtl8723bs/hal/sdio_halinit.c    | 4 ++--
> > >  drivers/staging/rtl8723bs/include/hal_com_reg.h | 3 +++
> > >  2 files changed, 5 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/drivers/staging/rtl8723bs/hal/sdio_halinit.c
> > > b/drivers/staging/rtl8723bs/hal/sdio_halinit.c
> > > index c9cd6578f7f8..9493562c1619 100644
> > > --- a/drivers/staging/rtl8723bs/hal/sdio_halinit.c
> > > +++ b/drivers/staging/rtl8723bs/hal/sdio_halinit.c
> > > @@ -380,8 +380,8 @@ static void _InitWMACSetting(struct adapter
> > *padapter)
> > >  	rtw_write32(padapter, REG_RCR, pHalData->ReceiveConfig);
> > >
> > >  	/*  Accept all multicast address */
> > > -	rtw_write32(padapter, REG_MAR, 0xFFFFFFFF);
> > > -	rtw_write32(padapter, REG_MAR + 4, 0xFFFFFFFF);
> > > +	rtw_write32(padapter, MAR0, 0xFFFFFFFF);
> > > +	rtw_write32(padapter, MAR4, 0xFFFFFFFF);
> > >
> > >  	/*  Accept all data frames */
> > >  	value16 = 0xFFFF;
> > > diff --git a/drivers/staging/rtl8723bs/include/hal_com_reg.h
> > > b/drivers/staging/rtl8723bs/include/hal_com_reg.h
> > > index 9a02ae69d7a4..baf326d53a46 100644
> > > --- a/drivers/staging/rtl8723bs/include/hal_com_reg.h
> > > +++ b/drivers/staging/rtl8723bs/include/hal_com_reg.h
> > > @@ -151,6 +151,9 @@
> > >  #define REG_BSSID						0x0618
> > >  #define REG_MAR
> 0x0620
> > >
> > > +#define MAR0						REG_MAR
> > 	/* Multicast Address Register, Offset 0x0620-0x0623 */
> > 
> > Why redefine this value again?  What is wrong with using it as "REG_MAR"?
> > Is this fixing anything or making anything more consistent somewhere?
> > It's only used in one place that I can see.
> > 
> > thanks,
> > 
> > greg k-h
> 
> Dear Greg,
> 
> Thank you for your feedback. I appreciate your point about the current usage
> of REG_MAR. While it's true that it's only used in one place currently, I
> believe there's value in making this change for the following reasons:
> 
>  - Consistency: Other similar registers in the codebase use this pattern.
> For example, we have IDR0 and IDR4 for MACID registers. Adding MAR0 and MAR4
> brings consistency to our register naming convention.
> 
>  - Clarity: The +4 offset in "REG_MAR + 4" isn't immediately clear without
> context. MAR4 makes it explicit that we're dealing with the next 4 bytes of
> the Multicast Address Register.
> 
>  - If we need to use these registers elsewhere in the future, having clear,
> specific names will make the code more readable.

You aren't going to use them elsewhere, worry about this then, not now.

> However, I understand if you feel this change doesn't provide enough benefit
> to justify inclusion. If you prefer, I could modify the patch to keep the
> REG_MAR usage but add comments for clarity:
> 
>     /* Multicast Address Register */
>     rtw_write32(padapter, REG_MAR, 0xFFFFFFFF);     /* Offset 0x0620-0x0623
> */
>     rtw_write32(padapter, REG_MAR + 4, 0xFFFFFFFF); /* Offset 0x0624-0x0627
> */

That seems a lot more sane and simpler.

thanks,

greg k-h

