Return-Path: <linux-kernel+bounces-343347-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 127509899ED
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 06:55:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C15911F217E5
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 04:55:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D400D12EBEA;
	Mon, 30 Sep 2024 04:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FT9CL003"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 252B71362
	for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 04:55:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727672153; cv=none; b=D6WpeVGw2cV65u5MKcRxMESEzuiVrs9yH0C4GF3WEJemeSSMKxj1mAifnGMowUd6YpSaN1snf65SP0KO8FE9PC+HWxgAqYJdb+dgx9N/vwsLjqZlRYmT1v1Lz+HrLr2uRU18EL6WT5SXkv9YZ2QBPmKzDwdNBWyNw7eThk/OeZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727672153; c=relaxed/simple;
	bh=Q55zwcK9NHHveRM5fKdkKDh6Ss/hCJR9Dsw/ROEkuZc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=IdKjvzVq0ITZFBhE36YwAZFUHHLMYYsflbXOb10utq6q5jqx0M450ZngEiRYgb6tngdfU8TaH/shjZ2Aryb0aMlwLOwHyHpo0V5blSSu01sCPoKd1j9vzlp1uY+zrzY7YGiBF9rWZNMnCblOFj8N73a7nTlrB/YuTl57CdoSCiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FT9CL003; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727672150; x=1759208150;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Q55zwcK9NHHveRM5fKdkKDh6Ss/hCJR9Dsw/ROEkuZc=;
  b=FT9CL0039/95fvrvEU2c2ZrMaTda6uOgKXJ/rgGy9P6pO5314oUoOYrq
   6mc29PuaY47Zhekig4mOeRPjC9upnv9TmeyJi7YFr6CYZIsi3rURoXowK
   iV6ORhkYzdpAl1W/o42Oe/tIv5ujrqJWgAmF4nCN9TB16JXElIeY7bbOY
   p28onSdpeidADW2UPy+5ELwG0ypJeadNjKgOQbs/HtEdtRGJQgSL1Lupd
   2EG8FWjHQXr4E4+SGENiWVKjvrSnFF1Zd4lspo5w7PBfwG6JEQIMhU8Pl
   9I6MWTOTkPi1Q1z1MN+4AMSnOgDbFCnzKcP/pCWu89XiEowvBWieFkQ69
   Q==;
X-CSE-ConnectionGUID: r6LAD4+/TEaIU2cGv1vRdQ==
X-CSE-MsgGUID: seNE6+6KQ9u1GzNm29xkOQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11210"; a="37304119"
X-IronPort-AV: E=Sophos;i="6.11,164,1725346800"; 
   d="scan'208";a="37304119"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2024 21:55:49 -0700
X-CSE-ConnectionGUID: Pt5FmVBVRcilAKBRB6MS5w==
X-CSE-MsgGUID: jxF4VoX4Teusqr4NXPXcHw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,164,1725346800"; 
   d="scan'208";a="73449632"
Received: from lkp-server01.sh.intel.com (HELO 53e96f405c61) ([10.239.97.150])
  by orviesa006.jf.intel.com with ESMTP; 29 Sep 2024 21:55:48 -0700
Received: from kbuild by 53e96f405c61 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sv8Rm-000P3T-06;
	Mon, 30 Sep 2024 04:55:46 +0000
Date: Mon, 30 Sep 2024 12:55:23 +0800
From: kernel test robot <lkp@intel.com>
To: Johannes Berg <johannes.berg@intel.com>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-kernel@vger.kernel.org, Richard Weinberger <richard@nod.at>
Subject: llvm-objcopy: error: Link field value 78 in section .rel.plt is not
 a symbol table
Message-ID: <202409301246.IGnVGOfv-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   9852d85ec9d492ebef56dc5f229416c925758edc
commit: 8c6174503c7b7134c22072b45f92724c8a959f06 um: hostfs: define our own API boundary
date:   1 year, 5 months ago
config: um-randconfig-001-20240929 (https://download.01.org/0day-ci/archive/20240930/202409301246.IGnVGOfv-lkp@intel.com/config)
compiler: clang version 20.0.0git (https://github.com/llvm/llvm-project 7773243d9916f98ba0ffce0c3a960e4aa9f03e81)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240930/202409301246.IGnVGOfv-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202409301246.IGnVGOfv-lkp@intel.com/

All errors (new ones prefixed by >>):

   /usr/bin/ld: warning: .tmp_vmlinux.btf has a LOAD segment with RWX permissions
>> llvm-objcopy: error: Link field value 78 in section .rel.plt is not a symbol table
   btf_encoder__write_elf: failed to add .BTF section to '.tmp_vmlinux.btf': 2!
   Failed to encode BTF
   .btf.vmlinux.bin.o: file not recognized: file format not recognized
   clang: error: linker command failed with exit code 1 (use -v to see invocation)

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

