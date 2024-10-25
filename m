Return-Path: <linux-kernel+bounces-381437-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E53B9AFF3B
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 11:59:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 201171F23486
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 09:59:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6321C1DD0C9;
	Fri, 25 Oct 2024 09:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UOc7cpTR"
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADB731D90C8;
	Fri, 25 Oct 2024 09:59:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729850364; cv=none; b=tmcZ+QNs+tGRPHi/8wPmK7SY4ssv0UeZAZWKxmqFo/8RiufNLUQ6ZmSsi4QdfJV42NjqszWPj/1CKEhwROc8qpMRq/z8ookfyIHAraOshgCHFJ2uAXwxgsdEMwOKXMfz/fehsHRsFYvro04AFjEyO/hndBVnEvUZTxRP/W8k2Eo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729850364; c=relaxed/simple;
	bh=fBmyIDKPno0DYsTiITeI60p5mA0bO0r2hrftp9ABmLA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=P04i6OkuRLrV2x/Ui1J7S5R7wRdAl3o71hOJgXZNQiz4Lh4XMCZ/t36loJ8waNZtPDxY8fO98fCs+o6LJnRmHxcXB7OqrJ6nxCbyfl05JoaVXwg5Cz2uMSG9ZwNzTcm4ZUNLtgjspIspc2GPqCvWhFWHYOvMINVJQn0GRjw1g4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UOc7cpTR; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-37ec4e349f4so1344178f8f.0;
        Fri, 25 Oct 2024 02:59:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729850361; x=1730455161; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ujk9DybyKkZDF/2MtHXApKNICNk9/HaCwbVOr5hVCKk=;
        b=UOc7cpTRse70IB3tQtRGm++6eM0cirKJK9P78MlYB6AwkAHgBj8+T+nh8hYsUwCvt6
         UOHWvD2F65by1rRsVBDzD+WuUNqqKWaBu19vg6+Vj8f/q7UvKp/f5tC66aAXz3VQVsbR
         Vf9YXa5PZp/XvDBQqN8sf3tKDxJj4tgr/wimG1c33r2+dPBWA+3rL/zQwzFCmvTxAxvE
         hH+Ms/27dLopEQ8qhMz0h2vLgXhMjWcOc4fuo91NvYP873W861xyMr2MPFPBU+EIeCKR
         QsBk5ikufof1h2L2TNSG1qMEgGk7c+5ZNMwBrJW7zUmXaTlGqCTbSovA8IhEbiaMHpF5
         LTzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729850361; x=1730455161;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ujk9DybyKkZDF/2MtHXApKNICNk9/HaCwbVOr5hVCKk=;
        b=uKQZxNUkUI2ueqUlf9Z4ieh114XJel5yop67Jem/yLRBD0Wd1x4m4bEG2LFT79OaeS
         wSGrX1+8/YZCi6sNxg4gAtoIDBU2wLl4JpPuthjI3RlwBvsEZwFnIt66nGDe1WoKVfH9
         1mpybJL6+2zckWEUDucky7mp4Z6hsLUrlMhnBqCtVcbOerUGwcAEhJ7aVf0LdXOKyCk2
         LFm8Y7yxTauoH2n9A1FyqGSnWZ3KIzKLK0XbRDPO14xlfxR7ggw/LivpO6jLU2hyid3C
         NTWMT+CUa3oypuuLusnrxtTdZvGBwqljxcQXTMHcBQgLnD9EsJnHfI/vSvfDtPA7E22V
         bhoQ==
X-Forwarded-Encrypted: i=1; AJvYcCWwCULmCAa7vKINU7G40PZyJDE9aJUtgiN0vwZVIAssacpeQvf6ENGQoUwKphcr6Kd5RDFC1mqlIjPUuEg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxbtZ38S62gfwuXFc3uIWk++eSJF9ZpcLkus0xlyPhdcz4ygQDZ
	skEBEPNUlI1vcPZ4Mj3LVa7iX0lpvpT9limYloMRQvy9cgJttmWg
X-Google-Smtp-Source: AGHT+IGQ/FkY+lqoyXqrOcHuZexookS5gw8fVWByzJEmmycGhV4kbog53gMdjkWU0W54WsbGNSPHXw==
X-Received: by 2002:adf:a442:0:b0:378:7f15:d51e with SMTP id ffacd0b85a97d-37efcf7f306mr5781853f8f.43.1729850360713;
        Fri, 25 Oct 2024 02:59:20 -0700 (PDT)
Received: from eichest-laptop.lan ([2a02:168:af72:0:7bc0:826e:69e3:7e40])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38058b3c7b9sm1098214f8f.32.2024.10.25.02.59.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Oct 2024 02:59:20 -0700 (PDT)
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
Subject: [PATCH v1 2/2] arm64: dts: imx8mp-verdin: add single-master property to all i2c nodes
Date: Fri, 25 Oct 2024 11:58:03 +0200
Message-ID: <20241025095915.22313-3-eichest@gmail.com>
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
 arch/arm64/boot/dts/freescale/imx8mp-verdin.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mp-verdin.dtsi b/arch/arm64/boot/dts/freescale/imx8mp-verdin.dtsi
index a19ad5ee7f792..323b45bac281e 100644
--- a/arch/arm64/boot/dts/freescale/imx8mp-verdin.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mp-verdin.dtsi
@@ -478,6 +478,7 @@ &i2c1 {
 	pinctrl-1 = <&pinctrl_i2c1_gpio>;
 	scl-gpios = <&gpio5 14 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
 	sda-gpios = <&gpio5 15 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
+	single-master;
 	status = "okay";
 
 	pca9450: pmic@25 {
@@ -669,6 +670,7 @@ &i2c2 {
 	pinctrl-1 = <&pinctrl_i2c2_gpio>;
 	scl-gpios = <&gpio5 16 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
 	sda-gpios = <&gpio5 17 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
+	single-master;
 
 	atmel_mxt_ts_mezzanine: touch-mezzanine@4a {
 		compatible = "atmel,maxtouch";
@@ -690,6 +692,7 @@ &i2c3 {
 	pinctrl-1 = <&pinctrl_i2c3_gpio>;
 	scl-gpios = <&gpio5 18 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
 	sda-gpios = <&gpio5 19 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
+	single-master;
 };
 
 /* Verdin I2C_1 */
@@ -700,6 +703,7 @@ &i2c4 {
 	pinctrl-1 = <&pinctrl_i2c4_gpio>;
 	scl-gpios = <&gpio5 20 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
 	sda-gpios = <&gpio5 21 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
+	single-master;
 
 	gpio_expander_21: gpio-expander@21 {
 		compatible = "nxp,pcal6416";
@@ -788,6 +792,7 @@ &i2c5 {
 	pinctrl-1 = <&pinctrl_i2c5_gpio>;
 	scl-gpios = <&gpio3 26 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
 	sda-gpios = <&gpio3 27 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
+	single-master;
 };
 
 /* Verdin PCIE_1 */
-- 
2.43.0


