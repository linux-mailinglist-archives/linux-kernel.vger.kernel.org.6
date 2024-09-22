Return-Path: <linux-kernel+bounces-335135-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 28F7C97E192
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Sep 2024 14:40:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4C3571C20A78
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Sep 2024 12:40:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C81663D;
	Sun, 22 Sep 2024 12:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="M4HDIxRm"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FAB6623
	for <linux-kernel@vger.kernel.org>; Sun, 22 Sep 2024 12:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727008798; cv=none; b=kAwH0yOBndzL1ZNYhfpaOwLLNjIJS1/cf7dcrhw0Nb8UqFIpY3V/E8M/lJyOBvtHLpLKJXeY8waug+0oMCUlV+dCOjsxj1key5f131ryHsYLwA889HEkXmSmgnkkq00qNFTNF2iIt+DCPM0lOKJE//gXCZmnpaE4SjaLJiwZUTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727008798; c=relaxed/simple;
	bh=T+E7B/UGebNG/RbgoEeLr0kMsiyTwKUGHSeOEMhw5rA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=sAMCS6gbXKkgMG1WPUwV0malwDTFDgh1Inwj6FV1wkDimK/dWD2Q06gp+wcuKclHDrb9/A9FkiGMlvMO4nI6ECEhcYZqAcRYaz27PdFW52Ax0/VawubdNV+4Zp7HJYTb6aEzoLvJSZkdmJ3Hh3Ux/8lnKLTuvD6nY8WTicsEsPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=M4HDIxRm; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727008795; x=1758544795;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=T+E7B/UGebNG/RbgoEeLr0kMsiyTwKUGHSeOEMhw5rA=;
  b=M4HDIxRm2iJps5DfSXhKkMpizIZY0YJVrc57yIFEDa3HX/ctaJ/ZU+l+
   afUo4fZ6bbC8U9qfJ+LJUv382xGSLwDQDUNTm66ODq9aFwc+AIwrYra77
   q79bfokaIiUrdO8PEVSp0+G+fZRAwLLuKf8VNBqFDgAD5epHd3vJCXBfc
   oZEMKVZYlPAb3yYrVmosOyTlY4ifLUGLt3nVGqgKX80ZxfH1B8iX+dbwB
   nVifQ7OlVrdaTbqsqIGil9aL5wYcOfqlP1/BkAUBI7NfTOYkb/nPHODWF
   4EECq4DWgw3ZJVpodlTGNZZZyRcYBACL6c3gTXCg/oKTkXpgRlfnf+u0a
   A==;
X-CSE-ConnectionGUID: rSBb8+ZfSfeG3f2h9QGCig==
X-CSE-MsgGUID: XADBjXWYRrq7+5cR75aHrg==
X-IronPort-AV: E=McAfee;i="6700,10204,11202"; a="36533453"
X-IronPort-AV: E=Sophos;i="6.10,249,1719903600"; 
   d="scan'208";a="36533453"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2024 05:39:55 -0700
X-CSE-ConnectionGUID: vaiw0bkhSZGUCAGKW/PZcQ==
X-CSE-MsgGUID: v/wDccsfRJesGHA6BnTyIQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,249,1719903600"; 
   d="scan'208";a="71234691"
Received: from lkp-server01.sh.intel.com (HELO 53e96f405c61) ([10.239.97.150])
  by orviesa007.jf.intel.com with ESMTP; 22 Sep 2024 05:39:53 -0700
Received: from kbuild by 53e96f405c61 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1ssLsV-000GJo-0T;
	Sun, 22 Sep 2024 12:39:51 +0000
Date: Sun, 22 Sep 2024 20:38:59 +0800
From: kernel test robot <lkp@intel.com>
To: Breno Leitao <leitao@debian.org>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	Vladimir Oltean <vladimir.oltean@nxp.com>
Subject: drivers/net/ethernet/freescale/dpaa/./dpaa_eth_trace.h:29:1: sparse:
 sparse: incorrect type in assignment (different base types)
Message-ID: <202409222040.EPSCh9v9-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   88264981f2082248e892a706b2c5004650faac54
commit: 782fe08e9861d00ce8aca370453dd9ceb9a23d50 soc: fsl: qbman: FSL_DPAA depends on COMPILE_TEST
date:   10 weeks ago
config: sparc64-randconfig-r133-20240922 (https://download.01.org/0day-ci/archive/20240922/202409222040.EPSCh9v9-lkp@intel.com/config)
compiler: sparc64-linux-gcc (GCC) 14.1.0
reproduce: (https://download.01.org/0day-ci/archive/20240922/202409222040.EPSCh9v9-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202409222040.EPSCh9v9-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
   drivers/net/ethernet/freescale/dpaa/dpaa_eth.c: note: in included file (through include/trace/trace_events.h, include/trace/define_trace.h, ...):
>> drivers/net/ethernet/freescale/dpaa/./dpaa_eth_trace.h:29:1: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] fd_status @@     got restricted __be32 const [usertype] status @@
   drivers/net/ethernet/freescale/dpaa/./dpaa_eth_trace.h:29:1: sparse:     expected unsigned int [usertype] fd_status
   drivers/net/ethernet/freescale/dpaa/./dpaa_eth_trace.h:29:1: sparse:     got restricted __be32 const [usertype] status
   drivers/net/ethernet/freescale/dpaa/dpaa_eth.c: note: in included file (through include/trace/perf.h, include/trace/define_trace.h, drivers/net/ethernet/freescale/dpaa/dpaa_eth_trace.h):
>> drivers/net/ethernet/freescale/dpaa/./dpaa_eth_trace.h:29:1: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] fd_status @@     got restricted __be32 const [usertype] status @@
   drivers/net/ethernet/freescale/dpaa/./dpaa_eth_trace.h:29:1: sparse:     expected unsigned int [usertype] fd_status
   drivers/net/ethernet/freescale/dpaa/./dpaa_eth_trace.h:29:1: sparse:     got restricted __be32 const [usertype] status
>> drivers/net/ethernet/freescale/dpaa/dpaa_eth.c:2745:24: sparse: sparse: cast to restricted __be32
   drivers/net/ethernet/freescale/dpaa/dpaa_eth.c: note: in included file (through include/linux/module.h):
   include/linux/list.h:83:21: sparse: sparse: self-comparison always evaluates to true
   drivers/net/ethernet/freescale/dpaa/dpaa_eth.c: note: in included file:
>> include/soc/fsl/qman.h:245:16: sparse: sparse: cast to restricted __be32
>> include/soc/fsl/qman.h:245:16: sparse: sparse: cast from restricted __be16

vim +29 drivers/net/ethernet/freescale/dpaa/./dpaa_eth_trace.h

eb11ddf36eb87f Madalin Bucur           2016-11-15  16  
eb11ddf36eb87f Madalin Bucur           2016-11-15  17  #define fd_format_name(format)	{ qm_fd_##format, #format }
eb11ddf36eb87f Madalin Bucur           2016-11-15  18  #define fd_format_list	\
eb11ddf36eb87f Madalin Bucur           2016-11-15  19  	fd_format_name(contig),	\
eb11ddf36eb87f Madalin Bucur           2016-11-15  20  	fd_format_name(sg)
eb11ddf36eb87f Madalin Bucur           2016-11-15  21  
eb11ddf36eb87f Madalin Bucur           2016-11-15  22  /* This is used to declare a class of events.
eb11ddf36eb87f Madalin Bucur           2016-11-15  23   * individual events of this type will be defined below.
eb11ddf36eb87f Madalin Bucur           2016-11-15  24   */
eb11ddf36eb87f Madalin Bucur           2016-11-15  25  
eb11ddf36eb87f Madalin Bucur           2016-11-15  26  /* Store details about a frame descriptor and the FQ on which it was
eb11ddf36eb87f Madalin Bucur           2016-11-15  27   * transmitted/received.
eb11ddf36eb87f Madalin Bucur           2016-11-15  28   */
eb11ddf36eb87f Madalin Bucur           2016-11-15 @29  DECLARE_EVENT_CLASS(dpaa_eth_fd,
eb11ddf36eb87f Madalin Bucur           2016-11-15  30  	/* Trace function prototype */
eb11ddf36eb87f Madalin Bucur           2016-11-15  31  	TP_PROTO(struct net_device *netdev,
eb11ddf36eb87f Madalin Bucur           2016-11-15  32  		 struct qman_fq *fq,
eb11ddf36eb87f Madalin Bucur           2016-11-15  33  		 const struct qm_fd *fd),
eb11ddf36eb87f Madalin Bucur           2016-11-15  34  
eb11ddf36eb87f Madalin Bucur           2016-11-15  35  	/* Repeat argument list here */
eb11ddf36eb87f Madalin Bucur           2016-11-15  36  	TP_ARGS(netdev, fq, fd),
eb11ddf36eb87f Madalin Bucur           2016-11-15  37  
eb11ddf36eb87f Madalin Bucur           2016-11-15  38  	/* A structure containing the relevant information we want to record.
eb11ddf36eb87f Madalin Bucur           2016-11-15  39  	 * Declare name and type for each normal element, name, type and size
eb11ddf36eb87f Madalin Bucur           2016-11-15  40  	 * for arrays. Use __string for variable length strings.
eb11ddf36eb87f Madalin Bucur           2016-11-15  41  	 */
eb11ddf36eb87f Madalin Bucur           2016-11-15  42  	TP_STRUCT__entry(
eb11ddf36eb87f Madalin Bucur           2016-11-15  43  		__field(u32,	fqid)
eb11ddf36eb87f Madalin Bucur           2016-11-15  44  		__field(u64,	fd_addr)
eb11ddf36eb87f Madalin Bucur           2016-11-15  45  		__field(u8,	fd_format)
eb11ddf36eb87f Madalin Bucur           2016-11-15  46  		__field(u16,	fd_offset)
eb11ddf36eb87f Madalin Bucur           2016-11-15  47  		__field(u32,	fd_length)
eb11ddf36eb87f Madalin Bucur           2016-11-15  48  		__field(u32,	fd_status)
eb11ddf36eb87f Madalin Bucur           2016-11-15  49  		__string(name,	netdev->name)
eb11ddf36eb87f Madalin Bucur           2016-11-15  50  	),
eb11ddf36eb87f Madalin Bucur           2016-11-15  51  
eb11ddf36eb87f Madalin Bucur           2016-11-15  52  	/* The function that assigns values to the above declared fields */
eb11ddf36eb87f Madalin Bucur           2016-11-15  53  	TP_fast_assign(
eb11ddf36eb87f Madalin Bucur           2016-11-15  54  		__entry->fqid = fq->fqid;
eb11ddf36eb87f Madalin Bucur           2016-11-15  55  		__entry->fd_addr = qm_fd_addr_get64(fd);
eb11ddf36eb87f Madalin Bucur           2016-11-15  56  		__entry->fd_format = qm_fd_get_format(fd);
eb11ddf36eb87f Madalin Bucur           2016-11-15  57  		__entry->fd_offset = qm_fd_get_offset(fd);
eb11ddf36eb87f Madalin Bucur           2016-11-15  58  		__entry->fd_length = qm_fd_get_length(fd);
eb11ddf36eb87f Madalin Bucur           2016-11-15  59  		__entry->fd_status = fd->status;
2c92ca849fcc6e Steven Rostedt (Google  2024-05-16  60) 		__assign_str(name);
eb11ddf36eb87f Madalin Bucur           2016-11-15  61  	),
eb11ddf36eb87f Madalin Bucur           2016-11-15  62  
eb11ddf36eb87f Madalin Bucur           2016-11-15  63  	/* This is what gets printed when the trace event is triggered */
eb11ddf36eb87f Madalin Bucur           2016-11-15  64  	TP_printk("[%s] fqid=%d, fd: addr=0x%llx, format=%s, off=%u, len=%u, status=0x%08x",
eb11ddf36eb87f Madalin Bucur           2016-11-15  65  		  __get_str(name), __entry->fqid, __entry->fd_addr,
eb11ddf36eb87f Madalin Bucur           2016-11-15  66  		  __print_symbolic(__entry->fd_format, fd_format_list),
eb11ddf36eb87f Madalin Bucur           2016-11-15  67  		  __entry->fd_offset, __entry->fd_length, __entry->fd_status)
eb11ddf36eb87f Madalin Bucur           2016-11-15  68  );
eb11ddf36eb87f Madalin Bucur           2016-11-15  69  

:::::: The code at line 29 was first introduced by commit
:::::: eb11ddf36eb87f3d568248370be4fdaaefb5043c dpaa_eth: add trace points

:::::: TO: Madalin Bucur <madalin.bucur@nxp.com>
:::::: CC: David S. Miller <davem@davemloft.net>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

