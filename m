Return-Path: <linux-kernel+bounces-386737-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D579C9B478E
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 11:57:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 12B261C213DB
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 10:57:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E48C205E0B;
	Tue, 29 Oct 2024 10:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mailerdienst.de header.i=@mailerdienst.de header.b="HpbWarL4"
Received: from mxout3.routing.net (mxout3.routing.net [134.0.28.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F251205AD9;
	Tue, 29 Oct 2024 10:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=134.0.28.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730198963; cv=none; b=JKe21S+y5XWZ2SEyI8g4s/qD21n0G4rAloYw/znCPqI1eOsmsOT7Mdaa0NU7YoRew4dcsTMNP3z+K4YfYeTyxdQbiaV2z5/0807m64HbP+P6gTvS1x5h1zQNsbHJL9h7gWM4RSKr0cuOSGY6PDdUb9psu0kgv5mqCLsAtimLwPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730198963; c=relaxed/simple;
	bh=2dFR/80HTaKveqrkW6jZEUv17yaPHGwJ3QGgE6j6qGU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fRevLui9UXFbV3pn4uHhMk4jiKQuOZkVoVPqywvLw2/wYNWk0fQsxH0geI7Gqne06Qc/X2QKeKkI6D93wb2SUtxLb/3Q76F64WKmMmlVTA7vrXW/lbZnkqQfU6YEfWdMWDk6Q+WHwlNu1f7iFBEMhRGm809KYvIl4WzX/adl7bU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fw-web.de; spf=pass smtp.mailfrom=fw-web.de; dkim=pass (1024-bit key) header.d=mailerdienst.de header.i=@mailerdienst.de header.b=HpbWarL4; arc=none smtp.client-ip=134.0.28.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fw-web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fw-web.de
Received: from mxbox3.masterlogin.de (unknown [192.168.10.78])
	by mxout3.routing.net (Postfix) with ESMTP id 4D0CD61620;
	Tue, 29 Oct 2024 10:39:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailerdienst.de;
	s=20200217; t=1730198383;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=M1NzIDk/zjZn+p9F0pg3KmI2reD3ofe4GIXlaqHK0ds=;
	b=HpbWarL4vYFyplMfLBsstBRfZ1NyTw3Fw9nqnTPn/W7mZE9LkovSRMSbS3kvNxsEA+5Xt0
	+Le5S8v7T5GycCoXmUBjZ+Z3X0y0s1pp5Zsd1kiTlb978XU2N534PxFiUDLBw476MbOSmh
	nYi1tX2JzIG0T/+criCQRfmB+fNXeD8=
Received: from frank-u24.. (fttx-pool-80.245.73.173.bambit.de [80.245.73.173])
	by mxbox3.masterlogin.de (Postfix) with ESMTPSA id 896653600D8;
	Tue, 29 Oct 2024 10:39:42 +0000 (UTC)
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
Subject: [RFC v1 00/14] Add some mt7988 DTS labels and new nodes
Date: Tue, 29 Oct 2024 11:39:19 +0100
Message-ID: <20241029103937.45852-1-linux@fw-web.de>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mail-ID: 1dafb263-a617-4e48-b72c-736ee605b004

From: Frank Wunderlich <frank-w@public-files.de>

This series adds some missing labels and new nodes to mt7988 DTS.

If wanted i can squash the coommits adding labels to have less patches,
but for first review i let them separate.

Frank Wunderlich (14):
  arm64: dts: mediatek: mt7988: add missing label for apmixedsys
  arm64: dts: mediatek: mt7988: add labels for i2c nodes
  arm64: dts: mediatek: mt7988: add labels for usb nodes
  arm64: dts: mediatek: mt7988: add serial labels
  arm64: dts: mediatek: mt7988: add label for pwm node
  arm64: dts: mediatek: mt7988: add label for efuse
  arm64: dts: mediatek: mt7988: add mmc support
  arm64: dts: mediatek: mt7988: add fixed regulators for 1v8 and 3v3
  arm64: dts: mediatek: mt7988: extend efuse node
  arm64: dts: mediatek: mt7988: add lvts node
  arm64: dts: mediatek: mt7988: add thermal-zone
  arm64: dts: mediatek: mt7988: add reserved memory
  arm64: dts: mediatek: mt7988: add mcu-sys node for cpu
  arm64: dts: mediatek: mt7988: add operating-points

 arch/arm64/boot/dts/mediatek/mt7988a.dtsi | 196 ++++++++++++++++++++--
 1 file changed, 181 insertions(+), 15 deletions(-)

-- 
2.43.0


