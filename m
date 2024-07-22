Return-Path: <linux-kernel+bounces-259266-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EF8293933D
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 19:34:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2DF6DB21301
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 17:34:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED6BD16EB58;
	Mon, 22 Jul 2024 17:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Qld73ZAt"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54DC716E864
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 17:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721669639; cv=none; b=fl8Oy4YMdT7xnoSXuQOMFsLPJwmt9VMtBKRN1jXuyaHT8zUUWHUKfQo/oS/k3yM3qNpxZMCSIxXWTHGHOxnjt1TJsZkOMe/VJuRjalm5le1L8a5lI+mPPEYqSPMkVtPJ0cN5bN6d752V4bvapzFwUspTsGyq9Wk3JZlSbTWSuZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721669639; c=relaxed/simple;
	bh=SylpFuWYr8O9DlS4O2vphUzA64YgGD956wPb+dXkl9g=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=sSySdaGt7h4DvVoZJnKEqnk3iDx9ztme4/4H0hZVC/2oNVsTee9Ta5+Zm2bkUAJf8Li4w8fOar7vvalGPvgmcZ0CWCisGhW1eq//iOEFxhndzU+FrD3gkQY3gwDCJN42MQ9zh+cX9FXcYnXuk4D492cs/sQiZHMQ+siNwOWW1TI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Qld73ZAt; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1721669637; x=1753205637;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=SylpFuWYr8O9DlS4O2vphUzA64YgGD956wPb+dXkl9g=;
  b=Qld73ZAtlu3j5J4kSxOJi4I5qWXAcWnG6qNYmPBQlS8lYG7lrMQvYwSx
   HtYn5Cbh0PS+opqKA7u/3rg2pnigX/2XQomkZxx6P031MRmsWF81NyC8i
   3Lo3g+pUbeHFkUtd4KHerRH4ixISZmMaJs14qRtvPWbqOpD1sqq/AJoeX
   6L9kOB33otpkMY46fImo9z9FuTkQP8I3vvpsT6DwnXJUQmbSx9h5T51MG
   QOWh7LwKT+3ep4stlcRZZGaKoK0LryVmgno+5o16et1/NNPPgs75Ey3RU
   aDctUVF+WUi694LFbxn+BoZqQItHy5PQ07cYxEbpk0qex68gulQxARSCU
   Q==;
X-CSE-ConnectionGUID: MxBTiz5pT62GVkEYBajELA==
X-CSE-MsgGUID: R4bDqVlqSq2TbkzU8D47cQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11141"; a="22153976"
X-IronPort-AV: E=Sophos;i="6.09,228,1716274800"; 
   d="scan'208";a="22153976"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2024 10:33:50 -0700
X-CSE-ConnectionGUID: +V4FCHunTYOYtBb0idQrvg==
X-CSE-MsgGUID: WmGLjcm8SFOgCGuHbNlnLA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,228,1716274800"; 
   d="scan'208";a="51838721"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by fmviesa008.fm.intel.com with ESMTP; 22 Jul 2024 10:33:49 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sVwuw-000lH2-2I;
	Mon, 22 Jul 2024 17:33:46 +0000
Date: Tue, 23 Jul 2024 01:33:23 +0800
From: kernel test robot <lkp@intel.com>
To: Mohan Kumar <mkumard@nvidia.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Mark Brown <broonie@kernel.org>, Sameer Pujar <spujar@nvidia.com>
Subject: sound/soc/tegra/tegra210_i2s.c:922:(.text+0x4f0): relocation
 truncated to fit: R_NIOS2_CALL26 against `simple_util_parse_convert'
Message-ID: <202407230154.Bazhs02X-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   933069701c1b507825b514317d4edd5d3fd9d417
commit: 2502f8dd8c30edbca9253d5999294f58211039b1 ASoC: tegra: I2S client convert formats handling
date:   8 weeks ago
config: nios2-buildonly-randconfig-r004-20230209 (https://download.01.org/0day-ci/archive/20240723/202407230154.Bazhs02X-lkp@intel.com/config)
compiler: nios2-linux-gcc (GCC) 13.3.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240723/202407230154.Bazhs02X-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202407230154.Bazhs02X-lkp@intel.com/

All errors (new ones prefixed by >>):

   nios2-linux-ld: sound/soc/tegra/tegra210_i2s.o: in function `tegra210_i2s_probe':
   sound/soc/tegra/tegra210_i2s.c:922:(.text+0x4f0): undefined reference to `simple_util_parse_convert'
>> sound/soc/tegra/tegra210_i2s.c:922:(.text+0x4f0): relocation truncated to fit: R_NIOS2_CALL26 against `simple_util_parse_convert'
>> nios2-linux-ld: sound/soc/tegra/tegra210_i2s.c:932:(.text+0x51c): undefined reference to `simple_util_get_sample_fmt'
>> sound/soc/tegra/tegra210_i2s.c:932:(.text+0x51c): relocation truncated to fit: R_NIOS2_CALL26 against `simple_util_get_sample_fmt'


vim +922 sound/soc/tegra/tegra210_i2s.c

   900	
   901	/*
   902	 * The AHUB HW modules are interconnected with CIF which are capable of
   903	 * supporting Channel and Sample bit format conversion. This needs different
   904	 * CIF Audio and client configuration. As one of the config comes from
   905	 * params_channels() or params_format(), the extra configuration is passed from
   906	 * CIF Port of DT I2S node which can help to perform this conversion.
   907	 *
   908	 *    4ch          audio = 4ch      client = 2ch       2ch
   909	 *   -----> ADMAIF -----------> CIF -------------> I2S ---->
   910	 */
   911	static void tegra210_parse_client_convert(struct device *dev)
   912	{
   913		struct tegra210_i2s *i2s = dev_get_drvdata(dev);
   914		struct device_node *ports, *ep;
   915		struct simple_util_data data = {};
   916		int cif_port = 0;
   917	
   918		ports = of_get_child_by_name(dev->of_node, "ports");
   919		if (ports) {
   920			ep = of_graph_get_endpoint_by_regs(ports, cif_port, -1);
   921			if (ep) {
 > 922				simple_util_parse_convert(ep, NULL, &data);
   923				of_node_put(ep);
   924			}
   925			of_node_put(ports);
   926		}
   927	
   928		if (data.convert_channels)
   929			i2s->client_channels = data.convert_channels;
   930	
   931		if (data.convert_sample_format)
 > 932			i2s->client_sample_format = simple_util_get_sample_fmt(&data);
   933	}
   934	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

