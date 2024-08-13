Return-Path: <linux-kernel+bounces-284204-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B1F6394FE6F
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 09:13:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E53EB1C22B6C
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 07:13:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98C3D481D1;
	Tue, 13 Aug 2024 07:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="eyzswFw/";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="XI0J4xhZ"
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EADB433DF;
	Tue, 13 Aug 2024 07:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723533195; cv=none; b=ebjDF7C2/UtwQCJMk7RT91afeQzfJY4ptH/1cyrnMAnUzuYt3hbBI/y+9eKqIqKnFetNMcxmVyCLsSFEbx0+hum6dzmWOoBdAT/Gip9b5ikruNX0S3irXsYWqlhVtsRE3ntjaIOzXokxJaWw7nUdyT8KGHuhH+M6/mydSE9P5D0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723533195; c=relaxed/simple;
	bh=Tz5+o2EQJanqDHdMEFmTbyOuz3iB7nz7hXbq9aJpFrI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=FKid/soj1HYkMqd+XImVzoexdnG3EXM3EPriLqoQX7q9uSE89uLmb24lcHG0UGDDoXzZpE/ZycUiBNCsfh1lApqtanP0dk8mtUkCa5+IFX7dnSLAnf+sALXFwJ86uXcqUYlzxa9esZCcNjK4Gz1ftQnEzc/uMX7Sh3F83Joo/i8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=eyzswFw/; dkim=fail (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=XI0J4xhZ reason="key not found in DNS"; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1723533193; x=1755069193;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=uUuJ2n6fURX6Nklvg7wbVO/q+IKx32NfKbL47pNkCqQ=;
  b=eyzswFw/Y7YMTto43AMU6eIu/uWWqAbsKewp6vUTQzwUuFXrz+JxJs3K
   Gr/mIjJ2hKA19bPOIjZyDWOn3aF2xZLMg7QqLkj5o26QlU02w/iWtrQoc
   I9DsFuknRqun/5pMsceIvx2N0RFP5z28/1QiVs/WruR5MK5TmVJpSyMHH
   SjakKrLhUgD33muEZpR559ncch870iK7UMup4Jfo9svVYF/VTLmVHIqah
   z9PM2dq9jsvBKwfGwFEUy8DAYUpqVRD54x0zgtUa/GhvjWy3f99t2yOo5
   +SuE0yV9cu1z9/zADy6bnreUXRAs+dHCLW6cTA05yHPGBv52l9e2CO5E7
   w==;
X-CSE-ConnectionGUID: LlxiBH6PQ0yKpbbmG3MElw==
X-CSE-MsgGUID: 4KnMRvpcRfaceBZ6CV0HIQ==
X-IronPort-AV: E=Sophos;i="6.09,285,1716242400"; 
   d="scan'208";a="38375669"
Received: from vmailcow01.tq-net.de ([10.150.86.48])
  by mx1.tq-group.com with ESMTP; 13 Aug 2024 09:13:10 +0200
X-CheckPoint: {66BB0786-D-78509F09-E532FC2E}
X-MAIL-CPID: 47CC1E94C537C86FAA25695DC1D67304_1
X-Control-Analysis: str=0001.0A782F28.66BB0786.00CB,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id D6B66167330;
	Tue, 13 Aug 2024 09:13:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ew.tq-group.com;
	s=dkim; t=1723533186; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding; bh=uUuJ2n6fURX6Nklvg7wbVO/q+IKx32NfKbL47pNkCqQ=;
	b=XI0J4xhZDHVFcWSyGKrjEb0m/8FnxBEKKLG2hTXDyZjSWHEdn7h0hLDOKKCuguIGvTHPA5
	lHUwPaW3AUd5iOhUOVzmbnfDiS+d7vEnHrgi6SbLlN/aLGQfGQdLrC/4kjVct8l0xdEEEY
	0y21u77FPkCwz9bDy7v/kAu+jE5pKuHi+fxjyE0gFOXkT7OXNYIWn8C2sYf8IOy/SnTM/p
	HOXLtYw0LnQ3pLW5SlPtemUPtKYKLKMIgXsCJuepjFADCL535kHJ4Kw/FOU7B3j4/9Yh7t
	AQF6IvjyDRwx1egX1gQP11+tq00eV/IMWX4sao6q3cfnFAncB4C3OPm9KkhwYw==
From: Max Merchel <Max.Merchel@ew.tq-group.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>
Cc: Max Merchel <Max.Merchel@ew.tq-group.com>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/1] dt-bindings: arm: fsl: correct spelling of TQ-Systems
Date: Tue, 13 Aug 2024 09:12:42 +0200
Message-Id: <20240813071242.71928-1-Max.Merchel@ew.tq-group.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

TQ-Systems is written with a hyphen. The incorrect spelling with spaces
is therefore corrected.

While at it, comments are added to TQMa6ULLx.

Signed-off-by: Max Merchel <Max.Merchel@ew.tq-group.com>
---
 Documentation/devicetree/bindings/arm/fsl.yaml | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentation/devicetree/bindings/arm/fsl.yaml
index 80747d79418a..7d173f6416da 100644
--- a/Documentation/devicetree/bindings/arm/fsl.yaml
+++ b/Documentation/devicetree/bindings/arm/fsl.yaml
@@ -809,19 +809,19 @@ properties:
           - const: kontron,sl-imx6ull   # Kontron SL i.MX6ULL SoM
           - const: fsl,imx6ull
 
-      - description: TQ Systems TQMa6ULLx SoM on MBa6ULx board
+      - description: TQ-Systems TQMa6ULLx SoM on MBa6ULx board
         items:
           - enum:
-              - tq,imx6ull-tqma6ull2-mba6ulx
-          - const: tq,imx6ull-tqma6ull2      # MCIMX6Y2
+              - tq,imx6ull-tqma6ull2-mba6ulx # TQMa6ULL socketable SoM with MCIMX6Y2 on MBa6ULx EVK
+          - const: tq,imx6ull-tqma6ull2      # TQMa6ULL socketable SoM with MCIMX6Y2
           - const: fsl,imx6ull
 
-      - description: TQ Systems TQMa6ULLxL SoM on MBa6ULx[L] board
+      - description: TQ-Systems TQMa6ULLxL SoM on MBa6ULx[L] board
         items:
           - enum:
-              - tq,imx6ull-tqma6ull2l-mba6ulx # using LGA adapter
-              - tq,imx6ull-tqma6ull2l-mba6ulxl
-          - const: tq,imx6ull-tqma6ull2l      # MCIMX6Y2, LGA SoM variant
+              - tq,imx6ull-tqma6ull2l-mba6ulx  # TQMa6ULLxL LGA SoM with socketable Adapter on MBa6ULx EVK
+              - tq,imx6ull-tqma6ull2l-mba6ulxl # TQMa6ULLxL LGA SoM on MBa6ULxL gateway board
+          - const: tq,imx6ull-tqma6ull2l       # TQMa6ULLxL LGA SoM with MCIMX6Y2
           - const: fsl,imx6ull
 
       - description: Seeed Stuido i.MX6ULL SoM on dev boards
-- 
2.33.0


