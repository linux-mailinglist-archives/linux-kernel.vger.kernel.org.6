Return-Path: <linux-kernel+bounces-407225-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BE4D9C6A75
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 09:17:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2BA182824D6
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 08:17:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F28C17837A;
	Wed, 13 Nov 2024 08:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="gqBl6l7S"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49028170A03
	for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 08:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731485818; cv=none; b=SOSOD2mJM7m+rKu8AqErpOfOlbY/Ri9B9WJgf/kJ+2+5jc4f2L4rhmLddxhyhBuPLfBzhIy2BEkDnqX9w9alh6dMr+iXhHB5hj/kC9u+EsDgz8CDMwZK1Dy2ahqoBbhbnLcrg5NJCPHDId9kI/9/WB79zSRDk/0Z91zV8A4eyls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731485818; c=relaxed/simple;
	bh=D+a0/HfZ9qQqRQETejI0cSOgKGfAeKoNtsNvnoEUGRo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=eMMBh7m5XB9MGlrARRfkrSfsGu3cnE+Jodxv+flvyD7IQ0wT5wpWMc0GrVFcRqcX/XeQ3QtPxoOHReWeN7tl58nsLdd0tTtcGgaIB4+UGUdTHdvnxUuRgNG+qYcoVcHAi759ToSUPP5uXDYUW64GTI2vjNs6CXXzeXUXxKFiqoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=gqBl6l7S; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-20e6981ca77so76380705ad.2
        for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 00:16:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1731485816; x=1732090616; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=L/uGdh4k87UdLsVlqrkIfn4gIIwnutqsKO4ayJkibeU=;
        b=gqBl6l7Sz6CO6KlqYlppFZ0GwkAjjR9ZvN1AzIKJTmEbJ4wSfxsV132mXYiquUa+Xp
         msHa7xDyGerJbyZisMgQVPzRAHsPFgWju2b2E/Lrps77xu7zvWWxxklmouV7xrZFYa2j
         YnO8tqblhShgOZnmlGSj4T4H4aUAy1Uc0r3t8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731485816; x=1732090616;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=L/uGdh4k87UdLsVlqrkIfn4gIIwnutqsKO4ayJkibeU=;
        b=F7UF+yZSVhfWiE8ox0zE+iVHWh8E84eFcwsR6w5Ppv6u8lyhmhJ7jLg54FYA42S5Ni
         Mx9Gzi6AsrX/g42Yv1nmS5jq+CNBmZLpldI2uQfy/aLbAGjaT7NFAGKq8v+6/2k1w45Y
         KJh3wGFFe9AcJ7HDboNoA21ivrNgsuZg/4G35Q3m/2oMRkr0NDVzSHIdG92KisSQcFI0
         7EVOa0DW3mfAO+wE4yvyyq0JZ1mx5hBm5anf9m8xSTwwEqerDzO5pZBxWzEXOoOvCwwD
         d+PfG/XH45CqCTzdqjY9V9UreerReB/BeAoZAyvcNutAQR6RwMtLmJUu/ekjPXvz1EFx
         7xMw==
X-Forwarded-Encrypted: i=1; AJvYcCXBCqUsUm4xVjQpZNsYMQq+sccqW8OZR0RBbj87LIxJ9fVh2DVoCeQwcVNP6caImvI1JG+x1pMaJALexRc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/y79LSQ03Xu6fNTpt/q+swWvGry43wlA0KXSkF+fM8vp2MSjr
	sTk5LcfBHIwnum9iiMDbvkYi2tHE1SBpOJJQFeniU5BzyJRie21uz+6WLvBxjSMO0pfVcSA2BBs
	=
X-Google-Smtp-Source: AGHT+IHPhYwkzPsxjo/RCUL5hnCpKp45auPZIIYVaYgX0w4KzvUg5iggyNngj3Fzi9Z6NWyiw/1UDw==
X-Received: by 2002:a17:903:1ca:b0:20c:ce1f:13bd with SMTP id d9443c01a7336-211b5c3f07cmr20960895ad.18.1731485816613;
        Wed, 13 Nov 2024 00:16:56 -0800 (PST)
Received: from yuanhsinte-p620-1.tpe.corp.google.com ([2401:fa00:1:10:a280:b47c:f4f6:1c31])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21177e69029sm105462645ad.230.2024.11.13.00.16.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Nov 2024 00:16:56 -0800 (PST)
From: Hsin-Te Yuan <yuanhsinte@chromium.org>
Date: Wed, 13 Nov 2024 16:16:53 +0800
Subject: [PATCH RESEND v4] arm64: dts: mt8183: set DMIC one-wire mode on
 Damu
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241113-damu-v4-1-6911b69610dd@chromium.org>
X-B4-Tracking: v=1; b=H4sIAHRgNGcC/7WOuw7CMBAEfwW55pBfSWwqCmgpoEQUTnImLhIjB
 wwI5d8xKZAQNBSUe7qdnTvpMTjsyXxyJwGj653vUpDTCaka0x0QXJ0y4ZRLRqmG2rRnMMJyK2S
 hJNUkvR4DWncdMTuyWW1X6yXZp7sNvoVTE9C8IFQzCr5DuLiAEDkw4GUpaZ0ZUVm1qJrUced25
 sPhiW5cf/LhNgpGMQ68u0SREIxrWSlkueL6HfHUiPJbT6ZeoXRZsLLOM55/TP/1f/TKfvfaD8P
 wAFpDMEK2AQAA
X-Change-ID: 20241009-damu-a3f2f3478409
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Hsin-Yi Wang <hsinyi@chromium.org>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
 Hsin-Te Yuan <yuanhsinte@chromium.org>
X-Mailer: b4 0.15-dev-2a633

From: Hsin-Yi Wang <hsinyi@chromium.org>

Sets DMIC one-wire mode on Damu.

Fixes: cabc71b08eb5 ("arm64: dts: mt8183: Add kukui-jacuzzi-damu board")
Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Signed-off-by: Hsin-Te Yuan <yuanhsinte@chromium.org>
---
Changes in v4:
- Add Reviewed-by tag back, which is dropped in v3
- Link to v3: https://lore.kernel.org/r/20241009-damu-v3-1-1294c8e16829@chromium.org

Changes in v3:
- Add missing Sign-off-by tag
- Link to v2: https://lore.kernel.org/r/20240910-one-wire-v2-1-2bb40d5a3cf8@chromium.org

Changes in v2:
- Add fixes tag 
- Link to v1: https://lore.kernel.org/r/20240910-one-wire-v1-1-d25486a6ba6d@chromium.org
---
 arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-damu.dts | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-damu.dts b/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-damu.dts
index 0b45aee2e29953b6117b462034a00dff2596b9ff..06a689feff52945d141d196d439cba034f25fdf6 100644
--- a/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-damu.dts
+++ b/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-damu.dts
@@ -26,6 +26,10 @@ &touchscreen {
 	hid-descr-addr = <0x0001>;
 };
 
+&mt6358codec {
+	mediatek,dmic-mode = <1>; /* one-wire */
+};
+
 &qca_wifi {
 	qcom,ath10k-calibration-variant = "GO_DAMU";
 };

---
base-commit: 75b607fab38d149f232f01eae5e6392b394dd659
change-id: 20241009-damu-a3f2f3478409

Best regards,
-- 
Hsin-Te Yuan <yuanhsinte@chromium.org>


