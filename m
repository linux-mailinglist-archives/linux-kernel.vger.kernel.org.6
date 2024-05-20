Return-Path: <linux-kernel+bounces-184185-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 99E598CA3AE
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 23:08:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C6D981C21086
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 21:08:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB993139CFC;
	Mon, 20 May 2024 21:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ij5EYZFG"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 290071D531;
	Mon, 20 May 2024 21:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716239302; cv=none; b=JYjpQL95189sACJQ1fjFn6Fq5rzaRTrm0DEZ1ayELElP0cBq78fhZ7e4pWeRhuDmL7nemKgzg1PGrjIsAdcQNaRmn5NkBylNJdsd7kAQ7n0MjUFt8tg6Km+p7SrHEXongwEUtfZ1HaEEeb73Atqmv5HNnEkE6Kj/Attn5Y3vYIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716239302; c=relaxed/simple;
	bh=XdvSekiHzDgJlBrerJZoQRBoaKO5FPl+a2h4OopvYLE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mclE08ZIcIrOGy3g9kRazfR9M8CrxGxK67MDBh1+cbUqqM47/1oFT0U4VBq3EbMq0+Y7pgOtD/iyIx+9q1iJasOPMCeH6ZucGdSzzYUVsQluoVljYiCC0GnX3rX9nRn+98pkX7qzXlJoKSMFk/xqetJGJE2PCfJRDtvdGSoXziw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ij5EYZFG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80B35C2BD10;
	Mon, 20 May 2024 21:08:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716239301;
	bh=XdvSekiHzDgJlBrerJZoQRBoaKO5FPl+a2h4OopvYLE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ij5EYZFGTBA7BJSVz7ErkPMIRsocyNH/PgnxEFQBTMJX7RWsdMCIGu/r2hU7yB/an
	 pxS1stbrBh7YtMJQ04A4Nh66T9CknlpTEDP/yR2/fhIdVZ3wPWwHWH210zl6bDax3b
	 epnP2SDwOs/dEbDvypvdSMsnTmiWxL17NXjMa8TSucLyGi+3Bxlo/urmzCd3x5u7yU
	 ndnzeW8ny2fxUmSu+0lj3g0hv/CFbL708Nv7kINz1KL9jmj56tUruHT2xEbUrE1y7p
	 /GIGGE4yrT5ge1Ql2IKQ+5zbXRRDjncOp/AKgNDNmYZ6l/OT6WZ/5BpObWMjzbe+hf
	 wGc9pi/oxUmAA==
Date: Mon, 20 May 2024 16:08:20 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Lars Povlsen <lars.povlsen@microchip.com>, Lee Jones <lee@kernel.org>,
	linux-mediatek@lists.infradead.org, UNGLinuxDriver@microchip.com,
	Daniel Machon <daniel.machon@microchip.com>,
	Jiaxun Yang <jiaxun.yang@flygoat.com>,
	Steen Hegelund <Steen.Hegelund@microchip.com>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	Matthias Brugger <matthias.bgg@gmail.com>,
	Nishanth Menon <nm@ti.com>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>
Subject: Re: [PATCH 4/8] dt-bindings: soc: microchip: sparx5-cpu-syscon: Move
 to dedicated schema
Message-ID: <171623929821.1525513.17330365725365080199.robh@kernel.org>
References: <20240519-dt-bindings-mfd-syscon-split-v1-0-aaf996e2313a@linaro.org>
 <20240519-dt-bindings-mfd-syscon-split-v1-4-aaf996e2313a@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240519-dt-bindings-mfd-syscon-split-v1-4-aaf996e2313a@linaro.org>


On Sun, 19 May 2024 20:42:19 +0200, Krzysztof Kozlowski wrote:
> microchip,sparx5-cpu-syscon is not a simple syscon device - it has
> children and implements simple-mfd compatible - thus it should be fully
> documented in its own binding.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> ---
> 
> Context might depend on
> https://lore.kernel.org/r/20240510123018.3902184-1-robh@kernel.org
> and also further patches here depend on this one.
> ---
>  Documentation/devicetree/bindings/mfd/syscon.yaml  |  1 -
>  .../soc/microchip/microchip,sparx5-cpu-syscon.yaml | 49 ++++++++++++++++++++++
>  2 files changed, 49 insertions(+), 1 deletion(-)
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>


