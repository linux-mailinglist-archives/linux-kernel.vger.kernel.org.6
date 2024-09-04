Return-Path: <linux-kernel+bounces-315060-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EE8496BD62
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 14:58:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 856F4B26EA2
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 12:58:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05F1E1D88CC;
	Wed,  4 Sep 2024 12:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="c0p0FyRW"
Received: from pv50p00im-ztdg10022001.me.com (pv50p00im-ztdg10022001.me.com [17.58.6.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4583A1D9D70
	for <linux-kernel@vger.kernel.org>; Wed,  4 Sep 2024 12:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.58.6.58
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725454643; cv=none; b=eahlmuhK73mYUYdh8CmgYNEe3FMMvPRSmdDDmAnrPLzUMAlrjR/mosKI6wcnbj7o6EEk1EmZGR49e0UFJh1hsUKeuvzjhnalTVx6Mzx12cRNewxMrd1y4hmBV0PwR2aJ0REr6ndQ2Uplhz3bDDOMMNBvhLoBaM7S0PKugwFg3oY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725454643; c=relaxed/simple;
	bh=CGxYiVKhmu3Z7BGr2eZdJ4gptixOi86m+olMDDO01t0=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=cjwMIYFSpc9m4m7PaiURZpUpKQTik+re3szT/WxkPgCxhU/bG8/CGYZhR4uaP7pxejsZEEPNwSI1UYYz2bzAYUz+TCEu8So58G/70yhZ60snHK1lm1hi8X/8Epe1cKcxE08AOZ02Qqt4O0wZ4jPXOP2bSazvm0n7Nvns5oBsKl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=c0p0FyRW; arc=none smtp.client-ip=17.58.6.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; t=1725454641;
	bh=YPOV2GRVxYfXL+1+omiRQ9RQfn+PuvrycIYhSvcVHNA=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To;
	b=c0p0FyRWoP1LBeGvmzExzCkgjpAL23vuYke2TxdAQUClrof4Anxk2tDZBEkrHwfxA
	 v7k9zdJoF5o02WfL3gYWQ3hTolGEtTiLoHKmJrQ1IM/lxTji+eRXcv8UCJm0HIevbB
	 WsqTLNnATE/KXz2YcR+QP1CN1mhYurgKe1tQJoT9EL91XIL0otmFw+4pmnKRCrwkML
	 Fl2wo+49eNOWKk1aSSdi4GH614SVxe3RSflVfXjwlpMdq96EJT8Gh7DGKKgJohCQik
	 ujyNZuFmL1R+Py9uKAC1+3/d9rVykAjsAqeNx1pwu/iQXZxavGj4enNGNwPWuJcD/A
	 T7EXpoyS/eg5Q==
Received: from [192.168.1.26] (pv50p00im-dlb-asmtp-mailmevip.me.com [17.56.9.10])
	by pv50p00im-ztdg10022001.me.com (Postfix) with ESMTPSA id 220F83E1E61;
	Wed,  4 Sep 2024 12:57:16 +0000 (UTC)
From: Zijun Hu <zijun_hu@icloud.com>
Subject: [PATCH 0/3] driver core: bus: Fix issues related to
 bus_rescan_devices_helper()
Date: Wed, 04 Sep 2024 20:56:41 +0800
Message-Id: <20240904-bus_match_unlikely-v1-0-122318285261@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAlZ2GYC/x3MQQ5AMBBA0avIrDWp1gJXEZG2hk5USYsQcXeN5
 Vv8/0DEQBihyR4IeFKk1ScUeQbGKj8hoyEZBBclryRn+oj9onZj+8M7mtHdTGmspSy1GQcBKdw
 CjnT907Z73w/sekocZAAAAA==
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Zijun Hu <zijun_hu@icloud.com>, linux-kernel@vger.kernel.org, 
 Zijun Hu <quic_zijuhu@quicinc.com>
X-Mailer: b4 0.14.1
X-Proofpoint-ORIG-GUID: SqsPATEGerh8sLymnNHmE1ALlJiz56it
X-Proofpoint-GUID: SqsPATEGerh8sLymnNHmE1ALlJiz56it
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-04_10,2024-09-04_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1015 mlxlogscore=857
 bulkscore=0 suspectscore=0 malwarescore=0 adultscore=0 mlxscore=0
 spamscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2409040098
X-Apple-Remote-Links: v=1;h=KCk=;charset=UTF-8

This patch series is to fix issues related to bus_rescan_devices_helper().

The function is currently used to scan drivers for both single and
all devices, but its return value can not cover expectations for both
scenarios as explained below:

for single device, user may care about precise scanning result, so
should not collapse error codes.

for all devices, user may want to scan drivers for devices as many as
possible, so need to ignore inconsequential error codes for a device to
continue to scan drivers for remaining devices.

Fixed by implementing bus_rescan_single_device() for single device and
correcting bus_rescan_devices_helper() for all devices.

Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
---
Zijun Hu (3):
      driver core: Mark impossible return values of bus_type's match() with unlikely()
      driver core: bus: Give error prompt for storing bus attribute drivers_probe failure
      driver core: bus: Correct API bus_rescan_devices() behavior

 drivers/base/bus.c         | 64 ++++++++++++++++++++++++++++++++++++----------
 drivers/base/dd.c          | 16 +++++++++---
 include/linux/device/bus.h |  9 +++----
 3 files changed, 67 insertions(+), 22 deletions(-)
---
base-commit: 888f67e621dda5c2804a696524e28d0ca4cf0a80
change-id: 20240830-bus_match_unlikely-abe9334bcfd2

Best regards,
-- 
Zijun Hu <quic_zijuhu@quicinc.com>


