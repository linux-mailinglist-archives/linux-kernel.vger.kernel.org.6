Return-Path: <linux-kernel+bounces-336941-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 84FBD9842DF
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 12:01:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5BEF9B28B94
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 10:01:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E32C716C444;
	Tue, 24 Sep 2024 10:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="EDEzJDOv"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56AC214BF9B;
	Tue, 24 Sep 2024 10:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727172090; cv=none; b=LkX5w/OSIX7Q9qwtyWi3MNM/FCIB9kQOqIIwolpO52YA0yjEucRu4XTPPouHGSlqzxmxEdtK52XcYb6tFebVX0CAfqVI2y0q8mO+HWPGhbaESZFsR/CCcSmR7SBw+f1OuSmluJQAYsjDdoT3hxCZZYLneahrnAR826kLJ68XJHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727172090; c=relaxed/simple;
	bh=8EkwCtL1pMLPJpFVyhCEcC4yr0fijNXf5bHbvdG9SaE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WzdA1PoOhwKIXKLa3E08m0YBPjrx/Y1VM9DckwVvTH4FflR31Nx449jPYD33SKBA3hDSofSDzvgd8SSo1FLkNkf97yTGoWpcH5uVrkEbNBAKau+4fYqr0PM51aG4EfN6+XbH7gdl+6m/Ply+WgH01Dp1MhOy5O2enOsUo4LkPHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=EDEzJDOv; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Type:Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=qHRSPWckHafEtxyIwPf3zZU4QzTnqXjXtDJvuDWNGxY=; b=EDEzJDOvTIqfDKu/h0+VACmGM+
	d6J1krWZp1rP+U/h2l7/YVcCVDjpu9xLJnRT0jmDbF5p1YBo6G9JlgZrdjjkLx63koYHZA0U6V/cE
	CPLGZkv012RDB9CdDejb5zLOx4r66xa0wDi2FuozwTUXhViqdsJeJVnCFK+e+Nrw3LjyEaZ6TpiPE
	0zeywkM2krVYU0Lv3u1KRpVQGTvWkxded/eEXWFmo3RttahcJEGMm/OBM9kh9W1va46iz9g53mMUQ
	JPSFdBsauXBiSDWYaicBVVOaF+G9CrvW0YgpA7nGn0f71bZjQPphw41KIyudHvZrhJKdEz7sI5TMJ
	O9fETzxQ==;
Received: from 90-177-212-167.rck.o2.cz ([90.177.212.167] helo=phil.localnet)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1st2MH-0000xL-2Y; Tue, 24 Sep 2024 12:01:25 +0200
From: Heiko Stuebner <heiko@sntech.de>
To: vkoul@kernel.org, kishon@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, Frank Wang <frawang.cn@gmail.com>
Cc: linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-rockchip@lists.infradead.org, william.wu@rock-chips.com,
 tim.chen@rock-chips.com, wmc@rock-chips.com,
 Frank Wang <frank.wang@rock-chips.com>
Subject:
 Re: [PATCH v2 2/2] phy: rockchip: inno-usb2: Add usb2 phys support for rk3576
Date: Tue, 24 Sep 2024 12:01:23 +0200
Message-ID: <15288441.JCcGWNJJiE@phil>
In-Reply-To: <20240924085510.20863-2-frawang.cn@gmail.com>
References:
 <20240924085510.20863-1-frawang.cn@gmail.com>
 <20240924085510.20863-2-frawang.cn@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Am Dienstag, 24. September 2024, 10:55:10 CEST schrieb Frank Wang:
> From: William Wu <william.wu@rock-chips.com>
> 
> The RK3576 SoC has two independent USB2.0 PHYs, and
> each PHY has one port.

Can you please split the content into "converting to clk_bulk" (see
additional comment below) and "add rk3576" please?

That would make the patch a lot cleaner.


> @@ -376,6 +378,7 @@ rockchip_usb2phy_clk480m_register(struct rockchip_usb2phy *rphy)
>  {
>  	struct device_node *node = rphy->dev->of_node;
>  	struct clk_init_data init;
> +	struct clk *refclk = of_clk_get_by_name(node, "phyclk");

Doesn't this create an imbalance - with the missing put?
I think ideally just define clk_bulk_data structs for the
1-clock and 3-clock variant, attach that to the device-data
and then use the regular devm_clk_bulk_get ?

That way you can then retrieve the clock from that struct?


Thanks
Heiko



