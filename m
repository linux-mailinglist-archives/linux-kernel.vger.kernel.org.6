Return-Path: <linux-kernel+bounces-572709-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C0702A6CDA6
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Mar 2025 03:20:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 19CE0174B36
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Mar 2025 02:20:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A9FE1FF60A;
	Sun, 23 Mar 2025 02:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fXrGb6pf"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7103413635E
	for <linux-kernel@vger.kernel.org>; Sun, 23 Mar 2025 02:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742696438; cv=none; b=CP/aoOjbCRqcJYEua4yAkrhDnOC2gmQrXUzu4/h/Xdk8tqjRRrQHP8ZupKg2kVzkdf5AejgmN/nLyCIjTVnYSctIKyyo7HgdXUHDQxIPpVf0DlDPFVWMAut4AQIUko4oudjj+u9N+bBPZutelyfwibKsVuGzrkfrJRPY6eiGQYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742696438; c=relaxed/simple;
	bh=BZXTt2kjYTHNNCugqk0nXnwtXVvYJwjhPKJVvD79d5M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YBAOOQTD0WEBfvfIUBh1h/SNAefAuzzu3msS/B1In3nIZ/mdab7KUhpv9TwAwBZ3ogSGvy39bKOs0ij2/iwVpB7i8RQMfHSh+FdaBbv6mKxlkuLHGom51rBQdEh2OLnktXYBn2dw+/ai9EhyHdoOcipJhHOtvgmtNsMosBnC75E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fXrGb6pf; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742696437; x=1774232437;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=BZXTt2kjYTHNNCugqk0nXnwtXVvYJwjhPKJVvD79d5M=;
  b=fXrGb6pfhgYwtQyX7O3RNpejJu5tTNQUNdibudSgeYybX3ceySeM6Tos
   0MEbZexhY5YBR9TN1xg25yguEQ48vz2fOZmzVONN/abtJW+tNQ1XBpjD2
   kSeI8zKBfeERCHo7jmSGKbE63hC0FccNsSDLoV5Ftf+t63UKAx7FY7ug0
   X9rrghgU1KoT6QLpc6FR268Hvvn2iiOllein1pDIpMSGdhGkBevcLJz8O
   SCzJjX/aKV61aXhqEzPDJaY261lbRXSaxQoNoBBnNCEU//J6T45lUrKoi
   6bS6ijZwVXyP3YjclnVb8HRh91LmNPy1ScWpP9i/QxKVAAw5JfmTXqBxi
   Q==;
X-CSE-ConnectionGUID: inHWl8b9QvyKJqftWwl9vw==
X-CSE-MsgGUID: ERC7a2l1Q9OHNfmlClKyjw==
X-IronPort-AV: E=McAfee;i="6700,10204,11381"; a="61447175"
X-IronPort-AV: E=Sophos;i="6.14,269,1736841600"; 
   d="scan'208";a="61447175"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Mar 2025 19:20:36 -0700
X-CSE-ConnectionGUID: tiJbONeHQ6KAK9e7l7nWRg==
X-CSE-MsgGUID: YpF4vCJzR4e+lr9yZzykzQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,269,1736841600"; 
   d="scan'208";a="128547063"
Received: from lkp-server02.sh.intel.com (HELO e98e3655d6d2) ([10.239.97.151])
  by orviesa003.jf.intel.com with ESMTP; 22 Mar 2025 19:20:35 -0700
Received: from kbuild by e98e3655d6d2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1twAwx-0002Wx-2w;
	Sun, 23 Mar 2025 02:20:31 +0000
Date: Sun, 23 Mar 2025 10:20:04 +0800
From: kernel test robot <lkp@intel.com>
To: nancyenos <nicymimz@gmail.com>,
	"outreachy @ lists . linux . dev Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	nancyenos <nicymimz@gmail.com>
Subject: Re: [PATCH] staging: octeon: Fix unused macro Argument 'x'
Message-ID: <202503231053.WFt2cPIR-lkp@intel.com>
References: <20250322003218.14134-1-nicymimz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250322003218.14134-1-nicymimz@gmail.com>

Hi nancyenos,

kernel test robot noticed the following build errors:

[auto build test ERROR on staging/staging-testing]

url:    https://github.com/intel-lab-lkp/linux/commits/nancyenos/staging-octeon-Fix-unused-macro-Argument-x/20250322-084136
base:   staging/staging-testing
patch link:    https://lore.kernel.org/r/20250322003218.14134-1-nicymimz%40gmail.com
patch subject: [PATCH] staging: octeon: Fix unused macro Argument 'x'
config: s390-allmodconfig (https://download.01.org/0day-ci/archive/20250323/202503231053.WFt2cPIR-lkp@intel.com/config)
compiler: clang version 18.1.8 (https://github.com/llvm/llvm-project 3b5b5c1ec4a3095ab096dd780e84d7ab81f3d7ff)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250323/202503231053.WFt2cPIR-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202503231053.WFt2cPIR-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/staging/octeon/ethernet.c:258:23: error: use of undeclared identifier 'OCTEON_CN3XXX'
     258 |                 if (OCTEON_IS_MODEL(OCTEON_CN3XXX) ||
         |                                     ^
>> drivers/staging/octeon/ethernet.c:259:23: error: use of undeclared identifier 'OCTEON_CN58XX'
     259 |                     OCTEON_IS_MODEL(OCTEON_CN58XX)) {
         |                                     ^
>> drivers/staging/octeon/ethernet.c:469:25: error: use of undeclared identifier 'OCTEON_FEATURE_PKND'
     469 |         if (octeon_has_feature(OCTEON_FEATURE_PKND))
         |                                ^
>> drivers/staging/octeon/ethernet.c:725:25: error: use of undeclared identifier 'OCTEON_CN68XX'
     725 |                                 if (OCTEON_IS_MODEL(OCTEON_CN68XX))
         |                                                     ^
   4 errors generated.
--
>> drivers/staging/octeon/ethernet-rx.c:67:25: error: use of undeclared identifier 'OCTEON_FEATURE_PKND'
      67 |         if (octeon_has_feature(OCTEON_FEATURE_PKND))
         |                                ^
>> drivers/staging/octeon/ethernet-rx.c:201:22: error: use of undeclared identifier 'OCTEON_CN68XX'
     201 |         if (OCTEON_IS_MODEL(OCTEON_CN68XX)) {
         |                             ^
   drivers/staging/octeon/ethernet-rx.c:233:24: error: use of undeclared identifier 'OCTEON_CN68XX'
     233 |                         if (OCTEON_IS_MODEL(OCTEON_CN68XX)) {
         |                                             ^
   drivers/staging/octeon/ethernet-rx.c:267:26: error: use of undeclared identifier 'OCTEON_FEATURE_PKND'
     267 |                 if (octeon_has_feature(OCTEON_FEATURE_PKND))
         |                                        ^
   drivers/staging/octeon/ethernet-rx.c:389:22: error: use of undeclared identifier 'OCTEON_CN68XX'
     389 |         if (OCTEON_IS_MODEL(OCTEON_CN68XX)) {
         |                             ^
   drivers/staging/octeon/ethernet-rx.c:489:23: error: use of undeclared identifier 'OCTEON_CN68XX'
     489 |                 if (OCTEON_IS_MODEL(OCTEON_CN68XX)) {
         |                                     ^
   drivers/staging/octeon/ethernet-rx.c:532:23: error: use of undeclared identifier 'OCTEON_CN68XX'
     532 |                 if (OCTEON_IS_MODEL(OCTEON_CN68XX))
         |                                     ^
   7 errors generated.
--
>> drivers/staging/octeon/ethernet-tx.c:227:41: error: use of undeclared identifier 'OCTEON_CN3XXX'
     227 |         if ((skb->len < 64) && OCTEON_IS_MODEL(OCTEON_CN3XXX)) {
         |                                                ^
>> drivers/staging/octeon/ethernet-tx.c:558:23: error: use of undeclared identifier 'OCTEON_CN68XX'
     558 |         if (!OCTEON_IS_MODEL(OCTEON_CN68XX))
         |                              ^
   2 errors generated.


vim +/OCTEON_CN3XXX +258 drivers/staging/octeon/ethernet.c

422d97b8b05ed3 Chris Packham 2020-02-05  230  
422d97b8b05ed3 Chris Packham 2020-02-05  231  /**
422d97b8b05ed3 Chris Packham 2020-02-05  232   * cvm_oct_common_change_mtu - change the link MTU
422d97b8b05ed3 Chris Packham 2020-02-05  233   * @dev:     Device to change
422d97b8b05ed3 Chris Packham 2020-02-05  234   * @new_mtu: The new MTU
422d97b8b05ed3 Chris Packham 2020-02-05  235   *
422d97b8b05ed3 Chris Packham 2020-02-05  236   * Returns Zero on success
422d97b8b05ed3 Chris Packham 2020-02-05  237   */
422d97b8b05ed3 Chris Packham 2020-02-05  238  static int cvm_oct_common_change_mtu(struct net_device *dev, int new_mtu)
422d97b8b05ed3 Chris Packham 2020-02-05  239  {
422d97b8b05ed3 Chris Packham 2020-02-05  240  	struct octeon_ethernet *priv = netdev_priv(dev);
422d97b8b05ed3 Chris Packham 2020-02-05  241  	int interface = INTERFACE(priv->port);
422d97b8b05ed3 Chris Packham 2020-02-05  242  #if IS_ENABLED(CONFIG_VLAN_8021Q)
422d97b8b05ed3 Chris Packham 2020-02-05  243  	int vlan_bytes = VLAN_HLEN;
422d97b8b05ed3 Chris Packham 2020-02-05  244  #else
422d97b8b05ed3 Chris Packham 2020-02-05  245  	int vlan_bytes = 0;
422d97b8b05ed3 Chris Packham 2020-02-05  246  #endif
422d97b8b05ed3 Chris Packham 2020-02-05  247  	int mtu_overhead = ETH_HLEN + ETH_FCS_LEN + vlan_bytes;
422d97b8b05ed3 Chris Packham 2020-02-05  248  
422d97b8b05ed3 Chris Packham 2020-02-05  249  	dev->mtu = new_mtu;
422d97b8b05ed3 Chris Packham 2020-02-05  250  
422d97b8b05ed3 Chris Packham 2020-02-05  251  	if ((interface < 2) &&
422d97b8b05ed3 Chris Packham 2020-02-05  252  	    (cvmx_helper_interface_get_mode(interface) !=
422d97b8b05ed3 Chris Packham 2020-02-05  253  		CVMX_HELPER_INTERFACE_MODE_SPI)) {
422d97b8b05ed3 Chris Packham 2020-02-05  254  		int index = INDEX(priv->port);
422d97b8b05ed3 Chris Packham 2020-02-05  255  		/* Add ethernet header and FCS, and VLAN if configured. */
422d97b8b05ed3 Chris Packham 2020-02-05  256  		int max_packet = new_mtu + mtu_overhead;
422d97b8b05ed3 Chris Packham 2020-02-05  257  
422d97b8b05ed3 Chris Packham 2020-02-05 @258  		if (OCTEON_IS_MODEL(OCTEON_CN3XXX) ||
422d97b8b05ed3 Chris Packham 2020-02-05 @259  		    OCTEON_IS_MODEL(OCTEON_CN58XX)) {
422d97b8b05ed3 Chris Packham 2020-02-05  260  			/* Signal errors on packets larger than the MTU */
422d97b8b05ed3 Chris Packham 2020-02-05  261  			cvmx_write_csr(CVMX_GMXX_RXX_FRM_MAX(index, interface),
422d97b8b05ed3 Chris Packham 2020-02-05  262  				       max_packet);
422d97b8b05ed3 Chris Packham 2020-02-05  263  		} else {
422d97b8b05ed3 Chris Packham 2020-02-05  264  			/*
422d97b8b05ed3 Chris Packham 2020-02-05  265  			 * Set the hardware to truncate packets larger
422d97b8b05ed3 Chris Packham 2020-02-05  266  			 * than the MTU and smaller the 64 bytes.
422d97b8b05ed3 Chris Packham 2020-02-05  267  			 */
422d97b8b05ed3 Chris Packham 2020-02-05  268  			union cvmx_pip_frm_len_chkx frm_len_chk;
422d97b8b05ed3 Chris Packham 2020-02-05  269  
422d97b8b05ed3 Chris Packham 2020-02-05  270  			frm_len_chk.u64 = 0;
422d97b8b05ed3 Chris Packham 2020-02-05  271  			frm_len_chk.s.minlen = VLAN_ETH_ZLEN;
422d97b8b05ed3 Chris Packham 2020-02-05  272  			frm_len_chk.s.maxlen = max_packet;
422d97b8b05ed3 Chris Packham 2020-02-05  273  			cvmx_write_csr(CVMX_PIP_FRM_LEN_CHKX(interface),
422d97b8b05ed3 Chris Packham 2020-02-05  274  				       frm_len_chk.u64);
422d97b8b05ed3 Chris Packham 2020-02-05  275  		}
422d97b8b05ed3 Chris Packham 2020-02-05  276  		/*
422d97b8b05ed3 Chris Packham 2020-02-05  277  		 * Set the hardware to truncate packets larger than
422d97b8b05ed3 Chris Packham 2020-02-05  278  		 * the MTU. The jabber register must be set to a
422d97b8b05ed3 Chris Packham 2020-02-05  279  		 * multiple of 8 bytes, so round up.
422d97b8b05ed3 Chris Packham 2020-02-05  280  		 */
422d97b8b05ed3 Chris Packham 2020-02-05  281  		cvmx_write_csr(CVMX_GMXX_RXX_JABBER(index, interface),
422d97b8b05ed3 Chris Packham 2020-02-05  282  			       (max_packet + 7) & ~7u);
422d97b8b05ed3 Chris Packham 2020-02-05  283  	}
422d97b8b05ed3 Chris Packham 2020-02-05  284  	return 0;
422d97b8b05ed3 Chris Packham 2020-02-05  285  }
422d97b8b05ed3 Chris Packham 2020-02-05  286  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

