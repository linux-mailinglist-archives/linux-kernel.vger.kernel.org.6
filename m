Return-Path: <linux-kernel+bounces-320650-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 91892970DB7
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 07:54:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B45431C21D6F
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 05:54:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AB131741F0;
	Mon,  9 Sep 2024 05:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lpIR/WDN"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07FDF171658
	for <linux-kernel@vger.kernel.org>; Mon,  9 Sep 2024 05:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725861261; cv=none; b=fjvqp/D8AhM1f2a6vDh3EMeAIHvZhDndRr365oOFiku5IJhgihQ2c7jRmN0pWdoaLU5JkrVqyn2MgQAHcmyVciZN/qv1cjrdRErvWyjezwbEMkki8YVlxaHJJBi9B8V8HEjOgWmseinasDpKb+Kbqck5amnSUS6aXoFSXem2hxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725861261; c=relaxed/simple;
	bh=bxex6xMzInlTbz9S7Sjl0HhrLpmlW6o8zrtqzzxe0Dk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dM6f6TGjFF3cxSz3+393aWJhgej4OxY2pwAiSmt9EoD1+duk0MwwAAXm77nMQUFDGXlXSOiST8lUoOXAe0FB6GmTB9IXrROwzcNzcFxJRAGhHhUJdJQFEiOLeIlSN1iihLF7tmDU96S162hkYi+7IwVcmD4kHo+ljKJvi+gPTEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lpIR/WDN; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725861260; x=1757397260;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=bxex6xMzInlTbz9S7Sjl0HhrLpmlW6o8zrtqzzxe0Dk=;
  b=lpIR/WDNP2L5dFWvRvMG9zkrp2MxQFTNoQwediFzztjEErt93mZJPu/F
   qxdmfsOKkOmR+GBpLc5TBo+Kh6hGj1IPNXGNsAMrIwJZo3cG/Mm5iMV10
   91znzE1ww0ymSFiGnPENc3Y+FKCEc2d9ElANv47o3jQoXf5altrecWACt
   AVS/oiU4bwtEcLy5Gm8Eh07lJBayj2FJUlTpOlP8y6PYZWmRLgOa7hKxJ
   ZWyNPqTktA1sv5+6in5rU8K14f6c6MasF7k8GYNneqOcbmZ3vbIi/733n
   F5v5n5rTLTxGSKTSrZ3vyfaAHzUj8kuSGCsDjM7gl8VjmDrwNvrn2nUAK
   w==;
X-CSE-ConnectionGUID: N41ves0pT16j5RzyVdvp3w==
X-CSE-MsgGUID: O/w2PvwLQy26GVHPoQthaQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11189"; a="35911236"
X-IronPort-AV: E=Sophos;i="6.10,213,1719903600"; 
   d="scan'208";a="35911236"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2024 22:54:19 -0700
X-CSE-ConnectionGUID: XmGWAFyTQ4+Sdw3V8P2ZKQ==
X-CSE-MsgGUID: YjYyMP3fRou+rsudVrrTPA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,213,1719903600"; 
   d="scan'208";a="97266050"
Received: from jkrzyszt-mobl2.ger.corp.intel.com (HELO tlindgre-MOBL1) ([10.245.246.140])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2024 22:54:17 -0700
Date: Mon, 9 Sep 2024 08:54:12 +0300
From: Tony Lindgren <tony.lindgren@linux.intel.com>
To: kernel test robot <lkp@intel.com>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-kernel@vger.kernel.org, Petr Mladek <pmladek@suse.com>
Subject: Re: ERROR: modpost: "match_devname_and_update_preferred_console"
 [drivers/tty/serial/serial_base.ko] undefined!
Message-ID: <Zt6NhNCbiBkSx_Uy@tlindgre-MOBL1>
References: <202409071312.qlwtTOS1-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202409071312.qlwtTOS1-lkp@intel.com>

Hi,

On Sat, Sep 07, 2024 at 01:23:47PM +0800, kernel test robot wrote:
> Hi Tony,
> 
> FYI, the error/warning still remains.
> 
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   b31c4492884252a8360f312a0ac2049349ddf603
> commit: 12c91cec3155f79216641162a32e04a59abb6e37 serial: core: Add serial_base_match_and_update_preferred_console()
> date:   9 weeks ago
> config: i386-buildonly-randconfig-004-20240907 (https://download.01.org/0day-ci/archive/20240907/202409071312.qlwtTOS1-lkp@intel.com/config)
> compiler: clang version 18.1.5 (https://github.com/llvm/llvm-project 617a15a9eac96088ae5e9134248d8236e34b91b1)
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240907/202409071312.qlwtTOS1-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202409071312.qlwtTOS1-lkp@intel.com/
> 
> All errors (new ones prefixed by >>, old ones prefixed by <<):
...

> >> ERROR: modpost: "match_devname_and_update_preferred_console" [drivers/tty/serial/serial_base.ko] undefined!

Sorry I did not realize we still have an open build issue. I'll send a fix.

As the serial port devices drives can select SERIAL_CORE_CONSOLE, and
CONFIG_PRINTK may not be set we should check for both Kconfig options.

So if defined(CONFIG_SERIAL_CORE_CONSOLE) && defined(CONFIG_PRINTK).

Regards,

Tony

