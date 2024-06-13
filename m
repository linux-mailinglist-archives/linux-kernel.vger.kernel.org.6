Return-Path: <linux-kernel+bounces-213156-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 605EC906DB5
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 14:03:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F266528656C
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 12:03:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D20F1494A0;
	Thu, 13 Jun 2024 11:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="HL+k0z4+"
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87239148FFB
	for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 11:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718279946; cv=none; b=N2/snA9PgzNhsBL/2Ss6jikLkyTCI1Zw1AJtnt/c217jkqfDVtZ/E/WuCfaxtQOCNjlOz/Ghf3cqisFW8fVD05zMtl5iUpcSJAy6nrsl0ShyoeBS141Me2qen0QnpTw+I2aIW7YwWtX33sD2MhMfTADzDOnynypovHFm9xL6rhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718279946; c=relaxed/simple;
	bh=QoeL0Uj0afYO2p7SCp2cSVT0H+JsGuapBhibEmka1qA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=G/2Y3R7LRuMlgedYIrEdMdmtbD6RZuewMcIeROsfy4S06xnfpbw7oEgc0WbieeXC3ZSgf3OE3ordUHW48I6rbp25GXlDHXn5zT649BCVcyDeGE8AjOmO/1kQm3qaU979j0sr3qTrTXL2gII2aGODuFmXfkoaPftMV/6inEsuoP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=HL+k0z4+; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-6e3ff7c4cc8so649568a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 04:59:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1718279945; x=1718884745; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lFWI3DDItyQVutRiXO8RX6hmLD8qSv3rrOP6UnExo6o=;
        b=HL+k0z4+2vvV3+p1QKwaAtNp+r0tnSr5ZQlwD5xUmH3gxNbF//Ve4GuMfIYjHzS7pA
         JoAGXpjc++q5gumaAH350u5CLPUiMXToSRHXtu+HA+142FXtfTNiyp/Z7IKNsmHSI80B
         WQ2sXoP9AjD6L2Zc7Ovie++dhlzaOW3x7WpwU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718279945; x=1718884745;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lFWI3DDItyQVutRiXO8RX6hmLD8qSv3rrOP6UnExo6o=;
        b=Yis7o4/6SUHesC5p4wPzeD12d0WvsueFw4B1PpMu+RSp80X25DBJYsV84qlSSTQZUN
         km1dfm+p8zFAHmpDDwfNuvS2Pb0jUNdyzHbb5e4juctLXMoQZX90OJylNLxw3a3wDNcW
         yWoTyDCkHP0TXs+PqfgqDU/zo390F0P3fvblQ7YI9EHO1QYUr8Ekj5utgxm4m4KX3wb4
         pLySw9CMQzZ/IqCzVHceIrTVZ9prjOs4Vq5Fe+JJKSz4LzukIRUrlZU+vXCgQeB6g30/
         d5LF/wAnsgCsO+6ZiGPTG9lwAIzofxjoDsD2fFuau7kD8lgq8JXYvDE3nl6usO6MdZLM
         YQ2g==
X-Forwarded-Encrypted: i=1; AJvYcCWZxXtJmDJiya4Bd8UUoyXu7mAASkHfRjDLw9ywmK8kNkeWB/xhT+V9otzhlgDbdZtImIDxLwWs6DGGJ49oi6fLtxeAFf6OQ0aKoqSN
X-Gm-Message-State: AOJu0YxMRvNrIojHgYHazbEHusRCGsEzZFR6hWirYxtrImtOsY1nMplu
	j/j5VrvizYiWb+iZP7Ht/N74LM731czBlkibt2AvL6OgZJATNZzNue7kCJJ+9OarEALaPuzgGsM
	=
X-Google-Smtp-Source: AGHT+IHD/wwLAZVG66P7MmZbAQ5abkZDMU6aSnV1YmSQrBqnGyhFTlyZLbFUkzCum+77t6hfBH2SyA==
X-Received: by 2002:a17:90b:391:b0:2c1:9892:8fb with SMTP id 98e67ed59e1d1-2c4a760a325mr4845537a91.5.1718279944696;
        Thu, 13 Jun 2024 04:59:04 -0700 (PDT)
Received: from yuanhsinte.c.googlers.com (60.252.199.104.bc.googleusercontent.com. [104.199.252.60])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c4c466c3desm1453505a91.46.2024.06.13.04.59.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jun 2024 04:59:04 -0700 (PDT)
From: Hsin-Te Yuan <yuanhsinte@chromium.org>
Date: Thu, 13 Jun 2024 11:58:54 +0000
Subject: [PATCH v2 1/2] arm64: dts: mediatek: mt8183-kukui: Fix the value
 of `dlg,jack-det-rate` mismatch
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240613-jack-rate-v2-1-ebc5f9f37931@chromium.org>
References: <20240613-jack-rate-v2-0-ebc5f9f37931@chromium.org>
In-Reply-To: <20240613-jack-rate-v2-0-ebc5f9f37931@chromium.org>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Heiko Stuebner <heiko@sntech.de>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
 linux-rockchip@lists.infradead.org, Hsin-Te Yuan <yuanhsinte@chromium.org>
X-Mailer: b4 0.13.0

According to Documentation/devicetree/bindings/sound/dialog,da7219.yaml,
the value of `dlg,jack-det-rate` property should be "32_64" instead of
"32ms_64ms".

Fixes: dc0ff0fa3a9b ("ASoC: da7219: Add Jack insertion detection polarity")
Signed-off-by: Hsin-Te Yuan <yuanhsinte@chromium.org>
---
 arch/arm64/boot/dts/mediatek/mt8183-kukui-audio-da7219.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/mediatek/mt8183-kukui-audio-da7219.dtsi b/arch/arm64/boot/dts/mediatek/mt8183-kukui-audio-da7219.dtsi
index 8b57706ac814..586eee79c73c 100644
--- a/arch/arm64/boot/dts/mediatek/mt8183-kukui-audio-da7219.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8183-kukui-audio-da7219.dtsi
@@ -27,7 +27,7 @@ da7219_aad {
 			dlg,btn-cfg = <50>;
 			dlg,mic-det-thr = <500>;
 			dlg,jack-ins-deb = <20>;
-			dlg,jack-det-rate = "32ms_64ms";
+			dlg,jack-det-rate = "32_64";
 			dlg,jack-rem-deb = <1>;
 
 			dlg,a-d-btn-thr = <0xa>;

-- 
2.45.2.505.gda0bf45e8d-goog


