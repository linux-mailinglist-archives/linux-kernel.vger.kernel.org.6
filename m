Return-Path: <linux-kernel+bounces-296792-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 62C3C95AF35
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 09:25:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0AE3D1F26FB0
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 07:25:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 906CB1836D5;
	Thu, 22 Aug 2024 07:21:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="OnWlChbF"
Received: from mail-oa1-f49.google.com (mail-oa1-f49.google.com [209.85.160.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DBEA16D9AF
	for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 07:21:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724311268; cv=none; b=nG6kC9PBzAjQixzqnRZuBep3zNobKcDdJGTQIHZQHletpbI/ZpuLsh87od8G80SW5ShBaYTBoF1nbitRRnIjtFhPhK+lCth/Pq0j2PySBhXTX6PBTjyHzfC1J2lRL5q5ac+CK/dTKPQg2Jxm5J5yU1L5ajiK2UpnxHzzVaCJDN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724311268; c=relaxed/simple;
	bh=NBiwkhavnp34Pc1WlCjDSkj4dCnJ5BXJFDbN6ms4Sfw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J6Geq8g5HE6PbWmjQoliuUyfrY2TXTL2iaxaQuAoaGqQo17cpKevlo/xUria8BWcSoSslo313thddXxJYvoaNaj5IEkbksCpH4s/Fl8e63kHLeFVhG5TCrw57LSwaI9VhNhy9mPJpRJja2G7T9CL/n7oDNsfSRlJizakFkfyV5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=OnWlChbF; arc=none smtp.client-ip=209.85.160.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-27051f63018so301638fac.3
        for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 00:21:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1724311266; x=1724916066; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0OkXJystyHFO3QqFrhx1xRYATCv0SLvRjJj6gA62TPk=;
        b=OnWlChbFfXpz0H73PscU9GFIR9LDB70vb/WZDBW99U88jbckci2ScqC87Y1y6KPhJr
         4lfL5wv5f6ogdghhk/v8LeAFJTAFwgF6EZ4Sd/vvNmHTlVNr3dbHnAn+QHInqLm+obiC
         4t2Gd6ohpA7E87OAOVa+IyIObJHWCJtgfJCp8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724311266; x=1724916066;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0OkXJystyHFO3QqFrhx1xRYATCv0SLvRjJj6gA62TPk=;
        b=TRDKJUg2i+ltOYbuob5CiAauVUAwvZCwKgce3DRV/VCk+xcRlbf5+1TKMwpQWhngoO
         +EnMrHrMcpM/J9oFsXy1naxJvcPdsii1ru1FhCDMx0m4mL8N5MVHQfNDjlY7Qf4ebJiU
         mXkUNtY5ntOY5u6LZZImTPfIiwy9LNgFGPjQ6cKqpnDSHAljZe6TEU8stQ/kKhQeAbpl
         x1vchVewPo6j7hyF8yTScKnucvHTDbedkQVhAWprksoAWJSxOxHqhHw049MGjwihlbTv
         vm01vmqHSVMxtqKhsMFKTQ9n3OLPZeHB5ItvRKsZLBHeKpQJbFo9sJIKTC1eJvqn33zU
         SyUg==
X-Forwarded-Encrypted: i=1; AJvYcCV97hRFX4QoTCiQz7EPHjBms4rLma3C527xjV8GD8yEILm9lx/eGCE04zDlUugLd2PaVRKNu0gi8/V4HiA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxKqfWU0R6jAlC5Can0TC8/1Op1fTgaKCLidNC2B7/4KNjzx6z8
	GeVd/xcKyiFKle913vTqNpJkWRWBmDyAumL8F5OGFv0iAA68qLwNTSVC1x8VkA==
X-Google-Smtp-Source: AGHT+IFzUCqhCkTr+YqoZpsRxb513kbI0DI/K30PqGR1wgWwO2DPHl2WC1ed/qu4VuxElP0+ie671w==
X-Received: by 2002:a05:6871:1c6:b0:25e:7a1:ea8f with SMTP id 586e51a60fabf-273cff9bceamr1248838fac.47.1724311266536;
        Thu, 22 Aug 2024 00:21:06 -0700 (PDT)
Received: from wenstp920.tpe.corp.google.com ([2401:fa00:1:10:8470:6a67:8877:ce2c])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7cd9ad6e8e9sm615901a12.86.2024.08.22.00.21.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Aug 2024 00:21:06 -0700 (PDT)
From: Chen-Yu Tsai <wenst@chromium.org>
To: Mark Brown <broonie@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>
Cc: Chen-Yu Tsai <wenst@chromium.org>,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH 1/3] regulator: Clarify error message for "id == NULL" in _regulator_get()
Date: Thu, 22 Aug 2024 15:20:44 +0800
Message-ID: <20240822072047.3097740-2-wenst@chromium.org>
X-Mailer: git-send-email 2.46.0.184.g6999bdac58-goog
In-Reply-To: <20240822072047.3097740-1-wenst@chromium.org>
References: <20240822072047.3097740-1-wenst@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The original error message simply said "get() with no identifier"
without any context as to what was requested or what device the
request was related to. The only thing the user or developer could
do was grep for the message in the full source tree.

Amend the error message to be more specific, and also use dev_*
to associate the error message with a device.

Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
---
 drivers/regulator/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index 7674b7f2df14..9029de5395ee 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -2183,7 +2183,7 @@ struct regulator *_regulator_get(struct device *dev, const char *id,
 	}
 
 	if (id == NULL) {
-		pr_err("get() with no identifier\n");
+		dev_err(dev, "regulator request with no identifier\n");
 		return ERR_PTR(-EINVAL);
 	}
 
-- 
2.46.0.184.g6999bdac58-goog


