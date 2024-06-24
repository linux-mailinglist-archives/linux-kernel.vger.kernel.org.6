Return-Path: <linux-kernel+bounces-227055-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B4A499147B2
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 12:42:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6A2241F218B2
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 10:42:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5CA5137748;
	Mon, 24 Jun 2024 10:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="uYYshNpj"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D50F1369B6;
	Mon, 24 Jun 2024 10:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719225699; cv=none; b=qeeexL/jVPNdptkwehBuMGBvRDTJ9rwJey8INk1WwWBz4OBjIetEUevXSPvLF89d9INRX/nlu79huYi52ExPg30eHjsqYkAzlvCkQOQW7BdudA6wlI8Lh5kBziqdWOPUd6zZuMwEYRHNAEEMA9jpGWfjhDjbiSWkbDm9LBi3Zbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719225699; c=relaxed/simple;
	bh=lRcWFdj1tPIGdt84c7U3m1iIUKW6+NWyO5+tcAGp/Qc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=NBcovXwHVcdcqk1uKlX5DMnGbTEJmoghXsoKfNb20eq+cZ0Ady2ioFshQouR4ZnpSxcTSTmBCU/7Gq33DHjDFYfrm0NmdzAjjPd4EZw+DShU2JS88XZta7hGoKhc3z+0ZkjbJPdzvZnAiJu1EH/TT1o3TXuttGsRyKRwKngYqfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=uYYshNpj; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1719225695;
	bh=lRcWFdj1tPIGdt84c7U3m1iIUKW6+NWyO5+tcAGp/Qc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=uYYshNpjF3He9y+T4oaG9biMebHHNRVnGGSme4yHnIttoAdHs6uGTX7h9XHAMyy3/
	 3kSPksIqTtLky1Vna8RZIQ0SP1qIdSXVkbU1FmxXYclk2Pb84AbNuyMjh8O9RpPNrn
	 YYiMy87Ukde8wp6eosuCKHGCsqutitFhqVePw3KqaPfD1ZUO2AsH/haa0qFDIB1WXK
	 qFosUzUlDUyLInpD1yp8f2gHH8zzdU5Loig9PIzP68dolCo5zTvF5XLpvkp2GU0TXX
	 7uG0FsbqVvcu2fn0GPUdhZjQePYz3S8OlBnbq2IX/U7CjLiq9HuaowoliwZnnPsXEM
	 KQUMdPbJZQDNQ==
Received: from IcarusMOD.eternityproject.eu (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 5533D378216A;
	Mon, 24 Jun 2024 10:41:35 +0000 (UTC)
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
To: Matthias Brugger <matthias.bgg@gmail.com>, 
 Chen-Yu Tsai <wenst@chromium.org>
Cc: devicetree@vger.kernel.org, linux-mediatek@lists.infradead.org, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>
In-Reply-To: <20240131083931.3970388-1-wenst@chromium.org>
References: <20240131083931.3970388-1-wenst@chromium.org>
Subject: Re: [PATCH] arm64: dts: mediatek: mt8183-kukui-jacuzzi: Add ports
 node for anx7625
Message-Id: <171922569527.118951.2617308405240923693.b4-ty@collabora.com>
Date: Mon, 24 Jun 2024 12:41:35 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0

On Wed, 31 Jan 2024 16:39:29 +0800, Chen-Yu Tsai wrote:
> The anx7625 binding requires a "ports" node as a container for the
> "port" nodes. The jacuzzi dtsi file is missing it.
> 
> Add a "ports" node under the anx7625 node, and move the port related
> nodes and properties under it.
> 
> 
> [...]

Applied to v6.10-next/dts64, thanks!

[1/1] arm64: dts: mediatek: mt8183-kukui-jacuzzi: Add ports node for anx7625
      commit: 96d95052915de95fd26e7a42322653078f19e3bb

Cheers,
Angelo



