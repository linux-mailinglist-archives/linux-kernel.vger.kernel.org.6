Return-Path: <linux-kernel+bounces-534494-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B09D2A467A4
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 18:14:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 42EC617186C
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 17:05:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A01AC224AE8;
	Wed, 26 Feb 2025 17:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fwt3AhCh"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3584F224894
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 17:05:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740589534; cv=none; b=o9969a/A9cqBiFzNzZDtu2y1ZDz+gWTLxTGA3pXctTK5/4mwl1qKSwHJJ7lHwEErROo2y/IETudp+wzIaIcV561zEec3ABaMTnIKHBAtN/RMgbRpx56Y37+owMCugcJN84z6CEuHgSyq4I8CQUAlMXES31Hoq9oonFoAs8cRSTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740589534; c=relaxed/simple;
	bh=Wn1/CceYWAVJQuoyMYnGd5us75/9qlS0eq34VURZLMM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=VqP3rU4Xdqw/6QBFcnHOQKFH4FfJE5kVttihyX751DkCvvGUb9DNy4SRwjuOVXispttyZhYYvprR2Wgce5hzPv5yg+M8F2L1ytk0Ac33wHq8bGppV6Z7m3EVFgvKpnhrL3BEdoj+e5xwH7a0KTUKQquJy81XA39uHNQjm4JfdW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fwt3AhCh; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740589533; x=1772125533;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Wn1/CceYWAVJQuoyMYnGd5us75/9qlS0eq34VURZLMM=;
  b=fwt3AhCh3ntoIbdE1DZq8xK3Yg1G2fTHb9LFUe9MoLy4dyQqhHaOgE9E
   JiAOYsHiOi1WGDOfm+FPrpGrNwVFCVTDoMfN/DzM5BhL54aXVjiQ63QUa
   MEBGOuUNHWTShcumOEBm6Kinsw1V5RcmRMr7jig2wIg2EHZydIwW/gSwD
   ht74LOP94UgzsgjYvzXa4BE+3x2K9fov28yVWKy0NbNwGm1Oo1nLKWFxA
   GGm8fAiR0V+Bk84CA14q1E9GB48YOi8wccT1Ne+yz90n+kH7LMAxJHsQB
   U4/oqMWmlibpaKDTuvpPhxtoi1ZL4uPGhoKSDiZbPXd15NgTRDsex5oE7
   g==;
X-CSE-ConnectionGUID: icfJt0CMS7KMP9wrxDCuaw==
X-CSE-MsgGUID: 9qB+TiIWRG+iEU0OUM6pxA==
X-IronPort-AV: E=McAfee;i="6700,10204,11357"; a="45361827"
X-IronPort-AV: E=Sophos;i="6.13,317,1732608000"; 
   d="scan'208";a="45361827"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2025 09:04:54 -0800
X-CSE-ConnectionGUID: RHud15SvQtKBdyyCLk+kDw==
X-CSE-MsgGUID: wR9CR6AyRJ2Sr+r4b6DYlw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,317,1732608000"; 
   d="scan'208";a="116946786"
Received: from lkp-server02.sh.intel.com (HELO 76cde6cc1f07) ([10.239.97.151])
  by fmviesa008.fm.intel.com with ESMTP; 26 Feb 2025 09:04:50 -0800
Received: from kbuild by 76cde6cc1f07 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tnKq0-000C7r-0h;
	Wed, 26 Feb 2025 17:04:48 +0000
Date: Thu, 27 Feb 2025 01:03:56 +0800
From: kernel test robot <lkp@intel.com>
To: Matthew Garrett <mjg59@google.com>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
	Bartosz Szczepanek <bsz@semihalf.com>
Subject: include/linux/tpm_eventlog.h:165:6: warning: variable 'mapping_size'
 set but not used
Message-ID: <202502270159.BdFzuxvF-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Matthew,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   ac9c34d1e45a4c25174ced4fc0cfc33ff3ed08c7
commit: c46f3405692de1ac82240d927b9c7a0f9d6a4a36 tpm: Reserve the TPM final events table
date:   6 years ago
config: x86_64-buildonly-randconfig-006-20250127 (https://download.01.org/0day-ci/archive/20250227/202502270159.BdFzuxvF-lkp@intel.com/config)
compiler: clang version 19.1.3 (https://github.com/llvm/llvm-project ab51eccf88f5321e7c60591c5546b254b6afab99)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250227/202502270159.BdFzuxvF-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202502270159.BdFzuxvF-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from drivers/char/tpm/tpm_tis.c:30:
   In file included from drivers/char/tpm/tpm.h:29:
>> include/linux/tpm_eventlog.h:165:6: warning: variable 'mapping_size' set but not used [-Wunused-but-set-variable]
     165 |         int mapping_size;
         |             ^
   1 warning generated.
--
   In file included from drivers/char/tpm/tpm-chip.c:24:
>> include/linux/tpm_eventlog.h:165:6: warning: variable 'mapping_size' set but not used [-Wunused-but-set-variable]
     165 |         int mapping_size;
         |             ^
   drivers/char/tpm/tpm-chip.c:422:11: warning: cast from 'void (*)(struct device *)' to 'void (*)(void *)' converts to incompatible function type [-Wcast-function-type-strict]
     422 |                                       (void (*)(void *)) put_device,
         |                                       ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   2 warnings generated.
--
   In file included from drivers/char/tpm/eventlog/tpm1.c:24:
>> include/linux/tpm_eventlog.h:165:6: warning: variable 'mapping_size' set but not used [-Wunused-but-set-variable]
     165 |         int mapping_size;
         |             ^
   drivers/char/tpm/eventlog/tpm1.c:253:6: warning: variable 'len' set but not used [-Wunused-but-set-variable]
     253 |         int len = 0;
         |             ^
   2 warnings generated.


vim +/mapping_size +165 include/linux/tpm_eventlog.h

   138	
   139	/**
   140	 * __calc_tpm2_event_size - calculate the size of a TPM2 event log entry
   141	 * @event:        Pointer to the event whose size should be calculated
   142	 * @event_header: Pointer to the initial event containing the digest lengths
   143	 * @do_mapping:   Whether or not the event needs to be mapped
   144	 *
   145	 * The TPM2 event log format can contain multiple digests corresponding to
   146	 * separate PCR banks, and also contains a variable length of the data that
   147	 * was measured. This requires knowledge of how long each digest type is,
   148	 * and this information is contained within the first event in the log.
   149	 *
   150	 * We calculate the length by examining the number of events, and then looking
   151	 * at each event in turn to determine how much space is used for events in
   152	 * total. Once we've done this we know the offset of the data length field,
   153	 * and can calculate the total size of the event.
   154	 *
   155	 * Return: size of the event on success, <0 on failure
   156	 */
   157	
   158	static inline int __calc_tpm2_event_size(struct tcg_pcr_event2_head *event,
   159						 struct tcg_pcr_event *event_header,
   160						 bool do_mapping)
   161	{
   162		struct tcg_efi_specid_event_head *efispecid;
   163		struct tcg_event_field *event_field;
   164		void *mapping = NULL;
 > 165		int mapping_size;
   166		void *marker;
   167		void *marker_start;
   168		u32 halg_size;
   169		size_t size;
   170		u16 halg;
   171		int i;
   172		int j;
   173	
   174		marker = event;
   175		marker_start = marker;
   176		marker = marker + sizeof(event->pcr_idx) + sizeof(event->event_type)
   177			+ sizeof(event->count);
   178	
   179		/* Map the event header */
   180		if (do_mapping) {
   181			mapping_size = marker - marker_start;
   182			mapping = TPM_MEMREMAP((unsigned long)marker_start,
   183					       mapping_size);
   184			if (!mapping) {
   185				size = 0;
   186				goto out;
   187			}
   188		} else {
   189			mapping = marker_start;
   190		}
   191	
   192		event = (struct tcg_pcr_event2_head *)mapping;
   193	
   194		efispecid = (struct tcg_efi_specid_event_head *)event_header->event;
   195	
   196		/* Check if event is malformed. */
   197		if (event->count > efispecid->num_algs) {
   198			size = 0;
   199			goto out;
   200		}
   201	
   202		for (i = 0; i < event->count; i++) {
   203			halg_size = sizeof(event->digests[i].alg_id);
   204	
   205			/* Map the digest's algorithm identifier */
   206			if (do_mapping) {
   207				TPM_MEMUNMAP(mapping, mapping_size);
   208				mapping_size = halg_size;
   209				mapping = TPM_MEMREMAP((unsigned long)marker,
   210						     mapping_size);
   211				if (!mapping) {
   212					size = 0;
   213					goto out;
   214				}
   215			} else {
   216				mapping = marker;
   217			}
   218	
   219			memcpy(&halg, mapping, halg_size);
   220			marker = marker + halg_size;
   221	
   222			for (j = 0; j < efispecid->num_algs; j++) {
   223				if (halg == efispecid->digest_sizes[j].alg_id) {
   224					marker +=
   225						efispecid->digest_sizes[j].digest_size;
   226					break;
   227				}
   228			}
   229			/* Algorithm without known length. Such event is unparseable. */
   230			if (j == efispecid->num_algs) {
   231				size = 0;
   232				goto out;
   233			}
   234		}
   235	
   236		/*
   237		 * Map the event size - we don't read from the event itself, so
   238		 * we don't need to map it
   239		 */
   240		if (do_mapping) {
   241			TPM_MEMUNMAP(mapping, mapping_size);
   242			mapping_size += sizeof(event_field->event_size);
   243			mapping = TPM_MEMREMAP((unsigned long)marker,
   244					       mapping_size);
   245			if (!mapping) {
   246				size = 0;
   247				goto out;
   248			}
   249		} else {
   250			mapping = marker;
   251		}
   252	
   253		event_field = (struct tcg_event_field *)mapping;
   254	
   255		marker = marker + sizeof(event_field->event_size)
   256			+ event_field->event_size;
   257		size = marker - marker_start;
   258	
   259		if ((event->event_type == 0) && (event_field->event_size == 0))
   260			size = 0;
   261	out:
   262		if (do_mapping)
   263			TPM_MEMUNMAP(mapping, mapping_size);
   264		return size;
   265	}
   266	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

