Return-Path: <linux-kernel+bounces-299965-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 94D8895DD16
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Aug 2024 11:08:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 34FC91F228FE
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Aug 2024 09:08:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0DA3153BE8;
	Sat, 24 Aug 2024 09:08:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Xlcc4S2e"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53FBD558B7
	for <linux-kernel@vger.kernel.org>; Sat, 24 Aug 2024 09:08:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724490483; cv=none; b=lQMHTm5Z62wde3PLTQ7whHuma0MUKzKXMGfPeWLdWpb960CCE8A/OLJ8bg0Y4AgQhthAD6f8R+Mm87z4j5cqsWp1jnH7W1llRcjRlEy3WEmgNUnUyHCZCxVzWDohGMp5l3+MrfE6CYiaKIUDUYGCqT4zmJZNzGnsHCY8ByewonE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724490483; c=relaxed/simple;
	bh=nO+dgJIkmDAO58yDF+knscpZ/1cT6CKUm6iGHn3zE3g=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=SMNPDm3aJho3FFzD03fXqO66+xAoFKJa49aiiOwz9bK9jgART//DEgAbebhI30tepX9KgRKBa8/fNSCTS9JWu6V7HpEtjtz+jKT8BY1HmfR/u0nrINAptVv5Ux/I0+S0v5OTwEA3raa1jDXEHneDrFvprAtrzRPl0X0YYjPNnj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Xlcc4S2e; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724490481; x=1756026481;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=nO+dgJIkmDAO58yDF+knscpZ/1cT6CKUm6iGHn3zE3g=;
  b=Xlcc4S2e7vmB7ImCaDFmSXHyYJ/qYLEeCBo1J7On1pzNOHTCt8yfQ4AP
   rdNNN3asbMu1zsDDRMBPP5NSJ4sgXIp2dQKPx9XnZUDm6XyNJ+Hurv/WM
   c9JIHB1e3GNGc3fxF4hyQ+J5tF9AdImr3pXl448/XLOzSydTQ/7qgGx4C
   Zrr/bnRqygHW4WQRBGOGzFBfjx0umTzfup2twRSmnufn1L33Pfam1+kI9
   08PHRXhE2upG08VyTp5CIy74RkGI4L7HiL8KS4X78qNrhSp53jbysSH80
   D/eC7STRUoGbFIf4gvFUpWLFxEswh07KJXhQZWAWsnOaB/9pGdqy3hIMe
   A==;
X-CSE-ConnectionGUID: 9FQbNOuRRYuryYXyQAGVAQ==
X-CSE-MsgGUID: KPYwN/+AR1aYQU/okG6O0A==
X-IronPort-AV: E=McAfee;i="6700,10204,11173"; a="34386163"
X-IronPort-AV: E=Sophos;i="6.10,173,1719903600"; 
   d="scan'208";a="34386163"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2024 02:08:00 -0700
X-CSE-ConnectionGUID: fyz6BjuqRwuDczMo8cSlJQ==
X-CSE-MsgGUID: FpDID5CSTjyp2sJvTsF1sw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,173,1719903600"; 
   d="scan'208";a="66975750"
Received: from lkp-server01.sh.intel.com (HELO 9a732dc145d3) ([10.239.97.150])
  by orviesa004.jf.intel.com with ESMTP; 24 Aug 2024 02:07:59 -0700
Received: from kbuild by 9a732dc145d3 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1shmkW-000ENf-30;
	Sat, 24 Aug 2024 09:07:56 +0000
Date: Sat, 24 Aug 2024 17:07:11 +0800
From: kernel test robot <lkp@intel.com>
To: Saurabh Sengar <ssengar@linux.microsoft.com>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-kernel@vger.kernel.org, Wei Liu <wei.liu@kernel.org>,
	Michael Kelley <mikelley@microsoft.com>
Subject: error: ran out of registers during register allocation
Message-ID: <202408241749.UqczF06l-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   d2bafcf224f3911b183113b2fcb536c9e90684a3
commit: f83705a51275ed29117d46e1d68e8b16dcb40507 Driver: VMBus: Add Devicetree support
date:   1 year, 4 months ago
config: i386-buildonly-randconfig-004-20240824 (https://download.01.org/0day-ci/archive/20240824/202408241749.UqczF06l-lkp@intel.com/config)
compiler: clang version 18.1.5 (https://github.com/llvm/llvm-project 617a15a9eac96088ae5e9134248d8236e34b91b1)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240824/202408241749.UqczF06l-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202408241749.UqczF06l-lkp@intel.com/

All errors (new ones prefixed by >>):

>> error: ran out of registers during register allocation
>> error: ran out of registers during register allocation
   2 errors generated.
--
>> error: ran out of registers during register allocation
   1 error generated.
--
>> error: ran out of registers during register allocation
>> error: ran out of registers during register allocation
>> error: ran out of registers during register allocation
>> error: ran out of registers during register allocation
>> error: ran out of registers during register allocation
   5 errors generated.

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

