Return-Path: <linux-kernel+bounces-285959-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A78F9514DD
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 08:58:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AD1CC1C22BF5
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 06:58:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C0E213A40C;
	Wed, 14 Aug 2024 06:58:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="NQicJqic";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="fgJCpRnp"
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FB73139CFF;
	Wed, 14 Aug 2024 06:58:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723618729; cv=none; b=RTfappUPkN07Y/kPhX4eo9HaaoRIqlcLf30i6i6mJ8IyKN+LXpCTTfqiD3N2ZEoKtn7TLwgryLpVTNlgO8LsNbPNOYlc4WMybsJXuC0EJZW8ixALhnB0JjaAW74sfYprvI732/KCKpXeaHft5UhB3xsJi9EpA8o/rHNvPhjXJD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723618729; c=relaxed/simple;
	bh=t7CBaIxNVj9T0fzzc3RFMK3i8sNHL0A5x2Jiz9dAgio=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=F+l4+skK4eADpmcBKA7DONyzdwE9x3+1gqprE/VTCmzbH3zfXERooPv/5QPK46v8oAHB5luNF+2gr8fSBb9Hwj8hcjkN6KEh1XPIJ+VTJC/xS12VnqAbShA38jxKSMcvA0S4rBnPQptPm+7NP5udf2fF5Pz1n8WxF9S6dS5QYmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=NQicJqic; dkim=fail (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=fgJCpRnp reason="key not found in DNS"; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1723618725; x=1755154725;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=T8Dk74LGDVg/tN90TzcMULyu6cYduNis76nw3yjsFUk=;
  b=NQicJqic96KGCNX+o7Oqth5xqosH8a5xlABb40D+iwU308Nhw63SiSpX
   FvMTCtvjZTHSRQmOKRORVNjPmiWHT/wRXpFL/CMYO+odIi4DAUw7/7XFc
   OH8mj0BRVwz8dzJfWJF5eZio39MMELGldO3zW6tPoDn4YfvXWU2WFBz5X
   K7kInW0c2hT5i7bJdkn5o4Zj/IVWZdgwTy/O+OIaqpIxNU/HMhDTKfIz8
   QcxuzB6X8kj1bpPpnYP0m9asdZ2OEAK22+tlyWeKy2Ag/YBEcRXMvUKFp
   FYybZ8kgwEW9kUBaJY7sPV+GN57AhZIfAQhWVVNuI9etJ6zwKBiFXbaMp
   Q==;
X-CSE-ConnectionGUID: mf7OCCk2SCigMPR2/cQ1JQ==
X-CSE-MsgGUID: 4DQpEQThSDqDRiVxiQEJ3g==
X-IronPort-AV: E=Sophos;i="6.09,288,1716242400"; 
   d="scan'208";a="38398272"
Received: from vmailcow01.tq-net.de ([10.150.86.48])
  by mx1.tq-group.com with ESMTP; 14 Aug 2024 08:58:42 +0200
X-CheckPoint: {66BC55A2-1F-2C7A84BB-EFCBC4CF}
X-MAIL-CPID: B571A4AD0AE74DDCB56BA14AD4731CB4_2
X-Control-Analysis: str=0001.0A782F1F.66BC55A2.0122,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id D8FC816339B;
	Wed, 14 Aug 2024 08:58:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ew.tq-group.com;
	s=dkim; t=1723618718; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding; bh=T8Dk74LGDVg/tN90TzcMULyu6cYduNis76nw3yjsFUk=;
	b=fgJCpRnplIJGp80TfykALyYJ6I7ABhibmBg1B4tRHQNPHBq6ip6aUawUKR3XzYo1pbuNg9
	0TS3TUS7dWydZ01xAOq1qThL+IOsxLlQkJYTJDTPTltrSzC/DcMxG22XAbRNgR50QVywo/
	i9Dpnxj8f5p2HCRSRRw5Gd4S0h8u+ibE0WxYlAk5h5LWpYzHIt3Z1Kbc+vQFM/8plscDdR
	f9Q8KYkD7u0gF2S+w1r5bEsv9CQnGsSdoAnmRHkaVq9CnTqmztmpPtHLpmo0WGdgXSTo0h
	ET/FjqX96CEdzuuda6AC8bTp2HvG+L4ufWeR+e3f5jkVjbi+9i6iMj9j3Z8oNQ==
From: Alexander Stein <alexander.stein@ew.tq-group.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Fabio Estevam <festevam@gmail.com>
Cc: Alexander Stein <alexander.stein@ew.tq-group.com>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	linux-usb@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/1] dt-bindings: usb: microchip,usb2514: Fix reference USB device schema
Date: Wed, 14 Aug 2024 08:58:32 +0200
Message-Id: <20240814065833.36372-1-alexander.stein@ew.tq-group.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

An USB hub is not a HCD, but an USB device. Fix the referenced schema
accordingly. Adjust example to keep it aligned to other schemas.

Fixes: bfbf2e4b77e27 ("dt-bindings: usb: Document the Microchip USB2514 hub")
Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
---
As this USB hub also can contain an USB (ethernet) sub device, I copied
the subdevice part from usb-hcd.yaml.

I had to add 'additionalProperties: true' as well, because I got that warning
upon dt_binding_check otherwise:
> Documentation/devicetree/bindings/usb/microchip,usb2514.yaml: 
>   ^.*@[0-9a-f]{1,2}$: Missing additionalProperties/unevaluatedProperties constraint

I added a Fixes tag to keep this schema aligned in v6.10 stable tree.

 .../devicetree/bindings/usb/microchip,usb2514.yaml    | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/usb/microchip,usb2514.yaml b/Documentation/devicetree/bindings/usb/microchip,usb2514.yaml
index 245e8c3ce6699..aa3db8e373c70 100644
--- a/Documentation/devicetree/bindings/usb/microchip,usb2514.yaml
+++ b/Documentation/devicetree/bindings/usb/microchip,usb2514.yaml
@@ -10,7 +10,7 @@ maintainers:
   - Fabio Estevam <festevam@gmail.com>
 
 allOf:
-  - $ref: usb-hcd.yaml#
+  - $ref: usb-device.yaml#
 
 properties:
   compatible:
@@ -36,6 +36,13 @@ required:
   - compatible
   - reg
 
+patternProperties:
+  "^.*@[0-9a-f]{1,2}$":
+    description: The hard wired USB devices
+    type: object
+    $ref: /schemas/usb/usb-device.yaml
+    additionalProperties: true
+
 unevaluatedProperties: false
 
 examples:
@@ -47,7 +54,7 @@ examples:
         #address-cells = <1>;
         #size-cells = <0>;
 
-        usb-hub@1 {
+        hub@1 {
             compatible = "usb424,2514";
             reg = <1>;
             clocks = <&clks IMX6QDL_CLK_CKO>;
-- 
2.34.1


