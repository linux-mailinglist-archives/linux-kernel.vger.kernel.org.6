Return-Path: <linux-kernel+bounces-567037-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 54BFFA6801D
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 23:56:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6050E17F9FA
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 22:54:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAF72215171;
	Tue, 18 Mar 2025 22:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="2ZH0bW/A"
Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58561211A1E
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 22:52:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742338355; cv=none; b=cL/08uuLqZGz7bCrqcLweef77pzATSHBkdblFsZF7/iKIQLKznStsmWOyaQNTzV6eXnStKNjeyoErAUZdHWwnBhTt9Z6y+65S2Xz0Ea7M2FLYXbx1cyCfk6dPhDzI/lufL8A3UZWoJUB3m3TaHhWPrHZKueKXuayoscR6nMp+no=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742338355; c=relaxed/simple;
	bh=kM+k5AQriGEQF4EjhCiLnSRLo7GvLPAK1dzRegvKVGo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ijxiuEMM1///3FBytRNWGV78wnI/P5Wpa3DP22a93os0n7VCmhlKKr7UgjCagUtmudUNUQMJC0Z27wo3vvZMOh84mv6T7GvB37tmD6Ev50R1vZLWdoVGtAG9aKU13ZqNY/x03ZNRyDYmqI6lC6nttZH0MhWKuHmUqo16eKQftog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=2ZH0bW/A; arc=none smtp.client-ip=209.85.210.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-72bceb93f2fso84183a34.0
        for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 15:52:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1742338352; x=1742943152; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ttzqhRfuW1j8Jj5xatxxwRwR97+YJSALRqNQY7//6rw=;
        b=2ZH0bW/AuiC51LZA1APyzO6+1my3EM9ekOKTmPJKZyLG2Ye80yMZCcPBmz1TM0PA90
         8JfrkUObwbhLTz8U7j5iJk1gco8L3JZXMs2MLWtNMBOYSqeTAHdZneIZ/9pntAkKawA+
         6PA+3W7FRje8NoywxqdDRdBzocFjkI+LvYWxINWP405zCUqYc/MfBKqbVFMaGCsoI9pA
         AEMGNU+jFzz6uhXRhiois8HFMsj+mH6aPRc9wB1e5yk+TooJfhNXh+B88tgKAri/P8Er
         X5NeHfp4SlmkOlXpocA5fWPYhn4yuLD/cAE7ijKApoILK/DxIuP1Lg/bcZau56ZFpPBi
         C8mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742338352; x=1742943152;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ttzqhRfuW1j8Jj5xatxxwRwR97+YJSALRqNQY7//6rw=;
        b=FLlu16emvlK/x9X8QoZfcsS1PBG1e2Wz3npHjaqLP3FXU5Zf4u9+/VC2ODf+wo/ldb
         zTn7jUsKWa71n5jUXRc62jv+Dm9VWZMUfmLI+9yi6ZkmO2SVxmRKlrA7PEvirdJZRuLm
         893MfV3l0C4Cr0HU3WQe1j043foUiCN5s4fE++PRxno+ePxhYub2qXEWGy1UEtXdv67b
         nAbZFNoq+y+iCLj5O64oJGVVhkn2KuXx2pDfkRtrfUpf+IZOAVSzr5BLb0ZKi34RN64k
         sZftM8XolRUBqb1tDN1txfZSIKRWJYmFQ2Yk6IBB8aaw7Gc/+5HK6sq3/zAKaZw+0O6Q
         0yig==
X-Forwarded-Encrypted: i=1; AJvYcCWCoHd7NwN8MW2dX6T9xUrd7qU54mPwAFjrqgESMQ3kLod+GXZbu846jUGmjbXVuRfug2aWvJimDx82rZE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyrj/mtOZKK+nr2WGdkP/AaeegvblzdtxHQbwINUbqNo2ba6lnh
	vZEuLf0F2X/gKQeAytMntNWXMmHaJZYyNcbDaYGn1fUQWy1poNgUyN2VMo6mGJM=
X-Gm-Gg: ASbGncujBWItMiz4f2hc//GNsJywIB5LdqOHIQPyVoLxP/dQfzVZAcjB9vZ4sWf+ORc
	vJEbiRmWDzwsVdFN9AqdBJb1czINFB7T8C0cS9PimFhWh76AyB33YLRA+cJKysSvmTrh04liebC
	xemyHTxNg+0kthtTHX1xifmbyOezQuFsUc0zmgXE+VN1qkxx5eSJH07Al0Ge1/vummOXb823Eqd
	XmywWj1tKTPFU3sJUb4yw9EG6YgYEprjn71r4Ctyt5aQML4wkj6vkRzaMjaaIieJa0DPSwAhtCO
	NoDBPWIgqL2RmopSXSKjtFU/doS+t6LSRR4KEQ18atZKE2pNXkGgWOi9Eybyz8oj45jiw2TRozH
	e
X-Google-Smtp-Source: AGHT+IF23n+Eb/NK7sCDA9N/jZFII8yjWuc4vEkdMAkKMnop1OrsXpDOG/2CjJ/+bL0dRFjzNPLwWg==
X-Received: by 2002:a05:6830:381b:b0:72b:974f:de49 with SMTP id 46e09a7af769-72bfc10c94dmr380936a34.7.1742338352458;
        Tue, 18 Mar 2025 15:52:32 -0700 (PDT)
Received: from [127.0.1.1] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-72bb274e95dsm2191690a34.52.2025.03.18.15.52.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Mar 2025 15:52:32 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Tue, 18 Mar 2025 17:52:18 -0500
Subject: [PATCH v2 10/10] iio: adc: ad7606_par: add ad7606c chips
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250318-iio-adc-ad7606-improvements-v2-10-4b605427774c@baylibre.com>
References: <20250318-iio-adc-ad7606-improvements-v2-0-4b605427774c@baylibre.com>
In-Reply-To: <20250318-iio-adc-ad7606-improvements-v2-0-4b605427774c@baylibre.com>
To: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org
Cc: Michael Hennerich <Michael.Hennerich@analog.com>, 
 Angelo Dureghello <adureghello@baylibre.com>, 
 Alexandru Ardelean <aardelean@baylibre.com>, 
 Beniamin Bia <beniamin.bia@analog.com>, 
 Stefan Popa <stefan.popa@analog.com>, linux-kernel@vger.kernel.org, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1736; i=dlechner@baylibre.com;
 h=from:subject:message-id; bh=kM+k5AQriGEQF4EjhCiLnSRLo7GvLPAK1dzRegvKVGo=;
 b=owEBgwJ8/ZANAwAKAR+K+IyC93wDAcsmYgBn2fkdBcvwaygKuokVp6uC8fcc9pqtVqrS8+l0n
 OTZJIZxNSiJAkkEAAEKADMWIQSKc9gqah9QmQfzc4gfiviMgvd8AwUCZ9n5HRUcZGF2aWRAbGVj
 aG5vbG9neS5jb20ACgkQH4r4jIL3fAP+aA//QlUhUn2O4TYB3ctNgaiMB+xOE4kflWFSAP6sz1b
 LSLSkg5nyzB+X8UJ1YRDe8lnlX83sHjL7mn9g+8ao1Bd8gABdm6uPB+8sk5WOEXMRg9VHJi8+Yb
 K6SQrzHbD30MxAYa8AsWFLoJWstMajWoibGfrGWMtNyPIAiVriL41/LLeKJmENx5w/mA7idggF/
 Fab57FILLOn2hBcrMNjQJGKBnNQx3Lp87dCMa1TO1ynv1HBv7cOIqIf8To3dP4LymY3f3+SBtQB
 /dA3TgB00z6k1XcxNEco0j1Hvnyz7iMq5VOsvYehI552B3J+mVLKg6Qysff38E6RPMMH0htWVvr
 lsoMTXve5ayIV6sx4WOfAkUSzewwIUmm/N/3sFX56kQbMNvtUr0t1YMCVCMXZueVedhGOhTu+BK
 QNOzSPGaw8jFRYxGIhjr68zHmUqxUI9O5yYdBQv9rWiWoEj6RFyajm9FHcOfryhlVuW99tJWJ08
 PCaXTEMtp1ziOje9Hlts7nd6az2DdEcqLkEelUFz7emkCOiBWb11EifrQngJE8WNi6UUms8+u9/
 OCdc7QEROsVMv+vH6aqJELEVylDkXDI5YYYuXulu8ulSrolTVf2Kq55K7Z6D84qUDlaZndvmHnV
 gscWVFbMWR1ObhSxZft4iWzsfCb/Io2Ywv3Kq9rRugP0=
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03

Add lookup table entries for ad7606c-16 and ad7606c-18 chips.

Reviewed-by: Nuno Sá <nuno.sa@analog.com>
Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/iio/adc/ad7606_par.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/iio/adc/ad7606_par.c b/drivers/iio/adc/ad7606_par.c
index e33b07ab5eace4b78e7cf39ee7e8d9379c9f73e7..634852c4bbd2c531d6c0e02d2f1e62db9008cad9 100644
--- a/drivers/iio/adc/ad7606_par.c
+++ b/drivers/iio/adc/ad7606_par.c
@@ -222,6 +222,8 @@ static const struct platform_device_id ad7606_driver_ids[] = {
 	{ .name	= "ad7606-6", .driver_data = (kernel_ulong_t)&ad7606_6_info, },
 	{ .name	= "ad7606-8", .driver_data = (kernel_ulong_t)&ad7606_8_info, },
 	{ .name	= "ad7606b", .driver_data = (kernel_ulong_t)&ad7606b_info, },
+	{ .name = "ad7606c-16", .driver_data = (kernel_ulong_t)&ad7606c_16_info },
+	{ .name = "ad7606c-18", .driver_data = (kernel_ulong_t)&ad7606c_18_info },
 	{ .name	= "ad7607", .driver_data = (kernel_ulong_t)&ad7607_info, },
 	{ .name	= "ad7608", .driver_data = (kernel_ulong_t)&ad7608_info, },
 	{ .name	= "ad7609", .driver_data = (kernel_ulong_t)&ad7609_info, },
@@ -235,6 +237,8 @@ static const struct of_device_id ad7606_of_match[] = {
 	{ .compatible = "adi,ad7606-6", .data = &ad7606_6_info },
 	{ .compatible = "adi,ad7606-8", .data = &ad7606_8_info },
 	{ .compatible = "adi,ad7606b", .data = &ad7606b_info },
+	{ .compatible = "adi,ad7606c-16", .data = &ad7606c_16_info },
+	{ .compatible = "adi,ad7606c-18", .data = &ad7606c_18_info },
 	{ .compatible = "adi,ad7607", .data = &ad7607_info },
 	{ .compatible = "adi,ad7608", .data = &ad7608_info },
 	{ .compatible = "adi,ad7609", .data = &ad7609_info },

-- 
2.43.0


