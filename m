Return-Path: <linux-kernel+bounces-207063-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D8A79011F5
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jun 2024 16:21:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 81B0C1F21FD1
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jun 2024 14:21:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DF8717A92C;
	Sat,  8 Jun 2024 14:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="q0P8Lecy"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A801DF4D
	for <linux-kernel@vger.kernel.org>; Sat,  8 Jun 2024 14:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717856475; cv=none; b=FG1wSW4SC4CjW30UJXTjR8D2y8HYtIqWpROg1trdf1gRu9OnxfMWkTlEZHCb7FgOJTY4u0sDJgvpQuKTiMw8iRiVLmvfsLFHwMLSum22snocTIOGzKQXaooDMWRjoPjLMh8bvB8lbx+TaWkzgrOmZAhtjbd6YxbVh6i/z6g1ztM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717856475; c=relaxed/simple;
	bh=xLFhrGBiH0pcuHVcunVgk1rk5xm4/9iOzHVu/jiIkck=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=uImovbFCnSoi6puLReFRPevkjdtAyeI8kEKRnnw3cUFuNAeR8ab133N+M//wuR8D7NdlNYHdJTiOByL/aExKwSjG2nGrft+Fne7Qa0l4niwI4R2H7MfvZV5uNzPiBSzvrPsBe9jdVd3Qraz3RRQbba9iDPxhDY3pZRw9V5dZctE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=q0P8Lecy; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-42166eb31b2so13654615e9.0
        for <linux-kernel@vger.kernel.org>; Sat, 08 Jun 2024 07:21:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1717856473; x=1718461273; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FjYuT33PAKShV15vOZT2MY4Py8HrSQc+sDa6zAJXDS0=;
        b=q0P8LecyZkzYuWNg2fMGyBAo+DYQI8t5wBKq4Ac8r1yXQKpEjvZnorCOHlWlm32qZ3
         Rj26hZ6EX8PyipdzUH0DXOzg3MGMNLl8/MZTCCaVLg1a9Dy0UC2eOkGqcffjJoBe1M2k
         s32jF4QWS0Pchx01AV3AwSC+qcNI/ytLakzZr5CVYXTAACT0KBFY10TRK6f1uKgCakBL
         JiP8ZPxteSjXAajTLBTdhDYRg9RBeJVRqvDBC8JCUOsCbLyzKEKdNmmrH0C5NtKu8rcC
         arYJqoNKGu5WKeiGhKzGRoV/4sDZ1Ug9XVbMDcRgW+cMs3ZApDizQ2x92fY3Qo3EYvEs
         5Myg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717856473; x=1718461273;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FjYuT33PAKShV15vOZT2MY4Py8HrSQc+sDa6zAJXDS0=;
        b=gXiML9ffqmLuoXqQwggYyIkvEg63htjvzgsk3vq7/HbqO2O7z9ogy8U9tOeORdHGWZ
         dUg+rIlQpju0ZO/oJQn4yrrPdORyi6L6+lpPI1Y4RywUcWW30o/rqpjWqhTDc0RpRoy+
         ffOiQop9MryQFIJTaTQsCRbOEAPOvEwCWgk48ik1FU3NHcIf+3MBs3F2D4i3kZhJaIJb
         QjmhWdiAKV6ME7YTB6sn+umAyp3KJ0MJtMKVMcnE5bQd8Cls8CnDE455lHJ8X7cI8mB8
         lxoqg5dS3m6pYHLgl07FSNrjAeJHmS3tyPg2kNTU3rtOpVbfAgBIzFDFn+xgurAgjxVO
         yYng==
X-Forwarded-Encrypted: i=1; AJvYcCWVrCrgdUAjifS6M5HGnwLz8X50JpJQjEnRCF/WOFIlkAx06nC9rAWGP/b1uUiX0t5f5Qdno4Pf0+m4Li99foKjXEXUcluXJQyjGc5F
X-Gm-Message-State: AOJu0YykrI5IMuPRMYgdbdfQ0oxl2OuwGx6w/m/tg89kNbRxQNJOniau
	KxUbyCE4fkgigh3NHsnZSqOwqKas2NMtCvWUR/qwVwtn71HoTZ2StmQwQAeMU5A=
X-Google-Smtp-Source: AGHT+IHMSDClGwHp6ZpeLqtN0xANquwVMTE0SCEKdNN8oNRycIpwR41xcOpeGGQ6Ptb5UJz1fLwcoA==
X-Received: by 2002:a05:600c:1552:b0:421:6a73:5fd7 with SMTP id 5b1f17b1804b1-4216a736254mr33767185e9.15.1717856472749;
        Sat, 08 Jun 2024 07:21:12 -0700 (PDT)
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4215c2c690dsm87193245e9.34.2024.06.08.07.21.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Jun 2024 07:21:12 -0700 (PDT)
Date: Sat, 8 Jun 2024 17:21:08 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Allen Chen <allen.chen@ite.com.tw>
Cc: Andrzej Hajda <andrzej.hajda@intel.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Robert Foss <rfoss@kernel.org>,
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
	Jonas Karlman <jonas@kwiboo.se>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
	Hermes Wu <hermes.wu@ite.com.tw>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: [PATCH] drm/bridge: it6505: Fix potential NULL dereference
Message-ID: <5e6e8882-478a-46c0-9119-b643d524cc0c@moroto.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

Smatch complains correctly that the NULL checking isn't consistent:

    drivers/gpu/drm/bridge/ite-it6505.c:2583 it6505_poweron()
    error: we previously assumed 'pdata->pwr18' could be null
    (see line 2569)

Add a NULL check to prevent a NULL dereference on the error path.

Fixes: b5c84a9edcd4 ("drm/bridge: add it6505 driver")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 drivers/gpu/drm/bridge/ite-it6505.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/bridge/ite-it6505.c b/drivers/gpu/drm/bridge/ite-it6505.c
index 3f68c82888c2..4f01fadaec0f 100644
--- a/drivers/gpu/drm/bridge/ite-it6505.c
+++ b/drivers/gpu/drm/bridge/ite-it6505.c
@@ -2580,7 +2580,8 @@ static int it6505_poweron(struct it6505 *it6505)
 		usleep_range(1000, 2000);
 		err = regulator_enable(pdata->ovdd);
 		if (err) {
-			regulator_disable(pdata->pwr18);
+			if (pdata->pwr18)
+				regulator_disable(pdata->pwr18);
 			return err;
 		}
 	}
-- 
2.43.0


