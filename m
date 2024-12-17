Return-Path: <linux-kernel+bounces-448905-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D5EB9F4708
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 10:14:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EAAD918833DB
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 09:14:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BFEB1E9B34;
	Tue, 17 Dec 2024 09:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mailerdienst.de header.i=@mailerdienst.de header.b="xR7DGNE3"
Received: from mxout1.routing.net (mxout1.routing.net [134.0.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB3221E00BD;
	Tue, 17 Dec 2024 09:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=134.0.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734426782; cv=none; b=hzYjg7EjWA4gonHW4CmrmvArz+CPihPGqVAJn8s3yae5CTqoq3bkTiVl2FQv2qgn/0Q60mRDvpQwKDKjLzB+vNPRA84BDi/yVW9Dht/ks1ZW7oIPos40WT9mMfK1DRHZWSITfcYeSYe/Ax4S0sGZq8CA38DR+YD3ozxWpeHxCp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734426782; c=relaxed/simple;
	bh=TjSeqzAtQUORlnor6Rlo24byTI6cGTclnAejzshRHO4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HyjLz91fRnCkZSV0VOq8vM0ogsgP03/YVul+mPP92YdgowwMZ1p9jEe8wBS7ysaaADnRPoPeuD+qZsYHbVG6Tx744kqnJP3yrviWxwUjd7mMbeAlsYrhsMtbBJSYNipAI39BvgU3f17Jaq26aRIdARmK/LfLjD8hz8nnW7nEOL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fw-web.de; spf=pass smtp.mailfrom=fw-web.de; dkim=pass (1024-bit key) header.d=mailerdienst.de header.i=@mailerdienst.de header.b=xR7DGNE3; arc=none smtp.client-ip=134.0.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fw-web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fw-web.de
Received: from mxbox2.masterlogin.de (unknown [192.168.10.89])
	by mxout1.routing.net (Postfix) with ESMTP id 6BB7D3FE32;
	Tue, 17 Dec 2024 09:12:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailerdienst.de;
	s=20200217; t=1734426779;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0W5WwAem8dpZHSS34J2J4eQ29iT5ELnc6lnNChNApFA=;
	b=xR7DGNE3NSYgxtHz7eGu8NJVVQ373JNIsf0S/nicWv/NH7NBoFlqNbrttBFjlcE3vi90tp
	li4VersP0S7ayqwSCELMWtdPZKk/yOtYeAOA+imCq8EuRK2bGQRRb+aPagozi8GEtUrhma
	8z3Mh6Iiw94Yu98IDhXMliQT2s46ZFQ=
Received: from frank-u24.. (fttx-pool-217.61.150.187.bambit.de [217.61.150.187])
	by mxbox2.masterlogin.de (Postfix) with ESMTPSA id 8E2DF1004DD;
	Tue, 17 Dec 2024 09:12:58 +0000 (UTC)
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
Subject: [PATCH v3 11/22] arm64: dts: mediatek: mt7988a-bpi-r4: Enable watchdog
Date: Tue, 17 Dec 2024 10:12:25 +0100
Message-ID: <20241217091238.16032-12-linux@fw-web.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241217091238.16032-1-linux@fw-web.de>
References: <20241217091238.16032-1-linux@fw-web.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mail-ID: 9aa7e1fb-a7b2-4dad-849a-4d9e56f36875

From: Frank Wunderlich <frank-w@public-files.de>

Enable the watchdog on Bananapi R4 board.

Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
changes:
v3: change commit title to include prefix for r4
---
 arch/arm64/boot/dts/mediatek/mt7988a-bananapi-bpi-r4.dts | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt7988a-bananapi-bpi-r4.dts b/arch/arm64/boot/dts/mediatek/mt7988a-bananapi-bpi-r4.dts
index aa2dabc041fd..d914eae2b524 100644
--- a/arch/arm64/boot/dts/mediatek/mt7988a-bananapi-bpi-r4.dts
+++ b/arch/arm64/boot/dts/mediatek/mt7988a-bananapi-bpi-r4.dts
@@ -198,3 +198,7 @@ mux {
 		};
 	};
 };
+
+&watchdog {
+	status = "okay";
+};
-- 
2.43.0


