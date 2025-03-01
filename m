Return-Path: <linux-kernel+bounces-540092-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A7A21A4AD8E
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Mar 2025 20:46:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3FD1518963E1
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Mar 2025 19:46:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30D221E47C5;
	Sat,  1 Mar 2025 19:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="H3e5t1h9"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 368B01C3BE9
	for <linux-kernel@vger.kernel.org>; Sat,  1 Mar 2025 19:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740858380; cv=none; b=iYwEuiu9M3QrlDZ3Bg3QBuYs2N7g6FM5Pwtd67PVWL5PBFgRZeqLmWiEU1qJHWBmgw8ywCCipaKYq9wpR1+/m6Q2TFLjYEAk0e+NMqQ+X+mcLlIr0e1ueFxsA/yg03JmZW0XvGDDyJgOcXG0MvEX7irX1hddRQfWNTrLC/JYWpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740858380; c=relaxed/simple;
	bh=qxk/1IErP7ezHpBzvYsFraep9e+fs/CSKLgfqHjW7rI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=HhVylvO0yW0ke53pVyzhW9zaB/PxcO4a45S7vXSYeCFdFDQtVk6hwAGHEMKqHTgP/OYT0aNSzyc1d/f2SaW0xOswjmA4SVsXc4wWP8fxK+ePVi/pSVYxE/puczDCObB/ifTqibFSDI0W4djzRiRcsJ6PzHjrWI7OeQ+hyQPRsLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=H3e5t1h9; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740858378; x=1772394378;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=qxk/1IErP7ezHpBzvYsFraep9e+fs/CSKLgfqHjW7rI=;
  b=H3e5t1h964xZ0KCjpIfdDz390fT3XRJGPskueq0R9dSlc2PcojeNgnBQ
   SjfccsgxrqWF02su84+0h9fqqHdc6EvChfFSH6dZxcZIc4M54ju5iK9qK
   l0F9bjyQ2YHkfPNr3iJnx58pHoj/47P/Xty0RMQMOghXtuLY6MI6GstKL
   cq1RVYip66ReXKEK/ImEVg8TZ90zq6ROFa9JxAG8pBemKxZPZ/BTVhE6U
   9aDDLf6oDBb/LS5hC5di4Va0MOn0xI3gdqDlVOei9EViF4C1ziCD1cW9K
   Eb5szdtkdmnHcAUDKTafSQ+PPMX5dXH5A7RSbQ1FHNPdq+uY96Lq+qjEJ
   Q==;
X-CSE-ConnectionGUID: j5GMZEcIQjuubjd0neTXQw==
X-CSE-MsgGUID: FWhMW/nNT06Nk7Kfqb2D8g==
X-IronPort-AV: E=McAfee;i="6700,10204,11360"; a="52401018"
X-IronPort-AV: E=Sophos;i="6.13,326,1732608000"; 
   d="scan'208";a="52401018"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2025 11:46:18 -0800
X-CSE-ConnectionGUID: vjKGDmTQQcS5DsKVKDaTrQ==
X-CSE-MsgGUID: uI4mbYQxToC7kxqNQfcaQQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,326,1732608000"; 
   d="scan'208";a="122638182"
Received: from lkp-server02.sh.intel.com (HELO 76cde6cc1f07) ([10.239.97.151])
  by orviesa004.jf.intel.com with ESMTP; 01 Mar 2025 11:46:14 -0800
Received: from kbuild by 76cde6cc1f07 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1toSmm-000GdT-0m;
	Sat, 01 Mar 2025 19:46:09 +0000
Date: Sun, 2 Mar 2025 03:44:29 +0800
From: kernel test robot <lkp@intel.com>
To: Mike Snitzer <snitzer@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Matthew Sakai <msakai@redhat.com>
Subject: drivers/md/dm-vdo/dm-vdo-target.c:1157: warning: Function parameter
 or struct member 'vdo' not described in 'get_thread_id_for_phase'
Message-ID: <202503020324.YOfRr9xp-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Mike,

First bad commit (maybe != root cause):

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   03d38806a902b36bf364cae8de6f1183c0a35a67
commit: f36b1d3ba533d21b5b793623f05761b0297d114e dm vdo: use a proper Makefile for dm-vdo
date:   1 year ago
config: x86_64-randconfig-161-20241019 (https://download.01.org/0day-ci/archive/20250302/202503020324.YOfRr9xp-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250302/202503020324.YOfRr9xp-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202503020324.YOfRr9xp-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/md/dm-vdo/action-manager.c:64: warning: Function parameter or struct member 'scheduler' not described in 'action_manager'
>> drivers/md/dm-vdo/action-manager.c:64: warning: Excess struct member 'Scheduler' description in 'action_manager'
--
>> drivers/md/dm-vdo/admin-state.c:159: warning: Function parameter or struct member 'state' not described in 'get_next_state'
>> drivers/md/dm-vdo/admin-state.c:159: warning: Function parameter or struct member 'operation' not described in 'get_next_state'
>> drivers/md/dm-vdo/admin-state.c:198: warning: Function parameter or struct member 'state' not described in 'vdo_finish_operation'
>> drivers/md/dm-vdo/admin-state.c:198: warning: Function parameter or struct member 'result' not described in 'vdo_finish_operation'
>> drivers/md/dm-vdo/admin-state.c:226: warning: Function parameter or struct member 'state' not described in 'begin_operation'
>> drivers/md/dm-vdo/admin-state.c:226: warning: Function parameter or struct member 'operation' not described in 'begin_operation'
>> drivers/md/dm-vdo/admin-state.c:226: warning: Function parameter or struct member 'waiter' not described in 'begin_operation'
>> drivers/md/dm-vdo/admin-state.c:226: warning: Function parameter or struct member 'initiator' not described in 'begin_operation'
>> drivers/md/dm-vdo/admin-state.c:271: warning: Function parameter or struct member 'state' not described in 'start_operation'
>> drivers/md/dm-vdo/admin-state.c:271: warning: Function parameter or struct member 'operation' not described in 'start_operation'
>> drivers/md/dm-vdo/admin-state.c:271: warning: Function parameter or struct member 'waiter' not described in 'start_operation'
>> drivers/md/dm-vdo/admin-state.c:271: warning: Function parameter or struct member 'initiator' not described in 'start_operation'
>> drivers/md/dm-vdo/admin-state.c:288: warning: Function parameter or struct member 'valid' not described in 'check_code'
>> drivers/md/dm-vdo/admin-state.c:288: warning: Function parameter or struct member 'code' not described in 'check_code'
>> drivers/md/dm-vdo/admin-state.c:288: warning: Function parameter or struct member 'what' not described in 'check_code'
>> drivers/md/dm-vdo/admin-state.c:288: warning: Function parameter or struct member 'waiter' not described in 'check_code'
>> drivers/md/dm-vdo/admin-state.c:310: warning: Function parameter or struct member 'operation' not described in 'assert_vdo_drain_operation'
>> drivers/md/dm-vdo/admin-state.c:310: warning: Function parameter or struct member 'waiter' not described in 'assert_vdo_drain_operation'
   drivers/md/dm-vdo/admin-state.c:310: warning: expecting prototype for vdo_drain_operation(). Prototype was for assert_vdo_drain_operation() instead
>> drivers/md/dm-vdo/admin-state.c:325: warning: Function parameter or struct member 'state' not described in 'vdo_start_draining'
>> drivers/md/dm-vdo/admin-state.c:325: warning: Function parameter or struct member 'operation' not described in 'vdo_start_draining'
   drivers/md/dm-vdo/admin-state.c:325: warning: Function parameter or struct member 'waiter' not described in 'vdo_start_draining'
   drivers/md/dm-vdo/admin-state.c:325: warning: Function parameter or struct member 'initiator' not described in 'vdo_start_draining'
   drivers/md/dm-vdo/admin-state.c:352: warning: Function parameter or struct member 'state' not described in 'vdo_finish_draining'
   drivers/md/dm-vdo/admin-state.c:362: warning: Function parameter or struct member 'state' not described in 'vdo_finish_draining_with_result'
   drivers/md/dm-vdo/admin-state.c:362: warning: Function parameter or struct member 'result' not described in 'vdo_finish_draining_with_result'
   drivers/md/dm-vdo/admin-state.c:374: warning: Function parameter or struct member 'operation' not described in 'vdo_assert_load_operation'
   drivers/md/dm-vdo/admin-state.c:374: warning: Function parameter or struct member 'waiter' not described in 'vdo_assert_load_operation'
   drivers/md/dm-vdo/admin-state.c:389: warning: Function parameter or struct member 'state' not described in 'vdo_start_loading'
   drivers/md/dm-vdo/admin-state.c:389: warning: Function parameter or struct member 'operation' not described in 'vdo_start_loading'
   drivers/md/dm-vdo/admin-state.c:389: warning: Function parameter or struct member 'waiter' not described in 'vdo_start_loading'
   drivers/md/dm-vdo/admin-state.c:389: warning: Function parameter or struct member 'initiator' not described in 'vdo_start_loading'
   drivers/md/dm-vdo/admin-state.c:400: warning: Function parameter or struct member 'state' not described in 'vdo_finish_loading'
   drivers/md/dm-vdo/admin-state.c:411: warning: Function parameter or struct member 'state' not described in 'vdo_finish_loading_with_result'
   drivers/md/dm-vdo/admin-state.c:411: warning: Function parameter or struct member 'result' not described in 'vdo_finish_loading_with_result'
   drivers/md/dm-vdo/admin-state.c:423: warning: Function parameter or struct member 'operation' not described in 'assert_vdo_resume_operation'
   drivers/md/dm-vdo/admin-state.c:423: warning: Function parameter or struct member 'waiter' not described in 'assert_vdo_resume_operation'
   drivers/md/dm-vdo/admin-state.c:439: warning: Function parameter or struct member 'state' not described in 'vdo_start_resuming'
   drivers/md/dm-vdo/admin-state.c:439: warning: Function parameter or struct member 'operation' not described in 'vdo_start_resuming'
   drivers/md/dm-vdo/admin-state.c:439: warning: Function parameter or struct member 'waiter' not described in 'vdo_start_resuming'
   drivers/md/dm-vdo/admin-state.c:439: warning: Function parameter or struct member 'initiator' not described in 'vdo_start_resuming'
   drivers/md/dm-vdo/admin-state.c:450: warning: Function parameter or struct member 'state' not described in 'vdo_finish_resuming'
   drivers/md/dm-vdo/admin-state.c:461: warning: Function parameter or struct member 'state' not described in 'vdo_finish_resuming_with_result'
   drivers/md/dm-vdo/admin-state.c:461: warning: Function parameter or struct member 'result' not described in 'vdo_finish_resuming_with_result'
   drivers/md/dm-vdo/admin-state.c:472: warning: Function parameter or struct member 'state' not described in 'vdo_resume_if_quiescent'
   drivers/md/dm-vdo/admin-state.c:487: warning: Function parameter or struct member 'state' not described in 'vdo_start_operation'
   drivers/md/dm-vdo/admin-state.c:487: warning: Function parameter or struct member 'operation' not described in 'vdo_start_operation'
   drivers/md/dm-vdo/admin-state.c:502: warning: Function parameter or struct member 'state' not described in 'vdo_start_operation_with_waiter'
   drivers/md/dm-vdo/admin-state.c:502: warning: Function parameter or struct member 'operation' not described in 'vdo_start_operation_with_waiter'
   drivers/md/dm-vdo/admin-state.c:502: warning: Function parameter or struct member 'waiter' not described in 'vdo_start_operation_with_waiter'
   drivers/md/dm-vdo/admin-state.c:502: warning: Function parameter or struct member 'initiator' not described in 'vdo_start_operation_with_waiter'
--
>> drivers/md/dm-vdo/block-map.c:183: warning: Function parameter or struct member 'cache' not described in 'initialize_info'
>> drivers/md/dm-vdo/block-map.c:222: warning: Function parameter or struct member 'cache' not described in 'allocate_cache_components'
   drivers/md/dm-vdo/block-map.c:222: warning: Excess function parameter 'maximum_age' description in 'allocate_cache_components'
>> drivers/md/dm-vdo/block-map.c:248: warning: Function parameter or struct member 'cache' not described in 'assert_on_cache_thread'
>> drivers/md/dm-vdo/block-map.c:248: warning: Function parameter or struct member 'function_name' not described in 'assert_on_cache_thread'
>> drivers/md/dm-vdo/block-map.c:284: warning: Function parameter or struct member 'state' not described in 'get_page_state_name'
>> drivers/md/dm-vdo/block-map.c:351: warning: Function parameter or struct member 'info' not described in 'set_info_state'
>> drivers/md/dm-vdo/block-map.c:351: warning: Function parameter or struct member 'new_state' not described in 'set_info_state'
>> drivers/md/dm-vdo/block-map.c:427: warning: Function parameter or struct member 'cache' not described in 'find_free_page'
>> drivers/md/dm-vdo/block-map.c:446: warning: Function parameter or struct member 'cache' not described in 'find_page'
>> drivers/md/dm-vdo/block-map.c:465: warning: Function parameter or struct member 'cache' not described in 'select_lru_page'
>> drivers/md/dm-vdo/block-map.c:537: warning: Function parameter or struct member 'info' not described in 'distribute_page_over_waitq'
>> drivers/md/dm-vdo/block-map.c:537: warning: Function parameter or struct member 'waitq' not described in 'distribute_page_over_waitq'
>> drivers/md/dm-vdo/block-map.c:562: warning: Function parameter or struct member 'cache' not described in 'set_persistent_error'
>> drivers/md/dm-vdo/block-map.c:562: warning: Function parameter or struct member 'result' not described in 'set_persistent_error'
>> drivers/md/dm-vdo/block-map.c:594: warning: Function parameter or struct member 'completion' not described in 'validate_completed_page'
>> drivers/md/dm-vdo/block-map.c:769: warning: Function parameter or struct member 'info' not described in 'launch_page_load'
>> drivers/md/dm-vdo/block-map.c:769: warning: Function parameter or struct member 'pbn' not described in 'launch_page_load'
>> drivers/md/dm-vdo/block-map.c:846: warning: Function parameter or struct member 'info' not described in 'schedule_page_save'
>> drivers/md/dm-vdo/block-map.c:862: warning: Function parameter or struct member 'info' not described in 'launch_page_save'
>> drivers/md/dm-vdo/block-map.c:877: warning: Function parameter or struct member 'waiter' not described in 'completion_needs_page'
   drivers/md/dm-vdo/block-map.c:888: warning: Function parameter or struct member 'info' not described in 'allocate_free_page'
   drivers/md/dm-vdo/block-map.c:940: warning: Function parameter or struct member 'cache' not described in 'discard_a_page'
   drivers/md/dm-vdo/block-map.c:966: warning: Function parameter or struct member 'vdo_page_comp' not described in 'discard_page_for_completion'
   drivers/md/dm-vdo/block-map.c:1148: warning: Function parameter or struct member 'completion' not described in 'vdo_release_page_completion'
   drivers/md/dm-vdo/block-map.c:1188: warning: Function parameter or struct member 'info' not described in 'load_page_for_completion'
   drivers/md/dm-vdo/block-map.c:1188: warning: Function parameter or struct member 'vdo_page_comp' not described in 'load_page_for_completion'
   drivers/md/dm-vdo/block-map.c:1335: warning: Function parameter or struct member 'cache' not described in 'vdo_invalidate_page_cache'
   drivers/md/dm-vdo/block-map.c:1362: warning: Function parameter or struct member 'forest' not described in 'get_tree_page_by_index'
   drivers/md/dm-vdo/block-map.c:1362: warning: Function parameter or struct member 'root_index' not described in 'get_tree_page_by_index'
   drivers/md/dm-vdo/block-map.c:1362: warning: Function parameter or struct member 'height' not described in 'get_tree_page_by_index'
   drivers/md/dm-vdo/block-map.c:1362: warning: Function parameter or struct member 'page_index' not described in 'get_tree_page_by_index'
   drivers/md/dm-vdo/block-map.c:2226: warning: Function parameter or struct member 'data_vio' not described in 'vdo_find_block_map_slot'
   drivers/md/dm-vdo/block-map.c:2451: warning: Function parameter or struct member 'map' not described in 'make_forest'
   drivers/md/dm-vdo/block-map.c:2489: warning: Function parameter or struct member 'map' not described in 'replace_forest'
   drivers/md/dm-vdo/block-map.c:2505: warning: Function parameter or struct member 'cursor' not described in 'finish_cursor'
   drivers/md/dm-vdo/block-map.c:2564: warning: Function parameter or struct member 'cursor' not described in 'traverse'
   drivers/md/dm-vdo/block-map.c:2637: warning: Function parameter or struct member 'waiter' not described in 'launch_cursor'
   drivers/md/dm-vdo/block-map.c:2653: warning: Function parameter or struct member 'map' not described in 'compute_boundary'
   drivers/md/dm-vdo/block-map.c:2653: warning: Function parameter or struct member 'root_index' not described in 'compute_boundary'
   drivers/md/dm-vdo/block-map.c:2686: warning: Function parameter or struct member 'map' not described in 'vdo_traverse_forest'
   drivers/md/dm-vdo/block-map.c:2728: warning: Function parameter or struct member 'map' not described in 'initialize_block_map_zone'
   drivers/md/dm-vdo/block-map.c:2728: warning: Function parameter or struct member 'zone_number' not described in 'initialize_block_map_zone'
   drivers/md/dm-vdo/block-map.c:2728: warning: Function parameter or struct member 'vdo' not described in 'initialize_block_map_zone'
   drivers/md/dm-vdo/block-map.c:2728: warning: Function parameter or struct member 'cache_size' not described in 'initialize_block_map_zone'
   drivers/md/dm-vdo/block-map.c:3109: warning: Function parameter or struct member 'data_vio' not described in 'clear_mapped_location'
   drivers/md/dm-vdo/block-map.c:3124: warning: Function parameter or struct member 'data_vio' not described in 'set_mapped_location'
   drivers/md/dm-vdo/block-map.c:3124: warning: Function parameter or struct member 'entry' not described in 'set_mapped_location'
--
>> drivers/md/dm-vdo/completion.c:72: warning: Function parameter or struct member 'completion' not described in 'vdo_set_completion_result'
>> drivers/md/dm-vdo/completion.c:72: warning: Function parameter or struct member 'result' not described in 'vdo_set_completion_result'
>> drivers/md/dm-vdo/completion.c:88: warning: Function parameter or struct member 'completion' not described in 'vdo_launch_completion_with_priority'
>> drivers/md/dm-vdo/completion.c:133: warning: Function parameter or struct member 'completion' not described in 'vdo_requeue_completion_if_needed'
>> drivers/md/dm-vdo/completion.c:133: warning: Function parameter or struct member 'callback_thread_id' not described in 'vdo_requeue_completion_if_needed'
--
>> drivers/md/dm-vdo/data-vio.c:233: warning: Function parameter or struct member 'pool' not described in 'check_for_drain_complete_locked'
   drivers/md/dm-vdo/data-vio.c:342: warning: Function parameter or struct member 'data_vio' not described in 'set_data_vio_compression_status'
   drivers/md/dm-vdo/data-vio.c:342: warning: Function parameter or struct member 'status' not described in 'set_data_vio_compression_status'
   drivers/md/dm-vdo/data-vio.c:342: warning: Function parameter or struct member 'new_status' not described in 'set_data_vio_compression_status'
   drivers/md/dm-vdo/data-vio.c:342: warning: Excess function parameter 'state' description in 'set_data_vio_compression_status'
   drivers/md/dm-vdo/data-vio.c:342: warning: Excess function parameter 'new_state' description in 'set_data_vio_compression_status'
>> drivers/md/dm-vdo/data-vio.c:394: warning: Function parameter or struct member 'data_vio' not described in 'cancel_data_vio_compression'
>> drivers/md/dm-vdo/data-vio.c:487: warning: Function parameter or struct member 'data_vio' not described in 'launch_data_vio'
>> drivers/md/dm-vdo/data-vio.c:487: warning: Function parameter or struct member 'lbn' not described in 'launch_data_vio'
>> drivers/md/dm-vdo/data-vio.c:660: warning: Function parameter or struct member 'pool' not described in 'schedule_releases'
>> drivers/md/dm-vdo/data-vio.c:788: warning: Function parameter or struct member 'data_vio' not described in 'initialize_data_vio'
>> drivers/md/dm-vdo/data-vio.c:788: warning: Function parameter or struct member 'vdo' not described in 'initialize_data_vio'
   drivers/md/dm-vdo/data-vio.c:844: warning: Function parameter or struct member 'pool_ptr' not described in 'make_data_vio_pool'
   drivers/md/dm-vdo/data-vio.c:844: warning: Excess function parameter 'pool' description in 'make_data_vio_pool'
>> drivers/md/dm-vdo/data-vio.c:898: warning: Function parameter or struct member 'pool' not described in 'free_data_vio_pool'
>> drivers/md/dm-vdo/data-vio.c:959: warning: Function parameter or struct member 'pool' not described in 'vdo_launch_bio'
>> drivers/md/dm-vdo/data-vio.c:959: warning: Function parameter or struct member 'bio' not described in 'vdo_launch_bio'
>> drivers/md/dm-vdo/data-vio.c:1004: warning: Function parameter or struct member 'pool' not described in 'drain_data_vio_pool'
>> drivers/md/dm-vdo/data-vio.c:1015: warning: Function parameter or struct member 'pool' not described in 'resume_data_vio_pool'
>> drivers/md/dm-vdo/data-vio.c:1034: warning: Function parameter or struct member 'pool' not described in 'dump_data_vio_pool'
>> drivers/md/dm-vdo/data-vio.c:1152: warning: Function parameter or struct member 'completion' not described in 'release_allocated_lock'
>> drivers/md/dm-vdo/data-vio.c:1232: warning: Function parameter or struct member 'completion' not described in 'release_logical_lock'
>> drivers/md/dm-vdo/data-vio.c:1269: warning: Function parameter or struct member 'data_vio' not described in 'finish_cleanup'
>> drivers/md/dm-vdo/data-vio.c:1378: warning: Function parameter or struct member 'data_vio' not described in 'get_data_vio_operation_name'
>> drivers/md/dm-vdo/data-vio.c:1398: warning: Function parameter or struct member 'data_vio' not described in 'data_vio_allocate_data_block'
>> drivers/md/dm-vdo/data-vio.c:1418: warning: Function parameter or struct member 'data_vio' not described in 'release_data_vio_allocation_lock'
>> drivers/md/dm-vdo/data-vio.c:1438: warning: Function parameter or struct member 'data_vio' not described in 'uncompress_data_vio'
   drivers/md/dm-vdo/data-vio.c:1557: warning: Function parameter or struct member 'completion' not described in 'read_block'
   drivers/md/dm-vdo/data-vio.c:1714: warning: Function parameter or struct member 'completion' not described in 'read_old_block_mapping'
   drivers/md/dm-vdo/data-vio.c:1742: warning: Function parameter or struct member 'completion' not described in 'pack_compressed_data'
   drivers/md/dm-vdo/data-vio.c:1763: warning: Function parameter or struct member 'completion' not described in 'compress_data_vio'
   drivers/md/dm-vdo/data-vio.c:1792: warning: Function parameter or struct member 'data_vio' not described in 'launch_compress_data_vio'
   drivers/md/dm-vdo/data-vio.c:1830: warning: bad line: 
   drivers/md/dm-vdo/data-vio.c:1834: warning: Function parameter or struct member 'completion' not described in 'hash_data_vio'
   drivers/md/dm-vdo/data-vio.c:1868: warning: Function parameter or struct member 'bio' not described in 'write_bio_finished'
   drivers/md/dm-vdo/data-vio.c:1922: warning: Function parameter or struct member 'completion' not described in 'acknowledge_write_callback'
   drivers/md/dm-vdo/data-vio.c:1947: warning: Function parameter or struct member 'completion' not described in 'allocate_block'
   drivers/md/dm-vdo/data-vio.c:1978: warning: Function parameter or struct member 'completion' not described in 'handle_allocation_error'
   drivers/md/dm-vdo/data-vio.c:2007: warning: Function parameter or struct member 'completion' not described in 'continue_data_vio_with_block_map_slot'
--
   drivers/md/dm-vdo/dedupe.c:577: warning: Function parameter or struct member '__always_unused' not described in 'abort_waiter'
   drivers/md/dm-vdo/dedupe.c:577: warning: Excess function parameter 'context' description in 'abort_waiter'
>> drivers/md/dm-vdo/dedupe.c:932: warning: Function parameter or struct member 'waiter' not described in 'enter_forked_lock'
>> drivers/md/dm-vdo/dedupe.c:932: warning: Function parameter or struct member 'context' not described in 'enter_forked_lock'
   drivers/md/dm-vdo/dedupe.c:1746: warning: Function parameter or struct member 'completion' not described in 'vdo_continue_hash_lock'
   drivers/md/dm-vdo/dedupe.c:1746: warning: Excess function parameter 'data_vio' description in 'vdo_continue_hash_lock'
   drivers/md/dm-vdo/dedupe.c:1843: warning: Function parameter or struct member 'completion' not described in 'vdo_acquire_hash_lock'
   drivers/md/dm-vdo/dedupe.c:1843: warning: Excess function parameter 'data_vio' description in 'vdo_acquire_hash_lock'
>> drivers/md/dm-vdo/dedupe.c:2572: warning: Function parameter or struct member 'context' not described in 'suspend_index'
>> drivers/md/dm-vdo/dedupe.c:2572: warning: Function parameter or struct member 'completion' not described in 'suspend_index'
>> drivers/md/dm-vdo/dedupe.c:2586: warning: Function parameter or struct member 'state' not described in 'initiate_drain'
>> drivers/md/dm-vdo/dedupe.c:2597: warning: Function parameter or struct member 'context' not described in 'drain_hash_zone'
>> drivers/md/dm-vdo/dedupe.c:2597: warning: Function parameter or struct member 'zone_number' not described in 'drain_hash_zone'
>> drivers/md/dm-vdo/dedupe.c:2597: warning: Function parameter or struct member 'parent' not described in 'drain_hash_zone'
>> drivers/md/dm-vdo/dedupe.c:2634: warning: Function parameter or struct member 'context' not described in 'resume_index'
>> drivers/md/dm-vdo/dedupe.c:2634: warning: Function parameter or struct member 'parent' not described in 'resume_index'
>> drivers/md/dm-vdo/dedupe.c:2667: warning: Function parameter or struct member 'context' not described in 'resume_hash_zone'
>> drivers/md/dm-vdo/dedupe.c:2667: warning: Function parameter or struct member 'zone_number' not described in 'resume_hash_zone'
>> drivers/md/dm-vdo/dedupe.c:2667: warning: Function parameter or struct member 'parent' not described in 'resume_hash_zone'
   drivers/md/dm-vdo/dedupe.c:2745: warning: Function parameter or struct member 'zones' not described in 'vdo_get_dedupe_statistics'
   drivers/md/dm-vdo/dedupe.c:2745: warning: Function parameter or struct member 'stats' not described in 'vdo_get_dedupe_statistics'
   drivers/md/dm-vdo/dedupe.c:2745: warning: Excess function parameter 'hash_zones' description in 'vdo_get_dedupe_statistics'
   drivers/md/dm-vdo/dedupe.c:2837: warning: expecting prototype for vdo_dump_hash_zone(). Prototype was for dump_hash_zone() instead
--
>> drivers/md/dm-vdo/encodings.c:439: warning: Function parameter or struct member 'root_count' not described in 'vdo_compute_new_forest_pages'
>> drivers/md/dm-vdo/encodings.c:439: warning: Function parameter or struct member 'old_sizes' not described in 'vdo_compute_new_forest_pages'
>> drivers/md/dm-vdo/encodings.c:439: warning: Function parameter or struct member 'new_sizes' not described in 'vdo_compute_new_forest_pages'
>> drivers/md/dm-vdo/encodings.c:466: warning: Function parameter or struct member 'buffer' not described in 'encode_recovery_journal_state_7_0'
>> drivers/md/dm-vdo/encodings.c:466: warning: Function parameter or struct member 'offset' not described in 'encode_recovery_journal_state_7_0'
>> drivers/md/dm-vdo/encodings.c:466: warning: Function parameter or struct member 'state' not described in 'encode_recovery_journal_state_7_0'
>> drivers/md/dm-vdo/encodings.c:489: warning: Function parameter or struct member 'offset' not described in 'decode_recovery_journal_state_7_0'
>> drivers/md/dm-vdo/encodings.c:548: warning: Function parameter or struct member 'buffer' not described in 'encode_slab_depot_state_2_0'
>> drivers/md/dm-vdo/encodings.c:548: warning: Function parameter or struct member 'offset' not described in 'encode_slab_depot_state_2_0'
>> drivers/md/dm-vdo/encodings.c:548: warning: Function parameter or struct member 'state' not described in 'encode_slab_depot_state_2_0'
>> drivers/md/dm-vdo/encodings.c:576: warning: Function parameter or struct member 'buffer' not described in 'decode_slab_depot_state_2_0'
>> drivers/md/dm-vdo/encodings.c:576: warning: Function parameter or struct member 'offset' not described in 'decode_slab_depot_state_2_0'
>> drivers/md/dm-vdo/encodings.c:576: warning: Function parameter or struct member 'state' not described in 'decode_slab_depot_state_2_0'
   drivers/md/dm-vdo/encodings.c:870: warning: Function parameter or struct member 'offset' not described in 'vdo_initialize_layout'
   drivers/md/dm-vdo/encodings.c:870: warning: Excess function parameter 'origin' description in 'vdo_initialize_layout'
>> drivers/md/dm-vdo/encodings.c:1174: warning: Function parameter or struct member 'buffer' not described in 'decode_vdo_component'
>> drivers/md/dm-vdo/encodings.c:1174: warning: Function parameter or struct member 'offset' not described in 'decode_vdo_component'
>> drivers/md/dm-vdo/encodings.c:1174: warning: Function parameter or struct member 'component' not described in 'decode_vdo_component'
   drivers/md/dm-vdo/encodings.c:1174: warning: expecting prototype for vdo_decode_component(). Prototype was for decode_vdo_component() instead
>> drivers/md/dm-vdo/encodings.c:1405: warning: Function parameter or struct member 'buffer' not described in 'vdo_encode_component_states'
>> drivers/md/dm-vdo/encodings.c:1405: warning: Function parameter or struct member 'offset' not described in 'vdo_encode_component_states'
>> drivers/md/dm-vdo/encodings.c:1405: warning: Function parameter or struct member 'states' not described in 'vdo_encode_component_states'
>> drivers/md/dm-vdo/encodings.c:1423: warning: Function parameter or struct member 'buffer' not described in 'vdo_encode_super_block'
   drivers/md/dm-vdo/encodings.c:1423: warning: Function parameter or struct member 'states' not described in 'vdo_encode_super_block'
   drivers/md/dm-vdo/encodings.c:1447: warning: Function parameter or struct member 'buffer' not described in 'vdo_decode_super_block'
--
>> drivers/md/dm-vdo/dm-vdo-target.c:1157: warning: Function parameter or struct member 'vdo' not described in 'get_thread_id_for_phase'
--
   drivers/md/dm-vdo/flush.c:97: warning: expecting prototype for waiter_as_flush(). Prototype was for vdo_waiter_as_flush() instead
>> drivers/md/dm-vdo/flush.c:532: warning: Function parameter or struct member 'state' not described in 'initiate_drain'
--
>> drivers/md/dm-vdo/funnel-workqueue.c:385: warning: Function parameter or struct member 'thread_name_prefix' not described in 'vdo_make_work_queue'
>> drivers/md/dm-vdo/funnel-workqueue.c:385: warning: Function parameter or struct member 'name' not described in 'vdo_make_work_queue'
>> drivers/md/dm-vdo/funnel-workqueue.c:385: warning: Function parameter or struct member 'owner' not described in 'vdo_make_work_queue'
>> drivers/md/dm-vdo/funnel-workqueue.c:385: warning: Function parameter or struct member 'type' not described in 'vdo_make_work_queue'
>> drivers/md/dm-vdo/funnel-workqueue.c:385: warning: Function parameter or struct member 'thread_count' not described in 'vdo_make_work_queue'
>> drivers/md/dm-vdo/funnel-workqueue.c:385: warning: Function parameter or struct member 'thread_privates' not described in 'vdo_make_work_queue'
>> drivers/md/dm-vdo/funnel-workqueue.c:385: warning: Function parameter or struct member 'queue_ptr' not described in 'vdo_make_work_queue'
--
>> drivers/md/dm-vdo/logical-zone.c:170: warning: Function parameter or struct member 'state' not described in 'initiate_drain'
>> drivers/md/dm-vdo/logical-zone.c:181: warning: Function parameter or struct member 'context' not described in 'drain_logical_zone'
>> drivers/md/dm-vdo/logical-zone.c:181: warning: Function parameter or struct member 'zone_number' not described in 'drain_logical_zone'
>> drivers/md/dm-vdo/logical-zone.c:181: warning: Function parameter or struct member 'parent' not described in 'drain_logical_zone'
>> drivers/md/dm-vdo/logical-zone.c:204: warning: Function parameter or struct member 'context' not described in 'resume_logical_zone'
>> drivers/md/dm-vdo/logical-zone.c:204: warning: Function parameter or struct member 'zone_number' not described in 'resume_logical_zone'
>> drivers/md/dm-vdo/logical-zone.c:204: warning: Function parameter or struct member 'parent' not described in 'resume_logical_zone'
   drivers/md/dm-vdo/logical-zone.c:303: warning: expecting prototype for void attempt_generation_complete_notification()(). Prototype was for attempt_generation_complete_notification() instead
..


vim +1157 drivers/md/dm-vdo/dm-vdo-target.c

03d1e20fa16e0a drivers/md/dm-vdo-target.c Matthew Sakai 2023-11-16  1151  
03d1e20fa16e0a drivers/md/dm-vdo-target.c Matthew Sakai 2023-11-16  1152  /**
03d1e20fa16e0a drivers/md/dm-vdo-target.c Matthew Sakai 2023-11-16  1153   * get_thread_id_for_phase() - Get the thread id for the current phase of the admin operation in
03d1e20fa16e0a drivers/md/dm-vdo-target.c Matthew Sakai 2023-11-16  1154   *                             progress.
03d1e20fa16e0a drivers/md/dm-vdo-target.c Matthew Sakai 2023-11-16  1155   */
03d1e20fa16e0a drivers/md/dm-vdo-target.c Matthew Sakai 2023-11-16  1156  static thread_id_t __must_check get_thread_id_for_phase(struct vdo *vdo)
03d1e20fa16e0a drivers/md/dm-vdo-target.c Matthew Sakai 2023-11-16 @1157  {
03d1e20fa16e0a drivers/md/dm-vdo-target.c Matthew Sakai 2023-11-16  1158  	switch (vdo->admin.phase) {
03d1e20fa16e0a drivers/md/dm-vdo-target.c Matthew Sakai 2023-11-16  1159  	case RESUME_PHASE_PACKER:
03d1e20fa16e0a drivers/md/dm-vdo-target.c Matthew Sakai 2023-11-16  1160  	case RESUME_PHASE_FLUSHER:
03d1e20fa16e0a drivers/md/dm-vdo-target.c Matthew Sakai 2023-11-16  1161  	case SUSPEND_PHASE_PACKER:
03d1e20fa16e0a drivers/md/dm-vdo-target.c Matthew Sakai 2023-11-16  1162  	case SUSPEND_PHASE_FLUSHES:
03d1e20fa16e0a drivers/md/dm-vdo-target.c Matthew Sakai 2023-11-16  1163  		return vdo->thread_config.packer_thread;
03d1e20fa16e0a drivers/md/dm-vdo-target.c Matthew Sakai 2023-11-16  1164  
03d1e20fa16e0a drivers/md/dm-vdo-target.c Matthew Sakai 2023-11-16  1165  	case RESUME_PHASE_DATA_VIOS:
03d1e20fa16e0a drivers/md/dm-vdo-target.c Matthew Sakai 2023-11-16  1166  	case SUSPEND_PHASE_DATA_VIOS:
03d1e20fa16e0a drivers/md/dm-vdo-target.c Matthew Sakai 2023-11-16  1167  		return vdo->thread_config.cpu_thread;
03d1e20fa16e0a drivers/md/dm-vdo-target.c Matthew Sakai 2023-11-16  1168  
03d1e20fa16e0a drivers/md/dm-vdo-target.c Matthew Sakai 2023-11-16  1169  	case LOAD_PHASE_DRAIN_JOURNAL:
03d1e20fa16e0a drivers/md/dm-vdo-target.c Matthew Sakai 2023-11-16  1170  	case RESUME_PHASE_JOURNAL:
03d1e20fa16e0a drivers/md/dm-vdo-target.c Matthew Sakai 2023-11-16  1171  	case SUSPEND_PHASE_JOURNAL:
03d1e20fa16e0a drivers/md/dm-vdo-target.c Matthew Sakai 2023-11-16  1172  		return vdo->thread_config.journal_thread;
03d1e20fa16e0a drivers/md/dm-vdo-target.c Matthew Sakai 2023-11-16  1173  
03d1e20fa16e0a drivers/md/dm-vdo-target.c Matthew Sakai 2023-11-16  1174  	default:
03d1e20fa16e0a drivers/md/dm-vdo-target.c Matthew Sakai 2023-11-16  1175  		return vdo->thread_config.admin_thread;
03d1e20fa16e0a drivers/md/dm-vdo-target.c Matthew Sakai 2023-11-16  1176  	}
03d1e20fa16e0a drivers/md/dm-vdo-target.c Matthew Sakai 2023-11-16  1177  }
03d1e20fa16e0a drivers/md/dm-vdo-target.c Matthew Sakai 2023-11-16  1178  

:::::: The code at line 1157 was first introduced by commit
:::::: 03d1e20fa16e0aaa753c09f2ae72faec27a01273 dm vdo: add the top-level DM target

:::::: TO: Matthew Sakai <msakai@redhat.com>
:::::: CC: Mike Snitzer <snitzer@kernel.org>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

