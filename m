Return-Path: <linux-kernel+bounces-510995-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D065FA3249A
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 12:16:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 57F501881AFA
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 11:16:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8147D20AF7E;
	Wed, 12 Feb 2025 11:15:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="QESPeC4I"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43C612046A6;
	Wed, 12 Feb 2025 11:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739358950; cv=none; b=npB5KKBggG2RP0Rn6sAVd/dVaXtxOsxAQSDSyBYuko6gCeZN1nvUkTjlqbIJauX+irvy2IguxqKGbCxulKOe3IST6Fi3DI4UY5liSWZBrQ7jYUmtJG9oUuZl69ymtvklv3EVbERRq+hfdi3iFWdG1LH0AyjHUuVCsiO/S2LwROs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739358950; c=relaxed/simple;
	bh=CPpp5p/Qbj7YQxkb0e+0ZwICrCMzLZP3T2zYLuNWwlU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=kCEH7demiRB4C9srAgJp9rgkdf8bDvy/NOsglckb2HaXYwJQU1aP0Z7H3MO4/0b95D5W6Sao1z+DEe6NzhdoDgs0fexaxPsDtXvAs0SK4frfEIrDyYj9pKukp8qVaJyHFncQCl4OPPh25yxdpeE9oLsjtQh4+/sb0E3EL0Cs2SQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=QESPeC4I; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1739358947;
	bh=CPpp5p/Qbj7YQxkb0e+0ZwICrCMzLZP3T2zYLuNWwlU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=QESPeC4I0/ajZ8/yaC5D7QzgOML+PQwl5pmSc9BXQy2/vXZOMrW4x+hbCTrbeIL2O
	 ESpDUAP9As2bH9mcr/GfKWdKl2gR9MP/TN/wmZNYQ1hjq7Jniwem0ZOMZRYOHvRSTQ
	 O4XCOD8gMgNkEhQkew9RzyTNbF74budV5HTR8ueqXBegShI1e18loLmjdrqQaUiDCa
	 m65yag6GR0N+VDHxPRQEvstBmkdTcV3YJeJq5FLDCpDSs9jbWXQm4rCqIuxREqwG9t
	 TUB4z3Wku5g8+TJ7t+kug7mCep5ig75RQP+U19u/njzs68B0UfTol1g+Pbi4QfYYPG
	 KZnmVQZI6Mnuw==
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id D606F17E151F;
	Wed, 12 Feb 2025 12:15:46 +0100 (CET)
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
To: linux-mediatek@lists.infradead.org, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
 matthias.bgg@gmail.com, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 kernel@collabora.com, macpaul.lin@mediatek.com
In-Reply-To: <20241218105409.39165-1-angelogioacchino.delregno@collabora.com>
References: <20241218105409.39165-1-angelogioacchino.delregno@collabora.com>
Subject: Re: [PATCH] arm64: dts: mediatek: mt8188: Add tertiary
 eMMC/SD/SDIO controller
Message-Id: <173935894680.45655.5939286400504120661.b4-ty@collabora.com>
Date: Wed, 12 Feb 2025 12:15:46 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2

On Wed, 18 Dec 2024 11:54:09 +0100, AngeloGioacchino Del Regno wrote:
> Add a node for the third instance of the eMMC/SD/SDIO controller
> found on the MT8188 SoC and keep it disabled.
> 
> It is expected that only boards that are using this controller
> instance will configure and enable it.
> 
> 
> [...]

Applied to v6.14-next/dts64, thanks!

[1/1] arm64: dts: mediatek: mt8188: Add tertiary eMMC/SD/SDIO controller
      commit: 5de2b8ed833a1cc3c9629beb34ea6040d9f18cf5

Cheers,
Angelo



