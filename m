Return-Path: <linux-kernel+bounces-212772-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 12861906614
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 10:01:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A15FE1F25539
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 08:01:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B079013CF99;
	Thu, 13 Jun 2024 08:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="1gIWHpeX"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7962513CABC;
	Thu, 13 Jun 2024 08:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718265682; cv=none; b=ewdFmhxZ5xLnz2036+O1V6TW4u53IAvV63XG6vIeYk+CupW/PjKDY0PzTy20brdnxJe4eniir65Mi+KtyPdAFgsAnMuJ7umaDgzvddbMHNhPy/bMm7cstKN0jKK+GxPq5Ri+LiSDVkD2RXXOevmim8gNqDJtCWfEl2kuuTncsSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718265682; c=relaxed/simple;
	bh=wbyJLiiccUCYB2zQ+xDgPMn5sJZiH3NYN8ymff9xip0=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Rkhu83lTCmhxQmx4lqinuxOWUdSlR1xXGy6zbpdXdTQra+vCLBk5rkbKfjmyZqDDvq5ZUn4eQNyEH6bIE58a2zgJU8gPKVe/UR9SdresggrAObOIj6KjhzlZ85MgPa+6/6ZJU06+dArj6rhqFeTtuBq5r6wfnI+T6kIwLu6x1hA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=1gIWHpeX; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1718265678;
	bh=wbyJLiiccUCYB2zQ+xDgPMn5sJZiH3NYN8ymff9xip0=;
	h=From:To:In-Reply-To:References:Subject:Date:From;
	b=1gIWHpeX9ArQUPA+l2Bs5OXv0HqNko8JXsrMO8/bzJfar+d0DH5A7zwcVB3JokMqv
	 sdTkr7oll0IM3wf3ZIdP1ErQmSwO2ABvI7u/7APCj7lONW+Gz3H9HG/RKjoXAGTjxi
	 oFN0MELbxlKKDoJLrHdXl+eFJH3sz00dproVxAFswJLYEp/Vjsxp9O/9autAySlINV
	 AOn5m9jsrqN5udj3R1SVt80t/c5eRorxrKo8HdRWvk+aEa40/xIdzYnloBZazvAC+m
	 8+1CaBZd4cjFQ/MU6KEOrdKRTO1gXIak8LlqqU9uW1Lpu96jbGOGQ0iaweeAnaLQze
	 un+j2pWwFwAtg==
Received: from IcarusMOD.eternityproject.eu (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 22ECA3782158;
	Thu, 13 Jun 2024 08:01:18 +0000 (UTC)
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20240612092421.52917-1-krzysztof.kozlowski@linaro.org>
References: <20240612092421.52917-1-krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH v2 1/3] arm64: dts: mediatek: mt8365: drop incorrect
 power-domain-cells
Message-Id: <171826567806.48354.15294674818509794534.b4-ty@collabora.com>
Date: Thu, 13 Jun 2024 10:01:18 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0

On Wed, 12 Jun 2024 11:24:19 +0200, Krzysztof Kozlowski wrote:
> The top SCPSYS node is not a power domain provider.  It's child
> "power-controller" is instead.
> 
> 

Applied to v6.10-next/dts64, thanks!

[1/3] arm64: dts: mediatek: mt8365: drop incorrect power-domain-cells
      commit: 24d29b58184973d328c3a17d007bb21e423ea414
[2/3] arm64: dts: mediatek: mt8365: use a specific SCPSYS compatible
      commit: 58adf8df342bbdd0e821750b103e7be6e5e2fd5f
[3/3] arm64: dts: mediatek: mt8173-elm: drop PMIC's syscon node
      commit: e7450bc4f8f187b87522d992c3e226dadeac3ba6

Cheers,
Angelo



