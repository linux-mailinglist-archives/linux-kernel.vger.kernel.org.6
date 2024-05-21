Return-Path: <linux-kernel+bounces-184640-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 24D608CA9F1
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 10:30:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 54E401C20A9E
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 08:30:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C004955C33;
	Tue, 21 May 2024 08:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tMzcLzl5"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8445846435
	for <linux-kernel@vger.kernel.org>; Tue, 21 May 2024 08:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716280231; cv=none; b=ubuMD9EpKzdxYrW+YsodBkP5LS/oAC1Eqpq1/DkUE8bt6eMB3UXuMOuDO+rUWg7glwy6YZHcOUxj253ZHpTfnZ7NDB2Mu0o6Cxp2L67DWhomCbfLA9Tq81JVOm/SfNOFs2qW2nC6HGgILGR6CN1Jl8Vl1NCaTG44G4isIhfQR/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716280231; c=relaxed/simple;
	bh=13gYofko46IZMmpvH5qkx1agAyFYwqb1N2f3GxAXerM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=m8RRjI+WjdEziPV+Ql2USQGdw4NCTzKyF+IauChlWwsduwXqfYMpiooaDelbVXhTIQ6j78O3BbNRDfrlcEbgWhLIl2CiU/fCHv0k1wlx0hyTms7nd7HHNGRMXaGxCLh1MM1+om2QPpfii1OVWvwU7HoaC1QBHOpxRKLeXbK1hsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=tMzcLzl5; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-420180b5897so27852665e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 21 May 2024 01:30:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1716280228; x=1716885028; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wrA786U4KPavR4LnBySZw2GdS7HLYmlFSbgJ1uOdz/o=;
        b=tMzcLzl5cu7NYEQg5pJPzYCI4K5OZDVcL16E/F3vL88fwZywPZt/ZrzrhI1r95+IgL
         K4tFmaWw4OPhB8swgw/5moMKLe5ydhPfsrbkJccq+PS2CmwKULnRKY2Z7mouvqlPMZaP
         DrO1EfGJ8KTsNChnrK83j7uIAYnyFZ64eZyK2SsqnFFgss9MberQ+Rp3MeR1hQMsRMez
         5aEAYtQa6YEuIHpAZ3VCyHpTeWvp1L+OoqiRQ2itbOzQ1Bsgs03mMODbjgPfNvFcbP5N
         e51HaHEbL4TOa3iYQlXVoGyGqxidSB+mAykYGhOp3QthJ+3C8nIsnodItIAQPTI4cZDL
         nQ7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716280228; x=1716885028;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wrA786U4KPavR4LnBySZw2GdS7HLYmlFSbgJ1uOdz/o=;
        b=QWqc6hqkD2oCjDRO2TIa0Y8qgpKeDfCKqBMTOx4G5eefMS7n/UG1B942AjOGaW8Yi0
         tphbXB0bS4sYzufxakHhURC8r7gh9XMWQbAliFTjlTem8we5hvxR3uPeMlIfAkJ2sGkI
         NenI/WdKRYOvdIOMbFd9tCW4I27XL+0In+brUChpSYvkhqYhhiV8NmeZ2dHSbD8CUi2D
         ZNlSc20brAjC9P+eeX1jry59FvzqFxDrVs2VVE46XbOAeforXcyyYg0iD+qcOx773TJK
         7/TG8vUjKXVnayjltud7LfESBwIlszYCPJV51S/EnWRhS8Th5RAFUh23bL+iPs1vR74l
         +VBw==
X-Forwarded-Encrypted: i=1; AJvYcCUREwy1UVS4MTdaOJxhN1iuzyElMm+gkSFBA/zPqWm6Fh9fBPApnEqmdSJdtarCik4wn0eySpGVE+rxvhla2Jk5zYiPKshP/vP77VWk
X-Gm-Message-State: AOJu0Yx+xFEXjroF2kxXfMCdAnktnAp6IZ7S9V2iIIDO6mMq5Jp0W/tw
	MPavO6crwYdRrhk9MTpVQudP3SxMEqBNZSgg8YO7mgLSEoFn0J0UfKegjGjGiFM=
X-Google-Smtp-Source: AGHT+IHVWqYYv8hCOa92k+zWOJjeMXITMTd7bwD6mQcIHDreBv9G4RztpYp+KuIYeogkzXFxDXyW4Q==
X-Received: by 2002:a05:6000:12d0:b0:34d:a719:4e09 with SMTP id ffacd0b85a97d-3504a96866cmr21533641f8f.45.1716280227892;
        Tue, 21 May 2024 01:30:27 -0700 (PDT)
Received: from krzk-bin.. ([178.197.206.169])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3502b897e39sm31282433f8f.48.2024.05.21.01.30.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 May 2024 01:30:27 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Frank Li <Frank.Li@nxp.com>,
	Vinod Koul <vkoul@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Peng Fan <peng.fan@nxp.com>,
	imx@lists.linux.dev,
	dmaengine@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	stable@vger.kernel.org
Subject: [PATCH] dt-bindings: dma: fsl-edma: fix dma-channels constraints
Date: Tue, 21 May 2024 10:30:02 +0200
Message-ID: <20240521083002.23262-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

dma-channels is a number, not a list.  Apply proper constraints on the
actual number.

Fixes: 6eb439dff645 ("dt-bindings: fsl-dma: fsl-edma: add edma3 compatible string")
Cc: <stable@vger.kernel.org>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 Documentation/devicetree/bindings/dma/fsl,edma.yaml | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/dma/fsl,edma.yaml b/Documentation/devicetree/bindings/dma/fsl,edma.yaml
index 825f4715499e..9ef99eb54104 100644
--- a/Documentation/devicetree/bindings/dma/fsl,edma.yaml
+++ b/Documentation/devicetree/bindings/dma/fsl,edma.yaml
@@ -60,8 +60,8 @@ properties:
       - 3
 
   dma-channels:
-    minItems: 1
-    maxItems: 64
+    minimum: 1
+    maximum: 64
 
   clocks:
     minItems: 1
-- 
2.43.0


