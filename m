Return-Path: <linux-kernel+bounces-530054-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F1C33A42E36
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 21:45:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E1D0C17783F
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 20:45:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5540424BC14;
	Mon, 24 Feb 2025 20:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X4PuSmUd"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC14618A6BD;
	Mon, 24 Feb 2025 20:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740429920; cv=none; b=PofCIGiTNOl6VuOI/tAzMqjvo8F4QUtuhQ7+D5tVbCAS4A1ssohHXLggZCzfscv1rasIsgodGLMD6Nw48SvRjqfb2Ah8oWi5jcvhv9Q1qTyC7ksZOW+cpdoKUybBUNVZv5jKzbYDKdCDln4lQ3aDeOuc/GrmtHxvF2pLqrEEL9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740429920; c=relaxed/simple;
	bh=QgksAgFLJVabfIFwX75z/Nx5a6DuAlpc5gJA1Ykv2Ec=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cVE6kmTMR7gAyr98rL75Mvn59QTsImL5Zs5+kb5sAac08cQS0O7qi+8kuKV8DEnikHpkXYAajZQHB55zWONIyitQk5KrUbGAdVwAcjSuxiKVvBtm7uCKetBsWJv8RevSMEAWygiUE069k4Gb3Dxqip1gPwrjk1QyW+WeFymCe2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X4PuSmUd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D491C4CED6;
	Mon, 24 Feb 2025 20:45:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740429920;
	bh=QgksAgFLJVabfIFwX75z/Nx5a6DuAlpc5gJA1Ykv2Ec=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=X4PuSmUd5e6xEQZv/m92TzrDuWVhYUGj5Z/fSbN9X3NjRGO4vd2/oE/ErwnO3/pCu
	 wrW8DU37q0JZkRZ+kBVC5s1Fuji5ufLY5GKxKuyL+ENKJg96Ifn7uOcss5PyHj8VD7
	 cEVG7FP+A8aqDBWBjORYcaYatL0k8S0az8QjfFaFF02iFbmoeU5I07+ToJjGd9uxzn
	 LylpT+opFNf8oftDndf6VXgtMXk/7V9zOCTTvsICrYhZJNErObLlRWhd3Q8WUFpWOa
	 rqy7+C7u718DposJaPRNyxvartvPH8K/PMoqZf74GKiTjutyzwnB0hhXrcfn6+PD7R
	 EKun7ZzeFI+Ow==
Date: Mon, 24 Feb 2025 14:45:18 -0600
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Maud Spierings <maudspierings@gocontroll.com>
Cc: dri-devel@lists.freedesktop.org, Liu Ying <victor.liu@nxp.com>,
	Thierry Reding <thierry.reding@gmail.com>,
	linux-arm-kernel@lists.infradead.org,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Simona Vetter <simona@ffwll.ch>,
	Thomas Zimmermann <tzimmermann@suse.de>, imx@lists.linux.dev,
	linux-kernel@vger.kernel.org, Sam Ravnborg <sam@ravnborg.org>,
	David Airlie <airlied@gmail.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Maxime Ripard <mripard@kernel.org>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Jessica Zhang <quic_jesszhan@quicinc.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	devicetree@vger.kernel.org, Fabio Estevam <festevam@gmail.com>
Subject: Re: [PATCH 06/14] arm64: dts: imx8mp: Add pinctrl config definitions
Message-ID: <174042991798.4062591.16695660457830350664.robh@kernel.org>
References: <20250224-initial_display-v1-0-5ccbbf613543@gocontroll.com>
 <20250224-initial_display-v1-6-5ccbbf613543@gocontroll.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250224-initial_display-v1-6-5ccbbf613543@gocontroll.com>


On Mon, 24 Feb 2025 14:50:56 +0100, Maud Spierings wrote:
> Currently to configure each IOMUXC_SW_PAD_CTL_PAD the raw value of this
> register is written in the dts, these values are not obvious. Add defines
> which describe the fields of this register which can be or-ed together to
> produce readable settings.
> 
> Signed-off-by: Maud Spierings <maudspierings@gocontroll.com>
> 
> ---
> This patch has already been sent in a different group of patches: [1]
> It was requested there to submit it along with a user, this series also
> includes some users for it.
> 
> [1]: https://lore.kernel.org/all/20250218-pinctrl_defines-v2-2-c554cad0e1d2@gocontroll.com/
> ---
>  arch/arm64/boot/dts/freescale/imx8mp-pinfunc.h | 27 ++++++++++++++++++++++++++
>  1 file changed, 27 insertions(+)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>


