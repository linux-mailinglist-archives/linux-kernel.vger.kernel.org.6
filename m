Return-Path: <linux-kernel+bounces-381436-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F34AF9AFF36
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 11:59:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 710361F230A6
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 09:59:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADC601D9A76;
	Fri, 25 Oct 2024 09:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a7eMgdMW"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 027F41D7E46;
	Fri, 25 Oct 2024 09:59:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729850364; cv=none; b=JvA+XSFZZQ7uE5nH+99Eytl7OQ0YUlzlBsLUycx8P8l22jn2w8BgxnMDfqCA/couVOJzXPN32+dcJCZiAfhzv1Gvf2lZwElD70JaPHZr9QCCtInhnGqKFxnXwk8mE4CL1f7qy5Dd6Usv35UwjBqURxcNL6tAy/9jAIqF6OCpWl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729850364; c=relaxed/simple;
	bh=4DTEm7iesIQWirW8sh5Y6omeTGVkUjzxTvYToHDG8mM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=e9EKUVrsRNpH9CCOOV02aEFM0WlX7hAdhkFjQjYt2ba/fKBFWmeTc/FSZrJZ2AtnGLp6syOb8RcEVBT76x7qUhWgH5AMg8LGWNyJPHjE/0+N0LbOyltkTcqY8tpHa+zSn2czshsMtRUUd4unQ3UHGlBlYhw/sm8rdTNBMGtFnao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a7eMgdMW; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4319399a411so4035455e9.2;
        Fri, 25 Oct 2024 02:59:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729850360; x=1730455160; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vtKvVgvka9iN+kbiGV17uPT0FqDZwLoJavxYI8Qd0js=;
        b=a7eMgdMWCblBbo4qFL+Tf+j1DduSZZLGf0Zsr3sDOKbRw1b/xDkM1Y8uQexx4hAt/2
         QQVQh7P2tYagKbUdyx+MdV+qsdX+vSbxamb03aK2QZG2dNxsTr1s53evOLB46K/9ATyx
         ygYGH7piuKsOV4OjGvhkLjdh2Ut+gOr8aDF/TQ2dNUCcwyXuOQSPngBUFuTUPLjy5WJN
         P7ShpeM+5VqZhbCYdu+jzsiE78wWRr2hSxOQPo9U5axbc2bVdeTkpsvbWW821Wu1lnJO
         PbENpYpDhn8wqt0ImiqMvDF8EZ7nnv/qt9Wy6ttdK8Xf+tma8k8Ug9NqhAX41YA2lPOZ
         Z2LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729850360; x=1730455160;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vtKvVgvka9iN+kbiGV17uPT0FqDZwLoJavxYI8Qd0js=;
        b=pswZfJQFaN7w2zVjLz+aop5YaMmG1JbdjcTWh2/nJUkpHqYgjRxBiuDqQu5m9L4xCl
         rtiPOv1EAamFKHEmxLoJ3+NfwsUYBH9hFcvyUTQnka6Bw2wXZU2cbp4fnE0jW9m7+Ny4
         PScQtX3JfISIWtcpoyJ3CeFsdIvTP8tND6wPu5NAHFR/EscrHC0TlaZVvdjmfW+g3rll
         kwJdfX/avlh206aTKF7/xYUQkZIqXhgMDMaEuX1VzJXmW0ZfBtdONwnkNhYWoh2NAHyg
         xVOWSwTq73RfJg/O0QNzkVxYtN2B40A+m/xx3j6EkV0rE4vJHKYO5tc9A+AMMpli6iLA
         x8zQ==
X-Forwarded-Encrypted: i=1; AJvYcCVZbIX6NCu+Ojk8VGcwalnGAFapXtBiZ6aHPlCefKJogy5loR+vimcx4/G7yliZmPXEWIEcVDzsHQ1tCNg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxsNsaxEJjoHehmQG7NjLyCSUCHxBgyYw0Rp/OQjX/8wVYhh6Cv
	XHau5CvHbvGNa0fxRcVj8hIBiWk4AuX1WcQ8A32Z9t2fn62+SByD
X-Google-Smtp-Source: AGHT+IHgz1qa+4ruXXEU9mLOWIYjUTskP3J0uPmavT75tDGVcKYFxvpomruMOKNd7WxPb9yzDb7knA==
X-Received: by 2002:a05:600c:5123:b0:430:52ec:1e2b with SMTP id 5b1f17b1804b1-4318c77ee2emr44793845e9.29.1729850359933;
        Fri, 25 Oct 2024 02:59:19 -0700 (PDT)
Received: from eichest-laptop.lan ([2a02:168:af72:0:7bc0:826e:69e3:7e40])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38058b3c7b9sm1098214f8f.32.2024.10.25.02.59.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Oct 2024 02:59:19 -0700 (PDT)
From: Stefan Eichenberger <eichest@gmail.com>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	shawnguo@kernel.org,
	s.hauer@pengutronix.de,
	kernel@pengutronix.de,
	festevam@gmail.com,
	francesco.dolcini@toradex.com
Cc: devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Stefan Eichenberger <stefan.eichenberger@toradex.com>
Subject: [PATCH v1 1/2] arm64: dts: imx8mm-verdin: add single-master property to all i2c nodes
Date: Fri, 25 Oct 2024 11:58:02 +0200
Message-ID: <20241025095915.22313-2-eichest@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241025095915.22313-1-eichest@gmail.com>
References: <20241025095915.22313-1-eichest@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Stefan Eichenberger <stefan.eichenberger@toradex.com>

By default we expect all i2c nodes to be single-master, we do not have
any module or carrier board that uses multi-master mode on any i2c
controller. With this property set, we benefit from optimisations made
exclusively for single-masters.

Signed-off-by: Stefan Eichenberger <stefan.eichenberger@toradex.com>
---
 arch/arm64/boot/dts/freescale/imx8mm-verdin.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mm-verdin.dtsi b/arch/arm64/boot/dts/freescale/imx8mm-verdin.dtsi
index 5fa3959141911..95d5d2333ca1e 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm-verdin.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mm-verdin.dtsi
@@ -367,6 +367,7 @@ &i2c1 {
 	pinctrl-1 = <&pinctrl_i2c1_gpio>;
 	scl-gpios = <&gpio5 14 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
 	sda-gpios = <&gpio5 15 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
+	single-master;
 	status = "okay";
 
 	pca9450: pmic@25 {
@@ -561,6 +562,7 @@ &i2c2 {
 	pinctrl-1 = <&pinctrl_i2c2_gpio>;
 	scl-gpios = <&gpio5 16 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
 	sda-gpios = <&gpio5 17 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
+	single-master;
 	status = "disabled";
 };
 
@@ -574,6 +576,7 @@ &i2c3 {
 	pinctrl-1 = <&pinctrl_i2c3_gpio>;
 	scl-gpios = <&gpio5 18 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
 	sda-gpios = <&gpio5 19 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
+	single-master;
 };
 
 /* Verdin I2C_1 */
@@ -584,6 +587,7 @@ &i2c4 {
 	pinctrl-1 = <&pinctrl_i2c4_gpio>;
 	scl-gpios = <&gpio5 20 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
 	sda-gpios = <&gpio5 21 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
+	single-master;
 
 	gpio_expander_21: gpio-expander@21 {
 		compatible = "nxp,pcal6416";
-- 
2.43.0


