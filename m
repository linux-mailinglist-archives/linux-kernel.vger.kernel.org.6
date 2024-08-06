Return-Path: <linux-kernel+bounces-276077-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 95273948E1D
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 13:50:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C6BD21C23167
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 11:50:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2E2D1C460D;
	Tue,  6 Aug 2024 11:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wSNBgM19"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 350BC1C37B6
	for <linux-kernel@vger.kernel.org>; Tue,  6 Aug 2024 11:49:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722944982; cv=none; b=fJsh/W1pmgSq/TuIBT6qKsbZzy7DwaOX+PwWr2A4b+58qXejJCbFJSH4aVGg2cVRkQK+S3A+eOTh9d5v6UJpqwWcBhEZI76O5W+nWGipWqbtVmDiHCcrvqy/qCaUJX0vegiVKMwRV4uvvmzG9baAEGzC/uHwzqbMJ3tg0qaJkN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722944982; c=relaxed/simple;
	bh=6V65vXM8FQwUV7v0SXbiGpzXztfTEZwxdLqnBCxG6/Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gpZlmy3miTkDlCxHeS7fqTsrn/k5AB1BZH4QnLciCMx0nCWlIU6hto4sQQV7H9WjC6QL+Sp7Phww+k3ilwMkVAOZQ5uoeAE0GcLbJ8otlYBsDyPcu83HiWX3KDUjPJRSdzAWvfo8adfwcWRMCV8n6CCXvW7lPJ8Vx/GGq+aQKnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=wSNBgM19; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-42819654737so3686385e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 06 Aug 2024 04:49:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1722944979; x=1723549779; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Zcyvcwsgz2iQmtLQWjshVBEVrR/YiNBp3RnZXLsmNgk=;
        b=wSNBgM19l1rWghz/Y+iV07S+3KyuVFlPOmmltuNp1SW28LhGJgTUoWFpUpIvcvh1S6
         0KbiDtj1TbK/UVaZqOmk+k7ZGnSRyFvDTw02mboKPHnQKOFFcQl+BJj+dgN5jWdI+s3o
         9scMRHPYWFx0y8oyC8S64vVgwhi8DWUvBp0Ov9JNGEPsFPoUW6NSXZmRtPBA6df5Rb9S
         kf8vEqr4OxQuwdTCB60I01fVWLVktzZkLsoDrfXPIGkLQOfvjyUndxxslmFrN8pN5Jl2
         cG9pfHMqIABHhh+o1Ov/rkS4RhjFHGKzIkch2ks7gzlJO52YaDJYdK3EQJOqYUtFcBbd
         cWjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722944979; x=1723549779;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Zcyvcwsgz2iQmtLQWjshVBEVrR/YiNBp3RnZXLsmNgk=;
        b=n/9NyAZ90BwFBtQkCciBlGr5aY8p4ydKwRoRYxyZVvBZtCY3mzIicb+raJtJiF45pd
         R0jYzsoXvIUPwU8VY7zibGjuf+VHAqMJYDpli2WSH4eSiEbU0134jlrZW3azwByig6fT
         j0Z//AdbY89GLGn4Z7o6aW8a7+Cbk7+mJ/gUVmPEsCUPU3z23mGQumWAw3WpY4YT67l3
         q2VB3rzy7CviEnzZSZM6MToqjCuWEDGy7GLbFVH76DdsjKiY/KbzctjTAY9dijzaB6n+
         PzIHC6MU6HddaAj1B6CnLWrmrTNf2GPU3barYSrN761fq1uBV27jIhAOzfNFxTvwciPf
         0yGQ==
X-Forwarded-Encrypted: i=1; AJvYcCWzkGxPogoqZWK2pyt0+OQ6C3h8j0vh4zehFr65Hqj0HGEp9vwZpEAc/BEjzfeZkBbYWIdUWt7vSDXF8EAWGADIPlK2mCZY3aQjahd4
X-Gm-Message-State: AOJu0YwPqnL4feoEgkaHdvL9xXe7bLsRWNmxCjvczbMGQI4t5pwkrqnQ
	VqZ7XzIexD7Gw8XlRWSbppPGf2VYwIrN6IvNmlqwQVxYrcEaAxHi2xHQHX7N1cc=
X-Google-Smtp-Source: AGHT+IHdNQyl3G6YqRv/AULLacN9IkO3UKdGEkDTc1z/CSIyS1focn/fP6c1AdbO/8YkYsQAvDZDYA==
X-Received: by 2002:a05:600c:4513:b0:426:63b4:73b0 with SMTP id 5b1f17b1804b1-428e6b96e50mr97378085e9.34.1722944979504;
        Tue, 06 Aug 2024 04:49:39 -0700 (PDT)
Received: from krzk-bin.. ([178.197.219.137])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-428e6e0357asm180287485e9.12.2024.08.06.04.49.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Aug 2024 04:49:39 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-arm-msm@vger.kernel.org,
	alsa-devel@alsa-project.org,
	linux-sound@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 2/4] ASoC: dt-bindings: qcom,wcd934x: Correct reset GPIO polarity in example
Date: Tue,  6 Aug 2024 13:49:29 +0200
Message-ID: <20240806114931.40090-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240806114931.40090-1-krzysztof.kozlowski@linaro.org>
References: <20240806114931.40090-1-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The reset GPIO of WCD9340/WCD9341 is active low and that's how it is
routed on typical boards, so correct the example DTS to use expected
polarity.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 Documentation/devicetree/bindings/sound/qcom,wcd934x.yaml | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/sound/qcom,wcd934x.yaml b/Documentation/devicetree/bindings/sound/qcom,wcd934x.yaml
index beb0ff0245b0..a65b1d1d5fdd 100644
--- a/Documentation/devicetree/bindings/sound/qcom,wcd934x.yaml
+++ b/Documentation/devicetree/bindings/sound/qcom,wcd934x.yaml
@@ -199,10 +199,11 @@ additionalProperties: false
 
 examples:
   - |
+    #include <dt-bindings/gpio/gpio.h>
     codec@1,0{
         compatible = "slim217,250";
         reg = <1 0>;
-        reset-gpios = <&tlmm 64 0>;
+        reset-gpios = <&tlmm 64 GPIO_ACTIVE_LOW>;
         slim-ifc-dev = <&wcd9340_ifd>;
         #sound-dai-cells = <1>;
         interrupt-parent = <&tlmm>;
-- 
2.43.0


