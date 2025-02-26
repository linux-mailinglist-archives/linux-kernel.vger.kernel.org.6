Return-Path: <linux-kernel+bounces-533857-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A5DF7A45F5F
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 13:36:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4293C1776A5
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 12:35:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7B23218591;
	Wed, 26 Feb 2025 12:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RLq943lP"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 754A985931
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 12:34:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740573293; cv=none; b=ZaMs//KCja86zFOGS5bewP1msFvzCLAnO+ZD9jIW4tiTb1mb5g4s0fd51ZfIcuWzPL4i+5yc7kDZ3KP2gwB7ynk/aQUgwQS2OYwg4NfoT4H9u+2cRLX2+D3GrSKc/GyQm587mBhXGvPbqzX818A6xnpkNfjLl+ms7uq7HCVnDyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740573293; c=relaxed/simple;
	bh=PQOqhMTAND0WfUVL/15Gcri8L3CHX0g9HC1V7Q7Zqjk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=G3xm49Xu0d5aB8ua+UjWuhylvHRkdpAVh7+yEQKqWLK/tvXkbEhXutLwtTkcQn3I4ZUS8ZkgziXSa9RZ2tXHgKZsYCd6RUVP2uL93BbZNRX+0DKg/SLRiMm5+sj7axRHQa5btDqBKkBF9ZZBOTC8lvVyuvYtcniMQXeeVQeST/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RLq943lP; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740573292; x=1772109292;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=PQOqhMTAND0WfUVL/15Gcri8L3CHX0g9HC1V7Q7Zqjk=;
  b=RLq943lPXqyeu3LdaW1oOdcOwDH8yknj9tI+fqhQvrNQukFumyjBvr+n
   2WeKFLb0QusF/Re76JDsyKKp9v0fSHV98RhhQq/6RRzbd36U6Y620lfm5
   moHTuA7NtuPk5r04fqGSAbGyi7/d3dTPYkbrP2kxjoirc1UpUJtQG02Hl
   SChksU4Sh24mbBJqPrv5+04E9gGmnwxmR2ahiHlNkNFKYo+HpyfzAeuKx
   oEICnqs3Ibmz6y866W36tOahu0Eig3SzzeA20bJc4S0KipVJX4Mfercj3
   JdpRk35Qz8LefxWNFekl8Ze/NQGj/x+97lvaXg9CS5SKQvLImMRSpZShV
   w==;
X-CSE-ConnectionGUID: 8SDEedfgSEmD/vZvXVftLQ==
X-CSE-MsgGUID: 5dXmcKA7TguK5a6nNsi6Gg==
X-IronPort-AV: E=McAfee;i="6700,10204,11314"; a="41611108"
X-IronPort-AV: E=Sophos;i="6.12,310,1728975600"; 
   d="scan'208";a="41611108"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2025 04:34:51 -0800
X-CSE-ConnectionGUID: L5qt3kwJTrWwShSWsgB/rA==
X-CSE-MsgGUID: Yjt9/YOXTz+UVXk2BQpSYg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,317,1732608000"; 
   d="scan'208";a="116476092"
Received: from lkp-server02.sh.intel.com (HELO 76cde6cc1f07) ([10.239.97.151])
  by orviesa009.jf.intel.com with ESMTP; 26 Feb 2025 04:34:50 -0800
Received: from kbuild by 76cde6cc1f07 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tnGch-000Bh9-0c;
	Wed, 26 Feb 2025 12:34:47 +0000
Date: Wed, 26 Feb 2025 20:33:19 +0800
From: kernel test robot <lkp@intel.com>
To: Filipe Manana <fdmanana@suse.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	David Sterba <dsterba@suse.com>, Josef Bacik <josef@toxicpanda.com>
Subject: WARNING: modpost: "cmpxchg8b_emu" [fs/btrfs/btrfs.ko] has no CRC!
Message-ID: <202502262004.CMcvv66T-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Filipe,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   ac9c34d1e45a4c25174ced4fc0cfc33ff3ed08c7
commit: 1020443840569535f6025a855958f07ea3eebf71 btrfs: make the extent map shrinker run asynchronously as a work queue job
date:   4 months ago
config: um-randconfig-r054-20230701 (https://download.01.org/0day-ci/archive/20250226/202502262004.CMcvv66T-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250226/202502262004.CMcvv66T-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202502262004.CMcvv66T-lkp@intel.com/

All warnings (new ones prefixed by >>, old ones prefixed by <<):

WARNING: modpost: EXPORT symbol "cmpxchg8b_emu" [vmlinux] version generation failed, symbol will not be versioned.
Is "cmpxchg8b_emu" prototyped in <asm/asm-prototypes.h>?
WARNING: modpost: EXPORT symbol "csum_partial" [vmlinux] version generation failed, symbol will not be versioned.
Is "csum_partial" prototyped in <asm/asm-prototypes.h>?
WARNING: modpost: EXPORT symbol "csum_partial_copy_generic" [vmlinux] version generation failed, symbol will not be versioned.
Is "csum_partial_copy_generic" prototyped in <asm/asm-prototypes.h>?
WARNING: modpost: "csum_partial" [fs/nfsd/nfsd.ko] has no CRC!
>> WARNING: modpost: "cmpxchg8b_emu" [fs/btrfs/btrfs.ko] has no CRC!
WARNING: modpost: "cmpxchg8b_emu" [fs/ceph/ceph.ko] has no CRC!
WARNING: modpost: "cmpxchg8b_emu" [lib/test_lockup.ko] has no CRC!
WARNING: modpost: "csum_partial" [drivers/net/vxlan/vxlan.ko] has no CRC!
WARNING: modpost: "csum_partial" [drivers/net/geneve.ko] has no CRC!
WARNING: modpost: "csum_partial" [net/sched/act_csum.ko] has no CRC!
WARNING: modpost: "csum_partial" [net/sched/act_mpls.ko] has no CRC!
WARNING: modpost: "csum_partial" [net/ipv4/fou.ko] has no CRC!
WARNING: modpost: "csum_partial" [net/ipv6/ip6_tunnel.ko] has no CRC!
WARNING: modpost: "csum_partial" [net/dsa/dsa_core.ko] has no CRC!
WARNING: modpost: "csum_partial" [net/dsa/tag_dsa.ko] has no CRC!
WARNING: modpost: "csum_partial" [net/dsa/tag_lan9303.ko] has no CRC!
WARNING: modpost: "csum_partial" [net/dsa/tag_ocelot.ko] has no CRC!
WARNING: modpost: "csum_partial" [net/wireless/cfg80211.ko] has no CRC!
WARNING: modpost: "csum_partial" [net/sunrpc/sunrpc.ko] has no CRC!
WARNING: modpost: "cmpxchg8b_emu" [net/sunrpc/auth_gss/rpcsec_gss_krb5.ko] has no CRC!
WARNING: modpost: "csum_partial" [net/mac80211/mac80211.ko] has no CRC!
WARNING: modpost: "csum_partial" [net/batman-adv/batman-adv.ko] has no CRC!
WARNING: modpost: "csum_partial" [net/openvswitch/openvswitch.ko] has no CRC!

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

