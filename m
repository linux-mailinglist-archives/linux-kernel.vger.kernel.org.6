Return-Path: <linux-kernel+bounces-381164-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B4C09AFB77
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 09:48:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1108EB22F9F
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 07:48:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF3891BAEDC;
	Fri, 25 Oct 2024 07:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="WwYk1HBL"
Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 574AC18D64C
	for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 07:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729842533; cv=none; b=gHAfBAe50Z0jgniqUy5LzM1a9RFIvmHpS9vSZEQszdJXJDEIITnuEMu3T34qXMT3JIUvOa8A3ysj/Wkm5DiucV9/nWK8Mfj4yWkdgU4BOnZQIxS5xfsMp3DRwMUl8eoUf8JvxA8cOLyX6QpsYk6u8dvyx0uZc3AQPiLaDOWX7Kg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729842533; c=relaxed/simple;
	bh=AcKtayDA1l3B02uNLoEC1MG1LG4klFVt49WT24NvHCY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=b4LZblKhOJs37O3BUQHHdSzl26NCSIqVOlJrc/HH8/SPjhdjwrHDMauMz2KXBZprCHFd5QV0sV4GqjxXZM2Ud9hV9Q3QbNC08dCjyizBehmsylUqWBtLKtNLMnQrzAOWDB/v8MTuODPrmWs4JYdqF11MJIP1Cr2iW6RIpeiU3zM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=WwYk1HBL; arc=none smtp.client-ip=209.85.210.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-7180c7a4e02so1015789a34.0
        for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 00:48:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1729842530; x=1730447330; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=L/uGdh4k87UdLsVlqrkIfn4gIIwnutqsKO4ayJkibeU=;
        b=WwYk1HBLeEN4hAMyOoNLvJeqPSD+JEEKToBcuhbQLAvoeRKvY6W3DXFDVaq1P0skO2
         0uZ5jutFaH1T+O8ADF+Gb3tWJ1dAc9TMmhvIAhJywwHNV6aqeZpn2LKAv9teia0CZXQl
         5iYw6aEZFpoQ5LqKhUk8RRDjJu/bujDzYaV6U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729842530; x=1730447330;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=L/uGdh4k87UdLsVlqrkIfn4gIIwnutqsKO4ayJkibeU=;
        b=GWl5Zom+595/MwHndC/Lrd0FFvgkkOHOB9PQ9SyI8NQkQUN2FYiRyA3PIJVJHRdnDL
         l0j5v8ZKQdoenrxLOAbsIuLcP02pKkZsWyKTZgQfz20boqs5SWKyzxSue9fapGScC0wl
         mJMjij9jYrOaTNW4J+Q739AtfuGHyci/xTVM0+P6yg3rWcO4Yg0wJx6M43/tqrt/ODYr
         geOzNItg6q+fbokrcp7LNR5PplUAYiN4xucx8bpY5/ye6V1leUZkPWevzX8Qi5Xab97t
         3oq43Xy10y3L4ZuO3GlCIftBP3g+wxpjOJYcfAPHhMDFf6juAuJiCZEuq7xegH5+F2se
         tPmg==
X-Forwarded-Encrypted: i=1; AJvYcCVH11IezwDOaub77iN6arlwxZcgUHCc/XPGZZxVYbo9Sc5EmbTYH66+bd9NhooqefHe8pNcdQlVrRD6Ehk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZEtcDbu9uIjicZ6mdDxA4pp3fO7uPdvJ9xNKPS8VygxrHNrkw
	3nXou3AHiqpE902FTaXvkhH5Hp9pQcrozIMQAPIvoDRHclnpbG4puUqK0F+3YA==
X-Google-Smtp-Source: AGHT+IGSIU/bFTwcE96kf/0wGJ0BJfJiuO8y8CrN5NyTUQ2vHijmdL2HboIEe85P5cA+/Hj/rUfY3A==
X-Received: by 2002:a05:6830:25c2:b0:718:1606:c2df with SMTP id 46e09a7af769-7185940f8e5mr3286435a34.3.1729842530333;
        Fri, 25 Oct 2024 00:48:50 -0700 (PDT)
Received: from yuanhsinte-p620-1.tpe.corp.google.com ([2401:fa00:1:10:5a9f:16cc:8d5a:55e5])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7205793189esm535527b3a.58.2024.10.25.00.48.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Oct 2024 00:48:49 -0700 (PDT)
From: Hsin-Te Yuan <yuanhsinte@chromium.org>
Date: Fri, 25 Oct 2024 15:48:44 +0800
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
Message-Id: <20241025-damu-v4-1-241bd9366c20@chromium.org>
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


