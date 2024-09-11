Return-Path: <linux-kernel+bounces-324525-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF487974DC7
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 11:01:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 999A9287950
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 09:01:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE67E153BE8;
	Wed, 11 Sep 2024 09:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Kc1jZ6yx"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FE3D2F860
	for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 09:00:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726045260; cv=none; b=Agsb90kx2RGzFKPldf2DOKty/OdNsI1whKm9lveglh1fBtezxVFrSVTWKwmWfpyPfuXpk6hybBoHwlt35oiEzXCK5DghS2cav+oMWUKS3YkBOxtTa5C1KHy7FvAPJSa0cfMs8DuVEIgIwryoKO6m6UhfXpG/yvzOoumHE2neaU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726045260; c=relaxed/simple;
	bh=C9IcDWvX8JdKfzZiR8BrNEEjYIw4rA+V9soRN3TrQCU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=dIZSEJnVqMuzrr0Ip5ADJ3JfKtXfjLkl07Ly4lQrh1nXkP8+7UoX0T3NAYpM+Q3GyXcPNcUPggm1c1xuit17p9CLz6HLGeEnmf6pVV76aTX11I5vbfWtW8FMB1gr8YOkvA3IvAWfTtVDHif54NgKUzxXHEP85YoVwarB6Fmvkm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Kc1jZ6yx; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726045259; x=1757581259;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=C9IcDWvX8JdKfzZiR8BrNEEjYIw4rA+V9soRN3TrQCU=;
  b=Kc1jZ6yxfZ3g1oprA2LNcBxCwbzIuWDxIA3joVylw55sshGZtA9LEuiC
   XgWDMXCWPprA8WcOEWS3WBmo9xYvUmdi1WZ957JkldJFiMQDZ5z6ZvzP7
   KuGEwotdTXNQ01J5kqgVqerPZFRS1XFrGlyt+cNLQKzLiQJdzEiyIV3A+
   LdL3er7g3F7YZc6oQERGXbl3gtS5MIqj93qcmNC1TZk8ABxAZAe0pSPM4
   jAWM7bf29d8qRjG6Gqyg2INTEk9ZNiEeB9t6cb4P7fPyNrDLFWrbiUzDp
   arLj8yL3ycrKKLiAvvgdWbuJqQEegtCbEbU8YoHlsoX2E0/ZQrIVBvlQk
   Q==;
X-CSE-ConnectionGUID: h9R7nU95TiGWzZQIP2Nxjw==
X-CSE-MsgGUID: 5I79OvgSRrKNAcJDexaAEg==
X-IronPort-AV: E=McAfee;i="6700,10204,11191"; a="24657025"
X-IronPort-AV: E=Sophos;i="6.10,219,1719903600"; 
   d="scan'208";a="24657025"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2024 02:00:45 -0700
X-CSE-ConnectionGUID: trebp31kRoChNeXiGSShmg==
X-CSE-MsgGUID: mRY0xGx8R/6p73D1W9muvg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,219,1719903600"; 
   d="scan'208";a="67008840"
Received: from lkp-server01.sh.intel.com (HELO 53e96f405c61) ([10.239.97.150])
  by fmviesa007.fm.intel.com with ESMTP; 11 Sep 2024 02:00:41 -0700
Received: from kbuild by 53e96f405c61 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1soJDL-0003H1-0X;
	Wed, 11 Sep 2024 09:00:39 +0000
Date: Wed, 11 Sep 2024 16:59:44 +0800
From: kernel test robot <lkp@intel.com>
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: fs/bcachefs/super.c:1096:59-60: Unneeded semicolon
Message-ID: <202409111620.WGpinYej-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   8d8d276ba2fb5f9ac4984f5c10ae60858090babc
commit: 0d529663f04be744d6af879889c5b16e46286ce1 bcachefs: Split brain detection
date:   8 months ago
config: loongarch-randconfig-r063-20240911 (https://download.01.org/0day-ci/archive/20240911/202409111620.WGpinYej-lkp@intel.com/config)
compiler: loongarch64-linux-gcc (GCC) 14.1.0

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202409111620.WGpinYej-lkp@intel.com/

cocci warnings: (new ones prefixed by >>)
>> fs/bcachefs/super.c:1096:59-60: Unneeded semicolon
   fs/bcachefs/super.c:1100:59-60: Unneeded semicolon

vim +1096 fs/bcachefs/super.c

  1065	
  1066	static int bch2_dev_in_fs(struct bch_sb_handle *fs,
  1067				  struct bch_sb_handle *sb)
  1068	{
  1069		if (fs == sb)
  1070			return 0;
  1071	
  1072		if (!uuid_equal(&fs->sb->uuid, &sb->sb->uuid))
  1073			return -BCH_ERR_device_not_a_member_of_filesystem;
  1074	
  1075		if (!bch2_dev_exists(fs->sb, sb->sb->dev_idx))
  1076			return -BCH_ERR_device_has_been_removed;
  1077	
  1078		if (fs->sb->block_size != sb->sb->block_size)
  1079			return -BCH_ERR_mismatched_block_size;
  1080	
  1081		if (le16_to_cpu(fs->sb->version) < bcachefs_metadata_version_member_seq ||
  1082		    le16_to_cpu(sb->sb->version) < bcachefs_metadata_version_member_seq)
  1083			return 0;
  1084	
  1085		if (fs->sb->seq == sb->sb->seq &&
  1086		    fs->sb->write_time != sb->sb->write_time) {
  1087			struct printbuf buf = PRINTBUF;
  1088	
  1089			prt_printf(&buf, "Split brain detected between %pg and %pg:",
  1090				   sb->bdev, fs->bdev);
  1091			prt_newline(&buf);
  1092			prt_printf(&buf, "seq=%llu but write_time different, got", le64_to_cpu(sb->sb->seq));
  1093			prt_newline(&buf);
  1094	
  1095			prt_printf(&buf, "%pg ", fs->bdev);
> 1096			bch2_prt_datetime(&buf, le64_to_cpu(fs->sb->write_time));;
  1097			prt_newline(&buf);
  1098	
  1099			prt_printf(&buf, "%pg ", sb->bdev);
  1100			bch2_prt_datetime(&buf, le64_to_cpu(sb->sb->write_time));;
  1101			prt_newline(&buf);
  1102	
  1103			prt_printf(&buf, "Not using older sb");
  1104	
  1105			pr_err("%s", buf.buf);
  1106			printbuf_exit(&buf);
  1107			return -BCH_ERR_device_splitbrain;
  1108		}
  1109	
  1110		struct bch_member m = bch2_sb_member_get(fs->sb, sb->sb->dev_idx);
  1111		u64 seq_from_fs		= le64_to_cpu(m.seq);
  1112		u64 seq_from_member	= le64_to_cpu(sb->sb->seq);
  1113	
  1114		if (seq_from_fs && seq_from_fs < seq_from_member) {
  1115			pr_err("Split brain detected between %pg and %pg:\n"
  1116			       "%pg believes seq of %pg to be %llu, but %pg has %llu\n"
  1117			       "Not using %pg",
  1118			       sb->bdev, fs->bdev,
  1119			       fs->bdev, sb->bdev, seq_from_fs,
  1120			       sb->bdev, seq_from_member,
  1121			       sb->bdev);
  1122			return -BCH_ERR_device_splitbrain;
  1123		}
  1124	
  1125		return 0;
  1126	}
  1127	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

