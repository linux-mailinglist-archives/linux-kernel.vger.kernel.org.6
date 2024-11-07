Return-Path: <linux-kernel+bounces-399966-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D22F29C0726
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 14:21:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 89A3D1F21F8C
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 13:21:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19AF420EA49;
	Thu,  7 Nov 2024 13:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cYrvDi7n"
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED95A1E1048;
	Thu,  7 Nov 2024 13:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730985678; cv=none; b=OrNGognWw1iW3A9GliXJKB5HC109w/lOPxIJKnflAfQkSfVeMgA/ta4jK/lhNHLSB4G0cxfdLUPpL+fmA13vY9MS4ArQXcKSykgDKSAmiFoHSDx9z2QO8RaqfJuRJicV2vqIHShxOa99wHy3Qec2kw9BGLRMLcUlYTbaBoCr0OM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730985678; c=relaxed/simple;
	bh=OVv9ifGn8JQI5BCwW+w6UoB4j809hlfmgBlW/wNe8BQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=lgndRY7ZYKIxlUkbfjjBSwcWUybtwVz186vjC2CHH2WykhZzv53peS1ybveKdYlRKoyf37ICR3JOQF0YnBEoWvx9xau4Z6z1nFHJlIwX2obPR7Pgyf24wdF/4gLqscoToxnV3ZKkQH0aO990ocpUGfb3yIiyfPg2Z7bwmMPaXTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cYrvDi7n; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-37d4b0943c7so501911f8f.1;
        Thu, 07 Nov 2024 05:21:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730985675; x=1731590475; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=x48A24d9EG3vC7+OzW7Pkz/MOvuoiuHEwn/TjkX8Lrw=;
        b=cYrvDi7nv2i0qxHzmTmzv863SBH2kaR5LzxKjHQbZU49mYTzf8JyPT+PpCisXO4ami
         KKV3EMoUfJAbzpxEb62ozwjyV5ykN1wgly8QS/lQe3XciSZLIiaiJ9Xmkm0cDutW8lOd
         eQqAJd9Vw9gbRzMiD/JEjM3yiHqhGLNlICVOkhBVZuZZuum2w5Xt8j6pIwmMUQPp1qvS
         vsGSw7x6F+nDQGGxE5MrbpvCVKdxdaqVpSv+y6T6Z+N+gOlaLhxxrkHaSeTMdzmyEJuy
         uzmrpXq0vbqIYV1xbhiB5DMlkJmeQ0F7DiXp90gKDG1BYBt52LUez5IbLjtEyvTmyMOu
         UuUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730985675; x=1731590475;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=x48A24d9EG3vC7+OzW7Pkz/MOvuoiuHEwn/TjkX8Lrw=;
        b=f8lTcQxDhymW4NSgwv+oGEU1alVS3zcWx38msLf4T+Mz0MEsnrBTJPaLoBVR7vZCST
         vyfo1Nj5cZdEFy6PGLfMde/uyhUc9nFFkqgxvZ3YI2zQTSyR0PU5gPNuJG9UIbQU7A5u
         79OBRWoy7EqoiWvhWICmr01Fg5TI+gXLqrYAI3/P3M+83SrHXy/h6ojKkD4CM+UWZxyw
         dNVfcy4jBdZFqMcLH6m9HB+XCXynygf6C1bVdT8gy/GI0aL7Uc92MgMC18FAVwDeycts
         DrOYvA936wM3n1blwj3vL0TjGf/DUv0opg147O/eXYRwiXKPKhUuu2inZ5uvGifSNz1W
         wAGQ==
X-Forwarded-Encrypted: i=1; AJvYcCWXItqqV/F5gqeBgGo0ynVUFDcfbUF683pxiSGDOjYgHGMAeTzsznoOVo1NJgfvlUZT0KwWGFfJ2phyckI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwDT4gP4GAz1uC0kmO2z5ETy3YTiOcSXuZoI7p9uj0E7GmMUrXj
	6GA9ncU8d4Br3M3qYWl5aE2cIYM2xuPoIGmhmh5LbueCsFlzfDp4RW0wVqapcRU=
X-Google-Smtp-Source: AGHT+IGDc+8YZf7dKd0Zij01XmxG6xQTZ3cNTUk7h0sARTGTVOECCSJSGzn9JsXbtM3C4Gvb7uXKoQ==
X-Received: by 2002:adf:f28f:0:b0:37d:4b73:24c0 with SMTP id ffacd0b85a97d-38061190da2mr27250414f8f.35.1730985675155;
        Thu, 07 Nov 2024 05:21:15 -0800 (PST)
Received: from localhost ([194.120.133.65])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-381ed97ce0fsm1711845f8f.33.2024.11.07.05.21.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Nov 2024 05:21:14 -0800 (PST)
From: Colin Ian King <colin.i.king@gmail.com>
To: "Michael S . Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	virtualization@lists.linux.dev
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH][next] virtio_vdpa: remove redundant check on desc
Date: Thu,  7 Nov 2024 13:21:14 +0000
Message-Id: <20241107132114.22188-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

The boolean variable has_affinity is true when desc is non-null and
ops->set_vq_affinity is non-null. Hence the call to create_affinity_masks
does not need to check for desc being non-null is redundant when
has_affinity is true, so it can be removed as well as the now unused
default_affd.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/virtio/virtio_vdpa.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/virtio/virtio_vdpa.c b/drivers/virtio/virtio_vdpa.c
index 7364bd53e38d..1f60c9d5cb18 100644
--- a/drivers/virtio/virtio_vdpa.c
+++ b/drivers/virtio/virtio_vdpa.c
@@ -364,14 +364,13 @@ static int virtio_vdpa_find_vqs(struct virtio_device *vdev, unsigned int nvqs,
 	struct virtio_vdpa_device *vd_dev = to_virtio_vdpa_device(vdev);
 	struct vdpa_device *vdpa = vd_get_vdpa(vdev);
 	const struct vdpa_config_ops *ops = vdpa->config;
-	struct irq_affinity default_affd = { 0 };
 	struct cpumask *masks;
 	struct vdpa_callback cb;
 	bool has_affinity = desc && ops->set_vq_affinity;
 	int i, err, queue_idx = 0;
 
 	if (has_affinity) {
-		masks = create_affinity_masks(nvqs, desc ? desc : &default_affd);
+		masks = create_affinity_masks(nvqs, desc);
 		if (!masks)
 			return -ENOMEM;
 	}
-- 
2.39.5


