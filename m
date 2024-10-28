Return-Path: <linux-kernel+bounces-383979-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EDB119B22BD
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 03:30:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 99A941F21BFD
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 02:30:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D5131632CE;
	Mon, 28 Oct 2024 02:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lhC1jyhW"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E387165EEB
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 02:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730082609; cv=none; b=V+QYltiRqt7nh6Ry9NZrIYV3dwb7SaMw7/kLnhP+enaKqi+fco2lILvnBqrBkZl6Yr/lblUTNlx5thUEQq6pZ83WhFxXHSnmb1MASSsprVj1CUSRsLRJ3viKOmZAxhmjrrqnA4wNMqdJEHX4Y8T17+puRXJJAGHw7PFbSfjKy4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730082609; c=relaxed/simple;
	bh=vPflcniBB5HgfHs566NWlkAa+8vDqM04BjZ2oX2B2vc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Hs3mHsO1US9OE6Ay2LfjejPaZ2J0bCmbz/h1aH9IjQUYbTiSSrRMKCW54aQPuxhMNnX/IDQAbu9wEoxiMJFovpeNlOH1rqPzj0tdkLSdL2jgYa1jIKbPrepak2l4AmG68RFXD+HFIhu9OeX+5StiaHh2a+OGwNlZLhvFDfX1Ff0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lhC1jyhW; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730082607; x=1761618607;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=vPflcniBB5HgfHs566NWlkAa+8vDqM04BjZ2oX2B2vc=;
  b=lhC1jyhWpCVKbqJSDPg+x1a96Akc5eu7GI9irjKIKgrqO09yPJaAztuq
   cRDF+oUHwzUjAEujEElN6vKVwiLIuV8Q2Rx9+jWdS6BRmN63r5BIXgnEc
   pJcPX8dKC14RFjCFfzb0mDM5Yj4J9yxrIKeeQMcc1mv+o/2SENZ/y3JAZ
   ZDFvvZtPB9SPJEgQhGGY7MIkpx3uRXbQ1HBjaRVSWKPwEu7Fjhx8hEKT1
   wC71c4kHJ7fwJoIN+hTm6MN17qg1eHMXS+4LKOCDW8wXkXbRYVo4xArmV
   qjvkBuMGEZFZbxto303J7jYoRmVMSPS6wGC3/+VJzSBXhj38TP7nfw3cD
   A==;
X-CSE-ConnectionGUID: k7u5zvJDQu2Ca2x0MR9Yiw==
X-CSE-MsgGUID: 3Up64EqCRw6B7CSho5dM0A==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="52225619"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="52225619"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2024 19:30:07 -0700
X-CSE-ConnectionGUID: WU+NGgUZSpa22jfFaXNhpg==
X-CSE-MsgGUID: 8cwwjbOVS6iz0sUPfx5LOw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,238,1725346800"; 
   d="scan'208";a="86579680"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by orviesa004.jf.intel.com with ESMTP; 27 Oct 2024 19:30:06 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1t5FW7-000bC4-2O;
	Mon, 28 Oct 2024 02:30:03 +0000
Date: Mon, 28 Oct 2024 10:29:28 +0800
From: kernel test robot <lkp@intel.com>
To: Takashi Iwai <tiwai@suse.de>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: sound/core/seq/seq_ump_convert.o: warning: objtool:
 cc_ev_to_ump_midi2+0x584: return with modified stack frame
Message-ID: <202410281021.MlTZBXFv-lkp@intel.com>
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
commit: a4ff92ff0bdd731eca9f0b50b1cbb5aba89be4b2 ALSA: seq: ump: Transmit RPN/NRPN message at each MSB/LSB data reception
date:   3 months ago
config: x86_64-randconfig-121-20241028 (https://download.01.org/0day-ci/archive/20241028/202410281021.MlTZBXFv-lkp@intel.com/config)
compiler: clang version 19.1.2 (https://github.com/llvm/llvm-project 7ba7d8e2f7b6445b60679da826210cdde29eaf8b)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241028/202410281021.MlTZBXFv-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202410281021.MlTZBXFv-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> sound/core/seq/seq_ump_convert.o: warning: objtool: cc_ev_to_ump_midi2+0x584: return with modified stack frame

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

