Return-Path: <linux-kernel+bounces-394412-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DB6B29BAEB9
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 09:56:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6D6441F21616
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 08:56:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF3651ABEBB;
	Mon,  4 Nov 2024 08:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="lMorisUp";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="eSuOISPK"
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ACC214B06C;
	Mon,  4 Nov 2024 08:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730710604; cv=none; b=goGJNXe4EbgjvQxb3YySjmh/Oo6MvmCHvBpcNiQjS9ecDk9HN6Ase/DHF2Px8alRXocSSmeaMRNBVChb3WwQMv2gr0rF3T1t9iTpx7La9byQUK7EUVeZ2R8I0hclb1biV7vJAwtDGs2f6gt4yh6MRoagO5Famni0iyLsmY1Zd9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730710604; c=relaxed/simple;
	bh=Vz20v+1mMjGBXMV3/Ud1+fs+2WLaeyAEPGs1X8XeUgA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=jUkdTTpXAg6jJrnzLBqLQBGY9e0LVC4ihuXrB+3+jfedsdGQVNrle3GTJDOkC7cmQkocxBmbgns53BjNOqXdU02JNyZvS9Wgz8MCnkQeMttBW+e+A/d3/kUruNLbin0sJzMHhW4I3GC9Aq6AM1kFBphb6TZLs2aKi7DhccoyDhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=lMorisUp; dkim=fail (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=eSuOISPK reason="key not found in DNS"; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1730710600; x=1762246600;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=bZVznDietMqc8CDisChXL1GqxDSxeGo8m3Z1J4jxM2Y=;
  b=lMorisUpN+AQUmwWYZhPvRvHnHpgqFo2nMD+p0/zVQQDyWV6/9UL1oKr
   KfUKRi18WlA1j7PBVETDffMcMI+WwkA4P4q1nWJw8DjcjySsJ4qpQYGJC
   RJkQxrSIhIXsRDhcGAbcAXKXeaOqdu+CsC4omZdAiSdWj4kuAffw8o1gj
   jIgbmrjjGZ73RGBYYPczF+gthKFWfskdm0GPEP620HtHOHLtkS6MqIjrG
   5X15IX8NYd4DkpvHYuVDydyVMmu58YZi6V/l9YkK16h+SWjJPOHZy0cqe
   WwF/cpl2xWxRpMM7ZesozP6skSaW35T+oQlhhiisZu8igqZllQR/AvyHo
   g==;
X-CSE-ConnectionGUID: M8Pqh8T1SQubNcH7SyS38A==
X-CSE-MsgGUID: NH7lcu2QSreFwOgS1H6gcA==
X-IronPort-AV: E=Sophos;i="6.11,256,1725314400"; 
   d="scan'208";a="39825187"
Received: from vmailcow01.tq-net.de ([10.150.86.48])
  by mx1.tq-group.com with ESMTP; 04 Nov 2024 09:56:32 +0100
X-CheckPoint: {67288C40-C-90CD5875-E0265C0B}
X-MAIL-CPID: 0A056B4CA4F8B68938265580AB1C91AE_3
X-Control-Analysis: str=0001.0A682F17.67288C40.0091,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 788D8160A4B;
	Mon,  4 Nov 2024 09:56:26 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ew.tq-group.com;
	s=dkim; t=1730710587; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding; bh=bZVznDietMqc8CDisChXL1GqxDSxeGo8m3Z1J4jxM2Y=;
	b=eSuOISPKfPImLq0eXXN5Lwhyv503U1T0BcpmaKEIt/m3tpbtQ1gaweKcvynPFBkRcVvBCl
	ZGJps3JG6ZdK+kOz6F0mFQgxjass7YbMLdf0kAPzhq/cFriJL7weQK5S5DkZl8nOuCg1K2
	aEGVcKqsHUoe1LqOWgEOYV7pmsxtlMRt5eJ1AAYXdcKX4abFWns5h61FteR4//7+7CA2xX
	qZRLoKEBPp/42gh6GY+0fA0E29eN5ABwAlsPpBtQQoRXA1InzslxdhPUYspnKyTyIbtPlU
	SgG3Yh7G731Si5uDbqPhZ75eEF8s9Cb0XuqXiXbscyA9TWUzZnlQgYz8iKtZXw==
From: Alexander Stein <alexander.stein@ew.tq-group.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Peng Fan <peng.fan@nxp.com>
Cc: Alexander Stein <alexander.stein@ew.tq-group.com>,
	devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/1] dt-bindings: firmware: imx95-scmi: Allow linux,code for protocol@81
Date: Mon,  4 Nov 2024 09:56:21 +0100
Message-Id: <20241104085622.177781-1-alexander.stein@ew.tq-group.com>
X-Mailer: git-send-email 2.34.1
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
Changes in v2:
* Added default value

 .../devicetree/bindings/firmware/nxp,imx95-scmi.yaml   | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/firmware/nxp,imx95-scmi.yaml b/Documentation/devicetree/bindings/firmware/nxp,imx95-scmi.yaml
index 1a95010a546b1..c1b7140ee0098 100644
--- a/Documentation/devicetree/bindings/firmware/nxp,imx95-scmi.yaml
+++ b/Documentation/devicetree/bindings/firmware/nxp,imx95-scmi.yaml
@@ -12,13 +12,19 @@ maintainers:
 
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
 
+      linux,code:
+        default: 116  # KEY_POWER
+
   protocol@84:
     $ref: '/schemas/firmware/arm,scmi.yaml#/$defs/protocol-node'
     unevaluatedProperties: false
-- 
2.34.1


