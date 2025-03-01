Return-Path: <linux-kernel+bounces-540088-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A0AFA4AD80
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Mar 2025 20:24:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AB6A21894665
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Mar 2025 19:24:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57F7E1E520E;
	Sat,  1 Mar 2025 19:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fRLh7aSF"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECA8D1BD9C7
	for <linux-kernel@vger.kernel.org>; Sat,  1 Mar 2025 19:24:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740857044; cv=none; b=mkvILzwMfZaJSEQUnb6HTiaA+BrIN5ghJjOF+1Zpl/Tna3A0I0fREppANAdd5pLuhGzDaZk0+V80JB9uUh4VuJM9j/kkQdtOmwFsvUcHu5V0snL96Aeez3DZKvfW+jMvD8m7zvDDQgCAn7fgJ5GKNlCvwER6dTa6fPG9WtiBQsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740857044; c=relaxed/simple;
	bh=luWs7wPzy832WByvbfgN79yEzfBwF4tpzpLI0asBZ8A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Wct9Axx1e1sImN7DM6yMgkshlyS7h/dCXTUgLMh9ZSIHdbMjsYeFtN3yuYGw6yObygggDWJxDZhCd6BEoZy/jkL+u4cMKZD9TTdVnabMk552bljNGqo0eYSpNwiOc4CTE4JCZeTJOCRay5UCd2KvA903gQ51B8pYILmE3CWSKvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fRLh7aSF; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740857042; x=1772393042;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=luWs7wPzy832WByvbfgN79yEzfBwF4tpzpLI0asBZ8A=;
  b=fRLh7aSFQRiZfgOvJzIhp6IzzvEc/eDHjs3r3YsUXuZkiWSGCWgTDUiE
   LcWpDQbbRIyiVLMwdGtSrAGJIE/d6oE08D3IN+pxPjjIRpjSoWFXXmjJz
   RqYUKSsz99d/AqMhEUkCbv7HCDhssdoyvpiYLdSgPstvvI/PbA2gyQopp
   8k38tpR7CnTQJMVtgRXTOGm66cEWI0ZKAMS9AOS7YaaNo6zcx9fDjNLnW
   hdPe5noKwL16diTV+mYDd3sKMSPYH7Us6yvdAOgW4NiED2JySwJ5jXD4c
   5fliRvcAeWUWr9zTLla6xO63xHeUl6XdATUWnD9eML8NOGasFnjxjCNki
   Q==;
X-CSE-ConnectionGUID: 3ZrE0NFQToydoiUmERkCBQ==
X-CSE-MsgGUID: pJTR+bVzTKu7YA5KAVnhIg==
X-IronPort-AV: E=McAfee;i="6700,10204,11360"; a="52410488"
X-IronPort-AV: E=Sophos;i="6.13,326,1732608000"; 
   d="scan'208";a="52410488"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2025 11:24:01 -0800
X-CSE-ConnectionGUID: 0fC+S3hbQ4iJk0yjnlGMUQ==
X-CSE-MsgGUID: CEcRVnjtQ3mEEiL12Yhxew==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="118157777"
Received: from lkp-server02.sh.intel.com (HELO 76cde6cc1f07) ([10.239.97.151])
  by orviesa007.jf.intel.com with ESMTP; 01 Mar 2025 11:23:58 -0800
Received: from kbuild by 76cde6cc1f07 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1toSPm-000GbS-03;
	Sat, 01 Mar 2025 19:22:50 +0000
Date: Sun, 2 Mar 2025 03:21:49 +0800
From: kernel test robot <lkp@intel.com>
To: Xi Ruoyao <xry111@xry111.site>, "Jason A. Donenfeld" <Jason@zx2c4.com>,
	Thomas =?iso-8859-1?Q?Wei=DFschuh?= <thomas.weissschuh@linutronix.de>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>, Guo Ren <guoren@kernel.org>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
	Xi Ruoyao <xry111@xry111.site>
Subject: Re: [PATCH] RISC-V: vDSO: Wire up getrandom() vDSO implementation
Message-ID: <202503020317.POudjwvT-lkp@intel.com>
References: <20250224122541.65045-1-xry111@xry111.site>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250224122541.65045-1-xry111@xry111.site>

Hi Xi,

kernel test robot noticed the following build errors:

[auto build test ERROR on crng-random/master]
[also build test ERROR on shuah-kselftest/next shuah-kselftest/fixes linus/master v6.14-rc4 next-20250228]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Xi-Ruoyao/RISC-V-vDSO-Wire-up-getrandom-vDSO-implementation/20250224-203232
base:   https://git.kernel.org/pub/scm/linux/kernel/git/crng/random.git master
patch link:    https://lore.kernel.org/r/20250224122541.65045-1-xry111%40xry111.site
patch subject: [PATCH] RISC-V: vDSO: Wire up getrandom() vDSO implementation
config: riscv-randconfig-001-20250302 (https://download.01.org/0day-ci/archive/20250302/202503020317.POudjwvT-lkp@intel.com/config)
compiler: clang version 21.0.0git (https://github.com/llvm/llvm-project 14170b16028c087ca154878f5ed93d3089a965c6)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250302/202503020317.POudjwvT-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202503020317.POudjwvT-lkp@intel.com/

All errors (new ones prefixed by >>):

>> arch/riscv/kernel/vdso/vgetrandom-chacha.S:92:2: error: instruction requires the following: RV64I Base Instruction Set
    ld t2, (a2)
    ^
>> arch/riscv/kernel/vdso/vgetrandom-chacha.S:118:15: error: immediate must be an integer in the range [0, 31]
    srli a6, t2, 32
                 ^
>> <instantiation>:1:1: error: instruction requires the following: RV64I Base Instruction Set
   addw s0, s0, s4
   ^
   arch/riscv/kernel/vdso/vgetrandom-chacha.S:127:2: note: while in macro instantiation
    OP_4REG addw s0, s1, s2, s3, s4, s5, s6, s7
    ^
   <instantiation>:2:2: error: instruction requires the following: RV64I Base Instruction Set
    addw s1, s1, s5
    ^
   arch/riscv/kernel/vdso/vgetrandom-chacha.S:127:2: note: while in macro instantiation
    OP_4REG addw s0, s1, s2, s3, s4, s5, s6, s7
    ^
   <instantiation>:3:2: error: instruction requires the following: RV64I Base Instruction Set
    addw s2, s2, s6
    ^
   arch/riscv/kernel/vdso/vgetrandom-chacha.S:127:2: note: while in macro instantiation
    OP_4REG addw s0, s1, s2, s3, s4, s5, s6, s7
    ^
   <instantiation>:4:2: error: instruction requires the following: RV64I Base Instruction Set
    addw s3, s3, s7
    ^
   arch/riscv/kernel/vdso/vgetrandom-chacha.S:127:2: note: while in macro instantiation
    OP_4REG addw s0, s1, s2, s3, s4, s5, s6, s7
    ^
>> <instantiation>:1:1: error: instruction requires the following: RV64I Base Instruction Set
   slliw t0, a5, 32 - 16
   ^
   <instantiation>:1:1: note: while in macro instantiation
   ROTRI a5, a5, 16
   ^
   arch/riscv/kernel/vdso/vgetrandom-chacha.S:129:2: note: while in macro instantiation
    OP_4REG ROTRI a5, a6, a7, t1, 16, 16, 16, 16
    ^
   <instantiation>:2:2: error: instruction requires the following: RV64I Base Instruction Set
    srliw a5, a5, 16
    ^
   <instantiation>:1:1: note: while in macro instantiation
   ROTRI a5, a5, 16
   ^
   arch/riscv/kernel/vdso/vgetrandom-chacha.S:129:2: note: while in macro instantiation
    OP_4REG ROTRI a5, a6, a7, t1, 16, 16, 16, 16
    ^
>> <instantiation>:1:1: error: instruction requires the following: RV64I Base Instruction Set
   slliw t0, a6, 32 - 16
   ^
   <instantiation>:2:2: note: while in macro instantiation
    ROTRI a6, a6, 16
    ^
   arch/riscv/kernel/vdso/vgetrandom-chacha.S:129:2: note: while in macro instantiation
    OP_4REG ROTRI a5, a6, a7, t1, 16, 16, 16, 16
    ^
   <instantiation>:2:2: error: instruction requires the following: RV64I Base Instruction Set
    srliw a6, a6, 16
    ^
   <instantiation>:2:2: note: while in macro instantiation
    ROTRI a6, a6, 16
    ^
   arch/riscv/kernel/vdso/vgetrandom-chacha.S:129:2: note: while in macro instantiation
    OP_4REG ROTRI a5, a6, a7, t1, 16, 16, 16, 16
    ^
>> <instantiation>:1:1: error: instruction requires the following: RV64I Base Instruction Set
   slliw t0, a7, 32 - 16
   ^
   <instantiation>:3:2: note: while in macro instantiation
    ROTRI a7, a7, 16
    ^
   arch/riscv/kernel/vdso/vgetrandom-chacha.S:129:2: note: while in macro instantiation
    OP_4REG ROTRI a5, a6, a7, t1, 16, 16, 16, 16
    ^
   <instantiation>:2:2: error: instruction requires the following: RV64I Base Instruction Set
    srliw a7, a7, 16
    ^
   <instantiation>:3:2: note: while in macro instantiation
    ROTRI a7, a7, 16
    ^
   arch/riscv/kernel/vdso/vgetrandom-chacha.S:129:2: note: while in macro instantiation
    OP_4REG ROTRI a5, a6, a7, t1, 16, 16, 16, 16
    ^
>> <instantiation>:1:1: error: instruction requires the following: RV64I Base Instruction Set
   slliw t0, t1, 32 - 16
   ^
   <instantiation>:4:2: note: while in macro instantiation
    ROTRI t1, t1, 16
    ^
   arch/riscv/kernel/vdso/vgetrandom-chacha.S:129:2: note: while in macro instantiation
    OP_4REG ROTRI a5, a6, a7, t1, 16, 16, 16, 16
    ^
   <instantiation>:2:2: error: instruction requires the following: RV64I Base Instruction Set
    srliw t1, t1, 16
    ^
   <instantiation>:4:2: note: while in macro instantiation
    ROTRI t1, t1, 16
    ^
   arch/riscv/kernel/vdso/vgetrandom-chacha.S:129:2: note: while in macro instantiation
    OP_4REG ROTRI a5, a6, a7, t1, 16, 16, 16, 16
    ^
>> <instantiation>:1:1: error: instruction requires the following: RV64I Base Instruction Set
   addw s8, s8, a5
   ^
   arch/riscv/kernel/vdso/vgetrandom-chacha.S:131:2: note: while in macro instantiation
    OP_4REG addw s8, s9, s10, s11, a5, a6, a7, t1
    ^
   <instantiation>:2:2: error: instruction requires the following: RV64I Base Instruction Set
    addw s9, s9, a6
    ^
   arch/riscv/kernel/vdso/vgetrandom-chacha.S:131:2: note: while in macro instantiation
    OP_4REG addw s8, s9, s10, s11, a5, a6, a7, t1
    ^
   <instantiation>:3:2: error: instruction requires the following: RV64I Base Instruction Set
    addw s10, s10, a7
    ^
   arch/riscv/kernel/vdso/vgetrandom-chacha.S:131:2: note: while in macro instantiation
    OP_4REG addw s8, s9, s10, s11, a5, a6, a7, t1
    ^
   <instantiation>:4:2: error: instruction requires the following: RV64I Base Instruction Set
    addw s11, s11, t1
    ^
   arch/riscv/kernel/vdso/vgetrandom-chacha.S:131:2: note: while in macro instantiation
    OP_4REG addw s8, s9, s10, s11, a5, a6, a7, t1
    ^
>> <instantiation>:1:1: error: instruction requires the following: RV64I Base Instruction Set
   slliw t0, s4, 32 - 20
   ^
   <instantiation>:1:1: note: while in macro instantiation
   ROTRI s4, s4, 20
   ^
   arch/riscv/kernel/vdso/vgetrandom-chacha.S:133:2: note: while in macro instantiation
    OP_4REG ROTRI s4, s5, s6, s7, 20, 20, 20, 20
    ^
   <instantiation>:2:2: error: instruction requires the following: RV64I Base Instruction Set
    srliw s4, s4, 20
    ^
   <instantiation>:1:1: note: while in macro instantiation
   ROTRI s4, s4, 20
   ^
   arch/riscv/kernel/vdso/vgetrandom-chacha.S:133:2: note: while in macro instantiation
    OP_4REG ROTRI s4, s5, s6, s7, 20, 20, 20, 20
    ^
>> <instantiation>:1:1: error: instruction requires the following: RV64I Base Instruction Set
   slliw t0, s5, 32 - 20
   ^
   <instantiation>:2:2: note: while in macro instantiation
    ROTRI s5, s5, 20
    ^
   arch/riscv/kernel/vdso/vgetrandom-chacha.S:133:2: note: while in macro instantiation
    OP_4REG ROTRI s4, s5, s6, s7, 20, 20, 20, 20
    ^
   <instantiation>:2:2: error: instruction requires the following: RV64I Base Instruction Set
    srliw s5, s5, 20
    ^
   <instantiation>:2:2: note: while in macro instantiation
    ROTRI s5, s5, 20
    ^
   arch/riscv/kernel/vdso/vgetrandom-chacha.S:133:2: note: while in macro instantiation
    OP_4REG ROTRI s4, s5, s6, s7, 20, 20, 20, 20
    ^
>> <instantiation>:1:1: error: instruction requires the following: RV64I Base Instruction Set
   slliw t0, s6, 32 - 20
   ^
   <instantiation>:3:2: note: while in macro instantiation
    ROTRI s6, s6, 20
    ^
   arch/riscv/kernel/vdso/vgetrandom-chacha.S:133:2: note: while in macro instantiation
    OP_4REG ROTRI s4, s5, s6, s7, 20, 20, 20, 20
    ^
   <instantiation>:2:2: error: instruction requires the following: RV64I Base Instruction Set
    srliw s6, s6, 20
    ^
   <instantiation>:3:2: note: while in macro instantiation
    ROTRI s6, s6, 20
    ^
   arch/riscv/kernel/vdso/vgetrandom-chacha.S:133:2: note: while in macro instantiation
    OP_4REG ROTRI s4, s5, s6, s7, 20, 20, 20, 20
    ^
>> <instantiation>:1:1: error: instruction requires the following: RV64I Base Instruction Set
   slliw t0, s7, 32 - 20
   ^
   <instantiation>:4:2: note: while in macro instantiation
    ROTRI s7, s7, 20
    ^
   arch/riscv/kernel/vdso/vgetrandom-chacha.S:133:2: note: while in macro instantiation
    OP_4REG ROTRI s4, s5, s6, s7, 20, 20, 20, 20
    ^
   <instantiation>:2:2: error: instruction requires the following: RV64I Base Instruction Set
    srliw s7, s7, 20
    ^
   <instantiation>:4:2: note: while in macro instantiation
    ROTRI s7, s7, 20
    ^
   arch/riscv/kernel/vdso/vgetrandom-chacha.S:133:2: note: while in macro instantiation
    OP_4REG ROTRI s4, s5, s6, s7, 20, 20, 20, 20
    ^
>> <instantiation>:1:1: error: instruction requires the following: RV64I Base Instruction Set
   addw s0, s0, s4
   ^
   arch/riscv/kernel/vdso/vgetrandom-chacha.S:135:2: note: while in macro instantiation
    OP_4REG addw s0, s1, s2, s3, s4, s5, s6, s7
    ^
   <instantiation>:2:2: error: instruction requires the following: RV64I Base Instruction Set
    addw s1, s1, s5
    ^
   arch/riscv/kernel/vdso/vgetrandom-chacha.S:135:2: note: while in macro instantiation
    OP_4REG addw s0, s1, s2, s3, s4, s5, s6, s7
    ^
   <instantiation>:3:2: error: instruction requires the following: RV64I Base Instruction Set
    addw s2, s2, s6
    ^
   arch/riscv/kernel/vdso/vgetrandom-chacha.S:135:2: note: while in macro instantiation
    OP_4REG addw s0, s1, s2, s3, s4, s5, s6, s7
    ^
   <instantiation>:4:2: error: instruction requires the following: RV64I Base Instruction Set
    addw s3, s3, s7
    ^
   arch/riscv/kernel/vdso/vgetrandom-chacha.S:135:2: note: while in macro instantiation
    OP_4REG addw s0, s1, s2, s3, s4, s5, s6, s7
    ^
>> <instantiation>:1:1: error: instruction requires the following: RV64I Base Instruction Set
   slliw t0, a5, 32 - 24
   ^
   <instantiation>:1:1: note: while in macro instantiation
   ROTRI a5, a5, 24
   ^
   arch/riscv/kernel/vdso/vgetrandom-chacha.S:137:2: note: while in macro instantiation
    OP_4REG ROTRI a5, a6, a7, t1, 24, 24, 24, 24
    ^
   <instantiation>:2:2: error: instruction requires the following: RV64I Base Instruction Set
    srliw a5, a5, 24
    ^
   <instantiation>:1:1: note: while in macro instantiation
   ROTRI a5, a5, 24
   ^
   arch/riscv/kernel/vdso/vgetrandom-chacha.S:137:2: note: while in macro instantiation
    OP_4REG ROTRI a5, a6, a7, t1, 24, 24, 24, 24
    ^
>> <instantiation>:1:1: error: instruction requires the following: RV64I Base Instruction Set
   slliw t0, a6, 32 - 24
   ^
   <instantiation>:2:2: note: while in macro instantiation
    ROTRI a6, a6, 24
    ^
   arch/riscv/kernel/vdso/vgetrandom-chacha.S:137:2: note: while in macro instantiation
    OP_4REG ROTRI a5, a6, a7, t1, 24, 24, 24, 24
    ^
   <instantiation>:2:2: error: instruction requires the following: RV64I Base Instruction Set
    srliw a6, a6, 24
    ^
   <instantiation>:2:2: note: while in macro instantiation
    ROTRI a6, a6, 24
    ^
   arch/riscv/kernel/vdso/vgetrandom-chacha.S:137:2: note: while in macro instantiation
    OP_4REG ROTRI a5, a6, a7, t1, 24, 24, 24, 24
    ^
>> <instantiation>:1:1: error: instruction requires the following: RV64I Base Instruction Set
   slliw t0, a7, 32 - 24
   ^
   <instantiation>:3:2: note: while in macro instantiation
    ROTRI a7, a7, 24
    ^
   arch/riscv/kernel/vdso/vgetrandom-chacha.S:137:2: note: while in macro instantiation
    OP_4REG ROTRI a5, a6, a7, t1, 24, 24, 24, 24
    ^
   <instantiation>:2:2: error: instruction requires the following: RV64I Base Instruction Set
    srliw a7, a7, 24
    ^
   <instantiation>:3:2: note: while in macro instantiation
    ROTRI a7, a7, 24
    ^
   arch/riscv/kernel/vdso/vgetrandom-chacha.S:137:2: note: while in macro instantiation
    OP_4REG ROTRI a5, a6, a7, t1, 24, 24, 24, 24
    ^
>> <instantiation>:1:1: error: instruction requires the following: RV64I Base Instruction Set
   slliw t0, t1, 32 - 24
   ^
   <instantiation>:4:2: note: while in macro instantiation
    ROTRI t1, t1, 24
    ^
   arch/riscv/kernel/vdso/vgetrandom-chacha.S:137:2: note: while in macro instantiation
    OP_4REG ROTRI a5, a6, a7, t1, 24, 24, 24, 24
    ^
   <instantiation>:2:2: error: instruction requires the following: RV64I Base Instruction Set
    srliw t1, t1, 24
    ^
   <instantiation>:4:2: note: while in macro instantiation
    ROTRI t1, t1, 24
    ^
   arch/riscv/kernel/vdso/vgetrandom-chacha.S:137:2: note: while in macro instantiation
    OP_4REG ROTRI a5, a6, a7, t1, 24, 24, 24, 24
    ^
>> <instantiation>:1:1: error: instruction requires the following: RV64I Base Instruction Set
   addw s8, s8, a5
   ^
   arch/riscv/kernel/vdso/vgetrandom-chacha.S:139:2: note: while in macro instantiation
    OP_4REG addw s8, s9, s10, s11, a5, a6, a7, t1
    ^
   <instantiation>:2:2: error: instruction requires the following: RV64I Base Instruction Set
    addw s9, s9, a6
    ^
   arch/riscv/kernel/vdso/vgetrandom-chacha.S:139:2: note: while in macro instantiation
    OP_4REG addw s8, s9, s10, s11, a5, a6, a7, t1
    ^
   <instantiation>:3:2: error: instruction requires the following: RV64I Base Instruction Set
    addw s10, s10, a7
    ^
   arch/riscv/kernel/vdso/vgetrandom-chacha.S:139:2: note: while in macro instantiation
    OP_4REG addw s8, s9, s10, s11, a5, a6, a7, t1
    ^
   <instantiation>:4:2: error: instruction requires the following: RV64I Base Instruction Set
    addw s11, s11, t1
    ^
   arch/riscv/kernel/vdso/vgetrandom-chacha.S:139:2: note: while in macro instantiation
    OP_4REG addw s8, s9, s10, s11, a5, a6, a7, t1
    ^
>> <instantiation>:1:1: error: instruction requires the following: RV64I Base Instruction Set
   slliw t0, s4, 32 - 25
   ^
   <instantiation>:1:1: note: while in macro instantiation
   ROTRI s4, s4, 25
   ^
   arch/riscv/kernel/vdso/vgetrandom-chacha.S:141:2: note: while in macro instantiation
    OP_4REG ROTRI s4, s5, s6, s7, 25, 25, 25, 25
    ^
   <instantiation>:2:2: error: instruction requires the following: RV64I Base Instruction Set
    srliw s4, s4, 25
    ^
   <instantiation>:1:1: note: while in macro instantiation
   ROTRI s4, s4, 25
   ^
   arch/riscv/kernel/vdso/vgetrandom-chacha.S:141:2: note: while in macro instantiation
    OP_4REG ROTRI s4, s5, s6, s7, 25, 25, 25, 25
    ^
>> <instantiation>:1:1: error: instruction requires the following: RV64I Base Instruction Set
   slliw t0, s5, 32 - 25
   ^
   <instantiation>:2:2: note: while in macro instantiation
    ROTRI s5, s5, 25
    ^
   arch/riscv/kernel/vdso/vgetrandom-chacha.S:141:2: note: while in macro instantiation
    OP_4REG ROTRI s4, s5, s6, s7, 25, 25, 25, 25
    ^
   <instantiation>:2:2: error: instruction requires the following: RV64I Base Instruction Set
    srliw s5, s5, 25
    ^
   <instantiation>:2:2: note: while in macro instantiation
    ROTRI s5, s5, 25
    ^
   arch/riscv/kernel/vdso/vgetrandom-chacha.S:141:2: note: while in macro instantiation
    OP_4REG ROTRI s4, s5, s6, s7, 25, 25, 25, 25
    ^
   <instantiation>:1:1: error: instruction requires the following: RV64I Base Instruction Set
   slliw t0, s6, 32 - 25
   ^
   <instantiation>:3:2: note: while in macro instantiation
    ROTRI s6, s6, 25
    ^
   arch/riscv/kernel/vdso/vgetrandom-chacha.S:141:2: note: while in macro instantiation
    OP_4REG ROTRI s4, s5, s6, s7, 25, 25, 25, 25
    ^
   <instantiation>:2:2: error: instruction requires the following: RV64I Base Instruction Set
    srliw s6, s6, 25
    ^
   <instantiation>:3:2: note: while in macro instantiation
    ROTRI s6, s6, 25
    ^
   arch/riscv/kernel/vdso/vgetrandom-chacha.S:141:2: note: while in macro instantiation
    OP_4REG ROTRI s4, s5, s6, s7, 25, 25, 25, 25
    ^
   <instantiation>:1:1: error: instruction requires the following: RV64I Base Instruction Set
   slliw t0, s7, 32 - 25
   ^
   <instantiation>:4:2: note: while in macro instantiation
    ROTRI s7, s7, 25
    ^
   arch/riscv/kernel/vdso/vgetrandom-chacha.S:141:2: note: while in macro instantiation
    OP_4REG ROTRI s4, s5, s6, s7, 25, 25, 25, 25
    ^
   <instantiation>:2:2: error: instruction requires the following: RV64I Base Instruction Set
    srliw s7, s7, 25
    ^
   <instantiation>:4:2: note: while in macro instantiation
    ROTRI s7, s7, 25
    ^
   arch/riscv/kernel/vdso/vgetrandom-chacha.S:141:2: note: while in macro instantiation
    OP_4REG ROTRI s4, s5, s6, s7, 25, 25, 25, 25
    ^
   <instantiation>:1:1: error: instruction requires the following: RV64I Base Instruction Set
   addw s0, s0, s5
   ^
   arch/riscv/kernel/vdso/vgetrandom-chacha.S:144:2: note: while in macro instantiation
    OP_4REG addw s0, s1, s2, s3, s5, s6, s7, s4
    ^
   <instantiation>:2:2: error: instruction requires the following: RV64I Base Instruction Set
    addw s1, s1, s6
    ^
   arch/riscv/kernel/vdso/vgetrandom-chacha.S:144:2: note: while in macro instantiation
    OP_4REG addw s0, s1, s2, s3, s5, s6, s7, s4
    ^
   <instantiation>:3:2: error: instruction requires the following: RV64I Base Instruction Set
    addw s2, s2, s7
    ^
   arch/riscv/kernel/vdso/vgetrandom-chacha.S:144:2: note: while in macro instantiation
    OP_4REG addw s0, s1, s2, s3, s5, s6, s7, s4
    ^
   <instantiation>:4:2: error: instruction requires the following: RV64I Base Instruction Set
    addw s3, s3, s4
    ^
   arch/riscv/kernel/vdso/vgetrandom-chacha.S:144:2: note: while in macro instantiation
    OP_4REG addw s0, s1, s2, s3, s5, s6, s7, s4
    ^
   <instantiation>:1:1: error: instruction requires the following: RV64I Base Instruction Set
   slliw t0, t1, 32 - 16
   ^
   <instantiation>:1:1: note: while in macro instantiation
   ROTRI t1, t1, 16
   ^
   arch/riscv/kernel/vdso/vgetrandom-chacha.S:146:2: note: while in macro instantiation
    OP_4REG ROTRI t1, a5, a6, a7, 16, 16, 16, 16
    ^
   <instantiation>:2:2: error: instruction requires the following: RV64I Base Instruction Set
    srliw t1, t1, 16
    ^
   <instantiation>:1:1: note: while in macro instantiation
   ROTRI t1, t1, 16
   ^
   arch/riscv/kernel/vdso/vgetrandom-chacha.S:146:2: note: while in macro instantiation
    OP_4REG ROTRI t1, a5, a6, a7, 16, 16, 16, 16
    ^
   <instantiation>:1:1: error: instruction requires the following: RV64I Base Instruction Set
   slliw t0, a5, 32 - 16
   ^
   <instantiation>:2:2: note: while in macro instantiation
    ROTRI a5, a5, 16


vim +92 arch/riscv/kernel/vdso/vgetrandom-chacha.S

    77	
    78		addi		sp, sp, -12*SZREG
    79		REG_S		s0,         (sp)
    80		REG_S		s1,    SZREG(sp)
    81		REG_S		s2,  2*SZREG(sp)
    82		REG_S		s3,  3*SZREG(sp)
    83		REG_S		s4,  4*SZREG(sp)
    84		REG_S		s5,  5*SZREG(sp)
    85		REG_S		s6,  6*SZREG(sp)
    86		REG_S		s7,  7*SZREG(sp)
    87		REG_S		s8,  8*SZREG(sp)
    88		REG_S		s9,  9*SZREG(sp)
    89		REG_S		s10, 10*SZREG(sp)
    90		REG_S		s11, 11*SZREG(sp)
    91	
  > 92		ld		cnt, (counter)
    93	
    94		li		copy0, 0x61707865
    95		li		copy1, 0x3320646e
    96		li		copy2, 0x79622d32
    97		li		copy3, 0x6b206574
    98	
    99	.Lblock:
   100		/* state[0,1,2,3] = "expand 32-byte k" */
   101		mv		state0, copy0
   102		mv		state1, copy1
   103		mv		state2, copy2
   104		mv		state3, copy3
   105	
   106		/* state[4,5,..,11] = key */
   107		lw		state4,   (key)
   108		lw		state5,  4(key)
   109		lw		state6,  8(key)
   110		lw		state7,  12(key)
   111		lw		state8,  16(key)
   112		lw		state9,  20(key)
   113		lw		state10, 24(key)
   114		lw		state11, 28(key)
   115	
   116		/* state[12,13] = counter */
   117		mv		state12, cnt
 > 118		srli		state13, cnt, 32

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

