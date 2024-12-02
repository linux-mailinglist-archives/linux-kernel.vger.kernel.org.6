Return-Path: <linux-kernel+bounces-427180-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 27BDB9DFDC3
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 10:50:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E156F281FF5
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 09:50:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7907B1FC0F8;
	Mon,  2 Dec 2024 09:49:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="T4W00Jm/"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F87E1FA249
	for <linux-kernel@vger.kernel.org>; Mon,  2 Dec 2024 09:49:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733132951; cv=none; b=J/I1ZkOL/4PIatg/fXSUQYFhUl6n5eXpWfNsoxfC51BRn4o89RMa6yUcogfy050wphxEtvGITRJY5A2z9DK71JHYo7cF8hUI8rGM3WJg50/UgvY63PahAW1ikxgluFvaNW406ylnHqFW7FREW5brTAOryU28YD/gSyRD6tF/e/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733132951; c=relaxed/simple;
	bh=7TsWaTIWJQYD+y9SICdpkAnWxQKe1BiPBtoMoUrrt9g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uijdhhAu8bEPHFtQFY3ke9oF3D58Aq4gcBQGkrCdq94D5cIe9I+KXyNOrRUTHF5mbMzWv9I9o6Ibjh96ZwZDPMXz5+Ep4RnyTSAMAH+F2GyYhWE3KurTg8Z2m4Tf10/thm5iJKuRNFihVtyqCi5NZK3K7p3Fpoli07Hn+1Uqf5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=T4W00Jm/; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4349fb56260so34403475e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 02 Dec 2024 01:49:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1733132948; x=1733737748; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+tz/xNuOuXmUEM+zhS3HXnHXawb1XEPnU6wuMOHx78M=;
        b=T4W00Jm/IPoUkK5t6lu2Z2eR1Oc6HNuVPu/YKg1wC1RPxWZaB90X+BYk/Kiyv3Ygzc
         H+lRi+hM68p+B1t14P6aCfmfRTNw2GoMBtlAZbZUx2RdkVm8yChtC21bcCiCtoUDqQtU
         S7mdh1XOx9GEYe/n7lxOKcDQJQi4J5K8zSHmT0RGtF29Z8n5r2zV8ME6D8GJmuE9YKh1
         r4uUEdeEWxXk1RugfQiQ/wpxCC/XxxtoGTvFQ6nauMHSDCVvSCi6emJ8+4SnmSzwQagU
         Nwtr55JZquqj55AP02O+CAEDPfYbTWO8w/PPrxX4S+3DLePYu/WaeEcqnBMe0sYDf90b
         JEvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733132948; x=1733737748;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+tz/xNuOuXmUEM+zhS3HXnHXawb1XEPnU6wuMOHx78M=;
        b=tD8WKxnF4Otfmjq1CS2H86cGoEo5SKmqMCpzggDW6/PsdLA+OlmOHDJSVyaH3tH7va
         uShtXmEP+IAmR8bYmHrcDNeP46G7iyF85qAUFy+rGMGr+BDQeEdoSsKFlEreWr8RzNks
         qE0nSSAYu0VNrHbid7DKP8NXNDeTfrIOqjf5NsfV8ORy5T4HXDaf0VbDrWLFhuvJk7YH
         C30YQQ1865ej4uNLnQLKntRc/D7Dz0jOD/uHKFYG0An/fPJSjcw7MzJGESFtPEHC2ZYh
         kFQEEHZbttin2PXhswIbOxJhg4dOOgRyyUDNJB+0wvW+dRomx/ag6zWuuCUjgSNz7ZF0
         OUnQ==
X-Forwarded-Encrypted: i=1; AJvYcCWacZ8BmkSaPshDZe0A/ybJiedqSXo9/WUTAcbh4pfm7B0h7BVxvtXxhbeDLBld3VmXDV03LxZ6aTAhmKo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyb6gx8OSr2I6mFtyMjQfLkIuvIecdwaQsHV3SFzU/75nU4FAKY
	qeJU2FKaOeYkn2PPMahguVf+hv1co69AqqDBdjzZ8Of+edthLaexM9zvLrTRVqfEIthZJ5sde/s
	n
X-Gm-Gg: ASbGncvmdOkIGid4ThPYry3ogTjBtf2UvlsX3SDv3UpQnfB0r6va24otD2RkLoF/8Da
	OZ7s8A4ts+WeQuabZx4UEe6Q/j8qHIulCZsoCBfFWnr5IxOYrsXit2WXrjnICo0aarwz0/BDWBZ
	LTTR0q4eGSJH7Z4LPgvFqoCmZcLmGbyLe/xiKgiXTHO+aupzRcNvxAOv+dEXSxUw2qUzk4KAGCo
	5lrnIJhViF+vzFBI0fEY2vACEX7o4XxJ1469Fi9bZbdWjQsGQ==
X-Google-Smtp-Source: AGHT+IFBViBzFl4UbOb2Q7QPujdsLTswwDPnJQOow8/tEwXztCuRe/qAmFq2iQFkA4m98awINGeM7w==
X-Received: by 2002:a05:600c:3111:b0:430:563a:b20a with SMTP id 5b1f17b1804b1-434a9dc01b2mr185421235e9.11.1733132947755;
        Mon, 02 Dec 2024 01:49:07 -0800 (PST)
Received: from brgl-uxlite.home ([2a01:cb1d:dc:7e00:223b:dce7:ef1c:4bc4])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-385e3c21ba7sm6486475f8f.53.2024.12.02.01.49.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Dec 2024 01:49:07 -0800 (PST)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Subject: [RESEND PATCH 1/2] soc: qcom: rmtfs: allow building the module with COMPILE_TEST=y
Date: Mon,  2 Dec 2024 10:49:02 +0100
Message-ID: <20241202094903.18388-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Make it possible to build the module when COMPILE_TEST is enabled for
better build coverage.

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/soc/qcom/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/soc/qcom/Kconfig b/drivers/soc/qcom/Kconfig
index 74b9121240f89..58e63cf0036ba 100644
--- a/drivers/soc/qcom/Kconfig
+++ b/drivers/soc/qcom/Kconfig
@@ -139,7 +139,7 @@ config QCOM_RAMP_CTRL
 
 config QCOM_RMTFS_MEM
 	tristate "Qualcomm Remote Filesystem memory driver"
-	depends on ARCH_QCOM
+	depends on ARCH_QCOM || COMPILE_TEST
 	select QCOM_SCM
 	help
 	  The Qualcomm remote filesystem memory driver is used for allocating
-- 
2.45.2


