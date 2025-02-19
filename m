Return-Path: <linux-kernel+bounces-521061-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A15FA3B372
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 09:18:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D76F97A4379
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 08:17:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AB741C5F35;
	Wed, 19 Feb 2025 08:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="iM9omnFv";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="Kf3hXjJd"
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AB95180A80;
	Wed, 19 Feb 2025 08:18:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739953094; cv=none; b=T2Sc/QGMkImjtp4d3OmhzxBBWwfC9n9NKX3bgDu2CNyg9Un9asHemg63TdG84ohc/eki+igcvk/nSjJ3vxi+ZNQCq2ms3R9XNdBZH7h5G571fLC/2dod6+qEVphG7Mo1ym7tHqRrcgi0vop3gG/7gh/jGg+YBzLrXGyzPYDTg9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739953094; c=relaxed/simple;
	bh=Gsb70OLJ7VZEyejWwpV7S8Mp5w0l1y5sKFYBV2uvDvQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AxOeSNxYOXGqK1cnp4e4CcdUzU1qinGSsd3ZmeXf+gYq6Py0ZgvV4XF2tJb6BQcz3TKWleg1og1PF/DPv/NfbWpMJj9+ZRYHNAqc8KMLnjO+ROFNDpxkcuaqRlmpHkxgMZltRr//J0xN3pCljjtmNZ7zR1d4Rs/B0CwXymHhNk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=iM9omnFv; dkim=fail (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=Kf3hXjJd reason="key not found in DNS"; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1739953092; x=1771489092;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=AlDaEXwA98E5yip/4WkX62llBCpH4fE7hTiQtGBXBKQ=;
  b=iM9omnFvqbpAI+kxW8Q3kgv4p48LeUZRvI1pW3RulVbchitHeouO26vE
   a+goeBvrN9/QvNUhzWgC6sfVZQA0a1kVg35yJZouSAbZIlBt6EJxNa9Vz
   nVgijHpb4KCqrim4EDf+b15w/1VGgVhVYEQ0iAhS6zFLMNJ56Z6X+oR7q
   AxL+Lb6HsozsicZgePpaY6Al0QJkSyShaiZ1to2i6goNO1FEKdgmRVfi7
   E2JQNEk2J8/LubqSJO1y1tTnt0v7ttGNVSDFh6qDWSrlpv3kvR5S5I/8/
   tm9JsU0fz0jaOzoG8g8ju+N8CpPCRVjXfLDrTWVSsao+9LEIxOiU+pxO4
   g==;
X-CSE-ConnectionGUID: YaF0d2HXQdCoCojK7HXmsg==
X-CSE-MsgGUID: nqNTARlOTnmT2NCFhaYhsQ==
X-IronPort-AV: E=Sophos;i="6.13,298,1732575600"; 
   d="scan'208";a="41945127"
Received: from vmailcow01.tq-net.de ([10.150.86.48])
  by mx1.tq-group.com with ESMTP; 19 Feb 2025 09:18:03 +0100
X-CheckPoint: {67B593BB-2D-28232521-C0C2250B}
X-MAIL-CPID: C0229471A839A1E2B4E661868D99E2AD_4
X-Control-Analysis: str=0001.0A002116.67B593BC.0024,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id ECDAC164350;
	Wed, 19 Feb 2025 09:17:58 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ew.tq-group.com;
	s=dkim; t=1739953079;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AlDaEXwA98E5yip/4WkX62llBCpH4fE7hTiQtGBXBKQ=;
	b=Kf3hXjJdxtM2+VfLohPbeMmt5afm2Y3D+1wBSHvLioVi0f1affUmzKtXNne7IxVVDKUCT1
	J31v2a1RPrthYDMrfNrja4w44a+pW7U6faPMZyTxPewTtdTmZeQ2kfcmXB8kUfzB3Aa5lk
	43ZE4BAHUxubxvHIZwUHi+7ygQz6bHcIwKk2G8IfvKNFdelJH4iewtzSaSicJprJYbCm5c
	pKhF6SbC5zVez+AxSScg7QjKg9XNI9La2MBx1TsdjoFDpbei7UUHDg3x45Pu/GDPq/1MFu
	5QB8402KuF27Sjq3xBoI76dofV0cRYRGJVynfwscZb4SPfl8KRmF+Er4Ch4s3Q==
From: Alexander Stein <alexander.stein@ew.tq-group.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>
Cc: Alexander Stein <alexander.stein@ew.tq-group.com>,
	linux@ew.tq-group.com,
	devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/9] ARM: dts: imx6qdl-tqma6: Order DT properties
Date: Wed, 19 Feb 2025 09:17:36 +0100
Message-ID: <20250219081748.1181507-2-alexander.stein@ew.tq-group.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250219081748.1181507-1-alexander.stein@ew.tq-group.com>
References: <20250219081748.1181507-1-alexander.stein@ew.tq-group.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

'compatible' and 'reg' are put first.

Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
---
 arch/arm/boot/dts/nxp/imx/imx6qdl-tqma6.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/nxp/imx/imx6qdl-tqma6.dtsi b/arch/arm/boot/dts/nxp/imx/imx6qdl-tqma6.dtsi
index 6152a9ed47682..303def00cdfa9 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6qdl-tqma6.dtsi
+++ b/arch/arm/boot/dts/nxp/imx/imx6qdl-tqma6.dtsi
@@ -25,8 +25,8 @@ &ecspi1 {
 
 	m25p80: flash@0 {
 		compatible = "jedec,spi-nor";
-		spi-max-frequency = <50000000>;
 		reg = <0>;
+		spi-max-frequency = <50000000>;
 		#address-cells = <1>;
 		#size-cells = <1>;
 		m25p,fast-read;
-- 
2.43.0


