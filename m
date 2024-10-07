Return-Path: <linux-kernel+bounces-352782-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DAA33992416
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 08:03:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6E5E11F22E0E
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 06:03:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88DEA13CA81;
	Mon,  7 Oct 2024 06:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="baWekIS/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E17655473C;
	Mon,  7 Oct 2024 06:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728280995; cv=none; b=LoV3ihw00t0V6d8jsIoBJYDORiMxwVJIuW6K7yXtGWoODPshuPC+fOTHSPXNNfAPxKJKYyCa+U7qd2uROMyi7xZ5HyfnQ3rsWN/GkFPIr6X7F7XYnItmu10sMMzaY9q2p8i46SEKWmCKgce1TzZJCoh7piGO8vi8EXsp46p/EsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728280995; c=relaxed/simple;
	bh=T1bREH4yDLWyE4xjZyozN2Zb3J6IlRSP3pWJSlbvkmc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IPJ3F1uaFX7kWvecWmGt5db5QIoAOQ47e2bdHytU4x+lMhZ9rKYBnvLgtp4IXy8wyVm7E2bpV7YvEGzNkHQwLygxkhM/D//KeZWqferElkHjwU7/cI2xMqUuFd234ww2LdFRU+M1qA7+/OZ+hWFUM2GinU2MH3WWXGBCblhDLOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=baWekIS/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E4C2C4CEC6;
	Mon,  7 Oct 2024 06:03:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728280994;
	bh=T1bREH4yDLWyE4xjZyozN2Zb3J6IlRSP3pWJSlbvkmc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=baWekIS/fyExGpr5aHbhxTGF7PnGZ2UrnXL6xio6nsLVb4Pr8ZsUVp8+LJHs1Dq1A
	 APcM1gKdbC0uiusVWSbPslE5gXxACFZBtaSwuSnG1seal/2LF6VmvcyhcEy4kGSInV
	 OfN4aXoZom5qMAdb0LuKpuWjg2Kq9WrZp7k34JSu6Pb7L9j674xFMBLr+uOSQI0Az3
	 P2yqPDlcZIHejz3If046VBcIBZalID12cfyVOgglAuK60dgUUFpJLQtFgv+XMrXdws
	 IsFSkWaUQZsX3TvTt+76kNFQ/BTCCedLBfACfVxi5mmGYKosQKcPt4NufFHWToNJkz
	 OlyxgPwrfpaDg==
Date: Mon, 7 Oct 2024 08:03:10 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Moudy Ho <moudy.ho@mediatek.com>
Cc: Chun-Kuang Hu <chunkuang.hu@kernel.org>, 
	Philipp Zabel <p.zabel@pengutronix.de>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, dri-devel@lists.freedesktop.org, 
	linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, Macpaul Lin <macpaul.lin@mediatek.com>
Subject: Re: [PATCH v5] dt-bindings: display: mediatek: split: add subschema
 property constraints
Message-ID: <tiduxmxji7nmlatceor2cmjy4xh7e36bvt6c6hygkkzots3kgm@ibwqoxij37g3>
References: <20241007022834.4609-1-moudy.ho@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241007022834.4609-1-moudy.ho@mediatek.com>

On Mon, Oct 07, 2024 at 10:28:34AM +0800, Moudy Ho wrote:
> The display node in mt8195.dtsi was triggering a CHECK_DTBS error due
> to an excessively long 'clocks' property:
>   display@14f06000: clocks: [[31, 14], [31, 43], [31, 44]] is too long
> 
> To resolve this issue, the constraints for 'clocks' and
> other properties within the subschemas will be reinforced.
> 
> Fixes: 739058a9c5c3 ("dt-bindings: display: mediatek: split: add compatible for MT8195")
> Signed-off-by: Macpaul Lin <macpaul.lin@mediatek.com>
> Signed-off-by: Moudy Ho <moudy.ho@mediatek.com>
> 
> --
> This is based on [v2] dt-bindings: display: mediatek: split: add clocks count constraint for MT8195

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof


