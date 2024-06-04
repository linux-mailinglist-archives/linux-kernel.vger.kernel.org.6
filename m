Return-Path: <linux-kernel+bounces-200344-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AD208FAEA8
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 11:24:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3DCB11C2139F
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 09:24:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA893143890;
	Tue,  4 Jun 2024 09:23:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qJAAXZqj"
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2C1E143C62
	for <linux-kernel@vger.kernel.org>; Tue,  4 Jun 2024 09:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717493032; cv=none; b=qVjjc/LIySwEDI1Sguw1vl4HD0EFA0DiHQFIba0ySlHCnJA3+myYtgL/ZsrDa7N/QAnMRJ/inf/EskBry/Z8SWmUplw71e7p2Uyg1ozSpoMtSd4sZtn1shNWV/+S6746VSnGbqsw3scQqdsesR501+WiAxgQrGsSgQ+a28nrIIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717493032; c=relaxed/simple;
	bh=hPRDfVN9zrZHHC+fiHl3+xNBPjg/xtoXtIax3D3WLeg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=SaJmtQv3uM7Rj4qDfejySIbcggbbAane4cxZlzL3ouGB4MQa7ErcGvcAkAuJ7gcEDyCR5pX/R264B4NwAQQHPlQoJ+/+9cT9u9g96aCWdpJEs5VbxPf/j6pqFxask3xhepJR69NsK2ERNGf0f/o+9SxH7+CLCdjcCXzh4N5MaWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=qJAAXZqj; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a6269885572so936584166b.1
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jun 2024 02:23:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1717493029; x=1718097829; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xemicTBwRPyiUNufo8q8iiZLE9eFd5HL26ZHWNiDDh8=;
        b=qJAAXZqjlHf2y2L0Rb6gSBeqtCRU2PVpKpNFHNbljTAAP748kFkdOYUomjY6qfx3AL
         RGFnokQcsBlDJ8e1VbNe0w9PlHPyAn6U4uL4ZEgTTRSmrBG3qjMi8A7nAV26Sn27qi3/
         2w4/vLdMS2k/WLXeWWjZXET43q9xTvUwcd9AU+fgkS9nf8mJDo8sPghV3Y5b3Letca9W
         2J/RGs5IF3NQ9eTmTMQBv4H88lRuaVwIw5ux45H6EauerWgpupkAyb/ldwnbXqr6RZ2/
         R/vwMDv85E7DxPiiBDZLC56At5LmKm9MFZQX+puMXmOdJexD0j62VLkNyu8oMZ7V8l9V
         6lnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717493029; x=1718097829;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xemicTBwRPyiUNufo8q8iiZLE9eFd5HL26ZHWNiDDh8=;
        b=wdyxwmDIcMauxA7j/xB+ZYAoCe06ViduwMRqRp9IllJwmmd8lrd1cXpPI8wb+p1zgB
         OkD2T1LjhjY89b28/+f2/maVJpfj3dqeYCxCOwficLV59AHUwfMNUsK/6aHd/jyNfWhq
         q59xaAHrSg8ZINhH3Zprf67wRPS/NGfLoe2CA77ZZH48LkzGXNB2PRfoa0iBEZulRSNA
         dxpQeH8M6uAq6qr4NotJOOmRVgTflUK4CEDWtCQMvMSZlJ+UK1EOVqqDsd1uc3Na0Ffz
         Dvvp5jBigkV9QIECkb/HPnlqwMXpu+WInD+PSHlIJhg//Zm498tNCcjFYF80AfPaYCl7
         Aq3Q==
X-Forwarded-Encrypted: i=1; AJvYcCU1Z+cJLV3HBf3YmIZC26qcBO9GVOvHFz43OZPsRsZS5qRUvduZezm2hMXp2J1jxfJLwCNzE+kFtem6V1l+5/xCdGjmcQZAX44iJSoV
X-Gm-Message-State: AOJu0YyjIWcKdPNVF0AwP3297ZSfXzIMYTHruF9DS9ZEpXOfqL5pjoUV
	ItRkdQhFmeSi2+FITAuDgVU78SXwWM1QXf88ldV4UjH9m4/G8MnZYkeyTgB+Mqc=
X-Google-Smtp-Source: AGHT+IGgzFJu020ZVDFJOaUBGqmgiXocPAB8ffUUBJMs4jrthf8Wee4u7s4o7NJ9GYESXPBanDgkdQ==
X-Received: by 2002:a17:907:bc4:b0:a68:f1ca:a8de with SMTP id a640c23a62f3a-a69545649bbmr126880066b.36.1717493028989;
        Tue, 04 Jun 2024 02:23:48 -0700 (PDT)
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a68fa8035adsm332061266b.185.2024.06.04.02.23.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jun 2024 02:23:48 -0700 (PDT)
Date: Tue, 4 Jun 2024 12:23:45 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: oe-kbuild@lists.linux.dev, Baolin Wang <baolin.wang@linux.alibaba.com>,
	akpm@linux-foundation.org, hughd@google.com
Cc: lkp@intel.com, oe-kbuild-all@lists.linux.dev, willy@infradead.org,
	david@redhat.com, wangkefeng.wang@huawei.com, ying.huang@intel.com,
	21cnbao@gmail.com, ryan.roberts@arm.com, shy828301@gmail.com,
	ziy@nvidia.com, ioworker0@gmail.com, da.gomez@samsung.com,
	p.raghav@samsung.com, baolin.wang@linux.alibaba.com,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 4/6] mm: shmem: add mTHP support for anonymous shmem
Message-ID: <ad47dc93-0cdb-45fb-83b3-170f2c09b93a@moroto.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ec35a23026dd016705d211e85163cabe07681516.1717033868.git.baolin.wang@linux.alibaba.com>

Hi Baolin,

kernel test robot noticed the following build warnings:

https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Baolin-Wang/mm-memory-extend-finish_fault-to-support-large-folio/20240530-100805
base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-everything
patch link:    https://lore.kernel.org/r/ec35a23026dd016705d211e85163cabe07681516.1717033868.git.baolin.wang%40linux.alibaba.com
patch subject: [PATCH v3 4/6] mm: shmem: add mTHP support for anonymous shmem
config: powerpc64-randconfig-r071-20240531 (https://download.01.org/0day-ci/archive/20240602/202406020203.14sT311e-lkp@intel.com/config)
compiler: clang version 19.0.0git (https://github.com/llvm/llvm-project bafda89a0944d947fc4b3b5663185e07a397ac30)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
| Closes: https://lore.kernel.org/r/202406020203.14sT311e-lkp@intel.com/

smatch warnings:
mm/shmem.c:1766 shmem_alloc_and_add_folio() error: uninitialized symbol 'suitable_orders'.

vim +/suitable_orders +1766 mm/shmem.c

ededbc2c2f28a1 Baolin Wang             2024-05-30  1729  static struct folio *shmem_alloc_and_add_folio(struct vm_fault *vmf,
ededbc2c2f28a1 Baolin Wang             2024-05-30  1730  		gfp_t gfp, struct inode *inode, pgoff_t index,
ededbc2c2f28a1 Baolin Wang             2024-05-30  1731  		struct mm_struct *fault_mm, unsigned long orders)
800d8c63b2e989 Kirill A. Shutemov      2016-07-26  1732  {
3022fd7af9604d Hugh Dickins            2023-09-29  1733  	struct address_space *mapping = inode->i_mapping;
0f0796945614b7 Mike Rapoport           2017-09-06  1734  	struct shmem_inode_info *info = SHMEM_I(inode);
ededbc2c2f28a1 Baolin Wang             2024-05-30  1735  	struct vm_area_struct *vma = vmf ? vmf->vma : NULL;
ededbc2c2f28a1 Baolin Wang             2024-05-30  1736  	unsigned long suitable_orders;
ededbc2c2f28a1 Baolin Wang             2024-05-30  1737  	struct folio *folio = NULL;
3022fd7af9604d Hugh Dickins            2023-09-29  1738  	long pages;
ededbc2c2f28a1 Baolin Wang             2024-05-30  1739  	int error, order;
800d8c63b2e989 Kirill A. Shutemov      2016-07-26  1740  
396bcc5299c281 Matthew Wilcox (Oracle  2020-04-06  1741) 	if (!IS_ENABLED(CONFIG_TRANSPARENT_HUGEPAGE))
ededbc2c2f28a1 Baolin Wang             2024-05-30  1742  		orders = 0;
800d8c63b2e989 Kirill A. Shutemov      2016-07-26  1743  
ededbc2c2f28a1 Baolin Wang             2024-05-30  1744  	if (orders > 0) {
ededbc2c2f28a1 Baolin Wang             2024-05-30  1745  		if (vma && vma_is_anon_shmem(vma)) {
ededbc2c2f28a1 Baolin Wang             2024-05-30  1746  			suitable_orders = anon_shmem_suitable_orders(inode, vmf,
ededbc2c2f28a1 Baolin Wang             2024-05-30  1747  							mapping, index, orders);
ededbc2c2f28a1 Baolin Wang             2024-05-30  1748  		} else if (orders & BIT(HPAGE_PMD_ORDER)) {
3022fd7af9604d Hugh Dickins            2023-09-29  1749  			pages = HPAGE_PMD_NR;
ededbc2c2f28a1 Baolin Wang             2024-05-30  1750  			suitable_orders = BIT(HPAGE_PMD_ORDER);
3022fd7af9604d Hugh Dickins            2023-09-29  1751  			index = round_down(index, HPAGE_PMD_NR);
3022fd7af9604d Hugh Dickins            2023-09-29  1752  
3022fd7af9604d Hugh Dickins            2023-09-29  1753  			/*
3022fd7af9604d Hugh Dickins            2023-09-29  1754  			 * Check for conflict before waiting on a huge allocation.
3022fd7af9604d Hugh Dickins            2023-09-29  1755  			 * Conflict might be that a huge page has just been allocated
3022fd7af9604d Hugh Dickins            2023-09-29  1756  			 * and added to page cache by a racing thread, or that there
3022fd7af9604d Hugh Dickins            2023-09-29  1757  			 * is already at least one small page in the huge extent.
3022fd7af9604d Hugh Dickins            2023-09-29  1758  			 * Be careful to retry when appropriate, but not forever!
3022fd7af9604d Hugh Dickins            2023-09-29  1759  			 * Elsewhere -EEXIST would be the right code, but not here.
3022fd7af9604d Hugh Dickins            2023-09-29  1760  			 */
3022fd7af9604d Hugh Dickins            2023-09-29  1761  			if (xa_find(&mapping->i_pages, &index,
3022fd7af9604d Hugh Dickins            2023-09-29  1762  				    index + HPAGE_PMD_NR - 1, XA_PRESENT))
3022fd7af9604d Hugh Dickins            2023-09-29  1763  				return ERR_PTR(-E2BIG);
ededbc2c2f28a1 Baolin Wang             2024-05-30  1764  		}

suitable_orders uninitialized on else path.

52cd3b074050dd Lee Schermerhorn        2008-04-28  1765  
ededbc2c2f28a1 Baolin Wang             2024-05-30 @1766  		order = highest_order(suitable_orders);
ededbc2c2f28a1 Baolin Wang             2024-05-30  1767  		while (suitable_orders) {
ededbc2c2f28a1 Baolin Wang             2024-05-30  1768  			pages = 1UL << order;
ededbc2c2f28a1 Baolin Wang             2024-05-30  1769  			index = round_down(index, pages);
ededbc2c2f28a1 Baolin Wang             2024-05-30  1770  			folio = shmem_alloc_folio(gfp, order, info, index);
ededbc2c2f28a1 Baolin Wang             2024-05-30  1771  			if (folio)
ededbc2c2f28a1 Baolin Wang             2024-05-30  1772  				goto allocated;
ededbc2c2f28a1 Baolin Wang             2024-05-30  1773  
ededbc2c2f28a1 Baolin Wang             2024-05-30  1774  			if (pages == HPAGE_PMD_NR)
3022fd7af9604d Hugh Dickins            2023-09-29  1775  				count_vm_event(THP_FILE_FALLBACK);
ededbc2c2f28a1 Baolin Wang             2024-05-30  1776  			order = next_order(&suitable_orders, order);
ededbc2c2f28a1 Baolin Wang             2024-05-30  1777  		}
3022fd7af9604d Hugh Dickins            2023-09-29  1778  	} else {
3022fd7af9604d Hugh Dickins            2023-09-29  1779  		pages = 1;

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


