Return-Path: <linux-kernel+bounces-425376-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90CC49DC13D
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 10:13:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E8E42B23FD2
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 09:13:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C19316DEDF;
	Fri, 29 Nov 2024 09:13:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="Nh8MyWTQ"
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8CCC170A15;
	Fri, 29 Nov 2024 09:13:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732871596; cv=none; b=o13ulheFsc66vqmPpkd+dacvGgm1P2aUArv+Ii2a0tYTdRXimU8hRQmW7KklJCSihQwRxxmhvsJ7cFn7ASrmTVS6Fx9R1EpiG/HPbzcRm3A8Z9DPdUOYq1rPjaQu7XpCBc0ypp0oK7c3Ino87ehkQJtzlSS9byWWDC+clGlaqlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732871596; c=relaxed/simple;
	bh=gf9f49tviEAzV4fvUAEwrimuRbxrjsaGei4k5zUY64Y=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pe2H+CXNiXiZCggvXwuoBI2LRKlF4AFMq4umv27vqrU+Q1vi8x7ooh131dKOLXn8N6B3itImqecQ2W07OnZX74eL9bBvyofvXs2xY0v/i1LcpscSgamITg6c8U4zPbkNghfXgVEGGrHwwMI1MFzL1QfmlNPISSQjcCpesKyLPiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=Nh8MyWTQ; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AT12tr8032173;
	Fri, 29 Nov 2024 01:13:02 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pfpt0220; bh=OOEqDqIyVktPaA1eakQuPDXEQ
	1AB2rfzBRUEWU0hoI0=; b=Nh8MyWTQNN0U1DJeo8hj0wSZGQ+RUz5Vh5vqRwc/E
	u+OUpMmnZuxe0hkfBrvRnK4Abm1wVzWj6LoMwKBaBVi9Z1l3RQN7TTwQjqbWUJgR
	6wtvRw9MfSFLyR/M7aaEtY1ZNPz1GP08QE2JtZO3Ac2rMKz5K8154i9N2NRrI4Go
	YHkMjGtQ2Zw9rHvXHO49eiFha73B+BdJ3ixGOhxBlvCoaGdA+vlNxnLRr2RMbTep
	h/4B60d4GoYnuHspH6ThRgCtKdMGKZezkdM90zL8Kp2XQNbS/YGra1aZlOkMji7H
	8pps43N72NB81osiqDBZ5+Me1AZNtiQigvbKNu8QaYZng==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4373jv0qhs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 29 Nov 2024 01:13:02 -0800 (PST)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Fri, 29 Nov 2024 01:13:01 -0800
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Fri, 29 Nov 2024 01:13:01 -0800
Received: from hyd1403.caveonetworks.com (unknown [10.29.37.84])
	by maili.marvell.com (Postfix) with SMTP id 12D795C68E3;
	Fri, 29 Nov 2024 01:12:56 -0800 (PST)
Date: Fri, 29 Nov 2024 14:42:55 +0530
From: Linu Cherian <lcherian@marvell.com>
To: <suzuki.poulose@arm.com>, <mike.leach@linaro.org>, <james.clark@arm.com>
CC: <linux-arm-kernel@lists.infradead.org>, <coresight@lists.linaro.org>,
        <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <corbet@lwn.net>, <devicetree@vger.kernel.org>, <sgoutham@marvell.com>,
        <gcherian@marvell.com>
Subject: Re: [PATCH v12 0/8] Coresight for Kernel panic and watchdog reset
Message-ID: <20241129091255.GA1150491@hyd1403.caveonetworks.com>
References: <20241129084714.3057080-1-lcherian@marvell.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20241129084714.3057080-1-lcherian@marvell.com>
X-Proofpoint-ORIG-GUID: sDqqnwTgwogyxTdadwkaEuKDWOlnLppZ
X-Proofpoint-GUID: sDqqnwTgwogyxTdadwkaEuKDWOlnLppZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01

Hi,

On 2024-11-29 at 14:17:06, Linu Cherian (lcherian@marvell.com) wrote:
> This patch series is rebased on coresight-next-v6.12.rc4
> 
> * Patches 1 & 2 adds support for allocation of trace buffer pages from reserved RAM
> * Patches 3 & 4 adds support for saving metadata at the time of kernel panic 
> * Patch 5 adds support for reading trace data captured at the time of panic
> * Patches 6 & 7 adds support for disabling coresight blocks at the time of panic
> * Patch 8: Gives the full description about this feature as part of documentation 
> 
> V11 is posted here,
> https://lore.kernel.org/linux-arm-kernel/20241111124746.2210378-1-lcherian@marvell.com/
> 
> Changelog from v11:
> Convert all commands to literal code blocks, that was missed out in v11.
> No other code changes.

To make it clear, this is just some missed out fixes in Patch 8,
Documentation.

> 
> Changelog from v10:
> * Converted all csdev_access_* to readl functions in tmc_panic_sync_*
> * Added "tmc" prefix for register snapshots in struct tmc_crash_metadata
> * Converted dev_info to dev_dbg in panic handlers 
> * Converted dsb to dmb in panic handlers 
> * Fixed marking metadata as invalid when a user is trying to use the
>   reserved buffer. Earlier this was wrongly set at the time of reading
>   reserved trace buffer.
> * Moved common validation checks to is_tmc_crashdata_valid and minor
>   code rearrangements for efficiency
> * Got rid of sink specific prepare/unprepare invocations  
> * Got rid of full from struct tmc_resrv_buf
> * While reading crashdata, size is now calculated from metdata instead 
>   of relying on reserved buffer size populated by dtb 
> * Minor documenation fixes
> 
> Changelog from v9:
> * Add common helper function of_tmc_get_reserved_resource_by_name
>   for better code reuse
> * Reserved buffer validity and crashdata validity has been separated to
>   avoid interdependence
> * New fields added to crash metadata: version, ffcr, ffsr, mode
> * Version checks added for metadata validation
> * Special file /dev/crash_tmc_xxx would be available only when
>   crash metadata is valid
> * Removed READ_CRASHDATA mode meant for special casing crashdata reads.
>   Instead, dedicated read function added for crashdata reads from reserved
>   buffer which is common for both ETR and ETF sinks as well.
> * Documentation added to Documentation/tracing/coresight/panic.rst
> 
> Changelog from v8:
> * Added missing exit path on error in __tmc_probe.
> * Few whitespace fixes, checkpatch fixes.
> * With perf sessions honouring stop_on_flush sysfs attribute, 
>   removed redundant variable stop_on_flush_en. 
> 
> Changelog from v7:
> * Fixed breakage on perf test -vvvv  "arm coresight".
>   No issues seen with and without "resrv" buffer mode
> * Moved the crashdev registration into a separate function.
> * Removed redundant variable in tmc_etr_setup_crashdata_buf
> * Avoided a redundant memcpy in tmc_panic_sync_etf.
> * Tested kernel panic with trace session started uisng perf.   
>   Please see the title "Perf based testing" below for details.
>   For this, stop_on_flush sysfs attribute is taken into 
>   consideration while starting perf sessions as well. 
> 
> Changelog from v6:
> * Added special device files for reading crashdata, so that
>   read_prevboot mode flag is removed. 
> * Added new sysfs TMC device attribute, stop_on_flush.
>   Stop on flush trigger event is disabled by default. 
>   User need to explicitly enable this from sysfs for panic stop
>   to work.
> * Address parameter for panicstop ETM configuration is   
>   chosen as kernel "panic" address by default.
> * Added missing tmc_wait_for_tmcready during panic handling
> * Few other misc code rearrangements. 
> 
> Changelog from v5:
> * Fixed issues reported by CONFIG_DEBUG_ATOMIC_SLEEP
> * Fixed a memory leak while reading data from /dev/tmc_etrx in
>   READ_PREVBOOT mode
> * Tested reading trace data from crashdump kernel
> 
> Changelog from v4:
> * Device tree binding
>   - Description is made more explicit on the usage of reserved memory
>     region
>   - Mismatch in memory region names in dts binding and driver fixed
>   - Removed "mem" suffix from the memory region names
> * Rename "struct tmc_register_snapshot" ->  "struct tmc_crash_metadata",
>   since it contains more than register snapshot.
>   Related variables are named accordingly.
> * Rename struct tmc_drvdata members
>    resrv_buf -> crash_tbuf
>    metadata  -> crash_mdata
> * Size field in metadata refers to RSZ register and hence indicates the
>   size in 32 bit words. ETR metadata follows this convention, the same
>   has been extended to ETF metadata as well.
> * Added crc32 for more robust metadata and tracedata validation.
> * Added/modified dev_dbg messages during metadata validation
> * Fixed a typo in patch 5 commit description
> 
> Changelog from v3:
> * Converted the Coresight ETM driver change to a named configuration.
>   RFC tag has been removed with this change.
> * Fixed yaml issues reported by "make dt_binding_check"
> * Added names for reserved memory regions 0 and 1
> * Added prevalidation checks for metadata processing
> * Fixed a regression introduced in RFC v3
>   - TMC Status register was getting saved wrongly
> * Reverted memremap attribute changes from _WB to _WC to match
>   with the dma map attributes
> * Introduced reserved buffer mode specific .sync op.
>   This fixes a possible crash when reserved buffer mode was used in
>   normal trace capture, due to unwanted dma maintenance operations.
> 
> 
> 
>  
> Linu Cherian (8):
>   dt-bindings: arm: coresight-tmc: Add "memory-region" property
>   coresight: tmc-etr: Add support to use reserved trace memory
>   coresight: core: Add provision for panic callbacks
>   coresight: tmc: Enable panic sync handling
>   coresight: tmc: Add support for reading crash data
>   coresight: tmc: Stop trace capture on FlIn
>   coresight: config: Add preloaded configuration
>   Documentation: coresight: Panic support
> 
>  .../bindings/arm/arm,coresight-tmc.yaml       |  26 ++
>  Documentation/trace/coresight/panic.rst       | 362 ++++++++++++++++++
>  drivers/hwtracing/coresight/Makefile          |   2 +-
>  .../coresight/coresight-cfg-preload.c         |   2 +
>  .../coresight/coresight-cfg-preload.h         |   2 +
>  .../hwtracing/coresight/coresight-cfg-pstop.c |  83 ++++
>  drivers/hwtracing/coresight/coresight-core.c  |  42 ++
>  .../hwtracing/coresight/coresight-tmc-core.c  | 326 +++++++++++++++-
>  .../hwtracing/coresight/coresight-tmc-etf.c   |  92 ++++-
>  .../hwtracing/coresight/coresight-tmc-etr.c   | 181 ++++++++-
>  drivers/hwtracing/coresight/coresight-tmc.h   | 104 +++++
>  include/linux/coresight.h                     |  12 +
>  12 files changed, 1222 insertions(+), 12 deletions(-)
>  create mode 100644 Documentation/trace/coresight/panic.rst
>  create mode 100644 drivers/hwtracing/coresight/coresight-cfg-pstop.c
> 
> -- 
> 2.34.1
> 
> 

