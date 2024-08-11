Return-Path: <linux-kernel+bounces-282110-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BBC2F94DFB7
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Aug 2024 04:30:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A4A7B1C20DBC
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Aug 2024 02:30:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29F9B136356;
	Sun, 11 Aug 2024 02:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="acysh4Cc"
Received: from mr85p00im-ztdg06011901.me.com (mr85p00im-ztdg06011901.me.com [17.58.23.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 557AF139D16
	for <linux-kernel@vger.kernel.org>; Sun, 11 Aug 2024 02:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.58.23.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723343202; cv=none; b=bB9XbofXAu8zkFFA3ij1hkLz4dFe4zjnm5zROaalqHR418MOp7ngJ+21BXgpZ4nRnSHr76oyC4bfbPpKFmKn2w25Vr1v/wo1dEVdTtZFt6n7U19YieJbMOmeTiRLoVvsq/YBVlzz2f02F1OxvDo19FEeZx4X9zKsmEDMvPLF9F4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723343202; c=relaxed/simple;
	bh=tf3nO9JyklBhmboOl2UWXAHQehSGPZCGHTO3gPlpIHk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=eSrPCOb0TwF3XUDbP+7EpKhT4yN6/XZYMo0vOcFzyhba53N+cZBQiil8iuepor1WuFfS20AxJCj3o9GN6W81iAJfKsMTzpwihjz08pIpoRu97fKrLVQrhlkXgxEljbwFKXvpgZOjZnywPFFMX6aWR+7CQMsplx6tKLCEYIfnl9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=acysh4Cc; arc=none smtp.client-ip=17.58.23.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; t=1723343201;
	bh=9APqr7n9IhFJPdMFWSolgL6VU2mYNuZmGOTbbOMdviQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To;
	b=acysh4CcwVFQJ+ZWWsHX/Yf2c//eqQPnUHrRjm3oBey1j7XsgR1CHLSC5HQOm09E8
	 CfYQ1p29HriUqA4PR7zQ3W3CrpPEkUt31eGxyRs085JhgsHu3IxrpM50df+zOFQmz3
	 2Y/y5m8IsK0i0dwFmVe9E9aJZ0CQniuDFCYmBrPdezyN1az2/r+G6PaQ8Jw71KiTw+
	 XyvZ/C0oWrgV/JJ5ELP5eNPiadLXtya7/Q/R+1f6XGpJB4i50g8VgkhQ2ZNE2Dpg5H
	 +cb7yFoyHFr/NVs9XvXoU6rGEwbb0kXEjpG+mx0Tsdr6zY8zJS7VOKpWPngGA7P94c
	 EXmS33Ann9ahQ==
Received: from [192.168.1.26] (mr38p00im-dlb-asmtp-mailmevip.me.com [17.57.152.18])
	by mr85p00im-ztdg06011901.me.com (Postfix) with ESMTPSA id B007E1349C17;
	Sun, 11 Aug 2024 02:26:37 +0000 (UTC)
From: Zijun Hu <zijun_hu@icloud.com>
Date: Sun, 11 Aug 2024 10:25:13 +0800
Subject: [PATCH 22/27] nvdimm: Make device_find_child()'s match function
 take a const pointer
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240811-const_dfc_done-v1-22-9d85e3f943cb@quicinc.com>
References: <20240811-const_dfc_done-v1-0-9d85e3f943cb@quicinc.com>
In-Reply-To: <20240811-const_dfc_done-v1-0-9d85e3f943cb@quicinc.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Zijun Hu <zijun_hu@icloud.com>, linux-kernel@vger.kernel.org, 
 Zijun Hu <quic_zijuhu@quicinc.com>
X-Mailer: b4 0.14.1
X-Proofpoint-GUID: 2O7-UPuCEyD0FW4SWVvsCiGErQ_SrLod
X-Proofpoint-ORIG-GUID: 2O7-UPuCEyD0FW4SWVvsCiGErQ_SrLod
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-11_01,2024-08-07_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0
 clxscore=1015 phishscore=0 mlxscore=0 spamscore=0 mlxlogscore=731
 suspectscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2408110017
X-Apple-Remote-Links: v=1;h=KCk=;charset=UTF-8

From: Zijun Hu <quic_zijuhu@quicinc.com>

In order to adapt for constified device_find_child(), make
match_dimm() as its match function take a const pointer.

Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
---
 drivers/nvdimm/bus.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvdimm/bus.c b/drivers/nvdimm/bus.c
index 2237715e42eb..0ccf4a9e523a 100644
--- a/drivers/nvdimm/bus.c
+++ b/drivers/nvdimm/bus.c
@@ -1212,7 +1212,7 @@ enum nd_ioctl_mode {
 	DIMM_IOCTL,
 };
 
-static int match_dimm(struct device *dev, void *data)
+static int match_dimm(struct device *dev, const void *data)
 {
 	long id = (long) data;
 

-- 
2.34.1


