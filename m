Return-Path: <linux-kernel+bounces-345298-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 83C7C98B448
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 08:26:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 11D1E284240
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 06:26:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C1F51BBBED;
	Tue,  1 Oct 2024 06:26:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="TLI22kcq"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06D2719046D;
	Tue,  1 Oct 2024 06:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727763980; cv=none; b=HZiRE3jzy7IYoPpaM2wp9yvyXAioAxCehnZLx7BKt6oe5v+wG4CXNfb48FPdLRNKwxo+nF+yoGyBu2QvuT9pXQxIwnxzbgMJ0nzcyGwnhtVP/3I9J31XyINht6QfB0lmIF7NNuhZ6qZ3qNgnzJr1AKwvuUklEzM4EEnJrZOxm88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727763980; c=relaxed/simple;
	bh=2IGpuMaCCMmZF9wXwNoAM/P3xPLyHYRLwRKRkctYIoU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OqXOo3a9rVhkiHAwPgt//m/uVhLicIeamqccfhxrULqJHFJQA/pSH55gnX+0SWSoKRMi8p3a446QhEVs2uOyKvIuawTWpwjDd5ZC5PxFaffkhv/6YuVsgtmKQILkckBdU6H8XHbSJeppXXfMOE1WCUgrl3kdDBeuTDZHm7WNuPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=TLI22kcq; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4911te6b031730;
	Tue, 1 Oct 2024 06:26:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding; s=corp-2023-11-20; bh=ynm5UubeZN8/05
	jyHZV3Mzy9wSlSyMLNZm6kc6piD7s=; b=TLI22kcqJ2TwT43yzz/LCEqOT61md1
	ghpl1u30R6CUd+0Jk24j5d/DhNxyXpxPzXz/uJvNAmQ1oq0OuzkIYT4OCIrWGKYH
	V8eSUgfbhs2ZD1UO3gbDSVJkstStI3u+manIWCjOuZTyT9y+HmtpQ80qP7CI1+GN
	xOVmOq5JBBLXCiTFrESxKUUsRzBifH5g57PAGOFlgZ1Ew55MKFR4iTKFk4BAdJzs
	+uZyRusWP4LuFOF5mykYav+zIJgkGqbLQcG7QqIhZSnEZ4BvDRzeBcSz3bcje2Fy
	+aCs9uBdgGSato8t8JcM4/eAIPoqJlhLElTBnwjV8R2zxL8vHOXh0Lmg==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41x8qb5e53-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 01 Oct 2024 06:26:01 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49162Qlq012578;
	Tue, 1 Oct 2024 06:26:00 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 41x886usvm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 01 Oct 2024 06:26:00 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 4916Pxcd017923;
	Tue, 1 Oct 2024 06:25:59 GMT
Received: from ca-dev112.us.oracle.com (ca-dev112.us.oracle.com [10.129.136.47])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 41x886usuf-1;
	Tue, 01 Oct 2024 06:25:59 +0000
From: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
To: Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Tvrtko Ursulin <tursulin@ursulin.net>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Jonathan Corbet <corbet@lwn.net>,
        Andi Shyti <andi.shyti@linux.intel.com>,
        Jonathan Cavitt <jonathan.cavitt@intel.com>,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: vegard.nossum@oracle.com,
        Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Subject: [PATCH] drm/i915: Rename functions in the docs to match code changes
Date: Mon, 30 Sep 2024 23:25:54 -0700
Message-ID: <20241001062555.1908090-1-harshit.m.mogalapalli@oracle.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-01_03,2024-09-30_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 malwarescore=0 mlxscore=0 spamscore=0 suspectscore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2408220000 definitions=main-2410010042
X-Proofpoint-GUID: z_dP0EpF79RgKrDIG2aJ8fVG7AvxDQlH
X-Proofpoint-ORIG-GUID: z_dP0EpF79RgKrDIG2aJ8fVG7AvxDQlH

make htmldocs is reporting:

drivers/gpu/drm/i915/i915_irq.c:1: warning: 'intel_runtime_pm_disable_interrupts' not found
drivers/gpu/drm/i915/i915_irq.c:1: warning: 'intel_runtime_pm_enable_interrupts' not found

intel_runtime_pm_disable_interrupts() is renamed to intel_irq_suspend(),
make documentation changes accordingly.

Fixes: 3de5774cb8c0 ("drm/i915/irq: Rename suspend/resume functions")
Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Closes: https://lore.kernel.org/all/20241001134331.7b4d4ca5@canb.auug.org.au/
Signed-off-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
---
Noticed that Stephen also reported this so added a Closes URL.
---
 Documentation/gpu/i915.rst | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/gpu/i915.rst b/Documentation/gpu/i915.rst
index ad59ae579237..7a469df675d8 100644
--- a/Documentation/gpu/i915.rst
+++ b/Documentation/gpu/i915.rst
@@ -35,10 +35,10 @@ Interrupt Handling
    :functions: intel_irq_init intel_irq_init_hw intel_hpd_init
 
 .. kernel-doc:: drivers/gpu/drm/i915/i915_irq.c
-   :functions: intel_runtime_pm_disable_interrupts
+   :functions: intel_irq_suspend
 
 .. kernel-doc:: drivers/gpu/drm/i915/i915_irq.c
-   :functions: intel_runtime_pm_enable_interrupts
+   :functions: intel_irq_resume
 
 Intel GVT-g Guest Support(vGPU)
 -------------------------------
-- 
2.46.0


