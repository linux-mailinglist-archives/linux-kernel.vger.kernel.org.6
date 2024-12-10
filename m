Return-Path: <linux-kernel+bounces-440224-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 945EB9EBA6F
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 20:57:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 895BF283BBE
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 19:57:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 874EA228CA7;
	Tue, 10 Dec 2024 19:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="eS0bQQSR"
Received: from mail-vk1-f178.google.com (mail-vk1-f178.google.com [209.85.221.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45397228C90
	for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 19:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733860582; cv=none; b=jeHzBy0CYJzIjAGmUVoUg4SQIrrAjKSRZ7uMbi0qwml+HdOTTHeCC+GTR4mZARFuSc1A3kn9L65dDTbmOrxEMsSkkpvHqAdBaX4MC3TEgKXuCCOiHYOuNJMc2zuYTv+OSemzWvzJtOtp/b3aOM148JyQZLPd20QE5QDxyKUaD/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733860582; c=relaxed/simple;
	bh=oQ6DOmEDhAhaC7ko0Me30Rr/Q1eMZQPunpUP2qNklrs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tWl2Me5VjA4WgzkUTP/vAuPGDeETbAhN1V1VekUn0Ti5kHRenBu8FDdtXk6VBMGOiwfmy+9E73B8kEeJV2lLCmQkLbpyICdiCowioyvnlrqh0WEf3FKf6K+0uGCSiiZezx4wXFGnIGMVYi1BgPBvr3VEm1y22NQM5hx69yxFT3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=eS0bQQSR; arc=none smtp.client-ip=209.85.221.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-vk1-f178.google.com with SMTP id 71dfb90a1353d-5188c6f260cso433105e0c.1
        for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 11:56:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1733860579; x=1734465379; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lezNY8dR9ljfu1iEN3ZQdA0hj9drLp6T4ntvpJiXGhM=;
        b=eS0bQQSRKOkRTg1R00Lzul3TSSpu/eJPD7952BfrCPISozqKj5oTrH2z+ycumAO7P2
         aqMeIYtSUBs9+yuennfm1GB1PlaEgI6Lvc0xLC6rU8Vc+wEEuIKK5bNUBtqUmCbogqVG
         KMc46btlPwz1ne0c0cRg0s/yOEeBRJApCUoHM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733860579; x=1734465379;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lezNY8dR9ljfu1iEN3ZQdA0hj9drLp6T4ntvpJiXGhM=;
        b=ImSjDEhUTiuQm11AxDjjmgpBTyIJl9uoOdowla7Lc2wgbMMlMbzSKmBjWUa8Znso1U
         SqELkwTaed7EyTlTvyIp5f1H1ocrl1UxQVbRcLwHfc7u8gCBbz4EomWOvlSedX4b9eYO
         6xw973/i3WIV5xxUyGYvyGYU9igMvDpjD0Lw9FkchF2vgPPXOaglRBhv1xrNj1HGA+9L
         ObUyrCVZX12wyCf9i7ADyvphwZwwH8YKNoIgNbT+EjFVArzWVWKxTcTsMVudMWKcj153
         fqyMkMwNfOW0c284ismK8wb8TkOLt5ioc6griFKPe5cf164NrXI1oUAlhk0xirCorrzG
         +1NA==
X-Forwarded-Encrypted: i=1; AJvYcCVAavP0UCCquTQ4n0yIHyy0GhzhiYEaNPlh9/CTEFlU8wqoWO+loIDhEVV3Yo7pt+AyXj83kRxN88lddW0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2ZSmNFNRgCtFrdgTIO4CZh/OeE+nDvOXnA+v33u2CLnGcNrSM
	6VHVhhSiIJVQE6h+Tt4zXtHB7JTkvQPXL1VgQTix32js+Fo8oVdTGDL56cV7Kw==
X-Gm-Gg: ASbGncvOGMH/ZZ/041Uhw/J0X/ViozY2qJ7k7LovVda52lZ2cJz8OhC8b5gju5Ghe+8
	BBJr8y0VbiK7+XyY+QRjykwrNqVFY6OvyHOlg2uTFFYHWw+WKLi/LxtixtsbNsz2xBLLcsgTdr6
	OqvuYoHD9qvg4KjbVPJyqyghOTQ5sYtxr9Dj+8KelTiWgh3yU0z7Dj5nnFSXs+5BxVHTkwTIl5U
	ewnfSTUQmE3U8vs3mxAvgAnYyAtDw8ewZNggPPk+r/rgsK93ZuyKt9l/H+gthbNnUPBevIJ8O24
	xseDKmfpiMhrhEHrZSzaX5evjtPb
X-Google-Smtp-Source: AGHT+IEMhYnLWvQoSWZmZsMGZeYTR3YN9TLWCv16La+76YSYWE5jDBmdmVAao50oTu5BwjDFJ7Yo7w==
X-Received: by 2002:a05:6122:1d8b:b0:515:c769:9d32 with SMTP id 71dfb90a1353d-518a3a34d65mr938780e0c.4.1733860579349;
        Tue, 10 Dec 2024 11:56:19 -0800 (PST)
Received: from denia.c.googlers.com (5.236.236.35.bc.googleusercontent.com. [35.236.236.5])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-85c2ba7dc70sm1279522241.15.2024.12.10.11.56.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2024 11:56:18 -0800 (PST)
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Tue, 10 Dec 2024 19:56:01 +0000
Subject: [PATCH v3 4/7] ACPI: header: implement acpi_device_handle when
 !ACPI
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241210-fix-ipu-v3-4-00e409c84a6c@chromium.org>
References: <20241210-fix-ipu-v3-0-00e409c84a6c@chromium.org>
In-Reply-To: <20241210-fix-ipu-v3-0-00e409c84a6c@chromium.org>
To: Mauro Carvalho Chehab <mchehab@kernel.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, 
 Robert Moore <robert.moore@intel.com>, 
 "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Cc: Sakari Ailus <sakari.ailus@linux.intel.com>, 
 Dan Carpenter <dan.carpenter@linaro.org>, linux-media@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, 
 acpica-devel@lists.linux.dev, Ricardo Ribalda <ribalda@chromium.org>
X-Mailer: b4 0.13.0

Provide an implementation of acpi_device_handle that can be used when
CONFIG_ACPI is not set.

Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 include/linux/acpi.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index 05f39fbfa485..59a5d110ff54 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -787,6 +787,12 @@ const char *acpi_get_subsystem_id(acpi_handle handle);
 #define acpi_dev_hid_uid_match(adev, hid2, uid2)	(adev && false)
 
 struct fwnode_handle;
+struct acpi_device;
+
+static inline acpi_handle acpi_device_handle(struct acpi_device *adev)
+{
+	return NULL;
+}
 
 static inline bool acpi_dev_found(const char *hid)
 {

-- 
2.47.0.338.g60cca15819-goog


