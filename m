Return-Path: <linux-kernel+bounces-325244-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 457649756D1
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 17:19:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DC6261F2142C
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 15:19:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E2811AB6DA;
	Wed, 11 Sep 2024 15:19:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nG/Oi8WS"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 653612C190;
	Wed, 11 Sep 2024 15:19:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726067954; cv=none; b=h8h58FoCQdxWDpH5JRqFHyv5s9usxDpgNxIbyD4zwwZ/vmy6aLycycF4ygoZ979ne4SCRtgWOBtOVtLA3RFPOgpPCkblLEcjcc72Z0o08VMBeMYvU8f6c/vQKVe3WlBlxelK8wmoCCWRghQYzFL7aywr5NnKVW0U9yCs3rGbAyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726067954; c=relaxed/simple;
	bh=cSb4CB+p3svhD9W83Ai81pItfERhLziRxmos5X+V7zs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a/ugutWq5zPhd3fgNv+vmteIiVmnfN/FHDWri1YstUh3cOYBnTKZ8G6UDlouqf4PoRE1DMPkjVYO6uJG+XYCXnL+jd2bwam4LSOXTGpbUPnNtlW+lBUjS/z8ntonlLU9fOLZfvgxV2wGuGV8NTqqr8kg/JKYp8/BmqJITpTmzqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nG/Oi8WS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB8A4C4CEC0;
	Wed, 11 Sep 2024 15:19:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726067954;
	bh=cSb4CB+p3svhD9W83Ai81pItfERhLziRxmos5X+V7zs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nG/Oi8WS0wa/mQHwyhqf/ToC0P5uZCRfa9LB7OGh+BkN0wBvMZECjzDve8CebSm5O
	 /0ctI8bnAM6qdnnIZEFSQqhV88Q3tojzY3Zdkq3CbH8NY3SwQ3zJX4pbmA90TLdqWG
	 O2CsBkvfxEjhFrLaODX3K/aFHn4zGcXXIHD7mVO800t5hGvRcBL4I7wPpBEFO+KXd/
	 nCWEEjP/2wTPA6zbiIo3koZ5ZfRanos8krXsgvyey3+qEVEBk1n/4bdaVZVG8Ldrdr
	 jvkktjgJXG+GG48by1uyHxL2Idab86vQt3I1IXeiguBa8QAS0VqZRTsNdgTgtzcCEM
	 hRKoU1+yMKtRg==
Date: Wed, 11 Sep 2024 10:19:12 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Maxime Ripard <mripard@kernel.org>, Takashi Iwai <tiwai@suse.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Conor Dooley <conor+dt@kernel.org>,
	Anatoliy Klymenko <anatoliy.klymenko@amd.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	linux-kernel@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>,
	dri-devel@lists.freedesktop.org, Mark Brown <broonie@kernel.org>,
	devicetree@vger.kernel.org, linux-sound@vger.kernel.org,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Vishal Sagar <vishal.sagar@amd.com>,
	Jaroslav Kysela <perex@perex.cz>, Rob Herring <robh+dt@kernel.org>,
	=?iso-8859-1?Q?P=E9ter?= Ujfalusi <peter.ujfalusi@gmail.com>,
	Michal Simek <michal.simek@amd.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	linux-arm-kernel@lists.infradead.org,
	David Airlie <airlied@gmail.com>
Subject: Re: [PATCH v3 1/3] dt-bindings: display/xlnx/zynqmp-dpsub: Add audio
 DMAs
Message-ID: <172606795201.325596.766778615878256783.robh@kernel.org>
References: <20240910-xilinx-dp-audio-v3-0-75560793f4d0@ideasonboard.com>
 <20240910-xilinx-dp-audio-v3-1-75560793f4d0@ideasonboard.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240910-xilinx-dp-audio-v3-1-75560793f4d0@ideasonboard.com>


On Tue, 10 Sep 2024 14:19:19 +0300, Tomi Valkeinen wrote:
> The DP subsystem for ZynqMP supports audio via two channels, and the DP
> DMA has dma-engines for those channels. For some reason the DT binding
> has not specified those channels, even if the picture included in
> xlnx,zynqmp-dpsub.yaml shows "2 x aud" DMAs.
> 
> This hasn't caused any issues as the drivers have not supported audio,
> and has thus gone unnoticed.
> 
> To make it possible to add the audio support to the driver, add the two
> audio DMAs to the binding. While strictly speaking this is an ABI break,
> there should be no regressions caused by this as we're adding new
> entries at the end of the dmas list, and, after the audio support has
> been added in "arm64: dts: zynqmp: Add DMA for DP audio",  the driver
> will treat the audio DMAs as optional to also support the old bindings.
> 
> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
> ---
>  .../devicetree/bindings/display/xlnx/xlnx,zynqmp-dpsub.yaml    | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>


