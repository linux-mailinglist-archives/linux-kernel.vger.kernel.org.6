Return-Path: <linux-kernel+bounces-336377-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 826FF9839DD
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 01:04:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 002C91F220FC
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 22:57:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7BFF12CD89;
	Mon, 23 Sep 2024 22:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b="NE5qcTUQ"
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [202.36.163.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A95D0126C0C
	for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2024 22:57:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.36.163.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727132249; cv=none; b=Aqb4MaEGq5JD5uAMqS/sIr9qvPNjiWLj6xNIOfUCwojgwkLn9K5NFL2Tjox3Hwl1L17hWJBlNrgMZk9QdCBQcAxGxCiWs35RgXottt/YrDzKfpbS97Bdh+VN8OX8zGU2IlWnXCEQvJ7lebNqg+DNXQzKKz1B7zTsrXGvhct9Yu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727132249; c=relaxed/simple;
	bh=EbnVLx57027FowiGZ2tAUiI9ulPHqKSPwbQfoqRhDVY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CJq1mVr3vNol+yUHZ9M6y4o7bBS+VFKzLEwtKL+6d/ctdOGzzh4XdSzPBxdr+BMjGGphMujjSgNmqh3oXHPl8Rl07ZaoxvcboCFmTyfmFKqcXmWuAMi1NqLAb9oJhHGrwSAex0ZG3TDj0GPYXki6vVUSvSRZJPNYjjfRuiv8VzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz; spf=pass smtp.mailfrom=alliedtelesis.co.nz; dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b=NE5qcTUQ; arc=none smtp.client-ip=202.36.163.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alliedtelesis.co.nz
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 423FE2C0613;
	Tue, 24 Sep 2024 10:57:23 +1200 (NZST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
	s=mail181024; t=1727132243;
	bh=HntQRhLdGZ3zqOBGA94v/e1rM6aolDz4a97biFSUOJw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NE5qcTUQ5TXDt1PnXSD3duxnh8IIPmjR9tak7LlliPixQnGsFIdydk7+x1mf1i9Gb
	 SzF/mbENZn0xUR4/QczA0Kh4HOSpaurYsYHSbmzZz5MybLprhvqdsuB0zioGYMD+4c
	 BkmK72j2ukG5bLcaGKgVQHsZdjfQ+mOMipW7wTvYY11rcyzVupIAbxJS/3cINS8cCX
	 lo6cUrk/s78uPx+R7FXV/HrOfOY2NYImynPjKQXD0z3cxxH4Ly4O2iNezLVFJ5pznY
	 MW3PFvdrsnQVjyYa7celYkoa7dWrAshRwu2CV10WAudDMiM5IuHbRglajnKudCAA2n
	 Pmbv3cSPmfcGw==
Received: from pat.atlnz.lc (Not Verified[10.32.16.33]) by svr-chch-seg1.atlnz.lc with Trustwave SEG (v8,2,6,11305)
	id <B66f1f2530001>; Tue, 24 Sep 2024 10:57:23 +1200
Received: from chrisp-dl.ws.atlnz.lc (chrisp-dl.ws.atlnz.lc [10.33.22.30])
	by pat.atlnz.lc (Postfix) with ESMTP id 068E713EE56;
	Tue, 24 Sep 2024 10:57:23 +1200 (NZST)
Received: by chrisp-dl.ws.atlnz.lc (Postfix, from userid 1030)
	id 0347E280E29; Tue, 24 Sep 2024 10:57:23 +1200 (NZST)
From: Chris Packham <chris.packham@alliedtelesis.co.nz>
To: lee@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	tsbogend@alpha.franken.de
Cc: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mips@vger.kernel.org,
	Chris Packham <chris.packham@alliedtelesis.co.nz>
Subject: [PATCH v4 3/3] dt-bindings: mfd: Add more RTL9300 variants
Date: Tue, 24 Sep 2024 10:57:19 +1200
Message-ID: <20240923225719.2999821-4-chris.packham@alliedtelesis.co.nz>
X-Mailer: git-send-email 2.46.1
In-Reply-To: <20240923225719.2999821-1-chris.packham@alliedtelesis.co.nz>
References: <20240923225719.2999821-1-chris.packham@alliedtelesis.co.nz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-SEG-SpamProfiler-Analysis: v=2.4 cv=Id0kWnqa c=1 sm=1 tr=0 ts=66f1f253 a=KLBiSEs5mFS1a/PbTCJxuA==:117 a=EaEq8P2WXUwA:10 a=NGg2wX1vYba99ZzXuQ8A:9 a=3ZKOabzyN94A:10
X-SEG-SpamProfiler-Score: 0
x-atlnz-ls: pat

Add the RTL9301, RTL9300B and RTL9303. These have the same SoC as the
RTL9302C but differ in the Ethernet switch/SERDES arrangement.

Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
---

Notes:
    Changes in v4:
    - New

 .../devicetree/bindings/mfd/realtek,rtl9302c-switch.yaml       | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/mfd/realtek,rtl9302c-switc=
h.yaml b/Documentation/devicetree/bindings/mfd/realtek,rtl9302c-switch.ya=
ml
index 2d20dd07a7e9..a3ba6d9bacaa 100644
--- a/Documentation/devicetree/bindings/mfd/realtek,rtl9302c-switch.yaml
+++ b/Documentation/devicetree/bindings/mfd/realtek,rtl9302c-switch.yaml
@@ -18,7 +18,10 @@ properties:
   compatible:
     items:
       - enum:
+          - realtek,rtl9301-switch
+          - realtek,rtl9302b-switch
           - realtek,rtl9302c-switch
+          - realtek,rtl9303-switch
       - const: syscon
       - const: simple-mfd
=20
--=20
2.46.1


