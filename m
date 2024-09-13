Return-Path: <linux-kernel+bounces-327435-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D9FBE9775ED
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 02:12:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 18DC61C241A9
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 00:12:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A09410F7;
	Fri, 13 Sep 2024 00:12:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gf2imanF"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31A60376
	for <linux-kernel@vger.kernel.org>; Fri, 13 Sep 2024 00:12:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726186324; cv=none; b=UdeTvx1GOxPfYf0Y/HSXFyGU2dj7OLxbmlDyXf0NUSaxr7gF1Ybv4MDTfBcWJsum8AEVpNN4vniQA8sJ8eEHpqKi4n6tSiG3gGY7WLc6iz+bWnX4Bm+ATPNfC16M+UCQ/5vLLo8/mtNNEBYo1TnIXYYpIkzK2pagvt+4ZUGjRhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726186324; c=relaxed/simple;
	bh=7ouh47RZB8dDIhhgNnYE7Bt3QBF3M0wDaeQ+vU4kGYg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OPdqsZLIxpv8Lb+K/96nIuzF+3PhhK125JA2rhRMm6TzLMgJUwAV9tyRNYRVCYIoAZlngtUK4NH/cHdaVVBsJtYr1hQhDnFnf4/9R8hVmPKU7bwgo8FL9pdUzdwRneNZHWky0d6kcZ6PxVdq2fKPm0MgV2DC2vePtD0o2s+Q1Ws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gf2imanF; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-42bbffe38e6so12583315e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 17:12:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726186321; x=1726791121; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6T+0eaJ0+QZO0CeXbfyrLWwnYfT3dS09dqDCJalwF5E=;
        b=gf2imanFOgorQuQq6UCk1rTHlLilqWAac9q2N8CkRfEkNljwuHODEQk2xALx8zWOOc
         ojXAbXyAz5OWW/MiY7D2ntVIPKDvGMHz0kKhGDzkqzW0v7HrqRnTAiQdU2D9iUTVJ/B4
         jUiq/NKib0XpcW8/0/bAfTGQa4pU5v5IR1Sk4l7P2Gs8OGWn+M0xgMR9KqY5enDqiN29
         lAEIbHiRfeqjOiPlddiKXguEJXgucDTRga/CSNSKDb9wq9rQ6C4d5h1P3ecHleePB1tx
         FkRyUYB+kA7IJ/PyBzkCUbeX4o4xXI2cNxHIh4vOx8maGXWfmj1z8V+uUaEG19XkYJ+w
         vtgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726186321; x=1726791121;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6T+0eaJ0+QZO0CeXbfyrLWwnYfT3dS09dqDCJalwF5E=;
        b=tR5zjZ0DWX+KQADI1SRSXyjFjjq7R7Pv7lkF7CxWS007l3sygwSDRGayeP3IzBKDBG
         E8bCpEcxoSlXS+Gf0+4GmVdwje5hFmHtFaOzn/p92vLX4rwv+cwmHCwgsGusD7eYQ0Az
         px6QOlFIo8vNxxq4KMojfmVtSUp9fr4n0t2KGZ2UWhakavdmme0x2erbqxvoviIf9rUD
         vG+LhNkogTNvHfGR0mAlhOlWVUIN7HNEB6aXpAGFxS8eWJuE5gYY1hQOn6xirCknPIHP
         HYxCf51OFtmfzALHWBpvVHVKuzDAoEIHsSiN9uWw7+Vr2E1DLz3txQq88l6tKxSaq1Sl
         iqXA==
X-Forwarded-Encrypted: i=1; AJvYcCXUd8+MRn9R+weMNRnrH7SEJwo1M4+oAdm+4kFyteVXC4EbjUgLPRMzm6EgQLt5dHQf50hvxJCTvNw8ZVo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzRjEGangEDb18raSkEvVL6IWPQOZ1ibY/YXpVsuBpEBNqOB64j
	q6xcb79748uZdBT94i+uRm+iGUHlFmgGc7jM+nqzAXCBuQNqjk/+
X-Google-Smtp-Source: AGHT+IGMzxr+56gg6zPXGQJ2O6ilxKturjM+t2Z4vXloB1d4rAN+9SK2jOPXDXS1PNchMW2TBuikaw==
X-Received: by 2002:a05:600c:1547:b0:425:7c5f:1bac with SMTP id 5b1f17b1804b1-42cdb547d32mr35158755e9.21.1726186321385;
        Thu, 12 Sep 2024 17:12:01 -0700 (PDT)
Received: from localhost.localdomain ([2a04:ee41:82:7577:85e4:cf41:16db:65d5])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42d9b002a9asm6433075e9.0.2024.09.12.17.12.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Sep 2024 17:12:00 -0700 (PDT)
From: Vasileios Amoiridis <vassilisamir@gmail.com>
To: linux@armlinux.org.uk,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org
Cc: tzimmermann@suse.de,
	airlied@gmail.com,
	simona@ffwll.ch,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	andriy.shevchenko@linux.intel.com,
	Vasileios Amoiridis <vassilisamir@gmail.com>
Subject: [PATCH v2 1/1] drm/i2c: tda998x: Make use of irq_get_trigger_type()
Date: Fri, 13 Sep 2024 02:11:56 +0200
Message-Id: <20240913001156.56634-2-vassilisamir@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240913001156.56634-1-vassilisamir@gmail.com>
References: <20240913001156.56634-1-vassilisamir@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert irqd_get_trigger_type(irq_get_irq_data(irq)) cases to the more
simple irq_get_trigger_type(irq).

Suggested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Vasileios Amoiridis <vassilisamir@gmail.com>
---
 drivers/gpu/drm/i2c/tda998x_drv.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/i2c/tda998x_drv.c b/drivers/gpu/drm/i2c/tda998x_drv.c
index 2160f05bbd16..8dfcebec800e 100644
--- a/drivers/gpu/drm/i2c/tda998x_drv.c
+++ b/drivers/gpu/drm/i2c/tda998x_drv.c
@@ -1911,8 +1911,7 @@ static int tda998x_create(struct device *dev)
 		/* init read EDID waitqueue and HDP work */
 		init_waitqueue_head(&priv->wq_edid);
 
-		irq_flags =
-			irqd_get_trigger_type(irq_get_irq_data(client->irq));
+		irq_flags = irq_get_trigger_type(client->irq);
 
 		priv->cec_glue.irq_flags = irq_flags;
 
-- 
2.25.1


