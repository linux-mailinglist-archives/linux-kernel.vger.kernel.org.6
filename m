Return-Path: <linux-kernel+bounces-571148-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 36EAAA6B9C5
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 12:20:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A5C7B17377E
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 11:19:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAF07224AFB;
	Fri, 21 Mar 2025 11:18:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BZY0lNKy"
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B75211F03C1;
	Fri, 21 Mar 2025 11:18:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742555915; cv=none; b=cpCcsUnHvHLbl2PSarL2bTyJOffTweohWNiFi+htjSwd8zlNbl7o2Hj56uDxB0whsZhj3A7pVZYIbKY8TXH/ef/wFxjQMik/840CPd+1lZdOrv9A1NHuBE/lOwoTWNheDlfTKK4PTM32pgIsoWfme8uiskbu0lK3lDUaoAh84Xc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742555915; c=relaxed/simple;
	bh=9Yum7gc6i/8UQqEbWnNM9zWGS93w39tPmf+p47vqATk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QImLqYWRDYirNX+AUZqgqWFSEKF14vvE3X4LvnUjWl9vPy8XAZ6uzzvUUEmaH1FqdxDPYmYwAcF4vVWo9qj1Z9VmoKgKOdAEfFG9MDti3d1RyHJfxkz3vwURP0hD1NOwYQuPbfNs/bA2DjX4YP7u7fyV0Sdo5adwhaLlGoGE2TI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BZY0lNKy; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-ac25d2b2354so315584766b.1;
        Fri, 21 Mar 2025 04:18:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742555912; x=1743160712; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wabejZpAhNXZ4/gZ6Mz5z7QPUdV1DRKOqhima9IvQnA=;
        b=BZY0lNKyXivwvSAtoPfh8Kza/lcAfKO56D672dQwiHiGOuBZREiLypKeK/n/I+CRm+
         AwR40aDEVYotXF0SSGbdloAR8wH77FKCgd6lmwVO0Q1Wkxr7viJTBybXNmvNW/tNgTtY
         9tih2czvH/0uV/qPJcNBFz0nZ8M+LoXup2FHbhmCQ+M9tL0+Nq2bC9Fd9bJPPKlkp9Px
         P/dS2J63qedSRQY/KPYxM5u4UMwtUQ76Zo/YKSBjiI23FgWfDeXWKlYLO8eah94zFWFp
         5gvNQZnQ76FwfY70sQyxfzVGTRW0VsPitNDgvtQfTgTDmvmSMN7PT7MGsdLCiuk3GD2l
         TU2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742555912; x=1743160712;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wabejZpAhNXZ4/gZ6Mz5z7QPUdV1DRKOqhima9IvQnA=;
        b=dP1rUuwOBlJaj51+kSMUKBKN04p1VKvTcmiTCr4K0el0A78EiV1nR8HwftgfH2mAgD
         8tXNpd9Qx0TgDikubQH8Xfkq+5NhOzEZOmllc2+t6jHSBKxWz8zqIfM1WqZEMDihMwD3
         /QRhNqYyjyj0TBATPY0laCFA8QdGGL4ijWuW8qVXksKNCUJvJlc83GNkLyBSVKDejfS1
         wPGCsSf2dwnIC0QhPbvaMdr3aPqYDtZTpfsTfraLT+ByN/NhdywhzTubVMDmXxQxGuys
         Z7jtWH5Y/PPzC5TYjjEnppvg+T+PnI8SgxSECv1phQTnI5045RtuEIoMPTBOgMUU7NyC
         rVTQ==
X-Forwarded-Encrypted: i=1; AJvYcCUchCn8Lm194gUXZePkT0vjVX2rc7Xbhua5bjBj4bnq/1Ix4l06Gn6+yQ9LowX09MWI+YfFp7LuLFj4@vger.kernel.org, AJvYcCVKxXpfMqaqJHGm1VgReVIxZlLW5nwbqfopxF03oHm03tLLMAAcXm5K6XZ1u10Q3B0hGkTiNoz8vKiVGRnL@vger.kernel.org
X-Gm-Message-State: AOJu0YxrLyUBiJKRPZY2u27GV0f+Xx+aQZjjcNjqFrOuq1FnwOsZnRdb
	7vfn+jcJ0yq3IP7yEvF9cquAJhQdDyPAb+wGWm2EGuqCb2ZeffOK
X-Gm-Gg: ASbGncsdkPA1LKik5fBgYxsMx6duHJ2PRHRZIUefoi6UcVAPTu+yVMptHv7Wms1VTqN
	rKBB/ZOcEx/2pBDvFuyosdL0KkREt4C9S2LfeGcyqkRmkNji34hE3Q/BhE31nBcaibaWaYLFKbB
	C30yblv11M5kq09wL+p/PY0KuAe9ofaFiPl6MSbtncAaNbDy6XiAmpIHhfaCjOIXiUsUR3GanxQ
	4k0VQw+hURXW2tVRdSr4knJVI5PtX9LU379rI5UnNdI8+iBIIfCuAudBl8EtgRHo3viuj1oj2Ym
	s2bMEh6Msc8n4PeHE9PavyzmouhOy7RjD+Ox7qXhhPhb3jTB
X-Google-Smtp-Source: AGHT+IHMumxU+/ISFAj+iAHmIZdUWCL4jaCPHJzJ+2s0QvWW8i+j2WLpKz/19GnwzdojwRlGDakcKQ==
X-Received: by 2002:a17:907:da0c:b0:ac3:ed4c:6a17 with SMTP id a640c23a62f3a-ac3f224dab8mr322426666b.24.1742555911781;
        Fri, 21 Mar 2025 04:18:31 -0700 (PDT)
Received: from wslxew242.. ([188.193.103.108])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac3efd569f3sm134228866b.171.2025.03.21.04.18.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Mar 2025 04:18:31 -0700 (PDT)
From: =?UTF-8?q?Goran=20Ra=C4=91enovi=C4=87?= <goran.radni@gmail.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>
Cc: =?UTF-8?q?Goran=20Ra=C4=91enovi=C4=87?= <gradenovic@ultratronik.de>,
	devicetree@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/4] dt-bindings: arm: stm32: Document Ultratronik's Fly board DT binding
Date: Fri, 21 Mar 2025 12:18:18 +0100
Message-ID: <20250321111821.361419-4-goran.radni@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250321111821.361419-1-goran.radni@gmail.com>
References: <20250321111821.361419-1-goran.radni@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Goran Rađenović <gradenovic@ultratronik.de>

This commit documents ultra-fly-sbc devicetree binding based on
STM32MP157 SoC.

Signed-off-by: Goran Rađenović <gradenovic@ultratronik.de>
---
 Documentation/devicetree/bindings/arm/stm32/stm32.yaml | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/stm32/stm32.yaml b/Documentation/devicetree/bindings/arm/stm32/stm32.yaml
index b6c56d4ce6b9..c1cb54ffb210 100644
--- a/Documentation/devicetree/bindings/arm/stm32/stm32.yaml
+++ b/Documentation/devicetree/bindings/arm/stm32/stm32.yaml
@@ -175,6 +175,11 @@ properties:
           - const: phytec,phycore-stm32mp157c-som
           - const: st,stm32mp157
 
+      - description: Ultratronik STM32MP1 SBC based Boards
+        items:
+          - const: ultratronik,stm32mp157c-ultra-fly-sbc
+          - const: st,stm32mp157
+
       - description: ST STM32MP257 based Boards
         items:
           - enum:
-- 
2.43.0


