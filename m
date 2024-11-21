Return-Path: <linux-kernel+bounces-417468-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D491E9D5470
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 22:03:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 90BBE281987
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 21:02:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E3851CACFC;
	Thu, 21 Nov 2024 21:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LNsN/Qbr"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B5A71AD5D8
	for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2024 21:02:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732222974; cv=none; b=AsmBponTkV1GSJfB1XP3DksYJMklSiYzY7MO0Pl1saXhPD3OJuYdJ4TRS/rgDgkEaHDibqKk1XybWtx1u9HiFWYN731xnMeAL5DmCDICSdcgOBHcDr3iKISMoi6pwsv1GbPk05U+RSKpkU1xEqvutd8MQXe10j02kuN4D4Gk7qg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732222974; c=relaxed/simple;
	bh=T4YKVUaUJjY9qe38D0AL3quzsZVuX+0MOMF55YEgFJk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P1Avw/2R/Q6PrYy2fEObkN8SwsQ8JQDHonQyf08gAiEBzzsbuRGv31iTipaZ6P27k/+EALVftVqSZwvvFwprA8AyQaJAcq3fzK4LunNX2Yhra/2ly8EsuKxheOK594jFJuuQvMTvBPyATMlkLBNDmHIx9AlMsOc2xqneWHqZTDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LNsN/Qbr; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732222974; x=1763758974;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=T4YKVUaUJjY9qe38D0AL3quzsZVuX+0MOMF55YEgFJk=;
  b=LNsN/Qbr9hYuCg5e6Kiv7smqVzJiKg7IYqgodzKMuKALepxLIPC+ibYM
   txjPjfwaGgBOkbaqmymd90hn6BDwrP/vMbyqcX1ZF/LY70EnBSwpJNahX
   Y4ivyhaGQipGsBhhKXE3HYsqJMdL1Gbh09+wcMcA4llBcsFTofNsyd/ok
   HCIp6hDibiD6+8NRXHm+/hNcb5qUS4uiBxlulPgVmWguU14GgsswD68P6
   L9WPv+vqnd5kz9FsMGNMbMadC7V5sY2z/nN1O0Dj8wE2DetzcPZ0aZXQY
   w6GYnMglW0Knx6XdOAkqN7Pml1mBCMys8vzuWwC8EUmIo5tCpkNFY/g2T
   g==;
X-CSE-ConnectionGUID: 3V2pAWzYRrekrVjPeMwSYw==
X-CSE-MsgGUID: AwSzQnyaTG2oSKSfHgW8DQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11263"; a="32217858"
X-IronPort-AV: E=Sophos;i="6.12,173,1728975600"; 
   d="scan'208";a="32217858"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Nov 2024 13:02:53 -0800
X-CSE-ConnectionGUID: dFlbWoJsQiS+i+hsPh7xBQ==
X-CSE-MsgGUID: HHtnoyZKRZuO93QR1azAqQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,173,1728975600"; 
   d="scan'208";a="94816991"
Received: from lkp-server01.sh.intel.com (HELO 8122d2fc1967) ([10.239.97.150])
  by fmviesa005.fm.intel.com with ESMTP; 21 Nov 2024 13:02:50 -0800
Received: from kbuild by 8122d2fc1967 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tEEK7-0003Lb-1X;
	Thu, 21 Nov 2024 21:02:47 +0000
Date: Fri, 22 Nov 2024 05:01:50 +0800
From: kernel test robot <lkp@intel.com>
To: Philipp Stanner <pstanner@redhat.com>,
	Luben Tuikov <ltuikov89@gmail.com>,
	Matthew Brost <matthew.brost@intel.com>,
	Danilo Krummrich <dakr@kernel.org>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: oe-kbuild-all@lists.linux.dev, dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Christian =?unknown-8bit?B?S8O2bmln?= <christian.koenig@amd.com>
Subject: Re: [PATCH 2/2] drm/sched: Fix docu of drm_sched_entity_flush()
Message-ID: <202411220432.6kkVBxah-lkp@intel.com>
References: <20241119134122.21950-3-pstanner@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241119134122.21950-3-pstanner@redhat.com>

Hi Philipp,

kernel test robot noticed the following build warnings:

[auto build test WARNING on drm-misc/drm-misc-next]
[also build test WARNING on v6.12 next-20241121]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Philipp-Stanner/drm-sched-Fix-docu-of-drm_sched_entity_flush/20241121-125617
base:   git://anongit.freedesktop.org/drm/drm-misc drm-misc-next
patch link:    https://lore.kernel.org/r/20241119134122.21950-3-pstanner%40redhat.com
patch subject: [PATCH 2/2] drm/sched: Fix docu of drm_sched_entity_flush()
config: arc-randconfig-001-20241122 (https://download.01.org/0day-ci/archive/20241122/202411220432.6kkVBxah-lkp@intel.com/config)
compiler: arc-elf-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241122/202411220432.6kkVBxah-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202411220432.6kkVBxah-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/gpu/drm/scheduler/sched_entity.c:277: warning: bad line: 


vim +277 drivers/gpu/drm/scheduler/sched_entity.c

   270	
   271	/**
   272	 * drm_sched_entity_flush - Flush a context entity
   273	 * @entity: scheduler entity
   274	 * @timeout: time to wait in jiffies
   275	 *
   276	 * Returns: 0 if the timeout ellapsed, the remaining time otherwise.
 > 277	
   278	 * Waits at most @timeout jiffies for the entity's job queue to become empty.
   279	 */
   280	long drm_sched_entity_flush(struct drm_sched_entity *entity, long timeout)
   281	{
   282		struct drm_gpu_scheduler *sched;
   283		struct task_struct *last_user;
   284		long ret = timeout;
   285	
   286		if (!entity->rq)
   287			return 0;
   288	
   289		sched = entity->rq->sched;
   290		/*
   291		 * The client will not queue more IBs during this fini, consume existing
   292		 * queued IBs or discard them on SIGKILL
   293		 */
   294		if (timeout != 0 && (current->flags & PF_EXITING)) {
   295			ret = wait_event_timeout(sched->job_scheduled,
   296					drm_sched_entity_is_idle(entity),
   297					timeout);
   298			/*
   299			 * wait_event_timeout() returns 1 if it timed out but the
   300			 * condition became true on timeout. We only care about whether
   301			 * it timed out or not.
   302			 */
   303			if (ret == 1)
   304				ret = 0;
   305		} else {
   306			wait_event_killable(sched->job_scheduled,
   307					    drm_sched_entity_is_idle(entity));
   308	
   309			ret -= (long)get_jiffies_64();
   310			if (ret < 0)
   311				ret = 0;
   312		}
   313	
   314		/* For killed process disable any more IBs enqueue right now */
   315		last_user = cmpxchg(&entity->last_user, current->group_leader, NULL);
   316		if ((!last_user || last_user == current->group_leader) &&
   317		    (current->flags & PF_EXITING) && (current->exit_code == SIGKILL))
   318			drm_sched_entity_kill(entity);
   319	
   320		return ret;
   321	}
   322	EXPORT_SYMBOL(drm_sched_entity_flush);
   323	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

