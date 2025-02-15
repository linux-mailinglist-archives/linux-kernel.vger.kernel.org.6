Return-Path: <linux-kernel+bounces-516194-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EC7BBA36DF8
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Feb 2025 13:07:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AB3411894668
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Feb 2025 12:07:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C2921AAA1E;
	Sat, 15 Feb 2025 12:07:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Et+6fhmq"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CA031624F4
	for <linux-kernel@vger.kernel.org>; Sat, 15 Feb 2025 12:07:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739621264; cv=none; b=kBrRXLBThVpTcZMhfSLGvT3E7pdWwqxZlNVN8rh5gV7EsQ34OkCmFKnMyQ5Mga2VHrjcGNpitJ+lanEEJgDcZfdCoAzCnPpH2UIL9G+ppqoATN+xP6cyL0OVMCcuZqMmbxSo7U9dIbnaVjxsbwfJT+PTiICj3V7fcFYYcQedcUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739621264; c=relaxed/simple;
	bh=FENgo9N+5CHwfI3frlW5p4Ha594C1eAblgT51nZjjjg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=hcstKR4fey+cSmxnFxZtVtoegXKx9Xh+nj1nTlmiLrXG4jPbHznSmEdnz4DJTkcqyed0tK2OPIb3LRvK625tBaC0og2gaJ1nIC1rDmG9z4neRPtLIcr99h3blAdcoFULPsKsBsrhSY5RbuWaf32QH7XUH8XlqPCzJCLbj2QGIj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Et+6fhmq; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739621260; x=1771157260;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=FENgo9N+5CHwfI3frlW5p4Ha594C1eAblgT51nZjjjg=;
  b=Et+6fhmqI25tDchRISzOQO+NEsNW2yu5QUoVw8yYwKK+CmPA/qvvv3G1
   hMN3p7M3DeAFvJL1BGu2HJwiaKIu4w68kYVeozih+6cXocVc41tQnAolP
   x4GXEcEfIcvKrJnfH87uLBFazpRbdf9xO0xdLfc2dsBMQXU+rU/snVZhQ
   BjU+Tay0MkeVNTNNaqzPgc39XRM4o0IP/4qexH6plD27VYs3Wt/MDvhVA
   xDEhEqL5RzYbbqPyiV9vlRjeG98jvH3Oz1fyr+TRIOKZNkYtZRJoAuHvc
   fmU/hXSzm8F0NOwDscbhxoHHpR515N8R+YNvnmJy+X+5dpmtivxTSbaYA
   g==;
X-CSE-ConnectionGUID: zsiqq9BaSfGWSqYY1/0mKQ==
X-CSE-MsgGUID: lWtHPVo6SWSEBMlNj+i8sw==
X-IronPort-AV: E=McAfee;i="6700,10204,11346"; a="44126543"
X-IronPort-AV: E=Sophos;i="6.13,288,1732608000"; 
   d="scan'208";a="44126543"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2025 04:07:39 -0800
X-CSE-ConnectionGUID: JLxBdXJ1S1aKpg37870oPg==
X-CSE-MsgGUID: rgyOkmrESWi5xMRRklU8eQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,288,1732608000"; 
   d="scan'208";a="118800086"
Received: from lkp-server01.sh.intel.com (HELO d63d4d77d921) ([10.239.97.150])
  by fmviesa004.fm.intel.com with ESMTP; 15 Feb 2025 04:07:38 -0800
Received: from kbuild by d63d4d77d921 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tjGxM-001AmN-06;
	Sat, 15 Feb 2025 12:07:36 +0000
Date: Sat, 15 Feb 2025 20:07:19 +0800
From: kernel test robot <lkp@intel.com>
To: Vincent Donnefort <vdonnefort@google.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	"Steven Rostedt (Google)" <rostedt@goodmis.org>
Subject: kernel/trace/ring_buffer.c:6265 __rb_map_vma() warn: unsigned '_x'
 is never less than zero.
Message-ID: <202502151925.c1S00bk3-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   7ff71e6d923969d933e1ba7e0db857782d36cd19
commit: 117c39200d9d760cbd5944bb89efb7b9c51965aa ring-buffer: Introducing ring-buffer mapping functions
date:   9 months ago
config: riscv-randconfig-r073-20250213 (https://download.01.org/0day-ci/archive/20250215/202502151925.c1S00bk3-lkp@intel.com/config)
compiler: riscv32-linux-gcc (GCC) 14.2.0

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202502151925.c1S00bk3-lkp@intel.com/

New smatch warnings:
kernel/trace/ring_buffer.c:6265 __rb_map_vma() warn: unsigned '_x' is never less than zero.

Old smatch warnings:
include/linux/mm.h:1306 virt_to_folio() warn: unsigned '_x' is never less than zero.

vim +/_x +6265 kernel/trace/ring_buffer.c

  6212	
  6213	/*
  6214	 *   +--------------+  pgoff == 0
  6215	 *   |   meta page  |
  6216	 *   +--------------+  pgoff == 1
  6217	 *   | subbuffer 0  |
  6218	 *   |              |
  6219	 *   +--------------+  pgoff == (1 + (1 << subbuf_order))
  6220	 *   | subbuffer 1  |
  6221	 *   |              |
  6222	 *         ...
  6223	 */
  6224	#ifdef CONFIG_MMU
  6225	static int __rb_map_vma(struct ring_buffer_per_cpu *cpu_buffer,
  6226				struct vm_area_struct *vma)
  6227	{
  6228		unsigned long nr_subbufs, nr_pages, vma_pages, pgoff = vma->vm_pgoff;
  6229		unsigned int subbuf_pages, subbuf_order;
  6230		struct page **pages;
  6231		int p = 0, s = 0;
  6232		int err;
  6233	
  6234		/* Refuse MP_PRIVATE or writable mappings */
  6235		if (vma->vm_flags & VM_WRITE || vma->vm_flags & VM_EXEC ||
  6236		    !(vma->vm_flags & VM_MAYSHARE))
  6237			return -EPERM;
  6238	
  6239		/*
  6240		 * Make sure the mapping cannot become writable later. Also tell the VM
  6241		 * to not touch these pages (VM_DONTCOPY | VM_DONTEXPAND).
  6242		 */
  6243		vm_flags_mod(vma, VM_DONTCOPY | VM_DONTEXPAND | VM_DONTDUMP,
  6244			     VM_MAYWRITE);
  6245	
  6246		lockdep_assert_held(&cpu_buffer->mapping_lock);
  6247	
  6248		subbuf_order = cpu_buffer->buffer->subbuf_order;
  6249		subbuf_pages = 1 << subbuf_order;
  6250	
  6251		nr_subbufs = cpu_buffer->nr_pages + 1; /* + reader-subbuf */
  6252		nr_pages = ((nr_subbufs) << subbuf_order) - pgoff + 1; /* + meta-page */
  6253	
  6254		vma_pages = (vma->vm_end - vma->vm_start) >> PAGE_SHIFT;
  6255		if (!vma_pages || vma_pages > nr_pages)
  6256			return -EINVAL;
  6257	
  6258		nr_pages = vma_pages;
  6259	
  6260		pages = kcalloc(nr_pages, sizeof(*pages), GFP_KERNEL);
  6261		if (!pages)
  6262			return -ENOMEM;
  6263	
  6264		if (!pgoff) {
> 6265			pages[p++] = virt_to_page(cpu_buffer->meta_page);
  6266	
  6267			/*
  6268			 * TODO: Align sub-buffers on their size, once
  6269			 * vm_insert_pages() supports the zero-page.
  6270			 */
  6271		} else {
  6272			/* Skip the meta-page */
  6273			pgoff--;
  6274	
  6275			if (pgoff % subbuf_pages) {
  6276				err = -EINVAL;
  6277				goto out;
  6278			}
  6279	
  6280			s += pgoff / subbuf_pages;
  6281		}
  6282	
  6283		while (p < nr_pages) {
  6284			struct page *page = virt_to_page(cpu_buffer->subbuf_ids[s]);
  6285			int off = 0;
  6286	
  6287			if (WARN_ON_ONCE(s >= nr_subbufs)) {
  6288				err = -EINVAL;
  6289				goto out;
  6290			}
  6291	
  6292			for (; off < (1 << (subbuf_order)); off++, page++) {
  6293				if (p >= nr_pages)
  6294					break;
  6295	
  6296				pages[p++] = page;
  6297			}
  6298			s++;
  6299		}
  6300	
  6301		err = vm_insert_pages(vma, vma->vm_start, pages, &nr_pages);
  6302	
  6303	out:
  6304		kfree(pages);
  6305	
  6306		return err;
  6307	}
  6308	#else
  6309	static int __rb_map_vma(struct ring_buffer_per_cpu *cpu_buffer,
  6310				struct vm_area_struct *vma)
  6311	{
  6312		return -EOPNOTSUPP;
  6313	}
  6314	#endif
  6315	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

