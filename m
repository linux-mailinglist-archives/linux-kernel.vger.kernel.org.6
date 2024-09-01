Return-Path: <linux-kernel+bounces-310076-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9747696747F
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Sep 2024 05:42:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2515BB20E80
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Sep 2024 03:42:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C9932C6B6;
	Sun,  1 Sep 2024 03:42:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cPejINPH"
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B50E26AC6;
	Sun,  1 Sep 2024 03:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725162157; cv=none; b=Qa7il4NDwSQz5K/YQMLXqh2OU4yE+uo+oK72iygDn6kHF3hofPc7P3YaX1k4I0IOpJhHpkHUY/MInmEI2vxWlUxgnkXXpEg3JBNG7nqO3tCjO3S5JfLbLWOHImrqDkVfBKdes5+KpJXjfIuDJWH0gYw+PbICOtZyX+2n+BtmMdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725162157; c=relaxed/simple;
	bh=XTKSZNA1PDZHsBQHwS6oF9do6WxomCMOodlSA/e5p34=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VhxlMidNcteYXP7ix3d3TYZCEVNeYxh2uhgLE5gNlDEdreCzGCd2YgmA5TbZhKBQZ7R0udieB8xvv2jKNWff6FRkrum6n106I2Z1ME6lFqmacWUVxB3F6do1KPlcYAaGImqutMb265YI6ecQFmGqqTLLKMRv2Ob8mbqrdjXpUo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cPejINPH; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-715cdc7a153so2242183b3a.0;
        Sat, 31 Aug 2024 20:42:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725162155; x=1725766955; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yH9DpB2vOqWFl9C9V+jaABjITs0KYB7EL4dBUQbha48=;
        b=cPejINPH/0FT3aQkz6HWm/605Xkr1HBCeF6Lcxm7un4eeFfLIi6Semx4btUj967IpJ
         hX9NQzW1ondz3HCZHBrvAUmaf1jlKiDC27Ba5gsaxcwlZ425mOX8dRSThPhLm1XUSw23
         M0Uo/crkDEPVFBD0HfpmXSr6Lccnn1MNGLuTYyVlQdj+p5ZbNAT4WwQihhP6TGtodQPj
         c8AQQZsnuLduRs3839LKZQnMhf6ZXdhroOOOrdXKURD/ai+UOUvaKiXRA+pgJeRS3BVH
         N71U5l///rw1w2W968rKU1a4lJxVsc6Ege4Rs1k0piCKcPtarKv/dTyxcpltGd2INfhJ
         EL7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725162155; x=1725766955;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yH9DpB2vOqWFl9C9V+jaABjITs0KYB7EL4dBUQbha48=;
        b=iE4yWCzDP94kGfhZ59u8UwPpnx5XCJS+p6vz4WTZsXLS3wLcuXz8VLMKzAK3wTGGHH
         5CCyVz2MJoOKvLZfry8MREkXoDX9GAiXsRdsTAuG/sNXsJpdfsuYHk8Ch0CAqfz2dCjI
         yDiVQfqasEsAiPco2GPV8DI/XaiC5v9RFIzEpgxf/TXX9ho0LNLSxlrwjawsHUr6xV1Y
         MTFaHI+T514SOzEykl29hH7jxB8fDBh3YZpSBjV4ziOYI1KBvyoyF6+BMpG1MB3YEsu3
         N23QytlGs224ZzMOYZc1zJ/275VbJgPoR/QDEUBZZHHJgQejCVhqSd8sYOLMSViHfBPM
         K/1Q==
X-Forwarded-Encrypted: i=1; AJvYcCUwMUxkEtHPRi7QO2VjuF582rHQYMVIjrvm30qyGKrDtJc2VV4haj8xYmmo6zPZRXQTzmpecE5gk9OD7Hru@vger.kernel.org, AJvYcCVdlL0iJtyTElyxv/WsHq86wyD9LFZ2XyoUu3ffhh35vJquJEdGV8uu7VeVmNOnIx0GRFZTklx/ISMV@vger.kernel.org
X-Gm-Message-State: AOJu0Yyr8xFkqEohJUdr+wkqZuLbLLJKyXgmYGnX0XlrUqHBNFDh2bI2
	w4aYdQ7eO0F1llNAHzTPsIjfiXiQATk7z87poMN2ZARB9xUu0QhA
X-Google-Smtp-Source: AGHT+IEObdUwisREopDN74WlXGu+MwK3ECILVmBEK+u0lfuO5t0y0gHsYBPq4cQjNKSsi8PuduAg6w==
X-Received: by 2002:a05:6a00:181a:b0:714:2922:7c6d with SMTP id d2e1a72fcca58-715e101f8d7mr19711987b3a.12.1725162155177;
        Sat, 31 Aug 2024 20:42:35 -0700 (PDT)
Received: from localhost.localdomain ([49.130.72.113])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-715e55771ccsm4826767b3a.43.2024.08.31.20.42.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Aug 2024 20:42:34 -0700 (PDT)
From: Nick Chan <towinchenmi@gmail.com>
To: Hector Martin <marcan@marcan.st>,
	Sven Peter <sven@svenpeter.dev>,
	Alyssa Rosenzweig <alyssa@rosenzweig.io>,
	Thomas Gleixner <tglx@linutronix.de>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	asahi@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org
Cc: ~postmarketos/upstreaming@lists.sr.ht,
	konrad.dybcio@somainline.org,
	Nick Chan <towinchenmi@gmail.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v3 1/4] dt-bindings: apple,aic: Document A7-A11 compatibles
Date: Sun,  1 Sep 2024 11:40:04 +0800
Message-ID: <20240901034143.12731-2-towinchenmi@gmail.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240901034143.12731-1-towinchenmi@gmail.com>
References: <20240901034143.12731-1-towinchenmi@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Document and describe the compatibles for Apple A7-A11 SoCs.

There are three feature levels:
- apple,aic: No fast IPI, for A7-A10
- apple,t8015-aic: fast IPI, global only, for A11
- apple,t8103-aic: fast IPI with local and global support, for M1

Each feature level is an extension of the previous, for example, M1 will
also work with the A7 feature level.

All of A7-M1 gets its own SoC-specific compatible, and the "apple,aic"
compatible as a fallback.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Reviewed-by: Sven Peter <sven@svenpeter.dev>
Signed-off-by: Nick Chan <towinchenmi@gmail.com>
---
 .../bindings/interrupt-controller/apple,aic.yaml   | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/interrupt-controller/apple,aic.yaml b/Documentation/devicetree/bindings/interrupt-controller/apple,aic.yaml
index 698588e9aa86..4be9b596a790 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/apple,aic.yaml
+++ b/Documentation/devicetree/bindings/interrupt-controller/apple,aic.yaml
@@ -31,13 +31,25 @@ description: |
   This device also represents the FIQ interrupt sources on platforms using AIC,
   which do not go through a discrete interrupt controller.
 
+  IPIs may be performed via MMIO registers on all variants of AIC. Starting
+  from A11, system registers may also be used for "fast" IPIs. Starting from
+  M1, even faster IPIs within the same cluster may be achieved by writing to
+  a "local" fast IPI register as opposed to using the "global" fast IPI
+  register.
+
 allOf:
   - $ref: /schemas/interrupt-controller.yaml#
 
 properties:
   compatible:
     items:
-      - const: apple,t8103-aic
+      - enum:
+          - apple,s5l8960x-aic
+          - apple,t7000-aic
+          - apple,s8000-aic
+          - apple,t8010-aic
+          - apple,t8015-aic
+          - apple,t8103-aic
       - const: apple,aic
 
   interrupt-controller: true
-- 
2.46.0


