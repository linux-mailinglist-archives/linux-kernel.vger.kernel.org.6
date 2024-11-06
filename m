Return-Path: <linux-kernel+bounces-397698-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A7A39BDF27
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 08:09:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0CCD2B23674
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 07:09:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 507271990A2;
	Wed,  6 Nov 2024 07:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ONT95VoX"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E48A193084;
	Wed,  6 Nov 2024 07:09:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730876958; cv=none; b=L8wxpntjjtWkc3A5G9EvzECQ5/DieHH94Ub08m5w7zFQIrjbvgBxrPWRBo3Nv2i/mxOrlmCycT7T7gr8JRDFLHJJK1OXJdSwtub9l3CAjUJmFr+xh0U9VeekBdrxoeRHEPTce1v8fnZKKTag3hoJ5fE+07YyWhq2ebfNa+EhI7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730876958; c=relaxed/simple;
	bh=Aik0BlK9GpCBPc4NaR4/Gdl2TUZQRHDvQtSQx1TcZJA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gR/teQ+vBjZWMtC9NLpZiPd0PZSfpFyW/DGNB1arp6q4MTb5M7ixCUma63nwsoGlop/e3gcZBYj2lpd/WJFdpcW7SYUlcGQpXR3Wh5spRFLwoofBFgi3vj2tvBYHC+Ap9KkD63HmqdLZCPXhvt3sbu5urOsxA1FE5Gw+GMNpsLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ONT95VoX; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730876958; x=1762412958;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Aik0BlK9GpCBPc4NaR4/Gdl2TUZQRHDvQtSQx1TcZJA=;
  b=ONT95VoXb4qoHQuU2BXF6jeFKQXdKNOhsSVoBnICXixw81DqKlL3uicr
   v4KAPbU+lrs7xf4d2ncl4OKMQLqm/QYxJbmX7xtZuYdEo4UW/7cGpp5C8
   zt/CYBmRXSpimB5C3VRdVzEDnPdFhag5w5okQQ3q+3i4pGXJbNNK9bsD3
   syj2CzIG+nsVphwPrJ8t6vSbp2f2IOKa6vY6rHX2XBV6g2S08vCPFpChP
   RouPQ8H2h6U6eHyDmIrH9heMfRXac9JQWuE0Y1Cj5oBt721DWa1DvSiYy
   ic8nZ5S917lhjKPfuuYDtmLGJtNrBeNgq/T2qid9jMJyTAFZsZGJRUMo9
   A==;
X-CSE-ConnectionGUID: 4quSh+AiSDaRd3GlCb7ccA==
X-CSE-MsgGUID: 1RXvsbRPQDyK8jAkddg7Lg==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="30819280"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="30819280"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2024 23:09:17 -0800
X-CSE-ConnectionGUID: g+ijCVvvQJaH0WlrizcASQ==
X-CSE-MsgGUID: 5U6qr/TmQ2KoaYtWCIxuDg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,262,1725346800"; 
   d="scan'208";a="89213837"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by orviesa005.jf.intel.com with ESMTP; 05 Nov 2024 23:09:13 -0800
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1t8aAA-000n2A-0k;
	Wed, 06 Nov 2024 07:09:10 +0000
Date: Wed, 6 Nov 2024 15:08:53 +0800
From: kernel test robot <lkp@intel.com>
To: Hironori KIKUCHI <kikuchan98@gmail.com>, linux-kernel@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, Hironori KIKUCHI <kikuchan98@gmail.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Jessica Zhang <quic_jesszhan@quicinc.com>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Ryan Walklin <ryan@testtoast.com>, dri-devel@lists.freedesktop.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH 4/7] dt-bindings: display: panel: Add YLM-LBV0345001H-V2
 panel
Message-ID: <202411061425.Qitk3g1Q-lkp@intel.com>
References: <20241105055239.1577275-5-kikuchan98@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241105055239.1577275-5-kikuchan98@gmail.com>

Hi Hironori,

kernel test robot noticed the following build warnings:

[auto build test WARNING on next-20241104]
[also build test WARNING on v6.12-rc6]
[cannot apply to robh/for-next linus/master v6.12-rc6 v6.12-rc5 v6.12-rc4]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Hironori-KIKUCHI/dt-bindings-display-panel-Rename-rg35xx-plus-panel-back-to-WL-355608-A8/20241105-135601
base:   next-20241104
patch link:    https://lore.kernel.org/r/20241105055239.1577275-5-kikuchan98%40gmail.com
patch subject: [PATCH 4/7] dt-bindings: display: panel: Add YLM-LBV0345001H-V2 panel
config: csky-randconfig-051-20241106 (https://download.01.org/0day-ci/archive/20241106/202411061425.Qitk3g1Q-lkp@intel.com/config)
compiler: csky-linux-gcc (GCC) 14.2.0
dtschema version: 2024.10.dev6+g12c3cd5
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241106/202411061425.Qitk3g1Q-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202411061425.Qitk3g1Q-lkp@intel.com/

All warnings (new ones prefixed by >>):

   Documentation/devicetree/bindings/net/snps,dwmac.yaml: mac-mode: missing type definition
>> Warning: Duplicate compatible "anbernic,rg35xx-h-panel" found in schemas matching "$id":
   	http://devicetree.org/schemas/display/panel/anbernic,wl-355608-a8.yaml#
   	http://devicetree.org/schemas/display/panel/anbernic,ylm-lbv0345001h-v2.yaml#
>> Warning: Duplicate compatible "anbernic,rg35xx-sp-panel" found in schemas matching "$id":
   	http://devicetree.org/schemas/display/panel/anbernic,wl-355608-a8.yaml#
   	http://devicetree.org/schemas/display/panel/anbernic,ylm-lbv0345001h-v2.yaml#
>> Warning: Duplicate compatible "anbernic,rg35xx-plus-panel" found in schemas matching "$id":
   	http://devicetree.org/schemas/display/panel/anbernic,wl-355608-a8.yaml#
   	http://devicetree.org/schemas/display/panel/anbernic,ylm-lbv0345001h-v2.yaml#
>> Warning: Duplicate compatible "anbernic,rg35xx-2024-panel" found in schemas matching "$id":
   	http://devicetree.org/schemas/display/panel/anbernic,wl-355608-a8.yaml#
   	http://devicetree.org/schemas/display/panel/anbernic,ylm-lbv0345001h-v2.yaml#

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

