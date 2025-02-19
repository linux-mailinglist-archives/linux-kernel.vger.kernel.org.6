Return-Path: <linux-kernel+bounces-521069-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C1E5AA3B386
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 09:21:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F03351899B70
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 08:20:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 379831CAA82;
	Wed, 19 Feb 2025 08:18:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="eUEfaZ39";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="BBMFsjuK"
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0A271DE4C7;
	Wed, 19 Feb 2025 08:18:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739953128; cv=none; b=CdcEWJkYa1B5UM25sgF9Ww0dC0+nUtfSlH1jDhHgwJJg9e8AEY0j8HcRrRBPSFotoGWtndq8AsfwmuZA7FgeyN27NBxpOPhDbRYl2qHwEwjVytqjOYGDLBfjZgiIxKxgLNSBYi4ymGCZkcsPi0jD9CsRyfBZoIoeo43LUPpzKDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739953128; c=relaxed/simple;
	bh=SXlKeyatYd6ebA4XAf4Taul/4a54oHG5ZtJlcQBGsbA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Vd7OssR9nXz+7TBw9i3cbAC2lT+LGKcsG5LMvRM3zKrWlQDb4gcQcAhRJOIl1J7u33aCwp1ItVLdmDoDV0U2fZ+oZcR9fQJRjLRp5AfBAlnUgG6G3AaH5Y6vHXOwwfSmZoleXyNu3r6JQs0gh6Urqsw8EoyF89AyzA6kjguHHWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=eUEfaZ39; dkim=fail (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=BBMFsjuK reason="key not found in DNS"; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1739953123; x=1771489123;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=AENnf3CgBOghgCPCO6AUYPMH/oVpMZNd906YezBjWG8=;
  b=eUEfaZ39w0aqs45u05o4X5jv5JXBdeD0yfUbHWYIzdGVS64Hg1v7sK2a
   h4mhJ4jqMes3IQZs/KRzKifCArJQ0zMt3UVY3RE2976EO8YtjS/XGBohN
   YPw+Iq0U56cfneS/WrWiMlfhxCSa6MHK9TL3yGhZ338pR/tqETPOC3Tmi
   A6+zjTX6sI8pMvTuMvkLk9RDC1J+8lM6OtH4JDBQWpx9vYGLvYLB8f9om
   fToB+c9a6GSsUNy1b8iHvXpvwcOiJOTUnx8mOdQN/SS0FtdjRQI2C9c1L
   4EvoRteqXsdJ9krTckhJ+BgINxeLXBeYFjf06Mg+m1fwkz1+u35Ls+7Di
   A==;
X-CSE-ConnectionGUID: ePkEWgcZSWmPLQ96I4NdvQ==
X-CSE-MsgGUID: ifjATzQ3RmyROuGkezU3hg==
X-IronPort-AV: E=Sophos;i="6.13,298,1732575600"; 
   d="scan'208";a="41945176"
Received: from vmailcow01.tq-net.de ([10.150.86.48])
  by mx1.tq-group.com with ESMTP; 19 Feb 2025 09:18:40 +0100
X-CheckPoint: {67B593E0-23-EBA888C4-C1AC8B84}
X-MAIL-CPID: 228EAB8CE74423764938FA9A084C0A86_0
X-Control-Analysis: str=0001.0A002119.67B593E0.00D2,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id B70FF16D460;
	Wed, 19 Feb 2025 09:18:35 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ew.tq-group.com;
	s=dkim; t=1739953116;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AENnf3CgBOghgCPCO6AUYPMH/oVpMZNd906YezBjWG8=;
	b=BBMFsjuKVv7H2WEZzDsfIOuutjd2xtCvQWGB29tj625HnZJlmmbEPVw8+UFMPzcA+BFQuA
	Ra+Nrm9VWi4Ih1C6wbcy5MVtVNVSL1UF3BkROUgVS3tSHhcSxCwWIc2MuCZWy2l/XRfbrM
	wKP1POTxQNVzZ1yWdVj+rAL8x9H9FgOM7bDDmUz8yz8AcRDESRRKIb/sjXMK8E29sB/Hkm
	dbG4jl2MYduDehK/AWrVX2r0gJJnHAzvBsdA7gattAT2/HqEE2Bb14szcOH8oi/t7ZJsMi
	7y6YopzzGXKzU5U+kgr94Hg0ysKF6+XZkzT+lztmMEVZjMpg9pYiEK/6LX4ouA==
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
Subject: [PATCH 8/9] ARM: dts: imx7-tqma7: Add vcc-supply for spi-nor
Date: Wed, 19 Feb 2025 09:17:43 +0100
Message-ID: <20250219081748.1181507-9-alexander.stein@ew.tq-group.com>
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

(Q)SPI NOR flash is supplied by 3.3V. Add the corresponding supply.

Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
---
 arch/arm/boot/dts/nxp/imx/imx7-tqma7.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/nxp/imx/imx7-tqma7.dtsi b/arch/arm/boot/dts/nxp/imx/imx7-tqma7.dtsi
index aa8f65cd4adf7..618c3f68fbe25 100644
--- a/arch/arm/boot/dts/nxp/imx/imx7-tqma7.dtsi
+++ b/arch/arm/boot/dts/nxp/imx/imx7-tqma7.dtsi
@@ -265,6 +265,7 @@ flash0: flash@0 {
 		spi-max-frequency = <29000000>;
 		spi-rx-bus-width = <4>;
 		spi-tx-bus-width = <4>;
+		vcc-supply = <&vgen4_reg>;
 	};
 };
 
-- 
2.43.0


