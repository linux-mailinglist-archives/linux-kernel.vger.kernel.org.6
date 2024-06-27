Return-Path: <linux-kernel+bounces-232550-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F404491AADB
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 17:14:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AC32028663B
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 15:14:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D84ED19884D;
	Thu, 27 Jun 2024 15:14:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="fJh/dX8Q"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 374AE770F9
	for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2024 15:14:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719501283; cv=none; b=iAcqUeEYp4Pf1yeV5WOx0mWyf/Ct+qNH8yqwXoE49wikBQAP4yZ37bOxUxDjEduoKUdMEbtEzts3w2hj+et9wbQwgd8JvX2BPkOcLXxo0rFcb1sDOsiKfMDtBULG1eW3T32ke0lM3bZTD25rRYjWBHpE6NmZtHqwGptGtd7EBdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719501283; c=relaxed/simple;
	bh=TJ0hLCAPt6oS7swx8wRwtpJ+VVj0vUCHH1pmIssurpw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TBeA+Z/mmHeQcMT4KN2zDJ3hJGUXHBvdY7kX+oz+DiKzAPCcyb9dK1tIGflnfl/FOtnKDb1HDYNuE/XDVJwuzlHwh5EqRk2jgE1gl0K9DV9mqmQTzm06wpwRqCB5zCq31jIashMex17GHlaerHgQzvBIJYDiQALOmMb/qt1jtEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=fJh/dX8Q; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45RF47r2016202;
	Thu, 27 Jun 2024 15:14:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
	:to:cc:subject:date:message-id:content-transfer-encoding
	:mime-version; s=pp1; bh=QdDAGtNIksLN3TSRjQF5b124MTmCkp/A2KggmGZ
	7GMg=; b=fJh/dX8Q9Ev6D/vqCzAquaaGq8jkLtilqYZSa/3ak5sSOX595fJgICm
	LQGBtJw1VU01Kil5fnv0OxF9tTmWifT8ttu2YKLhj4Dv6B5sO40XDLZHcIFeISod
	u3dRPfd8NmBJsmu8g82wnWuPpTZJ4EjiYxTXaha2gy5Cq+RRwcGRKfaxbehlh7to
	e50bVXu4dydtmDBz4xghBvswtO5CKWdCLxECWd7MeI2RVNcy7sPQTo/VDOwgZRdU
	ZJ4dYpDICR7j1LfSuPZLOal/2j+uvGy57Ygb6v0txTvP59fOJTdGmYoyd/S4NXA6
	xTn23ENGYwG1JxwXnPyw1p69Tyk2hyA==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 401909r9fc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 27 Jun 2024 15:14:35 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 45RFEYQY031080;
	Thu, 27 Jun 2024 15:14:34 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 401909r9f8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 27 Jun 2024 15:14:34 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 45REMfW1008184;
	Thu, 27 Jun 2024 14:58:01 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3yx9b13fdy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 27 Jun 2024 14:58:01 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 45REvvDD55509334
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 27 Jun 2024 14:57:59 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 62E992004D;
	Thu, 27 Jun 2024 14:57:57 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D34A82004B;
	Thu, 27 Jun 2024 14:57:56 +0000 (GMT)
Received: from heavy.ibm.com (unknown [9.171.10.182])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 27 Jun 2024 14:57:56 +0000 (GMT)
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Alexander Potapenko <glider@google.com>, Marco Elver <elver@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc: kasan-dev@googlegroups.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH 0/2] kmsan: fix sparse warnings
Date: Thu, 27 Jun 2024 16:57:45 +0200
Message-ID: <20240627145754.27333-1-iii@linux.ibm.com>
X-Mailer: git-send-email 2.45.2
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: y6p9zJc1wjXWp-Ja6k75xUtEZP9K9CNK
X-Proofpoint-GUID: ON2OLEdnX9O3qYUGjGa9cm7TJjNipMIl
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-27_11,2024-06-27_03,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 phishscore=0
 bulkscore=0 mlxlogscore=483 lowpriorityscore=0 priorityscore=1501
 malwarescore=0 suspectscore=0 spamscore=0 impostorscore=0 clxscore=1015
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2406270113

Hi,

Kernel test robot reported several sparse warnings in the KMSAN code
base [1].  They belong to two broad classes; fix each in a separate
commit.

Best regards,
Ilya

[1] https://lore.kernel.org/linux-mm/202406272033.KejtfLkw-lkp@intel.com/

Ilya Leoshkevich (2):
  kmsan: add missing __user tags
  kmsan: do not pass NULL pointers as 0

 mm/kmsan/core.c            |  4 ++--
 mm/kmsan/hooks.c           | 15 ++++++++-------
 mm/kmsan/instrumentation.c |  4 ++--
 mm/kmsan/kmsan.h           |  6 +++---
 mm/kmsan/report.c          |  2 +-
 5 files changed, 16 insertions(+), 15 deletions(-)

-- 
2.45.2


