Return-Path: <linux-kernel+bounces-544670-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EAC93A4E506
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 17:08:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6D404880994
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 15:35:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEF59280A5D;
	Tue,  4 Mar 2025 15:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OeNUlsbb"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1F13280A51
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 15:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741101810; cv=none; b=IXeqGZlKHr0PR5c6MnSIq1276uvxI2Jly1zLb0sIfFmmyvy96L1EyBi7hcNrU3NlY5tV79+WAuvDckLAy/U/qbKusSCMje4cImGhziK0S8pBtJ7KG8hrQJ3CnVYsNwA8KjDq6tjYsRhHPllmojvUk4+DxIcUE10DA3/oiJhbdj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741101810; c=relaxed/simple;
	bh=PZHJoJ/7VWW4g+h9L/cqtrml+/bVKjjoSHX1du9qdjI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=gtp8Ia1dIVyRPE4mR3o5bO41sFvi8BLhigvfDxv7t3JzeTOPDNrpdIQHQl+6QXwqdBD7G/RtiCOdAVGEsIvrGXhq1kotqr40O68+eC6e+v6R9zzbXO2RlwMf/PRhjemJmBhQUreUhApT4K2BhfQEnvuIZS5D9PwfSPq9d6MQJDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OeNUlsbb; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741101808; x=1772637808;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=PZHJoJ/7VWW4g+h9L/cqtrml+/bVKjjoSHX1du9qdjI=;
  b=OeNUlsbb+wtoG3ZZmYJWxACTlWUCpMM1uyT/j/tIM3DiTGdJrV59OrWd
   s0C62R2Z58HefFWMIYKI8X9plfh9WMnF4o2LDujtuN7rWsdYPAVv81jxd
   nNssdnes6fkFoIitwg0oB2ZhgteXywXP8D8FxUkeCLqYAXb/RsX9nCL9o
   xymJ0zLyEhiPcE8O4Xz82Gt+fhvXiZKKT759sDhVgop31pd9+/GGVckC+
   JYL1vqGlGGrdXB0nsBWpHl4m4UZmTkp/17jfzMI5gojPVVUn8W2GvO+zV
   q7HWcN7WC1fIRjXM+2cuWth4vaDyyAtSd0i8bKy/gWPMi2CiyHQ1T2mCL
   Q==;
X-CSE-ConnectionGUID: iJwsYz4yQye6ORD66AjJ/Q==
X-CSE-MsgGUID: 0k2Lrc3NR2aKyn0JJr1TQw==
X-IronPort-AV: E=McAfee;i="6700,10204,11363"; a="41934924"
X-IronPort-AV: E=Sophos;i="6.14,220,1736841600"; 
   d="scan'208";a="41934924"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2025 07:23:28 -0800
X-CSE-ConnectionGUID: rh+4aNFrS9K0k1ypraRd3w==
X-CSE-MsgGUID: tfTQ/j8XSk+2vuzlnfT9pw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,220,1736841600"; 
   d="scan'208";a="118549467"
Received: from lkp-server02.sh.intel.com (HELO 76cde6cc1f07) ([10.239.97.151])
  by fmviesa008.fm.intel.com with ESMTP; 04 Mar 2025 07:23:25 -0800
Received: from kbuild by 76cde6cc1f07 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tpU78-000Jwc-2m;
	Tue, 04 Mar 2025 15:23:22 +0000
Date: Tue, 4 Mar 2025 23:22:32 +0800
From: kernel test robot <lkp@intel.com>
To: Liao Chang <liaochang1@huawei.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Palmer Dabbelt <palmer@rivosinc.com>,
	Li Zhengyu <lizhengyu3@huawei.com>
Subject: kernel/kexec_elf.c:253: warning: Function parameter or struct member
 'elf_info' not described in 'elf_read_phdrs'
Message-ID: <202503042345.rmMbhg9D-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Liao,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   99fa936e8e4f117d62f229003c9799686f74cebc
commit: 6261586e0c91db14c34f894f4bc48f2300cff1d4 RISC-V: Add kexec_file support
date:   2 years, 10 months ago
config: riscv-randconfig-002-20240701 (https://download.01.org/0day-ci/archive/20250304/202503042345.rmMbhg9D-lkp@intel.com/config)
compiler: riscv64-linux-gcc (GCC) 12.4.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250304/202503042345.rmMbhg9D-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202503042345.rmMbhg9D-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> kernel/kexec_elf.c:64: warning: Function parameter or struct member 'ehdr' not described in 'elf_is_ehdr_sane'
>> kernel/kexec_elf.c:186: warning: Function parameter or struct member 'phdr' not described in 'elf_is_phdr_sane'
>> kernel/kexec_elf.c:253: warning: Function parameter or struct member 'buf' not described in 'elf_read_phdrs'
>> kernel/kexec_elf.c:253: warning: Function parameter or struct member 'len' not described in 'elf_read_phdrs'
>> kernel/kexec_elf.c:253: warning: Function parameter or struct member 'elf_info' not described in 'elf_read_phdrs'
>> kernel/kexec_elf.c:320: warning: Function parameter or struct member 'elf_info' not described in 'kexec_free_elf_info'
>> kernel/kexec_elf.c:329: warning: Function parameter or struct member 'buf' not described in 'kexec_build_elf_info'
>> kernel/kexec_elf.c:329: warning: Function parameter or struct member 'len' not described in 'kexec_build_elf_info'
>> kernel/kexec_elf.c:329: warning: Function parameter or struct member 'ehdr' not described in 'kexec_build_elf_info'
>> kernel/kexec_elf.c:329: warning: Function parameter or struct member 'elf_info' not described in 'kexec_build_elf_info'
>> kernel/kexec_elf.c:392: warning: Function parameter or struct member 'image' not described in 'kexec_elf_load'
>> kernel/kexec_elf.c:392: warning: Function parameter or struct member 'ehdr' not described in 'kexec_elf_load'
>> kernel/kexec_elf.c:392: warning: Function parameter or struct member 'elf_info' not described in 'kexec_elf_load'
>> kernel/kexec_elf.c:392: warning: Function parameter or struct member 'kbuf' not described in 'kexec_elf_load'


vim +253 kernel/kexec_elf.c

175fca3bf91a11 Sven Schnelle 2019-08-23   58  
175fca3bf91a11 Sven Schnelle 2019-08-23   59  /**
175fca3bf91a11 Sven Schnelle 2019-08-23   60   * elf_is_ehdr_sane - check that it is safe to use the ELF header
175fca3bf91a11 Sven Schnelle 2019-08-23   61   * @buf_len:	size of the buffer in which the ELF file is loaded.
175fca3bf91a11 Sven Schnelle 2019-08-23   62   */
175fca3bf91a11 Sven Schnelle 2019-08-23   63  static bool elf_is_ehdr_sane(const struct elfhdr *ehdr, size_t buf_len)
175fca3bf91a11 Sven Schnelle 2019-08-23  @64  {
175fca3bf91a11 Sven Schnelle 2019-08-23   65  	if (ehdr->e_phnum > 0 && ehdr->e_phentsize != sizeof(struct elf_phdr)) {
175fca3bf91a11 Sven Schnelle 2019-08-23   66  		pr_debug("Bad program header size.\n");
175fca3bf91a11 Sven Schnelle 2019-08-23   67  		return false;
175fca3bf91a11 Sven Schnelle 2019-08-23   68  	} else if (ehdr->e_shnum > 0 &&
175fca3bf91a11 Sven Schnelle 2019-08-23   69  		   ehdr->e_shentsize != sizeof(struct elf_shdr)) {
175fca3bf91a11 Sven Schnelle 2019-08-23   70  		pr_debug("Bad section header size.\n");
175fca3bf91a11 Sven Schnelle 2019-08-23   71  		return false;
175fca3bf91a11 Sven Schnelle 2019-08-23   72  	} else if (ehdr->e_ident[EI_VERSION] != EV_CURRENT ||
175fca3bf91a11 Sven Schnelle 2019-08-23   73  		   ehdr->e_version != EV_CURRENT) {
175fca3bf91a11 Sven Schnelle 2019-08-23   74  		pr_debug("Unknown ELF version.\n");
175fca3bf91a11 Sven Schnelle 2019-08-23   75  		return false;
175fca3bf91a11 Sven Schnelle 2019-08-23   76  	}
175fca3bf91a11 Sven Schnelle 2019-08-23   77  
175fca3bf91a11 Sven Schnelle 2019-08-23   78  	if (ehdr->e_phoff > 0 && ehdr->e_phnum > 0) {
175fca3bf91a11 Sven Schnelle 2019-08-23   79  		size_t phdr_size;
175fca3bf91a11 Sven Schnelle 2019-08-23   80  
175fca3bf91a11 Sven Schnelle 2019-08-23   81  		/*
175fca3bf91a11 Sven Schnelle 2019-08-23   82  		 * e_phnum is at most 65535 so calculating the size of the
175fca3bf91a11 Sven Schnelle 2019-08-23   83  		 * program header cannot overflow.
175fca3bf91a11 Sven Schnelle 2019-08-23   84  		 */
175fca3bf91a11 Sven Schnelle 2019-08-23   85  		phdr_size = sizeof(struct elf_phdr) * ehdr->e_phnum;
175fca3bf91a11 Sven Schnelle 2019-08-23   86  
175fca3bf91a11 Sven Schnelle 2019-08-23   87  		/* Sanity check the program header table location. */
175fca3bf91a11 Sven Schnelle 2019-08-23   88  		if (ehdr->e_phoff + phdr_size < ehdr->e_phoff) {
175fca3bf91a11 Sven Schnelle 2019-08-23   89  			pr_debug("Program headers at invalid location.\n");
175fca3bf91a11 Sven Schnelle 2019-08-23   90  			return false;
175fca3bf91a11 Sven Schnelle 2019-08-23   91  		} else if (ehdr->e_phoff + phdr_size > buf_len) {
175fca3bf91a11 Sven Schnelle 2019-08-23   92  			pr_debug("Program headers truncated.\n");
175fca3bf91a11 Sven Schnelle 2019-08-23   93  			return false;
175fca3bf91a11 Sven Schnelle 2019-08-23   94  		}
175fca3bf91a11 Sven Schnelle 2019-08-23   95  	}
175fca3bf91a11 Sven Schnelle 2019-08-23   96  
175fca3bf91a11 Sven Schnelle 2019-08-23   97  	if (ehdr->e_shoff > 0 && ehdr->e_shnum > 0) {
175fca3bf91a11 Sven Schnelle 2019-08-23   98  		size_t shdr_size;
175fca3bf91a11 Sven Schnelle 2019-08-23   99  
175fca3bf91a11 Sven Schnelle 2019-08-23  100  		/*
175fca3bf91a11 Sven Schnelle 2019-08-23  101  		 * e_shnum is at most 65536 so calculating
175fca3bf91a11 Sven Schnelle 2019-08-23  102  		 * the size of the section header cannot overflow.
175fca3bf91a11 Sven Schnelle 2019-08-23  103  		 */
175fca3bf91a11 Sven Schnelle 2019-08-23  104  		shdr_size = sizeof(struct elf_shdr) * ehdr->e_shnum;
175fca3bf91a11 Sven Schnelle 2019-08-23  105  
175fca3bf91a11 Sven Schnelle 2019-08-23  106  		/* Sanity check the section header table location. */
175fca3bf91a11 Sven Schnelle 2019-08-23  107  		if (ehdr->e_shoff + shdr_size < ehdr->e_shoff) {
175fca3bf91a11 Sven Schnelle 2019-08-23  108  			pr_debug("Section headers at invalid location.\n");
175fca3bf91a11 Sven Schnelle 2019-08-23  109  			return false;
175fca3bf91a11 Sven Schnelle 2019-08-23  110  		} else if (ehdr->e_shoff + shdr_size > buf_len) {
175fca3bf91a11 Sven Schnelle 2019-08-23  111  			pr_debug("Section headers truncated.\n");
175fca3bf91a11 Sven Schnelle 2019-08-23  112  			return false;
175fca3bf91a11 Sven Schnelle 2019-08-23  113  		}
175fca3bf91a11 Sven Schnelle 2019-08-23  114  	}
175fca3bf91a11 Sven Schnelle 2019-08-23  115  
175fca3bf91a11 Sven Schnelle 2019-08-23  116  	return true;
175fca3bf91a11 Sven Schnelle 2019-08-23  117  }
175fca3bf91a11 Sven Schnelle 2019-08-23  118  
175fca3bf91a11 Sven Schnelle 2019-08-23  119  static int elf_read_ehdr(const char *buf, size_t len, struct elfhdr *ehdr)
175fca3bf91a11 Sven Schnelle 2019-08-23  120  {
175fca3bf91a11 Sven Schnelle 2019-08-23  121  	struct elfhdr *buf_ehdr;
175fca3bf91a11 Sven Schnelle 2019-08-23  122  
175fca3bf91a11 Sven Schnelle 2019-08-23  123  	if (len < sizeof(*buf_ehdr)) {
175fca3bf91a11 Sven Schnelle 2019-08-23  124  		pr_debug("Buffer is too small to hold ELF header.\n");
175fca3bf91a11 Sven Schnelle 2019-08-23  125  		return -ENOEXEC;
175fca3bf91a11 Sven Schnelle 2019-08-23  126  	}
175fca3bf91a11 Sven Schnelle 2019-08-23  127  
175fca3bf91a11 Sven Schnelle 2019-08-23  128  	memset(ehdr, 0, sizeof(*ehdr));
175fca3bf91a11 Sven Schnelle 2019-08-23  129  	memcpy(ehdr->e_ident, buf, sizeof(ehdr->e_ident));
175fca3bf91a11 Sven Schnelle 2019-08-23  130  	if (!elf_is_elf_file(ehdr)) {
175fca3bf91a11 Sven Schnelle 2019-08-23  131  		pr_debug("No ELF header magic.\n");
175fca3bf91a11 Sven Schnelle 2019-08-23  132  		return -ENOEXEC;
175fca3bf91a11 Sven Schnelle 2019-08-23  133  	}
175fca3bf91a11 Sven Schnelle 2019-08-23  134  
175fca3bf91a11 Sven Schnelle 2019-08-23  135  	if (ehdr->e_ident[EI_CLASS] != ELF_CLASS) {
175fca3bf91a11 Sven Schnelle 2019-08-23  136  		pr_debug("Not a supported ELF class.\n");
175fca3bf91a11 Sven Schnelle 2019-08-23  137  		return -ENOEXEC;
175fca3bf91a11 Sven Schnelle 2019-08-23  138  	} else  if (ehdr->e_ident[EI_DATA] != ELFDATA2LSB &&
175fca3bf91a11 Sven Schnelle 2019-08-23  139  		ehdr->e_ident[EI_DATA] != ELFDATA2MSB) {
175fca3bf91a11 Sven Schnelle 2019-08-23  140  		pr_debug("Not a supported ELF data format.\n");
175fca3bf91a11 Sven Schnelle 2019-08-23  141  		return -ENOEXEC;
175fca3bf91a11 Sven Schnelle 2019-08-23  142  	}
175fca3bf91a11 Sven Schnelle 2019-08-23  143  
175fca3bf91a11 Sven Schnelle 2019-08-23  144  	buf_ehdr = (struct elfhdr *) buf;
175fca3bf91a11 Sven Schnelle 2019-08-23  145  	if (elf16_to_cpu(ehdr, buf_ehdr->e_ehsize) != sizeof(*buf_ehdr)) {
175fca3bf91a11 Sven Schnelle 2019-08-23  146  		pr_debug("Bad ELF header size.\n");
175fca3bf91a11 Sven Schnelle 2019-08-23  147  		return -ENOEXEC;
175fca3bf91a11 Sven Schnelle 2019-08-23  148  	}
175fca3bf91a11 Sven Schnelle 2019-08-23  149  
175fca3bf91a11 Sven Schnelle 2019-08-23  150  	ehdr->e_type      = elf16_to_cpu(ehdr, buf_ehdr->e_type);
175fca3bf91a11 Sven Schnelle 2019-08-23  151  	ehdr->e_machine   = elf16_to_cpu(ehdr, buf_ehdr->e_machine);
175fca3bf91a11 Sven Schnelle 2019-08-23  152  	ehdr->e_version   = elf32_to_cpu(ehdr, buf_ehdr->e_version);
175fca3bf91a11 Sven Schnelle 2019-08-23  153  	ehdr->e_flags     = elf32_to_cpu(ehdr, buf_ehdr->e_flags);
175fca3bf91a11 Sven Schnelle 2019-08-23  154  	ehdr->e_phentsize = elf16_to_cpu(ehdr, buf_ehdr->e_phentsize);
175fca3bf91a11 Sven Schnelle 2019-08-23  155  	ehdr->e_phnum     = elf16_to_cpu(ehdr, buf_ehdr->e_phnum);
175fca3bf91a11 Sven Schnelle 2019-08-23  156  	ehdr->e_shentsize = elf16_to_cpu(ehdr, buf_ehdr->e_shentsize);
175fca3bf91a11 Sven Schnelle 2019-08-23  157  	ehdr->e_shnum     = elf16_to_cpu(ehdr, buf_ehdr->e_shnum);
175fca3bf91a11 Sven Schnelle 2019-08-23  158  	ehdr->e_shstrndx  = elf16_to_cpu(ehdr, buf_ehdr->e_shstrndx);
175fca3bf91a11 Sven Schnelle 2019-08-23  159  
ea46a13ebf5366 Sven Schnelle 2019-08-23  160  	switch (ehdr->e_ident[EI_CLASS]) {
ea46a13ebf5366 Sven Schnelle 2019-08-23  161  	case ELFCLASS64:
ea46a13ebf5366 Sven Schnelle 2019-08-23  162  		ehdr->e_entry = elf64_to_cpu(ehdr, buf_ehdr->e_entry);
ea46a13ebf5366 Sven Schnelle 2019-08-23  163  		ehdr->e_phoff = elf64_to_cpu(ehdr, buf_ehdr->e_phoff);
ea46a13ebf5366 Sven Schnelle 2019-08-23  164  		ehdr->e_shoff = elf64_to_cpu(ehdr, buf_ehdr->e_shoff);
ea46a13ebf5366 Sven Schnelle 2019-08-23  165  		break;
ea46a13ebf5366 Sven Schnelle 2019-08-23  166  
ea46a13ebf5366 Sven Schnelle 2019-08-23  167  	case ELFCLASS32:
ea46a13ebf5366 Sven Schnelle 2019-08-23  168  		ehdr->e_entry = elf32_to_cpu(ehdr, buf_ehdr->e_entry);
ea46a13ebf5366 Sven Schnelle 2019-08-23  169  		ehdr->e_phoff = elf32_to_cpu(ehdr, buf_ehdr->e_phoff);
ea46a13ebf5366 Sven Schnelle 2019-08-23  170  		ehdr->e_shoff = elf32_to_cpu(ehdr, buf_ehdr->e_shoff);
ea46a13ebf5366 Sven Schnelle 2019-08-23  171  		break;
ea46a13ebf5366 Sven Schnelle 2019-08-23  172  
ea46a13ebf5366 Sven Schnelle 2019-08-23  173  	default:
ea46a13ebf5366 Sven Schnelle 2019-08-23  174  		pr_debug("Unknown ELF class.\n");
ea46a13ebf5366 Sven Schnelle 2019-08-23  175  		return -EINVAL;
ea46a13ebf5366 Sven Schnelle 2019-08-23  176  	}
ea46a13ebf5366 Sven Schnelle 2019-08-23  177  
175fca3bf91a11 Sven Schnelle 2019-08-23  178  	return elf_is_ehdr_sane(ehdr, len) ? 0 : -ENOEXEC;
175fca3bf91a11 Sven Schnelle 2019-08-23  179  }
175fca3bf91a11 Sven Schnelle 2019-08-23  180  
175fca3bf91a11 Sven Schnelle 2019-08-23  181  /**
175fca3bf91a11 Sven Schnelle 2019-08-23  182   * elf_is_phdr_sane - check that it is safe to use the program header
175fca3bf91a11 Sven Schnelle 2019-08-23  183   * @buf_len:	size of the buffer in which the ELF file is loaded.
175fca3bf91a11 Sven Schnelle 2019-08-23  184   */
175fca3bf91a11 Sven Schnelle 2019-08-23  185  static bool elf_is_phdr_sane(const struct elf_phdr *phdr, size_t buf_len)
175fca3bf91a11 Sven Schnelle 2019-08-23 @186  {
175fca3bf91a11 Sven Schnelle 2019-08-23  187  
175fca3bf91a11 Sven Schnelle 2019-08-23  188  	if (phdr->p_offset + phdr->p_filesz < phdr->p_offset) {
175fca3bf91a11 Sven Schnelle 2019-08-23  189  		pr_debug("ELF segment location wraps around.\n");
175fca3bf91a11 Sven Schnelle 2019-08-23  190  		return false;
175fca3bf91a11 Sven Schnelle 2019-08-23  191  	} else if (phdr->p_offset + phdr->p_filesz > buf_len) {
175fca3bf91a11 Sven Schnelle 2019-08-23  192  		pr_debug("ELF segment not in file.\n");
175fca3bf91a11 Sven Schnelle 2019-08-23  193  		return false;
175fca3bf91a11 Sven Schnelle 2019-08-23  194  	} else if (phdr->p_paddr + phdr->p_memsz < phdr->p_paddr) {
175fca3bf91a11 Sven Schnelle 2019-08-23  195  		pr_debug("ELF segment address wraps around.\n");
175fca3bf91a11 Sven Schnelle 2019-08-23  196  		return false;
175fca3bf91a11 Sven Schnelle 2019-08-23  197  	}
175fca3bf91a11 Sven Schnelle 2019-08-23  198  
175fca3bf91a11 Sven Schnelle 2019-08-23  199  	return true;
175fca3bf91a11 Sven Schnelle 2019-08-23  200  }
175fca3bf91a11 Sven Schnelle 2019-08-23  201  
175fca3bf91a11 Sven Schnelle 2019-08-23  202  static int elf_read_phdr(const char *buf, size_t len,
175fca3bf91a11 Sven Schnelle 2019-08-23  203  			 struct kexec_elf_info *elf_info,
175fca3bf91a11 Sven Schnelle 2019-08-23  204  			 int idx)
175fca3bf91a11 Sven Schnelle 2019-08-23  205  {
175fca3bf91a11 Sven Schnelle 2019-08-23  206  	/* Override the const in proghdrs, we are the ones doing the loading. */
175fca3bf91a11 Sven Schnelle 2019-08-23  207  	struct elf_phdr *phdr = (struct elf_phdr *) &elf_info->proghdrs[idx];
ea46a13ebf5366 Sven Schnelle 2019-08-23  208  	const struct elfhdr *ehdr = elf_info->ehdr;
175fca3bf91a11 Sven Schnelle 2019-08-23  209  	const char *pbuf;
175fca3bf91a11 Sven Schnelle 2019-08-23  210  	struct elf_phdr *buf_phdr;
175fca3bf91a11 Sven Schnelle 2019-08-23  211  
175fca3bf91a11 Sven Schnelle 2019-08-23  212  	pbuf = buf + elf_info->ehdr->e_phoff + (idx * sizeof(*buf_phdr));
175fca3bf91a11 Sven Schnelle 2019-08-23  213  	buf_phdr = (struct elf_phdr *) pbuf;
175fca3bf91a11 Sven Schnelle 2019-08-23  214  
175fca3bf91a11 Sven Schnelle 2019-08-23  215  	phdr->p_type   = elf32_to_cpu(elf_info->ehdr, buf_phdr->p_type);
175fca3bf91a11 Sven Schnelle 2019-08-23  216  	phdr->p_flags  = elf32_to_cpu(elf_info->ehdr, buf_phdr->p_flags);
175fca3bf91a11 Sven Schnelle 2019-08-23  217  
ea46a13ebf5366 Sven Schnelle 2019-08-23  218  	switch (ehdr->e_ident[EI_CLASS]) {
ea46a13ebf5366 Sven Schnelle 2019-08-23  219  	case ELFCLASS64:
ea46a13ebf5366 Sven Schnelle 2019-08-23  220  		phdr->p_offset = elf64_to_cpu(ehdr, buf_phdr->p_offset);
ea46a13ebf5366 Sven Schnelle 2019-08-23  221  		phdr->p_paddr  = elf64_to_cpu(ehdr, buf_phdr->p_paddr);
ea46a13ebf5366 Sven Schnelle 2019-08-23  222  		phdr->p_vaddr  = elf64_to_cpu(ehdr, buf_phdr->p_vaddr);
ea46a13ebf5366 Sven Schnelle 2019-08-23  223  		phdr->p_filesz = elf64_to_cpu(ehdr, buf_phdr->p_filesz);
ea46a13ebf5366 Sven Schnelle 2019-08-23  224  		phdr->p_memsz  = elf64_to_cpu(ehdr, buf_phdr->p_memsz);
ea46a13ebf5366 Sven Schnelle 2019-08-23  225  		phdr->p_align  = elf64_to_cpu(ehdr, buf_phdr->p_align);
ea46a13ebf5366 Sven Schnelle 2019-08-23  226  		break;
ea46a13ebf5366 Sven Schnelle 2019-08-23  227  
ea46a13ebf5366 Sven Schnelle 2019-08-23  228  	case ELFCLASS32:
ea46a13ebf5366 Sven Schnelle 2019-08-23  229  		phdr->p_offset = elf32_to_cpu(ehdr, buf_phdr->p_offset);
ea46a13ebf5366 Sven Schnelle 2019-08-23  230  		phdr->p_paddr  = elf32_to_cpu(ehdr, buf_phdr->p_paddr);
ea46a13ebf5366 Sven Schnelle 2019-08-23  231  		phdr->p_vaddr  = elf32_to_cpu(ehdr, buf_phdr->p_vaddr);
ea46a13ebf5366 Sven Schnelle 2019-08-23  232  		phdr->p_filesz = elf32_to_cpu(ehdr, buf_phdr->p_filesz);
ea46a13ebf5366 Sven Schnelle 2019-08-23  233  		phdr->p_memsz  = elf32_to_cpu(ehdr, buf_phdr->p_memsz);
ea46a13ebf5366 Sven Schnelle 2019-08-23  234  		phdr->p_align  = elf32_to_cpu(ehdr, buf_phdr->p_align);
ea46a13ebf5366 Sven Schnelle 2019-08-23  235  		break;
ea46a13ebf5366 Sven Schnelle 2019-08-23  236  
ea46a13ebf5366 Sven Schnelle 2019-08-23  237  	default:
ea46a13ebf5366 Sven Schnelle 2019-08-23  238  		pr_debug("Unknown ELF class.\n");
ea46a13ebf5366 Sven Schnelle 2019-08-23  239  		return -EINVAL;
ea46a13ebf5366 Sven Schnelle 2019-08-23  240  	}
175fca3bf91a11 Sven Schnelle 2019-08-23  241  
175fca3bf91a11 Sven Schnelle 2019-08-23  242  	return elf_is_phdr_sane(phdr, len) ? 0 : -ENOEXEC;
175fca3bf91a11 Sven Schnelle 2019-08-23  243  }
175fca3bf91a11 Sven Schnelle 2019-08-23  244  
175fca3bf91a11 Sven Schnelle 2019-08-23  245  /**
175fca3bf91a11 Sven Schnelle 2019-08-23  246   * elf_read_phdrs - read the program headers from the buffer
175fca3bf91a11 Sven Schnelle 2019-08-23  247   *
175fca3bf91a11 Sven Schnelle 2019-08-23  248   * This function assumes that the program header table was checked for sanity.
175fca3bf91a11 Sven Schnelle 2019-08-23  249   * Use elf_is_ehdr_sane() if it wasn't.
175fca3bf91a11 Sven Schnelle 2019-08-23  250   */
175fca3bf91a11 Sven Schnelle 2019-08-23  251  static int elf_read_phdrs(const char *buf, size_t len,
175fca3bf91a11 Sven Schnelle 2019-08-23  252  			  struct kexec_elf_info *elf_info)
175fca3bf91a11 Sven Schnelle 2019-08-23 @253  {
175fca3bf91a11 Sven Schnelle 2019-08-23  254  	size_t phdr_size, i;
175fca3bf91a11 Sven Schnelle 2019-08-23  255  	const struct elfhdr *ehdr = elf_info->ehdr;
175fca3bf91a11 Sven Schnelle 2019-08-23  256  
175fca3bf91a11 Sven Schnelle 2019-08-23  257  	/*
175fca3bf91a11 Sven Schnelle 2019-08-23  258  	 * e_phnum is at most 65535 so calculating the size of the
175fca3bf91a11 Sven Schnelle 2019-08-23  259  	 * program header cannot overflow.
175fca3bf91a11 Sven Schnelle 2019-08-23  260  	 */
175fca3bf91a11 Sven Schnelle 2019-08-23  261  	phdr_size = sizeof(struct elf_phdr) * ehdr->e_phnum;
175fca3bf91a11 Sven Schnelle 2019-08-23  262  
175fca3bf91a11 Sven Schnelle 2019-08-23  263  	elf_info->proghdrs = kzalloc(phdr_size, GFP_KERNEL);
175fca3bf91a11 Sven Schnelle 2019-08-23  264  	if (!elf_info->proghdrs)
175fca3bf91a11 Sven Schnelle 2019-08-23  265  		return -ENOMEM;
175fca3bf91a11 Sven Schnelle 2019-08-23  266  
175fca3bf91a11 Sven Schnelle 2019-08-23  267  	for (i = 0; i < ehdr->e_phnum; i++) {
175fca3bf91a11 Sven Schnelle 2019-08-23  268  		int ret;
175fca3bf91a11 Sven Schnelle 2019-08-23  269  
175fca3bf91a11 Sven Schnelle 2019-08-23  270  		ret = elf_read_phdr(buf, len, elf_info, i);
175fca3bf91a11 Sven Schnelle 2019-08-23  271  		if (ret) {
175fca3bf91a11 Sven Schnelle 2019-08-23  272  			kfree(elf_info->proghdrs);
175fca3bf91a11 Sven Schnelle 2019-08-23  273  			elf_info->proghdrs = NULL;
175fca3bf91a11 Sven Schnelle 2019-08-23  274  			return ret;
175fca3bf91a11 Sven Schnelle 2019-08-23  275  		}
175fca3bf91a11 Sven Schnelle 2019-08-23  276  	}
175fca3bf91a11 Sven Schnelle 2019-08-23  277  
175fca3bf91a11 Sven Schnelle 2019-08-23  278  	return 0;
175fca3bf91a11 Sven Schnelle 2019-08-23  279  }
175fca3bf91a11 Sven Schnelle 2019-08-23  280  
175fca3bf91a11 Sven Schnelle 2019-08-23  281  /**
175fca3bf91a11 Sven Schnelle 2019-08-23  282   * elf_read_from_buffer - read ELF file and sets up ELF header and ELF info
175fca3bf91a11 Sven Schnelle 2019-08-23  283   * @buf:	Buffer to read ELF file from.
175fca3bf91a11 Sven Schnelle 2019-08-23  284   * @len:	Size of @buf.
175fca3bf91a11 Sven Schnelle 2019-08-23  285   * @ehdr:	Pointer to existing struct which will be populated.
175fca3bf91a11 Sven Schnelle 2019-08-23  286   * @elf_info:	Pointer to existing struct which will be populated.
175fca3bf91a11 Sven Schnelle 2019-08-23  287   *
175fca3bf91a11 Sven Schnelle 2019-08-23  288   * This function allows reading ELF files with different byte order than
175fca3bf91a11 Sven Schnelle 2019-08-23  289   * the kernel, byte-swapping the fields as needed.
175fca3bf91a11 Sven Schnelle 2019-08-23  290   *
175fca3bf91a11 Sven Schnelle 2019-08-23  291   * Return:
175fca3bf91a11 Sven Schnelle 2019-08-23  292   * On success returns 0, and the caller should call
175fca3bf91a11 Sven Schnelle 2019-08-23  293   * kexec_free_elf_info(elf_info) to free the memory allocated for the section
175fca3bf91a11 Sven Schnelle 2019-08-23  294   * and program headers.
175fca3bf91a11 Sven Schnelle 2019-08-23  295   */
175fca3bf91a11 Sven Schnelle 2019-08-23  296  static int elf_read_from_buffer(const char *buf, size_t len,
175fca3bf91a11 Sven Schnelle 2019-08-23  297  				struct elfhdr *ehdr,
175fca3bf91a11 Sven Schnelle 2019-08-23  298  				struct kexec_elf_info *elf_info)
175fca3bf91a11 Sven Schnelle 2019-08-23  299  {
175fca3bf91a11 Sven Schnelle 2019-08-23  300  	int ret;
175fca3bf91a11 Sven Schnelle 2019-08-23  301  
175fca3bf91a11 Sven Schnelle 2019-08-23  302  	ret = elf_read_ehdr(buf, len, ehdr);
175fca3bf91a11 Sven Schnelle 2019-08-23  303  	if (ret)
175fca3bf91a11 Sven Schnelle 2019-08-23  304  		return ret;
175fca3bf91a11 Sven Schnelle 2019-08-23  305  
175fca3bf91a11 Sven Schnelle 2019-08-23  306  	elf_info->buffer = buf;
175fca3bf91a11 Sven Schnelle 2019-08-23  307  	elf_info->ehdr = ehdr;
175fca3bf91a11 Sven Schnelle 2019-08-23  308  	if (ehdr->e_phoff > 0 && ehdr->e_phnum > 0) {
175fca3bf91a11 Sven Schnelle 2019-08-23  309  		ret = elf_read_phdrs(buf, len, elf_info);
175fca3bf91a11 Sven Schnelle 2019-08-23  310  		if (ret)
175fca3bf91a11 Sven Schnelle 2019-08-23  311  			return ret;
175fca3bf91a11 Sven Schnelle 2019-08-23  312  	}
175fca3bf91a11 Sven Schnelle 2019-08-23  313  	return 0;
175fca3bf91a11 Sven Schnelle 2019-08-23  314  }
175fca3bf91a11 Sven Schnelle 2019-08-23  315  
175fca3bf91a11 Sven Schnelle 2019-08-23  316  /**
175fca3bf91a11 Sven Schnelle 2019-08-23  317   * kexec_free_elf_info - free memory allocated by elf_read_from_buffer
175fca3bf91a11 Sven Schnelle 2019-08-23  318   */
175fca3bf91a11 Sven Schnelle 2019-08-23  319  void kexec_free_elf_info(struct kexec_elf_info *elf_info)
175fca3bf91a11 Sven Schnelle 2019-08-23 @320  {
175fca3bf91a11 Sven Schnelle 2019-08-23  321  	kfree(elf_info->proghdrs);
175fca3bf91a11 Sven Schnelle 2019-08-23  322  	memset(elf_info, 0, sizeof(*elf_info));
175fca3bf91a11 Sven Schnelle 2019-08-23  323  }
175fca3bf91a11 Sven Schnelle 2019-08-23  324  /**
175fca3bf91a11 Sven Schnelle 2019-08-23  325   * kexec_build_elf_info - read ELF executable and check that we can use it
175fca3bf91a11 Sven Schnelle 2019-08-23  326   */
175fca3bf91a11 Sven Schnelle 2019-08-23  327  int kexec_build_elf_info(const char *buf, size_t len, struct elfhdr *ehdr,
175fca3bf91a11 Sven Schnelle 2019-08-23  328  			       struct kexec_elf_info *elf_info)
175fca3bf91a11 Sven Schnelle 2019-08-23 @329  {
175fca3bf91a11 Sven Schnelle 2019-08-23  330  	int i;
175fca3bf91a11 Sven Schnelle 2019-08-23  331  	int ret;
175fca3bf91a11 Sven Schnelle 2019-08-23  332  
175fca3bf91a11 Sven Schnelle 2019-08-23  333  	ret = elf_read_from_buffer(buf, len, ehdr, elf_info);
175fca3bf91a11 Sven Schnelle 2019-08-23  334  	if (ret)
175fca3bf91a11 Sven Schnelle 2019-08-23  335  		return ret;
175fca3bf91a11 Sven Schnelle 2019-08-23  336  
175fca3bf91a11 Sven Schnelle 2019-08-23  337  	/* Big endian vmlinux has type ET_DYN. */
175fca3bf91a11 Sven Schnelle 2019-08-23  338  	if (ehdr->e_type != ET_EXEC && ehdr->e_type != ET_DYN) {
175fca3bf91a11 Sven Schnelle 2019-08-23  339  		pr_err("Not an ELF executable.\n");
175fca3bf91a11 Sven Schnelle 2019-08-23  340  		goto error;
175fca3bf91a11 Sven Schnelle 2019-08-23  341  	} else if (!elf_info->proghdrs) {
175fca3bf91a11 Sven Schnelle 2019-08-23  342  		pr_err("No ELF program header.\n");
175fca3bf91a11 Sven Schnelle 2019-08-23  343  		goto error;
175fca3bf91a11 Sven Schnelle 2019-08-23  344  	}
175fca3bf91a11 Sven Schnelle 2019-08-23  345  
175fca3bf91a11 Sven Schnelle 2019-08-23  346  	for (i = 0; i < ehdr->e_phnum; i++) {
175fca3bf91a11 Sven Schnelle 2019-08-23  347  		/*
175fca3bf91a11 Sven Schnelle 2019-08-23  348  		 * Kexec does not support loading interpreters.
175fca3bf91a11 Sven Schnelle 2019-08-23  349  		 * In addition this check keeps us from attempting
175fca3bf91a11 Sven Schnelle 2019-08-23  350  		 * to kexec ordinay executables.
175fca3bf91a11 Sven Schnelle 2019-08-23  351  		 */
175fca3bf91a11 Sven Schnelle 2019-08-23  352  		if (elf_info->proghdrs[i].p_type == PT_INTERP) {
175fca3bf91a11 Sven Schnelle 2019-08-23  353  			pr_err("Requires an ELF interpreter.\n");
175fca3bf91a11 Sven Schnelle 2019-08-23  354  			goto error;
175fca3bf91a11 Sven Schnelle 2019-08-23  355  		}
175fca3bf91a11 Sven Schnelle 2019-08-23  356  	}
175fca3bf91a11 Sven Schnelle 2019-08-23  357  
175fca3bf91a11 Sven Schnelle 2019-08-23  358  	return 0;
175fca3bf91a11 Sven Schnelle 2019-08-23  359  error:
175fca3bf91a11 Sven Schnelle 2019-08-23  360  	kexec_free_elf_info(elf_info);
175fca3bf91a11 Sven Schnelle 2019-08-23  361  	return -ENOEXEC;
175fca3bf91a11 Sven Schnelle 2019-08-23  362  }
175fca3bf91a11 Sven Schnelle 2019-08-23  363  
175fca3bf91a11 Sven Schnelle 2019-08-23  364  
175fca3bf91a11 Sven Schnelle 2019-08-23  365  int kexec_elf_probe(const char *buf, unsigned long len)
175fca3bf91a11 Sven Schnelle 2019-08-23  366  {
175fca3bf91a11 Sven Schnelle 2019-08-23  367  	struct elfhdr ehdr;
175fca3bf91a11 Sven Schnelle 2019-08-23  368  	struct kexec_elf_info elf_info;
175fca3bf91a11 Sven Schnelle 2019-08-23  369  	int ret;
175fca3bf91a11 Sven Schnelle 2019-08-23  370  
175fca3bf91a11 Sven Schnelle 2019-08-23  371  	ret = kexec_build_elf_info(buf, len, &ehdr, &elf_info);
175fca3bf91a11 Sven Schnelle 2019-08-23  372  	if (ret)
175fca3bf91a11 Sven Schnelle 2019-08-23  373  		return ret;
175fca3bf91a11 Sven Schnelle 2019-08-23  374  
175fca3bf91a11 Sven Schnelle 2019-08-23  375  	kexec_free_elf_info(&elf_info);
175fca3bf91a11 Sven Schnelle 2019-08-23  376  
175fca3bf91a11 Sven Schnelle 2019-08-23  377  	return elf_check_arch(&ehdr) ? 0 : -ENOEXEC;
175fca3bf91a11 Sven Schnelle 2019-08-23  378  }
175fca3bf91a11 Sven Schnelle 2019-08-23  379  
175fca3bf91a11 Sven Schnelle 2019-08-23  380  /**
175fca3bf91a11 Sven Schnelle 2019-08-23  381   * kexec_elf_load - load ELF executable image
175fca3bf91a11 Sven Schnelle 2019-08-23  382   * @lowest_load_addr:	On return, will be the address where the first PT_LOAD
175fca3bf91a11 Sven Schnelle 2019-08-23  383   *			section will be loaded in memory.
175fca3bf91a11 Sven Schnelle 2019-08-23  384   *
175fca3bf91a11 Sven Schnelle 2019-08-23  385   * Return:
175fca3bf91a11 Sven Schnelle 2019-08-23  386   * 0 on success, negative value on failure.
175fca3bf91a11 Sven Schnelle 2019-08-23  387   */
175fca3bf91a11 Sven Schnelle 2019-08-23  388  int kexec_elf_load(struct kimage *image, struct elfhdr *ehdr,
175fca3bf91a11 Sven Schnelle 2019-08-23  389  			 struct kexec_elf_info *elf_info,
175fca3bf91a11 Sven Schnelle 2019-08-23  390  			 struct kexec_buf *kbuf,
175fca3bf91a11 Sven Schnelle 2019-08-23  391  			 unsigned long *lowest_load_addr)
175fca3bf91a11 Sven Schnelle 2019-08-23 @392  {

:::::: The code at line 253 was first introduced by commit
:::::: 175fca3bf91a1111b7e46f6655666640556b9059 kexec: add KEXEC_ELF

:::::: TO: Sven Schnelle <svens@stackframe.org>
:::::: CC: Helge Deller <deller@gmx.de>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

