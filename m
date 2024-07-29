Return-Path: <linux-kernel+bounces-265895-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D44F93F764
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 16:17:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 40C161C218EB
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 14:17:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D523D14AD19;
	Mon, 29 Jul 2024 14:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FGaAqyfn"
Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 232821E4A2
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 14:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722262621; cv=none; b=t+pUEugflFeGQyfEwF6TMANmtlq6XCb7WB5Zsi2m475utRX9owS0d5N5LY5/pCjBe4fZjlehsUHxW/O89ai+Y4I0grh5nbBem6O47kr2u6fZlhkEGwcyibmr/Ew2Jo6uKO5UgefZw1ZilyoIuLhjd00F/UEHnuazelKmLkMwDCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722262621; c=relaxed/simple;
	bh=/EG4uv666fnZnr3hB/LVfDRZ/7A7ZQWvJSvD/OiniYs=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=VC+Af8Z0R/I8BWQQpy6t5qt1tqkCJZfVPUSMVyhI0OhDcirTThEK5JwfYDtSXIi2Si31iK4KlrJ0xkdf15D/Lc/Iy3p8tJTntUB3qX30MYtBqqfGLB1aMy3Q2xGT3TxeLstKgqDqBPGn4YadCPVUTCNTTygoBD6YAvWFGaNixm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=FGaAqyfn; arc=none smtp.client-ip=209.85.210.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-7094468d392so960979a34.0
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 07:16:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1722262617; x=1722867417; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=yPht4KtsC8wgJ3uBaPUdo+wbgqa7iqwnOKIvSKNeLNg=;
        b=FGaAqyfnGJERsLuRzagQ/iz2v61d7MfvXpFc5J1gCGm21bZwkU5KtObOft3hW7AxPQ
         yVg0yiiCPqzcVwAhCbnhTe6JzPBHuhJ8MrIOpORDnsbDFxCx+lHbdENGzlh5X4a4UF1l
         WAG5167Xf98VQexg5RlEVDjyHx2RQluQbRmKEu/XKWzHucokjQguphuvMsCA7nf6cGXl
         hhLeem4fjz7Zo8Z5O9HaT7Ou/riSsnOgR99xifVBJnN6u3fwZA9h2ndwvxq1E1yyzHsm
         p5KZ1QY3MChhVQuhmQnUSA1eQZgkkANdKvfc+QLOA9BVo5aPm2wML71qMaKOOTbqD18B
         g2kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722262617; x=1722867417;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:message-id:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yPht4KtsC8wgJ3uBaPUdo+wbgqa7iqwnOKIvSKNeLNg=;
        b=efPVdoUOqkDf/hKwXWdKYEXzBxvHhUqLi0BUTRLNzuqrZfTrQCREdgQpc/Sl/r+zE4
         h351+fYqR3S7rc4KNjSzLQCvOA8fT3r0uuYdH9nTcSyZ2zvRbiFwwsTk4qZfyrEiMb6+
         SkY8APaoJDgifESPBTZqkCuPgNT8/T8CG0/vMdObIq25ROIBbd920BsSqgUU/yifG6bK
         8o01PkkPAZW5QjuUIPD5aAZhaO4PkritiqlP5RxT5DWmHpV1yYTpl23WewR/r/YaEqag
         /w3G9D7tkj/NWKcE68HQDEmXtrfdCO6IAsLGdaxVJITj9+aU2ljz/cwQJ2BbaQkRbKXR
         dcug==
X-Forwarded-Encrypted: i=1; AJvYcCUNk6W2K3wgNXQkII53RZ23v1THwuUk6XWJuWhf1jMuKNWdlQa+QUSMlIfyld+Yh6IkVh5J3ixjQqR2YiH1G6Wr9stSD7HW8MEIC5Y/
X-Gm-Message-State: AOJu0YwT0jw782AOJtP9Z7LaiJ5d89vK31BqYFcKDbghw+P32ODdePI5
	II+Gc5H+4dOF7Xp1GogkogfEPyGf/fic90uezjxvVie5CzZaYNDfkNFoVI5fHBA=
X-Google-Smtp-Source: AGHT+IEJwJIG+K/Yv/Lf3D5/a7aV4GXGN5dyzXyaivHDYxwgYCRb0Nt9YcsnXrlF3FhnAzSkDiKoNg==
X-Received: by 2002:a05:6830:3707:b0:703:7821:d9e with SMTP id 46e09a7af769-70940c98bbemr10581781a34.30.1722262616801;
        Mon, 29 Jul 2024 07:16:56 -0700 (PDT)
Received: from localhost ([2603:8080:b800:f700::17c0])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-70930706baasm2131057a34.19.2024.07.29.07.16.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jul 2024 07:16:56 -0700 (PDT)
Date: Mon, 29 Jul 2024 09:16:54 -0500
From: Dan Carpenter <dan.carpenter@linaro.org>
To: oe-kbuild@lists.linux.dev, Barry Song <21cnbao@gmail.com>,
	akpm@linux-foundation.org, linux-mm@kvack.org
Cc: lkp@intel.com, oe-kbuild-all@lists.linux.dev, ying.huang@intel.com,
	baolin.wang@linux.alibaba.com, chrisl@kernel.org, david@redhat.com,
	hannes@cmpxchg.org, hughd@google.com, kaleshsingh@google.com,
	kasong@tencent.com, linux-kernel@vger.kernel.org, mhocko@suse.com,
	minchan@kernel.org, nphamcs@gmail.com, ryan.roberts@arm.com,
	senozhatsky@chromium.org, shakeel.butt@linux.dev,
	shy828301@gmail.com, surenb@google.com, v-songbaohua@oppo.com,
	willy@infradead.org, xiang@kernel.org, yosryahmed@google.com,
	Chuanhua Han <hanchuanhua@oppo.com>
Subject: Re: [PATCH v5 3/4] mm: support large folios swapin as a whole for
 zRAM-like swapfile
Message-ID: <e1eb828e-95eb-449b-9d6d-badc9aa4868e@suswa.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240726094618.401593-4-21cnbao@gmail.com>

Hi Barry,

kernel test robot noticed the following build warnings:

url:    https://github.com/intel-lab-lkp/linux/commits/Barry-Song/mm-swap-introduce-swapcache_prepare_nr-and-swapcache_clear_nr-for-large-folios-swap-in/20240726-181412
base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-everything
patch link:    https://lore.kernel.org/r/20240726094618.401593-4-21cnbao%40gmail.com
patch subject: [PATCH v5 3/4] mm: support large folios swapin as a whole for zRAM-like swapfile
config: i386-randconfig-141-20240727 (https://download.01.org/0day-ci/archive/20240727/202407270917.18F5rYPH-lkp@intel.com/config)
compiler: clang version 18.1.5 (https://github.com/llvm/llvm-project 617a15a9eac96088ae5e9134248d8236e34b91b1)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
| Closes: https://lore.kernel.org/r/202407270917.18F5rYPH-lkp@intel.com/

smatch warnings:
mm/memory.c:4467 do_swap_page() error: uninitialized symbol 'nr_pages'.

vim +/nr_pages +4467 mm/memory.c

2b7403035459c7 Souptick Joarder        2018-08-23  4143  vm_fault_t do_swap_page(struct vm_fault *vmf)
^1da177e4c3f41 Linus Torvalds          2005-04-16  4144  {
82b0f8c39a3869 Jan Kara                2016-12-14  4145  	struct vm_area_struct *vma = vmf->vma;
d4f9565ae598bd Matthew Wilcox (Oracle  2022-09-02  4146) 	struct folio *swapcache, *folio = NULL;
d4f9565ae598bd Matthew Wilcox (Oracle  2022-09-02  4147) 	struct page *page;
2799e77529c2a2 Miaohe Lin              2021-06-28  4148  	struct swap_info_struct *si = NULL;
14f9135d547060 David Hildenbrand       2022-05-09  4149  	rmap_t rmap_flags = RMAP_NONE;
13ddaf26be324a Kairui Song             2024-02-07  4150  	bool need_clear_cache = false;
1493a1913e34b0 David Hildenbrand       2022-05-09  4151  	bool exclusive = false;
65500d234e74fc Hugh Dickins            2005-10-29  4152  	swp_entry_t entry;
^1da177e4c3f41 Linus Torvalds          2005-04-16  4153  	pte_t pte;
2b7403035459c7 Souptick Joarder        2018-08-23  4154  	vm_fault_t ret = 0;
aae466b0052e18 Joonsoo Kim             2020-08-11  4155  	void *shadow = NULL;
508758960b8d89 Chuanhua Han            2024-05-29  4156  	int nr_pages;
508758960b8d89 Chuanhua Han            2024-05-29  4157  	unsigned long page_idx;
508758960b8d89 Chuanhua Han            2024-05-29  4158  	unsigned long address;
508758960b8d89 Chuanhua Han            2024-05-29  4159  	pte_t *ptep;
^1da177e4c3f41 Linus Torvalds          2005-04-16  4160  
2ca99358671ad3 Peter Xu                2021-11-05  4161  	if (!pte_unmap_same(vmf))
8f4e2101fd7df9 Hugh Dickins            2005-10-29  4162  		goto out;
65500d234e74fc Hugh Dickins            2005-10-29  4163  
2994302bc8a171 Jan Kara                2016-12-14  4164  	entry = pte_to_swp_entry(vmf->orig_pte);
d1737fdbec7f90 Andi Kleen              2009-09-16  4165  	if (unlikely(non_swap_entry(entry))) {
0697212a411c1d Christoph Lameter       2006-06-23  4166  		if (is_migration_entry(entry)) {
82b0f8c39a3869 Jan Kara                2016-12-14  4167  			migration_entry_wait(vma->vm_mm, vmf->pmd,
82b0f8c39a3869 Jan Kara                2016-12-14  4168  					     vmf->address);
b756a3b5e7ead8 Alistair Popple         2021-06-30  4169  		} else if (is_device_exclusive_entry(entry)) {
b756a3b5e7ead8 Alistair Popple         2021-06-30  4170  			vmf->page = pfn_swap_entry_to_page(entry);
b756a3b5e7ead8 Alistair Popple         2021-06-30  4171  			ret = remove_device_exclusive_entry(vmf);
5042db43cc26f5 Jérôme Glisse           2017-09-08  4172  		} else if (is_device_private_entry(entry)) {
1235ccd05b6dd6 Suren Baghdasaryan      2023-06-30  4173  			if (vmf->flags & FAULT_FLAG_VMA_LOCK) {
1235ccd05b6dd6 Suren Baghdasaryan      2023-06-30  4174  				/*
1235ccd05b6dd6 Suren Baghdasaryan      2023-06-30  4175  				 * migrate_to_ram is not yet ready to operate
1235ccd05b6dd6 Suren Baghdasaryan      2023-06-30  4176  				 * under VMA lock.
1235ccd05b6dd6 Suren Baghdasaryan      2023-06-30  4177  				 */
1235ccd05b6dd6 Suren Baghdasaryan      2023-06-30  4178  				vma_end_read(vma);
1235ccd05b6dd6 Suren Baghdasaryan      2023-06-30  4179  				ret = VM_FAULT_RETRY;
1235ccd05b6dd6 Suren Baghdasaryan      2023-06-30  4180  				goto out;
1235ccd05b6dd6 Suren Baghdasaryan      2023-06-30  4181  			}
1235ccd05b6dd6 Suren Baghdasaryan      2023-06-30  4182  
af5cdaf82238fb Alistair Popple         2021-06-30  4183  			vmf->page = pfn_swap_entry_to_page(entry);
16ce101db85db6 Alistair Popple         2022-09-28  4184  			vmf->pte = pte_offset_map_lock(vma->vm_mm, vmf->pmd,
16ce101db85db6 Alistair Popple         2022-09-28  4185  					vmf->address, &vmf->ptl);
3db82b9374ca92 Hugh Dickins            2023-06-08  4186  			if (unlikely(!vmf->pte ||
c33c794828f212 Ryan Roberts            2023-06-12  4187  				     !pte_same(ptep_get(vmf->pte),
c33c794828f212 Ryan Roberts            2023-06-12  4188  							vmf->orig_pte)))
3b65f437d9e8dd Ryan Roberts            2023-06-02  4189  				goto unlock;
16ce101db85db6 Alistair Popple         2022-09-28  4190  
16ce101db85db6 Alistair Popple         2022-09-28  4191  			/*
16ce101db85db6 Alistair Popple         2022-09-28  4192  			 * Get a page reference while we know the page can't be
16ce101db85db6 Alistair Popple         2022-09-28  4193  			 * freed.
16ce101db85db6 Alistair Popple         2022-09-28  4194  			 */
16ce101db85db6 Alistair Popple         2022-09-28  4195  			get_page(vmf->page);
16ce101db85db6 Alistair Popple         2022-09-28  4196  			pte_unmap_unlock(vmf->pte, vmf->ptl);
4a955bed882e73 Alistair Popple         2022-11-14  4197  			ret = vmf->page->pgmap->ops->migrate_to_ram(vmf);
16ce101db85db6 Alistair Popple         2022-09-28  4198  			put_page(vmf->page);
d1737fdbec7f90 Andi Kleen              2009-09-16  4199  		} else if (is_hwpoison_entry(entry)) {
d1737fdbec7f90 Andi Kleen              2009-09-16  4200  			ret = VM_FAULT_HWPOISON;
5c041f5d1f23d3 Peter Xu                2022-05-12  4201  		} else if (is_pte_marker_entry(entry)) {
5c041f5d1f23d3 Peter Xu                2022-05-12  4202  			ret = handle_pte_marker(vmf);
d1737fdbec7f90 Andi Kleen              2009-09-16  4203  		} else {
2994302bc8a171 Jan Kara                2016-12-14  4204  			print_bad_pte(vma, vmf->address, vmf->orig_pte, NULL);
d99be1a8ecf377 Hugh Dickins            2009-12-14  4205  			ret = VM_FAULT_SIGBUS;
d1737fdbec7f90 Andi Kleen              2009-09-16  4206  		}
0697212a411c1d Christoph Lameter       2006-06-23  4207  		goto out;
0697212a411c1d Christoph Lameter       2006-06-23  4208  	}
0bcac06f27d752 Minchan Kim             2017-11-15  4209  
2799e77529c2a2 Miaohe Lin              2021-06-28  4210  	/* Prevent swapoff from happening to us. */
2799e77529c2a2 Miaohe Lin              2021-06-28  4211  	si = get_swap_device(entry);
2799e77529c2a2 Miaohe Lin              2021-06-28  4212  	if (unlikely(!si))
2799e77529c2a2 Miaohe Lin              2021-06-28  4213  		goto out;
0bcac06f27d752 Minchan Kim             2017-11-15  4214  
5a423081b2465d Matthew Wilcox (Oracle  2022-09-02  4215) 	folio = swap_cache_get_folio(entry, vma, vmf->address);
5a423081b2465d Matthew Wilcox (Oracle  2022-09-02  4216) 	if (folio)
5a423081b2465d Matthew Wilcox (Oracle  2022-09-02  4217) 		page = folio_file_page(folio, swp_offset(entry));
d4f9565ae598bd Matthew Wilcox (Oracle  2022-09-02  4218) 	swapcache = folio;
f80207727aaca3 Minchan Kim             2018-01-18  4219  
d4f9565ae598bd Matthew Wilcox (Oracle  2022-09-02  4220) 	if (!folio) {
a449bf58e45abf Qian Cai                2020-08-14  4221  		if (data_race(si->flags & SWP_SYNCHRONOUS_IO) &&
eb085574a7526c Huang Ying              2019-07-11  4222  		    __swap_count(entry) == 1) {
684d098daf0b3a Chuanhua Han            2024-07-26  4223  			/* skip swapcache */
684d098daf0b3a Chuanhua Han            2024-07-26  4224  			folio = alloc_swap_folio(vmf);
684d098daf0b3a Chuanhua Han            2024-07-26  4225  			page = &folio->page;
684d098daf0b3a Chuanhua Han            2024-07-26  4226  			if (folio) {
684d098daf0b3a Chuanhua Han            2024-07-26  4227  				__folio_set_locked(folio);
684d098daf0b3a Chuanhua Han            2024-07-26  4228  				__folio_set_swapbacked(folio);
684d098daf0b3a Chuanhua Han            2024-07-26  4229  
684d098daf0b3a Chuanhua Han            2024-07-26  4230  				nr_pages = folio_nr_pages(folio);

nr_pages is initialized here

684d098daf0b3a Chuanhua Han            2024-07-26  4231  				if (folio_test_large(folio))
684d098daf0b3a Chuanhua Han            2024-07-26  4232  					entry.val = ALIGN_DOWN(entry.val, nr_pages);
13ddaf26be324a Kairui Song             2024-02-07  4233  				/*
13ddaf26be324a Kairui Song             2024-02-07  4234  				 * Prevent parallel swapin from proceeding with
13ddaf26be324a Kairui Song             2024-02-07  4235  				 * the cache flag. Otherwise, another thread may
13ddaf26be324a Kairui Song             2024-02-07  4236  				 * finish swapin first, free the entry, and swapout
13ddaf26be324a Kairui Song             2024-02-07  4237  				 * reusing the same entry. It's undetectable as
13ddaf26be324a Kairui Song             2024-02-07  4238  				 * pte_same() returns true due to entry reuse.
13ddaf26be324a Kairui Song             2024-02-07  4239  				 */
684d098daf0b3a Chuanhua Han            2024-07-26  4240  				if (swapcache_prepare_nr(entry, nr_pages)) {
13ddaf26be324a Kairui Song             2024-02-07  4241  					/* Relax a bit to prevent rapid repeated page faults */
13ddaf26be324a Kairui Song             2024-02-07  4242  					schedule_timeout_uninterruptible(1);
684d098daf0b3a Chuanhua Han            2024-07-26  4243  					goto out_page;
13ddaf26be324a Kairui Song             2024-02-07  4244  				}
13ddaf26be324a Kairui Song             2024-02-07  4245  				need_clear_cache = true;
13ddaf26be324a Kairui Song             2024-02-07  4246  
6599591816f522 Matthew Wilcox (Oracle  2022-09-02  4247) 				if (mem_cgroup_swapin_charge_folio(folio,
63ad4add382305 Matthew Wilcox (Oracle  2022-09-02  4248) 							vma->vm_mm, GFP_KERNEL,
63ad4add382305 Matthew Wilcox (Oracle  2022-09-02  4249) 							entry)) {
545b1b077ca6b3 Michal Hocko            2020-06-25  4250  					ret = VM_FAULT_OOM;
4c6355b25e8bb8 Johannes Weiner         2020-06-03  4251  					goto out_page;
545b1b077ca6b3 Michal Hocko            2020-06-25  4252  				}
684d098daf0b3a Chuanhua Han            2024-07-26  4253  				mem_cgroup_swapin_uncharge_swap_nr(entry, nr_pages);
4c6355b25e8bb8 Johannes Weiner         2020-06-03  4254  
aae466b0052e18 Joonsoo Kim             2020-08-11  4255  				shadow = get_shadow_from_swap_cache(entry);
aae466b0052e18 Joonsoo Kim             2020-08-11  4256  				if (shadow)
63ad4add382305 Matthew Wilcox (Oracle  2022-09-02  4257) 					workingset_refault(folio, shadow);
0076f029cb2906 Joonsoo Kim             2020-06-25  4258  
63ad4add382305 Matthew Wilcox (Oracle  2022-09-02  4259) 				folio_add_lru(folio);
0add0c77a9bd0c Shakeel Butt            2021-04-29  4260  
c9bdf768dd9319 Matthew Wilcox (Oracle  2023-12-13  4261) 				/* To provide entry to swap_read_folio() */
3d2c9087688777 David Hildenbrand       2023-08-21  4262  				folio->swap = entry;
b2d1f38b524121 Yosry Ahmed             2024-06-07  4263  				swap_read_folio(folio, NULL);
63ad4add382305 Matthew Wilcox (Oracle  2022-09-02  4264) 				folio->private = NULL;
0bcac06f27d752 Minchan Kim             2017-11-15  4265  			}
aa8d22a11da933 Minchan Kim             2017-11-15  4266  		} else {
e9e9b7ecee4a13 Minchan Kim             2018-04-05  4267  			page = swapin_readahead(entry, GFP_HIGHUSER_MOVABLE,
e9e9b7ecee4a13 Minchan Kim             2018-04-05  4268  						vmf);
63ad4add382305 Matthew Wilcox (Oracle  2022-09-02  4269) 			if (page)
63ad4add382305 Matthew Wilcox (Oracle  2022-09-02  4270) 				folio = page_folio(page);
d4f9565ae598bd Matthew Wilcox (Oracle  2022-09-02  4271) 			swapcache = folio;
0bcac06f27d752 Minchan Kim             2017-11-15  4272  		}
0bcac06f27d752 Minchan Kim             2017-11-15  4273  
d4f9565ae598bd Matthew Wilcox (Oracle  2022-09-02  4274) 		if (!folio) {
^1da177e4c3f41 Linus Torvalds          2005-04-16  4275  			/*
8f4e2101fd7df9 Hugh Dickins            2005-10-29  4276  			 * Back out if somebody else faulted in this pte
8f4e2101fd7df9 Hugh Dickins            2005-10-29  4277  			 * while we released the pte lock.
^1da177e4c3f41 Linus Torvalds          2005-04-16  4278  			 */
82b0f8c39a3869 Jan Kara                2016-12-14  4279  			vmf->pte = pte_offset_map_lock(vma->vm_mm, vmf->pmd,
82b0f8c39a3869 Jan Kara                2016-12-14  4280  					vmf->address, &vmf->ptl);
c33c794828f212 Ryan Roberts            2023-06-12  4281  			if (likely(vmf->pte &&
c33c794828f212 Ryan Roberts            2023-06-12  4282  				   pte_same(ptep_get(vmf->pte), vmf->orig_pte)))
^1da177e4c3f41 Linus Torvalds          2005-04-16  4283  				ret = VM_FAULT_OOM;
65500d234e74fc Hugh Dickins            2005-10-29  4284  			goto unlock;
^1da177e4c3f41 Linus Torvalds          2005-04-16  4285  		}
^1da177e4c3f41 Linus Torvalds          2005-04-16  4286  
^1da177e4c3f41 Linus Torvalds          2005-04-16  4287  		/* Had to read the page from swap area: Major fault */
^1da177e4c3f41 Linus Torvalds          2005-04-16  4288  		ret = VM_FAULT_MAJOR;
f8891e5e1f93a1 Christoph Lameter       2006-06-30  4289  		count_vm_event(PGMAJFAULT);
2262185c5b287f Roman Gushchin          2017-07-06  4290  		count_memcg_event_mm(vma->vm_mm, PGMAJFAULT);
d1737fdbec7f90 Andi Kleen              2009-09-16  4291  	} else if (PageHWPoison(page)) {
71f72525dfaaec Wu Fengguang            2009-12-16  4292  		/*
71f72525dfaaec Wu Fengguang            2009-12-16  4293  		 * hwpoisoned dirty swapcache pages are kept for killing
71f72525dfaaec Wu Fengguang            2009-12-16  4294  		 * owner processes (which may be unknown at hwpoison time)
71f72525dfaaec Wu Fengguang            2009-12-16  4295  		 */
d1737fdbec7f90 Andi Kleen              2009-09-16  4296  		ret = VM_FAULT_HWPOISON;
4779cb31c0ee3b Andi Kleen              2009-10-14  4297  		goto out_release;
^1da177e4c3f41 Linus Torvalds          2005-04-16  4298  	}
^1da177e4c3f41 Linus Torvalds          2005-04-16  4299  
fdc724d6aa44ef Suren Baghdasaryan      2023-06-30  4300  	ret |= folio_lock_or_retry(folio, vmf);
fdc724d6aa44ef Suren Baghdasaryan      2023-06-30  4301  	if (ret & VM_FAULT_RETRY)
d065bd810b6deb Michel Lespinasse       2010-10-26  4302  		goto out_release;
073e587ec2cc37 KAMEZAWA Hiroyuki       2008-10-18  4303  
84d60fdd3733fb David Hildenbrand       2022-03-24  4304  	if (swapcache) {
4969c1192d15af Andrea Arcangeli        2010-09-09  4305  		/*
3b344157c0c15b Matthew Wilcox (Oracle  2022-09-02  4306) 		 * Make sure folio_free_swap() or swapoff did not release the
84d60fdd3733fb David Hildenbrand       2022-03-24  4307  		 * swapcache from under us.  The page pin, and pte_same test
84d60fdd3733fb David Hildenbrand       2022-03-24  4308  		 * below, are not enough to exclude that.  Even if it is still
84d60fdd3733fb David Hildenbrand       2022-03-24  4309  		 * swapcache, we need to check that the page's swap has not
84d60fdd3733fb David Hildenbrand       2022-03-24  4310  		 * changed.
4969c1192d15af Andrea Arcangeli        2010-09-09  4311  		 */
63ad4add382305 Matthew Wilcox (Oracle  2022-09-02  4312) 		if (unlikely(!folio_test_swapcache(folio) ||
cfeed8ffe55b37 David Hildenbrand       2023-08-21  4313  			     page_swap_entry(page).val != entry.val))
4969c1192d15af Andrea Arcangeli        2010-09-09  4314  			goto out_page;
4969c1192d15af Andrea Arcangeli        2010-09-09  4315  
84d60fdd3733fb David Hildenbrand       2022-03-24  4316  		/*
84d60fdd3733fb David Hildenbrand       2022-03-24  4317  		 * KSM sometimes has to copy on read faults, for example, if
84d60fdd3733fb David Hildenbrand       2022-03-24  4318  		 * page->index of !PageKSM() pages would be nonlinear inside the
84d60fdd3733fb David Hildenbrand       2022-03-24  4319  		 * anon VMA -- PageKSM() is lost on actual swapout.
84d60fdd3733fb David Hildenbrand       2022-03-24  4320  		 */
96db66d9c8f3c1 Matthew Wilcox (Oracle  2023-12-11  4321) 		folio = ksm_might_need_to_copy(folio, vma, vmf->address);
96db66d9c8f3c1 Matthew Wilcox (Oracle  2023-12-11  4322) 		if (unlikely(!folio)) {
5ad6468801d28c Hugh Dickins            2009-12-14  4323  			ret = VM_FAULT_OOM;
96db66d9c8f3c1 Matthew Wilcox (Oracle  2023-12-11  4324) 			folio = swapcache;
4969c1192d15af Andrea Arcangeli        2010-09-09  4325  			goto out_page;
96db66d9c8f3c1 Matthew Wilcox (Oracle  2023-12-11  4326) 		} else if (unlikely(folio == ERR_PTR(-EHWPOISON))) {
6b970599e807ea Kefeng Wang             2022-12-09  4327  			ret = VM_FAULT_HWPOISON;
96db66d9c8f3c1 Matthew Wilcox (Oracle  2023-12-11  4328) 			folio = swapcache;
6b970599e807ea Kefeng Wang             2022-12-09  4329  			goto out_page;
4969c1192d15af Andrea Arcangeli        2010-09-09  4330  		}
96db66d9c8f3c1 Matthew Wilcox (Oracle  2023-12-11  4331) 		if (folio != swapcache)
96db66d9c8f3c1 Matthew Wilcox (Oracle  2023-12-11  4332) 			page = folio_page(folio, 0);
c145e0b47c77eb David Hildenbrand       2022-03-24  4333  
c145e0b47c77eb David Hildenbrand       2022-03-24  4334  		/*
c145e0b47c77eb David Hildenbrand       2022-03-24  4335  		 * If we want to map a page that's in the swapcache writable, we
c145e0b47c77eb David Hildenbrand       2022-03-24  4336  		 * have to detect via the refcount if we're really the exclusive
c145e0b47c77eb David Hildenbrand       2022-03-24  4337  		 * owner. Try removing the extra reference from the local LRU
1fec6890bf2247 Matthew Wilcox (Oracle  2023-06-21  4338) 		 * caches if required.
c145e0b47c77eb David Hildenbrand       2022-03-24  4339  		 */
d4f9565ae598bd Matthew Wilcox (Oracle  2022-09-02  4340) 		if ((vmf->flags & FAULT_FLAG_WRITE) && folio == swapcache &&
63ad4add382305 Matthew Wilcox (Oracle  2022-09-02  4341) 		    !folio_test_ksm(folio) && !folio_test_lru(folio))
c145e0b47c77eb David Hildenbrand       2022-03-24  4342  			lru_add_drain();
84d60fdd3733fb David Hildenbrand       2022-03-24  4343  	}
5ad6468801d28c Hugh Dickins            2009-12-14  4344  
4231f8425833b1 Kefeng Wang             2023-03-02  4345  	folio_throttle_swaprate(folio, GFP_KERNEL);
8a9f3ccd24741b Balbir Singh            2008-02-07  4346  
^1da177e4c3f41 Linus Torvalds          2005-04-16  4347  	/*
8f4e2101fd7df9 Hugh Dickins            2005-10-29  4348  	 * Back out if somebody else already faulted in this pte.
^1da177e4c3f41 Linus Torvalds          2005-04-16  4349  	 */
82b0f8c39a3869 Jan Kara                2016-12-14  4350  	vmf->pte = pte_offset_map_lock(vma->vm_mm, vmf->pmd, vmf->address,
82b0f8c39a3869 Jan Kara                2016-12-14  4351  			&vmf->ptl);
c33c794828f212 Ryan Roberts            2023-06-12  4352  	if (unlikely(!vmf->pte || !pte_same(ptep_get(vmf->pte), vmf->orig_pte)))
b81074800b98ac Kirill Korotaev         2005-05-16  4353  		goto out_nomap;
b81074800b98ac Kirill Korotaev         2005-05-16  4354  
63ad4add382305 Matthew Wilcox (Oracle  2022-09-02  4355) 	if (unlikely(!folio_test_uptodate(folio))) {
b81074800b98ac Kirill Korotaev         2005-05-16  4356  		ret = VM_FAULT_SIGBUS;
b81074800b98ac Kirill Korotaev         2005-05-16  4357  		goto out_nomap;
^1da177e4c3f41 Linus Torvalds          2005-04-16  4358  	}
^1da177e4c3f41 Linus Torvalds          2005-04-16  4359  
684d098daf0b3a Chuanhua Han            2024-07-26  4360  	/* allocated large folios for SWP_SYNCHRONOUS_IO */
684d098daf0b3a Chuanhua Han            2024-07-26  4361  	if (folio_test_large(folio) && !folio_test_swapcache(folio)) {
684d098daf0b3a Chuanhua Han            2024-07-26  4362  		unsigned long nr = folio_nr_pages(folio);
684d098daf0b3a Chuanhua Han            2024-07-26  4363  		unsigned long folio_start = ALIGN_DOWN(vmf->address, nr * PAGE_SIZE);
684d098daf0b3a Chuanhua Han            2024-07-26  4364  		unsigned long idx = (vmf->address - folio_start) / PAGE_SIZE;
684d098daf0b3a Chuanhua Han            2024-07-26  4365  		pte_t *folio_ptep = vmf->pte - idx;
684d098daf0b3a Chuanhua Han            2024-07-26  4366  
684d098daf0b3a Chuanhua Han            2024-07-26  4367  		if (!can_swapin_thp(vmf, folio_ptep, nr))
684d098daf0b3a Chuanhua Han            2024-07-26  4368  			goto out_nomap;
684d098daf0b3a Chuanhua Han            2024-07-26  4369  
684d098daf0b3a Chuanhua Han            2024-07-26  4370  		page_idx = idx;
684d098daf0b3a Chuanhua Han            2024-07-26  4371  		address = folio_start;
684d098daf0b3a Chuanhua Han            2024-07-26  4372  		ptep = folio_ptep;
684d098daf0b3a Chuanhua Han            2024-07-26  4373  		goto check_folio;

Let's say we hit this goto

684d098daf0b3a Chuanhua Han            2024-07-26  4374  	}
684d098daf0b3a Chuanhua Han            2024-07-26  4375  
508758960b8d89 Chuanhua Han            2024-05-29  4376  	nr_pages = 1;
508758960b8d89 Chuanhua Han            2024-05-29  4377  	page_idx = 0;
508758960b8d89 Chuanhua Han            2024-05-29  4378  	address = vmf->address;
508758960b8d89 Chuanhua Han            2024-05-29  4379  	ptep = vmf->pte;
508758960b8d89 Chuanhua Han            2024-05-29  4380  	if (folio_test_large(folio) && folio_test_swapcache(folio)) {
508758960b8d89 Chuanhua Han            2024-05-29  4381  		int nr = folio_nr_pages(folio);
508758960b8d89 Chuanhua Han            2024-05-29  4382  		unsigned long idx = folio_page_idx(folio, page);
508758960b8d89 Chuanhua Han            2024-05-29  4383  		unsigned long folio_start = address - idx * PAGE_SIZE;
508758960b8d89 Chuanhua Han            2024-05-29  4384  		unsigned long folio_end = folio_start + nr * PAGE_SIZE;
508758960b8d89 Chuanhua Han            2024-05-29  4385  		pte_t *folio_ptep;
508758960b8d89 Chuanhua Han            2024-05-29  4386  		pte_t folio_pte;
508758960b8d89 Chuanhua Han            2024-05-29  4387  
508758960b8d89 Chuanhua Han            2024-05-29  4388  		if (unlikely(folio_start < max(address & PMD_MASK, vma->vm_start)))
508758960b8d89 Chuanhua Han            2024-05-29  4389  			goto check_folio;
508758960b8d89 Chuanhua Han            2024-05-29  4390  		if (unlikely(folio_end > pmd_addr_end(address, vma->vm_end)))
508758960b8d89 Chuanhua Han            2024-05-29  4391  			goto check_folio;
508758960b8d89 Chuanhua Han            2024-05-29  4392  
508758960b8d89 Chuanhua Han            2024-05-29  4393  		folio_ptep = vmf->pte - idx;
508758960b8d89 Chuanhua Han            2024-05-29  4394  		folio_pte = ptep_get(folio_ptep);
508758960b8d89 Chuanhua Han            2024-05-29  4395  		if (!pte_same(folio_pte, pte_move_swp_offset(vmf->orig_pte, -idx)) ||
508758960b8d89 Chuanhua Han            2024-05-29  4396  		    swap_pte_batch(folio_ptep, nr, folio_pte) != nr)
508758960b8d89 Chuanhua Han            2024-05-29  4397  			goto check_folio;
508758960b8d89 Chuanhua Han            2024-05-29  4398  
508758960b8d89 Chuanhua Han            2024-05-29  4399  		page_idx = idx;
508758960b8d89 Chuanhua Han            2024-05-29  4400  		address = folio_start;
508758960b8d89 Chuanhua Han            2024-05-29  4401  		ptep = folio_ptep;
508758960b8d89 Chuanhua Han            2024-05-29  4402  		nr_pages = nr;
508758960b8d89 Chuanhua Han            2024-05-29  4403  		entry = folio->swap;
508758960b8d89 Chuanhua Han            2024-05-29  4404  		page = &folio->page;
508758960b8d89 Chuanhua Han            2024-05-29  4405  	}
508758960b8d89 Chuanhua Han            2024-05-29  4406  
508758960b8d89 Chuanhua Han            2024-05-29  4407  check_folio:
78fbe906cc900b David Hildenbrand       2022-05-09  4408  	/*
78fbe906cc900b David Hildenbrand       2022-05-09  4409  	 * PG_anon_exclusive reuses PG_mappedtodisk for anon pages. A swap pte
78fbe906cc900b David Hildenbrand       2022-05-09  4410  	 * must never point at an anonymous page in the swapcache that is
78fbe906cc900b David Hildenbrand       2022-05-09  4411  	 * PG_anon_exclusive. Sanity check that this holds and especially, that
78fbe906cc900b David Hildenbrand       2022-05-09  4412  	 * no filesystem set PG_mappedtodisk on a page in the swapcache. Sanity
78fbe906cc900b David Hildenbrand       2022-05-09  4413  	 * check after taking the PT lock and making sure that nobody
78fbe906cc900b David Hildenbrand       2022-05-09  4414  	 * concurrently faulted in this page and set PG_anon_exclusive.
78fbe906cc900b David Hildenbrand       2022-05-09  4415  	 */
63ad4add382305 Matthew Wilcox (Oracle  2022-09-02  4416) 	BUG_ON(!folio_test_anon(folio) && folio_test_mappedtodisk(folio));
63ad4add382305 Matthew Wilcox (Oracle  2022-09-02  4417) 	BUG_ON(folio_test_anon(folio) && PageAnonExclusive(page));
78fbe906cc900b David Hildenbrand       2022-05-09  4418  
1493a1913e34b0 David Hildenbrand       2022-05-09  4419  	/*
1493a1913e34b0 David Hildenbrand       2022-05-09  4420  	 * Check under PT lock (to protect against concurrent fork() sharing
1493a1913e34b0 David Hildenbrand       2022-05-09  4421  	 * the swap entry concurrently) for certainly exclusive pages.
1493a1913e34b0 David Hildenbrand       2022-05-09  4422  	 */
63ad4add382305 Matthew Wilcox (Oracle  2022-09-02  4423) 	if (!folio_test_ksm(folio)) {
1493a1913e34b0 David Hildenbrand       2022-05-09  4424  		exclusive = pte_swp_exclusive(vmf->orig_pte);
d4f9565ae598bd Matthew Wilcox (Oracle  2022-09-02  4425) 		if (folio != swapcache) {
1493a1913e34b0 David Hildenbrand       2022-05-09  4426  			/*
1493a1913e34b0 David Hildenbrand       2022-05-09  4427  			 * We have a fresh page that is not exposed to the
1493a1913e34b0 David Hildenbrand       2022-05-09  4428  			 * swapcache -> certainly exclusive.
1493a1913e34b0 David Hildenbrand       2022-05-09  4429  			 */
1493a1913e34b0 David Hildenbrand       2022-05-09  4430  			exclusive = true;
63ad4add382305 Matthew Wilcox (Oracle  2022-09-02  4431) 		} else if (exclusive && folio_test_writeback(folio) &&
eacde32757c756 Miaohe Lin              2022-05-19  4432  			  data_race(si->flags & SWP_STABLE_WRITES)) {
1493a1913e34b0 David Hildenbrand       2022-05-09  4433  			/*
1493a1913e34b0 David Hildenbrand       2022-05-09  4434  			 * This is tricky: not all swap backends support
1493a1913e34b0 David Hildenbrand       2022-05-09  4435  			 * concurrent page modifications while under writeback.
1493a1913e34b0 David Hildenbrand       2022-05-09  4436  			 *
1493a1913e34b0 David Hildenbrand       2022-05-09  4437  			 * So if we stumble over such a page in the swapcache
1493a1913e34b0 David Hildenbrand       2022-05-09  4438  			 * we must not set the page exclusive, otherwise we can
1493a1913e34b0 David Hildenbrand       2022-05-09  4439  			 * map it writable without further checks and modify it
1493a1913e34b0 David Hildenbrand       2022-05-09  4440  			 * while still under writeback.
1493a1913e34b0 David Hildenbrand       2022-05-09  4441  			 *
1493a1913e34b0 David Hildenbrand       2022-05-09  4442  			 * For these problematic swap backends, simply drop the
1493a1913e34b0 David Hildenbrand       2022-05-09  4443  			 * exclusive marker: this is perfectly fine as we start
1493a1913e34b0 David Hildenbrand       2022-05-09  4444  			 * writeback only if we fully unmapped the page and
1493a1913e34b0 David Hildenbrand       2022-05-09  4445  			 * there are no unexpected references on the page after
1493a1913e34b0 David Hildenbrand       2022-05-09  4446  			 * unmapping succeeded. After fully unmapped, no
1493a1913e34b0 David Hildenbrand       2022-05-09  4447  			 * further GUP references (FOLL_GET and FOLL_PIN) can
1493a1913e34b0 David Hildenbrand       2022-05-09  4448  			 * appear, so dropping the exclusive marker and mapping
1493a1913e34b0 David Hildenbrand       2022-05-09  4449  			 * it only R/O is fine.
1493a1913e34b0 David Hildenbrand       2022-05-09  4450  			 */
1493a1913e34b0 David Hildenbrand       2022-05-09  4451  			exclusive = false;
1493a1913e34b0 David Hildenbrand       2022-05-09  4452  		}
1493a1913e34b0 David Hildenbrand       2022-05-09  4453  	}
1493a1913e34b0 David Hildenbrand       2022-05-09  4454  
6dca4ac6fc91fd Peter Collingbourne     2023-05-22  4455  	/*
6dca4ac6fc91fd Peter Collingbourne     2023-05-22  4456  	 * Some architectures may have to restore extra metadata to the page
6dca4ac6fc91fd Peter Collingbourne     2023-05-22  4457  	 * when reading from swap. This metadata may be indexed by swap entry
6dca4ac6fc91fd Peter Collingbourne     2023-05-22  4458  	 * so this must be called before swap_free().
6dca4ac6fc91fd Peter Collingbourne     2023-05-22  4459  	 */
f238b8c33c6738 Barry Song              2024-03-23  4460  	arch_swap_restore(folio_swap(entry, folio), folio);
6dca4ac6fc91fd Peter Collingbourne     2023-05-22  4461  
8c7c6e34a1256a KAMEZAWA Hiroyuki       2009-01-07  4462  	/*
c145e0b47c77eb David Hildenbrand       2022-03-24  4463  	 * Remove the swap entry and conditionally try to free up the swapcache.
c145e0b47c77eb David Hildenbrand       2022-03-24  4464  	 * We're already holding a reference on the page but haven't mapped it
c145e0b47c77eb David Hildenbrand       2022-03-24  4465  	 * yet.
8c7c6e34a1256a KAMEZAWA Hiroyuki       2009-01-07  4466  	 */
508758960b8d89 Chuanhua Han            2024-05-29 @4467  	swap_free_nr(entry, nr_pages);
                                                                                    ^^^^^^^^
Smatch warning.  The code is a bit complicated so it could be a false
positive.

a160e5377b55bc Matthew Wilcox (Oracle  2022-09-02  4468) 	if (should_try_to_free_swap(folio, vma, vmf->flags))
a160e5377b55bc Matthew Wilcox (Oracle  2022-09-02  4469) 		folio_free_swap(folio);
^1da177e4c3f41 Linus Torvalds          2005-04-16  4470  
508758960b8d89 Chuanhua Han            2024-05-29  4471  	add_mm_counter(vma->vm_mm, MM_ANONPAGES, nr_pages);
508758960b8d89 Chuanhua Han            2024-05-29  4472  	add_mm_counter(vma->vm_mm, MM_SWAPENTS, -nr_pages);
^1da177e4c3f41 Linus Torvalds          2005-04-16  4473  	pte = mk_pte(page, vma->vm_page_prot);
c18160dba5ff63 Barry Song              2024-06-02  4474  	if (pte_swp_soft_dirty(vmf->orig_pte))
c18160dba5ff63 Barry Song              2024-06-02  4475  		pte = pte_mksoft_dirty(pte);
c18160dba5ff63 Barry Song              2024-06-02  4476  	if (pte_swp_uffd_wp(vmf->orig_pte))
c18160dba5ff63 Barry Song              2024-06-02  4477  		pte = pte_mkuffd_wp(pte);
c145e0b47c77eb David Hildenbrand       2022-03-24  4478  
c145e0b47c77eb David Hildenbrand       2022-03-24  4479  	/*
1493a1913e34b0 David Hildenbrand       2022-05-09  4480  	 * Same logic as in do_wp_page(); however, optimize for pages that are
1493a1913e34b0 David Hildenbrand       2022-05-09  4481  	 * certainly not shared either because we just allocated them without
1493a1913e34b0 David Hildenbrand       2022-05-09  4482  	 * exposing them to the swapcache or because the swap entry indicates
1493a1913e34b0 David Hildenbrand       2022-05-09  4483  	 * exclusivity.
c145e0b47c77eb David Hildenbrand       2022-03-24  4484  	 */
63ad4add382305 Matthew Wilcox (Oracle  2022-09-02  4485) 	if (!folio_test_ksm(folio) &&
63ad4add382305 Matthew Wilcox (Oracle  2022-09-02  4486) 	    (exclusive || folio_ref_count(folio) == 1)) {
c18160dba5ff63 Barry Song              2024-06-02  4487  		if ((vma->vm_flags & VM_WRITE) && !userfaultfd_pte_wp(vma, pte) &&
20dfa5b7adc5a1 Barry Song              2024-06-08  4488  		    !pte_needs_soft_dirty_wp(vma, pte)) {
c18160dba5ff63 Barry Song              2024-06-02  4489  			pte = pte_mkwrite(pte, vma);
6c287605fd5646 David Hildenbrand       2022-05-09  4490  			if (vmf->flags & FAULT_FLAG_WRITE) {
c18160dba5ff63 Barry Song              2024-06-02  4491  				pte = pte_mkdirty(pte);
82b0f8c39a3869 Jan Kara                2016-12-14  4492  				vmf->flags &= ~FAULT_FLAG_WRITE;
6c287605fd5646 David Hildenbrand       2022-05-09  4493  			}
c18160dba5ff63 Barry Song              2024-06-02  4494  		}
14f9135d547060 David Hildenbrand       2022-05-09  4495  		rmap_flags |= RMAP_EXCLUSIVE;
^1da177e4c3f41 Linus Torvalds          2005-04-16  4496  	}
508758960b8d89 Chuanhua Han            2024-05-29  4497  	folio_ref_add(folio, nr_pages - 1);
508758960b8d89 Chuanhua Han            2024-05-29  4498  	flush_icache_pages(vma, page, nr_pages);
508758960b8d89 Chuanhua Han            2024-05-29  4499  	vmf->orig_pte = pte_advance_pfn(pte, page_idx);
0bcac06f27d752 Minchan Kim             2017-11-15  4500  
0bcac06f27d752 Minchan Kim             2017-11-15  4501  	/* ksm created a completely new copy */
d4f9565ae598bd Matthew Wilcox (Oracle  2022-09-02  4502) 	if (unlikely(folio != swapcache && swapcache)) {
15bde4abab734c Barry Song              2024-06-18  4503  		folio_add_new_anon_rmap(folio, vma, address, RMAP_EXCLUSIVE);
63ad4add382305 Matthew Wilcox (Oracle  2022-09-02  4504) 		folio_add_lru_vma(folio, vma);
9ae2feacedde16 Barry Song              2024-06-18  4505  	} else if (!folio_test_anon(folio)) {
9ae2feacedde16 Barry Song              2024-06-18  4506  		/*
684d098daf0b3a Chuanhua Han            2024-07-26  4507  		 * We currently only expect small !anon folios which are either
684d098daf0b3a Chuanhua Han            2024-07-26  4508  		 * fully exclusive or fully shared, or new allocated large folios
684d098daf0b3a Chuanhua Han            2024-07-26  4509  		 * which are fully exclusive. If we ever get large folios within
684d098daf0b3a Chuanhua Han            2024-07-26  4510  		 * swapcache here, we have to be careful.
9ae2feacedde16 Barry Song              2024-06-18  4511  		 */
684d098daf0b3a Chuanhua Han            2024-07-26  4512  		VM_WARN_ON_ONCE(folio_test_large(folio) && folio_test_swapcache(folio));
9ae2feacedde16 Barry Song              2024-06-18  4513  		VM_WARN_ON_FOLIO(!folio_test_locked(folio), folio);
9ae2feacedde16 Barry Song              2024-06-18  4514  		folio_add_new_anon_rmap(folio, vma, address, rmap_flags);
0bcac06f27d752 Minchan Kim             2017-11-15  4515  	} else {
508758960b8d89 Chuanhua Han            2024-05-29  4516  		folio_add_anon_rmap_ptes(folio, page, nr_pages, vma, address,
b832a354d787bf David Hildenbrand       2023-12-20  4517  					rmap_flags);
00501b531c4723 Johannes Weiner         2014-08-08  4518  	}
^1da177e4c3f41 Linus Torvalds          2005-04-16  4519  
63ad4add382305 Matthew Wilcox (Oracle  2022-09-02  4520) 	VM_BUG_ON(!folio_test_anon(folio) ||
63ad4add382305 Matthew Wilcox (Oracle  2022-09-02  4521) 			(pte_write(pte) && !PageAnonExclusive(page)));
508758960b8d89 Chuanhua Han            2024-05-29  4522  	set_ptes(vma->vm_mm, address, ptep, pte, nr_pages);
508758960b8d89 Chuanhua Han            2024-05-29  4523  	arch_do_swap_page_nr(vma->vm_mm, vma, address,
508758960b8d89 Chuanhua Han            2024-05-29  4524  			pte, pte, nr_pages);
1eba86c096e35e Pasha Tatashin          2022-01-14  4525  
63ad4add382305 Matthew Wilcox (Oracle  2022-09-02  4526) 	folio_unlock(folio);
d4f9565ae598bd Matthew Wilcox (Oracle  2022-09-02  4527) 	if (folio != swapcache && swapcache) {
4969c1192d15af Andrea Arcangeli        2010-09-09  4528  		/*
4969c1192d15af Andrea Arcangeli        2010-09-09  4529  		 * Hold the lock to avoid the swap entry to be reused
4969c1192d15af Andrea Arcangeli        2010-09-09  4530  		 * until we take the PT lock for the pte_same() check
4969c1192d15af Andrea Arcangeli        2010-09-09  4531  		 * (to avoid false positives from pte_same). For
4969c1192d15af Andrea Arcangeli        2010-09-09  4532  		 * further safety release the lock after the swap_free
4969c1192d15af Andrea Arcangeli        2010-09-09  4533  		 * so that the swap count won't change under a
4969c1192d15af Andrea Arcangeli        2010-09-09  4534  		 * parallel locked swapcache.
4969c1192d15af Andrea Arcangeli        2010-09-09  4535  		 */
d4f9565ae598bd Matthew Wilcox (Oracle  2022-09-02  4536) 		folio_unlock(swapcache);
d4f9565ae598bd Matthew Wilcox (Oracle  2022-09-02  4537) 		folio_put(swapcache);
4969c1192d15af Andrea Arcangeli        2010-09-09  4538  	}
c475a8ab625d56 Hugh Dickins            2005-06-21  4539  
82b0f8c39a3869 Jan Kara                2016-12-14  4540  	if (vmf->flags & FAULT_FLAG_WRITE) {
2994302bc8a171 Jan Kara                2016-12-14  4541  		ret |= do_wp_page(vmf);
61469f1d51777f Hugh Dickins            2008-03-04  4542  		if (ret & VM_FAULT_ERROR)
61469f1d51777f Hugh Dickins            2008-03-04  4543  			ret &= VM_FAULT_ERROR;
^1da177e4c3f41 Linus Torvalds          2005-04-16  4544  		goto out;
^1da177e4c3f41 Linus Torvalds          2005-04-16  4545  	}
^1da177e4c3f41 Linus Torvalds          2005-04-16  4546  
^1da177e4c3f41 Linus Torvalds          2005-04-16  4547  	/* No need to invalidate - it was non-present before */
508758960b8d89 Chuanhua Han            2024-05-29  4548  	update_mmu_cache_range(vmf, vma, address, ptep, nr_pages);
65500d234e74fc Hugh Dickins            2005-10-29  4549  unlock:
3db82b9374ca92 Hugh Dickins            2023-06-08  4550  	if (vmf->pte)
82b0f8c39a3869 Jan Kara                2016-12-14  4551  		pte_unmap_unlock(vmf->pte, vmf->ptl);
^1da177e4c3f41 Linus Torvalds          2005-04-16  4552  out:
13ddaf26be324a Kairui Song             2024-02-07  4553  	/* Clear the swap cache pin for direct swapin after PTL unlock */
13ddaf26be324a Kairui Song             2024-02-07  4554  	if (need_clear_cache)
684d098daf0b3a Chuanhua Han            2024-07-26  4555  		swapcache_clear_nr(si, entry, nr_pages);
2799e77529c2a2 Miaohe Lin              2021-06-28  4556  	if (si)
2799e77529c2a2 Miaohe Lin              2021-06-28  4557  		put_swap_device(si);
^1da177e4c3f41 Linus Torvalds          2005-04-16  4558  	return ret;
b81074800b98ac Kirill Korotaev         2005-05-16  4559  out_nomap:
3db82b9374ca92 Hugh Dickins            2023-06-08  4560  	if (vmf->pte)
82b0f8c39a3869 Jan Kara                2016-12-14  4561  		pte_unmap_unlock(vmf->pte, vmf->ptl);
bc43f75cd98158 Johannes Weiner         2009-04-30  4562  out_page:
63ad4add382305 Matthew Wilcox (Oracle  2022-09-02  4563) 	folio_unlock(folio);
4779cb31c0ee3b Andi Kleen              2009-10-14  4564  out_release:
63ad4add382305 Matthew Wilcox (Oracle  2022-09-02  4565) 	folio_put(folio);
d4f9565ae598bd Matthew Wilcox (Oracle  2022-09-02  4566) 	if (folio != swapcache && swapcache) {
d4f9565ae598bd Matthew Wilcox (Oracle  2022-09-02  4567) 		folio_unlock(swapcache);
d4f9565ae598bd Matthew Wilcox (Oracle  2022-09-02  4568) 		folio_put(swapcache);
4969c1192d15af Andrea Arcangeli        2010-09-09  4569  	}
13ddaf26be324a Kairui Song             2024-02-07  4570  	if (need_clear_cache)
684d098daf0b3a Chuanhua Han            2024-07-26  4571  		swapcache_clear_nr(si, entry, nr_pages);
2799e77529c2a2 Miaohe Lin              2021-06-28  4572  	if (si)
2799e77529c2a2 Miaohe Lin              2021-06-28  4573  		put_swap_device(si);
65500d234e74fc Hugh Dickins            2005-10-29  4574  	return ret;
^1da177e4c3f41 Linus Torvalds          2005-04-16  4575  }

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


