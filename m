Return-Path: <linux-kernel+bounces-386707-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F5B59B4736
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 11:48:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D006FB213F3
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 10:48:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBF11205120;
	Tue, 29 Oct 2024 10:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mailerdienst.de header.i=@mailerdienst.de header.b="HgHT8SI0"
Received: from mxout2.routing.net (mxout2.routing.net [134.0.28.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53EB52038B2;
	Tue, 29 Oct 2024 10:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=134.0.28.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730198870; cv=none; b=FfWlb/PMk1JkW2LK8rBtn/AltdUxta57R9ajtdrIF6GCf6yil3+EweLbzK908MssyWiYaG7x19NvpcD/dpRvFEgMDtucKMyXBnx5mTuq8o/m9GFvP7n9rGhNb8yxR5xU7xb1vUcxejZDWSAllAycL/ppihxlbcii7Kw3nBVs7GA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730198870; c=relaxed/simple;
	bh=R6+Kfep9x1yc1k/Le/VE9nl3JdJsgSCoDMYkEJqfmzM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nkDtLiZCIqK0Hmf0bSaF5rHOkBG1v8f1KanLl3nzNqfDLurChTGmhkURDh098vqai40fvSn1JPdnvNW+zMgfh9xh0jWvEJzxpRUnALJwX1HlaQBNer45x648R2XeeqajJCtTYiZJpIxlzvq+Pu3NMS7p4IXKjjnBjBkyoXYyAfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fw-web.de; spf=pass smtp.mailfrom=fw-web.de; dkim=pass (1024-bit key) header.d=mailerdienst.de header.i=@mailerdienst.de header.b=HgHT8SI0; arc=none smtp.client-ip=134.0.28.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fw-web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fw-web.de
Received: from mxbox3.masterlogin.de (unknown [192.168.10.78])
	by mxout2.routing.net (Postfix) with ESMTP id E4F226021B;
	Tue, 29 Oct 2024 10:39:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailerdienst.de;
	s=20200217; t=1730198384;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nAG53wtz8oKYi+8ALTcdS4fgknUjRs99/WlbWTdaX44=;
	b=HgHT8SI09081mzFVgeTV1W1ugGCj+0n4BbNumhT3MdzQKQ4LDcRecnUcaWn1q7o2IIo4kB
	VhVmP7ThXSu53Ra5zNkM9CkqvzGxeUN2KSvzYx/PZ1iClattoa0jnfnkWTe+yITDmPH1Zg
	1UnjUyB5SLIDpH/3vNImObPZS3MmAbc=
Received: from frank-u24.. (fttx-pool-80.245.73.173.bambit.de [80.245.73.173])
	by mxbox3.masterlogin.de (Postfix) with ESMTPSA id 4D6C936037C;
	Tue, 29 Oct 2024 10:39:43 +0000 (UTC)
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
Subject: [RFC v1 01/14] arm64: dts: mediatek: mt7988: add missing label for apmixedsys
Date: Tue, 29 Oct 2024 11:39:20 +0100
Message-ID: <20241029103937.45852-2-linux@fw-web.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241029103937.45852-1-linux@fw-web.de>
References: <20241029103937.45852-1-linux@fw-web.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mail-ID: 08f7d28b-29f0-426f-acbe-c3b9b6e7ff85

From: Frank Wunderlich <frank-w@public-files.de>

Add Label to allow easier referencing in dtsi and board dts.

Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
---
 arch/arm64/boot/dts/mediatek/mt7988a.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/mediatek/mt7988a.dtsi b/arch/arm64/boot/dts/mediatek/mt7988a.dtsi
index 46969577c87a..5b93c2c843e0 100644
--- a/arch/arm64/boot/dts/mediatek/mt7988a.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt7988a.dtsi
@@ -100,7 +100,7 @@ watchdog: watchdog@1001c000 {
 			#reset-cells = <1>;
 		};
 
-		clock-controller@1001e000 {
+		apmixedsys: clock-controller@1001e000 {
 			compatible = "mediatek,mt7988-apmixedsys";
 			reg = <0 0x1001e000 0 0x1000>;
 			#clock-cells = <1>;
-- 
2.43.0


