Return-Path: <linux-kernel+bounces-330502-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 45085979F6A
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 12:35:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 303B4B23396
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 10:35:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04F7F15534B;
	Mon, 16 Sep 2024 10:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="FFdO/att"
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4446154C18;
	Mon, 16 Sep 2024 10:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726482917; cv=none; b=Z4kByEA7ZStes3DiDcT7kK+be/29lDj5TsB93zXMoXSQHfsIiOHjPn5oW65nNyhjjG3wGDxvMdBJZsMNvh5AR7x+HPozHWfnJ6X3Ujf2jylb3aw/1aj1Wi6vi8gAwKByxsyqG3fG5/EDkqTmg0PtXGxEp97wz1BIe+YU0xQopEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726482917; c=relaxed/simple;
	bh=20qsj4m1DPQ+/ZDMLLZxIdaw/hQ/nP4PxruNqxKGFIo=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=DYxbVqiflj6D/YD2taVtkthZHd11rQ7ynwnzwPVlQf6uORPXElMMvxzjbJVzf4l7EtxNsHlbQZyM+ZMgAx8HNk4PgQRARg55ct/yj9DqqLPhvQxCe5FN7i59jObJgPPfD7691hOkGpar6qRqe5RPhTQi+zcdVvcahv48g2i3Jlk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=FFdO/att; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48GA0QaD024628;
	Mon, 16 Sep 2024 03:34:51 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pfpt0220; bh=gUdewsYTg5kNQwINFdOpoCt
	8+cBKcqpcXykI+k/2fRE=; b=FFdO/atte8kvwQkTqYCVIE7ALmOwL0m/Edxuz41
	XUfSvruuHWvjSOlV3VHPFzxJRSYAptmJEkMQt/+8oG8xLqPsXFaSUlr/rCnAJ7Df
	bRc6e0J/fqxBSnK5TYRytpnx/p91aHFnCBNSsIWrr1xr7u6Ad/6/rjXebqZ/TzJJ
	+J4yrklCYMMqdWtb0XPTFL0UkoIE4+xnJLOdHXogDnlkdhu6JIjXS7MYCISW+hNw
	uYUfs+wzW/ZhTvhyBmxC5Gx2VweuQDh0mgYG96TGkC7ciWT7Di6jrcnlyumbVwfv
	utZZ3DbEMadoBbHUksLLbDtlBuwEjURWWCllo58uhWuddeA==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 41n7ujnd9t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 16 Sep 2024 03:34:50 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Mon, 16 Sep 2024 03:34:49 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Mon, 16 Sep 2024 03:34:49 -0700
Received: from virtx40.. (unknown [10.28.34.196])
	by maili.marvell.com (Postfix) with ESMTP id 41B213F704A;
	Mon, 16 Sep 2024 03:34:45 -0700 (PDT)
From: Linu Cherian <lcherian@marvell.com>
To: <suzuki.poulose@arm.com>, <mike.leach@linaro.org>, <james.clark@arm.com>
CC: <linux-arm-kernel@lists.infradead.org>, <coresight@lists.linaro.org>,
        <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <corbet@lwn.net>, <devicetree@vger.kernel.org>, <sgoutham@marvell.com>,
        <gcherian@marvell.com>, Linu Cherian <lcherian@marvell.com>
Subject: [PATCH v10 0/8] Coresight for Kernel panic and watchdog reset
Date: Mon, 16 Sep 2024 16:04:29 +0530
Message-ID: <20240916103437.226816-1-lcherian@marvell.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: UxWg_Zc5P0_kRgQNtx6jkYl4t9jKAjP8
X-Proofpoint-ORIG-GUID: UxWg_Zc5P0_kRgQNtx6jkYl4t9jKAjP8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01

This patch series is rebased on coresight-next-v6.12.

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

   *** SUBJECT HERE ***

*** BLURB HERE ***

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
 Documentation/trace/coresight/panic.rst       | 356 ++++++++++++++++++
 drivers/hwtracing/coresight/Makefile          |   2 +-
 .../coresight/coresight-cfg-preload.c         |   2 +
 .../coresight/coresight-cfg-preload.h         |   2 +
 .../hwtracing/coresight/coresight-cfg-pstop.c |  83 ++++
 drivers/hwtracing/coresight/coresight-core.c  |  42 +++
 .../hwtracing/coresight/coresight-tmc-core.c  | 296 ++++++++++++++-
 .../hwtracing/coresight/coresight-tmc-etf.c   | 124 +++++-
 .../hwtracing/coresight/coresight-tmc-etr.c   | 231 +++++++++++-
 drivers/hwtracing/coresight/coresight-tmc.h   | 106 ++++++
 include/linux/coresight.h                     |  24 ++
 12 files changed, 1282 insertions(+), 12 deletions(-)
 create mode 100644 Documentation/trace/coresight/panic.rst
 create mode 100644 drivers/hwtracing/coresight/coresight-cfg-pstop.c

-- 
2.34.1


