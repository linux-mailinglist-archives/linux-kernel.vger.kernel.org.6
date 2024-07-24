Return-Path: <linux-kernel+bounces-260497-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D691F93AA41
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 02:57:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9A91D28453C
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 00:57:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE11F5221;
	Wed, 24 Jul 2024 00:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KJxy2Xzc"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37980290F
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2024 00:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721782621; cv=none; b=kHOUG8xo9d9yaPp8F7NwKltM6RbPtSomwG4J3ejtp9svGZP1ZUjZhMLfkI4LgE/9yowd2LgIWiinNoOLLNsQoCP+XsR8tXNn/v5o6GYrRsF8vlvL/A4s84VehI7BmIvYvIM9t7pqgUNUvX7KOUTOobai6rirFnETYIHKaeKw78g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721782621; c=relaxed/simple;
	bh=l2GwPdv7X5GsJVoTR+K0x66sBo/f2oVbtOLNeCB43VA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=rZO/6lJj7JgbUw4hi/pkqX/CNMnYZeU1no0SBA2iUNjl0p45Q9Ch0N76Rbk1TyFk5n65ug6jzGROcRd++wWqn5tr9vEqTclkWCWomYOO0OsphUk2hx2DY8P9+XYSeQsW8p3A2jKJk1Rz1Y6iprB1FHBATPF3JGuLacyZVNNmULU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KJxy2Xzc; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1721782619; x=1753318619;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=l2GwPdv7X5GsJVoTR+K0x66sBo/f2oVbtOLNeCB43VA=;
  b=KJxy2XzcCsURquPlNMF67ZNSamxHK+3ryosrn/2jd0AuJRgjlJ/IHQpv
   68k6qFE2Rihbg+KP/xs57IM8Z+fNZTtuh37jw1cyZdG1jhYeb9y9a2z/z
   uYxjy/hooZx8wMLMwhA3L4ZYmOztZ+NoWfNATQAxtvGMqqupPUZKy/AZ/
   iQgOOWqg6MKXq8G6QZ8zs0syDrl0ztvo0I42apJE8TzsNzL9c5I/sxdUA
   VWL3pUTwNo+RrfiPaefPiHA5xlOm3l9xWQ9OPJjEwTSMtjGnKDup9JcYP
   9bLLe8X6OLrBA4iaaTGg6owisEOkTlyM0BHQV/0wcyGbotVEN1MzJl2Mh
   A==;
X-CSE-ConnectionGUID: z5NAX6veRw66BmOaTojegA==
X-CSE-MsgGUID: zsD2xtvfQO6z+yH6+Euwmg==
X-IronPort-AV: E=McAfee;i="6700,10204,11142"; a="19243804"
X-IronPort-AV: E=Sophos;i="6.09,232,1716274800"; 
   d="scan'208";a="19243804"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jul 2024 17:56:59 -0700
X-CSE-ConnectionGUID: zoXRsZPDSOSLGujx9LfCaA==
X-CSE-MsgGUID: F3jC3tKUSMW3z+Hs2phywQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,232,1716274800"; 
   d="scan'208";a="56712372"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by fmviesa005.fm.intel.com with ESMTP; 23 Jul 2024 17:56:57 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sWQJL-000mVU-13;
	Wed, 24 Jul 2024 00:56:55 +0000
Date: Wed, 24 Jul 2024 08:56:24 +0800
From: kernel test robot <lkp@intel.com>
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Jan Kara <jack@suse.cz>
Subject: fs/reiserfs/inode.o: warning: objtool: reiserfs_write_folio+0x394:
 unreachable instruction
Message-ID: <202407240856.rcNo0xl1-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   5ad7ff8738b8bd238ca899df08badb1f61bcc39e
commit: 4f8cf60ac18bee62e8c58654a300eb44b96caf09 reiserfs: Convert to writepages
date:   3 months ago
config: loongarch-randconfig-001-20240722 (https://download.01.org/0day-ci/archive/20240724/202407240856.rcNo0xl1-lkp@intel.com/config)
compiler: loongarch64-linux-gcc (GCC) 14.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240724/202407240856.rcNo0xl1-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202407240856.rcNo0xl1-lkp@intel.com/

All warnings (new ones prefixed by >>):

   fs/reiserfs/inode.o: warning: objtool: restart_transaction+0x38: unreachable instruction
   fs/reiserfs/inode.o: warning: objtool: reiserfs_write_begin+0x90: unreachable instruction
   fs/reiserfs/inode.o: warning: objtool: __reiserfs_write_begin+0x88: unreachable instruction
>> fs/reiserfs/inode.o: warning: objtool: reiserfs_write_folio+0x394: unreachable instruction
   fs/reiserfs/inode.o: warning: objtool: reiserfs_new_inode+0x8c: unreachable instruction


objdump-func vmlinux.o reiserfs_write_folio:

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

