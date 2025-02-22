Return-Path: <linux-kernel+bounces-527140-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 187E7A407D5
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Feb 2025 12:16:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 53574700CA2
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Feb 2025 11:15:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12F9620B1F9;
	Sat, 22 Feb 2025 11:15:27 +0000 (UTC)
Received: from szxga06-in.huawei.com (szxga06-in.huawei.com [45.249.212.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E5D920ADD1
	for <linux-kernel@vger.kernel.org>; Sat, 22 Feb 2025 11:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740222926; cv=none; b=JtLlUAX8sigsu50/FuVHZaHSGdnlSN4OLDpT1b4sbAM+waUXMfpT2XUhWMc6vRb48x72cKDAzKlVq7O1ZtE5/ZpuaYa9td5kA7/iISr3WP2YmTHHEQ3Mc7IdrKCV7a1BduB23HnXl2BgYof8aVMYDSmemguAQTgvKHXSyxgFQ2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740222926; c=relaxed/simple;
	bh=bsM8gF5vLY1aiatMpbafXqU2OA/hu8+UZhi+44pk95I=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=XnIybCd+xlUzuBFPiB37l30ZcUbnmGT16RX7++jKDnRswDdeMkbA6uAs+syir7prekrNYGJEQjaX5qf9xEqrpBfdPh6SbQY7SMQ0+dpgUy1hcyt6WTTwOIF24tpT7X7OOkohs6uOmBtuiPX8Gdt36gabVnTga/WQUKGb5uudgMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.44])
	by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4Z0PYv06CNznl1v;
	Sat, 22 Feb 2025 19:15:47 +0800 (CST)
Received: from kwepemf100008.china.huawei.com (unknown [7.202.181.222])
	by mail.maildlp.com (Postfix) with ESMTPS id 8CCB51402C4;
	Sat, 22 Feb 2025 19:15:15 +0800 (CST)
Received: from huawei.com (10.175.103.91) by kwepemf100008.china.huawei.com
 (7.202.181.222) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Sat, 22 Feb
 2025 19:15:14 +0800
From: Zeng Heng <zengheng4@huawei.com>
To: <Dave.Martin@arm.com>, <james.morse@arm.com>
CC: <bobo.shaobowang@huawei.com>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <jonathan.cameron@huawei.com>
Subject: [PATCH mpam mpam/snapshot/v6.14-rc1 v2 0/5] arm_mpam: Introduce the Narrow-PARTID feature for MPAM driver
Date: Sat, 22 Feb 2025 19:24:43 +0800
Message-ID: <20250222112448.2438586-1-zengheng4@huawei.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemf100008.china.huawei.com (7.202.181.222)

The patch set is applied for mpam/snapshot/v6.14-rc1 branch of
https://git.kernel.org/pub/scm/linux/kernel/git/morse/linux.git
repository.

The narrow-partid feature in MPAM allows for a more efficient use of
PARTIDs by enabling a many-to-one mapping of reqpartids (requested PARTIDs)
to intpartids (internal PARTIDs). This mapping reduces the number of unique
PARTIDs needed, thus allowing more tasks or processes to be monitored and
managed with the available resources.

For a mixture of MSCs system, for MSCs that do not support narrow-partid,
we use the PARTIDs exceeding the number of closids as reqPARTIDs for
expanding the monitoring groups.

Therefore, we will expand the information contained in the RMID, so that it
includes not only PMG, but also reqPARTIDs information. The new RMID would
be like:

    RMID = (reqPARTID << shift | PMG).

Each control group has m (req)PARTIDs, which are used to expand the
number of monitoring groups under one control group. Therefore, the number
of monitoring groups is no longer limited by the range of MPAM's PMG, which
enhances the extensibility of the system's monitoring capabilities.

---
Compared with v1:
  - Redefine the RMID information.
  - Refactor the resctrl_arch_rmid_idx_decode() and
    resctrl_arch_rmid_idx_encode().
  - Simplify closid_rmid2reqpartid() to rmid2reqpartid() and replace it
    accordingly.

Compared with RFC-v4:
  - Rebase the patch set on the v6.14-rc1 branch.

Compared with RFC-v3:
  - Add limitation of the Narrow-PARTID feature (See Patch 2).
  - Remove redundant reqpartid2closid() and reqpartid_pmg2rmid().
  - Refactor closid_rmid2reqpartid() partially.
  - Merge the PARTID conversion-related patches into a single patch for
    bisectability.
  - Skip adaptation of resctrl_arch_set_rmid() which is going to be
    removed.

Compared with RFC-v2:
  - Refactor closid/rmid pair translation.
  - Simplify the logic of synchronize configuration.
  - Remove reqPARTID source bitmap.

Compared with RFC-v1:
  - Rebase this patch set on latest MPAM driver of the v6.12-rc1 branch.
---

Dave Martin (1):
  arm_mpam: Set INTERNAL as needed when setting MSC controls

Zeng Heng (4):
  arm_mpam: Introduce the definitions of intPARTID and reqPARTID
  arm_mpam: Add limitation for the Narrow-PARTID feature
  arm_mpam: Expand the composition of RMID
  arm_mpam: Automatically synchronize the configuration of all
    sub-monitoring groups

 drivers/platform/arm64/mpam/mpam_devices.c  |  62 ++++++--
 drivers/platform/arm64/mpam/mpam_internal.h |   5 +
 drivers/platform/arm64/mpam/mpam_resctrl.c  | 155 ++++++++++++++------
 3 files changed, 168 insertions(+), 54 deletions(-)

--
2.25.1


