Return-Path: <linux-kernel+bounces-249398-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5786892EB2D
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 17:00:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6E3311C21EFD
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 15:00:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7472816A952;
	Thu, 11 Jul 2024 15:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="OHjL7T02"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2588B1E49B;
	Thu, 11 Jul 2024 15:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720710031; cv=none; b=srhKXqlkOOUjWcXD+8ukatDWaSAtI4YKAxoWz2zidWK376L3bC7gpp46rNE7UmBZKvrIM5ctYHj2lOPvp5zFIhflV92FiJHie8vPNBQ5MJhVUXpxAnjL9lcd1L/lLtMEjqIiSJViT5y4lpfzynsp3/L42oBC8qK1bIrLG8bi0IM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720710031; c=relaxed/simple;
	bh=itsb3ZhOZhDxbRFDuhwPmOmd5B61fMqvju+ZGjeXyag=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eN0XkRhYm9LRBpcB7gb7tS/BPdBBhowVYM6ZoYu8BChQq29uIkqfSwmV44Z6R+voxjeSuTqVRMbog7G+r4ah4RASWTdhnNQ/7ztjtg0VOil/oZxNRkBn0fXc6ARgVf2GgTQ7ssyQLg9YKY5TqUy8qKAbD/ZSXYWmoCRQdaQRsuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=OHjL7T02; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1720710028;
	bh=itsb3ZhOZhDxbRFDuhwPmOmd5B61fMqvju+ZGjeXyag=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OHjL7T02nlYOYz3aiCp07/l5asG9Ed/PCld4oMyOu9qgYD9chneaaV+4joG//kLzR
	 uPA0SbAC4zTnxeBabO21Z92YcFXP8GopO91sC+WpEBecjQQUNfyjPxa0cNzLPnOIsx
	 ieumt/wiGFAX/adpNibPQA1gUmaQJXET1ARhukYEY91NAjTHMCGk9Sk1oSkSyS/QkC
	 3+xwLLD1T3LsPOSkHg0m8rUieNOAt/JD9oHIe6VgtZifSmxMw3/je2rTi+gbld9vF6
	 qT28i+0F/b5HiJrZRs6yS4ZlOaiMAqaezQJhJSGlDW5meKRIAdl0IP4ZV5/PDW79mI
	 lkfCqdfF1U3cg==
Received: from notapiano (zone.collabora.co.uk [167.235.23.81])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: nfraprado)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id DC6FA3780627;
	Thu, 11 Jul 2024 15:00:25 +0000 (UTC)
Date: Thu, 11 Jul 2024 11:00:23 -0400
From: =?utf-8?B?TsOtY29sYXMgRi4gUi4gQS4=?= Prado <nfraprado@collabora.com>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: linux-mediatek@lists.infradead.org, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, matthias.bgg@gmail.com,
	tinghan.shen@mediatek.com, seiya.wang@mediatek.com,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, wenst@chromium.org
Subject: Re: [PATCH] arm64: dts: mediatek: mt8195: Add power domain to
 secondary XHCI
Message-ID: <4ac0e464-5ef6-445d-a784-fe367ea23a2d@notapiano>
References: <20240711093230.118534-1-angelogioacchino.delregno@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240711093230.118534-1-angelogioacchino.delregno@collabora.com>

On Thu, Jul 11, 2024 at 11:32:30AM +0200, AngeloGioacchino Del Regno wrote:
> The secondary XHCI controller, using a PHY that is shared between
> it and the secondary PCI-Express controller, gets powered by the
> PCIE_MAC_P1 power domain.
> 
> Add this power domain to the usb@11290000 node to fix probe.
> 
> Fixes: 37f2582883be ("arm64: dts: Add mediatek SoC mt8195 and evaluation board")
> Reported-by: Nícolas F. R. A. Prado <nfraprado@collabora.com> #KernelCI
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

Hi Angelo,

thanks for the patch, but unfortunately it doesn't fix the issue:

[   10.772128] mtk-pcie-gen3 112f8000.pcie: host bridge /soc/pcie@112f8000 ranges:
[   10.788914] mtk-pcie-gen3 112f8000.pcie:       IO 0x0024000000..0x00241fffff -> 0x0024000000
[   10.802111] mtk-pcie-gen3 112f8000.pcie:      MEM 0x0024200000..0x0027ffffff -> 0x0024200000
[   10.941278] mtk-pcie-gen3 112f8000.pcie: PCI host bridge to bus 0000:00

[   10.785937] xhci-mtk 11290000.usb: uwk - reg:0x400, version:104
[   10.796352] xhci-mtk 11290000.usb: xHCI Host Controller
[   10.810530] xhci-mtk 11290000.usb: new USB bus registered, assigned bus number 5
[   10.844258] xhci-mtk 11290000.usb: clocks are not stable (0x1003d0f)
[   10.844262] xhci-mtk 11290000.usb: can't setup: -110
[   10.844266] xhci-mtk 11290000.usb: USB bus 5 deregistered
[   10.861969] xhci-mtk 11290000.usb: probe with driver xhci-mtk failed with error -110

In fact it seems to have made the issue more frequent, as it happened every time
for the 5 boots I tried.

But that gives me idea to try booting with clk_ignore_unused and
pd_ignore_unused. I'll update the report with the results.

Thanks,
Nícolas

> ---
>  arch/arm64/boot/dts/mediatek/mt8195.dtsi | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm64/boot/dts/mediatek/mt8195.dtsi b/arch/arm64/boot/dts/mediatek/mt8195.dtsi
> index 2ee45752583c..96ad1b14626e 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8195.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt8195.dtsi
> @@ -1445,6 +1445,7 @@ xhci1: usb@11290000 {
>  			reg-names = "mac", "ippc";
>  			interrupts = <GIC_SPI 530 IRQ_TYPE_LEVEL_HIGH 0>;
>  			phys = <&u2port1 PHY_TYPE_USB2>;
> +			power-domains = <&spm MT8195_POWER_DOMAIN_PCIE_MAC_P1>;
>  			assigned-clocks = <&topckgen CLK_TOP_USB_TOP_1P>,
>  					  <&topckgen CLK_TOP_SSUSB_XHCI_1P>;
>  			assigned-clock-parents = <&topckgen CLK_TOP_UNIVPLL_D5_D4>,
> -- 
> 2.45.2
> 

