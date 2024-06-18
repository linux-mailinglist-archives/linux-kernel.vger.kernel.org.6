Return-Path: <linux-kernel+bounces-220158-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9568590DDAA
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 22:46:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 281CF1F2467B
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 20:46:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3379185E78;
	Tue, 18 Jun 2024 20:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NpzmG5Ly"
Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C07C17BB14
	for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 20:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718743532; cv=none; b=NC/b+74ekOMP+lxenZu2FDItNfAC8HfwNzI6WvsjtHb1/b8AvEJbLbVrfZy/bm4xck+X4kRFl0nh6tQUcYhbOu1KgrPlOrkRu8r3c8G7TQKRamM4uYOAlbvhkwXS806ksnpWY1+gWseC1arAgTD8/DVZGXOEJ13D02yPdDnA62k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718743532; c=relaxed/simple;
	bh=rUnkk/wWp2sBNpjdL8bQQN9zcFpLFYBuc4V2vmUKBPA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pqGmFukImc9q/ZuF4HYOvEWtYoMDTJ/AZTsHwUDAkSscd3VUTi4bw/UFhsODcgv0yqvfF1Q5GIKn+2zepFx7YasiBBSQXQCMPJanbD0YeG7oDW1wF1ZyCKIuabtnK6hIFgZCQB37a0IrmnfsCvaVsYGfSwAtlyVtpwE1A4bvfK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=NpzmG5Ly; arc=none smtp.client-ip=209.85.210.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-6fa0edb64bdso3199132a34.1
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 13:45:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718743529; x=1719348329; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1QypTvkVpwSwPwrJWMvND1OKOL2Sl2RDuWylFLER89I=;
        b=NpzmG5Ly3n1yFvYTlRk80TvVWZOIciXljpQqzN9zXbsKygeg+KQ8LUBMmiWBHxBm4X
         zcMfILvwCvaAvcnj6g/+qOUXMTovT/erA/aWUZ4IsIXHAvhmDw0Wtmpzk7evgP4iugEn
         mCg1X+Gnuo7PfQ5I1AjN8xALUtBCm0wCcuGoi7hkbpDih7n7QNGEWf7NxjoPqgnBAgbW
         1KYRktryaao8aqG/Hj5v0c8oKMPkIAIPMyK0J7/jHJgeGd7PJRsXrrzKJoDvb14hEA3B
         R4ojBAXrhmU1y0iUNSjeCtT40ZcEGoM9QFSPqb515PIUbJHVNkrm822YwJsCOovZ6WD3
         a6rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718743529; x=1719348329;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1QypTvkVpwSwPwrJWMvND1OKOL2Sl2RDuWylFLER89I=;
        b=XRtt+mFny1BqLjt/rS8OD2NINj17FZnXzogOZtWbcvlFwa0CALwkUNxM5Cx3xRsqz5
         pzmYV0fmmvhCd3s+2ytn0BFwa1UXAbt/1KFE08jjh9d/yIxZhyZ1jbUvZuzJGyylHNtl
         EgaOcHEYAjhHxugX2lHFG8e6dXmQbc+DYw6pHK2NkcXrIlWLsNmgH7OFoVFlTTYesOYs
         RCWWbQpLgl/2sYaky207HRWlLe9aqZoUmjC+iqZJzNeHNTCbWPK6W7Lsxl5g3hW9KIE7
         MoVQ2Xcj46XdH2lhja0B8c1ypMOd8gTR7jl87mXVE0OD98pa8YWMoV0oHoQH/bD7uYea
         OrHw==
X-Forwarded-Encrypted: i=1; AJvYcCUyFVy8ZunlqPfa41nFlpJIUyzlMYqRooZOSrcA2PDF2HhmgAwBnczAUQgDPGZvuKGwqxZOqAz5vDrH7E8bY6qLoLobLyKEj3HJ/YNZ
X-Gm-Message-State: AOJu0YyfiLP9w4jVPMOMwpoq2dO+4PVTIJAcswR/yDTol+HQP3uVpgIX
	yVSVg4pHe6KetA2VWA1DES+35JSDow/GJTOTMupsBOvTEPrDecFMvjld/lVFmko=
X-Google-Smtp-Source: AGHT+IF0mhCadvOIWkaEzxJ7YG63of9Ku+vM0wRbKCJ3zcWLEWNNSJ7oU6/+slg8XAwGOA979+WVSQ==
X-Received: by 2002:a05:6830:1390:b0:6f9:7abf:c6df with SMTP id 46e09a7af769-700761499b8mr936632a34.27.1718743529356;
        Tue, 18 Jun 2024 13:45:29 -0700 (PDT)
Received: from localhost ([136.62.192.75])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-6fb5b755c2bsm1938957a34.69.2024.06.18.13.45.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jun 2024 13:45:28 -0700 (PDT)
From: Sam Protsenko <semen.protsenko@linaro.org>
To: =?UTF-8?q?=C5=81ukasz=20Stelmach?= <l.stelmach@samsung.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: Anand Moon <linux.amoon@gmail.com>,
	Olivia Mackall <olivia@selenic.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Alim Akhtar <alim.akhtar@samsung.com>,
	linux-samsung-soc@vger.kernel.org,
	linux-crypto@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 6/7] hwrng: exynos: Enable Exynos850 support
Date: Tue, 18 Jun 2024 15:45:22 -0500
Message-Id: <20240618204523.9563-7-semen.protsenko@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240618204523.9563-1-semen.protsenko@linaro.org>
References: <20240618204523.9563-1-semen.protsenko@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add Exynos850 compatible and its driver data. It's only possible to
access TRNG block via SMC calls in Exynos850, so specify that fact using
EXYNOS_SMC flag in the driver data.

Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
---
Changes in v2:
  - Changed QUIRK_SMC to EXYNOS_SMC to reflect the name change in the
    previous patch

 drivers/char/hw_random/exynos-trng.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/char/hw_random/exynos-trng.c b/drivers/char/hw_random/exynos-trng.c
index 497d6018c6ba..841598037cce 100644
--- a/drivers/char/hw_random/exynos-trng.c
+++ b/drivers/char/hw_random/exynos-trng.c
@@ -313,6 +313,9 @@ static DEFINE_SIMPLE_DEV_PM_OPS(exynos_trng_pm_ops, exynos_trng_suspend,
 static const struct of_device_id exynos_trng_dt_match[] = {
 	{
 		.compatible = "samsung,exynos5250-trng",
+	}, {
+		.compatible = "samsung,exynos850-trng",
+		.data = (void *)EXYNOS_SMC,
 	},
 	{ },
 };
-- 
2.39.2


