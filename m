Return-Path: <linux-kernel+bounces-232365-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5377091A7AA
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 15:18:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 114C1284186
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 13:17:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90718192B7C;
	Thu, 27 Jun 2024 13:17:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="N2IHBIPr"
Received: from m15.mail.163.com (m15.mail.163.com [45.254.50.220])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED24A187541
	for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2024 13:17:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.50.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719494274; cv=none; b=h4txzHPgf3u0Nph67dcU71iRnChrmIZWsh2xwxgZjAVPk8+D7Z29HGspOl4O+58MYCKqBM6fkeIZjUqNZ/p98bSWxploTum7FlCoevc/4OjZXK4Vk6DXex08tyeE+i572WV+AhYB9flfJTcn0g7mEyMpAI4+LBEv7MB+/xAgJ6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719494274; c=relaxed/simple;
	bh=370pLVgH43l7QVAvTccXXK1/Sk+pJeLSfVCugZ/Pibo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OwaRYm3fR+Z37zCh8+HkiaXxsmpqpKr8tT03NEj4XtgF9O3yOlvhEeYRsc3YHjNGFesfiDWiF6jE+jQxOJ0gx4WAj45sU47jNZven7Ff7fLW/z2v4X9ULvlhmnRGsCK/ESe6cUUuF4OR1w1CQzjOu2K9nCrW3l/osMEHqKTLAEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=N2IHBIPr; arc=none smtp.client-ip=45.254.50.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=Fk602
	xZpwxu8hEFijAI24Vfb9FDwk9rs/d9oKAbmeVY=; b=N2IHBIPrjKfOgTmzvLsRv
	3ptBqeOjMZh5kRFSqqkdn5oMFelqpFR02q/vREfuFLsz/aHX1UQNV1tzBmZLu57C
	7lBiK3tg6+Dbc0Kyb0Zsm8zjXXu5ugZ+q94VxU8++QnMuQbnba863wFiB88aMvwc
	FgdjnVi2cF5fq+D2byvfcc=
Received: from localhost.localdomain (unknown [193.203.214.57])
	by gzga-smtp-mta-g0-1 (Coremail) with SMTP id _____wDXjylHZn1mTc7GAg--.20362S4;
	Thu, 27 Jun 2024 21:16:57 +0800 (CST)
From: ran xiaokai <ranxiaokai627@163.com>
To: ziy@nvidia.com
Cc: baohua@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	lkp@intel.com,
	llvm@lists.linux.dev,
	oe-kbuild-all@lists.linux.dev,
	peterx@redhat.com,
	ran.xiaokai@zte.com.cn,
	ranxiaokai627@163.com
Subject: Re: [PATCH 2/2] kpageflags: fix wrong KPF_THP on non-pmd-mappable compound pages
Date: Thu, 27 Jun 2024 13:16:55 +0000
Message-Id: <20240627131655.23524-1-ranxiaokai627@163.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <D2ATJC1R3T10.14DE626BQO28Y@nvidia.com>
References: <D2ATJC1R3T10.14DE626BQO28Y@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDXjylHZn1mTc7GAg--.20362S4
X-Coremail-Antispam: 1Uf129KBjvJXoWxGFWDCr48Zr4xKryrXr1xGrg_yoW5XFWfpa
	y8GFs8KF48Wr1rGw4xKF1DZa1jqws8WryagF18Cw47ZFs0vF9Fgr4Ikr15uwnrur1kCrW8
	Crn3XF9Yqa4UAFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0JUKtCwUUUUU=
X-CM-SenderInfo: xudq5x5drntxqwsxqiywtou0bp/1tbiqRILTGVOBIjUegAAs1

>On Thu Jun 27, 2024 at 8:38 AM EDT, ran xiaokai wrote:
>> > Hi ran,
>> > 
>> > kernel test robot noticed the following build errors:
>> > 
>> > [auto build test ERROR on akpm-mm/mm-everything]
>> > [also build test ERROR on linus/master v6.10-rc5 next-20240625]
>> > [If your patch is applied to the wrong git tree, kindly drop us a note.
>> > And when submitting patch, we suggest to use '--base' as documented in
>> > https://git-scm.com/docs/git-format-patch#_base_tree_information]
>> > 
>> > url:    https://github.com/intel-lab-lkp/linux/commits/ran-xiaokai/mm-Constify-folio_order-folio_test_pmd_mappable/20240626-113027
>> > base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-everything
>> > patch link:    https://lore.kernel.org/r/20240626024924.1155558-3-ranxiaokai627%40163.com
>> > patch subject: [PATCH 2/2] kpageflags: fix wrong KPF_THP on non-pmd-mappable compound pages
>> > config: x86_64-allnoconfig (https://download.01.org/0day-ci/archive/20240626/202406262300.iAURISyJ-lkp@intel.com/config)
>> > compiler: clang version 18.1.5 (https://github.com/llvm/llvm-project 617a15a9eac96088ae5e9134248d8236e34b91b1)
>> > reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240626/202406262300.iAURISyJ-lkp@intel.com/reproduce)
>> > 
>> > If you fix the issue in a separate patch/commit (i.e. not just a new version of
>> > the same patch/commit), kindly add following tags
>> > | Reported-by: kernel test robot <lkp@intel.com>
>> > | Closes: https://lore.kernel.org/oe-kbuild-all/202406262300.iAURISyJ-lkp@intel.com/
>> > 
>> > All errors (new ones prefixed by >>):
>> > 
>> > >> fs/proc/page.c:151:35: error: passing 'const struct folio *' to parameter of type 'struct folio *' discards qualifiers [-Werror,-Wincompatible-pointer-types-discards-qualifiers]
>> >      151 |         else if (folio_test_pmd_mappable(folio)) {
>> >          |                                          ^~~~~
>> >    include/linux/huge_mm.h:438:58: note: passing argument to parameter 'folio' here
>> >      438 | static inline bool folio_test_pmd_mappable(struct folio *folio)
>> >          |                                                          ^
>> >    1 error generated.
>>
>> Hi,
>>
>> This patch is the second patch of the serial:
>> https://lore.kernel.org/lkml/20240626024924.1155558-1-ranxiaokai627@163.com/
>>
>> and it relies on the first patch:
>> https://lore.kernel.org/lkml/20240626024924.1155558-2-ranxiaokai627@163.com/
>>
>> and it seems the first patch is not applied.
>> Or in this case, we should not split these two patches?
>
>No, this is the definition when THP is disabled. You only changed the
>definition when THP is enabled.

Thanks for reminding. 
Will fix this.

>-- 
>Best Regards,
>Yan, Zi
>


