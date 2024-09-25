Return-Path: <linux-kernel+bounces-338102-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 66C7398535C
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 09:00:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 106F51F211C6
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 07:00:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E5E315665C;
	Wed, 25 Sep 2024 06:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="utEltkYf"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6894E156222;
	Wed, 25 Sep 2024 06:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727247580; cv=none; b=fShKWLuPpIWoZpJ280N6Xv+A/NiP6Em2ajWErsmqnSM+bHUx6dWCHtFJ+1Ri92E8dBM+TZgACbS7NaPCP2tnnrI+8BFssNgqhdN0Fm5HtIHsZpPtWrK9VwkYU5yDVWR7ahpuhKWsrAdIoV+nX8Ydpk0isuzgGeHPx5iZubjoguM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727247580; c=relaxed/simple;
	bh=pPGnLwtCha067R6Blg9D6MM8QJP6IClF4qSK62B2Yzs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Azbo/nEE5HwBMRUUG/ve8/YlF0He6WmJaKEKlHBsNYvUatr7R3L0fUoZ0gnq+uNM2c2AjUu4jAhNtbk2jDr5A8ZZj9R+LtJNDTnqU4LWXwzxGIg/82Oc2i3NWOgZB+mteHAJd5tOclhl6mWdTUOHY3ovRYSA+EHjaiLCP9rij/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=utEltkYf; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Type:Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=4OHDvy0JbwIo9T9ERJY3XrQ0uyG3wqjaKHFSvcXXFsw=; b=utEltkYfHyzwR+C/bwO7gQuIvm
	OCsXLnaMF0nOUSAoY1NHWyYYEVNsbDaDTqzFdClMIk69dYyHGWRXA5Er+eAkv7xtBWtC8MmhWYUBX
	kltVnupn96hDAgeokDV+Rm+pfm+QQbM41f/AX2Hu/mj81U/rgj7me4CNw7jEJ9qAXDRQ3EhUuGyFX
	/aTFheYa4Yrxr0uA4G+LRg+lNrYawxIweumhAU16ej0tO66lUSDscJ8gSpFHf9QcTYeV5O44GlRPS
	gzR/0wCm4HwoZze+yWHFt0mNvcgNL6mh+kRmFfhqOH/MbCWE9UToh/A0IuB4WvmC+2VD9Pb6q99sn
	1O7py0vw==;
Received: from 90-177-212-167.rck.o2.cz ([90.177.212.167] helo=phil.localnet)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1stLzp-0007NK-Jb; Wed, 25 Sep 2024 08:59:33 +0200
From: Heiko Stuebner <heiko@sntech.de>
To: vkoul@kernel.org, kishon@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, frawang <frawang.cn@gmail.com>
Cc: linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-rockchip@lists.infradead.org, william.wu@rock-chips.com,
 tim.chen@rock-chips.com, Frank Wang <frank.wang@rock-chips.com>
Subject:
 Re: [PATCH v2 2/2] phy: rockchip: inno-usb2: Add usb2 phys support for rk3576
Date: Wed, 25 Sep 2024 08:59:33 +0200
Message-ID: <5522095.29KlJPOoH8@phil>
In-Reply-To: <29d80d30-dcbf-4fe1-b7aa-3f8c46fee714@gmail.com>
References:
 <20240924085510.20863-1-frawang.cn@gmail.com> <15288441.JCcGWNJJiE@phil>
 <29d80d30-dcbf-4fe1-b7aa-3f8c46fee714@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Hi Frank,

Am Mittwoch, 25. September 2024, 03:42:35 CEST schrieb frawang:
> >> @@ -376,6 +378,7 @@ rockchip_usb2phy_clk480m_register(struct rockchip_usb2phy *rphy)
> >>   {
> >>   	struct device_node *node = rphy->dev->of_node;
> >>   	struct clk_init_data init;
> >> +	struct clk *refclk = of_clk_get_by_name(node, "phyclk");
> > Doesn't this create an imbalance - with the missing put?
> > I think ideally just define clk_bulk_data structs for the
> > 1-clock and 3-clock variant, attach that to the device-data
> > and then use the regular devm_clk_bulk_get ?
> >
> > That way you can then retrieve the clock from that struct?
> 
> How about keep the clk_bulk_data and num_clks member in rockchip_usb2phy 
> structs, and retrieve the clock by "clks.id" here?
> Just like the following codes.
> 
> @@ -378,8 +378,9 @@ rockchip_usb2phy_clk480m_register(struct 
> rockchip_usb2phy *rphy)
>   {
>          struct device_node *node = rphy->dev->of_node;
>          struct clk_init_data init;
> -       struct clk *refclk = of_clk_get_by_name(node, "phyclk");
> +       struct clk *refclk = NULL;
>          const char *clk_name;
> +       int i;
>          int ret = 0;
> 
>          init.flags = 0;
> @@ -389,6 +390,13 @@ rockchip_usb2phy_clk480m_register(struct 
> rockchip_usb2phy *rphy)
>          /* optional override of the clockname */
>          of_property_read_string(node, "clock-output-names", &init.name);
> 
> +       for (i = 0; i < rphy->num_clks; i++) {
> +               if (!strncmp(rphy->clks[i].id, "phyclk", 6)) {
> +                       refclk = rphy->clks[i].clk;
> +                       break;
> +               }
> +       }
> +

this is exactly what I had in mind :-)

Thanks
Heiko



