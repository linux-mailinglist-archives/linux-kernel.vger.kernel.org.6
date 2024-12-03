Return-Path: <linux-kernel+bounces-428925-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 102E39E150B
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 09:05:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D7CDC164DE8
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 08:05:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBFBB1E008D;
	Tue,  3 Dec 2024 08:02:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="k71A0S3u"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD41A1DFE36
	for <linux-kernel@vger.kernel.org>; Tue,  3 Dec 2024 08:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733212925; cv=none; b=mQUfmD+y+lU8Wf/GfDP1Xlu4mAjbT58Uzw1inn310OhwzcS0+1DZ/gEZKxsgvrcjFxsekdfu7waFcqcKC2xMyuisewirUQ37YXCufFxF+d/E76+63drNokerd0XuKRStG6Y8a9lcymlyE7xN6opp1v1eqA+yRlO3so85izr4eR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733212925; c=relaxed/simple;
	bh=bgUgNjI5CwZYUCMaIi5Pl9Y4YHyJdxRhabmmG4cHyO0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=H68RNgs6madiF5r9s0nqP4CzVny1LaGNImkWjoJ3IkVua3ZLuSMqamCNdgzc4CDSG15q5Q2wBn3u6WsJqe+oHEMcl2mVpPC67PXqaShAS4DOQ5i+VsK5z/2HmdDso2Rid7Yhgy/4XfGNZq58MIkTaNvo+nibkiSYzSHanUk+Cd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=k71A0S3u; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733212923; x=1764748923;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=bgUgNjI5CwZYUCMaIi5Pl9Y4YHyJdxRhabmmG4cHyO0=;
  b=k71A0S3uaQ6J7oaKz8oBEnMfc4dxKaLWVBgi6l1dPaNZIuUy0m4xkpwB
   hLWVGBdUzeIPW0rCc+tD4GQa0Wqsif9rqyuEqJM9W0GRGbjSY1Br/DMXp
   ruDVVE/iUxPRDEHA+8jxCn70/SIBt2o8yP1S/KSwyV2KL7NS3D6Ue4YG2
   bDAfyKdtuDKkBjIjEwqb0qaSfDRURQU3T1HPhC/1yhKfa5ykV+w3Ksvqj
   H23fIBdakPht65QwDBKDCl1MoNRhpKBMrjRKvm/yhwuWuP1x+2BnHnmOO
   3VpY35KdXrG+bQGgeGIdx2ThnG3t6dgZJj192N/OhKQTnpq9PvrwbF1ql
   w==;
X-CSE-ConnectionGUID: 1OLS4ii0Rgap8eXeUa+3kw==
X-CSE-MsgGUID: ZQSyN/EjRHubrikjl/j2HA==
X-IronPort-AV: E=McAfee;i="6700,10204,11274"; a="44079176"
X-IronPort-AV: E=Sophos;i="6.12,204,1728975600"; 
   d="scan'208";a="44079176"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Dec 2024 00:02:03 -0800
X-CSE-ConnectionGUID: jm/ynzqCRMOxyvJjqfPJFA==
X-CSE-MsgGUID: GmlW304CR/OQh3jNYKvfWQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,204,1728975600"; 
   d="scan'208";a="98364762"
Received: from lkp-server01.sh.intel.com (HELO 388c121a226b) ([10.239.97.150])
  by orviesa005.jf.intel.com with ESMTP; 03 Dec 2024 00:02:02 -0800
Received: from kbuild by 388c121a226b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tINr5-0000KJ-1K;
	Tue, 03 Dec 2024 08:01:59 +0000
Date: Tue, 3 Dec 2024 16:01:24 +0800
From: kernel test robot <lkp@intel.com>
To: Yogesh Lal <quic_ylal@quicinc.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Bjorn Andersson <andersson@kernel.org>,
	Sibi Sankar <quic_sibis@quicinc.com>
Subject: drivers/remoteproc/qcom_q6v5_pas.c:123:9: sparse: sparse: incorrect
 type in argument 2 (different address spaces)
Message-ID: <202412031509.TMyYOtXN-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   cdd30ebb1b9f36159d66f088b61aee264e649d7a
commit: a376c10d45a8e6ee5ea55791193f90625b35e156 remoteproc: qcom: pas: Adjust the phys addr wrt the mem region
date:   1 year, 10 months ago
config: arm-randconfig-r123-20241111 (https://download.01.org/0day-ci/archive/20241203/202412031509.TMyYOtXN-lkp@intel.com/config)
compiler: clang version 14.0.6 (https://github.com/llvm/llvm-project f28c006a5895fc0e329fe15fead81e37457cb1d1)
reproduce: (https://download.01.org/0day-ci/archive/20241203/202412031509.TMyYOtXN-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202412031509.TMyYOtXN-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> drivers/remoteproc/qcom_q6v5_pas.c:123:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const volatile [noderef] __iomem *from @@     got void * @@
   drivers/remoteproc/qcom_q6v5_pas.c:123:9: sparse:     expected void const volatile [noderef] __iomem *from
   drivers/remoteproc/qcom_q6v5_pas.c:123:9: sparse:     got void *
   drivers/remoteproc/qcom_q6v5_pas.c:108:6: sparse: sparse: symbol 'adsp_segment_dump' was not declared. Should it be static?
   drivers/remoteproc/qcom_q6v5_pas.c:553:26: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void *mem_region @@     got void [noderef] __iomem * @@
   drivers/remoteproc/qcom_q6v5_pas.c:553:26: sparse:     expected void *mem_region
   drivers/remoteproc/qcom_q6v5_pas.c:553:26: sparse:     got void [noderef] __iomem *
   drivers/remoteproc/qcom_q6v5_pas.c:575:30: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void *dtb_mem_region @@     got void [noderef] __iomem * @@
   drivers/remoteproc/qcom_q6v5_pas.c:575:30: sparse:     expected void *dtb_mem_region
   drivers/remoteproc/qcom_q6v5_pas.c:575:30: sparse:     got void [noderef] __iomem *

vim +123 drivers/remoteproc/qcom_q6v5_pas.c

   107	
   108	void adsp_segment_dump(struct rproc *rproc, struct rproc_dump_segment *segment,
   109			       void *dest, size_t offset, size_t size)
   110	{
   111		struct qcom_adsp *adsp = rproc->priv;
   112		int total_offset;
   113	
   114		total_offset = segment->da + segment->offset + offset - adsp->mem_phys;
   115		if (total_offset < 0 || total_offset + size > adsp->mem_size) {
   116			dev_err(adsp->dev,
   117				"invalid copy request for segment %pad with offset %zu and size %zu)\n",
   118				&segment->da, offset, size);
   119			memset(dest, 0xff, size);
   120			return;
   121		}
   122	
 > 123		memcpy_fromio(dest, adsp->mem_region + total_offset, size);
   124	}
   125	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

