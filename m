Return-Path: <linux-kernel+bounces-230472-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 21551917D4D
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 12:09:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A0E5F1F21B91
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 10:09:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21F45176AA9;
	Wed, 26 Jun 2024 10:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TzGQz/rE"
Received: from mail-io1-f44.google.com (mail-io1-f44.google.com [209.85.166.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B73E1175AA
	for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 10:09:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719396576; cv=none; b=lTyqOPZ/zu57LzlVmuikNh3p5fMNU+AFZwMf6EDQh1gzcuPMZ5Ofunjftl4sZRiADQzqAO4/yNXX8w8lA0lNLxL5XM63CpFSuHmk86jKtV3vbw6BRr7uog2V0A7DfCqAguda3eLvi8T4IUZmm1J5gFRg3GXGwjf0RiNWNTz4I9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719396576; c=relaxed/simple;
	bh=/+SdbAB8tNyIXJJMDFjZw6Vl+/DTTF3+zBwTN7W75TM=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=fiAgMyVOdOp4GqtAFNC3fP8QIxfoo9rcyt5UQ2pSiglU08sRGIVX/wCEzKv4o/xCWjmz7A/LAv+Qi8cS4GzIpqZR29dLPP5YQ4atpnGF7YoVWpc4GzryA9XtVd+A0UCi7JyNRqiUrmncmdr3fYQNlFlJ+mntMvrALGmzkiOTNvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=TzGQz/rE; arc=none smtp.client-ip=209.85.166.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-io1-f44.google.com with SMTP id ca18e2360f4ac-7f3d3f1294dso11088739f.2
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 03:09:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719396573; x=1720001373; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9Gly2EJcNPyMI+Zs26/l+uL8LDm6luZq6AxL3zJnFgo=;
        b=TzGQz/rEb7pwGh3TSQcjx13yWio9klnRhOz18RuH0uSfQNctnLF4jLgrU4Q0TOZyMC
         CYDhPaGhFOVDHkE7vd4s7sO1jlBAnd4PMrA/+K6ksHlOvND125n36riQgWZFhvOjRPg1
         wGZNqTpR33MAtIi7Ia/OchXCKpse5Oi9ULfuVDTCTxZ+3lBV3/Sj8+2ys47Ya1ZBa0v3
         c31LtLSuEgFdjaxOWwBLgM0u4KhvzhSzxPS3GIkBznxIA5/dJcmZLXSrEFBBZx7ZX4Kh
         yNs6A2dKpcoYrNNhRlUllMJrreBAv2Mbhd6QLyOKjJOGdMkusgk6EG+IlNyGH/2+H+z9
         y+pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719396573; x=1720001373;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9Gly2EJcNPyMI+Zs26/l+uL8LDm6luZq6AxL3zJnFgo=;
        b=J506kNHhwIiUtmTZfv4tjbi1zKGNKWWNXbybP1J+wPCEOhETmyWpXf0A5c8gKZz/aG
         I/FCwFGVOuP89iWJJV8ZtReJ0QJtivkXFVjPmXaAsIq0pAauHPTJkwCWUYVgdwNAidgN
         fPbzpvSSx/gor1BrHWEx+N+zyG/cLJsJNwjahiV2W2I4my2AWnsAi2+2kj8Sb9W+5mBx
         /INqKK8443rfgLtV6lwHsK/65lDE/PtsZ0IGkjinpukUnXxSP+2KQj3+IETeZKfzZJVt
         iVFlZ/UDRQ78aJK1EW/fFRBiPW9bIQ2dzYyOnLxDGh3G7+IRBFLHtlMqbYUEggE9odGZ
         CVbQ==
X-Forwarded-Encrypted: i=1; AJvYcCUKueVvP2YV2TfHVgclUJ6DXlUxedFhiPYRFJRj/mb/xNbuaLYC7qJTKHqGa1s7s538moUJM3SacPD49nTXlUd959aSuE8awYn2A4cJ
X-Gm-Message-State: AOJu0Yws1LepBaaA5bKI8Pm3MZtEs5x0s+auooPosTLDiob0s5JdHfLf
	kPebFQk2H9Lq06yjcnCseFd1Spv7VKrD7abZ+hwcI1YHKvaVtBoPdqggjOkJ7ck=
X-Google-Smtp-Source: AGHT+IFY5MjA30Nyok2zslby/rOF5Fn6zOokJk2qbpya4vJQlT82lPIryncWawRYzwNxqwvaD7SSIw==
X-Received: by 2002:a05:6602:6b86:b0:7e1:e022:9e46 with SMTP id ca18e2360f4ac-7f3a75faec7mr1165335739f.21.1719396572843;
        Wed, 26 Jun 2024 03:09:32 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.219.137])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4b9d121859csm3079108173.137.2024.06.26.03.09.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jun 2024 03:09:32 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v3 0/7] dt-bindings: mfd: syscon: Document more compatibles
 and require simpe-mfd description
Date: Wed, 26 Jun 2024 12:09:09 +0200
Message-Id: <20240626-dt-bindings-mfd-syscon-split-v3-0-3409903bb99b@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAMXoe2YC/4XNSw6CMBSF4a2Yjr2mD0rFkfswDgotcBNsSUsaC
 WHvFhJjnOjwP4PvLCTagDaSy2EhwSaM6F0OcTyQpteus4AmN+GUF1QyBWaCGp1B10V4tAbiHBv
 vII4DTiCU5aKqSsmFIZkYg23xufO3e+4e4+TDvL8ltq1vuPoNJwYUtG6znR+Y0NcBnQ7+5ENHN
 jnxj1ay8o/GsyYVq+VZUqaKb21d1xdXI0/XFwEAAA==
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3730;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=/+SdbAB8tNyIXJJMDFjZw6Vl+/DTTF3+zBwTN7W75TM=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBme+jKR9bIVyuhO37T4BNBrIQsJHrqRHZKjWwzG
 GgxpFshv4qJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZnvoygAKCRDBN2bmhouD
 1xSJD/9t9refEMFFgJOHkfZlT0WLV2gc0cFrk5vgxGWc+pwHCkl/YxVaTDvtfs1s7Xiljgqml1j
 C9biNJW9bluKEDJt8YUrcKgUB2Y6tpUDDeT/a1RQreIHeSTI0VY54GtxsMt8SSCo0GPB4foPgIf
 pG00jWL3lY6ZE+e0fQPEmrNI2G6/vkSIwFGmIHLNGWAMkyfu764gqCdW2JwJYDyGOfgJsYImw/h
 Nz53aWq0whLq/Veou50dM7JIhnu1Hg7NFy9hMxJxvDrSQ2kKxgcjwmyTcBwDpO3eefr6hvmbwrk
 rxb9VNMBXv+EDYeSOiJrhP8kwqI3MqWKEFSlnKfdUEA7HBvCeB7sD7VtTi+noXA6wbk2pEnNk4x
 V+0LXtp3en2qemFU3174cs7071ItbLfr87yrWYssC9SLpSIi7x0wOVg0qFpZhCB+R81NtkLPobb
 q+5IBsxrU4g3GDDyRFKjuzHYTJxvD2jgCJrEYL9DeNS08aEksyIoi6rIR/1DgOrTWF6frMddmpZ
 kNt/4Gr7BPxGBRkRdAsvj9OCgkSw9dvQUtlPM/P5WoLtRSPX8SY677XKfC6lsg4IXM051divZTo
 aCqpAIdIIJTmbpYko0NFHUZgR68E77UwUaFJLl5bjhnZ94BCFJ8oTYrCSsLCUUkgCIty5l3V8O/
 F79UEfZArgJzRiA==
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
 Documentation/devicetree/bindings/mfd/syscon.yaml  | 306 ++++++++++++---------
 .../bindings/soc/intel/intel,lgm-syscon.yaml       |  57 ++++
 .../soc/microchip/microchip,sparx5-cpu-syscon.yaml |  49 ++++
 .../bindings/soc/sprd/sprd,sc9863a-glbregs.yaml    |  55 ++++
 .../bindings/soc/ti/ti,am654-serdes-ctrl.yaml      |  42 +++
 6 files changed, 457 insertions(+), 123 deletions(-)
---
base-commit: 8dc7c29f608649f3d9eca826e9d4fe4b8a32c472
change-id: 20240517-dt-bindings-mfd-syscon-split-37e23996523d

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


