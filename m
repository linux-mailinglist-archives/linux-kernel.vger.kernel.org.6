Return-Path: <linux-kernel+bounces-576981-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B892FA716F1
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 13:53:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A04E416F34D
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 12:53:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D84EA1E1DE5;
	Wed, 26 Mar 2025 12:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fjPsBb5g"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0FA21E485
	for <linux-kernel@vger.kernel.org>; Wed, 26 Mar 2025 12:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742993619; cv=none; b=iAW5F1BqzG6LJAFtO2Kuo3+N6D2Wp5OAGCJLZm3dpETmH/zT3QT74ttMbel92K2URMMxcyQO4OKo+uA75DAOtc6hPyU7wLWmX7L0C4k8FgIoGlWOreu1Hro8obAijZj1uyhESfz7SZ8mqAui0/23lZbZx7In7Enbips+tZ3oTgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742993619; c=relaxed/simple;
	bh=qldN62PjCFlYuOW1Hw/7vBhDRt4i9kg3Fs4B3evpBbY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ConH50izUGrCkB0ROag2vg1mqKZpLdtTh3dlxkZ/HSpgHYQL9uS/djgWnx5xvNA8olHjvUVEVZ0qQRmzhT35mw/CqQbB+Ay4ExnzQ7PYI52Y1jCU/4poGQw/qUkWVCuudx6mMOvRNrf5oypmtejBhQTZaxXY6JVUPiH5luUKBCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fjPsBb5g; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-43cef035a3bso47916645e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 26 Mar 2025 05:53:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742993616; x=1743598416; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=coBo9zTOkV+54/uJ8ZjRiGU/vI3P1bGg7BoPmlBVdVs=;
        b=fjPsBb5gBWt1Qy9CquCF2p3rhlvCl/FpIn2C0u8qn9P9AtHWOi8TGnB3yydRpoF6l1
         jCcCu+kEh4zOmyjqgMt3FSuyRBINvbvS9HvEJFlyevw34SYSRlCWC1zPiQCBMGm2QZwb
         +zvv3T397r3nna+iDA1fw2e93FaZlzwcfTgC9WUaJswbsRC+BaCCsQkqzyxyjZkWJQNx
         Gx781BJO2wenhqwX3MPnFEz8OtYl4P+5LGXrlsNoi9CS1sKOA2C8HjHF5alTpDkhK8uf
         CCD0keU4q/JLY/xkHpc0jQF1HuNumJb4+jWNiRtWg7Mw5LaxeCv95Y373MmwPq1Tosy1
         zXNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742993616; x=1743598416;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=coBo9zTOkV+54/uJ8ZjRiGU/vI3P1bGg7BoPmlBVdVs=;
        b=gWDnYq6pgOP315ZQC1qyMzHns+1/4ulDPYGI2dcsdPkb54UT7PzBzRVFWqrABfGZqV
         fb+iKqDQcCofcS8fpUL0nsw+xWmhTcXTv2r/hsBZxotXSk42xduO1gx1QYWh/psgj1jZ
         M/MxegtGTNDylv4ym4J8QEiMp4ulERHJVin/uwzzKNFW7Hv1WlS0OuToQuOIyHy/WtEn
         wHXAfBB3vKdWfvnxuEA3rZQuofM0mx3cJRxPx4p2xYhpAemDyGEI55/o2zqX82lEQQ4/
         MVa8CCwAq3wNsZqserSQb41VOxK5EzDq3GuTgIVuqz/N7Xe5p2KZh4p2yiz1uz+o1T4r
         piRQ==
X-Forwarded-Encrypted: i=1; AJvYcCVVplRWlE7xfQFRP7LsvgbdhVYXmV5lFkxNa1mSiS41mOMwhwteDAsW5R7mK3V9zn34iuuQdW+5Jwl3dus=@vger.kernel.org
X-Gm-Message-State: AOJu0Yym2Kjb0tQ4HiCztWPKzSmSl+latYj18eboTHXEJWRctviDV3h5
	AD+amQUax8dlhSy8JOP/zlQtO5jr+Gv9qRg9dUYRtQHaCRGwK9Wy
X-Gm-Gg: ASbGncsK3WJVu5dQ9OBkqfCIZml1dWPft/zlx9pBC3vj69RQyQHkRQ1rLb6CjWKIwI+
	IV0sxt+GZnN7Yx1BQP5a7hKRPnOiS1Su9IMgPhJrbFVCBYQCpVZofzWGNksgUSGjOhmx2mjtLb+
	7z6b9a6WQua8ECRdTxCpGaird+7Pys4flqZG+GPQ7ZWJ2//NLFEuht5Xqh5DoD78cIxWI27LSPT
	CHKmJ9D+WpzN+wmp+R2g9M3OOa1JptwM65nLkoPvHlohF5CXXr2Fisa9wNWuLXI4m5bqHZhCUXz
	i4D3UygQWxFXiGbO7bu1ixCLi0fdf4qFQK0M3sI3+RueAYXw0qbddh59
X-Google-Smtp-Source: AGHT+IFx/B2y4pVZ+fIGudSc0pHJcHiMF94Yu3KK2XDJYxFrBVKU4DKqM242i+DiiGBlB3U5k+xijg==
X-Received: by 2002:a05:600c:198a:b0:43c:fd27:a216 with SMTP id 5b1f17b1804b1-43d52376b88mr200235635e9.23.1742993615726;
        Wed, 26 Mar 2025 05:53:35 -0700 (PDT)
Received: from debian.local ([2a0a:ef40:4d4:f101:e41a:977a:f788:910f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3997f9e6651sm16793284f8f.75.2025.03.26.05.53.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Mar 2025 05:53:35 -0700 (PDT)
Date: Wed, 26 Mar 2025 12:53:33 +0000
From: Chris Bainbridge <chris.bainbridge@gmail.com>
To: Danilo Krummrich <dakr@kernel.org>
Cc: Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
	nouveau@lists.freedesktop.org, maarten.lankhorst@linux.intel.com,
	mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com,
	simona@ffwll.ch, lyude@redhat.com, sumit.semwal@linaro.org,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH] drm/nouveau: prime: drm_prime_gem_destroy comment
Message-ID: <Z-P4zQ1464SeZGmB@debian.local>
References: <Z9GHj-edWJmyzpdY@debian.local>
 <00e4d9c4-ecfc-4784-b603-12db04cda806@amd.com>
 <Z9q-ggKKgTsvW-Rz@debian.local>
 <Z9rA0G2urlVHFOSx@cassiopeiae>
 <1f4a534f-8883-4793-b191-60c2773f6217@amd.com>
 <Z9rSTkXlub-JZAz0@cassiopeiae>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Z9rSTkXlub-JZAz0@cassiopeiae>

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


