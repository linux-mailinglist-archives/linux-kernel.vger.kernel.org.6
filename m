Return-Path: <linux-kernel+bounces-448184-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 235379F3C8D
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 22:19:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3DAF07A518D
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 21:19:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 756B21DB34C;
	Mon, 16 Dec 2024 21:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="fkTiktYF"
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C94F01D63ED
	for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 21:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734383851; cv=none; b=XsIWP/Q5eQD6+YbJPWpSUGJ/G5mD5N8FShHitOwEgXq/Jme7IDw1YYk+hHodQCyueHPXt47GAnMsyc2LaIwytJVzwt9s/waJReYJISGEDYHfLf1b8OTlqdhs9KVAZOUx5BHwxxOl99gqDzsiaTukrfY0ZbKnXclj2jgozyX3HiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734383851; c=relaxed/simple;
	bh=OSI5+enbqVnK80hh3GRt2v2/xjuyertlyl2dDt3BvaM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JVZMVQL4xAMTm+5D34O1LBGVvQE37uiMLbMGw0y70D+9lIkKqvUVavgyP22Y0/4FIaWIR/4zJ4J+jss7pj8+GJJl4oTnYBbT8NJZuvDJn4/BVKvmMJ7AqNAecbUDyGuQh1Ue4f71AHjx0tCHZYHfoVr/HXMuQfDe42QIwOfb69U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=fkTiktYF; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-467a8d2d7f1so29564711cf.1
        for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 13:17:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1734383849; x=1734988649; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=94GpRvEFGP1zDl7TooYa5XXxiXoizWnVF+RBMjgEO9A=;
        b=fkTiktYFTPmDeU9C4JP925QArvW+eKnHcm6j/H5w2zAykkSRytleeNs+VWy4zzwKTB
         +aYKjrb1UEjiGE6Du8jzPlIzSkdGhavIKg0Gbnk2WkrGHnPO3naJwCBiMxKlW8mBpNuN
         GOsPXWogbrd2ZH1g8Gj1fL7YemXx3isGnfgSs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734383849; x=1734988649;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=94GpRvEFGP1zDl7TooYa5XXxiXoizWnVF+RBMjgEO9A=;
        b=kR3p5lxHYP0BDhsk9yKohTU4UQYqSafRe/5/oEedC5ckWDLukzh9GyPG7nRYEp9na2
         ez7b/XE7YsW1AHXFCmKTkmEt0qkCOinYcyPOYzUTprzIdKec2szjI5HJzELHX/rpIY1f
         unDyC2OuZ+q9hrq4mFmhNRWkBhIvbADXR1XqAoNFRsj7i8nIoFXi9gotweoTq3JePukj
         2GbLD/eebfI9q3JRW2r0NDsB1GxyPWHePLGw1A8xQazE0zxn+JtKy/Oq4AqpQrnZ+UuN
         /6ne22NW+uQNbuheKjBdVckZyk5wNwK7dUaXSfLMm/zrkYFbuG+kDRON3fFqG+Owkqva
         t0sA==
X-Forwarded-Encrypted: i=1; AJvYcCVRJwajsbokogcpEIkjHiotCXFR+W7xyeDWIRokh1YUI8i5jfA4EGWGsymGS+RAxHdwWlZwb0Ah96Ty8g0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzmsfcpWmZhGXj5kk3YLTms5Nh3gFI3SjytBS+L0x4bGS2LAkh6
	bwCvFxUqvFo9jy6bj4JGRP4w9D0W4zXC7qJFnYT4JqUvGWpbhRhoyRFe0+5msG7j62ROcq30B1U
	=
X-Gm-Gg: ASbGncvxOj5qABY6OcnlekP3OL+TKb/6B6mRUMiOaVGonscd9JsTwV0w0hesJBIKH+W
	gJjY0+V6H9/esSIycqnX8pZ0Hh8CB/ZLpIGTo1BiiqRG7TS+ISrypgwiB9hsVv7m8Ra4Ad8FW/3
	UOET9g13j9Hn2EqEwyz7CD9C3vt/4y+2y7p4PbwYBE5bkHUa7JxPpwG/CzQWHoqqj6a8CdNo4ou
	P4yYWed9d1W0vLBpzM+cekXQwih8Xtm4RJf9OAdAq/pHRiylNwtNQa23msRGXfhIQU5Qu6XoiAv
	dYKvk0u8B4hUCV86mlahhd5ycktp2gI=
X-Google-Smtp-Source: AGHT+IFyzGw+gglrqm8+RhNerLly3LfTpt0cYg/FTCF385N1SMb70IaANKI6otHSuU62jnflMlYR+g==
X-Received: by 2002:a05:622a:1210:b0:462:e827:c11a with SMTP id d75a77b69052e-467a575a86emr267051701cf.19.1734383849004;
        Mon, 16 Dec 2024 13:17:29 -0800 (PST)
Received: from denia.c.googlers.com (5.236.236.35.bc.googleusercontent.com. [35.236.236.5])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-467b2e85c03sm31927501cf.69.2024.12.16.13.17.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Dec 2024 13:17:28 -0800 (PST)
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Mon, 16 Dec 2024 21:17:18 +0000
Subject: [PATCH v5 4/7] ACPI: header: implement acpi_device_handle when
 !ACPI
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241216-fix-ipu-v5-4-3d6b35ddce7b@chromium.org>
References: <20241216-fix-ipu-v5-0-3d6b35ddce7b@chromium.org>
In-Reply-To: <20241216-fix-ipu-v5-0-3d6b35ddce7b@chromium.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Robert Moore <robert.moore@intel.com>, 
 "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-media@vger.kernel.org, linux-usb@vger.kernel.org, 
 acpica-devel@lists.linux.dev, Sakari Ailus <sakari.ailus@linux.intel.com>, 
 Dan Carpenter <dan.carpenter@linaro.org>, 
 Ricardo Ribalda <ribalda@chromium.org>, 
 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
X-Mailer: b4 0.13.0

Provide an implementation of acpi_device_handle that can be used when
CONFIG_ACPI is not set.

Reviewed-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Acked-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 include/linux/acpi.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index 05f39fbfa485..fb88f21bffb2 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -854,6 +854,11 @@ static inline struct fwnode_handle *acpi_fwnode_handle(struct acpi_device *adev)
 	return NULL;
 }
 
+static inline acpi_handle acpi_device_handle(struct acpi_device *adev)
+{
+	return NULL;
+}
+
 static inline bool has_acpi_companion(struct device *dev)
 {
 	return false;

-- 
2.47.1.613.gc27f4b7a9f-goog


