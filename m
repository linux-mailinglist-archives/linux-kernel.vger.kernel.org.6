Return-Path: <linux-kernel+bounces-529404-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 43B3DA425F7
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 16:17:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1563D19E1D7B
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 15:00:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4F99189905;
	Mon, 24 Feb 2025 15:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="JSJCrmdd";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="KBJvqddd"
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D50F38DD8;
	Mon, 24 Feb 2025 15:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740409230; cv=none; b=EFO8ZbGo9wY25Qgxow872XPlhn1Gw+qtXt8PXp+1N1nfPnH9+g4mzgP2qgGdjUAiG6rRoBwNoHCtBAy6W9jiHrTjRNj87mKKiB/XGh+7gzBfYQfbzq9s1HTyHeJgRIfvY1j1bfCn4hTx8mHGr2tVVQCIKZ7K4APwc3Nk6PPslsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740409230; c=relaxed/simple;
	bh=Hxa8pbq3jaNkyuqDkj4YzOOvo8feC1TgyuBllE+WYYk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Uj3qaVihYS8gDeDAaDHTI/AWWlGgZh5RR7gofFsBIvF0uZlU3/JiBkSZ9Sy+G3LvPt5VPNAqDdKfAryJgdqn5jRNAI0a9EJ3m50pZPu1k+dDU8ryWO5sfQakauvN0ejBh96AtSerOmV7/IP0XDpreOaYYBBUcLfTueD5//lQcXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=JSJCrmdd; dkim=fail (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=KBJvqddd reason="key not found in DNS"; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1740409227; x=1771945227;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=T6W5ZMpXaDdvfRap/6NIAL55MOOCeVq3QJ0xPOvFRkQ=;
  b=JSJCrmddb1ewxEIwrA0Y7GpOSgYsDmQxEIGoWSQcjDEZ/0rfAo0ehXe0
   z1Tw5yst9qVn4uU808eU5hYJe1cZOeByHS7zRj1uzEp6UJJ+uiaRi0Mwb
   dvh4Qog+ETvOXyvxVim/g5KUbBZZpPrhndmHHgKPhzwMI5g07OG0Xbp8Z
   gdYuBrvD9O8ut7WYHJMZo7o5Y2GzRGIcRfzscFejKI31IcqTieqSwgKve
   l0E6otPcDRaBwnmhpXOzPG0v/VDHrGrHm86EPBuW1yii7XjA34LLMdHwl
   KpkLGzXq0oA85M0WVGUH22Odjo0eSI3lCJoEQuywfBMLiYJmoqhtg7cvV
   Q==;
X-CSE-ConnectionGUID: lvFkyRSJSjyP0h7uqar+0g==
X-CSE-MsgGUID: fM+2bR44QEOqxtSh2K96uQ==
X-IronPort-AV: E=Sophos;i="6.13,309,1732575600"; 
   d="scan'208";a="42043004"
Received: from vmailcow01.tq-net.de ([10.150.86.48])
  by mx1.tq-group.com with ESMTP; 24 Feb 2025 16:00:24 +0100
X-CheckPoint: {67BC8988-21-C21CC984-D1047F1F}
X-MAIL-CPID: C40F4806809927EB72D8AB495A33CC91_5
X-Control-Analysis: str=0001.0A002117.67BC8987.00BB,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id A61D016798B;
	Mon, 24 Feb 2025 16:00:18 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ew.tq-group.com;
	s=dkim; t=1740409220;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=T6W5ZMpXaDdvfRap/6NIAL55MOOCeVq3QJ0xPOvFRkQ=;
	b=KBJvqddd7Fo+MyVSzXw/Tg1rWwnj/aVyFzMT45gg9ZcLAMoxBoEzuPGyESCuNI3SsyYyVJ
	cOIqIrzIVVpHNnH6PTq1iH7gF4u0fbWapn7sbxIP8qabLDZbZ3zBAeH6NPYAOCo02NlfwA
	zQau4MhcsDYUx8fXYNpmMqsMvGeuu6W/BTtbOa/+oFtKYwPQCH/u9Uz6ARQpGoNmoq99sw
	aDPAave9zUomXQi7VAUPj8CBDnqJRKIeJRjNHMX3eN7MjcVVX2erH0ruIjMt4t4dknKmpI
	LA4RjQ84x8NBhTW5MJpuj71d1JCiro1jC6zprU0ty/5jHm/t8IFUVb7pYsDAdA==
From: Alexander Stein <alexander.stein@ew.tq-group.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>
Cc: Markus Niebel <Markus.Niebel@ew.tq-group.com>,
	linux@ew.tq-group.com,
	devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Alexander Stein <alexander.stein@ew.tq-group.com>
Subject: [PATCH v2 1/2] arm64: dts: imx8mp-tqma8mpql-mba8mpxl: change sound card model name
Date: Mon, 24 Feb 2025 16:00:14 +0100
Message-ID: <20250224150016.499055-1-alexander.stein@ew.tq-group.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

From: Markus Niebel <Markus.Niebel@ew.tq-group.com>

The card name for ALSA is generated from the model name string and
is limited to 16 characters. Use a shorter name to prevent cutting the
name.

Since nearly all starter kit mainboards for i.MX based SoM by TQ-Systems
use the same codec with the same routing on board it is a good idea to
use the same model name for the sound card. This allows sharing a default
asound.conf in BSP over all the kits.

Signed-off-by: Markus Niebel <Markus.Niebel@ew.tq-group.com>
Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
---
Changes in v2:
* Rebased to next-20240224
* Remove dependency on local patch

 arch/arm64/boot/dts/freescale/imx8mp-tqma8mpql-mba8mpxl.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mp-tqma8mpql-mba8mpxl.dts b/arch/arm64/boot/dts/freescale/imx8mp-tqma8mpql-mba8mpxl.dts
index ae64731266f35..23c612e80dd38 100644
--- a/arch/arm64/boot/dts/freescale/imx8mp-tqma8mpql-mba8mpxl.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mp-tqma8mpql-mba8mpxl.dts
@@ -234,7 +234,7 @@ linux,cma {
 
 	sound {
 		compatible = "fsl,imx-audio-tlv320aic32x4";
-		model = "tq-tlv320aic32x";
+		model = "tqm-tlv320aic32";
 		audio-cpu = <&sai3>;
 		audio-codec = <&tlv320aic3x04>;
 	};
-- 
2.43.0


