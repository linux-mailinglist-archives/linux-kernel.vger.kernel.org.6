Return-Path: <linux-kernel+bounces-423415-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EE90E9DA718
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 12:48:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F0341B24C26
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 11:47:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C8BA1F8AE7;
	Wed, 27 Nov 2024 11:47:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F6TGMjkT"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F23601F9EB4
	for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2024 11:47:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732708035; cv=none; b=IlbazWgLKLmiO0fzVBGKTQwurjwBIp5XkzMVnIQ9nKN/FH/7CNfQ3SbLRCuWw4JiaDeSG/CaujCWCjTof1/JzR1QJ+eUdFxshOpJ0B1Gl8tXFyBnnfvTYc4AlsM7nARxVFv/gz/uqAd8ejSsUaUpEr5tVaaQ3YIZ7oXlUz3NjAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732708035; c=relaxed/simple;
	bh=d3MTBcQkwU2lmQ98bFrXDrFppjPfqnEERbGS0GGjuaI=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=d5QQ/iy73cFbVNtYYpe19U256cAcnhJPZ3pzI05y4nOo8RXcEfzYDm1A74pO8Lwh5hhPBP1R1uGa3xbAnxaTxTIPLLZ4Yd7xjkoOUKcAKVxutNGkZhhe9VbgGkDZjW/+ysPnaL6hXNQiEgCGhVaxhqCeU+wHpJlh6sfFdSiOowM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F6TGMjkT; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-21210fe8775so5966865ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2024 03:47:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732708033; x=1733312833; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MuylmfZA3oDT64r9NGCB6xYFcj/Ra9P9EYBkVyg6c3M=;
        b=F6TGMjkTt1ISzgWEe9grfsUGeY7L/Jnnlf1dNpr0aPjeOHCLptkE+7n9wW4CCJrIu/
         WXC23HkFWM0xPqeCOFwdag6dcTvnn+nVNZVGJBnVMGBBU6Ac5lyMQbknBSmcz9ikC6N9
         B6welkb+1Ley9sCPLsBCMB2uu55ijAMshKiO35FVrSFAOsfW8WHJqPz9ETkBLCUOa7jW
         vvk+gUWClyDg8LZVNt3xWp+KdrZs+gr0rFlDHvl5DKea2QXYuAne2Rt80VoS48Cb8zCm
         GAPQjAFaI9pWafkDgg83qgplENCs+IxvqGhAuBAikvm47U8w6DCjZIGsVWT9202sbHZa
         OZag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732708033; x=1733312833;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MuylmfZA3oDT64r9NGCB6xYFcj/Ra9P9EYBkVyg6c3M=;
        b=wK8wE+z2E7wAPQNmgUc+sBZKGDVd7v7lI4k8O/n0ikdEZGLG4H9A8qEMnyZR3vaoLR
         +4S64qaD6+uSJZ+HWRw0dfPdDGe/pL7jEYR8Y65WxJWxCZElXnmLuTvzPuuQxRVyj0wq
         2g8ebw2OR+EDN41PMHwg2bhoQK+lj//kFNIdu6T5MEd15IYDR22LXEVyzBjXqjpCUqwL
         YSEPRxCuz/wH76AcLvYAVqStP3USq5U0A9FipM6C2TMrcaZoRAqJn/JC4xMVrk5KprdM
         G9als00uZ35KyW+Y/pus55jQNmoeCQOCHX9D7NJ9YLOBZwuiYOu0QOZVI2qvpf1437oY
         KATQ==
X-Forwarded-Encrypted: i=1; AJvYcCVKnS+G+v1J/AufYckrxF1wqA5wu3/smXh1Ck8DtdGnbI4k5Yogyw4DnICC0nZ1WM9GI8cDaSW7in347wc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1a4BmkC9i+hyLjbAefUOPpK3DDD07kvlGWwlg3MTN43KyqpVQ
	cBmU/Obac4dKOe2pjGeu/MDzVVNI1x8ibBZxRd71tcTguv806vw4
X-Gm-Gg: ASbGnctqhVEJDU+4PdvFMhhAiK9xc/aXX7kNFYGaesPFBXYzD6UIkOAdlDwy1Qq4aJO
	HbB34d70/reyMQDyRC31K0TuoE4sm50Ap0CFeDI3jTG5tJQbL57eRlv6G9qaqLysJZOJ02iVC2M
	ky6b0TZb4vmVTbBAIpGRCjtlmqqb+aGwN/eZflhRrL/vlMU3GLyuhv161csBqn+H8nz33MGq99N
	ciS8JdcOWO6krCo/h9U6jn0foAnDRLUSQFW4Ghd1WKOVUX2as2QnbB6lXQNa5RI1ZKLV8Vtb0xm
	QQ==
X-Google-Smtp-Source: AGHT+IHoX3eDCwwyCInnqKWFs872hvgjGvyI4beYdRcCyyPD9WI1QnVw1OwIhB5AgQuCLd1pLGXWxA==
X-Received: by 2002:a17:903:1c2:b0:20c:b3ea:9006 with SMTP id d9443c01a7336-214e6e5b6a2mr90909195ad.6.1732708033193;
        Wed, 27 Nov 2024 03:47:13 -0800 (PST)
Received: from miley.lan (c-73-162-202-2.hsd1.ca.comcast.net. [73.162.202.2])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-2129dbfa834sm100805645ad.117.2024.11.27.03.47.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Nov 2024 03:47:12 -0800 (PST)
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
Subject: [PATCH 1/1] amdgpu fix for gfx1103 queue evict/restore crash
Date: Wed, 27 Nov 2024 03:46:38 -0800
Message-ID: <20241127114638.11216-2-lamikr@gmail.com>
X-Mailer: git-send-email 2.41.1
In-Reply-To: <20241127114638.11216-1-lamikr@gmail.com>
References: <20241127114638.11216-1-lamikr@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

AMD gfx1103 / M780 iGPU will crash eventually when used for
pytorch ML/AI operations on rocm sdk stack. After kernel error
the application exits on error and linux desktop can itself
sometimes either freeze or reset back to login screen.

Error will happen randomly when kernel calls evict_process_queues_cpsch and
restore_process_queues_cpsch methods to remove and restore the queues
that has been created earlier.

The fix is to remove the evict and restore calls when device used is
iGPU. The queues that has been added during the user space application execution
time will still be removed when the application exits

On evety test attempts the crash has always happened on the
same location while removing the 2nd queue of 3 with doorbell id 0x1002.

Below is the trace captured by adding more printouts to problem
location to print message also when the queue is evicted or resrored
succesfully.

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
 .../drm/amd/amdkfd/kfd_device_queue_manager.c | 24 ++++++++++++-------
 1 file changed, 16 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
index c79fe9069e22..96088d480e09 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
@@ -1187,9 +1187,12 @@ static int evict_process_queues_cpsch(struct device_queue_manager *dqm,
 	struct kfd_process_device *pdd;
 	int retval = 0;
 
+	// gfx1103 APU can fail to remove queue on evict/restore cycle
+	if (dqm->dev->adev->flags & AMD_IS_APU)
+		goto out;
 	dqm_lock(dqm);
 	if (qpd->evicted++ > 0) /* already evicted, do nothing */
-		goto out;
+		goto out_unlock;
 
 	pdd = qpd_to_pdd(qpd);
 
@@ -1198,7 +1201,7 @@ static int evict_process_queues_cpsch(struct device_queue_manager *dqm,
 	 * Skip queue eviction on process eviction.
 	 */
 	if (!pdd->drm_priv)
-		goto out;
+		goto out_unlock;
 
 	pr_debug_ratelimited("Evicting PASID 0x%x queues\n",
 			    pdd->process->pasid);
@@ -1219,7 +1222,7 @@ static int evict_process_queues_cpsch(struct device_queue_manager *dqm,
 			if (retval) {
 				dev_err(dev, "Failed to evict queue %d\n",
 					q->properties.queue_id);
-				goto out;
+				goto out_unlock;
 			}
 		}
 	}
@@ -1231,8 +1234,9 @@ static int evict_process_queues_cpsch(struct device_queue_manager *dqm,
 					      KFD_UNMAP_QUEUES_FILTER_DYNAMIC_QUEUES, 0,
 					      USE_DEFAULT_GRACE_PERIOD);
 
-out:
+out_unlock:
 	dqm_unlock(dqm);
+out:
 	return retval;
 }
 
@@ -1326,14 +1330,17 @@ static int restore_process_queues_cpsch(struct device_queue_manager *dqm,
 	uint64_t eviction_duration;
 	int retval = 0;
 
+	// gfx1103 APU can fail to remove queue on evict/restore cycle
+	if (dqm->dev->adev->flags & AMD_IS_APU)
+		goto out;
 	pdd = qpd_to_pdd(qpd);
 
 	dqm_lock(dqm);
 	if (WARN_ON_ONCE(!qpd->evicted)) /* already restored, do nothing */
-		goto out;
+		goto out_unlock;
 	if (qpd->evicted > 1) { /* ref count still > 0, decrement & quit */
 		qpd->evicted--;
-		goto out;
+		goto out_unlock;
 	}
 
 	/* The debugger creates processes that temporarily have not acquired
@@ -1364,7 +1371,7 @@ static int restore_process_queues_cpsch(struct device_queue_manager *dqm,
 			if (retval) {
 				dev_err(dev, "Failed to restore queue %d\n",
 					q->properties.queue_id);
-				goto out;
+				goto out_unlock;
 			}
 		}
 	}
@@ -1375,8 +1382,9 @@ static int restore_process_queues_cpsch(struct device_queue_manager *dqm,
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
2.43.0


