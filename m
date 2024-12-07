Return-Path: <linux-kernel+bounces-435974-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B51D9E7F4A
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Dec 2024 10:09:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 110DB168837
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Dec 2024 09:09:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D09C813AD22;
	Sat,  7 Dec 2024 09:09:26 +0000 (UTC)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A99B883CC7
	for <linux-kernel@vger.kernel.org>; Sat,  7 Dec 2024 09:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733562566; cv=none; b=CD+1HyxiYKkg6Jl9IsiNPjXVHTqemtcpZ0SpQUaJgAzc+Wn3EUBRpmLv+2nyjm7sHx3d0hx0ocw8XSYbIAIlynCVfmWe+e2ejhz7IXIEN7rVfIChgVcGbYmOZIK3Af+vluUYDEFPTYPxkdk0J2vOwxR3dQuC2Yk20enUEy2GbXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733562566; c=relaxed/simple;
	bh=S7vH8/jyVWdZFjFX72A7TalolQAOkAvTw1rjfgEBwi0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=XzdSlBKUgxb0fQhOfTNSstbxAQoktUkx9DiCEtlZrFB4+CVOsYX//9wJS5B98b01Zfw63H3BVxGyZvrQSToqIw8Y/4XbEsx8TVRobVj9ZwSzay2TPQ2n4XdeqKrQ2/XZVW9WLCFI2/au/aTTxa2l7xRDxrrw5sPIvKSj+e2oVUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.105])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Y52Lq5mj3zhZVn;
	Sat,  7 Dec 2024 17:06:59 +0800 (CST)
Received: from kwepemf100008.china.huawei.com (unknown [7.202.181.222])
	by mail.maildlp.com (Postfix) with ESMTPS id 0CF671402C4;
	Sat,  7 Dec 2024 17:09:20 +0800 (CST)
Received: from huawei.com (10.175.103.91) by kwepemf100008.china.huawei.com
 (7.202.181.222) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Sat, 7 Dec
 2024 17:09:19 +0800
From: Zeng Heng <zengheng4@huawei.com>
To: <Dave.Martin@arm.com>, <james.morse@arm.com>
CC: <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<jonathan.cameron@huawei.com>, <xiexiuqi@huawei.com>
Subject: [RFC PATCH mpam mpam/snapshot/v6.12-rc1 v3 0/5] arm_mpam: Introduce the Narrow-PARTID feature for MPAM driver
Date: Sat, 7 Dec 2024 17:21:31 +0800
Message-ID: <20241207092136.2488426-1-zengheng4@huawei.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemf100008.china.huawei.com (7.202.181.222)

The patch set is applied for mpam/snapshot/v6.12-rc1 branch of
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

In order to keep the existing resctrl API interface, the rmid contains both
req_idx and PMG information instead of PMG only under the MPAM driver. The
req_idx represents the req_idx-th sub-monitoring group under the control
group. The new rmid would be like:

    rmid = (req_idx << shift | pmg).

The new conversion relationship between closid/rmid and (req)PARTID/PMG is:

    (req)PARTID = (rmid.req_idx * n) + closid,
    PMG = rmid.pmg.

Each intPARTID has m reqPARTIDs, which are used to expand the number of
monitoring groups under the control group. Therefore, the number of
monitoring groups is no longer limited by the range of MPAM PMG, which
enhances the extensibility of the system's monitoring capabilities.

---
Compared with v1:
  - Rebase this patch set on latest MPAM driver of the v6.12-rc1 branch.

Compared with v2:
  - Refactor closid/rmid pair translation
  - Simplify the logic of synchronize configuration
  - Remove reqPARTID pool
---

Dave Martin (1):
  arm_mpam: Set INTERNAL as needed when setting MSC controls

Zeng Heng (4):
  arm_mpam: Introduce the definitions of intPARTID and reqPARTID
  arm_mpam: Read monitor value with new closid/rmid pair
  arm_mpam: Automatically synchronize the configuration of all
    sub-monitoring groups
  arm_mpam: Adapting the closid/rmid matching determination functions

 arch/arm64/include/asm/mpam.h               |   6 +-
 drivers/platform/arm64/mpam/mpam_devices.c  |  61 +++++++--
 drivers/platform/arm64/mpam/mpam_internal.h |   5 +
 drivers/platform/arm64/mpam/mpam_resctrl.c  | 142 +++++++++++++++-----
 4 files changed, 170 insertions(+), 44 deletions(-)

--
2.25.1


