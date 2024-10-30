Return-Path: <linux-kernel+bounces-389316-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A94E79B6B4D
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 18:49:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6EF2E283D58
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 17:49:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D94D1C7B68;
	Wed, 30 Oct 2024 17:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nr5PzKo7"
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D75B1BD9DD;
	Wed, 30 Oct 2024 17:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730310525; cv=none; b=Ke8ao9i20D4F0lLy1DnKANX6FAqn+Jwl+xP0cFLgD4/sslnNDX9ZUUZwQv2p5go2N5oecYDJpQnBd7W0R92RfIzxedOCxeeXTV5NAXSprZS1Enq1w3900fqEKaD3Mon63POsRx5aA48k9/otkSjdsFbwdK1ypFrcBf29s/XwqEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730310525; c=relaxed/simple;
	bh=S/CnkymRqaJT3ioMxi9DFh/1tiGv8xRkdVInnQUNGAw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=vABFi9OWf9hln/ARvNSD4RPI53hMO7Jam4n2RRaHhvmeafjbvJte/CXfTnXwJ1a8rPi4CqCmcvhmCWuZJ2HpsI3hULSE3jqNChAcAJJABhE1N/vFn2uqZiO22OTAi2xzrNnwoXNPc2TBbzQbXP27eHaKcEPp/HZntP8HvhNP/x0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Nr5PzKo7; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2fabb837ddbso603281fa.1;
        Wed, 30 Oct 2024 10:48:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730310521; x=1730915321; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3c8WANbuwNQmIFyGiM0fFg9azajzbhCZ4zzBYom44vk=;
        b=Nr5PzKo7lU/+i0ASAbL2EZHJ+HIT9AgM/lTggm5bc9OoV9DHYkO6M/e0v2NOnJh0VI
         x5ogQJjyJwUsz+iU4bd4z34Tvdnf/K8LGbUjYsGyrCO4egxBLWV+YxX/5FMltwsv3Es8
         qmlz20oOBGK+GiQFuELjgBm8ipv9SfCT5C64ezriWg2rTCstVyogeE7Rnsk1PRlkvoTy
         WXwbVyaBKs9fsznU/N+ERS4iT5wkcWVYf5a1JOiQU9Hg+NaLqSbTX4P7Twg9uOSPQv5W
         lTT0328hRjLR6LVVN8DQPxQVNjjTlZlLS6YXzstSwISR0odpnSWAMwYZDjmuwWFf+Oy4
         mKLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730310521; x=1730915321;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3c8WANbuwNQmIFyGiM0fFg9azajzbhCZ4zzBYom44vk=;
        b=LGRNhuIS8ORoRfdGl2WzdKlgwwPVWil+X5xhfYOYyAvp/XCcT39wrCkxpiolxQ262D
         pqiMVW8XQhjJRdUo921kGR+UKOPrSPqi5CRY0O1bwfzRvYSEJoTMiFbCcYCikjs/aw36
         D5kKmEuDOtR4EF9Q1dDEsE761cjstX/bfKz4yZ9WhJMkqj1B0Hl5GQSvytoXnpflo34z
         Sth4xwiREi80YWoTqmTI7vfJqm8epdPC+K3fi1Kl1N46nU7Oc00f/RqK4tgYzR5L6y+W
         JTVQ8nDANpQ2Ph7/pUG6KsmVYGVEIFP/alG7SUWPJYCuwWrpcuPHtotdJ0zPFEyb3bCq
         vB5w==
X-Forwarded-Encrypted: i=1; AJvYcCUW6x69MBc4Tdh2b4EiJhiPEe4n6SbxBYWo7ZR3jcjt1fwBBA32PvG/+rZ/2ywFLcQmimebE/Ez4ZEG@vger.kernel.org, AJvYcCXaE0JU93PrAye1nS9NsYIRhQyKhRAs9q89gguUDvelNewx/5sCTF2srNLeAVztv2CzrScjzHSABssDCNOt@vger.kernel.org
X-Gm-Message-State: AOJu0YzksAx+QB5wOCnYMTx9s7CLoZmdWgsm7JbEESbpAqJLwXHSKGfK
	levWc75RIqeSoRCSxvCyCTv9njjvMnKRyqYZNjDSfOHs9hKqVGbzx8JUUA==
X-Google-Smtp-Source: AGHT+IF936HZvLKS36ZaGc+lnPVpTe4gcKZT85VFBeyPb+8M3ZNRhuEEpARe78myz2xA5w8VsI1TWQ==
X-Received: by 2002:a2e:d09:0:b0:2fa:d7ea:a219 with SMTP id 38308e7fff4ca-2fcbe08857emr105624461fa.37.1730310520853;
        Wed, 30 Oct 2024 10:48:40 -0700 (PDT)
Received: from standask-GA-A55M-S2HP (lu-nat-113-247.ehs.sk. [188.123.113.247])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9b3a088adesm587224766b.222.2024.10.30.10.48.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Oct 2024 10:48:40 -0700 (PDT)
Date: Wed, 30 Oct 2024 18:48:38 +0100
From: Stanislav Jakubek <stano.jakubek@gmail.com>
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Orson Zhai <orsonzhai@gmail.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Chunyan Zhang <zhang.lyra@gmail.com>
Cc: linux-sound@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] dt-bindings: sound: sprd,pcm-platform: convert to YAML
Message-ID: <9fc646b70a73e7a6c513771d69b0edcd140f09d7.1730310275.git.stano.jakubek@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Convert the Spreadtrum DMA plaform bindings to DT schema.
Adjust filename to match compatible.

Signed-off-by: Stanislav Jakubek <stano.jakubek@gmail.com>
---
 .../bindings/sound/sprd,pcm-platform.yaml     | 56 +++++++++++++++++++
 .../devicetree/bindings/sound/sprd-pcm.txt    | 23 --------
 2 files changed, 56 insertions(+), 23 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/sound/sprd,pcm-platform.yaml
 delete mode 100644 Documentation/devicetree/bindings/sound/sprd-pcm.txt

diff --git a/Documentation/devicetree/bindings/sound/sprd,pcm-platform.yaml b/Documentation/devicetree/bindings/sound/sprd,pcm-platform.yaml
new file mode 100644
index 000000000000..c15c01bbb884
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/sprd,pcm-platform.yaml
@@ -0,0 +1,56 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/sound/sprd,pcm-platform.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Spreadtrum DMA platform
+
+maintainers:
+  - Orson Zhai <orsonzhai@gmail.com>
+  - Baolin Wang <baolin.wang7@gmail.com>
+  - Chunyan Zhang <zhang.lyra@gmail.com>
+
+properties:
+  compatible:
+    const: sprd,pcm-platform
+
+  dmas:
+    maxItems: 10
+
+  dma-names:
+    items:
+      - const: normal_p_l
+      - const: normal_p_r
+      - const: normal_c_l
+      - const: normal_c_r
+      - const: voice_c
+      - const: fast_p
+      - const: loop_c
+      - const: loop_p
+      - const: voip_c
+      - const: voip_p
+
+required:
+  - compatible
+  - dmas
+  - dma-names
+
+additionalProperties: false
+
+examples:
+  - |
+    platform {
+      compatible = "sprd,pcm-platform";
+      dmas = <&agcp_dma 1 1>, <&agcp_dma 2 2>,
+             <&agcp_dma 3 3>, <&agcp_dma 4 4>,
+             <&agcp_dma 5 5>, <&agcp_dma 6 6>,
+             <&agcp_dma 7 7>, <&agcp_dma 8 8>,
+             <&agcp_dma 9 9>, <&agcp_dma 10 10>;
+      dma-names = "normal_p_l", "normal_p_r",
+                  "normal_c_l", "normal_c_r",
+                  "voice_c", "fast_p",
+                  "loop_c", "loop_p",
+                  "voip_c", "voip_p";
+    };
+...
diff --git a/Documentation/devicetree/bindings/sound/sprd-pcm.txt b/Documentation/devicetree/bindings/sound/sprd-pcm.txt
deleted file mode 100644
index fbbcade2181d..000000000000
--- a/Documentation/devicetree/bindings/sound/sprd-pcm.txt
+++ /dev/null
@@ -1,23 +0,0 @@
-* Spreadtrum DMA platform bindings
-
-Required properties:
-- compatible: Should be "sprd,pcm-platform".
-- dmas: Specify the list of DMA controller phandle and DMA request line ordered pairs.
-- dma-names: Identifier string for each DMA request line in the dmas property.
-  These strings correspond 1:1 with the ordered pairs in dmas.
-
-Example:
-
-	audio_platform:platform@0 {
-		compatible = "sprd,pcm-platform";
-		dmas = <&agcp_dma 1 1>, <&agcp_dma 2 2>,
-		     <&agcp_dma 3 3>, <&agcp_dma 4 4>,
-		     <&agcp_dma 5 5>, <&agcp_dma 6 6>,
-		     <&agcp_dma 7 7>, <&agcp_dma 8 8>,
-		     <&agcp_dma 9 9>, <&agcp_dma 10 10>;
-		dma-names = "normal_p_l", "normal_p_r",
-			"normal_c_l", "normal_c_r",
-			"voice_c", "fast_p",
-			"loop_c", "loop_p",
-			"voip_c", "voip_p";
-	};
-- 
2.43.0


