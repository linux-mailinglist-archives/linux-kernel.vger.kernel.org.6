Return-Path: <linux-kernel+bounces-390206-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C23119B76FE
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 10:02:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8669C285971
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 09:02:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4CF31891B8;
	Thu, 31 Oct 2024 09:02:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Bzxat93o"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 066D5145B07
	for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 09:02:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730365330; cv=none; b=Pd1D7JYF4VkI1NhRhhBO3unfqaaF16xXI0Mzsq6sqE5ikkL+DzIdFwCgvWiGtA0T8j0nAZTTAH15hyuk9xCqWJlJ+++5aey2iYjJxvg+1emM8oWM8J9PqkAUiHSJBu10sfsMaDdNH0U78Nz0AOcduEFSYsHtO435QTGLSEBzmjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730365330; c=relaxed/simple;
	bh=/n84PVy4YbxIQu6M1YNauirYO2NoxZN4HxZ03Pp+Pzc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=sOWy9WzOQmM16/kxQJ76TFRx62YNrjLwm36IqcpkdCJnA2MFo8AA4QRDBcYvaiYEs+e049oKHES8JzkOM7ksnMEy4CHdidIphwUGFQqN7VnBs4IO7Ee9WCWRgI2tXt0rHEk8j1qR//JfXZClJik9gmqXTKsfVPFQQekRQsW0Pgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Bzxat93o; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730365327; x=1761901327;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=/n84PVy4YbxIQu6M1YNauirYO2NoxZN4HxZ03Pp+Pzc=;
  b=Bzxat93oyPoqEcIw/i5h7ANuMbcW5EbbYv5aEjagrmVHWLAGfK/m+TW/
   VyGeQvDxOhFMGP2Q0wApryQHpRtU80Un5M2e864Fz89gh6gSBZucF2U8/
   zWoVooNHVC8WB7yX725rWqAs212+2bf9Txq8+Vvd6iY3d86LYwLslFPes
   mJ1y5dOqnZjbZiupK7BZEOCPLMjoE8dvOQXbMxlXFYtUYkN2VXHDi3iHg
   mKLYVA89kXxJNziFym6ZoutW3bWAJqwJtyauuUV4WaIeAsOqD2ueYrTLh
   7emhEdvrwdOtO2wNJt+nmSLKKsm7dhQK0ihQMJaCgn1AFjUHCdcssu3HU
   Q==;
X-CSE-ConnectionGUID: qeiR6HJYTrSBiBHkmBA4Xw==
X-CSE-MsgGUID: lxP7DuOoR3m9hktEYr1/RA==
X-IronPort-AV: E=McAfee;i="6700,10204,11241"; a="40705624"
X-IronPort-AV: E=Sophos;i="6.11,247,1725346800"; 
   d="scan'208";a="40705624"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2024 02:02:06 -0700
X-CSE-ConnectionGUID: /Udoi9zqQiOSRfx3k09MHQ==
X-CSE-MsgGUID: wlBJBE6ZTFeVUvXQZ81jNA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,247,1725346800"; 
   d="scan'208";a="105885892"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by fmviesa002.fm.intel.com with ESMTP; 31 Oct 2024 02:02:05 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1t6R47-000ftW-1E;
	Thu, 31 Oct 2024 09:02:03 +0000
Date: Thu, 31 Oct 2024 17:01:35 +0800
From: kernel test robot <lkp@intel.com>
To: Andrii Nakryiko <andrii@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Alexei Starovoitov <ast@kernel.org>
Subject: kernel/bpf/token.c:50:6-27: WARNING: atomic_dec_and_test variation
 before object free at line 54.
Message-ID: <202410311704.yIRxjp0C-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   0fc810ae3ae110f9e2fcccce80fc8c8d62f97907
commit: 35f96de04127d332a5c5e8a155d31f452f88c76d bpf: Introduce BPF token object
date:   9 months ago
config: i386-randconfig-051-20241031 (https://download.01.org/0day-ci/archive/20241031/202410311704.yIRxjp0C-lkp@intel.com/config)
compiler: clang version 19.1.2 (https://github.com/llvm/llvm-project 7ba7d8e2f7b6445b60679da826210cdde29eaf8b)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202410311704.yIRxjp0C-lkp@intel.com/

cocci warnings: (new ones prefixed by >>)
>> kernel/bpf/token.c:50:6-27: WARNING: atomic_dec_and_test variation before object free at line 54.

vim +50 kernel/bpf/token.c

    44	
    45	void bpf_token_put(struct bpf_token *token)
    46	{
    47		if (!token)
    48			return;
    49	
  > 50		if (!atomic64_dec_and_test(&token->refcnt))
    51			return;
    52	
    53		INIT_WORK(&token->work, bpf_token_put_deferred);
  > 54		schedule_work(&token->work);
    55	}
    56	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

