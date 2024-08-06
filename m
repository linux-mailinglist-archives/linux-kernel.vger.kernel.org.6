Return-Path: <linux-kernel+bounces-276293-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D5029491CE
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 15:42:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 048222836B5
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 13:42:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA3471D4177;
	Tue,  6 Aug 2024 13:41:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fris.de header.i=@fris.de header.b="gcXpcJzA"
Received: from mail.fris.de (mail.fris.de [116.203.77.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD1791BD009;
	Tue,  6 Aug 2024 13:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.77.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722951717; cv=none; b=QvG9htGW8UtcIWIKOONMLe8QwzlkAWUNRPjHfEVljpfIcj0O7YiTuZz2rR7bG83OY17hXPlQeZnkIxtMrubcqJo2uUgZl62J6Mevdd6719MpHy2jJouJDuddAIaunigtTDltzxeGeGJBhz3kwtRfmkRTX5qNzVjo1eGqxUwlKvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722951717; c=relaxed/simple;
	bh=dG+ATzNVBJJx+LQfMja9kcJSBo8Yp4nr8S6S//gMM8M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=M4h3P4ImzJR2pcJRaigiCy8KRv5kv9joJqwUfEWApTwGPcX9/cnZno2t4NC8UlipTyAQp3abZOkO9qaq9m3E5Vg+M8mqF3MDxJFy5qPzd6CZwjvoWSf49H4Lo0Zr9aRQ5wpStEWRQw4zw8FwJKA/lOwGjYH9iSf3KCp023Na5Cw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fris.de; spf=fail smtp.mailfrom=fris.de; dkim=pass (2048-bit key) header.d=fris.de header.i=@fris.de header.b=gcXpcJzA; arc=none smtp.client-ip=116.203.77.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fris.de
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=fris.de
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 42E3EBFBC6;
	Tue,  6 Aug 2024 15:34:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fris.de; s=dkim;
	t=1722951285; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=wFp5tFAhv5MQ0QywadpHG7YRFsalFYFU8NQQ9AMayj0=;
	b=gcXpcJzAI++/xeJ2POQgRkkjHHJd971rCA5DnGmNHuoldVCoAwuLhhghGkrJ12k8+tI2eh
	aMGj5wgvx9IVqONVW8z5n9JGMRDjnytIXkLZfst/VSz6prENUJLdfk48kEfbvYW131ZwiG
	GxVctSBECogbLnmYsmytucDz23eCr/kx4gfATpAFQteFIG5ntnoUj/1ikHCyiA35W/9Dfb
	Fp44t0IhLk8K39Oag/eHsnM7BC4m3N8fPhvDxb6CvhnrOv7Hy2yhyJBIeN2f12UVqwQEJL
	mOjXXI32a9uqMWwUq31zn+zS22/1LyAuOg5bJRiLskSXXsOV4zbfb75EPhbdfg==
From: Frieder Schrempf <frieder@fris.de>
To: Conor Dooley <conor+dt@kernel.org>,
	devicetree@vger.kernel.org,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	linux-kernel@vger.kernel.org,
	Rob Herring <robh@kernel.org>
Cc: Frieder Schrempf <frieder.schrempf@kontron.de>,
	Chris Morgan <macromorgan@hotmail.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	Heiko Stuebner <heiko.stuebner@cherry.de>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	=?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>
Subject: [PATCH 1/4] dt-bindings: vendor-prefixes: Add Jenson Display
Date: Tue,  6 Aug 2024 15:32:59 +0200
Message-ID: <20240806133352.440922-2-frieder@fris.de>
In-Reply-To: <20240806133352.440922-1-frieder@fris.de>
References: <20240806133352.440922-1-frieder@fris.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

From: Frieder Schrempf <frieder.schrempf@kontron.de>

Add vendor prefix for manufacturer Jenson Display.

Signed-off-by: Frieder Schrempf <frieder.schrempf@kontron.de>
---
 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index a70ce43b3dc03..2b483eb5e364c 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -750,6 +750,8 @@ patternProperties:
     description: Japan Display Inc.
   "^jedec,.*":
     description: JEDEC Solid State Technology Association
+  "^jenson,.*":
+    description: Jenson Display Co. Ltd.
   "^jesurun,.*":
     description: Shenzhen Jesurun Electronics Business Dept.
   "^jethome,.*":
-- 
2.45.2


