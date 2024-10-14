Return-Path: <linux-kernel+bounces-363813-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DD79B99C75C
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 12:44:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 888FD1F236DE
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 10:44:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FAF117C7BD;
	Mon, 14 Oct 2024 10:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="KGqk5ly+"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C80519CCFA;
	Mon, 14 Oct 2024 10:43:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728902639; cv=none; b=D/WDYY3nUbV4dKgAhr6EnffWV+eOTq8egrHkLfg9gCeZnvyuf77T9KbrX+E7P2CiwAd2+p66T4LoRRp+WBc8WNwZi7peLw9IhR8cmXmvAy5PRYNOCCdV3qvpGRu27kAT79zZFFKnVtFrCmuMZQKkiGZbFK+CqxnRd3LoU+V6UZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728902639; c=relaxed/simple;
	bh=zFfoFsOW4aI08PZHk3ptJ0clOIxFlUdsSM/Wo+lQl1c=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=qijvz/rOQ4BMORho8cd0JKrbd2ZH0VQPqfWeiKqoT4M1tEnjG9/RQKLsjWGP5Rum9EXLZoBKcCnZ2rYfAJbcBkgzdjyxcu/xoSqfbAsOnEKuBnj3kLltkaXrNl2kx/agQwT9sKLpZ3AOk7ID0dmhJAlRURgWNr3Otb2oIhkByKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=KGqk5ly+; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1728902636;
	bh=zFfoFsOW4aI08PZHk3ptJ0clOIxFlUdsSM/Wo+lQl1c=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=KGqk5ly+yUNt70G/i3UxSCVVZp2/URpXU8o39e191dK5cPhLNukJcZqDHqR9p4mlc
	 sIJGeWqnOtc8cAoRhDDgTFxxF157rTvDB3eOlb6FjUS+rkgq1bcs0RO4ISnyMBQWxQ
	 5L9D69RCSpb2ZxS8z4EhKnWGkE+24fnqIuX805orU6dZvHFv9cvxz8RNf5F7WDUysQ
	 7gi41HK2puEvWxlETJsQ6bb5PcDjOoFaImnb2CinS6qIGKs//wLxP/UvN0YiLfmBVk
	 6uysZQdJqV8XhKhdwuCnX9xBu/tJybPLV4MtsW7R0AxTpaoNAY3ruAcsJ48XpnMa6c
	 qysItZe/pf10w==
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id CC9D517E1395;
	Mon, 14 Oct 2024 12:43:55 +0200 (CEST)
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, 
 Alexandre Mergnat <amergnat@baylibre.com>, 
 Macpaul Lin <macpaul.lin@mediatek.com>
Cc: Bear Wang <bear.wang@mediatek.com>, Pablo Sun <pablo.sun@mediatek.com>, 
 Macpaul Lin <macpaul@gmail.com>, Sen Chu <sen.chu@mediatek.com>, 
 Chris-qj chen <chris-qj.chen@mediatek.com>, 
 MediaTek Chromebook Upstream <Project_Global_Chrome_Upstream_Group@mediatek.com>, 
 Chen-Yu Tsai <wenst@chromium.org>
In-Reply-To: <20241007090244.1731-1-macpaul.lin@mediatek.com>
References: <20241007090244.1731-1-macpaul.lin@mediatek.com>
Subject: Re: [PATCH v2 1/2] arm64: dts: mediatek: mt8390-genio-700-evk:
 update regulator names
Message-Id: <172890263578.119829.14354732422757704375.b4-ty@collabora.com>
Date: Mon, 14 Oct 2024 12:43:55 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2

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
> [...]

Applied to v6.12-next/dts64, thanks!

[1/2] arm64: dts: mediatek: mt8390-genio-700-evk: update regulator names
      commit: 4fcf4347c2a74bbc297b6f626de4ad0ca8fee96b
[2/2] arm64: dts: mediatek: mt8390-genio-700-evk: add keys and USB HUB
      commit: 13799dcd86813793349bf2136937bca91ae73253

Cheers,
Angelo



