Return-Path: <linux-kernel+bounces-343812-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C650989FDA
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 12:53:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A64D9B23DC3
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 10:53:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64B2BB65C;
	Mon, 30 Sep 2024 10:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XYERiYDp"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30FD018C939
	for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 10:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727693590; cv=none; b=TNoskEwsKfzBAszbdVFb6VMp9emj7yPaqutdEvJecNf0txovNMYxeFF81EMq6QQz2W7YoP62HcRcCzntb3/NzXxDRfE9B/2THoyV5jBy4NSPeo7dVcYPj8lMV6nNbQ6q6AOk9+bp3hPoJ0r1Gp9SWcKXccoQ8nGtLd3e3PpKnD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727693590; c=relaxed/simple;
	bh=R2oUj7MDtm4hWVv71UWEveQWhFJSK6XkDTbHfRryS7k=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=E7BQ7LNuiV3iHlKjo5xkRLDUGf+mGGI9AI5mydMqhYjSUxuviJ53uOra6z6mBK8DcI60CgRWG9HWgJ591Lt+SVJFPO+3VeyjYj28/xDGgyAz1E6lMah+37pqt2QVaHYLx834m5DSSKOoKhosxaikbB8Hv0dkax52qSe39RCg7no=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XYERiYDp; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727693589; x=1759229589;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=R2oUj7MDtm4hWVv71UWEveQWhFJSK6XkDTbHfRryS7k=;
  b=XYERiYDp+y1AC7VRQLNM0uaqTo04X4y41Lgi28ex9/dEq7+VyrH98H80
   TdCBUkdyC5YeOWXPaDqpMzQQVAqYae0nwP2G+PogTh/9YwFTOmnOVgQSU
   s5csNyef4Kdd36rI3z4bUIv75fbWm12gbwKy1/nt3U8bj4Ix9Ky0GWQTF
   Ph0j3mbZBKkNFy4tIqE3k3WWxhiEcGD7UmaolTZcsL5luTS23PQmrYby/
   zz8o3wwtELEAvwbHzqZemSNVTYUD0heEfaFkAAUMBfQQH63AEuWtPE8iB
   GuQTWuRK5B6k4aq2TRlDgI3Xu+w6k57RkZUbZPzrlEx740GplAajoiluc
   Q==;
X-CSE-ConnectionGUID: Nkb4yHeNTaK9eilDF0EIpg==
X-CSE-MsgGUID: et/1nx0JQoWd4YP7E3H/6g==
X-IronPort-AV: E=McAfee;i="6700,10204,11210"; a="26660106"
X-IronPort-AV: E=Sophos;i="6.11,165,1725346800"; 
   d="scan'208";a="26660106"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2024 03:53:08 -0700
X-CSE-ConnectionGUID: PfnqrRNfQsiiK2aSFbbaJg==
X-CSE-MsgGUID: W7T7HlzFSkWoLlcElUBiqw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,165,1725346800"; 
   d="scan'208";a="73658802"
Received: from lkp-server01.sh.intel.com (HELO 53e96f405c61) ([10.239.97.150])
  by orviesa007.jf.intel.com with ESMTP; 30 Sep 2024 03:53:07 -0700
Received: from kbuild by 53e96f405c61 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1svE1Y-000PLx-3D;
	Mon, 30 Sep 2024 10:53:04 +0000
Date: Mon, 30 Sep 2024 18:52:49 +0800
From: kernel test robot <lkp@intel.com>
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: fs/bcachefs/reflink.c:37:5-8: Unneeded variable: "ret". Return "0"
 on line 44
Message-ID: <202409301841.NRs5IxiB-lkp@intel.com>
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
commit: 074cbcdaeee433a02d6d0565b936bee0915cc5da bcachefs: fsck_err()s don't need to manually check c->sb.version anymore
date:   9 months ago
config: arc-randconfig-r061-20240930 (https://download.01.org/0day-ci/archive/20240930/202409301841.NRs5IxiB-lkp@intel.com/config)
compiler: arc-elf-gcc (GCC) 13.2.0

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202409301841.NRs5IxiB-lkp@intel.com/

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

