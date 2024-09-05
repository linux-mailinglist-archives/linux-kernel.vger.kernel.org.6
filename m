Return-Path: <linux-kernel+bounces-317631-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2539096E147
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 19:38:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BFE6EB261C5
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 17:38:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 378741A76DE;
	Thu,  5 Sep 2024 17:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cf9l6VGh"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14C5D1A704E;
	Thu,  5 Sep 2024 17:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725557847; cv=none; b=LH19TTWWbqzt3q0J1aGT1ZzKlCDKRqb523mGUIKYUXNkdu0lxUl+SrfOdzghQlXSW3GQz9fbJvIoNQ6dAebW2Htrp3QmuEYxrS6y2HiCYOiivfWKcO6zH7XxnwjcPIdSfAedI/juUU+V17GhTFGVUX3OU3ehyMaSLqHykH+gC1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725557847; c=relaxed/simple;
	bh=ZUQNvjzepWA4pCK8RLWIXzlmS349ucRwrxxaYBZS3Do=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Hzz4JM3sIVQ2gKal/A9A8oN+oq0NoMKSfheadg+s6JkwB98H0T2eRfLAdqppMHpr6UkZhO54q+6iW0fyY6Me+Yau30BzBDCfckWn2Vbg6ciJr7GCpDJicNbD4FLiDuOs/Asw476qGec6IyPxfhru/zeiA3CcJ13FFZOO9k6fwKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Cf9l6VGh; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-42bbffe38e6so8437835e9.0;
        Thu, 05 Sep 2024 10:37:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725557844; x=1726162644; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=557eQ0nrkCY+/ANVkKP3VQXQ7163oT4FiuaAuauOfKc=;
        b=Cf9l6VGhQs/Vl8ZO3QVU2VZHJNBixy8fSm0etdt6fVmpEteLMCuwq6ZEEadJ/nKEJc
         nI8RYuwYQpfndwGDkmzqFPfddRu013GaV5LvNkEJshVNOoEk9egb4ycjgDYewuIRe4qJ
         zgUSRCQvo1DtkRv2tT5a4przqznH9rfoROq6WQX3cYXmlO1h3PHZrKq2PG94Hl0KE0s6
         l59aynadlhywVgxANviFC+a8FGVaril1qDmc/S3YYl7XakycFgPvGCVBn78I0kEEyKMc
         jQ+i4Su8DHyP+SPoUBxp5bjTEZ3HdfF3ALwPe9fZ4ooMMuT+rtz3zxBJlhUNW3PtJMVU
         a2UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725557844; x=1726162644;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=557eQ0nrkCY+/ANVkKP3VQXQ7163oT4FiuaAuauOfKc=;
        b=Oq+9IOH+oM7dkuoVt1np+gEGViAmInrVIxxU8aoC0s7IU9W6LaFwLg48+p3KxnBOKG
         mhOxTzES95jPKytcM1AaomXeZVSY8bXpMpgWh4YHyF//NF/w9oPlPw4W9F6MqGqxvPuF
         FbJmQzafsGLE8aC/UGz0ekzVwYJO4aBMVhV8EJGTUgOG3yMYCgbYjbPaiqRvhGqhNNVy
         Gvopcu6sNRJaHkdkenb0dUpbBVOrdkUFar74GRD9zM9qmsYZJXf93JUSA5Xye5y3tpN7
         pkDlM90bajh63H18ioW+fAtLsD9RmgMAot2HG6FhGXZcIg1p9Vo0FgGbrlCRihSzDQ7t
         DxqA==
X-Forwarded-Encrypted: i=1; AJvYcCX4qaLKPqsrDWWRTa9Vhax4i6x6pcgyxTzY/37awO33EwwYDPrce2ljzorfYzg+XZR8kssVV1Lisj8fF4M=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+cr1WXaxdZptKkVwRrSUp6bXby36HayR0BEp/0ixr623WF2Lh
	Emn8t7oYb8cOMxjOP2mRqEY/bcwBFtzEG3U1QvNJZbmFAJWXxLHgev1sb1/xX60=
X-Google-Smtp-Source: AGHT+IHG7cIYEiQK4CjUWPerdwh6CKrVoOAyBG3msAvSCV3Qn00TYv6w1O7L2+TkplQKEGL8B3Og9w==
X-Received: by 2002:a05:600c:3596:b0:426:66e9:b844 with SMTP id 5b1f17b1804b1-42bb02c0711mr192660435e9.8.1725557844242;
        Thu, 05 Sep 2024 10:37:24 -0700 (PDT)
Received: from cleve-worktop. (85-193-33-185.rib.o2.cz. [85.193.33.185])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-42bb37f7849sm245704605e9.7.2024.09.05.10.37.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Sep 2024 10:37:23 -0700 (PDT)
From: =?utf-8?q?Kry=C5=A1tof_=C4=8Cern=C3=BD?= <cleverline1mc@gmail.com>
Date: Thu, 05 Sep 2024 19:37:11 +0200
Subject: [PATCH v3 2/2] arm64: dts: allwinner: H5: NanoPi NEO Plus2: Use
 regulators for pio
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240905-nanopi-neo-plus2-regfix-v3-2-1895dff59598@gmail.com>
References: <20240905-nanopi-neo-plus2-regfix-v3-0-1895dff59598@gmail.com>
In-Reply-To: <20240905-nanopi-neo-plus2-regfix-v3-0-1895dff59598@gmail.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>, 
 Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Samuel Holland <samuel@sholland.org>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org, 
 =?utf-8?q?Kry=C5=A1tof_=C4=8Cern=C3=BD?= <cleverline1mc@gmail.com>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1725557840; l=958;
 i=cleverline1mc@gmail.com; s=20240824; h=from:subject:message-id;
 bh=ZUQNvjzepWA4pCK8RLWIXzlmS349ucRwrxxaYBZS3Do=;
 b=HR9gGVSIHOvwivYhckB8+lKbHqe+U0NuPSVXQyZHFvG79aOdTUJqu593cgFwNB7Tm+0Wxox4m
 GvATeaSEke+ALXSM3Dxy21o3ZbF5vQNIEpWqEBoAD5294oLrtCJ2zZu
X-Developer-Key: i=cleverline1mc@gmail.com; a=ed25519;
 pk=CQifx5FUgTQKAoj5VCYrwYHi235AkXQ5yT1P6gkaBxM=

Pin controllers pio and r_pio will have proper regulators assigned.

Signed-off-by: Kryštof Černý <cleverline1mc@gmail.com>
---
 arch/arm64/boot/dts/allwinner/sun50i-h5-nanopi-neo-plus2.dts | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h5-nanopi-neo-plus2.dts b/arch/arm64/boot/dts/allwinner/sun50i-h5-nanopi-neo-plus2.dts
index dee4cd82636b..526443bb736c 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h5-nanopi-neo-plus2.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h5-nanopi-neo-plus2.dts
@@ -171,6 +171,18 @@ &ohci3 {
 	status = "okay";
 };
 
+&pio {
+	vcc-pa-supply = <&reg_vcc3v3>;
+	vcc-pc-supply = <&reg_vcc3v3>;
+	vcc-pd-supply = <&reg_gmac_2v5>;
+	vcc-pf-supply = <&reg_vcc3v3>;
+	vcc-pg-supply = <&reg_vcc3v3>;
+};
+
+&r_pio {
+	vcc-pl-supply = <&reg_vcc3v3>;
+};
+
 &uart0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&uart0_pa_pins>;

-- 
2.39.2


