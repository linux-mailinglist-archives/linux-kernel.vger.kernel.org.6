Return-Path: <linux-kernel+bounces-563107-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E47AA6370D
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Mar 2025 19:57:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6B5A7188F444
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Mar 2025 18:57:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED7A91F3B85;
	Sun, 16 Mar 2025 18:56:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EPO8Cj7y"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90CAD1E1DE2;
	Sun, 16 Mar 2025 18:56:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742151409; cv=none; b=UbC8jIC6Pr0ZOoZuwv4qhgV2XT7XgzbcrrDHa9LmAIMBjQK2AhQzIMWmM2WYT/8qzYJY7kRnqPqBLPwuOhDrVRXQwDa+1sed7w+XcK+o77mNmYBcBRcd87WrAzEyf+G0ShqUj5rljbp10qGI/5T22rJLoCr69p2phy8de8Uxmb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742151409; c=relaxed/simple;
	bh=sKVSL3M4/KD93xYcJ6rjVSTuBGDP3/FX4AyXzkFXliI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KYQxGDz/o0xLmZNcYC4EiqSbnVlAPcrnETFZsyMPfpsTd5DdvesjSTD8Oq9eBiWDJXcZCqr0MMoFR9+S21JYwAWC0O7yIirjsJ4nco9c0wjquep6WGyZHuoMQX5jYb/hzNVbof3ke7g2g8ULAFog3l0twmgurD/mzkNFXttbLVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EPO8Cj7y; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-43d0359b1fcso8427025e9.0;
        Sun, 16 Mar 2025 11:56:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742151406; x=1742756206; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kzk2teZVxdXMwphTfuXZGFBjNByuLEoXPWf93JJtGZY=;
        b=EPO8Cj7yF0t6W5bQxshuAhCQ2TAICAb4XX4jJel8uMd/3CcAta3S6DskCQqe22lmhC
         IYuOiqlaRsQrfTwqAIFC/vpbAc0tK4/GEYLLfRzRwm7oh3lYWigUztrZzH8p/hAY+KcO
         SjPtMEN/4AY2a5H5dOKWMiH4G8HIHE99IOwqiE3BUAV5kOq8mJ0PfD1897KcHsze047y
         j93lj8s8LCNKqjohAldxGev0jJNFTyhMbEI5sL74RwgDGBo+64c9rXH2pFL/YbDrYaIn
         6UfSAV5mWchyLcXWPbj08mUjaOs60b4a3gK4Gq4FPkWwEDBvrwIqExP1VeUIs+Gf0PQf
         TAQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742151406; x=1742756206;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kzk2teZVxdXMwphTfuXZGFBjNByuLEoXPWf93JJtGZY=;
        b=w8RSIUT1ZDfD356cqgVsSczhPJGlp6aohVXX+jpomI+L3/UMkgC7NoXKWTIbVk9z/Z
         e/x3LjVMNZzGZRORlTUIS4+cDDsUXp8m1EMuqJumZmV8sXgaRWzEG26hm36D5gszlLSN
         RsYxR9GOS0nn/xxKkyBF85FKPc3qnCnW74Vn23fmklHl9yALdowjrKcq2Fb4EZXf/fXm
         C07YddF4Fnpex8ra65KBxV0hca5DEC1EYd4mOUslRXR7j6RJ9zRhA0kcSzUdN3XKLnVs
         oaGKtyCmOWwHgWnO/HUTlhtsZvYCROkSPx/XNaiOaBL7tayB4+EubQxmHUjog6Lj/ZBg
         ZtKA==
X-Forwarded-Encrypted: i=1; AJvYcCVjb8eZlbY9mfthxJ++gc07bR4mzGdYKPU/4XsmbGuP/wf0uw+QDxLn973mx8CO1Pu42We1070HviOM@vger.kernel.org, AJvYcCXPhMlpe2vUERVK5rwk5j8nYRgo8LeET1Z3JeimQIXMGBL2mwD/er8KRK/OSYlv5bAOg21s5nyPlX3kLkbK@vger.kernel.org
X-Gm-Message-State: AOJu0YyJ7QtQoUnvOkA95ITwIfNK0GBfKsjRQ4vHz5xQeUd62pikWrrf
	m3lU4zQK0CvKHTrNYPx4cd/GfgPzeYQOSswVOpLsHeat3pHT/5NO
X-Gm-Gg: ASbGncu4/xx26kVSbLWfhoRfwmpz0n7c7Fy72rvtgZah95WlaiowNXzUM39y7X1CfxQ
	BEcvr0tf2cWyHzlBj6Wrb0aqqHhts6jQ6O+F2ongxGCTWthh/lHzmsoWotJ2XF75k4IjBvvmF9J
	A0OptYFpB5u+dEp/6C3Eh142XIB3ZfgcZuW/VUKBOO6c1Qo1U51wI4dlrfN5faqakrF9hcxaU4J
	B/Tj1XKSUQ1058SniedoWh0BHHQGPjtKdhlhpukzSdmeUbZzV34JREMjRmmpZditfqikDaqEc04
	BB/bg6gJoz9rscDfqBYlXYuN1UVNOJu5t30QHGKQ9RgPpBpTZ0iZg+q0IQ==
X-Google-Smtp-Source: AGHT+IECHd83CexxVzAZ8pNQZPc8xCrp0cWv1eBYkNmKsGFINq/gOCr5P12MPmJNN96+kopi143wkg==
X-Received: by 2002:a05:600c:1f1b:b0:43b:c6a7:ac60 with SMTP id 5b1f17b1804b1-43d24e78c6bmr67452775e9.10.1742151405638;
        Sun, 16 Mar 2025 11:56:45 -0700 (PDT)
Received: from giga-mm.. ([2a02:1210:861b:6f00:82ee:73ff:feb8:99e3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d1ffb6292sm84692335e9.1.2025.03.16.11.56.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Mar 2025 11:56:45 -0700 (PDT)
From: Alexander Sverdlin <alexander.sverdlin@gmail.com>
To: sophgo@lists.linux.dev,
	soc@lists.linux.dev
Cc: Alexander Sverdlin <alexander.sverdlin@gmail.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Chen Wang <unicorn_wang@outlook.com>,
	Inochi Amaoto <inochiama@gmail.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Jisheng Zhang <jszhang@kernel.org>,
	Haylen Chu <heylenay@outlook.com>,
	Chao Wei <chao.wei@sophgo.com>,
	devicetree@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH v5 2/7] dt-bindings: soc: sophgo: Move SoCs/boards from riscv into soc, add SG2000
Date: Sun, 16 Mar 2025 19:56:32 +0100
Message-ID: <20250316185640.3750873-3-alexander.sverdlin@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250316185640.3750873-1-alexander.sverdlin@gmail.com>
References: <20250316185640.3750873-1-alexander.sverdlin@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Move sophgo.yaml from riscv into soc/sophgo so that it can be shared for
all SoCs containing ARM cores as well. This already applies to SG2002.

Add SG2000 SoC, Milk-V Duo Module 01 and Milk-V Module 01 EVB.

Reviewed-by: Chen Wang <unicorn_wang@outlook.com>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Alexander Sverdlin <alexander.sverdlin@gmail.com>
---
Changelog:
v5:
v4:
v3:
v2:
- patch introduced

 .../devicetree/bindings/{riscv => soc/sophgo}/sophgo.yaml  | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)
 rename Documentation/devicetree/bindings/{riscv => soc/sophgo}/sophgo.yaml (80%)

diff --git a/Documentation/devicetree/bindings/riscv/sophgo.yaml b/Documentation/devicetree/bindings/soc/sophgo/sophgo.yaml
similarity index 80%
rename from Documentation/devicetree/bindings/riscv/sophgo.yaml
rename to Documentation/devicetree/bindings/soc/sophgo/sophgo.yaml
index a14cb10ff3f0..5d73d0ccc547 100644
--- a/Documentation/devicetree/bindings/riscv/sophgo.yaml
+++ b/Documentation/devicetree/bindings/soc/sophgo/sophgo.yaml
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
 %YAML 1.2
 ---
-$id: http://devicetree.org/schemas/riscv/sophgo.yaml#
+$id: http://devicetree.org/schemas/soc/sophgo/sophgo.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
 title: Sophgo SoC-based boards
@@ -26,6 +26,11 @@ properties:
           - enum:
               - sophgo,huashan-pi
           - const: sophgo,cv1812h
+      - items:
+          - enum:
+              - milkv,duo-module-01-evb
+          - const: milkv,duo-module-01
+          - const: sophgo,sg2000
       - items:
           - enum:
               - sipeed,licheerv-nano-b
-- 
2.48.1


