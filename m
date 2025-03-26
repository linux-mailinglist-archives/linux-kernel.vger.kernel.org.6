Return-Path: <linux-kernel+bounces-576996-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 662F8A71722
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 14:11:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A75421894494
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 13:11:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 309B91E51FB;
	Wed, 26 Mar 2025 13:11:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TQjpO7Tx"
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB36C1A2398
	for <linux-kernel@vger.kernel.org>; Wed, 26 Mar 2025 13:11:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742994665; cv=none; b=TAW+aj7lECJi35z9pL/OEdFE39mAeBSQbKEnyMZZZZGk4/MYgn24oFcNwpxv+MQEINxa0Z269v1uFnZM/ntg3VF6nMtfE33mE6SKoaE7cB6F4mrfRPX+2lKl82Q8nv8ajKqFxCzQ3sN5vU3Nl7BEw5PsNGoInBYlugoNxYv+ZEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742994665; c=relaxed/simple;
	bh=qldN62PjCFlYuOW1Hw/7vBhDRt4i9kg3Fs4B3evpBbY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qCHHQTKwSUcIMPM14nB/bRojqDOhuxg35iLQudg+35pm0k/2LRUdeus3NXWB9iaZ7sQRpsWMOAZYhFEFV/eA5YvLhu3DZFPSFaW6xNQRIbSQWqCbgQeYxVIEZCZv+JibtAP77RSGUAqr5DOcJQZRjYIDvQjbG6umfemRFnncuf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TQjpO7Tx; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-39141ffa9fcso5677426f8f.0
        for <linux-kernel@vger.kernel.org>; Wed, 26 Mar 2025 06:11:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742994662; x=1743599462; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=coBo9zTOkV+54/uJ8ZjRiGU/vI3P1bGg7BoPmlBVdVs=;
        b=TQjpO7TxhihHFg0WqDDX2wZaRN5vgMNeQnfSqibOCQlXQ8OpX68SfU0uOdMjl30Nqe
         BRd0uPExReRjayXFq0kkl0lS3rGC+UGayWqSgvEShbEVhcncxfQT9H4fTZ2dyTmfwdhG
         oHLcq0egSTPlWsPzsT2N6linrPHNAkfnlOUigZnSVkA0+CHIq7WupMXYbVO4iNrO51Rg
         Ks1eEPr0wLQbGcpYJaIussuL2ysk3gTyC3l5i7/Pax4guybmU9Pl0HdKOYY5lVEv6o+3
         rzFbmyKavoDG4uNOt2yqnT1MYbdo29azKApuX96M3M6e9acjAdnRv1ZP8CNyOv1nNeY3
         I1RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742994662; x=1743599462;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=coBo9zTOkV+54/uJ8ZjRiGU/vI3P1bGg7BoPmlBVdVs=;
        b=QQDND7kl15WsEKadXImEHe0Zz/uxB1V59XqqoyI4SsyLvPD1+BvUBntf8F3OyB4oPO
         5mE/WgGcNqAycz/GDUlcs9WWPmwlC1k4c/iui/Zn3+ij6S5OqgxLenYBMEU+qcF2r2Ww
         XOG+tGub6/yO1VOBy7T37QuheFPsrj0eSYCVgoKiwlC7TPl6L+2baBOMI0+pD5YB0HES
         bMb/MQjFJpYexiJCtQYhNzbx8RhUwfyPv4Jpx+E5AotYiarP9I6Ar/f0e1YdEnvm1ACP
         lPNel9z5DufYa5dEHVh5jbdxDUaBEcMejEdvdO2+YSWHo4TvW+HunGVR8wTHzz05PEry
         hT4A==
X-Forwarded-Encrypted: i=1; AJvYcCV8fB3fwyKTLoMrd1e4ZA26fvHmG3rujsmWmOTjWEPtOYka8jqEWfB13+k36Cdrf+BE8e4lJcQdF3HyO3U=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7NQafbu9ucpu+eVuFoY0UZIVYeZ2PiI5W9SZmN6edKYpu7dhr
	Jgwtx0qbEcXyzgBT7aNslfdnnzGYgPiZOshScDvfAFNt3U834S33
X-Gm-Gg: ASbGncvocd/AJywwupfZi/EiedT5fNmjSfm8uY6syXU2KBetZtvEtFVUJV839Es8IZL
	1Chqeoj+GtBOEVvHH0ROdJc0iV1EDwDMNT5lzd4U/mXoBZDNI1ycX3DwF1USfBiYA+yZ7I4TP5e
	a3LRbDbV0f3SjtlSLszCCBbKuxjzpdDE3mYEIuD/FONfuMbQYLpM0xQL8gNqMmJbfsGlevyb7En
	vKnkokCADA+ncJfnjl0QhnpRKZyW4mWlOYjigTljtmTvdNohaG/5c3iQOg/iuCeXO04JzcUTJLd
	m4XfEOqIfKDOeyih+40JL1oQ9Hf5O8WqA77ZyYH6RHo7Cs+BFEvCJxCV
X-Google-Smtp-Source: AGHT+IGo5kRZQjK7go8ME7rLgXCUGjJN5HdX5Ne05KaMSmNpoFgkpvAveAfXQrZVzmsvdqDm6os96w==
X-Received: by 2002:a5d:584b:0:b0:390:f9a5:bd79 with SMTP id ffacd0b85a97d-3997f90ab9emr20396175f8f.26.1742994661851;
        Wed, 26 Mar 2025 06:11:01 -0700 (PDT)
Received: from debian.local ([2a0a:ef40:4d4:f101:e41a:977a:f788:910f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d82e6ab48sm1773125e9.10.2025.03.26.06.11.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Mar 2025 06:11:01 -0700 (PDT)
Date: Wed, 26 Mar 2025 13:10:58 +0000
From: Chris Bainbridge <chris.bainbridge@gmail.com>
To: Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>
Cc: Danilo Krummrich <dakr@kernel.org>, nouveau@lists.freedesktop.org,
	maarten.lankhorst@linux.intel.com, mripard@kernel.org,
	tzimmermann@suse.de, airlied@gmail.com, simona@ffwll.ch,
	lyude@redhat.com, sumit.semwal@linaro.org,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] drm/prime: fix drm_prime_gem_destroy comment
Message-ID: <Z-P84iMUP4NBAY7k@debian.local>
References: <Z9GHj-edWJmyzpdY@debian.local>
 <00e4d9c4-ecfc-4784-b603-12db04cda806@amd.com>
 <Z9q-ggKKgTsvW-Rz@debian.local>
 <Z9rA0G2urlVHFOSx@cassiopeiae>
 <1f4a534f-8883-4793-b191-60c2773f6217@amd.com>
 <Z9rSTkXlub-JZAz0@cassiopeiae>
 <Z-P4zQ1464SeZGmB@debian.local>
 <94eeb36a-9aa5-4afd-9ba6-76e8ace10122@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <94eeb36a-9aa5-4afd-9ba6-76e8ace10122@amd.com>

Edit the comments on correct usage of drm_prime_gem_destroy to note
that, if using TTM, drm_prime_gem_destroy must be called in the
ttm_buffer_object.destroy hook, to avoid the dma_buf being freed leaving
a dangling pointer which will be later dereferenced by
ttm_bo_delayed_delete.

Signed-off-by: Chris Bainbridge <chris.bainbridge@gmail.com>
Suggested-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/drm_prime.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/drm_prime.c b/drivers/gpu/drm/drm_prime.c
index 32a8781cfd67..452d5c7cd292 100644
--- a/drivers/gpu/drm/drm_prime.c
+++ b/drivers/gpu/drm/drm_prime.c
@@ -929,7 +929,9 @@ EXPORT_SYMBOL(drm_gem_prime_export);
  * &drm_driver.gem_prime_import_sg_table internally.
  *
  * Drivers must arrange to call drm_prime_gem_destroy() from their
- * &drm_gem_object_funcs.free hook when using this function.
+ * &drm_gem_object_funcs.free hook or &ttm_buffer_object.destroy
+ * hook when using this function, to avoid the dma_buf being freed while the
+ * ttm_buffer_object can still dereference it.
  */
 struct drm_gem_object *drm_gem_prime_import_dev(struct drm_device *dev,
 					    struct dma_buf *dma_buf,
@@ -999,7 +1001,9 @@ EXPORT_SYMBOL(drm_gem_prime_import_dev);
  * implementation in drm_gem_prime_fd_to_handle().
  *
  * Drivers must arrange to call drm_prime_gem_destroy() from their
- * &drm_gem_object_funcs.free hook when using this function.
+ * &drm_gem_object_funcs.free hook or &ttm_buffer_object.destroy
+ * hook when using this function, to avoid the dma_buf being freed while the
+ * ttm_buffer_object can still dereference it.
  */
 struct drm_gem_object *drm_gem_prime_import(struct drm_device *dev,
 					    struct dma_buf *dma_buf)
-- 
2.47.2



