Return-Path: <linux-kernel+bounces-203780-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E71E28FE06E
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 10:01:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4BDAAB24BC0
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 08:01:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D52513C684;
	Thu,  6 Jun 2024 08:01:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=norik.com header.i=@norik.com header.b="KbXP3xbe"
Received: from cpanel.siel.si (cpanel.siel.si [46.19.9.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0F0513BAFB;
	Thu,  6 Jun 2024 08:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.19.9.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717660869; cv=none; b=g97hGLOCvse3B6Yaa7wMay08rt/mXrpkwGoXK33VbDUto0zuJIG9nMnzQ72SaIEVuVVm8hwW+PuZ72LQn0QDUBOrRrMTScx4sp3Bt3t1kGONgLd4w+62HdYRXnmVrZ9MQogRaeFUOxunzvpApRPAWb2onMkH3OBnkxbmsi2jshw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717660869; c=relaxed/simple;
	bh=itJ7A09E14i+ZxJkErJepvrcPuK+R4pR2HLajDAgQew=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=sTVJ1Ru+oRk609RBs6cSXD82Pw14UpIG3QSnrqM0g7Td2Wc7xR0Bnol4ed4d/r/IkMCmXfXoQ7m+lRbPnWbibbz9RpVJRhcw4NzBqc/NikgKitd6UmwJ5RpXb8tlmk/7voBywFvwgvHzpLRiZ6EY2Defsuh3wG7UlbmqnxTDwaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=norik.com; spf=pass smtp.mailfrom=norik.com; dkim=pass (2048-bit key) header.d=norik.com header.i=@norik.com header.b=KbXP3xbe; arc=none smtp.client-ip=46.19.9.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=norik.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=norik.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=norik.com;
	s=default; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:
	Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=7s68vawvM88MOkUXWMwzFJ3k8tEB3l1beOIvsHYWJZ8=; b=KbXP3xbe6ra38k9I5QUoTbaYWy
	CIvr/HcJvbyDM4O+SXH19IrbxSStcoFiRHvdwCHCgMSCxr2q5hdWVcnqYNidTIRV9894RNRF4jNHk
	2gZTWVWDtzJJN1vWTz+ylrwWUxXc3dh9LWIag89j6GPjwDXV/GTOkF5BRhrUApZ2TXM0g7CVpiQpe
	uNu8q+mLNzPKoBpNt7NJ68IvAzvF+mMt667Srdw4J9ITPAa9K0khq5NrTsyu2LRhR/irvOdlJgURB
	sAa2cSOLdADuj9MhEdPKIpXkC1eLhzRcJgzXPYRkglCbAY2tf02ce7LMk9jHn8rKWB8mKacW3T6LL
	fYuKS9CA==;
Received: from [89.212.21.243] (port=51044 helo=localhost.localdomain)
	by cpanel.siel.si with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96.2)
	(envelope-from <primoz.fiser@norik.com>)
	id 1sF83W-00BWkF-2t;
	Thu, 06 Jun 2024 10:01:06 +0200
From: Primoz Fiser <primoz.fiser@norik.com>
To: Jessica Zhang <quic_jesszhan@quicinc.com>,
	Sam Ravnborg <sam@ravnborg.org>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko.stuebner@cherry.de>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Chris Morgan <macromorgan@hotmail.com>,
	Sebastian Reichel <sre@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	dri-devel@lists.freedesktop.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: upstream@lists.phytec.de
Subject: [PATCH v2 1/3] dt-bindings: vendor-prefixes: Add PrimeView
Date: Thu,  6 Jun 2024 10:01:02 +0200
Message-Id: <20240606080104.3663355-1-primoz.fiser@norik.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - cpanel.siel.si
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - norik.com
X-Get-Message-Sender-Via: cpanel.siel.si: authenticated_id: primoz.fiser@norik.com
X-Authenticated-Sender: cpanel.siel.si: primoz.fiser@norik.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 

The Prime View International (PVI) is a LCD panel manufacturer.

Signed-off-by: Primoz Fiser <primoz.fiser@norik.com>
---
Changes in v2:
- fix subject line
- sort alphabetically

 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index fbf47f0bacf1..69cedce51628 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -1160,6 +1160,8 @@ patternProperties:
     description: PowerVR (deprecated, use img)
   "^powkiddy,.*":
     description: Powkiddy
+  "^primeview,.*":
+    description: Prime View International (PVI)
   "^primux,.*":
     description: Primux Trading, S.L.
   "^probox2,.*":
-- 
2.25.1


