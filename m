Return-Path: <linux-kernel+bounces-510994-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2557EA3249C
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 12:16:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C8E683A55C6
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 11:15:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D902520AF62;
	Wed, 12 Feb 2025 11:15:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="K7oHOn+z"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DA4C20A5EC;
	Wed, 12 Feb 2025 11:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739358950; cv=none; b=ZPadUhvxs6yuPDLKC9l/3byddlQsIaagVguxAJDvPNOwNsEhnaO0YVZmLiZ+RBjAct+28lffYMRWil/AWXjVLoYIz4eO4EC/oRGPV15MUKwpvUbTGgXj8ca6m3vWKb/cUkrKYtATFli+QFVoIJuwyx9URc+Okrc2/KxLOyTwQGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739358950; c=relaxed/simple;
	bh=YKDYw4EgJ1J5b/WF+gfNmcPIuyPdAY3GNHs6SNyZAFQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Wr9Hor1R9x/6VlIskdIyfmh9fK/b0eYOPjZ7pmK0qD6MuBDsIJOe3dUWZsPgKEWX0x3LvGL6olmfBunkpQorMdEQuWp3g/A+rni+18aLjJhpDpD5siAfBVbyhTZ0zCwC6SjA/HQg8/PVPhFuX+UQuuTp1EUxZifpbAtmABwDvBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=K7oHOn+z; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1739358946;
	bh=YKDYw4EgJ1J5b/WF+gfNmcPIuyPdAY3GNHs6SNyZAFQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=K7oHOn+zn3EE8LPVGFyRSAMjIWrVt7o1s38DJhLtiSgGb7LPbrWXP5jeCfm8foiAJ
	 D5oViv6VPCYNh7KtLmUxhS8ZQ9kZkqhZx1iIo+THiMdYv9r8fkrszbpsslUYvEft1y
	 iXqButssceRsGWaKkDrCT4ljpzX/1LeoOt1JShZtcZYksetScIECZn4QJBnF3nFkaR
	 aB4xkjXNYFjOOA0d4VYlw5UED+DVEAbdRqYKrWokox39rPEwkL3A2+ul8HI9pxZw0B
	 +CYxbwKS/KKFEbEDTEpRLGhsBYYXjuD3PB+mwKwZCAOcM8fxIaB+TYrre6AIiAOBlH
	 ZP1wcP/4NcbYg==
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 19DF917E0F8B;
	Wed, 12 Feb 2025 12:15:46 +0100 (CET)
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
To: linux-mediatek@lists.infradead.org, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
 matthias.bgg@gmail.com, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 kernel@collabora.com, macpaul.lin@mediatek.com
In-Reply-To: <20241218105356.39111-1-angelogioacchino.delregno@collabora.com>
References: <20241218105356.39111-1-angelogioacchino.delregno@collabora.com>
Subject: Re: [PATCH] arm64: dts: mediatek: mt8188: Add VDO0's DSC and MERGE
 block nodes
Message-Id: <173935894602.45655.9401418712379275131.b4-ty@collabora.com>
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

On Wed, 18 Dec 2024 11:53:56 +0100, AngeloGioacchino Del Regno wrote:
> Add nodes for the DSC0 and MERGE0 blocks, located in VDOSYS0 and
> necessary to add support for Display Stream Compression with a
> display pipeline that looks like:
> 
>     [other components] -> DSC0 -> MERGE0 -> Display Interface
> 
> 
> [...]

Applied to v6.14-next/dts64, thanks!

[1/1] arm64: dts: mediatek: mt8188: Add VDO0's DSC and MERGE block nodes
      commit: 449d7d1dcea3ff5bc454c586bbdf9eb4c8ecb0b9

Cheers,
Angelo



