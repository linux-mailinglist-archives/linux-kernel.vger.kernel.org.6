Return-Path: <linux-kernel+bounces-281212-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 910D694D462
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 18:17:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4601E1F22BB8
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 16:17:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 621521990A7;
	Fri,  9 Aug 2024 16:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="Cg6Q9Z5K"
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EED631990A3
	for <linux-kernel@vger.kernel.org>; Fri,  9 Aug 2024 16:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.153.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723219908; cv=none; b=F4zWt2VCRcvPnHuUVODd8m5qFprp9UCTtYj8ksFsmYK+VvsyJ5ourbRH8vnfTXDHjzmITj7VJ7e6AU3nt6nGIupx0S71ril29PH3yq1jtYeoJl81qJWmGDvzc+Wm7BheAg1vGsYlwoT7VvKZoVz/CHlJI3tvtId0xysjbii7e9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723219908; c=relaxed/simple;
	bh=2XhSFfV/KJdDAk67Pffeuo1pxjjaJ23oOWzQQ7nv1aE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=GjfRGs1mx7B3C6EAh3ZbRdD60UbZFPOUgkG808hX5CXDTyouGMJZIgzLw47r/TaSH6Tnp6aC38DzbcBhdPJcg2e7i0zWhc4GlIABks4JFOTxmrjs9PxG9E8wjftHJKiT8VPH4vFOFkzNDa07rPidJ4ouXZ3jES70aD5R8w7ASEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fb.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b=Cg6Q9Z5K; arc=none smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fb.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
	by m0089730.ppops.net (8.18.1.2/8.18.1.2) with ESMTP id 479E32AA026386
	for <linux-kernel@vger.kernel.org>; Fri, 9 Aug 2024 09:11:45 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from
	:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=facebook; bh=NmjoYanE
	bhJeq7UYSr3Cu4n8C4nNNjc9xp238NFfOSU=; b=Cg6Q9Z5KJ0wZQ+Z7N9wCjtPR
	gfwY+bCbXvRFVYwh2DeQGm59SAaAw6K8DKL6qhhcrZ12Y7hW0UN2xHVo4d1F8NSt
	v1ZeRyt77NDa0aS0IQIGnEyTSeUmydOqxzyXwSOTN8TrVWqtDvCiTXAoCuJu7Qjw
	wiHW0gX+9bDWNyIYtgg=
Received: from mail.thefacebook.com ([163.114.134.16])
	by m0089730.ppops.net (PPS) with ESMTPS id 40wmhh0x2m-15
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 09 Aug 2024 09:11:45 -0700 (PDT)
Received: from twshared28432.07.ash9.facebook.com (2620:10d:c085:108::150d) by
 mail.thefacebook.com (2620:10d:c08b:78::2ac9) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1544.11; Fri, 9 Aug 2024 16:11:44 +0000
Received: by devbig276.nha1.facebook.com (Postfix, from userid 660015)
	id 4D3375420950; Fri,  9 Aug 2024 17:11:35 +0100 (BST)
From: Mark Harmstone <maharmstone@fb.com>
To: <linux-kernel@vger.kernel.org>
CC: Mark Harmstone <maharmstone@fb.com>
Subject: [PATCH] include/linux/log2.h: mark is_power_of_2 __always_inline
Date: Fri, 9 Aug 2024 17:11:12 +0100
Message-ID: <20240809161132.660566-1-maharmstone@fb.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: T6VEKLA4pdgZQ2D5XWguUo8BB-0S9xPK
X-Proofpoint-GUID: T6VEKLA4pdgZQ2D5XWguUo8BB-0S9xPK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-09_12,2024-08-07_01,2024-05-17_01

For debugging purposes, it would be useful to be able to compile the whol=
e
kernel with -fno-inline. Unfortunately BUILD_BUG_ON statements with
is_power_of_2 prevent this from working, as the condition needs to be
evaluable at compile-time. Marking is_power_of_2 as __always_inline,
rather than just normal inline, fixes this.

Signed-off-by: Mark Harmstone <maharmstone@fb.com>
---
 include/linux/log2.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/log2.h b/include/linux/log2.h
index 9f30d087a128..1366cb688a6d 100644
--- a/include/linux/log2.h
+++ b/include/linux/log2.h
@@ -41,7 +41,7 @@ int __ilog2_u64(u64 n)
  * *not* considered a power of two.
  * Return: true if @n is a power of 2, otherwise false.
  */
-static inline __attribute__((const))
+static __always_inline __attribute__((const))
 bool is_power_of_2(unsigned long n)
 {
 	return (n !=3D 0 && ((n & (n - 1)) =3D=3D 0));
--=20
2.44.2


