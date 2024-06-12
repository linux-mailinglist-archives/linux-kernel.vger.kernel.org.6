Return-Path: <linux-kernel+bounces-212319-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA9A9905E73
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 00:25:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7DEC8284DB9
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 22:25:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E03712D74D;
	Wed, 12 Jun 2024 22:24:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="MvJMW5+0"
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D02512D1F4
	for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 22:24:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718231095; cv=none; b=WkP666S4Q+L5S8ckHhl6TsWyxF/j9cySPxNPdiMX3Cnusq5vYDabEIO+06b3CUjEPEfgWY9k+qhZd7OmaOmhjMzmdBnBb8QEK7MKhq74SQR1I0JlDdLPM8Q2fVsJQ/2k9TUouzVK/Lk1sp6nT6POof68IUE76gRd9FnK1/ulpSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718231095; c=relaxed/simple;
	bh=8xjZTpeFcaE74g6l02h1dDzTdoSJ+H05F9AhpsSAsWE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZgbIVEIfAigNQYkOkVMMMYCvHBjR8M6BC/P08du2upRERdayZ1e94hgbkkjGX2ntXJEnswBwOefMG/wXFJOudiaSPAT4d4mtm2PBIoCid1YZdIu2P+121/nRI5yywsAPA94FM6ic3V13vuV1Z8xDdrAFa7qFbhUw99BJXkqkxxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=MvJMW5+0; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-656d8b346d2so289184a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 15:24:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1718231093; x=1718835893; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cG9YsnvV0dqFs63XW3w7FcDwXhGHgBYJnS7/vNMDsUI=;
        b=MvJMW5+0l3kvsauUsrvS9g4K8VmDgpAjlIooetS/QiOpUPnU+e5mc1Vy0Z5p7WP0tU
         3JgJ5R6A65bK8Lp9r/kpH1dq3xRDKPrIYyWWiHWpW0sH3Mo2z9bthTfBWfpSt0S5ou3Z
         t3bemCAkGEk2o/hN8GGxNSaB3r8PrtyvVStSw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718231093; x=1718835893;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cG9YsnvV0dqFs63XW3w7FcDwXhGHgBYJnS7/vNMDsUI=;
        b=Qfj7I/xfaRG5nIeFsS+Qhy1li15wpHjmGZAENGlt6uuv3BnBuUWxjBvGINoWKg67F6
         EalvAe8xX8TJOAKCoTUJrUAUxQhvbFsZ9SWDVePXIcssMXF4xSLzPHUmPv1ungw8Ud2L
         3RzqBDS+v0IBhEhIefmkoI0Gcp9nSs0PzVaTZLuCkcHVpJ9/1f2KFB00lGCKnQXCFVTD
         qa0GFM0F1fJ6oXDOkdCbJ5yd+H7T1koe/YHz+L9UY7vW5XeMa8NrFs3YMjS+Pc5ntsf7
         4FeHpileymNVQX4QZ5Ws50FEYs7QxD+CB3mUSziGhfkfBvmjG1l05Ynaxc2SpcH6Mb88
         v95Q==
X-Forwarded-Encrypted: i=1; AJvYcCUxSdvEFIXcvaHeMVd+6PPT0Al2JAKrXWf6PTmIcSyabBOHHjZvHmMipd9kljdhnHDHAZYFwC2Fql//JsE9R1XNz4dxlTZS4xBuZkco
X-Gm-Message-State: AOJu0YxmcQvLTUjBDIFg9YMzvNRohUSWfy6lmubTbyuLpe61mMq0fp3S
	05HlYJ/kYJ0petUTFBFkwb806ti4/7iQpjo5AxymNCCtWQZpHGi1CspFmOQEKg==
X-Google-Smtp-Source: AGHT+IGI/wCAa9iSAbUyULm8uaZzcZmzyBGn6eSxHSxLyKPWYAONixriz1scQsX3eltdmrQaRYhqHw==
X-Received: by 2002:a17:903:1cd:b0:1f7:234b:4f28 with SMTP id d9443c01a7336-1f83b60954cmr37501915ad.25.1718231093331;
        Wed, 12 Jun 2024 15:24:53 -0700 (PDT)
Received: from dianders.sjc.corp.google.com ([2620:15c:9d:2:2816:6a42:9074:18cc])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f6f30acda9sm87914105ad.198.2024.06.12.15.24.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jun 2024 15:24:52 -0700 (PDT)
From: Douglas Anderson <dianders@chromium.org>
To: dri-devel@lists.freedesktop.org,
	Maxime Ripard <mripard@kernel.org>
Cc: Douglas Anderson <dianders@chromium.org>,
	Alexey Brodkin <abrodkin@synopsys.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	David Airlie <airlied@gmail.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 4/8] drm/arcpgu: Call drm_atomic_helper_shutdown() at shutdown time
Date: Wed, 12 Jun 2024 15:23:44 -0700
Message-ID: <20240612152336.v2.4.I8a0a246fea222059881d01a8fff2adcf7ef3d7a4@changeid>
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

 drivers/gpu/drm/tiny/arcpgu.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/tiny/arcpgu.c b/drivers/gpu/drm/tiny/arcpgu.c
index 4f8f3172379e..85b21f5aac55 100644
--- a/drivers/gpu/drm/tiny/arcpgu.c
+++ b/drivers/gpu/drm/tiny/arcpgu.c
@@ -412,6 +412,11 @@ static void arcpgu_remove(struct platform_device *pdev)
 	arcpgu_unload(drm);
 }
 
+static void arcpgu_shutdown(struct platform_device *pdev)
+{
+	drm_atomic_helper_shutdown(platform_get_drvdata(pdev));
+}
+
 static const struct of_device_id arcpgu_of_table[] = {
 	{.compatible = "snps,arcpgu"},
 	{}
@@ -422,6 +427,7 @@ MODULE_DEVICE_TABLE(of, arcpgu_of_table);
 static struct platform_driver arcpgu_platform_driver = {
 	.probe = arcpgu_probe,
 	.remove_new = arcpgu_remove,
+	.shutdown = arcpgu_shutdown,
 	.driver = {
 		   .name = "arcpgu",
 		   .of_match_table = arcpgu_of_table,
-- 
2.45.2.505.gda0bf45e8d-goog


