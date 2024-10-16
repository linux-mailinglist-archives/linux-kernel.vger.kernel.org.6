Return-Path: <linux-kernel+bounces-367855-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D613E9A07A2
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 12:42:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 515701F277A1
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 10:42:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDBEC207200;
	Wed, 16 Oct 2024 10:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hBqayez/"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B52282071EB;
	Wed, 16 Oct 2024 10:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729075333; cv=none; b=QEIFqnteDMUnLZckMp2TfSycE3iGT72hWqaY9GjnIXuiEe5LqbHxEXADz8Mi0So00KSwbnG4U/LlApxVwJUJCO5FsJ33a+rumDBUGArXKWWicOERteqh13j7NXgCSXxqGUz5d9tgbZXEu+3uSUTpBZGsw7+AlyzjMd1FZoHyydk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729075333; c=relaxed/simple;
	bh=WfdQdE555lvYkoLc9BccgWDGN9ZdZ5pdAw6H/bDgewI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=udRnt5QFsecE3EGjxzss8TQPjFUSyc+lQMe8iQrcNseP0hDeiABRk2NeS+sKaqnMue4nxSMkRh24n/jyz/WfCsdMCyOKbvTLg9TjSAMTTkHTBqzXScPQvhkIKa9WvRlNV6atWjt30QK9d0EgBL/d6mU9eS9O3wlTQ44kGEFVvAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hBqayez/; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-20c714cd9c8so51957815ad.0;
        Wed, 16 Oct 2024 03:42:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729075331; x=1729680131; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=k508/q7r9Xmap/s2FAN/xIftwMTAgTxS8yX0bzw466Y=;
        b=hBqayez/I8N6d5FTfWPzwRZ1NuGOzMwXaKc1+tltaSsOuLcR1emOAPH46XGqUal8Bk
         VRqoffJi9lij8Acl7o0adZZKiwPD8Wd49GJ7sxraC5JOETUCNANc+B0AdXm50TA2dqMw
         jomv8sL7oWd5Kp5Xr9QWpDsAU4EWq2S1RvlOV3jsbhV5Fj3VQ6GiK2+9zydPNgLVGSfG
         kCbkWJXhm1H7SZ1XHPZ9QxI+VmzvGNoBGicUi8siWL6btn9gWiMIS53NW5rbSAKeXYE2
         l36jeDouSak1LtGtpcVQJzXDR1WoW1gQANK03Bqn9VmnqNoX0W1HN1ugJpLNRcVxmNxl
         rEXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729075331; x=1729680131;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k508/q7r9Xmap/s2FAN/xIftwMTAgTxS8yX0bzw466Y=;
        b=gx0T1zBflAhLnMeWsw0eLddZjhlolZBeV8RkEK0s2FVbXlTS3A24i3V8Ur7p2YoQqY
         Uz3/rIyLVQYIjuch1plFGzLlAtgXGTFs5z5h3TZGOlDMq5O+ZHRQHFbMdOtpsEpIvaws
         BRbxg7hRzPY13THFjiQTLsFuvKwHuH3+9IkFYWiXzbIRUvzbTZGHd3l6b8dI+jSZLRc5
         gSvdx9VLLq7u/rVxMohqPHCKYmwST6QXNaUjpIbFCnD5+/wgFFXqBNJFyNG8JnUc3+Pa
         Sy2xAlIVKzbxNteweP8ag4ng08/433mbZuODhKJe77hp0YDaNKkOFiT9rfkSWp9UFWpz
         BuSA==
X-Forwarded-Encrypted: i=1; AJvYcCVrl6/xYcNCx3z9eCPV5DD9xpc7AArqJfMlfxzS3NqTu3hEGmmQA7bzvYs0GPzGwFDEn2njKnWn3zupryOH@vger.kernel.org, AJvYcCWaTVaYa4kBq2M83qCAuOW2gmHfPLY6DZu8jgDQ7XyX7jw5JRG9iD/ezYySi8KoKON6Nq1VJhSLpscHIPI=@vger.kernel.org, AJvYcCWllv78zGdJ+cHtHeJpncJuikvwEBP3lOMtsaHM/58CZorC7nGCZctHnDfw2NI/jBRsGI/bn8/1wggl@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9ni+hq6vke04cTu7mZke15VN2bMTRYs/DraHKLyIdCr842gXR
	zoAWJLGgbtx0XhR83TRLCnMCm/WJ2/OsSWWf236eSMa+ddEAwNM2
X-Google-Smtp-Source: AGHT+IHV1QjAhkHaZMC2MlpFEwK/9q0QOJH8CZm7u6scVRC0Jr1r79GdYyTvOMpomjciV5quEKWJ8Q==
X-Received: by 2002:a17:902:ecc9:b0:20b:b75d:e8c1 with SMTP id d9443c01a7336-20cbb17d002mr261501975ad.4.1729075330947;
        Wed, 16 Oct 2024 03:42:10 -0700 (PDT)
Received: from [192.168.2.3] (2403-580a-80ed-0-4835-5a07-49e7-f115.ip6.aussiebb.net. [2403:580a:80ed:0:4835:5a07:49e7:f115])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20d1804b2e4sm26319645ad.182.2024.10.16.03.42.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Oct 2024 03:42:10 -0700 (PDT)
From: James Calligeros <jcalligeros99@gmail.com>
Date: Wed, 16 Oct 2024 20:41:00 +1000
Subject: [PATCH 1/3] dt-bindings: sound: Add CS42L84 codec
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241016-cs42l84-v1-1-8d7e9d437d2d@gmail.com>
References: <20241016-cs42l84-v1-0-8d7e9d437d2d@gmail.com>
In-Reply-To: <20241016-cs42l84-v1-0-8d7e9d437d2d@gmail.com>
To: =?utf-8?q?Martin_Povi=C5=A1er?= <povik+lin@cutebit.org>, 
 James Calligeros <jcalligeros99@gmail.com>, 
 David Rhodes <david.rhodes@cirrus.com>, 
 Richard Fitzgerald <rf@opensource.cirrus.com>, 
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Jaroslav Kysela <perex@perex.cz>, 
 Takashi Iwai <tiwai@suse.com>
Cc: asahi@lists.linux.dev, linux-sound@vger.kernel.org, 
 patches@opensource.cirrus.com, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3030;
 i=jcalligeros99@gmail.com; h=from:subject:message-id;
 bh=JkQ/4zpAYjuUTa+FzkoroKSF3ka6mM4DeIsa/iLWu70=;
 b=owGbwMvMwCV2xczoYuD3ygTG02pJDOn8M8rYe28kbym9PnNJ8d6eE3yp2b+up0nbrTaa4brDM
 7pqRrVcRykLgxgXg6yYIsuGJiGP2UZsN/tFKvfCzGFlAhnCwMUpABOJqWb4X2mpPpkp32a2R9oi
 udSVZmXhd37Jla8qkP/BG3ZyzhEZbkaGZ3cjknYfmH3ZPkz8x4NTV2JLj09+LnHnMl83z6dwy2c
 lbAA=
X-Developer-Key: i=jcalligeros99@gmail.com; a=openpgp;
 fpr=B08212489B3206D98F1479BDD43632D151F77960

From: Martin Povišer <povik+lin@cutebit.org>

CS42L84 is a headphone jack codec made by Cirrus Logic and seen in Apple
computer models starting with 2021 Macbook Pros. It is not a publicly
documented part. To a degree the part is similar to the public CS42L42.
(The L84 superseded L83 seen in earlier Apple models, and the L83 was
pretty much the same as L42.)

Signed-off-by: Martin Povišer <povik+lin@cutebit.org>
Signed-off-by: James Calligeros <jcalligeros99@gmail.com>
---
 Documentation/devicetree/bindings/sound/cirrus,cs42l84.yaml | 60 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 MAINTAINERS                                                 |  1 +
 2 files changed, 61 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/cirrus,cs42l84.yaml b/Documentation/devicetree/bindings/sound/cirrus,cs42l84.yaml
new file mode 100644
index 0000000000000000000000000000000000000000..12bc6dbeeddfaccf9dd00deb2676deac25f28c9e
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/cirrus,cs42l84.yaml
@@ -0,0 +1,60 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/sound/cirrus,cs42l84.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Cirrus Logic CS42L84 audio CODEC
+
+maintainers:
+  - povik+lin@cutebit.org
+
+description:
+  The CS42L84 is a headphone jack codec made by Cirrus Logic and embedded
+  in personal computers sold by Apple. It was first seen in 2021 Macbook Pro
+  models.
+
+  It has stereo DAC for playback, mono ADC for capture, and is somewhat
+  similar to CS42L42 but with a different regmap.
+
+properties:
+  compatible:
+    enum:
+      - cirrus,cs42l84
+
+  reg:
+    description:
+      I2C address of the device
+    maxItems: 1
+
+  reset-gpios:
+    description:
+      Reset pin, asserted to reset the device, deasserted to bring
+      the device online
+    maxItems: 1
+
+  interrupts:
+    description:
+      Interrupt for the IRQ output line of the device
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+
+additionalProperties: false
+
+examples:
+  - |
+    i2c {
+      #address-cells = <1>;
+      #size-cells = <0>;
+
+      jack_codec: codec@4b {
+          compatible = "cirrus,cs42l84";
+          reg = <0x4b>;
+          reset-gpios = <&pinctrl_nub 4 GPIO_ACTIVE_LOW>;
+          interrupts-extended = <&pinctrl_ap 180 IRQ_TYPE_LEVEL_LOW>;
+          #sound-dai-cells = <0>;
+      };
+    };
diff --git a/MAINTAINERS b/MAINTAINERS
index c1a2c296446c0724a0c6e70c845e5e5e1e693fd5..f5f85714dc4e8ca9c60b3f6963b2cec1ea33fdd0 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2132,6 +2132,7 @@ L:	asahi@lists.linux.dev
 L:	linux-sound@vger.kernel.org
 S:	Maintained
 F:	Documentation/devicetree/bindings/sound/adi,ssm3515.yaml
+F:	Documentation/devicetree/bindings/sound/cirrus,cs42l84.yaml
 F:	Documentation/devicetree/bindings/sound/apple,*
 F:	sound/soc/apple/*
 F:	sound/soc/codecs/cs42l83-i2c.c

-- 
2.47.0


