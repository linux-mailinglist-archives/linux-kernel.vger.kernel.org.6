Return-Path: <linux-kernel+bounces-566896-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DB08AA67E05
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 21:30:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9DE7B3B6D10
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 20:29:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 831F12116FE;
	Tue, 18 Mar 2025 20:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lbB7rOiJ"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62D801DE4FE
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 20:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742329800; cv=none; b=BCvl0YnJs07EF/nDGFsE0Wz1oKquqwn6Ng4YCemdI+LIEK3SOc1f1VByEJJh7T2on/aqlotg/VgeKSu+yi1nh5OF24YRo8xwEulxAiu8tVgPgFsvFQ3G2jt91Dvcd3yAbL4BMtbWACZpWV36+7PVbg9mZ6ztkGrSwswMnGbT06I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742329800; c=relaxed/simple;
	bh=FYqLhIo5QrjyRe1xR2T64rrJDRQzI5b89y4rA9z9WIw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=eRixWcGJoh7KDE+me6ykAgTaC6Q+agLU3NezkiIjk6XegehJz0xSJbLFGAmuoaZ6r5EdfKqe07zftzFUba3iEy9MgINt68LsdwXQxplV1pY/dea5b8bxDpE3EgTlMp1ZJQ1Uo78hEMWARcEPnh/phccARW7GQQ5coLLmNBVaVwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lbB7rOiJ; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742329798; x=1773865798;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=FYqLhIo5QrjyRe1xR2T64rrJDRQzI5b89y4rA9z9WIw=;
  b=lbB7rOiJgP34KeOdrlqbcWNwUr6UFcEraU+ho5aFZrsbf+e1Vxh8l9hn
   poLrkF+Lh3arzzx471YYBzbrK/GBAceVdE50Zjm4+uoERWBS1ZNBwNcyw
   S2XvSC1y6sBXE2/mvCtyc+sxtmh22AnN3gw4PDIgiIBZlUq7xcvnDIAlQ
   Ka7qNrMzmxL9FVLlkZjzXZMTXAHQb/XUNJZTu2dkev/Vefw2HKTbCGs5n
   gYyMDuH2sOLNjX3S0Wnmz1nSYBbDTmgTaG4RV3UnZas3Ge34igAHX/xv1
   pvfAYIVZdpFhZ84jVA8Dp8SLEuKmvNl95fNwj+pt5oTf7WRTBVAQyrdQv
   Q==;
X-CSE-ConnectionGUID: qHGL68NRQjqKiRdXHIMsEg==
X-CSE-MsgGUID: pw4ZrbrQQeO1IoYcwMZoAw==
X-IronPort-AV: E=McAfee;i="6700,10204,11377"; a="54166338"
X-IronPort-AV: E=Sophos;i="6.14,258,1736841600"; 
   d="scan'208";a="54166338"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2025 13:29:57 -0700
X-CSE-ConnectionGUID: Rd596ZyXRx69fPPkLapzwA==
X-CSE-MsgGUID: jT0nPkaySHWy6wyobYG0tQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,258,1736841600"; 
   d="scan'208";a="145556422"
Received: from lkp-server02.sh.intel.com (HELO a4747d147074) ([10.239.97.151])
  by fmviesa002.fm.intel.com with ESMTP; 18 Mar 2025 13:29:56 -0700
Received: from kbuild by a4747d147074 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tudZR-000EA6-1l;
	Tue, 18 Mar 2025 20:29:53 +0000
Date: Wed, 19 Mar 2025 04:26:53 +0800
From: kernel test robot <lkp@intel.com>
To: Konrad Knitter <konrad.knitter@intel.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Marcin Szycik <marcin.szycik@linux.intel.com>,
	Sharon Haroni <sharon.haroni@intel.com>,
	Nicholas Nunley <nicholas.d.nunley@intel.com>,
	Brett Creeley <brett.creeley@intel.com>
Subject: drivers/net/ethernet/intel/ice/devlink/health.c:35:3: error:
 initializer element is not constant
Message-ID: <202503190404.sA5CPXty-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   81e4f8d68c66da301bb881862735bd74c6241a19
commit: 85d6164ec56deef2e5692cf8b132115f9317cdf6 ice: add fw and port health reporters
date:   9 weeks ago
config: sparc-allyesconfig (https://download.01.org/0day-ci/archive/20250319/202503190404.sA5CPXty-lkp@intel.com/config)
compiler: sparc64-linux-gcc (GCC) 7.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250319/202503190404.sA5CPXty-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202503190404.sA5CPXty-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/net/ethernet/intel/ice/devlink/health.c:35:3: error: initializer element is not constant
      ice_common_port_solutions, {ice_port_number_label}},
      ^~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/net/ethernet/intel/ice/devlink/health.c:35:3: note: (near initialization for 'ice_health_status_lookup[0].solution')
   drivers/net/ethernet/intel/ice/devlink/health.c:35:31: error: initializer element is not constant
      ice_common_port_solutions, {ice_port_number_label}},
                                  ^~~~~~~~~~~~~~~~~~~~~
   drivers/net/ethernet/intel/ice/devlink/health.c:35:31: note: (near initialization for 'ice_health_status_lookup[0].data_label[0]')
   drivers/net/ethernet/intel/ice/devlink/health.c:37:46: error: initializer element is not constant
      "Change or replace the module or cable.", {ice_port_number_label}},
                                                 ^~~~~~~~~~~~~~~~~~~~~
   drivers/net/ethernet/intel/ice/devlink/health.c:37:46: note: (near initialization for 'ice_health_status_lookup[1].data_label[0]')
   drivers/net/ethernet/intel/ice/devlink/health.c:39:3: error: initializer element is not constant
      ice_common_port_solutions, {ice_port_number_label}},
      ^~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/net/ethernet/intel/ice/devlink/health.c:39:3: note: (near initialization for 'ice_health_status_lookup[2].solution')
   drivers/net/ethernet/intel/ice/devlink/health.c:39:31: error: initializer element is not constant
      ice_common_port_solutions, {ice_port_number_label}},
                                  ^~~~~~~~~~~~~~~~~~~~~
   drivers/net/ethernet/intel/ice/devlink/health.c:39:31: note: (near initialization for 'ice_health_status_lookup[2].data_label[0]')
   drivers/net/ethernet/intel/ice/devlink/health.c:43:4: error: initializer element is not constant
      {ice_port_number_label}},
       ^~~~~~~~~~~~~~~~~~~~~
   drivers/net/ethernet/intel/ice/devlink/health.c:43:4: note: (near initialization for 'ice_health_status_lookup[3].data_label[0]')
   drivers/net/ethernet/intel/ice/devlink/health.c:46:4: error: initializer element is not constant
      {ice_port_number_label}},
       ^~~~~~~~~~~~~~~~~~~~~
   drivers/net/ethernet/intel/ice/devlink/health.c:46:4: note: (near initialization for 'ice_health_status_lookup[4].data_label[0]')
   drivers/net/ethernet/intel/ice/devlink/health.c:49:4: error: initializer element is not constant
      {ice_port_number_label}},
       ^~~~~~~~~~~~~~~~~~~~~
   drivers/net/ethernet/intel/ice/devlink/health.c:49:4: note: (near initialization for 'ice_health_status_lookup[5].data_label[0]')
   drivers/net/ethernet/intel/ice/devlink/health.c:52:4: error: initializer element is not constant
      {ice_port_number_label}},
       ^~~~~~~~~~~~~~~~~~~~~
   drivers/net/ethernet/intel/ice/devlink/health.c:52:4: note: (near initialization for 'ice_health_status_lookup[6].data_label[0]')
   drivers/net/ethernet/intel/ice/devlink/health.c:54:3: error: initializer element is not constant
      ice_common_port_solutions, {ice_port_number_label}},
      ^~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/net/ethernet/intel/ice/devlink/health.c:54:3: note: (near initialization for 'ice_health_status_lookup[7].solution')
   drivers/net/ethernet/intel/ice/devlink/health.c:54:31: error: initializer element is not constant
      ice_common_port_solutions, {ice_port_number_label}},
                                  ^~~~~~~~~~~~~~~~~~~~~
   drivers/net/ethernet/intel/ice/devlink/health.c:54:31: note: (near initialization for 'ice_health_status_lookup[7].data_label[0]')
   drivers/net/ethernet/intel/ice/devlink/health.c:56:10: error: initializer element is not constant
      NULL, {ice_port_number_label}},
             ^~~~~~~~~~~~~~~~~~~~~
   drivers/net/ethernet/intel/ice/devlink/health.c:56:10: note: (near initialization for 'ice_health_status_lookup[8].data_label[0]')
   drivers/net/ethernet/intel/ice/devlink/health.c:58:3: error: initializer element is not constant
      ice_update_nvm_solution, {ice_port_number_label}},
      ^~~~~~~~~~~~~~~~~~~~~~~
   drivers/net/ethernet/intel/ice/devlink/health.c:58:3: note: (near initialization for 'ice_health_status_lookup[9].solution')
   drivers/net/ethernet/intel/ice/devlink/health.c:58:29: error: initializer element is not constant
      ice_update_nvm_solution, {ice_port_number_label}},
                                ^~~~~~~~~~~~~~~~~~~~~
   drivers/net/ethernet/intel/ice/devlink/health.c:58:29: note: (near initialization for 'ice_health_status_lookup[9].data_label[0]')
   drivers/net/ethernet/intel/ice/devlink/health.c:63:4: error: initializer element is not constant
      {ice_port_number_label}},
       ^~~~~~~~~~~~~~~~~~~~~
   drivers/net/ethernet/intel/ice/devlink/health.c:63:4: note: (near initialization for 'ice_health_status_lookup[11].data_label[0]')
   drivers/net/ethernet/intel/ice/devlink/health.c:67:4: error: initializer element is not constant
      {ice_port_number_label}},
       ^~~~~~~~~~~~~~~~~~~~~
   drivers/net/ethernet/intel/ice/devlink/health.c:67:4: note: (near initialization for 'ice_health_status_lookup[12].data_label[0]')
   drivers/net/ethernet/intel/ice/devlink/health.c:70:50: error: initializer element is not constant
      "Change the module to align to port option.", {ice_port_number_label}},
                                                     ^~~~~~~~~~~~~~~~~~~~~
   drivers/net/ethernet/intel/ice/devlink/health.c:70:50: note: (near initialization for 'ice_health_status_lookup[13].data_label[0]')
   drivers/net/ethernet/intel/ice/devlink/health.c:72:3: error: initializer element is not constant
      ice_update_nvm_solution, {ice_port_number_label}},
      ^~~~~~~~~~~~~~~~~~~~~~~
   drivers/net/ethernet/intel/ice/devlink/health.c:72:3: note: (near initialization for 'ice_health_status_lookup[14].solution')
   drivers/net/ethernet/intel/ice/devlink/health.c:72:29: error: initializer element is not constant
      ice_update_nvm_solution, {ice_port_number_label}},
                                ^~~~~~~~~~~~~~~~~~~~~
   drivers/net/ethernet/intel/ice/devlink/health.c:72:29: note: (near initialization for 'ice_health_status_lookup[14].data_label[0]')
   drivers/net/ethernet/intel/ice/devlink/health.c:74:3: error: initializer element is not constant
      ice_update_nvm_solution, {ice_port_number_label}},
      ^~~~~~~~~~~~~~~~~~~~~~~
   drivers/net/ethernet/intel/ice/devlink/health.c:74:3: note: (near initialization for 'ice_health_status_lookup[15].solution')
   drivers/net/ethernet/intel/ice/devlink/health.c:74:29: error: initializer element is not constant
      ice_update_nvm_solution, {ice_port_number_label}},
                                ^~~~~~~~~~~~~~~~~~~~~
   drivers/net/ethernet/intel/ice/devlink/health.c:74:29: note: (near initialization for 'ice_health_status_lookup[15].data_label[0]')
   drivers/net/ethernet/intel/ice/devlink/health.c:78:3: error: initializer element is not constant
      ice_update_nvm_solution, {ice_port_number_label}},
      ^~~~~~~~~~~~~~~~~~~~~~~
   drivers/net/ethernet/intel/ice/devlink/health.c:78:3: note: (near initialization for 'ice_health_status_lookup[17].solution')
   drivers/net/ethernet/intel/ice/devlink/health.c:78:29: error: initializer element is not constant
      ice_update_nvm_solution, {ice_port_number_label}},
                                ^~~~~~~~~~~~~~~~~~~~~
   drivers/net/ethernet/intel/ice/devlink/health.c:78:29: note: (near initialization for 'ice_health_status_lookup[17].data_label[0]')
   drivers/net/ethernet/intel/ice/devlink/health.c:80:3: error: initializer element is not constant
      ice_update_nvm_solution, {ice_port_number_label}},
      ^~~~~~~~~~~~~~~~~~~~~~~
   drivers/net/ethernet/intel/ice/devlink/health.c:80:3: note: (near initialization for 'ice_health_status_lookup[18].solution')
   drivers/net/ethernet/intel/ice/devlink/health.c:80:29: error: initializer element is not constant
      ice_update_nvm_solution, {ice_port_number_label}},
                                ^~~~~~~~~~~~~~~~~~~~~
   drivers/net/ethernet/intel/ice/devlink/health.c:80:29: note: (near initialization for 'ice_health_status_lookup[18].data_label[0]')
   drivers/net/ethernet/intel/ice/devlink/health.c:82:3: error: initializer element is not constant


vim +35 drivers/net/ethernet/intel/ice/devlink/health.c

    32	
    33	static const struct ice_health_status ice_health_status_lookup[] = {
    34		{ICE_AQC_HEALTH_STATUS_ERR_UNKNOWN_MOD_STRICT, "An unsupported module was detected.",
  > 35			ice_common_port_solutions, {ice_port_number_label}},
    36		{ICE_AQC_HEALTH_STATUS_ERR_MOD_TYPE, "Module type is not supported.",
    37			"Change or replace the module or cable.", {ice_port_number_label}},
    38		{ICE_AQC_HEALTH_STATUS_ERR_MOD_QUAL, "Module is not qualified.",
    39			ice_common_port_solutions, {ice_port_number_label}},
    40		{ICE_AQC_HEALTH_STATUS_ERR_MOD_COMM,
    41			"Device cannot communicate with the module.",
    42			"Check your cable connection. Change or replace the module or cable. Manually set speed and duplex.",
    43			{ice_port_number_label}},
    44		{ICE_AQC_HEALTH_STATUS_ERR_MOD_CONFLICT, "Unresolved module conflict.",
    45			"Manually set speed/duplex or change the port option. If the problem persists, use a cable/module that is found in the supported modules and cables list for this device.",
    46			{ice_port_number_label}},
    47		{ICE_AQC_HEALTH_STATUS_ERR_MOD_NOT_PRESENT, "Module is not present.",
    48			"Check that the module is inserted correctly. If the problem persists, use a cable/module that is found in the supported modules and cables list for this device.",
    49			{ice_port_number_label}},
    50		{ICE_AQC_HEALTH_STATUS_INFO_MOD_UNDERUTILIZED, "Underutilized module.",
    51			"Change or replace the module or cable. Change the port option.",
    52			{ice_port_number_label}},
    53		{ICE_AQC_HEALTH_STATUS_ERR_UNKNOWN_MOD_LENIENT, "An unsupported module was detected.",
    54			ice_common_port_solutions, {ice_port_number_label}},
    55		{ICE_AQC_HEALTH_STATUS_ERR_INVALID_LINK_CFG, "Invalid link configuration.",
    56			NULL, {ice_port_number_label}},
    57		{ICE_AQC_HEALTH_STATUS_ERR_PORT_ACCESS, "Port hardware access error.",
    58			ice_update_nvm_solution, {ice_port_number_label}},
    59		{ICE_AQC_HEALTH_STATUS_ERR_PORT_UNREACHABLE, "A port is unreachable.",
    60			"Change the port option. Update to the latest NVM image."},
    61		{ICE_AQC_HEALTH_STATUS_INFO_PORT_SPEED_MOD_LIMITED, "Port speed is limited due to module.",
    62			"Change the module or configure the port option to match the current module speed. Change the port option.",
    63			{ice_port_number_label}},
    64		{ICE_AQC_HEALTH_STATUS_ERR_PARALLEL_FAULT,
    65			"All configured link modes were attempted but failed to establish link. The device will restart the process to establish link.",
    66			"Check link partner connection and configuration.",
    67			{ice_port_number_label}},
    68		{ICE_AQC_HEALTH_STATUS_INFO_PORT_SPEED_PHY_LIMITED,
    69			"Port speed is limited by PHY capabilities.",
    70			"Change the module to align to port option.", {ice_port_number_label}},
    71		{ICE_AQC_HEALTH_STATUS_ERR_NETLIST_TOPO, "LOM topology netlist is corrupted.",
    72			ice_update_nvm_solution, {ice_port_number_label}},
    73		{ICE_AQC_HEALTH_STATUS_ERR_NETLIST, "Unrecoverable netlist error.",
    74			ice_update_nvm_solution, {ice_port_number_label}},
    75		{ICE_AQC_HEALTH_STATUS_ERR_TOPO_CONFLICT, "Port topology conflict.",
    76			"Change the port option. Update to the latest NVM image."},
    77		{ICE_AQC_HEALTH_STATUS_ERR_LINK_HW_ACCESS, "Unrecoverable hardware access error.",
    78			ice_update_nvm_solution, {ice_port_number_label}},
    79		{ICE_AQC_HEALTH_STATUS_ERR_LINK_RUNTIME, "Unrecoverable runtime error.",
    80			ice_update_nvm_solution, {ice_port_number_label}},
    81		{ICE_AQC_HEALTH_STATUS_ERR_DNL_INIT, "Link management engine failed to initialize.",
    82			ice_update_nvm_solution, {ice_port_number_label}},
    83		{ICE_AQC_HEALTH_STATUS_ERR_PHY_FW_LOAD,
    84			"Failed to load the firmware image in the external PHY.",
    85			ice_update_nvm_solution, {ice_port_number_label}},
    86		{ICE_AQC_HEALTH_STATUS_INFO_RECOVERY, "The device is in firmware recovery mode.",
    87			ice_update_nvm_solution, {"Extended Error"}},
    88		{ICE_AQC_HEALTH_STATUS_ERR_FLASH_ACCESS, "The flash chip cannot be accessed.",
    89			"If issue persists, call customer support.", {"Access Type"}},
    90		{ICE_AQC_HEALTH_STATUS_ERR_NVM_AUTH, "NVM authentication failed.",
    91			ice_update_nvm_solution},
    92		{ICE_AQC_HEALTH_STATUS_ERR_OROM_AUTH, "Option ROM authentication failed.",
    93			ice_update_nvm_solution},
    94		{ICE_AQC_HEALTH_STATUS_ERR_DDP_AUTH, "DDP package authentication failed.",
    95			"Update to latest base driver and DDP package."},
    96		{ICE_AQC_HEALTH_STATUS_ERR_NVM_COMPAT, "NVM image is incompatible.",
    97			ice_update_nvm_solution},
    98		{ICE_AQC_HEALTH_STATUS_ERR_OROM_COMPAT, "Option ROM is incompatible.",
    99			ice_update_nvm_solution, {"Expected PCI Device ID", "Expected Module ID"}},
   100		{ICE_AQC_HEALTH_STATUS_ERR_DCB_MIB,
   101			"Supplied MIB file is invalid. DCB reverted to default configuration.",
   102			"Disable FW-LLDP and check DCBx system configuration.",
   103			{ice_port_number_label, "MIB ID"}},
   104	};
   105	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

