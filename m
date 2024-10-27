Return-Path: <linux-kernel+bounces-383667-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 481999B1EE3
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Oct 2024 15:40:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 798DC1C214C7
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Oct 2024 14:40:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D84F718CC15;
	Sun, 27 Oct 2024 14:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ickUewi0"
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35E1418BC3B;
	Sun, 27 Oct 2024 14:37:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730039843; cv=none; b=C+YfLfuHeq+Z8TGsRCTsZS3RpdAND/8viKMAAiIT//gLZGgs7LkAA/bNZYh0gQdT13ZYFmxnhQsbca345aOaJXt8396yqEfU6pYVH5Tdz1fBYDRazSIjCaCDlxNZCtCKRDEiCwiLMJL/SpTcQVYdP24iv8D51QQh5QuWtVNF5Bs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730039843; c=relaxed/simple;
	bh=+WI7z4cCdgzRCz2IC29X1z8kx4r4PyB+TcV+EvRg5uU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=EtsknrrxSxkJlx26kwp9kekKTJgOn8NTDQI8wu6LCZ1QoRA1rvonKx9MhYxIMUdwP2Z/JTBAzg1ddBKvimezy7krCtiZ4nRjJRT0wKGsDLLkOfc+D/0y0V32BG7ytgocMJPq9W0PRR3A4+i1DCeWBwWj7+aNmXXlIyQtsNPn4yo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ickUewi0; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a9a68480e3eso49438266b.1;
        Sun, 27 Oct 2024 07:37:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730039839; x=1730644639; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UiZ7/G9UNkzspOjV6MuvUoqfRxBzDKu6uAviqklHEbU=;
        b=ickUewi0SQvBLZ+VpXlmqe9n8YcAkLOKFqwgFSpwnRcVuKU+eoj8wfP/h1j6wrLSjh
         9UUxQMHADvVJ/OIDISF1mdz63FjQKVC/iYukLOibBL1TV1UYW37duJiw0DFyF7plLjTn
         ECza7z2+K7EpLOXvC8brDY5ibhS336i87m04ULAaF4FSzn3c1uYulqC86G4EcSfjAqQv
         NkbC5Db6we7ZZyzjzuU74akncxuA+Zlz1qg5wBt2o9mpcYmGW05eOMQogq6eiJFGImO6
         5e9O2b/8Lu4BVSpbhaQieprIQo7DQSyWOAEqxYx1RokOWKda27rcAK35lJSq/H5LT9l2
         QlAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730039839; x=1730644639;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UiZ7/G9UNkzspOjV6MuvUoqfRxBzDKu6uAviqklHEbU=;
        b=Bybtnn7KIUX32nNKaPMN9iBMSMx0+Pdv4sFE+XJIjwBFFvqZZfAtwjpxpv2jMZa5hA
         Oehk0lUVx5BpQJpjjscJ/HPPTZ+CuBAC3c5+13pjnG8BQePg14zFMBe9cL5wA74mWlzy
         TmIShLHkI1vxtjUP00XiDChJsYxYmZUCa7klSuJiesixfGxkmzHwwsuf36O7jPgjVmin
         +O3BK3W/sLMTlIb89XVPeoLnwfv/m8h/MMP3UZMdW+/S5K57B28/1df8f0x8PeCkzGGT
         GH+OwIHMHPIdeZLeP2ZWEKZ1RH/2AVuCM+Gdjfp0yaf2qy0i81v7q6fhUW6wixqlKV8i
         JyWA==
X-Forwarded-Encrypted: i=1; AJvYcCUHcyXTfzUzj2NDpOSfQJWBiA3rnLliReJLMFnfgB3ga5cOmbIS3QwK3uiYYuD7IdjJlJBfCWCiya7F@vger.kernel.org, AJvYcCW/wGNgYVWWvgu8fA7pxsl1ffzr0sKTak5SAxIwSrhRcKcZ24dsMlac2UYCtZGI/gCMP55zXoFAi/wGTsQ0@vger.kernel.org
X-Gm-Message-State: AOJu0YwjtRLZk1xNS0nYXUtXo/ayhBsreLAy6tc/ns2OrFFWnzO6uY07
	640VahMhJfiS+qEdDSvuayyIAUTYWodbnfnPMMdRK3zYlLbkEwqC
X-Google-Smtp-Source: AGHT+IHgaZj45gpAMc6On9X0FaiyPY8vTkZWxOxBkPZxFGxygdYQm7kbkLilioZ3VOHoH57cEOIHvw==
X-Received: by 2002:a17:906:c150:b0:a99:f76b:3d3 with SMTP id a640c23a62f3a-a9de61f51c9mr170555066b.12.1730039839389;
        Sun, 27 Oct 2024 07:37:19 -0700 (PDT)
Received: from 6c1d2e1f4cf4.v.cablecom.net (84-72-156-211.dclient.hispeed.ch. [84.72.156.211])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9b331b0d44sm281127966b.187.2024.10.27.07.37.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Oct 2024 07:37:19 -0700 (PDT)
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
Subject: [PATCHv3 17/22] dt-bindings: altera: add binding for Mercury+ SA2
Date: Sun, 27 Oct 2024 14:36:49 +0000
Message-Id: <20241027143654.28474-18-l.rubusch@gmail.com>
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

Update the device-tree binding for the Enclustra Mercury+ SA2 SoM.

Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 Documentation/devicetree/bindings/arm/altera.yaml | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/altera.yaml b/Documentation/devicetree/bindings/arm/altera.yaml
index 87a22d2a4..31af6859d 100644
--- a/Documentation/devicetree/bindings/arm/altera.yaml
+++ b/Documentation/devicetree/bindings/arm/altera.yaml
@@ -61,6 +61,16 @@ properties:
           - const: altr,socfpga-cyclone5
           - const: altr,socfpga
 
+      - description: Mercury+ SA2 boards
+        items:
+          - enum:
+              - enclustra,mercury-sa2-pe1
+              - enclustra,mercury-sa2-pe3
+              - enclustra,mercury-sa2-st1
+          - const: enclustra,mercury-sa2
+          - const: altr,socfpga-cyclone5
+          - const: altr,socfpga
+
       - description: Stratix 10 boards
         items:
           - enum:
-- 
2.25.1


