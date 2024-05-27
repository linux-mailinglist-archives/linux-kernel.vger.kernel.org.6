Return-Path: <linux-kernel+bounces-191201-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 285DA8D07E4
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 18:15:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D2D1B1F21344
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 16:15:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D7BB1649C8;
	Mon, 27 May 2024 16:04:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QcnfB5f+"
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6043016190C;
	Mon, 27 May 2024 16:04:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716825860; cv=none; b=J7lIwkOQst8EUBup6PTk9Q9CcQ0UPzeA6LK7XTFYfqqIyMd+IuRqu/HfWKc+EMZeY0sE47HaWQyVU82AKj9pV5Lvg+iKYVwgwEttDkUmpYgZc3PWm20Gzhobb+uS2PHR7YBNF8VGHc74SDZsc+EqU8sAeg7YoRHu62u8yxPNiDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716825860; c=relaxed/simple;
	bh=p/Ie9SW5LLry5odHyn1Z+OtVpPLJguI7HShBHpE0eKA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fjqLZXlTfp79uoYSuHLvKLAW13AhZISPK01v3Eg6BuWNoMn3+1WfVoYl+9cwoEyI9JX7QHkdL/4pqqwfxh8+Ufhp6g6EytBG8emFg5fkW/vmAollfPCjPfXR6RwtVSIctx8GvCuTfpsmRxED97BaGTlOENi5oltwnS+OJhl7+rM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QcnfB5f+; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-3564a0bea19so3187488f8f.2;
        Mon, 27 May 2024 09:04:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716825857; x=1717430657; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GX7MWRomctyKxwYidxaCMCj15SrJj2c1nUuhZiJGE4Y=;
        b=QcnfB5f+tCNgPKf2/F4j/uLyyJ22QvqaEeHCAMIPL5rr8wBo6h+APJO9OmR+gP5+TY
         7n5ESf3O+vb4nd3/gfIQWG0HqyQWgpMbFGVeJihZBZenmCbAfgdm26/TtDlHdGJ2d/XW
         ojap53Kc4qDx7BcoqUHZLRr7P/AmG38MbJl5/Ni35d+2+jEyBbh4Xq1ZUWRd7nke3/3u
         wua+XLrvkiroMCi34RTPrfnjYPIXoFKgGi3AukcTVSVYAnLsxhkcpQOoc6F7uRb768+P
         89+RWXxUnFwv7tWBN6yQxg6amS4DJRf5YuwnaLZJ3EmTVLHGJnqlk13Q4ztFJbqQ0Izz
         vEfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716825857; x=1717430657;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GX7MWRomctyKxwYidxaCMCj15SrJj2c1nUuhZiJGE4Y=;
        b=XxWtYuveshcmAunAeRZCJmnuqOQdOAo91x0xDpQzQhhgFner4fa18IXhzzB50wGbXk
         65K5xzOQJSOlCLTrTNjYNA/9vDRcDFovNz9WxlBIa0MgsJR6WOPud2bU9L1CNN8s5uvs
         Tmb8s/ZZ0KeDSZSAitmMPI2+fmEyjcO+Hp6h51gZyy5F4QqkU1ByufyuGmFyIELRWCSK
         MbKCswBYIBoBT8108KeazpaDcPUfzV/4N0BJsimI9Ebt4HGTTdytKx9JkZivNShaDnqP
         sywM8rigqHZL6Yg9S6Ku61ENhZig1JQqUAhxP5wNpubL8Mx+DXo8J5vBd8OIwK6JHkLO
         d3mA==
X-Forwarded-Encrypted: i=1; AJvYcCVCGk+Uie5K6q0wyf9Izewn9Co0N/11IIUTxHWHOMh5mPnV1t5asK3SWN1+7xpSc9mJfhT6YaTRcSZNvc+X0b208AEdesn5Ws4oqba+8700nRtvqzgcn2scOeVs26KUlRoxI6c2/BTbeg==
X-Gm-Message-State: AOJu0YwhIt3zcMZPoohD3hhU+uSrKzHshOSTU/F9FpEil5HEccTcYrRS
	60N0FPbRSVcgAG/iQfS+l4TF6OUkrYkvRGa4bQIg2l7IT+9PpxLo
X-Google-Smtp-Source: AGHT+IGIGygC2UpwgSkACZB8IxM9lQz/dCKFi424OCk/HsYCzOxG44VH9Zf55MjJBWI44kLuK6cLzA==
X-Received: by 2002:adf:e444:0:b0:356:4cfa:b4a2 with SMTP id ffacd0b85a97d-3564cfaebb7mr8173765f8f.3.1716825856453;
        Mon, 27 May 2024 09:04:16 -0700 (PDT)
Received: from toolbox.int.toradex.com (31-10-206-125.static.upc.ch. [31.10.206.125])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-35579f96519sm9349394f8f.26.2024.05.27.09.04.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 May 2024 09:04:16 -0700 (PDT)
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
Subject: [PATCH v1 2/2] arm64: dts: freescale: imx8mp-verdin: don't limit i2c2 max. clock
Date: Mon, 27 May 2024 18:03:46 +0200
Message-ID: <20240527160359.1965512-3-max.oss.09@gmail.com>
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

 arch/arm64/boot/dts/freescale/imx8mp-verdin.dtsi | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mp-verdin.dtsi b/arch/arm64/boot/dts/freescale/imx8mp-verdin.dtsi
index aef4bef4bccd..3c6b47edd4c1 100644
--- a/arch/arm64/boot/dts/freescale/imx8mp-verdin.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mp-verdin.dtsi
@@ -650,8 +650,7 @@ eeprom@50 {
 
 /* Verdin I2C_2_DSI */
 &i2c2 {
-	/* Lower frequency to avoid DDC/EDID issues with certain displays/screens. */
-	clock-frequency = <10000>;
+	clock-frequency = <400000>;
 	pinctrl-names = "default", "gpio";
 	pinctrl-0 = <&pinctrl_i2c2>;
 	pinctrl-1 = <&pinctrl_i2c2_gpio>;
-- 
2.42.0


