Return-Path: <linux-kernel+bounces-376164-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FF029AA105
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 13:19:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 177F11F24181
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 11:19:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E507A199FB5;
	Tue, 22 Oct 2024 11:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="lrC/5R+G"
Received: from pv50p00im-zteg10011501.me.com (pv50p00im-zteg10011501.me.com [17.58.6.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1508C140E38
	for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 11:19:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.58.6.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729595942; cv=none; b=u6egDZdCvMhvxcWOGMQV5d1/KtSKWVS/6qtSnAVcpbDhzgMPA+m2WHn7BptSWtrSYmXSK04XBZ+XMINi7Z17WJlAxb8/iIkPbuG2kS6cpHQKVynWXiv9sz5gfB7IcDrIvWecMUvvD4I5c7yi/4uMgltS1uq9pxUQbY+rbAzUbtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729595942; c=relaxed/simple;
	bh=B50yCI+7g3rlA61YQayrRubUe1WioMl2mNfq9WjwUI4=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=krYh4ijJaW3CGmTX+GGSsMhicBoP0KI53fZs6NvJczQpTVUlzokiz1D4b7OpTU3JxXmNrEsEhpu0Pa09tzb/Y5B7Rvup2nmbCS9awtZRQPaKPnr2wFuwW4zlZZtP/UIeess34NrPszQBnPBTOZpPLUsSzxxOOAhxOXJ65V0RQvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=lrC/5R+G; arc=none smtp.client-ip=17.58.6.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; t=1729595940;
	bh=wzxai2NUUu8d3eUdEhZyYHSGztfXIrMi20zKKxPtA5g=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To;
	b=lrC/5R+GHzKXxeYSFJRvAHXU1N01FIQXpqYr79/XlkAP5EzlepRUMLXO+EbDyxVvm
	 k6jTqyHGAvk91Kn18h7q2GfBmMPEQ7NgctwI0Hwh032eu4Q6rmx2m8P1TQ6/dYUHZj
	 sNAijKjl5zLQXHpnBrWLuVBHwoBP3kUXsArziK4mJnWlbr4N5vFG02hQD+0Xf0DAQ+
	 RHexR6zzIFNwyWgedEi0xl67NZevk3C1puFo1Y3aZoo9aR6n3IMdQjgaZWD4WUlUjy
	 Pp/PegxHmnKVquV96DqwJfKO1UMe2Mt+k+Ssb71Bdfr2h1V5scAFjZsv8tPAIzxrIs
	 gWKyL01pbwtBg==
Received: from [192.168.1.26] (pv50p00im-dlb-asmtp-mailmevip.me.com [17.56.9.10])
	by pv50p00im-zteg10011501.me.com (Postfix) with ESMTPSA id 01A524A02E3;
	Tue, 22 Oct 2024 11:18:57 +0000 (UTC)
From: Zijun Hu <zijun_hu@icloud.com>
Subject: [PATCH RESEND v2 0/2] driver core: bus: Fix issues related to
 bus_rescan_devices_helper()
Date: Tue, 22 Oct 2024 19:18:00 +0800
Message-Id: <20241022-bus_match_unlikely-v2-0-1a6f8e6839a0@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Zijun Hu <zijun_hu@icloud.com>, linux-kernel@vger.kernel.org, 
 Zijun Hu <quic_zijuhu@quicinc.com>
X-Mailer: b4 0.14.1
X-Proofpoint-GUID: k9cs6d1LqfPzQsQmvGcv21l3HJQkSqUE
X-Proofpoint-ORIG-GUID: k9cs6d1LqfPzQsQmvGcv21l3HJQkSqUE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-22_10,2024-10-22_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=909 spamscore=0
 phishscore=0 bulkscore=0 malwarescore=0 mlxscore=0 clxscore=1015
 suspectscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2308100000 definitions=main-2410220073
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


