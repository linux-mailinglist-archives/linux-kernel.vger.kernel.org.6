Return-Path: <linux-kernel+bounces-444291-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 315759F0432
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 06:28:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 63764188AC7D
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 05:28:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BED318B499;
	Fri, 13 Dec 2024 05:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="bp2tVNku"
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0574979F5
	for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 05:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734067678; cv=none; b=T9njTHJaqPIjMgCAg0T1IeMWJ+N1n2rEllSWM4FgkYc6m3IkJU4rtT66qvhWJeMRPXpJK+rIVgjNioT0tnQtSESsgRbpKiozLFx2SL5FRFisieDw5BImeF2hwdlwxmIRAL4nzgFSJZjh78AJP1gCC+2ZSGWxdWLCStbgG2GQags=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734067678; c=relaxed/simple;
	bh=jMjWyG71NBdV/v7LoHgXhC3iazIf1/LR6gBvhVPK4n4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HEDuipMJtdfnvy0l6oXrBH2KFXeDfp+Z0kXqTJBiR8iDW1A7xmoYFVVPaLfeyfv1xnjiS7ZgEEuiqrGj3yDmQziooMuiVi90p5GYpne9rX/O8DQGm347JSBgwEvF1jmtJghr2ekTZXVs8XW9OD0/pm1nq6YakLkuUjYbuNnWoBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=bp2tVNku; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-728ea1e0bdbso1118382b3a.0
        for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 21:27:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1734067676; x=1734672476; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Y4GVLFVs9w1ID31bls4QxEe595eevO3e2bV1KeBxYl8=;
        b=bp2tVNkuXv7b1tIpn+B9n2AvQZcmD777MdxAYRZUp8eXS0cvy86wWy7yTYENl4G/5g
         L9pfBnlNmwzL4uGRmbSDUXmS08qQdvs6VpHLlkS3eM+c20JoavpkcI5FjEsR/RFpWDcn
         MQt167KKTbsdocEHF38FWcuxKZbsovqqy0ahQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734067676; x=1734672476;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y4GVLFVs9w1ID31bls4QxEe595eevO3e2bV1KeBxYl8=;
        b=QQ2FcbFGbaoDH6I/QtzSQ8Qug92SsHs/vGejrncDf2xs/2XhU6qZwRC219yobZksbT
         YB0MnKL3UzHs6D6WRE2DuOpBMiA84EueQdoOQ37uh1JaPmwSwVEVt7zzEgCZhE+18vea
         8mU5qAh1d8LWDiRdzHu8OBS8/OoX06S3f8WK9sqboz63at3yAGsTP1u1LS7M48oMWmHX
         Q8KbbfKwvXwu72BUFuAO3O41WlipTwQS0Q+PnwiDMdLuPmU9eRgRBqHaX/Laf0da2u5G
         /Og/TCzNZ+Lp1SIOu1hxigpNccnhjVDvpPC4H/IqF6mHOGyugq4SjoT3QR0OdppQnG0T
         0/Kw==
X-Forwarded-Encrypted: i=1; AJvYcCUEAi80USLXIKsareFKKhZZxdz99WvyAlw2rx8A0AbqWDd9ANVDy/bDkQSGiq+jdbF8oVMOdY8FjxyCzYE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxTSwhhKO+Kbvhkn1xMY2cxLjQ/rMHkhRaN7WQ/BkhE4YLG7pxY
	wBNFjWQ1eJeBl2COFlzDQp+r8yZZ4fKdW7BEYhkyy6f2I+R3Rq7CMmA5fEIV8JpnFqlV8wF6wGs
	=
X-Gm-Gg: ASbGnctdvBsT/IZRR5QfjSfDWYviqfmeKXj2ulPtAxSchLTlwaj7OtAJFNyPE+jLles
	LxVmLQxTSn9Zjmpn7wIntoAZ558yy0nQLL/FXzH3jBvqUzSnVSsujj3BJjx5owjzHMHrtZ7j5Rs
	wqSplBRF0Y0vz5rf2RYRws+eh8cEGi/f9A5ZqrVaoem/V7J82ll5f6TJZwto7FSKbYMCukWZsx3
	L+iCrAKqQXhe2M44mRGbU98UJVAP6xZlDMBn5jfaYET3fpyNapP4TDQsJGw5jyKAqWeNevkgIGV
	1jOUNm4ZTMG1DKnD/iNG6/qHX9ZHTd2jx2pAd0z8bIHPxJk=
X-Google-Smtp-Source: AGHT+IHal8NKejL0izByzIBf1fuwDy1PG2fbPNERA1Cbl9Yln/09XYoA7/+dew9qh4tY8eROOfTDpA==
X-Received: by 2002:a05:6a00:c96:b0:724:bf30:147d with SMTP id d2e1a72fcca58-7290c17f109mr1865316b3a.11.1734067676481;
        Thu, 12 Dec 2024 21:27:56 -0800 (PST)
Received: from yuanhsinte.c.googlers.com (176.220.194.35.bc.googleusercontent.com. [35.194.220.176])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7263803a805sm7386830b3a.14.2024.12.12.21.27.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Dec 2024 21:27:56 -0800 (PST)
From: Hsin-Te Yuan <yuanhsinte@chromium.org>
Date: Fri, 13 Dec 2024 05:27:48 +0000
Subject: [PATCH v3 2/2] arm64: dts: mediatek: mt8183: willow: Support
 second source touchscreen
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241213-touchscreen-v3-2-7c1f670913f9@chromium.org>
References: <20241213-touchscreen-v3-0-7c1f670913f9@chromium.org>
In-Reply-To: <20241213-touchscreen-v3-0-7c1f670913f9@chromium.org>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Enric Balletbo i Serra <eballetbo@kernel.org>, 
 Hsin-Yi Wang <hsinyi@chromium.org>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
 Hsin-Te Yuan <yuanhsinte@chromium.org>
X-Mailer: b4 0.15-dev-7be4f

Some willow devices use second source touchscreen.

Fixes: f006bcf1c972 ("arm64: dts: mt8183: Add kukui-jacuzzi-willow board")
Signed-off-by: Hsin-Te Yuan <yuanhsinte@chromium.org>
---
 .../boot/dts/mediatek/mt8183-kukui-jacuzzi-willow.dtsi    | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-willow.dtsi b/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-willow.dtsi
index 76d33540166f900c99c419c4f97ca0a56cf658f5..c942e461a177efe1e711a978c3bfb9f852f1b0ee 100644
--- a/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-willow.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-willow.dtsi
@@ -6,6 +6,21 @@
 /dts-v1/;
 #include "mt8183-kukui-jacuzzi.dtsi"
 
+&i2c0 {
+	touchscreen@40 {
+		compatible = "hid-over-i2c";
+		reg = <0x40>;
+
+		pinctrl-names = "default";
+		pinctrl-0 = <&touchscreen_pins>;
+
+		interrupts-extended = <&pio 155 IRQ_TYPE_LEVEL_LOW>;
+
+		post-power-on-delay-ms = <70>;
+		hid-descr-addr = <0x0001>;
+	};
+};
+
 &i2c2 {
 	trackpad@2c {
 		compatible = "hid-over-i2c";

-- 
2.47.1.613.gc27f4b7a9f-goog


