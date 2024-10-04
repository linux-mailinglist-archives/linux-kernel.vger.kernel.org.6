Return-Path: <linux-kernel+bounces-351468-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8543C99118C
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 23:44:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A271A1C21C45
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 21:44:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4767F1AE007;
	Fri,  4 Oct 2024 21:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="h6DWKt5M"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9926231CB1
	for <linux-kernel@vger.kernel.org>; Fri,  4 Oct 2024 21:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728078286; cv=none; b=Kj4RO7XiaWyuXIiSCPWFA6rRYXXKnb2plDcuCH6Ue59kSiizFf43WAqC418g0aH0FGNvRB1axrUi9CjjehT2INy2hrhwoywDzaXNpGDmvtV0/fIdzl1ICrRrWWGr1vONdHDhMOetF5XId9sDBJfddBsLDlN326rSHILFBss2dzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728078286; c=relaxed/simple;
	bh=6S7dQE7YX30x5tG/whRpkE7lHNxsTPiy562mjp3pvLc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Ii3XlxXHkRW+nbKm2RqRxSIZsx+ZZ6KjD7OfZCzTRAbcbox19VDznwyU1HT8WmLBCJ4zUcslmrvEPYCN43Q1vKGOdVX5hk930iMz2W7qI/sbDZaHSASJe/DmrMvn+wuiRhAIm7SKTWmscSCr79HYrXaWwR27oIASlwLn/TEuVCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=h6DWKt5M; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728078285; x=1759614285;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=6S7dQE7YX30x5tG/whRpkE7lHNxsTPiy562mjp3pvLc=;
  b=h6DWKt5MaiB/zK5UaggimCCOgfc1OmEEY/h4B8W9Ob92GWo/5ppM8gbO
   /5QnaxwJu7JnU1NqA7YrsC7nRbClVLTx3WQFUh+Toh2qc08LatzrHFZag
   u5C5vb8i5FcgU58S5qu4aFsbvf8hNo76kVa4hjKuvLMqKDM4F2eBasqOB
   9Wp+54i6Ib9lyVpuBcnGxtVkAm+gSp5mOcwFl7JdFAXxCalEbmJAGjwGG
   MvO8u2XGOc9qHn7bmaiwZH9DZJyaQPztB0l4T6cRChpr85hommtsvtInD
   JuqgjV74zPrfKORF2AYYFkDc+rhPKWMhdbxpoa7hRt6jHC/Inwf0L8lIk
   g==;
X-CSE-ConnectionGUID: s618MG0ZRSWZ8pRYWQXeSA==
X-CSE-MsgGUID: ALyAPIASQ6GFvzTmDx9efg==
X-IronPort-AV: E=McAfee;i="6700,10204,11215"; a="27198274"
X-IronPort-AV: E=Sophos;i="6.11,178,1725346800"; 
   d="scan'208";a="27198274"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Oct 2024 14:44:44 -0700
X-CSE-ConnectionGUID: 62j+IPdPRpGL2GzZTdaNxQ==
X-CSE-MsgGUID: X0BApJk7TES87DfG5zlB7w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,178,1725346800"; 
   d="scan'208";a="98143973"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by fmviesa002.fm.intel.com with ESMTP; 04 Oct 2024 14:44:43 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1swq6K-0002FW-2M;
	Fri, 04 Oct 2024 21:44:40 +0000
Date: Sat, 5 Oct 2024 05:44:27 +0800
From: kernel test robot <lkp@intel.com>
To: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev,
	"Gustavo A. R. Silva" <gustavo@embeddedor.com>,
	LKML <linux-kernel@vger.kernel.org>
Subject: [gustavoars:testing/wfamnae-next20241003 6/14]
 drivers/net/wireless/intel/iwlwifi/mvm/d3.c:2149:2: error: call to
 '__compiletime_assert_1069' declared with 'error' attribute: BUILD_BUG_ON
 failed: conf->keylen < WLAN_KEY_LEN_GCMP_256
Message-ID: <202410050510.vbrOXEXd-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/gustavoars/linux.git testing/wfamnae-next20241003
head:   ec64acf2dce7577a42c01241e78b24afebc26e96
commit: e99409254091557e1e28e56900da37395bed8163 [6/14] wifi: iwlwifi: mvm: Use __counted_by() and avoid -Wfamnae warnings
config: riscv-allmodconfig (https://download.01.org/0day-ci/archive/20241005/202410050510.vbrOXEXd-lkp@intel.com/config)
compiler: clang version 20.0.0git (https://github.com/llvm/llvm-project fef3566a25ff0e34fb87339ba5e13eca17cec00f)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241005/202410050510.vbrOXEXd-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202410050510.vbrOXEXd-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from drivers/net/wireless/intel/iwlwifi/mvm/d3.c:7:
   In file included from include/linux/etherdevice.h:20:
   In file included from include/linux/if_ether.h:19:
   In file included from include/linux/skbuff.h:17:
   In file included from include/linux/bvec.h:10:
   In file included from include/linux/highmem.h:8:
   In file included from include/linux/cacheflush.h:5:
   In file included from arch/riscv/include/asm/cacheflush.h:9:
   In file included from include/linux/mm.h:2213:
   include/linux/vmstat.h:504:43: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-enum-conversion]
     504 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~ ^
     505 |                            item];
         |                            ~~~~
   include/linux/vmstat.h:511:43: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-enum-conversion]
     511 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~ ^
     512 |                            NR_VM_NUMA_EVENT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~~
   include/linux/vmstat.h:518:36: warning: arithmetic between different enumeration types ('enum node_stat_item' and 'enum lru_list') [-Wenum-enum-conversion]
     518 |         return node_stat_name(NR_LRU_BASE + lru) + 3; // skip "nr_"
         |                               ~~~~~~~~~~~ ^ ~~~
   include/linux/vmstat.h:524:43: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-enum-conversion]
     524 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~ ^
     525 |                            NR_VM_NUMA_EVENT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~~
>> drivers/net/wireless/intel/iwlwifi/mvm/d3.c:2149:2: error: call to '__compiletime_assert_1069' declared with 'error' attribute: BUILD_BUG_ON failed: conf->keylen < WLAN_KEY_LEN_GCMP_256
    2149 |         BUILD_BUG_ON(conf->keylen < WLAN_KEY_LEN_GCMP_256);
         |         ^
   include/linux/build_bug.h:50:2: note: expanded from macro 'BUILD_BUG_ON'
      50 |         BUILD_BUG_ON_MSG(condition, "BUILD_BUG_ON failed: " #condition)
         |         ^
   include/linux/build_bug.h:39:37: note: expanded from macro 'BUILD_BUG_ON_MSG'
      39 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
         |                                     ^
   include/linux/compiler_types.h:517:2: note: expanded from macro 'compiletime_assert'
     517 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |         ^
   include/linux/compiler_types.h:505:2: note: expanded from macro '_compiletime_assert'
     505 |         __compiletime_assert(condition, msg, prefix, suffix)
         |         ^
   include/linux/compiler_types.h:498:4: note: expanded from macro '__compiletime_assert'
     498 |                         prefix ## suffix();                             \
         |                         ^
   <scratch space>:67:1: note: expanded from here
      67 | __compiletime_assert_1069
         | ^
>> drivers/net/wireless/intel/iwlwifi/mvm/d3.c:2148:2: error: call to '__compiletime_assert_1068' declared with 'error' attribute: BUILD_BUG_ON failed: conf->keylen < WLAN_KEY_LEN_CCMP
    2148 |         BUILD_BUG_ON(conf->keylen < WLAN_KEY_LEN_CCMP);
         |         ^
   include/linux/build_bug.h:50:2: note: expanded from macro 'BUILD_BUG_ON'
      50 |         BUILD_BUG_ON_MSG(condition, "BUILD_BUG_ON failed: " #condition)
         |         ^
   include/linux/build_bug.h:39:37: note: expanded from macro 'BUILD_BUG_ON_MSG'
      39 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
         |                                     ^
   include/linux/compiler_types.h:517:2: note: expanded from macro 'compiletime_assert'
     517 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |         ^
   include/linux/compiler_types.h:505:2: note: expanded from macro '_compiletime_assert'
     505 |         __compiletime_assert(condition, msg, prefix, suffix)
         |         ^
   include/linux/compiler_types.h:498:4: note: expanded from macro '__compiletime_assert'
     498 |                         prefix ## suffix();                             \
         |                         ^
   <scratch space>:63:1: note: expanded from here
      63 | __compiletime_assert_1068
         | ^
   4 warnings and 2 errors generated.

Kconfig warnings: (for reference only)
   WARNING: unmet direct dependencies detected for MODVERSIONS
   Depends on [n]: MODULES [=y] && !COMPILE_TEST [=y]
   Selected by [y]:
   - RANDSTRUCT_FULL [=y] && (CC_HAS_RANDSTRUCT [=y] || GCC_PLUGINS [=n]) && MODULES [=y]


vim +2149 drivers/net/wireless/intel/iwlwifi/mvm/d3.c

  2134	
  2135	static bool iwl_mvm_gtk_rekey(struct iwl_wowlan_status_data *status,
  2136				      struct ieee80211_vif *vif,
  2137				      struct iwl_mvm *mvm, u32 gtk_cipher)
  2138	{
  2139		int i, j;
  2140		struct ieee80211_key_conf *key;
  2141		DEFINE_FLEX(struct ieee80211_key_conf, conf, key, keylen,
  2142			    WOWLAN_KEY_MAX_SIZE);
  2143		int link_id = vif->active_links ? __ffs(vif->active_links) : -1;
  2144	
  2145		conf->cipher = gtk_cipher;
  2146	
  2147		BUILD_BUG_ON(WLAN_KEY_LEN_CCMP != WLAN_KEY_LEN_GCMP);
> 2148		BUILD_BUG_ON(conf->keylen < WLAN_KEY_LEN_CCMP);
> 2149		BUILD_BUG_ON(conf->keylen < WLAN_KEY_LEN_GCMP_256);
  2150		BUILD_BUG_ON(conf->keylen < WLAN_KEY_LEN_TKIP);
  2151		BUILD_BUG_ON(conf->keylen < sizeof(status->gtk[0].key));
  2152	
  2153		switch (gtk_cipher) {
  2154		case WLAN_CIPHER_SUITE_CCMP:
  2155		case WLAN_CIPHER_SUITE_GCMP:
  2156			conf->keylen = WLAN_KEY_LEN_CCMP;
  2157			break;
  2158		case WLAN_CIPHER_SUITE_GCMP_256:
  2159			conf->keylen = WLAN_KEY_LEN_GCMP_256;
  2160			break;
  2161		case WLAN_CIPHER_SUITE_TKIP:
  2162			conf->keylen = WLAN_KEY_LEN_TKIP;
  2163			break;
  2164		default:
  2165			WARN_ON(1);
  2166		}
  2167	
  2168		for (i = 0; i < ARRAY_SIZE(status->gtk); i++) {
  2169			if (!status->gtk[i].len)
  2170				continue;
  2171	
  2172			conf->keyidx = status->gtk[i].id;
  2173			IWL_DEBUG_WOWLAN(mvm,
  2174					 "Received from FW GTK cipher %d, key index %d\n",
  2175					 conf->cipher, conf->keyidx);
  2176			memcpy(conf->key, status->gtk[i].key,
  2177			       sizeof(status->gtk[i].key));
  2178	
  2179			key = ieee80211_gtk_rekey_add(vif, conf, link_id);
  2180			if (IS_ERR(key))
  2181				return false;
  2182	
  2183			for (j = 0; j < ARRAY_SIZE(status->gtk_seq); j++) {
  2184				if (!status->gtk_seq[j].valid ||
  2185				    status->gtk_seq[j].key_id != key->keyidx)
  2186					continue;
  2187				iwl_mvm_set_key_rx_seq_idx(key, status, j);
  2188				break;
  2189			}
  2190			WARN_ON(j == ARRAY_SIZE(status->gtk_seq));
  2191		}
  2192	
  2193		return true;
  2194	}
  2195	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

