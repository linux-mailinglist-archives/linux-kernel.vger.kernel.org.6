Return-Path: <linux-kernel+bounces-437087-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 452CE9E8EF4
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 10:43:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 45DE3162100
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 09:43:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02604216385;
	Mon,  9 Dec 2024 09:43:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="CVJ7DvfT"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03439215F65
	for <linux-kernel@vger.kernel.org>; Mon,  9 Dec 2024 09:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733737393; cv=none; b=jQygF2988HBU3RKjBHKe7uzdypTeNY/+6NxijJLSiJEe44E2qK76LjYmB0s7+Nf5jeNAijNOq555Il9MBAzmQ0KdOuPtloWqSAoVd2aRBZbZOSiG6Lr+ONF+jrdTLTLWFlFmnRzeWVV+n1gHdBfU8QC8yO2STUVgIvx3o5UhckM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733737393; c=relaxed/simple;
	bh=P+kRVDrMatcDU8zlzJ4oHYyXHcRXCUWcggpAglhLF5E=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=q1ktl5hZh1Iq1tm8+gxwSwSWWMS5HC5egwcSh+HdJxXn+U7iDabH0dyjOaeLEpqdPMsqiWObvSiEkC97ONfT/nxt+bWU1zJ+h+fT76A0MKxsXSrOvdZJl+0AnMCc83a1zln9AogUIj0dosd9Fou2jtFTRqoAnTV5VicgVS3HRro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=CVJ7DvfT; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B8Natjq022156;
	Mon, 9 Dec 2024 09:42:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=TBBcsGnUIismUG5M3WVT1h
	0rVoJD1839Z45T+RuqpKw=; b=CVJ7DvfT6Dp13Puxxnt1Wt1JjVCmPH5If7Go2H
	sh/hLV/2SX6GieDsDwjJjy8meIn/lLAZmi/1KsEd7dgsTscyjx3ruyc4Loy/WBEt
	pb39er6NqWaMiRjBeIo45W7EXtZfZJWCAa+rfTd/MNBxmeSN5lLhTOrkwVbKbfdy
	XNJPTwFeEp7e8boBYNDC1DLgPDvh++sEqgrD4maln7GOpujHbYxWCL1HvP3+z+hz
	D6OeZu6lf1Df2x59YbGN7kNAkiQ0fCyh9WW+l6qucxi+AR5INMiOltN7jrMmJni4
	Isi0vj+l5Jx3+uT8JJVEGikfj0mjgjxS/f+nGpr3oVIIhWUA==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 43cdpgm6hm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 09 Dec 2024 09:42:52 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4B99gpr6021596
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 9 Dec 2024 09:42:51 GMT
Received: from ap-kernel-sh01-lnx.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Mon, 9 Dec 2024 01:42:48 -0800
From: Zhenhua Huang <quic_zhenhuah@quicinc.com>
To: <catalin.marinas@arm.com>, <will@kernel.org>, <ardb@kernel.org>,
        <ryan.roberts@arm.com>, <mark.rutland@arm.com>, <joey.gouly@arm.com>,
        <dave.hansen@linux.intel.com>, <akpm@linux-foundation.org>,
        <chenfeiyang@loongson.cn>, <chenhuacai@kernel.org>
CC: <linux-mm@kvack.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Zhenhua Huang <quic_zhenhuah@quicinc.com>
Subject: [PATCH v2 0/2] Fix subsection vmemmap_populate logic
Date: Mon, 9 Dec 2024 17:42:25 +0800
Message-ID: <20241209094227.1529977-1-quic_zhenhuah@quicinc.com>
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
X-Proofpoint-GUID: cdWhVh-WYovZf2n086SfZ1G6qeakYZGR
X-Proofpoint-ORIG-GUID: cdWhVh-WYovZf2n086SfZ1G6qeakYZGR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 adultscore=0 clxscore=1011 suspectscore=0 mlxscore=0 priorityscore=1501
 phishscore=0 mlxlogscore=757 spamscore=0 malwarescore=0 bulkscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412090075

To perform memory hotplug operations, the memmap (aka struct page) will be
updated. For arm64 with 4K page size, the typical granularity is 128M,
which corresponds to a 2M memmap buffer.
Commit c1cc1552616d ("arm64: MMU initialisation")
optimizes this 2M buffer to be mapped with one single PMD entry. However,
commit ba72b4c8cf60 ("mm/sparsemem: support sub-section hotplug")
which supports 2M subsection hotplug granularity, causes other issues
(refer to the change log of patch #1). The logic is adjusted to populate
with huge pages only if the hotplug address/size is section-aligned.

Changes since v1:
  - Modified change log to make it more clear which was based on Catalin's
    comments.

Zhenhua Huang (2):
  arm64: mm: vmemmap populate to page level if not section aligned
  arm64: mm: implement vmemmap_check_pmd for arm64

 arch/arm64/mm/mmu.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

-- 
2.25.1


