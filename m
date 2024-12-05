Return-Path: <linux-kernel+bounces-432679-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AB769E4EB1
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 08:35:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8170F1881B7B
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 07:35:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F95C1CEEAA;
	Thu,  5 Dec 2024 07:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cycQCvX+"
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6C3C19F475
	for <linux-kernel@vger.kernel.org>; Thu,  5 Dec 2024 07:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733384001; cv=none; b=F0MTnsmq3PYkCZ2IAojnXtSCMKI2SJWzMls9H+6+fNF4P8m/RXKqynJjrfSh6hcgVOmaUPZ3JlBQ4c0HoAUCSj1KycEkdh1d9/52ukZmdW0Od7YePZKbI4CeyOzIrSogyDlWtHgi6rzPXuXY9Sxp8galPYDBTm2OAksSTqxCJ3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733384001; c=relaxed/simple;
	bh=wB85TvHGNmOfHJ/mMWKC/8ms9JuX3aQUHHifkpUaQBk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nVWc2QK16B9tbB2WRB5/J/WfpG4G9V8sCjFBojM0G7gm4KIpZqaD6R+A+5P4NohaRPyY1aDvy2IsscQRL6m7v28sF2fGhXVuaTd3kzU6LkspYQR8NDgQq0QSI6stpUOBv6OEV8C12IDNvzFZnX6Fp2Pyjb/RglmctfTXaOuBhYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=cycQCvX+; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-aa549d9dffdso76970366b.2
        for <linux-kernel@vger.kernel.org>; Wed, 04 Dec 2024 23:33:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733383997; x=1733988797; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=g6O3lCGzSUbOgWyay+aXa9djkwZjywsxQgF3zhLj0KI=;
        b=cycQCvX+0PwZJorSyfq6T5opZHAYSM61m6PVHaGqCBccztUA2aezN+r9KcLDucfbO2
         z7owfGjuB3LUtdpJ23PtkmRVYvqrDCasOP7qZS/a9DhEm0tnrYHooPU7HoX6nDBpVmpZ
         3uszl7bbHFu3NIGijAkH+mzVYyM1GfP4zsIATTdvnIxoK6uuGzsN6hDSFi7TrCd9KSob
         OfoU8+i5V7st4yzC3Kn9p+CwUtI+8fHUTQLfMCePDYWTT0Uuf4DuTqwBDvgBbO1yBmnS
         KGrJ0MLLxiUKoiILTpYPZ55DJ7IeoGc3oT66D7hf13wEVle/pdoShv9XR1WCO8eTCHPp
         t5Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733383997; x=1733988797;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g6O3lCGzSUbOgWyay+aXa9djkwZjywsxQgF3zhLj0KI=;
        b=Tec6Ct8pA9HDyOKo9N/8MmdgZp6DLWHPElJzrJgRKg4VP0kCGoEE3ip2UXjf/Yjdtd
         F4BOQpj6ylnOtKRmgxXROE91SM4u+IYjSRe731L4Wzqgp9XjenVkxEIzlFcrWP0wak6U
         QfUxbA63Awi0NPLQYgTV0L32ruJUz6oX3oowZto4pM8FQa+mLP5h4iCiXzjNMDAjGLMz
         MVYMWT5WyE9DeS/ZIm7PC3iIzRg9hgl0L45SOYBh4W1+FFY0mUrU4KG66l6tkwL+tXV2
         GufFgcI8UDRTWW/850SoeHf8LAD5Vzwce42qJ6R7bmyv37XUnv34YFZF3Enwu2Ewo41c
         +gig==
X-Forwarded-Encrypted: i=1; AJvYcCUaszXwKfRuofRATjjFVoHhTmiI+kzTQsFnpzrHvYN7gEHQouRnr040qdsuW2byVzVLKamuzHlW/xrdwV8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy50JwWFoK5EYPJpklmKXwojZ+vRW9kX1Ob/kWV2xs9eql+1GaS
	+v2CZU0GKeXzcTqc6tLNl93bGlbIoQPL3Z/ghtugE6yB2AARjYqziCGWsN96VnYM7rj/DRF5X45
	TCDo=
X-Gm-Gg: ASbGncsjMh3zlMAvXf2LN86q5/WJMjzHaTk1KSi/WdLaPRSzsI53dw2JKhR0nGwRO1k
	anysHvS0HeOFqoc5ZavwepTqcCNlEEiNkTHyak+EGgTDMuWAvEdLQM58KxPPJIK75ka4A4eRkoW
	6tSsol6tlCrOHVXqqSFA5Y2pY6Ktu+LtnNHjODuaJHznfUhMr2eJpmxzbQI+lMHGAbiwaq+Ub8F
	gcUehWskphqsMRNGu6IwGAFckYLQlnmzVBpTRJFhGNgga1jA/lv2cr8aZ9O7JgUP2kBRC+QdFtx
	SP0USIF1Xc0hWnp+uklUk6rwLu2nSN85uA==
X-Google-Smtp-Source: AGHT+IEi/zCT7Ze2IPO+Cv0zWjyb+MBILaN1VwgbSpJ0ZibfzpwTs9mA6Loh2tFdluQCoQvAqduEeA==
X-Received: by 2002:a17:906:18a9:b0:aa5:391e:cad5 with SMTP id a640c23a62f3a-aa5f7d9a2a7mr737322566b.33.1733383996962;
        Wed, 04 Dec 2024 23:33:16 -0800 (PST)
Received: from puffmais.c.googlers.com (64.227.90.34.bc.googleusercontent.com. [34.90.227.64])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa6260888casm53371766b.133.2024.12.04.23.33.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Dec 2024 23:33:16 -0800 (PST)
From: =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Date: Thu, 05 Dec 2024 07:33:18 +0000
Subject: [PATCH v3 7/8] phy: exynos5-usbdrd: subscribe to orientation
 notifier if required
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241205-gs101-phy-lanes-orientation-phy-v3-7-32f721bed219@linaro.org>
References: <20241205-gs101-phy-lanes-orientation-phy-v3-0-32f721bed219@linaro.org>
In-Reply-To: <20241205-gs101-phy-lanes-orientation-phy-v3-0-32f721bed219@linaro.org>
To: Vinod Koul <vkoul@kernel.org>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Marek Szyprowski <m.szyprowski@samsung.com>, 
 Sylwester Nawrocki <s.nawrocki@samsung.com>, 
 Alim Akhtar <alim.akhtar@samsung.com>
Cc: Peter Griffin <peter.griffin@linaro.org>, 
 Tudor Ambarus <tudor.ambarus@linaro.org>, 
 Sam Protsenko <semen.protsenko@linaro.org>, 
 Will McVicker <willmcvicker@google.com>, Roy Luo <royluo@google.com>, 
 kernel-team@android.com, linux-phy@lists.infradead.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, 
 =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
X-Mailer: b4 0.13.0

gs101's SS phy needs to be configured differently based on the
connector orientation, as the SS link can only be established if the
mux is configured correctly.

The code to handle programming of the mux is in place already, this commit
now adds the missing pieces to subscribe to the Type-C orientation
switch event.

Note that for this all to work we rely on the USB controller
re-initialising us. It should invoke our .exit() upon cable unplug, and
during cable plug we'll receive the orientation event after which we
expect our .init() to be called.

Above reinitialisation happens if the DWC3 controller can enter runtime
suspend automatically. For the DWC3 driver, this is an opt-in:
    echo auto > /sys/devices/.../11110000.usb/power/control
Once done, things work as long as the UDC is not bound as otherwise it
stays busy because it doesn't cancel / stop outstanding TRBs. For now
we have to manually unbind the UDC in that case:
     echo "" > sys/kernel/config/usb_gadget/.../UDC

Note that if the orientation-switch property is missing from the DT,
the code will behave as before this commit (meaning for gs101 it will
work in SS mode in one orientation only). Other platforms are not
affected either way.

Signed-off-by: André Draszik <andre.draszik@linaro.org>

---
v3:
* drop init to -1 of phy_drd->orientation (Vinod)
* avoid #ifdef and switch to normal conditional IS_ENABLED() for
  CONFIG_TYPEC

v2:
* move #include typec_mux.h from parent patch into this one (Peter)

IS_ENABLED(CONFIG_TYPEC)
---
 drivers/phy/samsung/Kconfig              |  1 +
 drivers/phy/samsung/phy-exynos5-usbdrd.c | 56 ++++++++++++++++++++++++++++++++
 2 files changed, 57 insertions(+)

diff --git a/drivers/phy/samsung/Kconfig b/drivers/phy/samsung/Kconfig
index f10afa3d7ff5..fc7bd1088576 100644
--- a/drivers/phy/samsung/Kconfig
+++ b/drivers/phy/samsung/Kconfig
@@ -80,6 +80,7 @@ config PHY_EXYNOS5_USBDRD
 	tristate "Exynos5 SoC series USB DRD PHY driver"
 	depends on (ARCH_EXYNOS && OF) || COMPILE_TEST
 	depends on HAS_IOMEM
+	depends on TYPEC || (TYPEC=n && COMPILE_TEST)
 	depends on USB_DWC3_EXYNOS
 	select GENERIC_PHY
 	select MFD_SYSCON
diff --git a/drivers/phy/samsung/phy-exynos5-usbdrd.c b/drivers/phy/samsung/phy-exynos5-usbdrd.c
index 206483c7ca55..6dcc3c80c1d2 100644
--- a/drivers/phy/samsung/phy-exynos5-usbdrd.c
+++ b/drivers/phy/samsung/phy-exynos5-usbdrd.c
@@ -24,6 +24,7 @@
 #include <linux/regulator/consumer.h>
 #include <linux/soc/samsung/exynos-regs-pmu.h>
 #include <linux/usb/typec.h>
+#include <linux/usb/typec_mux.h>
 
 /* Exynos USB PHY registers */
 #define EXYNOS5_FSEL_9MHZ6		0x0
@@ -394,6 +395,7 @@ struct exynos5_usbdrd_phy_drvdata {
  * @extrefclk: frequency select settings when using 'separate
  *	       reference clocks' for SS and HS operations
  * @regulators: regulators for phy
+ * @sw: TypeC orientation switch handle
  * @orientation: TypeC connector orientation - normal or flipped
  */
 struct exynos5_usbdrd_phy {
@@ -415,6 +417,7 @@ struct exynos5_usbdrd_phy {
 	u32 extrefclk;
 	struct regulator_bulk_data *regulators;
 
+	struct typec_switch_dev *sw;
 	enum typec_orientation orientation;
 };
 
@@ -1400,6 +1403,55 @@ static int exynos5_usbdrd_phy_clk_handle(struct exynos5_usbdrd_phy *phy_drd)
 	return 0;
 }
 
+static int exynos5_usbdrd_orien_sw_set(struct typec_switch_dev *sw,
+				       enum typec_orientation orientation)
+{
+	struct exynos5_usbdrd_phy *phy_drd = typec_switch_get_drvdata(sw);
+
+	scoped_guard(mutex, &phy_drd->phy_mutex)
+		phy_drd->orientation = orientation;
+
+	return 0;
+}
+
+static void exynos5_usbdrd_orien_switch_unregister(void *data)
+{
+	struct exynos5_usbdrd_phy *phy_drd = data;
+
+	typec_switch_unregister(phy_drd->sw);
+}
+
+static int exynos5_usbdrd_setup_notifiers(struct exynos5_usbdrd_phy *phy_drd)
+{
+	int ret;
+
+	if (!IS_ENABLED(CONFIG_TYPEC))
+		return 0;
+
+	if (device_property_present(phy_drd->dev, "orientation-switch")) {
+		struct typec_switch_desc sw_desc = { };
+
+		sw_desc.drvdata = phy_drd;
+		sw_desc.fwnode = dev_fwnode(phy_drd->dev);
+		sw_desc.set = exynos5_usbdrd_orien_sw_set;
+
+		phy_drd->sw = typec_switch_register(phy_drd->dev, &sw_desc);
+		if (IS_ERR(phy_drd->sw))
+			return dev_err_probe(phy_drd->dev,
+					     PTR_ERR(phy_drd->sw),
+					     "Failed to register TypeC orientation switch\n");
+
+		ret = devm_add_action_or_reset(phy_drd->dev,
+					       exynos5_usbdrd_orien_switch_unregister,
+					       phy_drd);
+		if (ret)
+			return dev_err_probe(phy_drd->dev, ret,
+					     "Failed to register TypeC orientation devm action\n");
+	}
+
+	return 0;
+}
+
 static const struct exynos5_usbdrd_phy_config phy_cfg_exynos5[] = {
 	{
 		.id		= EXYNOS5_DRDPHY_UTMI,
@@ -1789,6 +1841,10 @@ static int exynos5_usbdrd_phy_probe(struct platform_device *pdev)
 	if (ret)
 		return dev_err_probe(dev, ret, "failed to get regulators\n");
 
+	ret = exynos5_usbdrd_setup_notifiers(phy_drd);
+	if (ret)
+		return ret;
+
 	dev_vdbg(dev, "Creating usbdrd_phy phy\n");
 
 	for (i = 0; i < EXYNOS5_DRDPHYS_NUM; i++) {

-- 
2.47.0.338.g60cca15819-goog


