Return-Path: <linux-kernel+bounces-426860-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E0E4E9DF980
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 04:22:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5CEF4B22625
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 03:21:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD3B21E2823;
	Mon,  2 Dec 2024 03:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=huaqin-corp-partner-google-com.20230601.gappssmtp.com header.i=@huaqin-corp-partner-google-com.20230601.gappssmtp.com header.b="bd67FZgt"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2049E1E2831
	for <linux-kernel@vger.kernel.org>; Mon,  2 Dec 2024 03:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733109703; cv=none; b=U4UGvyBdDFs9lLyVw6+k2ZzmYwcBtTwt57uX6gwRseJeQDmwJ6xZ85lRZ7IIFEmpIy7I1IOiTNSP3No4zuCmuaDLPmd7UwwaFf9jYRAlBRXNI+T0koUVy0nI44+miBVx9e8bm1nfcQ4roVBbug26mW7OoKSDKeuJf3NdI3idxS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733109703; c=relaxed/simple;
	bh=19k00t3bhSauQp6R24aL1bW0bHM8u7tNAtzDOGnrjIA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=VxrBwhg7kGq1QmqR37N/z3JxhEWc4IYMeIufUdxxmaoIXRje5HrRtwcWfBS+DqzlvDJc6BKvsbvKSoo4NFNdqYij4Ppa+9PEUTn1vfav7kP2F2S0EsWbS7m0qW8muUjhvpBLKYeQyg9TLW1fa2Z7Thnno2zc2yHbsivkm7iuGPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=huaqin.corp-partner.google.com; spf=pass smtp.mailfrom=huaqin.corp-partner.google.com; dkim=pass (2048-bit key) header.d=huaqin-corp-partner-google-com.20230601.gappssmtp.com header.i=@huaqin-corp-partner-google-com.20230601.gappssmtp.com header.b=bd67FZgt; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=huaqin.corp-partner.google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaqin.corp-partner.google.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-21571559c05so616195ad.2
        for <linux-kernel@vger.kernel.org>; Sun, 01 Dec 2024 19:21:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=huaqin-corp-partner-google-com.20230601.gappssmtp.com; s=20230601; t=1733109696; x=1733714496; darn=vger.kernel.org;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=LwpNUnjMlFvYQmQxOKj3RBcYwjK66Q7pEDvGTCX7zBM=;
        b=bd67FZgtAosiN5zyQUj3fgGBqmDkRD/fCSP7ylltYe5uuGg63PbRc4J8nMRohuwQFy
         Gjgd6Eb6wAl/N9rtMFyn5NeqNTKYUdn8D4om/40PBPMaVoJsjB7jt5B2NJNB2Zi3aNQe
         1zS7ScHCWZsHDS8tlzeGg+PJp9BOEWs1z1bzhoggeWxb2F3eXCrEz2S8e6L3Z8aRQhnS
         gJICYPUBWpReqwYU6yvVNGdsAqm9s04nZPu7uLgTxYsIANN1EVRBdDRaiXgrA05FOPUg
         iIzKrIMnhFvv9eX35gfXLQlQ1/OWabzHxbzFsEcaohlew5YLmpb8u/2Ey5uqmVNpKhaf
         NiRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733109696; x=1733714496;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LwpNUnjMlFvYQmQxOKj3RBcYwjK66Q7pEDvGTCX7zBM=;
        b=GHriZZQi/TEvCjTNYjsv78sDwTfas9arsmiT93pZuXEP7scfBHHHsKsbN5HwoPyo/R
         3YEoTnkSo9lmPH9VSrSKRviY1g8IrlwGprkddo4unnu/qcfQDhornFIK9ImvWo07qtAP
         Nx8hUe5l5ZVUQrAkhl1eeLt77uhSK5lftjMcK4yB6bW4X2F7i7ZrBl2KkUjlYtNpnhrD
         UdXowY4n87g6rxuT8Phn49vJTfbGSWZ7tssSVF2YhORf8Gdri31Q3nusFePZZs9R7jIa
         mj4SUxuiaRNaceCMHnhPfPQNjufK0GFBilSMLjeYWpZVM08gEqUJbKzksaIpK/5kC+Y2
         Fe0g==
X-Forwarded-Encrypted: i=1; AJvYcCXfp3OqgEdM9PqxrKZm9gvHYZBZiNY8vhPgmH+GYJIo1+h+48heEnd/I6zXhtrJfbAKhtKB4JkavTVDUWc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwH36eEsdLPLw4m9cHVnbJPyyyQmdd5vvQ39MMdFqD/2mSYp2Uh
	YCWVS4x8g68XB7sXznrS+0235xEwvXlZm5zm9eonfcnF+5al/WZFP8Qo3ecJO3o=
X-Gm-Gg: ASbGncu+ZmRqUvr3oI6jjYOlMCOxlZHW09NQ7tPA1Y6BSDiGSCCOgVBn2L+Di6eBOJl
	+h7/ChQVeeXJNoZEjvYH/yQuFPleU7tCimUbQJOss3SOXwHc6UvCQvDX1uPBt1ovBuDr1OcWEde
	ER/3qwMkN7WiGWZm809HD2qQgt1lZ7ny6aGqFy2ZpYLkgLYjdvqFL5riOQoXAl37rjWP/63jFE3
	QQMJFji8IIdOZDb9R5csnU4djB7ajSMVGiuAxFon9czLAHkysvKD7uPyMv0bVzAM02InawweTDk
	PBhmGhDE6X6Bxg==
X-Google-Smtp-Source: AGHT+IEJN88pnwqqXHYSIyic7eyBMjw0obUFHPnwV3eN7HNKvCq55lxxoodclMDswm8TKyzGp9aVVQ==
X-Received: by 2002:a17:902:edd0:b0:215:435d:b41a with SMTP id d9443c01a7336-215435db4a5mr63665425ad.1.1733109696542;
        Sun, 01 Dec 2024 19:21:36 -0800 (PST)
Received: from ubuntu.huaqin.com ([116.66.212.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21521986004sm66305725ad.184.2024.12.01.19.21.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Dec 2024 19:21:36 -0800 (PST)
From: Zhengqiao Xia <xiazhengqiao@huaqin.corp-partner.google.com>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com,
	wenst@chromium.org,
	hsinyi@chromium.org,
	sean.wang@mediatek.com,
	dianders@google.com
Cc: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	Zhengqiao Xia <xiazhengqiao@huaqin.corp-partner.google.com>
Subject: [PATCH v4 4/4] arm64: dts: mediatek: Modify audio codec name for pmic
Date: Mon,  2 Dec 2024 11:20:35 +0800
Message-Id: <20241202032035.29045-5-xiazhengqiao@huaqin.corp-partner.google.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20241202032035.29045-1-xiazhengqiao@huaqin.corp-partner.google.com>
References: <20241202032035.29045-1-xiazhengqiao@huaqin.corp-partner.google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

change `codec` in pmic (in mt8186-corsola.dtsi) to `audio-codec`

Signed-off-by: Zhengqiao Xia <xiazhengqiao@huaqin.corp-partner.google.com>
---
 arch/arm64/boot/dts/mediatek/mt8186-corsola.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/mediatek/mt8186-corsola.dtsi b/arch/arm64/boot/dts/mediatek/mt8186-corsola.dtsi
index e324e3fd347e..cebb134331fb 100644
--- a/arch/arm64/boot/dts/mediatek/mt8186-corsola.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8186-corsola.dtsi
@@ -1276,7 +1276,7 @@
 		interrupts-extended = <&pio 201 IRQ_TYPE_LEVEL_HIGH>;
 		#interrupt-cells = <2>;
 
-		mt6366codec: codec {
+		mt6366codec: audio-codec {
 			compatible = "mediatek,mt6366-sound", "mediatek,mt6358-sound";
 			Avdd-supply = <&mt6366_vaud28_reg>;
 			mediatek,dmic-mode = <1>; /* one-wire */
-- 
2.17.1


