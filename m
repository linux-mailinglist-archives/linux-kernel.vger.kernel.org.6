Return-Path: <linux-kernel+bounces-272695-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A370C946008
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 17:15:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5FBC9284300
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 15:15:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23DC22101B6;
	Fri,  2 Aug 2024 15:15:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="wousDlC4"
Received: from pv50p00im-tydg10021701.me.com (pv50p00im-tydg10021701.me.com [17.58.6.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30E111E505
	for <linux-kernel@vger.kernel.org>; Fri,  2 Aug 2024 15:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.58.6.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722611738; cv=none; b=jiNzqTi3VF6zVoKE3xrs3IS61VBRzmRJmNkwzrNCFEvJ0e09qbuuNXBjmmxUUFFJ+/HYW2KQ+eKX2QtN6D9fe9+cXxb5StLdQua2dus0/oyKRTpN9IHSlM3/shuVCx9c77CKH6NMrZhuPTLcsoqpzw7iELVGo7Sn/NWrRt3wL0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722611738; c=relaxed/simple;
	bh=iDqYMyds3l/rw+YZ3Y8gUb2pc9zLCcVm25sVWrFQTcE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=NEjfIrWBwqBmsPDwBRAzf54/QXPPRFdkq8HUAeFlUEDIyzRpjsBJ65hykU+H5D7T9jMMFHidIlN4U23e3nwbQw9Bqp7LoyQtK8r9fF+NZH7gBRTYinUocAeOTdEua/T4DIRAkwuam1LRQBmnByMaLiuiQUXLCw7Ez6Ya1tLksrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=wousDlC4; arc=none smtp.client-ip=17.58.6.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; t=1722611735;
	bh=LW7O3t6eR4bD/ctY46Os0i6msApACQ6Vz8uHe+UsPKQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To;
	b=wousDlC4nudHWqmWiaDWuDs2ink9/GGmbMI+BFCRpNnbylXgO72viPiz2msVLcAB4
	 Q81xJi/vAKbY4wdNb30zY7m9UgXHBVVwGD0vIezIj+HDQBN0rteQY8ejezNrhrWzqq
	 jfRJP+iSFHqB6Drs6e9SbmduK0mBPhSEBitmrP+Ce816j6TGFyYdTCuVllnplVo/nW
	 TnHGMfI1/MrVpss1765a3Zst4iBAItVN7HzrU7LlF117h5ZUavzUqbGeK1gvEsz6/2
	 Pb+JJ6g7RujmPhmORabFnZf3wCBH/lTaPtdiXscXunKr3wFmBZGlVCbPakmDoPdJTz
	 mzqUZwovAnHNA==
Received: from [192.168.1.26] (pv50p00im-dlb-asmtp-mailmevip.me.com [17.56.9.10])
	by pv50p00im-tydg10021701.me.com (Postfix) with ESMTPSA id 1E51A3A118D;
	Fri,  2 Aug 2024 15:15:30 +0000 (UTC)
From: Zijun Hu <zijun_hu@icloud.com>
Date: Fri, 02 Aug 2024 23:15:15 +0800
Subject: [PATCH] linux/container_of.h: Remove redundant type cast in
 container_of_const()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240802-container_of_const_fix-v1-1-90e7a5b624f9@quicinc.com>
X-B4-Tracking: v=1; b=H4sIAAL4rGYC/x3MQQqAIBCF4avErBNMAq2rRIjpWLPR0IhAuntDy
 ++H9xpULIQV5q5BwZsq5cQY+g784dKOggIblFSjNFIJn9PlKGGxOVpGvWykRxiNPmx62Nwkgcd
 nQc7/8bK+7weqm2TYaAAAAA==
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jason Gunthorpe <jgg@ziepe.ca>, 
 Sakari Ailus <sakari.ailus@linux.intel.com>, 
 "Matthew Wilcox (Oracle)" <willy@infradead.org>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Zijun Hu <zijun_hu@icloud.com>, 
 linux-kernel@vger.kernel.org, Zijun Hu <quic_zijuhu@quicinc.com>
X-Mailer: b4 0.14.1
X-Proofpoint-GUID: LdTH7tCN29nB1zynYv3mgRwb3HP7Qj4W
X-Proofpoint-ORIG-GUID: LdTH7tCN29nB1zynYv3mgRwb3HP7Qj4W
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-02_11,2024-08-02_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 adultscore=0
 clxscore=1011 bulkscore=0 mlxscore=0 suspectscore=0 malwarescore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2408020105
X-Apple-Remote-Links: v=1;h=KCk=;charset=UTF-8

From: Zijun Hu <quic_zijuhu@quicinc.com>

Remove redundant (type *) cast for default branch in container_of_const()
since the cast has been done by container_of().

Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
---
 include/linux/container_of.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/container_of.h b/include/linux/container_of.h
index 713890c867be..c36435e7c7f2 100644
--- a/include/linux/container_of.h
+++ b/include/linux/container_of.h
@@ -32,7 +32,7 @@
 #define container_of_const(ptr, type, member)				\
 	_Generic(ptr,							\
 		const typeof(*(ptr)) *: ((const type *)container_of(ptr, type, member)),\
-		default: ((type *)container_of(ptr, type, member))	\
+		default: container_of(ptr, type, member)	\
 	)
 
 #endif	/* _LINUX_CONTAINER_OF_H */

---
base-commit: 8400291e289ee6b2bf9779ff1c83a291501f017b
change-id: 20240802-container_of_const_fix-87ecdb71ba90

Best regards,
-- 
Zijun Hu <quic_zijuhu@quicinc.com>


