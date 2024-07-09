Return-Path: <linux-kernel+bounces-245814-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0586092B9BF
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 14:42:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3785D1C21E1B
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 12:42:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FE6115A84D;
	Tue,  9 Jul 2024 12:42:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="ancl+B9/"
Received: from www530.your-server.de (www530.your-server.de [188.40.30.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAA88158D6A;
	Tue,  9 Jul 2024 12:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.40.30.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720528942; cv=none; b=sekQMrC3Ra3QnM4FUnmsVuMfZ7Lw9APt4/KHJfBqtovZk8Q4NOMhTErPzqCBlmvQq0H9MIoPX39/gGHHwVWDv/BOfNxZJyyV20lXoIdE39rwnLAOF8oSy8uasl3TCjhcHjGrLycvT5PepeFGzbNrQjsM68zEDO7LqmaEoqWLRBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720528942; c=relaxed/simple;
	bh=LRv8f1wr7502luzov9ObS+8pANTSCs3QeOmSBUJY1jA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tzCC2yg9R57lG4pR2GtVy9KTggGRjUwCbbGklbo62bLVN/g0i2HzxHLLADdHWIVZYZsafGIqpPCWkavC0J78y45m3/+/jQb2uqcEtf4cNQBRE1PZlX0gsIKv2x1QYVxAeszRlMbRJtdyPbe7wx9zvFbzVAht62uH4XJdml+4tOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=geanix.com; spf=pass smtp.mailfrom=geanix.com; dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b=ancl+B9/; arc=none smtp.client-ip=188.40.30.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=geanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=geanix.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=geanix.com;
	s=default2211; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:
	Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References;
	bh=KTFnKX/Tz5FoE0vj9XJJB3ATiZqKxMooQslAEcSOCGY=; b=ancl+B9/JMTaxg5lz1FfRltgD0
	UMFtD8LBi52bkM5+mhDuskOnERbXQcGURPhilfJt1aSjumzjZildNZ/vE9EG+IjtYCyxcT4hYXDvV
	A/8JSHuKSabBTNGNzh2MRsNXJnsqa427bZbno71ntDMVzkuy6N6x8f45pDBg0lrZJ9n+PGQp/gSpU
	nj7/rhD9eFjveb2AmILV9oO2Ho17NWGAMYl21QZHdjr1wC+W79tXBsn1YXEQOhObc4i7sQk5TBk8U
	yRgHrnI7Iln+JZbWwLodF2oKJzSfTNhKZ+rgZCxdWpxIE+FZHqt1voUkYK+FKNX3BA26iIRY4bwvv
	WyYbmsPw==;
Received: from sslproxy03.your-server.de ([88.198.220.132])
	by www530.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <sean@geanix.com>)
	id 1sR9mh-000MNl-Ln; Tue, 09 Jul 2024 14:17:27 +0200
Received: from [185.17.218.86] (helo=zen..)
	by sslproxy03.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <sean@geanix.com>)
	id 1sR9mg-000NY1-2c;
	Tue, 09 Jul 2024 14:17:26 +0200
From: Sean Nyekjaer <sean@geanix.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Marcin Sloniewski <marcin.sloniewski@gmail.com>,
	Ahmad Fatoum <a.fatoum@pengutronix.de>
Cc: Sean Nyekjaer <sean@geanix.com>,
	Alexandre Torgue <alexandre.torgue@st.com>,
	devicetree@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] ARM: dts: stm32: Add missing gpio options for sdmmc2_d47_pins_d
Date: Tue,  9 Jul 2024 14:16:18 +0200
Message-ID: <20240709121619.1588520-1-sean@geanix.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: sean@geanix.com
X-Virus-Scanned: Clear (ClamAV 0.103.10/27331/Tue Jul  9 10:38:11 2024)

This enables DDR50 mode for the eMMC on Octavo OSD32MP1-RED board.

Fixes: be78ab4f632c ("ARM: dts: stm32: add initial support for stm32mp157-odyssey board")
Signed-off-by: Sean Nyekjaer <sean@geanix.com>
---
 arch/arm/boot/dts/st/stm32mp15-pinctrl.dtsi | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/boot/dts/st/stm32mp15-pinctrl.dtsi b/arch/arm/boot/dts/st/stm32mp15-pinctrl.dtsi
index ae83e7b10232..70e132dc6147 100644
--- a/arch/arm/boot/dts/st/stm32mp15-pinctrl.dtsi
+++ b/arch/arm/boot/dts/st/stm32mp15-pinctrl.dtsi
@@ -2229,6 +2229,9 @@ pins {
 				 <STM32_PINMUX('A', 9, AF10)>, /* SDMMC2_D5 */
 				 <STM32_PINMUX('E', 5, AF9)>, /* SDMMC2_D6 */
 				 <STM32_PINMUX('C', 7, AF10)>; /* SDMMC2_D7 */
+			slew-rate = <1>;
+			drive-push-pull;
+			bias-pull-up;
 		};
 	};
 
-- 
2.45.2


