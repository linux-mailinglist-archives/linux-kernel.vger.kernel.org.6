Return-Path: <linux-kernel+bounces-168864-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 542FA8BBF03
	for <lists+linux-kernel@lfdr.de>; Sun,  5 May 2024 03:25:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D2462281E81
	for <lists+linux-kernel@lfdr.de>; Sun,  5 May 2024 01:25:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D360ED8;
	Sun,  5 May 2024 01:25:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="cSGvdP03"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1560281F
	for <linux-kernel@vger.kernel.org>; Sun,  5 May 2024 01:25:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714872330; cv=none; b=lCO8QqQPNEi77M7q/6gRPP3D7K4BCXcnVO5d8Q/X83VBMlDpl26w/Bwh8TbcTeBPvgFc3F70coFqkaZXJS2anflnHBkpqpfmtkzAgE0qdQ34mSeu/SIdHAdTlQWJiJ0UJVrcXt7WBjuFeAD2xEbdiqUSslKEcAiFR+fYkVGxtSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714872330; c=relaxed/simple;
	bh=JmIz5WrIUMBF0HxvEC8+Oe+zPi1CpdHGV0E6ZKKV7b4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:To:CC; b=S9b1+nxgP2d0Tvxa88QT062B0s33uoehHiP7bVqbmAyWnVQIeZdAPbfYF9vHrD/GRu3/hLYxHbTf3bEV7LsD5XSMR2cdlALMwdTXC7Fz3oqCVD1PHXXOEqVMLVD5vA8S36b0fzwyHlnEy+HMlYX6nzVqzLffjF09yIlGbs0H+kk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=cSGvdP03; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4451NUiT002608;
	Sun, 5 May 2024 01:25:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:date:subject:mime-version:content-type
	:content-transfer-encoding:message-id:to:cc; s=qcppdkim1; bh=J0e
	UDGUOX7X2N/gQsRlJeX+THo1jPFVIBTxcxncVpj8=; b=cSGvdP03mZRPOr0PSO7
	douvu9qByI3kkTvU2XQ2bM04FM4gK/J1ZZjQ4sHW6GwUXMdeIB8Ny6m1bUGwOmQP
	v7M8OLHash6ZXCDYIJckzm0CJWr159xmlwSaKPMuKD1JW3h1bpxx5XJg/SCszkih
	fei35kd4lEDkdZA3YkThCwyjNluEEWsE+TyQZAnp6PeuhZjTb/p7uJGDTWvbhf/Y
	n7l79917VcijW0GwSzmfkLMa8AD2D/IgdIrjJ7DL2MmU1dhqBc8WqQQatv7mXd2o
	N5RqyHri0ZHcz1Un0fMP3G4YELwfzGhICjxt+1njDEp8hrKD3lGUNSFC74CEc9Mp
	LmA==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xwd3y97b6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 05 May 2024 01:25:10 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 4451P9hZ013052
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 5 May 2024 01:25:09 GMT
Received: from [169.254.0.1] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Sat, 4 May 2024
 18:25:08 -0700
From: Jeff Johnson <quic_jjohnson@quicinc.com>
Date: Sat, 4 May 2024 18:25:07 -0700
Subject: [PATCH] most: fix current kernel-doc warnings
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240504-most-kdoc-v1-1-378c468ccd85@quicinc.com>
X-B4-Tracking: v=1; b=H4sIAPLfNmYC/x3MQQqDMBBA0avIrDuQaNTiVUoXSRx1KCYyI0UQ7
 27a5YPPP0FJmBSG6gShLyvnVGAfFcTFp5mQx2KoTe1MaxyuWXf8jDmiDU/buL6NXROg9JvQxMf
 /9XoXB6+EQXyKy++wet1J4Lpu5/4yeHQAAAA=
To: Parthiban Veerasooran <parthiban.veerasooran@microchip.com>,
        "Christian
 Gromm" <christian.gromm@microchip.com>,
        Randy Dunlap <rdunlap@infradead.org>
CC: <linux-kernel@vger.kernel.org>, Jeff Johnson <quic_jjohnson@quicinc.com>
X-Mailer: b4 0.13.0
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: kVUW8BoOo1F8PMgqCcm7MfjQ-2QfkU7W
X-Proofpoint-GUID: kVUW8BoOo1F8PMgqCcm7MfjQ-2QfkU7W
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-04_18,2024-05-03_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxscore=0
 malwarescore=0 phishscore=0 mlxlogscore=999 adultscore=0 clxscore=1011
 impostorscore=0 lowpriorityscore=0 priorityscore=1501 spamscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2405050004

Follow up on the prior work [1] from Randy Dunlap and fix the current
set of W=1 kernel-doc warnings in drivers/most/:

drivers/most/most_snd.c:58: warning: Excess struct member 'opened' description in 'channel'
drivers/most/most_usb.c:69: warning: Function parameter or struct member 'dev' not described in 'most_dci_obj'
drivers/most/most_usb.c:69: warning: Excess struct member 'kobj' description in 'most_dci_obj'
drivers/most/most_usb.c:122: warning: Function parameter or struct member 'dev' not described in 'most_dev'
drivers/most/most_usb.c:122: warning: Function parameter or struct member 'clear_work' not described in 'most_dev'
drivers/most/most_usb.c:122: warning: Function parameter or struct member 'on_netinfo' not described in 'most_dev'
drivers/most/most_usb.c:650: warning: Function parameter or struct member 'on_netinfo' not described in 'hdm_request_netinfo'

Link: https://lore.kernel.org/r/20230113063947.23174-1-rdunlap@infradead.org [1]
Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
---
 drivers/most/most_snd.c | 1 -
 drivers/most/most_usb.c | 6 +++++-
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/most/most_snd.c b/drivers/most/most_snd.c
index 45d762804c5e..3b19fa835206 100644
--- a/drivers/most/most_snd.c
+++ b/drivers/most/most_snd.c
@@ -36,7 +36,6 @@ static struct most_component comp;
  * @period_pos: current period position (ring buffer)
  * @buffer_pos: current buffer position (ring buffer)
  * @is_stream_running: identifies whether a stream is running or not
- * @opened: set when the stream is opened
  * @playback_task: playback thread
  * @playback_waitq: waitq used by playback thread
  * @copy_fn: copy function for PCM-specific format and width
diff --git a/drivers/most/most_usb.c b/drivers/most/most_usb.c
index 485d5ca39951..3e5bab68fa47 100644
--- a/drivers/most/most_usb.c
+++ b/drivers/most/most_usb.c
@@ -58,7 +58,7 @@
 
 /**
  * struct most_dci_obj - Direct Communication Interface
- * @kobj:position in sysfs
+ * @dev: device structure
  * @usb_device: pointer to the usb device
  * @reg_addr: register address for arbitrary DCI access
  */
@@ -83,6 +83,7 @@ struct clear_hold_work {
 
 /**
  * struct most_dev - holds all usb interface specific stuff
+ * @dev: device structure
  * @usb_device: pointer to usb device
  * @iface: hardware interface
  * @cap: channel capabilities
@@ -94,10 +95,12 @@ struct clear_hold_work {
  * @channel_lock: synchronize channel access
  * @padding_active: indicates channel uses padding
  * @is_channel_healthy: health status table of each channel
+ * @clear_work: list of work items to send clear_halt to USB pipes
  * @busy_urbs: list of anchored items
  * @io_mutex: synchronize I/O with disconnect
  * @link_stat_timer: timer for link status reports
  * @poll_work_obj: work for polling link status
+ * @on_netinfo: call-back used to deliver network status to mostcore
  */
 struct most_dev {
 	struct device dev;
@@ -638,6 +641,7 @@ static int hdm_configure_channel(struct most_interface *iface, int channel,
  * hdm_request_netinfo - request network information
  * @iface: pointer to interface
  * @channel: channel ID
+ * @on_netinfo: call-back used to deliver network status to mostcore
  *
  * This is used as trigger to set up the link status timer that
  * polls for the NI state of the INIC every 2 seconds.

---
base-commit: 2c4d8e19cf060744a9db466ffbaea13ab37f25ca
change-id: 20240504-most-kdoc-1b813475c63b


