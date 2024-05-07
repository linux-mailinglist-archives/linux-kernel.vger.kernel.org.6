Return-Path: <linux-kernel+bounces-171940-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF0888BEAF9
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 19:58:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 78F76281A39
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 17:58:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE58D16D301;
	Tue,  7 May 2024 17:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="j/g0CEmr"
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08D3F1607A7;
	Tue,  7 May 2024 17:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715104707; cv=none; b=VcEJo5OG64Byg/B+LRu1aDj0j42JThpXToWPwdxmABBNdecETfyCN2kORzY1ZtvKVBBPXHyziSPnOYkgI2PP6oIojhu4TWsWGml1uB59jieWpqHCcB2DhwRqTD05MjTMx9OV81WEO2z9zbOwd2f0+CN4owX+i2uXkTah0Jd+60Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715104707; c=relaxed/simple;
	bh=cLhYMUfavX/is8oPA4vFjuYUvx4gHjw9s6GruuvD9E8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ceL2kv0ndzEKBWJ1aBZ92mH1vUOch7doof66vQ03WAJbYhDFqioEGP3ytwEPyV0X/uLz0TbzmUVNaj+uBydU/JZsOsiSY8a74AKgRc4QuTWxPk8K/dmyxkhzCuEo191QWQ6AybOzmpP4Ia6fhoMc5FlY8jzmZ0pkO7Afau7fAqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=j/g0CEmr; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=jhtPKTCf2rAFUz3lZJnxmPbFv+4BaiLF1W7Jae20gYI=; b=j/g0CEmrxGRCGwQVYvHY/UrX8a
	XrAAQ9UmOPxMRWI0rhRsrXX0d0Yx5EpPm8YrPkH34Svqe5xREnhckMam2p+ly12QRtE/hj2P03mtW
	yorPSYlbnkg9sGDE9uPI/af7s7at75lwPgVmv9fwe10NeaFGzw0LNpVa2Qnd9GdyIRv8IoGQpGMrS
	eIiwZEp98gf05AaM659uXZYcEhw2K9/c0+wO3x8okGCPWuDZ010R2hc1Xh50DLE+SpEfit90FAFVO
	gKTqREa+2WvZJj3wEwmeNw7qtuGWldAE+/iZ8A7uKgOHS1L6a1EKFzbdeE022S0ggsI0vROkAeM02
	MEVPSkcg==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:34370)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1s4P50-00047K-0H;
	Tue, 07 May 2024 18:58:18 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1s4P4y-0000Vr-JX; Tue, 07 May 2024 18:58:16 +0100
Date: Tue, 7 May 2024 18:58:16 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: =?iso-8859-1?Q?Andr=E9?= Draszik <andre.draszik@linaro.org>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, linux-clk@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>
Subject: Re: [PATCH] clkdev: fix potential NULL pointer dereference
Message-ID: <ZjpruBO7iwcrz5ru@shell.armlinux.org.uk>
References: <CGME20240507064445eucas1p1bfc17da4f824ef46567774634482f12f@eucas1p1.samsung.com>
 <20240507064434.3213933-1-m.szyprowski@samsung.com>
 <e4ad92b88556f0de05b6b7ae03da1e581d688ce5.camel@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e4ad92b88556f0de05b6b7ae03da1e581d688ce5.camel@linaro.org>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Tue, May 07, 2024 at 05:42:45PM +0100, André Draszik wrote:
> Hi Marek,
> 
> On Tue, 2024-05-07 at 08:44 +0200, Marek Szyprowski wrote:
> > diff --git a/drivers/clk/clkdev.c b/drivers/clk/clkdev.c
> > index ddacab7863d0..d2801ae70e34 100644
> > --- a/drivers/clk/clkdev.c
> > +++ b/drivers/clk/clkdev.c
> > @@ -194,10 +194,12 @@ vclkdev_alloc(struct clk_hw *hw, const char *con_id, const char *dev_fmt,
> >  	return &cla->cl;
> >  
> >  fail:
> > -	fmt.fmt = dev_fmt;
> > -	fmt.va = &ap_copy;
> > -	pr_err("%pV:%s: %s ID is greater than %zu\n",
> > -	       &fmt, con_id, failure, max_size);
> > +	if (dev_fmt) {
> > +		fmt.fmt = dev_fmt;
> > +		fmt.va = &ap_copy;
> > +		pr_err("%pV:%s: %s ID is greater than %zu\n",
> > +		       &fmt, con_id, failure, max_size);
> > +	}
> 
> It might be nice to still print the rest of the error, so it's easier to see which
> clock is causing trouble.

Good point. I'll fix the patch myself, merging the fix in.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

