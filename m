Return-Path: <linux-kernel+bounces-388428-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FD4B9B5F90
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 11:01:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DACF7B20FAF
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 10:01:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B653C1EF920;
	Wed, 30 Oct 2024 09:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="o99xrL23";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="FL+xN7ua"
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1FDC1EF099;
	Wed, 30 Oct 2024 09:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730282171; cv=none; b=ab91CQLuc5dKDbrE6DL4imFzbHWlZgaL9eFAzFpOFYK3iJJwC5EAKh3fXukvPVQAuUYFwuMuk7QSaX0NPBfeXrYaydfKrh3ATkAHl1Hx28C2qgGMzfPIxd8/4tUaGk0Tdf76EhVStVX2JlYO1YRMVg6goPT/9oMeD583z9OjQgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730282171; c=relaxed/simple;
	bh=99fzVsgguHDqwVji99RP999dNaQOQkCqoH4a8e3boJY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=nGmU1RejGFrXIk4bP4SkFDDXRnJlKGE37Q7XNUNz1lHwy9D9XKhYZRUnoP4w6daWAfI6zTKCjgFsPZ9CCj8tOCFOUEnRL3UEr89GvcIWKgbk7Q69IpdFH1593K+eCrPLr2YRAaAno5lCK+vmyoWiKChhAD+DAjzVoKlORSOEI0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=o99xrL23; dkim=fail (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=FL+xN7ua reason="key not found in DNS"; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1730282166; x=1761818166;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=aPtpCx0bE2hy6c7hMOkAIGp+0vvTAehcVRieP5LmqI8=;
  b=o99xrL23GwIGjbsMnkEkbBErXOB1OUanIqhSJ+mI1P1nUGR7X7bSmzer
   t0MNx5Y/ELd9kL/G+66TqcPFixBJVyLbHM/kd6y5Xqxy4SGskm8VAl/fD
   pBqdwxTIC3WYWyvjmyZcO0vG55Klofbtl/tJg+tj9QwVAeSV2bwz0sJzP
   oW9Yj95a1lpKFmlpxQPP4n3eYtWtRqQu/xj6q4aZkWvdQcMgrYiayBi5z
   Y3isjoAby1gfK+ADEnMCy6NN3Thy8VrVhpvD+vaI9DMS4jEbeqTGKmIr+
   S1WlX+LrGH6E852WbQ1FtQu5DPoEww8ASoCYnftWyXimpjXlqluNj2UU4
   A==;
X-CSE-ConnectionGUID: ++MbzpPnSeOwLv5XgpMU0Q==
X-CSE-MsgGUID: ceWgtWl6R8uurZ1eb3nwlA==
X-IronPort-AV: E=Sophos;i="6.11,244,1725314400"; 
   d="scan'208";a="39758789"
Received: from vmailcow01.tq-net.de ([10.150.86.48])
  by mx1.tq-group.com with ESMTP; 30 Oct 2024 10:56:03 +0100
X-CheckPoint: {672202B3-21-86C05612-CA75E1CA}
X-MAIL-CPID: F7C9B31834748EFB307F69D08630B802_1
X-Control-Analysis: str=0001.0A682F19.672202B3.00D8,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 5C6D2169508;
	Wed, 30 Oct 2024 10:55:58 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ew.tq-group.com;
	s=dkim; t=1730282159; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding; bh=aPtpCx0bE2hy6c7hMOkAIGp+0vvTAehcVRieP5LmqI8=;
	b=FL+xN7uakK0lwhfmfYEmgnm79qVIEe08IZeA/9o7k4L9nOZ2LuBWdvmYIr+Pwpi3v8ZJoE
	FCpaK7pMsnfZzG2u5dr8mWtTPVyZKcVgMvSkbVdYtgt063F0PRR3lp7JjXd2n8S2zuVqu5
	jADVNxELm6HzE85MkRWcM2ftexeEltH6gSXFxHBYIJtwfoNwlRlQzKrSTbRgU5P8l7E55v
	8annQqSHQxd3sIROAwyC43tTWJL+38I5WdbHss1AwxsrFMol6+azZuwTeWmKeWGePznDYu
	vRw1cxOfO8+SXt99P0I4MXZGx+PkcJcMoEMom+1tQFfwVLQQwqq2VKWwo9Yc5Q==
From: Alexander Stein <alexander.stein@ew.tq-group.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Peng Fan <peng.fan@nxp.com>,
	Alexander Stein <alexander.stein@ew.tq-group.com>
Cc: devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/2 resend] arm64: dts: imx95: Add missing vendor string to SCMI property
Date: Wed, 30 Oct 2024 10:55:51 +0100
Message-Id: <20241030095555.222143-1-alexander.stein@ew.tq-group.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

With commit 7bf46ec090b9e ("dt-bindings: firmware: arm,scmi: Add missing
vendor string") this property has 'arm' vendor prefix. Fix the property
name accordingly.

Fixes: 61ed94cd54e3 ("arm64: dts: imx95: set max-rx-timeout-ms")
Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
---
Sorry, there was a mistake while sending the first batch, so patch 1/2
was missing.

 arch/arm64/boot/dts/freescale/imx95.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/freescale/imx95.dtsi b/arch/arm64/boot/dts/freescale/imx95.dtsi
index 62bb526ba507b..d10f62eacfe08 100644
--- a/arch/arm64/boot/dts/freescale/imx95.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx95.dtsi
@@ -313,7 +313,7 @@ scmi {
 			shmem = <&scmi_buf0>, <&scmi_buf1>;
 			#address-cells = <1>;
 			#size-cells = <0>;
-			max-rx-timeout-ms = <5000>;
+			arm,max-rx-timeout-ms = <5000>;
 
 			scmi_devpd: protocol@11 {
 				reg = <0x11>;
-- 
2.34.1


