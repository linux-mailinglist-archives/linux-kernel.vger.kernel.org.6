Return-Path: <linux-kernel+bounces-394534-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 004909BB0AE
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 11:10:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A13D51F20FD9
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 10:10:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A0C61B2188;
	Mon,  4 Nov 2024 10:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="Gup59poh"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4EDD1B0F38;
	Mon,  4 Nov 2024 10:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730715026; cv=none; b=rpm7zsXs6Hzy+hfw6mMtIypkhNpuM0AriaLpqPkYPWShw6vkUDHCIV7upCo1nhR7clmUqe2otB7J99HHWI1OqTxgf6+0sbfozl346AbaxIYsx2Huye4G7rVt23M6B3GektqeJD/CKX0jDCsr7e2AYd8634QZr2cPi+Ezc0UtHqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730715026; c=relaxed/simple;
	bh=CSYjP+K7N5aRJn2h9T1DLvgtC+RNWp28+4aFe4h0Gn0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Gw7/Sf+6hHs9SonVNZcjpK6gt6xIyoXXEkfCdyx4KbCMykio2/eSYBRIUPjGMuhgWPKZYqU62pTcnzxTLHkvdYYsQK18hhW7gf0zstTjjDkSGULpKVw9+AGOrk5WSeu7iHP6SBCgqLqhf1fRxp0L9TfQUIgtMvnKi7ODvEs+z8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=Gup59poh; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1730715022;
	bh=CSYjP+K7N5aRJn2h9T1DLvgtC+RNWp28+4aFe4h0Gn0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=Gup59pohQBT87OEkR5N8zLsA21IUm3/nZ31/e8b9Gm5d8/0gp0PrTlddgvji0g/ca
	 MUtnC7m9mzuAR5vBYqZmakEh36t7ir8FmcwCnWuTnFdK0p6z7qweKw752JX524A5or
	 IIBTAz07Yu/M3tP4fXOw50OpiNAYey0ijh5oNH0VXXGPKcL/lxXEzcOhgp3ZIJzz/S
	 cwXbwycmL8LzKq90PhVE5Wxm4KICsveUJ9EJX63Ga3sZ/T+P8D4N5vDej1fsio5CBE
	 2cNUv87uL9d/dh335U/lT1RQZFbjZkhTkWxL8MIp7KB5N6ZZeTrawBlx9c9V2QFJbD
	 2J20lFU39klgQ==
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 352C217E14EF;
	Mon,  4 Nov 2024 11:10:22 +0100 (CET)
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 Hsin-Hsiung Wang <hsin-hsiung.wang@mediatek.com>, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
 Alexandre Mergnat <amergnat@baylibre.com>, 
 Macpaul Lin <macpaul.lin@mediatek.com>
Cc: Bear Wang <bear.wang@mediatek.com>, Pablo Sun <pablo.sun@mediatek.com>, 
 Macpaul Lin <macpaul@gmail.com>, 
 Project_Global_Chrome_Upstream_Group@mediatek.com, 
 linux-usb@vger.kernel.org, Chris-qj chen <chris-qj.chen@mediatek.com>
In-Reply-To: <20241029064647.13370-1-macpaul.lin@mediatek.com>
References: <20241029064647.13370-1-macpaul.lin@mediatek.com>
Subject: Re: [PATCH] arm64: dts: mediatek: mt6358: fix dtbs_check error
Message-Id: <173071502217.114014.11522421669609196627.b4-ty@collabora.com>
Date: Mon, 04 Nov 2024 11:10:22 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2

On Tue, 29 Oct 2024 14:46:47 +0800, Macpaul Lin wrote:
> Fix DTBS check errors for 'mt6358codec' and 'mt6358regulator':
> 
> Error message is:
> pmic: 'mt6358codec' and 'mt6358regulator' does not match any of the
> regexes: 'pinctrl-[0-9]+'.
> Rename these two device node to generic 'audio-codec' and 'regulators'.
> 
> [...]

Applied to v6.12-next/dts64, thanks!

[1/1] arm64: dts: mediatek: mt6358: fix dtbs_check error
      commit: 76ab2ae0ab9ebb2d70e6ee8a9f59911621192c37

Cheers,
Angelo



