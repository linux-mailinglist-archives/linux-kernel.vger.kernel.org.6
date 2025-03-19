Return-Path: <linux-kernel+bounces-568077-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CAE2DA68DDD
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 14:32:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7926C3B8D97
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 13:31:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B10372566E7;
	Wed, 19 Mar 2025 13:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="Ap5GYuAl"
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78852255224
	for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 13:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742391115; cv=none; b=kZYyoF8Zx2lKzBe/dCa+ztZ3JZzXR0MHH3y3C2a/H9dkdISo8wiULnMthH1foAXQJ141i/8+tBrQSdgCTPUaMEwm9zl31+HGp+LXpoMNNXRZvhA5Zf7cjAXC1dspu/2+47sIdsvVLumvv2WgHAeDK/dzjLClluMh0tuG/v3J788=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742391115; c=relaxed/simple;
	bh=9qiRCmD/XCESCMM/7dpS86HRNH+iD7bkRk00QdKM360=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=cSeyhk4DFqY2IFNsaOxgMItyv17EqiJKnzJk1+Xzq0nZn5zPtZ4LC/4F/iYMX+OFAhnKXmIWQejbf7Rglal/pJ2rZLBuHKVrM0ABy+0RlrIGufLYYXpc0ubUtl319eYDw7DqndKp4W6zHxL6zjlz/hio5iMhoLPPxbIn3zqlk54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=Ap5GYuAl; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5e5bc066283so9651192a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 06:31:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1742391110; x=1742995910; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=lzHbJ+a3kNpZ2LWVgT8v9kpI3XVTjp/CmEA/PKlMAZY=;
        b=Ap5GYuAlf1HoCAibVNIeEgPFFnxujSvsDArGoO+kiHraN6k3j0FTgXLINOYaU5mHKN
         ojVcdpb31TvNfqOCjpw/jewpYBABG8JeU8XvHjhFQUESFC2PUbUdOeLlyBTMsfRgqVeo
         SEI785qO3wMkYj6Vf+2RZgHgLbUiBBSyzKM2JsnFZ8sE+/H+LMwHl9VPzNkkL3bBfOb0
         UeALJDHksJxENIu0W8V0dnhkUERZUpk6dXTL2YCxFbfNbKEsvLCLnPHX/mcvYXSDTG6z
         PCWSxX/sJrF+/COTyXhCOcgraoSMxxZNn4oHdqt9UcmPCsM7mfLgAZK2nIaH/+UEqEif
         +AwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742391110; x=1742995910;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lzHbJ+a3kNpZ2LWVgT8v9kpI3XVTjp/CmEA/PKlMAZY=;
        b=p1NJzJKsFOCUV7K1asYSHrBVdwhbHsZLHlJpMWdQ6TRntI48ihT5yOxQ1n6VM45aSA
         50EKFGt/Tco9VyKqoWvvOyZGBdZz0eOyDl+dpqhgbe0lJ7+UDQvdwwqZ/vmCZEAv5LHY
         vknsNeZbvGDv3WWCJinOwxvTAtrapxVr8Sx47ROW77Tun3kfXNltAVHsJHm0xhBsW6dn
         J2fNdFYY8bllH4q3wvFtfUCTJ19i7lw0LBckoBm+Fm+9zWxejuat/k5BkVUXqHr54ZhE
         OYBmdzfPS+Th77ztJJJSPtCrIJ5yHH+NgGigI4BdNZWYcByze4ErNPEtOEBqGcWOc4ZG
         QUHA==
X-Forwarded-Encrypted: i=1; AJvYcCWwz+OlAE37Zg+Rnb5JzeGZegwcXtea4V3rkr0s5dqchiML91i8O8jRXuyXrxiAJrHtSCAwgFIavYoGSOQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxG/o0zsoCybVSUVA0Co6EFPhL/19IDQ3ZohazZ/keb0+kwhVyG
	vUHUgfj1PYW6vfGqnWevUFUG6zWGCqAYSQOP2iRU3mp5GIaZD9LeV8yaIUpdKdu77k0DuI+2Efr
	1
X-Gm-Gg: ASbGncsc1ZJWaJtEJ0utC0GbIWSa2fBLo5JzCV3Sj3CtEL9S3iHKlu29aswzoioFt2w
	0nFs/7n9MzNiVG13HvWNaQEPwtHC24Og+jFDKaK02wSv80fzH6+sX+w3NoliXpGQF6Ngs5jp4pB
	vP8QZTAlU5dHAfkPXRnaMot3vlC0aMighJLQErI2EW2zRb7yO5E9fJfK1VYiw9wsmH4YbK+Bl9x
	jBRxXZCTMtf57jxc6dQIt975yBsBylNfOewg/EWuM10LlOYhAouhCx2U+Q49j3wU5b3wP8nTI9m
	WCaT5SGKQR70X0flhYOSd1Zj5x6Zz4/TuV/FwhaQ6Y22wyfgG23SzTclfdVtLx1cyg6lVpzotxx
	kHADFKHu4Tu2gZF1iSfk=
X-Google-Smtp-Source: AGHT+IFt9KxbN3+sudW98Q6jzh3T9AtoL6/jWit3aUuDsut21tbFt7KtxucKbyyaJLaQkGlcyAWOWQ==
X-Received: by 2002:a05:6402:3513:b0:5e5:c5f5:f82 with SMTP id 4fb4d7f45d1cf-5eb80ab52c8mr2712328a12.0.1742391106316;
        Wed, 19 Mar 2025 06:31:46 -0700 (PDT)
Received: from [127.0.1.1] (host-87-10-75-167.retail.telecomitalia.it. [87.10.75.167])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5e816ad27c1sm9421159a12.59.2025.03.19.06.31.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Mar 2025 06:31:45 -0700 (PDT)
From: Angelo Dureghello <adureghello@baylibre.com>
X-Google-Original-From: Angelo Dureghello <adureghello@baylibre.org>
Date: Wed, 19 Mar 2025 14:30:28 +0100
Subject: [PATCH v2] iio: dac: ad3552r-hs: add debugfs reg access
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250319-wip-bl-ad3552r-fixes-v2-1-2656bdd6778e@baylibre.com>
X-B4-Tracking: v=1; b=H4sIAPPG2mcC/4WNTQ6CMBCFr0Jm7Zi2WBNceQ/Coj9TmQSBtKZKS
 O9u5QIuv/fyvbdDosiU4NbsEClz4mWuoE4NuNHMD0L2lUEJpUUrO3zzinZC41utVcTAH0p4CdZ
 S5730ykJV10hHUc1+qDxyei1xO16y/KV/BrNEiS5I4a/BkFbmbs02sY10dssThlLKF3GGmo67A
 AAA
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
Changes in v2:
- set reg size setup as inline.
- Link to v1: https://lore.kernel.org/r/20250319-wip-bl-ad3552r-fixes-v1-1-cf10d6fae52a@baylibre.com
---
 drivers/iio/dac/ad3552r-hs.c | 26 ++++++++++++++++++++++++++
 drivers/iio/dac/ad3552r.h    |  2 ++
 2 files changed, 28 insertions(+)

diff --git a/drivers/iio/dac/ad3552r-hs.c b/drivers/iio/dac/ad3552r-hs.c
index cd8dabb60c5548780f0fce5d1b68c494cd71321d..fdea9984547ae338a51c4671024133be82ed854f 100644
--- a/drivers/iio/dac/ad3552r-hs.c
+++ b/drivers/iio/dac/ad3552r-hs.c
@@ -7,6 +7,7 @@
  */
 
 #include <linux/bitfield.h>
+#include <linux/debugfs.h>
 #include <linux/delay.h>
 #include <linux/gpio/consumer.h>
 #include <linux/iio/backend.h>
@@ -464,6 +465,30 @@ static int ad3552r_hs_setup_custom_gain(struct ad3552r_hs_state *st,
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
+	/*
+	 * There is no 3 or 4 bytes r/w len possible in HDL, so keeping 2
+	 * also for the 24bit area.
+	 */
+	size_xfer = (reg > AD3552R_SECONDARY_REGION_START) ? 2 : 1;
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
@@ -639,6 +664,7 @@ static const struct iio_chan_spec ad3552r_hs_channels[] = {
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


