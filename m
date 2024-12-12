Return-Path: <linux-kernel+bounces-443320-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 389C89EED36
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 16:43:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 821AA16A0BD
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 15:40:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F74B2210FE;
	Thu, 12 Dec 2024 15:40:29 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA1F1218587
	for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 15:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734018029; cv=none; b=UQBlhF3WZkYqrqk1OJCYQOlq2a3umqvezNREsyzIoOwKTS9s0kP9l/mJvjflS9F8/4AEFKwdCuuTpDNdlZebqtsM0npMUsgrfEJ8eTkO8sN0lR/p01ZA3MdPVZgOI0pmYUzg6qHoeh3LkXn2jE7ltDOw6KmhZhaLACeyIpzTQkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734018029; c=relaxed/simple;
	bh=LxFuKOGtUZ57KWIF0MRDZcGpFnCBLPOed9rSDSFKV2Y=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=beT6Mvmfc6+c9JUgaCnvyBe0wiWj8TuH/owt63rnEP5FKPeXzyK2lDA4z4buRIoFUDHhLlG4VckRd5GVr7ihc8C3jWIgMaZQYJX76xd/skKlwwoVYz/1m4HgZkj0I7dEiKlG7r1JrmSnEtl7Cl+aBOyC5aWZNXVQ38jEidQWI2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 089901762;
	Thu, 12 Dec 2024 07:40:53 -0800 (PST)
Received: from e133380.cambridge.arm.com (e133380.arm.com [10.1.197.41])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E8BF93F720;
	Thu, 12 Dec 2024 07:40:23 -0800 (PST)
From: Dave Martin <Dave.Martin@arm.com>
To: linux-kernel@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org,
	Zeng Heng <zengheng4@huawei.com>,
	Shaopeng Tan <tan.shaopeng@fujitsu.com>,
	James Morse <james.morse@arm.com>
Subject: [RFC PATCH 0/6] Introduce flexible CLOSID/RMID translation
Date: Thu, 12 Dec 2024 15:39:54 +0000
Message-Id: <20241212154000.330467-1-Dave.Martin@arm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series introduces an ID remapping scheme, as a preparatory step
towards improved support for MPAM hardware that implements the MPAM
PARTID Narrowing feature.

This series is not a complete implementation, but is sufficient to
provide additional resctrl monitoring groups beyond the number of PMGs
supported by the hardware (with some limitations; see "Limitations",
below).

Based on:
git://git.kernel.org/pub/scm/linux/kernel/git/morse/linux.git mpam/snapshot/v6.12-rc1


Background
==========

An MPAM Memory System Component (MSC) that does not implement the
PARTID Narrowing feature (Narrowing) provides independently
programmable resource controls for each PARTID up to the maximum PARTID
that the MSC supports.

An MSC that _does_ implement Narrowing performs a remapping step to
convert the PARTID from the incoming memory transaction ("request
PARTID", or "reqPARTID") to an internal ID ("internal PARTID", or
"intPARTID") before looking up and applying resource controls.  Such an
MSC does not necessarily need to provide the same number of
independently programmable resource control partitions (indexed by the
intPARTID) as that which the size of the supported PARTID ("reqPARTID")
space would otherwise require.  Instead, independently programmable
resource controls are provided for each intPARTID, accompanied by a
software programmable mapping that allows each reqPARTID to be mapped
independently to a selected intPARTID.

Typically, the number of intPARTIDs supported by a Narrowing MSC is
smaller than the number of reqPARTIDs.  Narrowing permits multiple
reqPARTIDs to be mapped to each intPARTID, so allowing the whole MPAM
PARTID space to be served.

A non-Narrowing MSC can be understood as implementing special case of
Narrowing, where the reqPARTID-to-intPARTID mapping is the identity
function and is not programmable.


The number of independently configurable control partitions at a given
MSC cannot exceed the number of intPARTIDs available, so the number of
resctrl CLOSIDs (which need to be independently controllable) must
typically be limited not to exceed the maximum number of intPARTIDs
available on any Narrowing MSC.

However, the presence of a programmable reqPARTID-to-intPARTID mapping
in each MSC creates an opportunity: because a group of multiple MPAM
PARTIDs can be mapped onto the same controls, they behave as a single
resource control partition.  Because the PARTID is used as a match
criterion for monitoring purposes along with the MPAM Performance
Monitoring Group (PMG) identifier assigned each memory system
transaction, the specific PARTID in the group can be used to
distinguish transactions for monitoring purposes, even within the same
resctrl control group and when the PMGs of the transactions are the
same.

This means that it becomes possible to provide a larger number of
resctrl monitoring groups than the number of PMGs supported by the MPAM
hardware implementation.


In order to take advantage of this, a more flexible mapping scheme is
required for mapping resctrl CLOSIDs and RMIDs to MPAM PARTIDs and PMGs
than the current MPAM driver provides.

Similar approaches have been suggested by other people
(see Acknowledgements).

However, since I was already working on this, I'm posting my approach
for comparison.


This Series
===========

This series introduces a remapping scheme as follows:

1) The resctrl partition identifiers are combined into a single
identifier (formally the Cartesian product of the CLOSID, Code/Data
partition where applicable, and RMID ID spaces).

2) The resulting identifier is then broken down into the MPAM PARTID
and PMG, in such a way that each possible <CLOSID, CDP index, RMID>
maps to a unique <PARTID, PMG> pair and vice versa, and so that any two
<PARTID, PMG> that differ only in the PMG value, map onto the same
<CLOSID, CDP index> pair.


This transformation could be done in intuitive way using bitwise
concatenation, shift and masking operations, but since the size of the
MPAM hardware ID spaces may limited, I have tried to generalise this
approach using multiplication in place of bit-shifts, to permit ID
spaces whose size is not a power of two.


Limitations
===========

This series aims to contain all translations within the mpam_resctrl.c
code.  This seems the most sensible place for it, since this is a
conversion scheme that will be used to interface the MPAM hardware with
the resctrl core code (but has nothing to do with the "pure" MPAM
architecture or the resctrl core code itself).

To simplify the interface between mpam_resctrl.c and mpam_devices.c,
the ID conversion scheme is arranged so that each resctrl CLOSID maps
to a contiguous sequence of MPAM PARTIDs.  This means that programming
controls for a CLOSID can be achieved by iterating over the appropriate
range of PARTIDs.

No change is made to program the reqPARTID-to-intPARTID mappings, so
the number of MPAM PARTIDs in use continues to be limited not to exceed
the maximum number of intPARTIDs available, for now.

Because a CLOSID may be fragmented across multiple PARTIDs, this series
will cause certain types of resource control to be applied incorrectly
to each individual PARTID instead of the whole resctrl control group.

Future patches will need to program the intPARTID mappings
appropriately and/or disable certain controls in order to restore the
expected regulation behaviour as seen by users of resctrl.


Patches
=======

Patches 1-3 are pending fixes / cleanups for the MPAM branch.  They
have nothing directly to do with this series, but I don't want to
maintain two versions of my development branch.  This seems as a good a
time as any to post them.

Patch 4 implements the ID remapping scheme.

Following these are two development patches which may be useful to
reviewers:

Patch 5 adds a kernel command-line parameter mpam.partid_per_closid=<n>
to allow the number of PARTIDs to map to each CLOSID.  This is intended
to be temporary, but since the patches contain no logic for choosing
this parameter, allowing it to be specified on the kernel command line
makes it easier to experiment with different configurations.

Patch 6 adds some debug printks to show how MPAM PARTIDs / PMGs are
actually being assigned, and shows when each MSC is reprogrammed.
Since we don't want to create unintentional ABI exposing these IDs, I
don't expect this to be upstreamed in any form.


Acknowledgements
================

Thanks to Shaopeng Tan for pointing out this opportunity and suggesting
a related idea, and to Zeng Heng who has also implemented something
similar. [1], [2], [3]


References
==========

Zeng Heng <zengheng4@huawei.com>:

[1] (v3) arm_mpam: Introduce the Narrow-PARTID feature for MPAM driver
https://lore.kernel.org/linux-arm-kernel/20241207092136.2488426-1-zengheng4@huawei.com/

[2] (v2) arm_mpam: Introduce the Narrow-PARTID feature for MPAM driver
https://lore.kernel.org/linux-arm-kernel/20241119135104.595630-1-zengheng4@huawei.com/

[3] (v1) arm_mpam: Introduce the definitions of intPARTID and reqPARTID
https://lore.kernel.org/linux-arm-kernel/20241114135037.918470-1-zengheng4@huawei.com/



Dave Martin (6):
  arm_mpam: Clean up config update checks in mpam_apply_config()
  arm_mpam: Fix read-back of cloned resource controls under CDP
    emulation
  arm_mpam: Delete unused function resctrl_arch_set_rmid()
  arm_mpam: Introduce flexible CLOSID/RMID translation
  arm_mpam: [NFU] Rework ID remapping to use a kernel command-line
    argument
  arm_mpam: [NFU] Development diagnostics for MPAM ID assignments

 arch/arm64/include/asm/mpam.h              |  21 +-
 drivers/platform/arm64/mpam/mpam_devices.c |  29 +++
 drivers/platform/arm64/mpam/mpam_resctrl.c | 214 +++++++++++++--------
 3 files changed, 168 insertions(+), 96 deletions(-)


base-commit: 4d17b37b670795954fd7a70c8ec83fb705a5e2ad
-- 
2.34.1


