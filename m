Return-Path: <linux-kernel+bounces-364080-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FD1999CAE9
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 15:03:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CF933281FD2
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 13:03:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 950DF19E7F7;
	Mon, 14 Oct 2024 13:03:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="so2dIubd"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E56F1A76CF
	for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 13:03:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728910989; cv=none; b=rPLLsvkdJQxgFh8m9CrzeKtMvg2zBHFZa3vaHxGI+w4XxK9Ddy0Y2YKE6FfaGNpXGONGhImRXgbGJukB2MFJxn58Ce2ewZP9t4qNw+YHRSgJwwqZKe74FV8lwM5XOJoereanAYD60DcQEVgkZL4rNa84VD8BovPde3tPsiPplrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728910989; c=relaxed/simple;
	bh=yONDw6uE9ByPPaAetTLRmsPW5n/SXNwd7bahh32YHsY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=X66kpQGwvvuvoGdMe4Z3yqIl5CRtRD6hivP0wjEZrhCdl0TR62gsI9IKAdOygPGTaXy5GepXk2kr60ei+HRtMJKr7dwlkQOO6RtLLNbsN/7WebRm3biVUsF4XGRshIeYvl3AQP2tJmucIzrUrIuD7tcVF7dk2eUTwE2DFAzTKB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=so2dIubd; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-43111cff9d3so31865175e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 06:03:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1728910986; x=1729515786; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=VHsxRurxb3YNKpq+CSim7nhafTMQAT3Vz8QLEJ/Qplo=;
        b=so2dIubdlQD/IfQgtT8k+u+NDknFHjrvUJRFjTDBi1s4A5TG0kNd3dihaAa5cApkEv
         B8AkZ43kLgvR95v91fmjpnpqmtNAbmFImXdXsgsIPsnmsbSm62VYA9wdsL711K/mXADb
         WNvJavgOiAX2OQVB0qW5MfWBJJnwNCPh+gh26kh3D69uUIFTMEDdBhQWTRwqme7isWpG
         6xRKPn00jAPgtKspWOyEelGuq4ocr7ATi9LH6JckshKzw3eDfTqYTExl0EJrrtim0r8n
         mC0qLgVkXbx7DJL5XQp0ZZJxhZBQOGgsMIc8hhmptD55xG66l2oOxzTWRIhdvOWiS+gA
         wwLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728910986; x=1729515786;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VHsxRurxb3YNKpq+CSim7nhafTMQAT3Vz8QLEJ/Qplo=;
        b=uqkdWZ4Lguc5UMpbiVN0gMiTLfV06tKvBX9FIhqr/JORit3b1xokotUyUpJNJmow5u
         WiTTo0iqOEUnPHj7NvDPaI/n27BShAkW9um/F67Bk2DURnzepNOyTDUVUFR4l8hgdvOE
         mXCFdOjS0GkfgYAKq3A65sGZ+UQcN8x1cbIsdWjeaWmZFP8ZPC9gd87XWRSSx4IL2tEm
         eIYOIK6phtWNvcnwmIRogk84HCN7FFb1R7eangLKH/rLF82WpXVmiYivbpcamJteuMWj
         4NhDaQzGAjrgLDlXjE8u7xhTSZMCrbpU1mdWsLEPue83gSJGXc5g56s1SPrl+oujvvD/
         lq2Q==
X-Forwarded-Encrypted: i=1; AJvYcCUsHOovZ7au9U+qy4KDhV3UdDspmUUj52ucnVQtstYqiaPMtCJQ30J5ab0jBDPH6X5uNunVTVToy7wWo9E=@vger.kernel.org
X-Gm-Message-State: AOJu0YzXwDYAGusQJmKqlXheB4IEkg1ksskQU46MDSZui5yscvWqZwcz
	sTwpylnzp6UJYxzBHleQKVpb+91s9zkzKHwsYgcAYxF/b8/Tyg0qNNvtyDL0SL0=
X-Google-Smtp-Source: AGHT+IHuo2DJaAhhCChDriVee0Yyu/n82ShWKM8vzOqpVU24xftupWjtxoUwQvYIy82CNRtOrQXQ/g==
X-Received: by 2002:a05:600c:3ba9:b0:426:593c:9361 with SMTP id 5b1f17b1804b1-4311df47018mr96197865e9.26.1728910985785;
        Mon, 14 Oct 2024 06:03:05 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:dc:7e00:de54:ebb2:31be:53a])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d4b6cffa5sm11360500f8f.53.2024.10.14.06.03.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Oct 2024 06:03:05 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH 1/2] soc: qcom: rmtfs: allow building the module with COMPILE_TEST=y
Date: Mon, 14 Oct 2024 15:03:02 +0200
Message-ID: <20241014130303.123394-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.43.0
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

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/soc/qcom/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/soc/qcom/Kconfig b/drivers/soc/qcom/Kconfig
index 74b9121240f8..58e63cf0036b 100644
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
2.43.0


