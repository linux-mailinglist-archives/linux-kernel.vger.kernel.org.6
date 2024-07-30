Return-Path: <linux-kernel+bounces-267191-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E1068940E37
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 11:47:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1E4BB1C239EF
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 09:47:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C7E6196DA4;
	Tue, 30 Jul 2024 09:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="1aDTlIf1"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C41411946DA;
	Tue, 30 Jul 2024 09:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722332853; cv=none; b=gnARYqwqHDBZLDymGNOJDNK0CEXp3v4V4b3B7cdLbGqcWSjMz5FOlfrOJVMXicvcCJx2l+fi5PFe5xdNQF1v6QbM9y0eyGf21fEQinXDfsLIlGq4nsFz2I/GJqW91w9dsY97j3PE6t7WLF3n4pU7yLucavNPJ9rHVbupAm6ha3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722332853; c=relaxed/simple;
	bh=DED+NOuoNWUw+7V5AqaAhT37gqGBt+JeGB6mkgfB8U8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=uXZy2xEMl6wDz6GFSNqxTvDamjIyx0emUqwm5fU7oqKjUcQbE17W+/srDTZ3pGn5eBtN64ERYErPvMmGUhT/fXF1a2CN0SsEC7q+0ndMaE+J9XL+t2qZ4B98pLQqQ+LwpRV8u29TmKYl2Uv7n/g9g/AB5TilO+2E/UUCbZXxiQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=1aDTlIf1; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1722332849;
	bh=DED+NOuoNWUw+7V5AqaAhT37gqGBt+JeGB6mkgfB8U8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=1aDTlIf1g4/q6x4Oed+fRyFaQKanU0Xt93hazYLZXAcRvCdsCMgem/q640/vPvATM
	 rN2KjguWnYYDlHqC7TLOLffcsWateYkqtprpXlTWU7iO2n56A8hXPqthgTXF98JolB
	 fg/qQLSMagyrl9yfUH14gJDt97yCvIrz+iS8x2Eg/fftBoGT3P7qbum1p582zZbzHy
	 5+mh3is2ILQWdtrWOtQNS5xNwKVaRBR7t4omIhMxIW4TPG9Vz22216cKGY2YJqbEjj
	 5Q3SfLeHSYe265wY5H/znQSaaQCJy9W0YXOLFCvHCyxRSnNSH9WAGW8tHa4iHpvM2n
	 G/1BRedgBnerQ==
Received: from IcarusMOD.eternityproject.eu (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id B50D637821ED;
	Tue, 30 Jul 2024 09:47:28 +0000 (UTC)
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
To: Matthias Brugger <matthias.bgg@gmail.com>, 
 Chen-Yu Tsai <wenst@chromium.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20240625095705.3474713-1-wenst@chromium.org>
References: <20240625095705.3474713-1-wenst@chromium.org>
Subject: Re: [PATCH] arm64: dts: mediatek: mt8183-kukui-jacuzzi: Simplify
 DSI endpoint replacement
Message-Id: <172233284865.78062.3102616199099045616.b4-ty@collabora.com>
Date: Tue, 30 Jul 2024 11:47:28 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0

On Tue, 25 Jun 2024 17:57:04 +0800, Chen-Yu Tsai wrote:
> Currently the Jacuzzi dtsi file redeclares the full DSI endpoint tree
> from the DSI controller just to replace the remote endpoint. This is
> not necessary since the local endpoint already has a label that can be
> referenced. This will also confusion when the inherited layout is
> changed.
> 
> Replace the redeclared DSI endpoint tree with a label reference.
> 
> [...]

Applied to v6.11-next/dts64, thanks!

[1/1] arm64: dts: mediatek: mt8183-kukui-jacuzzi: Simplify DSI endpoint replacement
      commit: 98ef7cef1b3a5d73b5023c8661534768810dd941

Cheers,
Angelo



