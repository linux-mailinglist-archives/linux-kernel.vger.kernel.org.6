Return-Path: <linux-kernel+bounces-568896-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 902E7A69BC6
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 23:08:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6EF1C18917F3
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 22:04:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A69D72165E9;
	Wed, 19 Mar 2025 22:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fY7VwvaS"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A761B20C47C
	for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 22:00:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742421660; cv=none; b=k8ctkxttpt7JhHAXlZCmVJxpdP2E899aA2jQJgOv6pTW3iMpoL23fv97FGWxh1lbYcZ9Ud72Ty4lmuef8KN2cfAonYDGjP/6wjOAMqAkXK8xNDVgRfpARN5XuVSUXABh+0OYiKgFZT1JAvWkHl1KR4lj76yhqvwqKY8McmB8x44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742421660; c=relaxed/simple;
	bh=xFkzuPe8071QwP4bSLQApe14iWS2SWIctQbYZeTUqMs=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=o6GweTZUedajIepUAmsgKjtm9mzCJ1CQiFHC/88LFDbNbxM5ez0Szxhiap86EEes5FKCBKFnxHwy/0TNY7gvNIWoQN3+gTISvmGSgVfZY8GbEpTbzgSI2q5hTrLE1golG+LK8MKrD0gNfiyLTRLFDxvdqdjdBlWNDS3n99m4S2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fY7VwvaS; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742421658; x=1773957658;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=xFkzuPe8071QwP4bSLQApe14iWS2SWIctQbYZeTUqMs=;
  b=fY7VwvaSwxv2HvwU7QV690UNrvnRmYZbAQhdpQWhKwXOlx1SelmCY+Hx
   TbvpPhmRrinBNtPj8TwZWOCMq6vbO64rAZdL0PQztVeqezFuP1yzYSpnI
   wmlnZwaguYAnBNQ2coKj1zEmjkp0GjMsQlzQvWwFLHq8B5/qpoO8vljPw
   bcRHsXTDGPuS8nhE/YVmsiVmUSSYAJoRKqiL3IhT9KnrIfblMepphaMSm
   96nXMfXdOH02RAOMPHHdp3UftcodBNfXFccCnKqoheo1eRyK5Da7AxSbv
   kpoyyJbbird6YySmU+MnIZkF1PGqnm5FR5wUMNlO4W3Dkv6NTXpD6H2yV
   Q==;
X-CSE-ConnectionGUID: FrigOrJIS72+Tt1/IrcaHA==
X-CSE-MsgGUID: RiFGvQNFTqOBLxvAsaDtbA==
X-IronPort-AV: E=McAfee;i="6700,10204,11378"; a="43364068"
X-IronPort-AV: E=Sophos;i="6.14,259,1736841600"; 
   d="scan'208";a="43364068"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2025 15:00:57 -0700
X-CSE-ConnectionGUID: R07qKtp0RY2jZGX/IvLuqA==
X-CSE-MsgGUID: 40Chy0WRQf6Cs2DF+6JBGg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,259,1736841600"; 
   d="scan'208";a="153822794"
Received: from lkp-server02.sh.intel.com (HELO a4747d147074) ([10.239.97.151])
  by fmviesa001.fm.intel.com with ESMTP; 19 Mar 2025 15:00:56 -0700
Received: from kbuild by a4747d147074 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tv1T3-000Fha-32;
	Wed, 19 Mar 2025 22:00:53 +0000
Date: Thu, 20 Mar 2025 06:00:17 +0800
From: kernel test robot <lkp@intel.com>
To: Takashi Iwai <tiwai@suse.de>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: sound/core/seq/snd-seq.o: warning: objtool:
 cc_ev_to_ump_midi2+0x589: return with modified stack frame
Message-ID: <202503200535.J3hAvcjw-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   81e4f8d68c66da301bb881862735bd74c6241a19
commit: a4ff92ff0bdd731eca9f0b50b1cbb5aba89be4b2 ALSA: seq: ump: Transmit RPN/NRPN message at each MSB/LSB data reception
date:   8 months ago
config: x86_64-buildonly-randconfig-003-20250320 (https://download.01.org/0day-ci/archive/20250320/202503200535.J3hAvcjw-lkp@intel.com/config)
compiler: clang version 20.1.0 (https://github.com/llvm/llvm-project 24a30daaa559829ad079f2ff7f73eb4e18095f88)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250320/202503200535.J3hAvcjw-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202503200535.J3hAvcjw-lkp@intel.com/

All warnings (new ones prefixed by >>):

   ld.lld: warning: call to __read_overflow2_field marked "dontcall-warn": detected read beyond size of field (2nd parameter); maybe use struct_group()?
>> sound/core/seq/snd-seq.o: warning: objtool: cc_ev_to_ump_midi2+0x589: return with modified stack frame

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

