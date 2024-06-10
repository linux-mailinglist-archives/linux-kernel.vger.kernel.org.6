Return-Path: <linux-kernel+bounces-207830-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 71BAB901CCB
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 10:19:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E95A4B23A33
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 08:19:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C76C5FBB1;
	Mon, 10 Jun 2024 08:19:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="W4WM/4bP";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="m8aqM+6A"
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6453242056;
	Mon, 10 Jun 2024 08:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718007573; cv=none; b=DvTbuHt14Ho8WUfzul5lb6YaAnPb0kaeLtXsXCuYQGI4c8/5ci8FLCXbyTh6ib+Q6Xt02uyFwm9wKouxX1ZZcnP9KvNu/4nM3OrajhIhcQ2BpwVfaPLkMfy02v7MR2C3VXyY1CVkgZDGYwhvtGp6W1pTUYIDkWCy7qPNKj6VL78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718007573; c=relaxed/simple;
	bh=LB1uCJgoLfTPxUw5p3900BEwW8PP2FYKrGJVvybz9U8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=mLx4Lj4evwdtXqaTJBuFf/D5rOo7Z73NsXLEx4bR57sZaBtshkjYbvCGKDnXzggKmsR6sa0lva50oanx8M9cN0GeyqG+StQGZ9MBH2Te79+DJdT2x/UyAMiU1zBr5x08ZNftt+F8QnVnn2Q9n3FaxXd3EtsORYRG3JGxnKtRkh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=W4WM/4bP; dkim=fail (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=m8aqM+6A reason="key not found in DNS"; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1718007570; x=1749543570;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=TFbicy+mwtStkQReucKb9kND+lMZA6N/BgT+KQQPvkY=;
  b=W4WM/4bP5XTBSBpu0TdGVPnYFptiTtNLmItCtn7vicUSF49jueFHa2sQ
   Igy0nT43rqaryo8w5pmHbWoU+rEez9lB/aPccZpPhbmvu0L6fM9ayQBtN
   Cd+Z28cZ/5QUxCycQqYJtuyj4GHaThqC2vXZGHJoGyvsi/NY/j6dMHwE4
   NkCGvKdtVzloKI/sZy8c8wJkcW9rXAJia2Y+e/fXHMQFr+U+pF4wH6r+x
   +cM7vy74ArBLDWGiGN9Bw98j7wRYE6tD1/s3w9R8eJBmsd6Z57YcrBBhJ
   e9B8eCgazPSy0cs8YBOFPurSV5PZFfknBkJaxl/gOHb87ACMtWXMFWiXD
   g==;
X-CSE-ConnectionGUID: qw+0R3kbRdeal3fn5U2vsQ==
X-CSE-MsgGUID: oWrJ6gO9QX6XOCXfT+wDTg==
X-IronPort-AV: E=Sophos;i="6.08,227,1712613600"; 
   d="scan'208";a="37303535"
Received: from vmailcow01.tq-net.de ([10.150.86.48])
  by mx1.tq-group.com with ESMTP; 10 Jun 2024 10:19:21 +0200
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id F350D160AC6;
	Mon, 10 Jun 2024 10:19:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ew.tq-group.com;
	s=dkim; t=1718007557; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding; bh=TFbicy+mwtStkQReucKb9kND+lMZA6N/BgT+KQQPvkY=;
	b=m8aqM+6AMMtaRlm2cEfyY/dCKIAwl3Tz5u9ATlDGroa3SpItJ2Ptm98O1IsRBbgrckYKLB
	wf6k5vktPdgStDNffuo1nXnhxO7aut0vlTTVU8ga5Bn2cY70BX/OF8aIyVMDAlyecJe3UJ
	zGnAm8Oz4O55WCyyPaNC0RkQ/O6tJBBMiv9Zcb4phFvwu007HU5+L4HtW1T5ZIFUI09YW+
	r97yaMAFcE0irVb9aMmnCMxig3vZtHYHXs5XyA85mXkgZkZp4VsjGtm1PwHKXBDVShIRXf
	zTn8+7nCtgHiCnCq5Am14oEyd+BjMDM4aJ+Arb7pjwCuoixW0/ow3aJ7KMwfjw==
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
Subject: [PATCH v2 1/2] dt-bindings: arm: add MBa8MP-RAS314 SBC
Date: Mon, 10 Jun 2024 10:19:12 +0200
Message-Id: <20240610081913.46790-1-alexander.stein@ew.tq-group.com>
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


