Return-Path: <linux-kernel+bounces-556284-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 911F4A5C3A9
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 15:20:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D08E3AA9F7
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 14:20:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42BEB25B692;
	Tue, 11 Mar 2025 14:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="eLRiegRk"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC26E1C5D61
	for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 14:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741702807; cv=none; b=TV0soyj/9spVPRE6PWUYs4kgJ+gMEe9J2BSaNWRLvAt3/uAsr7PYMB2hPibj3YTVCquQxzwHDkj7RG0el6hzzCzCL6/du9ADWbMEUlGSmVW6zpIPdm88OaB7EWA/abdEX0u4jK2kSnBhrxE0gCbd+PJwpkuBVvhP8oQx2LC3sDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741702807; c=relaxed/simple;
	bh=cmoBnmYROyr1vTCfbv4khA9GTiVhMeUO3b4dsrEgK2k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=tlmHTH/wQPaSDgU8ieWf8GuCnW3qqsBX8GTLBFl2TAN2aaPK+qim4l2dsKZxGmKwZt/+gB2clbR+jcrSpeUJb/ehBcfts8WRCpscmhkhKnPX7K3ewDNSqNu0KuSroxQ80PSZcSwLfXNO7ihaYMtpw7IGLWJ4lFfPaGZbKcIzTnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=eLRiegRk; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-43cfa7e7f54so13384685e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 07:20:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1741702804; x=1742307604; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=m6ajwEUDxB1mv9ikaPpTiM6Af18J/u+Q+MVbC1QE0kg=;
        b=eLRiegRksI9Uxv1YZkjHfGpeJ8HRV0TWWaze5yRX6WIth78wd7Z53z4jlG1fCJJiT2
         CZq11pQbBgWOgimHvCPamBeBnK3QvDUIA7OAIwclE/gbxsStYkVgh5fnuHkCSDQKlgQG
         e4v8DSqVCaBYd5zCqyLdORlbv/XSU3vZ6PqD/5SJv45fQSDzPVeLepPXQNmKrjOd+jfs
         Zuai9OAEDzw+R0lu9o39RHIXGZYiBMiCcU7pGmg8982NOV2HVRDUhzAZCls+80/fm3qK
         lgWZsK971zQOIeQfjZGyx2ZR8ujcYgLkfpbrn26qQqxTkWtqi4XKCsQ98dujzDM+WahJ
         Odjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741702804; x=1742307604;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=m6ajwEUDxB1mv9ikaPpTiM6Af18J/u+Q+MVbC1QE0kg=;
        b=n7MAvMmR/WZox3LtZfo+tOTtJ3QhMWV4kSacH12lwKOL3SrAGfqWh+/VNfBPCtivrf
         feTZYMY4NeOXMZXslEsh72GbD5cLIHiHIGoQx1DSNpwz8aQLklQM3IUOz3lqHgBA7/xu
         nUnPMr4ttuJbiOH8BWbWqoWYpjbcKR1CaqzJ7GbmEGAFOuq3n6cOMq/Ozrz0b42hqxmR
         PxyWTO40acqNPiLJQkvkpPANj6TxHBptG//GiTl5TZPdEh8UQYjwZGGF/SVUu9m9ntTZ
         lCJSOf2v/JXlPVOBD/cul/HsqbBkK8CLqqSmBbL4DfXFw1sKbH5G2AeHQHjye/U5Ch7C
         wjCA==
X-Forwarded-Encrypted: i=1; AJvYcCXAcQWzc4UOB6P0DFICGQsNP1h7u4Xv79gB9cPz3f8KRzOdEPCIn2I89/AEP8c31Ar2U1lfkVSIfQQgFiE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3dJQ2H9NVtLvtnTvwcH+MV+O/3VpI82q5pIBH0ieStFPtn2Br
	4JLwXNfF5C2cUFpedATWdMLwVnVQz4cbMRXVGIFQQczO2fBDn0fF8q8PgFFei1LGyxcHRtophfc
	y
X-Gm-Gg: ASbGncu5BEqlfdbBB80wbTwRmGqmyupLoWRAJ3F23AIqfs8vvbMXO3xHeOWVemPcFko
	JTSYcrtZBWc0yDQXUsW6IZVJ4ZSYKrW/BLANFe/8ltOKDTX3FArCA030rKfZxUgkPBW0FvToZ+t
	LDDK2715u6psB369pkAybR6FAy0xknwdAZ2tj0kLcbYc6PSYwFprDqqBqz2qWVPBl/Q8Zc9xZEv
	GVFHNUMZ0wggR/SsNoyMyahtYB64cD53B8y6TmjchXkzvEtp3FIVCoA7gcL3gzxbzMgbOsmNRE1
	P7NjdeBq+OR6gJKZSryOTl0aBU3dmonQw9mE
X-Google-Smtp-Source: AGHT+IEC45NYHRE2fvrpMgbBacd2HbN8g4QiPFZ2DzbZrET5lw5lJdvYj+StfFG1LHsSLXOsGFsGGA==
X-Received: by 2002:a05:600c:1c22:b0:439:8634:9909 with SMTP id 5b1f17b1804b1-43d01d50313mr46305895e9.14.1741702803632;
        Tue, 11 Mar 2025 07:20:03 -0700 (PDT)
Received: from [127.0.1.1] ([2a01:cb1d:dc:7e00:5946:3143:114d:3f3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43cf85f2359sm72333765e9.27.2025.03.11.07.20.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Mar 2025 07:20:02 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Tue, 11 Mar 2025 15:19:51 +0100
Subject: [PATCH] gpiolib: don't allow setting values on input lines
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250311-gpio-set-check-output-v1-1-d971bca9e6fa@linaro.org>
X-B4-Tracking: v=1; b=H4sIAIZG0GcC/x3MQQqAIBBA0avErBtolKC6SrQIm3QIUtQikO6et
 HyL/wskjsIJpqZA5FuS+LOC2gaMW0/LKFs1qE71nSZCG8Rj4ozGsTnQXzlcGQetyNDQjytrqG2
 IvMvzf+flfT/CfOfWZwAAAA==
To: Bartosz Golaszewski <brgl@bgdev.pl>, Kent Gibson <warthog618@gmail.com>, 
 Linus Walleij <linus.walleij@linaro.org>, 
 Matti Vaittinen <mazziesaccount@gmail.com>
Cc: linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=3338;
 i=bartosz.golaszewski@linaro.org; h=from:subject:message-id;
 bh=5ZfF6iWBiiBJbZn8mf1Ew+4qYOUTKuHr1XALe0cVmmw=;
 b=owEBbQKS/ZANAwAKARGnLqAUcddyAcsmYgBn0EaSIs8WFMJ8+wZxg6gDL1dsFCswJ1bNWBZJI
 EhaRPwwkvSJAjMEAAEKAB0WIQQWnetsC8PEYBPSx58Rpy6gFHHXcgUCZ9BGkgAKCRARpy6gFHHX
 ckBLD/9pQ4RFnqUq3lijtQHM0IdgfpAFUF36AKwikYFe4Uh1PNZkTrpyUnFq1jcBjupqvBhT2P9
 EBu0CgHkug/1CpCAHnuk33nfc9n+7BT4E+VSrknSW2eDADlBDEVXRifHFEZPqb49ySZYOFtF+Kr
 GvbD7pxXymDXg+78fo8xhJZCg5cc62jmE94nhccwC7ii/5bEVCTgk7uGVKw4SYIuxfKUChan6Q4
 h3kzJ8+MdtWuhhf6UWP3j2F3CpL5JsizVg3g3RF2HLl/HlfYjJugTJYNCeEYkl3loUp3TaHl7Ws
 ifBMowBJmB1H59dFzJNcwPrpzeylUOa+Qqo7Zl65e0EKrO1Llid/SXGRQsOv40znTZK68O2AuM+
 s0wwONBorZNoRbPUH9IU+PYQfN9dHi64iAT4xzoqrR6TakGlFJBP9fLPn0Kh37CWl4WRtgh1SqQ
 uIy97acYi7j6sxmHY+qRiW+5Hx2u1As0zkAL/6ap6OILniF15UjTCpJdzhoeaWwHhdqMJ+HTt1f
 8WDB3gn4Aw46phcebyBge6XXa/HQZnWpJn6XJBYT5J4mmUmH9jyHQ/1W3Ru9U5UFXe33ZvZcQgR
 zg7GBJPo97uOOUxKZidfDm9eixvZOdSQMrm7J8n7ZIawZY1lxwak7sA94pl+9cu4P6d/x2XOrgT
 kMcSVNcjbtTASzQ==
X-Developer-Key: i=bartosz.golaszewski@linaro.org; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Some drivers as well as the character device and sysfs code check
whether the line actually is in output mode before allowing the user to
set a value.

However, GPIO value setters now return integer values and can indicate
failures. This allows us to move these checks into the core code.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/gpio/gpiolib-cdev.c  |  3 ---
 drivers/gpio/gpiolib-sysfs.c | 12 +++++-------
 drivers/gpio/gpiolib.c       | 12 ++++++++++++
 3 files changed, 17 insertions(+), 10 deletions(-)

diff --git a/drivers/gpio/gpiolib-cdev.c b/drivers/gpio/gpiolib-cdev.c
index 40f76a90fd7d..8da9c28d57f6 100644
--- a/drivers/gpio/gpiolib-cdev.c
+++ b/drivers/gpio/gpiolib-cdev.c
@@ -1366,9 +1366,6 @@ static long linereq_set_values(struct linereq *lr, void __user *ip)
 	/* scan requested lines to determine the subset to be set */
 	for (num_set = 0, i = 0; i < lr->num_lines; i++) {
 		if (lv.mask & BIT_ULL(i)) {
-			/* setting inputs is not allowed */
-			if (!test_bit(FLAG_IS_OUT, &lr->lines[i].desc->flags))
-				return -EPERM;
 			/* add to compacted values */
 			if (lv.bits & BIT_ULL(i))
 				__set_bit(num_set, vals);
diff --git a/drivers/gpio/gpiolib-sysfs.c b/drivers/gpio/gpiolib-sysfs.c
index 1acfa43bf1ab..4a3aa09dad9d 100644
--- a/drivers/gpio/gpiolib-sysfs.c
+++ b/drivers/gpio/gpiolib-sysfs.c
@@ -134,16 +134,14 @@ static ssize_t value_store(struct device *dev,
 	long value;
 
 	status = kstrtol(buf, 0, &value);
-
-	guard(mutex)(&data->mutex);
-
-	if (!test_bit(FLAG_IS_OUT, &desc->flags))
-		return -EPERM;
-
 	if (status)
 		return status;
 
-	gpiod_set_value_cansleep(desc, value);
+	guard(mutex)(&data->mutex);
+
+	status = gpiod_set_value_cansleep(desc, value);
+	if (status)
+		return status;
 
 	return size;
 }
diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index e5eb3f0ee071..a4b746e80e57 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -3592,6 +3592,9 @@ static int gpio_set_open_source_value_commit(struct gpio_desc *desc, bool value)
 
 static int gpiod_set_raw_value_commit(struct gpio_desc *desc, bool value)
 {
+	if (unlikely(!test_bit(FLAG_IS_OUT, &desc->flags)))
+		return -EPERM;
+
 	CLASS(gpio_chip_guard, guard)(desc);
 	if (!guard.gc)
 		return -ENODEV;
@@ -3663,6 +3666,12 @@ int gpiod_set_array_value_complex(bool raw, bool can_sleep,
 		if (!can_sleep)
 			WARN_ON(array_info->gdev->can_sleep);
 
+		for (i = 0; i < array_size; i++) {
+			if (unlikely(!test_bit(FLAG_IS_OUT,
+					       &desc_array[i]->flags)))
+				return -EPERM;
+		}
+
 		guard(srcu)(&array_info->gdev->srcu);
 		gc = srcu_dereference(array_info->gdev->chip,
 				      &array_info->gdev->srcu);
@@ -3722,6 +3731,9 @@ int gpiod_set_array_value_complex(bool raw, bool can_sleep,
 			int hwgpio = gpio_chip_hwgpio(desc);
 			int value = test_bit(i, value_bitmap);
 
+			if (unlikely(!test_bit(FLAG_IS_OUT, &desc->flags)))
+				return -EPERM;
+
 			/*
 			 * Pins applicable for fast input but not for
 			 * fast output processing may have been already

---
base-commit: 0a2f889128969dab41861b6e40111aa03dc57014
change-id: 20250311-gpio-set-check-output-8321c1859ae3

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@linaro.org>


