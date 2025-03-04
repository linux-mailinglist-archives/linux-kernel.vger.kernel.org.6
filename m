Return-Path: <linux-kernel+bounces-543897-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CDC7A4DB2E
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 11:46:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CAEB57A35B2
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 10:45:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAA2C200BB5;
	Tue,  4 Mar 2025 10:43:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="N3N0Pn0T"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F0961FCCF1
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 10:42:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741084981; cv=none; b=I24KaxcsVbg6eaE1GqZXv36NKw2ZHmCOF53dOnUoSEtFoFJSTZGTlifBYX3W0fjIFD3EqYnFU4wLvmuMVyfn2COBbDyE+4jdFcX3ijhd40PkBgcIx/asOEOiN38L0KOYEqCKIyI5O9IM9DFqPMtcqHOQdoTgHO2pJmlxQv4hbbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741084981; c=relaxed/simple;
	bh=AAUmVn2f+OJGl5++4TDAcy/d2xI+fSp6H+1SWf1N1kE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=OCsES/4su4dPf6CWo3bzjpcyAOCWffV/fZ9bSn6t0yiYcSFd1LMWPMHoaHXVsX1PPZsQHIqYAVPELm/Dk7EjvgcnZKyl52KaXDbE8p0O7FmwLt7PG8OB83a5YQ0ZGP5BlHxmuwd/2OIDqPLjFliJbtfhxZeFrVb4arYuBuKDugE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=N3N0Pn0T; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741084980; x=1772620980;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=AAUmVn2f+OJGl5++4TDAcy/d2xI+fSp6H+1SWf1N1kE=;
  b=N3N0Pn0ThMUJYITdmWg/cwJajIkkIT1XVQKsGBEhHqEq2DieQnZ9Dx5C
   gpKQqKHG8DLx5CE1OzldQtFYArhnmBCPD4HnDjrZzP2mTmAHTHRedlAxy
   vleDbp0o4ABzZkcZerrQHOzHK4dzoCgHI7aSkQBslZ7N/o/mImR+b50TZ
   N20yvujAs1MrU1/mXFYzz7wHZtdqZmVP64c2Q5YO7KQ+XUyeTFBGmukTZ
   P67jiKiq5BuBI0ziuI4tZ4zy+4MDowbiCVBiOm5oG0J6GM03IIobRzWJM
   CWINWzqXBYY9mXm7CVXu/lBSTBFVj8GW5Cq/4znpxu+QKbjJ+Dt0yND9B
   Q==;
X-CSE-ConnectionGUID: 8EqK1BW6Rrqcegr5Tkex2g==
X-CSE-MsgGUID: Vmtpp6qOSTm2aquv/i/3qw==
X-IronPort-AV: E=McAfee;i="6700,10204,11362"; a="53390798"
X-IronPort-AV: E=Sophos;i="6.13,331,1732608000"; 
   d="scan'208";a="53390798"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2025 02:42:58 -0800
X-CSE-ConnectionGUID: RRpphfkFQdaIgE+9o57zZA==
X-CSE-MsgGUID: CKZ0dbezRhiyjX2wyXbDEA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,331,1732608000"; 
   d="scan'208";a="119028097"
Received: from lkp-server02.sh.intel.com (HELO 76cde6cc1f07) ([10.239.97.151])
  by fmviesa009.fm.intel.com with ESMTP; 04 Mar 2025 02:42:56 -0800
Received: from kbuild by 76cde6cc1f07 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tpPjh-000JcV-2P;
	Tue, 04 Mar 2025 10:42:53 +0000
Date: Tue, 4 Mar 2025 18:42:16 +0800
From: kernel test robot <lkp@intel.com>
To: Peter Xu <peterx@redhat.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Linux Memory Management List <linux-mm@kvack.org>
Subject: mm/gup.c:778:15: sparse: sparse: cast to non-scalar
Message-ID: <202503041858.tK5Q1vkP-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   99fa936e8e4f117d62f229003c9799686f74cebc
commit: e6fd5564c07c3c749ff3d1b2aa35540b4047e395 mm/gup: cache p4d in follow_p4d_mask()
date:   10 months ago
config: alpha-randconfig-r123-20250304 (https://download.01.org/0day-ci/archive/20250304/202503041858.tK5Q1vkP-lkp@intel.com/config)
compiler: alpha-linux-gcc (GCC) 14.2.0
reproduce: (https://download.01.org/0day-ci/archive/20250304/202503041858.tK5Q1vkP-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202503041858.tK5Q1vkP-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> mm/gup.c:778:15: sparse: sparse: cast to non-scalar
>> mm/gup.c:778:15: sparse: sparse: cast from non-scalar
   mm/gup.c: note: in included file (through include/linux/mm.h):
   include/linux/pgtable.h:315:16: sparse: sparse: cast to non-scalar
   include/linux/pgtable.h:315:16: sparse: sparse: cast from non-scalar
   include/linux/pgtable.h:315:16: sparse: sparse: cast to non-scalar
   include/linux/pgtable.h:315:16: sparse: sparse: cast from non-scalar
   mm/gup.c: note: in included file (through include/linux/mmzone.h, include/linux/gfp.h, include/linux/mm.h):
   include/linux/page-flags.h:241:46: sparse: sparse: self-comparison always evaluates to false
   mm/gup.c:682:9: sparse: sparse: context imbalance in 'follow_page_pte' - unexpected unlock
   mm/gup.c: note: in included file (through include/linux/mm.h):
   include/linux/pgtable.h:322:16: sparse: sparse: cast to non-scalar
   include/linux/pgtable.h:322:16: sparse: sparse: cast from non-scalar
   include/linux/pgtable.h:315:16: sparse: sparse: cast to non-scalar
   include/linux/pgtable.h:315:16: sparse: sparse: cast from non-scalar
   mm/gup.c:911:18: sparse: sparse: context imbalance in 'get_gate_page' - unexpected unlock

vim +778 mm/gup.c

   769	
   770	static struct page *follow_p4d_mask(struct vm_area_struct *vma,
   771					    unsigned long address, pgd_t *pgdp,
   772					    unsigned int flags,
   773					    struct follow_page_context *ctx)
   774	{
   775		p4d_t *p4dp, p4d;
   776	
   777		p4dp = p4d_offset(pgdp, address);
 > 778		p4d = READ_ONCE(*p4dp);
   779		if (p4d_none(p4d))
   780			return no_page_table(vma, flags);
   781		BUILD_BUG_ON(p4d_huge(p4d));
   782		if (unlikely(p4d_bad(p4d)))
   783			return no_page_table(vma, flags);
   784	
   785		return follow_pud_mask(vma, address, p4dp, flags, ctx);
   786	}
   787	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

