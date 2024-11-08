Return-Path: <linux-kernel+bounces-401730-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E00779C1E76
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 14:50:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9EF5F2820EE
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 13:50:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 832EC1F4295;
	Fri,  8 Nov 2024 13:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="JsiZVPgX";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="tC6ER5Qo"
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BF6C1EF95A;
	Fri,  8 Nov 2024 13:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731073791; cv=none; b=rjrOgPjChBrirTjChTfik3HR43/xnbP3havZJVd+qYhcYR6TB/YrLYT2z+NaM6U5yRHSEr8AHEOEKWHBN14CnQaHqUna8/h0yHleN/dlfRx3XPhPRurRWhLv0AByYSoygYLOnJFhCSraQ1TdNZE05czGHy5aMUK0ChpWH6iGwRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731073791; c=relaxed/simple;
	bh=rOWiUzfKwJyDqi8ajGVUrwrThZcBOMBZTpmijefzonk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bLNjRhb/rXZGLB1ncFMTaygmTACQZYMpfnS3fPK61vh20vd76/e0jpYeHTcPQJmR1OmHESYJkMO7OrIoh8xIZqQZ5scWjTNWPA4d+93vK6miQkkKSLCsXT9rYEC8dHW19SvdZim+ZN5byneCuTwIR2ieFygqSyIhhkW0AHECYZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=JsiZVPgX; dkim=fail (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=tC6ER5Qo reason="key not found in DNS"; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1731073790; x=1762609790;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=m3bOax/iwbQ/EP8te2iWhC8WQNV4+LXp2K8y224vh9c=;
  b=JsiZVPgXsERpFKdVCpGCwUlMDFrnlBP60wUu2CKjW0FTX7+QjjcKvB6O
   UfRYMrpB4nAJ8I7ToW6YprSvKlBrojnov0fTMXz9QG9MPhQPabAL7rnXz
   rpI1Cfmcsd+IINyCSXCFcgahwz5eMJX47VgvlS6GUL7+8p6ACwJ29jAtv
   NNLGFWB3D2TRr2CEbtIc35Q1UzfoYO61fINEl6dnxHdddmRyfJ0XehJW0
   fxauyfnnz4cFSsJK8zDyDRWr725JzpheZq0FVl0I7Rz0RtwfdrvWNycgf
   Pu8IOc6KnboKSYHxxI7bFlMYuel9Ziwc+PdnNH1NMxD1dkXarCFmP1C0e
   w==;
X-CSE-ConnectionGUID: f9SSM+pjToWPN5eBr3bWCg==
X-CSE-MsgGUID: poFUq83pQgybocnlkYZ4fA==
X-IronPort-AV: E=Sophos;i="6.12,138,1728943200"; 
   d="scan'208";a="39936927"
Received: from vmailcow01.tq-net.de ([10.150.86.48])
  by mx1.tq-group.com with ESMTP; 08 Nov 2024 14:49:47 +0100
X-CheckPoint: {672E16FB-1D-5736D786-D50827BE}
X-MAIL-CPID: BD1F24A25D10CF92982105AEDCB74FFD_2
X-Control-Analysis: str=0001.0A682F28.672E16FB.0096,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 5534F165074;
	Fri,  8 Nov 2024 14:49:42 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ew.tq-group.com;
	s=dkim; t=1731073782; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=m3bOax/iwbQ/EP8te2iWhC8WQNV4+LXp2K8y224vh9c=;
	b=tC6ER5QolfygrDfxSSSZ3iMzQXu5jBbvYxhHEyq/Cp/d25Udl02TqA172pGAlflnd/+SMB
	PDRpiV/jbuBgWm1QxUqNxNcjAeZC1B45asEpFTkr/6rLJ1R17gmC9TXD3aLrtqGGudlnOr
	Gi8yxRxTkhvH4ellklKP/VLloLSEbmwlmShBzM1gu1YpFzlFX4axczRrN+DBjbd/rZre5Y
	X0dOhcft9KJTwE/2e9zd+1aviym4WGT1zceOEM9T63BSSYfa2ms3MRpACtQUOaHCme2+A+
	BnfyO0MawcJKDLcZulXMqnhB8FbecF2IlzlRYT7frPJpQM51x0bpYiYkDjw72A==
From: Alexander Stein <alexander.stein@ew.tq-group.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	=?UTF-8?q?Jo=C3=A3o=20Rodrigues?= <jrodrigues@ubimet.com>,
	Bruno Thomsen <bruno.thomsen@gmail.com>
Cc: Alexander Stein <alexander.stein@ew.tq-group.com>,
	linux@ew.tq-group.com,
	devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/8] ARM: dts: imx7-tqma7: Remove superfluous status="okay" property
Date: Fri,  8 Nov 2024 14:49:20 +0100
Message-Id: <20241108134926.1324626-3-alexander.stein@ew.tq-group.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241108134926.1324626-1-alexander.stein@ew.tq-group.com>
References: <20241108134926.1324626-1-alexander.stein@ew.tq-group.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

There is no need to specify status = "okay"; for newly created nodes,
remove this property.

Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
---
 arch/arm/boot/dts/nxp/imx/imx7-tqma7.dtsi | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arm/boot/dts/nxp/imx/imx7-tqma7.dtsi b/arch/arm/boot/dts/nxp/imx/imx7-tqma7.dtsi
index 028961eb71089..656ab0562695b 100644
--- a/arch/arm/boot/dts/nxp/imx/imx7-tqma7.dtsi
+++ b/arch/arm/boot/dts/nxp/imx/imx7-tqma7.dtsi
@@ -150,7 +150,6 @@ m24c64: eeprom@50 {
 		reg = <0x50>;
 		pagesize = <32>;
 		vcc-supply = <&vgen4_reg>;
-		status = "okay";
 	};
 
 	at24c02: eeprom@56 {
@@ -158,7 +157,6 @@ at24c02: eeprom@56 {
 		reg = <0x56>;
 		pagesize = <16>;
 		vcc-supply = <&vgen4_reg>;
-		status = "okay";
 	};
 
 	ds1339: rtc@68 {
-- 
2.34.1


