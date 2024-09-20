Return-Path: <linux-kernel+bounces-334544-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A083F97D891
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Sep 2024 18:48:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C4DF11C21EEC
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Sep 2024 16:48:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FA3D184559;
	Fri, 20 Sep 2024 16:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="Am13g7Pp"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A216F183CA1
	for <linux-kernel@vger.kernel.org>; Fri, 20 Sep 2024 16:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726850855; cv=none; b=ZC2xm06jpsqakPljAbdbZ5OPmw6c+btg+C7GRqSeqrM/jFS56NRvLvdi7AlEcYUfyyLOEbLMySzGVxOszjVVZXjxlpUjlQ4+g/M2+teK3mwDyjNLs+po0+1FENomGiHyrIMZfT+HcL+9zrmwwEMZAkOWA3GBCQE8hzStgN71A2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726850855; c=relaxed/simple;
	bh=CjFFhc9MMW49VE8u5F61A8xLqeMREhaJD452w7fqvfs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QkKrwm3j4vm+n3ciAbijYTVlRNXrp8iq5G0LbXHYVmlCPiZmThX4aez/Pr/Jnr8wO1txCRkd4QKeiS6/LZvpToloh+6nkIDWt7ZMjsvEp8jNpzO8jH12WjefEbDt7VcolrjdnNmf+euKavc+DFROd64wiaNXUdszEzxTOznCnTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=Am13g7Pp; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-42cc43454d5so18170335e9.3
        for <linux-kernel@vger.kernel.org>; Fri, 20 Sep 2024 09:47:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1726850852; x=1727455652; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9qllhEfwvR3O4kFWcLK8tY64jimzQys29VMp9CXwNVU=;
        b=Am13g7Pp4Th2TNYl0OmOU3HxwArqkgR04NFH39lh+mBc4t76MgCfvoXI7UMAaco9Ec
         ExnvAtOQjmlyYezI4+edKQ5yeCeb4wk8Vq15yjjIOt2WmI0v2x/nRAVcoCgoh8KyUsy0
         DEOHVeeg42z9FOsdxESzvV2IU6CAyY7MZsdtoEfHMyFt0iltrY0uUxmxPuF18ZKwXHLN
         OfaBNgcf5LqGs1fpdbIMeGX4kKtMhYITFRMK4lpaxDnUcF2+FNYxaN01OdUvSwjC/KG2
         vKYlbXM1b3WZJK8ipM6c7seqWy49GoZJ0wDbvnL5QkaPh67b50SzpHdNqBegC5U6N/UY
         iZRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726850852; x=1727455652;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9qllhEfwvR3O4kFWcLK8tY64jimzQys29VMp9CXwNVU=;
        b=C/t1+D+uZpgFQVhqLw5oN/xwdmwEwr9v/dxVHEiAGFQpyrAAM0pcSJkuVeZ05Il8Th
         jG6I7kB5BOzDKqhG0Zhsbi4kyTmczZvkE6DHYCuoaWI4KCExqoNagLyS8SsKB3BP3SAI
         QYprPZx8wiRboIwCsm3gyYwjFVpJTk2zzYSI0/uzu2ZelQhSt+navR4zbvVOj9EiP4Bg
         gdz5JAs60NgDn1KTrUMBKyd7JpncK2HXsyEZUIkgQsM2CnCQa1E3NtKFs/LPb0fmGet7
         Wc8gQx8m9Td/NBDGoSzJBc8cpG5tl97SxfjiFbl70CNw+Y2Y9sd5ZfyQ4Yxj798K6Ert
         ZhyQ==
X-Gm-Message-State: AOJu0YwT+80n48y4hZkwowWCI1GzLSyfINAmJTXpytzgLKOYlAyHPAJY
	TQbOkbiToMY0TZvExaXHakUrNssXq7Dn04cV86iRG2y8XLax2Exnc/kTRH75AGc=
X-Google-Smtp-Source: AGHT+IEt0mM17T+QkgiiYQ9Xi5bCM7DZKFGhbLt/nTTYRXLtk0K+n3YEG7uPcLIhjOVfXQUGSIfHYw==
X-Received: by 2002:a05:600c:4f0c:b0:42c:a7cc:cb64 with SMTP id 5b1f17b1804b1-42e7abe4424mr26563375e9.3.1726850851917;
        Fri, 20 Sep 2024 09:47:31 -0700 (PDT)
Received: from toaster.baylibre.com ([2a01:e0a:3c5:5fb1:8e69:83a7:a29a:ba83])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-378e7804476sm18172250f8f.90.2024.09.20.09.47.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Sep 2024 09:47:31 -0700 (PDT)
From: Jerome Brunet <jbrunet@baylibre.com>
Date: Fri, 20 Sep 2024 18:47:06 +0200
Subject: [PATCH 5/5] hwmon: (pmbus/core) add wp module param
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240920-pmbus-wp-v1-5-d679ef31c483@baylibre.com>
References: <20240920-pmbus-wp-v1-0-d679ef31c483@baylibre.com>
In-Reply-To: <20240920-pmbus-wp-v1-0-d679ef31c483@baylibre.com>
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>, 
 Jonathan Corbet <corbet@lwn.net>
Cc: linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org, 
 linux-doc@vger.kernel.org, Jerome Brunet <jbrunet@baylibre.com>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=4312; i=jbrunet@baylibre.com;
 h=from:subject:message-id; bh=CjFFhc9MMW49VE8u5F61A8xLqeMREhaJD452w7fqvfs=;
 b=owEBbQKS/ZANAwAKAeb8Dxw38tqFAcsmYgBm7accgwF3pAoGMadS0uLmPG3TjPnHKaehiS7BO
 q/wHo52nMaJAjMEAAEKAB0WIQT04VmuGPP1bV8btxvm/A8cN/LahQUCZu2nHAAKCRDm/A8cN/La
 hTCCD/9bQZablXDI+t6T4xSNVQA9V6jPgrq8Mwr4Qdn3Sb1S6l7rmjLjRCZ+ukYqm8JfNaQjtiU
 b/z1f1CS+g84eBFCphG1xjCrgNoVAtVToR2fPbE4ugvqFAFeq8VoTKrxh9cbnz7JwrJRtZ16TGM
 MRPPglExlRbgQcbWfVOMaxa+83bdubMwNqDtWnfmVb+zW57F/iKyAsqka+1PqaZsozpWBvsB7Ak
 +ePVvPOkkGVT1XtwmeCF4x0vs5PuFIWMZ4ct6Qlca8UVSpLocVwkZ3b1L3cDYjdX3hLMODXsI9+
 FwcFiNICY75flV9AcriBS3MiPR9vCjWW4vGYIwSAw4/sRfXtwuUWcQyI3rwtKj5uAkp3Oj4DxCR
 xgwXtj79YOWkfADhVBaB+4i8cLTSIfJlpcYvowhfZKEOUXsuA10cuVr9+ZskgpLVPGDRJd2A2et
 GOEXHuMdd7xibOoNCypCxEASsGAnz983G0+HkvudeN++D1tv+uyYbxENUa58aXU1cZdMU91gcwO
 eZvu5FPf/jeZ2B+kRTLwiabTcqhdP0VU+xIPB2jp/QMxcULFZQtW7nsnjHRj+gSBGShnZmvUA0F
 leJizcwQ/QM9NaCjS8AsaRY74u1TRTTLZd5IrtNIHYGNRuGStjuLIAuOqnmRzftdBi7VKWdonVA
 INERHNsw978xEAQ==
X-Developer-Key: i=jbrunet@baylibre.com; a=openpgp;
 fpr=F29F26CF27BAE1A9719AE6BDC3C92AAF3E60AED9

Add a module parameter to force the write protection mode of pmbus chips.

2 protections modes are provided to start with:
* 0: Remove the write protection if possible
* 1: Enable full write protection if possible

Of course, if the parameter is not provided, the default write protection
status of the pmbus chips is left untouched.

Suggested-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 Documentation/admin-guide/kernel-parameters.txt |  4 ++
 drivers/hwmon/pmbus/pmbus_core.c                | 74 ++++++++++++++++++-------
 2 files changed, 59 insertions(+), 19 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 09126bb8cc9f..e41d13f46140 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -4672,6 +4672,10 @@
 			Format: { parport<nr> | timid | 0 }
 			See also Documentation/admin-guide/parport.rst.
 
+	pmbus.wp=	[HW] PMBus Chips write protection forced mode
+			Format: { 0 | 1 }
+			See drivers/hwmon/pmbus/pmbus_core.c
+
 	pmtmr=		[X86] Manual setup of pmtmr I/O Port.
 			Override pmtimer IOPort with a hex value.
 			e.g. pmtmr=0x508
diff --git a/drivers/hwmon/pmbus/pmbus_core.c b/drivers/hwmon/pmbus/pmbus_core.c
index 363def768888..ca5803bfd24a 100644
--- a/drivers/hwmon/pmbus/pmbus_core.c
+++ b/drivers/hwmon/pmbus/pmbus_core.c
@@ -31,6 +31,20 @@
 #define PMBUS_ATTR_ALLOC_SIZE	32
 #define PMBUS_NAME_SIZE		24
 
+/*
+ * PMBus write protect forced mode:
+ * PMBus may come up with a variety of write protection configuration.
+ * 'pmbus_wp' may be used if a particular write protection is necessary.
+ * The ability to actually alter the protection may also depend on the chip
+ * so the actual runtime write protection configuration may differ from
+ * the requested one. pmbus_core currently support the following value:
+ * - 0: write protection removed
+ * - 1: write protection fully enabled, including OPERATION and VOUT_COMMAND
+ *      registers. Chips essentially become read-only with this.
+ */
+static int wp = -1;
+module_param(wp, int, 0444);
+
 struct pmbus_sensor {
 	struct pmbus_sensor *next;
 	char name[PMBUS_NAME_SIZE];	/* sysfs sensor name */
@@ -2658,6 +2672,45 @@ static void pmbus_remove_pec(void *dev)
 	device_remove_file(dev, &dev_attr_pec);
 }
 
+static void pmbus_init_wp(struct i2c_client *client, struct pmbus_data *data)
+{
+	int ret;
+
+	switch (wp) {
+	case 0:
+		_pmbus_write_byte_data(client, 0xff,
+				       PMBUS_WRITE_PROTECT, 0);
+		break;
+
+	case 1:
+		_pmbus_write_byte_data(client, 0xff,
+				       PMBUS_WRITE_PROTECT, PB_WP_ALL);
+		break;
+
+	default:
+		/* Ignore the other values */
+		break;
+	}
+
+	ret = _pmbus_read_byte_data(client, 0xff, PMBUS_WRITE_PROTECT);
+
+	switch (ret) {
+	case PB_WP_ALL:
+		data->flags |= PMBUS_OP_PROTECTED;
+		fallthrough;
+	case PB_WP_OP:
+		data->flags |= PMBUS_VOUT_PROTECTED;
+		fallthrough;
+	case PB_WP_VOUT:
+		data->flags |= PMBUS_WRITE_PROTECTED | PMBUS_SKIP_STATUS_CHECK;
+		break;
+
+	default:
+		/* Ignore manufacturer specific and invalid as well as errors */
+		break;
+	}
+}
+
 static int pmbus_init_common(struct i2c_client *client, struct pmbus_data *data,
 			     struct pmbus_driver_info *info)
 {
@@ -2711,25 +2764,8 @@ static int pmbus_init_common(struct i2c_client *client, struct pmbus_data *data,
 	 * faults, and we should not try it. Also, in that case, writes into
 	 * limit registers need to be disabled.
 	 */
-	if (!(data->flags & PMBUS_NO_WRITE_PROTECT)) {
-		ret = _pmbus_read_byte_data(client, 0xff, PMBUS_WRITE_PROTECT);
-
-		switch (ret) {
-		case PB_WP_ALL:
-			data->flags |= PMBUS_OP_PROTECTED;
-			fallthrough;
-		case PB_WP_OP:
-			data->flags |= PMBUS_VOUT_PROTECTED;
-			fallthrough;
-		case PB_WP_VOUT:
-			data->flags |= PMBUS_WRITE_PROTECTED | PMBUS_SKIP_STATUS_CHECK;
-			break;
-
-		default:
-			/* Ignore manufacturer specific and invalid as well as errors */
-			break;
-		}
-	}
+	if (!(data->flags & PMBUS_NO_WRITE_PROTECT))
+		pmbus_init_wp(client, data);
 
 	if (data->info->pages)
 		pmbus_clear_faults(client);

-- 
2.45.2


