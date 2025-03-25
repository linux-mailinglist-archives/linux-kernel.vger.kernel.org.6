Return-Path: <linux-kernel+bounces-575407-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 543EEA7022A
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 14:38:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5452918806BE
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 13:29:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE60F188A3A;
	Tue, 25 Mar 2025 13:19:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="SmhH3SNb";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="QT45mSxu"
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEE8F125DF;
	Tue, 25 Mar 2025 13:19:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742908783; cv=none; b=tfHkJjpfMWraSk510F8iQ3zK4lbcTTKpLVR74PZivgp+bmlzhSAd04i8B2yaSoZmvpE5J8Phheg8kYCGbXHjzlxqCCbR41iSk/Tvay/kMvAVM05EdeCvMJSuTbBsqEdz0RLQ7QUzU4QW6w4SfXnAfWwib90EYwhUYIDeWh9694U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742908783; c=relaxed/simple;
	bh=DVeixBVuxDT4oMWaD2rURJ/uLpvPHd0QOtOr4AymZrg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=fGPc0QzgnZPEthpREpwZd0mvArfGIdLETNFvp7kUi39xMcNwbOb3AD8hQ4OYy8NNZqhqOB5sfzPGh6PRgiXq+gEQPJpP064PF7ZR2jb6ZOp4xEetnLDoNymD9Jn8/iR6G8pf960YIWLGn/AzPChKc0OxzvLsfIN8jN2bzefLO9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=SmhH3SNb; dkim=fail (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=QT45mSxu reason="key not found in DNS"; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1742908779; x=1774444779;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=8UycVuZiVNJB4WUINByx61NDOE4aSQezliwEn5u6VQ8=;
  b=SmhH3SNbMjaWwc0gCy97ZIyZBblJVIFnmwAKd+58/XodLBHMyD/vX7Dq
   myG/YKURzqZBaMFq1kfQd8HbrgvOfgrtu61lQtsAsFDQUF2toGaomzGy+
   lEX9p7nB6F5U6Y729hMYEs7+wxkEe5XMzJx181L2tsjSgPPUWYJ9D0zoB
   AsO5/0JOIg5Ic0BjjVsAgC4kUOrNWP0F4TzwDxx46NBcMCudL0Km+PCK4
   AEV7kY4PeAJ6c74gdoZtpfWyx3SdW439i+fLj7W+hDFDA76wVThYplLZl
   DwRYF7l1XfunLsp6dONSsC5zjnnhCxJ54bJNv+8jDKzI+W++BN/U7Zidc
   Q==;
X-CSE-ConnectionGUID: xEkqf47SRmOlZuBVH8GBHA==
X-CSE-MsgGUID: ZasAIHFhSm2cLlpvUuDSCQ==
X-IronPort-AV: E=Sophos;i="6.14,275,1736809200"; 
   d="scan'208";a="43148001"
Received: from vmailcow01.tq-net.de ([10.150.86.48])
  by mx1.tq-group.com with ESMTP; 25 Mar 2025 14:19:30 +0100
X-CheckPoint: {67E2AD62-2E-2417938-F0170C2B}
X-MAIL-CPID: 13A640736E1C7EA6E91AFA08FE664B38_2
X-Control-Analysis: str=0001.0A006396.67E2AD5A.0038,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 7D57916AB6C;
	Tue, 25 Mar 2025 14:19:24 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ew.tq-group.com;
	s=dkim; t=1742908765;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=8UycVuZiVNJB4WUINByx61NDOE4aSQezliwEn5u6VQ8=;
	b=QT45mSxuM3bcqPqUbEzB60yOjsQ5VvM2MdE50KKc685znvgYCijep6FbiEbtaehC6jeAP/
	SzcAom3TRCUoVz5tRUvkJ8hv3bOTmzrgBfyyJSSjgEsBQus3WpNmnThIhF3LkWUPeBz72q
	LPR5YohyA4sdyU0F2L+NNWvDq30Aoi4uONEcRXTzrjS9fRL69bhGuYiwh7lxhVd1C2lTaE
	klH0ZyzBA1OzIefw+9rv9ujPVnzH46p67+tuFKZtLCrrmLEztDwc7nux12hstszAgRheyf
	4PQW5YgnoWukrmpte0yuKJdUqA+RUFlBFIUsjb8TMz1YVO/1I43yXEjcYFmbYQ==
From: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Cc: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Felipe Balbi <balbi@kernel.org>,
	linux-usb@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux@ew.tq-group.com,
	Matthias Schiffer <matthias.schiffer@ew.tq-group.com>,
	Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH v3] dt-bindings: usb: dwc3: Allow connector in USB controller node
Date: Tue, 25 Mar 2025 14:18:48 +0100
Message-ID: <20250325131848.127438-1-matthias.schiffer@ew.tq-group.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

Allow specifying the connector directly in the USB controller node, as
allow in other USB controller bindings and commonly used for
"gpio-usb-b-connector". Linux already supports this without driver
changes.

Signed-off-by: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
---

Changes in v3:
- Rebased onto linux-next (moved to the new snps,dwc3-common.yaml)
- Extended commit message
- Pull patch out of "TQ-Systems TQMa62xx SoM and MBa62xx board" series,
  as the series will need some more rework, and this patch should be
  good to go independently (and should go through the USB tree, unlike
  the rest of the series)
  In the submissions of the previous versions, the linux-usb list was
  forgotten by accident.

Changes in v2:
- Collected ack
- Rebased onto v6.13-rc1

 Documentation/devicetree/bindings/usb/snps,dwc3-common.yaml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/usb/snps,dwc3-common.yaml b/Documentation/devicetree/bindings/usb/snps,dwc3-common.yaml
index 71249b6ba6168..6c0b8b6538246 100644
--- a/Documentation/devicetree/bindings/usb/snps,dwc3-common.yaml
+++ b/Documentation/devicetree/bindings/usb/snps,dwc3-common.yaml
@@ -390,6 +390,12 @@ properties:
     maximum: 8
     default: 1
 
+  connector:
+    $ref: /schemas/connector/usb-connector.yaml#
+    description: Connector for dual role switch
+    type: object
+    unevaluatedProperties: false
+
   port:
     $ref: /schemas/graph.yaml#/properties/port
     description:
-- 
TQ-Systems GmbH | Mühlstraße 2, Gut Delling | 82229 Seefeld, Germany
Amtsgericht München, HRB 105018
Geschäftsführer: Detlef Schneider, Rüdiger Stahl, Stefan Schneider
https://www.tq-group.com/


