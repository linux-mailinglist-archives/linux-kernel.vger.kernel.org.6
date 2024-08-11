Return-Path: <linux-kernel+bounces-282096-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C7DF94DFA9
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Aug 2024 04:27:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EC753B20DAB
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Aug 2024 02:27:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECD6B17552;
	Sun, 11 Aug 2024 02:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="N+/meKc9"
Received: from mr85p00im-ztdg06011901.me.com (mr85p00im-ztdg06011901.me.com [17.58.23.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C2E426287
	for <linux-kernel@vger.kernel.org>; Sun, 11 Aug 2024 02:25:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.58.23.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723343146; cv=none; b=NhJQvBkLLgjdqtB7VViX2H8VOF1Wde7fWV1RM1XoZYely0Z9Vs9EsDks/grMC4XVJGIqgYFrCe3zKj7Y6ajbL1uAaTZu4fFxAVqCh0AVOG6BISq7b9I1F+UenSWniBzuSH13XOKwHVuPTAiVVGweuA64bVpHV8CLvw2Bfa6zwHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723343146; c=relaxed/simple;
	bh=5yj7GugAurwuo2jXjU0qAvCGblW5HqDnRuTMDqpBDkA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cnqEIMFlz07Mu2oHMqBTQPdl7XAD3s3DJMu5UWNjjh6INJ3/8JjggDbapaufBx4JEm06/5NsCXQ4rB/J6XlZ1ZI8laOV6uT9Rxm3XSH4plzET4aIXHZ835hbB7gbtSuGj3GFU6QIYQHMiywt64a27O3Cs+8kGZbTuLQyc7soAN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=N+/meKc9; arc=none smtp.client-ip=17.58.23.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; t=1723343144;
	bh=hCZmJX6sJAYOcCpIrSUhCPuMRSyEvmDzlxcTEVhfE+M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To;
	b=N+/meKc977IHaHgKFvDdc+i7mIGbjkAJDCXghzRFIaCwjJTel68TWRRe4tbe+5Hr1
	 MUu3T54zBwZGsjDjT+YdEKOVt65jYKcOczOLk6L+QScXzvJnoD2q9sEQ4BOsG2TEt/
	 yzAVXTFvgo5J+Mr20XcjBAVwBQZrTde7AXTMtZiaeXMM0/34l9bbzpBRMGeSjYrF5S
	 kk+7UvEiZITSCrdI5Ldi1/jBj63aE1V2r8C+l2AVYdBpOHF9ZC58qSqkM8icS82wa+
	 ENSjll9mNehL2kwjF2+5e6Qlhue5mCHYdYJ9Ocen9vmdRuthZPT7tZefjyymEWu9wl
	 c0C3yQcXsJ+Wg==
Received: from [192.168.1.26] (mr38p00im-dlb-asmtp-mailmevip.me.com [17.57.152.18])
	by mr85p00im-ztdg06011901.me.com (Postfix) with ESMTPSA id 537D41349C0A;
	Sun, 11 Aug 2024 02:25:40 +0000 (UTC)
From: Zijun Hu <zijun_hu@icloud.com>
Date: Sun, 11 Aug 2024 10:24:59 +0800
Subject: [PATCH 08/27] scsi: iscsi: Constify driver API
 iscsi_find_flashnode_sess()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240811-const_dfc_done-v1-8-9d85e3f943cb@quicinc.com>
References: <20240811-const_dfc_done-v1-0-9d85e3f943cb@quicinc.com>
In-Reply-To: <20240811-const_dfc_done-v1-0-9d85e3f943cb@quicinc.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Zijun Hu <zijun_hu@icloud.com>, linux-kernel@vger.kernel.org, 
 Zijun Hu <quic_zijuhu@quicinc.com>
X-Mailer: b4 0.14.1
X-Proofpoint-GUID: FuiEUiY9_yxVEQ1uzVqp8F92Wo3TkypA
X-Proofpoint-ORIG-GUID: FuiEUiY9_yxVEQ1uzVqp8F92Wo3TkypA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-11_01,2024-08-07_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0
 clxscore=1015 phishscore=0 mlxscore=0 spamscore=0 mlxlogscore=597
 suspectscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2408110017
X-Apple-Remote-Links: v=1;h=KCk=;charset=UTF-8

From: Zijun Hu <quic_zijuhu@quicinc.com>

Constify iscsi_find_flashnode_sess() as well since it is a a simple
and specific wrapper of constified device_find_child().

Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
---
 drivers/scsi/scsi_transport_iscsi.c | 4 ++--
 include/scsi/scsi_transport_iscsi.h | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/scsi/scsi_transport_iscsi.c b/drivers/scsi/scsi_transport_iscsi.c
index b4aa091c687a..0d474de2d960 100644
--- a/drivers/scsi/scsi_transport_iscsi.c
+++ b/drivers/scsi/scsi_transport_iscsi.c
@@ -1389,8 +1389,8 @@ iscsi_get_flashnode_by_index(struct Scsi_Host *shost, uint32_t idx)
  *  %NULL on failure
  */
 struct device *
-iscsi_find_flashnode_sess(struct Scsi_Host *shost, void *data,
-			  int (*fn)(struct device *dev, void *data))
+iscsi_find_flashnode_sess(struct Scsi_Host *shost, const void *data,
+			  device_match_t fn)
 {
 	return device_find_child(&shost->shost_gendev, data, fn);
 }
diff --git a/include/scsi/scsi_transport_iscsi.h b/include/scsi/scsi_transport_iscsi.h
index bd1243657c01..4d3baf324900 100644
--- a/include/scsi/scsi_transport_iscsi.h
+++ b/include/scsi/scsi_transport_iscsi.h
@@ -497,8 +497,8 @@ extern void iscsi_destroy_all_flashnode(struct Scsi_Host *shost);
 extern int iscsi_flashnode_bus_match(struct device *dev,
 				     const struct device_driver *drv);
 extern struct device *
-iscsi_find_flashnode_sess(struct Scsi_Host *shost, void *data,
-			  int (*fn)(struct device *dev, void *data));
+iscsi_find_flashnode_sess(struct Scsi_Host *shost, const void *data,
+			  device_match_t fn);
 extern struct device *
 iscsi_find_flashnode_conn(struct iscsi_bus_flash_session *fnode_sess);
 

-- 
2.34.1


