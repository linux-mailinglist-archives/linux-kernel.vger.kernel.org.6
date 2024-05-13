Return-Path: <linux-kernel+bounces-178033-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E88CB8C47AC
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 21:39:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A3ED8285E36
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 19:39:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 796067E76F;
	Mon, 13 May 2024 19:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="IbB6uTSl"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69B50768F0
	for <linux-kernel@vger.kernel.org>; Mon, 13 May 2024 19:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715629106; cv=none; b=XMMBfBE4/wRthtVlAAt3vgROqP8ebW/kDCqvT7VhpcW7etEcr5T73gNpY7fCA1S/yS7eD7rH1JkQF1CWhDmbMQmu1joHF1ajInM3MHsSkNTw1V18/gYdPtyoV5IXre+yUppodOdf5vKIr4GNIF/m4E7Nc23a//3cimsnVr7zAdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715629106; c=relaxed/simple;
	bh=+K5Q1pErdVhW5WpaNo9MJ5nj0B7sVzb+xBEQ/WVwXAw=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type:To:CC; b=dkxelklqW17Yek1fqRwOqOMgmpBaC6Cv2PXEaPyoWMueDdOeKaIqrnnPHuTmp3s1mQnMD+PvRIQkL+c58MRsS3nW/jSvGKP4tUnSrSTxjai4ese9yFNWKRtLOwdZ97Kyq9Pw1LTw4tszO9V2GoDZ7dN9kArdO/LF+LyWsKrpgOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=IbB6uTSl; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44DJ8f9U028204;
	Mon, 13 May 2024 19:38:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:subject:date:message-id:mime-version:content-type
	:content-transfer-encoding:to:cc; s=qcppdkim1; bh=bFyFaa/NQXCcTp
	URCq6Gc7kDIXa680HCq1Qyl3U6MHo=; b=IbB6uTSlUkT8rb92G/05/iu8DBJL7d
	t8at++dL5PNKVP6AEY6UmBgWNil/I/odlgLWl73inqPnpiamZAl4kAPOKeV0eoqg
	zaWfwlCvyS4tVwzlQT5wtPnLuKKRJ3xa+rkySwfv5wBdLDerwhjN2gCC8i0vHmA8
	kyy9OofNWNd1utLZ9pQnttiGkDdV0I4WCQbdDAHF0FijaUMJ6rnUh8DNn3wx54H0
	UC1LK3iWwzJv6Ffgg78JAabpK2bbESGOUpxl7ByGGu0yDGQlTSwvD9m9nnghT1qL
	ZzgITY5dDj20tgwtsBOhCUP2IstrmYppbi6U38S2/QIpxluTmXOH9Q6w==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3y1yp5cfa7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 13 May 2024 19:38:04 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 44DJc247026805
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 13 May 2024 19:38:02 GMT
Received: from [169.254.0.1] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 13 May
 2024 12:38:02 -0700
From: Jeff Johnson <quic_jjohnson@quicinc.com>
Subject: [PATCH 0/4] mm: add missing MODULE_DESCRIPTION() macros
Date: Mon, 13 May 2024 12:37:37 -0700
Message-ID: <20240513-mm-md-v1-0-8c20e7d26842@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAJsQmYC/x3MQQqDQAyF4atI1g3oqKBepXSRcVINONOSqAji3
 Z12+cH/3gnGKmwwFCco72LySRnVo4BxpjQxSsgGV7qmbKsaY8QYsPfBt65h6qmD3H6V33L8f56
 vbE/G6JXSOP/Wi6TtwEi2ssJ13f5/iul2AAAA
To: Miaohe Lin <linmiaohe@huawei.com>,
        Naoya Horiguchi
	<nao.horiguchi@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>, Dmitry Vyukov <dvyukov@google.com>,
        Minchan Kim <minchan@kernel.org>,
        "Sergey
 Senozhatsky" <senozhatsky@chromium.org>
CC: <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <kasan-dev@googlegroups.com>, Jeff Johnson <quic_jjohnson@quicinc.com>
X-Mailer: b4 0.13.0
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: uKwSFenHOLiW_NjIv5wDDoqkhrTJ3KjA
X-Proofpoint-ORIG-GUID: uKwSFenHOLiW_NjIv5wDDoqkhrTJ3KjA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-13_14,2024-05-10_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 impostorscore=0 bulkscore=0 suspectscore=0 clxscore=1011
 lowpriorityscore=0 spamscore=0 malwarescore=0 phishscore=0 adultscore=0
 mlxlogscore=804 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405010000 definitions=main-2405130131

This fixes the instances of "WARNING: modpost: missing
MODULE_DESCRIPTION()" that I'm seeing in 'mm'.

Note I'm not using an "everything enabled" configuration so there may
be more left to fix.

Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
---
Jeff Johnson (4):
      mm/hwpoison: add MODULE_DESCRIPTION()
      mm/dmapool: add MODULE_DESCRIPTION()
      mm/kfence: add MODULE_DESCRIPTION()
      mm/zsmalloc: add MODULE_DESCRIPTION()

 mm/dmapool_test.c       | 1 +
 mm/hwpoison-inject.c    | 1 +
 mm/kfence/kfence_test.c | 1 +
 mm/zsmalloc.c           | 1 +
 4 files changed, 4 insertions(+)
---
base-commit: dd5a440a31fae6e459c0d6271dddd62825505361
change-id: 20240513-mm-md-9bdb524ea9a8


