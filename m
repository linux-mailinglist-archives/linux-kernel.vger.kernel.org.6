Return-Path: <linux-kernel+bounces-575221-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E8EC0A6F49C
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 12:42:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9022216E3B9
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 11:42:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B13D2571D7;
	Tue, 25 Mar 2025 11:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sNiEq731"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9116A256C8C
	for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 11:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742902872; cv=none; b=TyPdZpoY/LJf1VeMVfgAYKOMPD4mOsVr2wgnJzijeUQC0KxMWDKZTlkB2CXHC31xQvIJwOprK5MGHwf+yyTYM90Z7IH6E0aCTE6zRyI7ZKUsysh6I0iBXfijbVTDMUWtIBZwO9+AWedUvQlFNMwOq9EQzQetlYqW41nJKZDWCAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742902872; c=relaxed/simple;
	bh=SaEurHg9my0SgGDfooWj4uP1HnHehhMQjbSphU85xtU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TXc6i1TrWYLmRJLKhiOSO6VyQP6E20be0y72oumqH79Qh5qypbIaaCgj56auB/d4Mzvvyr62qmnobknPmo5Fg6H7aB961zps0LyqmgEMdwUc9JxupH34Mz+dzKaz6EkfRBSLAQLWrynCQmjvjACe9NHalNuab+Rtm5+PPn9DjTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=sNiEq731; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-43948f77f1aso36455745e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 04:41:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1742902869; x=1743507669; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GZ6QvHirUebkLT0cLpo0Lkee0nQc81mUaPIyQl+HrrA=;
        b=sNiEq731KTmc1jjTcm9F7gE2NNji+grJtIKmNHJ32ZmXJLv/+37Ls9RS2WPCzmPXzz
         rxosFbjIq4Tt3l+HHYcXACz92l76Lc2zYqYZjs1GRYgqb5ubRUnjBkWJsdrAuCHZNN/t
         ItDoHUTRGt+azghgSgnlrabAk2ez4U1eg1CIprAAMlzJdaAo64IPldLV0YDotlUvWn/T
         /kCKnd7Zh2z+rBhmzwIaoy0bHQ4tPoKdTxeAqDM6OEDLLfaMfKQo78VgKrLiaegdWWO0
         yM0sBQn0REvebg6R5befbv3mpjUyC+6aWX6AvrUObxQ3X1cR42tEFVfn4Szz1JEV4YKx
         Jrlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742902869; x=1743507669;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GZ6QvHirUebkLT0cLpo0Lkee0nQc81mUaPIyQl+HrrA=;
        b=PQ8FlcnP2MTo7YugToTUrL8QBbCOJyIj/mx4IvgWWv1BpMQntuBfPQnjYPpD16swyO
         fxfBkGeiLBiqhal80oFx0DjWvTmrUovF/qKHcCu0n3hkPXnAhi9KcXUyTcfPl5CGB87U
         qFevIJkRN7uU2jxc1jMIy/VTolMONKcF+X78y/UcRQzJXN3ehAmy/a/MxYiU5zg9nuy1
         M7IYblGa6YoDleWGT7dk29HW5oSQLqjTe60O0eGp2auCLsJEZoFrWfpR91DJnPd075NY
         n9dJ29opZR1NeTfOnqpiYVJ6t0E6Rb9P/2ay7DxudINdVJprxQRhLedO8AXaaqnX0odu
         W6xw==
X-Forwarded-Encrypted: i=1; AJvYcCWhNBygw/fAoNrmvnMDdhX6g0ZQwFeAGBDf2uVeZ748Gl5IuexTyaxbXhzVc3dj6zyJfQ6Z+NOzI8N0Meo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwnpoMopAS2UIuuMoz3jrKHX1bnMhaq/36uubAiXt/I3zaCYOh0
	bgGUPorqd3SvzN1p2csVR1soXarRoaxyY2ehbI+79I+d7XMzLWeXFeLEEqQSIDU=
X-Gm-Gg: ASbGnctRvwTOco3tCLhTC3GKecpuH9lAv0e84ZfFEGYHjju4bDeNjbagStlV4+hbctk
	QFJkap/AEpXLQdVWX84InpQ2SwEZPMSB4GcgopGf/lCbv/KRyQX2X7Mteo1I6GFMLln/7XaGJoL
	YjkFAZcLdTfNanII8vKHKr/Vzc3LJ6FqF855peK1Y92eXGjgj1IjW+kvCoHzOSsMr7OdVyaeJCH
	IRhwD/zhm2+vUGyqnK9YxpYGG/WGr/a+hPDm+136ogajUtFiNjHUq916Oo6/+3vTRGE+8ukjsi3
	mPLflyF6Up40LwsXn3uRFtSfdB1XycbgTCs7agwo+PXXenL3KlGOSH3ImZ1/l5ue7bWVdg==
X-Google-Smtp-Source: AGHT+IF1Bqa+5FDwi9MVrJZo7CYKuUtOKzFgzROxuovQWzOm+8iaGpshZQMW9c6GASBDXYEB8yBJ5A==
X-Received: by 2002:a5d:5989:0:b0:390:fbcf:56be with SMTP id ffacd0b85a97d-3997f892973mr13392870f8f.0.1742902868882;
        Tue, 25 Mar 2025 04:41:08 -0700 (PDT)
Received: from localhost.localdomain ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3997f9a6326sm13213330f8f.29.2025.03.25.04.41.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Mar 2025 04:41:07 -0700 (PDT)
From: srinivas.kandagatla@linaro.org
To: peda@axentia.se,
	broonie@kernel.org,
	andersson@kernel.org,
	krzk+dt@kernel.org
Cc: ivprusov@salutedevices.com,
	luca.ceresoli@bootlin.com,
	zhoubinbin@loongson.cn,
	paulha@opensource.cirrus.com,
	lgirdwood@gmail.com,
	robh@kernel.org,
	conor+dt@kernel.org,
	konradybcio@kernel.org,
	perex@perex.cz,
	tiwai@suse.com,
	dmitry.baryshkov@oss.qualcomm.com,
	linux-sound@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	johan+linaro@kernel.org,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v5 4/6] ASoC: dt-bindings: wcd93xx: add bindings for audio mux controlling hp
Date: Tue, 25 Mar 2025 11:40:56 +0000
Message-Id: <20250325114058.12083-5-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250325114058.12083-1-srinivas.kandagatla@linaro.org>
References: <20250325114058.12083-1-srinivas.kandagatla@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

On some platforms to minimise pop and click during switching between
CTIA and OMTP headset an additional HiFi mux is used. Most common
case is that this switch is switched on by default, but on some
platforms this needs a regulator enable.

Move to using mux-controls so that both the gpio and regulators can be
driven correctly, rather than adding regulator handing in the codec.

This patch adds required bindings to add such mux controls.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 Documentation/devicetree/bindings/sound/qcom,wcd938x.yaml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/qcom,wcd938x.yaml b/Documentation/devicetree/bindings/sound/qcom,wcd938x.yaml
index 10531350c336..ab1c6285dbf8 100644
--- a/Documentation/devicetree/bindings/sound/qcom,wcd938x.yaml
+++ b/Documentation/devicetree/bindings/sound/qcom,wcd938x.yaml
@@ -23,9 +23,15 @@ properties:
       - qcom,wcd9380-codec
       - qcom,wcd9385-codec
 
+  mux-controls:
+    description: A reference to the audio mux switch for
+      switching CTIA/OMTP Headset types
+    maxItems: 1
+
   us-euro-gpios:
     description: GPIO spec for swapping gnd and mic segments
     maxItems: 1
+    deprecated: true
 
 required:
   - compatible
-- 
2.39.5


