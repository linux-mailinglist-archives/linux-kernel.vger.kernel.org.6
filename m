Return-Path: <linux-kernel+bounces-198427-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D81918D7817
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Jun 2024 22:26:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 93A13283C67
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Jun 2024 20:26:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 509EC77620;
	Sun,  2 Jun 2024 20:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="c67PWXVi"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3862476041;
	Sun,  2 Jun 2024 20:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717359961; cv=none; b=uwV0oNNCICVJbaSRucckhuve5UYFM7SiBW9J/Dk5tNXi1O8hSdzZive0dNsNH4oLu3jrSrImh5vK/OX6ns9lsA0Uz5JzOuIQBFs3s6XWvZqlR19l14+8QhdKWSKyfkoJmmvh4TnAFvIzLyJWun4g4UPEdQ+patJURJMOyPq3pWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717359961; c=relaxed/simple;
	bh=zKdJIEfsfIc2zUt9he++jsJ04HnLgAtEmg/zpbjQ6bc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:To:CC; b=bKH+xjJxYUXq4kjPRq0Fl+Ah3StTSeNQeoyt3qJNPbgcUteVQR2+97ad0hmzxjc2SiUhsO8EQrF1UKIIbFzH0KHgoplWRKq/8unnHRGSupS//wh9CVrBuEJRiXDla2P3mlQ7pVUVTzIpAqd5+ys02Q1vtCAHhyGUKWMNokPrfZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=c67PWXVi; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 452K05Ag013708;
	Sun, 2 Jun 2024 20:25:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=vvfnFj3d8Ff5jt86j9qEjo
	ZKXmx6T4Um4nWCM7qd8oo=; b=c67PWXVi9+o2gMvUGOGTxBFJdzen1rSxlAQK8f
	7Bn3efcFpyzxJ+Pr6CQ8tYtqRY0PL8dcZzBwzqEbYUTsCZ+LDMIU5LKrFEk9E1kQ
	BnM6rwMWxuPKJrJi4LzpjYA8rk/qM7EM/yVhNf6FnKX9Dfrlez2CTYtFwsGBhJOH
	xQx6DksFBdoz4wqDL+isFxC3TfnyH7mXF2PzWGwxE2YhliZa5RcKNj1sIkssRXkA
	I5Xy81WTuAWdwdbWr2yO1G0bM8RfaUp79xx3mKUtAPmgPtUWYBJeVqfm2lN26AGs
	Oz4mM0KVhq95edVd2KwqvTUctlo1d+s+d5G/zfCGm9JLqwxw==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3yfw4d2hd1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 02 Jun 2024 20:25:51 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 452KPTIP028832
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 2 Jun 2024 20:25:29 GMT
Received: from [169.254.0.1] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Sun, 2 Jun 2024
 13:25:28 -0700
From: Jeff Johnson <quic_jjohnson@quicinc.com>
Date: Sun, 2 Jun 2024 13:25:28 -0700
Subject: [PATCH] virtio: add missing MODULE_DESCRIPTION() macro
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240602-md-virtio_dma_buf-v1-1-ce602d47e257@quicinc.com>
X-B4-Tracking: v=1; b=H4sIADfVXGYC/x3MQQqDMBBA0avIrDuQxsZFr1KKTJJRB0wsExVBv
 HvTLt/i/xMKq3CBZ3OC8i5FllxxvzUQJsojo8RqsMY+TGcspoi76CpLHxP1fhvQt87ZQF1w0UH
 tPsqDHP/n613tqTB6pRym32mWvB2YqKyscF1fXlRPg4IAAAA=
To: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        =?utf-8?q?Eugenio_P=C3=A9rez?=
	<eperezma@redhat.com>
CC: <virtualization@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
        <kernel-janitors@vger.kernel.org>,
        Jeff Johnson <quic_jjohnson@quicinc.com>
X-Mailer: b4 0.13.0
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: CGK5tmEWOLsksuJhBsO-6MA5LoNJKGc_
X-Proofpoint-GUID: CGK5tmEWOLsksuJhBsO-6MA5LoNJKGc_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-06-02_14,2024-05-30_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 mlxscore=0 adultscore=0 impostorscore=0 bulkscore=0
 spamscore=0 phishscore=0 clxscore=1011 mlxlogscore=997 suspectscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2406020178

make allmodconfig && make W=1 C=1 reports:
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/virtio/virtio_dma_buf.o

Add the missing invocation of the MODULE_DESCRIPTION() macro.

Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
---
 drivers/virtio/virtio_dma_buf.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/virtio/virtio_dma_buf.c b/drivers/virtio/virtio_dma_buf.c
index 2521a75009c3..3034a2f605c8 100644
--- a/drivers/virtio/virtio_dma_buf.c
+++ b/drivers/virtio/virtio_dma_buf.c
@@ -85,5 +85,6 @@ int virtio_dma_buf_get_uuid(struct dma_buf *dma_buf,
 }
 EXPORT_SYMBOL(virtio_dma_buf_get_uuid);
 
+MODULE_DESCRIPTION("dma-bufs for virtio exported objects");
 MODULE_LICENSE("GPL");
 MODULE_IMPORT_NS(DMA_BUF);

---
base-commit: 83814698cf48ce3aadc5d88a3f577f04482ff92a
change-id: 20240602-md-virtio_dma_buf-b3552ca6c5d5


