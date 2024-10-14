Return-Path: <linux-kernel+bounces-363933-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD39A99C8F3
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 13:33:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 07868B24195
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 11:21:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BE9B17C227;
	Mon, 14 Oct 2024 11:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="EdjcBH3h"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEA73149C57;
	Mon, 14 Oct 2024 11:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728904783; cv=none; b=XbKF5FEsZc4DE8Q4HuWdy/ZKSHtUT8AAEgaXM84GrD8fIBDskiMWd4OZnu0PulY0bCxuMbkJm5C3LQudqzCpV74qYBfXMlB3t/LLFxCssv8t5bIar66TWGwWKWoof2kS7QkGDL9NoeAWR9Z805nGJxKjjL6Ooj8kvpDbDTChFCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728904783; c=relaxed/simple;
	bh=/fb6TY0+Ozh7vKmaHycGQhRR0AayQLHOM1cQjCfprq0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=IBRXXg8dFAQ3BjDhgqjbYj3GDHbxq+2cu8yY1StMjGVAWa2RMsvd6AB3s+2UpdAMEAOuSJl12wiUvJPsfPlHL41oylnApRNGhE2czkfM7Ae9MU1AhRLLW9AH6kwjUmL3cJeRg8bWa48P2oBAihbqsRGToKC2KKUo0XkHcLsihuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=EdjcBH3h; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1728904780;
	bh=/fb6TY0+Ozh7vKmaHycGQhRR0AayQLHOM1cQjCfprq0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=EdjcBH3hIss5MqTd0Ls6YLDmV2CPEqo8bKyUO6p2VHeVEE8yKhs6pwtcBald0uv26
	 lxUhEGrsSSoV60b9V7tle9itNOmkdfffY+X8IMXPtHyfSjodqRtVHcAJ9olHc9wmns
	 qBfxsBBaxykZdyS2b+Bkh1t2wZlUGVm2X1Fw1mHKPMezfVVwXoElnzu+9Lk57VDP3y
	 UAR/9Dyf+ejk+xAl/eEfonw9dYkJKhH8Cicq0gbHphPIEc1jCAGoxOV313VRdx3TAX
	 9Px2qN30N38WqtZkP00a5wmyJlS9ZX/DRj5hprFCmsRyG+uZsMEivrHQnd4cTterbN
	 8KGXyOxqBXZoA==
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id B0B4817E1366;
	Mon, 14 Oct 2024 13:19:39 +0200 (CEST)
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
To: Matthias Brugger <matthias.bgg@gmail.com>, 
 Fei Shao <fshao@chromium.org>
Cc: Conor Dooley <conor+dt@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Rob Herring <robh@kernel.org>, 
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org
In-Reply-To: <20241014111053.2294519-1-fshao@chromium.org>
References: <20241014111053.2294519-1-fshao@chromium.org>
Subject: Re: [PATCH v4 0/9] Add platform supports to MediaTek MT8188 SoC
 (part 2)
Message-Id: <172890477965.134864.8253638961403618415.b4-ty@collabora.com>
Date: Mon, 14 Oct 2024 13:19:39 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2

On Mon, 14 Oct 2024 19:09:22 +0800, Fei Shao wrote:
> I'm re-sending this v4 series to hotfix a bug in the patch that adds
> vdosys1 display nodes, as suggested in this [link].
> 
> Note that the previous [v3] series is in v6.12-next/dts64, so please
> drop that series and reapply this v4 instead.
> 
> Sorry for causing any inconvenience.
> 
> [...]

Applied to v6.12-next/dts64, thanks!

[1/9] arm64: dts: mediatek: mt8188: Assign GCE aliases
      commit: 45f57a28629ab6f37ca7c2920daf0eac90608e45
[2/9] arm64: dts: mediatek: mt8188: Add PCIe nodes
      commit: 355508880d41cfa5b0643515f27b6da490a1345e
[3/9] arm64: dts: mediatek: mt8188: Add MIPI DSI nodes
      commit: 3147d168a516e4f6f7aebb25d2206f40d3168c85
[4/9] arm64: dts: mediatek: mt8188: Add video decoder and encoder nodes
      commit: 3ebe1aefa27e87b688f5bdd06713e01de3f19c12
[5/9] arm64: dts: mediatek: mt8188: Add JPEG decoder and encoder nodes
      commit: 4d3a0bbca1b6d7d5c873f9b1ebe81be2f5301905
[6/9] arm64: dts: mediatek: mt8188: Add display nodes for vdosys0
      commit: 7d3008158e9ccc45bec8f85b2393e279de1b2c93
[7/9] arm64: dts: mediatek: mt8188: Add display nodes for vdosys1
      commit: 6a6ebbeea64256d2b69ce660dc2a510714be537d
[8/9] arm64: dts: mediatek: mt8188: Add DP-INTF nodes
      commit: 42bf3bbd6237a816ef3d5d66c9734618838e81d3
[9/9] arm64: dts: mediatek: mt8188: Add eDP and DP TX nodes
      commit: 05c2e1902c73d6bbd93d77611b4495c587664029

Cheers,
Angelo



