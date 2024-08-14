Return-Path: <linux-kernel+bounces-286971-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D5BB6952101
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 19:24:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 58E2BB23CFF
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 17:24:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C22C1BBBF5;
	Wed, 14 Aug 2024 17:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WhbElZxS"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB0EB111A1
	for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 17:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723656271; cv=none; b=qMqDwO5KRGue2o5MZpShWBcopCILCY2DX2uFiBSXBxttzYiKCI7GziJsRO/I//OAJLVtRa2DwvnjNRGSn9ppBpuhL6t4nRu8++jMrt63kCZYTTGSjsxMz8hNcnfGh9FkHoCJk/xudx4xrJl6f1OsRUvqdbqErpfG7S7uVDYWUGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723656271; c=relaxed/simple;
	bh=lA+xgV+iDgHq0xbaiiQy3rlhIvSZnsZQd5TAPMVjzso=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UHABWjgYV9pygbCXL6Mxa1rM3Xgu8oL+8Tnl6nYThofWKbU43GbK2Ed9NeWOVoErSl6EvvzpnlGK1D+3WiCboSIC4fzrjg2LdTOED0RZ1ZmNbpjmfGJSL37pewvA9ooGUkKstzaRUS32qwNYGdoDxiuyIqlpznxwuMdugpe38yQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WhbElZxS; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723656270; x=1755192270;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=lA+xgV+iDgHq0xbaiiQy3rlhIvSZnsZQd5TAPMVjzso=;
  b=WhbElZxSq0PC/Zzpybr4sDkmt9u8RlWqrIJfgQYzdm2P+0f1k5UyLMZ0
   WAvKEZkPtRe9xlkZH5QbqQNiW7ixi7DUEY6++2vEgQi2n4svPfdCGHKeu
   2MstTe0EhFVyJhjvVKwqsC2MTrMEEmHA03xTEsh+HjBKiXwBilRQi58q+
   BhjQ69bORUIYkx2ydnUDQfWcIdRnY/+ANVeG4dbOYBZm8KYu9AiEig3S+
   XkhVgmc/OXfTX8Ok4Qa3xAKrOPUbShvKMzRnliOGynwgbnNqy02eWOPQD
   KY1pHbClnWk4cB4XoC6QJEYPlZ6qd+/mJeIj8w4lAF9C0Gt5hnCbZkuiw
   A==;
X-CSE-ConnectionGUID: JZxvmZu1QuiVYVsv2bRZrg==
X-CSE-MsgGUID: oebdHWwyQeKD1FTqbLj7PQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11164"; a="32564565"
X-IronPort-AV: E=Sophos;i="6.10,146,1719903600"; 
   d="scan'208";a="32564565"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2024 10:24:29 -0700
X-CSE-ConnectionGUID: wffD7kcEScaJXp8C+mn8Ag==
X-CSE-MsgGUID: jJzill+7TK+s2hclhmnJyA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,146,1719903600"; 
   d="scan'208";a="89790982"
Received: from lkp-server01.sh.intel.com (HELO 9a732dc145d3) ([10.239.97.150])
  by orviesa002.jf.intel.com with ESMTP; 14 Aug 2024 10:24:24 -0700
Received: from kbuild by 9a732dc145d3 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1seHjS-0002bs-1C;
	Wed, 14 Aug 2024 17:24:22 +0000
Date: Thu, 15 Aug 2024 01:24:22 +0800
From: kernel test robot <lkp@intel.com>
To: Li Li <dualli@chromium.org>, dualli@google.com,
	gregkh@linuxfoundation.org, arve@android.com, tkjos@android.com,
	maco@android.com, joel@joelfernandes.org, brauner@kernel.org,
	cmllamas@google.com, surenb@google.com, arnd@arndb.de,
	masahiroy@kernel.org, devel@driverdev.osuosl.org,
	linux-kernel@vger.kernel.org, hridya@google.com,
	smoreland@google.com
Cc: oe-kbuild-all@lists.linux.dev, kernel-team@android.com
Subject: Re: [PATCH v1] add binder genl for txn report
Message-ID: <202408150142.elc854F6-lkp@intel.com>
References: <20240812211844.4107494-1-dualli@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240812211844.4107494-1-dualli@chromium.org>

Hi Li,

kernel test robot noticed the following build errors:

[auto build test ERROR on staging/staging-testing]
[also build test ERROR on staging/staging-next staging/staging-linus linus/master v6.11-rc3 next-20240814]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Li-Li/add-binder-genl-for-txn-report/20240814-150338
base:   staging/staging-testing
patch link:    https://lore.kernel.org/r/20240812211844.4107494-1-dualli%40chromium.org
patch subject: [PATCH v1] add binder genl for txn report
config: x86_64-buildonly-randconfig-005-20240814 (https://download.01.org/0day-ci/archive/20240815/202408150142.elc854F6-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240815/202408150142.elc854F6-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202408150142.elc854F6-lkp@intel.com/

All errors (new ones prefixed by >>):

   ld: vmlinux.o: in function `binder_genl_cmd_doit':
   binder_genl.c:(.text+0x1284e00): undefined reference to `__alloc_skb'
   ld: binder_genl.c:(.text+0x1284e2f): undefined reference to `genlmsg_put'
   ld: binder_genl.c:(.text+0x1284e5c): undefined reference to `nla_put'
   ld: binder_genl.c:(.text+0x1284e94): undefined reference to `init_net'
   ld: binder_genl.c:(.text+0x1284e9d): undefined reference to `netlink_unicast'
   ld: binder_genl.c:(.text+0x1284f04): undefined reference to `skb_trim'
   ld: binder_genl.c:(.text+0x1284f18): undefined reference to `sk_skb_reason_drop'
   ld: binder_genl.c:(.text+0x1284f72): undefined reference to `sk_skb_reason_drop'
   ld: vmlinux.o: in function `binder_genl_send_report':
>> (.text+0x12850d9): undefined reference to `__alloc_skb'
>> ld: (.text+0x128510a): undefined reference to `genlmsg_put'
>> ld: (.text+0x1285131): undefined reference to `nla_put'
>> ld: (.text+0x128516e): undefined reference to `init_net'
>> ld: (.text+0x1285173): undefined reference to `netlink_unicast'
>> ld: (.text+0x12851c2): undefined reference to `skb_trim'
>> ld: (.text+0x12851d6): undefined reference to `sk_skb_reason_drop'
   ld: (.text+0x128527a): undefined reference to `sk_skb_reason_drop'
   ld: vmlinux.o: in function `binder_genl_init':
>> (.init.text+0xa5bd7): undefined reference to `genl_register_family'

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

