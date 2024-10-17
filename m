Return-Path: <linux-kernel+bounces-369871-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C30DF9A23E0
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 15:33:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C1C071C21217
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 13:33:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BD7A1DE2C4;
	Thu, 17 Oct 2024 13:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="g9sOSzrH"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1BD61DD865
	for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 13:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729172010; cv=none; b=Vh0u42BCBcKxwQo5YepW1PiPGd9txglfzvoJE+KOJpxSK2Z6Oe2gaEZGU7iROb+JuHIvbB24n9wBvuJA13BSBjoVDDjiSql/ptDIPTsKg8auMi1LqI6rb3nzZqssfZQnInPIcfw0MJTqnSjQycCnHBtxgWuJgw/k2BKkosAwspc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729172010; c=relaxed/simple;
	bh=JkDXhb6MlaMFLEm8EgMyS7ZZvyXV2SzLExiOmUrr698=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=OfFgzK761jtJE1YjaSet8CtKBRSOdjdEqYIZLxnYddI6D7ijPJQ8RG/hao6mZ+E7jjkCwl65Qr8RefI1yGPPvBVRZONJ6BNEXZzkAhMnYWsW6ZwUEclwRMV/H7h4/KTQux2dJErMy14HYh/Zg1XSWEjuYtSFld2Gsnvc1ksyQ9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=g9sOSzrH; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729172007; x=1760708007;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=JkDXhb6MlaMFLEm8EgMyS7ZZvyXV2SzLExiOmUrr698=;
  b=g9sOSzrHshNsLuMvPcvgp1KThgpoVB9EAX7vGeX7vFujnV7UWB9lNnjq
   naEFAFdPjMkjjkXBCdNXmI2Bsr3O/HBRwUMrdYcDqsYyJFVXPL/cC7Fky
   pevHAEnYVkpITIcpGof7YXQcr0iF+tJiM5GY63m9BRaE+mE2fuwhbpPyT
   mOKuAOWrtJOC7xJWDzXrgj2LRQ2lVPH2a0HNtXqIFuLe4zCYwD8l4cuqq
   2cYPeaGiMd2mbEyd0IO9lTrwofinF4WPY6kuNOqAkH7rflmPmm2zu7RC1
   W0M1EaTotGS7HJtQ+wROuM+jzhjfYG0tQfq011RWrrzF42No95r7QN973
   A==;
X-CSE-ConnectionGUID: 0BNH6ilBSl6kXeE9QdJU1Q==
X-CSE-MsgGUID: xAdLOKyqSIGGS4+zsEXYWw==
X-IronPort-AV: E=McAfee;i="6700,10204,11227"; a="54070413"
X-IronPort-AV: E=Sophos;i="6.11,211,1725346800"; 
   d="scan'208";a="54070413"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2024 06:33:27 -0700
X-CSE-ConnectionGUID: 2Li0FzT5T0Gzr4POuyCGag==
X-CSE-MsgGUID: aIlon3qWQ5qDO0ietYFfgA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,211,1725346800"; 
   d="scan'208";a="78692128"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by orviesa006.jf.intel.com with ESMTP; 17 Oct 2024 06:33:25 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1t1Qd0-000MP5-33;
	Thu, 17 Oct 2024 13:33:22 +0000
Date: Thu, 17 Oct 2024 21:32:28 +0800
From: kernel test robot <lkp@intel.com>
To: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	"Gustavo A. R. Silva" <gustavo@embeddedor.com>,
	LKML <linux-kernel@vger.kernel.org>
Subject: [gustavoars:testing/wfamnae-next20241015-2 6/18]
 drivers/net/wireless/intel/iwlwifi/mvm/d3.c:2149:2: error: call to
 '__compiletime_assert_1077' declared with 'error' attribute: BUILD_BUG_ON
 failed: conf->keylen < WLAN_KEY_LEN_GCMP_256
Message-ID: <202410172107.g265uYlG-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/gustavoars/linux.git testing/wfamnae-next20241015-2
head:   41fe8a04339b3781dca5a8ba323ba77022acc441
commit: a1882510f2c31c9e3a9db8c138f5fa4b90eda0c8 [6/18] wifi: iwlwifi: mvm: Use __counted_by() and avoid -Wfamnae warnings
config: riscv-allmodconfig (https://download.01.org/0day-ci/archive/20241017/202410172107.g265uYlG-lkp@intel.com/config)
compiler: clang version 20.0.0git (https://github.com/llvm/llvm-project bfe84f7085d82d06d61c632a7bad1e692fd159e4)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241017/202410172107.g265uYlG-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202410172107.g265uYlG-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from drivers/net/wireless/intel/iwlwifi/mvm/d3.c:7:
   In file included from include/linux/etherdevice.h:20:
   In file included from include/linux/if_ether.h:19:
   In file included from include/linux/skbuff.h:17:
   In file included from include/linux/bvec.h:10:
   In file included from include/linux/highmem.h:8:
   In file included from include/linux/cacheflush.h:5:
   In file included from arch/riscv/include/asm/cacheflush.h:9:
   In file included from include/linux/mm.h:2225:
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
>> drivers/net/wireless/intel/iwlwifi/mvm/d3.c:2149:2: error: call to '__compiletime_assert_1077' declared with 'error' attribute: BUILD_BUG_ON failed: conf->keylen < WLAN_KEY_LEN_GCMP_256
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
   <scratch space>:76:1: note: expanded from here
      76 | __compiletime_assert_1077
         | ^
>> drivers/net/wireless/intel/iwlwifi/mvm/d3.c:2148:2: error: call to '__compiletime_assert_1076' declared with 'error' attribute: BUILD_BUG_ON failed: conf->keylen < WLAN_KEY_LEN_CCMP
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
   <scratch space>:72:1: note: expanded from here
      72 | __compiletime_assert_1076
         | ^
   4 warnings and 2 errors generated.


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

