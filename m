Return-Path: <linux-kernel+bounces-427519-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C5F509E0246
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 13:33:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C0D02B2B9B1
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 12:32:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EB141FECB8;
	Mon,  2 Dec 2024 12:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mailerdienst.de header.i=@mailerdienst.de header.b="BGoxqogn"
Received: from mxout1.routing.net (mxout1.routing.net [134.0.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 803601FC0F4;
	Mon,  2 Dec 2024 12:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=134.0.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733142745; cv=none; b=lDk2Fdi09m1wfEdGXBI2Av3tPoSHQTpxmsJXniWplXEizftMkUC0hO8zcknNHbHduO7sDUFrYPnv9N9G47scp54KnINRAojjN3oVDVz4am0qSWI/YYxstaj5aVXWQ0aM8pWQN1uBe2LMBM/FtAK37/WEz3Wtrm/5mXoyTQ85YWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733142745; c=relaxed/simple;
	bh=T4btWX95vEKJjhK49Q+yigukUUVBdZdBwUda8UrTQZM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BzyDCIPOVdWqymA8pApWohDNWYQS+s971wb1Wa1+xK6m8bg5C9DvFz+5Ou8enFUGP+sjSi1kVGtdjTnIXVlVKb3eEPPiUYWUpBUbGnkkLLNsszWKgU5uKK3pjW2wsnFkrsfDTgiPV1hN0XLhpBE8uuUNyY+IINdYLNK2AC0iMbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fw-web.de; spf=pass smtp.mailfrom=fw-web.de; dkim=pass (1024-bit key) header.d=mailerdienst.de header.i=@mailerdienst.de header.b=BGoxqogn; arc=none smtp.client-ip=134.0.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fw-web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fw-web.de
Received: from mxbox3.masterlogin.de (unknown [192.168.10.78])
	by mxout1.routing.net (Postfix) with ESMTP id 954E741044;
	Mon,  2 Dec 2024 12:26:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailerdienst.de;
	s=20200217; t=1733142370;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=uIVXD+ggnYVJ2OypdUsH1KMHttJYvEwI8nTci5/ARXk=;
	b=BGoxqognHJL0UXPkeLLMu5yMPfM+090AIv5wTybZ9N/nVz8TIs01vPqbwggxtfQXFbm4Lh
	KwvViq644H+2+cwCslnQ/d+Nv32KxcQDJZ/mEvF/DmdELr5Ugien5JkHDrYqb+vhE3DAe+
	FKNQpwkVlaiN1tB7QXzDKWQgIjRslTI=
Received: from frank-u24.. (fttx-pool-217.61.149.104.bambit.de [217.61.149.104])
	by mxbox3.masterlogin.de (Postfix) with ESMTPSA id E2D253600C0;
	Mon,  2 Dec 2024 12:26:09 +0000 (UTC)
From: Frank Wunderlich <linux@fw-web.de>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: Frank Wunderlich <frank-w@public-files.de>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH v2 00/18] continue mt7988 devicetree work
Date: Mon,  2 Dec 2024 13:25:41 +0100
Message-ID: <20241202122602.30734-1-linux@fw-web.de>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mail-ID: 9e46718b-c2e1-4f2d-94be-63a5bc01281d

From: Frank Wunderlich <frank-w@public-files.de>

This series adds some missing labels and new nodes to mt7988 DTS.

based on pinctrl-series
https://patchwork.kernel.org/project/linux-mediatek/list/?series=913700

changes:
v2:
- reorder and squash label-commits to where they are used
- add some more nodes
- add changes to bananapi-r4 board
- moving some nodes from SoC dtsi to board dts

Frank Wunderlich (18):
  arm64: dts: mediatek: mt7988: enable watchdog on bpi-r4
  arm64: dts: mediatek: mt7988: add mmc support
  arm64: dts: mediatek: mt7988: add fixed regulators for 1v8 and 3v3
  arm64: dts: mediatek: mt7988: add lvts node
  arm64: dts: mediatek: mt7988: add thermal-zone
  arm64: dts: mediatek: mt7988: add thermal trips to bpi-r4
  arm64: dts: mediatek: mt7988: add reserved memory
  arm64: dts: mediatek: mt7988: add mcu-sys node for cpu
  arm64: dts: mediatek: mt7988: add operating-points
  arm64: dts: mediatek: mt7988: enable serial0 on bpi-r4
  arm64: dts: mediatek: mt7988: add chosen node on bpi-r4
  arm64: dts: mediatek: mt7988: add missing clock-div property for i2c
  arm64: dts: mediatek: mt7988: add i2c to bpi-r4 board
  arm64: dts: mediatek: mt7988: add pmic on bpi-r4
  arm64: dts: mediatek: mt7988: add proc-supply for cpus on bpi-r4
  arm64: dts: mediatek: mt7988: add i2c-mux on bpi-r4
  arm64: dts: mediatek: mt7988: enable ssusb1 on bpi-r4
  arm64: dts: mediatek: mt7988: enable pwm on bpi-r4

 .../dts/mediatek/mt7988a-bananapi-bpi-r4.dts  | 186 ++++++++++++++++++
 arch/arm64/boot/dts/mediatek/mt7988a.dtsi     | 137 +++++++++++--
 2 files changed, 311 insertions(+), 12 deletions(-)

-- 
2.43.0


