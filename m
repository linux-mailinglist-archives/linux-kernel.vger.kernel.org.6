Return-Path: <linux-kernel+bounces-283135-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2642194EDB3
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 15:06:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CCEDE1F210FA
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 13:06:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F8B017BB32;
	Mon, 12 Aug 2024 13:06:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="CnNB9pcn";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="dEXbQ3q+"
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8951175D45;
	Mon, 12 Aug 2024 13:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723468006; cv=none; b=lekF1x1FLo5xDo/LkK99/4sqMiZkDugjriIi63rAx/Qd92NCBUiyGrwkdaoiA0jX8scL1hSkIY81rhmn7BPxbCDqghQoYy0WErInwaoXl0c0O0eVG6cYFCyvdbJuY3NwH9byrmM2uLeF+ic+KPYKs4CjWkZW6vhbbfcTWsBYHvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723468006; c=relaxed/simple;
	bh=4ycj7qkoaU+ecW9Ztj6eFtAdV4gPsJFk/M1APr36D5w=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=FPGx2BCcrcU0MWrkPFCycUSe6wMxSF0f9vAD0X4oXZENiFHJDDc4R3h1YExW64Vs4CxQ5U07raQAZcHFw3rwbubpWiQKo0A+dfb0BVF/yKFLGfgShFlV+3GZoGrv0aY8XGDpzEbFPur7LBq9XwZcGucDRiAdAjlI+Kr9ddO6YPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=CnNB9pcn; dkim=fail (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=dEXbQ3q+ reason="key not found in DNS"; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1723468002; x=1755004002;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Dva4abrryEv4enlCuMBSl0BO5YyP15MlHbz8/ylANBg=;
  b=CnNB9pcn4+XiAYhXshqOoqTdCIapFDpZ00dHM9KhhlmgBv6KV2y2lEBJ
   /CUDCidiTESDFZzRQL9wEOs8tCkVnStNgJwRkKgbQnNjL9PDXHIVAWiS9
   Ezs9WqWqf/gbp+lp8WYQfG+7uBpYzGH3GEDQ41murYr7E3ghvuE/mm+9d
   35xY0WmcvZgtkk0zvzjcfKie0w7kcj8uVvzTSi4kemoLrLUbYLFce+iwc
   RNqC4oXHRIdt+BTClT0uCSFJwNKeuG6tqFDP0c69puK7r60jBO6ek1Qkf
   seAwl1Vw4KvUJ8wDQZaS2xshMjCH4so1YUQWDlEOlWZNBjMLQT/THCUEy
   Q==;
X-CSE-ConnectionGUID: hTc5B/2MSFyLkPj5qOZy/w==
X-CSE-MsgGUID: La8Gw4Q3SZqB9Eyznb4Ntw==
X-IronPort-AV: E=Sophos;i="6.09,283,1716242400"; 
   d="scan'208";a="38363820"
Received: from vmailcow01.tq-net.de ([10.150.86.48])
  by mx1.tq-group.com with ESMTP; 12 Aug 2024 15:06:39 +0200
X-CheckPoint: {66BA08DF-1D-CD6ACE3E-F977C2C0}
X-MAIL-CPID: 810B3F6CEC151C3B3BE02C9F9516F1E7_1
X-Control-Analysis: str=0001.0A782F18.66BA08DF.0163,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id CB6C7161336;
	Mon, 12 Aug 2024 15:06:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ew.tq-group.com;
	s=dkim; t=1723467995; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding; bh=Dva4abrryEv4enlCuMBSl0BO5YyP15MlHbz8/ylANBg=;
	b=dEXbQ3q+3fPnZIpHKfeCpVSfFs4shyF/nHWfSRCnq3zzN+7Gs95gUAEwxh1NNy42YQZuVP
	Vw5RGDFugJfeJP0otcnmiuIkhwSDVT2UU1eQr1jkhGuWhwoIqWX1aHtKI/9wg8UiYA4he8
	NEoelBENnwNjYhm1J6bZHmSmMR4dteaepjwr/4HQaWUo0vyZHEcWk+hAi7yMexjo5a9GAw
	MTz0sGYm31Z6HGhBmEJW1PHgKEuzNLTrSOF3TeTY6ATcu+fjXoqPcq5kEaJK6DyhFIbIbA
	RiVRUbXuZ5EzmMtd60Kx0ADMY0AHLJioTuPfaQ592/awHu4xb5unmBhSRcbPhA==
From: Alexander Stein <alexander.stein@ew.tq-group.com>
To: Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: Alexander Stein <alexander.stein@ew.tq-group.com>,
	linux@ew.tq-group.com,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/1] arm64: dts: mba8mx: Add Ethernet PHY IRQ support
Date: Mon, 12 Aug 2024 15:06:36 +0200
Message-Id: <20240812130636.180483-1-alexander.stein@ew.tq-group.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

The interrupt pin of the PHY is connected to the GPIO expander, configure
it accordingly.

Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
---
Changes in v2:
* Fix context (wrong local rebase)

 arch/arm64/boot/dts/freescale/mba8mx.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/mba8mx.dtsi b/arch/arm64/boot/dts/freescale/mba8mx.dtsi
index 815241526a0d3..8d898506b3bce 100644
--- a/arch/arm64/boot/dts/freescale/mba8mx.dtsi
+++ b/arch/arm64/boot/dts/freescale/mba8mx.dtsi
@@ -185,6 +185,8 @@ ethphy0: ethernet-phy@e {
 			reset-gpios = <&expander2 7 GPIO_ACTIVE_LOW>;
 			reset-assert-us = <500000>;
 			reset-deassert-us = <500>;
+			interrupt-parent = <&expander2>;
+			interrupts = <6 IRQ_TYPE_EDGE_FALLING>;
 		};
 	};
 };
-- 
2.34.1


