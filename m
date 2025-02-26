Return-Path: <linux-kernel+bounces-535001-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1439DA46DB1
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 22:40:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ACB773A9F18
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 21:40:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 214E4263C9E;
	Wed, 26 Feb 2025 21:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="EhJ+rQ5g"
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0CED20DD7A
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 21:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.153.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740605973; cv=none; b=UYzIFJtB4jgUpOaB+tUuuqhyL5gypXrOBKgAJkhW7YtQMhGQi+O2gRodDaBVh3dM1BzM9Z0d27mYZS1YkROWa1Rmz2e2y+7jOEo2SPwCXrCxpPLVLODPaAe4FQge2dzn3rSOFmwgmumU5XTIKz5sVGANM/sw/v6jya7DvMxjExE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740605973; c=relaxed/simple;
	bh=QrmEP8tN0yyZl54302laf2o0i1y0v20R661+ErCqyqE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fY1lYIuXSrXw/lPJ31fDM2VA6VLGrGLQ1gIJhUZ4okMJjMVAmtUVu3+0/rAKdaDEq5G3yM5b4OYz4bAwCUeHHMztcv617icggwHYh1/cC7t3d+zWvKEhL7CfSCQU50pQs6/7N5jdGbOuXjAioPLFPDIQ9Onw7A511OV2fLU4CSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=EhJ+rQ5g; arc=none smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51QKcd8a011226
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 13:39:30 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2021-q4;
	 bh=6QWMRWFJaMkolJ4N5fn/a7XdpweKZa/QIaMY7SwUwCE=; b=EhJ+rQ5gnA22
	LPjCW3FVCVOMYRKkT8w6EINOcbZO2B++l2lp1qwEq18MH8Dbp0mNAASd790R/86m
	5+BDX8Wu4McTHfEwdGQWTOssNXUmeIY5SnWPYUBjsQrb8U7MhrMr11R7zp17HVe+
	ViGB+0HL1JA1rYNpZGTI+lW4T6FR7zzUuqUWGPguNxCnZMC71CAaRUdBldwKacJm
	c9JxXoHIY1WOfXcUMetvPH+ACcCodqvTiLzV9L1oOL6n44jAFMEyXxsqv8DIp7TJ
	5nqChHZmU/bt7e/OjCRx8q6VsOZ5Q3ZtbSv5jGGZI7+Dd1xnCVJTjEP2x3wLZ8RA
	lh7k6PZGKA==
Received: from maileast.thefacebook.com ([163.114.135.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 45257gu7am-4
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 13:39:30 -0800 (PST)
Received: from twshared11082.06.ash8.facebook.com (2620:10d:c0a8:1b::30) by
 mail.thefacebook.com (2620:10d:c0a9:6f::237c) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1544.14; Wed, 26 Feb 2025 21:38:48 +0000
Received: by devbig638.nha1.facebook.com (Postfix, from userid 544533)
	id 32A80187DD500; Wed, 26 Feb 2025 13:38:45 -0800 (PST)
From: Keith Busch <kbusch@meta.com>
To: <pbonzini@redhat.com>, <seanjc@google.com>, <kvm@vger.kernel.org>
CC: <x86@kernel.org>, <virtualization@lists.linux.dev>,
        <linux-kernel@vger.kernel.org>, Keith Busch <kbusch@kernel.org>
Subject: [PATCHv2 1/2] vhost: return task creation error instead of NULL
Date: Wed, 26 Feb 2025 13:38:43 -0800
Message-ID: <20250226213844.3826821-2-kbusch@meta.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250226213844.3826821-1-kbusch@meta.com>
References: <20250226213844.3826821-1-kbusch@meta.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: 3bKkHc11QqpxgssWmWqANtGLxx3xRbfO
X-Proofpoint-ORIG-GUID: 3bKkHc11QqpxgssWmWqANtGLxx3xRbfO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-26_06,2025-02-26_01,2024-11-22_01

From: Keith Busch <kbusch@kernel.org>

Lets callers distinguish why the vhost task creation failed. No one
currently cares why it failed, so no runtime change from this patch, but
that will not be the case for long.

Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 arch/x86/kvm/mmu/mmu.c | 2 +-
 drivers/vhost/vhost.c  | 2 +-
 kernel/vhost_task.c    | 4 ++--
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index d4ac4a1f8b81b..18ca1ea6dc240 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -7471,7 +7471,7 @@ static void kvm_mmu_start_lpage_recovery(struct onc=
e *once)
 				      kvm_nx_huge_page_recovery_worker_kill,
 				      kvm, "kvm-nx-lpage-recovery");
=20
-	if (!nx_thread)
+	if (IS_ERR(nx_thread))
 		return;
=20
 	vhost_task_start(nx_thread);
diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
index 9ac25d08f473e..61dd19c7f99f1 100644
--- a/drivers/vhost/vhost.c
+++ b/drivers/vhost/vhost.c
@@ -666,7 +666,7 @@ static struct vhost_worker *vhost_worker_create(struc=
t vhost_dev *dev)
=20
 	vtsk =3D vhost_task_create(vhost_run_work_list, vhost_worker_killed,
 				 worker, name);
-	if (!vtsk)
+	if (!IS_ERR(vtsk))
 		goto free_worker;
=20
 	mutex_init(&worker->mutex);
diff --git a/kernel/vhost_task.c b/kernel/vhost_task.c
index 8800f5acc0071..2ef2e1b800916 100644
--- a/kernel/vhost_task.c
+++ b/kernel/vhost_task.c
@@ -133,7 +133,7 @@ struct vhost_task *vhost_task_create(bool (*fn)(void =
*),
=20
 	vtsk =3D kzalloc(sizeof(*vtsk), GFP_KERNEL);
 	if (!vtsk)
-		return NULL;
+		return ERR_PTR(-ENOMEM);
 	init_completion(&vtsk->exited);
 	mutex_init(&vtsk->exit_mutex);
 	vtsk->data =3D arg;
@@ -145,7 +145,7 @@ struct vhost_task *vhost_task_create(bool (*fn)(void =
*),
 	tsk =3D copy_process(NULL, 0, NUMA_NO_NODE, &args);
 	if (IS_ERR(tsk)) {
 		kfree(vtsk);
-		return NULL;
+		return ERR_PTR(PTR_ERR(tsk));
 	}
=20
 	vtsk->task =3D tsk;
--=20
2.43.5


