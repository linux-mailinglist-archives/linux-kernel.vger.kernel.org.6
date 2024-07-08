Return-Path: <linux-kernel+bounces-243827-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BA5E929B23
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 05:47:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B21A51F2159A
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 03:47:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C30679C8;
	Mon,  8 Jul 2024 03:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WXsozBWT"
Received: from mail-pl1-f195.google.com (mail-pl1-f195.google.com [209.85.214.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5788E812;
	Mon,  8 Jul 2024 03:47:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720410461; cv=none; b=Zryo0GVAisosKzjSV+N5Msf97OZ2K7bWkC3YjGFVVtmlupxHG2LtCnwSWCp/Ycy5IyliUzql8Adfap5yr/gPyjg52Z2sh6cZUoHjxse4o8FdwaCLrQkVpLRO22sCbsKbuJRnBPkHb0bnmFcZ1dGNikG2jZQB9i4k90dfyb4aOzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720410461; c=relaxed/simple;
	bh=EGlitiQ+7azkrlc+AyuJmqvbVuxh+O+C3MAA0ATjmxg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=f0CNPF7qV4cTW8XefZIVJeuAXxIxrZvwhPfzbQMXU0Nm9OXAkuY9h7YFojepoDpKJipnPnl2Sk7muJ4dnWhOvp79qTmM/gIvruvq1FKgX4xBMnNzRpExZ1PFk/VhqlcQ9g18YskCTp+3QgGTGZkqNvEbl/Lx5WtRBQ6IXcojzZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WXsozBWT; arc=none smtp.client-ip=209.85.214.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f195.google.com with SMTP id d9443c01a7336-1f4c7b022f8so23890975ad.1;
        Sun, 07 Jul 2024 20:47:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720410459; x=1721015259; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dD8EVl2OD2lKbICm6AWgZ5uplW/zFGU233eXdZiblYU=;
        b=WXsozBWTAwzesEA6ryQDtjVIE0dhrHgeaXUOU53pjTcGsZWBrMRS1MYGPma5A62945
         aZmdmuzK/lMv7MBqeqtCIsZYOGaFy+VMANB2eiX0gr5q7iBI9RPP8hDpO2Gu2YZpQwsV
         AbFakmUfjzYBKM39IqM+HfoHjvFK7MlmYHzaeadD2KCX4rU3RcrNazs2b287DwJauwAU
         RVpo8swo8fJVZifxZRsWMDCCpmwx6u0bWji1ywP99xA0IZcUbsV4TR+/30sKrOjUO4wH
         IB3px6zOlVsFd8awwu+GxcXgbgYW8ORpSilTe9YnC8W0mBJkNXA+3zGxnJw3MymAmlRF
         oMwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720410459; x=1721015259;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dD8EVl2OD2lKbICm6AWgZ5uplW/zFGU233eXdZiblYU=;
        b=LKdlX4a4rVduXgAUJfuGkxvkZpo2RvAbQ5ZaGnoxjrGhF4nf3MEmy2jvyE0sbpQ1rz
         u2R+WL5oE4qc39fPHhlwazCXZk/sI/YgsqU5YW0IrbV53U5vNVXp0fHO3R1Y3i6Jq8Lh
         Oc7FOZYPW+lxWb6a4HkY7tL8ZhnwUgIpdYBmsy3jcujqKaIRL4LkcPdUiawvSb+fU3LE
         vaEPacj8Xnu41pnCWiGRa9A1odVZQ3SQvj3HonYfggpYxu2rwku30gZW64vKRQNsqQs9
         G9/2eiMoyjZFB1j6W6kPKXl0RKIzX6Ru7uvdBFXhc/pQMOoq0gwOUJfMxSdrwpOGP6Kb
         JRQg==
X-Forwarded-Encrypted: i=1; AJvYcCVl2tUAyDxPRpcMNAy8NuA1gqH0fXaSg0i+NVom9wXe258D8g6iPl+tOzVxVyEu8Mimg9RLrLB5HV/akt4U9lg14DEeQYY6oIm2SNTJ
X-Gm-Message-State: AOJu0YwiWi6uTJACB/CaAGeKVvVHXRbvSQ1eTieeU3BS46lM6HEV56Vx
	ZgahKmkoPEH94HWxwoNL83ksc7V0m7EHnww1tozFc+++CkkWN83oqEw8Vlbs
X-Google-Smtp-Source: AGHT+IEfhNewiFkD9qCPnpsxedt+bsoXU61Lo/i8mRnWBWH1fjPCfpRQcvs04bkLIWdMuqKfKSGrxQ==
X-Received: by 2002:a17:903:2444:b0:1fb:798d:b333 with SMTP id d9443c01a7336-1fb798db6f0mr46232975ad.66.1720410459057;
        Sun, 07 Jul 2024 20:47:39 -0700 (PDT)
Received: from localhost (66.112.216.249.16clouds.com. [66.112.216.249])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fb48b1bb68sm50824035ad.283.2024.07.07.20.47.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Jul 2024 20:47:38 -0700 (PDT)
From: George Liu <liuxiwei1013@gmail.com>
X-Google-Original-From: George Liu <liuxiwei@ieisystem.com>
To: linux-aspeed@lists.ozlabs.org
Cc: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org
Subject: [PATCH v2] dt-bindings: vendor-prefixes: Add prefix for ieisystem
Date: Mon,  8 Jul 2024 11:47:35 +0800
Message-Id: <20240708034735.99939-1-liuxiwei@ieisystem.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Add a vendor prefix entry for ieisystem

Signed-off-by: George Liu <liuxiwei@ieisystem.com>
---
 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index 573578db9509..0ffa8d06aea9 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -609,6 +609,8 @@ patternProperties:
     description: IC Plus Corp.
   "^idt,.*":
     description: Integrated Device Technologies, Inc.
+  "^ieit,.*":
+    description: IEIT SYSTEMS Co.，Ltd.
   "^ifi,.*":
     description: Ingenieurburo Fur Ic-Technologie (I/F/I)
   "^ilitek,.*":
-- 
2.34.1


