Return-Path: <linux-kernel+bounces-558676-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 202B0A5E952
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 02:18:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5C0DD16CD71
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 01:18:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A3833D561;
	Thu, 13 Mar 2025 01:16:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="ssBCQ26N"
Received: from mail-oo1-f51.google.com (mail-oo1-f51.google.com [209.85.161.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98A0116FF44
	for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 01:16:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741828587; cv=none; b=IQqT+HI0QKnhyL7di0kMKLehuUOJI4HE8bKQCrdtSA2gHLPBMjr6XaOs2o2m6g2W/NSq5EfsB5yxGjjLZMeH6zcnRp52j2nazZNdSiJQDdVZRGZjSPhd0fJsdLDQPDiaCyVuXq0rA3P3AAqEN7rW9aqP9flgy2wFnEBEBz22zMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741828587; c=relaxed/simple;
	bh=G6T/2KDF4C5JsW8WYTxDGIcsK077JHDl513PdKR03Zs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=D4/9gLTVz/RqskVPymix/+dzSUY16D3Jmk133TuNcq6O+RD+omAcDWyfOBI1grhJ2Yp+9cvPv+Gshm6xYLaY/iGbwF0eCIUQqFBMO6ojcV3eXtL9/ZB/Lsw95O7JU7rJ5ILPgUhHPtLgxoSqVISpe+FvUqaV5p8NXSNjCJKrFQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=ssBCQ26N; arc=none smtp.client-ip=209.85.161.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-6003b679812so90658eaf.3
        for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 18:16:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1741828584; x=1742433384; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vqKSGn1O/86vBug4de9CRWQ48RhJd0oISYiM5GUaq+8=;
        b=ssBCQ26Nc0hQaHiJlO/z4uVuuBE78mMbY+leGhaTqCvKxV0bHC1AwVPtv5Xa+9u7f4
         6Or8VyBdgeT3T8Tj6mO+em157qp+/GNAU4AGGTjyGk00sSrYHeU4k+fTapdj7M/8rdAp
         O3YZCVTsnWyYU3NWXySyReBbJiIT5AYX8uI/mBpgpaZ8yKaJb1Uww76DRMbjwXyPMDDJ
         DfNOLG4EOaFA2mzxz8DH9u0z0JIQDNuk/+fKInUJ0OQ43FXEqahXUg94tZixS/dMaqZz
         3QjgA3gi/X0/J0uF6GI0J05Mn/GoSAnTfrqdYX4rDf0bwggwudYaZ58C66xcFM/qtI9r
         6Iog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741828584; x=1742433384;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vqKSGn1O/86vBug4de9CRWQ48RhJd0oISYiM5GUaq+8=;
        b=byo9uUKtBncBjx05q/Y9ga2RU5EN5Eku0XKB/tbc5edtjEZM6yW7aVzpHIfBM5N3Nw
         ya1DhE2Uqf6k/riRRWFm+5d8OisH3undw1HeqtZb//qGSFXp/+ZKIP+wwwAeN41/GRgE
         +j1iNsrfYW94bpeVdJt4VHzX1FDLNZhKFCz8+5fPi6Mz0L0QVSiW4C91+Q6+T85Kj9LX
         RDij34hu+v1/FnNoH9dXYU5wBU/6d2ty1tL/VucCtdsFQ8IP7oAbtbnKkgBLrhw565cx
         J1w8OnCFTUCDbGBfI+0hnNx7fYk6vAKa7uI4sJBO/alOfmrLdgpbmRXmLDyFicGunPdO
         8H6w==
X-Forwarded-Encrypted: i=1; AJvYcCUPrGY2m4UG+YbHHP16NXtZTSgUOJ+I66jfbPMnbDNK+/RvAWQKrBGv/I+kOKnHJ35YWwa+QtzyP1f8Chs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxFpMAHpxw/wQGdHOcjxeXCYXFW6lItK+MrQBkGngWSry9py+el
	Ac2Or9rFemhw1ZmyzlNY+m03SMP81NHon8diUQIq0H2ylddyT9G8Fes7FsJvm9L4y4G60r9yoDC
	7pVU=
X-Gm-Gg: ASbGncspOm2Xw+Ul1LNWVNZDDndsz4gajUuL3Z7Xz/YVXSETWIRAxmNpR7sMbSHXT4z
	ZT0EDngpruttbnGikuFL55NvXuROrsCwo4smIYGZXSWkZtBWzKCI48UsCrL10SgimxJ29lHoHA7
	dd4qPqfG2yJ0CfeNfwOcNdBBximk1BuQIy5uDpf3TkrqgYGrVfmxpHp/RaNAYvzE9hSjh3AwxJH
	yGXrwh4DlYvf+UVuJoZqhvSU3WSXFsLwUMgc/PiZ28r8p8MdLvULne2NABKbap462OA2iqgnDAk
	sdtSpLXROHYZ1Vxrai4x2VmoKpxSp6QYV21qfhepcuzxnJz18Lz152gVPAdwpNfBL1Y5J7vP0iO
	OAVldDDAS1kA=
X-Google-Smtp-Source: AGHT+IFn+Gu4WaglzOvc/w350Ccu55y0spz2nKJMrLuphFNAedL18lQyKziTYY0RnAUjpY2+hWiHUg==
X-Received: by 2002:a4a:ec46:0:b0:601:bf4d:86e6 with SMTP id 006d021491bc7-601bf4d88d1mr5787314eaf.1.1741828584549;
        Wed, 12 Mar 2025 18:16:24 -0700 (PDT)
Received: from [127.0.1.1] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-601db659ad8sm39865eaf.8.2025.03.12.18.16.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Mar 2025 18:16:23 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Wed, 12 Mar 2025 20:15:44 -0500
Subject: [PATCH 06/11] iio: adc: ad7606: fix kernel-doc comments
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250312-iio-adc-ad7606-improvements-v1-6-d1ec04847aea@baylibre.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=7781; i=dlechner@baylibre.com;
 h=from:subject:message-id; bh=G6T/2KDF4C5JsW8WYTxDGIcsK077JHDl513PdKR03Zs=;
 b=owEBgwJ8/ZANAwAKAR+K+IyC93wDAcsmYgBn0jHbIlTN9NpWATQrGaRPKhfK7x4ZDeRxfGXTW
 +l8VL0aqNOJAkkEAAEKADMWIQSKc9gqah9QmQfzc4gfiviMgvd8AwUCZ9Ix2xUcZGF2aWRAbGVj
 aG5vbG9neS5jb20ACgkQH4r4jIL3fAOg1hAAkJ4wWePRT0ryxssBC1FBgRQaSo+RSKtGWSTPxO7
 iSrSvH+3+TqfJNQ1MHeeDCY/5v1tUxDYlcEUZPfFsHdsunYUFUgcPhETm9qsTjJB/11eTZNXKoe
 GtrEa1WM6xtT6rXAD4Yq1/cQpHruvq1WHACRH2M5n1TUpjzDNDwms+Tlphb7aIYDvBWewM9HW0V
 xb0rXtMAliIhDdb5627WsOO57wzwVn8UQrXr4LF5YxHCPII9HtsmD6mvlhl5EjI3wYsNmHQdS6a
 DmL8sePfnqGgFmiBalVdTScGZDVXwPEVUVF7s5ODUVp+r41JG/qXylrlhsWLNW+2xvZXRd98QTD
 Gsd1WJxtLmrzZelk9AsavwpKVk+1SbYITaKyrQeuk8fYCyuGgiTelPZPkPj1wna93hWPJ7a/qlt
 r5UfwEz4wzWSJVVmIj1eMKtXcQfV36izGNkxIvod8EFNmKbzJjRmrBZkdYueClhmWe22A9pDaKG
 fzza7PvpeAoz1VaqyTFZwZCnYeWfwDsutZOMbKGjXin9yigJd4aBdtV1/e4gSiNu4p3nC+lMmkx
 P0cXw7XW85ZBPI8EErEaeMKAyotpi2i2z99ltexlQxH2hFxYfoz2qbYWnVQb/Sk8GDkfcKVopuy
 cKxbdlh18FJSIq0nEKLmgLRvxz2+9gVGYlzeoCc5twPk=
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03

Fix several issues with kernel-doc comments in ad7606.h:
* Add missing ":" to @param names.
* Add some missing parameters.
* Remove some non-existent parameters.
* Fix alignment and wrapping.
* Fix some spelling.

`./scripts/kernel-doc -v -none drivers/iio/adc/ad7606*` is happy now.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/iio/adc/ad7606.h | 90 ++++++++++++++++++++++++------------------------
 1 file changed, 45 insertions(+), 45 deletions(-)

diff --git a/drivers/iio/adc/ad7606.h b/drivers/iio/adc/ad7606.h
index 71a30525eaab512fa811f28fa79268a1a976bc8c..3da78488c8a247dccbff930023f98717d540081a 100644
--- a/drivers/iio/adc/ad7606.h
+++ b/drivers/iio/adc/ad7606.h
@@ -120,17 +120,17 @@ typedef int (*ad7606_sw_setup_cb_t)(struct iio_dev *indio_dev);
 /**
  * struct ad7606_chip_info - chip specific information
  * @channels:		channel specification
- * @max_samplerate:	maximum supported samplerate
- * @name		device name
+ * @max_samplerate:	maximum supported sample rate
+ * @name:		device name
  * @num_channels:	number of channels
- * @num_adc_channels	the number of channels the ADC actually inputs.
+ * @num_adc_channels:	the number of channels the ADC actually inputs.
  * @scale_setup_cb:	callback to setup the scales for each channel
  * @sw_setup_cb:	callback to setup the software mode if available.
- * @oversampling_avail	pointer to the array which stores the available
+ * @oversampling_avail:	pointer to the array which stores the available
  *			oversampling ratios.
- * @oversampling_num	number of elements stored in oversampling_avail array
- * @os_req_reset	some devices require a reset to update oversampling
- * @init_delay_ms	required delay in milliseconds for initialization
+ * @oversampling_num:	number of elements stored in oversampling_avail array
+ * @os_req_reset:	some devices require a reset to update oversampling
+ * @init_delay_ms:	required delay in milliseconds for initialization
  *			after a restart
  */
 struct ad7606_chip_info {
@@ -149,10 +149,10 @@ struct ad7606_chip_info {
 
 /**
  * struct ad7606_chan_scale - channel scale configuration
- * @scale_avail		pointer to the array which stores the available scales
- * @num_scales		number of elements stored in the scale_avail array
- * @range		voltage range selection, selects which scale to apply
- * @reg_offset		offset for the register value, to be applied when
+ * @scale_avail:	pointer to the array which stores the available scales
+ * @num_scales:		number of elements stored in the scale_avail array
+ * @range:		voltage range selection, selects which scale to apply
+ * @reg_offset:		offset for the register value, to be applied when
  *			writing the value of 'range' to the register value
  */
 struct ad7606_chan_scale {
@@ -165,32 +165,33 @@ struct ad7606_chan_scale {
 
 /**
  * struct ad7606_state - driver instance specific data
- * @dev		pointer to kernel device
- * @chip_info		entry in the table of chips that describes this device
- * @bops		bus operations (SPI or parallel)
- * @chan_scales		scale configuration for channels
- * @oversampling	oversampling selection
- * @cnvst_pwm		pointer to the PWM device connected to the cnvst pin
- * @base_address	address from where to read data in parallel operation
- * @sw_mode_en		software mode enabled
- * @oversampling_avail	pointer to the array which stores the available
+ * @dev:		pointer to kernel device
+ * @chip_info:		entry in the table of chips that describes this device
+ * @bops:		bus operations (SPI or parallel)
+ * @chan_scales:	scale configuration for channels
+ * @oversampling:	oversampling selection
+ * @cnvst_pwm:		pointer to the PWM device connected to the cnvst pin
+ * @base_address:	address from where to read data in parallel operation
+ * @sw_mode_en:		software mode enabled
+ * @oversampling_avail:	pointer to the array which stores the available
  *			oversampling ratios.
- * @num_os_ratios	number of elements stored in oversampling_avail array
- * @write_scale		pointer to the function which writes the scale
- * @write_os		pointer to the function which writes the os
- * @lock		protect sensor state from concurrent accesses to GPIOs
- * @gpio_convst	GPIO descriptor for conversion start signal (CONVST)
- * @gpio_reset		GPIO descriptor for device hard-reset
- * @gpio_range		GPIO descriptor for range selection
- * @gpio_standby	GPIO descriptor for stand-by signal (STBY),
+ * @num_os_ratios:	number of elements stored in oversampling_avail array
+ * @back:		pointer to the iio_backend structure, if used
+ * @write_scale:	pointer to the function which writes the scale
+ * @write_os:		pointer to the function which writes the os
+ * @lock:		protect sensor state from concurrent accesses to GPIOs
+ * @gpio_convst:	GPIO descriptor for conversion start signal (CONVST)
+ * @gpio_reset:		GPIO descriptor for device hard-reset
+ * @gpio_range:		GPIO descriptor for range selection
+ * @gpio_standby:	GPIO descriptor for stand-by signal (STBY),
  *			controls power-down mode of device
- * @gpio_frstdata	GPIO descriptor for reading from device when data
+ * @gpio_frstdata:	GPIO descriptor for reading from device when data
  *			is being read on the first channel
- * @gpio_os		GPIO descriptors to control oversampling on the device
- * @complete		completion to indicate end of conversion
- * @trig		The IIO trigger associated with the device.
- * @data		buffer for reading data from the device
- * @d16			be16 buffer for reading data from the device
+ * @gpio_os:		GPIO descriptors to control oversampling on the device
+ * @trig:		The IIO trigger associated with the device.
+ * @completion:		completion to indicate end of conversion
+ * @data:		buffer for reading data from the device
+ * @d16:		be16 buffer for reading data from the device
  */
 struct ad7606_state {
 	struct device			*dev;
@@ -232,17 +233,16 @@ struct ad7606_state {
 
 /**
  * struct ad7606_bus_ops - driver bus operations
- * @iio_backend_config	function pointer for configuring the iio_backend for
+ * @iio_backend_config:	function pointer for configuring the iio_backend for
  *			the compatibles that use it
- * @read_block		function pointer for reading blocks of data
+ * @read_block:		function pointer for reading blocks of data
  * @sw_mode_config:	pointer to a function which configured the device
  *			for software mode
- * @reg_read	function pointer for reading spi register
- * @reg_write	function pointer for writing spi register
- * @write_mask	function pointer for write spi register with mask
- * @update_scan_mode	function pointer for handling the calls to iio_info's update_scan
- *			mode when enabling/disabling channels.
- * @rd_wr_cmd	pointer to the function which calculates the spi address
+ * @reg_read:		function pointer for reading spi register
+ * @reg_write:		function pointer for writing spi register
+ * @update_scan_mode:	function pointer for handling the calls to iio_info's
+ *			update_scan mode when enabling/disabling channels.
+ * @rd_wr_cmd:		pointer to the function which calculates the spi address
  */
 struct ad7606_bus_ops {
 	/* more methods added in future? */
@@ -258,9 +258,9 @@ struct ad7606_bus_ops {
 };
 
 /**
- * struct ad7606_bus_info - agregate ad7606_chip_info and ad7606_bus_ops
- * @chip_info		entry in the table of chips that describes this device
- * @bops		bus operations (SPI or parallel)
+ * struct ad7606_bus_info - aggregate ad7606_chip_info and ad7606_bus_ops
+ * @chip_info:		entry in the table of chips that describes this device
+ * @bops:		bus operations (SPI or parallel)
  */
 struct ad7606_bus_info {
 	const struct ad7606_chip_info	*chip_info;

-- 
2.43.0


