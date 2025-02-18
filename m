Return-Path: <linux-kernel+bounces-518929-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A8A44A39660
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 10:04:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF98E3A23CA
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 08:54:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0166422D7BA;
	Tue, 18 Feb 2025 08:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="ezqVAXZv"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87B061DD886;
	Tue, 18 Feb 2025 08:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739868880; cv=none; b=JJtbo+/oXw+8FyRz6MLDVtuDe7oyVFXg7zuPENiN5TlL/af8RNG5fGhZWLSqG6b8s7ll9WtNxZt4MZ8YtCHsqqXRjTLQEkwmYbLtl353M5Lr5AUdMnCPeL+qEYof1QctWivH/3IN11uUpKHCofzKGFzDsAVpPmyVhgAVFX4ODmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739868880; c=relaxed/simple;
	bh=nBEJjisUo0PMocvrJPXI1lmZXGGqamSU/fT9KlpRkcM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=TVSRJbwURYVtlNgSgET7sQtmB5A3luu1UBQjLn0W1kdzVslN1X5wJ56GDatwLVkGxLX+u6vN6cOEHMqV2QFSCS7/5c8Ko60Kw5C3yOx03tMlnaQQ1d9YCfkYQgtCCmQCeYiDJukcnUKABzdNvoUTNoVKHMVrsh0jynZhAQKDbrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=ezqVAXZv; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1739868876;
	bh=nBEJjisUo0PMocvrJPXI1lmZXGGqamSU/fT9KlpRkcM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=ezqVAXZvjzTrkZ+XNZyqbkY0wB0yXd0VEZgExQ2jPKxIbIrjHfiHb8dmlHi2tsGHY
	 yQT5wPxPOB7pyeW4Ez36SYw28gAAvpoLYNRWJo09tOLmbLKIqJXQvKw2t1PzZOzorl
	 kQ6Vt0QMP/xZ3xj0vxfWZqnB+CAfxFnpFPra9P6EQ7xgDzTWxBSCI87Lris0Jn1Cq0
	 6fCTjpvVlgXEghV2sVL9pzBP9zpjyLLm0AuTTjOCkt9VxLGCWF3rBUzPxrX0R+WWQy
	 TCJTOWgL2VgucTV1bJPRdgscecS0ZjD3xN28vkPFNpKz/ELxRH2CqusiPJMr03GFJZ
	 TwL1nKlTmegtw==
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id C0F8817E0657;
	Tue, 18 Feb 2025 09:54:35 +0100 (CET)
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, 
 Alexandre Mergnat <amergnat@baylibre.com>, 
 Macpaul Lin <macpaul.lin@mediatek.com>
Cc: Bear Wang <bear.wang@mediatek.com>, Pablo Sun <pablo.sun@mediatek.com>, 
 Macpaul Lin <macpaul@gmail.com>, 
 Project_Global_Chrome_Upstream_Group@mediatek.com, 
 linux-usb@vger.kernel.org, Sen Chu <sen.chu@mediatek.com>, 
 Chris-qj chen <chris-qj.chen@mediatek.com>
In-Reply-To: <20250217113736.1867808-1-macpaul.lin@mediatek.com>
References: <20250217113736.1867808-1-macpaul.lin@mediatek.com>
Subject: Re: [PATCH v3] arm64: dts: mediatek: mt6359: fix dtbs_check error
 for audio-codec
Message-Id: <173986887570.18173.5945528132983122010.b4-ty@collabora.com>
Date: Tue, 18 Feb 2025 09:54:35 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2

On Mon, 17 Feb 2025 19:37:36 +0800, Macpaul Lin wrote:
> This change fixes these dtbs_check errors for audio-codec:
> 1. pmic: 'mt6359codec' does not match any of the regexes: 'pinctrl-[0-9]+'
>  - Replace device node name to generic 'audio-codec'
> 2. pmic: regulators: 'compatible' is a required property
>  - Add 'mediatek,mt6359-codec' to compatible.
> 
> 
> [...]

Applied to v6.14-next/dts64, thanks!

[1/1] arm64: dts: mediatek: mt6359: fix dtbs_check error for audio-codec
      commit: 76b35f59bbe66d3eda8a98021bc01f9200131f09

Cheers,
Angelo



