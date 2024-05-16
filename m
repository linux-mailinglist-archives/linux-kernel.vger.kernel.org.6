Return-Path: <linux-kernel+bounces-180936-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 172298C7529
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 13:24:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE764284C16
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 11:24:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAA801459F2;
	Thu, 16 May 2024 11:24:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="QwzuzIkC";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="JlhsJMet"
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BB3A145A04;
	Thu, 16 May 2024 11:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715858641; cv=none; b=bTRLmb1PLqteRZv5wl+LYQgBVTFTEAxEX2qwFvusaa3CjzlPAPf0b1wAJ3/ww1+0nhpCXuM7N1u2XFzdsugYnJsUMaHghVVz7ZI48cSw8SDBFGFR4jt+eIqVGrFQzfgj9R4rfpGNbJtAMz6S1XS5sJTQXHLkTZpGp8LmxUnzDB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715858641; c=relaxed/simple;
	bh=dygKe781fou1FapmVMwdHZ+d2tsqO0Q3GSv4mBt+99I=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=P2grfTGvhwkpzP4YxKBZ2fjpmcQ/+frMGyefbq9twRWNpCSj4c36WpNwsdh56wGEyr0EnOxx8PScmUR+oKxP7r+KTrtfnKZwV/zurH+WKAlY3aBVvGV6CsiYc83VaZtubUn9WBrl5tZypgzecq4v9SYl4qOjYjUJhduhOhphrys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=QwzuzIkC; dkim=fail (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=JlhsJMet reason="key not found in DNS"; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1715858638; x=1747394638;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=4dnex/xUk7TjleoUmpI1aQSD8YhKcwheLotIfshPkPY=;
  b=QwzuzIkC7xJ7VrWmg20ZRpS8lfCe21GzmskC5w7CZkgPxTLhYR15dyXI
   +SOSq95elrIM9K+nIZm4wzhCDpOzSfYsJJyEyt6shcfGKysomvF6oKBZs
   IjT460lvHH5HCVHD+n3LXJtQP+B9EzpXypZMEtC9vjWV7FCyi8VnvinOD
   rTcdQPNUlDksWm3hnxlRfl/0BVV0mP51yiozAMhD0KNZvvaC5SPLA6eJ9
   N42YcGKqpwQdwZ/mwsKJoCnebscz++WFzlB45Mfe7A6DCDVXAURPLmZT+
   t7BeoktixPvr/VNX+uZKuEkSsiqnL4+2s4JS0TUsHpBQUl3BbQTDEpJTF
   A==;
X-CSE-ConnectionGUID: Vb+Dj1RYToCD1bT9sQ8bKw==
X-CSE-MsgGUID: BqdPCyzYQgSe76uwnvXjzw==
X-IronPort-AV: E=Sophos;i="6.08,164,1712613600"; 
   d="scan'208";a="36936029"
Received: from vmailcow01.tq-net.de ([10.150.86.48])
  by mx1.tq-group.com with ESMTP; 16 May 2024 13:23:57 +0200
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 28C65172C19;
	Thu, 16 May 2024 13:23:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ew.tq-group.com;
	s=dkim; t=1715858633; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding; bh=4dnex/xUk7TjleoUmpI1aQSD8YhKcwheLotIfshPkPY=;
	b=JlhsJMet1DcYfqCXGHFmHnAS+CzKzfp+7FckSZVIsOthwATfHQyu1zL06qunDbbuxcBiSP
	6O0VhcyUBClg7jvQIcJLQEjwFihRW3j0mQ+xiw7Jst2qjGKJW65RRJF28nm6b0QPxyggam
	2nHEnnctTQYH5nJ2ObFRih0oBObbXATqmmvqC3+cqiNquGsDTfIgFirEcDr3ArEdGuu2ef
	K0iFKFn3HalCso2qqrX0+T1C+VWNvVHyH8B5CCweFPz47PGJzuTYP3uOXKiPkt9bmptWvf
	gMUWTtR9hcv/FMHWdWnui3h0uoVS3xubZR0ACaYwIWk7QUbx3YbKuG8/d4p7Rw==
From: Alexander Stein <alexander.stein@ew.tq-group.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Li Yang <leoyang.li@nxp.com>
Cc: Alexander Stein <alexander.stein@ew.tq-group.com>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] dt-bindings: arm: add MBa8MP-RAS314 SBC
Date: Thu, 16 May 2024 13:23:54 +0200
Message-Id: <20240516112355.200265-1-alexander.stein@ew.tq-group.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

MBa8MP-RAS314 is an SBC based on the embedded module TQMa8MPxL.
All relevant interfaces integrated in the CPU have been implemented on
the MBa8MP-RAS314 for (an) industrial usage. Due to the numerous interfaces
and the small size of this SBC the use in different applications
is possible without the need of a [special,custom] design.

Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
---
 Documentation/devicetree/bindings/arm/fsl.yaml | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentation/devicetree/bindings/arm/fsl.yaml
index 6d185d09cb6ae..f168400d29950 100644
--- a/Documentation/devicetree/bindings/arm/fsl.yaml
+++ b/Documentation/devicetree/bindings/arm/fsl.yaml
@@ -1145,8 +1145,9 @@ properties:
           version as an industrial computing device.
         items:
           - enum:
-              - tq,imx8mp-tqma8mpql-mba8mpxl # TQ-Systems GmbH i.MX8MP TQMa8MPQL SOM on MBa8MPxL
-          - const: tq,imx8mp-tqma8mpql       # TQ-Systems GmbH i.MX8MP TQMa8MPQL SOM
+              - tq,imx8mp-tqma8mpql-mba8mpxl      # TQ-Systems GmbH i.MX8MP TQMa8MPQL SOM on MBa8MPxL
+              - tq,imx8mp-tqma8mpql-mba8mp-ras314 # TQ-Systems GmbH i.MX8MP TQMa8MPQL SOM on MBa8MP-RAS314
+          - const: tq,imx8mp-tqma8mpql            # TQ-Systems GmbH i.MX8MP TQMa8MPQL SOM
           - const: fsl,imx8mp
 
       - description: i.MX8MQ based Boards
-- 
2.34.1


