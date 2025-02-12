Return-Path: <linux-kernel+bounces-511064-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B83CA3254A
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 12:50:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4C13F188A073
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 11:50:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0ADA120B1E3;
	Wed, 12 Feb 2025 11:49:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="UY1vuHyh"
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E11920A5EE;
	Wed, 12 Feb 2025 11:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739360987; cv=none; b=mMMoNrvJQ6imunEB4HvRegrRWKa6io3aMwBONE2+AMsyZPp1+SNrK2m8huvfXyXjKDmK6VcVWeaFopNopBhWfniJcn4fig9RJC7IYLTevFmSykLwu4S/2KEq8xmDFYudUlFaQyV7+AUHm2W270d0Bx7gFopv40EfoTivAPWCvjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739360987; c=relaxed/simple;
	bh=efZbEN5VQGU9GNNYmboFpDs+LUnSjVwRvkbfTOq5sDw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=jwSgIL4VgqzorxwC+2tMAbMHuzEms+CaPa/IDhvNtoVwnGrQJIEQs8i3uF28vCdQ9679+fSLRZKzJ8d/jSd0JF/TFQCZgAPnLbmV+y2zZy0yP2/7kaqRHfU3qhpB5dAS6h6xb8Z1u888k8/UmWMgNBJbDJt2IZu89iXYq1FMAyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=UY1vuHyh; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51CAi2N8008420;
	Wed, 12 Feb 2025 03:49:32 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pfpt0220; bh=diCFLpm9wwGN8BtsuEDbSY3
	81ASSh6O4E3ny6a9IRXE=; b=UY1vuHyh/esvQPCbXT4G2msIlxHso0j52KNanRA
	MTq0w798G3oZYQPj/9h1tG/Tz2wTKXlxBailP/qHQyB2O5xsKg6aouhrm1rSszH6
	eIDTWcNJPrD7+sbCOoSWu5DWo7gYkJcADQtQEdpUdZ7ZaqAg6o+QgHLxkSpX2zCq
	TDRXlBar0CwT2j5DPm/6n5hel6qwai7/m+U4b5z1AU8VCAgAf+FTXxg8Vpo9Kfdf
	AEz9Mj0Jywr4G2RDziD+VIqeWystRsGQTbV7e5UpbWikMteE9RlXv6Co+bXXt0YH
	JBRr3+ZCgwwED2HP7mbP1vQrSBxFzPJ0VHfE28SYTm+4tvg==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 44rn8c8mmw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Feb 2025 03:49:31 -0800 (PST)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Wed, 12 Feb 2025 03:49:30 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Wed, 12 Feb 2025 03:49:30 -0800
Received: from virtx40.. (unknown [10.28.34.196])
	by maili.marvell.com (Postfix) with ESMTP id 85B485B693C;
	Wed, 12 Feb 2025 03:49:26 -0800 (PST)
From: Linu Cherian <lcherian@marvell.com>
To: <suzuki.poulose@arm.com>, <mike.leach@linaro.org>, <james.clark@arm.com>
CC: <linux-arm-kernel@lists.infradead.org>, <coresight@lists.linaro.org>,
        <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <corbet@lwn.net>, <devicetree@vger.kernel.org>, <sgoutham@marvell.com>,
        <gcherian@marvell.com>, Linu Cherian <lcherian@marvell.com>
Subject: [PATCH v14 0/8] Coresight for Kernel panic and watchdog reset
Date: Wed, 12 Feb 2025 17:19:10 +0530
Message-ID: <20250212114918.548431-1-lcherian@marvell.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: KgrdpqPRvKOlDG_PXkVJwJvVGckKx6vc
X-Proofpoint-GUID: KgrdpqPRvKOlDG_PXkVJwJvVGckKx6vc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-12_04,2025-02-11_01,2024-11-22_01

This patch series is rebased on coresight-next-v6.13.rc2

* Patches 1 & 2 adds support for allocation of trace buffer pages from
  reserved RAM
* Patches 3 & 4 adds support for saving metadata at the time of kernel panic 
* Patch 5 adds support for reading trace data captured at the time of panic
* Patches 6 & 7 adds support for disabling coresight blocks at the time of
  panic
* Patch 8: Gives the full description about this feature as part of
  documentation 

v13 is posted here,
https://lore.kernel.org/linux-arm-kernel/20241216053014.3427909-1-lcherian@marvell.com/

Changelog from v13:
* Changed the log levels of crc error check failure prints from dev_dbg to
  dev_err as suggested by Suzuki 
* Add metadata valid flag checks for successfully opening crashdata files,
  as suggested by Suzuki
* Report to the user during probe if valid crash tracedata is found,
  as suggested by Suzuki
* Added CRC recalculation upon barrier packet insertion for overflow
  cases, this fixes crc check failures upon subsequent boots
* Few other trivial cleanups suggested by Suzuki

Changelog from v12:
* Fixed wrong buffer pointer passed to coresigh_insert_barrier_packet  
* tmc_read_prepare/unprepare_crashdata need to be called only once and
  hence removed from read path and added to tmc_probe
* tmc_read_prepare_crashdata renamed to tmc_prepare_crashdata and
  avoid taking locks  as its moved to probe function.
* Introduced read status flag, "reading" specific to reserved buffer to keep the
  reserved buffer reading independent of the regular buffer.
* open/release ops for reserved buffer has to take care only about the
  set/unset the "reading" status flag as the reserved buffer is prepared
  during the probe time itself.  
* Few other trivial changes  

Changelog from v11:
Convert all commands to literal code blocks, that was missed out in v11.
No other code changes.

Changelog from v10:
* Converted all csdev_access_* to readl functions in tmc_panic_sync_*
* Added "tmc" prefix for register snapshots in struct tmc_crash_metadata
* Converted dev_info to dev_dbg in panic handlers 
* Converted dsb to dmb in panic handlers 
* Fixed marking metadata as invalid when a user is trying to use the
  reserved buffer. Earlier this was wrongly set at the time of reading
  reserved trace buffer.
* Moved common validation checks to is_tmc_crashdata_valid and minor
  code rearrangements for efficiency
* Got rid of sink specific prepare/unprepare invocations  
* Got rid of full from struct tmc_resrv_buf
* While reading crashdata, size is now calculated from metadata instead 
  of relying on reserved buffer size populated by dtb 
* Minor documenation fixes

Changelog from v9:
* Add common helper function of_tmc_get_reserved_resource_by_name
  for better code reuse
* Reserved buffer validity and crashdata validity has been separated to
  avoid interdependence
* New fields added to crash metadata: version, ffcr, ffsr, mode
* Version checks added for metadata validation
* Special file /dev/crash_tmc_xxx would be available only when
  crash metadata is valid
* Removed READ_CRASHDATA mode meant for special casing crashdata reads.
  Instead, dedicated read function added for crashdata reads from reserved
  buffer which is common for both ETR and ETF sinks as well.
* Documentation added to Documentation/tracing/coresight/panic.rst

Changelog from v8:
* Added missing exit path on error in __tmc_probe.
* Few whitespace fixes, checkpatch fixes.
* With perf sessions honouring stop_on_flush sysfs attribute, 
  removed redundant variable stop_on_flush_en. 

Changelog from v7:
* Fixed breakage on perf test -vvvv  "arm coresight".
  No issues seen with and without "resrv" buffer mode
* Moved the crashdev registration into a separate function.
* Removed redundant variable in tmc_etr_setup_crashdata_buf
* Avoided a redundant memcpy in tmc_panic_sync_etf.
* Tested kernel panic with trace session started uisng perf.   
  Please see the title "Perf based testing" below for details.
  For this, stop_on_flush sysfs attribute is taken into 
  consideration while starting perf sessions as well. 

Changelog from v6:
* Added special device files for reading crashdata, so that
  read_prevboot mode flag is removed. 
* Added new sysfs TMC device attribute, stop_on_flush.
  Stop on flush trigger event is disabled by default. 
  User need to explicitly enable this from sysfs for panic stop
  to work.
* Address parameter for panicstop ETM configuration is   
  chosen as kernel "panic" address by default.
* Added missing tmc_wait_for_tmcready during panic handling
* Few other misc code rearrangements. 

Changelog from v5:
* Fixed issues reported by CONFIG_DEBUG_ATOMIC_SLEEP
* Fixed a memory leak while reading data from /dev/tmc_etrx in
  READ_PREVBOOT mode
* Tested reading trace data from crashdump kernel

Changelog from v4:
* Device tree binding
  - Description is made more explicit on the usage of reserved memory
    region
  - Mismatch in memory region names in dts binding and driver fixed
  - Removed "mem" suffix from the memory region names
* Rename "struct tmc_register_snapshot" ->  "struct tmc_crash_metadata",
  since it contains more than register snapshot.
  Related variables are named accordingly.
* Rename struct tmc_drvdata members
   resrv_buf -> crash_tbuf
   metadata  -> crash_mdata
* Size field in metadata refers to RSZ register and hence indicates the
  size in 32 bit words. ETR metadata follows this convention, the same
  has been extended to ETF metadata as well.
* Added crc32 for more robust metadata and tracedata validation.
* Added/modified dev_dbg messages during metadata validation
* Fixed a typo in patch 5 commit description

Changelog from v3:
* Converted the Coresight ETM driver change to a named configuration.
  RFC tag has been removed with this change.
* Fixed yaml issues reported by "make dt_binding_check"
* Added names for reserved memory regions 0 and 1
* Added prevalidation checks for metadata processing
* Fixed a regression introduced in RFC v3
  - TMC Status register was getting saved wrongly
* Reverted memremap attribute changes from _WB to _WC to match
  with the dma map attributes
* Introduced reserved buffer mode specific .sync op.
  This fixes a possible crash when reserved buffer mode was used in
  normal trace capture, due to unwanted dma maintenance operations.

  
Linu Cherian (8):
  dt-bindings: arm: coresight-tmc: Add "memory-region" property
  coresight: tmc-etr: Add support to use reserved trace memory
  coresight: core: Add provision for panic callbacks
  coresight: tmc: Enable panic sync handling
  coresight: tmc: Add support for reading crash data
  coresight: tmc: Stop trace capture on FlIn
  coresight: config: Add preloaded configuration
  Documentation: coresight: Panic support

 .../bindings/arm/arm,coresight-tmc.yaml       |  26 ++
 Documentation/trace/coresight/panic.rst       | 362 ++++++++++++++++++
 drivers/hwtracing/coresight/Makefile          |   2 +-
 .../coresight/coresight-cfg-preload.c         |   2 +
 .../coresight/coresight-cfg-preload.h         |   2 +
 .../hwtracing/coresight/coresight-cfg-pstop.c |  83 ++++
 drivers/hwtracing/coresight/coresight-core.c  |  42 ++
 .../hwtracing/coresight/coresight-tmc-core.c  | 321 +++++++++++++++-
 .../hwtracing/coresight/coresight-tmc-etf.c   |  92 ++++-
 .../hwtracing/coresight/coresight-tmc-etr.c   | 184 ++++++++-
 drivers/hwtracing/coresight/coresight-tmc.h   | 105 +++++
 include/linux/coresight.h                     |  12 +
 12 files changed, 1221 insertions(+), 12 deletions(-)
 create mode 100644 Documentation/trace/coresight/panic.rst
 create mode 100644 drivers/hwtracing/coresight/coresight-cfg-pstop.c

-- 
2.34.1


