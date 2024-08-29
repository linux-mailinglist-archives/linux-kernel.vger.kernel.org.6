Return-Path: <linux-kernel+bounces-307549-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DFA4C964EF3
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 21:31:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EA2781C20B4B
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 19:31:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F0D71BA27F;
	Thu, 29 Aug 2024 19:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FbYM6A9K"
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3F36153BEF
	for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 19:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724959847; cv=none; b=RN8vMODcpCGKNgoIkcBqzQ06UJ6hL3vMahYOhCXP+Kof69Dufbb3aKJIGrjoVodwCG7o2px/sxTQb143phQxgetw1dS6whRUkId3aiX8a+q0Z/ORHUXJha6fLJqs1QUzGzNKx42y3z0NzYoTBYXvtSE1jLvqxHwXcIBIibfVY50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724959847; c=relaxed/simple;
	bh=CXsIUiDA8SVSLQs9npYgmvUfqux38XLA9LpGsNTuAmw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=agY9tRA0r2WSYYewSnFdhgwz9AxEA9PEQaSqbKwvSBWZL6HZ6MfAXwrH5S2muwxtGCvhwRoO2iBCCdOG+dg4Pl0Gsj7FqQVpaEmzoihTs5nNhYqzxSt7GokMmbzohAY5bQalTFrIPuqyt1DoKavjY8bMiznCrGqsVinOzb0AZjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=FbYM6A9K; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-371ba7e46easo708465f8f.0
        for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 12:30:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1724959844; x=1725564644; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XTIlWbVkKMoIHTYoPixZvVSXn7Ujj8xniVFLaiolivE=;
        b=FbYM6A9KMRV4byW9IySWbU3U/PN/eFWvi+L0A3L3K5TONTHj8DiMwB9v42GW13pksw
         egH+iDFnrWWrwy5q37E1G24+0QO7vOBtImCOJ2myw7pkyPHh3IOVdlo2MQ8RMbUPubiV
         +AS1xNL5brjDI4rTVBz1AKSKqgHKL0QG1C60uP7RdV+PcRUPlfjjZcKeKQRZaplEuM5t
         rKCpOGHyXp4RS/aOFYQI/uIjEin3pG8FPn2vRy800oheH5YgcecZu1nJwbSLjqEivdSE
         EHRDUGSzT7bsTgI/q3jjWJQ+TCcUWSr45fZdhymLsSbE9dLnfZiyHNGBe8FwCo3mXOBf
         yWXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724959844; x=1725564644;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XTIlWbVkKMoIHTYoPixZvVSXn7Ujj8xniVFLaiolivE=;
        b=RwVP3siYFibrM4vkksopYbjztIHgjU7d/ZnQUCn/zfSpNrKdL06JQcvYCTHM0QXg3t
         UkH4MBUIHvdXa1NolqXFPZQV6vThNzJmCXWdKNVaTV+vxEjwDO31iffWn2Rjh2XUeIMD
         gPUeo4d6WGfQLI3UPghQVubGvuQccAdyKUUOfkuRi6MbmkSnOxuu1dcdYZHgQuR8/oYv
         g6RrjHJeZq8GmhpTWQagfWKPiEACh13RqIW+avw/tlV3629u7aHeHKX1HnjXUz/Tk323
         cb9J08nneh/mkjDpddRIsYS/q04fWlf5+vgQdu6b5g6P0EXq0aASWIJWWX9KpdAyr/yP
         ++qA==
X-Forwarded-Encrypted: i=1; AJvYcCWDkSZJNWDzQmfb1fZCnuHEsNJDYnyQ5dvDhD4pVFIagGWKkPYGI4HyCZbe5ykL+e6OnryfGjHNEm+luXM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJBEZTLUtRkcsY1HKtehJcaicVVszLzlZBMnMGBO80S168KtLv
	S/X/DffPQfP4PYg8PBoDKwEeat754GGzHvfLeLnSS2drmWYTOCPT3aJsa/i0q8Q=
X-Google-Smtp-Source: AGHT+IGMmdJvaYiB1UpCQZzEoivkHJ5zTToQgDAadoaIM0r4rBLJnjEluKCsaEeb89RagvSoKzM+YQ==
X-Received: by 2002:adf:f792:0:b0:371:87d1:4248 with SMTP id ffacd0b85a97d-3749b5508f7mr2840300f8f.29.1724959843972;
        Thu, 29 Aug 2024 12:30:43 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42bb6df954asm25460525e9.26.2024.08.29.12.30.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Aug 2024 12:30:43 -0700 (PDT)
Date: Thu, 29 Aug 2024 22:30:39 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Charles Wang <charles.goodix@gmail.com>
Cc: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: [PATCH v2 next] HID: hid-goodix: Fix type promotion bug in
 goodix_hid_get_raw_report()
Message-ID: <a04cfa63-de06-4d09-af80-a567f2db8f12@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

The issue is GOODIX_HID_PKG_LEN_SIZE is defined as sizeof(u16) which is
type size_t.  However, goodix_hid_check_ack_status() returns negative
error codes or potentially a positive but invalid length which is too
small.  So when we compare "if ((response_data_len <=
GOODIX_HID_PKG_LEN_SIZE)" then negative error codes are type promoted to
size_t and counted as a positive large value and treated as valid.

It would have been easy enough to add some casting to avoid the type
promotion, however this patch takes a more thourough approach and moves
the length check into goodix_hid_check_ack_status().  Now the function
only return negative error codes or zero on success and the length
pointer is never set to an invalid length.

Fixes: 75e16c8ce283 ("HID: hid-goodix: Add Goodix HID-over-SPI driver")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
v2: take a different approach

 drivers/hid/hid-goodix-spi.c | 22 +++++++++++++++-------
 1 file changed, 15 insertions(+), 7 deletions(-)

diff --git a/drivers/hid/hid-goodix-spi.c b/drivers/hid/hid-goodix-spi.c
index 5103bf0aada4..de655f745d3f 100644
--- a/drivers/hid/hid-goodix-spi.c
+++ b/drivers/hid/hid-goodix-spi.c
@@ -335,11 +335,12 @@ static void goodix_hid_close(struct hid_device *hid)
 }
 
 /* Return date length of response data */
-static int goodix_hid_check_ack_status(struct goodix_ts_data *ts)
+static int goodix_hid_check_ack_status(struct goodix_ts_data *ts, u32 *resp_len)
 {
 	struct goodix_hid_report_header hdr;
 	int retry = 20;
 	int error;
+	int len;
 
 	while (retry--) {
 		/*
@@ -349,8 +350,15 @@ static int goodix_hid_check_ack_status(struct goodix_ts_data *ts)
 		 */
 		error = goodix_spi_read(ts, ts->hid_report_addr,
 					&hdr, sizeof(hdr));
-		if (!error && (hdr.flag & GOODIX_HID_ACK_READY_FLAG))
-			return le16_to_cpu(hdr.size);
+		if (!error && (hdr.flag & GOODIX_HID_ACK_READY_FLAG)) {
+			len = le16_to_cpu(hdr.size);
+			if (len < GOODIX_HID_PKG_LEN_SIZE) {
+				dev_err(ts->dev, "hrd.size too short: %d", len);
+				return -EINVAL;
+			}
+			*resp_len = len;
+			return 0;
+		}
 
 		/* Wait 10ms for another try */
 		usleep_range(10000, 11000);
@@ -383,7 +391,7 @@ static int goodix_hid_get_raw_report(struct hid_device *hid,
 	u16 cmd_register = le16_to_cpu(ts->hid_desc.cmd_register);
 	u8 tmp_buf[GOODIX_HID_MAX_INBUF_SIZE];
 	int tx_len = 0, args_len = 0;
-	int response_data_len;
+	u32 response_data_len;
 	u8 args[3];
 	int error;
 
@@ -434,9 +442,9 @@ static int goodix_hid_get_raw_report(struct hid_device *hid,
 		return 0;
 
 	/* Step2: check response data status */
-	response_data_len = goodix_hid_check_ack_status(ts);
-	if (response_data_len <= GOODIX_HID_PKG_LEN_SIZE)
-		return -EINVAL;
+	error = goodix_hid_check_ack_status(ts, &response_data_len);
+	if (error)
+		return error;
 
 	len = min(len, response_data_len - GOODIX_HID_PKG_LEN_SIZE);
 	/* Step3: read response data(skip 2bytes of hid pkg length) */
-- 
2.43.0


