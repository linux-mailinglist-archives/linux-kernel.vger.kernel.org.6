Return-Path: <linux-kernel+bounces-192425-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF0CE8D1D18
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 15:33:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 74FE1281FF5
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 13:33:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E08AC16F83F;
	Tue, 28 May 2024 13:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="fd3kvgt1"
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34C8E16F859
	for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 13:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716903182; cv=none; b=MPZUGPpU9SF5+NP8A4Jg6m+azrdjoZCpVfnHPFvIHtAVGUWhS+hOpimgZ52znB6yz3I1vjtQakZuKz2237/RM9NesIR2RRrWyvdlOQcyhI/K4hU5AIJKWR9n5Z2Bol0Zfz9jR/PruwDTMl5yFJp5HFZ9bfl0P9KXrUGuvLuDrII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716903182; c=relaxed/simple;
	bh=9k25ZsPTf+WrTiK8qVLkskl+r232la4YhtO+5MWY/Sk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ISEegfvrz5UFYAWCeLFXWxPTltzy+wsgoc0YewEFWVuAqp3m3xPYHh8pdYFIdB56h56HN3/7TUa3OSwUEOPoWLrDapHEJUAxvnKG/vFy6KHwZL1CC/3evFCl0idDfIGglg3phfdf2PkagZSF3JDe9B3piZTaOfz/60CbZwsR3a8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=fd3kvgt1; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2e6f51f9de4so11744091fa.3
        for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 06:32:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1716903178; x=1717507978; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sE1zrpU4sY3RHfj/RfOgVZHYb52D/eP6ho+94PIl9YU=;
        b=fd3kvgt1mB7F98/c+nrDsIQR1aPE4xbrVgnvejOCN6hP3kuSPyfhEyyrYWdUhQP+yx
         PD7SB2F00cCkS3g6GU99TVCjj4dfEKgYsYg5zarhgv5Fb14wuVvgWs1DI0LOCXibAJYJ
         ER4glnZdMNkoK9gIkxA7nQSQput9arVSB9fhWSsOZukFSA/TUStU+wcO8yL6wJbQs8Ag
         YWWrxCzsMW6sjIESkQ9Lg9c6WtSowCJclFsw4lboywn/rBe67chVm+rwiM4IhfVMwAy8
         J4EobSszR40irUj/nvGflzNpHOiDz9hlYtno+R6bwYZeKKjwtHRGaeiC612+o4lT9bEH
         pIqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716903178; x=1717507978;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sE1zrpU4sY3RHfj/RfOgVZHYb52D/eP6ho+94PIl9YU=;
        b=JzaBmrwGfOvBABV+6mVcIcG0daS28ORo4xek8peRABbAMZCRs/HfZh2QymzpR3/qaW
         UCjH+1+QPuGkbLakDeQF/NmkLCj4XywhjUX+3Mx3JB7zkNcrBCNd0EZFzPDRfG/db34I
         k1UWmg/XPg1NPZXkPuPK0jaJw6L6P9BTLjoMgryqFrpmkdgt5p2nTZwhWZMOCCvvwoHG
         HzBFn/1nP4It+u0MMyOwpDSeFK52QqyI7eXZ7bC4iWv1rEyqLp8/TIOAQqJ8C78ASbeY
         +Yb6LxPdv+SC1Dtv+TgWdjdXZ0ojl/74DBn542nmls2RkuHVw3M8JHKHOpEzV8/XevdN
         hz7g==
X-Forwarded-Encrypted: i=1; AJvYcCV/OVFls5lai8SiT1Ghm6ZnJZP9qcCxUU0tBw7UKgAazseiuXwek98SB3vDn+r8kr3+evTX8+McHGmkSIMnsRwH6YxfmMUtciQ6N0YD
X-Gm-Message-State: AOJu0Yxs2m5RXcovzxAj1xVaVXdcqbCUMkIG2zwiBxj9Do/w+r3/iBFj
	gLJALxB15tQ51/5y7JzpuyeUV/Ftif2VAlHKII2zRLaUbpY0OM7C4pKUEhr2LGc=
X-Google-Smtp-Source: AGHT+IHEXl3H52Dmzhq+38r5mv+t/FOvPtQ+YYhX+r6nXpLxsLtRN0zdfqcZDN5fXmZhSF3uHYSdMA==
X-Received: by 2002:a2e:a403:0:b0:2e9:8852:3d16 with SMTP id 38308e7fff4ca-2e9885242f1mr14453351fa.35.1716903178395;
        Tue, 28 May 2024 06:32:58 -0700 (PDT)
Received: from localhost (host-87-16-233-11.retail.telecomitalia.it. [87.16.233.11])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a626cda60bdsm615456466b.207.2024.05.28.06.32.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 May 2024 06:32:58 -0700 (PDT)
From: Andrea della Porta <andrea.porta@suse.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Ray Jui <rjui@broadcom.com>,
	Scott Branden <sbranden@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kamal Dasu <kamal.dasu@broadcom.com>,
	Al Cooper <alcooperx@gmail.com>,
	Stefan Wahren <wahrenst@gmx.net>,
	devicetree@vger.kernel.org,
	linux-rpi-kernel@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-mmc@vger.kernel.org
Cc: Andrea della Porta <andrea.porta@suse.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v4 1/4] dt-bindings: arm: bcm: Add BCM2712 SoC support
Date: Tue, 28 May 2024 15:32:38 +0200
Message-ID: <cfc4db17981ef946a71d40d522118a560aa0f15b.1716899600.git.andrea.porta@suse.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <cover.1716899600.git.andrea.porta@suse.com>
References: <cover.1716899600.git.andrea.porta@suse.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The BCM2712 SoC is found on Raspberry Pi 5. Add compatible string to
acknowledge its new chipset.

Signed-off-by: Andrea della Porta <andrea.porta@suse.com>
Reviewed-by: Stefan Wahren <wahrenst@gmx.net>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 Documentation/devicetree/bindings/arm/bcm/bcm2835.yaml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/bcm/bcm2835.yaml b/Documentation/devicetree/bindings/arm/bcm/bcm2835.yaml
index 162a39dab218..e4ff71f006b8 100644
--- a/Documentation/devicetree/bindings/arm/bcm/bcm2835.yaml
+++ b/Documentation/devicetree/bindings/arm/bcm/bcm2835.yaml
@@ -23,6 +23,12 @@ properties:
               - raspberrypi,4-model-b
           - const: brcm,bcm2711
 
+      - description: BCM2712 based Boards
+        items:
+          - enum:
+              - raspberrypi,5-model-b
+          - const: brcm,bcm2712
+
       - description: BCM2835 based Boards
         items:
           - enum:
-- 
2.35.3


