Return-Path: <linux-kernel+bounces-418044-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CA229D5C5B
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 10:50:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 41DB2281D28
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 09:50:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E02601DF243;
	Fri, 22 Nov 2024 09:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="A/sY87vJ"
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 516261DED6E
	for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 09:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732268910; cv=none; b=Hg4dZEozcwS96A8068y3mIF+4COYpY/NyIjAkHG9h45JlfGjk0BqVLfCM9x/s3fi9+A6Xs3Yd+820VpZk+ZXB2YjBUFOjTXeanv0YzoZ40xHUE5V9hEHT/GbWr93Z8NUcp0Tf90SNI2R9Dty8RQW8RWOvjONM3OSw/lzbQpx/is=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732268910; c=relaxed/simple;
	bh=4H1xI8rZic7uj8BVAr4deS1lVj9r+ITu7MlYRDSB8Ik=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=faLVDRlIom3lmu7eCo97PWMADIzV7GmRJx4gYurpUjJ8dJSC30a7+WDyMWZJTvpcXk/O8jXikDN+6p0eFWIvEGy8pAQtcJvfcXqJ1m3yMHHU7MhwonfdTYdU1/r9ikTluyY3fe9qvBdpAZ59SAVsSh6+lJD3dAUWvBjMmEMDt+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=A/sY87vJ; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-465392a6844so8249591cf.1
        for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 01:48:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1732268906; x=1732873706; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VrSmAj2jkvytw0rNLCddg1aexjt2xHCHXsrUaR3oGCc=;
        b=A/sY87vJxtLNW3pnMxjNevbIQvdRjQ4qjdxdDwQOBUUB4T7cEX9oxWyKrlDGKyfKRN
         Rk3LMSBF4ln1WUQLoY8ED0ux27iR8uspjKKZfg+K2LL14MmUks9R61PUn16FBb5ryQZF
         GWDPKk2ShrGJjhKngu+NSbYVjROvh+Mpyz9cg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732268906; x=1732873706;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VrSmAj2jkvytw0rNLCddg1aexjt2xHCHXsrUaR3oGCc=;
        b=bKk1IGrpVDzk8kLAB5iAA5sFrqMAXB/hMhWwccE2E3Qznq89l1Rd3qtEC/Ruo8V9So
         0GxRQc13Ker5i+SL/5FcmRY8wFfnsDfVbWVRzCMMWkqZ5eHoRnDji8z2GPsrJL6tkCWx
         p6fiA8KahbvTVWoO00btNUboVZnOVQucRTUgDzTHudq7Xg7eUFmR+FNQcyE55V3/SYSL
         Gfn43UwOSCNHrEEtBKc1KVz2YRpL+gnrEyyDXHWegfLrBZgxgtzF9VuKTbghAmPM/q+F
         XcOew930N3BqIxNib0BhIyN6m+mlo9cKi+WIRzVhfLmybHWWircbmEZIljVd4w4n1KHQ
         MzRg==
X-Forwarded-Encrypted: i=1; AJvYcCX+Sy4LeyKuu6eIJyWWso9dj6ImHjnzpGLYPeoueNmeJYqbO8LzTrCbdxxekXRxpLRpUaWfupPNiUguRUI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzDvj/mbeGcurYIQ9V8/WNNZmNz68SiOFrEgrxcx3aBQjQm1ViL
	S0IFJqt2XEvPnmdEf/Gh2PwqYpjYgLLGrpjSnVCstsgWcsj6wYm59ip/XWLLXw==
X-Gm-Gg: ASbGncsn6bVdsDn1c/AQ8K4ugDUEeH8Eq2l3xjlj494uNaXn3t1KMQpg1eyHlYLNGTN
	t1F0L4efL6AX7poahGlM3fywc37Swxj5r1f0A94vY4LWbtCY7xOZLwdfFYFmPxb3zYk5FrmeFqM
	TANIaH0goGMKBDyH6VZfAJwxsP+W1xZ2l51zdLh9VxZb9HZqsEz8jF/lWiupOsWZENNFDNpw1Og
	EOj2Gvw6qrFPp4t9ktJlwtPGFi9hx+CXkUPKZDXa03pt4mk7RyxFqQvTVQS2T8BIw2VpHT3tKm9
	lQo66/YRQSiTVWu8gbhZA1At
X-Google-Smtp-Source: AGHT+IFru2WAUE4DOiSVjGZ5la48og7nHQB/1X/SGFbEnNNed0D8aT6/FZPgrfye+Wt1XXhUhzTTyw==
X-Received: by 2002:a05:622a:2d2:b0:45d:9357:1cca with SMTP id d75a77b69052e-4653d57be12mr23934371cf.14.1732268906271;
        Fri, 22 Nov 2024 01:48:26 -0800 (PST)
Received: from denia.c.googlers.com (5.236.236.35.bc.googleusercontent.com. [35.236.236.5])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4653c47f124sm9282731cf.62.2024.11.22.01.48.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Nov 2024 01:48:25 -0800 (PST)
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Fri, 22 Nov 2024 09:48:02 +0000
Subject: [PATCH v2 5/7] ACPI: bus: implement for_each_acpi_consumer_dev
 when !ACPI
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241122-fix-ipu-v2-5-bba65856e9ff@chromium.org>
References: <20241122-fix-ipu-v2-0-bba65856e9ff@chromium.org>
In-Reply-To: <20241122-fix-ipu-v2-0-bba65856e9ff@chromium.org>
To: Mauro Carvalho Chehab <mchehab@kernel.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, 
 Robert Moore <robert.moore@intel.com>, 
 "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Cc: Sakari Ailus <sakari.ailus@linux.intel.com>, 
 Dan Carpenter <dan.carpenter@linaro.org>, linux-media@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, 
 acpica-devel@lists.linux.dev, Ricardo Ribalda <ribalda@chromium.org>
X-Mailer: b4 0.13.0

Provide an implementation of for_each_acpi_consumer_dev that can be use
used when CONFIG_ACPI is not set.

The expression `false && supplier` is used to avoid "variable not used"
warnings.

Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 include/acpi/acpi_bus.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/acpi/acpi_bus.h b/include/acpi/acpi_bus.h
index 4888231422ea..57298c7cfb5d 100644
--- a/include/acpi/acpi_bus.h
+++ b/include/acpi/acpi_bus.h
@@ -1005,6 +1005,9 @@ static inline int acpi_wait_for_acpi_ipmi(void) { return 0; }
 
 #define acpi_get_physical_device_location(handle, pld) (AE_ERROR)
 
+#define for_each_acpi_consumer_dev(supplier, consumer)			\
+	for (consumer = NULL; false && (supplier);)
+
 #define for_each_acpi_dev_match(adev, hid, uid, hrv)			\
 	for (adev = NULL; false && (hid) && (uid) && (hrv);)
 

-- 
2.47.0.371.ga323438b13-goog


