Return-Path: <linux-kernel+bounces-409376-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 023979C8BF2
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 14:38:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A14981F22B15
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 13:38:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60670208AD;
	Thu, 14 Nov 2024 13:37:43 +0000 (UTC)
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FA43F9C0
	for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 13:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.255
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731591462; cv=none; b=JJKfAhwc+u32T32rFdQ0W+JPELZVXlAk1I554rDxiPmsqa6nxpkaYgR5aTZJC+YpZ41oEu2r0wloJSy7iPKQM7g7sqVplISYr8ijhQT1WU0BcMobMG1tiFii/sKynySO2/0C+LxiCRAp119EKz3vPlEcuPWrQUnlsKTXSMrLEM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731591462; c=relaxed/simple;
	bh=zFRjc2QWjRmKvoynQjm9yt4RkMSH2l39EGyq4CkzDXM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=NgyflVQu9NcbkpL7bltAp/10CFu8OqiYl+/BbJ6mIY/+r6vXEWyzvtrrW8CFs72HGWtHRxwpuBhR2Wg7niwOLdeOQ/IATn/KvrZezT/L1QPUWEcPL8RwAcZLpuht65PpXltXNyOqi+cbfrptIyEtvfZfd/jO38SrXrCVpzTV48c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.255
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.105])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4Xq1Np3SVkz1V4Fw;
	Thu, 14 Nov 2024 21:35:06 +0800 (CST)
Received: from kwepemf100008.china.huawei.com (unknown [7.202.181.222])
	by mail.maildlp.com (Postfix) with ESMTPS id 0FC181400DC;
	Thu, 14 Nov 2024 21:37:37 +0800 (CST)
Received: from huawei.com (10.175.103.91) by kwepemf100008.china.huawei.com
 (7.202.181.222) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Thu, 14 Nov
 2024 21:37:36 +0800
From: Zeng Heng <zengheng4@huawei.com>
To: <james.morse@arm.com>, <Dave.Martin@arm.com>
CC: <bobo.shaobowang@huawei.com>, <linux-kernel@vger.kernel.org>,
	<jonathan.cameron@huawei.com>, <linux-arm-kernel@lists.infradead.org>
Subject: [RFC PATCH mpam mpam/snapshot/v6.11-rc1 0/6] arm_mpam: Introduce the definitions of intPARTID and reqPARTID
Date: Thu, 14 Nov 2024 21:50:31 +0800
Message-ID: <20241114135037.918470-1-zengheng4@huawei.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemf100008.china.huawei.com (7.202.181.222)

The patch set is applied for mpam/snapshot/v6.11-rc1 branch of
https://git.kernel.org/pub/scm/linux/kernel/git/morse/linux.git
repository.

The narrow-partid feature in MPAM allows for a more efficient use of
PARTIDs by enabling a many-to-one mapping of reqpartids (requested PARTIDs)
to intpartids (internal PARTIDs). This mapping reduces the number of unique
PARTIDs needed, thus allowing more tasks or processes to be monitored and
managed with the available resources.

Intpartid(Internal PARTID) is an internal identifier used by the hardware
to represent a specific resource partition. It is a low-level identifier
that the hardware uses to track and manage resource allocation and
monitoring.

Reqpartid(Request PARTID) is an identifier provided by the software when
requesting resources from the memory system. It indicates the desired
partition for resource monitoring. By using reqpartids, software can
monitor specific resources or allow the system to subdivide smaller
granularity partitions within existing partitions to serve as monitoring
partitions.

For the new rmid allocation strategy, it will check whether there is an
available rmid of any reqPARTID which belongs to the input intPARTID.

The MPAM driver statically assigns all reqPARTIDs to respective intPARTIDs,
with a specific illustration as follows:

m - Indicates the number of reqPARTIDs per intPARTID
n - Indicates the total number of intPARTIDs
(m * n) - Represents the total number of reqPARTIDs

intPARTID_1 = 0
    ├── reqPARTID_1_1 = 0
    ├── reqPARTID_1_2 = 0 + n
    ├── ...
    └── reqPARTID_1_m = 0 + n * (m - 1)

intPARTID_2 = 1
    ├── reqPARTID_2_1 = 1
    ├── reqPARTID_2_2 = 1 + n
    ├── ...
    └── reqPARTID_2_m = 1 + n * (m - 1)

...

intPARTID_n = (n - 1)

Each intPARTID has m reqPARTIDs, which are used to expand the number of
monitoring groups under the control group. Therefore, the number of
monitoring groups is no longer limited by the range of MPAM PMG, which
enhances the extensibility of the system's monitoring capabilities.

Dave Martin (1):
  arm_mpam: Set INTERNAL as needed when setting MSC controls

Zeng Heng (5):
  arm_mpam: Introduce the definitions of intPARTID and reqPARTID
  arm_mpam: Create reqPARTIDs resource bitmap
  arm_mpam: Enhance the rmid allocation strategy
  arm_mpam: Call resctrl_sync_config() when allocate new reqPARTID
  fs/resctrl: Add the helper to check if the task exists in the target
    group

 arch/x86/kernel/cpu/resctrl/core.c          |  20 +++
 drivers/platform/arm64/mpam/mpam_devices.c  |  83 +++++++++--
 drivers/platform/arm64/mpam/mpam_internal.h |   6 +
 drivers/platform/arm64/mpam/mpam_resctrl.c  | 145 +++++++++++++++++++-
 fs/resctrl/internal.h                       |   4 -
 fs/resctrl/monitor.c                        |  16 ++-
 fs/resctrl/pseudo_lock.c                    |   7 +-
 fs/resctrl/rdtgroup.c                       |  84 ++++++++----
 include/linux/resctrl.h                     |  30 ++++
 9 files changed, 344 insertions(+), 51 deletions(-)

--
2.25.1


