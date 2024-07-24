Return-Path: <linux-kernel+bounces-260988-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3943593B145
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 15:02:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E7A55285742
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 13:02:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6489915E5B7;
	Wed, 24 Jul 2024 12:59:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="YFrmjNNL";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="fV/Ks8Gq"
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9832815CD78;
	Wed, 24 Jul 2024 12:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721825974; cv=none; b=hIzJDLvcI0kIgV3i/B4nNOkyFj76Z2ay1F5KA1Ol2peszYiu6m5YzHMI0gGIjtVf4exi1DuxXWqMmuPx+KHnWruoKASNd0JCWyZ+CxZRzA7BdJ0fDxdpkKXwTTj0RIktS1HNldPn+/LQ2CfqUjaAUW82cdaSy/8iQImX9XOE/0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721825974; c=relaxed/simple;
	bh=5582bQVm1xVCnwoK1Q6oULLjSaqp4TS5zq4aS4O4EcM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=a3iMvh+y90CzGGG0UJWmEeRyg1Inktap2B/PrbDJHvUrvJ19MbmeMkK57PWA3k9W0m/M+rIGcI/IQTnVQMvpuli3ZdQkv3B4ruBKxToBny+04edc2MlCUvscfWCsjRoQzYmwWDpLzCFPuxtnFyag4V32V5svbUoF9HoFvX7jGGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=YFrmjNNL; dkim=fail (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=fV/Ks8Gq reason="key not found in DNS"; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1721825973; x=1753361973;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=b5HjJryAsPyXd3a7Rm+RmIPtfVbzSlaHWGxEX71ESGc=;
  b=YFrmjNNLQIqS3SJLLn1hlq9yX49UAR9EF0WNfmydy1UxYuThv50QU/eZ
   PWR2WRc63isRfVz1gCgEh2BZq+jtTm8dWRbbUJrFg9So5u6iu/uXyOKNO
   ojtwUUm3wyKkgZUYGsZvyrPabyCNqgqhVwbQQTS2T9hHujBcjfh3J3Qrv
   QDF7KQVv85nP0rToADJGKXAe8Vv9H6EaH2hhdGKcj0EteBLF/CCJ4rflQ
   MHDqtwiYMkgKWmoq8VrKlGCxzOScJTRIXr+dBHguH1cQY8nEW5HW0mA1Y
   /4/zFlulTEkThRTk1pvEKtn+sy5zQr4eq4Ev0iapCTO6Tmok4Int0OjlD
   Q==;
X-CSE-ConnectionGUID: 3FAy47EPRimYMLtjBM7xJw==
X-CSE-MsgGUID: uSDH+VWjROu9UxcDpVbPEw==
X-IronPort-AV: E=Sophos;i="6.09,232,1716242400"; 
   d="scan'208";a="38058834"
Received: from vmailcow01.tq-net.de ([10.150.86.48])
  by mx1.tq-group.com with ESMTP; 24 Jul 2024 14:59:32 +0200
X-CheckPoint: {66A0FAB4-1-6C016D47-F93F7C64}
X-MAIL-CPID: 5655B701C17FCA1689806FA86F465761_0
X-Control-Analysis: str=0001.0A782F26.66A0FAB4.0071,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 2AA8916376E;
	Wed, 24 Jul 2024 14:59:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ew.tq-group.com;
	s=dkim; t=1721825971; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=b5HjJryAsPyXd3a7Rm+RmIPtfVbzSlaHWGxEX71ESGc=;
	b=fV/Ks8GqEPX2H7aD8UkblpX68q41gH2wYqBkBZt4ZQ0Zo/Il7NxtMiUz4PoplFM0IVXTSK
	lMDZO8Fk8QgN3sEZtiDQ7dlB2Hu8mAEoc5c8GCI9v/3KEdcooh2zH+1sRpWg1rDZVwBEle
	zw5w2WnPC8b57/OJjZIvZ2YKyWTPahi0tnLLm/GnDhGDOn1BvLOL8rcjG4Uh8dme97qj5u
	S/lAfqRYyz8BYqXw9UE5PNaSg0FkDMstzRlSpnAPAoaju8XpNyt8Xqjec5ziLlvVGI5vr5
	HHZZNt0xL8AycnyxXZV++d1BtGAew/7FRk7zc79iWC2pp09akvt2EjiqhzWJmg==
From: Alexander Stein <alexander.stein@ew.tq-group.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Alexander Stein <alexander.stein@ew.tq-group.com>
Cc: linux@ew.tq-group.com,
	devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 12/14] arm64: dts: freescale: imx93-tqma9352-mba91xxca: Add ethernet aliases
Date: Wed, 24 Jul 2024 14:58:59 +0200
Message-Id: <20240724125901.1391698-13-alexander.stein@ew.tq-group.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240724125901.1391698-1-alexander.stein@ew.tq-group.com>
References: <20240724125901.1391698-1-alexander.stein@ew.tq-group.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

They are used by systemd to rename network interfaces to predictable
interface names, e.g. end0 & end1.

Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
---
 arch/arm64/boot/dts/freescale/imx93-tqma9352-mba93xxca.dts | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx93-tqma9352-mba93xxca.dts b/arch/arm64/boot/dts/freescale/imx93-tqma9352-mba93xxca.dts
index 2d979ab085ee..8a64959e92cb 100644
--- a/arch/arm64/boot/dts/freescale/imx93-tqma9352-mba93xxca.dts
+++ b/arch/arm64/boot/dts/freescale/imx93-tqma9352-mba93xxca.dts
@@ -26,6 +26,8 @@ chosen {
 
 	aliases {
 		eeprom0 = &eeprom0;
+		ethernet0 = &fec;
+		ethernet1 = &eqos;
 		rtc0 = &pcf85063;
 		rtc1 = &bbnsm_rtc;
 	};
-- 
2.34.1


