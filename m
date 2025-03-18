Return-Path: <linux-kernel+bounces-567033-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 990F2A68013
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 23:53:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6BCA74251B6
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 22:53:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CDE221420F;
	Tue, 18 Mar 2025 22:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="lRGBdyNZ"
Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A43A213E92
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 22:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742338345; cv=none; b=k//A3Ewr7K8RfWjwkjX3XCUJaoUQlDKgeWHK5atP4vB4UrVBk3yZc+CjSgamA/xXZWqNdakGNGcjr/Y0PfJnogXrtGCefKc0P1DNW5JomoTF5RtRhL+9yCBN5G8wnFu/3EEcckwL3uJIhAzABtkEPBcY2dBexqRPY/z43iWE1rc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742338345; c=relaxed/simple;
	bh=U6hTKOUdv8NzJNt/VAwCG4k1hYCfglrZdWj4ZUh8BG0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VkzR5mYb+3ut7MRlx3bmS+X+YvL56yuv/TlbmRQ2TWHtaGSdoDTmtbdosR1xqMvk6ihzjsMYgHG1xxc6NUc3Ofv0HIj8RgkJzcFUaJKlL9xLpVKWWWyXucwIEp4VIgke6N5U6nXhUz3Wx9dlCOapGCt3D2EXEAPUO/BQ3y55WJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=lRGBdyNZ; arc=none smtp.client-ip=209.85.210.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-727388e8f6cso3573878a34.0
        for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 15:52:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1742338342; x=1742943142; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vPQCJrVzhsb3m8wB7eSx0v8THRAkXBBOHXV7wuYowq4=;
        b=lRGBdyNZQHj0IGzaJ3sZwRbgRaTN6bytKGyPX+1eFBgUqFtfo8MWmYLD63za4N0sxO
         jTPjakvRsyfqtsE16UI3+QcGVHZSUgfrfIzi+i8iyZX26NB2izhN1viS864RWZ7aGm0R
         qFYf3zniyfCdnn/f1qWtHajLwXdqTv+T5RGVCLI5aUVUbrzekoyOtbCgx5VIDd99/zZB
         qy98tcxhuFoWfzI/dQrMXzDpZ3GJ1iwoTnWX9gtUaJUQjUJRAEIrzWfq6IkwA/wVqz2w
         egwjcv+uZ2OL9awMsfXuoI71fs6rU5/Wm1Q+sUHGQEwq7t0oAnnb6CQ+C25zBw00YFt3
         f5UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742338342; x=1742943142;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vPQCJrVzhsb3m8wB7eSx0v8THRAkXBBOHXV7wuYowq4=;
        b=S5ElRDKugp3LfUkJjqLPtUu1rZPNeizT1/mI29LBgmQ6a0GDQgj4/TzrVMx5GhD1xq
         pClY2Gw5eJJPH6wjqYDyCT1MJFx9XaFCXaR07fL6lby19TMPxhEhZ2Oa/thMbhSkAWR/
         nXTuD3jesoAmwkOHE160E6zqR2TtADfRqAFRyLFb1c8Ggj1dEr9GbRtFFGOTy4t+zxK6
         W7Qt+d4km4vy15iDFah/2huIHeQVj86EoMUaYX2o231Vx25idG4CLC5xBp3M350YMlv7
         F5hUSx94OqOA0MmVyoUfuBa+8ZRi70FfJpMTZMu1uLRr9p+MRHXDJN4sKc2IKKhKMtxy
         HE9g==
X-Forwarded-Encrypted: i=1; AJvYcCWAuzOtl9QsRsGU+iE5WKKby4uHBEWY9ZJ5q3X5mFbslDKOpbVaHeuJVu00x3A1LuqUWn4nO78tTAk7xRc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyFAfV/4UMovoWNScOKDud/Q2TYxVZSfhljoddmmRz0n57IMO/8
	nkZNxkOZEgy/7K/SJa75vXy6JPHo9RYBgm20kI9cohjylQ/WAYWKJM7Z5Yr6ohA=
X-Gm-Gg: ASbGncu6Y8CohP1iiqYLpjoXdttmWwMW27sNp0G3T6y5PAPA68XYYsBswo5Tkj15CGp
	H0KKAiU8y00qSnQouYPU6YQam46zqdmELanLybmHx304MBGSCknpNuq1vLdht91blqmfuLLNTRu
	r+2BEpCSOzX0EMZVUfdaLeqZGuW9jqLeTizpU6qIf/qgB00fxXLSUvSJeHxb1fLSGrVdv/5tgTX
	FtzOL7VJT8RkAaRGB2RiJtg0o8HT9zxZmzz40AmDPOJg0kx05VRHeGwESNzgMQZqhUc4Xzlt4k7
	v3Ten1VaUa4s0nZLrOzLOnocFQNN6TSKoKL+xvsB7g166yfzYOWmKdLw1EwF+6eLG35JhjlAlTM
	l
X-Google-Smtp-Source: AGHT+IH33ojHGgMHagKxoEeXf3gIZ8D9FVLoiXpN6QIMZYjy2GjwSQAeRnN3r1Mcja22NVMGVMOztA==
X-Received: by 2002:a05:6830:270e:b0:72b:9506:8db6 with SMTP id 46e09a7af769-72bfbdb5bb6mr373989a34.6.1742338342201;
        Tue, 18 Mar 2025 15:52:22 -0700 (PDT)
Received: from [127.0.1.1] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-72bb274e95dsm2191690a34.52.2025.03.18.15.52.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Mar 2025 15:52:21 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Tue, 18 Mar 2025 17:52:13 -0500
Subject: [PATCH v2 05/10] iio: adc: ad7606: fix kernel-doc comments
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250318-iio-adc-ad7606-improvements-v2-5-4b605427774c@baylibre.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=7888; i=dlechner@baylibre.com;
 h=from:subject:message-id; bh=U6hTKOUdv8NzJNt/VAwCG4k1hYCfglrZdWj4ZUh8BG0=;
 b=owEBgwJ8/ZANAwAKAR+K+IyC93wDAcsmYgBn2fkcBuvBCTSWmRf0mMlLi+cfc575+8GY+bjKd
 XY5Dn2iGdSJAkkEAAEKADMWIQSKc9gqah9QmQfzc4gfiviMgvd8AwUCZ9n5HBUcZGF2aWRAbGVj
 aG5vbG9neS5jb20ACgkQH4r4jIL3fANNxg//W++JG4InPLiXsmqX4Ksjbi5XmpamMzZA0gm9P6V
 NnNDCzVLK7colfh35suoZl4J3Kqzhnmzrv1VoPpumejaTgh4v3CDu2W5+PzsXt89vO9UhaeFJMU
 8Yk9JJiSe0xNRnj5PaiyXt//tg585160a7dCVuMMZq6XUINyUCsvwmYJEhMu7UTaIE7cltWxyWy
 lgZ+msrr9uQg/sM90jkEAbToK5Prq+kEpt6kQiG70XXmHTr5LD4NjDQVWjxRkQt4wNbYIhyKLUn
 eUoVKF1C2+qXs+4WiC1ITHLymz5+QDwFOOrswTZ/Mk3kzjZpp4Spyy9Mm9sABOk/f5XjWJHWvje
 PO/Ggm3GDNQKkeZkmEZm8DPL5Y4BmkUQend4B3SniENqtcQ0oeze/8hHvzNJBhcmvk3AVAGa/fw
 X863BLFUfWcFWDIAsa1FSasQUfMN1wCxPJI/gKMJsRXplR3ovJhVxTWpE/LoX4X5qKbk0wXTcSf
 ucrEnKodGUAIG52lSrBgDOC+HMsD06imvEizkuaUjWL+GKId7gc2FukdYLs2t1RmuoY+B7RC1+0
 GnG1Tx8GYbcyQZrCboAGDQyCYC6LbiUlfUiIA7YIykYuH9IGkS3eMcp6GxiajmAYvONQsKsd94m
 jELxLYP+LsMSgXJipZIfhAxU3b9SPgwmqJ5DMKIuWQxk=
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03

Fix several issues with kernel-doc comments in ad7606.h:
* Add missing ":" to @param names.
* Fix order of @param names.
* Add some missing parameters.
* Remove some non-existent parameters.
* Fix alignment and wrapping.
* Fix some spelling.

`./scripts/kernel-doc -v -none drivers/iio/adc/ad7606*` is happy now.

Reviewed-by: Nuno Sá <nuno.sa@analog.com>
Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/iio/adc/ad7606.h | 92 ++++++++++++++++++++++++------------------------
 1 file changed, 46 insertions(+), 46 deletions(-)

diff --git a/drivers/iio/adc/ad7606.h b/drivers/iio/adc/ad7606.h
index 71a30525eaab512fa811f28fa79268a1a976bc8c..dd4ae59dc59ab17e437171caf6d8a5abcce97f74 100644
--- a/drivers/iio/adc/ad7606.h
+++ b/drivers/iio/adc/ad7606.h
@@ -120,17 +120,17 @@ typedef int (*ad7606_sw_setup_cb_t)(struct iio_dev *indio_dev);
 /**
  * struct ad7606_chip_info - chip specific information
  * @channels:		channel specification
- * @max_samplerate:	maximum supported samplerate
- * @name		device name
- * @num_channels:	number of channels
- * @num_adc_channels	the number of channels the ADC actually inputs.
+ * @max_samplerate:	maximum supported sample rate
+ * @name:		device name
+ * @num_adc_channels:	the number of physical voltage inputs
+ * @num_channels:	number of IIO channels
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


