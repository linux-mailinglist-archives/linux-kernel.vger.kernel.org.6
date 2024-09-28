Return-Path: <linux-kernel+bounces-342603-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 014E69890C9
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Sep 2024 19:25:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BAEBF2819B7
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Sep 2024 17:25:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E56116BE14;
	Sat, 28 Sep 2024 17:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="gGP4UWxi"
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11044140E5F
	for <linux-kernel@vger.kernel.org>; Sat, 28 Sep 2024 17:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727544260; cv=none; b=WjfM/55MiH9bt4imc0MMqqs+/tIiVYvbXVCIs5betBgAY/Kes80EPWIP6qx0/4XEsZAiemK1UTCDpvWU86ljliz4a/OjhtFiIkStwhKQnmfgad47VsJRMx5dWgwtpZqzV6/A8U+XVjgU+G5hy5BxqS311IzN605D+BlC9EUYqBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727544260; c=relaxed/simple;
	bh=hgkkoJn8PRzdejp8I35gJaE8ZuE8GBz1RxcmW/6Wl+g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=R59UL8kMVE4dT1kCag9HZ9zj0MMQqZmrG4vz3B+rt1pasEuhTM9mlJdu4yMZPhnfdm4c0z6LD+/DQFMhXvTcqjVu5kVTg8fqiGqxylKe672dK9+WjAgD/QG+QpOfOBvDbWMuiPWvTQB2eyUXu9qG6Z3vWyzpQbUzUtNnc9oAMGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=gGP4UWxi; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-6cb399056b4so20337986d6.0
        for <linux-kernel@vger.kernel.org>; Sat, 28 Sep 2024 10:24:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1727544258; x=1728149058; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0V4zAv66G9UTs98/sxGH5EUfTLy7Jj/aYXT4lmuMNEQ=;
        b=gGP4UWxigzZMNWCVVy9+SQBgmVXRcrwXOfz5rJqGQGO1ARuQL4UoY2/MQXj/JOoeJr
         DKjw2dbHAjtHjvDS+3quGpwpgikOmHrHEveksb+XOzAUz6BziS5ZEVNoDW3y3k4LRKgb
         NK6+zGoakPQuC4dCPkbJ6fUtrS21S/gMd5waI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727544258; x=1728149058;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0V4zAv66G9UTs98/sxGH5EUfTLy7Jj/aYXT4lmuMNEQ=;
        b=qCul9Lm+RU6HK9Z5Ljia75tsOZRRrlTngDIV7BFDsLAXaWQ+zZojs5Xil4nSbh3rTr
         i98ECuNMULfdIazXM0mlYbCCYuBDaMZmLdCmSf6DekR4NO0dRfXoEwxjkUudEP1yEfBY
         d21t6obWmoQKJi1Bp4hILjNZdiu+68eVGony7AMWYrvK7uF7JFKXjIpSA3yZ2s7BMtFq
         QHDktFgPy4gerOHI9kyujiaSv7zdBHSrWBQP27B10V1yq5FuevfyEbDkmUb3WeRETUJu
         kjsDFouPBJdkmrQJznX9xPBtCRvELhpmgMUdqXFsHt7ajEujWxf8aYHPqFN0/NPZRHxD
         9ang==
X-Forwarded-Encrypted: i=1; AJvYcCU2LLESPNxJDZqC0B5iXzts1x/M66Q7S0/8LaV5JwVFmFsKh9WH9gZFV84hNBleR6wIYDTPV1iITwIveZQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YycoViw+w8cbzZgJZhYZ8o+AuyoakE7ukGj4P7saD92kLfSc+nm
	8T3qZTQW2/BKu/dWop11ctkAiE++CPOfhzksD6adSdH+k3Bre3A02ykRG4TPsA==
X-Google-Smtp-Source: AGHT+IH+tjSCRlTFxQ4PkHc9qIvV7UgaC6LscTYg12k3dh3Dx2AnhCdOqFqATrCtJLZthR1CXmZWqA==
X-Received: by 2002:a05:6214:5d8f:b0:6c5:50be:dd74 with SMTP id 6a1803df08f44-6cb3b64cb65mr103688526d6.45.1727544257964;
        Sat, 28 Sep 2024 10:24:17 -0700 (PDT)
Received: from denia.c.googlers.com (76.224.245.35.bc.googleusercontent.com. [35.245.224.76])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6cb3b68311dsm21437756d6.122.2024.09.28.10.24.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Sep 2024 10:24:16 -0700 (PDT)
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Sat, 28 Sep 2024 17:24:00 +0000
Subject: [PATCH v3 3/3] media: atomisp: Replace ternary operator with if
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240928-cocci-6-12-v3-3-53fc5ed20be0@chromium.org>
References: <20240928-cocci-6-12-v3-0-53fc5ed20be0@chromium.org>
In-Reply-To: <20240928-cocci-6-12-v3-0-53fc5ed20be0@chromium.org>
To: Benoit Parrot <bparrot@ti.com>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Sakari Ailus <sakari.ailus@linux.intel.com>, 
 Bingbu Cao <bingbu.cao@intel.com>, Tianshu Qiu <tian.shu.qiu@intel.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Hans de Goede <hdegoede@redhat.com>, Andy Shevchenko <andy@kernel.org>, 
 Hans Verkuil <hverkuil-cisco@xs4all.nl>
Cc: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-staging@lists.linux.dev, Ricardo Ribalda <ribalda@chromium.org>
X-Mailer: b4 0.13.0

Replace the ternary operator with an if. In this case the code is more
clear and also fixes the following cocci warnings:

drivers/staging/media/atomisp/pci/sh_css_frac.h:40:17-18: WARNING opportunity for max()
drivers/staging/media/atomisp/pci/sh_css_frac.h:50:17-18: WARNING opportunity for max()

Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 drivers/staging/media/atomisp/pci/sh_css_frac.h | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/media/atomisp/pci/sh_css_frac.h b/drivers/staging/media/atomisp/pci/sh_css_frac.h
index 8ba65161f7a9..3191d2858f59 100644
--- a/drivers/staging/media/atomisp/pci/sh_css_frac.h
+++ b/drivers/staging/media/atomisp/pci/sh_css_frac.h
@@ -37,7 +37,8 @@ static inline int sDIGIT_FITTING(int v, int a, int b)
 	int fit_shift = sFRACTION_BITS_FITTING(a) - b;
 
 	v >>= sSHIFT;
-	v >>= fit_shift > 0 ? fit_shift : 0;
+	if (fit_shift > 0)
+		v >>= fit_shift;
 
 	return clamp_t(int, v, sISP_VAL_MIN, sISP_VAL_MAX);
 }
@@ -47,7 +48,8 @@ static inline unsigned int uDIGIT_FITTING(unsigned int v, int a, int b)
 	int fit_shift = uFRACTION_BITS_FITTING(a) - b;
 
 	v >>= uSHIFT;
-	v >>= fit_shift > 0 ? fit_shift : 0;
+	if (fit_shift > 0)
+		v >>= fit_shift;
 
 	return clamp_t(unsigned int, v, uISP_VAL_MIN, uISP_VAL_MAX);
 }

-- 
2.46.1.824.gd892dcdcdd-goog


