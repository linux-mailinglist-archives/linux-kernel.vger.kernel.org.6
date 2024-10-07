Return-Path: <linux-kernel+bounces-354024-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7888199367B
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 20:45:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 029F7B2330E
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 18:45:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90B5B1DE3BB;
	Mon,  7 Oct 2024 18:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FOzIYEZ8"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9F061DE3A5;
	Mon,  7 Oct 2024 18:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728326678; cv=none; b=oq9Kl1CWX1oKqCrSp2Y1/AJkghWsB6Yq7vPbUXPzJf21J8j3Dez9pAJgIGzaYYaSOMX3OKVDOUYNB6Z3yNsa0FDws/78xAHZzZdAE7V+DN+/En48q0fTBYBdtrkQPGdFHJitYK4KP6z9qZB2vYCUgi0R3G/bJF3VrzeJQ5lG5zU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728326678; c=relaxed/simple;
	bh=TcLq86HfQp6OVk5c65NcK0ozHUSmDFRywdIQzX3Glvo=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=bKCgT+4sBnWoMOK7PJF1cVXF4eVVaWAPQobaKJU/FlNbNaXKJSPm6ShfxYLh0iXDOok2A82dNaQBvvkmL2D8uS9EVNZxlcC0CxQLlbbdeYYie5+gueY2bcYgqZq6hFXLke96wkQ+pvqg1JiuxPrzheIqmJfbI0ZK4Hsp8bCiKzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FOzIYEZ8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49FB3C4CECF;
	Mon,  7 Oct 2024 18:44:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728326677;
	bh=TcLq86HfQp6OVk5c65NcK0ozHUSmDFRywdIQzX3Glvo=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=FOzIYEZ8AGF0vIWApCeiMj3cfB0wCBt3iVN0F+H1/laJ/9zNhA4Q9mshN/IXmBcAR
	 CYyCAuOr0u2m26nwQCgwlHCDo6xHyPezUT3aK5RUNKCBUfvtgoYM6QgVkTTCThbms9
	 dntaINgQb1XHaYMEm49Kl/iQBiOSTph7SkXH/zC6WTho7UWaZevOfq7K/XM4d4w1Cn
	 3XiPn8qaNvWYlo2VP2y8/pvTQlt5gG2be1O7bybSBcFjjEhTkCv1mYUif8NsRyQ0/O
	 Ao+Kb8KU8hRUQYW9N410etNpefTDjR14UNjpfU/XL2hWwfPlJOzFJgxrmkUBQMtGnN
	 Lw9/3trvSSHDw==
Date: Mon, 07 Oct 2024 13:44:36 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Macpaul Lin <macpaul.lin@mediatek.com>
Cc: Chen-Yu Tsai <wenst@chromium.org>, Sen Chu <sen.chu@mediatek.com>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Macpaul Lin <macpaul@gmail.com>, linux-arm-kernel@lists.infradead.org, 
 Pablo Sun <pablo.sun@mediatek.com>, 
 Chris-qj chen <chris-qj.chen@mediatek.com>, 
 Conor Dooley <conor+dt@kernel.org>, Bear Wang <bear.wang@mediatek.com>, 
 devicetree@vger.kernel.org, 
 MediaTek Chromebook Upstream <Project_Global_Chrome_Upstream_Group@mediatek.com>, 
 Alexandre Mergnat <amergnat@baylibre.com>, linux-kernel@vger.kernel.org, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 linux-mediatek@lists.infradead.org
In-Reply-To: <20241007090244.1731-1-macpaul.lin@mediatek.com>
References: <20241007090244.1731-1-macpaul.lin@mediatek.com>
Message-Id: <172832632818.2107048.871461442982598898.robh@kernel.org>
Subject: Re: [PATCH v2 1/2] arm64: dts: mediatek: mt8390-genio-700-evk:
 update regulator names


On Mon, 07 Oct 2024 17:02:43 +0800, Macpaul Lin wrote:
> Update regulator names to match schematics, replacing generic terms.
> 1. Add system wide 'reg_vsys' node for 4.2V power rail.
> 2. Add 'reg_vsys' node as 'vin-supply' for the following nodes
>  - common_fixed_5v, edp_panel_fixed_3v3, gpio_fixed_3v3, sdio_fixed_3v3,
>    touch0_fixed_3v3, usb_hub_fixed_3v3, usb_p0_vbus, and usb_p1_vbus.
> 3. Update regulator names according to the stable output name on
>    schematics.
>  - vdd_5v, vedp_3v3, ext_3v3, vio18_conn, wifi_3v3, vio33_tp1, vhub_3v3,
>    vbus_p0, vbus_p1.
>  - vcn18_pmu, vcn33_2_pmu, dvdd_proc_l, dvdd_core, vpa_pmu, dvdd_adsp,
>    va12_abb2_pmu, vsim1_pmu, vufs18_pmu.
> 4. Remove usb_hub_reset_1v8. Use 'hub' node to probe USB HUB
>    in subsequent patches.
> 
> Suggested-by: Chen-Yu Tsai <wenst@chromium.org>
> Signed-off-by: Macpaul Lin <macpaul.lin@mediatek.com>
> ---
>  .../dts/mediatek/mt8390-genio-700-evk.dts     | 65 ++++++++++++-------
>  1 file changed, 42 insertions(+), 23 deletions(-)
> 
> Changes for v2:
>  - Add Suggested-by: tag.
>  - Rebase on mediatek/dts64 branch (v6.12-rc1)
> 


My bot found new DTB warnings on the .dts files added or changed in this
series.

Some warnings may be from an existing SoC .dtsi. Or perhaps the warnings
are fixed by another series. Ultimately, it is up to the platform
maintainer whether these warnings are acceptable or not. No need to reply
unless the platform maintainer has comments.

If you already ran DT checks and didn't see these error(s), then
make sure dt-schema is up to date:

  pip3 install dtschema --upgrade


New warnings running 'make CHECK_DTBS=y mediatek/mt8390-genio-700-evk.dtb' for 20241007090244.1731-1-macpaul.lin@mediatek.com:

arch/arm64/boot/dts/mediatek/mt8390-genio-700-evk.dtb: /soc/pwrap@10024000/pmic/keys: failed to match any schema with compatible: ['mediatek,mt6359-keys']






