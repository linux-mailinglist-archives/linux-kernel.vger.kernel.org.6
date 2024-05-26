Return-Path: <linux-kernel+bounces-189841-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 737028CF582
	for <lists+linux-kernel@lfdr.de>; Sun, 26 May 2024 20:45:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2E74B281193
	for <lists+linux-kernel@lfdr.de>; Sun, 26 May 2024 18:45:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4B7E12BEA5;
	Sun, 26 May 2024 18:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nMSi52wv"
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BE4C1A2C21;
	Sun, 26 May 2024 18:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716749139; cv=none; b=B8G1RBv3OGhXA3r5HpOjWsl6Rszmpw5rdlyx98fRDc14r/zszETALqUqZu5ScfCxTj1mjBTdMNC8ZMXv7lB0XpezkpIidCfEzYUpr7tcWp4JLrPZmPEpCSdwnGw9aRmBiOGAZ0iCU1w+bCNKKM/+svKPlUeddQua7Z2DW5Psj5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716749139; c=relaxed/simple;
	bh=Jn/oennutCbKq+bpfLRWSfWybsFguqTo2dXI8ycdh5k=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n4keTb8m7aJoolkIaR1G2yy3CUEuIDJtJwePW7BPJyjQ/KhgxoIEdZxXD67Xd8+8U/tKkl2olTxQtDlnPUOC4GRsItqEBlokD8sS8PX/JEkdw90sDn05gIOZ7jkFrjIwYphCAEeCeLwkiuxS6+P2Qb8n9RAzB5HJZQpf3u3PweA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nMSi52wv; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-35507fc2600so2413858f8f.0;
        Sun, 26 May 2024 11:45:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716749136; x=1717353936; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nnzxDfpe0iPVXlvwWkWqHb0XuymYzvTbT0c38MGaPZY=;
        b=nMSi52wvw42VdsJ7+9DGOHH8iXdnVvCvw6pGiRJz6o9aXhnJan43ub1Jrvhp+pBpWW
         NmFwdQlXjpcpyKqftbtLBq/oRP9aIwHmrFqvsesZr2iJPS8sGZWHC8ahpsM9IlDsrn5m
         dHwqFP58D0BjUkq883gvv1jxewbV90PljzT2zmNOnnJ4C6nc9dC6qACGY2D/dJx81pWs
         +fC446Nrgvp726X2ZFp7oZBha9Hmy9TwyY4QjFamtu30D6nqZL0yVyhJ2q4tS5bTLiCP
         p1z1nKEgZm+aSJEioQtoZB/2RPu/AfVmbFjxjMtzTmAS6kuN5oFzljFDGrwfeH1vTF0l
         xO4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716749136; x=1717353936;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nnzxDfpe0iPVXlvwWkWqHb0XuymYzvTbT0c38MGaPZY=;
        b=wUOuv68SHcn49c7HTTPTZQr8wu6GaynYMWXUPBfKLgzjdmP7ro/Vq8v+K0vxshLd+c
         NntJyAY2Zi86mHAjae9LE0UfVvbkxVrVkWR7KH3gzgrNepsF2L9aQF01lJjJLV0QXLz6
         xX82fgILHMuINN31/k9LhNwPKQySE1mHusk3iEHNCGkU7DU2t5lcKlp1Oh84CeN89Vro
         dvMZDb31WWqt4PeaF6KTXXZqUnq1AHc1+pqbicuod+kvftLsYNyhTvtYXGoPAvAMGVME
         9ootv8Js/6RAFl5JuY7Q/AOlbMobt+/3jfj/Uod/frznUKJO81t5zacHYgG2+KJrOOgG
         wqzQ==
X-Forwarded-Encrypted: i=1; AJvYcCXnRqWsUYwIRtZpqLlAW8IJRfswMF0gsXlUouS+sCmg9VDvVVd4S2lXWC0szLE5Hf9J1oHJMII8BBgW5/wXZI3hGQWd7AMICzryUsWGbwEDMaljxTKwY+cJKW7b0Z5wihmuyVgPcuO++HkE1kSva5iUPZt+8DNMAG+cOQeV5sDDYNojFdwR
X-Gm-Message-State: AOJu0Yw9KOUsIMMzdU+lEtfORnu0c6unFpThnGkfRN2sT7M3BflreHxN
	l1uV8frRNikLvG0fvQgDxqp5kyamO8r0S65caB9gOXWq7ThAVUA0
X-Google-Smtp-Source: AGHT+IElfipAR8N2uKG3K9Zf0InJRVbqv0ms/tbTMdGV5hx1RHXSHuNWaAq9BPK+MX56S6kekTfWsw==
X-Received: by 2002:a5d:64ec:0:b0:358:a66:160 with SMTP id ffacd0b85a97d-3580a66021dmr2333078f8f.38.1716749135462;
        Sun, 26 May 2024 11:45:35 -0700 (PDT)
Received: from localhost.localdomain (93-34-90-105.ip49.fastwebnet.it. [93.34.90.105])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-421089cc504sm84960075e9.40.2024.05.26.11.45.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 May 2024 11:45:35 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Jean Delvare <jdelvare@suse.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Christian Marangi <ansuelsmth@gmail.com>,
	linux-hwmon@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/3] dt-bindings: hwmon: g76x: Add support for g761
Date: Sun, 26 May 2024 20:45:24 +0200
Message-ID: <20240526184526.21010-2-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240526184526.21010-1-ansuelsmth@gmail.com>
References: <20240526184526.21010-1-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support for g761 PWM Fan controller. This is an exact copy of g763
with the difference that it does also support an internal clock
oscillator.

With clocks property not defined, the internal clock oscillator is used.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
Changes v2:
- Drop internal-clock property

 .../devicetree/bindings/hwmon/gmt,g76x.yaml   | 29 +++++++++++++++++--
 1 file changed, 26 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/hwmon/gmt,g76x.yaml b/Documentation/devicetree/bindings/hwmon/gmt,g76x.yaml
index bfefe49f54bf..6dadd24efca2 100644
--- a/Documentation/devicetree/bindings/hwmon/gmt,g76x.yaml
+++ b/Documentation/devicetree/bindings/hwmon/gmt,g76x.yaml
@@ -4,13 +4,17 @@
 $id: http://devicetree.org/schemas/hwmon/gmt,g76x.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
-title: GMT G762/G763 PWM Fan controller
+title: GMT G761/G762/G763 PWM Fan controller
 
 maintainers:
   - Christian Marangi <ansuelsmth@gmail.com>
 
 description: |
-  GMT G762/G763 PWM Fan controller.
+  GMT G761/G762/G763 PWM Fan controller.
+
+  G761 supports an internal-clock hence the clocks property is optional.
+  If not defined, internal-clock will be used. (31KHz is the clock of
+  the internal crystal oscillator)
 
   If an optional property is not set in DT, then current value is kept
   unmodified (e.g. bootloader installed value).
@@ -22,6 +26,7 @@ description: |
 properties:
   compatible:
     enum:
+      - gmt,g761
       - gmt,g762
       - gmt,g763
 
@@ -51,7 +56,17 @@ properties:
 required:
   - compatible
   - reg
-  - clocks
+
+if:
+  properties:
+    compatible:
+      contains:
+        enum:
+          - gmt,g762
+          - gmt,g763
+then:
+  required:
+    - clocks
 
 additionalProperties: false
 
@@ -80,4 +95,12 @@ examples:
             fan_startv = <1>;
             pwm_polarity = <0>;
         };
+
+        g761@1e {
+            compatible = "gmt,g761";
+            reg = <0x1e>;
+            fan_gear_mode = <0>;
+            fan_startv = <1>;
+            pwm_polarity = <0>;
+        };
     };
-- 
2.43.0


