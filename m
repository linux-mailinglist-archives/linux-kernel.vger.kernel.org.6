Return-Path: <linux-kernel+bounces-232315-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EEC1A91A6B6
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 14:40:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 27F361C22533
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 12:40:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9430715ECEF;
	Thu, 27 Jun 2024 12:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="ahrCbyoU"
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6372F15E5DB
	for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2024 12:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719491995; cv=none; b=omvQjTXDahNn2aeoNF7rJoVBH5y2zEHVbbiOG6DUwRH8HUKs5DI7an0PIVqXw+pl/gJ3ETuV0M+fTYIBlF0ZbEwzkkwFx+fBRpoU8CfLW1+uFQQ32PDRIxoBPL5fqeCTcJDfkwK8kVKGSL48NMfxHQ7tqjjr4IrJ2HEgGgB78LY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719491995; c=relaxed/simple;
	bh=XIiN2SU02Qa6IoY68GGkhAS66T4UHBbwG6fx2lujuAg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=oIg1/eMOQ9BVFBY4ffF5zV5G/zJCmNaVz84EUebcG4WQ/on2SMXmhq+jSWIHeSOtitY2rXu+5gF7rV2KTDcXPXLOmydT5ahapAv+QX1PI0bNfd4i1RF4r95NgimEs385uxS2gQVTzwxiRk/DGBTefvq/U2qdrvP+Ks9+/U8ogi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=ahrCbyoU; arc=none smtp.client-ip=117.135.210.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=vkEX8
	CnABxw6g+6C0/kCh5ySrZHNhjny2P+4xtrVQvM=; b=ahrCbyoULxWhJIuJgH8Iv
	VP5YQszl65e68JeQy8ymXXc1VGhMW9wIF7+FtuJGzQsNyjVcJ1xhw/meuLrZAB8t
	pd4v8ynYeEIFRv6FpZVdsvnHU0vhXim9J3AMY66WQrn3ejw8NvRYkJ90vJw9dVEd
	FqXpcpPrvY4lmzBcdhbEpI=
Received: from localhost.localdomain (unknown [193.203.214.57])
	by gzga-smtp-mta-g1-0 (Coremail) with SMTP id _____wD3_4FeXX1m+wa7Ag--.41205S4;
	Thu, 27 Jun 2024 20:38:55 +0800 (CST)
From: ran xiaokai <ranxiaokai627@163.com>
To: lkp@intel.com
Cc: baohua@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	llvm@lists.linux.dev,
	oe-kbuild-all@lists.linux.dev,
	peterx@redhat.com,
	ran.xiaokai@zte.com.cn,
	ranxiaokai627@163.com,
	ziy@nvidia.com
Subject: Re: [PATCH 2/2] kpageflags: fix wrong KPF_THP on non-pmd-mappable compound pages
Date: Thu, 27 Jun 2024 12:38:54 +0000
Message-Id: <20240627123854.23205-1-ranxiaokai627@163.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <202406262300.iAURISyJ-lkp@intel.com>
References: <202406262300.iAURISyJ-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3_4FeXX1m+wa7Ag--.41205S4
X-Coremail-Antispam: 1Uf129KBjvJXoW7Cw1kCw17JF15ur47CFWfKrg_yoW5Jr1xpa
	18GFs8Kr48Gw1rGws7GFWUZa1jqws8Wr1agF18Gw47ZF4YvFyq9r4Ikr13uwnFgrykKrWf
	Crn7XF9Yqa4UAaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0JUKAp8UUUUU=
X-CM-SenderInfo: xudq5x5drntxqwsxqiywtou0bp/1tbiqQALTGVOBIg1VwAAsr

> Hi ran,
> 
> kernel test robot noticed the following build errors:
> 
> [auto build test ERROR on akpm-mm/mm-everything]
> [also build test ERROR on linus/master v6.10-rc5 next-20240625]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
> 
> url:    https://github.com/intel-lab-lkp/linux/commits/ran-xiaokai/mm-Constify-folio_order-folio_test_pmd_mappable/20240626-113027
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-everything
> patch link:    https://lore.kernel.org/r/20240626024924.1155558-3-ranxiaokai627%40163.com
> patch subject: [PATCH 2/2] kpageflags: fix wrong KPF_THP on non-pmd-mappable compound pages
> config: x86_64-allnoconfig (https://download.01.org/0day-ci/archive/20240626/202406262300.iAURISyJ-lkp@intel.com/config)
> compiler: clang version 18.1.5 (https://github.com/llvm/llvm-project 617a15a9eac96088ae5e9134248d8236e34b91b1)
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240626/202406262300.iAURISyJ-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202406262300.iAURISyJ-lkp@intel.com/
> 
> All errors (new ones prefixed by >>):
> 
> >> fs/proc/page.c:151:35: error: passing 'const struct folio *' to parameter of type 'struct folio *' discards qualifiers [-Werror,-Wincompatible-pointer-types-discards-qualifiers]
>      151 |         else if (folio_test_pmd_mappable(folio)) {
>          |                                          ^~~~~
>    include/linux/huge_mm.h:438:58: note: passing argument to parameter 'folio' here
>      438 | static inline bool folio_test_pmd_mappable(struct folio *folio)
>          |                                                          ^
>    1 error generated.

Hi,

This patch is the second patch of the serial:
https://lore.kernel.org/lkml/20240626024924.1155558-1-ranxiaokai627@163.com/

and it relies on the first patch:
https://lore.kernel.org/lkml/20240626024924.1155558-2-ranxiaokai627@163.com/

and it seems the first patch is not applied.
Or in this case, we should not split these two patches?


