Return-Path: <linux-kernel+bounces-440225-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E41229EBA72
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 20:57:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E20B2167924
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 19:57:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C54B7228C98;
	Tue, 10 Dec 2024 19:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="QkvUaSsD"
Received: from mail-vk1-f176.google.com (mail-vk1-f176.google.com [209.85.221.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A71B3229B3B
	for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 19:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733860584; cv=none; b=P9cCXWlea/EW5Vb5ix9E4vcefegW2/A1rvBRzGkSPTJ7mfOzoZebfsRvgux37pWhR1N1hWw8FKsEYzZINHDfLcDXhBu8t3FUDnVYyhas8GT8TmgFmzX8iEFuUseNgXNGx8KAuNu2rqOWi1UbjkXCV8cO3gOCqiIN4KDe+D5EuTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733860584; c=relaxed/simple;
	bh=Whh0DQItzHYKCLXHq+kfFC3x+7+Dk004xdEIyRizvX4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LWqyHj1zAabQ37K8ppUiJ3QzqTa7rTKJZdO8/sFl4XaPwK1YNPv/CGmczQ5pVxXY+kzNiaoS48MDJLC+5PwEdUkSDEELwaGvFPlzpPSJGcrfPEKMRHRACJam4KlLOR6YOOfbbSTzRkS8BE800heFpB2naE4ES8axRIvijQAM7kA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=QkvUaSsD; arc=none smtp.client-ip=209.85.221.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-vk1-f176.google.com with SMTP id 71dfb90a1353d-517ae9ff6e8so762551e0c.3
        for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 11:56:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1733860581; x=1734465381; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=y8Rm27YENFKXAm/b99nWNPn/wMV7ojkGu352W65SJ+Y=;
        b=QkvUaSsDjiaKz2N0cUsM9qtCGW0xthUakRBDtOZqKdtK4jG2jUqgbMhI3n43H0+YqT
         SmLX0FldveJuUcacSKDYeZBWIv9Bn8zLiSS636aIXDBVJ6aYwpRHADGKx+TJ4vTCF+A3
         WV/WuXdK89/b2l9+3Llaqrz60WkOLXK11QRjA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733860581; x=1734465381;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y8Rm27YENFKXAm/b99nWNPn/wMV7ojkGu352W65SJ+Y=;
        b=lXJ8Ket1SdIUblul7Wfh/zkgOZcWDfU2fG/I68cPiQFCPARXE9EOvrbxWkCilvppvI
         pFV7INmZ67XypWFhsqfFdEToNdQjdn6gY13pkncB8lp+jxcyzn1fg54uRU9MeJP8JvE4
         jBlKEGrF5izmgg62vKvK8RmwUW/WpF15u1fGodfxjS4guADUUpLaaGgJW4X11DA6Gcyo
         +0sNJzeu357uO54WgO68uGym3caOo7inmirEdaALOVArh4c33CIZFyqWnQHOgg7OLb0F
         HKeasyHRwKLw0UPsts1/r7pI3iS922yPK7IHl3ydcFbXglQXZz1ADMeoB8Y1AorGiMnF
         CTDA==
X-Forwarded-Encrypted: i=1; AJvYcCX9wuX0XAU0go0BqS577yq1EYrCGNcU7x/COuTbQMUZhecVgW2RYAmaqZuBg7rbgk3H9mZXzoFY41xKe6E=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/0eyoyGR1sx8bu52JBx1WtTsV1AZCsPizoJgp1sRcQxtSbReb
	QJFpy8Qx1HfhdCc/WXM6Ra+p52qm/jZSU0okeq15ru2Lz8pca3gAawk6KsOLwecgwldwP+Rj1Gg
	=
X-Gm-Gg: ASbGncsF/MfjpMcc1Y709u1pb6Jl7lX6X/eLglVSHkWizF6FaJFsKV4MXgzFeCxp0+F
	YvS19Y6CooJsITl+kSSL+26GIWYjbcDR16JL308lDpf0K/fMom8QnsM6DDW3uW8QIIIY6XNTdS7
	la0ZKI7iiRmVNxiqLY436D7ptpX24paQPhAj5NaZqPoZMtxrh3biH1Ld/n21fLqnBnM2fXAMUmZ
	PAYZ3P2tffHk5xeyF7H75akpUSMZ4so2UYQTDE3uHZlz1MDyF4QyiVpJcwEk7gZOzjze0LfOG5E
	Nwdy8XOdkNBe7735HC0d8HCAeXV1
X-Google-Smtp-Source: AGHT+IEooHxihkgq0sisqhW/5irMfcedK/Z/FIef/F30lACx1FcjAKe1abfF7f/u+XsC/FOi7CtYPg==
X-Received: by 2002:a05:6102:ccb:b0:4af:a925:6b40 with SMTP id ada2fe7eead31-4b12913b260mr760661137.20.1733860581729;
        Tue, 10 Dec 2024 11:56:21 -0800 (PST)
Received: from denia.c.googlers.com (5.236.236.35.bc.googleusercontent.com. [35.236.236.5])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-85c2ba7dc70sm1279522241.15.2024.12.10.11.56.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2024 11:56:20 -0800 (PST)
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Tue, 10 Dec 2024 19:56:02 +0000
Subject: [PATCH v3 5/7] ACPI: bus: implement for_each_acpi_consumer_dev
 when !ACPI
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241210-fix-ipu-v3-5-00e409c84a6c@chromium.org>
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

Provide an implementation of for_each_acpi_consumer_dev that can be use
used when CONFIG_ACPI is not set.

The expression `false && supplier` is used to avoid "variable not used"
warnings.

Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 include/acpi/acpi_bus.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/acpi/acpi_bus.h b/include/acpi/acpi_bus.h
index 520f12155e7f..4f1b3a6f107b 100644
--- a/include/acpi/acpi_bus.h
+++ b/include/acpi/acpi_bus.h
@@ -1009,6 +1009,9 @@ acpi_get_physical_device_location(acpi_handle handle, struct acpi_pld_info **pld
 	return AE_ERROR;
 }
 
+#define for_each_acpi_consumer_dev(supplier, consumer)			\
+	for (consumer = NULL; false && (supplier);)
+
 #define for_each_acpi_dev_match(adev, hid, uid, hrv)			\
 	for (adev = NULL; false && (hid) && (uid) && (hrv);)
 

-- 
2.47.0.338.g60cca15819-goog


