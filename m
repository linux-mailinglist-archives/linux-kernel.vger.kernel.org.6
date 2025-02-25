Return-Path: <linux-kernel+bounces-531537-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 787E6A441AE
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 15:03:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 95DF5189D45F
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 13:59:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24C0026A090;
	Tue, 25 Feb 2025 13:58:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="wx1Qwn0+"
Received: from pv50p00im-ztdg10012001.me.com (pv50p00im-ztdg10012001.me.com [17.58.6.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4633C1C6FF3
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 13:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.58.6.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740491912; cv=none; b=UaXmDAIwRAjvnKyVdH6NivL4Y4gZ0TeVKfGWaT7EOHaQiN4P9DrPgaV+5va7OhxFr5H/xnradjXtHDFMGC10AsMr4WB7hk64/O3AExs2h466IxzRpOyc1z9e9iHuDf1ZP/ziCEn+0L9UFjj5uUyoYBDCRXglAadJhQb3d8X2Ah8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740491912; c=relaxed/simple;
	bh=Il2vlYXIrtVzCZJnKLXesec5sO2a6P2q4EQBny/Ecu4=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=UgLrw0xIScnbU+tkHGrKi/AOhANWMmUN1E4S12vZo0x85zWI5QUSIlCL0j5tageME75eRl4FM8igmPC4BLvsucIyKwvX8Xa2nmAOI+UWCBV/XzmNM8+tNXsn++VEhW5+Gt4oU2TP19vonvMdhqeXsLTTC+SLoqknaAbv0SfrK7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=wx1Qwn0+; arc=none smtp.client-ip=17.58.6.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; bh=LPFt9BaA594wT21Qx1yKNC202CP9WF8CtOsKwO984Ms=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:x-icloud-hme;
	b=wx1Qwn0+1uxjt2tZqzE7aWzK+vlbLN4GW+awX2yDAUzTVmj0etBl4Rq987KFyndrv
	 tixcT5dIawbvU+DwBtV6D1V9HnNLv0T73y2nlcez1U1RyKfJqT/iSvpu2VYYwj6GJM
	 E7y8B3vNy8gumP6PMDi/KKNNy1Qhjb9iMcW0Mz5lIwS4DYCwyoMMNQuk19sMg5xyZT
	 whDeJ8oY15p+5v1vYI32nRNiL+VH6zUkg5F2bbj5zsVvQenl/uYLBXS1gb002pyPZb
	 4uK6v7LEN3CspLyVA954qQ6JJff8JcIGL6Z3qjXgwwT0uRwdfDVsUKn9w8CVgl8uOz
	 GqlVMBmV1XjPw==
Received: from [192.168.1.26] (pv50p00im-dlb-asmtp-mailmevip.me.com [17.56.9.10])
	by pv50p00im-ztdg10012001.me.com (Postfix) with ESMTPSA id ACA36A026C;
	Tue, 25 Feb 2025 13:58:24 +0000 (UTC)
From: Zijun Hu <zijun_hu@icloud.com>
Subject: [PATCH v4 0/2] of: property: Fix potential firmware node
 reference's argument count got out of range
Date: Tue, 25 Feb 2025 21:58:05 +0800
Message-Id: <20250225-fix_arg_count-v4-0-13cdc519eb31@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAG3MvWcC/2WPy27CMBBFfwV53UF+pQld8R9VFTnOmMyicbGD1
 Qrl3xkCEoUs79Wco7lnkTERZvGxOYuEhTLFkYN92wg/uPGAQD1noaWupFIWAv22Lh1aH0/jBLU
 J6HAng/edYOYnIR8svs8vzgPlKaa/RV/Utb2b5A5iYEnClgEoFmrou8bV2qqqa/z+eCJPo9/6+
 C2upqL/0as/igYFGJypEN+rWndr3jx4reQrb5h3srGO7UbK5pmfb9MScptpuu+b5wtXdWUsPwE
 AAA==
X-Change-ID: 20250114-fix_arg_count-73feae90fccb
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
 Daniel Scally <djrscally@gmail.com>, 
 Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
 Sakari Ailus <sakari.ailus@linux.intel.com>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Danilo Krummrich <dakr@kernel.org>, Rob Herring <robh@kernel.org>, 
 Saravana Kannan <saravanak@google.com>
Cc: Zijun Hu <zijun_hu@icloud.com>, linux-acpi@vger.kernel.org, 
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 Zijun Hu <quic_zijuhu@quicinc.com>
X-Mailer: b4 0.14.2
X-Proofpoint-ORIG-GUID: 5JMNDe478jqEIs8W4zaVogo0aEtnZoFs
X-Proofpoint-GUID: 5JMNDe478jqEIs8W4zaVogo0aEtnZoFs
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-25_04,2025-02-25_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=718
 suspectscore=0 phishscore=0 adultscore=0 malwarescore=0 bulkscore=0
 clxscore=1015 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2502250096
X-Apple-Remote-Links: v=1;h=KCk=;charset=UTF-8

This patch series is to fix an OF issue below:

The firmware node reference argument count @args->nargs got by
of_fwnode_get_reference_args() may be out of range.

---
Changes in v4:
- Correct commit message for patch 1/2
- Add one more patch 2/2 to align both macros
- Link to v3: https://lore.kernel.org/r/20250210-fix_arg_count-v3-1-a084a5013008@quicinc.com

Changes in v3:
- Remove RFC, correct title and commit message.
- Link to v2: https://lore.kernel.org/r/20250114-fix_arg_count-v2-1-efa35ee6572b@quicinc.com

Changes in v2:
- Increase macro @NR_FWNODE_REFERENCE_ARGS to align with @MAX_PHANDLE_ARGS.
- Correct fix tag and send as RFC patch.
- Link to v1: https://lore.kernel.org/r/20250109-of_core_fix-v4-7-db8a72415b8c@quicinc.com

---
Zijun Hu (2):
      of: property: Increase NR_FWNODE_REFERENCE_ARGS
      of: Align macro MAX_PHANDLE_ARGS with NR_FWNODE_REFERENCE_ARGS

 include/linux/fwnode.h | 2 +-
 include/linux/of.h     | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)
---
base-commit: cd726b80a9b2e35397f3f4ecd845a8fd247ee79e
change-id: 20250114-fix_arg_count-73feae90fccb

Best regards,
-- 
Zijun Hu <quic_zijuhu@quicinc.com>


