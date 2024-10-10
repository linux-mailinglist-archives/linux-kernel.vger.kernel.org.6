Return-Path: <linux-kernel+bounces-360186-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FAC49995A3
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 01:11:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 225292852DD
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 23:11:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 466A21E7C1A;
	Thu, 10 Oct 2024 23:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G6z6ZmzL"
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06A2C1E885D
	for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 23:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728601882; cv=none; b=DwDXtCZZlvZVeCVCBaXyofCyAM8ADNP1olEt3a/bLtUYcFPl5DSvzd8eHI0I32l2gcpfG6QacxtSgXerTzhGwZvZBbwX/iBVqfvCAH9UpNBp3q8Iy/ZTe8lsNok4DpC4z73/VcjN2s5F+3/vsppxdu9u/1k0Gwnu1jJMH4rC+F8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728601882; c=relaxed/simple;
	bh=uinenbL4FzpGTciwF347QzY3mFOrkO38x8ZvWc2oCkw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lEV7fHyOlsQGQT2oBRcf/qjnY79vA+mqbIvd8iJvmT1FaYBVMufTYYAeT8bJwBvsRVondsRDTHWRU5RtEkbuJZsG/LsUUVXOIYMBwPdd5rUXnhTJ0ItNPqGv9eJJo7VylkzYjUizxK/8wWEjwFzggIfU36g2usCMfWnWCn/say4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G6z6ZmzL; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2fac187eef2so16041461fa.3
        for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 16:11:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728601879; x=1729206679; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QoDVAypqQhFaK++Sbokvz3Z0Wf7Y1INjpj4oxIzXKe0=;
        b=G6z6ZmzLz9eVB3uOpFJckaYWC21LH9Jf/Ps5+MvBUcZb+hTEbZJJ/w80q2LyCyTbAI
         YwNq9yhRcDmuO7ZVjfdkd9ysNMcHiJgPZpmxbyo32C5G1U1fVgglTetDhPVqZ9XLJUfC
         HhMhNDAVvoxpo0uLcT8hEb50MRddh19RKQ98/LlAg2ESER1dxK/ojWjBUUXjIWO1pMkU
         k3KxoP/xWlbZcXjPjuTZIbNU2fWg4c0SjmisUBCDQzmVlTnHEKw0gensU635YU/1gxm1
         ZbHXjIGvsVznmJddww99Qh/Iz2hIb1v7sny9uEbFmR5i7qIiwqjMdZKFQUwiP9FLrlvP
         mhOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728601879; x=1729206679;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QoDVAypqQhFaK++Sbokvz3Z0Wf7Y1INjpj4oxIzXKe0=;
        b=VV36zYnlJIu2l2LRrIX8xvzutPhisr4YyAW5Do2GZeQxoNTrqJD0Mt0MGG8Z/1a75L
         ChktDwH9+s7+dUGYtF4kp8bobRVQdpkb+aSE/6MA4+QXtvtfng0EqfNNYfAPxICgr9EO
         iOxWIh/IcdB8dkDRuflnXJTfn39Szo4YV9HbqQgi5y6cCMGOKoMdcrqdf8VXXQfBozar
         ErkS5Alp7c0fDZvQK8WtCjPKgKsCAEiFQcvlGu+7Ztwnjck8wJGowhvWNiXm3nQoPvOQ
         yUgokc7rEpM+V+qYumY8anUGndsUw9FygxmSYXqUQa/4+p5fqo7f4M6CiBzExs3Pz5QP
         +Rrw==
X-Forwarded-Encrypted: i=1; AJvYcCXXsxC3ixqOu1SYR9593lwhopIO9QGV88SQX1C6EbWgFFySaEP63HoYTZVv1hdSj2hkQl0nE9WQ0oAYHRY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9F3sNiOkYCgZUhMgoHeK5e3wY8CYc7Vsyt9Nsiu8KJRYI98do
	adWSfAOyS+CArk7BLTANoec7OQOe0It1C8QJf2KAGnoUrjLQ8Eae
X-Google-Smtp-Source: AGHT+IElhmpWlC2qdcNgZuGCmGHV6znGXHgoxSCTjh96T2uVOnQzrc2WOk5htA5x1FIloEn2FdMlmg==
X-Received: by 2002:a05:651c:554:b0:2fa:d4ef:f222 with SMTP id 38308e7fff4ca-2fb329e7a91mr1874651fa.38.1728601878781;
        Thu, 10 Oct 2024 16:11:18 -0700 (PDT)
Received: from [127.0.1.1] (2a02-8389-41cf-e200-3d08-841a-0562-b7b5.cable.dynamic.v6.surfer.at. [2a02:8389:41cf:e200:3d08:841a:562:b7b5])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-431182d7934sm27465325e9.3.2024.10.10.16.11.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2024 16:11:17 -0700 (PDT)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Date: Fri, 11 Oct 2024 01:11:10 +0200
Subject: [PATCH 3/3] drm: logicvc: use automatic cleanup facility for
 layers_node
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241011-logicvc_layer_of_node_put-v1-3-1ec36bdca74f@gmail.com>
References: <20241011-logicvc_layer_of_node_put-v1-0-1ec36bdca74f@gmail.com>
In-Reply-To: <20241011-logicvc_layer_of_node_put-v1-0-1ec36bdca74f@gmail.com>
To: Paul Kocialkowski <paul.kocialkowski@bootlin.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Javier Carrasco <javier.carrasco.cruz@gmail.com>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1728601870; l=1455;
 i=javier.carrasco.cruz@gmail.com; s=20240312; h=from:subject:message-id;
 bh=uinenbL4FzpGTciwF347QzY3mFOrkO38x8ZvWc2oCkw=;
 b=rESW73w6bQNwfU9qYsD9vjiB0TiJRGQaTu/ideF4NtwMGTMuUj07VI2HR4vxhs94W51ewLqDK
 +4usfVuwQMhBDTEeG+WwrzapV2yArJJeDXA8h8rlPyqKvVct5mNdPzM
X-Developer-Key: i=javier.carrasco.cruz@gmail.com; a=ed25519;
 pk=lzSIvIzMz0JhJrzLXI0HAdPwsNPSSmEn6RbS+PTS9aQ=

Use the more robust approach provided by the __free() macro to
automatically call of_node_put() when the device node goes out of scope.

Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
---
 drivers/gpu/drm/logicvc/logicvc_layer.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/logicvc/logicvc_layer.c b/drivers/gpu/drm/logicvc/logicvc_layer.c
index 34caf5f0f619..9d7d1b58b002 100644
--- a/drivers/gpu/drm/logicvc/logicvc_layer.c
+++ b/drivers/gpu/drm/logicvc/logicvc_layer.c
@@ -581,12 +581,12 @@ int logicvc_layers_init(struct logicvc_drm *logicvc)
 	struct drm_device *drm_dev = &logicvc->drm_dev;
 	struct device *dev = drm_dev->dev;
 	struct device_node *of_node = dev->of_node;
-	struct device_node *layers_node;
+	struct device_node *layers_node __free(device_node) =
+		of_get_child_by_name(of_node, "layers");
 	struct logicvc_layer *layer;
 	struct logicvc_layer *next;
 	int ret = 0;
 
-	layers_node = of_get_child_by_name(of_node, "layers");
 	if (!layers_node) {
 		drm_err(drm_dev, "No layers node found in the description\n");
 		ret = -ENODEV;
@@ -611,14 +611,10 @@ int logicvc_layers_init(struct logicvc_drm *logicvc)
 		}
 
 		ret = logicvc_layer_init(logicvc, layer_node, index);
-		if (ret) {
-			of_node_put(layers_node);
+		if (ret)
 			goto error;
-		}
 	}
 
-	of_node_put(layers_node);
-
 	return 0;
 
 error:

-- 
2.43.0


