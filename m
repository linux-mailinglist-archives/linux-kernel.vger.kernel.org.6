Return-Path: <linux-kernel+bounces-363808-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD9C899C755
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 12:43:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 61B7F282DF6
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 10:43:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE77C17C990;
	Mon, 14 Oct 2024 10:43:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="UbfoJSZz"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F888176AD0;
	Mon, 14 Oct 2024 10:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728902602; cv=none; b=cXLfAz7tBSj/uPVebXy4iBAPVBgMkuhiYViNAZEHTN/BL0oPMohg+Ri3s2lHCYuYLouL88LK2ffSWZt23Cs7h9UXh1ttqg3etiZpXQTrMVsPsBnFDUX+AAMdSgQy2Ig1n8wKRfU8NW6su9ipVd9xg8iyzQeR1UOpiiobteZmbAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728902602; c=relaxed/simple;
	bh=TO+fsH/eUQ60nwauDDyn9iX3cCBxGqwedbX5VWj2Sa4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=cwBFSgfcX3myhtMYVzvxQUQeN4YzVs7SNC1pj4N+j/cNTnL9ThGWeNAAlaEbybYQuSJIHY/9zSgZzkdhnqMz6B3w6z94QpH7Dy9w7YbOJvIg2sYKLHNVDY1A5z75ZvTinOiVe7ebAuWK4XjP52VO6AjUpSSJZYs1sB4/ujZq1B0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=UbfoJSZz; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1728902597;
	bh=TO+fsH/eUQ60nwauDDyn9iX3cCBxGqwedbX5VWj2Sa4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=UbfoJSZzSxK9B/c9I5V+BRUXd++1Atv6hIKf1JAt3nJncKI8W9+7EFSYL6c3ZHRox
	 NkEtAjRCaIaaqy5iTzNvmh2j1mrVEpj5sf882PuP/upLXR5G7yFX8Skslhkye8Aov+
	 Znbk+Xj83wDPO5HkoNoZaQhCv2TL/Z/B0qX6ZgUVDjfnvxw+CJkRMubl4Dw5O6fXG+
	 iVPX87i7V1OblkRYLLzxFyhqGA2N+3sRedsp3NK/WF+ibv9YsmMrdhzJDojX38WRTJ
	 IjRrDAo8IZqntMeiFZNpg5M8s3chzBqzmm7smDCRTowrSx22abjkz7Jzbj6uZ18J1S
	 tVQnmwxGEaVpg==
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 1F5EC17E1395;
	Mon, 14 Oct 2024 12:43:17 +0200 (CEST)
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
Message-Id: <172890259705.119414.11953532411383385450.b4-ty@collabora.com>
Date: Mon, 14 Oct 2024 12:43:17 +0200
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

Applied to mediatek-next, thanks!

[1/2] arm64: dts: mediatek: mt8390-genio-700-evk: update regulator names
      commit: 54a1168b1a0adf9ee033b29bf32affca6059be7e
[2/2] arm64: dts: mediatek: mt8390-genio-700-evk: add keys and USB HUB
      commit: 46c2803425543deff4cb9be01da0cbd4bd6045a7

Cheers,
Angelo



