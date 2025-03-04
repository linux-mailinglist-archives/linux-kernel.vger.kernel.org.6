Return-Path: <linux-kernel+bounces-543883-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 95951A4DB0D
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 11:42:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E40B37A3709
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 10:41:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EA3B2054FB;
	Tue,  4 Mar 2025 10:38:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ObKoSlBm"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6972D20110B
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 10:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741084697; cv=none; b=W5xAco9p7p3X2XFpwgR1+wK7+ooq+oe4Lsvwu3KKB/dVrk8wzc+NfBTs4t8WJSH5l0RVmatjWvDH8eYUsQWaiYUOrd8NJCz5svTbcS5pS0HbzOAJNMBTeogdNjVoCsUZhECt4JM+zXZ9e3O/JmbIibgRtCkxQcQ5+a8ei1XnpOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741084697; c=relaxed/simple;
	bh=bQKkwDg66kSktLEPRMbXRZs1JHN1GixPZhKMmLhibFs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LegvjjD0+HX6yjAadG406AYWgKWZjdjl9pg4VWFOYCbQ/eU/TUsIS9Z18ZZtGAKZ8dSvlwEcqGFKpmj2QJa7D0uPRc2C78vxRMqCmHo2LjJPHcoWTrgHTn+HRG3m00+tCCobinfX450MCYVDySvvrrll2o+Tv6q09w6aw8LyWjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ObKoSlBm; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-43ba8bbeae2so4926515e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 04 Mar 2025 02:38:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741084693; x=1741689493; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m4c6wKYsvgnAeVjnxoSb9zpE19mfz0UUs/D4oCTMhK4=;
        b=ObKoSlBms0pIvvfRY54fp97O2009ia9A0yma70iqCh5v3vb0VqogmZwSJRGh1/7TOI
         aCrKNo9EgaFNYWleBw7oBoHImTilOcHn2QYKj49I5nigrCz0zCpzvjEQy8JMWfBz2k/t
         jJFDHkX3QDDMkjWQTiNutBRsqGbOus6VhBDMK2D8/uUvw2GzrJI3h9Hf1oYMw4sgS3cz
         PIj25qJHahjvnxTghwtRaAewJAyINx3rKZDXF8zhKjnc+bt9zVXQ8pQr0AIYsICjVca9
         ubGNLGrjUPVn/wzXyRIkdYD04fImTi9axg3MoBzPGLYqNYXWFuiw+04/jzIwcN3O/zoV
         rouQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741084693; x=1741689493;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m4c6wKYsvgnAeVjnxoSb9zpE19mfz0UUs/D4oCTMhK4=;
        b=AIGRlJQubmZUUmtGJTo4YyQ+eL62aibJ3hC75ESfb9WDxdeGRBiye9d5kQy/gverC7
         BHb4e6UjIcfsy25cbbl4tkQnVYv0cBP4irEzdwRhYjSWndzkLQ+M9WwTCr78Yo1VoG0b
         az+lH8GuT0UgAY6qysjZjDk6KGh3F+0y1XeuKykEOgcwRqkROxDbPQpuv8r6XdwkdT7Z
         n5oGx3Fk4jwZ4ZnrQwn8lIAaAvRhA/p10sZbYLeo5xBbETcZ2zrX1baZiQ7nzSRp+Ys5
         l9fDwiMHD1z7GtBI1KH7DVcppgYVkRiW5fbhc7/oNfAUGKuv29KZk57YXzrW1peLWQQh
         1L7g==
X-Forwarded-Encrypted: i=1; AJvYcCUzXRgMySUt+p+O8lLoNO1E/+aOEBOeaihyuRSfYd+U3PuaNMtIvv2yp6pnUXJAFbMKI9anaXrouksZPtY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyPh/KAtaOLXH4WQkEmdm7B2/qLmRD1LdvXp9R2+P913vNG3V2j
	5aIIUQOQ8C8mADYuPajATGc50mKX230ESOeNxE5uiTnBODERj+cWnhW1xBS2FMg=
X-Gm-Gg: ASbGnctENmlqoXFSQZeJjsDoNMVXCtT7GLG2fKOOGtDDuAfYFYTBCXrtNPFDAvpQA8k
	N9VJeGt8cVGTC2mKqfCWuriYJh85lfW/DCLgvLhoiBUVMMVOS0eWA0FC00v1WRXsLNaF6DDT+xj
	c957gyYgdAwgM9iUwcmBVG61phPRgE2qVX1b76Ggx+A1Gv2S5G3Y8ncLjaFMWXvRaX/2aDacE5N
	Of8v7BejaGb9UAut00FamDVQrrDXT1R7iMRDN76SLEEmmEuem3E0gAkX2pWYV6ZOZL9Fy3N6cHl
	8iLVQt1TkHtivHFSgniGIHJpaAaw2KtPwpAmCnR9zvD0COgMtwJa34zMDHU=
X-Google-Smtp-Source: AGHT+IH2p/EmPnfRVQkkOTi7SSiFvE6P2sYVBO3i3/SpzlZxDLh1MnVA8qE4Hr5Fj8Vaxg0QgloJwA==
X-Received: by 2002:a05:600c:4c89:b0:43b:c0fa:f9c4 with SMTP id 5b1f17b1804b1-43bc0fafdbemr23862335e9.4.1741084693497;
        Tue, 04 Mar 2025 02:38:13 -0800 (PST)
Received: from krzk-bin.. ([178.197.206.225])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43b694524c6sm198574825e9.0.2025.03.04.02.38.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Mar 2025 02:38:12 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	David Yang <yangxiaohua@everest-semi.com>,
	linux-sound@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 2/2] ASoC: dt-bindings: everest,es8328: Require reg property
Date: Tue,  4 Mar 2025 11:38:08 +0100
Message-ID: <20250304103808.75236-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250304103808.75236-1-krzysztof.kozlowski@linaro.org>
References: <20250304103808.75236-1-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ES8328 and ES8388 codecs are I2C or SPI devices, thus they are
addressable on their bus and 'reg' property should be always provided.
Requiring 'reg' is pretty close to redundant, because the I2C and SPI
controller/bus bindings require it already, but the convention is to
mention 'reg' also in the device schemas.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 Documentation/devicetree/bindings/sound/everest,es8328.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/sound/everest,es8328.yaml b/Documentation/devicetree/bindings/sound/everest,es8328.yaml
index 309c4d01db76..ddddd7b143ab 100644
--- a/Documentation/devicetree/bindings/sound/everest,es8328.yaml
+++ b/Documentation/devicetree/bindings/sound/everest,es8328.yaml
@@ -60,6 +60,7 @@ properties:
 
 required:
   - compatible
+  - reg
   - clocks
   - DVDD-supply
   - AVDD-supply
-- 
2.43.0


