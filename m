Return-Path: <linux-kernel+bounces-568035-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DDFFCA68D41
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 13:56:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5466842359E
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 12:54:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6903725524C;
	Wed, 19 Mar 2025 12:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y2VfCAw/"
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2DC0250F8
	for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 12:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742388872; cv=none; b=KHJx1bugw41l/o/DkY862eKc3GiZhiTLP9JLPqOQEeRmcZzI7CO7Bp0LFingUqeYVRV37dxJJU9wZn/rOokDg7k2M2kAZZB38l9Yx6+P5c1Hmmu7MprecFn3DjDlWQaH+PvOr7Ylm0HTC4HrcGwqLTOPuINmz/Hhz8gnmqDmRbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742388872; c=relaxed/simple;
	bh=i0sjbLsWQ6kQOJKuMwNygeCVl6zmrUgzU8/77KXSqGM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RTPsKuaSPhJdtqM5OSzasNqC90lwRCh6jsy9CMCOCLlAW/6PKvZWYyY50tYC3LYZVVJsLy6YZ2CtT7a3sr9dY+rN4mzOtcl/FK4GVxx6b8aI3RshlkxNeZoYnVtdD1wtKu6SENEKTDrjMC7cH5LrdqKqgj3c60TxmOSqHHcY+1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y2VfCAw/; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-39133f709f5so4199620f8f.0
        for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 05:54:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742388869; x=1742993669; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=X4QdDJ2tzHkN+lFmUSCLEya/f2yHJVYxm+pxkS4tFfI=;
        b=Y2VfCAw/ER+jwMm9dUX8ZPPd2LzodbnolKUVvmlgD6kYRpkm4mdW2NAfN8fo4UyHnA
         VvdeiXHk4Y6jWNGSTfZmw91jNWhYFl88rD8LXKPi1MRd12OTruaKmO/0K9dmOnvzi5Rl
         x32dgyIPXTU46s+r24uBjJCIQ3ckZ3CoquwUNfpUDYTikksBxip2fZPZHY5z3YEXM2Rf
         gcM0z9DW7XTD7sQaT8e3MkkqSfLbOIOiEKg8EvHv+ZRmg7JdZ6HrBpqJ87yZ9FmS5kHw
         UqzRROwF7Ow8UGAS0DwVL6tLzrhHMIIWq6M230mg/JewXYPaNzI+NmIsYL53YQ0VCl3K
         G6AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742388869; x=1742993669;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=X4QdDJ2tzHkN+lFmUSCLEya/f2yHJVYxm+pxkS4tFfI=;
        b=Q/myC8A7ROc8/2ZFeCqMV4CQ+wh1cXUEqur3qnQMAqoQjrv7C+nXWEifIJv6zJ3Tpp
         Ifgk8T0sHgzDXOagO7NAmfkGCrYGVd8c0rJiONW8FbH5UH2agUKrmqxhz588mXGk1n7t
         fkH6fXfae+iNOQ2aVznmaD0cau/EcmIzsQVwaKuyVPPXyC4p8UsgZJ8cGdvaTUYFDBGo
         EWS7L3Pm882/GtpqmXGoN5TchtQxp4Eg9k6sZKlIHO0XXxhf84nuDhM9mD7SuYxXiroJ
         HJeXBUiiSfYvTWqcqqGP2dcbwfRViEqCDhdQd2ncXt8nE8GJIK6rS6HQo2ZgshJqP6GH
         By7w==
X-Forwarded-Encrypted: i=1; AJvYcCV+tpkeHosW8D0MIRdx3JFejLOG+mfJdNTGtH8BFRjx/0yahYeQE3m31lPeXSuP4arjTOqwm6Y/NGY4il0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yymu+uYXEsH8+jrsHJke1tHk7e0QKv13Nm4LN0lt3aE8vOnnqRM
	VhO0QTQGxnzF8+2JKKXGnZO6C6k0naIpwa0027XPg6JEd+ZYffTF
X-Gm-Gg: ASbGnctn+wO01C2lKjUCTVHZ7gz7rui7MWCbPhMyWRJyL063/YDkFfmTMZ3ZKAllS29
	66QCqWxxmJsg7BeBm/A0VN3v+mKh88Yr8BABf0CW2gdXn1e0QKkN1+MK9hsvtYBiILcDCV52jpU
	uv16YkuwjFgSuMVjEq8sJCuX9fl1U6HDj6t7O6/laoLH9hnqvE5qEU/+oxx135WFhQjs9SG0177
	rEeM/KmpUgtdzmMUEvZtEg/qBTO+5c04UYjVtP0R7PHygc113Aa+RcmqzDf/byZE71dDZCGOTOM
	qUcT0g1u36pESYPJn1lMi2Pyw/ulZ1pejR3UDXYOjCvWYVHlZQ==
X-Google-Smtp-Source: AGHT+IFZ6FPtAbMMxEz4gP/mto1/uWDI3BM7h/JbFem0VhxOeZG8sDMPHltBWY5gxWrGw7NDRnawsw==
X-Received: by 2002:a05:6000:4007:b0:391:3261:ff48 with SMTP id ffacd0b85a97d-39973af9cb4mr3217380f8f.35.1742388868903;
        Wed, 19 Mar 2025 05:54:28 -0700 (PDT)
Received: from debian.local ([84.68.5.81])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3997656f43asm1046671f8f.25.2025.03.19.05.54.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Mar 2025 05:54:28 -0700 (PDT)
Date: Wed, 19 Mar 2025 12:54:26 +0000
From: Chris Bainbridge <chris.bainbridge@gmail.com>
To: Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>
Cc: nouveau@lists.freedesktop.org, maarten.lankhorst@linux.intel.com,
	mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com,
	simona@ffwll.ch, lyude@redhat.com, dakr@kernel.org,
	sumit.semwal@linaro.org, dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] drm/nouveau: prime: fix ttm_bo_delayed_delete oops
Message-ID: <Z9q-ggKKgTsvW-Rz@debian.local>
References: <Z9GHj-edWJmyzpdY@debian.local>
 <00e4d9c4-ecfc-4784-b603-12db04cda806@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <00e4d9c4-ecfc-4784-b603-12db04cda806@amd.com>

Fix an oops in ttm_bo_delayed_delete which results from dererencing a
dangling pointer:

Oops: general protection fault, probably for non-canonical address 0x6b6b6b6b6b6b6b7b: 0000 [#1] PREEMPT SMP
CPU: 4 UID: 0 PID: 1082 Comm: kworker/u65:2 Not tainted 6.14.0-rc4-00267-g505460b44513-dirty #216
Hardware name: LENOVO 82N6/LNVNB161216, BIOS GKCN65WW 01/16/2024
Workqueue: ttm ttm_bo_delayed_delete [ttm]
RIP: 0010:dma_resv_iter_first_unlocked+0x55/0x290
Code: 31 f6 48 c7 c7 00 2b fa aa e8 97 bd 52 ff e8 a2 c1 53 00 5a 85 c0 74 48 e9 88 01 00 00 4c 89 63 20 4d 85 e4 0f 84 30 01 00 00 <41> 8b 44 24 10 c6 43 2c 01 48 89 df 89 43 28 e8 97 fd ff ff 4c 8b
RSP: 0018:ffffbf9383473d60 EFLAGS: 00010202
RAX: 0000000000000001 RBX: ffffbf9383473d88 RCX: 0000000000000000
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: ffffbf9383473d78 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: 6b6b6b6b6b6b6b6b
R13: ffffa003bbf78580 R14: ffffa003a6728040 R15: 00000000000383cc
FS:  0000000000000000(0000) GS:ffffa00991c00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000758348024dd0 CR3: 000000012c259000 CR4: 0000000000f50ef0
PKRU: 55555554
Call Trace:
 <TASK>
 ? __die_body.cold+0x19/0x26
 ? die_addr+0x3d/0x70
 ? exc_general_protection+0x159/0x460
 ? asm_exc_general_protection+0x27/0x30
 ? dma_resv_iter_first_unlocked+0x55/0x290
 dma_resv_wait_timeout+0x56/0x100
 ttm_bo_delayed_delete+0x69/0xb0 [ttm]
 process_one_work+0x217/0x5c0
 worker_thread+0x1c8/0x3d0
 ? apply_wqattrs_cleanup.part.0+0xc0/0xc0
 kthread+0x10b/0x240
 ? kthreads_online_cpu+0x140/0x140
 ret_from_fork+0x40/0x70
 ? kthreads_online_cpu+0x140/0x140
 ret_from_fork_asm+0x11/0x20
 </TASK>

The cause of this is:

- drm_prime_gem_destroy calls dma_buf_put(dma_buf) which releases the
  reference to the shared dma_buf. The reference count is 0, so the
  dma_buf is destroyed, which in turn decrements the corresponding
  amdgpu_bo reference count to 0, and the amdgpu_bo is destroyed -
  calling drm_gem_object_release then dma_resv_fini (which destroys the
  reservation object), then finally freeing the amdgpu_bo.

- nouveau_bo obj->bo.base.resv is now a dangling pointer to the memory
  formerly allocated to the amdgpu_bo.

- nouveau_gem_object_del calls ttm_bo_put(&nvbo->bo) which calls
  ttm_bo_release, which schedules ttm_bo_delayed_delete.

- ttm_bo_delayed_delete runs and dereferences the dangling resv pointer,
  resulting in a general protection fault.

Fix this by moving the drm_prime_gem_destroy call from
nouveau_gem_object_del to nouveau_bo_del_ttm. This ensures that it will
be run after ttm_bo_delayed_delete.

Signed-off-by: Chris Bainbridge <chris.bainbridge@gmail.com>
Co-Developed-by: Christian König <christian.koenig@amd.com>
Fixes: https://gitlab.freedesktop.org/drm/amd/-/issues/3937
---
 drivers/gpu/drm/drm_prime.c           | 8 ++++++--
 drivers/gpu/drm/nouveau/nouveau_bo.c  | 3 +++
 drivers/gpu/drm/nouveau/nouveau_gem.c | 3 ---
 3 files changed, 9 insertions(+), 5 deletions(-)

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
diff --git a/drivers/gpu/drm/nouveau/nouveau_bo.c b/drivers/gpu/drm/nouveau/nouveau_bo.c
index db961eade225..2016c1e7242f 100644
--- a/drivers/gpu/drm/nouveau/nouveau_bo.c
+++ b/drivers/gpu/drm/nouveau/nouveau_bo.c
@@ -144,6 +144,9 @@ nouveau_bo_del_ttm(struct ttm_buffer_object *bo)
 	nouveau_bo_del_io_reserve_lru(bo);
 	nv10_bo_put_tile_region(dev, nvbo->tile, NULL);
 
+	if (bo->base.import_attach)
+		drm_prime_gem_destroy(&bo->base, bo->sg);
+
 	/*
 	 * If nouveau_bo_new() allocated this buffer, the GEM object was never
 	 * initialized, so don't attempt to release it.
diff --git a/drivers/gpu/drm/nouveau/nouveau_gem.c b/drivers/gpu/drm/nouveau/nouveau_gem.c
index 9ae2cee1c7c5..67e3c99de73a 100644
--- a/drivers/gpu/drm/nouveau/nouveau_gem.c
+++ b/drivers/gpu/drm/nouveau/nouveau_gem.c
@@ -87,9 +87,6 @@ nouveau_gem_object_del(struct drm_gem_object *gem)
 		return;
 	}
 
-	if (gem->import_attach)
-		drm_prime_gem_destroy(gem, nvbo->bo.sg);
-
 	ttm_bo_put(&nvbo->bo);
 
 	pm_runtime_mark_last_busy(dev);
-- 
2.47.2


