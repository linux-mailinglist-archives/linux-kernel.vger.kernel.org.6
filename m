Return-Path: <linux-kernel+bounces-440280-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DA2809EBB34
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 21:55:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 920C4166B9B
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 20:55:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A91B922CBCD;
	Tue, 10 Dec 2024 20:54:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="X55KkPeF"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3B2922B5BA;
	Tue, 10 Dec 2024 20:54:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733864091; cv=none; b=S60HozQkGzroxRHNS3VdObd1fJ3tvbq63SCzi8DtJQP5YculTK+kjj27E2QwHm2QAEDMXNzGm1CbQwxrfGkLQungk4PmYjzOSJIRghAuDVP1desp/J8i0Cv4h14K2M8AsO+seIhH7Q857Q7HpQqMerxWRPuzu9p0JLCtN4MCq5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733864091; c=relaxed/simple;
	bh=NDN0SnBLoWNiGYnla0Xah/O39AF4IpvBlJqD83Budgg=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=O9UhpKXRi/RO4MPfLqgwUTPtB6iBRAZT5MJ3LfCkcMFMtpiiBSVSLodSiXJl8ljeNs5sQpqOWzxxeo00CEuVICyJHlqVTyXGMu9yVfhSQwxmkdbAEsGlXWAO28WQH9K54HRY9jz9qhE1kHo4AW9KCFwlyUiqEUimQ+TTVU67yd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=X55KkPeF; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1733864087;
	bh=NDN0SnBLoWNiGYnla0Xah/O39AF4IpvBlJqD83Budgg=;
	h=From:Subject:Date:To:Cc:From;
	b=X55KkPeFFbbC1PUtd8IqdC6yhu9RZlxMgJdIe5Gnb0ee9wLreXlu1HVHk6JqNxsAX
	 OoFPQF7vhBVfG1TNLa15E3Z4YOaSdikSybexOAogUTaIpPphzgaLB0mrE0SbygcssL
	 ZM++8Z9PXzFY7jf3qhS9Kc+hBrKRWlSOkMGIAw7AEQ8EA2U0AKdVJ7kp8BwzPwJ1lf
	 PzeVxxTaRo2J5NZMJKQfaetDeHKPvJvEHI1sjD9jVh9pLMcHdrH7RewJYIwZLN3bfA
	 Eq6bMJ/nRTzK2isBk+hUdaq1/VvCYmbK693akW0fngbtBUPQfUEUc/fPuqE9rbTRRl
	 aFtXlQ/d9HIdw==
Received: from [192.168.0.47] (unknown [IPv6:2804:14c:1a9:53ee::1001])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: nfraprado)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 1976417E3802;
	Tue, 10 Dec 2024 21:54:42 +0100 (CET)
From: =?utf-8?q?N=C3=ADcolas_F=2E_R=2E_A=2E_Prado?= <nfraprado@collabora.com>
Subject: [PATCH v2 0/2] Enable audio output for Genio 700 EVK board
Date: Tue, 10 Dec 2024 17:54:27 -0300
Message-Id: <20241210-genio700-audio-output-v2-0-c50886ae0be2@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAIOqWGcC/3WNQQqDMBBFryKz7pQkKGpXvUdxEeOoA9aRJEqLe
 PemQpddvgf//R0CeaYAt2wHTxsHljmBuWTgRjsPhNwlBqNMro3KcaCZpVQK7dqxoKxxWSP2ra1
 6Q63ttIK0XTz1/Dq7jybxyCGKf583m/7aX7H4U9w0KlRUF4UrK2dqujuZJtuKt1cnT2iO4/gAM
 dKh6L4AAAA=
X-Change-ID: 20241204-genio700-audio-output-fba8f2ebad10
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Trevor Wu <trevor.wu@mediatek.com>
Cc: kernel@collabora.com, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, linux-sound@vger.kernel.org, 
 =?utf-8?q?N=C3=ADcolas_F=2E_R=2E_A=2E_Prado?= <nfraprado@collabora.com>, 
 Aary Patil <aary.patil@mediatek.com>, 
 Suhrid Subramaniam <suhrid.subramaniam@mediatek.com>, 
 parkeryang <Parker.Yang@mediatek.com>
X-Mailer: b4 0.14.2

This series enables audio output support for the Genio 700 EVK board.
Patch 1 adds the missing #sound-dai-cells property in the MT6359 node as
a prerequisite, and patch 2 describes the audio DT nodes to get audio
output working on the two audio jacks, Earphone and Speaker, present on
the board.

Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
---
Changes in v2:
- Dropped merged/unnecessary patches (2, 3, 4)
- Removed unnecessary mediatek,dai-link property
- Link to v1: https://lore.kernel.org/r/20241205-genio700-audio-output-v1-0-0e955c78c29e@collabora.com

---
Nícolas F. R. A. Prado (2):
      arm64: dts: mt6359: Add #sound-dai-cells property
      arm64: dts: mediatek: mt8390-genio-700-evk: Add sound output support

 arch/arm64/boot/dts/mediatek/mt6359.dtsi           |  1 +
 .../boot/dts/mediatek/mt8390-genio-700-evk.dts     | 48 ++++++++++++++++++++++
 2 files changed, 49 insertions(+)
---
base-commit: d1486dca38afd08ca279ae94eb3a397f10737824
change-id: 20241204-genio700-audio-output-fba8f2ebad10

Best regards,
-- 
Nícolas F. R. A. Prado <nfraprado@collabora.com>


