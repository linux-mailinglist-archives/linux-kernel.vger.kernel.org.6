Return-Path: <linux-kernel+bounces-209872-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A0792903C18
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 14:39:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 42857282510
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 12:39:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13B3617C226;
	Tue, 11 Jun 2024 12:39:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Drcvk4H4"
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED01F42A93;
	Tue, 11 Jun 2024 12:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718109564; cv=none; b=RpwgN31NMo7OFWH7OkAsGc+Ll7yeaKIPZr4kTLE3xln0wCPlXww5LBLsRKNX8MpMrOL2rYWG0JxE9YkiYshg4TDyx3qfFBXP1tc4gFpmSxEOvEH4fJhRrx0Ph1Jz7LxgJNUWHOtDPcoEEYZnM+KdFFslIoqeP87Owp0+0810LWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718109564; c=relaxed/simple;
	bh=EWpDnw3mVmMAdpRA6hNV+AS/efhTYYfOTWpFiFCjCDQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=arQ6Z9+hihK/6iNfYgE6v62iZBTAXSJOtImeDq1Ba7w/THbtP6b9yZYRZzQKr4YZVbOwbldeyf/wAt1U4dJOIQz25+3rsqBCxQ+dpsICpdqBxEXNVLRpy/cfOFK/S/UbSkkwPY9/879XWnGpdoxYq0TatMTGaohndb4jWHvL+G8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Drcvk4H4; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-7023b6d810bso4406504b3a.3;
        Tue, 11 Jun 2024 05:39:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718109562; x=1718714362; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=BS4fj5LiJWdmh+dFL70oOYb84KSkjmkL6BSWpG6VKA0=;
        b=Drcvk4H4/gL2FURrjQELVR3IIznCtwC4nU42I5M0U3U+ARG8n1Pdsqw9OdSr4ZplMt
         duXUauLZYSJC1Z9YlaUp4pXm1nIF1ClDusICDdyhBONGHAhHf6qZHTXMdRfHXZoQIRHK
         IsSa6ngNAATMukL5OPPNfnvbmlIZayfCCsVzyxtF5q6kjw2jScVkglAgLd/bwqrikUcB
         rK7TuLHcSMMR8KpGVoSuvsahtdr5aCXz3qIfQ1jRKMHtzmyhU7WEnOI+PbCG+CRQ9bTq
         rSWbo/bLv7D1VJLMGe9N2j+oSkfmP/8HRt41LTy61EpC2YZsoftkBoRk4OS2TvCVevh4
         g8kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718109562; x=1718714362;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BS4fj5LiJWdmh+dFL70oOYb84KSkjmkL6BSWpG6VKA0=;
        b=NKy/80Mx0Aup5yo78GWETwHyylATRa5QU9ltHjuxTUV8W7xqIViMLzYePaTZ+kUkjH
         NhKkf7PQvfhjgmYnB2Clg/U3gAqgVb87I4RMiL6hUgAjPfaMEIs8z1COvYEv2nTWu6Aw
         I94g/gSWLDUpR9457/Drx1mMpF551prfdOwanDp3NzZxUC3vYn7PWKozyAWSVccfP3TR
         FnYONuES+J4S0EAxLueQ8xezqZDDez6mOpgMSen+WpyFWyViMSGwGP3xpCtxwGiB1tt6
         S46ETCH8mUvD0CF71Fh60UfwYeBxiSyw3gRWwFVgCo79fizDPcNlP9P5qb0ENtrI2JRf
         UeTA==
X-Forwarded-Encrypted: i=1; AJvYcCVpKX+7annq681EgAch/cp3anpfbkerN/UnIS95b6XDh0nptVWXZ1iUFzceaPNHyDeychYKubHo100QXyGhSHMmexAKl8uVTGjdZ2ZsJiQPEr6A7PYvgXYFy11ruDcabePIQfMpHtqhBrZu6/dHxrf7VYQ5fKGVwE02IZeetvPS0QefBu3K
X-Gm-Message-State: AOJu0YwxXZNT6xf8Mfm3TBF4T9IXOYPJ3fqZBhGBoG/e6KXgQCy3bhau
	WzJVfQDGBeLm0A9IcsCCvRoKWfDk6xClbV0+wotsz0dQhHFBEE5htIef8UCE
X-Google-Smtp-Source: AGHT+IH7FlG2vOSy74vekCW1g4uTsKn76X+lcFrJIIyOQRFzaEvTxFQ8pkeL6COY7fY1HpfvXZVFoA==
X-Received: by 2002:a05:6a20:e605:b0:1b4:5605:dde5 with SMTP id adf61e73a8af0-1b45605e16fmr12833149637.52.1718109562163;
        Tue, 11 Jun 2024 05:39:22 -0700 (PDT)
Received: from fedora.one.one.one.one ([2405:201:6013:c0b2:ea4b:30e0:4e3a:ab56])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c3304f6b84sm1460214a91.14.2024.06.11.05.39.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jun 2024 05:39:21 -0700 (PDT)
From: Animesh Agarwal <animeshagarwal28@gmail.com>
To: 
Cc: animeshagarwal28@gmail.com,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Daniel Baluta <daniel.baluta@nxp.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-sound@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3] ASoC: dt-bindings: linux,spdif: Merge linux,spdif-dir into linux,spdif-dit
Date: Tue, 11 Jun 2024 18:08:54 +0530
Message-ID: <20240611123858.58881-1-animeshagarwal28@gmail.com>
X-Mailer: git-send-email 2.45.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

They are the same bindings other than compatible. "sound-name-prefix"
wasn't documented for linux,spdif-dir, but is in use already.

Acked-by: Neil Armstrong <neil.armstrong@linaro.org>
Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
Signed-off-by: Animesh Agarwal <animeshagarwal28@gmail.com>
Cc: Daniel Baluta <daniel.baluta@nxp.com>

---
Changes in v3:
- Changed the subject and the commit message.

Changes	in v2:
- Add linux,spdif-dir compatible in existing linux,spdif-dit.yaml
instead of creating new yaml file specifically for dummy SPDIF receiver.
- Change file name to support both transmitter and receiver bindings.
---
 .../sound/{linux,spdif-dit.yaml => linux,spdif.yaml}   |  8 +++++---
 .../devicetree/bindings/sound/spdif-receiver.txt       | 10 ----------
 2 files changed, 5 insertions(+), 13 deletions(-)
 rename Documentation/devicetree/bindings/sound/{linux,spdif-dit.yaml => linux,spdif.yaml} (75%)
 delete mode 100644 Documentation/devicetree/bindings/sound/spdif-receiver.txt

diff --git a/Documentation/devicetree/bindings/sound/linux,spdif-dit.yaml b/Documentation/devicetree/bindings/sound/linux,spdif.yaml
similarity index 75%
rename from Documentation/devicetree/bindings/sound/linux,spdif-dit.yaml
rename to Documentation/devicetree/bindings/sound/linux,spdif.yaml
index fe5f0756af2f..0f4893e11ec4 100644
--- a/Documentation/devicetree/bindings/sound/linux,spdif-dit.yaml
+++ b/Documentation/devicetree/bindings/sound/linux,spdif.yaml
@@ -1,10 +1,10 @@
 # SPDX-License-Identifier: GPL-2.0
 %YAML 1.2
 ---
-$id: http://devicetree.org/schemas/sound/linux,spdif-dit.yaml#
+$id: http://devicetree.org/schemas/sound/linux,spdif.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
-title: Dummy SPDIF Transmitter
+title: Dummy SPDIF Transmitter/Receiver
 
 maintainers:
   - Mark Brown <broonie@kernel.org>
@@ -14,7 +14,9 @@ allOf:
 
 properties:
   compatible:
-    const: linux,spdif-dit
+    enum:
+      - linux,spdif-dit
+      - linux,spdif-dir
 
   "#sound-dai-cells":
     const: 0
diff --git a/Documentation/devicetree/bindings/sound/spdif-receiver.txt b/Documentation/devicetree/bindings/sound/spdif-receiver.txt
deleted file mode 100644
index 80f807bf8a1d..000000000000
--- a/Documentation/devicetree/bindings/sound/spdif-receiver.txt
+++ /dev/null
@@ -1,10 +0,0 @@
-Device-Tree bindings for dummy spdif receiver
-
-Required properties:
-	- compatible: should be "linux,spdif-dir".
-
-Example node:
-
-	codec: spdif-receiver {
-		compatible = "linux,spdif-dir";
-	};
-- 
2.45.1


