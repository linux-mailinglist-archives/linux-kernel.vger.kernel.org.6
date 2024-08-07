Return-Path: <linux-kernel+bounces-278538-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C81CD94B193
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 22:47:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 04BCA1C21BE2
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 20:47:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCBEC146581;
	Wed,  7 Aug 2024 20:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GJqXsBVL"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56715145FFC
	for <linux-kernel@vger.kernel.org>; Wed,  7 Aug 2024 20:46:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723063615; cv=none; b=FUo6q2pUcLz0vSaj60AQURMZ5IeClctp1YgRwoNaovAswqGn/ov4HqKhp+a39VgVQhSlO3SvVvc93ifaswpb6wiA6yFZEUKNqxY0qUi7g6HIIAc9kHNVkwdxiBRVyRq4wJmQLAQI3JItG129EF8pfDuEWFfk9LeDQx4JESboR+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723063615; c=relaxed/simple;
	bh=xINgwg9P8t/oehn/2tIHod9BgOKc3mvBxYyxiOBjr4o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VF3HZkzMjfoTNxMsachfyiUnCW62+AI/Lh5UoydzZ4vgbbtsaGVXB+bp3mBH+XPIShWyV+nAPROd6xw3ShjxKAwVVJL+CyC0RqwEkq4gemKpcpsGO3oq949mwb0vbeWVaDBAlH4x+CDNkI9xRaNIhb/Z8F1mAA4HW6B+6ERd9k8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GJqXsBVL; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723063613; x=1754599613;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=xINgwg9P8t/oehn/2tIHod9BgOKc3mvBxYyxiOBjr4o=;
  b=GJqXsBVLRvpwgkzKdQ83Ey4Vxz1yiXGfq16ZU+GHMJ7RNbjxdx/Z7N/w
   VNKsQG7Rabibf2hrooIPjAvnfRaRSiuNtJsH0bS4P1Ov8zygJsQa5wng+
   Oyw+pizHHjaRV4UtR7jOFJ+FYD1725Q22Nm99k0G6JG2iB2jKBI9Un0jI
   oneJnIXTkgcBBmkmKYTuZvKnVYq5Ppm7Dv594Nk419CZ+JOcpX6FyA3pM
   sb8fYQlHIBb09/7WahjJsRHFYK05+IJ5Vxc5uWzKzO/ySFopmA9WmPEVC
   qWhBbChI8bEW9CbGBsxObea7c/lnlUUeHdeayayeIxGHISdhkQkjHlO97
   A==;
X-CSE-ConnectionGUID: rIr4C9+TR86057DZXFwUVg==
X-CSE-MsgGUID: 09b530DhRaanfACUmwiOsw==
X-IronPort-AV: E=McAfee;i="6700,10204,11157"; a="38665532"
X-IronPort-AV: E=Sophos;i="6.09,271,1716274800"; 
   d="scan'208";a="38665532"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Aug 2024 13:46:50 -0700
X-CSE-ConnectionGUID: h42rbhgvRNWf1VsmhoKZ9g==
X-CSE-MsgGUID: NofxAUPcRd+ej37wS/xyrw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,271,1716274800"; 
   d="scan'208";a="61918544"
Received: from unknown (HELO b6bf6c95bbab) ([10.239.97.151])
  by orviesa004.jf.intel.com with ESMTP; 07 Aug 2024 13:46:47 -0700
Received: from kbuild by b6bf6c95bbab with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sbnYS-0005i2-2t;
	Wed, 07 Aug 2024 20:46:44 +0000
Date: Thu, 8 Aug 2024 04:46:18 +0800
From: kernel test robot <lkp@intel.com>
To: Breno Leitao <leitao@debian.org>, martin.petersen@oracle.com,
	Sathya Prakash <sathya.prakash@broadcom.com>,
	Sreekanth Reddy <sreekanth.reddy@broadcom.com>,
	Suganath Prabu Subramani <suganath-prabu.subramani@broadcom.com>
Cc: oe-kbuild-all@lists.linux.dev, leit@meta.com,
	"open list:LSILOGIC MPT FUSION DRIVERS (FC/SAS/SPI)" <MPT-FusionLinux.pdl@broadcom.com>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] scsi: message: fusion: Remove unused variable
Message-ID: <202408080428.XtCwqGet-lkp@intel.com>
References: <20240807094000.398857-1-leitao@debian.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240807094000.398857-1-leitao@debian.org>

Hi Breno,

kernel test robot noticed the following build warnings:

[auto build test WARNING on mkp-scsi/for-next]
[also build test WARNING on linus/master v6.11-rc2 next-20240807]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Breno-Leitao/scsi-message-fusion-Remove-unused-variable/20240807-174402
base:   https://git.kernel.org/pub/scm/linux/kernel/git/mkp/scsi.git for-next
patch link:    https://lore.kernel.org/r/20240807094000.398857-1-leitao%40debian.org
patch subject: [PATCH] scsi: message: fusion: Remove unused variable
config: alpha-allyesconfig (https://download.01.org/0day-ci/archive/20240808/202408080428.XtCwqGet-lkp@intel.com/config)
compiler: alpha-linux-gcc (GCC) 13.3.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240808/202408080428.XtCwqGet-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202408080428.XtCwqGet-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/message/fusion/mptsas.c: In function 'mptsas_reprobe_lun':
>> drivers/message/fusion/mptsas.c:4235:9: warning: ignoring return value of 'scsi_device_reprobe' declared with attribute 'warn_unused_result' [-Wunused-result]
    4235 |         scsi_device_reprobe(sdev);
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~


vim +4235 drivers/message/fusion/mptsas.c

  4230	
  4231	static void
  4232	mptsas_reprobe_lun(struct scsi_device *sdev, void *data)
  4233	{
  4234		sdev->no_uld_attach = data ? 1 : 0;
> 4235		scsi_device_reprobe(sdev);
  4236	}
  4237	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

