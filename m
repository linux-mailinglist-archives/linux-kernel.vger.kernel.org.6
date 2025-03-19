Return-Path: <linux-kernel+bounces-567399-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F425A68584
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 08:07:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 22F143BBDC9
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 07:07:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D18A250C07;
	Wed, 19 Mar 2025 07:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W8JXI4ps"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8728B24EF7D;
	Wed, 19 Mar 2025 07:06:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742368000; cv=none; b=u7CNaxq9boIDlXuRHui2RSHbEVflzTEym9dsvnxmwxWalRofa7SCrpT4g0lC2CBGLu9zf3Ly0pvMUkin+3Dg+s8/eIyd0O1K7HyUEywjfPIXSmLZIp26EEIm90V+XsNxS18UFkZ6Pyaab2P5GI7phOMGNEjQekqRPEZUH9leYXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742368000; c=relaxed/simple;
	bh=tvgPwCRWbi/ALkXQMLlct6LyeXt6Qqe+tJZSRrxXF0I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=l3kJnJ7RsMPAKn4V33p2t+KWQRM5wlL+LJZbMHbH5fwpDPhK8KQ2yh3CMMf5pk4ZG+IbLyx3sE7Vx0q8958Z2nA9lzQYHz3BneCs1Zg8ZTh3+9H+L/YvELNZjHMPRuHlmBkXqJPWxQKxsNBgzm4iz01s/LPf9/eSVqg3ILCjx7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W8JXI4ps; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 17C15C4CEEA;
	Wed, 19 Mar 2025 07:06:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742368000;
	bh=tvgPwCRWbi/ALkXQMLlct6LyeXt6Qqe+tJZSRrxXF0I=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=W8JXI4ps/GpodZ9fu7N4s22fdmV9+leBQrvBov4qjUUvvZ7JzgZIEMcPGcLSxUavI
	 bhO8Z05FLZAzpMKLWq9tazy0NcrsHvb5dA0C41XggqZWbV2TdlKyAOy9nDYzD4Ltw9
	 LUVXlxbDnaz9aKjZDLStMOcsHL8T6c8pvwqBsIQ7YXYX79cIQRywWiDFBGXqA1r80w
	 vJ3Xuzlwq9Y0RAXrS0PtE7RTLPJPCMaz6nvdH02L5I9n50ooRcHrNUJtvmIk2RpoUy
	 jHYJ+3YXxotJafv9eVK/Z7AsZ2oNd22AhtvM283Y5IYM5uY0g2qQV+Wd+GvPanE410
	 GTquB86c6Sueg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED0E8C35FFC;
	Wed, 19 Mar 2025 07:06:39 +0000 (UTC)
From: jiebing chen via B4 Relay <devnull+jiebing.chen.amlogic.com@kernel.org>
Date: Wed, 19 Mar 2025 15:04:44 +0800
Subject: [PATCH v4 1/6] dt-bindings: clock: meson: Add audio power domain
 for s4 soc
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250319-audio_drvier-v4-1-686867fad719@amlogic.com>
References: <20250319-audio_drvier-v4-0-686867fad719@amlogic.com>
In-Reply-To: <20250319-audio_drvier-v4-0-686867fad719@amlogic.com>
To: Jerome Brunet <jbrunet@baylibre.com>, 
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Jaroslav Kysela <perex@perex.cz>, 
 Takashi Iwai <tiwai@suse.com>, Neil Armstrong <neil.armstrong@linaro.org>, 
 Kevin Hilman <khilman@baylibre.com>, 
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>
Cc: linux-sound@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org, 
 jian.xu@amlogic.com, shuai.li@amlogic.com, zhe.wang@amlogic.com, 
 jiebing chen <jiebing.chen@amlogic.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1742367997; l=1779;
 i=jiebing.chen@amlogic.com; s=20250110; h=from:subject:message-id;
 bh=LILue2hV/0RBI1wyR/+9esvdXN1gHROx+an1AXnFBQ0=;
 b=5p4uPDUvvHQ9UwyB7WW54kKulEkuralm/Z3oOIisosXjHg1ryW9BuqvlnKrqjlbFOTuCyxTtp
 ZB7idtOCV1MAQgWuF9mAAU56S+UpnvWu8ImxLz9HLy4nvtUq8rlKrrr
X-Developer-Key: i=jiebing.chen@amlogic.com; a=ed25519;
 pk=6rFvvF45A84pLNRy03hfUHeROxHCnZ+1KAGw/DoqKic=
X-Endpoint-Received: by B4 Relay for jiebing.chen@amlogic.com/20250110 with
 auth_id=316
X-Original-From: jiebing chen <jiebing.chen@amlogic.com>
Reply-To: jiebing.chen@amlogic.com

From: jiebing chen <jiebing.chen@amlogic.com>

Audio power domain found on S4 device.it need to enable before audio work.

Signed-off-by: jiebing chen <jiebing.chen@amlogic.com>
---
 .../bindings/clock/amlogic,axg-audio-clkc.yaml       | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/clock/amlogic,axg-audio-clkc.yaml b/Documentation/devicetree/bindings/clock/amlogic,axg-audio-clkc.yaml
index fd7982dd4ceab82389167079c2258a9acff51a76..50a5cbb6eb64873dd5aa55f6f1a63e9e97542760 100644
--- a/Documentation/devicetree/bindings/clock/amlogic,axg-audio-clkc.yaml
+++ b/Documentation/devicetree/bindings/clock/amlogic,axg-audio-clkc.yaml
@@ -21,6 +21,7 @@ properties:
       - amlogic,axg-audio-clkc
       - amlogic,g12a-audio-clkc
       - amlogic,sm1-audio-clkc
+      - amlogic,s4-audio-clkc
 
   '#clock-cells':
     const: 1
@@ -29,7 +30,7 @@ properties:
     const: 1
 
   reg:
-    maxItems: 1
+    maxItems: 2
 
   clocks:
     minItems: 1
@@ -100,6 +101,9 @@ properties:
   resets:
     description: internal reset line
 
+  power-domains:
+      maxItems: 1
+
 required:
   - compatible
   - '#clock-cells'
@@ -116,12 +120,26 @@ allOf:
             enum:
               - amlogic,g12a-audio-clkc
               - amlogic,sm1-audio-clkc
+              - amlogic,s4-audio-clkc
     then:
       required:
         - '#reset-cells'
     else:
       properties:
         '#reset-cells': false
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - amlogic,s4-audio-clkc
+    then:
+      required:
+        - power-domains
+
+    else:
+      properties:
+        power-domains: false
 
 additionalProperties: false
 

-- 
2.43.0



