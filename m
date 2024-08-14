Return-Path: <linux-kernel+bounces-286862-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D5452951FB8
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 18:22:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 146531C21752
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 16:22:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBF931BD513;
	Wed, 14 Aug 2024 16:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="EArQVfEA"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0DB71BB6BE
	for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 16:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723652419; cv=none; b=dBWq/D7HvpZ0Dr9yYkiu+qk5/VJbikKNn96Pj74sGFjA+C1WROFZV+WJC5C1B/Pzyag0Asuo7J+TAjBHqZ7kUDAoA/WuK07FLx5rzHOvKA+e42XiFkAPUEVNVw9fojpBcaOFphWqG5QWIcRBTu1Nx7ReSbT9P6jzBcp1C8GPA3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723652419; c=relaxed/simple;
	bh=wpmXDNJ3XFsaj0UIiM0xGdgM6jcaDtVuyKzuHIEAWz4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LKi8dhzwXvOyMxOp+fCFKo2t9AZgmmK9q3pWVflPqpk1Sn+H8NUStqtDb4pRCYQwWmVQ1mwCzQ79kWRkaIMupvAY45GmxGNU+nE0oneWJZrYBVYhV851Piy9g4FYweG5L60/jxkL2apvK9xGZhoo/QJjdFUc0286sOKKi2yzARI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=EArQVfEA; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47EBtcGx006145;
	Wed, 14 Aug 2024 16:19:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding; s=corp-2023-11-20; bh=F
	6//Jvlc/D0rvk43vXh/wiNs1SFnxWF+1gX4poKKCEk=; b=EArQVfEALrEoJo2oM
	TigFy7GcqqR6qe/rMjdeX7uZtN/u7IthiZ/k8iyweor+C8RN1oPFzzHv0MMJADfC
	QWbmKxp28rUv1lxJ0Xlaiyact4Xd73fcE1F3U/9HR9/nQnuZWQkH7kTdgSJYZvUE
	yI/3VXYIneYdxAeFtcgCjXEcB0B5zcH7Gyo3fYcyo2kBt0czoCKx7g+hnH55jBiE
	PIotWrUKfJwt0UDN54h+s3wPWlXsewI5GDbsNIUF8HySb5xLllmfXhUzAtea73VP
	+AYbc80574IrKeizuPa4TXJOQFWUG+dMGHzC45bg1BexChT4FQXhVnz85ssELssf
	o/Kwg==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 40wy4bgub2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 14 Aug 2024 16:19:54 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 47EFePwq020583;
	Wed, 14 Aug 2024 16:19:53 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 40wxngn7ng-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 14 Aug 2024 16:19:53 +0000
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 47EGIvC8035951;
	Wed, 14 Aug 2024 16:19:52 GMT
Received: from sidkumar-mac.us.oracle.com (dhcp-10-65-174-212.vpn.oracle.com [10.65.174.212])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 40wxngn7gt-7;
	Wed, 14 Aug 2024 16:19:52 +0000
From: Sidhartha Kumar <sidhartha.kumar@oracle.com>
To: linux-kernel@vger.kernel.org, maple-tree@lists.infradead.org
Cc: linux-mm@kvack.org, akpm@linux-foundation.org, liam.howlett@oracle.com,
        willy@infradead.org, surenb@google.com,
        Sidhartha Kumar <sidhartha.kumar@oracle.com>
Subject: [PATCH v4 06/17] maple_tree: preallocate nodes in mas_erase()
Date: Wed, 14 Aug 2024 12:19:33 -0400
Message-ID: <20240814161944.55347-7-sidhartha.kumar@oracle.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240814161944.55347-1-sidhartha.kumar@oracle.com>
References: <20240814161944.55347-1-sidhartha.kumar@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-14_12,2024-08-13_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 bulkscore=0
 phishscore=0 malwarescore=0 suspectscore=0 spamscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2408140111
X-Proofpoint-GUID: 4IOsR78Mk9VBiSAdzsFvMZEOU7qiZRxQ
X-Proofpoint-ORIG-GUID: 4IOsR78Mk9VBiSAdzsFvMZEOU7qiZRxQ

Use mas_wr_preallocate() in mas_erase() to preallocate enough nodes to
complete the erase. Add error handling by skipping the store if the
preallocation lead to some error besides no memory.

Signed-off-by: Sidhartha Kumar <sidhartha.kumar@oracle.com>
---
 lib/maple_tree.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/lib/maple_tree.c b/lib/maple_tree.c
index 58985107cf00..8ba52ffa778e 100644
--- a/lib/maple_tree.c
+++ b/lib/maple_tree.c
@@ -6371,14 +6371,18 @@ void *mas_erase(struct ma_state *mas)
 
 	/* Must reset to ensure spanning writes of last slot are detected */
 	mas_reset(mas);
-	mas_wr_store_setup(&wr_mas);
-	mas_wr_store_entry(&wr_mas);
+	mas_wr_preallocate(&wr_mas, NULL);
 	if (mas_nomem(mas, GFP_KERNEL)) {
 		/* in case the range of entry changed when unlocked */
 		mas->index = mas->last = index;
 		goto write_retry;
 	}
 
+	if (mas_is_err(mas))
+		goto out;
+
+	mas_wr_store_entry(&wr_mas);
+out:
 	mas_destroy(mas);
 	return entry;
 }
-- 
2.46.0


