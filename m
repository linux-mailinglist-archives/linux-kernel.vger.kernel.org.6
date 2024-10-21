Return-Path: <linux-kernel+bounces-373674-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3205E9A5A1B
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 08:02:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 572241C2170B
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 06:02:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21D661946C8;
	Mon, 21 Oct 2024 06:02:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="it4XXUve"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA9982209B;
	Mon, 21 Oct 2024 06:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729490571; cv=none; b=VWsBulpRG+Nz5e2/0WVMe30U8ZVnq3T6xyDpUNjrvz4edOCOyyY0xWkZypvW2GnM7l65/K3+qZMoPsEZ7x9nd5RZdW0HVh9J7oehsNTrv5NqbHRliCgxSZirvcGoAhr39EUskjnqOG5fN7Sd5pZwT/oLTyVb95ICb4W6jfcoWa0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729490571; c=relaxed/simple;
	bh=vu4RT3On7XnbTi5GEYXuD7VfT612YLOO9q2H7/dwXMk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BpSW9RO5kgZvgAzwx7Om8h2D7+2gEeOF1Oc9cnq+Rf8YJ5H+5/BOtcLN7JpG+I/PdnO6zcpZNwEz4YKrg8bBwuqHtc36pbpiZ8+pL9bC3L1aBcNa5UsosOoq1G0qrZrl/boe6/4DoaRdvvU16udUD5KCYJJSXtOBx637ceOHtR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=it4XXUve; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729490569; x=1761026569;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=vu4RT3On7XnbTi5GEYXuD7VfT612YLOO9q2H7/dwXMk=;
  b=it4XXUveHkGElbmpZX7T3OLz73cL61fk/hn7F5ySLQF2XPTktzyLps3/
   /ZHMbVB3irKUof/Ga2D3Sr8uKdCUaY8eop5wUHAJM7boWMSSrbo2+kZIz
   YDlT76hdT6pQp4EqFkkouyF7q9Nm8bFw0fNn9ob+aWxcwIWu1ewjQoBj6
   aU9FKatrdKwwR+nmsd+ajO3jiFMOqDrDtwdwe5BeUqbt2QWQ709z8D03j
   Gr10+8ZlEBWQjJu3KtoFverXKirrt6GRlKwe5hnoutTPBRMyX0j60PnPY
   6JJqQqWbxIMuAQ64O/i0cBhvsZIEoU9mbs4eHpirjOJgQa9GmwBFYleZ3
   g==;
X-CSE-ConnectionGUID: 4w4ihZ86SrSQcBKzM25b9w==
X-CSE-MsgGUID: UcXIjHebTMuqXWZs8SNk8Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="32641225"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="32641225"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2024 23:02:48 -0700
X-CSE-ConnectionGUID: 3RVbadbzQXiJFfRCWoMknA==
X-CSE-MsgGUID: Aho/sbD2QMWKcyndR5WT4g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,220,1725346800"; 
   d="scan'208";a="84214852"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by orviesa005.jf.intel.com with ESMTP; 20 Oct 2024 23:02:43 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1t2lV2-000RFj-2h;
	Mon, 21 Oct 2024 06:02:40 +0000
Date: Mon, 21 Oct 2024 14:02:34 +0800
From: kernel test robot <lkp@intel.com>
To: Inochi Amaoto <inochiama@gmail.com>,
	Chen Wang <unicorn_wang@outlook.com>,
	Thomas Gleixner <tglx@linutronix.de>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Peter Zijlstra <peterz@infradead.org>,
	Inochi Amaoto <inochiama@outlook.com>, Guo Ren <guoren@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Yangyu Chen <cyy@cyyself.name>,
	Hal Feng <hal.feng@starfivetech.com>
Cc: Paul Gazzillo <paul@pgazz.com>,
	Necip Fazil Yildiran <fazilyildiran@gmail.com>,
	oe-kbuild-all@lists.linux.dev, Yixun Lan <dlan@gentoo.org>,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	linux-riscv@lists.infradead.org
Subject: Re: [PATCH v3 2/3] irqchip: add T-HEAD C900 ACLINT SSWI driver
Message-ID: <202410211310.9jsZOb1L-lkp@intel.com>
References: <20241020121030.1012572-3-inochiama@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241020121030.1012572-3-inochiama@gmail.com>

Hi Inochi,

kernel test robot noticed the following build warnings:

[auto build test WARNING on tip/irq/core]
[also build test WARNING on sophgo/for-next sophgo/fixes tip/smp/core robh/for-next linus/master v6.12-rc4 next-20241018]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Inochi-Amaoto/dt-bindings-interrupt-controller-Add-Sophgo-SG2044-ACLINT-SSWI/20241020-201209
base:   tip/irq/core
patch link:    https://lore.kernel.org/r/20241020121030.1012572-3-inochiama%40gmail.com
patch subject: [PATCH v3 2/3] irqchip: add T-HEAD C900 ACLINT SSWI driver
config: riscv-kismet-CONFIG_GENERIC_IRQ_IPI_MUX-CONFIG_THEAD_C900_ACLINT_SSWI-0-0 (https://download.01.org/0day-ci/archive/20241021/202410211310.9jsZOb1L-lkp@intel.com/config)
reproduce: (https://download.01.org/0day-ci/archive/20241021/202410211310.9jsZOb1L-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202410211310.9jsZOb1L-lkp@intel.com/

kismet warnings: (new ones prefixed by >>)
>> kismet: WARNING: unmet direct dependencies detected for GENERIC_IRQ_IPI_MUX when selected by THEAD_C900_ACLINT_SSWI
   WARNING: unmet direct dependencies detected for GENERIC_IRQ_IPI_MUX
     Depends on [n]: SMP [=n]
     Selected by [y]:
     - THEAD_C900_ACLINT_SSWI [=y] && RISCV [=y]

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

