Return-Path: <linux-kernel+bounces-342450-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E87F988F3E
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Sep 2024 14:48:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D4486B2151B
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Sep 2024 12:48:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 142E0187FF2;
	Sat, 28 Sep 2024 12:48:30 +0000 (UTC)
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB5481DFF7;
	Sat, 28 Sep 2024 12:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727527709; cv=none; b=LL3gBaphhA6/cORcAC+Q34/Qlnd+Uzd55Yn/sD+u0Vjx3XJlE5J7dcoQkfj9hBHWpYfxB8WAZt7C31YR27Nz4me3L8hHClWuG6Dub8cjDcirYGGWCKJp0X4jb5PLHH+jO9ETS+KDr4pmv6rU4cvj3fEyGc/K94pVzx9E8HVncLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727527709; c=relaxed/simple;
	bh=H4ioE1FahHphI91yaeFtyMXpKapW58qXJau5TPysqAA=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=sHHeLiyLBKaB48/BaZHrNySgBUV5+8g4Yuy8+uKSu8gii8x8X8mJXqliyNGc1oMw5dMb5szPLcxyCTbc0pRxWeZrZamTq2z8Hm/iZD3Y90IeB5rJTo7K2E8I3+oRIe+O5NYHRxnbYKmtaLt3MDR44qLnTaR0A5vExjmKgVsQ29A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.98)
	(envelope-from <daniel@makrotopia.org>)
	id 1suWrh-000000004V2-2pUt;
	Sat, 28 Sep 2024 12:48:01 +0000
Date: Sat, 28 Sep 2024 13:47:54 +0100
From: Daniel Golle <daniel@makrotopia.org>
To: Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Zhihao Cheng <chengzhihao1@huawei.com>,
	Daniel Golle <daniel@makrotopia.org>,
	John Crispin <john@phrozen.org>, linux-mtd@lists.infradead.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH RFC 1/2] dt-bindings: mtd: ubi-volume: add
 'volume-is-critical' property
Message-ID: <e0936674dd1d6c98322e35831b8f0538a5cfa7a3.1727527457.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Add the 'volume-is-critical' boolean property which marks a UBI volume
as critical for the device to boot. If set it prevents the user from
all kinds of write access to the volume as well as from renaming it or
detaching the UBI device it is located on.

Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---
 .../devicetree/bindings/mtd/partitions/ubi-volume.yaml   | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/Documentation/devicetree/bindings/mtd/partitions/ubi-volume.yaml b/Documentation/devicetree/bindings/mtd/partitions/ubi-volume.yaml
index 19736b26056b..2bd751bb7f9e 100644
--- a/Documentation/devicetree/bindings/mtd/partitions/ubi-volume.yaml
+++ b/Documentation/devicetree/bindings/mtd/partitions/ubi-volume.yaml
@@ -29,6 +29,15 @@ properties:
     description:
       This container may reference an NVMEM layout parser.
 
+  volume-is-critical:
+    description: This parameter, if present, indicates that the UBI volume
+      contains early-boot firmware images or data which should not be clobbered.
+      If set, it prevents the user from renaming the volume, writing to it or
+      making any changes affecting it, as well as detaching the UBI device it is
+      located on, so direct access to the underlying MTD device is prevented as
+      well.
+    type: boolean
+
 anyOf:
   - required:
       - volid
-- 
2.46.2

