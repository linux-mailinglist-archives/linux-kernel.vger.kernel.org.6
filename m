Return-Path: <linux-kernel+bounces-306553-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 310ED964068
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 11:41:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DBB3928194B
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 09:41:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DDE818FC93;
	Thu, 29 Aug 2024 09:39:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="VXYyxIys"
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CE1218FDA5
	for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 09:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724924366; cv=none; b=H+mnpeepy1WDT9Grx8NKWtCd8x76jRPblC6uReCeTBJ+KU3cySdUKEZ6Vq4aopS0cvv7TNFv6T6BaJj7UK1X2EcK8URy+MfLq8pD0q6RVDIjtl1TPr391h633oZjnxwIbm1fTCWeRG92oSngrYau/xjLZ0CLQFZXmdDA+KKaIzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724924366; c=relaxed/simple;
	bh=mPEgUwqXJ+dLMm0555Ct6+WFU/Cz4/yQ7cT5iaJEEXE=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:References; b=P7aSJqP7WZSaGi7Co/2YGjc2HN4bzgs/KxQiAGBxgw0PL8Pgz47ADQ0P2M8FTUKrE/PnQz1uAIhwUXp3WiSR9ktOc29zQwBxIMbnufqRrdkXgaMwUWonB7ef33XUxdJsNZHU9PKclto1JbDAqTe7D2at29Yxe13srOzCheuKPnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=VXYyxIys; arc=none smtp.client-ip=203.254.224.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
	by mailout3.samsung.com (KnoxPortal) with ESMTP id 20240829093921epoutp03db35132e02443e32ae1ac0e5f382b817~wKZFJk69n0443304433epoutp03M
	for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 09:39:21 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20240829093921epoutp03db35132e02443e32ae1ac0e5f382b817~wKZFJk69n0443304433epoutp03M
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1724924361;
	bh=GZRN+8ZynbevAb3kkWyb73pK4GPrzyCiUbupj7z9a7Q=;
	h=From:To:Cc:Subject:Date:References:From;
	b=VXYyxIyswHqhpsrMVIBPxbyNenM7F4alERcnsi9S/rSsOGi1TFIjM15ugJ7l8UnZw
	 XbljEtYd8Q1EH9Ufes4syYrAPnKvYfArEqUhdO2vv1MWuTriqVM9+aHysOdFcw14Eq
	 bnV0Lp3qQQnC6yfyVGCzJgqcz5j2QC/jJsDGM9lo=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
	epcas1p4.samsung.com (KnoxPortal) with ESMTP id
	20240829093920epcas1p4120a49f57f2f0f8a529955adbca34e73~wKZEk3TuM0337203372epcas1p4S;
	Thu, 29 Aug 2024 09:39:20 +0000 (GMT)
Received: from epsmgec1p1.samsung.com (unknown [182.195.38.243]) by
	epsnrtp1.localdomain (Postfix) with ESMTP id 4WvbpJ3v3Wz4x9Pv; Thu, 29 Aug
	2024 09:39:20 +0000 (GMT)
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
	epsmgec1p1.samsung.com (Symantec Messaging Gateway) with SMTP id
	93.C4.08992.8C140D66; Thu, 29 Aug 2024 18:39:20 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20240829093920epcas1p1cf45ac0cd7d4ed8cf39ff5f1d1b4fe00~wKZEBz55X2152721527epcas1p1V;
	Thu, 29 Aug 2024 09:39:20 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20240829093920epsmtrp10c5e4f30ba25b718b9f3ef5263e1e95b~wKZEA5Lr32611826118epsmtrp1x;
	Thu, 29 Aug 2024 09:39:20 +0000 (GMT)
X-AuditID: b6c32a33-96dfa70000002320-4f-66d041c87b90
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
	43.8B.08456.7C140D66; Thu, 29 Aug 2024 18:39:19 +0900 (KST)
Received: from localhost.localdomain (unknown [10.253.98.171]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20240829093919epsmtip25f86e920d8cfa8dbce588cc615df2238~wKZDshxHy1298212982epsmtip2j;
	Thu, 29 Aug 2024 09:39:19 +0000 (GMT)
From: Seunghwan Baek <sh8267.baek@samsung.com>
To: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
	martin.petersen@oracle.com, James.Bottomley@HansenPartnership.com,
	bvanassche@acm.org, avri.altman@wdc.com, alim.akhtar@samsung.com
Cc: grant.jung@samsung.com, jt77.jang@samsung.com, junwoo80.lee@samsung.com,
	dh0421.hwang@samsung.com, jangsub.yi@samsung.com, sh043.lee@samsung.com,
	cw9316.lee@samsung.com, sh8267.baek@samsung.com, wkon.kim@samsung.com
Subject: [PATCH v1 0/1] Set SDEV_OFFLINE when ufs shutdown.
Date: Thu, 29 Aug 2024 18:39:12 +0900
Message-Id: <20240829093913.6282-1-sh8267.baek@samsung.com>
X-Mailer: git-send-email 2.17.1
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrKKsWRmVeSWpSXmKPExsWy7bCmvu4JxwtpBos7ZSwezNvGZvHy51U2
	i2kffjJbzDjVxmqx79pJdotff9ezW2zs57Do2DqZyWLH8zPsFrv+NjNZXN41h82i+/oONovl
	x/8xWTT92cdice3MCVaLzZe+sTgIeFy+4u0xbdIpNo+PT2+xePRtWcXo8XmTnEf7gW6mALao
	bJuM1MSU1CKF1Lzk/JTMvHRbJe/geOd4UzMDQ11DSwtzJYW8xNxUWyUXnwBdt8wcoLOVFMoS
	c0qBQgGJxcVK+nY2RfmlJakKGfnFJbZKqQUpOQVmBXrFibnFpXnpenmpJVaGBgZGpkCFCdkZ
	m3vmshZMYKp4d2MNWwPjNcYuRg4OCQETid6dyV2MXBxCAjsYJfav/8QK4XxilPi/9xwjhPON
	UaJp4nHmLkZOsI4vfY/YIBJ7GSX6rr5ignA+M0r8bjnGBlLFJqAn8ar9MFiViMBRRolb2x6A
	zWIWuA+05eAfRpAqYQFriUsrtrCBXMIioCpxel84SJgXKHx/00cWiHXyEqs3HGAG6ZUQ+Mou
	8fveLKiEi8SuEwegbGGJV8e3sEPYUhIv+9ug7GKJhRsnsUA0tzBKXF8OsVhCwF6iubUZbDGz
	gKbE+l36IGFmAT6Jd197WCEhwyvR0SYEUa0qcWrDVqhOaYnrzQ2sELaHxLn/c8BWCQnEShza
	vpJ9AqPMLIShCxgZVzGKpRYU56anJhsWGMKjJjk/dxMjOP1pGe9gvDz/n94hRiYOxkOMEhzM
	SiK8J46fTRPiTUmsrEotyo8vKs1JLT7EaAoMo4nMUqLJ+cAEnFcSb2hiaWBiZmRiYWxpbKYk
	znvmSlmqkEB6YklqdmpqQWoRTB8TB6dUA9P0/4+a+i9M7tt35k37NXb/9teMDUYH39zb4v00
	ddK3esEsc4YdqyZP83M2n/PkgPukZ5X/U96vX8vorNe79WNKwbPPi528VQN/OJVeNvkV8CV7
	vsSnayvt3I+wf39ocW7+Yx5Pln8q2V/q2IQs8jmY3lzq2bxDYMOMXw8Mj7SZWdqqi5Vxtp2b
	uuXLXbNmpe1RM+POea4uEBT591nrabi+5ZfejRNvrlkQELXmwpYJuVOqSitXfFcVlnV+f/9s
	yOLViyp+KmSlmhRO1qxOCz+fLuw+2cwuwUfwX6ePjJmo98xKzbDQxq5YzrfhB528bCSLPr19
	w7TVbUY5051j78K2dx3fPaNv7j3H9GzHb9OVWIozEg21mIuKEwFPISTvCAQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrLLMWRmVeSWpSXmKPExsWy7bCSvO5xxwtpBls2mVo8mLeNzeLlz6ts
	FtM+/GS2mHGqjdVi37WT7Ba//q5nt9jYz2HRsXUyk8WO52fYLXb9bWayuLxrDptF9/UdbBbL
	j/9jsmj6s4/F4tqZE6wWmy99Y3EQ8Lh8xdtj2qRTbB4fn95i8ejbsorR4/MmOY/2A91MAWxR
	XDYpqTmZZalF+nYJXBmbe+ayFkxgqnh3Yw1bA+M1xi5GTg4JAROJL32P2LoYuTiEBHYzSvya
	3cMEkZCWeHzgJVARB5AtLHH4cDFEzUdGiYXfIJrZBPQkXrUfZgOxRQTOMkocnVgAYjMLvGaU
	6LoQAWILC1hLXFqxhQ1kDouAqsTpfeEgYV6g8P1NH1kgVslLrN5wgHkCI88CRoZVjJKpBcW5
	6bnFhgVGeanlesWJucWleel6yfm5mxjBIaqltYNxz6oPeocYmTgYDzFKcDArifCeOH42TYg3
	JbGyKrUoP76oNCe1+BCjNAeLkjjvt9e9KUIC6YklqdmpqQWpRTBZJg5OqQamaR73Oe6UqfvV
	+sQ35Dw6OcFUue5tYvmr2vzN4lJFd74HHz7IcvqJnJjalH2Fr8yXJq5PPxAYu+TO7qYkoxez
	78ef+nRDeb7S/+y0W9Wa1hyGS3JKpnQucJbW2DF5XcdVjqtflkiIF8ySfPd+ynFx/kiPG+KF
	sUenLfftL9JeE2gqa63+7Urol6dGu2If9Pyo0Ds1vdyodpuZ5DrZuNXebYUHFY5N63hy80m5
	ybfkvb/KJ/z7vkhe+5/7qt2Kj1p+fymOLmqP877pOMHNP/3J7ojq3OfbXNw3TdFS0ZA9EePx
	cVWVgHXgaYMr31fdTJZ7yKV67IaFw+OW526/ZTR4arWDYjWlu1UWmN3+/3GGEktxRqKhFnNR
	cSIAJNBEEMACAAA=
X-CMS-MailID: 20240829093920epcas1p1cf45ac0cd7d4ed8cf39ff5f1d1b4fe00
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240829093920epcas1p1cf45ac0cd7d4ed8cf39ff5f1d1b4fe00
References: <CGME20240829093920epcas1p1cf45ac0cd7d4ed8cf39ff5f1d1b4fe00@epcas1p1.samsung.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

When ufs shutdown, set SDEV_OFFLINE instead of SDEV_QUIESCE for all lus
except device wlun.

Seunghwan Baek (1):
  ufs: core: set SDEV_OFFLINE when ufs shutdown.

 drivers/ufs/core/ufshcd.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

-- 
2.17.1


