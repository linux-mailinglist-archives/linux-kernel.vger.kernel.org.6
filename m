Return-Path: <linux-kernel+bounces-569318-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 823C6A6A162
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 09:30:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4CD093BBD6D
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 08:30:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 986841EF38D;
	Thu, 20 Mar 2025 08:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="keYFH239"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD38920AF6C
	for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 08:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742459437; cv=none; b=s69OfRECclCmM/g1k5BtYGKbFpY0/3u4jnebGa72x1GacMSpstp090RmPAjkQ/CstRTLfiAroFrAChE+A6C4isjy30lUKAw7fSrvu1cqcmfBbRumWDLVz6+CfDrUgrdsdcWCVZYlX1Hh2ktOA47CpwhIHj7QEbyeX7WWXLESQtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742459437; c=relaxed/simple;
	bh=aoS+5e3YcViyCC2a09NAneW8hHX39IFe5T/UZrKTauY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ou8PPkb58jHu/UjXhK7Py6La8YoYkyFmE1rCr9L7eGXM5YjEiTZnXfFwDFzuaFydW+rcLKwJUqxXLQR8j2C2afmu9w/wkefAVoBMjLXdhZ6TWKEfS/DFsUF3D1e6iaO5HW46Ab9ozCKdzb36dfKrS3/NZpFJjQagNUF2eU/yEIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=keYFH239; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742459435; x=1773995435;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=aoS+5e3YcViyCC2a09NAneW8hHX39IFe5T/UZrKTauY=;
  b=keYFH239UHaIyBWhBPOdJdhcDz2Jqp6J0DhslH7g+fRw46/ljH81dOfS
   M4udtpqODQXFQl4tPh1meItMHIQ7Ynwcg2JwQsSsY+n907BFHhw2PBvS9
   4M5Bv2zAhdpKNU1gJsTP7dLsCdgBUFY2qv1zn898Luud2BPO2/IzvWXvY
   BuWrktC0Zv3nEaGP6knoYUsbooUimbEjDQm5nFPlLg+185RAYwkO4Y2RP
   2NAdQCwnXfTr7LICyn73TsgECUvXVgam0yhNOjL/Z/bHQirGRugrr6TKM
   6+awnLdxVkRNXS5hTkiqW9s8oEyM5BdwV+M+082kMnTe7GCW7Kc1lnA4R
   w==;
X-CSE-ConnectionGUID: ybeGlTrZTXSBMR4ObMrsxQ==
X-CSE-MsgGUID: 3HuJJAVRSbq/xU2s5/kByQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11378"; a="42848488"
X-IronPort-AV: E=Sophos;i="6.14,261,1736841600"; 
   d="scan'208";a="42848488"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2025 01:30:33 -0700
X-CSE-ConnectionGUID: TFjbNl0eS1ugY5yMf3Hdiw==
X-CSE-MsgGUID: RQ4gdGXcR/+8e3Cl/uznxw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,261,1736841600"; 
   d="scan'208";a="128242032"
Received: from lkp-server02.sh.intel.com (HELO e98e3655d6d2) ([10.239.97.151])
  by orviesa005.jf.intel.com with ESMTP; 20 Mar 2025 01:30:29 -0700
Received: from kbuild by e98e3655d6d2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tvBIJ-0000Ip-0P;
	Thu, 20 Mar 2025 08:30:27 +0000
Date: Thu, 20 Mar 2025 16:29:51 +0800
From: kernel test robot <lkp@intel.com>
To: Rik van Riel <riel@surriel.com>, Vinay Banakar <vny@google.com>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Andrew Morton <akpm@linux-foundation.org>,
	Linux Memory Management List <linux-mm@kvack.org>,
	linux-kernel@vger.kernel.org, kernel-team@meta.com,
	Bharata B Rao <bharata@amd.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Borislav Petkov <bp@alien8.de>, SeongJae Park <sj@kernel.org>,
	Matthew Wilcox <willy@infradead.org>,
	Byungchul Park <byungchul@sk.com>,
	Brendan Jackman <jackmanb@google.com>
Subject: Re: [PATCH] mm/vmscan: batch TLB flush during memory reclaim
Message-ID: <202503201615.1tBb8BcR-lkp@intel.com>
References: <20250319132818.1003878b@fangorn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250319132818.1003878b@fangorn>

Hi Rik,

kernel test robot noticed the following build errors:

[auto build test ERROR on akpm-mm/mm-everything]

url:    https://github.com/intel-lab-lkp/linux/commits/Rik-van-Riel/mm-vmscan-batch-TLB-flush-during-memory-reclaim/20250320-013150
base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-everything
patch link:    https://lore.kernel.org/r/20250319132818.1003878b%40fangorn
patch subject: [PATCH] mm/vmscan: batch TLB flush during memory reclaim
config: i386-buildonly-randconfig-003-20250320 (https://download.01.org/0day-ci/archive/20250320/202503201615.1tBb8BcR-lkp@intel.com/config)
compiler: clang version 20.1.1 (https://github.com/llvm/llvm-project 424c2d9b7e4de40d0804dd374721e6411c27d1d1)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250320/202503201615.1tBb8BcR-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202503201615.1tBb8BcR-lkp@intel.com/

All errors (new ones prefixed by >>):

>> mm/vmscan.c:1560:32: error: call to undeclared function 'folio_test_young'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
    1560 |                             (folio_mapped(folio) && folio_test_young(folio)))
         |                                                     ^
   1 error generated.


vim +/folio_test_young +1560 mm/vmscan.c

  1093	
  1094	/*
  1095	 * shrink_folio_list() returns the number of reclaimed pages
  1096	 */
  1097	static unsigned int shrink_folio_list(struct list_head *folio_list,
  1098			struct pglist_data *pgdat, struct scan_control *sc,
  1099			struct reclaim_stat *stat, bool ignore_references)
  1100	{
  1101		struct folio_batch free_folios;
  1102		LIST_HEAD(ret_folios);
  1103		LIST_HEAD(demote_folios);
  1104		LIST_HEAD(pageout_folios);
  1105		unsigned int nr_reclaimed = 0, nr_demoted = 0;
  1106		unsigned int pgactivate = 0;
  1107		bool do_demote_pass;
  1108		struct swap_iocb *plug = NULL;
  1109	
  1110		folio_batch_init(&free_folios);
  1111		memset(stat, 0, sizeof(*stat));
  1112		cond_resched();
  1113		do_demote_pass = can_demote(pgdat->node_id, sc);
  1114	
  1115	retry:
  1116		while (!list_empty(folio_list)) {
  1117			struct address_space *mapping;
  1118			struct folio *folio;
  1119			enum folio_references references = FOLIOREF_RECLAIM;
  1120			bool dirty, writeback;
  1121			unsigned int nr_pages;
  1122	
  1123			cond_resched();
  1124	
  1125			folio = lru_to_folio(folio_list);
  1126			list_del(&folio->lru);
  1127	
  1128			if (!folio_trylock(folio))
  1129				goto keep;
  1130	
  1131			if (folio_contain_hwpoisoned_page(folio)) {
  1132				unmap_poisoned_folio(folio, folio_pfn(folio), false);
  1133				folio_unlock(folio);
  1134				folio_put(folio);
  1135				continue;
  1136			}
  1137	
  1138			VM_BUG_ON_FOLIO(folio_test_active(folio), folio);
  1139	
  1140			nr_pages = folio_nr_pages(folio);
  1141	
  1142			/* Account the number of base pages */
  1143			sc->nr_scanned += nr_pages;
  1144	
  1145			if (unlikely(!folio_evictable(folio)))
  1146				goto activate_locked;
  1147	
  1148			if (!sc->may_unmap && folio_mapped(folio))
  1149				goto keep_locked;
  1150	
  1151			/*
  1152			 * The number of dirty pages determines if a node is marked
  1153			 * reclaim_congested. kswapd will stall and start writing
  1154			 * folios if the tail of the LRU is all dirty unqueued folios.
  1155			 */
  1156			folio_check_dirty_writeback(folio, &dirty, &writeback);
  1157			if (dirty || writeback)
  1158				stat->nr_dirty += nr_pages;
  1159	
  1160			if (dirty && !writeback)
  1161				stat->nr_unqueued_dirty += nr_pages;
  1162	
  1163			/*
  1164			 * Treat this folio as congested if folios are cycling
  1165			 * through the LRU so quickly that the folios marked
  1166			 * for immediate reclaim are making it to the end of
  1167			 * the LRU a second time.
  1168			 */
  1169			if (writeback && folio_test_reclaim(folio))
  1170				stat->nr_congested += nr_pages;
  1171	
  1172			/*
  1173			 * If a folio at the tail of the LRU is under writeback, there
  1174			 * are three cases to consider.
  1175			 *
  1176			 * 1) If reclaim is encountering an excessive number
  1177			 *    of folios under writeback and this folio has both
  1178			 *    the writeback and reclaim flags set, then it
  1179			 *    indicates that folios are being queued for I/O but
  1180			 *    are being recycled through the LRU before the I/O
  1181			 *    can complete. Waiting on the folio itself risks an
  1182			 *    indefinite stall if it is impossible to writeback
  1183			 *    the folio due to I/O error or disconnected storage
  1184			 *    so instead note that the LRU is being scanned too
  1185			 *    quickly and the caller can stall after the folio
  1186			 *    list has been processed.
  1187			 *
  1188			 * 2) Global or new memcg reclaim encounters a folio that is
  1189			 *    not marked for immediate reclaim, or the caller does not
  1190			 *    have __GFP_FS (or __GFP_IO if it's simply going to swap,
  1191			 *    not to fs). In this case mark the folio for immediate
  1192			 *    reclaim and continue scanning.
  1193			 *
  1194			 *    Require may_enter_fs() because we would wait on fs, which
  1195			 *    may not have submitted I/O yet. And the loop driver might
  1196			 *    enter reclaim, and deadlock if it waits on a folio for
  1197			 *    which it is needed to do the write (loop masks off
  1198			 *    __GFP_IO|__GFP_FS for this reason); but more thought
  1199			 *    would probably show more reasons.
  1200			 *
  1201			 * 3) Legacy memcg encounters a folio that already has the
  1202			 *    reclaim flag set. memcg does not have any dirty folio
  1203			 *    throttling so we could easily OOM just because too many
  1204			 *    folios are in writeback and there is nothing else to
  1205			 *    reclaim. Wait for the writeback to complete.
  1206			 *
  1207			 * In cases 1) and 2) we activate the folios to get them out of
  1208			 * the way while we continue scanning for clean folios on the
  1209			 * inactive list and refilling from the active list. The
  1210			 * observation here is that waiting for disk writes is more
  1211			 * expensive than potentially causing reloads down the line.
  1212			 * Since they're marked for immediate reclaim, they won't put
  1213			 * memory pressure on the cache working set any longer than it
  1214			 * takes to write them to disk.
  1215			 */
  1216			if (folio_test_writeback(folio)) {
  1217				/* Case 1 above */
  1218				if (current_is_kswapd() &&
  1219				    folio_test_reclaim(folio) &&
  1220				    test_bit(PGDAT_WRITEBACK, &pgdat->flags)) {
  1221					stat->nr_immediate += nr_pages;
  1222					goto activate_locked;
  1223	
  1224				/* Case 2 above */
  1225				} else if (writeback_throttling_sane(sc) ||
  1226				    !folio_test_reclaim(folio) ||
  1227				    !may_enter_fs(folio, sc->gfp_mask)) {
  1228					/*
  1229					 * This is slightly racy -
  1230					 * folio_end_writeback() might have
  1231					 * just cleared the reclaim flag, then
  1232					 * setting the reclaim flag here ends up
  1233					 * interpreted as the readahead flag - but
  1234					 * that does not matter enough to care.
  1235					 * What we do want is for this folio to
  1236					 * have the reclaim flag set next time
  1237					 * memcg reclaim reaches the tests above,
  1238					 * so it will then wait for writeback to
  1239					 * avoid OOM; and it's also appropriate
  1240					 * in global reclaim.
  1241					 */
  1242					folio_set_reclaim(folio);
  1243					stat->nr_writeback += nr_pages;
  1244					goto activate_locked;
  1245	
  1246				/* Case 3 above */
  1247				} else {
  1248					folio_unlock(folio);
  1249					folio_wait_writeback(folio);
  1250					/* then go back and try same folio again */
  1251					list_add_tail(&folio->lru, folio_list);
  1252					continue;
  1253				}
  1254			}
  1255	
  1256			if (!ignore_references)
  1257				references = folio_check_references(folio, sc);
  1258	
  1259			switch (references) {
  1260			case FOLIOREF_ACTIVATE:
  1261				goto activate_locked;
  1262			case FOLIOREF_KEEP:
  1263				stat->nr_ref_keep += nr_pages;
  1264				goto keep_locked;
  1265			case FOLIOREF_RECLAIM:
  1266			case FOLIOREF_RECLAIM_CLEAN:
  1267				; /* try to reclaim the folio below */
  1268			}
  1269	
  1270			/*
  1271			 * Before reclaiming the folio, try to relocate
  1272			 * its contents to another node.
  1273			 */
  1274			if (do_demote_pass &&
  1275			    (thp_migration_supported() || !folio_test_large(folio))) {
  1276				list_add(&folio->lru, &demote_folios);
  1277				folio_unlock(folio);
  1278				continue;
  1279			}
  1280	
  1281			/*
  1282			 * Anonymous process memory has backing store?
  1283			 * Try to allocate it some swap space here.
  1284			 * Lazyfree folio could be freed directly
  1285			 */
  1286			if (folio_test_anon(folio) && folio_test_swapbacked(folio)) {
  1287				if (!folio_test_swapcache(folio)) {
  1288					if (!(sc->gfp_mask & __GFP_IO))
  1289						goto keep_locked;
  1290					if (folio_maybe_dma_pinned(folio))
  1291						goto keep_locked;
  1292					if (folio_test_large(folio)) {
  1293						/* cannot split folio, skip it */
  1294						if (!can_split_folio(folio, 1, NULL))
  1295							goto activate_locked;
  1296						/*
  1297						 * Split partially mapped folios right away.
  1298						 * We can free the unmapped pages without IO.
  1299						 */
  1300						if (data_race(!list_empty(&folio->_deferred_list) &&
  1301						    folio_test_partially_mapped(folio)) &&
  1302						    split_folio_to_list(folio, folio_list))
  1303							goto activate_locked;
  1304					}
  1305					if (folio_alloc_swap(folio, __GFP_HIGH | __GFP_NOWARN)) {
  1306						int __maybe_unused order = folio_order(folio);
  1307	
  1308						if (!folio_test_large(folio))
  1309							goto activate_locked_split;
  1310						/* Fallback to swap normal pages */
  1311						if (split_folio_to_list(folio, folio_list))
  1312							goto activate_locked;
  1313	#ifdef CONFIG_TRANSPARENT_HUGEPAGE
  1314						if (nr_pages >= HPAGE_PMD_NR) {
  1315							count_memcg_folio_events(folio,
  1316								THP_SWPOUT_FALLBACK, 1);
  1317							count_vm_event(THP_SWPOUT_FALLBACK);
  1318						}
  1319	#endif
  1320						count_mthp_stat(order, MTHP_STAT_SWPOUT_FALLBACK);
  1321						if (folio_alloc_swap(folio, __GFP_HIGH | __GFP_NOWARN))
  1322							goto activate_locked_split;
  1323					}
  1324					/*
  1325					 * Normally the folio will be dirtied in unmap because its
  1326					 * pte should be dirty. A special case is MADV_FREE page. The
  1327					 * page's pte could have dirty bit cleared but the folio's
  1328					 * SwapBacked flag is still set because clearing the dirty bit
  1329					 * and SwapBacked flag has no lock protected. For such folio,
  1330					 * unmap will not set dirty bit for it, so folio reclaim will
  1331					 * not write the folio out. This can cause data corruption when
  1332					 * the folio is swapped in later. Always setting the dirty flag
  1333					 * for the folio solves the problem.
  1334					 */
  1335					folio_mark_dirty(folio);
  1336				}
  1337			}
  1338	
  1339			/*
  1340			 * If the folio was split above, the tail pages will make
  1341			 * their own pass through this function and be accounted
  1342			 * then.
  1343			 */
  1344			if ((nr_pages > 1) && !folio_test_large(folio)) {
  1345				sc->nr_scanned -= (nr_pages - 1);
  1346				nr_pages = 1;
  1347			}
  1348	
  1349			/*
  1350			 * The folio is mapped into the page tables of one or more
  1351			 * processes. Try to unmap it here.
  1352			 */
  1353			if (folio_mapped(folio)) {
  1354				enum ttu_flags flags = TTU_BATCH_FLUSH;
  1355				bool was_swapbacked = folio_test_swapbacked(folio);
  1356	
  1357				if (folio_test_pmd_mappable(folio))
  1358					flags |= TTU_SPLIT_HUGE_PMD;
  1359				/*
  1360				 * Without TTU_SYNC, try_to_unmap will only begin to
  1361				 * hold PTL from the first present PTE within a large
  1362				 * folio. Some initial PTEs might be skipped due to
  1363				 * races with parallel PTE writes in which PTEs can be
  1364				 * cleared temporarily before being written new present
  1365				 * values. This will lead to a large folio is still
  1366				 * mapped while some subpages have been partially
  1367				 * unmapped after try_to_unmap; TTU_SYNC helps
  1368				 * try_to_unmap acquire PTL from the first PTE,
  1369				 * eliminating the influence of temporary PTE values.
  1370				 */
  1371				if (folio_test_large(folio))
  1372					flags |= TTU_SYNC;
  1373	
  1374				try_to_unmap(folio, flags);
  1375				if (folio_mapped(folio)) {
  1376					stat->nr_unmap_fail += nr_pages;
  1377					if (!was_swapbacked &&
  1378					    folio_test_swapbacked(folio))
  1379						stat->nr_lazyfree_fail += nr_pages;
  1380					goto activate_locked;
  1381				}
  1382			}
  1383	
  1384			/*
  1385			 * Folio is unmapped now so it cannot be newly pinned anymore.
  1386			 * No point in trying to reclaim folio if it is pinned.
  1387			 * Furthermore we don't want to reclaim underlying fs metadata
  1388			 * if the folio is pinned and thus potentially modified by the
  1389			 * pinning process as that may upset the filesystem.
  1390			 */
  1391			if (folio_maybe_dma_pinned(folio))
  1392				goto activate_locked;
  1393	
  1394			mapping = folio_mapping(folio);
  1395			if (folio_test_dirty(folio)) {
  1396				/*
  1397				 * Only kswapd can writeback filesystem folios
  1398				 * to avoid risk of stack overflow. But avoid
  1399				 * injecting inefficient single-folio I/O into
  1400				 * flusher writeback as much as possible: only
  1401				 * write folios when we've encountered many
  1402				 * dirty folios, and when we've already scanned
  1403				 * the rest of the LRU for clean folios and see
  1404				 * the same dirty folios again (with the reclaim
  1405				 * flag set).
  1406				 */
  1407				if (folio_is_file_lru(folio) &&
  1408				    (!current_is_kswapd() ||
  1409				     !folio_test_reclaim(folio) ||
  1410				     !test_bit(PGDAT_DIRTY, &pgdat->flags))) {
  1411					/*
  1412					 * Immediately reclaim when written back.
  1413					 * Similar in principle to folio_deactivate()
  1414					 * except we already have the folio isolated
  1415					 * and know it's dirty
  1416					 */
  1417					node_stat_mod_folio(folio, NR_VMSCAN_IMMEDIATE,
  1418							nr_pages);
  1419					folio_set_reclaim(folio);
  1420	
  1421					goto activate_locked;
  1422				}
  1423	
  1424				if (references == FOLIOREF_RECLAIM_CLEAN)
  1425					goto keep_locked;
  1426				if (!may_enter_fs(folio, sc->gfp_mask))
  1427					goto keep_locked;
  1428				if (!sc->may_writepage)
  1429					goto keep_locked;
  1430	
  1431				/*
  1432				 * Add to pageout list for batched TLB flushing and IO submission.
  1433				 */
  1434				list_add(&folio->lru, &pageout_folios);
  1435				continue;
  1436			}
  1437	
  1438			/*
  1439			 * If the folio has buffers, try to free the buffer
  1440			 * mappings associated with this folio. If we succeed
  1441			 * we try to free the folio as well.
  1442			 *
  1443			 * We do this even if the folio is dirty.
  1444			 * filemap_release_folio() does not perform I/O, but it
  1445			 * is possible for a folio to have the dirty flag set,
  1446			 * but it is actually clean (all its buffers are clean).
  1447			 * This happens if the buffers were written out directly,
  1448			 * with submit_bh(). ext3 will do this, as well as
  1449			 * the blockdev mapping.  filemap_release_folio() will
  1450			 * discover that cleanness and will drop the buffers
  1451			 * and mark the folio clean - it can be freed.
  1452			 *
  1453			 * Rarely, folios can have buffers and no ->mapping.
  1454			 * These are the folios which were not successfully
  1455			 * invalidated in truncate_cleanup_folio().  We try to
  1456			 * drop those buffers here and if that worked, and the
  1457			 * folio is no longer mapped into process address space
  1458			 * (refcount == 1) it can be freed.  Otherwise, leave
  1459			 * the folio on the LRU so it is swappable.
  1460			 */
  1461			if (folio_needs_release(folio)) {
  1462				if (!filemap_release_folio(folio, sc->gfp_mask))
  1463					goto activate_locked;
  1464				if (!mapping && folio_ref_count(folio) == 1) {
  1465					folio_unlock(folio);
  1466					if (folio_put_testzero(folio))
  1467						goto free_it;
  1468					else {
  1469						/*
  1470						 * rare race with speculative reference.
  1471						 * the speculative reference will free
  1472						 * this folio shortly, so we may
  1473						 * increment nr_reclaimed here (and
  1474						 * leave it off the LRU).
  1475						 */
  1476						nr_reclaimed += nr_pages;
  1477						continue;
  1478					}
  1479				}
  1480			}
  1481	
  1482			if (folio_test_anon(folio) && !folio_test_swapbacked(folio)) {
  1483				/* follow __remove_mapping for reference */
  1484				if (!folio_ref_freeze(folio, 1))
  1485					goto keep_locked;
  1486				/*
  1487				 * The folio has only one reference left, which is
  1488				 * from the isolation. After the caller puts the
  1489				 * folio back on the lru and drops the reference, the
  1490				 * folio will be freed anyway. It doesn't matter
  1491				 * which lru it goes on. So we don't bother checking
  1492				 * the dirty flag here.
  1493				 */
  1494				count_vm_events(PGLAZYFREED, nr_pages);
  1495				count_memcg_folio_events(folio, PGLAZYFREED, nr_pages);
  1496			} else if (!mapping || !__remove_mapping(mapping, folio, true,
  1497								 sc->target_mem_cgroup))
  1498				goto keep_locked;
  1499	
  1500			folio_unlock(folio);
  1501	free_it:
  1502			/*
  1503			 * Folio may get swapped out as a whole, need to account
  1504			 * all pages in it.
  1505			 */
  1506			nr_reclaimed += nr_pages;
  1507	
  1508			folio_unqueue_deferred_split(folio);
  1509			if (folio_batch_add(&free_folios, folio) == 0) {
  1510				mem_cgroup_uncharge_folios(&free_folios);
  1511				try_to_unmap_flush();
  1512				free_unref_folios(&free_folios);
  1513			}
  1514			continue;
  1515	
  1516	activate_locked_split:
  1517			/*
  1518			 * The tail pages that are failed to add into swap cache
  1519			 * reach here.  Fixup nr_scanned and nr_pages.
  1520			 */
  1521			if (nr_pages > 1) {
  1522				sc->nr_scanned -= (nr_pages - 1);
  1523				nr_pages = 1;
  1524			}
  1525	activate_locked:
  1526			/* Not a candidate for swapping, so reclaim swap space. */
  1527			if (folio_test_swapcache(folio) &&
  1528			    (mem_cgroup_swap_full(folio) || folio_test_mlocked(folio)))
  1529				folio_free_swap(folio);
  1530			VM_BUG_ON_FOLIO(folio_test_active(folio), folio);
  1531			if (!folio_test_mlocked(folio)) {
  1532				int type = folio_is_file_lru(folio);
  1533				folio_set_active(folio);
  1534				stat->nr_activate[type] += nr_pages;
  1535				count_memcg_folio_events(folio, PGACTIVATE, nr_pages);
  1536			}
  1537	keep_locked:
  1538			folio_unlock(folio);
  1539	keep:
  1540			list_add(&folio->lru, &ret_folios);
  1541			VM_BUG_ON_FOLIO(folio_test_lru(folio) ||
  1542					folio_test_unevictable(folio), folio);
  1543		}
  1544		/* 'folio_list' is always empty here */
  1545	
  1546		if (!list_empty(&pageout_folios)) {
  1547			/*
  1548			 * The loop above unmapped the folios from the page tables.
  1549			 * One TLB flush takes care of the whole batch.
  1550			 */
  1551			try_to_unmap_flush_dirty();
  1552	
  1553			while (!list_empty(&pageout_folios)) {
  1554				struct folio *folio = lru_to_folio(&pageout_folios);
  1555				struct address_space *mapping;
  1556				list_del(&folio->lru);
  1557	
  1558				/* Recheck if the page got reactivated */
  1559				if (folio_test_active(folio) ||
> 1560				    (folio_mapped(folio) && folio_test_young(folio)))
  1561					goto skip_pageout_locked;
  1562	
  1563				mapping = folio_mapping(folio);
  1564				switch (pageout(folio, mapping, &plug, &pageout_folios)) {
  1565				case PAGE_KEEP:
  1566				case PAGE_ACTIVATE:
  1567					goto skip_pageout_locked;
  1568				case PAGE_SUCCESS:
  1569					/*
  1570					 * If shmem folio is split when writeback to swap,
  1571					 * the tail pages will make their own pass through
  1572					 * this loop and be accounted then.
  1573					 */
  1574					stat->nr_pageout += folio_nr_pages(folio);
  1575	
  1576					if (folio_test_writeback(folio))
  1577						goto skip_pageout;
  1578					if (folio_test_dirty(folio))
  1579						goto skip_pageout;
  1580	
  1581					/*
  1582					 * A synchronous write - probably a ramdisk.  Go
  1583					 * ahead and try to reclaim the folio.
  1584					 */
  1585					if (!folio_trylock(folio))
  1586						goto skip_pageout;
  1587					if (folio_test_dirty(folio) ||
  1588					    folio_test_writeback(folio))
  1589						goto skip_pageout_locked;
  1590					mapping = folio_mapping(folio);
  1591					/* try to free the folio below */
  1592					fallthrough;
  1593				case PAGE_CLEAN:
  1594					/* try to free the folio */
  1595					if (!mapping ||
  1596					    !remove_mapping(mapping, folio))
  1597						goto skip_pageout_locked;
  1598	
  1599					nr_reclaimed += folio_nr_pages(folio);
  1600					folio_unlock(folio);
  1601					continue;
  1602				}
  1603	
  1604	skip_pageout_locked:
  1605				folio_unlock(folio);
  1606	skip_pageout:
  1607				list_add(&folio->lru, &ret_folios);
  1608			}
  1609		}
  1610	
  1611		/* Migrate folios selected for demotion */
  1612		nr_demoted = demote_folio_list(&demote_folios, pgdat);
  1613		nr_reclaimed += nr_demoted;
  1614		stat->nr_demoted += nr_demoted;
  1615		/* Folios that could not be demoted are still in @demote_folios */
  1616		if (!list_empty(&demote_folios)) {
  1617			/* Folios which weren't demoted go back on @folio_list */
  1618			list_splice_init(&demote_folios, folio_list);
  1619	
  1620			/*
  1621			 * goto retry to reclaim the undemoted folios in folio_list if
  1622			 * desired.
  1623			 *
  1624			 * Reclaiming directly from top tier nodes is not often desired
  1625			 * due to it breaking the LRU ordering: in general memory
  1626			 * should be reclaimed from lower tier nodes and demoted from
  1627			 * top tier nodes.
  1628			 *
  1629			 * However, disabling reclaim from top tier nodes entirely
  1630			 * would cause ooms in edge scenarios where lower tier memory
  1631			 * is unreclaimable for whatever reason, eg memory being
  1632			 * mlocked or too hot to reclaim. We can disable reclaim
  1633			 * from top tier nodes in proactive reclaim though as that is
  1634			 * not real memory pressure.
  1635			 */
  1636			if (!sc->proactive) {
  1637				do_demote_pass = false;
  1638				goto retry;
  1639			}
  1640		}
  1641	
  1642		pgactivate = stat->nr_activate[0] + stat->nr_activate[1];
  1643	
  1644		mem_cgroup_uncharge_folios(&free_folios);
  1645		try_to_unmap_flush();
  1646		free_unref_folios(&free_folios);
  1647	
  1648		list_splice(&ret_folios, folio_list);
  1649		count_vm_events(PGACTIVATE, pgactivate);
  1650	
  1651		if (plug)
  1652			swap_write_unplug(plug);
  1653		return nr_reclaimed;
  1654	}
  1655	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

