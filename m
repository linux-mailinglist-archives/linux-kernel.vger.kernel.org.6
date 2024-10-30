Return-Path: <linux-kernel+bounces-388429-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 601899B5F92
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 11:01:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0ABB01F21C94
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 10:01:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B54301F12E3;
	Wed, 30 Oct 2024 09:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="pgQxHQHY";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="J55rPhOX"
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84BAE1EF92C;
	Wed, 30 Oct 2024 09:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730282174; cv=none; b=o1i0VDhl6eCBFDlNbfMZwYE1/YAuMOD2ix4mj/vU4lEMUHyacuaDf6fgPV/qIRSvt4syzcqQHOFhatEoTw6QY01+nbiRUVJFwdt2BMEe5c0++il+Hgq9KbNWThFED2rUX4Y3U0lAdDGrydWU9hun5Xv9AJ4Leof4o9d1GHmpc+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730282174; c=relaxed/simple;
	bh=4K/WP62uPq6V560IiCzhbH2c1uA7hP9SMx44NCKtD0M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZXZfDVU+5qm487w9Ohq8xGRf2euGAFO5mtvhYOWaD6nV3OJc0dWSg5WUq1gBF5UaO7DJEHPfS59VZhGo/yE+C743yiW5k4oubpacdIJqxKNbXqe6cSuM7YA7g5ctwbxkmIrw9dIJfM1fO3YcU08W56zvVrfmI00MEhHmhIeF94Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=pgQxHQHY; dkim=fail (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=J55rPhOX reason="key not found in DNS"; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1730282172; x=1761818172;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=kv28fZyUnvSoy7xLNeLLk5bmzedyTwjko9yL0PpBFlA=;
  b=pgQxHQHYrtZ5k9bQrvTANRAPV5AfaeBTrZWx0iZ+5o1eCNY+LREQZLvp
   VSRlmZA2CQdS5DddbLPPLZ7MA7j5uaPC2oxBCdoMOZJ0ora4WGNrdVvi9
   5V28MR29SD+gniYK1eqbNfons4Q0k5PXPgssr1dBHZ/vumnrizublVXrn
   owidwZaTx9C3hYWUxBCCyX8IEMBgpQiwN7knnkLPVeBIc9DzsCa6QrNVs
   k1gm5RRai48bpqNe6PzeBkdGBtQOH8DA2WRVPbDvlqfTRz5ZR3o5N484h
   +/f/CLauZfC0Aut2CMOnVN4mwRiomqJk8SXNeyzNQl28dKV/8UeSLqYV6
   g==;
X-CSE-ConnectionGUID: uoyDv6P9SzW+ZF9EaeyEdQ==
X-CSE-MsgGUID: bcvcl0nPSXmb59G7BIj7vw==
X-IronPort-AV: E=Sophos;i="6.11,244,1725314400"; 
   d="scan'208";a="39758794"
Received: from vmailcow01.tq-net.de ([10.150.86.48])
  by mx1.tq-group.com with ESMTP; 30 Oct 2024 10:56:10 +0100
X-CheckPoint: {672202BA-36-D31EDE1A-D52D6119}
X-MAIL-CPID: 3CCE9A5DE1379AF4B1F2317D6AAD2271_5
X-Control-Analysis: str=0001.0A682F1B.672202BA.00B5,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id D3406169508;
	Wed, 30 Oct 2024 10:56:05 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ew.tq-group.com;
	s=dkim; t=1730282166; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=kv28fZyUnvSoy7xLNeLLk5bmzedyTwjko9yL0PpBFlA=;
	b=J55rPhOXKhQMM8TciVzawOjJmY94RiQVyPZgRS9vPBcRZGfz1ymnYFzj7NbLcqud9DZLte
	CarOq5O8wpnaRHMTa4at33+QVqyx+ZkXQwZ5Dfbk+0hZQcU3byesuhG9QJW4e8h1oVvhEB
	OtqhhPb492uHpkF0sbZEflgujTgzYs7JSAF8qOG6F24/NmDf+Yo1eVc5y8tDj1O3AiYuFq
	ZLKXnyfVPji063IgbQWE3EzszulYed3+cwXP76mUz+aXc6BqB6d8S+ERHzoYLyuoRzY/3Q
	D/ni0k7oZSlr/aI+79/Kvku3tlUzNO2oB1kZTnzFRQyOyLieqc1400+fAC+hMg==
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
Subject: [PATCH 2/2 resend] dt-bindings: firmware: imx95-scmi: Allow linux,code for protocol@81
Date: Wed, 30 Oct 2024 10:55:52 +0100
Message-Id: <20241030095555.222143-2-alexander.stein@ew.tq-group.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241030095555.222143-1-alexander.stein@ew.tq-group.com>
References: <20241030095555.222143-1-alexander.stein@ew.tq-group.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

BBM protocol supports a single power button, supported by driver
imx-sm-bbm-key.c. By default this is KEY_POWER, but can also be overwritten
using linux,code. Add a reference to this schema and add linux,code as a
supported property.

Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
---
Admittedly, I'm not sure if this is the correct way of referencing the
linux,code from input.yaml.

 .../devicetree/bindings/firmware/nxp,imx95-scmi.yaml     | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/firmware/nxp,imx95-scmi.yaml b/Documentation/devicetree/bindings/firmware/nxp,imx95-scmi.yaml
index 1a95010a546b1..112c3a3eb1980 100644
--- a/Documentation/devicetree/bindings/firmware/nxp,imx95-scmi.yaml
+++ b/Documentation/devicetree/bindings/firmware/nxp,imx95-scmi.yaml
@@ -12,13 +12,18 @@ maintainers:
 
 properties:
   protocol@81:
-    $ref: '/schemas/firmware/arm,scmi.yaml#/$defs/protocol-node'
-    unevaluatedProperties: false
+    type: object
+    allOf:
+      - $ref: '/schemas/firmware/arm,scmi.yaml#/$defs/protocol-node'
+      - $ref: /schemas/input/input.yaml#
+    additionalProperties: false
 
     properties:
       reg:
         const: 0x81
 
+      linux,code: true
+
   protocol@84:
     $ref: '/schemas/firmware/arm,scmi.yaml#/$defs/protocol-node'
     unevaluatedProperties: false
-- 
2.34.1


