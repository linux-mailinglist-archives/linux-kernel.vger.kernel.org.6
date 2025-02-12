Return-Path: <linux-kernel+bounces-510480-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90F35A31D93
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 05:53:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 379CC3A8192
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 04:53:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74C961F4168;
	Wed, 12 Feb 2025 04:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nQUp8o2e"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D0E45474C
	for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 04:52:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739335980; cv=none; b=ZMpyeHdiNGdfb8xdCU7ZT165AfLsSWZamTZi4ZXZJ9+E5Fs3Izvz4zcvwwrLGQtadcAAG/+rghWh2JIJz9y8e00ROwjQg4aooapyPhKpX1WwEaHl23e+tQlg4raZUX4OGVyNNJ6BPP/ayonvuTG6rUkDxUDwMu/vwqzChludrfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739335980; c=relaxed/simple;
	bh=wIrLq9LBkp3gDltsoDyAENzujaD3bK+4+HaitDCOaf0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=gmj2BV8bW1fsi8sdsa/7XyUKTkfEbe33l9m0j9WIOHO8kYchj5gHoASK2Il7I/R1J7j2s/Qsu/jy0JTDLFAL9wwx0nfKzxZJmgkv3lIcgRyZDn/xSEMugQl9uO1qEclialWGCYjWS1oLnidwpiM3YASFCgb67MNNdXyuEQAMoc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nQUp8o2e; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739335979; x=1770871979;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=wIrLq9LBkp3gDltsoDyAENzujaD3bK+4+HaitDCOaf0=;
  b=nQUp8o2eAcMia3Oe6Mdt18WG0DO3osWWV+FayEORlx0CSyYyvt8suy1N
   90MWMltqrna5Du9r4C70+3ZMfNlpjY7wYB/WVaYbEVoEiJONSNmxx/Uxh
   uV0o3XV8O2eS+nOjpKLuu3otDdgR0/+HSyMwtkI96UjzP5mexuPRVxTDP
   mD88H01yQGaV2y1874Ph9lX59iwsNdm9K12B99RA7mep59zNT59KgHC8w
   cXUsftwy44rsPGFHow3mHL5+wGyo06qPxQDXFptB2MP2auuhNZX4rt538
   1mG0Cw5XHcTnSm0h56YsIREkysxiwfRDSSNGKrrdTN2oUHTEEGAYumtnK
   A==;
X-CSE-ConnectionGUID: Xwjd29fCSxG1zZ87gZ34xQ==
X-CSE-MsgGUID: QrebmSyoT7WroVRn7KILXA==
X-IronPort-AV: E=McAfee;i="6700,10204,11342"; a="39211233"
X-IronPort-AV: E=Sophos;i="6.13,279,1732608000"; 
   d="scan'208";a="39211233"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2025 20:52:58 -0800
X-CSE-ConnectionGUID: bTyhRcYARvCOX7hKwjKKuA==
X-CSE-MsgGUID: zOL8wUXaTaWsHtny0CiM0w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,279,1732608000"; 
   d="scan'208";a="112461835"
Received: from lkp-server01.sh.intel.com (HELO d63d4d77d921) ([10.239.97.150])
  by orviesa009.jf.intel.com with ESMTP; 11 Feb 2025 20:52:57 -0800
Received: from kbuild by d63d4d77d921 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1ti4k2-00158H-0I;
	Wed, 12 Feb 2025 04:52:54 +0000
Date: Wed, 12 Feb 2025 12:52:13 +0800
From: kernel test robot <lkp@intel.com>
To: Deven Bowers <deven.desai@linux.microsoft.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Paul Moore <paul@paul-moore.com>,
	Fan Wu <wufan@linux.microsoft.com>
Subject: security/ipe/hooks.c:52: warning: Function parameter or struct
 member '__always_unused' not described in 'ipe_mmap_file'
Message-ID: <202502121207.AtcCkAj0-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Deven,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   09fbf3d502050282bf47ab3babe1d4ed54dd1fd8
commit: 52443cb60c356707df494910fa134bbb0a8b1a66 ipe: add LSM hooks on execution and kernel read
date:   6 months ago
config: i386-allmodconfig (https://download.01.org/0day-ci/archive/20250212/202502121207.AtcCkAj0-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250212/202502121207.AtcCkAj0-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202502121207.AtcCkAj0-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> security/ipe/hooks.c:52: warning: Function parameter or struct member '__always_unused' not described in 'ipe_mmap_file'
>> security/ipe/hooks.c:52: warning: Excess function parameter 'reqprot' description in 'ipe_mmap_file'
>> security/ipe/hooks.c:80: warning: Function parameter or struct member '__always_unused' not described in 'ipe_file_mprotect'
>> security/ipe/hooks.c:80: warning: Excess function parameter 'reqprot' description in 'ipe_file_mprotect'


vim +52 security/ipe/hooks.c

    34	
    35	/**
    36	 * ipe_mmap_file() - ipe security hook function for mmap check.
    37	 * @f: File being mmap'd. Can be NULL in the case of anonymous memory.
    38	 * @reqprot: The requested protection on the mmap, passed from usermode.
    39	 * @prot: The effective protection on the mmap, resolved from reqprot and
    40	 *	  system configuration.
    41	 * @flags: Unused.
    42	 *
    43	 * This hook is called when a file is loaded through the mmap
    44	 * family of system calls.
    45	 *
    46	 * Return:
    47	 * * %0		- Success
    48	 * * %-EACCES	- Did not pass IPE policy
    49	 */
    50	int ipe_mmap_file(struct file *f, unsigned long reqprot __always_unused,
    51			  unsigned long prot, unsigned long flags)
  > 52	{
    53		struct ipe_eval_ctx ctx = IPE_EVAL_CTX_INIT;
    54	
    55		if (prot & PROT_EXEC) {
    56			ipe_build_eval_ctx(&ctx, f, IPE_OP_EXEC);
    57			return ipe_evaluate_event(&ctx);
    58		}
    59	
    60		return 0;
    61	}
    62	
    63	/**
    64	 * ipe_file_mprotect() - ipe security hook function for mprotect check.
    65	 * @vma: Existing virtual memory area created by mmap or similar.
    66	 * @reqprot: The requested protection on the mmap, passed from usermode.
    67	 * @prot: The effective protection on the mmap, resolved from reqprot and
    68	 *	  system configuration.
    69	 *
    70	 * This LSM hook is called when a mmap'd region of memory is changing
    71	 * its protections via mprotect.
    72	 *
    73	 * Return:
    74	 * * %0		- Success
    75	 * * %-EACCES	- Did not pass IPE policy
    76	 */
    77	int ipe_file_mprotect(struct vm_area_struct *vma,
    78			      unsigned long reqprot __always_unused,
    79			      unsigned long prot)
  > 80	{
    81		struct ipe_eval_ctx ctx = IPE_EVAL_CTX_INIT;
    82	
    83		/* Already Executable */
    84		if (vma->vm_flags & VM_EXEC)
    85			return 0;
    86	
    87		if (prot & PROT_EXEC) {
    88			ipe_build_eval_ctx(&ctx, vma->vm_file, IPE_OP_EXEC);
    89			return ipe_evaluate_event(&ctx);
    90		}
    91	
    92		return 0;
    93	}
    94	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

