Return-Path: <linux-kernel+bounces-546911-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D8439A50081
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 14:28:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 424191649EC
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 13:25:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 876981EDA0E;
	Wed,  5 Mar 2025 13:25:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="ZcYinbhi"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F97624633D;
	Wed,  5 Mar 2025 13:25:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741181133; cv=none; b=ONcT2OfaYPwvLIZGjH+vDhH18Wg9mnIueXKP2e0ooe90P1CSmC4WPr6lujkddcZwyCVZSgxJs6jm4KB0vvTVfuHhpQr1OGIMtI4MDsD4MSL32vR+po+n9DqiE/a4vkbOuPd85P6/zM55L/ieDf41t9vhOC0ZA2Pkq8dHxr95PPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741181133; c=relaxed/simple;
	bh=xpWMmO1wQXH2vk0FpYl6JJDiWe8u0L3QtbU61Zx+7qE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=fuU1qsKwK78Kc3qrRpIX6lJ5zxYNqOrpifLgss43QOZm2Aj9COhJmSpspngMRr1phZwintNpMFSKVyd/CGgJdmI+4GmZQVIurucyYu/C8INzWpSmHiqCid7lFMoNQX+zs6WnbnAWjXbW1hLQARwthojDnYk9Oz1SEIbsZCe8Epg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=ZcYinbhi; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1741181129;
	bh=xpWMmO1wQXH2vk0FpYl6JJDiWe8u0L3QtbU61Zx+7qE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=ZcYinbhivIFekiC7RNjjkEI8thGBwmjW+zc2kLFxN6YMEU1ucrnVu1BGpMyUOgXgJ
	 euhq6gKs88DuQDaNCxEsAz4WPTMP2H3uXZ10R/CEQ6/vGiSfNl2VRJHES+NtB5nUsx
	 UbM1nAkXgeBpRRVgzRX2ToDHjYHRPsJjPoGg9/QVvR+ukmWDWhZVUZOSdhK0jtpifE
	 M5/MIO6lKVPMZ7otXK4rs1AYbdJmEk4f9WFfHLBYk65iayY41EM/Dq7urue6dcbn47
	 SUKCJWHko2WzHJdrKB38iwEmj2sx0s+9/FnwO563K3BVtXHW2aQ0ukYOq7CaLhprMH
	 ikuPVAnQ45vsQ==
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 6F0CE17E0880;
	Wed,  5 Mar 2025 14:25:28 +0100 (CET)
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
To: kernel@collabora.com, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 Julien Massot <julien.massot@collabora.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
 kernel@collabora.com
In-Reply-To: <20250304-radxa-panel-overlay-v2-0-3ee6797d3f86@collabora.com>
References: <20250304-radxa-panel-overlay-v2-0-3ee6797d3f86@collabora.com>
Subject: Re: [PATCH v2 0/2] mt8395-radxa-nio-12l: Add overlay for Radxa 8HD
 panel
Message-Id: <174118112837.81899.67489907591418089.b4-ty@collabora.com>
Date: Wed, 05 Mar 2025 14:25:28 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2

On Tue, 04 Mar 2025 15:01:54 +0100, Julien Massot wrote:
> small series to enable a DSI panel on Radxa NIO 12L.
> 
> The first patch adds missing dts nodes to expose some
> feature of the DSI0 port.
> 
> The second patch adds the Radxa 8 HD panel as an overlay.
> 
> [...]

Applied to v6.14-next/dts64, thanks!

[1/2] arm64: dts: mediatek: mt8395-nio-12l: Prepare MIPI DSI port
      commit: d4642e25bede20135d84e0ffdc234b72aaa1b6ba
[2/2] arm64: dts: mediatek: mt8395-radxa-nio-12l: Add Radxa 8 HD panel
      commit: 052cb5d105721a1bb517d278a005b0a100d27a62

Cheers,
Angelo



