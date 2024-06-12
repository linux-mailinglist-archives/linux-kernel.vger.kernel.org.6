Return-Path: <linux-kernel+bounces-212318-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C667905E71
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 00:25:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 90EC31C21872
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 22:25:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF3A512B170;
	Wed, 12 Jun 2024 22:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="dP8qkp8L"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9CAA12CDB2
	for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 22:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718231094; cv=none; b=QIS/NFym4iaWVFVHt66VHrwlpqXmAL+HgocgPc/MfcxTVNDSmy0aauk2dMidFgSH6Sm7Kj30f4Xov6ne3yT3IJy6bU0d9jMQJfk52pJqn0GMhz+s2fQCTsNkVB/JqKVphr1N3f9rwpT47CNX2LygXNEjbLzbVCOF/nGOzLo0/BE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718231094; c=relaxed/simple;
	bh=t3yv9e1EzMXtPY6KnpScajrOJgyZidM/cqL/We5XO9Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CrZYAdkW8P8nv8vJTapm77gLUfzp+nCZvzhZ2SljjRLUfIDCitxZh+5L64aFNHC6NsvG8RkFYpon3wDe+RbCsYydCRGlgtsj6rpHFTeLk6A0nJEm2Gz1/ycAdyD7BBTrmp07hxOVCfsan6tNW29kyYfRASoGS/JyGCkqBBMIA58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=dP8qkp8L; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1f6fabe9da3so3886215ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 15:24:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1718231092; x=1718835892; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zpmQn9g7cRN67S7SSaIwDQvRoODph3OOMStNp4IKliA=;
        b=dP8qkp8Lg+k1/d/wQ+63ftRNYeBDI742xoAoNOkKSXgBoCNZwuqLk53ZeuwlGJZcC0
         FQDIeJ9qBrZU80fkWx1sghO6+QYEkKyRe0ZJC3In/r/sp1hHKsocsqzF1jR2+I0aMsY1
         SUq2rwVbxT5xYl18m99gcxyNbZDd1lgBRAq14=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718231092; x=1718835892;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zpmQn9g7cRN67S7SSaIwDQvRoODph3OOMStNp4IKliA=;
        b=FNn/ixG0AWaFANvSjOSJWuihuMfPu1Aqcgy/g/a+GmwKCGjHsM/qFv11IkZ2IqE2OD
         Zl0fEdCpWRsI/ai6s2dHmgIgZ5FHcAvXC6B8V6kTMy8rrnmsR6PdZyeT71ZH02WrM4ag
         O6SfSWw1j0vJSDFKmIe75T9no3yT2r173Lvot5fPxPX2o2YrIhBp6YzFMdT+2Iw7RXP0
         2YAStKtS8/UMjjvc31GQSs0VVa58ufgV4+gnOS5UeSB39gGOvhPLDJVdnGcrr7vJBC4f
         y074tKlQ2PI/M+AwbgzxtM4bw4Wwj8AijSXBiLaJ783lUqDxZC5DVChC7a1JUHSvOGY6
         EpZA==
X-Forwarded-Encrypted: i=1; AJvYcCUeMuQa4TrzSlQiG13VA+SEkphfC2UmcDgVWg2Lpd9gJPgABMflx7u2NKb2MgZtvmMk4H1iCs+vf4TDf3p7i9Ij1H6woABBgBWyz/e9
X-Gm-Message-State: AOJu0Yyxh1mgbmbO2xdaOSIwfiGwJDxrY5MOlHez5NjcVYYlpsCs8Lat
	NKZFi7aXs14YCDDk/MNjKANUFMND1EAAZdY5itxto8RIKJuIu/wMfBrzEAl3OQ==
X-Google-Smtp-Source: AGHT+IEw5ujOqNAyOIoLP8KuspnMOnAtd7Hh5dDQKTX8TBm9/CzqJoj2TsY6aejmqFawCaR9pN4o7w==
X-Received: by 2002:a17:902:e750:b0:1f7:2a95:f2f8 with SMTP id d9443c01a7336-1f83b55e32cmr41999395ad.14.1718231091823;
        Wed, 12 Jun 2024 15:24:51 -0700 (PDT)
Received: from dianders.sjc.corp.google.com ([2620:15c:9d:2:2816:6a42:9074:18cc])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f6f30acda9sm87914105ad.198.2024.06.12.15.24.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jun 2024 15:24:51 -0700 (PDT)
From: Douglas Anderson <dianders@chromium.org>
To: dri-devel@lists.freedesktop.org,
	Maxime Ripard <mripard@kernel.org>
Cc: Douglas Anderson <dianders@chromium.org>,
	Daniel Vetter <daniel@ffwll.ch>,
	David Airlie <airlied@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Mikko Perttunen <mperttunen@nvidia.com>,
	Thierry Reding <thierry.reding@gmail.com>,
	linux-kernel@vger.kernel.org,
	linux-tegra@vger.kernel.org
Subject: [PATCH v2 3/8] drm/tegra: Call drm_atomic_helper_shutdown() at shutdown time
Date: Wed, 12 Jun 2024 15:23:43 -0700
Message-ID: <20240612152336.v2.3.Ifb4450979b62976fd5a98847dade2e5b377d47c8@changeid>
X-Mailer: git-send-email 2.45.2.505.gda0bf45e8d-goog
In-Reply-To: <20240612222435.3188234-1-dianders@chromium.org>
References: <20240612222435.3188234-1-dianders@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Based on grepping through the source code this driver appears to be
missing a call to drm_atomic_helper_shutdown() at system shutdown
time. Among other things, this means that if a panel is in use that it
won't be cleanly powered off at system shutdown time.

The fact that we should call drm_atomic_helper_shutdown() in the case
of OS shutdown/restart comes straight out of the kernel doc "driver
instance overview" in drm_drv.c.

Suggested-by: Maxime Ripard <mripard@kernel.org>
Reviewed-by: Maxime Ripard <mripard@kernel.org>
Signed-off-by: Douglas Anderson <dianders@chromium.org>
---
This commit is only compile-time tested.

(no changes since v1)

 drivers/gpu/drm/tegra/drm.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/tegra/drm.c b/drivers/gpu/drm/tegra/drm.c
index 03d1c76aec2d..d9f0728c3afd 100644
--- a/drivers/gpu/drm/tegra/drm.c
+++ b/drivers/gpu/drm/tegra/drm.c
@@ -1330,6 +1330,11 @@ static int host1x_drm_remove(struct host1x_device *dev)
 	return 0;
 }
 
+static void host1x_drm_shutdown(struct host1x_device *dev)
+{
+	drm_atomic_helper_shutdown(dev_get_drvdata(&dev->dev));
+}
+
 #ifdef CONFIG_PM_SLEEP
 static int host1x_drm_suspend(struct device *dev)
 {
@@ -1398,6 +1403,7 @@ static struct host1x_driver host1x_drm_driver = {
 	},
 	.probe = host1x_drm_probe,
 	.remove = host1x_drm_remove,
+	.shutdown = host1x_drm_shutdown,
 	.subdevs = host1x_drm_subdevs,
 };
 
-- 
2.45.2.505.gda0bf45e8d-goog


