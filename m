Return-Path: <linux-kernel+bounces-191200-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A7B268D07E2
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 18:15:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CB84A1C22204
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 16:15:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44D4F161B43;
	Mon, 27 May 2024 16:04:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ye7z527Y"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46EA816132F;
	Mon, 27 May 2024 16:04:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716825859; cv=none; b=gm5ycDYUcIjkFdEi1fX9AcOxxU21vnx4f0nc6pgxgHK/kbDMEqLTRdn0sJSFcigW5ifQ/oojKgjIVYPmhMFu4djqDik+cZ5Q1Ft2dxJ7+M30kkcXBGHdXDOwOWTq+6OznSDIhea98hb5tcBsbvddeFoW/9nv3d3CEWQYQ/4sKU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716825859; c=relaxed/simple;
	bh=L+gu2PKI59dIpxrARh9V0V6BqbRaGAiOSnYT14Qdn+c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V/u778Z+oIE0+sf6+cqaZ4S6/k40tfpPLNv/vCbGYNbPaObrqrDRTcgt/yxs1mVhT3NdhYh6ALU+xqqRbSleLtRYKdU+soEgQ3ueBFYw+dOudMBCZHR+anS+/kXOcQ1m6gJS3kZqXpkHDYhRf504bRiFS76XxvzwfW5SyJUP+wg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ye7z527Y; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-42108739ed8so35835545e9.0;
        Mon, 27 May 2024 09:04:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716825856; x=1717430656; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=beAo2V97IysZU2zPgVb+0hz2tpF1/iEIksP9hejwZuk=;
        b=Ye7z527YsnfV1YTQll2o8fjzBGdyBQWi2DpSdHS2zUTUHYWITwGvKIs0LO+qSN6/fM
         G33a+Lf2XVy69R2zxE7CZfYkKCdJfLhqbcm5b+4Ss59admY5UgSnuSkO+6lMeFy/6DEW
         /k2M0NHfhxYUw9MNbvymemBLobhx9TdpkcNyOnlqyMmNd4uuMJuvek5dR+gnghAbg9Rp
         LgSO0a4L8A6cn86nkGk0c7v4FFSc+FieVwEEGq/hFHfpQRAHEZySchvxlmxXCczioomn
         yCWpzSVF8HQzd/7bJe4msLM3HZ0mrVW+2+kjWjnxB7DZpAFzggpr5hH2G2DDPOBTq07r
         Il0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716825856; x=1717430656;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=beAo2V97IysZU2zPgVb+0hz2tpF1/iEIksP9hejwZuk=;
        b=N2XyEpHy1YUADjnh+OGCWzKwoIpCsb2gnjPPLckcdoplj3HFIwXD8maQNsl/ghSTQ2
         gJAynkTA4oQcq/mz5QXLMBDnToKCIPd+rDhhMVAxG0xUUh5yd6CUM2uVIcKf+sj8Q0kL
         j0o+zCQ+c4hErrwrx6/Hgay85Tvr7UOK7uSG7PY3QVVgImAEvPzBi0/Syv8bvMNvO9+N
         iy3jveE86UH+cO+agWgzSrwKzSMLsU8wWJK/Qao3CiRAq5eB3kGMW4KSDKj9rPGhWC6f
         nZMIlJdcZEgWfkBf2MOydUBkVsuWZjcFvQk9HYU8sqru0NJRFM6hQmlQFCm4FCEpatWL
         ixGQ==
X-Forwarded-Encrypted: i=1; AJvYcCV87SwMJeq4nHqup/nZCbMbzlecWZh439BglX4twLcSOdBRp9qSfs0phGHqFiq9JtqKxzYvCP2OpomptOrUitMJlByo6icIPXOUOpTDrvpp8he9b5kylsv0dpm1xgl6ZLwz6Z4sC9phig==
X-Gm-Message-State: AOJu0YwWMMSxzu+UWDarzPXpUrvAB4E9fB/Hzv4IsHaBEH24Iaj5bXqR
	1p/LunCyK1xB0ZjZqziNQ0Jy2S6gChAR5PNQsD54VwmLSOUJyhfhgx99lg==
X-Google-Smtp-Source: AGHT+IHV+7uj3oNwhQkFI8e8byFtEGjCoG+5dXKJN7KLcse27lqAdteZi9rMrKfCv6MfKNFAZTeWNw==
X-Received: by 2002:a5d:6109:0:b0:354:c2c3:a319 with SMTP id ffacd0b85a97d-3552fe17d7fmr8085671f8f.61.1716825855678;
        Mon, 27 May 2024 09:04:15 -0700 (PDT)
Received: from toolbox.int.toradex.com (31-10-206-125.static.upc.ch. [31.10.206.125])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-35579f96519sm9349394f8f.26.2024.05.27.09.04.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 May 2024 09:04:15 -0700 (PDT)
From: max.oss.09@gmail.com
To: Max Krummenacher <max.krummenacher@toradex.com>
Cc: Conor Dooley <conor+dt@kernel.org>,
	Fabio Estevam <festevam@gmail.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Rob Herring <robh@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Shawn Guo <shawnguo@kernel.org>,
	devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1 1/2] arm64: dts: freescale: imx8mm-verdin: don't limit i2c2 max. clock
Date: Mon, 27 May 2024 18:03:45 +0200
Message-ID: <20240527160359.1965512-2-max.oss.09@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240527160359.1965512-1-max.oss.09@gmail.com>
References: <20240527160359.1965512-1-max.oss.09@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Max Krummenacher <max.krummenacher@toradex.com>

Verdin I2C2 may be used to access other I2C devices apart from serving
as an HDMI DDC channel.
Thus do not limit the used I2C clock frequency to 10kHz in the module
specific device tree part.
If an overlay configures i2c2 as DDC the overlay is also responsible
to cope with an appropriate I2C clock.

Signed-off-by: Max Krummenacher <max.krummenacher@toradex.com>
---

 arch/arm64/boot/dts/freescale/imx8mm-verdin.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mm-verdin.dtsi b/arch/arm64/boot/dts/freescale/imx8mm-verdin.dtsi
index 4768b05fd765..82bbcec525d7 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm-verdin.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mm-verdin.dtsi
@@ -547,7 +547,7 @@ eeprom@50 {
 
 /* Verdin I2C_2_DSI */
 &i2c2 {
-	clock-frequency = <10000>;
+	clock-frequency = <400000>;
 	pinctrl-names = "default", "gpio";
 	pinctrl-0 = <&pinctrl_i2c2>;
 	pinctrl-1 = <&pinctrl_i2c2_gpio>;
-- 
2.42.0


