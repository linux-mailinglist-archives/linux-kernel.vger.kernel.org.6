Return-Path: <linux-kernel+bounces-430858-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93CF59E3697
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 10:29:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5478A281753
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 09:29:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A25E1ADFF8;
	Wed,  4 Dec 2024 09:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="HE0Lpkgo"
Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57D021AC8B8
	for <linux-kernel@vger.kernel.org>; Wed,  4 Dec 2024 09:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733304546; cv=none; b=nk3mGNYpgM8DPt62lHVVD5+t3UVVwkHp3Ejg7U1PP9GGsQcti9+f/fKt06Ye0Rl0PTOzlwLuGd1nH+7nCcAVmW6+ZT7N2G0HcSqvHvC3xeof+xdbcz6F+gVbouSD2d0TK3QwRBJMbjRJaAtbafRBypnq3B1f5ZGLmh0c8ev4X14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733304546; c=relaxed/simple;
	bh=BuT/7nos5URevs5nXU7ajsEIN7CIlXo3ltjg+xI8Y04=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=blqJGqsygpaw/ibwNOvs6kvZwu1ApSc+pI63uoRqx9u5GyD7ldO9brVDnbvrZIKS3znaRT0InGiHdIIrZkXQ8PZg3jA4SoeiVa4ESC3LjYE+HYuwEPkYblNA+AD7tSCnNLUY0Zf38wzJMag82+ndPwksuDl/hzmqz/FE/Xc0hFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=HE0Lpkgo; arc=none smtp.client-ip=209.85.210.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-71d5476ebb1so2992674a34.2
        for <linux-kernel@vger.kernel.org>; Wed, 04 Dec 2024 01:29:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1733304544; x=1733909344; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a3a2o2nbwJCPSnXwOfL4XIKrCkhJXnP+2FlXfd5kTMs=;
        b=HE0LpkgoVheOfstNCMMGYBGbRCebMj76iPNB4UbUQfuTpqfpSpblRueQcjNleZnWW3
         r4Ibbr6NyoetusNJX47Jw+MjfWMRgvorgBly0s4yRNXkIzw+B7z+5evqRlEoIxoSeTCf
         RIG6+m3heeDthOd1gWGcC4B78hICp80PGnn/w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733304544; x=1733909344;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a3a2o2nbwJCPSnXwOfL4XIKrCkhJXnP+2FlXfd5kTMs=;
        b=g1gbMo9T8mpZ336+OUouWidDvp7Kp2LzI31YfkncPaSkiKp7yXr8KV1SeQ+Kz/w0+6
         X1oqOJmyxwFDuch6lPVodhqmP9hd5BVgWOcZAbEEXOC8GKUCEt5ASa2NSsYDlGqRO18Y
         YxhlgycyExu5Xw8y8cr1HHKfDrH1VvISsh9jGSyXAHLN7ZVsWcGbhzfGcA/2CWFjAbNY
         1SlbHfYz4lp2wF8zW/h52frl3YJCIxWoXU3t17SnjEfnpivt3Kvt243NbfFScBG76+MQ
         +Z9LyaWDQJEi5GgGMw4NXASjs7j0pwiw9ecl/RwVgsHhVkgajL3N8IvL8bsINr4qHzEH
         Rzag==
X-Forwarded-Encrypted: i=1; AJvYcCXrhJISS7Kt1JGZwd336xY5xKBy+GsxLNpcwDObInnJIKZ3UnlUc+ORKHpCAX1Z1a3BiVmDDBqoltAYEPE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxOeg8DKEvIKiNxPNuM6RJF0FmS/MFAU9pRfIvcTeceZkUdQylg
	MOwxNnLPZWXcEoHmkYkJMk6SYOq7zMq18t2YwhXsQo0xeUUlIkT+vO0DPDry2Q==
X-Gm-Gg: ASbGncss1wNFTckyDDuE4YznOuo90KSg72oZRikGyDIfcbgucp+/YV1lepPr1UDmFev
	9G21T2kM0H/3qyUdmhwZxXwHEIW6aaSmNkSUsJCROdSt9StPq8Yn/+WqHUv4hS0tYA/ilNwTrXf
	WtPCEsFXTqvMKKg6YWbjQRQU6BnvdMFSJdrf6qcVRki3jqm0s25V+kZ3G4I0/ARBJGcetf3w2xO
	dtX7V/PQabBDaGhBWBcuAw47uGou0skUjBys7kY3lUhVR6LPiUFkcajxEnNzN1Hp/As
X-Google-Smtp-Source: AGHT+IG2OOr+DFMkoVU9c8r19W+ABIjfnQAct57iSGJbN6PcBsKoE81tPXls96jiKM1xKEyUQ5FchA==
X-Received: by 2002:a05:6830:2045:b0:71d:5b70:41bd with SMTP id 46e09a7af769-71dad610b0bmr5596609a34.12.1733304544427;
        Wed, 04 Dec 2024 01:29:04 -0800 (PST)
Received: from wenstp920.tpe.corp.google.com ([2401:fa00:1:10:2eb1:a68a:2625:b944])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7fc9c2d38dbsm11049024a12.15.2024.12.04.01.29.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Dec 2024 01:29:04 -0800 (PST)
From: Chen-Yu Tsai <wenst@chromium.org>
To: Chaotian Jing <chaotian.jing@mediatek.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Wenbin Mei <wenbin.mei@mediatek.com>
Cc: Chen-Yu Tsai <wenst@chromium.org>,
	linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	devicetree@vger.kernel.org,
	Frank Wunderlich <frank-w@public-files.de>,
	Andy-ld Lu <andy-ld.lu@mediatek.com>
Subject: [PATCH 1/2] dt-bindings: mmc: mtk-sd: Document compatibles that need two register ranges
Date: Wed,  4 Dec 2024 17:28:52 +0800
Message-ID: <20241204092855.1365638-2-wenst@chromium.org>
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
In-Reply-To: <20241204092855.1365638-1-wenst@chromium.org>
References: <20241204092855.1365638-1-wenst@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Besides the MT8183's MMC controller and all its compatible derivatives,
the recently added MT7986 and MT8196 also require two register ranges.
This is based on the actual device trees.

Properly enforce this in the binding.

Fixes: 4a8bd2b07d88 ("dt-bindings: mmc: mtk-sd: Add mt7988 SoC")
Fixes: 58927c9dc4ab ("dt-bindings: mmc: mtk-sd: Add support for MT8196")
Cc: Frank Wunderlich <frank-w@public-files.de>
Cc: Andy-ld Lu <andy-ld.lu@mediatek.com>
Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
---
 Documentation/devicetree/bindings/mmc/mtk-sd.yaml | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/mmc/mtk-sd.yaml b/Documentation/devicetree/bindings/mmc/mtk-sd.yaml
index f86ebd81f5a5..9ea035928563 100644
--- a/Documentation/devicetree/bindings/mmc/mtk-sd.yaml
+++ b/Documentation/devicetree/bindings/mmc/mtk-sd.yaml
@@ -235,11 +235,18 @@ allOf:
       properties:
         compatible:
           contains:
-            const: mediatek,mt8183-mmc
+            enum:
+              - mediatek,mt7986-mmc
+              - mediatek,mt8183-mmc
+              - mediatek,mt8196-mmc
     then:
       properties:
         reg:
           minItems: 2
+    else:
+      properties:
+        reg:
+          maxItems: 1
 
   - if:
       properties:
-- 
2.47.0.338.g60cca15819-goog


