Return-Path: <linux-kernel+bounces-260984-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A60393B13C
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 15:01:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AAFD8B23869
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 13:01:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 016BA15B153;
	Wed, 24 Jul 2024 12:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="FRnzu5JS";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="eYymLpOT"
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EA7515ADA1;
	Wed, 24 Jul 2024 12:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721825967; cv=none; b=HjjTUp+esTef864PH+4V4RmOnw+eSuodYObZWH8wxWLrgYkfnngGdD1tzwc2O3qzn/QVZ8ROUGlolXurh7clA3rN6cRTGInL/rgtF3w+uL2pyV/FodmnL7bbGNpR6wWAp3AAwy5A8Pc+aLnZ8cYJ5465Jhpf3Y/vn/9wBFkdFjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721825967; c=relaxed/simple;
	bh=fEhAbyF9NyXngJqCbaBmOcY8uPUQfQ+ByLcoZ3ulgyo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=e3cvQnC7BW7UEvV005PoVVM2Y3JHCj0X09dhjo5LC5kowcEj67JhS2bcNOtSnhFWoenV7FdnTpg+dHLfTSo7TO3NfHlzfm3gDdj4LrJ/T7/MqPcFc1FLiszwYOEda7BekrMgmRcA/xTSMaReKNXFP+IBCxUCqQ+EEAWFe0ERynw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=FRnzu5JS; dkim=fail (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=eYymLpOT reason="key not found in DNS"; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1721825965; x=1753361965;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=kQzLuoQ51RTGXKER6FeBkGzpC5diW/1G5WaKWBmYD8M=;
  b=FRnzu5JSbmYEGWcVtoTD7JwFZuk1uBuCKnlPQT6ynVb8hx4KUeXD9Qe4
   mBAnOpjfIoRx+jBWZNDhxXko3acTtve3nMWoDueLigJ/AwQkFYUTIIzNC
   vPkDZKVoyMQ09o39ZwULQjNLz55jqgyIxvf37RcBYSkkEkjYo0pzxRkOY
   OlEufl8H3l0blB7QE3SbxogsQE5Tg9UoCRdmOGklY2VcOQDfP4WhiGdsF
   yy0YWNmX/QjhNS5RDe6GBw6UyZlD4rliM7/pdMae63oWTSAHmnroqRhoR
   4TRt+wsf1JsPEzJtQ1wlV4SIf86Ag0tWwID187dI1O6CX4tJ0uhLfi2D+
   w==;
X-CSE-ConnectionGUID: CFp4y9yaTOKjgmhYuP0tHg==
X-CSE-MsgGUID: ZwEO5rciR+Sbydw8a7QZyA==
X-IronPort-AV: E=Sophos;i="6.09,232,1716242400"; 
   d="scan'208";a="38058830"
Received: from vmailcow01.tq-net.de ([10.150.86.48])
  by mx1.tq-group.com with ESMTP; 24 Jul 2024 14:59:23 +0200
X-CheckPoint: {66A0FAAB-1E-E8EE7C4B-C1098986}
X-MAIL-CPID: 299CE8E8F7873F39318C5F93AD98CC82_5
X-Control-Analysis: str=0001.0A782F26.66A0FAAB.0159,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id A40451672CE;
	Wed, 24 Jul 2024 14:59:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ew.tq-group.com;
	s=dkim; t=1721825963; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=kQzLuoQ51RTGXKER6FeBkGzpC5diW/1G5WaKWBmYD8M=;
	b=eYymLpOT7UI6P5iN+FTJE4gT1DTEihUvT0W09AXm/MBStL8XHvk797zHX46llI2RMkHJ/7
	8ayrHdCnExIsT5tWDQTmAlGXjUkgvTckP4P8HmHglCXQ+Ua87VVV6gRn2SDpwNT2QJqVT3
	i2rJNj+Igy1XoZCMvyCFBeobZGdrEGd6uO7i+rnz8aCeJ8SGwp8aiA6DODkskOmHjybgW2
	DtwRXfVQkIn9ijc+2oMhWzdWCQ5SXxs61Y4UWi2eHAQOv07Cfszj+MpVUhVlNAAVIbnZqr
	QaeqejTgZbOzSo2Og+zr0bHLIwjC07mAub+n+k0Ya10g3W7vKc/emX1MjV95LA==
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
Subject: [PATCH 08/14] arm64: dts: freescale: imx93-tqma9352-mba91xxla: Add ethernet aliases
Date: Wed, 24 Jul 2024 14:58:55 +0200
Message-Id: <20240724125901.1391698-9-alexander.stein@ew.tq-group.com>
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
 arch/arm64/boot/dts/freescale/imx93-tqma9352-mba93xxla.dts | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx93-tqma9352-mba93xxla.dts b/arch/arm64/boot/dts/freescale/imx93-tqma9352-mba93xxla.dts
index 3038c94a1184..a8870544514f 100644
--- a/arch/arm64/boot/dts/freescale/imx93-tqma9352-mba93xxla.dts
+++ b/arch/arm64/boot/dts/freescale/imx93-tqma9352-mba93xxla.dts
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


