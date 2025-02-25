Return-Path: <linux-kernel+bounces-530816-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 23673A438BB
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 10:08:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8B9AB17DF79
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 09:07:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8727D267B0D;
	Tue, 25 Feb 2025 09:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="mad34g9i"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C4972673B3;
	Tue, 25 Feb 2025 09:02:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740474160; cv=none; b=FAEOBEtdOrRUQ+rO2GnXvnl9xiPJvVl8BiRCrjYuOsoOtEh1vC+x5tmL0X+llDJpx26ZC1l/TwSc0dFj4JpAs/7DbNlQuXCy+o/Q/w1k+A9lRQHAsPxQROi+m33ZhsM613JKxaJA/AhOHb+u36ZYeBsBT4Jfc4dCiXwj2q4N7lI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740474160; c=relaxed/simple;
	bh=RwD9Gz02QH5eAwhS1aHv2+U1ENtiqeTZVSrKrGfP2dU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=hjsU6YGwOuKkcNB1L5LN9cwJ8K+OKaPsxoX5eoOqFjm93+GvOQw4IQ9OCmrYRXSc+q4QrkaonFamdw3giTCN/WHDi7Zf6Te5JT7IENmn0KzZKwecn820dq0wRJZ8CusFLnvhT2N9VNUl3HycP5NIRs4TLetXbupJb9RV0tnS8+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=mad34g9i; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1740474156;
	bh=RwD9Gz02QH5eAwhS1aHv2+U1ENtiqeTZVSrKrGfP2dU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=mad34g9i/Acnl3b3bjkV/XIYDG+h63kRAtLqDy1H60vvcFWoD0JAwFNTrA3WoOT48
	 k05gGSpJrlxAACdz+Iet2xyV97LFujkaEAbyNZybRU3UO9hRCXxQzHBiMdhi82/vUm
	 VhwQ4kVPYQvmucasQVX6QukQBRWH9tK8JI7FNvPXtllmZnsfF73eyi/LC9reiNRmR0
	 AUe4EqsmFyy+ThuTuis9sjrVa9uXvRYzC9ZagCGw8C6S0KeiAuMiVYhO8zLJkZ1VRv
	 1/Irl+it6iJOE0n9RbfpSpeI4lxCevSpRSKp8KIBpcfhNa8XpKxn0MJxJMUskp8OWF
	 jmoUznt7wHSNg==
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id BED1517E1016;
	Tue, 25 Feb 2025 10:02:35 +0100 (CET)
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
To: linux-mediatek@lists.infradead.org, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
 matthias.bgg@gmail.com, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 kernel@collabora.com, pablo.sun@mediatek.com
In-Reply-To: <20250220110948.45596-1-angelogioacchino.delregno@collabora.com>
References: <20250220110948.45596-1-angelogioacchino.delregno@collabora.com>
Subject: Re: [PATCH v1 0/4] MediaTek MT8188 Display Graph:
 Chromebooks+Genio
Message-Id: <174047415570.19243.8135103122459285284.b4-ty@collabora.com>
Date: Tue, 25 Feb 2025 10:02:35 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2

On Thu, 20 Feb 2025 12:09:44 +0100, AngeloGioacchino Del Regno wrote:
> Like already done for MT8195 in a parallel series, this one adds a
> base display controller graph for the MT8188 SoC, migrates the Geralt
> Chromebooks to use it, and adds support for the DSI display found on
> the Genio 510 and Genio 700 boards.
> 
> While at it, this also adds pinmux configuration for switching on/off
> the fixed power supply of the touchscreen IC found in Genio 510 and 700
> IoT boards to stop relying on the bootloader preconfiguring it as GPIO
> before booting the kernel.
> 
> [...]

Applied to v6.14-next/dts64, thanks!

[1/4] arm64: dts: mediatek: mt8188: Add base display controller graph
      commit: affbd1197886bf0e05a0a71d3fdeb0a1abd9703d
[2/4] arm64: dts: mediatek: mt8390-genio-common: Add Display on DSI0
      commit: e9596d5c78d08936e57af15ee9e59ecbfa51a85e
[3/4] arm64: dts: mediatek: mt8188-geralt: Add graph for DSI and DP displays
      commit: 67bd5834f6a72f9971fea6c07830d0c336d3fbee
[4/4] arm64: dts: mediatek: mt8390-genio-common: Configure touch vreg pins
      commit: 39371656c1592262205fa75bbd25bbda5592446f

Cheers,
Angelo



