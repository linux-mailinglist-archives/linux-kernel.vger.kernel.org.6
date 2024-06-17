Return-Path: <linux-kernel+bounces-216896-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F67290A832
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 10:13:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C85201F24B91
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 08:13:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93730190499;
	Mon, 17 Jun 2024 08:12:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="NZ51vGvJ";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="kB3bj8/a"
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FC2918FDC8;
	Mon, 17 Jun 2024 08:12:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718611962; cv=none; b=Ews23dw8YPwBVXoaMymsFr8fJ4Rs36QBEA8AVRvyYru/P4lpq5IveGvA7ekwGsZpUfAIYHMLMMBeIT/BQKBGkWUc2yPdRfC3Jlfr8oWHaoWny43XoDWNI3qYU0e9xvXRWza67vxTJ0ViPxc7dtRBuKOykSn4I5ThNAxIVrEdNSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718611962; c=relaxed/simple;
	bh=LB1uCJgoLfTPxUw5p3900BEwW8PP2FYKrGJVvybz9U8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=FY9v3qSwqn3ZY+4PUco5uuLTO0UOo/tBpocjKjEzzeNplWs+1D/1JHvJ5YFBc+zXGXB/+L5LnKhvAA7YScI2YSMRpFoS1eW3gM1jCH9hI4wj9P7iR/OgBNvVUjUTDTpt9qKwz3IB136uEDvk+CLfb+1pm91S8d+sMJyRX3Yt4FM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=NZ51vGvJ; dkim=fail (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=kB3bj8/a reason="key not found in DNS"; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1718611959; x=1750147959;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=TFbicy+mwtStkQReucKb9kND+lMZA6N/BgT+KQQPvkY=;
  b=NZ51vGvJYExKG96N+eMW15BRLd81+tAJdMA13ArlF6JT6d8GV7Uhryqp
   1Vv9+EKmigskEVXsiueGwVqVvyWhm+nhgAOw/zLqjXtVam+HjFJT8YpoG
   C//LFvlVUITGjoh7JDE9mkYVZuJWNE6a94PWbFuPaLevTv8FMQzDxIf80
   qLrLf0g5uLGO0wbuDscA/DzYr/UKo4SlMQoxthdH+wkz2AV4CgrE4SvkY
   7Z2ktSIKIzn4h3QjiKgKyFi584Dkl9M0bLNo22WLbJ+PZjssyOpQdOwqL
   LfMtG/ZRNKLOSO07NvvN7J5FfTlEii/rDepiOPFyE5v3fI4a1rhlAukcA
   Q==;
X-CSE-ConnectionGUID: /2GYNCziSWqafNXgADeirw==
X-CSE-MsgGUID: feKQdwM2R5WHlEm4kwBTWg==
X-IronPort-AV: E=Sophos;i="6.08,244,1712613600"; 
   d="scan'208";a="37420109"
Received: from vmailcow01.tq-net.de ([10.150.86.48])
  by mx1.tq-group.com with ESMTP; 17 Jun 2024 10:12:36 +0200
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 82529165881;
	Mon, 17 Jun 2024 10:12:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ew.tq-group.com;
	s=dkim; t=1718611952; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding; bh=TFbicy+mwtStkQReucKb9kND+lMZA6N/BgT+KQQPvkY=;
	b=kB3bj8/adMXRRmWmn/htTlCospq5P7v541JbsPm894OaHu9JEi6Y+SU1WuqZxc0KWourHD
	y0nlXmk1TrWKWPogH+igp+OF5KZu0tBjUa7OHN7c5SDBxmdI1CI8CE1xrCOSsjfZxAvRcV
	4p+69OpesU951fKlu+9fUdHr4ctabjTx8hIZ2c01VMRUTzBJrnQB3pR8Y4/gUl0o8PoLhI
	IPNRAU9y4mgJjH3S1BSh/85koJ+f95XwKW6i2pxLAKBg1i6V0ZHpeit/FX6S313UTtiYD7
	1R4QTtnH6+cn0l/dozmaQaLG/GefRfVVzKzb7URxWvJ5s4fAxcobYoRgbPAZ0Q==
From: Alexander Stein <alexander.stein@ew.tq-group.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Li Yang <leoyang.li@nxp.com>
Cc: Alexander Stein <alexander.stein@ew.tq-group.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/2] dt-bindings: arm: add MBa8MP-RAS314 SBC
Date: Mon, 17 Jun 2024 10:12:28 +0200
Message-Id: <20240617081229.195638-1-alexander.stein@ew.tq-group.com>
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
Acked-by: Conor Dooley <conor.dooley@microchip.com>
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


