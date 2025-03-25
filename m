Return-Path: <linux-kernel+bounces-575465-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DB00A702C3
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 14:51:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F231319A0324
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 13:46:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2B752571CD;
	Tue, 25 Mar 2025 13:44:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cjdns.fr header.i=@cjdns.fr header.b="n9TDCIFs"
Received: from mail.cjdns.fr (mail.cjdns.fr [5.135.140.105])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB48225A2A5;
	Tue, 25 Mar 2025 13:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.135.140.105
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742910271; cv=none; b=qwO9lVUxSbRFzNg9nGFnjW8/ibHsDUQmUWQZVfdGwalORQtq19e5B/QI/wE/vct/ZqW67xwhTT5uduDWa8hq9sfQbxLZ3wLv15IIJkwu8TcgStUi5UOEPLqqBPDEYcdwNjFUBOjdG3PMIVnGKyie75OO2AzoSMjzyBBtvSWqOGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742910271; c=relaxed/simple;
	bh=AOEWlC5v0jYqJv/tQW08VD/VFkLxK5bH6IPgZSGpDak=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CRoOqSeBz6YA9K+ddnQ3cpG/Ne2HRC50SNyFTcoKUK4qqHHmUpY41n2aFkP80KItHgj9SJT3OJQd88nwdxysUfdb7/YSPMEbXdviSJ1oiM2uHeaWJ1GECbxzbVBUZTpDRphIziBsSwvTsU8kefRozFOzrgH5JxzOzCWQ9h9nsIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cjdns.fr; spf=none smtp.mailfrom=cjdns.fr; dkim=pass (2048-bit key) header.d=cjdns.fr header.i=@cjdns.fr header.b=n9TDCIFs; arc=none smtp.client-ip=5.135.140.105
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cjdns.fr
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=cjdns.fr
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id A2E462CF58C;
	Tue, 25 Mar 2025 14:44:26 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cjdns.fr; s=dkim;
	t=1742910267; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=dgObVI3Cr2VB7PIuf4Elx/ac+oQoh86OCZ2uoslvyW8=;
	b=n9TDCIFsLOYVIXY1KogwRbAd2f/nL2aebL/629ZSLjijR5pQI6axxrSsmLlfVK51mxNVOF
	XrSl4ikLun3A/lUVgthq9GEcvPRbpGUJ5TFxIGtLDNwfKYB4X/ouN9HkulAbtmJiAGIOzE
	EDAaGk5rcP0UYStkudEcdhX1U7vq+KWIdt2pJcqD7tQASEgtaHJb/A8g4Vd81jsnlUqa4a
	QJ/KcrkyPVGL3EpNi0FGuYPEcSDXF/ByQEpEXNcKZudnUlcuS8UQIPeSUL4ntI/YE2w+U0
	qrb7Ru+YfBkjH0qt1QfROeFhxGo8IfU1i/52O+WgG4/XwOl6MlWUuEIUjKXs7w==
From: Caleb James DeLisle <cjd@cjdns.fr>
To: linux-mips@vger.kernel.org
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	benjamin.larsson@genexis.eu,
	Caleb James DeLisle <cjd@cjdns.fr>
Subject: [PATCH v2 08/10] dt-bindings: vendor-prefixes: Add SmartFiber
Date: Tue, 25 Mar 2025 13:43:47 +0000
Message-Id: <20250325134349.2476458-9-cjd@cjdns.fr>
In-Reply-To: <20250325134349.2476458-1-cjd@cjdns.fr>
References: <20250325134349.2476458-1-cjd@cjdns.fr>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

Add "smartfiber" vendor prefix for manufactorer of EcoNet based boards.

Signed-off-by: Caleb James DeLisle <cjd@cjdns.fr>
---
 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index 4cd050e50743..d4e69424dcd1 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -1388,6 +1388,8 @@ patternProperties:
     description: SKOV A/S
   "^skyworks,.*":
     description: Skyworks Solutions, Inc.
+  "^smartfiber,.*":
+    description: ShenZhen Smartfiber Technology Co, Ltd.
   "^smartlabs,.*":
     description: SmartLabs LLC
   "^smartrg,.*":
-- 
2.39.5


