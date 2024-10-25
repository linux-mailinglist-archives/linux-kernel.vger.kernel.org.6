Return-Path: <linux-kernel+bounces-381743-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E1429B03A9
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 15:16:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4FD651C211D2
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 13:16:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 732A8231CA3;
	Fri, 25 Oct 2024 13:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cm1KTRXz"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9263120BB5A
	for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 13:14:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729862100; cv=none; b=hDhLYpgKZejZ0X44EMsg615yp1AbuKrmR6q2zhfDUUrEuLyoD0Ic/q8tgort/6r/y6e9Uswnn6m2Ts51B/8r3PMnpPy4bof9K+sgUgf9A3f5QLqg3nVdAn/QQMPLXvok9ZeNVFqEYBrOBObhOS/QyNwLwj7oNPnldxejGN0RcIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729862100; c=relaxed/simple;
	bh=x7XRxl7ysLw3w3rGpNl5xX6v+xyCoZrRF5jieQeGFEc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KyxkfsSX7Ejp0idT76N9suCYRYRr6gY+6SzlUgmNQzVd55MpyhjwuySBQZEPm4dAdKhy4MeqDf8vBtLYQ9z9e8/R3okWpJYg/qcS0FigflJkB/hvyV1yDDAYV2i5UlmUAIXII6s3ua2ReV/0hkxCertGb8eE3zRN9IFdUJYLzKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=cm1KTRXz; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-43155abaf0bso20688325e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 06:14:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1729862097; x=1730466897; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cNn15pq7FtlSd8hCdE286On7l4GZ1JdLdzQd70l8fTI=;
        b=cm1KTRXz5lg838koa+prBNwXYveBj5m3AOdbflgBkOAeuSPsMODLhq+ECxNuT+3jpx
         TzIXalUL9K60+6fSQonUf9Gfh3pZUfKd/UJs+IzCkLNA9u2sQWTmMv6zpXxByBn/IOXx
         Cp3MhQ1ZSCblqCspoAGzrkNLKJcyaYvaJ/8H++4hfkAyhFl1z/qyOxzd6DpUUGa+wur8
         xN+ErjDP1KbGFG9c1fUpnGkiveN52rO9CKkDCjSW40ASjLa4cJ/u7sp0smF+dQr37zSa
         900tmE6qmhbyfQsSeYaSRMxyfiVkvY+ZwTBg4qEkXGu4jaDmdqj77vsL6ruDKK6DuYH6
         czZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729862097; x=1730466897;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cNn15pq7FtlSd8hCdE286On7l4GZ1JdLdzQd70l8fTI=;
        b=KWApdRjoG5MgzgIGd/REB7dYR3HCourqlC66vY0vE4E8R1DonxWy0332SmhVfr+usV
         JXArujsBhUvjGaBZIX3mSA41wCpKcSmLM+aVMjR8/Oi1CwVSzSYYmnqUgfz1krltNF0K
         kPLNZYx+76kevdXl+jWqD/OZ1C95MilnHxLkxlBTRxzhVL7JL8UsDU1oBzqZ7ClNPdHi
         4KyOF+TvsXidax9pjSznoNEOUy84KX2y4z47cwhmwfUi7r9Qer3GrkL8+3fkLiHUQuon
         A2Vpd/PqsNV001y+mz35buzUUDI2X8wcX0d9jRGLjFmIM//mW3TlsvkmNQCul3eCoAGZ
         Mqbg==
X-Forwarded-Encrypted: i=1; AJvYcCUg92Za66Gm1XHFowjFzx4cAEFlJlqOWhEZ4oNCgcJbYrFgCBodRJhMqlH4mSYzk4qcugXYVNKCdmlAbr8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzno4uY6fNrnclvkjvGajvFLot2uZU/q9WD4m6LHovI9v/jZMRu
	8VNyObldczgFMXrwD1fUJ8O1JGvgdBnNHac96I3HnrM6sfOpGMWLdv9W7GFsn64=
X-Google-Smtp-Source: AGHT+IGmYuHoaUOEGVL/28LOiMK/A9Q47ttebm2jL0yHOWlag+R8pd+KgV3xQfuxq1xntOnAKAHD4w==
X-Received: by 2002:a05:600c:46c4:b0:42a:a6d2:3270 with SMTP id 5b1f17b1804b1-43184224094mr87230815e9.21.1729862096953;
        Fri, 25 Oct 2024 06:14:56 -0700 (PDT)
Received: from gpeter-l.lan ([145.224.67.228])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4318b58b6bdsm47616685e9.45.2024.10.25.06.14.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Oct 2024 06:14:56 -0700 (PDT)
From: Peter Griffin <peter.griffin@linaro.org>
To: alim.akhtar@samsung.com,
	James.Bottomley@HansenPartnership.com,
	martin.petersen@oracle.com,
	avri.altman@wdc.com,
	bvanassche@acm.org,
	krzk@kernel.org
Cc: tudor.ambarus@linaro.org,
	andre.draszik@linaro.org,
	kernel-team@android.com,
	willmcvicker@google.com,
	linux-scsi@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	ebiggers@kernel.org,
	Peter Griffin <peter.griffin@linaro.org>
Subject: [PATCH v2 06/11] scsi: ufs: exynos: remove tx_dif_p_nsec from exynosauto_ufs_drv_init()
Date: Fri, 25 Oct 2024 14:14:37 +0100
Message-ID: <20241025131442.112862-7-peter.griffin@linaro.org>
X-Mailer: git-send-email 2.47.0.163.g1226f6d8fa-goog
In-Reply-To: <20241025131442.112862-1-peter.griffin@linaro.org>
References: <20241025131442.112862-1-peter.griffin@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Firstly exynosauto sets EXYNOS_UFS_OPT_SKIP_CONFIG_PHY_ATTR so setting
tx_dif_p_nsec has no effect.

Secondly this assignment can't get executed as samsung,sysreg dt property
is provided in for this platform. Meaning the execution flow will return on
regmap_update_bits call above.

Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
---
 drivers/ufs/host/ufs-exynos.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/ufs/host/ufs-exynos.c b/drivers/ufs/host/ufs-exynos.c
index 9d668d13fe94..d4e786afbbbc 100644
--- a/drivers/ufs/host/ufs-exynos.c
+++ b/drivers/ufs/host/ufs-exynos.c
@@ -205,8 +205,6 @@ static int exynos7_ufs_drv_init(struct device *dev, struct exynos_ufs *ufs)
 
 static int exynosauto_ufs_drv_init(struct device *dev, struct exynos_ufs *ufs)
 {
-	struct exynos_ufs_uic_attr *attr = ufs->drv_data->uic_attr;
-
 	/* IO Coherency setting */
 	if (ufs->sysreg) {
 		return regmap_update_bits(ufs->sysreg,
@@ -214,8 +212,6 @@ static int exynosauto_ufs_drv_init(struct device *dev, struct exynos_ufs *ufs)
 					  UFS_SHARABLE, UFS_SHARABLE);
 	}
 
-	attr->tx_dif_p_nsec = 3200000;
-
 	return 0;
 }
 
-- 
2.47.0.163.g1226f6d8fa-goog


