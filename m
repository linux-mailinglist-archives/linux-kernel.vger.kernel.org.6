Return-Path: <linux-kernel+bounces-322488-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 82083972998
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 08:33:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2EA7A1F25BBA
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 06:33:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8815517A924;
	Tue, 10 Sep 2024 06:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Msr6ugtA"
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEC82136358
	for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2024 06:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725950021; cv=none; b=pzTWioOoFxdXt9Z7K62w5tvQYCqzAFlGCYHpORuzB+O8Rpg7W58cvPPe1nOXghSONPE/oqCBwGCPdFdN+W6wXRjwLsRtwXCxLQ6h5ODKCSt8H60+Z5Ombi8f2qLGnQib1/U7+XWF8A0g8VmbFE1EW+jZLsoxKAn213pK0IxDnJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725950021; c=relaxed/simple;
	bh=W36EA+8bHBy4oo5rtfqzvMSAIZHUyh8OsV37A6Esrug=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=GYZ7yq0STe4e3zMp5Z1qdQjvSLum2Q1RYf2pKV0SLpaNtxZOME12rIVsdMAZu0I/K00TZabk92iylt2Xpd3ISNMHW23G1yZzOT+1N1d+t6BnJfp+pto9Qkw449QgAxId336F7GKSnV+jmzCj+LGUC4CP+Q0cGpDN0R3cOBE8HtE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Msr6ugtA; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-7d4f8a1626cso4057013a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 09 Sep 2024 23:33:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1725950018; x=1726554818; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+/aJw7OF4dGO4YwB0NFwJSdiUCvGjw20wyqsbh56zsk=;
        b=Msr6ugtArhGoCU8pD3KzvRJjP9ImZoaCheH2l0nGFjDMg5zLw9f6xbok2k70tCVjDW
         ypab37o9y/1tFC2BjGzrm7SlSlEnAUhwhYAxXHZ3aynKGq0DFfknO5orYleOgfIJJeVT
         R8YqbXMML6A9kiP5f3PHrxYG+Nqqq8dVW3HgQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725950018; x=1726554818;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+/aJw7OF4dGO4YwB0NFwJSdiUCvGjw20wyqsbh56zsk=;
        b=dHQUvdr8qLfM5tXyT66ojq7OgyVqFz0iz7Ls0qbZzV9mvClTKWWBoY7oj/644kXHY9
         oFRhILGTsdKxLwI+lpp3FF8nLLyRGzDqqvn/LCPrFcQw5QH0GWeYfbj/MA1ImTRW3vaE
         G5zN9m2APvQOZIcpLFnIgq8LdhgcFD+6qrOzH1RamGLk1Dvc3JfuuN94V806QIuhyo7B
         vP+FN1aaHGz3ZhUuAmIXK22Pu5k0WJ9fSSEoZ2pZRG0AiUvP8vdm7LkCih+cBIHv8XEn
         uZh0lU+exB3BjimtE7Omae+m2V7c1msCsFnoLqEqs1hNe3PEbs/H9GYaCRnb/GU/rMJw
         gadA==
X-Forwarded-Encrypted: i=1; AJvYcCVh1j3FqUs9lku95XH8ZSc/jpmQG8LwuQRLPK0tg+ZgHFbOOzBQvOyzpJtQbsfwnl55QLTzTZqL0Sb4QHU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxXsZFmRFzKXrhnyQeCVuEcVhcP0j/G7SPhH0EuJPzIRSZnFaya
	GWYWvrNxsRgNuxdb0AKJYsAh0bYThaDIIha5/HVobp3A/ZT87K5a2Ln0bZY/zQ==
X-Google-Smtp-Source: AGHT+IHZAOmJi6NMS7af0hTyK5lmGDFP2TH09MXuOWEpUh2DhKcLpAp2eDRZDwrIT3I2ERS0dm+E9g==
X-Received: by 2002:a05:6a20:2d0a:b0:1cf:451f:4624 with SMTP id adf61e73a8af0-1cf451f4876mr6216404637.21.1725950018062;
        Mon, 09 Sep 2024 23:33:38 -0700 (PDT)
Received: from yuanhsinte.c.googlers.com (30.191.80.34.bc.googleusercontent.com. [34.80.191.30])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-719090c9b08sm696684b3a.207.2024.09.09.23.33.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Sep 2024 23:33:37 -0700 (PDT)
From: Hsin-Te Yuan <yuanhsinte@chromium.org>
Date: Tue, 10 Sep 2024 06:33:33 +0000
Subject: [PATCH] arm64: dts: mt8183: set DMIC one-wire mode on Damu
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240910-one-wire-v1-1-d25486a6ba6d@chromium.org>
X-B4-Tracking: v=1; b=H4sIADzo32YC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDS0MD3fy8VN3yzKJUXaMUgzRzQ0PjlGSLJCWg8oKi1LTMCrBR0bG1tQD
 hj87jWgAAAA==
X-Change-ID: 20240910-one-wire-2d0f7113dc8b
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
 Hsin-Yi Wang <hsinyi@chromium.org>, Hsin-Te Yuan <yuanhsinte@chromium.org>
X-Mailer: b4 0.15-dev-7be4f

From: Hsin-Yi Wang <hsinyi@chromium.org>

Sets DMIC one-wire mode on Damu.

Signed-off-by: Hsin-Te Yuan <yuanhsinte@chromium.org>
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
base-commit: da3ea35007d0af457a0afc87e84fddaebc4e0b63
change-id: 20240910-one-wire-2d0f7113dc8b

Best regards,
-- 
Hsin-Te Yuan <yuanhsinte@chromium.org>


