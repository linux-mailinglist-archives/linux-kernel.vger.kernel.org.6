Return-Path: <linux-kernel+bounces-534965-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 08824A46D55
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 22:22:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F38A83A5C0F
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 21:22:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B3C02571A9;
	Wed, 26 Feb 2025 21:22:39 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 432A721CC54
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 21:22:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740604958; cv=none; b=PDaoiSQfDdqpHWhq+Va10GHzw09jLpB6TCc7j+WzHHv+YKkJOk+zzYVQEkZzJb5xkqPf5Oqbu3JZQFjZIydn7OXx0Z97pTy4g/GgFkw1SvDdNQjQfcngudSybsT4dx6QU+vaOgb5kBD3XxuWVDBfLUHse/K8Wduc86GfsCJRkXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740604958; c=relaxed/simple;
	bh=EzZkwmkop4wiw857fKxcJh0niCVBRlSLbeFVZXgxnI8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=plASaxLKlUoAq0XPTyqKw7/qGSD9yXCdb4OFwfpSGlgANJ44bWHI38jLOn0zWzZaZ5L+is9YSId0GF5ykR+sKNYFOnqVwned5PxWFH86CDrxPfHagp1/jpt/VfNN4LrW8Vt5yRO1VQWAzWRE4m70EN7ZQfiYTIm7XAmUzSf5+c0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mfe@pengutronix.de>)
	id 1tnOrD-00085X-L1; Wed, 26 Feb 2025 22:22:19 +0100
Received: from pty.whiteo.stw.pengutronix.de ([2a0a:edc0:2:b01:1d::c5])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mfe@pengutronix.de>)
	id 1tnOrD-0030wc-0f;
	Wed, 26 Feb 2025 22:22:19 +0100
Received: from mfe by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <mfe@pengutronix.de>)
	id 1tnOrD-001fiU-0G;
	Wed, 26 Feb 2025 22:22:19 +0100
Date: Wed, 26 Feb 2025 22:22:19 +0100
From: Marco Felsch <m.felsch@pengutronix.de>
To: Laurentiu Mihalcea <laurentiumihalcea111@gmail.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Daniel Baluta <daniel.baluta@nxp.com>,
	Shengjiu Wang <shengjiu.wang@nxp.com>, Frank Li <Frank.li@nxp.com>,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/5] imx8mp: add support for the IMX AIPSTZ bridge
Message-ID: <20250226212219.lthoofw7nrs3gtg6@pengutronix.de>
References: <20250226165314.34205-1-laurentiumihalcea111@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250226165314.34205-1-laurentiumihalcea111@gmail.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mfe@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

Hi,

On 25-02-26, Laurentiu Mihalcea wrote:
> From: Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>
> 
> The AIPSTZ bridge offers some security-related configurations which can
> be used to restrict master access to certain peripherals on the bridge.
> 
> Normally, this could be done from a secure environment such as ATF before
> Linux boots but the configuration of AIPSTZ5 is lost each time the power
> domain is powered off and then powered on. Because of this, it has to be
> configured each time the power domain is turned on and before any master
> tries to access the peripherals (e.g: AP, CM7, DSP, on i.MX8MP).

My question still stands:

Setting these bits requires very often that the core is running at EL3
(e.g. secure-monitor) which is not the case for Linux. Can you please
provide more information how Linux can set these bits?

Regards,
  Marco

> The child-parent relationship between the bridge and its peripherals
> should guarantee that the bridge is configured before the AP attempts
> to access the IPs.
> 
> Other masters should use the 'access-controllers' property to enforce
> a dependency between their device and the bridge device (see the DSP,
> for example).
> 
> At the moment, we only want to apply a default, more relaxed
> configuration, which is why the number of access controller cells
> is 0.
> 
> The initial version of the series can be found at [1]. The new version
> should provide better management of the device dependencies.
> 
> [1]: https://lore.kernel.org/linux-arm-kernel/20241119130726.2761726-1-daniel.baluta@nxp.com/
> 
> ---
> Changes in v2:
> * adress Frank Li's comments
> * pick up some A-b/R-b's
> * don't use "simple-bus" as the second compatible. As per Krzysztof's
> comment, AIPSTZ is not a "simple-bus".
> ---
> 
> Laurentiu Mihalcea (5):
>   dt-bindings: bus: add documentation for the IMX AIPSTZ bridge
>   dt-bindings: dsp: fsl,dsp: document 'access-controllers' property
>   bus: add driver for IMX AIPSTZ bridge
>   arm64: dts: imx8mp: convert 'aips5' to 'aipstz5'
>   arm64: dts: imx8mp: make 'dsp' node depend on 'aips5'
> 
>  .../bindings/bus/fsl,imx8mp-aipstz.yaml       | 86 +++++++++++++++++
>  .../devicetree/bindings/dsp/fsl,dsp.yaml      |  3 +
>  arch/arm64/boot/dts/freescale/imx8mp.dtsi     |  9 +-
>  drivers/bus/Kconfig                           |  6 ++
>  drivers/bus/Makefile                          |  1 +
>  drivers/bus/imx-aipstz.c                      | 92 +++++++++++++++++++
>  6 files changed, 194 insertions(+), 3 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/bus/fsl,imx8mp-aipstz.yaml
>  create mode 100644 drivers/bus/imx-aipstz.c
> 
> -- 
> 2.34.1
> 
> 
> 

