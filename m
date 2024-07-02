Return-Path: <linux-kernel+bounces-237968-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8748E924167
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 16:53:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2E6F2289506
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 14:52:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 895E61BA086;
	Tue,  2 Jul 2024 14:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="RkfVjZi+"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40DE376F17
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jul 2024 14:52:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719931968; cv=none; b=YnzWEfH34VBuMuT26QzCWLUfCdSAeam0x7DK01h+8ifL4LPXuCyaLHVXtTRYv9rEmzLbUfepyd9qzwNxUBxZMnah0hd1eKWKMgV1iIXT8nu6DWVSPxMePa+6et2nMwIYkxpBT+lM3eLMiKEq6suTHLkfR0UBQ+A4kKDdewz/CiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719931968; c=relaxed/simple;
	bh=tSHE8RfYTZrZObSZ4n3dnw1aB2inwmeuzWy8iMcpFKQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=uJmWhx3uICGzuhlTl5EUNoA7vnQHcpdvdteBbjlHP7Y1+/Ag02V1FY3q5fp5zWT5WlVMInpkrFy4FmGZcOrNQTwYfkCtGmUjJORuN3PDi+l9UFQQ/0AI21AiJInqslmGp1BU7X8wAvfr/Hwf9Z/SDVjy9VeYRyz6P/rp05JRCKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=RkfVjZi+; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 462CT5iA024745;
	Tue, 2 Jul 2024 14:52:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-type:date:from:message-id:mime-version:subject:to; s=
	qcppdkim1; bh=Z9nVYaCB7u2uXCVnEetCnG1dSqVjA0GOCHKXm9Nchnw=; b=Rk
	fVjZi+AAxTUvQLYJTsHeJTmzRmxtxb1S6yOcEt2BeloSF3X99Eg7ntZlwVqlpXnx
	wsip5K5AXqdwwLzA/4IYXpai2Y/mqONLb7eewrPvtlivy/q1Tw6slskYRetf+NO8
	gQnPG2oZGHEm/zmMUbedDFr+dWz6fB9nS9G/rVvgQ2VNA822nSIIr4ffyu8csk6H
	fxXoqbVj8iXwau46AHqLHm5h49UroeZ6anAmSEoYgqpAMGG+NQLdcSdpPH+WAHHs
	szJwElet6cI9DIIXcBTkDLAStr5TjTFXZJ7MpKMOKKpfgBYuicGWj4ZrvyhZIPCG
	dpjfBY5CW/V+UOfp0UTg==
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 40297rrqfs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 02 Jul 2024 14:52:38 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA04.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 462EqbdW022757
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 2 Jul 2024 14:52:37 GMT
Received: from zijuhu-gv.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Tue, 2 Jul 2024 07:52:36 -0700
From: Zijun Hu <quic_zijuhu@quicinc.com>
To: <linux-kernel@vger.kernel.org>
CC: <gregkh@linuxfoundation.org>, <rafael@kernel.org>, <brgl@bgdev.pl>,
        <madalin.bucur@nxp.com>, <davem@davemloft.net>,
        <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 0/5] Collection of my bug fixes and code optimizations for devres
Date: Tue, 2 Jul 2024 22:51:49 +0800
Message-ID: <1719931914-19035-1-git-send-email-quic_zijuhu@quicinc.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: ZRXE4ONug4mvKgMDagh8NzfMF_iDlMH6
X-Proofpoint-GUID: ZRXE4ONug4mvKgMDagh8NzfMF_iDlMH6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-02_10,2024-07-02_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxlogscore=820
 lowpriorityscore=0 clxscore=1015 mlxscore=0 suspectscore=0 spamscore=0
 adultscore=0 impostorscore=0 malwarescore=0 priorityscore=1501
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2407020110

This patch series is to collect all of my recent patches for devres. These
patches were sent separately for different bug fixes or code optimizations
but none of them have been merged yet. Therefore, I would like to collect
them together in order to manage them more easily.

Zijun Hu (5):
  devres: Fix devm_krealloc() wasting memory
  devres: Fix memory leakage caused by driver API devm_free_percpu()
  devres: Initialize an uninitialized struct member
  devres: Simplify devm_percpu_match() implementation
  devres: Correct code style for functions that return a pointer type

 drivers/base/devres.c | 39 +++++++++++++++++++++++----------------
 1 file changed, 23 insertions(+), 16 deletions(-)


base-commit: 6b521fc111a2ad5ead39776960d3d2d289ce0722
-- 
2.34.1


