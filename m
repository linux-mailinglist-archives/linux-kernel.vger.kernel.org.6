Return-Path: <linux-kernel+bounces-285380-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 36DB6950CC6
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 21:03:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BA97828194C
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 19:03:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B75411A4F14;
	Tue, 13 Aug 2024 19:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="g6hHk7Yx"
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FEAB19AD5C
	for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 19:03:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723575799; cv=none; b=I3nNA9OLjXlVj4k0hrtCB+zh+Nb6mu2UdHS1LZAG/bkKijGa2h+JdrLu2xcDy6QsPY+GlkD7uvPPlhJuUaiYblF2YenGoDbbXGOYhkxm/H/h6HaRKlXFObZa6cOUBeO07IfD+Zs4N1QTNrD31Ln/Pus51fgSAkFeIfGLFhZT00s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723575799; c=relaxed/simple;
	bh=wZZi2FnrSd3Y6ntD+VqvzTWx0ibV9Sj/dK6MjW4hzrY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fL84S2x86GN2o7cZQ59uGPeYPWGlAL7OcCgxFK5QXHrHa7IGqDUXEFTPtYxIY4nLobNTE41nSWLEgjv02+ein0WKaDDSpgnYGXUCQnLPzUGNzsIy23sappD6revcPFnwkiJ8SsGbPXDx4QQWJNa1q2SxHseP6mSkgqoo3Un0zgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=g6hHk7Yx; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-52ef95ec938so6132423e87.3
        for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 12:03:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1723575794; x=1724180594; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fpSg/3y828Pw97blr6HDnxsdU+5aKQgCf2MNnTGXTPg=;
        b=g6hHk7YxcXKw9XYZlz/rldPNPtP9sSxJ3sP5e9/TD+gaMjqzohmlaZeYju6RqwpK3s
         EW0YwOgAKdyl9GFH5qavww7ownEi0yz+UHzqKtdW2ThprXl+rQQEditJeq3TgyjN2FUE
         mbEd9Vk6WF/WHVu32tWpkTG7SA+mqCzGMXQhzZdKoXv9KRXYEtWTH7h1WOOIsIGKIRZM
         uIT//+AZ2sQCMC9gON8jVUTrD+OewaVnYf48Rspq19wg5V6bSmNlcuuFLgNZ8a+SIlfG
         Sya7cPzOOX29nHuhRPMkGljQIKFbJbYai10US3rO6qkz2NH5I8MdO3VfXUiDa2kpKFJv
         JygQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723575794; x=1724180594;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fpSg/3y828Pw97blr6HDnxsdU+5aKQgCf2MNnTGXTPg=;
        b=q+NErBxmFFLthe9auhoHb99Om6XQJTgnIFKhQmVdk+e55AxBN5RxRve7KEWJxRAkg4
         OLtz87Drh1CU4IqfE/V0JUklBv0Rq9TuSJQjid4KcxEmnuMpbnqDMd9ed5BspagNGtdt
         Q4dHJqVBAtDK2ZsdM1HBPBsNnPmFucQ7qndkdpyHPLPGtoaFuWEKrTanH3mzyZmM5fzZ
         /IP++W8tDF+uL1/GQ1s6Ko9Dl3+kKtc7PePD7vkvMHU7HkG3AajCIatMI26w/L74gYCt
         xQvce3c3y2104y6n1/fld6EKWbr/kNedM53eSf5mYz4lYdKE4TBP5pAKWZziUqDPKodI
         iM0Q==
X-Forwarded-Encrypted: i=1; AJvYcCXpQ3Wq4Iyflxl9lIOmM4Nk34epGf7Nsku+sXjfTGJMdCAkmAGYRImy4clkxy7JtCnudPC498ZZLf0TKPAovGWVNEvbyVxQ1R7sSXPN
X-Gm-Message-State: AOJu0Yx4LkKeXFqAePGGyMJegpCegzXk8n1CupsIoSZOsIOgctz2ugE0
	v4wFD0CSocx+FjubqICRMQgxImSov0kbwNU3cIi2OvVCJhtK5qavv2OXNxUHjaA=
X-Google-Smtp-Source: AGHT+IH+VagueuQIXMxGnIX0w5CylWhKwU2nLQR+DMf+tI3DEgtgkMQnem1H9OyA00MT+ZbTBm902g==
X-Received: by 2002:a05:6512:2351:b0:52c:b479:902d with SMTP id 2adb3069b0e04-532eda5b0famr222373e87.4.1723575794356;
        Tue, 13 Aug 2024 12:03:14 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:dc:7e00:3979:ff54:1b42:968a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4290c72d8ffsm229487185e9.7.2024.08.13.12.03.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Aug 2024 12:03:14 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Kalle Valo <kvalo@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jeff Johnson <jjohnson@kernel.org>
Cc: linux-wireless@vger.kernel.org,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	ath11k@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH] dt-bindings: net: ath11k: document the inputs of the ath11k on WCN6855
Date: Tue, 13 Aug 2024 21:03:05 +0200
Message-ID: <20240813190306.154943-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Describe the inputs from the PMU of the ath11k module on WCN6855.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 .../net/wireless/qcom,ath11k-pci.yaml         | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/wireless/qcom,ath11k-pci.yaml b/Documentation/devicetree/bindings/net/wireless/qcom,ath11k-pci.yaml
index 8675d7d0215c..404974d77826 100644
--- a/Documentation/devicetree/bindings/net/wireless/qcom,ath11k-pci.yaml
+++ b/Documentation/devicetree/bindings/net/wireless/qcom,ath11k-pci.yaml
@@ -50,6 +50,9 @@ properties:
   vddrfa1p7-supply:
     description: VDD_RFA_1P7 supply regulator handle
 
+  vddrfa1p8-supply:
+    description: VDD_RFA_1P8 supply regulator handle
+
   vddpcie0p9-supply:
     description: VDD_PCIE_0P9 supply regulator handle
 
@@ -77,6 +80,22 @@ allOf:
         - vddrfa1p7-supply
         - vddpcie0p9-supply
         - vddpcie1p8-supply
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: pci17cb,1103
+    then:
+      required:
+        - vddrfacmn-supply
+        - vddaon-supply
+        - vddwlcx-supply
+        - vddwlmx-supply
+        - vddrfa0p8-supply
+        - vddrfa1p2-supply
+        - vddrfa1p8-supply
+        - vddpcie0p9-supply
+        - vddpcie1p8-supply
 
 additionalProperties: false
 
-- 
2.43.0


