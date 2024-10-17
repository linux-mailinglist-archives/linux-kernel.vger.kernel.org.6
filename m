Return-Path: <linux-kernel+bounces-370147-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E2C59A2873
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 18:21:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 29FA62860CC
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 16:21:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D47D5C147;
	Thu, 17 Oct 2024 16:21:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hWuxEIUX"
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F41C21DED75
	for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 16:21:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729182069; cv=none; b=m9xYujflmHRnQhvz3fzrEc+FIrU/E7jwVPpIgeM/FgxsI4NAaGaZ00BPwPwTszoWGpJUz42BJ57wp8fWe4JlytoMlfh8pQ1Y5KkRBoS4avrHCYWGI3iGZw1195si+teS4QUDaNWtiUDf2s+t16ZArS+GbAW8ZCiN378exhjpgc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729182069; c=relaxed/simple;
	bh=a2i59VWj1wo9e8CLn5+zcB8WxjGpH7TvnwsUYLc1YEY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rE6fubBhpvmnWIa3GH2IRgT1ajAZZkBf4ioaaSelE9fEG7cx+oXginYOK+hTq+hC+T0UO8nYD8auZVzDEVSsA/lW3Mveho6kCd+PzgCi+jnOZiYzVPNS3u4pjxTFyQEO+zPjCB8WGcKPQojcKP01jXIQWPdQwettU2X9NrPOgDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hWuxEIUX; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-7eab7622b61so980206a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 09:21:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729182067; x=1729786867; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=84B0WJInqqjcmoF43Nq22SdcquNiLQ/awOiDN5FBvL8=;
        b=hWuxEIUXBAyRxMvnwP90KsNFlNlCq6arX+MK4z4t7CMvWq7VRs7QB5XfyOV5d0/PRI
         wsSs8MqB/aLHmutH9xXuCwW7ZnR017SjjR3TOJDaLfWXz/Gyvv/2ol9/epEd26UkMh/7
         cWXziNYi/EKuSeZDhQ/hTrW+HdkDWPYJhy59A1moV3k07pUFPfw5AzQpjDXb/pzOQJW2
         iHZTFYMqAbNIkbpN7IkwC5buTQtKtMZYvyFvU8wTIom2tJi+J61HOPY51IE3YHsb3eJw
         ZzxYoSYjm6xFN0W2z78R7mrycujpRGnchNW18/oDxl7+Q1e0vpims4Y/HFUI/5AJvojg
         AN+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729182067; x=1729786867;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=84B0WJInqqjcmoF43Nq22SdcquNiLQ/awOiDN5FBvL8=;
        b=i14luYLd7XaeA1TEN4tOyio581TBUuHrfyCjZf2qD7Dcs1y9BCj1sLMc53buQY8f6o
         nof2jgzM1YcmJj58Hzda7M8spvXNmznscJ5AgnoAE6iVZrfN8eTQHfbybYVtCFEM29lr
         /TT3v38lRjXJyjZhckz5GKxJoIsZ/uVwhsRvarBUb8B7rVrQxfxt+MxKah4r1Mqu5h67
         wNdZ/IvmfGWpdE9Q1JDP4aJsOOFsBFdkDzskCeNOU2cmPpgwpLfcqtN98I7yUnoxSgMe
         3/XfjC7SabuE/S/YVDSLu/mxlwCy80vb4Xyd2FkBBEEHKhWgwDk662JKLqQN2qUEA0Z2
         8JFQ==
X-Forwarded-Encrypted: i=1; AJvYcCUHmesy5tfDL1ls9gnOROlQID7UPfGtbIJQPIRJebvu3b+JJZhFU/pjSK3oA4nTug2G0n4eqN99dDF58gw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZPkL0zx71WKGyycAqCAoTEbPlaQHOt3Wpp3CkXLAahLckZkid
	Sm5tPUUxVf1E+/+OM+xhioEWh0zhRhsbkaZbIz/9CV74QGgZR8TY
X-Google-Smtp-Source: AGHT+IF12ydOszUTm4oW68gFcID0rg897sNB9oDunvXXfgsP1WLjvYkHW0/D83GSYZ6gOdMzz9UlbA==
X-Received: by 2002:a05:6a21:394a:b0:1cf:4fd9:61db with SMTP id adf61e73a8af0-1d905e9c059mr13107897637.8.1729182067253;
        Thu, 17 Oct 2024 09:21:07 -0700 (PDT)
Received: from localhost (134.90.125.34.bc.googleusercontent.com. [34.125.90.134])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71e774a42c4sm4919409b3a.114.2024.10.17.09.21.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Oct 2024 09:21:06 -0700 (PDT)
From: Chia-I Wu <olvaffe@gmail.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Cc: faith.ekstrand@collabora.com,
	boris.brezillon@collabora.com
Subject: [PATCH] drm/syncobj: ensure progress for syncobj queries
Date: Thu, 17 Oct 2024 09:20:53 -0700
Message-ID: <20241017162054.2701638-1-olvaffe@gmail.com>
X-Mailer: git-send-email 2.47.0.rc1.288.g06298d1525-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Userspace might poll a syncobj with the query ioctl.  Call
dma_fence_enable_sw_signaling to ensure dma_fence_is_signaled returns
true in finite time.

---

panvk hits this issue when timeline semaphore is enabled.  It uses the
transfer ioctl to propagate fences.  dma_fence_unwrap_merge converts the
dma_fence_chain to a dma_fence_array.  dma_fence_array_signaled never
return true unless signaling is enabled.
---
 drivers/gpu/drm/drm_syncobj.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/drm_syncobj.c b/drivers/gpu/drm/drm_syncobj.c
index 4fcfc0b9b386c..58c5593c897a2 100644
--- a/drivers/gpu/drm/drm_syncobj.c
+++ b/drivers/gpu/drm/drm_syncobj.c
@@ -1689,6 +1689,9 @@ int drm_syncobj_query_ioctl(struct drm_device *dev, void *data,
 			    DRM_SYNCOBJ_QUERY_FLAGS_LAST_SUBMITTED) {
 				point = fence->seqno;
 			} else {
+				/* ensure forward progress */
+				dma_fence_enable_sw_signaling(fence);
+
 				dma_fence_chain_for_each(iter, fence) {
 					if (iter->context != fence->context) {
 						dma_fence_put(iter);
-- 
2.47.0.rc1.288.g06298d1525-goog


