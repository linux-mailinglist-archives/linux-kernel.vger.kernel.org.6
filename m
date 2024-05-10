Return-Path: <linux-kernel+bounces-175814-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D21E8C2571
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 15:13:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AF6E71C21738
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 13:13:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9590A12C46B;
	Fri, 10 May 2024 13:13:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aFK3i6n8"
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 687E712A171;
	Fri, 10 May 2024 13:13:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715346798; cv=none; b=jyTK0HCURggKZc4VP5cmu9S9pTzjqA4ya+ZOceB9D49WjXq5sNuzTTAXqexDnBMRUM7hflVlaM7jfAwofyEcVy47RSQet9WbJ8V1bUNIMzcxt8oI+PZfd0vdLLMoAWQuiP9cTDrg9v9hBTPvOcCpVTSboIjTT2/K//jTzKg7TMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715346798; c=relaxed/simple;
	bh=8JrqbqQ2BG8wvX50IgeVr/P/vz0sXlkUdxE27nnRu1E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S2nBDoeEtB9TxZBuubTf9Own3XERa1YQSz3fasilgo0NSnyvZXS6vBAssXKRCBZbo5oAeyShNZWgwrk3pQaEClPFO5LCBUX132fQ1phR1AW9sShFSXE7YGGsLR0IRpcS9TqxSNmko9QUUZ+Q97xbNdXV1mnx7LxGDyYwMrjEpxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aFK3i6n8; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-51fea3031c3so2776024e87.0;
        Fri, 10 May 2024 06:13:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715346796; x=1715951596; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C//oVJ20yh+kou4nsdrVNMWq5Hv1zFS3WhKqZWl/XAY=;
        b=aFK3i6n8qMCZ0qB7LP7txUx6lROjFLhrI/WwWIyMx0iK04r5C1A7fowX4R/Uof4CcX
         K5jXWQ7gqDiyzxg/0R0spK4awXvXMIHMyasLudwVqHSmxlwxGsOmdqWmmKvqX6l70xXM
         R5llX8BQZxfI37dUVlDi56smVQMLsnFN0DNd/jqQDDsl72dLdOj9lBQvr3pvnYn2mJUP
         iIXxAkVm+3lxX3VbiAROWbtxo3l0aBkYZkJcpNh1zGkydj8GXgMMZnefsatzHqNqX5qI
         W61ahajoflK4rf2copfZt+Vkrjtij3oiJxUuPWGHLdq2NkoCjsFXDR1oiPcktRqvw1IH
         6p0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715346796; x=1715951596;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C//oVJ20yh+kou4nsdrVNMWq5Hv1zFS3WhKqZWl/XAY=;
        b=QkhcAlxOiN5dnX4T3h1wId2+p2REfV2x46iqil3OJ0CmFbqDhAa0BSbnqcmDAZrESQ
         XsUhmOmfACc2pqDLR76NewQ3+8DfgIxu+gffxGp9n7MiCd0vT9sQggPVPOiztpHyLvx0
         2mkdPNXIv3/Zh7yyazY3TU4uXpm+VZHwO2msFKhaKfgQ9bMBKGWgVx+tGWvSnM1RjAAC
         sBDqdGdzIXrhUJxv9GeIzE0Yl4SKpKMwv8h2WpSH7Jb+crlIYm0ToWwnT0JNbxj/5qnI
         b1WQuIiud0bt2QOQ/LAKiNEDS27aXFedonqRlhEwCo+MFiJDa0xs6hhAitL55vOKOwwR
         HLQg==
X-Forwarded-Encrypted: i=1; AJvYcCWHEFXTPKoNMqoYMrAX3V1iF7s0x9uHZn79589IkCD1wBH4KCk08xYXqzMYw+ngJcHmQ7PISpWKBeDtxBswT2Aj1c8wh2mZ2XKxT+71cIg2CNuTLTtXCJL+7wGYohwjuClN26FYoSxDqQ==
X-Gm-Message-State: AOJu0YyzcuoK9xR3WEUSt8OM3crnB6nv072jmViBAqB8JTlFZ8pxZPBn
	y0JM8sF1ZWScKKTS6401VlaDeeE40hu155css90TtuyEQVZ/KzNm
X-Google-Smtp-Source: AGHT+IFH2hVrVkHqWUPHjoPChiPy5r8DJIHo+cYCdl+DBjP9hAEmvnAhbMJcJEhYMoVt+f2nqIG9QA==
X-Received: by 2002:a05:6512:33cf:b0:51d:9291:6945 with SMTP id 2adb3069b0e04-522102785abmr2647690e87.44.1715346795531;
        Fri, 10 May 2024 06:13:15 -0700 (PDT)
Received: from localhost (host-79-55-54-147.retail.telecomitalia.it. [79.55.54.147])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-a5a17b0173asm185050166b.179.2024.05.10.06.13.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 May 2024 06:13:15 -0700 (PDT)
From: Matteo Martelli <matteomartelli3@gmail.com>
To: Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: linux-sound@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Matteo Martelli <matteomartelli3@gmail.com>
Subject: [PATCH 1/2] ASoC: es8311: dt-bindings: add everest es8311 codec
Date: Fri, 10 May 2024 15:00:13 +0200
Message-ID: <20240510131238.1319333-2-matteomartelli3@gmail.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240510131238.1319333-1-matteomartelli3@gmail.com>
References: <20240510131238.1319333-1-matteomartelli3@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add DT bindings documentation for the Everest-semi ES8311 codec.

Everest-semi ES8311 codec is a low-power mono audio codec with I2S audio
interface and I2C control.

Signed-off-by: Matteo Martelli <matteomartelli3@gmail.com>
---
 .../bindings/sound/everest,es8311.yaml        | 52 +++++++++++++++++++
 1 file changed, 52 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/everest,es8311.yaml

diff --git a/Documentation/devicetree/bindings/sound/everest,es8311.yaml b/Documentation/devicetree/bindings/sound/everest,es8311.yaml
new file mode 100644
index 000000000000..54fb58b9ab58
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/everest,es8311.yaml
@@ -0,0 +1,52 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/sound/everest,es8311.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Everest ES8311 audio CODEC
+
+maintainers:
+  - Matteo Martelli <matteomartelli3@gmail.com>
+
+allOf:
+  - $ref: dai-common.yaml#
+
+properties:
+  compatible:
+    const: everest,es8311
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    items:
+      - description: clock for master clock (MCLK)
+
+  clock-names:
+    items:
+      - const: mclk
+
+  "#sound-dai-cells":
+    const: 0
+
+required:
+  - compatible
+  - reg
+  - "#sound-dai-cells"
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    i2c {
+      #address-cells = <1>;
+      #size-cells = <0>;
+      es8316: codec@18 {
+        compatible = "everest,es8311";
+        reg = <0x18>;
+        clocks = <&clks 10>;
+        clock-names = "mclk";
+        #sound-dai-cells = <0>;
+      };
+    };
-- 
2.44.0


