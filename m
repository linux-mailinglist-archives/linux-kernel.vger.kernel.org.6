Return-Path: <linux-kernel+bounces-381515-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 97FEA9B0069
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 12:46:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C94D01C2162B
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 10:46:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D592218BC0B;
	Fri, 25 Oct 2024 10:46:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="fnSJ4QuQ"
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85667481B6
	for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 10:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729853165; cv=none; b=S8aA/kLpc/gXZNOqt4JMktMYqEvzhhh5jIF6PLGorMvsJtkjlvZlQMr/Z7OdlxfwK2quYuEdynUrsOWRWV3JU/tag39211sPSDNAdWjCz4UaMrn5qTiM9M9HOAG1Np0FJuviES4TUjHzx8iKkD25fAM6gya4N0u+6Li+Fnb8Hio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729853165; c=relaxed/simple;
	bh=O14uLJFcfQnS9aEjRH8ZapsPP/mCxPsRfwWSDCmOMkY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bkU2M8sb/uD8HQhVQwBBndy2RP5FSJ10QgUGmPuauIrggPUiayTzspn4wGAbv3KqkG6CDyexwXSv4+tj2f4YPRy8fIj5M0KPdfEeUzuh+bCMYIIg3+TQimeJ+VG1PgyALsP25THfY4VM5ZwuTGm6/Poe5ubxJZ+DxECq6lkNYnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=fnSJ4QuQ; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-7ea0ff74b15so1170656a12.3
        for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 03:46:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1729853162; x=1730457962; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ceLR0IvL9qdGH71mlJjn14Kdj5vXT4ULmmpb71qNMEk=;
        b=fnSJ4QuQVaAJl+9/VCdbdqBZ7Sxwbr/O6rAx92Td6BQXVubUv++AU/0CvNd8MvlKlc
         Ph8Lp4dv09HWw3VZrsH8GAHl8tmtMCr/6Z1jA+rwROaUg3c+xCgGkt/u2lru0WQ7MNhA
         +L3MRDcmbX6KI/d98bJU7NPkzSi9/MuHXqTSQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729853162; x=1730457962;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ceLR0IvL9qdGH71mlJjn14Kdj5vXT4ULmmpb71qNMEk=;
        b=Y7xy6TxTGuzQLueX1T9gYXetPnvRDuGgGXvSrc2HNymEaCtv+Expg2EQQSKxOOYddZ
         MDzAnKigvqSCYdTSv0gWdVjC4/ki50PU9Y+H2XVClsb4SByeSZ00Ax7KbGAhjjh/0Mi/
         zix+SJgf4pwyKYYiRmFJ7Dol6LMQ1dNszJoPdwhhX2eiJOt24ufR7lsAPIAyzbjGPpRM
         nLw+kGy/ciIA+nxySiHm7UeEffMqKj5RISzrzPWenGN5Xv7ROkzNp6vk8h42zzpPNgJd
         prl/cRbNFwME3/pG0m0zFQsHzb562iZbRkI+QEyEFgf/bSuyj0CKmXkVj2rbHYG2FFz6
         YOBw==
X-Forwarded-Encrypted: i=1; AJvYcCWfULK7ZKJ+7GiAq1cEEAnYE0zaRkmen6FOZFp8jdZp7ry94ALa9UkaQxK6/cg+nh/B2EoFwxwH10dTQW4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzGXhRBobbMH3+U4jHIB1qdA4cN7ool4KhieM4fN2wKmsLPyTcU
	nXMQZMqgNi3b2XzdCRCCA6wK3quZq7FF7bFSvoCt39Bfisk53OdgtjJZYB61HA==
X-Google-Smtp-Source: AGHT+IGz6wzyyQ3d+NeaKQh7ukjIPx/hDX/N2T3R4gD20OXmJ38D2JhCFST+k71O7anmr55JG00JVA==
X-Received: by 2002:a05:6a20:2d1f:b0:1d8:d880:2069 with SMTP id adf61e73a8af0-1d9898ff764mr4972242637.3.1729853161966;
        Fri, 25 Oct 2024 03:46:01 -0700 (PDT)
Received: from fshao-p620.tpe.corp.google.com ([2401:fa00:1:10:ebe1:dd63:343d:8a4c])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72057a0d089sm829548b3a.99.2024.10.25.03.45.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Oct 2024 03:46:01 -0700 (PDT)
From: Fei Shao <fshao@chromium.org>
To: Mark Brown <broonie@kernel.org>
Cc: Fei Shao <fshao@chromium.org>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	Rob Herring <robh@kernel.org>,
	Trevor Wu <trevor.wu@mediatek.com>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	linux-sound@vger.kernel.org
Subject: [PATCH 1/4] ASoC: dt-bindings: mediatek,mt8188-mt6359: Add adsp and dai-link properties
Date: Fri, 25 Oct 2024 18:44:41 +0800
Message-ID: <20241025104548.1220076-2-fshao@chromium.org>
X-Mailer: git-send-email 2.47.0.163.g1226f6d8fa-goog
In-Reply-To: <20241025104548.1220076-1-fshao@chromium.org>
References: <20241025104548.1220076-1-fshao@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add "mediatek,adsp" property for the ADSP handle if ADSP is enabled on
the platform.
Add "mediatek,dai-link" property for the required DAI links to configure
sound card.

Both properties are commonly used in the MediaTek sound card driver.

Signed-off-by: Fei Shao <fshao@chromium.org>
---

 .../bindings/sound/mediatek,mt8188-mt6359.yaml         | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/mediatek,mt8188-mt6359.yaml b/Documentation/devicetree/bindings/sound/mediatek,mt8188-mt6359.yaml
index f94ad0715e32..701cedfa38d2 100644
--- a/Documentation/devicetree/bindings/sound/mediatek,mt8188-mt6359.yaml
+++ b/Documentation/devicetree/bindings/sound/mediatek,mt8188-mt6359.yaml
@@ -29,6 +29,16 @@ properties:
     $ref: /schemas/types.yaml#/definitions/phandle
     description: The phandle of MT8188 ASoC platform.
 
+  mediatek,adsp:
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description: The phandle of MT8188 ADSP platform.
+
+  mediatek,dai-link:
+    $ref: /schemas/types.yaml#/definitions/string-array
+    description:
+      A list of the desired dai-links in the sound card. Each entry is a
+      name defined in the machine driver.
+
 patternProperties:
   "^dai-link-[0-9]+$":
     type: object
-- 
2.47.0.163.g1226f6d8fa-goog


