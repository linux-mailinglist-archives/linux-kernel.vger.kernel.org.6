Return-Path: <linux-kernel+bounces-526098-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FEE8A3FA06
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 17:05:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ABAE4868049
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 15:57:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF50E21146F;
	Fri, 21 Feb 2025 15:54:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=denx.de header.i=@denx.de header.b="S/FhBZ2M"
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A53271DF73A;
	Fri, 21 Feb 2025 15:54:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.58.32.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740153295; cv=none; b=i3mWSbnkiKsx8G1aEWEErdGycmBM9987xfOyuB9axYGFicFcGXztLCFCliWDG7rvVkcbvXRwkeMcNBd9aS5dvqsJJd5Zz7Zv4esBv/pprS2+j420XhR34RgBeZJRhaxNe434+MK2APtC2+6E6rd/C870xriWKCAEQXH5quG3SAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740153295; c=relaxed/simple;
	bh=uRcStSsUEMXH+ES+Y2khjcPmfTU+VcIPl3LSQMVO69Q=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=FtBK7zBJv+Gs6HsG4vzX9Echv9KJQ2DHoiCVkxvyRl9ExDenDPNGl3L6iuqc1LEEF6wshSHyzbSWg2ZLOLjVHjHZlzwVDRWrPkxeA4PVwvnsV326u4IXPLXiHtyclbHw0kaZNvFZV5L5hh6c9xmSJmDNuI23cXQUF2d4ccl1ZKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=S/FhBZ2M; arc=none smtp.client-ip=89.58.32.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 10B3410380106;
	Fri, 21 Feb 2025 16:54:39 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1740153283;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=b1NI8qsDqSPbmo68Dd1ckhcO5RAS74P0CLp/AbGI4Wo=;
	b=S/FhBZ2MbS41dKaXH/xgMiS3Xn+eFpyHMdgyyl8BJZvSZw78O492cpgG3HpurPz6RKUdfI
	g7lf15nvFZV/mVuziY3nKe8aH2HSCx6JRq9LBt+yrPOPtJBWdyKn389Xs/OWMLsqDf2YB1
	0LsqhA7+DUQzd3dBQoKUOjyjenbBIG7jpmWvhr6XnwcLuV7I9k8CQ65xfNA34zUVQXYjgR
	TPe1aPj3kJkt4GV1R5cIKDw/VNlkNdPWVudapShH03lZ1fBoFAwqE6wBGcCGSWLesjeXbm
	9DOtjW4e/mdMfRVItVIW//NTrun+h4VdDXjKm2wjqb1NneNJ61kPwgmzeREE7g==
From: Lukasz Majewski <lukma@denx.de>
To: Rob Herring <robh@kernel.org>, Krzysztof@web.codeaurora.org,
	Kozlowski@web.codeaurora.org, Conor Dooley <conor+dt@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Heiko Stuebner <heiko@sntech.de>, Aradhya Bhatia <a-bhatia1@ti.com>
Cc: rafal@milecki.pl,
	devicetree@vger.kernel.org,
	Guenter Roeck <linux@roeck-us.net>,
	Noah Wang <noahwang.wang@outlook.com>,
	linux-kernel@vger.kernel.org,
	Peter Yin <peteryin.openbmc@gmail.com>,
	Naresh Solanki <naresh.solanki@9elements.com>,
	Alex Vdovydchenko <xzeol@yahoo.com>,
	Grant Peltier <grantpeltier93@gmail.com>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Lukasz Majewski <lukma@denx.de>
Subject: [PATCH 1/2] dt-bindings: vendor-prefixes: Add prefix for Liebherr-Werk Ehingen GmbH
Date: Fri, 21 Feb 2025 16:54:17 +0100
Message-Id: <20250221155418.1167670-1-lukma@denx.de>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

This entry adds vendor prefix for Liebherr-Werk Ehingen GmbH.

Signed-off-by: Lukasz Majewski <lukma@denx.de>
---
 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index 5079ca6ce1d1..20ea550ac328 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -882,6 +882,8 @@ patternProperties:
     description: Shenzhen Lunzn Technology Co., Ltd.
   "^luxul,.*":
     description: Lagrand | AV
+  "^lwe,.*":
+    description: Liebherr-Werk Ehingen GmbH
   "^lwn,.*":
     description: Liebherr-Werk Nenzing GmbH
   "^lxa,.*":
-- 
2.39.5


