Return-Path: <linux-kernel+bounces-282095-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D0F3094DFA8
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Aug 2024 04:26:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5BD19B2152B
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Aug 2024 02:26:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CC82134AC;
	Sun, 11 Aug 2024 02:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="Eg4w6jW/"
Received: from mr85p00im-ztdg06011901.me.com (mr85p00im-ztdg06011901.me.com [17.58.23.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C9972C6B7
	for <linux-kernel@vger.kernel.org>; Sun, 11 Aug 2024 02:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.58.23.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723343143; cv=none; b=bKmCReaSD2avh4VCybPwowHnMiWfMvCXsG/9y02GCxm3nD9ZkzVRpe2lpsIk096El158WMq8oi4ywgmfLqmZhENqJuuUAjaW0yuT27JtWtAyqEa4VMGhOxZv9/c9QOf8IOMQ1ACmjxjqtP3jo35LQPNrAccyfZG5TOwa4cpxfaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723343143; c=relaxed/simple;
	bh=VGBKliRKM4qweMUi9hBT/SK8oCtlK4T39IMzYFasb78=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rxlrckJuEX1jT6cxnvGlJx9uqtRXlo1CpY5kgCOeivrjPmrmaPMgKT2buMJDGb37MxaAmLwwVaavGrghdAnzW9ipehR1Sm8YBSZsnoQoUvds3aMSxWikG8EJuhMTKNetiwlLpkMt3MXkbBkuTD5buXYDUJEpg50L3HONcbLRdSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=Eg4w6jW/; arc=none smtp.client-ip=17.58.23.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; t=1723343140;
	bh=4kVPMBy35QlvkF6oiTHhFGgrtza6VDYMgmOH9YV5OXY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To;
	b=Eg4w6jW/7tpI9cBiX8F9qznvFvQfpAYKOib9az5ziToaYfFoo5n3Q4Y9lqw7JdBnX
	 /HmI7JbNjJevLtZzdzN2NREzg1Jfg0AyHTbaOOXuN13q8QhUdkiJw7SPxXaUduBqjW
	 8N5GXYdz68dT7f1y63xBqG6fFSJgMq5b4f0dcq1Q7J6jD+87BrxCQ1h/d4kmWIbR/G
	 xZvbBmkuAGTTh4yN0Sy5liPKQXVxhJM5sr/fBRlyAf6TdZ1qlyrudhaJUxUCO/rs1X
	 RpvVX4pyqYUoFL05zbO4jIkvzN8ll+w6OHOiL1NG/Cg5vV6mcjlvXzk6A4Xe6h5g00
	 wHnCXrT3rRGyg==
Received: from [192.168.1.26] (mr38p00im-dlb-asmtp-mailmevip.me.com [17.57.152.18])
	by mr85p00im-ztdg06011901.me.com (Postfix) with ESMTPSA id 4978D1349C1D;
	Sun, 11 Aug 2024 02:25:36 +0000 (UTC)
From: Zijun Hu <zijun_hu@icloud.com>
Date: Sun, 11 Aug 2024 10:24:58 +0800
Subject: [PATCH 07/27] scsi: iscsi: Make device_find_child()'s match
 function take a const pointer
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240811-const_dfc_done-v1-7-9d85e3f943cb@quicinc.com>
References: <20240811-const_dfc_done-v1-0-9d85e3f943cb@quicinc.com>
In-Reply-To: <20240811-const_dfc_done-v1-0-9d85e3f943cb@quicinc.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Zijun Hu <zijun_hu@icloud.com>, linux-kernel@vger.kernel.org, 
 Zijun Hu <quic_zijuhu@quicinc.com>
X-Mailer: b4 0.14.1
X-Proofpoint-GUID: sBq1g7m7u0B5xfKmtwk97aX2HxcgrY1v
X-Proofpoint-ORIG-GUID: sBq1g7m7u0B5xfKmtwk97aX2HxcgrY1v
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-11_01,2024-08-07_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0
 clxscore=1015 phishscore=0 mlxscore=0 spamscore=0 mlxlogscore=649
 suspectscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2408110017
X-Apple-Remote-Links: v=1;h=KCk=;charset=UTF-8

From: Zijun Hu <quic_zijuhu@quicinc.com>

In order to adapt for constified device_find_child(), make its match
functions take a const pointer.

Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
---
 drivers/scsi/scsi_transport_iscsi.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/scsi/scsi_transport_iscsi.c b/drivers/scsi/scsi_transport_iscsi.c
index fde7de3b1e55..b4aa091c687a 100644
--- a/drivers/scsi/scsi_transport_iscsi.c
+++ b/drivers/scsi/scsi_transport_iscsi.c
@@ -1324,7 +1324,7 @@ EXPORT_SYMBOL_GPL(iscsi_create_flashnode_conn);
  *  1 on success
  *  0 on failure
  */
-static int iscsi_is_flashnode_conn_dev(struct device *dev, void *data)
+static int iscsi_is_flashnode_conn_dev(struct device *dev, const void *data)
 {
 	return dev->bus == &iscsi_flashnode_bus;
 }
@@ -1335,7 +1335,7 @@ static int iscsi_destroy_flashnode_conn(struct iscsi_bus_flash_conn *fnode_conn)
 	return 0;
 }
 
-static int flashnode_match_index(struct device *dev, void *data)
+static int flashnode_match_index(struct device *dev, const void *data)
 {
 	struct iscsi_bus_flash_session *fnode_sess = NULL;
 	int ret = 0;
@@ -1344,7 +1344,7 @@ static int flashnode_match_index(struct device *dev, void *data)
 		goto exit_match_index;
 
 	fnode_sess = iscsi_dev_to_flash_session(dev);
-	ret = (fnode_sess->target_id == *((int *)data)) ? 1 : 0;
+	ret = (fnode_sess->target_id == *((const int *)data)) ? 1 : 0;
 
 exit_match_index:
 	return ret;

-- 
2.34.1


