Return-Path: <linux-kernel+bounces-211822-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5982B90576F
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 17:52:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 80E651C20E6E
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 15:52:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2345180A81;
	Wed, 12 Jun 2024 15:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="hV7y+HxN"
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 964FF146017
	for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 15:52:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.153.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718207524; cv=none; b=KAJtnTSCnfAWQEgh3x5Dvw4qizKe9XMrMLrkNhne9pXgG5uUSlzv6BrxZXGsHy4LHXpPsBe/++7v1MTFLKcjNPVMFD2tUnoEd7+vyLnrl10c8BfLTDnZ4D6rZ+dOEln6Sv70TOnNoo0wzk3510ihsfdvKjI0TSgDTMXZcfOsZ3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718207524; c=relaxed/simple;
	bh=N86oabt2fKTMO2uOL8z7pPMGu8O/KQBt+1LpSMDdwSo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MEPGmysitEr5yZ0hCF4bY3wTnlbmVN6MvpaegC1s7SaMaBJEnRZBBAA3F8SuByjxK82I7N3AXkZZqAox6brMJDGO5QUwD911NVwNl76KD4bLVbTdrn/e/thvLkW0eG5sRMypE5mH1+MORwikH0jc+x38D67ezhT4xD/xY1hg4+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=hV7y+HxN; arc=none smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
	by m0089730.ppops.net (8.17.1.19/8.17.1.19) with ESMTP id 45CFbEQ6024314
	for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 08:52:01 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc :
 content-transfer-encoding : content-type : date : from : in-reply-to :
 message-id : mime-version : references : subject : to; s=s2048-2021-q4;
 bh=Dp9jB3/zWqEW0lejCiauS6edrezGeGq1zpJr+Kx+fZI=;
 b=hV7y+HxNxvW3yl2z+NBnGRGgju03oovha427d0bVPLpvulwd7Dpxq4Z/NgoozRYJOvcR
 +Xt/4MxiTMlgoUXQAI1wFf+hX0TZ371I6GFpGXgXZYDPeqsTqNJsqQCuXrjkUtZbEZLZ
 66KEAGqPhDNDAwHI9Nc2QZmCkD7ILOwWNOvnsnuhKhv38YElYtKTzpjV6iuJ5CQZsYmc
 hSAus7BVC9RGLNJGgiUuanNri6MFatJb0TvpMAwnG0w+pslM1+mt45/+f+d6xKPDcJnc
 HxL7cuBYW+KevdR72T9866U/2E5/zvlZetAbPFaqIFQgjRNh8Wm42FYboUK1oU0mTctk Dg== 
Received: from maileast.thefacebook.com ([163.114.130.16])
	by m0089730.ppops.net (PPS) with ESMTPS id 3yqefm836f-6
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 08:52:01 -0700
Received: from twshared26916.05.ash9.facebook.com (2620:10d:c0a8:1b::2d) by
 mail.thefacebook.com (2620:10d:c0a9:6f::8fd4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1544.11; Wed, 12 Jun 2024 15:51:58 +0000
Received: by devbig638.nha1.facebook.com (Postfix, from userid 544533)
	id 06B8FF5EA646; Wed, 12 Jun 2024 08:51:47 -0700 (PDT)
From: Keith Busch <kbusch@meta.com>
To: <linux-nvme@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <linux-kselftest@vger.kernel.org>
CC: <hch@lst.de>, <sagi@grimberg.me>, <paulmck@kernel.org>,
        <davidgow@google.com>, <akpm@linux-foundation.org>,
        <venkat88@linux.vnet.ibm.com>, Keith Busch <kbusch@kernel.org>
Subject: [PATCH 2/2] nvme: fix namespace removal list
Date: Wed, 12 Jun 2024 08:51:35 -0700
Message-ID: <20240612155135.3060667-2-kbusch@meta.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240612155135.3060667-1-kbusch@meta.com>
References: <20240612155135.3060667-1-kbusch@meta.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: qeSLCxNhe5c5qv8wtUvzILNfGT1BH2aF
X-Proofpoint-ORIG-GUID: qeSLCxNhe5c5qv8wtUvzILNfGT1BH2aF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-12_08,2024-06-12_02,2024-05-17_01

From: Keith Busch <kbusch@kernel.org>

This function wants to move a subset of a list from an element to the
end to another list, so do that with the new list_cut helper instead of
using the wrong list splice.

Fixes: be647e2c76b27f4 ("nvme: use srcu for iterating namespace list")
Reported-by: Venkat Rao Bagalkote <venkat88@linux.vnet.ibm.com>
Tested-by: Venkat Rao Bagalkote <venkat88@linux.vnet.ibm.com>
Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 drivers/nvme/host/core.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index f5d150c62955d..30fec15872b3d 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -3959,9 +3959,10 @@ static void nvme_remove_invalid_namespaces(struct =
nvme_ctrl *ctrl,
=20
 	mutex_lock(&ctrl->namespaces_lock);
 	list_for_each_entry_safe(ns, next, &ctrl->namespaces, list) {
-		if (ns->head->ns_id > nsid)
-			list_splice_init_rcu(&ns->list, &rm_list,
-					     synchronize_rcu);
+		if (ns->head->ns_id > nsid) {
+			list_cut(&rm_list, &ctrl->namespaces, &ns->list);
+			break;
+		}
 	}
 	mutex_unlock(&ctrl->namespaces_lock);
 	synchronize_srcu(&ctrl->srcu);
--=20
2.43.0


