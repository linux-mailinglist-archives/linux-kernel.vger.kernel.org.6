Return-Path: <linux-kernel+bounces-320929-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A36D97122D
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 10:34:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EAF80B256EB
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 08:34:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03E511B1D5D;
	Mon,  9 Sep 2024 08:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Iftki4IG"
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F9CD1B14E6
	for <linux-kernel@vger.kernel.org>; Mon,  9 Sep 2024 08:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725870836; cv=none; b=Mg46qf/oSx4krSWFkWClCk6AJoU9aBhjBaF48rHJLNR/VBXxZlPtX+xzjmsNpbVN95yuLbM89MOysjmVPQA69pxWwz7V8JgFQMKTe7D9w0hwsozfgASrTiG9E3STdrXjSLdkJyqS1V9AnKgeIzbY/SMs2vfRr+XV3TulFcLZ9zQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725870836; c=relaxed/simple;
	bh=dcfEfTIMQ2Vid5OahAl2RhKSJJcvXQC7mZ7CoJUci1A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ohj7b0KuXLkZcda0ddSyW1e6cudBEg2jk/JrAFg/wWOpU7mc+dwDfptRCz4/C6bokHvC83TdXOQHDfbEtm7a4dQjXzGte17p54f+52EYSXBsNMYwFC8ddJgse2Kuej5N/KMazwbO4Kx0GHp/rCLTEsK9JTyGBdvp6UnCUtJiyTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Iftki4IG; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-718da0821cbso2085952b3a.0
        for <linux-kernel@vger.kernel.org>; Mon, 09 Sep 2024 01:33:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1725870834; x=1726475634; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BnbOR5uWec+V2/X2EWwVUqdGkzkWhl7Tog8N2YvY4R8=;
        b=Iftki4IGe68J62reR5qa5uUgBI4NOQa1aNRh+0nwwFaR4p5WUrQnqR8XFWQIQlh7IM
         1SS36QNc+1Y3E6QHvrM7GE/s5yViTxrlvp+kKPA61dT1F/5qB67l5zcbfjDV42LAM3c0
         MvX3s5AlMJgz1IUbW5j94Zstw9GmntMw1XYtY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725870834; x=1726475634;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BnbOR5uWec+V2/X2EWwVUqdGkzkWhl7Tog8N2YvY4R8=;
        b=goSylUOaKkc7g5cwiFO4tgygO7gZPE/VShDJNGSSycCBs626i2Fz1KAAeNRZ63KLkZ
         pezMJPISQsIgHTUynlKI4XivBtSroNKXzUBW0nS6LWO2xraGIrSdZDoNzPKtBEdphn0Z
         2IKvlNKnlWZ02iqJ3v4Uahdj9hYac50mJ+RdybeVd7bSlIHEqbrPfY0r/fnHlNYhDB/U
         Fl6gDYGdpMxxsxLkNvdfCJXF7LJUTGhe6O0JVWwdFyDMFpvy4RZnHOlhac7UJMeaoJnX
         ObPI2nRovUHEayvGwV6OxZgwKeB0gjqcsiAITmuJodkoQpTRySsoMuBC2m1lsnaKY9zv
         X9Xg==
X-Forwarded-Encrypted: i=1; AJvYcCVYCj699FI56eDk5GZTSJA3SLSrx3heE5AXEHVYog/Jp3sWcT0/jpl6tFHwND0JhgAXQ8+2jvTGESJpYhk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6VPKYahkLLgDtVPQ52YYOjeM2Ad1nezFwKOpoyRUMAPXLd3KT
	4zgzQny+kMxnnzeRMGQ2A3FF3mv2NRk6TtE1b4hbtG2s89tZS9JcwoZBgsRyfg==
X-Google-Smtp-Source: AGHT+IG/tKtFagM6enobYRRBn21Rin0SunUwGhn1lOEDrVWlTYwstGWs3keYdbE6jgCuB1tmhhttvQ==
X-Received: by 2002:a05:6a00:928d:b0:705:a13b:e740 with SMTP id d2e1a72fcca58-718e404bb29mr11530088b3a.19.1725870833999;
        Mon, 09 Sep 2024 01:33:53 -0700 (PDT)
Received: from yuanhsinte.c.googlers.com (30.191.80.34.bc.googleusercontent.com. [34.80.191.30])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-718e5982103sm3153558b3a.142.2024.09.09.01.33.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Sep 2024 01:33:53 -0700 (PDT)
From: Hsin-Te Yuan <yuanhsinte@chromium.org>
Date: Mon, 09 Sep 2024 08:33:46 +0000
Subject: [PATCH 1/2] arm64: dts: mt8183: krane: Fix the address of eeprom
 at i2c4
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240909-eeprom-v1-1-1ed2bc5064f4@chromium.org>
References: <20240909-eeprom-v1-0-1ed2bc5064f4@chromium.org>
In-Reply-To: <20240909-eeprom-v1-0-1ed2bc5064f4@chromium.org>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Enric Balletbo i Serra <eballetbo@kernel.org>, Ben Ho <Ben.Ho@mediatek.com>, 
 Hsin-Yi Wang <hsinyi@chromium.org>, Nicolas Boichat <drinkcat@chromium.org>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
 Hsin-Te Yuan <yuanhsinte@chromium.org>
X-Mailer: b4 0.15-dev-7be4f

The address of eeprom should be 50.

Fixes: cd894e274b74 ("arm64: dts: mt8183: Add krane-sku176 board")
Signed-off-by: Hsin-Te Yuan <yuanhsinte@chromium.org>
---
 arch/arm64/boot/dts/mediatek/mt8183-kukui-krane.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/mediatek/mt8183-kukui-krane.dtsi b/arch/arm64/boot/dts/mediatek/mt8183-kukui-krane.dtsi
index 0f5fa893a77426d50c293f780b75cacfe988d866..8b56b8564ed7a25c269f4231ddadf8621aec41d8 100644
--- a/arch/arm64/boot/dts/mediatek/mt8183-kukui-krane.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8183-kukui-krane.dtsi
@@ -88,9 +88,9 @@ &i2c4 {
 	clock-frequency = <400000>;
 	vbus-supply = <&mt6358_vcn18_reg>;
 
-	eeprom@54 {
+	eeprom@50 {
 		compatible = "atmel,24c32";
-		reg = <0x54>;
+		reg = <0x50>;
 		pagesize = <32>;
 		vcc-supply = <&mt6358_vcn18_reg>;
 	};

-- 
2.46.0.469.g59c65b2a67-goog


