Return-Path: <linux-kernel+bounces-357088-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB660996B5B
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 15:06:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BFD99B26F8E
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 13:06:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B0A719049B;
	Wed,  9 Oct 2024 13:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Eum7nEgA"
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24C931EA84
	for <linux-kernel@vger.kernel.org>; Wed,  9 Oct 2024 13:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728479143; cv=none; b=qXepBtKmUFr5yib5oruybbHXN65KMQYMOLASdCgePf8Vc/fBWwfe6YwkIj6yrXFUHgW07bdU6QgzaDuf951znTjQHFyhKjAoP3KW4oz/7L9Xu7fU84nqm6LElyIm6wgIFgPT3BK2r2JA1ueMufAV0CuWsZ6jWRJnux5B7ySdjNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728479143; c=relaxed/simple;
	bh=D+a0/HfZ9qQqRQETejI0cSOgKGfAeKoNtsNvnoEUGRo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=FV7DXzH23j6IdgRrysKsZxNhvPsesG+6GcdDTDQb3SvhgZRGdVjBM7Hs3LZxVM26+hkhZURAyPpkhM45JtBqCz23qmJTAMXapPVloEKbgCb28BFwCnWxF9nYPn7UR0aI3fQgzbOi1Y83en7UxY1iAgy5NNJsW5oHGWWTh4j8zAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Eum7nEgA; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-2e221a7e7baso2685249a91.0
        for <linux-kernel@vger.kernel.org>; Wed, 09 Oct 2024 06:05:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1728479141; x=1729083941; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=L/uGdh4k87UdLsVlqrkIfn4gIIwnutqsKO4ayJkibeU=;
        b=Eum7nEgAO61IrI+bWSIvO23aRVQh6crdQM1VrRPuijsHhgF6czi603+Xo1s9tl593r
         PJYQfoRsNol0unSmNiKV94KXQ2uaM/vnEOhGhzc63529BjrXghLKFtpz/TpB6FIy+HVr
         AYM4Rtar5cqJqWAc8QBa32TjBzVtzNzabVIKo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728479141; x=1729083941;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=L/uGdh4k87UdLsVlqrkIfn4gIIwnutqsKO4ayJkibeU=;
        b=RVbhomZ29voe59IvrIbd7kawRZzrsFGYT124xTPwHCDoBofiM/hllNTMQybTRfyhsd
         /pWuw+SpSgXL5/Wv8kcaSUsRnccKQluij/XJKaXWSX8Fsh6ZwYXEB9FQlrmrMMApnbGk
         WTHqAm5TCSd3pez/7zepH8G17EtEL3Z4nDrk8JIX0zPegWxs2wocjmvK4zQyl9VZZvM8
         dsFeAy5KX7mfvywD7X1d3HvoZrENDoutRLW30QerJkUPjdmk4K3t9LJJzMQvC7Q+hr/i
         bK0rQ7zxZoedNZ5PVIVJ0jYOVEWEuVD3Kvnlp3uS3ZIhFuzNDPbOWSxfi6iDDuj14NKi
         Jswg==
X-Forwarded-Encrypted: i=1; AJvYcCWWhB6dw4b0mS5qE4Vr+tzr1CfoXmTsJtvn7DKeJi7JX1JSw1z17dzYAwIJRR8Tgep+0+PFQ4MBvw4tMWo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyTK63Bxp/CZCSQdDEw9ZcWbqsg0neUxBw4d64wIVdRAuPWNMZn
	emfxo9XLmEA8oXPuU7ZJJQYy6pto/lQZJ61zMERd4XhmdMYUvVlegj3Ji9UUhA==
X-Google-Smtp-Source: AGHT+IHzwKapyr5IrtSV/oQYAnR61TVG717Y8jfp24t1h7rKro/RA9ZWHLXInZS86oKuaEz5xT2XKQ==
X-Received: by 2002:a17:90a:a410:b0:2e2:ac13:6f7 with SMTP id 98e67ed59e1d1-2e2ac130994mr2132526a91.4.1728479141363;
        Wed, 09 Oct 2024 06:05:41 -0700 (PDT)
Received: from yuanhsinte-p620-1.tpe.corp.google.com ([2401:fa00:1:10:bfd7:eb4:8571:b3f4])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7e9f6c4adeasm7234252a12.84.2024.10.09.06.05.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Oct 2024 06:05:40 -0700 (PDT)
From: Hsin-Te Yuan <yuanhsinte@chromium.org>
Date: Wed, 09 Oct 2024 21:05:37 +0800
Subject: [PATCH v4] arm64: dts: mt8183: set DMIC one-wire mode on Damu
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241009-damu-v4-1-789b71bd6526@chromium.org>
X-B4-Tracking: v=1; b=H4sIAKF/BmcC/12Oyw6CMBQFf4V07TV9qdSV/2FYlHJLu4CaFqqG8
 O8WFia6nOScySwkYfSYyLVaSMTskw9jAXmoiHF67BF8V5hwyiWjVEGnhxm0sNwKeaklVaRMHxG
 tf+2ae1PYxjDA5CLq75kqRiGMCE8fETIHBrxtJe1OWhhb34wrHz8PxxD7Tel8mkJ872FZbOK/h
 iyKgnElTY3sXHP1q2jWdf0AJXpdJd4AAAA=
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


