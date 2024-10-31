Return-Path: <linux-kernel+bounces-389786-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22C969B7148
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 01:45:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DB3172825BC
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 00:45:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF25B1EB48;
	Thu, 31 Oct 2024 00:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TrV3EIYK"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A288C2FD;
	Thu, 31 Oct 2024 00:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730335550; cv=none; b=axfkpejWxDlxF3LynBByCS0rlsInuh/tF9FNEkL7AfyiKEwPMxFZlgKQ9Dy/Qj+sZb7MvHNDbf/TpvFmXKjeNkBJSkWzVUw87EGOuFqJEluIZPXZjkLdF0s93/3S/mfXQrch705RC4bPjprmubAoUNof2pDPuFA0bUiW9p+jMkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730335550; c=relaxed/simple;
	bh=oAA+9OSWf2l09wWMiiddhw7UfO+O2McyY//3wWYPwBo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MH3XKgoXTRAaGL4+Hp8MG5sKnA4nNviJzK+SeWAFEZD5mq+X8hTqgz+fOreSwcrrLj7xzRG0HO/AYdte/d94Q6E3OPwotgLfVZIghaW5eRuNl5HPjiQz6EhcROQOgxLputjOrb9Lh0EVbW8x8B+2iPZa3apmzjkmH24xpbRUoiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TrV3EIYK; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730335548; x=1761871548;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=oAA+9OSWf2l09wWMiiddhw7UfO+O2McyY//3wWYPwBo=;
  b=TrV3EIYKA05jJUu3v56RFE41aWGRuc8AZK9WjXOc0LgVijBropSuoGYh
   mEoZzccSFGb5SFvqVPhfevntmY+TZo5PEusSpjDhDwOWk8NM3nbwEwugl
   h0NxEXQAaVQc8Y5tfpYBusAyn9D9fV6+96B5CMJEuI8P/kclCV5yEjonh
   HLB1zTP7qt/gkWUpikt+ktfvkaoHLzHRuspIJkXUtaj6UZ1Xx3o4ErlGL
   aBDIrvP9vB3rV3JS9mDC73MvPapNoU7qV8Z4moz3RwWgjMZhg65dG00Gl
   B/zCuCpi6XJ+PdNlN0ZaUzEzY2qy55wwwCKWwkXEVeV7KoL4Lu9sYnN7o
   g==;
X-CSE-ConnectionGUID: pBbrpmWVTxy5luXuIjeOpA==
X-CSE-MsgGUID: HOhj0uCgSF2aE7SRWOyvxA==
X-IronPort-AV: E=McAfee;i="6700,10204,11241"; a="40637955"
X-IronPort-AV: E=Sophos;i="6.11,246,1725346800"; 
   d="scan'208";a="40637955"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2024 17:45:47 -0700
X-CSE-ConnectionGUID: X4k+Gr8wTfSo4COVZJWTZg==
X-CSE-MsgGUID: bS1Vd3qcQn2WxqGo5GafTw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,246,1725346800"; 
   d="scan'208";a="82790697"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by fmviesa010.fm.intel.com with ESMTP; 30 Oct 2024 17:45:43 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1t6JJk-000fSq-2D;
	Thu, 31 Oct 2024 00:45:40 +0000
Date: Thu, 31 Oct 2024 08:44:48 +0800
From: kernel test robot <lkp@intel.com>
To: Ryan Chen <ryan_chen@aspeedtech.com>, lee@kernel.org, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, joel@jms.id.au,
	andrew@codeconstruct.com.au, mturquette@baylibre.com,
	sboyd@kernel.org, p.zabel@pengutronix.de,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
	linux-clk@vger.kernel.org, dmitry.baryshkov@linaro.org
Cc: oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH v7 3/3] clk: aspeed: add AST2700 clock driver.
Message-ID: <202410310827.OOitgPg0-lkp@intel.com>
References: <20241028053018.2579200-4-ryan_chen@aspeedtech.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241028053018.2579200-4-ryan_chen@aspeedtech.com>

Hi Ryan,

kernel test robot noticed the following build errors:

[auto build test ERROR on clk/clk-next]
[also build test ERROR on pza/reset/next lee-mfd/for-mfd-next lee-leds/for-leds-next linus/master lee-mfd/for-mfd-fixes v6.12-rc5 next-20241030]
[cannot apply to pza/imx-drm/next]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Ryan-Chen/dt-bindings-mfd-aspeed-support-for-AST2700/20241028-133255
base:   https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git clk-next
patch link:    https://lore.kernel.org/r/20241028053018.2579200-4-ryan_chen%40aspeedtech.com
patch subject: [PATCH v7 3/3] clk: aspeed: add AST2700 clock driver.
config: csky-randconfig-001-20241031 (https://download.01.org/0day-ci/archive/20241031/202410310827.OOitgPg0-lkp@intel.com/config)
compiler: csky-linux-gcc (GCC) 14.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241031/202410310827.OOitgPg0-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202410310827.OOitgPg0-lkp@intel.com/

All errors (new ones prefixed by >>):

   csky-linux-ld: drivers/clk/clk-ast2700.o: in function `ast2700_soc_clk_probe':
   clk-ast2700.c:(.text+0x530): undefined reference to `aspeed_reset_controller_register'
>> csky-linux-ld: clk-ast2700.c:(.text+0x558): undefined reference to `aspeed_reset_controller_register'

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

