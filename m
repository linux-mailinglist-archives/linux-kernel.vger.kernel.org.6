Return-Path: <linux-kernel+bounces-206898-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9A7A900F78
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jun 2024 06:24:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E37DE1C2161C
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jun 2024 04:24:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04A6F13AD8;
	Sat,  8 Jun 2024 04:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dxUFkdXO"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C28CEDDC5
	for <linux-kernel@vger.kernel.org>; Sat,  8 Jun 2024 04:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717820651; cv=none; b=XLDg8GSDOFju6iUe3oNsD1e8EfeNJtAo5MBKYBwWL1QVjZ3dyUnYQ9dXOCTwUlXW5BtfqBA9TMCxLoF4+8i6LjG3QLshH2I2/2TRj1dlLeFXBKYAIhBml0cG/9rRpYrdgaFBauJFx1x1GxNRRpwpcmMGepS+J71sVQn/IJaKtRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717820651; c=relaxed/simple;
	bh=djyCoxwdB02mJxnU8dMa7DQUh1mSR9t7kFne7+MeAtI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Py8BbttxlShFmko/5A4no22gQ1QpfbnqYA4KewAC6ZT0RWJZKv/qGDf+rsx/mpLXwXmfV5mIxesOv/ng17EI37PnydFUNRdGlSg2KPzi+Qse+4BavJvezphCWG0PSq83aUdrBvs2pgC/4f5wvPp8kMnXYyPYNL1ru5YsNEM/QAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dxUFkdXO; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717820650; x=1749356650;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=djyCoxwdB02mJxnU8dMa7DQUh1mSR9t7kFne7+MeAtI=;
  b=dxUFkdXOXcu/tkLNvFJPWO5wvnGXpPfnbMEvaBgdcbZMmWi9YjAstB7h
   /dmWV4o8D3uR5Sc95O2e+BamX+63/K1UI4lFkyCM8/lMQHVRn6DzoOtBb
   rLpHZoFLrka0y6n/2GZJR9Pg2CCbiXTpY+50tH1X8USnC5G8UfJpc7lC0
   VBxibZoeIiYIy5GFRqp08tVgpf4iqQ6swds0rJpRMiNXO0Oq/zrNkvqUk
   ek8vNTyaxG0JKSRJTTgb5OeZsx1lDSXwYjCfgWVugginwI88p0TRFwQ61
   03Z2t4yfWvUoeq4XzuBuzGCf6cmihV/lXnlWbIRcRpcLlEmgvUNlQnaEL
   Q==;
X-CSE-ConnectionGUID: gC0VYnRXQROZp/ICmF8I1A==
X-CSE-MsgGUID: eSDBRO9nQXWyb1vQB95lsg==
X-IronPort-AV: E=McAfee;i="6600,9927,11096"; a="25970568"
X-IronPort-AV: E=Sophos;i="6.08,222,1712646000"; 
   d="scan'208";a="25970568"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2024 21:24:10 -0700
X-CSE-ConnectionGUID: NhCpHC2VTRGsG4BYleMG/Q==
X-CSE-MsgGUID: fnTx+2CBTLaD5CD5MbJziA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,222,1712646000"; 
   d="scan'208";a="43456635"
Received: from lkp-server01.sh.intel.com (HELO 472b94a103a1) ([10.239.97.150])
  by orviesa003.jf.intel.com with ESMTP; 07 Jun 2024 21:24:06 -0700
Received: from kbuild by 472b94a103a1 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sFncZ-0000yp-0Y;
	Sat, 08 Jun 2024 04:24:03 +0000
Date: Sat, 8 Jun 2024 12:23:35 +0800
From: kernel test robot <lkp@intel.com>
To: Coiby Xu <coxu@redhat.com>, kexec@lists.infradead.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Ondrej Kozina <okozina@redhat.com>,
	Milan Broz <gmazyland@gmail.com>,
	Thomas Staudt <tstaudt@de.ibm.com>,
	Daniel P =?iso-8859-1?Q?=2E_Berrang=E9?= <berrange@redhat.com>,
	Kairui Song <ryncsn@gmail.com>,
	Jan Pazdziora <jpazdziora@redhat.com>,
	Pingfan Liu <kernelfans@gmail.com>, Baoquan He <bhe@redhat.com>,
	Dave Young <dyoung@redhat.com>, linux-kernel@vger.kernel.org,
	x86@kernel.org, Dave Hansen <dave.hansen@intel.com>,
	Vitaly Kuznetsov <vkuznets@redhat.com>, Greg KH <greg@kroah.com>,
	Eric Biederman <ebiederm@xmission.com>
Subject: Re: [PATCH v5 1/7] kexec_file: allow to place kexec_buf randomly
Message-ID: <202406081214.kNbwlJWP-lkp@intel.com>
References: <20240607122622.167228-2-coxu@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240607122622.167228-2-coxu@redhat.com>

Hi Coiby,

kernel test robot noticed the following build errors:

[auto build test ERROR on 8a92980606e3585d72d510a03b59906e96755b8a]

url:    https://github.com/intel-lab-lkp/linux/commits/Coiby-Xu/kexec_file-allow-to-place-kexec_buf-randomly/20240607-203154
base:   8a92980606e3585d72d510a03b59906e96755b8a
patch link:    https://lore.kernel.org/r/20240607122622.167228-2-coxu%40redhat.com
patch subject: [PATCH v5 1/7] kexec_file: allow to place kexec_buf randomly
config: x86_64-kexec (https://download.01.org/0day-ci/archive/20240608/202406081214.kNbwlJWP-lkp@intel.com/config)
compiler: clang version 18.1.5 (https://github.com/llvm/llvm-project 617a15a9eac96088ae5e9134248d8236e34b91b1)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240608/202406081214.kNbwlJWP-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202406081214.kNbwlJWP-lkp@intel.com/

All errors (new ones prefixed by >>):

>> kernel/kexec_file.c:504:12: error: no member named 'random' in 'struct kexec_buf'
     504 |         if (kbuf->random)
         |             ~~~~  ^
>> kernel/kexec_file.c:505:16: error: call to undeclared function 'kexec_random_start'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     505 |                 temp_start = kexec_random_start(temp_start, end);
         |                              ^
   2 errors generated.


vim +504 kernel/kexec_file.c

   496	
   497	static int locate_mem_hole_bottom_up(unsigned long start, unsigned long end,
   498					     struct kexec_buf *kbuf)
   499	{
   500		struct kimage *image = kbuf->image;
   501		unsigned long temp_start, temp_end;
   502	
   503		temp_start = max(start, kbuf->buf_min);
 > 504		if (kbuf->random)
 > 505			temp_start = kexec_random_start(temp_start, end);
   506	
   507		do {
   508			temp_start = ALIGN(temp_start, kbuf->buf_align);
   509			temp_end = temp_start + kbuf->memsz - 1;
   510	
   511			if (temp_end > end || temp_end > kbuf->buf_max)
   512				return 0;
   513			/*
   514			 * Make sure this does not conflict with any of existing
   515			 * segments
   516			 */
   517			if (kimage_is_destination_range(image, temp_start, temp_end)) {
   518				temp_start = temp_start + PAGE_SIZE;
   519				continue;
   520			}
   521	
   522			/* We found a suitable memory range */
   523			break;
   524		} while (1);
   525	
   526		/* If we are here, we found a suitable memory range */
   527		kbuf->mem = temp_start;
   528	
   529		/* Success, stop navigating through remaining System RAM ranges */
   530		return 1;
   531	}
   532	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

