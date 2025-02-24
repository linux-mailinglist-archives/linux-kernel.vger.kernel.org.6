Return-Path: <linux-kernel+bounces-529260-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DB52A42278
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 15:10:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F40A9177992
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 14:02:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AD3C13BADF;
	Mon, 24 Feb 2025 14:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="lmYWGnuV"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C5A32571AD
	for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 14:02:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740405760; cv=none; b=V+oKM9SI/9VE6jAcQUOz2ckYThcwmHTt/NUP0t7wyp542vtM73Q97fmVA/PYBVGOrRPbD5Ak4UTIXmIabcftVa+LqizEbrmynTwUQqZYgrxCc98ILupKfbwvR8Q9z9JenBp0BQPpqilKygDS9ytmXuzSgvXpvj7lbifJjtbV9iE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740405760; c=relaxed/simple;
	bh=NtQ8UJ5HySKPPmQnEnNNQwk1UmdTw09FLFYUk5geJ0s=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=U8+e17VCZkxKPwdcflBb39Ecm0b5zVIaSkPQX0odKGJep46qk3CuhlnsBK9wVoreAovuoQ2+Sy91rY3Gb8S73+ylrNZF/3bQLcFw+KnJdELZTBv3Utbah709Ue2Q1y9FHnz5L/BB/0Dhb0ivfjPDUydS/jhM/smZJO2yd1v16sY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=lmYWGnuV; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1740405757;
	bh=NtQ8UJ5HySKPPmQnEnNNQwk1UmdTw09FLFYUk5geJ0s=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=lmYWGnuVgm+KmTD5YIxehDk+tVlRC1vDVfK3HtWmF4+Xq4+qBxIDwOjpAaJvHPift
	 Iui0tPLrBtCwaPZFe1Y0gbWZIrnAXC10sAKWIMuEnQs3olEYWEDjRCysz/YtqhkcYH
	 lWyzHOV4kXH761x7If9uEk2Ps2sjc7XQNhouXivC3kLAogKB4Fj1QFoIWUjp28UJIW
	 VwWMp6/+QipGW+jONwhGszvac4z5tVDFcVG86uo2VvwY+0EjwCVhO4/kTG+8wgKlRP
	 QNzimmhM4cg2etTnbrfvkeV0PvBbGwLAEkIuJjOqVK/BRTREvZESd7DV3lvUAh0NU8
	 CAzRrDrDeB5rA==
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id B74F517E00F6;
	Mon, 24 Feb 2025 15:02:36 +0100 (CET)
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
To: Chun-Kuang Hu <chunkuang.hu@kernel.org>, 
 Jason-JH Lin <jason-jh.lin@mediatek.com>
Cc: Nancy Lin <nancy.lin@mediatek.com>, 
 Singo Chang <singo.chang@mediatek.com>, 
 Yongqiang Niu <yongqiang.niu@mediatek.com>, 
 Sirius Wang <sirius.wang@mediatek.com>, 
 Xavier Chang <xavier.chang@mediatek.com>, Fei Shao <fshao@chromium.org>, 
 Chen-yu Tsai <wenst@chromium.org>, Pin-yen Lin <treapking@chromium.org>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 linux-mediatek@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
 Project_Global_Chrome_Upstream_Group@mediatek.com
In-Reply-To: <20250224105414.3576243-1-jason-jh.lin@mediatek.com>
References: <20250224105414.3576243-1-jason-jh.lin@mediatek.com>
Subject: Re: [PATCH v2] mailbox: mtk-cmdq: Refine GCE_GCTL_VALUE setting
Message-Id: <174040575668.71176.5895162308675381424.b4-ty@collabora.com>
Date: Mon, 24 Feb 2025 15:02:36 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2

On Mon, 24 Feb 2025 18:50:13 +0800, Jason-JH Lin wrote:
> Add cmdq_gctl_value_toggle() to configure GCE_CTRL_BY_SW and GCE_DDR_EN
> together in the same GCE_GCTL_VALUE register.
> 
> For the SoCs whose GCE is located in MMINFRA and uses MMINFRA_AO power,
> this allows it to be written without enabling the clocks. Otherwise, all
> GCE registers should be written after the GCE clocks are enabled.
> Move this function into cmdq_runtime_resume() and cmdq_runtime_suspend()
> to ensure it is called when the GCE clock is enabled.
> 
> [...]

Applied to v6.14-next/soc, thanks!

[1/1] mailbox: mtk-cmdq: Refine GCE_GCTL_VALUE setting
      commit: 6b9a5fc65a7880f7ac6a981a0a30b5ecba7bd5ae

Cheers,
Angelo



