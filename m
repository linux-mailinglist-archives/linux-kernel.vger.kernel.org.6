Return-Path: <linux-kernel+bounces-567824-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 484CCA68AD2
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 12:11:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BEFB57A22A3
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 11:10:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B1E025E463;
	Wed, 19 Mar 2025 11:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="VySlzV0L"
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C5EA25D537
	for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 11:03:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742382240; cv=none; b=Xg6hZAkeKWbCShEVvVz+IInXFiaTitk2G3YR9Sdg40bsU4tEvKF8rq0+4a3jSiimZPU9Ch+awM/AlFPrFg2JHL9pnPA2tUdiKaX4j46KF49CTy7Jtg0DB7w+WAcunOjZD73pJXjx5iaF7mpdoKiP/RVZFDqk38Fp/Q7GO8y8GA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742382240; c=relaxed/simple;
	bh=NcHfcUwCLbwHe5D53KCoWcwA4xO+xpxy4KWgV7nBxOc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=CHLf5UQuIe8/Ps3JjPB647cRhOUuMkXEgjtpPH6VMMXp34W/3fB8kSyXIKkPAfjGfE4McrqYZ/smZ2esOs9ALDVhkqYmkhTLKHbVM5aMQDPLisHvzM3LfI7eFoBIvRFdIHbWkuVFGguft3KKZiHz3UJRiL81HZHMSQMdRXS0dLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=VySlzV0L; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-ac2963dc379so1141362866b.2
        for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 04:03:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1742382235; x=1742987035; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2I1CmNXU0vxFsOEAZFuw8IP7FJqaRF8yVBtpLAFgrXA=;
        b=VySlzV0L2DPmw+O1Qnx0uQxT9JajZ7IxMqAvfJr27AnYt5bw9RtGiA23HiA/tfTThU
         kuJ+UFw567LP7fCuRzriHLULUNIzX/Ch0rFjZx1GnduolsAdwWhjbB11Rpa43MkmUN3Y
         WU7y8wUWl25MbUfwvuaHQxKhQDE+aoZ99W9o0IDHBeGoj0rIUft4cvPU/F4BLeDcM+Sr
         PDeGnX+Qjlfrn+Hn26mt1ika/F41a7TwOc2FQhM4bFIhiFNjByFIVoQ0m/4hCmN7KK95
         DtGYAd6QCwXIoIhpgZv6Z8j/NLn5/wm4+FuTv2+KHwH4sb1stuRzk79PppmHqAVSquBE
         yxxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742382235; x=1742987035;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2I1CmNXU0vxFsOEAZFuw8IP7FJqaRF8yVBtpLAFgrXA=;
        b=bRi3z/uSYh+ky+Uy68tX6h0+P+jngedeBHHfDPHWZ9bb+sPyDGLNbr3xZhKGuQQoln
         m6zNnNhnhhsQvV/CNj917xrYFwO1HKIogt2b1eSaQou1h0gBEk/HuNKWedkDgV5wI8KY
         tfwe7qcIkfMSZVWmkCFegwacunk4iPhbOS9odm+UHVXoNaP7razK/vUJpfi8liKkDpoJ
         DF+yMqmmSaanQSCsuAh/UYafCq9dBsoQ7OOb/635vTpHJid3oWdX+5h5cAp61+B3yoYm
         t9PznNVOi9ygmEBBMn3sieUPA5Tr/HTlTFccUh7JeGpz1bqr211kXV9hWrCpXwNWXZC3
         2IHg==
X-Forwarded-Encrypted: i=1; AJvYcCUwdd5lpwluMcCBryQi4XVR3V862nT395rJ/4SAsqaK/XwVRJQcIEHL90sOgR0UAHEkrXeCjkJASft/fHI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzhRAUn4SF1gMUl+OK4X/VCiWm39FLPmnoXI1WrvcgxFp9Te5ca
	Mo+H/MihfVmXxwupYeHUUTM5JQGBuvmeIgayT2CDohiy806skiR6U3Pf5OSUOkLo2JTvZuVw+DV
	u
X-Gm-Gg: ASbGncsUqIuLjNXPJvBpvDp/+Nb0GF1U0UM2u0cnor46drgNxuyhTA/IuX5WYzEQVeD
	WubHd8ULvgshWpbPh0NoHEh6taN0Q6gzTAbhOCukjU12+doP4KajIQKBQX5p0v4rx3KQquk/G6J
	MjGLIRGckXxj9wsPwqDC6/AQzuD4ZbSh76818nZ0nPqXOmaWYO/mTc++OE9wBTwApWJ92g/DXAJ
	ml/SDnLIVMQBFFn1AnXPJaUn9Sm9TrtoKoQUfbg1RPkKUZNd6QPKOO3qQ5j1nO8IbHcvfD6cU5C
	xZd3rfhgal3JR2k4W+C5+MLQW0BMRvQLB2KjxaNqVkIyQfz86MyfDcZ4Tg+jr1FR6hlPF+3+wy2
	wNZbu014ypdczNNSVwO5Yi52BwaNSqA==
X-Google-Smtp-Source: AGHT+IF5XKrV37A9FB390sea/EQKrs962W3+vWeOQPrhoFnDUFkHSAlBd7BcVo+cBG6QrMqMqeoB1w==
X-Received: by 2002:a17:907:7e5e:b0:abf:6ebf:5500 with SMTP id a640c23a62f3a-ac3b7c036d0mr274465366b.16.1742382234683;
        Wed, 19 Mar 2025 04:03:54 -0700 (PDT)
Received: from [127.0.1.1] (host-87-10-75-167.retail.telecomitalia.it. [87.10.75.167])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac314a47783sm1001431466b.144.2025.03.19.04.03.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Mar 2025 04:03:54 -0700 (PDT)
From: Angelo Dureghello <adureghello@baylibre.com>
X-Google-Original-From: Angelo Dureghello <adureghello@baylibre.org>
Date: Wed, 19 Mar 2025 12:02:32 +0100
Subject: [PATCH] iio: dac: ad3552r-hs: add debugfs reg access
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250319-wip-bl-ad3552r-fixes-v1-1-cf10d6fae52a@baylibre.com>
X-B4-Tracking: v=1; b=H4sIAEek2mcC/x3LQQqAIBBA0avErBtQy4VdJVpkM9ZAWChUIN09a
 fn4/AKZk3CGoSmQ+JIsR6zQbQPLNseVUagajDJWddrhLSf6HWfqrDUJgzycsQ/esyPSZDzU9Uz
 8h3qO0/t+ujBhxmYAAAA=
X-Change-ID: 20250319-wip-bl-ad3552r-fixes-4fbbe9dd1d2b
To: Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Angelo Dureghello <adureghello@baylibre.com>
X-Mailer: b4 0.14.2

From: Angelo Dureghello <adureghello@baylibre.com>

Add debugfs register access.

Signed-off-by: Angelo Dureghello <adureghello@baylibre.com>
---
 drivers/iio/dac/ad3552r-hs.c | 31 +++++++++++++++++++++++++++++++
 drivers/iio/dac/ad3552r.h    |  2 ++
 2 files changed, 33 insertions(+)

diff --git a/drivers/iio/dac/ad3552r-hs.c b/drivers/iio/dac/ad3552r-hs.c
index cd8dabb60c5548780f0fce5d1b68c494cd71321d..7bb6d8817a545f16de9432526ae28787af1a0146 100644
--- a/drivers/iio/dac/ad3552r-hs.c
+++ b/drivers/iio/dac/ad3552r-hs.c
@@ -7,6 +7,7 @@
  */
 
 #include <linux/bitfield.h>
+#include <linux/debugfs.h>
 #include <linux/delay.h>
 #include <linux/gpio/consumer.h>
 #include <linux/iio/backend.h>
@@ -56,6 +57,15 @@ struct ad3552r_hs_state {
 	u32 config_d;
 };
 
+static int ad3552r_hs_get_reg_length(unsigned int reg)
+{
+	/*
+	 * There is no 3 or 4 bytes r/w len possible in HDL, so keeping 2
+	 * also for the 24bit area.
+	 */
+	return (reg > AD3552R_SECONDARY_REGION_START) ? 2 : 1;
+}
+
 static int ad3552r_hs_reg_read(struct ad3552r_hs_state *st, u32 reg, u32 *val,
 			       size_t xfer_size)
 {
@@ -464,6 +474,26 @@ static int ad3552r_hs_setup_custom_gain(struct ad3552r_hs_state *st,
 				      gain, 1);
 }
 
+static int ad3552r_hs_reg_access(struct iio_dev *indio_dev, unsigned int reg,
+				 unsigned int writeval, unsigned int *readval)
+{
+	struct ad3552r_hs_state *st = iio_priv(indio_dev);
+	int size_xfer, max_reg_addr;
+
+	max_reg_addr = (st->model_data->num_hw_channels == 2) ?
+			AD3552R_REG_ADDR_MAX : AD3551R_REG_ADDR_MAX;
+
+	if (reg > max_reg_addr)
+		return -EINVAL;
+
+	size_xfer = ad3552r_hs_get_reg_length(reg);
+
+	if (readval)
+		return ad3552r_hs_reg_read(st, reg, readval, size_xfer);
+
+	return st->data->bus_reg_write(st->back, reg, writeval, size_xfer);
+}
+
 static int ad3552r_hs_setup(struct ad3552r_hs_state *st)
 {
 	u16 id;
@@ -639,6 +669,7 @@ static const struct iio_chan_spec ad3552r_hs_channels[] = {
 static const struct iio_info ad3552r_hs_info = {
 	.read_raw = &ad3552r_hs_read_raw,
 	.write_raw = &ad3552r_hs_write_raw,
+	.debugfs_reg_access = &ad3552r_hs_reg_access,
 };
 
 static int ad3552r_hs_probe(struct platform_device *pdev)
diff --git a/drivers/iio/dac/ad3552r.h b/drivers/iio/dac/ad3552r.h
index 768fa264d39e9e6d517aeb4098382e072f153543..69ce96f132cdb353d2f140939c534586cb791aee 100644
--- a/drivers/iio/dac/ad3552r.h
+++ b/drivers/iio/dac/ad3552r.h
@@ -113,6 +113,8 @@
 #define AD3552R_REG_ADDR_INPUT_PAGE_MASK_24B		0x44
 #define AD3552R_REG_ADDR_SW_LDAC_24B			0x45
 #define AD3552R_REG_ADDR_CH_INPUT_24B(ch)		(0x4B - (1 - (ch)) * 3)
+#define AD3551R_REG_ADDR_MAX				0x46
+#define AD3552R_REG_ADDR_MAX				0x49
 
 #define AD3552R_MAX_CH					2
 #define AD3552R_MASK_CH(ch)				BIT(ch)

---
base-commit: 6f9141cdd726e82d209b5fc6d6b5ea32ace339f1
change-id: 20250319-wip-bl-ad3552r-fixes-4fbbe9dd1d2b

Best regards,
-- 
Angelo Dureghello <adureghello@baylibre.com>


