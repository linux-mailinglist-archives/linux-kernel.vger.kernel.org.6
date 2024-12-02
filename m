Return-Path: <linux-kernel+bounces-427513-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ECBEB9E023A
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 13:31:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9147A16C6B4
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 12:29:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47387205E1F;
	Mon,  2 Dec 2024 12:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mailerdienst.de header.i=@mailerdienst.de header.b="H6OlpM3/"
Received: from mxout1.routing.net (mxout1.routing.net [134.0.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5A23204F6B;
	Mon,  2 Dec 2024 12:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=134.0.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733142385; cv=none; b=iJAF0+zuUGaS0Rd9YmIDHvN32iN4c2LWrM3I3WPMhG8T3lWKDt02VZQrx/CKijp2avr7Mo5u+DqUOcBH4EvwPVKmM8JZNAcGsgAfac+s8tBdCeS8p4eHqmw/HJektD+mtrCMeglKqqqw8z8hFpywIXHTFHKkSJ61aO5yjKHhQxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733142385; c=relaxed/simple;
	bh=JNoYGLH1HgET2E5tGOcjzqAacuexDmIyfSJpY17q+20=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Bd0Y2M83Y5Xhso+zWkl0czlyhWdJMdNKvV9D+l+bcTuI0u0lsW6oRvf3XRhXR02GEGt++ArUA+LfN5CGaDjiw8JnOFjkRpuBWsF3NtDZ3CvTBL8SBP9OPqyWX9BGFNGGpzr2TDDYJpMJZQBVMFGltvjX3Un4qf0OUJApaM1xeSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fw-web.de; spf=pass smtp.mailfrom=fw-web.de; dkim=pass (1024-bit key) header.d=mailerdienst.de header.i=@mailerdienst.de header.b=H6OlpM3/; arc=none smtp.client-ip=134.0.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fw-web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fw-web.de
Received: from mxbox3.masterlogin.de (unknown [192.168.10.78])
	by mxout1.routing.net (Postfix) with ESMTP id 099BC41A49;
	Mon,  2 Dec 2024 12:26:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailerdienst.de;
	s=20200217; t=1733142377;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sOTUUuXSqJqOxLQg93hTp4f/UPGOv1pJxXtTWZSbqk0=;
	b=H6OlpM3/Aac3DMKCYY3xlXS2VM/daKxJhSSZuR+OZegz3mMh4L5ncx4xE7yzEMKh2v3Smc
	UkqjZL3DcYF/npJy+F2M0yGgG6OEr53vOrttMOir+BrBeL4GhMr83nh78TY0n37xAmUj3X
	xhl6YhDXYKNdAtAsqmEzPSK7/mkbt+E=
Received: from frank-u24.. (fttx-pool-217.61.149.104.bambit.de [217.61.149.104])
	by mxbox3.masterlogin.de (Postfix) with ESMTPSA id 77EDA360211;
	Mon,  2 Dec 2024 12:26:16 +0000 (UTC)
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
Subject: [PATCH v2 11/18] arm64: dts: mediatek: mt7988: add chosen node on bpi-r4
Date: Mon,  2 Dec 2024 13:25:52 +0100
Message-ID: <20241202122602.30734-12-linux@fw-web.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241202122602.30734-1-linux@fw-web.de>
References: <20241202122602.30734-1-linux@fw-web.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mail-ID: ce7d2449-692a-46b7-8c22-2fa241136984

From: Frank Wunderlich <frank-w@public-files.de>

Add chosen node on Bananapi R4 board with stdout and default bootargs.

Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
---
 arch/arm64/boot/dts/mediatek/mt7988a-bananapi-bpi-r4.dts | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt7988a-bananapi-bpi-r4.dts b/arch/arm64/boot/dts/mediatek/mt7988a-bananapi-bpi-r4.dts
index 9037f35857a9..1c2a806f6f6c 100644
--- a/arch/arm64/boot/dts/mediatek/mt7988a-bananapi-bpi-r4.dts
+++ b/arch/arm64/boot/dts/mediatek/mt7988a-bananapi-bpi-r4.dts
@@ -9,6 +9,11 @@ / {
 	model = "Banana Pi BPI-R4";
 	chassis-type = "embedded";
 
+	chosen {
+		stdout-path = &serial0;
+		bootargs = "console=ttyS0,115200n1";
+	};
+
 	reg_1p8v: regulator-1p8v {
 		compatible = "regulator-fixed";
 		regulator-name = "fixed-1.8V";
-- 
2.43.0


