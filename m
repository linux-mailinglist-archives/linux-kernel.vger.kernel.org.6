Return-Path: <linux-kernel+bounces-546568-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62F81A4FC48
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 11:37:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 92DD6171968
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 10:37:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A97AE20897B;
	Wed,  5 Mar 2025 10:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="0j+YpGz/"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70F8B20767F
	for <linux-kernel@vger.kernel.org>; Wed,  5 Mar 2025 10:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741170718; cv=none; b=YVr3nc1Af3u5tEhT7zAIsYG/D4Ea7zIMO+9GfXbIsAoPvE8LOSdm+q/mkcqTqQeV3hGNyNCXCAhkM4Z4Y/dX27Xitw2LK+uG0AtfqU8YLmrmEnoiqbgkcS9jjqEzwanOIWOsrhXmnN7O/amoJGovZcLLLdyl62LcOE71EJUfDmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741170718; c=relaxed/simple;
	bh=0v6Zt/MABbD0gYMSTn3p9nKFECTkaY5R5P9eYaq23RQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=R9Kw/d9kTSNmMMaIu6LFCQEOsaa53/OcaNCuKG9ZpSaWhE3a1efpN33oU9rvu6SFqOWlmy1DbhHYzIJGO+xson8uwzf2noevj5A68fwEcAoHxIR7Jr0rC4TQJInHagLGHH76reb3yuStJLHjsVRuvhBHfWL2oxAbywEwHd6pUMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=0j+YpGz/; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-43bcc04d4fcso10973415e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 05 Mar 2025 02:31:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1741170715; x=1741775515; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=63++Ar5Not6v1z5SwzlcGxcT0577JgrxXolq6jAwmVk=;
        b=0j+YpGz/i8XYP9/bK0FoG19yqJqExhc60Wu+WtF90Bo4edM50LoIWjuaT4/19PCYWw
         9EY2Bhdb8y58jz5uEYuw1XrytNp4VraHsOgsdWnOLYgPhZdekqHUC5Yt6kEiKiuoh1BB
         sWX+BaHoaR6w2DCb2QY8lyKZ0LqehaaXnSiF7fKdQUl0Wmtv/ErP7E6Z0DacGNo5ERM+
         miyU95+pqnowa6uqeXH2Fq3Y0WfzYg6Rk6xxArepNaT41JFPZBxX3997Tlvyh2hERUSu
         LZqvkjghUxh09p3WQ01mGzTycHTyFBkYo3vt6Eo6QhYK1RdQ4UBQmrnqixDg1kacdYhc
         mnLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741170715; x=1741775515;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=63++Ar5Not6v1z5SwzlcGxcT0577JgrxXolq6jAwmVk=;
        b=o1ifF0q1g+6K9oQyMRpTxPJJ0Hd8509sBxrU/2xKE2i0SnPWJHMGgK8yMs02Xz0gd4
         Dtogt6tEuwL3z35EYJSyLaIthVN1lnCfoDznI5YsgKYGZvgAlYGJLSlsovvFnNeoIXsz
         v+PBdzjJEKoQ6+K5LpUdiySUsul47lHTcvBQRYz8LxdHkzSjfrQxLfZ+EUj8yVuXSFFV
         auOrS1paO9AN4PkUx9itjRNasvluIrLUWBSXtGDb942bXkQBMyu8pe4n5ScrZwnpWJsT
         lKJxlaRkVIVoKINSNJymLR8kTHAzLSeDVToS7avCZY40XcCngkJ59bfuNHs8F0CszK5Q
         8DGA==
X-Forwarded-Encrypted: i=1; AJvYcCX1UR/xSy9N1Xl+4GzLDg73KfnNuQAyQhocO97GTzzv5zyzorf0NnAcMFuHRwHiiXUvbKldnamAWAUaTuM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZonhk2lLsxbmMnwKHEP9sU9fyz5RSHmWO8bINKadeKAxc2L78
	97v0ndsm2kuWd6mZrB2Z9XkuhwXlunq0spYUjtHiLkoDsr92mC+2xFRDI+VtKTc=
X-Gm-Gg: ASbGnctI8ghplQyQ4/EyvtH+2Lq3jrptci+gK6P2jTIB7fi4rkcFmrNoFVPZL9SoBl5
	qmpIDE1ZdlWgaTnYXWnv3MDc9a4sR4c5a3lyeurFrCJeqiiH7bCPw4qMKzt4++M8ygLXUz1XjVH
	r4fIkOywXAM2Ovm86dCVDW8W9We5J7/GOW7G2ptN48OVRSbmFhMmHqbSWt3aQf98yWH7pgDMgsE
	ucDcMnCDDFv+BOKKrE2rb6K+4RZTyBOEL0qQPV4l7UmPxxCnHHnMwxwxBKbdoZAPbex0C5cOdvE
	ic7xO+nk3uzUDWvM98PeWkCiHKS+8mQPz0s/bgSJyqDw
X-Google-Smtp-Source: AGHT+IGdpofHBUYsSVKjftpHMXJCFI4qS6aBIfMRcLTGvpoDFRyhuHi7RyiMHkO579i4wWEd59VXnA==
X-Received: by 2002:a05:600c:1c95:b0:439:9b3f:2de1 with SMTP id 5b1f17b1804b1-43bd29ad100mr19311215e9.15.1741170714658;
        Wed, 05 Mar 2025 02:31:54 -0800 (PST)
Received: from brgl-uxlite.home ([2a01:cb1d:dc:7e00:e514:53b3:5af8:e408])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43bd4352eccsm13152975e9.27.2025.03.05.02.31.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Mar 2025 02:31:54 -0800 (PST)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Henrique de Moraes Holschuh <hmh@hmh.eng.br>,
	Hans de Goede <hdegoede@redhat.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: ibm-acpi-devel@lists.sourceforge.net,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH] platform/x86: thinkpad_acpi: check the return value of devm_mutex_init()
Date: Wed,  5 Mar 2025 11:31:46 +0100
Message-ID: <20250305103146.53221-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

devm_mutex_init() can fail so check its return value.

Fixes: 38b9ab80db31 ("platform/x86: thinkpad_acpi: Move subdriver initialization to tpacpi_pdriver's probe.")
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/platform/x86/thinkpad_acpi.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/platform/x86/thinkpad_acpi.c b/drivers/platform/x86/thinkpad_acpi.c
index 6128ad820ea0..d8df1405edfa 100644
--- a/drivers/platform/x86/thinkpad_acpi.c
+++ b/drivers/platform/x86/thinkpad_acpi.c
@@ -11849,7 +11849,9 @@ static int __init tpacpi_pdriver_probe(struct platform_device *pdev)
 {
 	int ret;
 
-	devm_mutex_init(&pdev->dev, &tpacpi_inputdev_send_mutex);
+	ret = devm_mutex_init(&pdev->dev, &tpacpi_inputdev_send_mutex);
+	if (ret)
+		return ret;
 
 	tpacpi_inputdev = devm_input_allocate_device(&pdev->dev);
 	if (!tpacpi_inputdev)
-- 
2.45.2


