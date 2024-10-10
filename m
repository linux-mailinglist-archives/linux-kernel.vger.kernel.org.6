Return-Path: <linux-kernel+bounces-358865-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 203D99984E0
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 13:23:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BA104282FD2
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 11:23:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07B491C2DA2;
	Thu, 10 Oct 2024 11:23:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=9elements.com header.i=@9elements.com header.b="FxvoE3wd"
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B26A41C2450
	for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 11:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728559423; cv=none; b=EY9TPoh969lUhZADfKR8gF85gf+mu+2wEFlW1QW7VjR2bU93VszBzQPWwGH4+B//mopf2GN7maBXPQUxzBOUzkMPM8Km69IJ+QeoFbKGM1t6i6lmUFDLfeU0iRrqiUwAQyVLOx4UZAigdX9deibBulWHK7h7fqHI6w11e6+epos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728559423; c=relaxed/simple;
	bh=r6b1YbYea6821kcyyk+/o9Ps7Vn8p6Hcspii7DWXgN0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Zf/4XMafq8ZZ4gfnkfoKOfsMaHjDVfs7gR9ari24M8n6WfTLZFLYRcZtEzM/5jDCjyuUhxdYqpgxR/ZHW4fILD2ta0ZzmwMP8xf59fuzPNSW7iPslPWbe9peHJ3z8Hee/rLiCx/UJUbPB1V0cRMIPa1JnaGTyMpvryrAXo7OOXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=9elements.com; spf=pass smtp.mailfrom=9elements.com; dkim=pass (2048-bit key) header.d=9elements.com header.i=@9elements.com header.b=FxvoE3wd; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=9elements.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=9elements.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-37cd8a5aac9so384883f8f.2
        for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 04:23:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google; t=1728559420; x=1729164220; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8qfJuw9pHQcCV2tXijS5mDrRlpcbQjwcuPA1DQvQPNA=;
        b=FxvoE3wd9vh09e+Wq6vWh8kqLaLA+ZDn9pTUdBy5sPvQc/8gZH7q49w4SFx89v+mA1
         QsTJdn37/8EHkD2wqqcnYEoVWYojYrnQNfpGIvO2eHwsavfwpSQ+J/Y+KIt8e/hXSeJH
         RYSrOLVSddsDUTSd7KRoOF+CDH6neZL0ATEBwhqj0+INAuvAZUL6jxRuPiQ7WiKHlDlH
         gH1cPTYnXWJ3TUVKygMLub+NQTXub1yOPZ0ix86AqsNb5M2dfi7MivwPb68N2Ij8rjew
         vKEzd3VWLLXBGpN1Uk7CpsSMIOHfer0BdVezIocye3oPKwzKJLa4SJA9tazGAInF7o1r
         wI5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728559420; x=1729164220;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8qfJuw9pHQcCV2tXijS5mDrRlpcbQjwcuPA1DQvQPNA=;
        b=gGmWWa8Gp2URcBDZSbpOoc13V5G0BR/2j140H+1FbyrxS4dLjMnJPDxg+lLq+C86kw
         HzNFshhvIUwPXJiza7QBVnQLUFQ0ieN35r1TDbpDVmV7Q6Ciq1Rmx9O5JrfKBNZvjljo
         SiUClIejb5Z7E/Xd9q06sFjeEdNgqnuK4HiVJTzi6ruSH97Y+hh38shRm7CbIdEO1t+r
         t+zigHZEcuk3zXV1DsmUzZM0WuDR0L+rDXQI9d6c/GnFZTN5Dpf0ksJwJPc5sjQMtX97
         cbv9EquLnfrwAB/Q3jwv3mQrOFJwgkmacS3j0znpXWUO4cAlKWxoEjwQD5N2ZC8waHy+
         Ba6w==
X-Forwarded-Encrypted: i=1; AJvYcCUCeDD+vN/4losGvUVwguuIQDRSyvd1OA4+gyK7VCP0s/6khSPHouUL03StonyuSW4mkj3tc3D6FCP6aUw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwnqKvf9Wesy1qUn9BhNdvnScfeaS0AuSUDk0ibRCCbq3FUZ9Uh
	vcjME/6V/W7DxH/Jt95pkdwiZwKrfz9IhfDLi+jU8dw06tOZ63yq+8Ip4nTpUGA=
X-Google-Smtp-Source: AGHT+IH0Vw9DArkGqysshRsRh+1TVUr/gLVYh5xxCOXj9zpK/lUtCdEkscRNDv0C5ZugXkPc3DUS9Q==
X-Received: by 2002:adf:e904:0:b0:37d:5141:ee91 with SMTP id ffacd0b85a97d-37d5141f219mr307476f8f.18.1728559419903;
        Thu, 10 Oct 2024 04:23:39 -0700 (PDT)
Received: from stroh80.lab.9e.network (ip-078-094-000-050.um19.pools.vodafone-ip.de. [78.94.0.50])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d4b6a8ab6sm1272727f8f.10.2024.10.10.04.23.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2024 04:23:39 -0700 (PDT)
From: Naresh Solanki <naresh.solanki@9elements.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Cc: Naresh Solanki <naresh.solanki@9elements.com>,
	Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH v5 1/2] dt-bindings: arm: aspeed: add IBM SBP1 board
Date: Thu, 10 Oct 2024 16:53:31 +0530
Message-ID: <20241010112337.3840703-1-naresh.solanki@9elements.com>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Document the new compatibles used on IBM SBP1.

Signed-off-by: Naresh Solanki <naresh.solanki@9elements.com>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
---
Changes in V4:
- Retain Acked-by from v2.
- Fix alphabetic order
---
 Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml b/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
index 2f92b8ab08fa..c79c74ab3d78 100644
--- a/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
+++ b/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
@@ -91,6 +91,7 @@ properties:
               - ibm,everest-bmc
               - ibm,fuji-bmc
               - ibm,rainier-bmc
+              - ibm,sbp1-bmc
               - ibm,system1-bmc
               - ibm,tacoma-bmc
               - inventec,starscream-bmc
-- 
2.42.0


