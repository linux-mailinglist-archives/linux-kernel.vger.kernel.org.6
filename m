Return-Path: <linux-kernel+bounces-516938-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F9ABA379FF
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 04:09:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0E2893A76B2
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 03:09:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77C0014F102;
	Mon, 17 Feb 2025 03:09:10 +0000 (UTC)
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ED0E14830A
	for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 03:09:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739761750; cv=none; b=aeRnBKwwVNDyxYMNVPjIuq+8IZxhppwyjd6X6azA9FwqvM0pFlX8FeHpKXewnrX411dT50RYA2jmJbWFN87vLb2lyBsv88R18uido77Er0gBjfoMOVPnUt84u0GPuWWYoxSP2T/54txu0omigeXEbn606tb52JMPjY12h4OgY+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739761750; c=relaxed/simple;
	bh=mnxv4uruKG94OeYTxTdEXWKkc0IoPegk3ozmrk4bw9U=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=SeT9yOxN1J7I2QyYRSSmCPi9tMz/VyvWJcEy1Nw7XnU7YI5GCiBVbgBJg22tfsvX8pbBOT/d+G3iq8XjrbNVAQt3DfswRIFT8+Gez87esqFz0hgn6AOaX1iJtxaJd4CxW3XUoVWtJkkQ2EMPM82q2ucSTS6NvEhcgjhdhyKgsl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4Yx6xB3STfz22sww;
	Mon, 17 Feb 2025 11:06:06 +0800 (CST)
Received: from kwepemf100008.china.huawei.com (unknown [7.202.181.222])
	by mail.maildlp.com (Postfix) with ESMTPS id 5A7A21A0188;
	Mon, 17 Feb 2025 11:09:04 +0800 (CST)
Received: from huawei.com (10.175.103.91) by kwepemf100008.china.huawei.com
 (7.202.181.222) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 17 Feb
 2025 11:09:03 +0800
From: Zeng Heng <zengheng4@huawei.com>
To: <Dave.Martin@arm.com>, <james.morse@arm.com>
CC: <bobo.shaobowang@huawei.com>, <linux-kernel@vger.kernel.org>,
	<jonathan.cameron@huawei.com>, <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH mpam mpam/snapshot/v6.14-rc1 0/5] arm_mpam: Introduce the Narrow-PARTID feature for MPAM driver
Date: Mon, 17 Feb 2025 11:18:47 +0800
Message-ID: <20250217031852.2014939-1-zengheng4@huawei.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
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

In order to keep the existing resctrl API interface, the rmid contains both
req_idx and PMG information instead of PMG only under the MPAM driver. The
req_idx represents the req_idx-th sub-monitoring group under the control
group. The new rmid would be like:

    rmid = (req_idx << shift | pmg).

The new conversion relationship between closid/rmid and (req)PARTID/PMG is:

    (req)PARTID = (rmid.req_idx * n) + closid
    PMG = rmid.pmg

Each intPARTID has m reqPARTIDs, which are used to expand the number of
monitoring groups under one control group. Therefore, the number of
monitoring groups is no longer limited by the range of MPAM PMG, which
enhances the extensibility of the system's monitoring capabilities.

---
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
  - Refactor closid/rmid pair translation
  - Simplify the logic of synchronize configuration
  - Remove reqPARTID source bitmap

Compared with RFC-v1:
  - Rebase this patch set on latest MPAM driver of the v6.12-rc1 branch.
---

Dave Martin (1):
  arm_mpam: Set INTERNAL as needed when setting MSC controls

Zeng Heng (4):
  arm_mpam: Introduce the definitions of intPARTID and reqPARTID
  arm_mpam: Add limitation for the Narrow-PARTID feature
  arm_mpam: Provide conversion method for new closid/rmid pairs
  arm_mpam: Automatically synchronize the configuration of all
    sub-monitoring groups

 drivers/platform/arm64/mpam/mpam_devices.c  |  61 ++++++--
 drivers/platform/arm64/mpam/mpam_internal.h |   5 +
 drivers/platform/arm64/mpam/mpam_resctrl.c  | 157 ++++++++++++++------
 3 files changed, 172 insertions(+), 51 deletions(-)

--
2.25.1


