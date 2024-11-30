Return-Path: <linux-kernel+bounces-426232-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B68C09DF09C
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Nov 2024 14:47:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 71E50162F25
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Nov 2024 13:47:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFB1419C575;
	Sat, 30 Nov 2024 13:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="P3+kqHzJ"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF2E0159596
	for <linux-kernel@vger.kernel.org>; Sat, 30 Nov 2024 13:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732974429; cv=none; b=Rpc3w7X4NJG7MWN/oGttMSzaT6tj/OvE57JADd/K6MDppLj8TKQJuyLXt6ygyzdmXk/KFbrg4EqMdo5knNF8SVsnmOcXCPaNcC2tx1h7Wh/8a986+tidiF2P1foaN2iLqATB0RtVindfJzgV0mOwWvBsY7unzo/bTS8UODlxZho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732974429; c=relaxed/simple;
	bh=eie+VG3mSd+zyjGWGVcXMLzvzcIzdqbr/m2yl2JIP80=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Ncj6qlHglxjWoX4NfDSMjss4sp5/YZsZeCFkG/I3Z4tR5/9dzXyzZj7D3WHCn/gjfs1nJJ928Ne9dm+i4rIBF7SG3isxwN/Z1j55g2FHUIIu7gZ66WVGH1q2qFEh7qf8wiPSZO7BEZBiXtGIBw7SBKW3RBlWIGTq6YJa6nMbymk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=P3+kqHzJ; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732974428; x=1764510428;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=eie+VG3mSd+zyjGWGVcXMLzvzcIzdqbr/m2yl2JIP80=;
  b=P3+kqHzJ3fol6RWelkEQQdX4k0/zkXZHifwQTOd5BxG/KWpvnSIVVACm
   /dL6dUYIWvkkYS8Q1f6cHk9QysX7u3J/4CkI/ZPlFY8mrJsxcNx5yRUNB
   znzkc5iB6itqjbhd3on48IdGT5W5syUj6/x0c0WLZKJRPQnQSEJI2lxcZ
   PMsYQIefbg11V3vqLqp29TbvoPHfxZ7ON7miqtqtgl/ox018XgKL4WVfd
   pMePVgs9oqsGMEm4LjopOjY8hYosQPEnbsmPi4lzjP18wlcoGYy5XtQa+
   NH06Xjte97ITWhExcGgHRM+FbCa5WjjZ809TlmpMAXln4F1pUZjwnE59l
   w==;
X-CSE-ConnectionGUID: qs6cC0KwSzuJSYLJuomHdw==
X-CSE-MsgGUID: OCgKgIQCRcm/anvwEpj5iw==
X-IronPort-AV: E=McAfee;i="6700,10204,11272"; a="32542536"
X-IronPort-AV: E=Sophos;i="6.12,198,1728975600"; 
   d="scan'208";a="32542536"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Nov 2024 05:47:07 -0800
X-CSE-ConnectionGUID: Tyu/aA5FTk2erCVD6As5YA==
X-CSE-MsgGUID: s8C7v7jaSG+Uq4wgPAihgA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,198,1728975600"; 
   d="scan'208";a="93159975"
Received: from lkp-server02.sh.intel.com (HELO 36a1563c48ff) ([10.239.97.151])
  by fmviesa009.fm.intel.com with ESMTP; 30 Nov 2024 05:47:06 -0800
Received: from kbuild by 36a1563c48ff with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tHNoO-0000hy-0X;
	Sat, 30 Nov 2024 13:47:04 +0000
Date: Sat, 30 Nov 2024 21:43:55 +0800
From: kernel test robot <lkp@intel.com>
To: Steve French <stfrench@microsoft.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: fs/smb/client/connect.c:2614:6-25: WARNING: atomic_dec_and_test
 variation before object free at line 2622.
Message-ID: <202411302131.YXhblRGy-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   2ba9f676d0a2e408aef14d679984c26373bf37b7
commit: 38c8a9a52082579090e34c033d439ed2cd1a462d smb: move client and server files to common directory fs/smb
date:   1 year, 6 months ago
config: i386-randconfig-051-20241118 (https://download.01.org/0day-ci/archive/20241130/202411302131.YXhblRGy-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202411302131.YXhblRGy-lkp@intel.com/

cocci warnings: (new ones prefixed by >>)
>> fs/smb/client/connect.c:2614:6-25: WARNING: atomic_dec_and_test variation before object free at line 2622.

vim +2614 fs/smb/client/connect.c

d00c28de55a69d fs/cifs/connect.c Jeff Layton 2010-04-24  2607  
9d002df492b14c fs/cifs/connect.c Jeff Layton 2010-10-06  2608  void
9d002df492b14c fs/cifs/connect.c Jeff Layton 2010-10-06  2609  cifs_put_tlink(struct tcon_link *tlink)
9d002df492b14c fs/cifs/connect.c Jeff Layton 2010-10-06  2610  {
9d002df492b14c fs/cifs/connect.c Jeff Layton 2010-10-06  2611  	if (!tlink || IS_ERR(tlink))
9d002df492b14c fs/cifs/connect.c Jeff Layton 2010-10-06  2612  		return;
9d002df492b14c fs/cifs/connect.c Jeff Layton 2010-10-06  2613  
9d002df492b14c fs/cifs/connect.c Jeff Layton 2010-10-06 @2614  	if (!atomic_dec_and_test(&tlink->tl_count) ||
9d002df492b14c fs/cifs/connect.c Jeff Layton 2010-10-06  2615  	    test_bit(TCON_LINK_IN_TREE, &tlink->tl_flags)) {
9d002df492b14c fs/cifs/connect.c Jeff Layton 2010-10-06  2616  		tlink->tl_time = jiffies;
9d002df492b14c fs/cifs/connect.c Jeff Layton 2010-10-06  2617  		return;
9d002df492b14c fs/cifs/connect.c Jeff Layton 2010-10-06  2618  	}
9d002df492b14c fs/cifs/connect.c Jeff Layton 2010-10-06  2619  
9d002df492b14c fs/cifs/connect.c Jeff Layton 2010-10-06  2620  	if (!IS_ERR(tlink_tcon(tlink)))
9d002df492b14c fs/cifs/connect.c Jeff Layton 2010-10-06  2621  		cifs_put_tcon(tlink_tcon(tlink));
9d002df492b14c fs/cifs/connect.c Jeff Layton 2010-10-06 @2622  	kfree(tlink);
9d002df492b14c fs/cifs/connect.c Jeff Layton 2010-10-06  2623  	return;
9d002df492b14c fs/cifs/connect.c Jeff Layton 2010-10-06  2624  }
d00c28de55a69d fs/cifs/connect.c Jeff Layton 2010-04-24  2625  

:::::: The code at line 2614 was first introduced by commit
:::::: 9d002df492b14c690425d9785530371b6c1ccbca cifs: add routines to build sessions and tcons on the fly

:::::: TO: Jeff Layton <jlayton@redhat.com>
:::::: CC: Steve French <sfrench@us.ibm.com>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

