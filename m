Return-Path: <linux-kernel+bounces-247046-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A2AC992CA41
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 07:51:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 58A8B2824F1
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 05:51:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E93EB41C92;
	Wed, 10 Jul 2024 05:51:32 +0000 (UTC)
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 712EEA47
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 05:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720590692; cv=none; b=FhE/teBx6C3Wts8JznQiaWXBjujmS+aqowwjR+OCRCduzZyq5Ma+xTQC2+d4xCX4OZpnI9GvnbKZk5br4zM4APprgYWJW+EGPS0RD+48sc9Ocxp8qt/VO+Zs+HBoWN7ZQ1mblvBGTrc5i/PEKOdA9EBTUQPMuUs5/LXIyumUqFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720590692; c=relaxed/simple;
	bh=qJAAyECMg5CnLOBtWJVgn/vwuKboRSLGFE96LMa/3sU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jvta+o9QxdcrIRD9Qh3ZwYA1x7Vk+WrDZ84y7PJnsval5wvWfpTZ8mB+rDziRXvKU/hSIJ4QVDBOwDBFhGGMUGT2Awz7PVpJ32wlMxl/uuVHLoSsilhuM1iJzYsEX0ZOaxi2ZA9F+nHadcB2/Ghudt4A/QJjZ0OE0XEiVvkc+jE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: b0c1c9063e7f11ef93f4611109254879-20240710
X-CID-CACHE: Type:Local,Time:202407101339+08,HitQuantity:1
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.38,REQID:f2f0c3ad-8855-4a6d-a8e9-82744da539f0,IP:0,U
	RL:0,TC:0,Content:0,EDM:25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:25
X-CID-META: VersionHash:82c5f88,CLOUDID:b8788c9dc47839bc094a2b215019a1db,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:5,IP:nil,URL:0,
	File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:N
	O,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: b0c1c9063e7f11ef93f4611109254879-20240710
Received: from node4.com.cn [(10.44.16.170)] by mailgw.kylinos.cn
	(envelope-from <jianghaoran@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 594430874; Wed, 10 Jul 2024 13:46:01 +0800
Received: from node4.com.cn (localhost [127.0.0.1])
	by node4.com.cn (NSMail) with SMTP id A97891600208E;
	Wed, 10 Jul 2024 13:46:01 +0800 (CST)
X-ns-mid: postfix-668E2019-6054441873
Received: from jhr-TianYi510S-07IMB.. (unknown [172.30.60.215])
	by node4.com.cn (NSMail) with ESMTPA id BD4EB1600208E;
	Wed, 10 Jul 2024 05:45:59 +0000 (UTC)
From: Haoran Jang <jianghaoran@kylinos.cn>
To: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org,
	lstoakes@gmail.com,
	vbabka@suse.cz,
	Liam.Howlett@oracle.com,
	akpm@linux-foundation.org,
	Haoran Jiang <jianghaoran@kylinos.cn>
Subject: [PATCH] mm/mmap: Align the length parameter of munmap with hugepage size
Date: Wed, 10 Jul 2024 13:45:58 +0800
Message-ID: <20240710054558.1959243-1-jianghaoran@kylinos.cn>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Haoran Jiang <jianghaoran@kylinos.cn>

munmap hugepge mappings, if the length of the range to munmap
is not aligned with hugepage size,munmap will fail.
In the hugetlb_vm_op_split function, an error will be returned
if startaddr+len is not hugepage size aligned.

before this patch:
in "tools/testing/selftests/mm/hugepage-mremap.c"
modify DEFAULT_LENGTH_MB to 3M,compile and run,
the following error message is displayed

-------------------------
running ./hugepage-mremap
-------------------------
TAP version 13
1..1
Map haddr: Returned address is 0x7eaa40000000
Map daddr: Returned address is 0x7daa40000000
Map vaddr: Returned address is 0x7faa40000000
Address returned by mmap() =3D 0x7cb34b000000
Mremap: Returned address is 0x7faa40000000
First hex is 0
First hex is 3020100
Bail out! mremap: Expected failure, but call succeeded

Signed-off-by: Haoran Jiang <jianghaoran@kylinos.cn>
---
 mm/mmap.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index 83b4682ec85c..0b3a60bf9b6f 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -2733,7 +2733,15 @@ int do_vmi_munmap(struct vma_iterator *vmi, struct=
 mm_struct *mm,
 	if ((offset_in_page(start)) || start > TASK_SIZE || len > TASK_SIZE-sta=
rt)
 		return -EINVAL;
=20
-	end =3D start + PAGE_ALIGN(len);
+	vma =3D find_vma(mm, start);
+	if (!vma) {
+		if (unlock)
+			mmap_write_unlock(mm);
+		return 0;
+	}
+
+	end =3D start + ALIGN(len, vma_kernel_pagesize(vma));
+
 	if (end =3D=3D start)
 		return -EINVAL;
=20
--=20
2.43.0


