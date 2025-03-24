Return-Path: <linux-kernel+bounces-573203-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D732A6D434
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 07:26:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BE7817A5F03
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 06:25:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABA471922DE;
	Mon, 24 Mar 2025 06:25:03 +0000 (UTC)
Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C6111B4248;
	Mon, 24 Mar 2025 06:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742797503; cv=none; b=LJZODjeuwkkdGO1WE4JcRcCLW9cswoF9AR39XmJ9hpfEQsIp+EQYLWj55N+GyPqGgZdViYz57ah9mP3HsaQXZhYBg3iENjD73FdMilJB8L7Jv81bJMJoi8/TGN/lM+QXMUtvuFXfb+ZX5FqotmKuksOtIUc0Eogu2PEKiahryV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742797503; c=relaxed/simple;
	bh=GLUjQfEpWB2Nxp8PDFXc3kKHegJ9tbzWrH3NEbLiPAs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HjD9N3WzRj+I/+fGJwlnOU8OxZ5reuOx9koxh/+kMTrzEinimjywcpVnTVPd5gxEhCDw6vE2kDzmUR1NTJphZpBJxaTnNQUGiUTLG8KTSQ0wWPMoZHkKj/gIX3jawk61Q7IaXWf44aaM6ukfK+GUwknyNHZXsbbuQ7hgJIJ5hxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org; spf=pass smtp.mailfrom=gentoo.org; arc=none smtp.client-ip=140.211.166.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentoo.org
Received: from localhost (unknown [116.232.48.233])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dlan)
	by smtp.gentoo.org (Postfix) with ESMTPSA id 7AA283434DF;
	Mon, 24 Mar 2025 06:25:00 +0000 (UTC)
Date: Mon, 24 Mar 2025 06:24:56 +0000
From: Yixun Lan <dlan@gentoo.org>
To: Alex Elder <elder@riscstar.com>
Cc: p.zabel@pengutronix.de, mturquette@baylibre.com, sboyd@kernel.org,
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	heylenay@4d2.org, guodong@riscstar.com, paul.walmsley@sifive.com,
	palmer@dabbelt.com, aou@eecs.berkeley.edu, spacemit@lists.linux.dev,
	devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND 4/7] clk: spacemit: define existing syscon resets
Message-ID: <20250324062456-GYB18687@gentoo>
References: <20250321151831.623575-1-elder@riscstar.com>
 <20250321151831.623575-5-elder@riscstar.com>
 <20250322162909-GYA15267@gentoo>
 <ee9fb4b7-7829-4eec-815c-1e269d6abc38@riscstar.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ee9fb4b7-7829-4eec-815c-1e269d6abc38@riscstar.com>

Hi Alex:

On 08:23 Sun 23 Mar     , Alex Elder wrote:
> On 3/22/25 11:29 AM, Yixun Lan wrote:
> > On 10:18 Fri 21 Mar     , Alex Elder wrote:
> >> Define reset controls associated with the MPMU, APBC, and APMU
> >> SpacemiT K1 CCUs.  These already have clocks associated with them.
> >>
> >> Signed-off-by: Alex Elder <elder@riscstar.com>
> >> ---
> >>   drivers/clk/spacemit/ccu-k1.c | 132 ++++++++++++++++++++++++++++++++++
> >>   1 file changed, 132 insertions(+)
> >>
> >> diff --git a/drivers/clk/spacemit/ccu-k1.c b/drivers/clk/spacemit/ccu-k1.c
> >> index 6d879411c6c05..be8abd27753cb 100644
> >> --- a/drivers/clk/spacemit/ccu-k1.c
> >> +++ b/drivers/clk/spacemit/ccu-k1.c
> > ..
> >> +static const struct ccu_reset_data apmu_reset_data[] = {
> >> +	[RST_CCIC_4X]	= RST_DATA(APMU_CCIC_CLK_RES_CTRL,	0, BIT(1)),
> >> +	[RST_CCIC1_PHY] = RST_DATA(APMU_CCIC_CLK_RES_CTRL,	0, BIT(2)),
> >> +	[RST_SDH_AXI]	= RST_DATA(APMU_SDH0_CLK_RES_CTRL,	0, BIT(0)),
> >> +	[RST_SDH0]	= RST_DATA(APMU_SDH0_CLK_RES_CTRL,	0, BIT(1)),
> >> +	[RST_SDH1]	= RST_DATA(APMU_SDH1_CLK_RES_CTRL,	0, BIT(1)),
> >> +	[RST_SDH2]	= RST_DATA(APMU_SDH2_CLK_RES_CTRL,	0, BIT(1)),
> >> +	[RST_USBP1_AXI] = RST_DATA(APMU_USB_CLK_RES_CTRL,	0, BIT(4)),
> >> +	[RST_USB_AXI]	= RST_DATA(APMU_USB_CLK_RES_CTRL,	0, BIT(0)),
> > ..
> >> +	[RST_USB3_0]	= RST_DATA(APMU_USB_CLK_RES_CTRL,	0,
> >> +				      BIT(9)|BIT(10)|BIT(11)),
> > 100 column if possible, also add one space between "BIT(9) | BIT(10) .."
> > continuous bits can just use GENMASK for short?
> 
> You'll notice that every place that has multiple bits in the mask
> also have a line break.  I kind of liked that as a way to highlight
> that fact (i.e., it goes beyond my preference for 80 columns).
> 
ok

> I will definitely add spaces, that was a mistake not to.
> 
> I will not define this with GENMASK().  In this case each bit
> represents a single reset, and so each one is significant on
> its own.  It is *not* a mask of contiguous bits, it's a set
> of bits that happen to have consecutive positions.
> 
ok

-- 
Yixun Lan (dlan)
Gentoo Linux Developer
GPG Key ID AABEFD55

