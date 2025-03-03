Return-Path: <linux-kernel+bounces-542714-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EF1B9A4CCC9
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 21:35:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DAA691893684
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 20:35:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 755D02343D2;
	Mon,  3 Mar 2025 20:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UmUJv6+X"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69A921DFD83
	for <linux-kernel@vger.kernel.org>; Mon,  3 Mar 2025 20:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741034111; cv=none; b=VVldEwul3TbR0C9MLxM15NL+zGKTf3Pe9LXR722bPhRZSOOlBQS4wmBuTwyf0GkyAZTeWTcF7h7LYyK13DBMY+tsZ3EH/FtitMov/KsClsJKFAdu4Rjub15JKyfzVfu2wS7+fusddywgzdKmW/ZcvCtBOMti+Mg/IQ2OOczrKSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741034111; c=relaxed/simple;
	bh=2DLHd41AajP9/Odp8t26DRg4Y/gTVfcdxk9tVK3GGOg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=fk+0WP702mmuRLpfmkZD/IDQ6d0qLTro9QOqoOzAjjj+LKA3Ak21g4sle7SRO9Fb/GkYGjY2ZFcULEDlvc69n9mZKSLut42XyxiIlsLaBv1NXur0onLbcNOcoyqCvgApojzN6vByWdQi1NYvAa6ZK3RLmJFG0TG4ACMW9TrSjd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UmUJv6+X; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741034110; x=1772570110;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=2DLHd41AajP9/Odp8t26DRg4Y/gTVfcdxk9tVK3GGOg=;
  b=UmUJv6+X7I6PRaNkh57oHtIyvfICTm/L76C5QokLbxhBXzie79KsrMbT
   ri3QD1nVPAWGtvlqzDtG6REXHwXZo9Ltdr28Dp48yaIFLBeFopoPbKcPn
   fKZOzrsEbqu95GkkwCUeQ1GAh5oDyXGPVWJ5+BXJejAoI910GdIcHpalp
   xe8VrbOou/K9BiP+9wcDrBSvEvwUkqQsZNwthCRKVd4n79/N2cPjK2ezK
   fd2b6i6UxnFLD3QiO6y7QBTSU3KmaWtHvI4wNzRe+mBi8bWtJS1dZ93FT
   5j3KcqOllQDs170vZDuAhsekjXVMISQ3mbiNB5KYkNCDRuhwBd6V9Sgei
   A==;
X-CSE-ConnectionGUID: 20PWv1xBToaHh+0gqx5iBw==
X-CSE-MsgGUID: nM2diF9EREuCxComiH827A==
X-IronPort-AV: E=McAfee;i="6700,10204,11362"; a="52134130"
X-IronPort-AV: E=Sophos;i="6.13,330,1732608000"; 
   d="scan'208";a="52134130"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2025 12:35:09 -0800
X-CSE-ConnectionGUID: PLRyAUzNQ8y5RfvgmFjgZA==
X-CSE-MsgGUID: PKOk17L2QReq3UtOHgmbFg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="155338940"
Received: from lkp-server02.sh.intel.com (HELO 76cde6cc1f07) ([10.239.97.151])
  by orviesa001.jf.intel.com with ESMTP; 03 Mar 2025 12:35:07 -0800
Received: from kbuild by 76cde6cc1f07 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tpCVF-000IvA-0Z;
	Mon, 03 Mar 2025 20:35:05 +0000
Date: Tue, 4 Mar 2025 04:34:45 +0800
From: kernel test robot <lkp@intel.com>
To: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>
Subject: drivers/gpu/drm/imx/dcss/dcss-scaler.c:174: warning: Function
 parameter or struct member 'phase0_identity' not described in
 'dcss_scaler_gaussian_filter'
Message-ID: <202503040454.T8GON6Mq-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

Hi Ville,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   99fa936e8e4f117d62f229003c9799686f74cebc
commit: 004555a18d57fbad42553c2e98e00a054bbe618c drm/imx/dcss: Allow build with COMPILE_TEST=y
date:   4 months ago
config: arm64-randconfig-001-20241212 (https://download.01.org/0day-ci/archive/20250304/202503040454.T8GON6Mq-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 12.3.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250304/202503040454.T8GON6Mq-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202503040454.T8GON6Mq-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/gpu/drm/imx/dcss/dcss-scaler.c:174: warning: Function parameter or struct member 'phase0_identity' not described in 'dcss_scaler_gaussian_filter'
>> drivers/gpu/drm/imx/dcss/dcss-scaler.c:271: warning: Function parameter or struct member 'phase0_identity' not described in 'dcss_scaler_filter_design'
>> drivers/gpu/drm/imx/dcss/dcss-scaler.c:271: warning: Function parameter or struct member 'nn_interpolation' not described in 'dcss_scaler_filter_design'


vim +174 drivers/gpu/drm/imx/dcss/dcss-scaler.c

9021c317b77024 Laurentiu Palcu 2020-07-31  164  
9021c317b77024 Laurentiu Palcu 2020-07-31  165  /**
9021c317b77024 Laurentiu Palcu 2020-07-31  166   * dcss_scaler_gaussian_filter() - Generate gaussian prototype filter.
9021c317b77024 Laurentiu Palcu 2020-07-31  167   * @fc_q: fixed-point cutoff frequency normalized to range [0, 1]
9021c317b77024 Laurentiu Palcu 2020-07-31  168   * @use_5_taps: indicates whether to use 5 taps or 7 taps
9021c317b77024 Laurentiu Palcu 2020-07-31  169   * @coef: output filter coefficients
9021c317b77024 Laurentiu Palcu 2020-07-31  170   */
9021c317b77024 Laurentiu Palcu 2020-07-31  171  static void dcss_scaler_gaussian_filter(int fc_q, bool use_5_taps,
9021c317b77024 Laurentiu Palcu 2020-07-31  172  					bool phase0_identity,
9021c317b77024 Laurentiu Palcu 2020-07-31  173  					int coef[][PSC_NUM_TAPS])
9021c317b77024 Laurentiu Palcu 2020-07-31 @174  {
9021c317b77024 Laurentiu Palcu 2020-07-31  175  	int sigma_q, g0_q, g1_q, g2_q;
9021c317b77024 Laurentiu Palcu 2020-07-31  176  	int tap_cnt1, tap_cnt2, tap_idx, phase_cnt;
9021c317b77024 Laurentiu Palcu 2020-07-31  177  	int mid;
9021c317b77024 Laurentiu Palcu 2020-07-31  178  	int phase;
9021c317b77024 Laurentiu Palcu 2020-07-31  179  	int i;
9021c317b77024 Laurentiu Palcu 2020-07-31  180  	int taps;
9021c317b77024 Laurentiu Palcu 2020-07-31  181  
9021c317b77024 Laurentiu Palcu 2020-07-31  182  	if (use_5_taps)
9021c317b77024 Laurentiu Palcu 2020-07-31  183  		for (phase = 0; phase < PSC_STORED_PHASES; phase++) {
9021c317b77024 Laurentiu Palcu 2020-07-31  184  			coef[phase][0] = 0;
9021c317b77024 Laurentiu Palcu 2020-07-31  185  			coef[phase][PSC_NUM_TAPS - 1] = 0;
9021c317b77024 Laurentiu Palcu 2020-07-31  186  		}
9021c317b77024 Laurentiu Palcu 2020-07-31  187  
9021c317b77024 Laurentiu Palcu 2020-07-31  188  	/* seed coefficient scanner */
9021c317b77024 Laurentiu Palcu 2020-07-31  189  	taps = use_5_taps ? PSC_NUM_TAPS_RGBA : PSC_NUM_TAPS;
9021c317b77024 Laurentiu Palcu 2020-07-31  190  	mid = (PSC_NUM_PHASES * taps) / 2 - 1;
9021c317b77024 Laurentiu Palcu 2020-07-31  191  	phase_cnt = (PSC_NUM_PHASES * (PSC_NUM_TAPS + 1)) / 2;
9021c317b77024 Laurentiu Palcu 2020-07-31  192  	tap_cnt1 = (PSC_NUM_PHASES * PSC_NUM_TAPS) / 2;
9021c317b77024 Laurentiu Palcu 2020-07-31  193  	tap_cnt2 = (PSC_NUM_PHASES * PSC_NUM_TAPS) / 2;
9021c317b77024 Laurentiu Palcu 2020-07-31  194  
9021c317b77024 Laurentiu Palcu 2020-07-31  195  	/* seed gaussian filter generator */
9021c317b77024 Laurentiu Palcu 2020-07-31  196  	sigma_q = div_q(PSC_Q_ROUND_OFFSET, fc_q);
9021c317b77024 Laurentiu Palcu 2020-07-31  197  	g0_q = 1 << PSC_Q_FRACTION;
9021c317b77024 Laurentiu Palcu 2020-07-31  198  	g1_q = exp_approx_q(div_q(-PSC_Q_ROUND_OFFSET,
9021c317b77024 Laurentiu Palcu 2020-07-31  199  				  mult_q(sigma_q, sigma_q)));
9021c317b77024 Laurentiu Palcu 2020-07-31  200  	g2_q = mult_q(g1_q, g1_q);
9021c317b77024 Laurentiu Palcu 2020-07-31  201  	coef[phase_cnt & PSC_PHASE_MASK][tap_cnt1 >> PSC_BITS_FOR_PHASE] = g0_q;
9021c317b77024 Laurentiu Palcu 2020-07-31  202  
9021c317b77024 Laurentiu Palcu 2020-07-31  203  	for (i = 0; i < mid; i++) {
9021c317b77024 Laurentiu Palcu 2020-07-31  204  		phase_cnt++;
9021c317b77024 Laurentiu Palcu 2020-07-31  205  		tap_cnt1--;
9021c317b77024 Laurentiu Palcu 2020-07-31  206  		tap_cnt2++;
9021c317b77024 Laurentiu Palcu 2020-07-31  207  
9021c317b77024 Laurentiu Palcu 2020-07-31  208  		g0_q = mult_q(g0_q, g1_q);
9021c317b77024 Laurentiu Palcu 2020-07-31  209  		g1_q = mult_q(g1_q, g2_q);
9021c317b77024 Laurentiu Palcu 2020-07-31  210  
9021c317b77024 Laurentiu Palcu 2020-07-31  211  		if ((phase_cnt & PSC_PHASE_MASK) <= 8) {
9021c317b77024 Laurentiu Palcu 2020-07-31  212  			tap_idx = tap_cnt1 >> PSC_BITS_FOR_PHASE;
9021c317b77024 Laurentiu Palcu 2020-07-31  213  			coef[phase_cnt & PSC_PHASE_MASK][tap_idx] = g0_q;
9021c317b77024 Laurentiu Palcu 2020-07-31  214  		}
9021c317b77024 Laurentiu Palcu 2020-07-31  215  		if (((-phase_cnt) & PSC_PHASE_MASK) <= 8) {
9021c317b77024 Laurentiu Palcu 2020-07-31  216  			tap_idx = tap_cnt2 >> PSC_BITS_FOR_PHASE;
9021c317b77024 Laurentiu Palcu 2020-07-31  217  			coef[(-phase_cnt) & PSC_PHASE_MASK][tap_idx] = g0_q;
9021c317b77024 Laurentiu Palcu 2020-07-31  218  		}
9021c317b77024 Laurentiu Palcu 2020-07-31  219  	}
9021c317b77024 Laurentiu Palcu 2020-07-31  220  
9021c317b77024 Laurentiu Palcu 2020-07-31  221  	phase_cnt++;
9021c317b77024 Laurentiu Palcu 2020-07-31  222  	tap_cnt1--;
9021c317b77024 Laurentiu Palcu 2020-07-31  223  	coef[phase_cnt & PSC_PHASE_MASK][tap_cnt1 >> PSC_BITS_FOR_PHASE] = 0;
9021c317b77024 Laurentiu Palcu 2020-07-31  224  
9021c317b77024 Laurentiu Palcu 2020-07-31  225  	/* override phase 0 with identity filter if specified */
9021c317b77024 Laurentiu Palcu 2020-07-31  226  	if (phase0_identity)
9021c317b77024 Laurentiu Palcu 2020-07-31  227  		for (i = 0; i < PSC_NUM_TAPS; i++)
9021c317b77024 Laurentiu Palcu 2020-07-31  228  			coef[0][i] = i == (PSC_NUM_TAPS >> 1) ?
9021c317b77024 Laurentiu Palcu 2020-07-31  229  						(1 << PSC_COEFF_PRECISION) : 0;
9021c317b77024 Laurentiu Palcu 2020-07-31  230  
9021c317b77024 Laurentiu Palcu 2020-07-31  231  	/* normalize coef */
9021c317b77024 Laurentiu Palcu 2020-07-31  232  	for (phase = 0; phase < PSC_STORED_PHASES; phase++) {
9021c317b77024 Laurentiu Palcu 2020-07-31  233  		int sum = 0;
9021c317b77024 Laurentiu Palcu 2020-07-31  234  		s64 ll_temp;
9021c317b77024 Laurentiu Palcu 2020-07-31  235  
9021c317b77024 Laurentiu Palcu 2020-07-31  236  		for (i = 0; i < PSC_NUM_TAPS; i++)
9021c317b77024 Laurentiu Palcu 2020-07-31  237  			sum += coef[phase][i];
9021c317b77024 Laurentiu Palcu 2020-07-31  238  		for (i = 0; i < PSC_NUM_TAPS; i++) {
9021c317b77024 Laurentiu Palcu 2020-07-31  239  			ll_temp = coef[phase][i];
9021c317b77024 Laurentiu Palcu 2020-07-31  240  			ll_temp <<= PSC_COEFF_PRECISION;
9021c317b77024 Laurentiu Palcu 2020-07-31  241  			ll_temp += sum >> 1;
f2cab5a0e8c3a4 Ville Syrjälä   2024-10-03  242  			ll_temp = div_s64(ll_temp, sum);
9021c317b77024 Laurentiu Palcu 2020-07-31  243  			coef[phase][i] = (int)ll_temp;
9021c317b77024 Laurentiu Palcu 2020-07-31  244  		}
9021c317b77024 Laurentiu Palcu 2020-07-31  245  	}
9021c317b77024 Laurentiu Palcu 2020-07-31  246  }
9021c317b77024 Laurentiu Palcu 2020-07-31  247  
05faf1559de524 Laurentiu Palcu 2020-11-05  248  static void dcss_scaler_nearest_neighbor_filter(bool use_5_taps,
05faf1559de524 Laurentiu Palcu 2020-11-05  249  						int coef[][PSC_NUM_TAPS])
05faf1559de524 Laurentiu Palcu 2020-11-05  250  {
05faf1559de524 Laurentiu Palcu 2020-11-05  251  	int i, j;
05faf1559de524 Laurentiu Palcu 2020-11-05  252  
05faf1559de524 Laurentiu Palcu 2020-11-05  253  	for (i = 0; i < PSC_STORED_PHASES; i++)
05faf1559de524 Laurentiu Palcu 2020-11-05  254  		for (j = 0; j < PSC_NUM_TAPS; j++)
05faf1559de524 Laurentiu Palcu 2020-11-05  255  			coef[i][j] = j == PSC_NUM_TAPS >> 1 ?
05faf1559de524 Laurentiu Palcu 2020-11-05  256  						(1 << PSC_COEFF_PRECISION) : 0;
05faf1559de524 Laurentiu Palcu 2020-11-05  257  }
05faf1559de524 Laurentiu Palcu 2020-11-05  258  
9021c317b77024 Laurentiu Palcu 2020-07-31  259  /**
9021c317b77024 Laurentiu Palcu 2020-07-31  260   * dcss_scaler_filter_design() - Compute filter coefficients using
9021c317b77024 Laurentiu Palcu 2020-07-31  261   *				 Gaussian filter.
9021c317b77024 Laurentiu Palcu 2020-07-31  262   * @src_length: length of input
9021c317b77024 Laurentiu Palcu 2020-07-31  263   * @dst_length: length of output
9021c317b77024 Laurentiu Palcu 2020-07-31  264   * @use_5_taps: 0 for 7 taps per phase, 1 for 5 taps
9021c317b77024 Laurentiu Palcu 2020-07-31  265   * @coef: output coefficients
9021c317b77024 Laurentiu Palcu 2020-07-31  266   */
9021c317b77024 Laurentiu Palcu 2020-07-31  267  static void dcss_scaler_filter_design(int src_length, int dst_length,
9021c317b77024 Laurentiu Palcu 2020-07-31  268  				      bool use_5_taps, bool phase0_identity,
05faf1559de524 Laurentiu Palcu 2020-11-05  269  				      int coef[][PSC_NUM_TAPS],
05faf1559de524 Laurentiu Palcu 2020-11-05  270  				      bool nn_interpolation)
9021c317b77024 Laurentiu Palcu 2020-07-31 @271  {
9021c317b77024 Laurentiu Palcu 2020-07-31  272  	int fc_q;
9021c317b77024 Laurentiu Palcu 2020-07-31  273  
9021c317b77024 Laurentiu Palcu 2020-07-31  274  	/* compute cutoff frequency */
9021c317b77024 Laurentiu Palcu 2020-07-31  275  	if (dst_length >= src_length)
9021c317b77024 Laurentiu Palcu 2020-07-31  276  		fc_q = div_q(1, PSC_NUM_PHASES);
9021c317b77024 Laurentiu Palcu 2020-07-31  277  	else
9021c317b77024 Laurentiu Palcu 2020-07-31  278  		fc_q = div_q(dst_length, src_length * PSC_NUM_PHASES);
9021c317b77024 Laurentiu Palcu 2020-07-31  279  
05faf1559de524 Laurentiu Palcu 2020-11-05  280  	if (nn_interpolation)
05faf1559de524 Laurentiu Palcu 2020-11-05  281  		dcss_scaler_nearest_neighbor_filter(use_5_taps, coef);
05faf1559de524 Laurentiu Palcu 2020-11-05  282  	else
9021c317b77024 Laurentiu Palcu 2020-07-31  283  		/* compute gaussian filter coefficients */
9021c317b77024 Laurentiu Palcu 2020-07-31  284  		dcss_scaler_gaussian_filter(fc_q, use_5_taps, phase0_identity, coef);
9021c317b77024 Laurentiu Palcu 2020-07-31  285  }
9021c317b77024 Laurentiu Palcu 2020-07-31  286  

:::::: The code at line 174 was first introduced by commit
:::::: 9021c317b77024fb2642af7e84ad944769ae0949 drm/imx: Add initial support for DCSS on iMX8MQ

:::::: TO: Laurentiu Palcu <laurentiu.palcu@nxp.com>
:::::: CC: Lucas Stach <l.stach@pengutronix.de>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

