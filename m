Return-Path: <linux-kernel+bounces-554402-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E8EEA59745
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 15:15:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6DC0F166AEB
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 14:15:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D69EB22B5B6;
	Mon, 10 Mar 2025 14:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="of9/8G05"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6779722CBE9
	for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 14:15:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741616121; cv=none; b=b71pGlUasGKEJ9IQpcXJZoC8x0Z6ldQyUpohswEJuVEt6FX54rEQZpup9ObQH0chlvg43/EOfN+BGQy+Q6FeaNySVpnvp5ytFVw8OVTWZap2ZAvn1Zvw31tUD4Pido1pFSJHvEs+qtGkgz7TjnVLgM/TO/08MaO15aeribs6qtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741616121; c=relaxed/simple;
	bh=VEQ4+hEeDHQ0ccw84pNvHcnSY7FOHv7KlXvL5LFijkY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Fohf8FIPf2OoEqZRLqmT2O2XinwPjzIVvrVaqTUhCup5GSUID+a3a6eXlrShKilFD7zgAtxLSvQm4qvpVNRgqiJVe4KPx1M10uY668Ow4sps2VG9gGTQm/23/Ww0B8sHM4OrLRynq0tYJcX9c6FQWTLr0xcOMjf3G3av8T8Oyug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=of9/8G05; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4394036c0efso24480585e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 07:15:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741616118; x=1742220918; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Bmb5F0W6Z7jeeDJaB9XNcpqLpScSh5IgdYNKbsZAHXk=;
        b=of9/8G05eoTWP0n1P7No18h6mnOnOt6ib1x0GgJsWjwnrO7rI0pguTogo1gu++Kv+5
         9k8LvoZVIJGtPjb98xPj0H6fgfo5/B3jA3GTu+1AoPyBNJRXWY0mh6OanUKVwiFwr5CL
         cYWBZSW7H3OtymaTs+gL3BovQePuUlUm1rq/aqHgYYYBCzHmDlzNcJ2uwFrBbnI6e0Ee
         vsSGXnk1/+Fi2Ti5iAvptxY42l3DsOTcKIcLRXKbX5Cy1Kn4iHAZFzq6707cAZhVE+gq
         ykO5ex/HPMbp19nRzydbX4iJKcHbf3mBsmKaySK8ku1lTlNawwuGWVcvdFHlhRnZ7N01
         0/Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741616118; x=1742220918;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Bmb5F0W6Z7jeeDJaB9XNcpqLpScSh5IgdYNKbsZAHXk=;
        b=NcJY87R7g4t97X8ZSiuuPN2kmIGpG4f4Cdd9dtIFmBx93EOikJNUdUA2CSL5LqKPn8
         2t3+jtEToUvuB8wu8QX887gCk4T4UTb8qIX7IWeiw8G9fd2w+YI18E9QYZgMqDaL0U57
         q3ahBgiUhs4AYzkMBfy491SsJ7zzdq4VQOghoHGfOsKOT99ZjOzWyAkLnBl6o3yBwjFJ
         wHMdfBK1CuUCAyC/H5MaE3TkZ3bpEdHmOCEKzMldHUZHEa+0hR0BzCU4ygYX+Wri/Xyk
         Tyif/5CrvD7VdAI1WMA5sq9KMzLgGM8MMqfPpDjlyZu8qoVXHVoOMfGAZIWl4aDn0Lh6
         bUlQ==
X-Forwarded-Encrypted: i=1; AJvYcCUT9pKKpJJZGS35e/4JPbPaXouxQqP7i/TMmWXtEThH0ogGI+dMvev0o+sl/IszAonc1Cg5IHoAwru/SQ0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5Dopyz0sWkBpbjEBHmM5YGrD5+btwRE1UwN1fwxtlYUPsceYO
	jts4TMpL9t+MbswGXffX+3nYteLnHH/RlXd3RuQlft3ye/t25V+QZi5KTUauqlw=
X-Gm-Gg: ASbGnctT2hRFu6KWmo1LgSNvrxhiC2MxzDI9Cv4hm9shjE6i/Edzh1Nr9tyJLPFFfZM
	4uOdFnN46R+A3VCEeuDb39/pWc4YH20tRa2gDTSNHGq3LrvmpU8gEzoDthpiyKom19TF5R1/4vi
	h3NJjXwvKmM3KnJHRGmhBHCiDZokaNDvzmAT+N6GY9vgwEQr42IT2hae7kaad6hB+m1doy4sshy
	FBFhorFWk9/6PI37UrC8Ll6a5Rf7JGS4FqXeJGtqpOQLS77cMByRd+S+SqNJ7nw4zkwlfXRGjvA
	nBRj7Nccy4Nat1p1GP3zxxjDOkq73MAfFFdaG/y2x+HUGagC4RZBDg==
X-Google-Smtp-Source: AGHT+IF6nMeJGjQ3VoeuLz0WsGtCfmOBe+MhQFbZffoJpmsn4bCNhptkAG0B7rxQUATmUtt6M9GZBA==
X-Received: by 2002:a05:600c:154d:b0:43d:160:cd97 with SMTP id 5b1f17b1804b1-43d0160cfb3mr1473885e9.25.1741616117589;
        Mon, 10 Mar 2025 07:15:17 -0700 (PDT)
Received: from hackbox.lan ([62.231.96.41])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43bdd8da097sm149824545e9.17.2025.03.10.07.15.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Mar 2025 07:15:17 -0700 (PDT)
From: Abel Vesa <abel.vesa@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: Johan Hovold <johan@kernel.org>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Sebastian Reichel <sre@kernel.org>
Subject: [PATCH v2 1/3] dt-bindings: arm: qcom: Document Lenovo ThinkPad T14s Gen 6 LCD and OLED
Date: Mon, 10 Mar 2025 16:15:02 +0200
Message-Id: <20250310141504.3008517-2-abel.vesa@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250310141504.3008517-1-abel.vesa@linaro.org>
References: <20250310141504.3008517-1-abel.vesa@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Due to the difference in how the panel backlight is being handled
between the OLED variant and LCD one, it is required to have two
separate DTBs.

So document the compatible string for both the OLED and LCD variants.

Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
---
 Documentation/devicetree/bindings/arm/qcom.yaml | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/arm/qcom.yaml b/Documentation/devicetree/bindings/arm/qcom.yaml
index 618a87693ac1..6260839fe972 100644
--- a/Documentation/devicetree/bindings/arm/qcom.yaml
+++ b/Documentation/devicetree/bindings/arm/qcom.yaml
@@ -1123,7 +1123,9 @@ properties:
 
       - items:
           - enum:
-              - lenovo,thinkpad-t14s
+              - lenovo,thinkpad-t14s-lcd
+              - lenovo,thinkpad-t14s-oled
+          - const: lenovo,thinkpad-t14s
           - const: qcom,x1e78100
           - const: qcom,x1e80100
 
-- 
2.34.1


