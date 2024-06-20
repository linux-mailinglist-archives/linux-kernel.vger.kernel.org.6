Return-Path: <linux-kernel+bounces-223085-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DCA1910D5E
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 18:43:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 39B54287268
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 16:43:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A74141B14FA;
	Thu, 20 Jun 2024 16:43:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Ls1z8Am1"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DA711B14E9;
	Thu, 20 Jun 2024 16:42:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718901781; cv=none; b=ieiWybvKa1ap6vzm9B9vW7qeQhsvGddqSiw1hadN+0YlVyE/vxUE6be7z1hi3RFg+efJ4lGz73QcHoh9KaCVxiCwNQbK813PWO1oe12WLlMhAzWC3DeJ6BFQLlnmmoUGdIj4pJlUcZ3DcHocwns9RwBIEPsOYBPm6D7FH7MjtSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718901781; c=relaxed/simple;
	bh=HT/ZBy9Xmd6m8pI02Qj94fqFj2FB4s9hC7/NHHPNE54=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:To:CC; b=WdkFRkwo35KJ8sy9m8RZKfn+Z9RgzwAyXWaiP8wAfbrGG2tsmeejjI7BPG4XqDmHz9Iho78GSeMC7wTuzvvPTpZQgAIpS8Aad6HSwnqZBAhW+Y5QjQM95FyEwFzAK55zk76va4QzghVD2CghJLjKnlXeM1j378gJTRTf4O8vlBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Ls1z8Am1; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45KAcY9r011376;
	Thu, 20 Jun 2024 16:42:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=1n3k6Rb+BKNEXxUiaweAV2
	r6d1TevLnFz/g5L7Yd+bE=; b=Ls1z8Am1seC2RN46nBOUEk5HvTwRhLHglj7xIS
	42B/S0LAuDPvcaeFTD9OBoqehPXM+eMhp7/g3wSsNnDy0Byxf2JZpn9uRWv9dlX6
	Sj4wfd4VAio18r2245CZL6cUS32lfpBmqqFJPMwwlXECbH+BVMxdQj4crfsXQ3wd
	eKDTotJpebasroLAPaTJy9RVhlp//hapblKAvxvT9HrKs1WX8Mjr7P68Tw+GATv0
	Myo6Pg0wntsYsDL0kiOSl0DE9USsVLWf3f/5wonxNCei1OqPXHGjqWG5veugKkz7
	8ORUgbiYr6JymTCYnjzQEdnzrp0FCHq1HcLooAf8TGf+poQg==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3yvjumrvf3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 20 Jun 2024 16:42:22 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 45KGgKxK031858
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 20 Jun 2024 16:42:20 GMT
Received: from [169.254.0.1] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 20 Jun
 2024 09:42:20 -0700
From: Jeff Johnson <quic_jjohnson@quicinc.com>
Date: Thu, 20 Jun 2024 09:42:18 -0700
Subject: [PATCH v2] nvme-apple: add missing MODULE_DESCRIPTION()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240620-md-nvme-apple-v2-1-72e9d7151a1f@quicinc.com>
X-B4-Tracking: v=1; b=H4sIAOpbdGYC/3WNQQ6CMBBFr0Jm7ZiCgMDKexgWbRllElqwhQZDu
 LuFvcuX/P/eBp4ck4cm2cBRYM+jjZBdEtC9tG9C7iJDJrJcFDeBpkMbDKGcpoGQBHWqVnWl8wL
 iZ3L04vX0PdvISnpC5aTV/WEZ2C4rGulncse8Zz+P7nvWQ3qc/oVCiimqSt21LMq6LMXjs7Bmq
 696NNDu+/4DC2sVuMsAAAA=
To: Hector Martin <marcan@marcan.st>, Sven Peter <sven@svenpeter.dev>,
        "Alyssa
 Rosenzweig" <alyssa@rosenzweig.io>,
        Keith Busch <kbusch@kernel.org>, "Jens
 Axboe" <axboe@kernel.dk>,
        Christoph Hellwig <hch@lst.de>, Sagi Grimberg
	<sagi@grimberg.me>
CC: <asahi@lists.linux.dev>, <linux-arm-kernel@lists.infradead.org>,
        <linux-nvme@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <kernel-janitors@vger.kernel.org>, Eric Curtin <ecurtin@redhat.com>,
        "Jeff
 Johnson" <quic_jjohnson@quicinc.com>
X-Mailer: b4 0.14.0
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: Xw8EQqg3_YaURzeNrtii9JX-O_Nr7YPr
X-Proofpoint-GUID: Xw8EQqg3_YaURzeNrtii9JX-O_Nr7YPr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-20_07,2024-06-20_04,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 phishscore=0
 mlxlogscore=999 bulkscore=0 mlxscore=0 priorityscore=1501 malwarescore=0
 adultscore=0 lowpriorityscore=0 clxscore=1011 suspectscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2405170001
 definitions=main-2406200119

make allmodconfig && make W=1 C=1 reports:
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/nvme/host/nvme-apple.o

Add the missing invocation of the MODULE_DESCRIPTION() macro.

Reviewed-by: Eric Curtin <ecurtin@redhat.com>
Reviewed-by: Sven Peter <sven@svenpeter.dev>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
---
Changes in v2:
- Don't see this is linux-next yet so rebased to 6.10-rc4 (no patch change)
- Picked up the Reviewed-by tags
- Link to v1: https://lore.kernel.org/r/20240530-md-nvme-apple-v1-1-b8b7ca569660@quicinc.com
---
 drivers/nvme/host/apple.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/nvme/host/apple.c b/drivers/nvme/host/apple.c
index dd6ec0865141..0cfa39361d3b 100644
--- a/drivers/nvme/host/apple.c
+++ b/drivers/nvme/host/apple.c
@@ -1602,4 +1602,5 @@ static struct platform_driver apple_nvme_driver = {
 module_platform_driver(apple_nvme_driver);
 
 MODULE_AUTHOR("Sven Peter <sven@svenpeter.dev>");
+MODULE_DESCRIPTION("Apple ANS NVM Express device driver");
 MODULE_LICENSE("GPL");

---
base-commit: 6ba59ff4227927d3a8530fc2973b80e94b54d58f
change-id: 20240530-md-nvme-apple-e0edb9b98c45


