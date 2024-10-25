Return-Path: <linux-kernel+bounces-381950-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 392C09B0697
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 17:00:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E52971F21641
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 15:00:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC81816FF4E;
	Fri, 25 Oct 2024 14:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="f+e7jg41"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 250C21632F9;
	Fri, 25 Oct 2024 14:57:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729868238; cv=none; b=bbQxZS5TG+nQwlOg8XZDHMgrQvBNE2HbhL+ismJDxM2ttmnM3ZZoVgQwOx4/jYI7JewtjS8GOKOpI8tTnjsyU5EMXxOXd/D8Ue7LEFV4DBev7Rh82A2wWNyWH1oGQi2o/qYzr34zPFv/FD19tn31tbenFWrlpOAkHDW7PeOtszQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729868238; c=relaxed/simple;
	bh=slQFkpvsOAihEgvv9wUjUeRexTrOCI2advJJoQkRFNw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QnHSsgHINiRkARYf2IdW8xoKcXyfdwXNQuZQDTxZmLJO2mbCriW0l5XQVLV7M77Ue1f9WKyI9ELf4+grHONneWwnpoflH4U0qgUW4gbqlSiybxblCAThEMwDOiW7qyMZCW+m1mv+FhTqWhHb9DLDDDlMUoD/FDU7I7rajKjjXPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=f+e7jg41; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729868233; x=1761404233;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=slQFkpvsOAihEgvv9wUjUeRexTrOCI2advJJoQkRFNw=;
  b=f+e7jg41V2cfZkh7VpXXXfpsq/5W1NA2NIj/6Ye5uvR1vr1YVUav1Yl4
   8qdgbT8kJlNJXCwctNoNdzcR4QZO9EbdxFkSkC4abLzEi+4MTMZ88blRP
   GKMmgzlMV53XzlnIPjWNgqXNQIVMyUxnbQK6Aso4EiBzE07Hn1QY2B4et
   OknzEE2csqeKVjBohVUcgjj8PpGWaiSudbE1VF0wJFQLRUUieDM+puG1b
   c/olI/qxHOyIgifv/S9SRM2kQF6ELRm6N/dq2Hv3SR6Zd3fObJ+XFMdO9
   pPfK5I12xGgnLKNGFIV28UWB4ku/Ppr1kX6plukgWkFGxuZbb3XyaRtmo
   w==;
X-CSE-ConnectionGUID: OdIkrPOVTqGtWXyiXsbKUw==
X-CSE-MsgGUID: sro77rrnT2i+BfeySQgTqw==
X-IronPort-AV: E=McAfee;i="6700,10204,11236"; a="47023391"
X-IronPort-AV: E=Sophos;i="6.11,232,1725346800"; 
   d="scan'208";a="47023391"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2024 07:57:12 -0700
X-CSE-ConnectionGUID: kFs+VMZSS8yTo5wXD3UPKA==
X-CSE-MsgGUID: CqzqTi+lQnmMt48hJypgFA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,232,1725346800"; 
   d="scan'208";a="81239477"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by fmviesa010.fm.intel.com with ESMTP; 25 Oct 2024 07:57:09 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1t4LkQ-000YNi-1v;
	Fri, 25 Oct 2024 14:57:06 +0000
Date: Fri, 25 Oct 2024 22:56:45 +0800
From: kernel test robot <lkp@intel.com>
To: Ryan Chen <ryan_chen@aspeedtech.com>, lee@kernel.org, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, joel@jms.id.au,
	andrew@codeconstruct.com.au, mturquette@baylibre.com,
	sboyd@kernel.org, p.zabel@pengutronix.de,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
	linux-clk@vger.kernel.org, dmitry.baryshkov@linaro.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH v6 3/3] clk: aspeed: add AST2700 clock driver.
Message-ID: <202410252216.a0X0bOLS-lkp@intel.com>
References: <20241023090153.1395220-4-ryan_chen@aspeedtech.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241023090153.1395220-4-ryan_chen@aspeedtech.com>

Hi Ryan,

kernel test robot noticed the following build errors:

[auto build test ERROR on clk/clk-next]
[also build test ERROR on pza/reset/next lee-mfd/for-mfd-next lee-leds/for-leds-next linus/master lee-mfd/for-mfd-fixes v6.12-rc4 next-20241025]
[cannot apply to pza/imx-drm/next]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Ryan-Chen/dt-bindings-mfd-aspeed-support-for-AST2700/20241023-170434
base:   https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git clk-next
patch link:    https://lore.kernel.org/r/20241023090153.1395220-4-ryan_chen%40aspeedtech.com
patch subject: [PATCH v6 3/3] clk: aspeed: add AST2700 clock driver.
config: hexagon-allmodconfig (https://download.01.org/0day-ci/archive/20241025/202410252216.a0X0bOLS-lkp@intel.com/config)
compiler: clang version 20.0.0git (https://github.com/llvm/llvm-project 5886454669c3c9026f7f27eab13509dd0241f2d6)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241025/202410252216.a0X0bOLS-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202410252216.a0X0bOLS-lkp@intel.com/

All errors (new ones prefixed by >>):

>> ld.lld: error: undefined symbol: aspeed_reset_controller_register
   >>> referenced by clk-ast2700.c
   >>>               drivers/clk/clk-ast2700.o:(ast2700_soc_clk_probe) in archive vmlinux.a
   >>> referenced by clk-ast2700.c
   >>>               drivers/clk/clk-ast2700.o:(ast2700_soc_clk_probe) in archive vmlinux.a

Kconfig warnings: (for reference only)
   WARNING: unmet direct dependencies detected for MODVERSIONS
   Depends on [n]: MODULES [=y] && !COMPILE_TEST [=y]
   Selected by [y]:
   - RANDSTRUCT_FULL [=y] && (CC_HAS_RANDSTRUCT [=y] || GCC_PLUGINS [=n]) && MODULES [=y]
   WARNING: unmet direct dependencies detected for GET_FREE_REGION
   Depends on [n]: SPARSEMEM [=n]
   Selected by [m]:
   - RESOURCE_KUNIT_TEST [=m] && RUNTIME_TESTING_MENU [=y] && KUNIT [=m]

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

