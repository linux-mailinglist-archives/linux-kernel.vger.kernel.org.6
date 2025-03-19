Return-Path: <linux-kernel+bounces-567559-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1030BA687BE
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 10:18:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AA26E188C8F1
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 09:18:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCAD5253B52;
	Wed, 19 Mar 2025 09:17:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AaW7Ojnh"
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9124D25291F
	for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 09:17:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742375875; cv=none; b=YZHeQ9BOL9MVI6KOcwhN6SLDyw+FUE+gpuoG1EnMYm9KgL6JeTq1KJGaqjviHukXOhLGY5ZqCL0lnAT2FUx81zyhxiYUGMYPubtz9Y+zs6+uqFW/PLjRRoZgx18oUy8hd05CySvXeWS8OqHE3s2fcG/BniRmjheLWa1ygNyCBwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742375875; c=relaxed/simple;
	bh=M6dCa9QbYlf7D6XIUvrH5DEVFVT265xiBP6CZshU2Xg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gS3AwcK+D0xV2unUfl78EYVh3yssurQsOOakh5Vbgw3HlL8nGhfKW266f67BR0KCV/eWJgEnfhFE1g9f4aVpCl/wWiCG47PRBd+LXsyZfEykkq07S4ALDfLOfQh6VvLENINo9KUm2sN4ew1r0lMXZORDkcKBGj/lm+Z9Ke08aJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=AaW7Ojnh; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-39130ee05b0so6446681f8f.3
        for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 02:17:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1742375871; x=1742980671; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rfIpSAHZSkPf6dqXb1ymwuVLti0MmykrLRZH/yq3jag=;
        b=AaW7Ojnh8acQujWQcfpmN1uNS62gQSq8vhCZsgh6mPdlfTv1ueWr0h3aOhA5i/Ex4E
         jRJ0sfMScHjxbMDVjWt9vPU0c8QzGdOOR7fe+FtC5/ll2qSqT/YOCutViF1s34CvC58a
         p4RRDVG4610bA5xYj0tznu0ElAdtHWDDN2y63wS5TXhiQMItcdbkzAH2IvOpqpwOPoiO
         kumWd+9po5D+6Fb0ILcCB1dC3bj5wfIggAM1UjiycwGqz7a/H4+NG76UeBVnz/J34M12
         U4I/MyZ+Jf3XwS8Iz0gdPQsdNs1jK7SzIXhvkUtkcG6M48wml+lvzijyYseQGYnIELxM
         Ac2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742375871; x=1742980671;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rfIpSAHZSkPf6dqXb1ymwuVLti0MmykrLRZH/yq3jag=;
        b=nf56XTsHpIUsK6t8qAEgBJKgtUnNuRWfzODfzdZL4aELZBh/AboaWvQ4ajWZ/jTLLB
         npOB6ZNUVdVx/wsv448208yUBHLt0IWRXsaNEspMWEOoL8fpIohXoZRaCuiuvGqMseoL
         gpcoG102e0lQHl8D3CYoBOx5s0TtYp/C/SqIBSo2ysh837m2YQbjK3AGqkBm44hAnsQl
         5VCURqAdP39U43FEXW+hzZlgtNm7wnBYzeq+N/42Bjck39/WO5CoU5hjrWk6ZKbelPjF
         odeRH+csKg4rcjNFJAITWbYmSTqiL9camucrh4RhC7rOjlEY6+UloAiYDqM/LCAsyz1H
         rGVw==
X-Forwarded-Encrypted: i=1; AJvYcCU9fmS/Kx+TwWEElELtXnbmp10UA5KuH+jIsLxg0nhfUe8ZIiLsWPrjxgdVShzSZuGRKFelL9hn51q1F6s=@vger.kernel.org
X-Gm-Message-State: AOJu0YxhtS3FvV43aj3113Y0it7Kvs0akSLlcWUby/WNPPTiIeShCwnj
	4UPe0bS3ufEMP+1dYO3V6GcDp9J8FyHvl9GAWEJUVh0JRqsy9WoweSwyaiXXCK4=
X-Gm-Gg: ASbGncu34rr0od0fxgL+8hDHPiXMW2wmK8AzDfPcpuN1WAmWYSiR9rhVtoxP78Ehtgp
	8A1mIuXmr3rKQ44Mqx5+7iqfBaggaKzE6nycoDOt0h2aOyMs92e4TUt4DNjMzCdxKbpD9uX/JyG
	X7svPoAq1vNJvwN5P5p8/pw78GbkX+obmw1py2obv3nY3D0V7jytgPeHmgeqqIJxX38jddNOjVw
	6XNqhVS45FRhUquAXLUYCMC4+37SOf1k0oDUjNbOg65858tEZbF+43UZH8h9jhg5w1lmvGqMgXL
	XWol9psI2CiIdb8edUFQqcSIP0N3Qkydmh+PigQ+suKBF4P92KwlPy9QnuNtspab1UY73Q==
X-Google-Smtp-Source: AGHT+IFJ2iLmk8pAPqBAWEp0LzO+Z/VRz7gyRhBPaVCohInnwXkQ6lhGBk/Zng0hIIeJtYAjoAn+AQ==
X-Received: by 2002:adf:a40d:0:b0:391:2dea:c9a5 with SMTP id ffacd0b85a97d-399739c6b29mr1425261f8f.20.1742375870820;
        Wed, 19 Mar 2025 02:17:50 -0700 (PDT)
Received: from localhost.localdomain ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-395c82c255bsm20023810f8f.23.2025.03.19.02.17.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Mar 2025 02:17:50 -0700 (PDT)
From: srinivas.kandagatla@linaro.org
To: broonie@kernel.org,
	andersson@kernel.org
Cc: lgirdwood@gmail.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	konradybcio@kernel.org,
	perex@perex.cz,
	tiwai@suse.com,
	dmitry.baryshkov@linaro.org,
	linux-sound@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	johan+linaro@kernel.org,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 1/3] ASoC: dt-bindings: wcd93xx: add bindings for audio switch controlling hp
Date: Wed, 19 Mar 2025 09:16:35 +0000
Message-Id: <20250319091637.4505-2-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250319091637.4505-1-srinivas.kandagatla@linaro.org>
References: <20250319091637.4505-1-srinivas.kandagatla@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

On some platforms to minimise pop and click during switching between
CTIA and OMTP headset an additional HiFi Switch is used. Most common
case is that this switch is switched on by default, but on some
platforms this needs a regulator enable.

This patch adds required bindings to add such regulator.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 .../devicetree/bindings/sound/qcom,wcd93xx-common.yaml        | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/qcom,wcd93xx-common.yaml b/Documentation/devicetree/bindings/sound/qcom,wcd93xx-common.yaml
index f78ba148ad25..fa00570caf24 100644
--- a/Documentation/devicetree/bindings/sound/qcom,wcd93xx-common.yaml
+++ b/Documentation/devicetree/bindings/sound/qcom,wcd93xx-common.yaml
@@ -26,6 +26,10 @@ properties:
   vdd-mic-bias-supply:
     description: A reference to the 3.8V mic bias supply
 
+  vdd-hp-switch-supply:
+    description: A reference to the audio switch supply
+      for switching CTIA/OMTP Headset
+
   qcom,tx-device:
     $ref: /schemas/types.yaml#/definitions/phandle-array
     description: A reference to Soundwire tx device phandle
-- 
2.39.5


