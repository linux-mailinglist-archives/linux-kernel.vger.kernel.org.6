Return-Path: <linux-kernel+bounces-345789-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F7C598BB24
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 13:32:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9138F1C2357D
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 11:32:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 660171C32E1;
	Tue,  1 Oct 2024 11:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="STgCD/Ll"
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6594B1C2DA4
	for <linux-kernel@vger.kernel.org>; Tue,  1 Oct 2024 11:31:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727782285; cv=none; b=ZYTlY5WhfM2M6DXTHvBj3lfIXmot1T7yBwQYuq/hkZHnvkFud+D4Aehj8mlYnjJgKsaBFGC4AxJcn7MFwCQ2pg7737wsSgpmNKmdx1wASOfDKHj4weQq9N+nEjPkH2w17lF1DUQwn1/6nFUGOEIQY6JBZiU7UdkV0IuZ/fa9jx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727782285; c=relaxed/simple;
	bh=MCBPCSdf0r5zSImbTGJmv5u3+Yij9V9+fbe7lh4RBNc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=r9F+kjRJFCNOKkFQNomrGC5GWXRQ18uyY45uAyfzVilIraYYh3MUpf0HyspYAqdc3qZQAbBtHFZi+Onj6yYCmYdZCb1mPQ/qEOgTZnGZIob9nu/LrQIIJD/PWyJQg0cxapgJlai1sOYGMnj5sLwE23AUYJfjrbt2b6tPjETKEec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=STgCD/Ll; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-71b00a97734so4687803b3a.1
        for <linux-kernel@vger.kernel.org>; Tue, 01 Oct 2024 04:31:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1727782284; x=1728387084; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HExE/eexnESQrLRIjvabM8eZD3ePYvWvDq6AbBnCJhI=;
        b=STgCD/LlSuC/vlEvwN8oN40yo6gWLblVY8oQ9uoYBUnozmdPMyn8FCgS/NXDXEya4v
         pmjfwOJ9XitYIaFW1tn1juCOyU2b2pdDEIdJ6I5napYB2LAj+fWC0kotWlUUZKQwG9in
         PfhevUdINp0cRcgx3Dd2feeAagKDYQeMCmMDo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727782284; x=1728387084;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HExE/eexnESQrLRIjvabM8eZD3ePYvWvDq6AbBnCJhI=;
        b=bbbxTju4G5xPUiK1KFYtdJ0YHZL8qe3Oz/vni9/Qq2QGPG7r7t1KS7dlENoAzHJO3c
         Cpb1n7+z9TSwqAHk6JXuLaiHT2JafgMnpO6xamOZ7BMsj25cv3Q5V5MKc+/UZDIhLgUV
         TGefVvvUdNgwtHPwXVX1HMOielX/8UOVDIHN75IrBRAWnsoh1jwWfREN71F3iSbS9Mlt
         OVOP91EGwN717a0PmQi5vUIZPtyos8qdyquz6bwgKUmOlacFJtaAm5H62Lu9Ld637/Hb
         UngIwF3B9f+/sqcXKtTILy9CtFjLJLvmM4R668MLdAAwRMXuP81wft4rTWgi8cHxHrai
         jmzg==
X-Forwarded-Encrypted: i=1; AJvYcCUbttO9lOmaC8KlTjEqIch72EnI+TN73PWuLjRWV8XhyI93fCxq+obvneChdBTzGmErM+1lSftl1hI2av0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2ABPjasdSWYTiwlPKvMni8FxlB71nR8tuiW4dtqVefRxgr78+
	wZfBOQlb2SsQPsWpNebgSWpbK4hAaSjFgFrPCCEh0A3N+15wtPnxAMii57ON1w==
X-Google-Smtp-Source: AGHT+IEKMhrohdkvwi4Udq7vmrZm1RN5zUB0skQ6nIN1r9c0R1TPgRRbL55DWTsl/CIJ8EZMUnlJMA==
X-Received: by 2002:a05:6a00:8c2:b0:710:bd4b:8b96 with SMTP id d2e1a72fcca58-71b26079af9mr22686021b3a.28.1727782283633;
        Tue, 01 Oct 2024 04:31:23 -0700 (PDT)
Received: from fshao-p620.tpe.corp.google.com ([2401:fa00:1:10:e044:f156:126b:d5c6])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71b264b63d9sm7810646b3a.52.2024.10.01.04.31.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Oct 2024 04:31:23 -0700 (PDT)
From: Fei Shao <fshao@chromium.org>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: Fei Shao <fshao@chromium.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Conor Dooley <conor+dt@kernel.org>,
	Jianjun Wang <jianjun.wang@mediatek.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	Rob Herring <robh@kernel.org>,
	Ryder Lee <ryder.lee@mediatek.com>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	linux-pci@vger.kernel.org
Subject: [PATCH v2 2/8] dt-bindings: PCI: mediatek-gen3: Allow exact number of clocks only
Date: Tue,  1 Oct 2024 19:27:20 +0800
Message-ID: <20241001113052.3124869-3-fshao@chromium.org>
X-Mailer: git-send-email 2.46.1.824.gd892dcdcdd-goog
In-Reply-To: <20241001113052.3124869-1-fshao@chromium.org>
References: <20241001113052.3124869-1-fshao@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In MediaTek PCIe gen3 bindings, "clocks" accepts a range of 1-6 clocks
across all SoCs. But in practice, each SoC requires a particular number
of clocks as defined in "clock-names", and the length of "clocks" and
"clock-names" can be inconsistent with current bindings.

For example:
- MT8188, MT8192 and MT8195 all require 6 clocks, while the bindings
  accept 4-6 clocks.
- MT7986 requires 4 clocks, while the bindings accept 4-6 clocks.

Update minItems and maxItems properties for individual SoCs as needed to
only accept the correct number of clocks.

Fixes: c6abd0eadec6 ("dt-bindings: PCI: mediatek-gen3: Add support for Airoha EN7581")
Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>
Signed-off-by: Fei Shao <fshao@chromium.org>
---

(no changes since v1)

 .../devicetree/bindings/pci/mediatek-pcie-gen3.yaml          | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/pci/mediatek-pcie-gen3.yaml b/Documentation/devicetree/bindings/pci/mediatek-pcie-gen3.yaml
index 898c1be2d6a4..f05aab2b1add 100644
--- a/Documentation/devicetree/bindings/pci/mediatek-pcie-gen3.yaml
+++ b/Documentation/devicetree/bindings/pci/mediatek-pcie-gen3.yaml
@@ -149,7 +149,7 @@ allOf:
     then:
       properties:
         clocks:
-          minItems: 4
+          minItems: 6
 
         clock-names:
           items:
@@ -178,7 +178,7 @@ allOf:
     then:
       properties:
         clocks:
-          minItems: 4
+          minItems: 6
 
         clock-names:
           items:
@@ -207,6 +207,7 @@ allOf:
       properties:
         clocks:
           minItems: 4
+          maxItems: 4
 
         clock-names:
           items:
-- 
2.46.1.824.gd892dcdcdd-goog


