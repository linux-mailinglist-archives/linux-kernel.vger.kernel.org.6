Return-Path: <linux-kernel+bounces-383665-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B827D9B1EDF
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Oct 2024 15:39:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7CADC281AFB
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Oct 2024 14:39:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8B96189903;
	Sun, 27 Oct 2024 14:37:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fLZqfBzB"
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EF58189F30;
	Sun, 27 Oct 2024 14:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730039841; cv=none; b=OtyFQxgJ4vWMHw5oOqlzbLjJj+34QV3q09Csza2n7BAaUgX2JuCP/Q4WqvCLE1mp/zw09tIfuyI2lwaxg+57sKXSiKiHm4WvMng+HTXlQgOmf1tHe2yZj6MgZlXppDZ7G57gJWMbA0Fc0v+5pbyFrZqtJXE2nOLzQ/MuFjQcyQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730039841; c=relaxed/simple;
	bh=6r3OTMCkg8JSnNJPL45Buou4ldCUlppeLIpHydg8N0I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MamuPwC0JUtOEo6VxmEISz1cN41Nc1ardiMRcnrxvn8uW/NPNyFh3eKHxPnyMn/AZ8MzQIkOCeC6d81keXvdB5X2Y9fQTX0b0oj9gVjiYX+ulLup7ztV9cT6DCOpsTPW30iWpH3jvEQuDaKlD41DtOzezWXwn4aHpynl/Ac1vdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fLZqfBzB; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5ca15e1f893so601852a12.3;
        Sun, 27 Oct 2024 07:37:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730039837; x=1730644637; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RcSzd2hHGzMI1nKPL5Zq2z/Pr8ApxfIMOQ8qhhepbX8=;
        b=fLZqfBzBbS7LHkWcdcef0T4pDZwKQyKHqcTvERbCksoAgZbvSrkLoj+e+sHpHGFNA8
         5r0Jeh8ttj6TiZqBTqFVpARvY/fP42nrzXubtS+a7V2UkVAs2FuiWFIDdprH6IvWfUdx
         5qLPMJeLUI5FYK1CvWzRw5kt9uakN+e+RfKXXKYsDXsGfNuhy75+99iHTjlU8Ou3iJ40
         U7W3xPtZp4IlTmdClLDyz9gV+yXm1LmCMKTSuJtWpE9kb4Dm7JEXDf5GDS8rytxtK2L6
         4HovQlrgWfTSVNjqx/p9qz/wotzV2DP4N5wRbhuKoX56NuWddxu2PAvnv75Lm02mgfTU
         i+QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730039837; x=1730644637;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RcSzd2hHGzMI1nKPL5Zq2z/Pr8ApxfIMOQ8qhhepbX8=;
        b=pz3KCJvYyz3NkNNhgzddnQjcXO2S7E6cez3e4j00hSKaARFApyyeC3wNoSx/eI6Peg
         fP2B73hO8TraaNG/mWuDMtV+cc77OuEkJ0pRZE7XgXDs1mSPLtvDvth2r7TNUt7bNKsC
         eC5cCHxUCoTjcUAA/jusUHMwxwz3hIM6zJA3TbYhSUnWJvFrB/8w3nXOMg3pv7WQEWKi
         1ChdmUsFB7dezOSj7M16Rj8yeQPAywmqxHg0SbEGGlOEHuJOAojyqMtUdXd7HWAogviM
         jmr/df8+Td3d0nwOo2jCvBtjZAtWCuQOPpNlZ3baY3QaeqK+GUB5lOPLYh+9UhkPJuwt
         8cJg==
X-Forwarded-Encrypted: i=1; AJvYcCV+4WUxUdQdaL60jDyMMPJjAtg9M7U6kHKkDNDN/zhNH5JKKCCjbJw2vpjRZE3tA4pNSK7SlOQfIYwT1Tbj@vger.kernel.org, AJvYcCXgqXoOBQiwO3fZdwD6RRvqASdSErVSA/6WsW+IYVOXkq30tw68mdhSWhY5+h7qV67ASoOKnlAveYNt@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7ypwAwzjMijTZmNixbajFstCkTwvD4UzDeWKG1bSGi1Pkta+i
	GZMikvPMzaAE5i4y+HOfRSlgvhrkDLn4YIwZpyDALWBApKJOAfTKgfxQPA==
X-Google-Smtp-Source: AGHT+IE41S74aYSnyIFvYLX7nOOTu+X3QQSzXvY1ykwlrlRKEL+R85JvJLWXSCQO4KosfLK0TMnrpw==
X-Received: by 2002:a17:907:6e8d:b0:a9a:2a56:b54 with SMTP id a640c23a62f3a-a9de5f279d1mr158991666b.5.1730039837169;
        Sun, 27 Oct 2024 07:37:17 -0700 (PDT)
Received: from 6c1d2e1f4cf4.v.cablecom.net (84-72-156-211.dclient.hispeed.ch. [84.72.156.211])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9b331b0d44sm281127966b.187.2024.10.27.07.37.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Oct 2024 07:37:16 -0700 (PDT)
From: Lothar Rubusch <l.rubusch@gmail.com>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	a.fatoum@pengutronix.de
Cc: conor+dt@kernel.org,
	dinguyen@kernel.org,
	marex@denx.de,
	s.trumtrar@pengutronix.de,
	l.rubusch@gmail.com,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCHv3 15/22] dt-bindings: altera: add Enclustra Mercury SA1
Date: Sun, 27 Oct 2024 14:36:47 +0000
Message-Id: <20241027143654.28474-16-l.rubusch@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241027143654.28474-1-l.rubusch@gmail.com>
References: <20241027143654.28474-1-l.rubusch@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Update the DT binding for the Enclustra Mercury+ SA1 SoM

Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 Documentation/devicetree/bindings/arm/altera.yaml | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/altera.yaml b/Documentation/devicetree/bindings/arm/altera.yaml
index 8c7575455..87a22d2a4 100644
--- a/Documentation/devicetree/bindings/arm/altera.yaml
+++ b/Documentation/devicetree/bindings/arm/altera.yaml
@@ -51,6 +51,16 @@ properties:
           - const: altr,socfpga-cyclone5
           - const: altr,socfpga
 
+      - description: Mercury SA1 boards
+        items:
+          - enum:
+              - enclustra,mercury-sa1-pe1
+              - enclustra,mercury-sa1-pe3
+              - enclustra,mercury-sa1-st1
+          - const: enclustra,mercury-sa1
+          - const: altr,socfpga-cyclone5
+          - const: altr,socfpga
+
       - description: Stratix 10 boards
         items:
           - enum:
-- 
2.25.1


