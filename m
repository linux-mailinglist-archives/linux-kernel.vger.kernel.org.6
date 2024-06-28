Return-Path: <linux-kernel+bounces-233284-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F3CB091B533
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 04:59:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 88C5F283D81
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 02:59:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96A5A1CD2D;
	Fri, 28 Jun 2024 02:59:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IduV4CMS"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5941F1103;
	Fri, 28 Jun 2024 02:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719543584; cv=none; b=jipJZyyJAITJt6SAqIgCWWyk2RS5jsB59UONx7YRCCxB8l6tbwLHr6dRmOjo98A9MpWnchuFzcKeV7iXAWrUIUQDTe5DtU6Y7CspQ/W0AcNDC/CAFK/q0XHKjMPwU7+HGTyQAotX/3KdHZT38O/WTaEtuON4WG8Zxe2dCNV3yks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719543584; c=relaxed/simple;
	bh=Ct68CjDqjgQwwhRKC3dSgVbAIcHqWopMZLbW3oBo1/M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qKqqt2KVhiWVNnbfohyeRz8HtMlZdHQf8C0VKT8DeSQHkh6CpMwVGNmKn7qAA+iQXKEGpnnCMZNTyVsOvH4cetVrPv1eWGwxkgI/WidwjfVTNfoTYGjwcuR5J9Gg9TYERgnokwZAfoqO7d75D07EHbn2vUJRh/YwdKtjGLQ3dV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IduV4CMS; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719543583; x=1751079583;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Ct68CjDqjgQwwhRKC3dSgVbAIcHqWopMZLbW3oBo1/M=;
  b=IduV4CMSjbHMEz21Kd+IgoCb/EnnnBty/vz5tUDe4xL2lG7RbDJikK/X
   kcrGv9oLeW9VCkzeTE0/VJun/7hlfaU0zjDl7FzmaGZNQIGO94G2ob9lJ
   G5UilMi6WSPf6sYVdgqiI4gi3dOHyPgrIDsjoWdpn2pApslnDIFwh9f3V
   M2bpYBneAbDfZf9dDzFB/tmyInsJC891ijxyOKno3gd/c/6Cs4Q00e3K4
   LN1YQFTJBwwDQ374GEriEiTXtKQCGrRtWqFCfXPiAfkAbVjgO9KZswOG4
   ynqC/wPVo2//nvPB1l9teKWsD9dMGfa7x7nmLhMJmc3DADJYL3XN29f2B
   g==;
X-CSE-ConnectionGUID: Usfsu4trSi6Qb1VqJLHP4Q==
X-CSE-MsgGUID: y22pk9hMSrWZ+40s0RU7lw==
X-IronPort-AV: E=McAfee;i="6700,10204,11116"; a="42129496"
X-IronPort-AV: E=Sophos;i="6.09,167,1716274800"; 
   d="scan'208";a="42129496"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jun 2024 19:59:42 -0700
X-CSE-ConnectionGUID: 7FsSgODLQjeimxLEseZANQ==
X-CSE-MsgGUID: lFAWz2uSS3eLIqtRvfglJg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,167,1716274800"; 
   d="scan'208";a="75340085"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by orviesa002.jf.intel.com with ESMTP; 27 Jun 2024 19:59:40 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sN1pp-000Gkd-1F;
	Fri, 28 Jun 2024 02:59:37 +0000
Date: Fri, 28 Jun 2024 10:59:16 +0800
From: kernel test robot <lkp@intel.com>
To: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>,
	Sudeep Holla <sudeep.holla@arm.com>,
	Cristian Marussi <cristian.marussi@arm.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, arm-scmi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH 2/2] firmware: arm_scmi: set mailbox timeout value from
 device tree
Message-ID: <202406281000.agOs4t8T-lkp@intel.com>
References: <20240621-scmi-mailbox-v1-v1-2-8ed450735f46@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240621-scmi-mailbox-v1-v1-2-8ed450735f46@nxp.com>

Hi Peng,

kernel test robot noticed the following build errors:

[auto build test ERROR on 76db4c64526c5e8ba0f56ad3d890dce8f9b00bbc]

url:    https://github.com/intel-lab-lkp/linux/commits/Peng-Fan-OSS/dt-bindings-firmware-arm-scmi-introduce-property-mbox-rx-timeout-ms/20240625-163117
base:   76db4c64526c5e8ba0f56ad3d890dce8f9b00bbc
patch link:    https://lore.kernel.org/r/20240621-scmi-mailbox-v1-v1-2-8ed450735f46%40nxp.com
patch subject: [PATCH 2/2] firmware: arm_scmi: set mailbox timeout value from device tree
config: i386-buildonly-randconfig-003-20240628 (https://download.01.org/0day-ci/archive/20240628/202406281000.agOs4t8T-lkp@intel.com/config)
compiler: gcc-13 (Ubuntu 13.2.0-4ubuntu3) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240628/202406281000.agOs4t8T-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202406281000.agOs4t8T-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/firmware/arm_scmi/raw_mode.c: In function 'scmi_xfer_raw_waiter_enqueue':
>> drivers/firmware/arm_scmi/raw_mode.c:382:42: error: 'struct scmi_raw_mode_info' has no member named 'max_rx_timeout_ms'
     382 |                                       raw->max_rx_timeout_ms,
         |                                          ^~
   drivers/firmware/arm_scmi/raw_mode.c: In function 'scmi_xfer_raw_worker':
   drivers/firmware/arm_scmi/raw_mode.c:440:39: error: 'struct scmi_raw_mode_info' has no member named 'max_rx_timeout_ms'
     440 |         max_tmo = msecs_to_jiffies(raw->max_rx_timeout_ms);
         |                                       ^~
   drivers/firmware/arm_scmi/raw_mode.c: In function 'scmi_xfer_raw_get_init':
   drivers/firmware/arm_scmi/raw_mode.c:577:35: error: 'struct scmi_raw_mode_info' has no member named 'max_rx_timeout_ms'
     577 |                         msleep(raw->max_rx_timeout_ms /
         |                                   ^~
   drivers/firmware/arm_scmi/raw_mode.c: In function 'scmi_raw_mode_init':
   drivers/firmware/arm_scmi/raw_mode.c:1193:12: error: 'struct scmi_raw_mode_info' has no member named 'max_rx_timeout_ms'
    1193 |         raw->max_rx_timeout_ms = max_rx_timeout_ms;
         |            ^~


vim +382 drivers/firmware/arm_scmi/raw_mode.c

   372	
   373	static void scmi_xfer_raw_waiter_enqueue(struct scmi_raw_mode_info *raw,
   374						 struct scmi_xfer_raw_waiter *rw)
   375	{
   376		/* A timestamp for the deferred worker to know how much this has aged */
   377		rw->start_jiffies = jiffies;
   378	
   379		trace_scmi_xfer_response_wait(rw->xfer->transfer_id, rw->xfer->hdr.id,
   380					      rw->xfer->hdr.protocol_id,
   381					      rw->xfer->hdr.seq,
 > 382					      raw->max_rx_timeout_ms,
   383					      rw->xfer->hdr.poll_completion);
   384	
   385		mutex_lock(&raw->active_mtx);
   386		list_add_tail(&rw->node, &raw->active_waiters);
   387		mutex_unlock(&raw->active_mtx);
   388	
   389		/* kick waiter work */
   390		queue_work(raw->wait_wq, &raw->waiters_work);
   391	}
   392	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

