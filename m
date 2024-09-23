Return-Path: <linux-kernel+bounces-336009-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E443A97EDFE
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 17:20:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 208E61C21310
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 15:20:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75E6519CC2C;
	Mon, 23 Sep 2024 15:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dr+c6A3N"
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52368126C01
	for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2024 15:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727104836; cv=none; b=Z3ysPcZkyqG4nX5rwPnRDW+HCY4Q8W5e/vmz5iYI24y4qAow2jqzUu+d24PFZtSuOGqsMZmSzZ+S1SsFJBbiOWikgf0+I+eW2pZ+mGFzN+YoSmmcWQFYab5HDVvFER7w4BD/Sd5u8e0MgzlSGOtjjZBXLYEAtfRIi//GxJng4jo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727104836; c=relaxed/simple;
	bh=co6ioMQ02V+r7uOOhlp3pHUwIbfMsiQy8IXRFurCexI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aABL636H69BctBLJQ8eT+2Qiz7Euf5/UleOui4qWv6kYGDQh4f1rjfsdK6pv/rbAj43pvgW0mURpe/lNR4jz9LCDcjNVFdlco+gJoAFoeBLXCrRZQEnLP59fzmeauhS3DyLHl13NYwKXoZs+z0+8DGgPFsMbRzYgfype40BncUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Dr+c6A3N; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a90349aa7e5so671230366b.0
        for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2024 08:20:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727104833; x=1727709633; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=VAoybQCw+SSRlMGkzjtBvNGKOwn68kaOmQ5Cr4iAn7E=;
        b=Dr+c6A3NQQPi39H4GWgJQV9g6mV8SV7XMWSMhBLuyf5XxTiY5HpQ5U5+nfUAMIiQfh
         clTQvVDYQx/6WBUqhXKqwhLrFDYH8VG1oetQvKOO7rz3k8tqZqZbjVynnb/ov0YgQIYx
         Oy6alDQ1WJpKzatM5shcbekzF0y5Vu1uOPMHpVsNJExJF1ksIpaqB22PynYsEU0t7xqV
         Y3bktYd8LZTKgCSl+yjtfKoXeUy26YVEqjKTE/S4qZi/WVyOGC+Ngi01JLBRKzmlALAD
         zWYNtQiw/UMjMC6tFZ1Wi1Ys4M2+hbyb9II4j+R7cV7Y9RhsTnLuXbTqhBdiXURJFBH2
         byTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727104833; x=1727709633;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VAoybQCw+SSRlMGkzjtBvNGKOwn68kaOmQ5Cr4iAn7E=;
        b=S+3CKNyuD5UftzeaSnajijVPDLtzfbWyGAIAeEOFcrZ5bqZxJiakOZUS0+I1zwR0at
         8SVzZBIPe6/AC4G2AKbRgRqGg2buvYLNs5OX4aIHRhESN/wd5aiK3z6BhSAdJe4NYwGS
         F7rkjecmvnPb6aIt05EJRyRFDxzZ79cgBiEZUKczLOEYu/ASq5vl1WQlxkyRWLq63Xa+
         94mOhpgZdlNlONbHMCP2ioHF2D1Hvn1I6nfC8IbPAfJok9KuaqdDUkaO3ALbS9ULebeF
         /F5tXHYE5g0n5zDxmt7E7rwrvynovHdjz/XMcm9gl9G2eNWJWEyTeJ/XkckI9NEcv8Sp
         +qYA==
X-Forwarded-Encrypted: i=1; AJvYcCUKwbYEBganKRhKq+67qeO0fWb9fnBBiJhiAtH/Wuk8ZQemeNy6h7mIG/stye0fzorWz2S8E3+1+khdMu8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwVSJKPXf/73TA7hyUyRKuxj6cRTTNHlzjAFZzhgHvuhInH9agR
	GFPSajvLakgWHM3Oy+vxUYZ6eTY8LICNzMlqOofFLkns1/Y89U4A
X-Google-Smtp-Source: AGHT+IEKHyP7+CWpuJe3pV9TPfqpvuYPi0TJx5uONwNak/pvlUj2NWuHdDJxFuhb1UuOhDoqj9ImYQ==
X-Received: by 2002:a17:907:2ce6:b0:a7a:9ca6:527 with SMTP id a640c23a62f3a-a90d5671b3cmr1377721866b.8.1727104833258;
        Mon, 23 Sep 2024 08:20:33 -0700 (PDT)
Received: from localhost.localdomain (62-178-82-42.cable.dynamic.surfer.at. [62.178.82.42])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a90610f151esm1242929866b.48.2024.09.23.08.20.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Sep 2024 08:20:32 -0700 (PDT)
From: Christian Gmeiner <christian.gmeiner@gmail.com>
To: Melissa Wen <mwen@igalia.com>,
	=?UTF-8?q?Ma=C3=ADra=20Canal?= <mcanal@igalia.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>
Cc: Christian Gmeiner <cgmeiner@igalia.com>,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] drm/v3d: Use v3d_perfmon_find(..)
Date: Mon, 23 Sep 2024 17:19:59 +0200
Message-ID: <20240923152000.185980-1-christian.gmeiner@gmail.com>
X-Mailer: git-send-email 2.46.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Christian Gmeiner <cgmeiner@igalia.com>

Replace the open coded v3d_perfmon_find(..) with the real
thing.

Signed-off-by: Christian Gmeiner <cgmeiner@igalia.com>
---
 drivers/gpu/drm/v3d/v3d_perfmon.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/v3d/v3d_perfmon.c b/drivers/gpu/drm/v3d/v3d_perfmon.c
index cd7f1eedf17f..54a486a9b74c 100644
--- a/drivers/gpu/drm/v3d/v3d_perfmon.c
+++ b/drivers/gpu/drm/v3d/v3d_perfmon.c
@@ -402,11 +402,7 @@ int v3d_perfmon_get_values_ioctl(struct drm_device *dev, void *data,
 	if (req->pad != 0)
 		return -EINVAL;
 
-	mutex_lock(&v3d_priv->perfmon.lock);
-	perfmon = idr_find(&v3d_priv->perfmon.idr, req->id);
-	v3d_perfmon_get(perfmon);
-	mutex_unlock(&v3d_priv->perfmon.lock);
-
+	perfmon = v3d_perfmon_find(v3d_priv, req->id);
 	if (!perfmon)
 		return -EINVAL;
 
-- 
2.46.1


