Return-Path: <linux-kernel+bounces-195584-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A86ED8D4ED9
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 17:15:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0C4AA287AE8
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 15:15:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F091217F50C;
	Thu, 30 May 2024 15:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="IA0CP7al"
Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DE1C17D8B3
	for <linux-kernel@vger.kernel.org>; Thu, 30 May 2024 15:14:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717082072; cv=none; b=th/EeQxaFSJFn+SVlyqdBZw22xvehqGl2coMRUHe6mkwpbBjNPcD2MqNGvblEn5vgxc6CcJoxBvDyfIFWTyCeuzZEvyNu1npzWJ9LSwr6vNgJDemaPP2MWiZC6faP2Fo5KN0UTPu7wng6W3myYyVD5YKOSm9dnVp3vk3Hj7c8YI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717082072; c=relaxed/simple;
	bh=ZRrBEnty0a3OvlAcxFKH/wVNDRG+6DSpTucqWWr66pQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YbWu2icWKjft3rudG0qq8jBmMsiDSfY7IVZBoh7I0ia/3y//qNvylB6rX6cDfUDsHMLEdbf3EBgqRHYuM+27HoDl4tnL6bc9SMdb2Ev0CHE9c1GFahdCvHVCLwSW5utzxILYqGcWk4U2e3qpBcUekb1d+z19oqZnDAECsqgqYO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=IA0CP7al; arc=none smtp.client-ip=209.85.210.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-6f8d0a00a35so38690a34.2
        for <linux-kernel@vger.kernel.org>; Thu, 30 May 2024 08:14:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1717082069; x=1717686869; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FbWYNDGeB4acdSvzLHvqWONXfu2Ni8kWHZVRyossuwM=;
        b=IA0CP7alcnAhoaw0ReGN3EZynNr/XEzvSWs+w6TKe4f+X5SVe04w8nFkvj+jymikic
         5QYcY3eBou1//g9hryIINrBQirenZ85DvWk5ppdc+u3r6WskxZIiF7HSNvEwAE/jzyAz
         q2yC6I3p1fafA+YBZC60mQ+3n9sVqBVpTsUEGNBUcI78wkYFJ1m7gTTtluVKJlH40KM8
         5WiXVRJNN2hWgQLNwU4M6wwQoNpuLO141M3B6wmMFttkd6CtZ6oblh94jTu6M4arzqs9
         MAY2fxA7hG1pcCpnaiWSP3c6Ew/+6u32i4veEDCl9n3J3OK/iGJIl0rnYHa0ECqU7ne+
         NNWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717082069; x=1717686869;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FbWYNDGeB4acdSvzLHvqWONXfu2Ni8kWHZVRyossuwM=;
        b=hN5FvNcsJh0f2rr89oHiuZKBclOGq9T6rVo4xS+wNJjaETB9yYFPNaJ8n3z3JxjYTh
         2QlwvtjCak94szlx6ayHfCHfgKEM2ZWa2yJXizsHtplH0x7l8yJ6k2z4dMt9Mr7t5NVM
         Ruz7ffnm0f7aBFhUFQtIvzG3McO7vIfx6sJZ1aTz7526PZOrjHMVQJFn20lsaWJvv5Rw
         /ogivFV+HFJojE1U6mL6DAqXrzpUsxpvlXeVkHnJcwHXF8jfAqAJnZJXgMToOPHxM0Kb
         eQ+BuuXqHZHSYUtsb73eCV6UU5PGYHVSfW00AAnP/Facbro1aDJprT70qhezFf07ddEd
         5XTg==
X-Forwarded-Encrypted: i=1; AJvYcCVje/4E3xZz7dyuIJvi7uyjAALPiHiqq0r+bcbg9cCBQQ/4nk92JE0mHZ4+oP7+haGKaJBmxpbRydWfUFT2GxOh63bw91tbqGyMbUaC
X-Gm-Message-State: AOJu0Yw15Ohi3V4V+d9FOdlJC9eo6yH0BzWOLcKbEQMUw47DT1cKKRWR
	Kmp3gOTrc8+5XccP4c9oEYzmIb/1B1dHBOk68Xub7wJ7f54SSyjt1C69pRbQj3o=
X-Google-Smtp-Source: AGHT+IE2lyAsahNdb+M+r2VsDVKfYnrWiFE+5vnGDiP3IBTld3L7Pf2jxyrJMpOL2y8G8xxJqtOR7w==
X-Received: by 2002:a9d:4802:0:b0:6f0:e7c3:945c with SMTP id 46e09a7af769-6f90af1c9b2mr2439771a34.36.1717082069189;
        Thu, 30 May 2024 08:14:29 -0700 (PDT)
Received: from freyr.lechnology.com (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-6f8d0de6314sm2803425a34.41.2024.05.30.08.14.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 May 2024 08:14:28 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	=?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
	Julien Stephan <jstephan@baylibre.com>,
	Esteban Blanc <eblanc@baylibre.com>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/5] iio: introduce struct iio_scan_type
Date: Thu, 30 May 2024 10:14:08 -0500
Message-ID: <20240530-iio-add-support-for-multiple-scan-types-v3-1-cbc4acea2cfa@baylibre.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240530-iio-add-support-for-multiple-scan-types-v3-0-cbc4acea2cfa@baylibre.com>
References: <20240530-iio-add-support-for-multiple-scan-types-v3-0-cbc4acea2cfa@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.12.4
Content-Transfer-Encoding: 8bit

This gives the channel scan_type a named type so that it can be used
to simplify code in later commits.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
v3 changes: none
v2 changes: none
---
 include/linux/iio/iio.h | 41 ++++++++++++++++++++++-------------------
 1 file changed, 22 insertions(+), 19 deletions(-)

diff --git a/include/linux/iio/iio.h b/include/linux/iio/iio.h
index 55e2b22086a1..19de573a944a 100644
--- a/include/linux/iio/iio.h
+++ b/include/linux/iio/iio.h
@@ -173,6 +173,27 @@ struct iio_event_spec {
 	unsigned long mask_shared_by_all;
 };
 
+/**
+ * struct iio_scan_type - specification for channel data format in buffer
+ * @sign:		's' or 'u' to specify signed or unsigned
+ * @realbits:		Number of valid bits of data
+ * @storagebits:	Realbits + padding
+ * @shift:		Shift right by this before masking out realbits.
+ * @repeat:		Number of times real/storage bits repeats. When the
+ *			repeat element is more than 1, then the type element in
+ *			sysfs will show a repeat value. Otherwise, the number
+ *			of repetitions is omitted.
+ * @endianness:		little or big endian
+ */
+struct iio_scan_type {
+	char	sign;
+	u8	realbits;
+	u8	storagebits;
+	u8	shift;
+	u8	repeat;
+	enum iio_endian endianness;
+};
+
 /**
  * struct iio_chan_spec - specification of a single channel
  * @type:		What type of measurement is the channel making.
@@ -184,17 +205,6 @@ struct iio_event_spec {
  * @scan_index:		Monotonic index to give ordering in scans when read
  *			from a buffer.
  * @scan_type:		struct describing the scan type
- * @scan_type.sign:		's' or 'u' to specify signed or unsigned
- * @scan_type.realbits:		Number of valid bits of data
- * @scan_type.storagebits:	Realbits + padding
- * @scan_type.shift:		Shift right by this before masking out
- *				realbits.
- * @scan_type.repeat:		Number of times real/storage bits repeats.
- *				When the repeat element is more than 1, then
- *				the type element in sysfs will show a repeat
- *				value. Otherwise, the number of repetitions
- *				is omitted.
- * @scan_type.endianness:	little or big endian
  * @info_mask_separate: What information is to be exported that is specific to
  *			this channel.
  * @info_mask_separate_available: What availability information is to be
@@ -245,14 +255,7 @@ struct iio_chan_spec {
 	int			channel2;
 	unsigned long		address;
 	int			scan_index;
-	struct {
-		char	sign;
-		u8	realbits;
-		u8	storagebits;
-		u8	shift;
-		u8	repeat;
-		enum iio_endian endianness;
-	} scan_type;
+	struct iio_scan_type scan_type;
 	long			info_mask_separate;
 	long			info_mask_separate_available;
 	long			info_mask_shared_by_type;

-- 
2.45.1


