Return-Path: <linux-kernel+bounces-322697-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F1C02972C78
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 10:48:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6F251B2328B
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 08:48:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE7E518787C;
	Tue, 10 Sep 2024 08:47:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="fVHXZSPS"
Received: from mail-il1-f181.google.com (mail-il1-f181.google.com [209.85.166.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01A3817DFFD
	for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2024 08:47:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725958071; cv=none; b=AwdEstNx7Xwn5P6R1y1KnxRH/eksL0xCwyaE8qlH5IUL6himVlUq57PMUXRVBF51NV1ej7xdZPY8VM4Q4WfQvi8fqDhCuD4BTFu4qJQXzyX/FKr8Cg+RlKJ68s6a2FYlSScrzbLz2cOcZZhrVuNdhiW6hEaFJ9HG5L//VDyQx+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725958071; c=relaxed/simple;
	bh=jHA0jeu39KXliSARGIHnAxhwXIadsXhXT0Q+hrmmgng=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=JNGh4lIpxFvHfbNzMBdvkYtwLMUde+2ej3Numpr73o51j50Hb88aZimdPZJQHhCaLNf99IOnrGwUO1BFxzGa4pFQrb01BDUmCh923NivquiBvtszIBCs/dhF51GejfjsSeBKSTaS1nlrUsGtjXbgSwkCXOJ7QJxMQP2zfwW5kyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=fVHXZSPS; arc=none smtp.client-ip=209.85.166.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-il1-f181.google.com with SMTP id e9e14a558f8ab-39d47a9ffd5so1769665ab.2
        for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2024 01:47:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1725958069; x=1726562869; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cBBzknlK+lLnrfwKbcqJfsrQ3C2pRWbeBhTXiYHvZyE=;
        b=fVHXZSPSFhKYYe3gtyoThElvELUXlaX1nQkqHGOVXkACrwR4sguPB8nX7bkFrZ1bwI
         a0/2NTx+8zHAwiKS4IPzWLrXklKTSn1f4ShhXq6kLnULbimH5X+ms8tUOWiCBTt/t1W5
         BPlXCDgN6ppwi0z2R/jaPC/9MgUEBmE+I6TyM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725958069; x=1726562869;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cBBzknlK+lLnrfwKbcqJfsrQ3C2pRWbeBhTXiYHvZyE=;
        b=kl8XfJnzNi5TaPVBv9LWeNGESvZsJA5Up6Hl53RBXVcO5bbCmGcxXaJXXXoWhu9MH3
         4vTTNv+6gqiQHRCV/mrkdzqkULFWZx8uGa3YSGeubZ2TWcmV5X2LA1f9EReFzxe/QFwP
         67uN3tzYGYsOlu2lcRCeKJNAAXtohnHYUN9eAppZP2CVXX7BAZoFspL4CHgJqpCqsB8C
         qBUVMmXQvABjgel3f4maPuxhZpyazpE0ERExealIp4hoa70GeLXZo4t5x1qyeEOFUt3n
         r3MqThHnI5O1qIlCQKe77ISU69qQBej/w1du61g1jYi/nAFzDrfPRQ9iRwh8MuPQDZf9
         M9kQ==
X-Forwarded-Encrypted: i=1; AJvYcCWhELFufrGw5REL9h6Ud5M7LLS8GiZjxe6WqgejX3ju219kQBmFgwb5Zz8RcpKdRX+X8GaBvCHarqU5nIU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxXYyangCnMbOIKCdCbx+vdPVpnPeffnPB5Yr/sUYEuMKi7mUGp
	7dSHLGSYc9T8onUPYpJCFoR3kqalFw2HoksDZwKybGtK/Li0BBdGnvJSRpDbAQ==
X-Google-Smtp-Source: AGHT+IFOVFWWzyNSgsRLILhNfgn8ya/XNChSnkapjK3BwdkIfk05bwfwygl28fTApbbAe6jPdsd0hQ==
X-Received: by 2002:a05:6e02:1d82:b0:3a0:4603:70df with SMTP id e9e14a558f8ab-3a04f07e7d9mr156667075ab.7.1725958068990;
        Tue, 10 Sep 2024 01:47:48 -0700 (PDT)
Received: from yuanhsinte.c.googlers.com (30.191.80.34.bc.googleusercontent.com. [34.80.191.30])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7d8b0fbffa0sm3931470a12.1.2024.09.10.01.47.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Sep 2024 01:47:48 -0700 (PDT)
From: Hsin-Te Yuan <yuanhsinte@chromium.org>
Date: Tue, 10 Sep 2024 08:47:44 +0000
Subject: [PATCH v2] arm64: dts: mt8183: set DMIC one-wire mode on Damu
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240910-one-wire-v2-1-2bb40d5a3cf8@chromium.org>
X-B4-Tracking: v=1; b=H4sIAK8H4GYC/23MQQ7CIBCF4as0sxYDWLG68h6mCwrTMosWMyhqG
 u4udu3yf3n5VkjIhAkuzQqMmRLFpYbeNeCCXSYU5GuDlrqVZyVFXFC8iFFoL8eTUgfvugHq/c4
 40nujbn3tQOkR+bPJWf3WP0hWQgmvj21nrBms8VcXOM70nPeRJ+hLKV+4ODgSowAAAA==
X-Change-ID: 20240910-one-wire-2d0f7113dc8b
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Hsin-Yi Wang <hsinyi@chromium.org>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
 Hsin-Te Yuan <yuanhsinte@chromium.org>
X-Mailer: b4 0.15-dev-7be4f

From: Hsin-Yi Wang <hsinyi@chromium.org>

Sets DMIC one-wire mode on Damu.

Fixes: cabc71b08eb5 ("arm64: dts: mt8183: Add kukui-jacuzzi-damu board")
Signed-off-by: Hsin-Te Yuan <yuanhsinte@chromium.org>
---
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
base-commit: da3ea35007d0af457a0afc87e84fddaebc4e0b63
change-id: 20240910-one-wire-2d0f7113dc8b

Best regards,
-- 
Hsin-Te Yuan <yuanhsinte@chromium.org>


