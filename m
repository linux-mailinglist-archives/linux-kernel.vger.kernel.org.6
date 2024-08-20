Return-Path: <linux-kernel+bounces-293933-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F22729586AD
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 14:15:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AEEE3282030
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 12:15:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C933F18FDBA;
	Tue, 20 Aug 2024 12:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="duOGKV0i"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81A1418C014;
	Tue, 20 Aug 2024 12:15:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724156134; cv=none; b=ov9gQtGltlD8FV7xKKq0WjoTFxUxkXWE2v5ms+F3XaCMLVE1cFppl2rXHoXnMbSj9VuFC/loTlg6PbvSsgm8YPYAuJaZR5tpgcBjL19pYfy583i4PkpEFaYvreW2d1K9cf/sipWtQLt52nsvxU3L3RAUTklJ4+vjCUecmqQb10c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724156134; c=relaxed/simple;
	bh=QH5c3NuhwizcJBe68p55a13P6p0ggigL3dsCF2BspwU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ShGOlmYThhCJANmS+c6Egwsxd9RL1DfuxIuLq3aa9KfVKnyyPLKWXTby5KrEnS5GH/h/8Se9AOhnF18zAQcoglsWdOrhwKpsFqvqwfOD9tIP8XeCLS92BgsFMExsSk3h2sXG4rOI6bjbXYOwD/FsYry+uaOOgjb5SFIGbuYDyok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=duOGKV0i; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47K72r6Q022736;
	Tue, 20 Aug 2024 12:15:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=EudIPUzh6TaSFlWzs9Fh9d
	xgTheI7QSqwJSMWY/Ngxc=; b=duOGKV0ircaT5b299A9+i1eyBxqDYmj918TwnA
	HmqFdRMCjDhSRSlGqp3p6lHfYdTVc9L7HYUbl/yU9S0TI/I0+y7PhVSldds6ymQ2
	h2F5ckb2ZkB3WA+zz2pVrafFxnCnfLZIldEgsvhLmQz+UgT9qh/gb7NZz/wJ2zEj
	Q97oq+zWS5JiBczNnm2VDd1i3Anc0PUNQVV2eH0Bq2No6R2eYYl7ByoGT0YsNqB3
	Y7OkPoPI1v8Y+GJUrpn+sKasljGAkwdFrQ+rGtBX9dKd74hr0OaX/z5SyZTOjglD
	HEtKflchkEOfu294/X7PNGkm4A4Pggc0qdGNr2qhP2QDu39A==
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 414pdm8xed-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 20 Aug 2024 12:15:28 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 47KCFKWU009324
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 20 Aug 2024 12:15:20 GMT
Received: from zhonhan-gv.qualcomm.com (10.80.80.8) by
 nasanex01c.na.qualcomm.com (10.45.79.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Tue, 20 Aug 2024 05:15:18 -0700
From: Zhongqiu Han <quic_zhonhan@quicinc.com>
To: <Thinh.Nguyen@synopsys.com>, <gregkh@linuxfoundation.org>,
        <mathias.nyman@intel.com>
CC: <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <quic_zhonhan@quicinc.com>
Subject: [PATCH 0/2] usb: Call cpu_relax() when polling registers
Date: Tue, 20 Aug 2024 20:14:59 +0800
Message-ID: <20240820121501.3593245-1-quic_zhonhan@quicinc.com>
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
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: JUhxY_dHm463WsXoiUlcodfpkFpjR1xP
X-Proofpoint-ORIG-GUID: JUhxY_dHm463WsXoiUlcodfpkFpjR1xP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-20_09,2024-08-19_03,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=273 spamscore=0
 suspectscore=0 malwarescore=0 phishscore=0 priorityscore=1501 mlxscore=0
 impostorscore=0 bulkscore=0 lowpriorityscore=0 adultscore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2407110000
 definitions=main-2408200091

This series adds cpu_relax() in registers polling busy loops and
it is a well-known idiom in the kernel.

Signed-off-by: Zhongqiu Han <quic_zhonhan@quicinc.com>
---
Zhongqiu Han (2):
  usb: dwc3: core: Call cpu_relax() in registers polling busy loops
  usb: xhci: ext-caps: Use cpu_relax() when polling registers

 drivers/usb/dwc3/core.c          | 2 ++
 drivers/usb/host/xhci-ext-caps.h | 2 ++
 2 files changed, 4 insertions(+)


base-commit: 469f1bad3c1c6e268059f78c0eec7e9552b3894c
-- 
2.25.1


