Return-Path: <linux-kernel+bounces-383968-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 595AE9B2297
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 03:10:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B9293B21A5D
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 02:10:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C33817BEAD;
	Mon, 28 Oct 2024 02:09:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NvzNLDKR"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E8911741CB
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 02:09:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730081349; cv=none; b=eUjxsmhAGc9aY9MRi0bxrY6xwsW73KXnFgOkck7TULk9mzD1rDYhYAbKB3rqNZSXjnP6dnWKLRkokAi00r8Zre4pFavtf3dlRUYmGFnoXzgISCI7w1Ua//Fon2XKyBq8cz3v8ZAXMOnfh/hn251mPA5ubU1BAXKWMk880fRKRpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730081349; c=relaxed/simple;
	bh=QbZh9pLsYnbOAqWLwrQwx4h0ILmWLuZsId00c6Qihb0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=TPJeGj2vaD/lNaglESgp+IgAqHUOU65CT8HyVJLMsoLrqE0oQA0PxEUFozR4QfUa0WUI/jhnITHTaoo/DkZrVkUe8kfee4p5bprTixsyinzx6JhxUxQ6Tg8UQklJQtZ8uZ7on1zZJ9AkEnVuTQHLefsPMQAL9beQJczV7EVoGK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NvzNLDKR; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730081347; x=1761617347;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=QbZh9pLsYnbOAqWLwrQwx4h0ILmWLuZsId00c6Qihb0=;
  b=NvzNLDKRnjozVOBzIJihsNf4cgUarhw83Q7Z58Ob+znnYVEjos1k79q/
   xrQpD1JkkauC7NRr33b0pDluHVefVLBQmoYs3RhWn3T38U++dHVoR9BGV
   k50SDiE2VZvRQ9Rwni35Fp5pRLDk5rA4ZMqoAADRyXLdbhF3rUgmVw9mg
   LDvzFY9jmStjvD2BeuP2KN4WneJp1rLLwgJEvzGFNabGRnLacRW4mPsvn
   4K5dGjqsVPTlI5Hgqzeiv2N2FuR7n8Y6Y2BPGk/8oAyz2r+H1Pjk+dgJu
   BrzgbV2xqLFAYMu5CAbFaSZeO5tSzXd+Eie8phC0+AJVupU0LW5695VZ1
   A==;
X-CSE-ConnectionGUID: bQvOOaKXTmWc1xW6mT0VeA==
X-CSE-MsgGUID: Go0TDtZ2QaOY0lxjHVROOA==
X-IronPort-AV: E=McAfee;i="6700,10204,11238"; a="55077735"
X-IronPort-AV: E=Sophos;i="6.11,238,1725346800"; 
   d="scan'208";a="55077735"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2024 19:09:06 -0700
X-CSE-ConnectionGUID: NiBEbUVxR9C+UCWnmqhS4Q==
X-CSE-MsgGUID: FKFxUSaHRu6QfnjeuYhr+g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,238,1725346800"; 
   d="scan'208";a="85413799"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by fmviesa003.fm.intel.com with ESMTP; 27 Oct 2024 19:09:05 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1t5FBm-000bAk-3B;
	Mon, 28 Oct 2024 02:09:02 +0000
Date: Mon, 28 Oct 2024 10:09:02 +0800
From: kernel test robot <lkp@intel.com>
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: fs/bcachefs/reflink.c:37:5-8: Unneeded variable: "ret". Return "0"
 on line 44
Message-ID: <202410281008.mjKBN0fU-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   81983758430957d9a5cb3333fe324fd70cf63e7e
commit: 074cbcdaeee433a02d6d0565b936bee0915cc5da bcachefs: fsck_err()s don't need to manually check c->sb.version anymore
date:   10 months ago
config: m68k-randconfig-r051-20241027 (https://download.01.org/0day-ci/archive/20241028/202410281008.mjKBN0fU-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 14.1.0

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202410281008.mjKBN0fU-lkp@intel.com/

cocci warnings: (new ones prefixed by >>)
>> fs/bcachefs/reflink.c:37:5-8: Unneeded variable: "ret". Return "0" on line 44

vim +37 fs/bcachefs/reflink.c

    31	
    32	int bch2_reflink_p_invalid(struct bch_fs *c, struct bkey_s_c k,
    33				   enum bkey_invalid_flags flags,
    34				   struct printbuf *err)
    35	{
    36		struct bkey_s_c_reflink_p p = bkey_s_c_to_reflink_p(k);
  > 37		int ret = 0;
    38	
    39		bkey_fsck_err_on(le64_to_cpu(p.v->idx) < le32_to_cpu(p.v->front_pad),
    40				 c, err, reflink_p_front_pad_bad,
    41				 "idx < front_pad (%llu < %u)",
    42				 le64_to_cpu(p.v->idx), le32_to_cpu(p.v->front_pad));
    43	fsck_err:
  > 44		return ret;
    45	}
    46	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

