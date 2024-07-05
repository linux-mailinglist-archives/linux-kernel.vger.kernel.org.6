Return-Path: <linux-kernel+bounces-242055-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6264792831F
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 09:50:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 834581C20C3C
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 07:50:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20D54146D5A;
	Fri,  5 Jul 2024 07:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xfnyfHLR"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDA521465BF
	for <linux-kernel@vger.kernel.org>; Fri,  5 Jul 2024 07:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720165757; cv=none; b=grJwIQ3iKaotyXr1/vYprEIdcjCRZktlNde/71EsiTQB5AqVpNQ+Du97170e+ORMGfB6+8ojv06/HRqURQrk7VQc/XWd55hy6sVefgUIVoYUymy4hpY7hH2HYaUoXycU2LhoNaNGf5/RHAz5mOfN84dF9CplF5Gcb+pnxX1KSbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720165757; c=relaxed/simple;
	bh=ApNgVEyefwonGtF2kg0CC6PZb0wdXDGqNokiDmHMekQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=K8HQbJosf+9QXpI309c/nS9/FpUJ2YuQyVI4M4AAoGQuuQv2NnSflnrZeNXr8SSpPnvJssHC3knmIlSwEeVTCIXoMR9R1pEb+IQyCfBvwyYOR9d+I0H+Dqx6Sk+BaMHj0Q4AewRNqD+ZcWYQbmqwCbxeyd5h0PNHWKYKwRWgKCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=xfnyfHLR; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-42565697036so14897435e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 05 Jul 2024 00:49:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1720165754; x=1720770554; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hgFHDePV9W2t1nLieQ6ukOgilmsjYBj+gzokwhFCmE0=;
        b=xfnyfHLRE2+l5JVYvw/HxIieRWa59q3lUxVxyeAdcyCnmYreRphfLgH/fNgYskrPaF
         EQSitkdA1jJjfWt1ZYcmPLXz/T5OqXHOUom6hsM2LHK55z3NGnGy/figyfc/HoSN6xsO
         YxTtVNSWToHBNVPD0X+4S9PjQE4rWL1tPRQybiSG+RvxGZClUOyB1o2V3S4SBhR4MicY
         VnB2x3Y0KJ0dZFj/xEjm65jMeX0ljWbF4ixoI4SZgVSAt2C8rA25rNeLaXthlNCVzvgm
         g9QCmCqXbpXTelmf0rry8CMRp3//15ghKUASdhFcXzN2Vo5ZPCcmjO2+vFrP317SZd9O
         fZCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720165754; x=1720770554;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hgFHDePV9W2t1nLieQ6ukOgilmsjYBj+gzokwhFCmE0=;
        b=pt5kDmaBKqB/vsiW8aJNL8mlwVK2JyxIU7eZ/rnv+eKo6L96S7RfFbJ888rOn/6aWH
         CMn9zFJ0gZQDkBhmSZRwNwS1Y/a11hgK8a/ykm7pijNxUys2b9hL+FSnLYyPVuhTumji
         B+K64p5KCABV77wgpEJw2BRRk9uEvYTidaNreNs9Ac8nkQCzeO99CEF9wthkcyC2cdQL
         gFacOEJzR1dLhE0czj1wn7UcSVu9Nqtn3iOnaCQYtxgXf3OhmsJnKy93bI9cMFPbmtVb
         1+TBpZ/0nhkLGeddJna1kitEmznlRC1koQXWCG1cLcYKQcui5P3Iy1C5i5BCFlvhZZT9
         JYIg==
X-Gm-Message-State: AOJu0YxuudDE/bK1MICLyNeNbIjnuY9GA5gipCksY6lceg7likB+9Xy9
	ahdxJJSFjRb2aoPeaj7szbmkvt5h+7INDdOLEh0woSs7ljZWzQHI4q+njDXZr+Q=
X-Google-Smtp-Source: AGHT+IGFRb9IDKV5phPE77Orp9M3S3Pni1bit2JH9rlAxTuR1q+tYzMrfJU3TZEbrjt5eP27+7sVbA==
X-Received: by 2002:a05:600c:19cc:b0:421:b906:8088 with SMTP id 5b1f17b1804b1-4264aff9862mr30895905e9.0.1720165754418;
        Fri, 05 Jul 2024 00:49:14 -0700 (PDT)
Received: from srini-hackbase.lan ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3675a0d8ed0sm20183521f8f.28.2024.07.05.00.49.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jul 2024 00:49:13 -0700 (PDT)
From: srinivas.kandagatla@linaro.org
To: gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org,
	=?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 08/15] dt-bindings: nvmem: mediatek: efuse: add support for MT7988
Date: Fri,  5 Jul 2024 08:48:45 +0100
Message-Id: <20240705074852.423202-9-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240705074852.423202-1-srinivas.kandagatla@linaro.org>
References: <20240705074852.423202-1-srinivas.kandagatla@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Rafał Miłecki <rafal@milecki.pl>

Add compatible for MT7988 SoC.

Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 Documentation/devicetree/bindings/nvmem/mediatek,efuse.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/nvmem/mediatek,efuse.yaml b/Documentation/devicetree/bindings/nvmem/mediatek,efuse.yaml
index a773101d8538..32b8c1eb4e80 100644
--- a/Documentation/devicetree/bindings/nvmem/mediatek,efuse.yaml
+++ b/Documentation/devicetree/bindings/nvmem/mediatek,efuse.yaml
@@ -30,6 +30,7 @@ properties:
               - mediatek,mt7623-efuse
               - mediatek,mt7981-efuse
               - mediatek,mt7986-efuse
+              - mediatek,mt7988-efuse
               - mediatek,mt8173-efuse
               - mediatek,mt8183-efuse
               - mediatek,mt8186-efuse
-- 
2.25.1


