Return-Path: <linux-kernel+bounces-529312-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 54D74A422E9
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 15:25:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 70B733AB2A3
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 14:16:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CAA613F43A;
	Mon, 24 Feb 2025 14:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="BfzInmTm"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85E2D2571D9
	for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 14:16:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740406598; cv=none; b=q+B2b9XKRHQDQJcGv60U1CbGC+fqu8NoP/1SVf7Z7ZqVoD/6LaxNEW0sQnp6xl+8Wa1RNJaSswmGKX8fPCOv0z+O/DToVdf41ELxlRWu+MAgHVPAM6cyNGD6aizzSzQyMpxnNfQMYh4lUsQSpr7tDcwgh0TKUyH6FUpmmZmKYao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740406598; c=relaxed/simple;
	bh=/hB7WleSMAnl4d2M3hYJKFwvgOXzbBh9ZQfmWlU9kcA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DTC++DIc8XbqRhLw4EHS87sdu+TYY1cERZD5q+1YMDUiQzAYu0rdqWlBZlVnkhIy2sUvMr4f+Ku6LC747452b7II7KHqjegovs3ieFzxOf/Q5Ga+oCsUNf/PFPj4Q5PAwiDrfpgL1yJ6k9fPOPgryrU2Jj2PNg5NqU3fu/ad7Mg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=fail (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=BfzInmTm reason="signature verification failed"; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id A681D40E015F;
	Mon, 24 Feb 2025 14:16:30 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=fail (4096-bit key)
	reason="fail (body has been altered)" header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 44wIs4ISm4sM; Mon, 24 Feb 2025 14:16:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1740406585; bh=qzClYPggLWDiXNgY8LrPH2xA1ZMjAyWL97e3UNy6MUs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BfzInmTm7L10mqtJdTiZFZFY5kg4HFcAwaFSaAfxCgY61If0BlkjOb6ItXc99IOkf
	 NMVxAsj62vmSVOfIvXsXq9BHDamLaaItuFcGX49wU0fvsKP6BgBWz6faCDwSdxyIlz
	 y1v4aQ33THbYrdqw9UPrqduMLj3lfmnYV9EKkebiu5vxnlXVvoVGaiaSydxlpRnuW3
	 OPyroYsQQnwpjArqhmyvN4hobbLmLRzRLkSLLjeghKJ3zKvcRC9eG95AnEDeLMuOEU
	 OS/2PMP1WBpYrjwHhT4g2tPuPDK9H8785FCM5pDFrGtPOnL9QSw+SDha6CWOlCx3Ei
	 E4OMJoTct4sojznh4/7mv4mtuZlwM24tmId00y0BFDRRCTMK2Iv78JvG5MZJyK8B6Y
	 lqA1VZypHHmHFA9LFhtqLe94V28i1TNdcfmGHCV/e40EOaCZpm4D33EB3JKpxoPi7y
	 2YM2sbjd9bDYEjuMZspkp/KxYldLGQMewQUp+ZF3eF6pyoXlkH4r3LWMsHNhANuhH+
	 x/ZlPYY1eQtb7eRZLwWAZZJdpaH6U44M+DcCNF33lZsQ1vW83q7yBFJl1wyEAdZWLK
	 pCo04BZSJZcNOnCa+891xIru6FAhvS9BeQmWPbF/1gqQJWxURAXxprwwfgqTRl7YJZ
	 lR18m30UXBqeQjEH/SmMjIIU=
Received: from zn.tnic (pd95303ce.dip0.t-ipconnect.de [217.83.3.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id ED99F40E01AE;
	Mon, 24 Feb 2025 14:16:07 +0000 (UTC)
Date: Mon, 24 Feb 2025 15:16:01 +0100
From: Borislav Petkov <bp@alien8.de>
To: Rik van Riel <riel@surriel.com>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, peterz@infradead.org,
	dave.hansen@linux.intel.com, zhengqi.arch@bytedance.com,
	nadav.amit@gmail.com, thomas.lendacky@amd.com, kernel-team@meta.com,
	linux-mm@kvack.org, akpm@linux-foundation.org, jackmanb@google.com,
	jannh@google.com, mhklinux@outlook.com, andrew.cooper3@citrix.com,
	Manali.Shukla@amd.com, mingo@kernel.org
Subject: Re: [PATCH v13 07/14] x86/mm: global ASID allocation helper functions
Message-ID: <20250224141601.GIZ7x_IXs-wla5BRsd@fat_crate.local>
References: <20250223194943.3518952-1-riel@surriel.com>
 <20250223194943.3518952-8-riel@surriel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250223194943.3518952-8-riel@surriel.com>
Content-Transfer-Encoding: quoted-printable

On Sun, Feb 23, 2025 at 02:48:57PM -0500, Rik van Riel wrote:
> Subject: Re: [PATCH v13 07/14] x86/mm: global ASID allocation helper fu=
nctions

This subject needs a verb. I.e.,

"Add global ..."

> Functions to manage global ASID space.=20

Ditto.

> Multithreaded processes that
> are simultaneously active on 4 or more CPUs can get a global ASID,
> resulting in the same PCID being used for that process on every CPU.
>=20
> This in turn will allow the kernel to use hardware-assisted TLB flushin=
g
> through AMD INVLPGB or Intel RAR for these processes.
>=20
> Helper functions split out by request.

No need for that sentence.

> Signed-off-by: Rik van Riel <riel@surriel.com>
> Reviewed-by: Nadav Amit <nadav.amit@gmail.com>
> Tested-by: Manali Shukla <Manali.Shukla@amd.com>
> Tested-by: Brendan Jackman <jackmanb@google.com>
> Tested-by: Michael Kelley <mhklinux@outlook.com>
> ---
>  arch/x86/include/asm/mmu.h      |  11 +++
>  arch/x86/include/asm/tlbflush.h |  43 ++++++++++
>  arch/x86/mm/tlb.c               | 144 +++++++++++++++++++++++++++++++-
>  3 files changed, 195 insertions(+), 3 deletions(-)

arch/x86/mm/tlb.c:378:6: warning: no previous prototype for =E2=80=98dest=
roy_context_free_global_asid=E2=80=99 [-Wmissing-prototypes]
  378 | void destroy_context_free_global_asid(struct mm_struct *mm)
      |      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
arch/x86/mm/tlb.c:355:13: warning: =E2=80=98use_global_asid=E2=80=99 defi=
ned but not used [-Wunused-function]
  355 | static void use_global_asid(struct mm_struct *mm)
      |             ^~~~~~~~~~~~~~~
arch/x86/mm/tlb.c:327:13: warning: =E2=80=98mm_active_cpus_exceeds=E2=80=99=
 defined but not used [-Wunused-function]
  327 | static bool mm_active_cpus_exceeds(struct mm_struct *mm, int thre=
shold)
      |             ^~~~~~~~~~~~~~~~~~~~~~

If those functions are going to remain global they better get a proper pr=
efix
like "tlb_".

And add the functions with their first use - no need to pre-add them.

> diff --git a/arch/x86/include/asm/mmu.h b/arch/x86/include/asm/mmu.h
> index 3b496cdcb74b..edb5942d4829 100644
> --- a/arch/x86/include/asm/mmu.h
> +++ b/arch/x86/include/asm/mmu.h
> @@ -69,6 +69,17 @@ typedef struct {
>  	u16 pkey_allocation_map;
>  	s16 execute_only_pkey;
>  #endif
> +
> +#ifdef CONFIG_X86_BROADCAST_TLB_FLUSH
> +	/*
> +	 * The global ASID will be a non-zero value when the process has
> +	 * the same ASID across all CPUs, allowing it to make use of
> +	 * hardware-assisted remote TLB invalidation like AMD INVLPGB.
> +	 */
> +	u16 global_asid;
> +	/* The process is transitioning to a new global ASID number. */
> +	bool asid_transition;
> +#endif
>  } mm_context_t;
> =20
>  #define INIT_MM_CONTEXT(mm)						\
> diff --git a/arch/x86/include/asm/tlbflush.h b/arch/x86/include/asm/tlb=
flush.h
> index 09463a2fb05f..83f1da2f1e4a 100644
> --- a/arch/x86/include/asm/tlbflush.h
> +++ b/arch/x86/include/asm/tlbflush.h
> @@ -6,6 +6,7 @@
>  #include <linux/mmu_notifier.h>
>  #include <linux/sched.h>
> =20
> +#include <asm/barrier.h>
>  #include <asm/processor.h>
>  #include <asm/cpufeature.h>
>  #include <asm/special_insns.h>
> @@ -234,6 +235,48 @@ void flush_tlb_one_kernel(unsigned long addr);
>  void flush_tlb_multi(const struct cpumask *cpumask,
>  		      const struct flush_tlb_info *info);
> =20
> +static inline bool is_dyn_asid(u16 asid)
> +{
> +	return asid < TLB_NR_DYN_ASIDS;
> +}
> +
> +#ifdef CONFIG_X86_BROADCAST_TLB_FLUSH
> +static inline u16 mm_global_asid(struct mm_struct *mm)
> +{
> +	u16 asid;
> +
> +	if (!cpu_feature_enabled(X86_FEATURE_INVLPGB))
> +		return 0;
> +
> +	asid =3D smp_load_acquire(&mm->context.global_asid);
> +
> +	/* mm->context.global_asid is either 0, or a global ASID */
> +	VM_WARN_ON_ONCE(asid && is_dyn_asid(asid));
> +
> +	return asid;
> +}
> +
> +static inline void assign_mm_global_asid(struct mm_struct *mm, u16 asi=
d)

mm_assign_global_asid()

> +{
> +	/*
> +	 * Notably flush_tlb_mm_range() -> broadcast_tlb_flush() ->
> +	 * finish_asid_transition() needs to observe asid_transition =3D true
> +	 * once it observes global_asid.
> +	 */
> +	mm->context.asid_transition =3D true;
> +	smp_store_release(&mm->context.global_asid, asid);
> +}
> +#else
> +static inline u16 mm_global_asid(struct mm_struct *mm)
> +{
> +	return 0;
> +}
> +
> +static inline void assign_mm_global_asid(struct mm_struct *mm, u16 asi=
d)
> +{
> +}
> +#endif
> +
>  #ifdef CONFIG_PARAVIRT
>  #include <asm/paravirt.h>
>  #endif
> diff --git a/arch/x86/mm/tlb.c b/arch/x86/mm/tlb.c
> index 16839651f67f..405630479b90 100644
> --- a/arch/x86/mm/tlb.c
> +++ b/arch/x86/mm/tlb.c
> @@ -74,13 +74,15 @@
>   * use different names for each of them:
>   *
>   * ASID  - [0, TLB_NR_DYN_ASIDS-1]
> - *         the canonical identifier for an mm
> + *         the canonical identifier for an mm, dynamically allocated o=
n each CPU
> + *         [TLB_NR_DYN_ASIDS, MAX_ASID_AVAILABLE-1]
> + *         the canonical, global identifier for an mm, identical acros=
s all CPUs
>   *
> - * kPCID - [1, TLB_NR_DYN_ASIDS]
> + * kPCID - [1, MAX_ASID_AVAILABLE]
>   *         the value we write into the PCID part of CR3; corresponds t=
o the
>   *         ASID+1, because PCID 0 is special.
>   *
> - * uPCID - [2048 + 1, 2048 + TLB_NR_DYN_ASIDS]
> + * uPCID - [2048 + 1, 2048 + MAX_ASID_AVAILABLE]
>   *         for KPTI each mm has two address spaces and thus needs two
>   *         PCID values, but we can still do with a single ASID denomin=
ation
>   *         for each mm. Corresponds to kPCID + 2048.
> @@ -251,6 +253,142 @@ static void choose_new_asid(struct mm_struct *nex=
t, u64 next_tlb_gen,
>  	*need_flush =3D true;
>  }
> =20
> +/*
> + * Global ASIDs are allocated for multi-threaded processes that are
> + * active on multiple CPUs simultaneously, giving each of those
> + * processes the same PCIDs on every CPU, for use with hardware-assist=
ed

"the same PCID" or "the same PCIDs"?

Does a multithreaded process get one or more than one PCIDs? I'd expect o=
nly
one ofc.

> + * TLB shootdown on remote CPUs, like AMD INVLPGB or Intel RAR.
> + *
> + * These global ASIDs are held for the lifetime of the process.
> + */
> +static DEFINE_RAW_SPINLOCK(global_asid_lock);
> +static u16 last_global_asid =3D MAX_ASID_AVAILABLE;
> +static DECLARE_BITMAP(global_asid_used, MAX_ASID_AVAILABLE);
> +static DECLARE_BITMAP(global_asid_freed, MAX_ASID_AVAILABLE);
> +static int global_asid_available =3D MAX_ASID_AVAILABLE - TLB_NR_DYN_A=
SIDS - 1;
> +
> +/*
> + * When the search for a free ASID in the global ASID space reaches
> + * MAX_ASID_AVAILABLE, a global TLB flush guarantees that previously
> + * freed global ASIDs are safe to re-use.
> + *
> + * This way the global flush only needs to happen at ASID rollover
> + * time, and not at ASID allocation time.
> + */
> +static void reset_global_asid_space(void)
> +{
> +	lockdep_assert_held(&global_asid_lock);
> +
> +	invlpgb_flush_all_nonglobals();
> +
> +	/*
> +	 * The TLB flush above makes it safe to re-use the previously
> +	 * freed global ASIDs.
> +	 */
> +	bitmap_andnot(global_asid_used, global_asid_used,
> +			global_asid_freed, MAX_ASID_AVAILABLE);
> +	bitmap_clear(global_asid_freed, 0, MAX_ASID_AVAILABLE);
> +
> +	/* Restart the search from the start of global ASID space. */
> +	last_global_asid =3D TLB_NR_DYN_ASIDS;
> +}
> +
> +static u16 allocate_global_asid(void)
> +{
> +	u16 asid;
> +
> +	lockdep_assert_held(&global_asid_lock);
> +
> +	/* The previous allocation hit the edge of available address space */
> +	if (last_global_asid >=3D MAX_ASID_AVAILABLE - 1)
> +		reset_global_asid_space();
> +
> +	asid =3D find_next_zero_bit(global_asid_used, MAX_ASID_AVAILABLE, las=
t_global_asid);
> +
> +	if (asid >=3D MAX_ASID_AVAILABLE) {

	if (asid >=3D MAX_ASID_AVAILABLE && !global_asid_available)

> +		/* This should never happen. */
> +		VM_WARN_ONCE(1, "Unable to allocate global ASID despite %d available=
\n",
> +				global_asid_available);
> +		return 0;
> +	}
> +
> +	/* Claim this global ASID. */
> +	__set_bit(asid, global_asid_used);
> +	last_global_asid =3D asid;
> +	global_asid_available--;
> +	return asid;
> +}
> +
> +/*
> + * Check whether a process is currently active on more than "threshold=
" CPUs.

@threshold - then it is clear that you mean the function argument.

> + * This is a cheap estimation on whether or not it may make sense to a=
ssign
> + * a global ASID to this process, and use broadcast TLB invalidation.
> + */
> +static bool mm_active_cpus_exceeds(struct mm_struct *mm, int threshold=
)
> +{
> +	int count =3D 0;
> +	int cpu;

Is this function supposed to hold some sort of a lock?

> +
> +	/* This quick check should eliminate most single threaded programs. *=
/
> +	if (cpumask_weight(mm_cpumask(mm)) <=3D threshold)
> +		return false;
> +
> +	/* Slower check to make sure. */
> +	for_each_cpu(cpu, mm_cpumask(mm)) {

Needs CPU hotplug protection?

> +		/* Skip the CPUs that aren't really running this process. */
> +		if (per_cpu(cpu_tlbstate.loaded_mm, cpu) !=3D mm)
> +			continue;
> +
> +		if (per_cpu(cpu_tlbstate_shared.is_lazy, cpu))
> +			continue;
> +
> +		if (++count > threshold)
> +			return true;
> +	}
> +	return false;
> +}
> +
> +/*
> + * Assign a global ASID to the current process, protecting against
> + * races between multiple threads in the process.
> + */
> +static void use_global_asid(struct mm_struct *mm)
> +{
> +	u16 asid;
> +
> +	guard(raw_spinlock_irqsave)(&global_asid_lock);
> +
> +	/* This process is already using broadcast TLB invalidation. */
> +	if (mm_global_asid(mm))
> +		return;
> +
> +	/* The last global ASID was consumed while waiting for the lock. */
> +	if (!global_asid_available) {
> +		VM_WARN_ONCE(1, "Ran out of global ASIDs\n");

And? Why do we want to warn here? We need to reset global ASIDs anyway.

> +		return;
> +	}
> +
> +	asid =3D allocate_global_asid();
> +	if (!asid)
> +		return;
> +
> +	assign_mm_global_asid(mm, asid);
> +}
> +
> +void destroy_context_free_global_asid(struct mm_struct *mm)

That name is a mouthful. mm_free_global_asid() is just fine.

--=20
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

