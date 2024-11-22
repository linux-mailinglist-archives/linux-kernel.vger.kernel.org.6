Return-Path: <linux-kernel+bounces-418045-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 10CF89D5C5C
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 10:50:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CB906281FC6
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 09:50:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1086F1DF245;
	Fri, 22 Nov 2024 09:48:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Swx+cqMp"
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9C0F1DED58
	for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 09:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732268910; cv=none; b=R3Td3eGCS6cCpkhnJBMirJS5rrw0oZqN3OvbbRrAVBAaTabBSy2uI9nzUzZMP8/TFKliVyWogNpi+dALML/pDwC/BCP4NKznzxVmBg7ZzP9EO7hCFdyFDZGDqrhObUG103d6aWzR18lxUf1x7SHxvPGMkC/9Ssrr4B0mTd8hkbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732268910; c=relaxed/simple;
	bh=BYuLHzueav0sdSprQfzk88q4Y6f26g51RU20Q1WXi6I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XcDWF6/Zrj+rfoDNMCQK+zNgjvrFuY4zCy5GasJccJplBz8yoVzjlxjWdakuFfwrkx5+F590QXro/YjhDo9x6qhKnREtxMqMbxj3EbB18O0fnp5hbeMLQbMKa5pTGbAmxJZzsCeUYKf2IBUZBS+xFFMHZCLojXWd2RKbYSKDVe8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Swx+cqMp; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-4613162181dso11148321cf.3
        for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 01:48:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1732268905; x=1732873705; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Acc8f5vjpjnUsttSTKqKG5ha9p9/8KASrkXH0sEj3iU=;
        b=Swx+cqMprFgLvaSl+WDnFWbXqyPb1COCP+tO98Oly3pcw1UZozCkYWVS6Lm4HkTodX
         olgFILbOfld5/PZpesnWfV6rDfOJh/U5TXIqY38hNUR2xA9Ev7fMhIwvbgzhkSYZF0dd
         0BrfQbG/NtOPfLf/s4ibj1f1jTKgBMEotrx6o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732268905; x=1732873705;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Acc8f5vjpjnUsttSTKqKG5ha9p9/8KASrkXH0sEj3iU=;
        b=ZJP3tu+Bzd2+VNaezXApDiiz2FhW8uigEj+IxL8d2we+lnCjlDftmhShSgwcuk5Os2
         4XuauHNYs3zLVtmuZtckXafS2j8+cPaORSm60xELa8PaQ5D/IdGjrYyU3wEcf7hzLAzB
         XZ+RXxhmQEgmzOLDMl1eMc908DlrYQ/b3goIGf4iIsM8Jo3Ead+O6O5VEsdTmtGNSN87
         jbCGc8lDeTd0YGOE1gJ0S/KGkOo9I6yfaQcWKC1uZ5xbBIS+d7RLjiiKl/P/VNPjfZsD
         qLrOvSlIGSbSsfSZd/6IehstIOZ3fJ+bzIYslp8S2OXZgeEI2u/Pj7tpcWMeoZr6M4Vt
         aOow==
X-Forwarded-Encrypted: i=1; AJvYcCUmnHo97pM4MCgKZ4GDVQH5H7KBKwYlJ5WqeO+AOK5rY4HgGSc6n+wWzja3NOb0X9+DaYzz+0QwriI/6dg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwopB0DEERlGd+aLJya1td0TD6b54IBVDygLd/6n1jUsAk4oytw
	f/Xvvm/GDI1c3A/n8bYJk2MZiNt5etK0d7JG6NNZtX+mZmIqfwSFc3rfeLMe5Q==
X-Gm-Gg: ASbGncvS/NTOBu95QqKflQINMm9I54guA/NEl31/2XpQeLbGhtWcakHkEp7+2XgLePz
	5OCcwiqZgihBm7yOQ5/QSee4CPPR+613YGWGLeBsHIRNNK71DSK8fWeaKeKmDQ+EN/+DGvCguzf
	OsG+h0aPrgaLO+MUXEoHNhpsKHYnpghDQ8IKtf3a8xe15bAh0/BbzQBJtIpTjiLIzTvwUJEmNGY
	l+zCMhqajSRCneMbv2Y/aXGxhgGw74GxMy61cjcNPUASvJ3AdLCjyibKgMj5i0Jpoymu+45P6Ui
	TkAkTBTeUCpz2tbcCvtihy5H
X-Google-Smtp-Source: AGHT+IECFL9WoKiDiu1xKptVQF2T2gvsl28cr0HW2a0s9qqj6Aj7Q+ZZVLocd/R1cde01FoPlwJaWg==
X-Received: by 2002:a05:622a:1ba9:b0:464:889f:a413 with SMTP id d75a77b69052e-4653d5344f9mr24237121cf.6.1732268904929;
        Fri, 22 Nov 2024 01:48:24 -0800 (PST)
Received: from denia.c.googlers.com (5.236.236.35.bc.googleusercontent.com. [35.236.236.5])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4653c47f124sm9282731cf.62.2024.11.22.01.48.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Nov 2024 01:48:23 -0800 (PST)
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Fri, 22 Nov 2024 09:48:01 +0000
Subject: [PATCH v2 4/7] ACPI: header: implement acpi_device_handle when
 !ACPI
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241122-fix-ipu-v2-4-bba65856e9ff@chromium.org>
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

Provide an implementation of acpi_device_handle that can be used when
CONFIG_ACPI is not set.

Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 include/linux/acpi.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index 4d5ee84c468b..85d7649ac17d 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -777,6 +777,7 @@ const char *acpi_get_subsystem_id(acpi_handle handle);
 
 #define acpi_disabled 1
 
+#define acpi_device_handle(adev)	(NULL)
 #define ACPI_COMPANION(dev)		(NULL)
 #define ACPI_COMPANION_SET(dev, adev)	do { } while (0)
 #define ACPI_HANDLE(dev)		(NULL)

-- 
2.47.0.371.ga323438b13-goog


