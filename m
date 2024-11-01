Return-Path: <linux-kernel+bounces-391837-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BF489B8C38
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 08:46:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0873C1F2315E
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 07:46:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 471AA156237;
	Fri,  1 Nov 2024 07:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="bJRS5Dw5"
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 009F01547DC
	for <linux-kernel@vger.kernel.org>; Fri,  1 Nov 2024 07:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730447196; cv=none; b=mSOcyulDV2b3MDaclyrNvj3UK0Ok+cXXtT5eAkwpXIkMkkcmaq76pX57DM2iOnhqWW/25sIyfeZ5UFMafvpkNveuKUxM3qANQ3zHwENehyQdtNHQa8o0j4zyPGzQGFXuiNKwCwMRXFEwsu25SbxMj61IDWcpGHPXMDwK1DRjS/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730447196; c=relaxed/simple;
	bh=E5IKpWlBrs6BrNxKGj8gL69lGAFGxkNE1Vi/39M/35Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=s1dOmKlMuKk1AF/RQZj0Yn68Vr3SaYLH0tFSHkApSa4ZgInB6ixNSNAuibZMKeBgnaR1/NJcEDVM5Yt8CP9DewulCRF3Gy8Uy8Sg6fr1PfnpuFF7B+G3hzS1POaievZRaQVF8WMrFXX9uuyef3x8a9OkzzsLE/CEtJ5XPn5Le0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=bJRS5Dw5; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-6cbf2fc28feso10275526d6.0
        for <linux-kernel@vger.kernel.org>; Fri, 01 Nov 2024 00:46:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1730447193; x=1731051993; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XRIQcTwMhYqGctEPu/xoF4uEWBP35j2ZdxAtYHSbb2E=;
        b=bJRS5Dw5Wtylh77JiND2eJPvXo38bl8BLLLMdbb+3nFGYV3u/RcUJPmbPrUZoj4WAJ
         fUnuue8zJWyjeeoyatVZr0HwGvzULX8LjhbjTseKVW+lz8Nmxzzz0t8QwoVXvl1qAweE
         hZ7lnIkXc2vGSNqH4hKHMa72JHo9Hqyqn8iVM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730447193; x=1731051993;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XRIQcTwMhYqGctEPu/xoF4uEWBP35j2ZdxAtYHSbb2E=;
        b=kqSWBJqIql+i7vBQHMPQqpRRbL1jsHZRmi5tyDWr5doxri0dwb938i1NUqK3duvhqX
         iwWKQA7blejaN4KkEAnMaskr3v8iO52IBKziHtL3eoP9lZIVFwWwcGVBOevZ1TL1DDRA
         KWrY9qlUsqGdd850MjbXIqtkzXopgpDPHlB2x4xDuRIBo/sz7XdVr1VpMcigOyOOMj58
         1tzTNkYiUGpC9zO3fIrrCLYJLpeNMb+k1sLkul9SzzHICCZimPmUHWvK0VRdqpVPhs3d
         v5tjUFfMvNdT4z1dD5acULX15udaDhTJyD4q0h97HH5U+57KWKSerhgtfQl4hspa/Oxu
         EJyA==
X-Forwarded-Encrypted: i=1; AJvYcCXAfkXDNN3lJGBGpoDftTu94P6Pr49eB2b/qG7D+3embqkWi0x2YSHkDv8pHxqlz/6cKT087kMl3adn8BE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzSCWY0JZX9tQOLN6gy+hum8Qd1HkgWu65xUrxX1mwr5zuYrwEx
	CaYJDcVHhw3xTxs0+TsJ7AJPvSawV6Xr8MJi/Mq7kdgHoql0bK2c4uvzx5x69Q==
X-Google-Smtp-Source: AGHT+IH85FO08smW7QUBXDwLWXCmrXXu+RueVAcXXNTAt6+T1hoAvANzKfmJkD42BgY3VSx0XSfq7Q==
X-Received: by 2002:a05:6214:54c3:b0:6cd:f236:d127 with SMTP id 6a1803df08f44-6d185683724mr358670136d6.2.1730447192949;
        Fri, 01 Nov 2024 00:46:32 -0700 (PDT)
Received: from denia.c.googlers.com (189.216.85.34.bc.googleusercontent.com. [34.85.216.189])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d35415b1casm16444236d6.78.2024.11.01.00.46.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Nov 2024 00:46:31 -0700 (PDT)
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Fri, 01 Nov 2024 07:46:27 +0000
Subject: [PATCH v3 1/5] iio: hid-sensors: Add proximity and attention IDs
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241101-hpd-v3-1-e9c80b7c7164@chromium.org>
References: <20241101-hpd-v3-0-e9c80b7c7164@chromium.org>
In-Reply-To: <20241101-hpd-v3-0-e9c80b7c7164@chromium.org>
To: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>, 
 Jonathan Cameron <jic23@kernel.org>, 
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, 
 Lars-Peter Clausen <lars@metafoo.de>
Cc: Harvey Yang <chenghaoyang@google.com>, linux-input@vger.kernel.org, 
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Ricardo Ribalda <ribalda@chromium.org>
X-Mailer: b4 0.13.0

The HID Usage Table at https://usb.org/sites/default/files/hut1_5.pdf
reserves:

- 0x4b2 for Human Proximity Range
Distance between a human and the computer. Default unit of
measure is meters;
https://www.usb.org/sites/default/files/hutrr39b_0.pdf

- 0x4bd for Human Attention Detected
Human-Presence sensors detect the presence of humans in the sensor’s
field-of-view using diverse and evolving technologies. Some presence
sensors are implemented with low resolution video cameras, which can
additionally track a subject’s attention (i.e. if the
user is ‘looking’ at the system with the integrated sensor).
A Human-Presence sensor, providing a Host with the user’s attention
state, allows the Host to optimize its behavior. For example, to
brighten/dim the system display, based on the user’s attention to the
system (potentially prolonging battery life). Default unit is
true/false;
https://www.usb.org/sites/default/files/hutrr107-humanpresenceattention_1.pdf

Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 include/linux/hid-sensor-ids.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/linux/hid-sensor-ids.h b/include/linux/hid-sensor-ids.h
index 6730ee900ee1..8a03d9696b1c 100644
--- a/include/linux/hid-sensor-ids.h
+++ b/include/linux/hid-sensor-ids.h
@@ -30,6 +30,8 @@
 #define HID_USAGE_SENSOR_PROX                                   0x200011
 #define HID_USAGE_SENSOR_DATA_PRESENCE                          0x2004b0
 #define HID_USAGE_SENSOR_HUMAN_PRESENCE                         0x2004b1
+#define HID_USAGE_SENSOR_HUMAN_PROXIMITY                        0x2004b2
+#define HID_USAGE_SENSOR_HUMAN_ATTENTION                        0x2004bd
 
 /* Pressure (200031) */
 #define HID_USAGE_SENSOR_PRESSURE                               0x200031

-- 
2.47.0.163.g1226f6d8fa-goog


