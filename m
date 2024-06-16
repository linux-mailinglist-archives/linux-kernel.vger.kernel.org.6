Return-Path: <linux-kernel+bounces-216399-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 166E7909ED8
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Jun 2024 19:43:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 84AB51F22898
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Jun 2024 17:43:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F2961CA84;
	Sun, 16 Jun 2024 17:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bPaECeDY"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3EA01BC57
	for <linux-kernel@vger.kernel.org>; Sun, 16 Jun 2024 17:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718559814; cv=none; b=th0JpHG1RLlinoHhoW09eZSu0XILsB/cPX/A2KUqn00Yu/GGoHVv7aM7X7VoiKxEF4VXM/+3idOi8ksznLhIaX0d4nHAJObFwKNYvL9EwFQgR4vp/8R+2135AZAbX2mVs8iD2irtgdm4xbrOWFQAdPAVdtBpF3JU1VjIycGZoZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718559814; c=relaxed/simple;
	bh=kney88/fR3zgNHKHHoQnct2BGElZJz8iOIPJpsSQXtk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BSa1g4ulUz5/z18I0uhRiHRHl+ashrX8chtFXZy9VhOi5aVKjxCr3xkyZca2AaExBjUF4YOSS805oKqgISF+sg1dJ+qn677xT0SWnXyZCOKgnznPmIVcbCYa5xgJ0v2sTTY5qhQd9VZxX4YAwGGEk5VrEsx6p3oO9dvhQ3xhz68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bPaECeDY; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718559811; x=1750095811;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=kney88/fR3zgNHKHHoQnct2BGElZJz8iOIPJpsSQXtk=;
  b=bPaECeDY221/bJgvCz1oBPc9EDq3dmOJSBv1gie2+53RjQHXcWQWImKd
   EtUA3s0EOCef+6KpmEKOZxrx3WHra3lhyLThucLLcBL3itiLqDu4ruRA3
   FS8d+1J+UgJ36q4ERferbdVTEfJHPFnSr5Bird41cuvXwK+d+5hdVOGPj
   maTDPXo0NQ/jXjXXMTGvBXL4ViGmSOPUzsYzPzI/cEslAyvy5frq+T7X0
   bSm84XVgGaMj35OJfl7VJUeVZni/6qTM+SGZAc33gGK7ZNg9EELnfyViL
   ne3p1yVWNSLuHQwHwf8kAzAkARVgrKLNp5FN0I2FqpAQ//b+tb1Dl2aWI
   A==;
X-CSE-ConnectionGUID: 0X2IzYivRzyvoawqqkWXfA==
X-CSE-MsgGUID: eex+JACwQeq5Jaglqu7pCw==
X-IronPort-AV: E=McAfee;i="6700,10204,11105"; a="32864148"
X-IronPort-AV: E=Sophos;i="6.08,242,1712646000"; 
   d="scan'208";a="32864148"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2024 10:43:31 -0700
X-CSE-ConnectionGUID: d0mv4TVPSEax9xjk+C2CPw==
X-CSE-MsgGUID: F5+OD2EFTYyH6/8hWUkYJw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,242,1712646000"; 
   d="scan'208";a="40839229"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by fmviesa007.fm.intel.com with ESMTP; 16 Jun 2024 10:43:29 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sItuY-00036s-2z;
	Sun, 16 Jun 2024 17:43:26 +0000
Date: Mon, 17 Jun 2024 01:42:27 +0800
From: kernel test robot <lkp@intel.com>
To: Abhinav Jain <jain.abhinav177@gmail.com>,
	almaz.alexandrovich@paragon-software.com, ntfs3@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, skhan@linuxfoundation.org,
	javier.carrasco.cruz@gmail.com, jain.abhinav177@gmail.com
Subject: Re: [PATCH] fs/ntfs3: Remove recursion in indx_insert_into_buffer
Message-ID: <202406170138.l8RDg80M-lkp@intel.com>
References: <20240616133704.45284-1-jain.abhinav177@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240616133704.45284-1-jain.abhinav177@gmail.com>

Hi Abhinav,

kernel test robot noticed the following build errors:

[auto build test ERROR on linus/master]
[also build test ERROR on v6.10-rc3 next-20240613]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Abhinav-Jain/fs-ntfs3-Remove-recursion-in-indx_insert_into_buffer/20240616-213846
base:   linus/master
patch link:    https://lore.kernel.org/r/20240616133704.45284-1-jain.abhinav177%40gmail.com
patch subject: [PATCH] fs/ntfs3: Remove recursion in indx_insert_into_buffer
config: arc-randconfig-001-20240616 (https://download.01.org/0day-ci/archive/20240617/202406170138.l8RDg80M-lkp@intel.com/config)
compiler: arc-elf-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240617/202406170138.l8RDg80M-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202406170138.l8RDg80M-lkp@intel.com/

All errors (new ones prefixed by >>):

   fs/ntfs3/index.c: In function 'indx_insert_into_buffer':
>> fs/ntfs3/index.c:1915:25: error: 'hrd1' undeclared (first use in this function); did you mean 'hdr1'?
    1915 |                         hrd1 = &n1->index->ihdr;
         |                         ^~~~
         |                         hdr1
   fs/ntfs3/index.c:1915:25: note: each undeclared identifier is reported only once for each function it appears in

Kconfig warnings: (for reference only)
   WARNING: unmet direct dependencies detected for REGMAP_SPI
   Depends on [n]: SPI [=n]
   Selected by [y]:
   - AD9739A [=y] && IIO [=y] && (SPI [=n] || COMPILE_TEST [=y])


vim +1915 fs/ntfs3/index.c

  1780	
  1781	/*
  1782	 * indx_insert_into_buffer
  1783	 *
  1784	 * Attempt to insert an entry into an Index Allocation Buffer.
  1785	 * If necessary, it will split the buffer.
  1786	 */
  1787	static int
  1788	indx_insert_into_buffer(struct ntfs_index *indx, struct ntfs_inode *ni,
  1789				struct INDEX_ROOT *root, const struct NTFS_DE *new_de,
  1790				const void *ctx, int level, struct ntfs_fnd *fnd)
  1791	{
  1792		int err;
  1793		const struct NTFS_DE *sp;
  1794		struct NTFS_DE *e, *de_t, *up_e;
  1795		struct indx_node *n2;
  1796		struct indx_node *n1 = fnd->nodes[level];
  1797		struct INDEX_HDR *hdr1 = &n1->index->ihdr;
  1798		struct INDEX_HDR *hdr2;
  1799		u32 to_copy, used, used1;
  1800		CLST new_vbn;
  1801		__le64 t_vbn, *sub_vbn;
  1802		u16 sp_size;
  1803		void *hdr1_saved = NULL;
  1804	
  1805		while (true) {
  1806			/* Try the most easy case. */
  1807			e = fnd->level - 1 == level ? fnd->de[level] : NULL;
  1808			e = hdr_insert_de(indx, hdr1, new_de, e, ctx);
  1809			fnd->de[level] = e;
  1810			if (e) {
  1811				/* Just write updated index into disk. */
  1812				indx_write(indx, ni, n1, 0);
  1813				return 0;
  1814			}
  1815	
  1816			/*
  1817			 * No space to insert into buffer. Split it.
  1818			 * To split we:
  1819			 * - Save split point because index buffers will be changed
  1820			 * - Allocate NewBuffer and copy all entries <= sp into new
  1821			 *   buffer
  1822			 * - Remove all entries (sp including) from TargetBuffer
  1823			 * - Insert NewEntry into left or right buffer
  1824			 *   (depending on sp <=> NewEntry)
  1825			 * - Insert sp into parent buffer (or root)
  1826			 * - Make sp a parent for new buffer
  1827			 */
  1828			sp = hdr_find_split(hdr1);
  1829			if (!sp)
  1830				return -EINVAL;
  1831	
  1832			sp_size = le16_to_cpu(sp->size);
  1833			up_e = kmalloc(sp_size + sizeof(u64), GFP_NOFS);
  1834			if (!up_e)
  1835				return -ENOMEM;
  1836			memcpy(up_e, sp, sp_size);
  1837	
  1838			used1 = le32_to_cpu(hdr1->used);
  1839			hdr1_saved = kmemdup(hdr1, used1, GFP_NOFS);
  1840			if (!hdr1_saved) {
  1841				err = -ENOMEM;
  1842				goto out;
  1843			}
  1844	
  1845			if (!hdr1->flags) {
  1846				up_e->flags |= NTFS_IE_HAS_SUBNODES;
  1847				up_e->size = cpu_to_le16(sp_size + sizeof(u64));
  1848				sub_vbn = NULL;
  1849			} else {
  1850				t_vbn = de_get_vbn_le(up_e);
  1851				sub_vbn = &t_vbn;
  1852			}
  1853	
  1854			/* Allocate on disk a new index allocation buffer. */
  1855			err = indx_add_allocate(indx, ni, &new_vbn);
  1856			if (err)
  1857				goto out;
  1858	
  1859			/* Allocate and format memory a new index buffer. */
  1860			n2 = indx_new(indx, ni, new_vbn, sub_vbn);
  1861			if (IS_ERR(n2)) {
  1862				err = PTR_ERR(n2);
  1863				goto out;
  1864			}
  1865	
  1866			hdr2 = &n2->index->ihdr;
  1867	
  1868			/* Make sp a parent for new buffer. */
  1869			de_set_vbn(up_e, new_vbn);
  1870	
  1871			/* Copy all the entries <= sp into the new buffer. */
  1872			de_t = hdr_first_de(hdr1);
  1873			to_copy = PtrOffset(de_t, sp);
  1874			hdr_insert_head(hdr2, de_t, to_copy);
  1875	
  1876			/* Remove all entries (sp including) from hdr1. */
  1877			used = used1 - to_copy - sp_size;
  1878			memmove(de_t, Add2Ptr(sp, sp_size),
  1879					used - le32_to_cpu(hdr1->de_off));
  1880			hdr1->used = cpu_to_le32(used);
  1881	
  1882			/*
  1883			 * Insert new entry into left or right buffer
  1884			 * (depending on sp <=> new_de).
  1885			 */
  1886			hdr_insert_de(indx,
  1887					(*indx->cmp)(new_de + 1,
  1888					le16_to_cpu(new_de->key_size),
  1889					up_e + 1, le16_to_cpu(up_e->key_size),
  1890					ctx) < 0 ? hdr2 : hdr1,
  1891					new_de, NULL, ctx);
  1892	
  1893			indx_mark_used(indx, ni, new_vbn >> indx->idx2vbn_bits);
  1894	
  1895			indx_write(indx, ni, n1, 0);
  1896			indx_write(indx, ni, n2, 0);
  1897	
  1898			put_indx_node(n2);
  1899	
  1900			/*
  1901			 * We've finished splitting everybody, so we are ready to
  1902			 * insert the promoted entry into the parent.
  1903			 */
  1904			if (!level) {
  1905				/* Insert in root. */
  1906				err = indx_insert_into_root(indx, ni, up_e,
  1907						NULL, ctx, fnd, 0);
  1908			} else {
  1909				/*
  1910				 * The target buffer's parent is another index
  1911				 * buffer. Move to the parent buffer for next
  1912				 * iteration.
  1913				 */
  1914				n1 = fnd->nodes[--level];
> 1915				hrd1 = &n1->index->ihdr;
  1916				new_de = up_e;
  1917				continue;
  1918			}
  1919	
  1920			if (err) {
  1921				/*
  1922				 * Undo critical operations.
  1923				 */
  1924				indx_mark_free(indx, ni,
  1925						new_vbn >> indx->idx2vbn_bits);
  1926				memcpy(hdr1, hdr1_saved, used1);
  1927				indx_write(indx, ni, n1, 0);
  1928			}
  1929		}
  1930	
  1931	out:
  1932		kfree(up_e);
  1933		kfree(hdr1_saved);
  1934	
  1935		return err;
  1936	}
  1937	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

