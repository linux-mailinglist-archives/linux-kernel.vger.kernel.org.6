Return-Path: <linux-kernel+bounces-560655-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D230A607C8
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 04:36:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DAA3D19C3466
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 03:36:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC94F770FE;
	Fri, 14 Mar 2025 03:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=inventec.com header.i=@inventec.com header.b="WdHMJ4Jt"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E726E2AEE1
	for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 03:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741923381; cv=none; b=Z2epBUiPXz9oLuqnEWRyq7kKRL3AhTor2NcxCfGdT3cv247M+FZwQRSf9ClM2YXwH8X11z5dQI9WHU2Dlxf9JADdf4hmtVY3gduChLjn2PIUeJSg9p4EAV7Ml9M27Qe6pYmBP3o6NeeA9LP52rXN59F7CEyaOAVnPqsnddWScNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741923381; c=relaxed/simple;
	bh=VG6guJY7C2RS+MEts0vMCLpbug3/g08c4TFm3dc652k=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=WUJsL6F+UearZV+TE+h5UYsZh9ZPyUfbbEBZBAf6BHCiRsdHvmgc8Baw0BMjwBPcp35i5uypeNkmemmxOcmaWeMByV4+G5+f0Y+g7LXQ7Ox5RmQQVNViS5isC+xB+3yu/pfC3G8O9ZOjN2MemBJqFlLVT18f0NZTOhdGE1ERVfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=inventec.com; spf=pass smtp.mailfrom=inventec.com; dkim=pass (2048-bit key) header.d=inventec.com header.i=@inventec.com header.b=WdHMJ4Jt; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=inventec.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inventec.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2239aa5da08so33562215ad.3
        for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 20:36:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=inventec.com; s=google; t=1741923378; x=1742528178; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2CKZ17Q4D67al7wDQAN94cc3LiLuJKQZdY3HIsX08mM=;
        b=WdHMJ4Jth2Q40uYNwj4cqXioVeA9/BQH2INU/GsdYcj+2KAkssHrjb6Ou8+cSwIuuZ
         DhbvwqA+ZZeY3yHYBKWxV8ZEc9zuZ4Q4jffeYRn1BuVUfY4hYzmc+GpM57bU+KZ8Ot/2
         opZ+qjC7IqHEGVBwCQaoZ6oa12nLf0CJ/3y6MWw+OYCzQpuSyoNWObkPPEV7GpfjF44l
         T+bVaQuK/vOEYMUejA5+RtQRbHQryQYXr+W3MJtIrXAMam24B738kHaoLWWnRZS8NIeb
         eRfMVBS4xe5FurgjHmc+/oP/HTb7KU86PApU3YZ+BskNaSNT++R1eiU/eF4P3XcBsad7
         Rn1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741923378; x=1742528178;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2CKZ17Q4D67al7wDQAN94cc3LiLuJKQZdY3HIsX08mM=;
        b=wjwzMxdwG2srZdJzdArBriCiB93Z20xc1wbc+3AmbgabBNS5AHlnC5oOxwyjYNESUQ
         IWjHPLwOKgzzTAHI+9jrladASqtjUHFt03/fVUrEoExWGhaKLCAY6/iezeA+kkXUIX+N
         KCC6eB4NP4YQBfA/cQ/D4yGPkZ+zy7clTOJdC65gSt1dzlbvuVEacCwFycGUgMlNGwWz
         b51DPJSaeHp9YJ9NniYXGrb4C2r7mdpE4JY2nGxaEk3hpPg5koDRLnsHT/QGh/mw3cvR
         DRON88gkprHygpAhdv0OR5DKBbNqhFBwPcvnERBjEWzytRo6cuwD85zCm2Jjps29yTLG
         KmKQ==
X-Forwarded-Encrypted: i=1; AJvYcCXV2V8NVXscMXgiZK8yPiMbA9YeShdenC388NtB/02i6mNDohgu95/EErHaEzrGtdskWd/nzfHsU4WI3pI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyXrM2LD5jYWbFB2vIj16Q43TLtM1G705PTx8vzwQqt6WBxJSlr
	EvG9tXV2ttbgmtosrTQyF7O/EQAnjtPyDd8twTkjhoO/nEPnQ7WKd0B4MSmo3ic=
X-Gm-Gg: ASbGncuZpBjfI9jp+fZEpyptbqOZylNIwV6aJzrSW3wNfnyYC1YzJz/zXP+IaQMIhZg
	qHW6Vp6Q7wbcIi8WrbJRDL2CB+Jko32bIu3o2yxTfpdAxbnD/BKIMdQq2TD699Cfqy4YtO7vbDH
	WoiN0btWxu50rSOoa6FbWsRf85jmHHwI/6wsq52sNTE7q3M3s6fCTlOm8CzWEEvujVKtOrHOyay
	aqM9S7Dq7vQnI477Kd2r4zvvLnMiSyH/BRfRF6/CczkhavgwI96MtZN+MQ2cZ2/R+lYE0avY34C
	p3yVkz9AB2yHZldm2Pu01x4dgO1crMXGMXQdr0LnfS3HEVkmSqMSYEpz6etZ2EvnDV8/QwykjO1
	6Kd/1O0fj5uN6yLUBINlVAviBlQ==
X-Google-Smtp-Source: AGHT+IF7o+fIRDqv9z47H1qL2o4yIcJDSVooZphsAXczLb9NaTSymeNDBDBJ4uhStmyxIiBcFqgjWQ==
X-Received: by 2002:a05:6a00:c92:b0:732:5276:4ac9 with SMTP id d2e1a72fcca58-73722357b4dmr1139599b3a.9.1741923378125;
        Thu, 13 Mar 2025 20:36:18 -0700 (PDT)
Received: from localhost.localdomain (60-250-242-163.hinet-ip.hinet.net. [60.250.242.163])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7371152938csm2210418b3a.12.2025.03.13.20.36.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Mar 2025 20:36:17 -0700 (PDT)
From: Chiang Brian <chiang.brian@inventec.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: Chiang Brian <chiang.brian@inventec.com>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1] dt-bindings: trivial: Document TPS53685
Date: Fri, 14 Mar 2025 11:28:01 +0800
Message-Id: <20250314032802.3187097-1-chiang.brian@inventec.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add undocumented tps53685 into compatible in dt-bindings

Signed-off-by: Chiang Brian <chiang.brian@inventec.com>
---
 Documentation/devicetree/bindings/trivial-devices.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/trivial-devices.yaml b/Documentation/devicetree/bindings/trivial-devices.yaml
index fadbd3c041c8..c98d69facb48 100644
--- a/Documentation/devicetree/bindings/trivial-devices.yaml
+++ b/Documentation/devicetree/bindings/trivial-devices.yaml
@@ -380,6 +380,8 @@ properties:
           - ti,tps53676
             # TI Dual channel DCAP+ multiphase controller TPS53679
           - ti,tps53679
+            # TI Dual channel DCAP+ multiphase controller TPS53685 with AMD-SVI3
+          - ti,tps53685
             # TI Dual channel DCAP+ multiphase controller TPS53688
           - ti,tps53688
             # TI DC-DC converters on PMBus
-- 
2.25.1


