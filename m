Return-Path: <linux-kernel+bounces-437259-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D9F059E90F4
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 11:51:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D1815164216
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 10:51:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2ED7B218E84;
	Mon,  9 Dec 2024 10:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="C0SyphQF"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0791521770F
	for <linux-kernel@vger.kernel.org>; Mon,  9 Dec 2024 10:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733741423; cv=none; b=u0pmj4/jKlTDsX6GUIh1eduJmpJ74QM0L9BTQQFLWqpvap/jAAyaNrGQerLPBvl1ZMPsOW6MTGT17hgX1X4WWHXTkeoNmBxMTWy0Irt4qpMZRnFwR4jl5FFOsxphyc+HWOW2Iyfdf3uYuXF+2/OFCpyPCN7OwRmeRJOOLbGoxYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733741423; c=relaxed/simple;
	bh=Al1nYJcI+WH60uOcfQJpnPEsLD/SNuVV0FT8A72aZh8=;
	h=Message-ID:Date:MIME-Version:To:CC:From:Subject:Content-Type; b=umopLJHAffMEeB1FWz/jI3EW4igrN0ZijBnsMSzPxF4BW35m8cGV0Lu7aAkkQryAbBl0xMJTotFBvgUErvuAcPIQtVhIo25CwhrwI2MUY5brpT0GEKxjeo2RE5uv+JiONuMjNTEXinfZmtfxVSOJsaOhei61ftksjP0lK5TZhjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=C0SyphQF; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B9AP99G024521;
	Mon, 9 Dec 2024 10:50:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=DQHDERoIpTVNFdTrNfwzhA
	S6rWPsfyTUVsAC0tG+skQ=; b=C0SyphQFvKEUzcErdoVb4MAVnqc4eltzISRguW
	u4FTbjkcpZYMKcIDa+AkPF6q1U2cNeCLMJWyt/WyGxukHLfs9NDu6TRUTNfLrJwJ
	oMS7q2jgCIhB5vD49RnSiD1f0dtl1h6wp7AAWnCMTWAA0C6fc9J4u8spFEG6UhJd
	p0MTkERm3MCf+5Iuu36VKJB9t81L1Dx7vMii3LW2MfuJHR8huSkd+C+Snnb8p1ma
	vPW2cZfiVFaLMJPdp93M9t8Vb8B6aGxmk8LzD7ybcQFcLYUnT0qgUsa8qmjSmU3X
	enzkPoXQYOFtBQQLlNLEn1QmzkRZnPQmVpwKLmwATxavKYmw==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 43cc2ecj6d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 09 Dec 2024 10:50:10 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4B9Ao9Cq030892
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 9 Dec 2024 10:50:09 GMT
Received: from [10.231.195.67] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 9 Dec 2024
 02:50:07 -0800
Message-ID: <64931fac-085b-4ff3-9314-84bac2fa9bdb@quicinc.com>
Date: Mon, 9 Dec 2024 18:50:06 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>,
        Marek Szyprowski
	<m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>
CC: linux-kernel <linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>
From: Baochen Qiang <quic_bqiang@quicinc.com>
Subject: missing clear bdr in check_ram_in_range_map()?
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: A1FLghzP3KIX_hPr8jPVNA5yMhoGy0YP
X-Proofpoint-GUID: A1FLghzP3KIX_hPr8jPVNA5yMhoGy0YP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxscore=0
 mlxlogscore=752 priorityscore=1501 impostorscore=0 lowpriorityscore=0
 adultscore=0 malwarescore=0 clxscore=1011 suspectscore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412090084

Hi,

while checking check_ram_in_range_map() I am confused by the condition set/check on bdr.
If I am reading the code correctly, if bdr is set once, it would never get cleared, hence
that function will always returns 0.

should we clear bdr before each new iteration?

diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
index 5b4e6d3bf7bc..1605b956b25e 100644
--- a/kernel/dma/direct.c
+++ b/kernel/dma/direct.c
@@ -611,6 +611,7 @@ static int check_ram_in_range_map(unsigned long start_pfn,
                        return 1;

                start_pfn = PFN_DOWN(bdr->cpu_start) + PFN_DOWN(bdr->size);
+               bdr = NULL;
        }

        return 0;


