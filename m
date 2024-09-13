Return-Path: <linux-kernel+bounces-328710-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 11BA99787A4
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 20:15:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 55B35B26D64
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 18:15:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD18212C474;
	Fri, 13 Sep 2024 18:15:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nyejt9wJ"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C71FD83A17
	for <linux-kernel@vger.kernel.org>; Fri, 13 Sep 2024 18:15:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726251317; cv=none; b=owQ1lycuewkbrGgcpl7zlt3arLjJhf2ooIN+hLRCw2YhoR4l0sQTTn2LY0mr7J/Ea64N+AyI7VvfQXwXWw3hqcrFwh6GJku7yndX8MJ3WgDkpxaXJID48yNRCH7WJSPfKwYf1gG3pzWqp9KeEqp0TlefdrYGDhlTF8NVDrPe9VY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726251317; c=relaxed/simple;
	bh=sC2Xh5tFSCBxAiboeODjLyDzh64Qovoi3OKhgLmAdbw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=INu8xIV3ls00iJnEUbKjx7kuA8IukU5MNY0Fu77tfmIEAjtyAPMzGVT9hdgPTN8GAH7ISsqfUKsCGE3Kdu0pGcxq7OGoL6D3KiGAcPEcf2LxhbW1cSVrfTrquj6NdudCj8jmFoJOfyZG9XgkAFYA2LMvJkv0MmbB0u99XyEySKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nyejt9wJ; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726251316; x=1757787316;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=sC2Xh5tFSCBxAiboeODjLyDzh64Qovoi3OKhgLmAdbw=;
  b=nyejt9wJwaZNAD2nHe7B5C34BF6/RPY26taaGg5LoDqmKuKlP+JYdsm2
   qm3SDHTOLJi1uTy49l4GK/8ftu8asnJn0ayztl+AP4rOIUMLhKiOBnksL
   y9rMGTPi+i2GLhLJQ5mHjE+EgRkQOqRP0IJYfUsXvxApVVAVsQcRlaUTl
   KXpvcqMdINJESQ27zr85Mrj3II+dhwlFCEYgrWc3HVzruZDMdEWEu0z0Y
   JwsP1YWDZpcbgQHhBm8vTm6gDXThxob333++Phmqp08Ar0Iwk1d0k8efl
   y8tmxEIGYUASJbM+EQOctfPotSSxVt8naOXnSGrCD4h/R4h8NLjIirE50
   g==;
X-CSE-ConnectionGUID: tx/SAcp9R/SQi+6z+aoB4g==
X-CSE-MsgGUID: NBiCxR4qTX6rqt6UxCuDGA==
X-IronPort-AV: E=McAfee;i="6700,10204,11194"; a="47677011"
X-IronPort-AV: E=Sophos;i="6.10,226,1719903600"; 
   d="scan'208";a="47677011"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2024 11:15:15 -0700
X-CSE-ConnectionGUID: by1VooGEQryfWp+oAhqYZA==
X-CSE-MsgGUID: fTlBtpbbQjyHsVB4OfQhcQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,226,1719903600"; 
   d="scan'208";a="67999578"
Received: from lkp-server01.sh.intel.com (HELO 53e96f405c61) ([10.239.97.150])
  by orviesa010.jf.intel.com with ESMTP; 13 Sep 2024 11:15:14 -0700
Received: from kbuild by 53e96f405c61 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1spAp5-0006oF-1e;
	Fri, 13 Sep 2024 18:15:11 +0000
Date: Sat, 14 Sep 2024 02:14:33 +0800
From: kernel test robot <lkp@intel.com>
To: Alexei Starovoitov <ast@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Daniel Borkmann <daniel@iogearbox.net>
Subject: kernel/bpf/verifier.c:19160:44: sparse: sparse: cast truncates bits
 from constant value (fffffff800000000 becomes 0)
Message-ID: <202409140211.psrlfLJ7-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   196145c606d0f816fd3926483cb1ff87e09c2c0b
commit: af682b767a41772499f8e54ca7d7e1deb3395f44 bpf: Optimize emit_mov_imm64().
date:   5 months ago
config: arm64-randconfig-r121-20240913 (https://download.01.org/0day-ci/archive/20240914/202409140211.psrlfLJ7-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 14.1.0
reproduce: (https://download.01.org/0day-ci/archive/20240914/202409140211.psrlfLJ7-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202409140211.psrlfLJ7-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
   kernel/bpf/verifier.c:20219:38: sparse: sparse: subtraction of functions? Share your drugs
   kernel/bpf/verifier.c: note: in included file (through include/linux/bpf.h, include/linux/bpf-cgroup.h):
   include/linux/bpfptr.h:65:40: sparse: sparse: cast to non-scalar
   include/linux/bpfptr.h:65:40: sparse: sparse: cast from non-scalar
   include/linux/bpfptr.h:65:40: sparse: sparse: cast to non-scalar
   include/linux/bpfptr.h:65:40: sparse: sparse: cast from non-scalar
   include/linux/bpfptr.h:65:40: sparse: sparse: cast to non-scalar
   include/linux/bpfptr.h:65:40: sparse: sparse: cast from non-scalar
>> kernel/bpf/verifier.c:19160:44: sparse: sparse: cast truncates bits from constant value (fffffff800000000 becomes 0)
   include/linux/bpfptr.h:65:40: sparse: sparse: cast to non-scalar
   include/linux/bpfptr.h:65:40: sparse: sparse: cast from non-scalar

vim +19160 kernel/bpf/verifier.c

 19113	
 19114	static int jit_subprogs(struct bpf_verifier_env *env)
 19115	{
 19116		struct bpf_prog *prog = env->prog, **func, *tmp;
 19117		int i, j, subprog_start, subprog_end = 0, len, subprog;
 19118		struct bpf_map *map_ptr;
 19119		struct bpf_insn *insn;
 19120		void *old_bpf_func;
 19121		int err, num_exentries;
 19122	
 19123		if (env->subprog_cnt <= 1)
 19124			return 0;
 19125	
 19126		for (i = 0, insn = prog->insnsi; i < prog->len; i++, insn++) {
 19127			if (!bpf_pseudo_func(insn) && !bpf_pseudo_call(insn))
 19128				continue;
 19129	
 19130			/* Upon error here we cannot fall back to interpreter but
 19131			 * need a hard reject of the program. Thus -EFAULT is
 19132			 * propagated in any case.
 19133			 */
 19134			subprog = find_subprog(env, i + insn->imm + 1);
 19135			if (subprog < 0) {
 19136				WARN_ONCE(1, "verifier bug. No program starts at insn %d\n",
 19137					  i + insn->imm + 1);
 19138				return -EFAULT;
 19139			}
 19140			/* temporarily remember subprog id inside insn instead of
 19141			 * aux_data, since next loop will split up all insns into funcs
 19142			 */
 19143			insn->off = subprog;
 19144			/* remember original imm in case JIT fails and fallback
 19145			 * to interpreter will be needed
 19146			 */
 19147			env->insn_aux_data[i].call_imm = insn->imm;
 19148			/* point imm to __bpf_call_base+1 from JITs point of view */
 19149			insn->imm = 1;
 19150			if (bpf_pseudo_func(insn)) {
 19151	#if defined(MODULES_VADDR)
 19152				u64 addr = MODULES_VADDR;
 19153	#else
 19154				u64 addr = VMALLOC_START;
 19155	#endif
 19156				/* jit (e.g. x86_64) may emit fewer instructions
 19157				 * if it learns a u32 imm is the same as a u64 imm.
 19158				 * Set close enough to possible prog address.
 19159				 */
 19160				insn[0].imm = (u32)addr;
 19161				insn[1].imm = addr >> 32;
 19162			}
 19163		}
 19164	
 19165		err = bpf_prog_alloc_jited_linfo(prog);
 19166		if (err)
 19167			goto out_undo_insn;
 19168	
 19169		err = -ENOMEM;
 19170		func = kcalloc(env->subprog_cnt, sizeof(prog), GFP_KERNEL);
 19171		if (!func)
 19172			goto out_undo_insn;
 19173	
 19174		for (i = 0; i < env->subprog_cnt; i++) {
 19175			subprog_start = subprog_end;
 19176			subprog_end = env->subprog_info[i + 1].start;
 19177	
 19178			len = subprog_end - subprog_start;
 19179			/* bpf_prog_run() doesn't call subprogs directly,
 19180			 * hence main prog stats include the runtime of subprogs.
 19181			 * subprogs don't have IDs and not reachable via prog_get_next_id
 19182			 * func[i]->stats will never be accessed and stays NULL
 19183			 */
 19184			func[i] = bpf_prog_alloc_no_stats(bpf_prog_size(len), GFP_USER);
 19185			if (!func[i])
 19186				goto out_free;
 19187			memcpy(func[i]->insnsi, &prog->insnsi[subprog_start],
 19188			       len * sizeof(struct bpf_insn));
 19189			func[i]->type = prog->type;
 19190			func[i]->len = len;
 19191			if (bpf_prog_calc_tag(func[i]))
 19192				goto out_free;
 19193			func[i]->is_func = 1;
 19194			func[i]->sleepable = prog->sleepable;
 19195			func[i]->aux->func_idx = i;
 19196			/* Below members will be freed only at prog->aux */
 19197			func[i]->aux->btf = prog->aux->btf;
 19198			func[i]->aux->func_info = prog->aux->func_info;
 19199			func[i]->aux->func_info_cnt = prog->aux->func_info_cnt;
 19200			func[i]->aux->poke_tab = prog->aux->poke_tab;
 19201			func[i]->aux->size_poke_tab = prog->aux->size_poke_tab;
 19202	
 19203			for (j = 0; j < prog->aux->size_poke_tab; j++) {
 19204				struct bpf_jit_poke_descriptor *poke;
 19205	
 19206				poke = &prog->aux->poke_tab[j];
 19207				if (poke->insn_idx < subprog_end &&
 19208				    poke->insn_idx >= subprog_start)
 19209					poke->aux = func[i]->aux;
 19210			}
 19211	
 19212			func[i]->aux->name[0] = 'F';
 19213			func[i]->aux->stack_depth = env->subprog_info[i].stack_depth;
 19214			func[i]->jit_requested = 1;
 19215			func[i]->blinding_requested = prog->blinding_requested;
 19216			func[i]->aux->kfunc_tab = prog->aux->kfunc_tab;
 19217			func[i]->aux->kfunc_btf_tab = prog->aux->kfunc_btf_tab;
 19218			func[i]->aux->linfo = prog->aux->linfo;
 19219			func[i]->aux->nr_linfo = prog->aux->nr_linfo;
 19220			func[i]->aux->jited_linfo = prog->aux->jited_linfo;
 19221			func[i]->aux->linfo_idx = env->subprog_info[i].linfo_idx;
 19222			func[i]->aux->arena = prog->aux->arena;
 19223			num_exentries = 0;
 19224			insn = func[i]->insnsi;
 19225			for (j = 0; j < func[i]->len; j++, insn++) {
 19226				if (BPF_CLASS(insn->code) == BPF_LDX &&
 19227				    (BPF_MODE(insn->code) == BPF_PROBE_MEM ||
 19228				     BPF_MODE(insn->code) == BPF_PROBE_MEM32 ||
 19229				     BPF_MODE(insn->code) == BPF_PROBE_MEMSX))
 19230					num_exentries++;
 19231				if ((BPF_CLASS(insn->code) == BPF_STX ||
 19232				     BPF_CLASS(insn->code) == BPF_ST) &&
 19233				     BPF_MODE(insn->code) == BPF_PROBE_MEM32)
 19234					num_exentries++;
 19235			}
 19236			func[i]->aux->num_exentries = num_exentries;
 19237			func[i]->aux->tail_call_reachable = env->subprog_info[i].tail_call_reachable;
 19238			func[i]->aux->exception_cb = env->subprog_info[i].is_exception_cb;
 19239			if (!i)
 19240				func[i]->aux->exception_boundary = env->seen_exception;
 19241			func[i] = bpf_int_jit_compile(func[i]);
 19242			if (!func[i]->jited) {
 19243				err = -ENOTSUPP;
 19244				goto out_free;
 19245			}
 19246			cond_resched();
 19247		}
 19248	
 19249		/* at this point all bpf functions were successfully JITed
 19250		 * now populate all bpf_calls with correct addresses and
 19251		 * run last pass of JIT
 19252		 */
 19253		for (i = 0; i < env->subprog_cnt; i++) {
 19254			insn = func[i]->insnsi;
 19255			for (j = 0; j < func[i]->len; j++, insn++) {
 19256				if (bpf_pseudo_func(insn)) {
 19257					subprog = insn->off;
 19258					insn[0].imm = (u32)(long)func[subprog]->bpf_func;
 19259					insn[1].imm = ((u64)(long)func[subprog]->bpf_func) >> 32;
 19260					continue;
 19261				}
 19262				if (!bpf_pseudo_call(insn))
 19263					continue;
 19264				subprog = insn->off;
 19265				insn->imm = BPF_CALL_IMM(func[subprog]->bpf_func);
 19266			}
 19267	
 19268			/* we use the aux data to keep a list of the start addresses
 19269			 * of the JITed images for each function in the program
 19270			 *
 19271			 * for some architectures, such as powerpc64, the imm field
 19272			 * might not be large enough to hold the offset of the start
 19273			 * address of the callee's JITed image from __bpf_call_base
 19274			 *
 19275			 * in such cases, we can lookup the start address of a callee
 19276			 * by using its subprog id, available from the off field of
 19277			 * the call instruction, as an index for this list
 19278			 */
 19279			func[i]->aux->func = func;
 19280			func[i]->aux->func_cnt = env->subprog_cnt - env->hidden_subprog_cnt;
 19281			func[i]->aux->real_func_cnt = env->subprog_cnt;
 19282		}
 19283		for (i = 0; i < env->subprog_cnt; i++) {
 19284			old_bpf_func = func[i]->bpf_func;
 19285			tmp = bpf_int_jit_compile(func[i]);
 19286			if (tmp != func[i] || func[i]->bpf_func != old_bpf_func) {
 19287				verbose(env, "JIT doesn't support bpf-to-bpf calls\n");
 19288				err = -ENOTSUPP;
 19289				goto out_free;
 19290			}
 19291			cond_resched();
 19292		}
 19293	
 19294		/* finally lock prog and jit images for all functions and
 19295		 * populate kallsysm. Begin at the first subprogram, since
 19296		 * bpf_prog_load will add the kallsyms for the main program.
 19297		 */
 19298		for (i = 1; i < env->subprog_cnt; i++) {
 19299			err = bpf_prog_lock_ro(func[i]);
 19300			if (err)
 19301				goto out_free;
 19302		}
 19303	
 19304		for (i = 1; i < env->subprog_cnt; i++)
 19305			bpf_prog_kallsyms_add(func[i]);
 19306	
 19307		/* Last step: make now unused interpreter insns from main
 19308		 * prog consistent for later dump requests, so they can
 19309		 * later look the same as if they were interpreted only.
 19310		 */
 19311		for (i = 0, insn = prog->insnsi; i < prog->len; i++, insn++) {
 19312			if (bpf_pseudo_func(insn)) {
 19313				insn[0].imm = env->insn_aux_data[i].call_imm;
 19314				insn[1].imm = insn->off;
 19315				insn->off = 0;
 19316				continue;
 19317			}
 19318			if (!bpf_pseudo_call(insn))
 19319				continue;
 19320			insn->off = env->insn_aux_data[i].call_imm;
 19321			subprog = find_subprog(env, i + insn->off + 1);
 19322			insn->imm = subprog;
 19323		}
 19324	
 19325		prog->jited = 1;
 19326		prog->bpf_func = func[0]->bpf_func;
 19327		prog->jited_len = func[0]->jited_len;
 19328		prog->aux->extable = func[0]->aux->extable;
 19329		prog->aux->num_exentries = func[0]->aux->num_exentries;
 19330		prog->aux->func = func;
 19331		prog->aux->func_cnt = env->subprog_cnt - env->hidden_subprog_cnt;
 19332		prog->aux->real_func_cnt = env->subprog_cnt;
 19333		prog->aux->bpf_exception_cb = (void *)func[env->exception_callback_subprog]->bpf_func;
 19334		prog->aux->exception_boundary = func[0]->aux->exception_boundary;
 19335		bpf_prog_jit_attempt_done(prog);
 19336		return 0;
 19337	out_free:
 19338		/* We failed JIT'ing, so at this point we need to unregister poke
 19339		 * descriptors from subprogs, so that kernel is not attempting to
 19340		 * patch it anymore as we're freeing the subprog JIT memory.
 19341		 */
 19342		for (i = 0; i < prog->aux->size_poke_tab; i++) {
 19343			map_ptr = prog->aux->poke_tab[i].tail_call.map;
 19344			map_ptr->ops->map_poke_untrack(map_ptr, prog->aux);
 19345		}
 19346		/* At this point we're guaranteed that poke descriptors are not
 19347		 * live anymore. We can just unlink its descriptor table as it's
 19348		 * released with the main prog.
 19349		 */
 19350		for (i = 0; i < env->subprog_cnt; i++) {
 19351			if (!func[i])
 19352				continue;
 19353			func[i]->aux->poke_tab = NULL;
 19354			bpf_jit_free(func[i]);
 19355		}
 19356		kfree(func);
 19357	out_undo_insn:
 19358		/* cleanup main prog to be interpreted */
 19359		prog->jit_requested = 0;
 19360		prog->blinding_requested = 0;
 19361		for (i = 0, insn = prog->insnsi; i < prog->len; i++, insn++) {
 19362			if (!bpf_pseudo_call(insn))
 19363				continue;
 19364			insn->off = 0;
 19365			insn->imm = env->insn_aux_data[i].call_imm;
 19366		}
 19367		bpf_prog_jit_attempt_done(prog);
 19368		return err;
 19369	}
 19370	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

