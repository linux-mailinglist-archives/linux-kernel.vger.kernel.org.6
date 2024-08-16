Return-Path: <linux-kernel+bounces-290407-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 642E595536A
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Aug 2024 00:38:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E76DE283E61
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 22:38:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE4B2145B39;
	Fri, 16 Aug 2024 22:38:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ni1WbB95"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 388A6BA33;
	Fri, 16 Aug 2024 22:38:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723847909; cv=none; b=N+5mY1tm7M4X8i/ugDwgatLrrPup8tAE+4tlkfllclZBY2SL0Es/daQOyPO56Hc47XHNt0/4j8r0mFHQZOlW+JxtdM9TiuRmuaV9f+SORm5AoPaX6wtHrSH4CIv7sHRnSHeUDjHsKvKU8KN6Rp9KVvhfiCLy5G5vQBzW2kA4iw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723847909; c=relaxed/simple;
	bh=Fjk1qhh8MhiVCg0maoWKTtUgd8BuOC//8pVyrOmXtIo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n6K/5UFWTgaMqOnJHXMd0U/I2jD/97lhkYRLWlQ4wpZC3jdme3UPof9FuzjkZq6sKoIp4pfqs0EQ0eZiOYjY/TgR3PbSBQWrPwuKCoQnZg7wKnX654Q4HYWebamqN2fd1ZoFdzvg7RgmllSOmTJNC5C5hTkUzZ9siJ7Y6D/sU/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ni1WbB95; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85D75C32782;
	Fri, 16 Aug 2024 22:38:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723847908;
	bh=Fjk1qhh8MhiVCg0maoWKTtUgd8BuOC//8pVyrOmXtIo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ni1WbB956Qo8TD6hjwwrk9k+6YrtuO2dkesGFQxQLCgYgPnkAnP8me9WRPBdFkYVb
	 elEVCbpG2IpUFiH9gOy+KM4198FDIKx6SlTjCMdKft04RYkqr0XPg3zjjt3y8VuTV+
	 D/PU47mhdiHpjadj1eVctKE30UB8JWSKdPhTMI+om7ADAvP/hKr+fIfoZV++FF1vZ9
	 D4fj/ujxmZc5bYMLbE3uxoRyNEfDnUWn+ow33chGavQAy6dgPdslNjTGQfv/Qcqt8/
	 t1YvklfkdUIAXy2L/L+3TkKGzf1eWA3biJkGnGu/Bmfp+rDdEUgAqW0zybAVaLJF1J
	 uaBZOXrP2T3tQ==
Date: Fri, 16 Aug 2024 16:38:27 -0600
From: Rob Herring <robh@kernel.org>
To: Liu Ying <victor.liu@nxp.com>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org,
	p.zabel@pengutronix.de, airlied@gmail.com, daniel@ffwll.ch,
	maarten.lankhorst@linux.intel.com, mripard@kernel.org,
	tzimmermann@suse.de, krzk+dt@kernel.org, conor+dt@kernel.org,
	shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
	festevam@gmail.com, tglx@linutronix.de, vkoul@kernel.org,
	kishon@kernel.org, aisheng.dong@nxp.com, agx@sigxcpu.org,
	francesco@dolcini.it, frank.li@nxp.com
Subject: Re: [PATCH v3 05/19] dt-bindings: display: imx: Add i.MX8qxp Display
 Controller AXI performance counter
Message-ID: <20240816223827.GB2394350-robh@kernel.org>
References: <20240724092950.752536-1-victor.liu@nxp.com>
 <20240724092950.752536-6-victor.liu@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240724092950.752536-6-victor.liu@nxp.com>

On Wed, Jul 24, 2024 at 05:29:36PM +0800, Liu Ying wrote:
> i.MX8qxp Display Controller contains a AXI performance counter which allows
> measurement of average bandwidth and latency during operation.
> 
> Signed-off-by: Liu Ying <victor.liu@nxp.com>
> ---
> v3:
> * New patch. (Rob)
> 
>  ...sl,imx8qxp-dc-axi-performance-counter.yaml | 57 +++++++++++++++++++
>  1 file changed, 57 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/imx/fsl,imx8qxp-dc-axi-performance-counter.yaml

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>

