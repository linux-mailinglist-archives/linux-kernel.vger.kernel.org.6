Return-Path: <linux-kernel+bounces-447141-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 891809F2DDB
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 11:09:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B073F1621D2
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 10:09:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05959202C38;
	Mon, 16 Dec 2024 10:09:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lUBnWPAF"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61CD3BA49;
	Mon, 16 Dec 2024 10:09:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734343781; cv=none; b=Yw59uSE4r4VmgU0GpGP+MbtU++cQRRnjx/wNM/hHSkiH1rurlM0mK+Qv33uGFl8FceKw3UOyv41cLcsdT25BesgiA+lg1STRdVObTmLdepZW2O8Pe2gDHcF5abv3f2+7Tts2nBV4Jkygj6A+DjiYRpG9fFyo4y/oM+0GmBlGY8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734343781; c=relaxed/simple;
	bh=Nay/Ysj46T8nFAC58Fcxr/oYYq+V5mUidfXinNesmug=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JXROyZPwwCGTqq+WeTvOb0rZKgHr08J1FTwJPzd2KEVDYZBAgw+JO/yT7hnjasIPFShA7Ib30jxmz/RV8kiGVI25cXwPo73Kez8BT/m8HCVGiF813Qz/SBv1NiavwsLE/wmVxTrOsuG+Ig6/2VTLxlOWrzSSk+vASPHTXzpfSFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lUBnWPAF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3AD18C4CED0;
	Mon, 16 Dec 2024 10:09:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734343780;
	bh=Nay/Ysj46T8nFAC58Fcxr/oYYq+V5mUidfXinNesmug=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lUBnWPAFmlPAhyJcJoHSApDI4vg2Wumq7oNXOalqY5m3EqfjPFvLLwEWF2n8Fj3jF
	 ZVmnJaoBj5+H7x+IyiSbHd2FrnJQDCJXciqBKhPZ5G5d1+lFSESDAldYxfS6oLaFq8
	 BHgy2W1fJQMWd1XoxZPIJRiTKi44/4gMIdMyhQYaaQ8Rgtfzjfbz5NMiB4tuy3GC4m
	 ctiVg4XZV6TGI9R4siYyTu71qfYefpwDMPhdsz4odAJwCqBovV1425ddnFyrXL8sBg
	 dEvlW0YgMADbCxUzhYk84LtGL5BDku+hNQ5Lq8zvidnm9YxHfPydId/MasgfIdkAFV
	 o8XZH5JSvWluw==
Date: Mon, 16 Dec 2024 11:09:37 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Luca Ceresoli <luca.ceresoli@bootlin.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>, 
	Jessica Zhang <quic_jesszhan@quicinc.com>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Thierry Reding <thierry.reding@gmail.com>, Sam Ravnborg <sam@ravnborg.org>, 
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>, dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: display: simple: Add Tianma
 TM070JDHG34-00 panel
Message-ID: <egqtfrmretlglzhizdgq32bioxqtydcz7ftv7j6ftj2or6vhch@tre2xmuz3pry>
References: <20241210-tianma_tm070jdhg34-v1-0-9fb7fe6b6cf0@bootlin.com>
 <20241210-tianma_tm070jdhg34-v1-1-9fb7fe6b6cf0@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241210-tianma_tm070jdhg34-v1-1-9fb7fe6b6cf0@bootlin.com>

On Tue, Dec 10, 2024 at 06:28:03PM +0100, Luca Ceresoli wrote:
> Add the Tianma Micro-electronics TM070JDHG34-00 7.0" LVDS LCD TFT panel.
> 
> Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
> ---
>  Documentation/devicetree/bindings/display/panel/panel-simple.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/display/panel/panel-simple.yaml b/Documentation/devicetree/bindings/display/panel/panel-simple.yaml
> index 18b63f356bb4bbf6d2c8e58b13ebb14c5f4004ad..30f655e82666bb1aa227edd26bd8d3621a39e74f 100644
> --- a/Documentation/devicetree/bindings/display/panel/panel-simple.yaml
> +++ b/Documentation/devicetree/bindings/display/panel/panel-simple.yaml
> @@ -281,6 +281,8 @@ properties:
>          # Tianma Micro-electronics TM070JDHG30 7.0" WXGA TFT LCD panel
>        - tianma,tm070jdhg30
>          # Tianma Micro-electronics TM070JVHG33 7.0" WXGA TFT LCD panel
> +      - tianma,tm070jdhg34-00

So tm070jdhg34 or tm070jvhg33? Comment says one, implementation different.

Best regards,
Krzysztof


