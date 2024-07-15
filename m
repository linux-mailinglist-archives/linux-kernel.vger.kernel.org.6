Return-Path: <linux-kernel+bounces-252494-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 304259313E1
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 14:16:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D8CA71F2207C
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 12:16:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FAD718C321;
	Mon, 15 Jul 2024 12:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="udJEA3t/"
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4CF3188CDA
	for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2024 12:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721045769; cv=none; b=hDb0ko8Pf0QLhlN+AwcbqgC097zzbbTHg/nOQdpdRgeTinMpgOuKYVvw9Agf+ux1WCMhMp2sQDLOkWRH7tL73+BbBpnuXDW1ueiY+zIlyi3KYpPKFhI7FDDG+we3OzC1eCACEfhS1nQ8mfIMjNlQf9UgiEk9SoDOb9Jnqqs+y6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721045769; c=relaxed/simple;
	bh=5xxCslBz39cd9KCBn386k+DYETh3rATBhqlskCXMh/4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Qq6HPQMQ0hWW3exScefiy24APlNcueffiZmkV9/IdtbaPAy0lrUEkSwfx1A2QqDfsOgCj/kCwDR+FSZx/h8ZZPrgDW0ZA3bksPf7OVr0SELzaQ0/mCLQ4z8Gp/SA4ke9IMyvMgfO4jRA6Fgnt9BzoPLbTe7UrwDjrSXjSnoSUMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=udJEA3t/; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-367ab50a07aso2632075f8f.0
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2024 05:16:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1721045766; x=1721650566; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CwYPDTPYAwmjKmZ1/Gf11accW/fLFhZgeFXsYW2+ut4=;
        b=udJEA3t/couQkVT3Z443Rkb88vX0bp7H5bvfLt7NoCtVzWhv4+4GwoFn9+NkEz5JU7
         JFtZdz5JtGNb0T6T+4FVYXMmyl1D4EORzAPlH/TxGVupStL/j+to8ngahPhaRI18nVp4
         Bs5yeq5yUArHjT5vEErVj0TRW6n2cVOmOQ1DFRqmvuXzDICmxNbUdb9L3Dcy3EJLyJDx
         LjFGmHQ7e+yb2pxzc4j0exUDvDT7w4g6/prxg8zYKPr9PrP9Ro9n3UKb2wGWVVLIPwjC
         kaT5QNaSDapoK/TZWgnsWu8B9I7AmHLNbOPJCF95ymDofMx8KLjecoknNxIIWsGGWja+
         J2Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721045766; x=1721650566;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CwYPDTPYAwmjKmZ1/Gf11accW/fLFhZgeFXsYW2+ut4=;
        b=g8mmg9WHm+xsiG1b6z8J/XHDkt6JTH0SMHdzb6XT1UtmsAhgK+VQcOAhv2mb/KxTlw
         q9R7giGd8IeuI7VpmDYBO8S56vbE9XQPuIgG6jcoNB92OnENJI6PRT5TaYIU0y84vEO4
         1CExsIQF8CQWbsX+Z//CpceyQOOG4Yt9NxRk9c4H3B7U+686OnLzXIneCzpX7hv0nHMy
         6asmSVB8nXiNemgW+5Tuo1kvsNGXfvdyJKixMdvrcJzU1u2RkmVp/9ETVAbk21P4zi2A
         T6uhZDkP1/4CT/V7jt5yni/pquw4fFV3ZU9TUnqBelk/7cqZe2k0snV6EfrBLm5+fXZp
         uJxw==
X-Forwarded-Encrypted: i=1; AJvYcCV17T6L3IbDV9QVzwFRbHVX+u7SLs3mhT9qDSKmIR9qbwQShaj2zS6I5Kw0PPEmqsxOZUQMA/y6ZWOBmlxImSXlOqp5oCFFJ62BVR6S
X-Gm-Message-State: AOJu0Yz1rPIge9brHEdMBqvGh0nUZGrTn2EOjjipEhd0fHr+iaikuTIx
	0mODBQAL6jA9YQnucvz0jmzxbyCe9Mr4lC6JejrU8/8e4Hj4fMy4/mubCoAIdpg=
X-Google-Smtp-Source: AGHT+IGqx28NbMNvmzLw5J0w/TQ3ZQHmxkK+h/DWdncxb76LIdC5qwbxWV7jVF8Ibsfqau3YeIjlGw==
X-Received: by 2002:a5d:47c3:0:b0:367:8a3b:2098 with SMTP id ffacd0b85a97d-367cea46076mr15982239f8f.3.1721045765987;
        Mon, 15 Jul 2024 05:16:05 -0700 (PDT)
Received: from [127.0.0.2] ([2a02:2454:ff1f:b240:886b:1a3a:7569:3d95])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3680d9771aasm6369201f8f.0.2024.07.15.05.16.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jul 2024 05:16:05 -0700 (PDT)
From: Stephan Gerhold <stephan.gerhold@linaro.org>
Date: Mon, 15 Jul 2024 14:15:37 +0200
Subject: [PATCH v2 1/4] dt-bindings: display: panel: samsung,atna33xc20:
 Document ATNA45AF01
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240715-x1e80100-crd-backlight-v2-1-31b7f2f658a3@linaro.org>
References: <20240715-x1e80100-crd-backlight-v2-0-31b7f2f658a3@linaro.org>
In-Reply-To: <20240715-x1e80100-crd-backlight-v2-0-31b7f2f658a3@linaro.org>
To: Neil Armstrong <neil.armstrong@linaro.org>, 
 Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>
Cc: Jessica Zhang <quic_jesszhan@quicinc.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Douglas Anderson <dianders@chromium.org>, dri-devel@lists.freedesktop.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, Abel Vesa <abel.vesa@linaro.org>, 
 Johan Hovold <johan@kernel.org>
X-Mailer: b4 0.13.0

The Samsung ATNA45AF01 panel is an AMOLED eDP panel that has backlight
control over the DP AUX channel. While it works almost correctly with the
generic "edp-panel" compatible, the backlight needs special handling to
work correctly. It is similar to the existing ATNA33XC20 panel, just with
a larger resolution and size.

Add a new "samsung,atna45af01" compatible to describe this panel in the DT.
Use the existing "samsung,atna33xc20" as fallback compatible since existing
drivers should work as-is, given that resolution and size are discoverable
through the eDP link.

Signed-off-by: Stephan Gerhold <stephan.gerhold@linaro.org>
---
 .../devicetree/bindings/display/panel/samsung,atna33xc20.yaml     | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/display/panel/samsung,atna33xc20.yaml b/Documentation/devicetree/bindings/display/panel/samsung,atna33xc20.yaml
index 765ca155c83a..5192c93fbd67 100644
--- a/Documentation/devicetree/bindings/display/panel/samsung,atna33xc20.yaml
+++ b/Documentation/devicetree/bindings/display/panel/samsung,atna33xc20.yaml
@@ -14,7 +14,13 @@ allOf:
 
 properties:
   compatible:
-    const: samsung,atna33xc20
+    oneOf:
+      # Samsung 13.3" FHD (1920x1080 pixels) eDP AMOLED panel
+      - const: samsung,atna33xc20
+      # Samsung 14.5" WQXGA+ (2880x1800 pixels) eDP AMOLED panel
+      - items:
+          - const: samsung,atna45af01
+          - const: samsung,atna33xc20
 
   enable-gpios: true
   port: true

-- 
2.44.1


