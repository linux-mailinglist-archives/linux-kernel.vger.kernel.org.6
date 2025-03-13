Return-Path: <linux-kernel+bounces-558681-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A4958A5E95C
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 02:19:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 96C363ACB10
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 01:19:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D3141DE4CD;
	Thu, 13 Mar 2025 01:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="P5gl1zhW"
Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04D0F1D89F0
	for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 01:16:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741828600; cv=none; b=izcOJKQLB/m8sl62O/tbhF+9CChSYOl0lY3EsF2WudUdBk0EkPG6gHh9c6X1Ld2VOxLVJv3S9WiEIZFAuqwKZM/L0x0XH3ZeeFGRtQyTRCd1/4hHEQ8L5oi3+Eijvjipf9PfCvsRHhNMaxZ/waVuFsQ1BwCDB7UaucAvlcuVR20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741828600; c=relaxed/simple;
	bh=53ONRiOABCptcxL3WGaLlWT6fl3RdJ2bBnZWG9HzvuU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=H+b+1FCg2HcznQIccLlstK7lxGxCpAo/+cxlEpTdKAZvnJ1XVUP7zbnxmoksQwSjNdSdtsDEn8i90aYQVfk+rs8Cw78jtuCVhju0vdj6P7pGyh3OLsaSFA78N1CIBCasYbLHvfhSxSXalixvRDxViV8eORRftoHe83DYvNP8r5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=P5gl1zhW; arc=none smtp.client-ip=209.85.210.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-7272f3477e9so121899a34.3
        for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 18:16:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1741828598; x=1742433398; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Xv9hPIQLpYDvfh5yD5dclx8jxi1p8xrXy5GO73MBJkE=;
        b=P5gl1zhW/NmnbENrD6+UN7UHgZnD5pHZUrcYanZlb5OatTIJ9wLugWrRm26gH7LZ1q
         EIsNaacY2NBdeYc9/jUsCmPwqRDE7CBWidNxCErWCiRJ3Pdu+IvxOmYwBTtUghIuToSc
         XgyHrWj+xd928WqPF1MJcAn/O/XiXxIXg0UNgkIsw+H8FWoW5Clna8yQdFKDXZMG41lG
         /rjlCuqZFq0TZ/Dsiipn6B+GpGHkkviq8KTWw/OsWqf8Y86EIlrGE4JFQEt38XL2oEQX
         ze+KDr3BDoxKT18jcWj0KjtNcx7Es8qaRMc/c3fKWAZfepXo7yrR4nI5jGDleVFPZrmP
         HBMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741828598; x=1742433398;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Xv9hPIQLpYDvfh5yD5dclx8jxi1p8xrXy5GO73MBJkE=;
        b=vjxR54ipY97pfmvB1ErgO+kbw1URzE9wpKn3w6xfUAAxkEvPtbzXoVVsQK8ep6+T1c
         FgV1YaHDjNOCjY3+wP5HPQDgGwncEisFopNo3pvnLoXH8c7UqesIPRt9/gwywdL8JemW
         Zj5PSrA5sBsjwn3iJlxl2F292sF7P5LWjkQbSeeR+dSlwZJOko7fdkQ82e6TdJWCLtXY
         VX0SK93ZZOKNknvlyoNI2zp7We/213HoxB9joANV1bJFX2R8RAYXFpiBVj6RFQN9xMZA
         AahTlEb1XAoUCQnAWlhYoyt+7oDwKxn3azXvb1ZgQz8wt156wwWxzIkCqrmYaAfMULQT
         upQg==
X-Forwarded-Encrypted: i=1; AJvYcCX5EQ7SAaz0xn4HsC3iIqYCJ4xdyg1IQ3ApxxLFeKjEmMCvGP2Fs+wkrEf2/L4ZAPpbe4kNBbGWZSHiQsU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxMLu8BYNpiTWdzmoWvdXlHfn3xFlm7NIJe855Evq29VHJuJoAe
	L/K1qKDJM43HqGFEsLoDxhOAtEt+2KsEmF31/PVM5QlxjBKts5gTCsBDWdWZj3c=
X-Gm-Gg: ASbGncv9qqP7Y7btCIdCo/gMZvzo2uHBgwlmWwS6gpzKf2/sBEzw57mk6LDRbkegbaI
	4/m9xcHX4hbxfjNv2BmVW71m9tPbjtN6ZuXtNKD3CXkIzQy+6m+3BAu0y9xJjJMaCoJqrpkmgFX
	BRy+zQhwIwjon/wpjMDrWth1qDhThVSFpT8uE1p4JnR0HDD+fAq+V6rQE3/gXVh062XKSjlXESr
	mGxqe0DpSX6xtw3TiO9z0DtEPAH+Km5nikfdA3GFHioemHRQp5j3YcgVeGHbHBjfTKKckBMnu5f
	ov73MsDQjdtBWkBtxMALtLUMUBaoK2cozD4NmK8t+1Nb3JClIVnlTruxlVm351oGRtxvM74WwgX
	u
X-Google-Smtp-Source: AGHT+IEV69HY5VNUjdgasp5RyTvYJGHiBK9Q8etypNphuhRoELCRTehmlHf3J3TG1MXjj3gzgiMimA==
X-Received: by 2002:a05:6830:6f44:b0:72b:89ca:5120 with SMTP id 46e09a7af769-72b89caa394mr9660712a34.8.1741828598072;
        Wed, 12 Mar 2025 18:16:38 -0700 (PDT)
Received: from [127.0.1.1] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-601db659ad8sm39865eaf.8.2025.03.12.18.16.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Mar 2025 18:16:36 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Wed, 12 Mar 2025 20:15:49 -0500
Subject: [PATCH 11/11] iio: adc: ad7606_par: add ad7606c chips
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250312-iio-adc-ad7606-improvements-v1-11-d1ec04847aea@baylibre.com>
References: <20250312-iio-adc-ad7606-improvements-v1-0-d1ec04847aea@baylibre.com>
In-Reply-To: <20250312-iio-adc-ad7606-improvements-v1-0-d1ec04847aea@baylibre.com>
To: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org
Cc: Michael Hennerich <Michael.Hennerich@analog.com>, 
 Angelo Dureghello <adureghello@baylibre.com>, 
 Alexandru Ardelean <aardelean@baylibre.com>, 
 Beniamin Bia <beniamin.bia@analog.com>, 
 Stefan Popa <stefan.popa@analog.com>, linux-kernel@vger.kernel.org, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1692; i=dlechner@baylibre.com;
 h=from:subject:message-id; bh=53ONRiOABCptcxL3WGaLlWT6fl3RdJ2bBnZWG9HzvuU=;
 b=owEBgwJ8/ZANAwAKAR+K+IyC93wDAcsmYgBn0jHbxvaCQrQgNIs++uwe1E8a2NdIiz0yfeW/J
 VX1pGFeYqqJAkkEAAEKADMWIQSKc9gqah9QmQfzc4gfiviMgvd8AwUCZ9Ix2xUcZGF2aWRAbGVj
 aG5vbG9neS5jb20ACgkQH4r4jIL3fAMKRA/9GgURgGtjoCiunTTxdXpNNrj/BWmhaluRQC2X9fJ
 eaD752dGW+GSfsw9umBPkUTCEE6GgpVcEOBVbbftRobMlU0bBrD13J/QyscQY5P8mohhfcDWwWH
 tkS3bzAMrQXyjq/NneMV/0r8ydQcfueVycvsHi5iTtAtrv2Pr7RRRohfdNrGz6Pb75LyZZ5YJBR
 bfwqq/rtGK4GH3Ad2PjeLWrg18yAH3tvEPX00CrX/x5ljYryow4ab+QLtnAHAYyyBaM+1b+F1XD
 63ZRvtiYoHc/018xFi0C83Zj13YkNQ5k2C8/Ly3iTwa36S7Lvpk3+fionGJeDC5AWA3cXL1kvAu
 rpSr9kqYcdTKZjXzFYBemcB0OZ1LF1MJbACZsEWAU1KjvS0dXHYBl/xdcEt4cn4I7aFN1cslGCU
 fy2UVV5WmfF7o2Zwzwmle0L9G7J6lpw29aL5wCjq628HLmqNTi3bqWbyCmgxxHNcmHVJEYv79aj
 DOEqXkbvCvucEUwTty8hl0l40EeVKRi3NDKagkTGtSQw/bDWhBx/fKnN29MXvLRJ4LMi3JYaEaX
 B5l4g/TwJA0eeRucX31+nmU2I9ztJ00RLA8Xg6z7vBApDdxIUVmCjbLk/WoK1uKW1dk1t7MxyQ2
 2+LoVhzdXZFbTxxMGPKxD/bTblF/RxNAVIFju5gXhvJM=
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03

Add lookup table entries for ad7606c-16 and ad7606c-18 chips.

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


