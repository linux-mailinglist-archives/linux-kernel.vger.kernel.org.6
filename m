Return-Path: <linux-kernel+bounces-334543-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D14797D88F
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Sep 2024 18:48:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 514EE1C221E6
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Sep 2024 16:48:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AA7A184543;
	Fri, 20 Sep 2024 16:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="Zz36+hBl"
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B1F4183090
	for <linux-kernel@vger.kernel.org>; Fri, 20 Sep 2024 16:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726850855; cv=none; b=FGIiW8AEhLnilCqq08QjKsIfPLuWUAcXOf9S+KBj2rsAsGE0G4GCOW3dDGXlwdbPipXGN/s6dLscLS083tI3Ib5HpurRsa0s625l63Zy+WhOL8XxV5UDAVE6eKRhJqdFbW78KsDvvYeMxd7yLgDNKSxlJwtDnaqPMYKLhCTeGfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726850855; c=relaxed/simple;
	bh=zsNq+PDcTEKGZXeuBcmGNoMaVB7tGewK0MhypO0Gu/k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ElyfnWDMMU26dy8hbHqtvcxRUCv/2EmYTqT+kalO18Jt++N1vqyNciyjvc70FJCCg7KjUKa8Zg3YqD04wtEjB413GWNs9wGEsy1IQpVwCivxwCBoA+gdeZn8g0BQXk7RRxp9LXRjglYMiQNiQ/eaonsEVXcis39ywHfXuEbJUyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=Zz36+hBl; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-37a413085cbso838655f8f.1
        for <linux-kernel@vger.kernel.org>; Fri, 20 Sep 2024 09:47:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1726850851; x=1727455651; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xvG11yWq9fBDuA1GWIjJf5XkqaA0AVG/AvWx55StoTg=;
        b=Zz36+hBl7h3Bt2s1OCAGoOlI+RC6frOWoZzz8RS8+AqZLPa3Qx0R56h66kXUYH2iZ9
         vIG0p/lvVdAAxooKxZ5HYlU3Ik5a0OPdX8E3e8UG6qOR9cJka4XTDx4r2AnJLrr1dIjv
         Vd4xMRvVUCAfBFLYqo1x7xnMJnE5bIMJDrNBjvFDTB1jt5pAk27kA1jIC4iu5OFQAimC
         YZD4X2vq3z6+sCSVmToVgsSocvz1OruqnYebWdbb/UHTzIxVkVDAQHj2eHeH30wShkYY
         1AOEPydKrcuZjzlpQL1HgYQr/RXlihgfl5nmb7u8TiihV976IQwU+D62DvNFAusA5T5M
         sXLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726850851; x=1727455651;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xvG11yWq9fBDuA1GWIjJf5XkqaA0AVG/AvWx55StoTg=;
        b=H8rIOmlWtzOD386hDBlcrMc0JbeCmPuOE/X8XHe6Bi3+UJwBU/oKbf7VzrQJCdmTbI
         Je6Yo/BtBVLvfdP715iBS5TUZ1HoPsJoBy1yYuWno8NZT/qqfiJrdv2aRRXHnukaK0cT
         sl6shapT1oR1m/royVQJWhZCatl0PI0rL/uCed3dUWLmkV737QNWge7RhlSjaTTOfQp2
         g9/6b6u82V44ee6ffb0ZnA9j/mC8veSJrpgxxuHUjbewP5gpnBooflVotUsY/extRqVn
         wImGW0uN8mWQEIQFKXJZvzrmcNoxB5Lr6gQ6NxvPDpAPdVUqKDYuWH7XsahWGKCaJU2e
         uHVA==
X-Gm-Message-State: AOJu0YyHYFlirFoJuNmykgvLAtIHRasvIZDPPj3aWahsU7BL2SfIbBad
	fnEsVZ5FvFB2guBkZgZ6sgJf6FBMjMhf/dZkmMQePY1j7BGV9L1dbMMoAPwuk+o=
X-Google-Smtp-Source: AGHT+IFNfQPAgXWVZgTbiHDHxfW/w57ppwxvispcmBLKSumCGr63LrH09BizxXHzfnC2wMVwUg8w0Q==
X-Received: by 2002:a5d:5b84:0:b0:374:b6e4:16a7 with SMTP id ffacd0b85a97d-3799a1d312dmr3849296f8f.8.1726850850718;
        Fri, 20 Sep 2024 09:47:30 -0700 (PDT)
Received: from toaster.baylibre.com ([2a01:e0a:3c5:5fb1:8e69:83a7:a29a:ba83])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-378e7804476sm18172250f8f.90.2024.09.20.09.47.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Sep 2024 09:47:30 -0700 (PDT)
From: Jerome Brunet <jbrunet@baylibre.com>
Date: Fri, 20 Sep 2024 18:47:05 +0200
Subject: [PATCH 4/5] hwmon: (pmbus/core) improve handling of write
 protected regulators
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240920-pmbus-wp-v1-4-d679ef31c483@baylibre.com>
References: <20240920-pmbus-wp-v1-0-d679ef31c483@baylibre.com>
In-Reply-To: <20240920-pmbus-wp-v1-0-d679ef31c483@baylibre.com>
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>, 
 Jonathan Corbet <corbet@lwn.net>
Cc: linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org, 
 linux-doc@vger.kernel.org, Jerome Brunet <jbrunet@baylibre.com>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=4754; i=jbrunet@baylibre.com;
 h=from:subject:message-id; bh=zsNq+PDcTEKGZXeuBcmGNoMaVB7tGewK0MhypO0Gu/k=;
 b=owEBbAKT/ZANAwAKAeb8Dxw38tqFAcsmYgBm7acbao3zIvXqaNheqeFc3p0DmPTEMe5MluMfx
 h7HTttOKFWJAjIEAAEKAB0WIQT04VmuGPP1bV8btxvm/A8cN/LahQUCZu2nGwAKCRDm/A8cN/La
 hRTdD/jpC8QdC54NzWDrfJ2/jk4ANYii+AlBOJ3MNcMKC4CU+IMtZ9ACXEJiesnQK8dTHY/wWrY
 UZMOmA65g7/145Oh7G/pPCYXMZMSWVT888pi+TJybFg1wUp945EzXKiH3leu426uP1ZfQWQz+k7
 SBWOUAHA7ptD8H6qR5v4KxNXT5Z6h8cax7gfkySX/SvQffwk/wRtcKqD6Yc7ruVdifKWcS6PqTV
 TREAWioe298JtdrpeW7IZrYHhhB0qcXe+Js26t9vUE68Ed9UBH1UlwKcxvM9Y/iQ9PZvdAC9Dm9
 24/zJ/GAR7TvjT5b5NiXH9RBm9XHQtocSttHSP2XBIlAyrfTzS686MMZtv11VokoH4guUooL+5j
 vHDN2or35kkdjDAWFRozRYeQMqvCP0pV6nUzL3tJGsfFBgKbvmS5ucHok2DSt0bCNeQvlZHQ1p9
 oRiWIKFqVqh2qAS9TB4Bhfrx6C1b5FhIBAvmkdzXUhYG2W4o5QQPWNEs+wmPH2z4LHiQlPicTgd
 ptaLiB1o4FjAleovO84Z0xN0JybS0cI44z6B2IrMAvjbLnl6B9wV058NIYj7630C7FdBOC6LL4V
 x+5WB2JCuyTlLyo2XUz5vf7yL2ZP3aigr74nreqTi4CfXEX+B8q76CFqk9sl1zEt5xnlOUah+xl
 j6FNMIUb/UTO/
X-Developer-Key: i=jbrunet@baylibre.com; a=openpgp;
 fpr=F29F26CF27BAE1A9719AE6BDC3C92AAF3E60AED9

Writing PMBus protected registers does succeed from the smbus perspective,
even if the write is ignored by the device and a communication fault is
raised. This fault will silently be caught and cleared by pmbus irq if one
has been registered.

This means that the regulator call may return succeed although the
operation was ignored.

With this change, the operation which are not supported will be properly
flagged as such and the regulator framework won't even try to execute them.

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 drivers/hwmon/pmbus/pmbus.h      |  4 ++++
 drivers/hwmon/pmbus/pmbus_core.c | 35 ++++++++++++++++++++++++++++++++++-
 include/linux/pmbus.h            | 14 ++++++++++++++
 3 files changed, 52 insertions(+), 1 deletion(-)

diff --git a/drivers/hwmon/pmbus/pmbus.h b/drivers/hwmon/pmbus/pmbus.h
index 5d5dc774187b..76cff65f38d5 100644
--- a/drivers/hwmon/pmbus/pmbus.h
+++ b/drivers/hwmon/pmbus/pmbus.h
@@ -481,6 +481,8 @@ struct pmbus_driver_info {
 /* Regulator ops */
 
 extern const struct regulator_ops pmbus_regulator_ops;
+int pmbus_regulator_init_cb(struct regulator_dev *rdev,
+			    struct regulator_config *config);
 
 /* Macros for filling in array of struct regulator_desc */
 #define PMBUS_REGULATOR_STEP(_name, _id, _voltages, _step, _min_uV)  \
@@ -495,6 +497,7 @@ extern const struct regulator_ops pmbus_regulator_ops;
 		.n_voltages = _voltages,			\
 		.uV_step = _step,				\
 		.min_uV = _min_uV,				\
+		.init_cb = pmbus_regulator_init_cb,		\
 	}
 
 #define PMBUS_REGULATOR(_name, _id)   PMBUS_REGULATOR_STEP(_name, _id, 0, 0, 0)
@@ -510,6 +513,7 @@ extern const struct regulator_ops pmbus_regulator_ops;
 		.n_voltages = _voltages,			\
 		.uV_step = _step,				\
 		.min_uV = _min_uV,				\
+		.init_cb = pmbus_regulator_init_cb,		\
 	}
 
 #define PMBUS_REGULATOR_ONE(_name)   PMBUS_REGULATOR_STEP_ONE(_name, 0, 0, 0)
diff --git a/drivers/hwmon/pmbus/pmbus_core.c b/drivers/hwmon/pmbus/pmbus_core.c
index 82522fc9090a..363def768888 100644
--- a/drivers/hwmon/pmbus/pmbus_core.c
+++ b/drivers/hwmon/pmbus/pmbus_core.c
@@ -2714,8 +2714,21 @@ static int pmbus_init_common(struct i2c_client *client, struct pmbus_data *data,
 	if (!(data->flags & PMBUS_NO_WRITE_PROTECT)) {
 		ret = _pmbus_read_byte_data(client, 0xff, PMBUS_WRITE_PROTECT);
 
-		if (ret > 0 && (ret & PB_WP_ANY))
+		switch (ret) {
+		case PB_WP_ALL:
+			data->flags |= PMBUS_OP_PROTECTED;
+			fallthrough;
+		case PB_WP_OP:
+			data->flags |= PMBUS_VOUT_PROTECTED;
+			fallthrough;
+		case PB_WP_VOUT:
 			data->flags |= PMBUS_WRITE_PROTECTED | PMBUS_SKIP_STATUS_CHECK;
+			break;
+
+		default:
+			/* Ignore manufacturer specific and invalid as well as errors */
+			break;
+		}
 	}
 
 	if (data->info->pages)
@@ -3172,8 +3185,12 @@ static int pmbus_regulator_list_voltage(struct regulator_dev *rdev,
 {
 	struct device *dev = rdev_get_dev(rdev);
 	struct i2c_client *client = to_i2c_client(dev->parent);
+	struct pmbus_data *data = i2c_get_clientdata(client);
 	int val, low, high;
 
+	if (data->flags & PMBUS_VOUT_PROTECTED)
+		return 0;
+
 	if (selector >= rdev->desc->n_voltages ||
 	    selector < rdev->desc->linear_min_sel)
 		return -EINVAL;
@@ -3208,6 +3225,22 @@ const struct regulator_ops pmbus_regulator_ops = {
 };
 EXPORT_SYMBOL_NS_GPL(pmbus_regulator_ops, PMBUS);
 
+int pmbus_regulator_init_cb(struct regulator_dev *rdev,
+			    struct regulator_config *config)
+{
+	struct pmbus_data *data = config->driver_data;
+	struct regulation_constraints *constraints = rdev->constraints;
+
+	if (data->flags & PMBUS_OP_PROTECTED)
+		constraints->valid_ops_mask &= ~REGULATOR_CHANGE_STATUS;
+
+	if (data->flags & PMBUS_VOUT_PROTECTED)
+		constraints->valid_ops_mask &= ~REGULATOR_CHANGE_VOLTAGE;
+
+	return 0;
+}
+EXPORT_SYMBOL_NS_GPL(pmbus_regulator_init_cb, PMBUS);
+
 static int pmbus_regulator_register(struct pmbus_data *data)
 {
 	struct device *dev = data->dev;
diff --git a/include/linux/pmbus.h b/include/linux/pmbus.h
index fa9f08164c36..884040e1383b 100644
--- a/include/linux/pmbus.h
+++ b/include/linux/pmbus.h
@@ -73,6 +73,20 @@
  */
 #define PMBUS_USE_COEFFICIENTS_CMD		BIT(5)
 
+/*
+ * PMBUS_OP_PROTECTED
+ * Set if the chip OPERATION command is protected and protection is not
+ * determined by the standard WRITE_PROTECT command.
+ */
+#define PMBUS_OP_PROTECTED			BIT(6)
+
+/*
+ * PMBUS_VOUT_PROTECTED
+ * Set if the chip VOUT_COMMAND command is protected and protection is not
+ * determined by the standard WRITE_PROTECT command.
+ */
+#define PMBUS_VOUT_PROTECTED			BIT(7)
+
 struct pmbus_platform_data {
 	u32 flags;		/* Device specific flags */
 

-- 
2.45.2


