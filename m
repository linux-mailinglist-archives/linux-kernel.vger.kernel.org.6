Return-Path: <linux-kernel+bounces-573667-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E99EA6DA7B
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 13:55:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 845311892096
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 12:54:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD1EA25F965;
	Mon, 24 Mar 2025 12:52:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="A6dVcf4a"
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64EF31953A2
	for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 12:52:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742820766; cv=none; b=EVpR6zdHZXq8Qruh8XAurxfAqW5IATSaV2jZZBQp5Z4dqC+zx3zbrsb6NscZYGe9Pz2jGIurCTyU9wFj7wantJfxq2RSgSgk0fFGu8/GCl4cPVIWgRLl60Ynr4waVwgihcU2H9G61SLUy5yV186I5HQMfnRe92fJKGBS10uxezQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742820766; c=relaxed/simple;
	bh=nq18JtxBJtNAIX2CZtMajdEApqZ+taDn1bWvq4LSEp4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hFe7G7t8oXAsGqr2oqPL4CRjBRaEUPD0TUD2eUSgI2EC/CoFz1hsAbEHPRqjaD425aGl3pxnTf47O+kengd466p/Oe9dcbF6ntob9FujhQh1HX85yAFhjbj31uP63aYjE55wsRLrht7jYr9xmluldSbFqbLLry+AHg7V1H8BGbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=A6dVcf4a; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-3912ebb8e88so498142f8f.0
        for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 05:52:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1742820763; x=1743425563; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=72JCJOMx53Iw0msa6ZgjXoc2/P2YAnqDlDwWLnOfpuU=;
        b=A6dVcf4aiKvBfHcpB53+xDvl9QMw0E3LuES8lP08dSTu1fPcVG4gzMu6xDGJmQaTjU
         74wVzvN78ahAMaZeXTdPSs4v1B0do7X2zvAZvS0q7mojlM96Uhy6nAKkYk54ZblSzaDg
         eODUUwJAav8IE3+xdBecciqJL0p6EOxI0lmUnB+ocCNNH2TWFDNuZKyvXMyM2QNjhNNp
         x4ukRzYqyO+u+4xde76Lcslf8PjjQazClIDxOr5caxqJleXnTBavNA83FxXEbgj9iEPQ
         NPsi4V6AiTCAHgRg6Hv5scCSqHQEmJIfLP0uH8LOS1mRyt/eDBOJf7IMJyUe12zKtwKw
         nUFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742820763; x=1743425563;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=72JCJOMx53Iw0msa6ZgjXoc2/P2YAnqDlDwWLnOfpuU=;
        b=XNpBbjiGAbXw1/SROJUlDnuSNjGNuvVbb2gi9q9yeH45wpPL6ZVXBAow68HCPVGr+M
         D8nK8lt5KQbci/QOhiz3i3utH5j1YGjK1Lf/ZNsIIDA6SHKhQ9CCPUsGHaH36LdrkMqR
         +pUe7yIpxzvWmWwYZslPrZwdDXE8NWBpHR1z22WFFj2dqIJ0L3bITZprXvgyLrp+hQXu
         Syu8uIP8hDE4Wmb4MbHfzGVwgeVh2zVIZXCS7HoH3lJh52m5VKBw3jxj7VS11cHiVe9j
         UPMoGj+PNHtWC9BE9EQmaK4kje3tD63BOCpreqUlDeCpfnsVyapUwFJaub1fVdAK7IiZ
         BrIA==
X-Forwarded-Encrypted: i=1; AJvYcCXisDHkGZcE+1B5YAKQ3PvsadEGAPvVKOB26TvtL1ioVYznsKwj/00cKQvXLIOgiBW2N79ypstyXXC/coY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwP3EIppRYDLe4s0/0z5136hRKZnaGP99mrC7o40cUtYJJXvUrQ
	O8e0yadedAPqopXagFf2W10e54MkkA2A/LxYVCCmJ79+iavEPQp8JKem3h5/j3U=
X-Gm-Gg: ASbGnctZSWdREz0vViJs9Gum2KnUuAwwvXQr8mNwxo1NtBMVU2vhA7Fk+b4fTA2AKcw
	qWxiw6H493MB47xxW5hKl9HACZH++CTFPTVSA0AE6ZLMiN5tPkcDmk4zWg9MttZ8TzGlCCYlYdo
	TyokI8UdSIkyeqblA8Rs8Ohs1AiOL3mBoc6NyMxutdrapYvW42lXFapsawypcPEMdJsbBOHc+fh
	Ga2DAZaWjhWACmcgqvu1UF7fERRFe+x7D+Kb283DTrQx+WP/H7PP2ePeG+0tYwloMrk0J9tUVQu
	VFPaWZKBRp4s1JI/Ou9mEX4qa98Gw1YIOuOlWMMCzVqjWUT2zC8faxUl4FZgYHvVKHqy
X-Google-Smtp-Source: AGHT+IG1z2NVJpJhN3ud8o4Am8/PaU698t9GntqKjtvZTM6FnpwxjCYqBRlF7gCoxVd0XB60+Pn5lQ==
X-Received: by 2002:a05:6000:401e:b0:391:1319:9007 with SMTP id ffacd0b85a97d-39ab7c2fbb7mr3331354f8f.5.1742820762583;
        Mon, 24 Mar 2025 05:52:42 -0700 (PDT)
Received: from krzk-bin.. ([178.197.198.86])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3997f9f682bsm10811402f8f.101.2025.03.24.05.52.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Mar 2025 05:52:42 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Lee Jones <lee@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Colin Foster <colin.foster@in-advantage.com>,
	=?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
	Marek Vasut <marek.vasut+renesas@gmail.com>,
	Chen-Yu Tsai <wens@csie.org>,
	Jeff LaBundy <jeff@labundy.com>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 1/2] dt-bindings: mfd: Drop unrelated nodes from DTS example
Date: Mon, 24 Mar 2025 13:52:38 +0100
Message-ID: <20250324125239.82098-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Binding example should not contain other nodes, e.g. consumers of
resource providers, because this is completely redundant and adds
unnecessary bloat.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../devicetree/bindings/mfd/mscc,ocelot.yaml          |  6 ------
 .../devicetree/bindings/mfd/netronix,ntxec.yaml       | 11 -----------
 2 files changed, 17 deletions(-)

diff --git a/Documentation/devicetree/bindings/mfd/mscc,ocelot.yaml b/Documentation/devicetree/bindings/mfd/mscc,ocelot.yaml
index 8bd1abfc44d9..b613da83dca4 100644
--- a/Documentation/devicetree/bindings/mfd/mscc,ocelot.yaml
+++ b/Documentation/devicetree/bindings/mfd/mscc,ocelot.yaml
@@ -76,12 +76,6 @@ additionalProperties: false
 
 examples:
   - |
-    ocelot_clock: ocelot-clock {
-          compatible = "fixed-clock";
-          #clock-cells = <0>;
-          clock-frequency = <125000000>;
-      };
-
     spi {
         #address-cells = <1>;
         #size-cells = <0>;
diff --git a/Documentation/devicetree/bindings/mfd/netronix,ntxec.yaml b/Documentation/devicetree/bindings/mfd/netronix,ntxec.yaml
index 59a630025f52..06bada577acb 100644
--- a/Documentation/devicetree/bindings/mfd/netronix,ntxec.yaml
+++ b/Documentation/devicetree/bindings/mfd/netronix,ntxec.yaml
@@ -63,14 +63,3 @@ examples:
                     #pwm-cells = <2>;
             };
     };
-
-    backlight {
-            compatible = "pwm-backlight";
-            pwms = <&ec 0 50000>;
-            power-supply = <&backlight_regulator>;
-    };
-
-    backlight_regulator: regulator-dummy {
-            compatible = "regulator-fixed";
-            regulator-name = "backlight";
-    };
-- 
2.43.0


