Return-Path: <linux-kernel+bounces-419059-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EDCD79D6906
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Nov 2024 13:42:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2A74D281861
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Nov 2024 12:42:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3276188583;
	Sat, 23 Nov 2024 12:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b="m7vYdD4C"
Received: from fw2.prolan.hu (fw2.prolan.hu [193.68.50.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4351F18EB0;
	Sat, 23 Nov 2024 12:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.68.50.107
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732365737; cv=none; b=hXCzzYzcE0+6bLEeBTHPU1X1CEFJQmPaU0an/o0sVCEASPnw9Vi1ZXV4U6SW8iK2CS0e2L3JfZGyTZ4ZtSGbc61D9RsiMjptC5MU0N5r1ndb6XU/VkqUv/rtmkOCPvyEmg4ypOO/EjBwDyruCKetGH0CbZ6VzAK2L0jT9g49cPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732365737; c=relaxed/simple;
	bh=XLt+eL6gvGf0WeHymcab1DvojRf4zp0Tlj9cL0/wZIo=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Y7UyYkajfYLa6SVEgfWI30rx+hgf8l0d3Iu+U3y+N7w+qp24rDgq8dh9Bk3sUKnL7NGHt4KQMyg0vZWj8FGwLcCkLzpQZhrzwrmShMWEzjyOs8X/5ZPsRAZ9HPp3YbuAivcTsb8kc+V035vskuYkihUAZNOU+qsWMS5xdK3bi8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu; spf=pass smtp.mailfrom=prolan.hu; dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b=m7vYdD4C; arc=none smtp.client-ip=193.68.50.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=prolan.hu
Received: from proxmox-mailgw.intranet.prolan.hu (localhost.localdomain [127.0.0.1])
	by proxmox-mailgw.intranet.prolan.hu (Proxmox) with ESMTP id 33191A0302;
	Sat, 23 Nov 2024 13:42:05 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prolan.hu; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:from:from:message-id:mime-version:reply-to:subject:subject:to
	:to; s=mail; bh=YbLZjplGEQIjdXszpZTw4vmkavVtRiLv7/HeUvS1y6Y=; b=
	m7vYdD4CUbhmbR53UkvxOK/TK4UYu/0dzaiSpkTHsbSOn/w+C9+PB3bK+Rx4OugB
	vzKmBP8GsuGe3a/fwmnPnqU5CDbEJwrLZiy4jGZKUgu3KRnJMZa8Uk5+m9j2rIMZ
	CRHq4s20Sp2T/zJhH322B1h87P4DQDLPLea3beVq7nSmB8+sr0zQC7BuSIvh3GqQ
	LKfwa+Wr1jCj27c8gXcIpf2n3BpgFpyDFEAMvsfwSXFm9VzJLSnXBTzQc1r3MNAo
	YTIVenfri5KnvRymrIWYSqU9IdQrNnpRUt8frMbWl8UCFNhg9ef3lksrnNbWTYex
	+yiQAj3gauhR4uwUjfjwqgh0jMDZttHf7FDs0AVqQVY5qv7G1LWfgw3Lb+I+UVIx
	IVvXAtx2qJgJ5QXWmaC+1F4u/X4kudFQawlTXmalQLgAuPG/LONAQGX3N6Ef6J3V
	A8vaUXfca5DngT07aNY1YA6vvY4WBdwek8oxfBinHpg3kueP0BOK+oOZDvRiz2Xu
	AImB+RaN0GrDud+sM8S5RvAAGaZQZmRWcK8xrZ1FqCa/fZcH0cFrsZSvdjOe9Q+e
	iEzTia0PF0KS1wcvTFQGESQuY1fuWT7n9QtHK8sqsFakSlH3MaD7kMY6VDm+phN6
	F95SmWDXFSbc13pvAD89hQLqi3HBsU+csH+H2uNphcI=
From: =?UTF-8?q?Cs=C3=B3k=C3=A1s=2C=20Bence?= <csokas.bence@prolan.hu>
To: <linux-sound@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-sunxi@lists.linux.dev>, <linux-kernel@vger.kernel.org>
CC: =?UTF-8?q?Cs=C3=B3k=C3=A1s=2C=20Bence?= <csokas.bence@prolan.hu>, "Mesih
 Kilinc" <mesihkilinc@gmail.com>, Liam Girdwood <lgirdwood@gmail.com>, "Mark
 Brown" <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai
	<tiwai@suse.com>, Chen-Yu Tsai <wens@csie.org>, Jernej Skrabec
	<jernej.skrabec@gmail.com>, Samuel Holland <samuel@sholland.org>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, Maxime Ripard <mripard@kernel.org>
Subject: [PATCH v6 0/3] Add support for codec of F1C100s
Date: Sat, 23 Nov 2024 13:38:55 +0100
Message-ID: <20241123123900.2656837-1-csokas.bence@prolan.hu>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ESET-AS: R=OK;S=0;OP=CALC;TIME=1732365724;VERSION=7980;MC=2816337656;ID=80950;TRN=0;CRV=0;IPC=;SP=0;SIPS=0;PI=3;F=0
X-ESET-Antispam: OK
X-EsetResult: clean, is OK
X-EsetId: 37303A29ACD9485560726B

Support for Allwinner F1C100s/200s series audio was
submitted in 2018 as an RFC series, but was not merged,
despite having only minor errors. However, this is
essential for having audio on these SoCs.
This series was forward-ported/rebased to the best of
my abilities, on top of Linus' tree as of now:
commit 28eb75e178d3 ("Merge tag 'drm-next-2024-11-21' of https://gitlab.freedesktop.org/drm/kernel")

Link: https://lore.kernel.org/all/cover.1543782328.git.mesihkilinc@gmail.com/

As requested by many, this series will now be split in 2, the DMA and the
ALSA/ASoC codec driver. This is the codec part of the series.
The first part (DMA) is at the link below. The first 3 patches of this
series can be applied and built without the former series, but for working
audio you need them both, plus the last 2 Device Tree patches in this series.
Link: https://lore.kernel.org/linux-kernel/20241122161128.2619172-1-csokas.bence@prolan.hu/

Csókás, Bence (1):
  dt-bindings: sound: Add Allwinner suniv F1C100s Audio Codec

Mesih Kilinc (4):
  ASoC: sun4i-codec: Add DMA Max Burst field
  ASoC: sun4i-codec: Add support for Allwinner suniv F1C100s
  ARM: dts: suniv: f1c100s: Add support for Audio Codec
  ARM: dts: suniv: f1c100s: Activate Audio Codec for Lichee Pi Nano

 .../sound/allwinner,sun4i-a10-codec.yaml      |  31 ++
 .../allwinner/suniv-f1c100s-licheepi-nano.dts |   8 +
 .../arm/boot/dts/allwinner/suniv-f1c100s.dtsi |  14 +
 sound/soc/sunxi/sun4i-codec.c                 | 367 +++++++++++++++++-
 4 files changed, 418 insertions(+), 2 deletions(-)

-- 
2.34.1



