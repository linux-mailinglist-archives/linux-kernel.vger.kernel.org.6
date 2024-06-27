Return-Path: <linux-kernel+bounces-232125-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8479B91A3D6
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 12:32:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3B498284486
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 10:32:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4ED3513DDAB;
	Thu, 27 Jun 2024 10:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uAek0YWy"
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C78079F0
	for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2024 10:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719484359; cv=none; b=vC5Kys/Yswxb9AM0gOHuLOxWKCnqjERSx4V6vFmj+4hDDAnVsUb1AxZRCV48ijZDxDsXTIjIc66Wm5AmftAaNzoDL/BWxo2wA7EwRzR5YlrLKeRu4FapU259112iz+b0T48tu84aEbhCmRcqQG3dYq0fr/NvLoeGvV0l2UiQnic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719484359; c=relaxed/simple;
	bh=ocq1F8+mwQSJgldcFPAEXtsLkh5F0fMdp5IKXEFxNPI=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=VasjdrdvBDK8V6wxF0eDRPrSO7AuEHLsUbXkB4bSYf0EviolDfJL5PhFqQ8cbzc7x4Bx1ZG+5wPtMYd0zE4uOtoUc/3rkb6HxpYI3IHeP+LmlIAa0nw9rgMvmq0AGz1PpInCFNHjSJzNnZvD/Py/vV0AJpgm7gSWYIi/Js471uQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=uAek0YWy; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-36743a79dceso282952f8f.0
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2024 03:32:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719484356; x=1720089156; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tc3OCxrbI5f3b0tGJOHFzaZIm8KYLF8iYniM50kiY4o=;
        b=uAek0YWynoj+hEYgtiUK86wf5HaQfP8NKnvi1lGHBOZBPqcCn5QefWQz0Q5AfZ0wSO
         8YDCnkpGj7krASbagWopspAIaLRKaQXkd9f/3DvaikGIILLyfQtymWaaotP3HlczLFTX
         eo4nBDMp15xHJblANAODabcIhwAdBMue1ahQRw+a6/LFFXI4LHcRBUAssoXyc8MmrG44
         3FSMficYHC8DiqAVFeUh3AdoHK2GVqsVZ+/5gffwqJ3i65bH0/0NbJM+21t7BFhKhJP9
         VXDNEXLM9xXrSN0fVE5VqkKS4+p5oa083BN81pxJmlarzHt44xcgAKBsm20kbvNwZTz8
         OOZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719484356; x=1720089156;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tc3OCxrbI5f3b0tGJOHFzaZIm8KYLF8iYniM50kiY4o=;
        b=i8ZIwEPz0FtGYR1Gi2r12ypONPYredMFqy9yzxsbbW8cJ4q28wEQGx9FCpHNu6Qgg1
         K8jJOw4EgvJVLvsBWPoLeGXHn8EAJixNkwerp9w2bhckZkQVyp0+mDDSBMq/1PtaoV3u
         4txUwElmTq/2KaFgQN3UfF3lnc8YlY5oGUQ0ZxXjHGY+VnVqtLFNtxHH+OkEpkphNe0x
         eIEPawM4PXokz2tFZskzkPmqZ+E9jLAGkXycnUufjMWf7gn9PLuSLXvhfHmnl2J6IQjk
         o9gk8EJBTOtZVjbieESxbRLko6B2WHBvwpUAfa8iNl/GVHp1OIJbEhVMOCUj9yq0LUkP
         2PpQ==
X-Forwarded-Encrypted: i=1; AJvYcCVM8Dq8of5mMYvwNhoJ1jjJypp5LNgSzxnCnRxKznxouolWy2+9jUekzmgei2pW8qtoK8UC6MPe8OIciiGTeyaF4o+lkHw/ruF0FMta
X-Gm-Message-State: AOJu0YxAFC6VCAcuvIwZIT2xGv5RD57xJCKRSmLpTz5L6o8yVVqNahTM
	Uke76616plgXiIjRwcVZE5ZCya5wJbOWFCGX060pWel/IZUCUGoOUXNz2bgYgIE=
X-Google-Smtp-Source: AGHT+IEUJg6zL1JLCvRaZYeqIRIS/dTo1xAqeSnR21HNYqFdNpYbAaRT/L9YMral9TrFx0zx5QA63g==
X-Received: by 2002:adf:fe46:0:b0:362:7b95:172c with SMTP id ffacd0b85a97d-3673cc55808mr2218753f8f.8.1719484355683;
        Thu, 27 Jun 2024 03:32:35 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.219.137])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-367435852afsm1384352f8f.53.2024.06.27.03.32.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jun 2024 03:32:35 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v4 0/7] dt-bindings: mfd: syscon: Document more compatibles
 and require simpe-mfd description
Date: Thu, 27 Jun 2024 12:32:16 +0200
Message-Id: <20240627-dt-bindings-mfd-syscon-split-v4-0-dc6699a9f3e4@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIALA/fWYC/4XNSwrCMBSF4a2UjL2SR9MaR+5DHCQmrRdqUpJSL
 KV7NxVERdDhfwbfmUlyEV0i+2Im0Y2YMPgc5aYg54v2rQO0uQmnvKSS1WAHMOgt+jbBtbGQpnQ
 OHlLf4QCidlwoVUkuLMlEH12Dtwd/POW+YBpCnB5vI1vXJ6x+wyMDClo32c4PTOhDh17HsA2xJ
 as88pdWseqPxrMma2bkTlJWl9+aeNP4P01kTZRUKSqMUcp8aMuy3AFZA7rnZQEAAA==
To: Orson Zhai <orsonzhai@gmail.com>, 
 Baolin Wang <baolin.wang@linux.alibaba.com>, 
 Chunyan Zhang <zhang.lyra@gmail.com>, Jacky Huang <ychuang3@nuvoton.com>, 
 Shan-Chun Hung <schung@nuvoton.com>, 
 Khuong Dinh <khuong@os.amperecomputing.com>, Lee Jones <lee@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Chuanhua Lei <lchuanhua@maxlinear.com>, 
 Rahul Tanwar <rtanwar@maxlinear.com>, 
 Lars Povlsen <lars.povlsen@microchip.com>, 
 Steen Hegelund <Steen.Hegelund@microchip.com>, 
 Daniel Machon <daniel.machon@microchip.com>, UNGLinuxDriver@microchip.com, 
 Nishanth Menon <nm@ti.com>, Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
 Conor Dooley <conor.dooley@microchip.com>, 
 Rahul Tanwar <rahul.tanwar@linux.intel.com>, 
 Amireddy Mallikarjuna reddy <mallikarjunax.reddy@intel.com>, 
 "Zhu, Yi Xin" <Yixin.zhu@intel.com>, Maxime Ripard <mripard@kernel.org>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3937;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=ocq1F8+mwQSJgldcFPAEXtsLkh5F0fMdp5IKXEFxNPI=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBmfT+3jsUV94j6aEl8yja5D8RbpsihEg4Epk3mN
 o28m5XTCEaJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZn0/twAKCRDBN2bmhouD
 1ywYD/oDS1OoY0D/nh6c2L4x0KHLdU/A6FBO4WfGKDEb/isjXWwjpIA5xQv67WEO+7IbEFENabm
 UhFLMQ0tzk/lF326adThJxQNoqoTyNFIVA4PlIOFpoxBA3ZM2ruKCHDNM79kge4SwXjbLdKBn5W
 wi5rUdibrSHu+JqHyRhM2djnCBiIZi175nJW6WMXZ3Q/itVYuiJ39903Iticd5mSG7+Uu0jx4Xe
 FzmB8xyZ2ob37N12uVElR27MlzoMKQt13Ih7BKqAhaW61pN6ZQYG92m05q4GHO1v3X00Rvv7Occ
 /BhrSrKgDVTY2GNPlvGoY4O7rcwqnZSB18KKlNJOzXdHYKgcqFMyOMlWBNmokk/qUiX/81yVizQ
 rid9FtlaUwaJyHLVzE1RhncqwvFZISeBb/e1tb2ydIlwIG1gDBIkLBaYN1zfcp3+w7u2LF5XEtO
 DPQ1ouNT7ToQl5kQNijebjXlBMhOtq39++6cIY2FDmG8k7OEm7hmivYpUIP1iawFoLzcxiRLKWv
 LOJs1w3uLM5jR1mzy+vI8bUv0bwxgiPau4YSM54mwmWet1xMJNHD7+6nXAAQAkwBmaxuEtVKAHE
 k3LxaajgoE7qX+VelkacisKjf2DjaUBqQ/D/om64qPUuu2UZFpa6AJ8mRZp2ZMp8/MZ3uPPnOaC
 QHvnDiLNSkwYVtw==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Hi,

Dependency
==========
Rebased on Lee's MFD tree, because dependency is there already:
https://lore.kernel.org/all/171828959006.2643902.8308227314531523435.b4-ty@kernel.org/

Merging
=======
Preferrably everything via MFD tree (file/context dependencies).

Changes in v4
=============
- Rebase - syscon.yaml got new compatible ti,am62-opp-efuse-table
- Link to v3: https://lore.kernel.org/r/20240626-dt-bindings-mfd-syscon-split-v3-0-3409903bb99b@linaro.org

Changes in v3
=============
- Add tags
- intel,lgm-syscon: change maintainers (email bounce)
- syscon/Split: drop unneeded |, use const instead of enum in select:
- Link to v2: https://lore.kernel.org/r/20240616-dt-bindings-mfd-syscon-split-v2-0-571b5850174a@linaro.org

Changes in v2
=============
- Add acks
- lgm-syscon: add ranges to binding and example
- syscon.yaml: add big select with all compatibles for older dtschema
- Link to v1: https://lore.kernel.org/r/20240519-dt-bindings-mfd-syscon-split-v1-0-aaf996e2313a@linaro.org

Description/problem
===================
Simple syscon nodes can be documented in common syscon.yaml, however
devices with simple-mfd compatible, thus some children, should have
their own schema listing these children.  Such listing makes the binding
specific, allows better validation (so the incorrect child would not
appear in the simple-mfd node) and actually enforces repeated rule for
simple-mfd devices:

  "simple-mfd" is only for simple devices, where the children do not
  depend on the parent.

Currently the syscon+simple-mfd binding is quite broad and allows
any child or property, thus above rule cannot be enforced.

Solution
========
1. Split the syscon.yaml binding into common syscon properties, used
   potentially by many bindings, and only simple syscon devices (NO
   simple-mfd!).
2. Move some known simple-mfd bindings from syscon.yaml to dedicated
   files.

This patchset might introduce new dtbs_check warnings for devices having
simple-mfd and being part of syscon.yaml previously. I fixed some of
them, but probably not all.

Best regards,
Krzysztof

To: Lee Jones <lee@kernel.org>
To: Rob Herring <robh@kernel.org>
To: Krzysztof Kozlowski <krzk+dt@kernel.org>
To: Conor Dooley <conor+dt@kernel.org>
To: Lars Povlsen <lars.povlsen@microchip.com>
To: Steen Hegelund <Steen.Hegelund@microchip.com>
To: Daniel Machon <daniel.machon@microchip.com>
To: UNGLinuxDriver@microchip.com
To: Nishanth Menon <nm@ti.com>
To: Matthias Brugger <matthias.bgg@gmail.com>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: devicetree@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-mediatek@lists.infradead.org

---
Krzysztof Kozlowski (7):
      dt-bindings: mfd: syscon: Drop hwlocks
      dt-bindings: soc: sprd: sc9863a-glbregs: Document SC9863A syscon
      dt-bindings: soc: intel: lgm-syscon: Move to dedicated schema
      dt-bindings: soc: microchip: sparx5-cpu-syscon: Move to dedicated schema
      dt-bindings: soc: ti: am654-serdes-ctrl: Move to dedicated schema
      dt-bindings: mfd: syscon: Split and enforce documenting MFD children
      dt-bindings: mfd: syscon: Add APM poweroff mailbox

 .../devicetree/bindings/mfd/syscon-common.yaml     |  71 +++++
 Documentation/devicetree/bindings/mfd/syscon.yaml  | 309 ++++++++++++---------
 .../bindings/soc/intel/intel,lgm-syscon.yaml       |  57 ++++
 .../soc/microchip/microchip,sparx5-cpu-syscon.yaml |  49 ++++
 .../bindings/soc/sprd/sprd,sc9863a-glbregs.yaml    |  55 ++++
 .../bindings/soc/ti/ti,am654-serdes-ctrl.yaml      |  42 +++
 6 files changed, 459 insertions(+), 124 deletions(-)
---
base-commit: c41503b65ef7b85189c39f6a6038feb7c93eac2f
change-id: 20240517-dt-bindings-mfd-syscon-split-37e23996523d

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


