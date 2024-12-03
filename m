Return-Path: <linux-kernel+bounces-428598-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 509FC9E110E
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 03:05:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1B29E282467
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 02:05:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B67E315CD78;
	Tue,  3 Dec 2024 02:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FFEWsQhS"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D1B1154430
	for <linux-kernel@vger.kernel.org>; Tue,  3 Dec 2024 02:04:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733191498; cv=none; b=E4/tuRpM5HakSBjuaGMwANDxuIL2LpnanR6F1mxVYTpqAgf0+PRTGfkh1OpdWYTLxWg+asL9vVWbnGh0erFG7AkGUh1kbzh0Mq0sUoZeD6fIWDVgkw4NMUWqR87yFot7V/d9Q3XVeDG9KYlHgOEP0wxk2teLKi+Bvh5vzbl09oc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733191498; c=relaxed/simple;
	bh=hM6N4Key9gQm1y6+HvTBTyvccuuAVeVxXVvvkX7anVc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=R8OuHI9+tjqOGrk9k2de4UH6fx9J59qkqpb/MDYxM/rE/R7RlytjTYMOXmcnI9gkGASpvpynbKom1HyAvee5UdCuSQgeC2F39k9BS2K5+9m2sgdPHpGeCrHFmdBCpMvHZGWVJf096nRmxFGeG41NCULHTfLxEH191h9pjgF4WqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FFEWsQhS; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733191497; x=1764727497;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=hM6N4Key9gQm1y6+HvTBTyvccuuAVeVxXVvvkX7anVc=;
  b=FFEWsQhSbVOYVTgFuAEyqPh2QUr9WNAjzTMRNd8gzYZLZm3ATqKncJlP
   qYpFANoJFHHpao4fuBPvN03anET8c8TBFzGOB4VCyLiOWg6Ap/D+d+bLh
   bWgncNKekefh1WmHqOeobeN0tt41CU6aU/APhfkJ4viQVM3OVsRvqyXJl
   xkN8cqSM3wczxIV9m7vbwTvEmV1MJvWdkYK+amIX9yIdd4cQKZVBfujCS
   4oq/VI1UzyVAANDKo9/x+hT0fPcHZf4BhtvX15z4VKXbtgb7yVgG7I4Kh
   uqfVEX8jXMLZ5+Oql/VW/SmTCzGPDZYryCnHvsDkI4WIHgzm5tLkavhxq
   w==;
X-CSE-ConnectionGUID: 4Ys74SEsTP6I0hniwclOQg==
X-CSE-MsgGUID: gDKlUVA+T+CrNuPDjWH7GQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11274"; a="33263844"
X-IronPort-AV: E=Sophos;i="6.12,204,1728975600"; 
   d="scan'208";a="33263844"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2024 18:04:56 -0800
X-CSE-ConnectionGUID: 8gyYd6UpQ02tFZd9lqEauQ==
X-CSE-MsgGUID: x8n/cjB1SLOkEqrS/IVOsg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,204,1728975600"; 
   d="scan'208";a="93369311"
Received: from lkp-server02.sh.intel.com (HELO 36a1563c48ff) ([10.239.97.151])
  by orviesa006.jf.intel.com with ESMTP; 02 Dec 2024 18:04:55 -0800
Received: from kbuild by 36a1563c48ff with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tIIHO-00039u-1V;
	Tue, 03 Dec 2024 02:04:49 +0000
Date: Tue, 3 Dec 2024 10:03:58 +0800
From: kernel test robot <lkp@intel.com>
To: Dave Marchevsky <davemarchevsky@fb.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Andrii Nakryiko <andrii@kernel.org>
Subject: versioncheck: ./tools/testing/selftests/bpf/progs/dev_cgroup.c: 9
 linux/version.h not needed.
Message-ID: <202412030943.qdGgRWdO-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   cdd30ebb1b9f36159d66f088b61aee264e649d7a
commit: dd65acf72d0e073970459d5da80573a04304aaa9 selftests/bpf: Remove SEC("version") from test progs
date:   3 years, 2 months ago
reproduce: (https://download.01.org/0day-ci/archive/20241203/202412030943.qdGgRWdO-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202412030943.qdGgRWdO-lkp@intel.com/

versioncheck warnings: (new ones prefixed by >>)
   INFO PATH=/opt/cross/clang/bin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
   /usr/bin/timeout -k 100 3h /usr/bin/make KCFLAGS= -Wtautological-compare -Wno-error=return-type -Wreturn-type -Wcast-function-type -funsigned-char -Wundef -Wformat-overflow -Wformat-truncation -Wrestrict -Wenum-conversion W=1 --keep-going HOSTCC=gcc-12 CC=gcc-12 -j32 ARCH=x86_64 versioncheck
   find ./* \( -name SCCS -o -name BitKeeper -o -name .svn -o -name CVS -o -name .pc -o -name .hg -o -name .git \) -prune -o \
   	-name '*.[hcS]' -type f -print | sort \
   	| xargs perl -w ./scripts/checkversion.pl
   ./arch/csky/include/asm/io.h: 8 linux/version.h not needed.
   ./arch/csky/kernel/process.c: 5 linux/version.h not needed.
   ./arch/csky/mm/dma-mapping.c: 12 linux/version.h not needed.
   ./drivers/media/platform/s3c-camif/camif-core.c: 26 linux/version.h not needed.
   ./drivers/media/platform/sti/c8sectpfe/c8sectpfe-common.h: 16 linux/version.h not needed.
   ./drivers/media/platform/sti/c8sectpfe/c8sectpfe-core.c: 31 linux/version.h not needed.
   ./drivers/media/platform/sti/c8sectpfe/c8sectpfe-dvb.c: 14 linux/version.h not needed.
   ./drivers/media/usb/uvc/uvc_driver.c: 19 linux/version.h not needed.
   ./drivers/net/ethernet/qlogic/qede/qede.h: 10 linux/version.h not needed.
   ./drivers/net/ethernet/qlogic/qede/qede_ethtool.c: 7 linux/version.h not needed.
   ./drivers/scsi/cxgbi/libcxgbi.h: 27 linux/version.h not needed.
   ./drivers/scsi/mpi3mr/mpi3mr.h: 32 linux/version.h not needed.
   ./drivers/scsi/qedi/qedi_dbg.h: 14 linux/version.h not needed.
   ./drivers/staging/media/atomisp/include/linux/atomisp.h: 23 linux/version.h not needed.
   ./init/version.c: 17 linux/version.h not needed.
   ./sound/soc/codecs/cs42l42.c: 14 linux/version.h not needed.
   ./tools/lib/bpf/bpf_helpers.h: 262: need linux/version.h
   ./tools/perf/include/bpf/bpf.h: 70: need linux/version.h
   ./tools/perf/tests/bpf-script-example.c: 49: need linux/version.h
   ./tools/perf/tests/bpf-script-test-kbuild.c: 21: need linux/version.h
   ./tools/perf/tests/bpf-script-test-prologue.c: 47: need linux/version.h
   ./tools/perf/tests/bpf-script-test-relocation.c: 51: need linux/version.h
>> ./tools/testing/selftests/bpf/progs/dev_cgroup.c: 9 linux/version.h not needed.
>> ./tools/testing/selftests/bpf/progs/netcnt_prog.c: 3 linux/version.h not needed.
   ./tools/testing/selftests/bpf/progs/test_map_lock.c: 4 linux/version.h not needed.
   ./tools/testing/selftests/bpf/progs/test_send_signal_kern.c: 4 linux/version.h not needed.
   ./tools/testing/selftests/bpf/progs/test_spin_lock.c: 4 linux/version.h not needed.
   ./tools/testing/selftests/bpf/progs/test_tcp_estats.c: 37 linux/version.h not needed.
   ./tools/testing/selftests/wireguard/qemu/init.c: 25 linux/version.h not needed.

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

