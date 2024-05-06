Return-Path: <linux-kernel+bounces-170313-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 457088BD4FD
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 20:57:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 00BF628409B
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 18:57:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 196C0158DBB;
	Mon,  6 May 2024 18:57:17 +0000 (UTC)
Received: from fgw20-7.mail.saunalahti.fi (fgw20-7.mail.saunalahti.fi [62.142.5.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 467158494
	for <linux-kernel@vger.kernel.org>; Mon,  6 May 2024 18:57:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.142.5.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715021836; cv=none; b=a1fXieGUbP5n23bE5f3XWYUI2VYZ1hsMjk8CW/mjvWb6MZf37szuXepR7r+osQ2xUbIMQjwtlwDZieRfRF+8jqy4bSgfmnr86wmI9vLyeh05ijlYgR2GHagj6o4Y6Kvypm/FTPMVeUZD0dAdLMLZH+Qu+Ha0MP79hkRMIRv1uqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715021836; c=relaxed/simple;
	bh=dMhPV3IMcLOLNuDvwfw8BsOYqG4R3kM9nwX10XYlXyA=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=goZDd3PSuaM1rpnFIccgUkr8zkIm2a5E3QSTkTi+xeQWgNJec3bQVCF2EoZ7c0QHEPc0/hQnHVEXDZ7V6clBrkb5bMslDQK5KX9NSSIcifJUKydmlHJcU2JmvJAZLc3Z1HnDMRsxiGETTudzkAl+5WLNKYkzY6f10Xz+PU3qwjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=fail smtp.mailfrom=gmail.com; arc=none smtp.client-ip=62.142.5.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=gmail.com
Received: from localhost (88-113-25-208.elisa-laajakaista.fi [88.113.25.208])
	by fgw20.mail.saunalahti.fi (Halon) with ESMTP
	id 4a9edbaf-0bda-11ef-b3cf-005056bd6ce9;
	Mon, 06 May 2024 21:56:05 +0300 (EEST)
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Mon, 6 May 2024 21:56:05 +0300
To: Johan Hovold <johan+linaro@kernel.org>
Cc: Lee Jones <lee@kernel.org>, Mark Brown <broonie@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Das Srinagesh <quic_gurus@quicinc.com>,
	Satya Priya <quic_c_skakit@quicinc.com>,
	Stephen Boyd <swboyd@chromium.org>, linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-gpio@vger.kernel.org
Subject: Re: [PATCH 02/13] mfd: pm8008: fix regmap irq chip initialisation
Message-ID: <ZjknxSsyo20b5_Tm@surfacebook.localdomain>
References: <20240506150830.23709-1-johan+linaro@kernel.org>
 <20240506150830.23709-3-johan+linaro@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240506150830.23709-3-johan+linaro@kernel.org>

Mon, May 06, 2024 at 05:08:19PM +0200, Johan Hovold kirjoitti:
> The regmap irq array is potentially shared between multiple PMICs and

IRQ

> should only contain static data.
> 
> Use a custom macro to initialise also the type fields and drop the
> unnecessary updates on each probe.

..

> +#define _IRQ_TYPE_ALL (IRQ_TYPE_EDGE_BOTH | IRQ_TYPE_LEVEL_HIGH | IRQ_TYPE_LEVEL_LOW)

This is repetition of IRQ_TYPE_DEFAULT.

..

> -			dev_err(dev, "Failed to probe irq periphs: %d\n", rc);
> +			dev_err(dev, "failed to add IRQ chip: %d\n", rc);

dev_err_probe(...); ?

-- 
With Best Regards,
Andy Shevchenko



