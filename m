Return-Path: <linux-kernel+bounces-175874-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 838A28C2683
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 16:15:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B56151C20D3E
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 14:15:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3233212DD93;
	Fri, 10 May 2024 14:15:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="ZZwFCyJV"
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BF5816EC0B
	for <linux-kernel@vger.kernel.org>; Fri, 10 May 2024 14:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.145.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715350525; cv=none; b=qJ0lq04vrD6+yjVer2MfTl8LP5bI+ma0GPoVk11pxg0s3DDYzonNN4dRjUxg51Z60v3DIYoPSbxzxVpyyfd+0cUD+rHr2lwRqcVy/oYCDwYHdY/l9kwyA1vvCSP5M9fNBV2zuB5zE/B7gd8iTX5GM26wS7A4Xgo3uBsIkMEr+os=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715350525; c=relaxed/simple;
	bh=Nq4HIfkNCerf+mgvCrnFqmakKaJLJNkaKiinm4/ynHE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ldaHQnItAjpwoh18ysHBhQXK8JCgZDUWcF3V1cjEQFt4YzKZhTkQejr8tQEhBXynr1ml/uMGTzbG9J1Nnzo/KWZjd4R9QJdc6YmOo5I81PTFEbdCmRxVNu36YiTdc8EYk/COtd129KuPDR8rnGm/aU9ZU5AtWC7mZ8ha+jbTgDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=ZZwFCyJV; arc=none smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 44A0Pv84003998
	for <linux-kernel@vger.kernel.org>; Fri, 10 May 2024 07:15:23 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=s2048-2021-q4;
 bh=pJiOW9sE/PxdcId7oxzz3zrqGCgVWqbLvPZXlyFVYsk=;
 b=ZZwFCyJVSVrD2aR2quQHmmPAwgEWW0b524hLtu6Tt2VbokYnsqwbYO8Nb0MT6r8k8R6a
 GEYLQJFDdEo/jk/5lvPSKt01sUBenVEQ9N7rgJ4Nk78shtW2sIc/RhmEd2AsI66cjj0q
 1lkCJVNTAPZ7t9YBslQuRu4nQitSpAmjxuLTq9+r3Rc7XoH/i0wFjXM3ZKOkCzwwtJs9
 PEBeIZQfPi40NA+bcm2T7TVTr3UMKGI1EB2jhxkuAMzIGVli/IXs/W4/17Pr6QGt6y8j
 uKwv8hWQ7obg6jgxHpheq7IVXsLQ1Od10kgfnP5qvzeQDdmuiddgQ61RU/3ZboexRMAx VA== 
Received: from mail.thefacebook.com ([163.114.132.120])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3y16pwbkpw-15
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 10 May 2024 07:15:22 -0700
Received: from twshared19845.02.ash8.facebook.com (2620:10d:c085:108::150d) by
 mail.thefacebook.com (2620:10d:c085:21d::8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 10 May 2024 07:15:10 -0700
Received: by devbig032.nao3.facebook.com (Postfix, from userid 544533)
	id 7BF682633F51; Fri, 10 May 2024 07:15:06 -0700 (PDT)
From: Keith Busch <kbusch@meta.com>
To: <linux-nvme@lists.infradead.org>, <linux-kernel@vger.kernel.org>
CC: <hch@lst.de>, <tglx@linutronix.de>, <ming.lei@redhat.com>,
        Keith Busch
	<kbusch@kernel.org>
Subject: [PATCH 1/2] genirq/affinity: remove rsvd check against minvec
Date: Fri, 10 May 2024 07:14:58 -0700
Message-ID: <20240510141459.3207725-1-kbusch@meta.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: qDskdO2yiMR8Pb9eK6aYr2t-boa-l_qH
X-Proofpoint-ORIG-GUID: qDskdO2yiMR8Pb9eK6aYr2t-boa-l_qH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-10_10,2024-05-10_02,2023-05-22_02

From: Keith Busch <kbusch@kernel.org>

The reserved vectors are just the desired vectors that don't need to be
managed.

Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 kernel/irq/affinity.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/kernel/irq/affinity.c b/kernel/irq/affinity.c
index 44a4eba80315c..74b7cccb51a16 100644
--- a/kernel/irq/affinity.c
+++ b/kernel/irq/affinity.c
@@ -113,9 +113,6 @@ unsigned int irq_calc_affinity_vectors(unsigned int m=
invec, unsigned int maxvec,
 	unsigned int resv =3D affd->pre_vectors + affd->post_vectors;
 	unsigned int set_vecs;
=20
-	if (resv > minvec)
-		return 0;
-
 	if (affd->calc_sets) {
 		set_vecs =3D maxvec - resv;
 	} else {
--=20
2.43.0


