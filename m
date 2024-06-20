Return-Path: <linux-kernel+bounces-222394-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47F799100C1
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 11:48:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA9D2283FAE
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 09:48:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAF751AAE0C;
	Thu, 20 Jun 2024 09:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="R07gqTv3"
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E39381A8C32
	for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2024 09:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718876880; cv=none; b=QEDdxmcEz/I4OuOOHRBmgWWNQTSgXw/bM61mO20ZwYzowZQCaNwesrecBcrI/SU8XOxoqKZnoIdIBO9V6dEQySiHsCCdNmsz06pLQ6Zvr2eEvUIqgL239dAduXw3LTCh2F4ov9et+tndfvkMr3DPcndKN05Lr0ppmAGf/sb41Ds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718876880; c=relaxed/simple;
	bh=QY/fE1vMgobk6BJWDBwWQ56ykc1bAz6OcQGPar4E5Io=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VnvaQOceliUmbKfGDDin2kns5UFeHv+Z6zrZuoyOCDlwYtq38K7Ml2eHyBgZO/UJ36hKPiV262BnPv8YeNarVLsPYIHY0r/fSF9BIQjIzyIJVUWhFYuNJ3qEnNbaNOrVQgjU+5Rl5Yc+EmxqKpeNWXpTQx8drfK7aDRFs6Sc2GY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=R07gqTv3; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-70623ec42c2so566779b3a.0
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2024 02:47:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1718876878; x=1719481678; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m1iA/zvEiFStBDAQUtTcnVMjUIjY5Wwj1aHdUMEw364=;
        b=R07gqTv3FbypFtcsjAm9ut7TeY1JRtKNHqhF1dF5W60HJhVWtEaL2qw1eLsW9CXDuK
         LGVyPdmXTxuAvd+nf4RGNuQEyTo7kIftZ3OrXqmtHrkJBdv10JGFK584MR5q+OvAL5AI
         QCaO6QjJnAacNx/bgoSgCyo9R3TihtenSD61o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718876878; x=1719481678;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m1iA/zvEiFStBDAQUtTcnVMjUIjY5Wwj1aHdUMEw364=;
        b=pg7fHZ2PCW1bNnDCQwSo4XPPfY0LAX1H/Nfw4XR6URA/VLXtQzD4BzwjXVXw1ChJmX
         EdgxoAfxJy1M1OAe7FmQBplpZxhu3/6Hmwp5TV+dMw9VVuYLQin1x5QC/ZULJnalaqJD
         jTnJurEwB31X4pJnoZDd1aVxredfe+l/jfIX2qlCSEl8WDhllUlk364avdZyf6Uc2BaA
         bOEtyurUyKhzemqITUQ+81lrSofm+t/NULTtOTe5E2soszbuGO9tczLWTznT7VBgMT1q
         ej3a5c3PItn8Ls9P+9M+OwojYresPwEa6BnX6yL0I3X6Xh0CUrz8qGPHj9bjtitK9CC9
         vWDg==
X-Forwarded-Encrypted: i=1; AJvYcCWg0S2WZpYM4UL7F2G82QJ6gn8Fc6PKM/ygpSleal6STlAd3xkiFG7VzY9lJWMevtGr4DJM2YcihU7ux4CxxHizkMvqIYodpPOC5mdV
X-Gm-Message-State: AOJu0YyHLofgl6rGfTKxyv+x4kchxMhYs1woSQiwq3cvgy7Ppt5fqxpN
	2zpQRldvKm4HDQ9AyKIZ3k1Le+hKnBUxgfyXw74Dw5iJCy0QDndO+/q9cL9huA==
X-Google-Smtp-Source: AGHT+IEbLm6UkzausNcxJ9iowsJM7AcH7c4cGUtul3KvHm8nPFGfqXBgRBs6sehTiRsxZ7Zo1TrDRQ==
X-Received: by 2002:aa7:9ddc:0:b0:704:229e:54bd with SMTP id d2e1a72fcca58-70628fa93eamr6460287b3a.8.1718876878161;
        Thu, 20 Jun 2024 02:47:58 -0700 (PDT)
Received: from wenstp920.tpe.corp.google.com ([2401:fa00:1:10:c53a:5326:7f72:759f])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-70dbae52920sm4164469a12.42.2024.06.20.02.47.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jun 2024 02:47:57 -0700 (PDT)
From: Chen-Yu Tsai <wenst@chromium.org>
To: Mark Brown <broonie@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Hsin-Hsiung Wang <hsin-hsiung.wang@mediatek.com>
Cc: Chen-Yu Tsai <wenst@chromium.org>,
	devicetree@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] dt-bindings: arm: mediatek: Add MT8186 Voltorb Chromebooks
Date: Thu, 20 Jun 2024 17:47:37 +0800
Message-ID: <20240620094746.2404753-3-wenst@chromium.org>
X-Mailer: git-send-email 2.45.2.741.gdbec12cfda-goog
In-Reply-To: <20240620094746.2404753-1-wenst@chromium.org>
References: <20240620094746.2404753-1-wenst@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add an entry for the MT8186 based Voltorb Chromebooks, also known as the
Acer Chromebook 311 (C723/C723T). The device is a clamshell style laptop
with an optional touchscreen.

Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
---
 Documentation/devicetree/bindings/arm/mediatek.yaml | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/mediatek.yaml b/Documentation/devicetree/bindings/arm/mediatek.yaml
index b1b09db0bd65..e7746afeb0b3 100644
--- a/Documentation/devicetree/bindings/arm/mediatek.yaml
+++ b/Documentation/devicetree/bindings/arm/mediatek.yaml
@@ -301,6 +301,13 @@ properties:
           - const: google,tentacruel-sku327683
           - const: google,tentacruel
           - const: mediatek,mt8186
+      - description: Google Voltorb (Acer Chromebook 311 C723/C732T)
+        items:
+          - enum:
+              - google,voltorb-sku589824
+              - google,voltorb-sku589825
+          - const: google,voltorb
+          - const: mediatek,mt8186
       - items:
           - enum:
               - mediatek,mt8186-evb
-- 
2.45.2.741.gdbec12cfda-goog


