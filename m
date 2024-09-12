Return-Path: <linux-kernel+bounces-327419-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D854A9775B3
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 01:45:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 989FB285C7F
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 23:45:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B2331C2DBE;
	Thu, 12 Sep 2024 23:45:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="XMM9Stm8"
Received: from mr85p00im-ztdg06021701.me.com (mr85p00im-ztdg06021701.me.com [17.58.23.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C2D418891D
	for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 23:45:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.58.23.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726184728; cv=none; b=E7BZ1QnMlRwHrm3xqdzVk7mL+IPUvV/OhvJ0AyQLaxPFbglX0wAnJ80JbwGO9ugkycpl5e8qlSFF3fPGxgH7ntfKt3vJpIOhCv1+WNLpZiDiSNPwp9sT79jVl+bdXNPEUQjBzZQOUUwmCVEAOrADfIskC8sIzjfuV450Lg1rYoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726184728; c=relaxed/simple;
	bh=B50yCI+7g3rlA61YQayrRubUe1WioMl2mNfq9WjwUI4=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=h3KNksECUDs0xXu4PsSa/Kfglc/OV5pX4ldTc4QfP7G0sSsRAl0Vpfiup12muLSGbQwcv5GNHSjWBQ4jzfbnCaLykx6U8dIH8pjInBM1mkGOS+/RFSYgyFbg2qLBHF2ycxwIxRNx2+yZo3Vv8VZignTDkfiSowqvDkn9RER+uuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=XMM9Stm8; arc=none smtp.client-ip=17.58.23.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; t=1726184726;
	bh=wzxai2NUUu8d3eUdEhZyYHSGztfXIrMi20zKKxPtA5g=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To;
	b=XMM9Stm88W/F7fWAfqSa3jWuaRbmuZimc3CRBANEsYYCE7AZCC8M2vrEONw9gl3dn
	 OVgpJABiFuCodEKrnisKIycqTumAYfNDONZnte2EQjFkTp2u5IKZArGBNZbkvFFZ3u
	 cp6pH0GyHSTUlbeCgFxZfs1wU4l7KY2chYM2w6q8BwGIdalC/RVL421EYJgERd/M75
	 Q9ToZ7S9BhnzL1mixzEgOXhwokhytTzWiPjnY5Xbt/cr5RDMQqImvhiKxi5d+AwFVK
	 0rnTIl+rD/ry2kD0/TLDOOFPdts426NBdMFPXVISlkjKidnf428S2/3drqouRPJa7a
	 wOv76QzKSxVNw==
Received: from [192.168.1.26] (mr38p00im-dlb-asmtp-mailmevip.me.com [17.57.152.18])
	by mr85p00im-ztdg06021701.me.com (Postfix) with ESMTPSA id 3509C26336B6;
	Thu, 12 Sep 2024 23:45:23 +0000 (UTC)
From: Zijun Hu <zijun_hu@icloud.com>
Subject: [PATCH v2 0/2] driver core: bus: Fix issues related to
 bus_rescan_devices_helper()
Date: Fri, 13 Sep 2024 07:45:09 +0800
Message-Id: <20240913-bus_match_unlikely-v2-0-5c0c3bfda2f6@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAV942YC/22NQQ6CMBBFr0JmbU07RQOuvIchBMogE6HVFoiEc
 Hcrbl2+l/z3VwjkmQJckhU8zRzY2Qh4SMB0lb2T4CYyoMRUZlqKegrlUI2mKyfb84P6RVQ15Vq
 ntWkbhDh8emr5vUdvReSOw+j8sn/M6mt/uVym/3KzElIoRK0yzE54VtfXxIatORo3QLFt2wf/9
 l0gtgAAAA==
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Zijun Hu <zijun_hu@icloud.com>, linux-kernel@vger.kernel.org, 
 Zijun Hu <quic_zijuhu@quicinc.com>
X-Mailer: b4 0.14.1
X-Proofpoint-GUID: aCS0dBNVakruggd6yvpgaLYkNMpU1CCA
X-Proofpoint-ORIG-GUID: aCS0dBNVakruggd6yvpgaLYkNMpU1CCA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-12_10,2024-09-12_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=900
 clxscore=1015 adultscore=0 suspectscore=0 malwarescore=0 mlxscore=0
 bulkscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2409120171
X-Apple-Remote-Links: v=1;h=KCk=;charset=UTF-8

This patch series is to fix issues related to bus_rescan_devices_helper().

The function is improperly used for 2 incompatible scenarios as
explained below:

Scenario A: scan drivers for a single device user specify
 - user may care about precise synchronous scanning result, so the
   function can not collapse error codes.

Scenario B: scan drivers for all devices of a bus
 - user may need to scan drivers for a bus's devices as many as
   possible, so the function needs to ignore inconsequential error
   codes for a device in order to continue to scan for next device.

Fixed by implementing bus_rescan_single_device() for scenario A
and correcting the function for scenario B.

Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
---
Changes in v2:
- Temporarily drop the change related to bus_type's match() return value
- For this 1/2 change, transfer internal -EPROBE_DEFER to user known
  -EAGAIN, correct title, commit message, inline comments.
- For this 2/2 change, Add an extra -EBUSY to ignore, correct title
  commit message, inline comments.
- Link to v1: https://lore.kernel.org/r/20240904-bus_match_unlikely-v1-0-122318285261@quicinc.com

---
Zijun Hu (2):
      driver core: bus: Fix drivers_probe_store() giving user wrong scanning result
      driver core: bus: Correct API bus_rescan_devices() behavior

 drivers/base/bus.c | 78 ++++++++++++++++++++++++++++++++++++++++++++----------
 1 file changed, 64 insertions(+), 14 deletions(-)
---
base-commit: fea64fa04c31426eae512751e0c5342345c5741c
change-id: 20240830-bus_match_unlikely-abe9334bcfd2

Best regards,
-- 
Zijun Hu <quic_zijuhu@quicinc.com>


