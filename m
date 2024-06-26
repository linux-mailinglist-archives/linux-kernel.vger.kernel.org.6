Return-Path: <linux-kernel+bounces-230023-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DEF3A91776E
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 06:33:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 406CBB226C8
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 04:33:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 388771474A0;
	Wed, 26 Jun 2024 04:32:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PfFAdojU"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9D9E13AA4C
	for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 04:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719376367; cv=none; b=ZqbrecFmjAsq6qfi3MqLjABlqf+bB1+9Z3EsR8xaLJkKOZgmuDNzWa8lLsHIofr/Dra5xfqSFYkEZ70PwyH8M8C4V8IFQg20VJHAWG5FPH0+rGgZVcOR2LvG3w6d/BGa6sr6nySkBpPjSYBaF5GtJz3eZN8dUdrXCgcq0MvtMAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719376367; c=relaxed/simple;
	bh=EEIDDclEXrFxIlDPjEEHaH4SxxP50Cs/OkDqBbkICAo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V4FbKl0WMA/h2MdeRs3FOfEj5GLc5y98aeLu/PxQgJ3NHZBxWjvFuhzabwmCAJOcGNcslC+WFJnDbnh9Y4m1aK9FKbj9BHQfdrxL0wy8a9c4IAvP54/vZOvTlXQNFwSdWIMiwBbRURLccAmUS+SvxLy+xphyezfIqczGuv98uT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PfFAdojU; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719376366; x=1750912366;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=EEIDDclEXrFxIlDPjEEHaH4SxxP50Cs/OkDqBbkICAo=;
  b=PfFAdojUqiSEtMXoNwIMxFQ3D/WiBnba/gNgqCMyTeHeQj/FNXPR1b4T
   /v2STe0OXnkdsWZo6A4ApLlx4be0NwAhCdwsj88M5wljpKNN/ID96IE1y
   ku27+sSd+2SknGdIGUYP9HbFYyzROzmn304rN6p89CNK1jh175U0VCsYU
   dKDJ+qdeQrC3bJD22Xdn3Z2emaNtIGPj4L6sClvzg8ErqLE0ZQYMhUsYJ
   bwOg/IYy5LnhTM6WZr16IzdrnWC7x7ookMpDIXUWHY/sNNxuYnoQCFrzw
   GicUjThT+U2xcTaxBR0MdZm5iQAxof/+g43+aqfCa3MFfm/XVvazdCeqG
   Q==;
X-CSE-ConnectionGUID: KzY6eqOxR+icQL6+KM/W9g==
X-CSE-MsgGUID: 6UeNfXo+REqphBRqcGJqzw==
X-IronPort-AV: E=McAfee;i="6700,10204,11114"; a="27047211"
X-IronPort-AV: E=Sophos;i="6.08,265,1712646000"; 
   d="scan'208";a="27047211"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2024 21:32:45 -0700
X-CSE-ConnectionGUID: BZXaXxd4SYmIa6XkquD/cA==
X-CSE-MsgGUID: JZgoqd7HTIu6stcORBAWKQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,265,1712646000"; 
   d="scan'208";a="44308317"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by orviesa006.jf.intel.com with ESMTP; 25 Jun 2024 21:32:41 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sMKKk-000Ez0-2V;
	Wed, 26 Jun 2024 04:32:38 +0000
Date: Wed, 26 Jun 2024 12:32:11 +0800
From: kernel test robot <lkp@intel.com>
To: Yi Sun <yi.sun@unisoc.com>, sunyibuaa@gmail.com, tj@kernel.org,
	jaegeuk@kernel.org, chao@kernel.org
Cc: oe-kbuild-all@lists.linux.dev, ebiggers@google.com,
	jiangshanlai@gmail.com, kent.overstreet@linux.dev,
	linux-kernel@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net, niuzhiguo84@gmail.com,
	Hao_hao.Wang@unisoc.com, yunlongxing23@gmail.com
Subject: Re: [PATCH 1/2] workqueue: add io priority to work_struct
Message-ID: <202406261201.0hc4qgvm-lkp@intel.com>
References: <20240621062617.595007-2-yi.sun@unisoc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240621062617.595007-2-yi.sun@unisoc.com>

Hi Yi,

kernel test robot noticed the following build errors:

[auto build test ERROR on tj-wq/for-next]
[also build test ERROR on jaegeuk-f2fs/dev-test jaegeuk-f2fs/dev linus/master v6.10-rc5 next-20240625]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Yi-Sun/workqueue-add-io-priority-to-work_struct/20240625-165935
base:   https://git.kernel.org/pub/scm/linux/kernel/git/tj/wq.git for-next
patch link:    https://lore.kernel.org/r/20240621062617.595007-2-yi.sun%40unisoc.com
patch subject: [PATCH 1/2] workqueue: add io priority to work_struct
config: arm-randconfig-003-20240626 (https://download.01.org/0day-ci/archive/20240626/202406261201.0hc4qgvm-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240626/202406261201.0hc4qgvm-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202406261201.0hc4qgvm-lkp@intel.com/

All errors (new ones prefixed by >>):

   arm-linux-gnueabi-ld: kernel/workqueue.o: in function `restore_work_task_ioprio':
>> workqueue.c:(.text+0xd2e): undefined reference to `set_task_ioprio'
   arm-linux-gnueabi-ld: kernel/workqueue.o: in function `may_adjust_work_task_ioprio':
   workqueue.c:(.text+0xd18): undefined reference to `set_task_ioprio'

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

