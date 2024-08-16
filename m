Return-Path: <linux-kernel+bounces-290377-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DAE85955313
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Aug 2024 00:05:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 19A091C2436A
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 22:05:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CB05143C70;
	Fri, 16 Aug 2024 22:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cBxCmD9x"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B928E127E37;
	Fri, 16 Aug 2024 22:05:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723845919; cv=none; b=dB9ZMiu/WdpEWbXkzHfYyEa5dxRjgjIoJJ5Pj3Y2BnlPoOEuiuh/v+8CCgCVCTnUV7iTC09iKxrGIl+LrY0KPC4p5h0unmlBSxPpDtgO0cNh58CqAgDg2ILKJhSG09i7zkMdbP66f3X918QEMs+R02RUM359jWGViVzpX8AHE/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723845919; c=relaxed/simple;
	bh=h9r1mnmS5fGiHw6Op7GOzpACqSXBQDNYwqVtGHhVfKQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sM74qu/ummMRwoK7/1SWTYmvduGPDbVOlOLzqLOJgJPRNAqtmqAMj9yrar5jDnNs5kw5P2N88VSrl1TUztK4Y6q7xIeqeZ+V6C90ffzuh1+23jxTRDyA+n1JsWG3GJRw2sgpjtFU05/wk3wq95PX30H4WYxaXgM+VXfsPN5FL1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cBxCmD9x; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1867CC32782;
	Fri, 16 Aug 2024 22:05:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723845919;
	bh=h9r1mnmS5fGiHw6Op7GOzpACqSXBQDNYwqVtGHhVfKQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cBxCmD9x+b6Xi2EztlTQr7l+0oKriA3Qm3EkwXTkYqJH8Gk9b2xMAlyG6hf679xB3
	 skaSIzYrtNKtQdd3i8CrmCF4SX/bJgri+17By6gT/rcBd30VO2OYwQef0Ke/p0AwgD
	 /tYhywnRQH7vc0/+W9Kiwt4Ulg7TmdIKclNfZ2focOnG+YwWkZX9Qa7oNweH6yopoW
	 8K/c/NWFWcKneaHH1+Mc1zxxNENSA1zVPtk6ij6vs9RSCQdp9ozrYBaKXmhXUUtw3L
	 nAucw6srxJ2UiuR4X0M1+p/Fj5ENlkqPsy2QL7IOYWvX93Hqx6SPdZvDQusoH2el2a
	 Y4mVJBKbM5cEg==
Date: Fri, 16 Aug 2024 16:05:18 -0600
From: Rob Herring <robh@kernel.org>
To: Frank Li <Frank.Li@nxp.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
	Jessica Zhang <quic_jesszhan@quicinc.com>,
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Liu Ying <victor.liu@nxp.com>,
	Thierry Reding <thierry.reding@gmail.com>,
	Sam Ravnborg <sam@ravnborg.org>,
	"open list:DRM PANEL DRIVERS" <dri-devel@lists.freedesktop.org>,
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>, imx@lists.linux.dev
Subject: Re: [PATCH 1/1] dt-bindings: display: panel-simple-lvds-dual-ports:
 use unevaluatedProperties
Message-ID: <20240816220518.GA2347670-robh@kernel.org>
References: <20240812193626.3826250-1-Frank.Li@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240812193626.3826250-1-Frank.Li@nxp.com>

On Mon, Aug 12, 2024 at 03:36:26PM -0400, Frank Li wrote:
> Replace additionalProperties with unevaluatedProperties because it ref to
> panel-common.yaml.
> 
> Remove properties (backlight, enable-gpios and power-supply), which defined
> in panel-common.yaml.
> 
> Fix below warning:
> arch/arm64/boot/dts/freescale/imx8mp-evk-mx8-dlvds-lcd1.dtb: panel-lvds: 'panel-timing' does not match any of the regexes: 'pinctrl-[0-9]+'
>         from schema $id: http://devicetree.org/schemas/display/panel/panel-simple-lvds-dual-ports.yaml#
> 
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
>  .../display/panel/panel-simple-lvds-dual-ports.yaml         | 6 +-----
>  1 file changed, 1 insertion(+), 5 deletions(-)

Actually, I prefer doing it this way. Applied.

Rob

