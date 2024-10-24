Return-Path: <linux-kernel+bounces-379973-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A58919AE698
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 15:34:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0F48EB21622
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 13:34:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7313E1E3DD0;
	Thu, 24 Oct 2024 13:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="C2L0ccF8"
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8626D1D63DB
	for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 13:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729776551; cv=none; b=dODolIdzLEKMaIlZUgBiWXSxdGSg0akGPQuzSk5WbYgqGHHjD7vIdSmnGJkFQhs6yPvy6hnsUho6z5bTgG56aKTYmRfmqI3ZNsl+8jHVNIBOZI6HBalt7ZJ9UnS64eFc/rcWdnVhD+ZrHL+I8FbJDW5zAaD9/7wzWrcnNXFxggI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729776551; c=relaxed/simple;
	bh=bFwyN+jEa2XvW5Q/VvqMtLqk9XXyDIBC0cTMCtFmW8I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NAnpLfRK5H3BU2F5u2tXnAPeNGnEHqVC0qSWDLjVzRZypTwaV+IcDFDbf04BLdtvaG8sxHBBRnaUStDG5MXPmaBtwcI8+StoMXgIlCD/eQLDwHSNcpuBiGnd59gDs0qg6Ea6tBQ+fYuTAw0mC9PCYYYmQgoDfJYQ4OUrzFtChgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=C2L0ccF8; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-7ac83a98e5eso86418085a.0
        for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 06:29:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1729776548; x=1730381348; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zzgB0Dmc7SbGSRkZ42QPW9VmAklZSsdEpabG3evbtX4=;
        b=C2L0ccF89lMnCzO/lOABh9M2irnWtNlV01UNnDvwggDQWRVMbTuXginOlkd9tXDFYz
         jLADbOLpGsn4fEvcPOw1zPUFuRE5fwGkevfhGowXHdiCUXopCz9YPhdBDprM9Oj1j9CL
         NHSySKqLQdu8900ssc+GlEZ8O8iOJjy5PdHwE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729776548; x=1730381348;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zzgB0Dmc7SbGSRkZ42QPW9VmAklZSsdEpabG3evbtX4=;
        b=Jt1ZNGZ4pUX1oUahPu3GKWQ1ks/HCo+f0me9aec05e3uli5e+r2MpxMCM9WnsgbV52
         k+jDP/qhfq6nCMmnLEJXhIyxk82BLwN5Ul3+gE1Hm1k3TLYWl9nv4yfhyrhbK5T/FgEN
         Z7T3hDWdy2gMbVZGxQ7y2X4brgOa5cpc1zzl9cB2GlTBoIXUSFnK9RopEmNTHbQGY+az
         WWGSrRMEDofEbf4MXx1A26sQkp24igyUXC5LGcp4FU0a8DIW5JvP0/vpXvbkcNDzA8LJ
         JWvAx2xflWQBPJ+wm/AC7fTmynvMmS8a8B31I6q4+OZExd8VVdymTUbIB6XgwJCSR2se
         HFoQ==
X-Forwarded-Encrypted: i=1; AJvYcCVNTrhSgVGwE+zHhDW7SWL88LdkCVUjlh+YlklWEDIFxhj0oVIkiBy4C65+6dCUpZfyhK3QpcnPCwGqxvw=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywkp2KBLAkTDYggjBDD9EvzmoE7Xp4CfSkbwWwJ61lIxRb8SgKO
	IcAkF+FvwaNuwWPivBz0pNclfVS/TR6LwPf7YNTRDq6JX4U093OQKR5bGUEmX3bOxfYs83WnJIh
	Dgw==
X-Google-Smtp-Source: AGHT+IHOq1CHjjVbrTOuW87w2sexGCJD7U4FXEseprlQ/Sd8ltK1U55/s300FMFOWnd7m15YHmBXEA==
X-Received: by 2002:a05:620a:4621:b0:7a9:aa9e:3a9a with SMTP id af79cd13be357-7b1865e2a18mr350813885a.18.1729776547888;
        Thu, 24 Oct 2024 06:29:07 -0700 (PDT)
Received: from denia.c.googlers.com (189.216.85.34.bc.googleusercontent.com. [34.85.216.189])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b165a5d663sm484204885a.94.2024.10.24.06.29.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Oct 2024 06:29:07 -0700 (PDT)
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Thu, 24 Oct 2024 13:29:05 +0000
Subject: [PATCH 1/3] iio: hid-sensors: Add proximity and attention IDs
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241024-hpd-v1-1-2a125882f1f8@chromium.org>
References: <20241024-hpd-v1-0-2a125882f1f8@chromium.org>
In-Reply-To: <20241024-hpd-v1-0-2a125882f1f8@chromium.org>
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
- 0x4bd for Human Attention Detected

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


