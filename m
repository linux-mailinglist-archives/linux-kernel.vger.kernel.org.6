Return-Path: <linux-kernel+bounces-196554-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D2F08D5DE4
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 11:12:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E68F22863F7
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 09:12:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE597156654;
	Fri, 31 May 2024 09:11:49 +0000 (UTC)
Received: from SHSQR01.spreadtrum.com (unknown [222.66.158.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00524155750
	for <linux-kernel@vger.kernel.org>; Fri, 31 May 2024 09:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=222.66.158.135
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717146709; cv=none; b=bpgmwvBgcxvnU+Mvrk/4dz0T1aOKC20tCp7EUL7KnQHuxIGDypzMoz3k/KvaIy0nwyzfX+IQbgDiWr/xdM/pWprM7gbXe939kUg8en8NXcise2haeU/PABx5AS5Qr8eF7jeqO7aq9f8j4r3tBQi5GEMDec+hIe/P/eeA1ViTQys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717146709; c=relaxed/simple;
	bh=qHJYZA6a5q1reu3d2mgSmNoW5K8sph6cAVm6974js/E=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=CDB4z9/oIVBQL+g8irkZr8l1JWKSbGXcgSWwVm1EcBc6l6l5/l1HG8P7+JN87Qvj2kzpuIUgdxmnZ/GhkbpZ2YwNXudh26DMZ1e7sXnDzI/jAcOg6UHwHJA9rmTqx44d+wRjBWjzu5k4+XPVCT4ebF/SXzEdpM6vzHqRKHP73Go=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unisoc.com; spf=pass smtp.mailfrom=unisoc.com; arc=none smtp.client-ip=222.66.158.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unisoc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=unisoc.com
Received: from dlp.unisoc.com ([10.29.3.86])
	by SHSQR01.spreadtrum.com with ESMTP id 44V9B080041893;
	Fri, 31 May 2024 17:11:00 +0800 (+08)
	(envelope-from Zhiguo.Niu@unisoc.com)
Received: from SHDLP.spreadtrum.com (bjmbx02.spreadtrum.com [10.0.64.8])
	by dlp.unisoc.com (SkyGuard) with ESMTPS id 4VrHLj2JJdz2QN2yZ;
	Fri, 31 May 2024 17:07:09 +0800 (CST)
Received: from bj08434pcu.spreadtrum.com (10.0.73.87) by
 BJMBX02.spreadtrum.com (10.0.64.8) with Microsoft SMTP Server (TLS) id
 15.0.1497.23; Fri, 31 May 2024 17:10:57 +0800
From: Zhiguo Niu <zhiguo.niu@unisoc.com>
To: <jaegeuk@kernel.org>, <chao@kernel.org>
CC: <linux-f2fs-devel@lists.sourceforge.net>, <linux-kernel@vger.kernel.org>,
        <niuzhiguo84@gmail.com>, <zhiguo.niu@unisoc.com>, <ke.wang@unisoc.com>
Subject: [PATCH] f2fs: use new ioprio Macro to get ckpt thread ioprio data
Date: Fri, 31 May 2024 17:10:45 +0800
Message-ID: <1717146645-18829-1-git-send-email-zhiguo.niu@unisoc.com>
X-Mailer: git-send-email 1.9.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: SHCAS03.spreadtrum.com (10.0.1.207) To
 BJMBX02.spreadtrum.com (10.0.64.8)
X-MAIL:SHSQR01.spreadtrum.com 44V9B080041893

Use new Macro IOPRIO_PRIO_LEVEL to get ckpt thread ioprio data(level),
it is more accurate and consisten with the way setting ckpt thread
ioprio(IOPRIO_PRIO_VALUE(class, data)).

Signed-off-by: Zhiguo Niu <zhiguo.niu@unisoc.com>
---
 fs/f2fs/sysfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/f2fs/sysfs.c b/fs/f2fs/sysfs.c
index 72676c5..55d46da 100644
--- a/fs/f2fs/sysfs.c
+++ b/fs/f2fs/sysfs.c
@@ -340,7 +340,7 @@ static ssize_t f2fs_sbi_show(struct f2fs_attr *a,
 	if (!strcmp(a->attr.name, "ckpt_thread_ioprio")) {
 		struct ckpt_req_control *cprc = &sbi->cprc_info;
 		int class = IOPRIO_PRIO_CLASS(cprc->ckpt_thread_ioprio);
-		int data = IOPRIO_PRIO_DATA(cprc->ckpt_thread_ioprio);
+		int data = IOPRIO_PRIO_LEVEL(cprc->ckpt_thread_ioprio);
 
 		if (class != IOPRIO_CLASS_RT && class != IOPRIO_CLASS_BE)
 			return -EINVAL;
-- 
1.9.1


