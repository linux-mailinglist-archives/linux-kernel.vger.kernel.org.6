Return-Path: <linux-kernel+bounces-360185-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2572C9995A2
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 01:11:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A71F0284EC8
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 23:11:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 855701E8851;
	Thu, 10 Oct 2024 23:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DYdMW+m/"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 454E71E7C1A
	for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 23:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728601879; cv=none; b=Cnb65bMBWE5FSwCgJZZU+gEJ8h7nPJENToXGqvurcNFPuT/7QxzupTgPNeHf52BcR68FJXqoPcdwSGZgfNMheVDiJyQm9oSYgBwNGYji01FL54bZsCaHYvQrL9TDGtnyrVyeWFLF9wlrYmWmkOHHesdtangcBb/pnH2psfGpJz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728601879; c=relaxed/simple;
	bh=mdTdY9w48aKKYhBF3Ntc48k1ASEGObuZ88AuC7JugAw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=X6ECnvOWHyT8KN/CStn2iXgjs8s+9Q5NhgF9aDH0jyLcDREgTIi4BLonKSiDrHoxOKjXaBqJvPC9rPQOrW18Pv35PWMvc2t6GbTxy2xD9o65P1Jvyf2i84C1CJnlXg1iJtqmwHS6JPaIH01AH7wVu38Jn0kHQ7aPA1wyJR95ljI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DYdMW+m/; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4311d972e3eso1430365e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 16:11:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728601876; x=1729206676; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=s58+PumcrxFi8ai7328YyPN+Kl/m7WNPj0jROfEsr9E=;
        b=DYdMW+m/cuGrkuoBZKmxPujSn4IOHzwcaxs5cLrGLt/Mumf7FaAOYw4QtDjw4zWEjv
         j5W+AuBDAxIOS9N06B6PJByADQfrH0kvfi9pIP6x3TSGifOWkGBD7wAbmuxnlirrd/fq
         zsMnPcq0YtQ8fOh6tICfw0UugO29C/YXiQuTn5BTqzTG1Zi9NvW6XoR6Bkjx8n7l5GAQ
         Bv9YJuaTpB3hdw2GF6+CUz1eErM45/ZCSSacflv1ybKJvfVfOJPhEoZOnqrsGg9yceVt
         UmrB+p7/tfq/qNpjkaOUArYsfSKIY7uApG6ntgSONNKy8x6mUKIkp9eAx442HQz0EJ3l
         io1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728601876; x=1729206676;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s58+PumcrxFi8ai7328YyPN+Kl/m7WNPj0jROfEsr9E=;
        b=nO5ICcVIyzZYqScMDUW/2Tz8Pg/0K9Fu1Ehf0cnxuIWlCXnXvBW3XSQoyDo03oRrh2
         hr4gjabVXOX8SMVSVQj+jXOMqeGa++gZOiS3kECwE/o5ycSBHY3mv951Jte4id9H3EFI
         VlxBWsqcdXN0NDL7mp5hwhh7erVBUfn07H3PAk9OgJ6h33jpLNPQBRBVpZ4davD7jS3i
         THwqrIdSdTS1YOShsXPGG37BsF2MUaxuKs6jf7JeSEgLHZoCgJLVNAAwsaSqLZsWZ9UA
         Lp/EnGw4bhfPGeob/LJXsVwfqt0DalSODy/QPEE5QYBKFp3snMtaG1Uve7r1YEm8DxX8
         8vng==
X-Forwarded-Encrypted: i=1; AJvYcCVOKq1sZ21Q9d/Y9hs21UnAX76qo8a3lgVoBaO961ZhDlRuc/menP08bLW5/LDoEA8pvxAJfubOG6jcLa4=@vger.kernel.org
X-Gm-Message-State: AOJu0YySi/EC/sntjjeqdz5qKElsDxcszmWykxhVM2SUmyCCM4iyvIyu
	ixkPYfz99dQflZtfzA7+UICzwKV/gXOkOIjQOrPJtSC0rGPRsMi43OoFv+eA
X-Google-Smtp-Source: AGHT+IGNpxnYI2exDYItoqZ2fn7Mvrf6IGBS7K8vHBpTFS5m8Lm+n/fI9fTxQdc0xpXrIqe0VaPpNA==
X-Received: by 2002:a05:600c:1c9e:b0:42f:8515:e479 with SMTP id 5b1f17b1804b1-4311dea4233mr2599505e9.4.1728601876501;
        Thu, 10 Oct 2024 16:11:16 -0700 (PDT)
Received: from [127.0.1.1] (2a02-8389-41cf-e200-3d08-841a-0562-b7b5.cable.dynamic.v6.surfer.at. [2a02:8389:41cf:e200:3d08:841a:562:b7b5])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-431182d7934sm27465325e9.3.2024.10.10.16.11.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2024 16:11:16 -0700 (PDT)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Date: Fri, 11 Oct 2024 01:11:09 +0200
Subject: [PATCH 2/3] drm: logicvc: switch to
 for_each_child_of_node_scoped()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241011-logicvc_layer_of_node_put-v1-2-1ec36bdca74f@gmail.com>
References: <20241011-logicvc_layer_of_node_put-v1-0-1ec36bdca74f@gmail.com>
In-Reply-To: <20241011-logicvc_layer_of_node_put-v1-0-1ec36bdca74f@gmail.com>
To: Paul Kocialkowski <paul.kocialkowski@bootlin.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Javier Carrasco <javier.carrasco.cruz@gmail.com>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1728601870; l=1408;
 i=javier.carrasco.cruz@gmail.com; s=20240312; h=from:subject:message-id;
 bh=mdTdY9w48aKKYhBF3Ntc48k1ASEGObuZ88AuC7JugAw=;
 b=R4bdEpUM8fPQRj1JiSQWFTkvdkMWF74Xsg1B14H1Vp8DgAWXnCmnzvrXo7Obi8t7B9VMNikVg
 DIvUSqwtF/bDhfd3OwCcY9v+4wA6UnmtiziXgNLYpIxJWVFZNAmYoSe
X-Developer-Key: i=javier.carrasco.cruz@gmail.com; a=ed25519;
 pk=lzSIvIzMz0JhJrzLXI0HAdPwsNPSSmEn6RbS+PTS9aQ=

Use the scoped variant of the macro to avoid leaking memory upon early
exits without the required call to of_node_put().

Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
---
 drivers/gpu/drm/logicvc/logicvc_layer.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/logicvc/logicvc_layer.c b/drivers/gpu/drm/logicvc/logicvc_layer.c
index 52dabacd42ee..34caf5f0f619 100644
--- a/drivers/gpu/drm/logicvc/logicvc_layer.c
+++ b/drivers/gpu/drm/logicvc/logicvc_layer.c
@@ -581,7 +581,6 @@ int logicvc_layers_init(struct logicvc_drm *logicvc)
 	struct drm_device *drm_dev = &logicvc->drm_dev;
 	struct device *dev = drm_dev->dev;
 	struct device_node *of_node = dev->of_node;
-	struct device_node *layer_node = NULL;
 	struct device_node *layers_node;
 	struct logicvc_layer *layer;
 	struct logicvc_layer *next;
@@ -594,7 +593,7 @@ int logicvc_layers_init(struct logicvc_drm *logicvc)
 		goto error;
 	}
 
-	for_each_child_of_node(layers_node, layer_node) {
+	for_each_child_of_node_scoped(layers_node, layer_node) {
 		u32 index = 0;
 
 		if (!logicvc_of_node_is_layer(layer_node))
@@ -613,7 +612,6 @@ int logicvc_layers_init(struct logicvc_drm *logicvc)
 
 		ret = logicvc_layer_init(logicvc, layer_node, index);
 		if (ret) {
-			of_node_put(layer_node);
 			of_node_put(layers_node);
 			goto error;
 		}

-- 
2.43.0


