Return-Path: <linux-kernel+bounces-530030-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A47C2A42DE8
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 21:34:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 532397A989C
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 20:32:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 787F6264F81;
	Mon, 24 Feb 2025 20:32:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L2UKt4dp"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0299263F4D;
	Mon, 24 Feb 2025 20:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740429151; cv=none; b=EmInWmQMTBfWPtI8tY2/z+UZP95S/PYTIGtasfkiIQq8pk+23D8OHjQw+5tBQUy7ETtGOo+9t9BdSnz2wr9umWnimlHQE0FN8YUtZAkKDFwkd3dcpUT1fP8RXmyBrjeugySr3122ovTPwd37Y2nwIArNAc6KhxqeLZhbOBp5PrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740429151; c=relaxed/simple;
	bh=7Eyqt9Yi27fAwHev0xOEgY0/gsh0CaOyA02i4c7f+q4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=efSkZ7ZwILiT0zhU8H/wCobbQNZF5c372hqjeQSYFSJa0mu4dq215TR6CxjPPXtNoQsnD8MTyYzeh4Qdi+gf3F4ijUlIhJhJ7mG/oDqLpsRf/Zt6n/D5pr56zWN1/hfkHIyMDNFc2CBAfqMv2YbZMB4KR/K18+X1a5ZfWP1SnNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L2UKt4dp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E19CC4CEE7;
	Mon, 24 Feb 2025 20:32:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740429151;
	bh=7Eyqt9Yi27fAwHev0xOEgY0/gsh0CaOyA02i4c7f+q4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=L2UKt4dp2RNeu+KYdq+fQJdJTheZkYadYmOtIHueFj0GXVQuUlJv4EHvzrmv1Wf10
	 ehwrZ9x3s5b+7d6WxmzWMMg4j7Mgx9B9gfB/rtJEyp3vt7HH7+VU9jA2JVRSrwaJhf
	 xxzyDLlq5YZuzNCMthRET42kiJ6+hBHE0RvI+8YbDuoPz9OMTV0Is8E7fEyivjAp1v
	 U3itUCvauiJdIBnxgRQdJ5NycxTs/JKlte2vxWxIRwy9wZNevC7mrgPrf/9rc6xNPu
	 R22YZEkaXTAxNvTAEwTXVP2cAiV1pS/dHyR/D4yexI9v7LbZExCZvRQW3haj68/BsV
	 h8AB6Gc0w+vDA==
Date: Mon, 24 Feb 2025 14:32:29 -0600
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Maud Spierings <maudspierings@gocontroll.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Sam Ravnborg <sam@ravnborg.org>,
	Thierry Reding <thierry.reding@gmail.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Jessica Zhang <quic_jesszhan@quicinc.com>,
	devicetree@vger.kernel.org, Simona Vetter <simona@ffwll.ch>,
	Fabio Estevam <festevam@gmail.com>,
	Conor Dooley <conor+dt@kernel.org>, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	dri-devel@lists.freedesktop.org, Shawn Guo <shawnguo@kernel.org>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	David Airlie <airlied@gmail.com>, Liu Ying <victor.liu@nxp.com>,
	Maxime Ripard <mripard@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 02/14] dt-bindings: display: simple: Add BOE AV123Z7M-N17
 panel
Message-ID: <174042914940.4047956.6244302350129117835.robh@kernel.org>
References: <20250224-initial_display-v1-0-5ccbbf613543@gocontroll.com>
 <20250224-initial_display-v1-2-5ccbbf613543@gocontroll.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250224-initial_display-v1-2-5ccbbf613543@gocontroll.com>


On Mon, 24 Feb 2025 14:50:52 +0100, Maud Spierings wrote:
> Add support for the BOE AV123Z7M-N17 12.3" LVDS panel.
> 
> Signed-off-by: Maud Spierings <maudspierings@gocontroll.com>
> ---
>  .../devicetree/bindings/display/panel/panel-simple-lvds-dual-ports.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>


