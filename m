Return-Path: <linux-kernel+bounces-416636-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 67DB39D4818
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 08:14:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 122881F225AB
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 07:14:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02CF31C6F54;
	Thu, 21 Nov 2024 07:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="dNwr26Ff"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DCFD154429
	for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2024 07:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732173277; cv=none; b=Ja0UBKE3vGbkrBI4nCAVdSGnzcr5gSCxNTVQ4rVKtRnu7HZ+IVeWtnI28vgI0YEMdSd3GoZu5DX6DgIGNvWAvSu0gFdzjZQAOQD2bN2bn7+FNpvq4CSAkOHRw/zbgYQb+lpC14NfudtpFHsTZvJ6AyFGwc8mc6xZkCjRhv59HnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732173277; c=relaxed/simple;
	bh=8fpyFT9/RSyKrItJmq/Nu84UV0A9mXxvs3TrZGT5WfI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=g/n44Zv3CdO08RW4V0uQSiKiX1MYWiSN86fKebBtaqi7JVceApCGJfRBChCSCrTdzGrWklvLTpGfv3QU8VH5qVbAqux1yUld/VQWzb6nnUkK16cggVYKZDRm0gseEmkz6LAq6Tj6azJ2t9Wt7ppytajER+pSJmYYmWx+4MklpJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=dNwr26Ff; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AKJs94p007659;
	Thu, 21 Nov 2024 07:14:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=rwkeTCE6wxoh+m+b9esUz6
	Hwk3y1XE+cMvORNr1yusM=; b=dNwr26FfybYG50tlGUcmZzbd/ZXhk58mB3WUy9
	wbANdxn9NPNaD8pSPeLR5Tfm/9+ecCbKckgVRieNffDyFekS4DWKCTo34MwJXazy
	pvkVdKuDKl1PAnU4Bzxl6W1L1bmBu5ISNsMPcxGA9aB/Lbv/qgzfzt5yCRu3HV7c
	gpHzaTJBcoJ6+qjQVt/Q3h/JFr+bHX8maHOBWSKbgY5lPYuOkuMWSrwlUbAF+Wi/
	WXWkXX065FkaukN2cgJ9YcsZOASBEP24hpBvRX4rAk6K29KClYAjDL+xJgaAYrxc
	4k9V+tn4DBOMAMqMdjmna7UL22L9sHTBHJs4W1vG1JmsoWrQ==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4318uvkjbn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 21 Nov 2024 07:14:16 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4AL7EF0a002516
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 21 Nov 2024 07:14:15 GMT
Received: from ap-kernel-sh01-lnx.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Wed, 20 Nov 2024 23:14:12 -0800
From: Zhenhua Huang <quic_zhenhuah@quicinc.com>
To: <catalin.marinas@arm.com>, <will@kernel.org>, <ardb@kernel.org>,
        <ryan.roberts@arm.com>, <mark.rutland@arm.com>, <joey.gouly@arm.com>,
        <dave.hansen@linux.intel.com>, <akpm@linux-foundation.org>,
        <chenfeiyang@loongson.cn>, <chenhuacai@kernel.org>
CC: <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        Zhenhua Huang <quic_zhenhuah@quicinc.com>
Subject: [PATCH 0/2] Fix subsection vmemmap_populate logic
Date: Thu, 21 Nov 2024 15:12:54 +0800
Message-ID: <20241121071256.487220-1-quic_zhenhuah@quicinc.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: VyNJfjpTkUBAUF4wCGCCAYxv21QuovWx
X-Proofpoint-GUID: VyNJfjpTkUBAUF4wCGCCAYxv21QuovWx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 bulkscore=0
 priorityscore=1501 phishscore=0 adultscore=0 malwarescore=0 mlxscore=0
 lowpriorityscore=0 mlxlogscore=772 spamscore=0 suspectscore=0
 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411210054

To perform memory hotplug operations, the memmap (aka struct page) will be
updated. For arm64 with 4K page size, the typical granularity is 128M,
which corresponds to a 2M memmap buffer.
Commit 2045a3b8911b ("mm/sparse-vmemmap: generalise vmemmap_populate_hugepages()")
optimizes this 2M buffer to be mapped with PMD huge pages. However,
commit ba72b4c8cf60 ("mm/sparsemem: support sub-section hotplug")
which supports 2M subsection hotplug granularity, causes other issues
(refer to the change log of patch #1). The logic is adjusted to populate
with huge pages only if the hotplug address/size is section-aligned.

Zhenhua Huang (2):
  arm64: mm: vmemmap populate to page level if not section aligned
  arm64: mm: implement vmemmap_check_pmd for arm64

 arch/arm64/mm/mmu.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

-- 
2.25.1


