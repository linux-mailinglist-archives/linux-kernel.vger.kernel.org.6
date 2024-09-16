Return-Path: <linux-kernel+bounces-330314-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BF613979C79
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 10:09:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6F7DA1F21230
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 08:09:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 429E41459E0;
	Mon, 16 Sep 2024 08:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="J8bFb6QN"
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8B9313B5B3
	for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2024 08:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726474128; cv=none; b=eh/ClgOAQREiXTjqm1U22T+N9nW55EMTiPuU7pqPNQO1LwSJMy7HpcFEPX2yADh1lIj7JNvc8CqHi7S2Gxj48QI1UPMK0RKJIeSTmzUnYudU8R7cBQoiIDsrABTKcEX4jFq2ZDPli/m4kjLXnBBDnkR5w7DRC8+KXT/ra29kiGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726474128; c=relaxed/simple;
	bh=UoETFPdjMMbnPlCPiHelAcyMEU+Sy/PC5jjGukKQYVo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FLPritYQRww3kaRgdmq/bRsKqApZCSGmWOVeDFwttpKP/NclVRKqUHlhBASAMTNC/ZjVHFXEgKcWKm6L1tEAmgZ3edEU3GUU9jRPzs5lEl9k+gRldSdYMot9RC6rCjfM8Sg5REh8KLm7V5lAl45dmDgvq+jQvXj6T425kAhABbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=J8bFb6QN; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-374bb08d011so2385481f8f.3
        for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2024 01:08:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1726474124; x=1727078924; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=E1vIpzk9oVyVOG06g0kL+sRHU+69aulg2Ae7JhwO8wI=;
        b=J8bFb6QN/KtUi6wMyCggkdgt4TWlaz9rvJ7m3q5N0cM74vi2okkvkLNpTIRdqBAtlg
         dVww4VNEuvMEAGGz2ICXwRWXUxpHrfYV+QlcMfTbr3B6NRSw+QQJzjYF2truWdX0ZCqr
         S1KdXrH8opMqJKoUBcjdfxPJ9oiNfJbDq0Bn7KA6oi/RkZoyC52ZhMqFpjNUV3nbdmQZ
         AcWIZu816KiYqHIqaH7CkHoIIm+Ry9UZn8U4zNRMbwAuqWMXHETL10/VcKQRDF5Mx0eg
         dWP1lM86ySs6p8S2RliQXRpLryJm4UAfv2fRJqCla1L3ixrZsTCysqAcR7dq6rEyjaIE
         7/7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726474124; x=1727078924;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E1vIpzk9oVyVOG06g0kL+sRHU+69aulg2Ae7JhwO8wI=;
        b=ax9DNnMKeAUp+bivRo2+AWsaTnYToYD95rcO1MCXXGmBF+HT8/Qc827TdeaEiNrcLq
         rCp3J5127pCd8uMYvW65KWuISm8x2enVltXEqRNn9NVvovapEW+lwXiFkno+1IWGXVZm
         vwO7KwUwJAUF2RWldti6bdCFvcSBE6vOfOnz3uE6j0E6Th5RinHZfgCaamRZYhATZkVs
         coB7gt2UKZ7P6r0zSifH6zMsyF3Rvr0XUtsOqugvDW+CK72Qh1sLw95587JyVxjCIK1y
         QKaObsX16kT0TQEgltaIkOTKEvKlMVQFO9wphSDEsOfvSmmxHuStP2GENotv+9AB8a6t
         IxBw==
X-Forwarded-Encrypted: i=1; AJvYcCWP4U5usCvGYg2YvW9g4+lcxxgGbxAO8FUm6K2QI3uNQkyynMt1/HO/+DQVpB570I6geaoRjcH8AXIcMt4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwyVB4KiTv1Yl1viSvLgUxn4z/v+grZFRhVfrNb9QeNLGCMmEmR
	+k1ni26fPN8n8atnN4O/wfc/QxCc3HdNnOCmcfUanKIdjEMrOW9AfFJ7GSSQUio=
X-Google-Smtp-Source: AGHT+IG81+KShsTttTV7KpPm//Kr4bYC9L8B76e5tQUnxOSIOPDISgzTpvOQZ1QN9LKC98DyFOdpzA==
X-Received: by 2002:a5d:6743:0:b0:371:88a6:80d8 with SMTP id ffacd0b85a97d-378c2d051c4mr7718649f8f.28.1726474124020;
        Mon, 16 Sep 2024 01:08:44 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42da22b900esm69309465e9.1.2024.09.16.01.08.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Sep 2024 01:08:43 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Mon, 16 Sep 2024 10:08:31 +0200
Subject: [PATCH v2 02/11] ARM: dts: amlogic: meson8: fix soc thermal-zone
 node name
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240916-topic-amlogic-arm32-upstream-bindings-fixes-v2-2-0b20ed4f0571@linaro.org>
References: <20240916-topic-amlogic-arm32-upstream-bindings-fixes-v2-0-0b20ed4f0571@linaro.org>
In-Reply-To: <20240916-topic-amlogic-arm32-upstream-bindings-fixes-v2-0-0b20ed4f0571@linaro.org>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Kevin Hilman <khilman@baylibre.com>, 
 Jerome Brunet <jbrunet@baylibre.com>, 
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=1469;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=UoETFPdjMMbnPlCPiHelAcyMEU+Sy/PC5jjGukKQYVo=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBm5+eEns2xpAxBYid4qem4ZlnMXmeoAFKNbpHSzSSh
 6MH/b16JAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZufnhAAKCRB33NvayMhJ0VBuD/
 9n+YgWfHkRajzlW1vTJNWZLmGRg7FezL0IYhxhYiXr6R/YeefCPamoSvjGvNrZHQ7tkyUvf1bXbaNw
 vkv9blEGGVjdFmEVPoqo58Paw5tMniQZcsoieB1WM7pj5c/erQ6sSrBjrLJYOvFeH0sY5PdP32bjaY
 x0HpCVUhQ6YjR1M5C2K7ix3F9mjWIBFHl44xZwURf/qwhaAyAMZeIBcpuRKttiRMZlJ2dg7Cyvqt1E
 01JSJV1RE8I81j53PZsHKRV7xmdED7+a5Ezjq8WOqJNq7M1PGExkq6jnNvV75Iw6RTsDVzRruqYCvM
 J5e3ylKgwBym5xMuxch5z0cK7jCR+6zw+kohkK/JmGD2cIZccz0s6/EYvwwXva3aLsmB9xClGDih0A
 zyAYl4ewUeZAZi7zVJt1D9Rz+pA5T8ohPXsRTV4lE1iXp1LYQlkUj9Aioma7EiGk8sDtYAeFWLmFLB
 GtLMCACr48z+aer0G+zr8po7tSSCf8H0GBHOKlOF8JVL6Q8cxWkNy77S6j1O3XwlaBejMTu0q+PfRL
 a7Jyrg8q1Q/skxQO3ijIrD+ORehBQykz+MUbGee3EN5jC8ShRTAf1kai3o1Pib6M6BxhlrJHjFs5X/
 D3X4vNj4Od69gY3YxYQPcgvnRxEDVMULLd3ggp6elTVdhrshccuh2C82FKUQ==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE

Use proper name for the soc thermal, fixing:
thermal-zones: 'soc' does not match any of the regexes: '^[a-zA-Z][a-zA-Z0-9\\-]{1,10}-thermal$', 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/thermal/thermal-zones.yaml#

Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 arch/arm/boot/dts/amlogic/meson8.dtsi  | 2 +-
 arch/arm/boot/dts/amlogic/meson8b.dtsi | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/amlogic/meson8.dtsi b/arch/arm/boot/dts/amlogic/meson8.dtsi
index f57be9ae150f..06174d8df789 100644
--- a/arch/arm/boot/dts/amlogic/meson8.dtsi
+++ b/arch/arm/boot/dts/amlogic/meson8.dtsi
@@ -196,7 +196,7 @@ power-firmware@4f00000 {
 	};
 
 	thermal-zones {
-		soc {
+		soc-thermal {
 			polling-delay-passive = <250>; /* milliseconds */
 			polling-delay = <1000>; /* milliseconds */
 			thermal-sensors = <&thermal_sensor>;
diff --git a/arch/arm/boot/dts/amlogic/meson8b.dtsi b/arch/arm/boot/dts/amlogic/meson8b.dtsi
index 2d9d24d3a95d..a3669025d8da 100644
--- a/arch/arm/boot/dts/amlogic/meson8b.dtsi
+++ b/arch/arm/boot/dts/amlogic/meson8b.dtsi
@@ -173,7 +173,7 @@ hwrom@0 {
 	};
 
 	thermal-zones {
-		soc {
+		soc-thermal {
 			polling-delay-passive = <250>; /* milliseconds */
 			polling-delay = <1000>; /* milliseconds */
 			thermal-sensors = <&thermal_sensor>;

-- 
2.34.1


