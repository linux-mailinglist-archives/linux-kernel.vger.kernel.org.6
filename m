Return-Path: <linux-kernel+bounces-417405-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EBD829D53A7
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 20:54:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ABEA3281CCE
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 19:54:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78B9A1C8FD4;
	Thu, 21 Nov 2024 19:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jQ9puGy8"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26A861C7B69
	for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2024 19:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732218865; cv=none; b=r0ZURauaLqyUEZSdBwdmkGPBNOxs22RgEJVf6Noqfc+kCrFOPX2X9xqmgVELGBz74x4wRk13Xp0E0xUfsSmYwXwStv6WCdNFlftaQ03XE84raAKR6m9Qs14Q9v6237EOqMzzdifxVEWURmzEsUxCmR15rQPSLDNPzje5XsVRHF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732218865; c=relaxed/simple;
	bh=C9EsC1iis1meHdEfwN0TIW5avQS6Ko7Rvhw2YiaNr5w=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=rp7i/Tx5+ohL+Ku5a1UrnzpHVJ48d6+lG3ujhivimgN27mTaKQPM8FPz0EjIiSoWpzibc7DIoaEjGk58MtHrsG02hmuAy5K616pCuJvXYnydOpa3xSEwJsr863wYA1n/XYDrmj0c5I6X/W40lBlcrlJ6qkJB7OVWHhKNmQ3AnvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jQ9puGy8; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-21288402a26so12913375ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2024 11:54:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732218863; x=1732823663; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=wp6l7XhsmrdMnTO0WKGfVcLhA31d906veXwj9w1//x4=;
        b=jQ9puGy84UTIVFD+wbvlyEaNJD2Mz3wb9VoxA9uWL4x53qAk3YYHL4ScQU+ZyuuYbl
         wUADQILMGw1ztC1Ytb3mJIuMaDIcdgxvSNZCZYCit7FecRJiMQp009UGMETDNUdH5KBc
         fc5IIrQG16BvSmLtKnwN06WG2BuppaLf81pya2/5WAfZlxUjqpC/+vS28xzqsTUHCDpr
         w/NCK501/q+z5RLZIny6EGaY9nehIOojb8cq6gcy051FW2ofzuiWn9LSrVlExumOBM6U
         8eglWU3RHgHaggEokVbYbU6Eo851hN+Fez5TSo73+byaJIJ/MLCyt25+Xh2yhpfbMxMG
         TKjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732218863; x=1732823663;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wp6l7XhsmrdMnTO0WKGfVcLhA31d906veXwj9w1//x4=;
        b=qxmHKnzS8S2q6k9GaMf76LjN74n56gJEKLK8IENaBib8p3b3G5y3uoxrbz5E8lLgPU
         XUMVzFkBfcAHyCotOCYaJPBwkuKxaWevDBBY5ank8fUuF2Tw1Cdil04Wq4JwlEP1sgWA
         rDUzhdamkZuvDd52L2awsiERyg3V6SR+ar6LTjjNRGX6pY2cH+DG9L5rJx/2iMP90vOS
         HosyE2c2p7JdDR60WlmnZxBUI6Q2k88reofI+GPC0Pd7swr7dO41nbdnvrisD5SPLPis
         9kmq/XJA7sFyeYVbeE2Dr23yJJg0jL4/XEPz32SCl6DWEBSry47efzJUCbwWVSvhJl+6
         IjmQ==
X-Forwarded-Encrypted: i=1; AJvYcCUItX34gnvDwjL4asE8XgrnPCyw0gJjnYFAaKPyi3TSys2n27upZNFt7e28RItDBogMESWaHONHbcKM030=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxs2AsBIzyiKZ/u2SmEqqHjZ7ChHM1bfA6sisYfKdadE1TbWhD5
	lOEm/DA6Dl9ZZw30HRkfpHPzNaNXp68FyiD2kWExseLm04swvGD8
X-Gm-Gg: ASbGncu2KOlLdRQn79TTzGX5+8gXqVeOMmoonOUu84IKOilKAhUIYHxN7c+pyGFHEHt
	U00F93TCMWY9cx7eCRaeQXodSTaN42uMFliVYhGbvGgIcFGrhNJAGBoSIrO/7d4uaBDe1gfB5sW
	3Fi+AfHdESUmjwn7gllKCbfCHar8SXvhSGApaaBl3K80xZPqGviu+Wvmzv2kS+LquzKMHgpjwo5
	Z+r0oCgE+bC9R5Zw8jgOWupiwaXvEpK8FnrvF1G0XqWwy0+sAKdm5Nqnnut
X-Google-Smtp-Source: AGHT+IGf/s3igp1qa5nwVQ3UdLZG958xwoVDCENF4/Gy7tOWTIVSR+2U/Yx0Ve/MsXWa6Y/f888KRQ==
X-Received: by 2002:a17:902:f711:b0:20c:dbff:b9d8 with SMTP id d9443c01a7336-2129f28a632mr5051985ad.37.1732218863209;
        Thu, 21 Nov 2024 11:54:23 -0800 (PST)
Received: from miley.wireless.pacific.edu ([138.9.3.75])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-2129dbfb2fdsm2122555ad.156.2024.11.21.11.54.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Nov 2024 11:54:22 -0800 (PST)
From: Mika Laitio <lamikr@gmail.com>
To: christian.koenig@amd.com,
	Xinhui.Pan@amd.com,
	airlied@gmail.com,
	simona@ffwll.ch,
	Hawking.Zhang@amd.com,
	sunil.khatri@amd.com,
	lijo.lazar@amd.com,
	kevinyang.wang@amd.com,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	lamikr@gmail.com
Subject: [PATCH] ammdgpu fix for gfx1103 queue evict/restore crash
Date: Thu, 21 Nov 2024 11:51:49 -0800
Message-ID: <20241121195233.10679-1-lamikr@gmail.com>
X-Mailer: git-send-email 2.41.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

AMD gfx1103/M780 iGPU will crash eventually while performing
pytorch ML/AI operations on rocm sdk stack. Crash causes linux
desktop randomly either to recover after killing the app,
freeze the desktop or reset back to login screen.

Easy way to trigger the problem is to build the the
ML/AI support for gfx1103 M780 iGPU with the
rocm sdk builder and then running the test application in loop.

Additional trace messages helped to found out that error happens
always on same location when kernel ends up peridiocally
calling evict_process_queues_cpsch and restore_process_queues_cpsch
methods and calls MES to restore the queues in loop.

Crash requires small but random amount calls to these evict and restore
calls. (usually around 10-50) before the error happens on kernel. On
gfx1103 case, there seems to be 3 queues that are evicted and restored
and errors happens always when restoring the second one from the list
with the doorbell 0x1002.

Adding delays to either to test application between calls (1 second)
or to loop inside kernel which removes the queues one by one (mdelay(10))
does not help to avoid the crash.

I tested multiple other GPUs and similar error could not be triggered
gfx1010 (rx 5900), gfx1030 (rx 6800) and gfx1035 (M680 iGPU) or gfx1102
(RX 7700S). From these devices only the gfx1102 uses same codepath for
calling mes firmware.

I tested that the problem could not be avoidded either by adding delay
to user space pytorch app via delays between calls (1 sec) or by adding
delay to loop inside the kernel which removes/restores the queues.
(tested with mdelay(10))

Testing has mostly been done on 6.12rcs and 6.12 final kernels but same
problem can been triggered also at least on 6.08 and 6.11 kernels.
After the fix I have run the application on loop multiple times over
1000 loop without seeing the error to happen again.

Original bug and test case was made by jrl290 on rocm sdk builder bug issue 141.

[  948.324174] amdgpu 0000:c4:00.0: amdgpu: add_queue_mes added hardware queue to MES, doorbell=0x1202, queue: 2, caller: restore_process_queues_cpsch
[  948.334344] amdgpu 0000:c4:00.0: amdgpu: add_queue_mes added hardware queue to MES, doorbell=0x1002, queue: 1, caller: restore_process_queues_cpsch
[  948.344499] amdgpu 0000:c4:00.0: amdgpu: add_queue_mes added hardware queue to MES, doorbell=0x1000, queue: 0, caller: restore_process_queues_cpsch
[  952.380614] amdgpu 0000:c4:00.0: amdgpu: remove_queue_mes removed hardware queue from MES, doorbell=0x1202, queue: 2, caller: evict_process_queues_cpsch
[  952.391330] amdgpu 0000:c4:00.0: amdgpu: remove_queue_mes removed hardware queue from MES, doorbell=0x1002, queue: 1, caller: evict_process_queues_cpsch
[  952.401634] amdgpu 0000:c4:00.0: amdgpu: remove_queue_mes removed hardware queue from MES, doorbell=0x1000, queue: 0, caller: evict_process_queues_cpsch
[  952.414507] amdgpu 0000:c4:00.0: amdgpu: add_queue_mes added hardware queue to MES, doorbell=0x1202, queue: 2, caller: restore_process_queues_cpsch
[  952.424618] amdgpu 0000:c4:00.0: amdgpu: add_queue_mes added hardware queue to MES, doorbell=0x1002, queue: 1, caller: restore_process_queues_cpsch
[  952.434922] amdgpu 0000:c4:00.0: amdgpu: add_queue_mes added hardware queue to MES, doorbell=0x1000, queue: 0, caller: restore_process_queues_cpsch
[  952.446272] amdgpu 0000:c4:00.0: amdgpu: remove_queue_mes removed hardware queue from MES, doorbell=0x1202, queue: 2, caller: evict_process_queues_cpsch
[  954.460341] amdgpu 0000:c4:00.0: amdgpu: MES failed to respond to msg=REMOVE_QUEUE
[  954.460356] amdgpu 0000:c4:00.0: amdgpu: remove_queue_mes failed to remove hardware queue from MES, doorbell=0x1002, queue: 1, caller: evict_process_queues_cpsch
[  954.460360] amdgpu 0000:c4:00.0: amdgpu: MES might be in unrecoverable state, issue a GPU reset
[  954.460366] amdgpu 0000:c4:00.0: amdgpu: Failed to evict queue 1
[  954.460368] amdgpu 0000:c4:00.0: amdgpu: Failed to evict process queues
[  954.460439] amdgpu 0000:c4:00.0: amdgpu: GPU reset begin!
[  954.460464] amdgpu 0000:c4:00.0: amdgpu: remove_all_queues_mes: Failed to remove queue 0 for dev 5257
[  954.460515] amdgpu 0000:c4:00.0: amdgpu: Dumping IP State
[  954.462637] amdgpu 0000:c4:00.0: amdgpu: Dumping IP State Completed
[  955.865591] amdgpu: process_termination_cpsch started
[  955.866432] amdgpu: process_termination_cpsch started
[  955.866445] amdgpu 0000:c4:00.0: amdgpu: Failed to remove queue 0
[  956.503043] amdgpu 0000:c4:00.0: amdgpu: MES failed to respond to msg=REMOVE_QUEUE
[  956.503059] [drm:amdgpu_mes_unmap_legacy_queue [amdgpu]] *ERROR* failed to unmap legacy queue
[  958.507491] amdgpu 0000:c4:00.0: amdgpu: MES failed to respond to msg=REMOVE_QUEUE
[  958.507507] [drm:amdgpu_mes_unmap_legacy_queue [amdgpu]] *ERROR* failed to unmap legacy queue
[  960.512077] amdgpu 0000:c4:00.0: amdgpu: MES failed to respond to msg=REMOVE_QUEUE
[  960.512093] [drm:amdgpu_mes_unmap_legacy_queue [amdgpu]] *ERROR* failed to unmap legacy queue
[  960.785816] [drm:gfx_v11_0_hw_fini [amdgpu]] *ERROR* failed to halt cp gfx

Signed-off-by: Mika Laitio <lamikr@gmail.com>
---
 .../drm/amd/amdkfd/kfd_device_queue_manager.c  | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
index 648f40091aa3..027c8b4010c2 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
@@ -1156,9 +1156,12 @@ static int evict_process_queues_cpsch(struct device_queue_manager *dqm,
 	struct kfd_process_device *pdd;
 	int retval = 0;
 
+	// gfx1103 APU fails to remove the queue usually after 10-50 attempts
+	if (dqm->dev->adev->flags & AMD_IS_APU)
+		goto out;
 	dqm_lock(dqm);
 	if (qpd->evicted++ > 0) /* already evicted, do nothing */
-		goto out;
+		goto out_unlock;
 
 	pdd = qpd_to_pdd(qpd);
 
@@ -1167,7 +1170,7 @@ static int evict_process_queues_cpsch(struct device_queue_manager *dqm,
 	 * Skip queue eviction on process eviction.
 	 */
 	if (!pdd->drm_priv)
-		goto out;
+		goto out_unlock;
 
 	pr_debug_ratelimited("Evicting PASID 0x%x queues\n",
 			    pdd->process->pasid);
@@ -1188,7 +1191,7 @@ static int evict_process_queues_cpsch(struct device_queue_manager *dqm,
 			if (retval) {
 				dev_err(dev, "Failed to evict queue %d\n",
 					q->properties.queue_id);
-				goto out;
+				goto out_unlock;
 			}
 		}
 	}
@@ -1200,8 +1203,9 @@ static int evict_process_queues_cpsch(struct device_queue_manager *dqm,
 					      KFD_UNMAP_QUEUES_FILTER_DYNAMIC_QUEUES, 0,
 					      USE_DEFAULT_GRACE_PERIOD);
 
-out:
+out_unlock:
 	dqm_unlock(dqm);
+out:
 	return retval;
 }
 
@@ -1295,6 +1299,9 @@ static int restore_process_queues_cpsch(struct device_queue_manager *dqm,
 	uint64_t eviction_duration;
 	int retval = 0;
 
+	// gfx1103 APU fails to remove the queue usually after 10-50 attempts
+	if (dqm->dev->adev->flags & AMD_IS_APU)
+		goto out;
 	pdd = qpd_to_pdd(qpd);
 
 	dqm_lock(dqm);
@@ -1344,8 +1351,9 @@ static int restore_process_queues_cpsch(struct device_queue_manager *dqm,
 	atomic64_add(eviction_duration, &pdd->evict_duration_counter);
 vm_not_acquired:
 	qpd->evicted = 0;
-out:
+out_unlock:
 	dqm_unlock(dqm);
+out:
 	return retval;
 }
 
-- 
2.41.1


