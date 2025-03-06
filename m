Return-Path: <linux-kernel+bounces-549308-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A503DA550B1
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 17:27:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 32C4017431E
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 16:26:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 184872135A3;
	Thu,  6 Mar 2025 16:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=motorola.com header.i=@motorola.com header.b="kgyicTSL"
Received: from mx0a-00823401.pphosted.com (mx0a-00823401.pphosted.com [148.163.148.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7856B21421C
	for <linux-kernel@vger.kernel.org>; Thu,  6 Mar 2025 16:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.148.104
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741278287; cv=none; b=hgyhs/2zYmdPYo9vXfOYRwlISsB0EK49ymNJ20uXdXMy4MVk52iojj8/SnKi3UGShtwZc+TD/4e8ouWG8Mw0QrgbQlbMKXLgYregtFcdyNWqa17WSMFaalM6bsbf/dIIMzALYdfdv41/DboROYaTFBO+L33P2INB/+UA6H3DlaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741278287; c=relaxed/simple;
	bh=DStPJWFnYxPG437Xjsj+Py4jSdJHkZtx8n1KMdy+2W4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CX9dg/aouB/8TpdMWCg0AULiOlctgy7lsyYAAtATQQb+dnXg9MbKIqS1jQ9or4sr8Tsy98PAVOxwuZwT01ZVXB36yJXCEmmPh7VxFkM/WImi0koXr87pPPCjPK7ULaCm5Md58L2IerbZODFEWZN1yCZPMIr2oIbFWk1xdkP9l0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=motorola.com; spf=pass smtp.mailfrom=motorola.com; dkim=pass (2048-bit key) header.d=motorola.com header.i=@motorola.com header.b=kgyicTSL; arc=none smtp.client-ip=148.163.148.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=motorola.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=motorola.com
Received: from pps.filterd (m0355086.ppops.net [127.0.0.1])
	by mx0a-00823401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 526FmPTd014597;
	Thu, 6 Mar 2025 16:24:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=motorola.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=DKIM202306; bh=ykbdmnItT07NYJB+G/dKwJ3
	dtZWck5/x3/WTkfFVHlg=; b=kgyicTSLaOvtMqAUTKL/+cOP6c+bdB0QTUO5fUL
	0oX4nKewyrFf+lISk+DIwAx7J7euCEV5QxfJyN8A8JSZIjPSNZv27zJrPBvNaS7p
	9ofdvX13K3Oe1NccBewcwgIvMTgnDtbniM3i/7ynG7nebqAF6ft6oD1qo2vxhxNk
	Gb4QE0auaix5cH14T5Uzd3f7479lOdvTld0uc/t6hwKTNes3GKwK+9XejFzhFQd0
	pLjzBDQkd3w4IXjGcXsKRR58DlaZlOGmmMSbm5+E8r47El/muv2SPEmky9sQPy+n
	JMVFEJA5M19roB38q/dY4D6ESUj4UKqB/LwggHWCiZQIDsQ==
Received: from va32lpfpp02.lenovo.com ([104.232.228.22])
	by mx0a-00823401.pphosted.com (PPS) with ESMTPS id 4577w4a1x1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 06 Mar 2025 16:24:00 +0000 (GMT)
Received: from ilclmmrp02.lenovo.com (unknown [100.65.83.26])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by va32lpfpp02.lenovo.com (Postfix) with ESMTPS id 4Z7vqz02C7zxd0Nr;
	Thu,  6 Mar 2025 16:23:59 +0000 (UTC)
Received: from ilclasset02 (ilclasset02.mot.com [100.64.11.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: mbland)
	by ilclmmrp02.lenovo.com (Postfix) with ESMTPSA id 4Z7vqy5d38z3npb4;
	Thu,  6 Mar 2025 16:23:58 +0000 (UTC)
Date: Thu, 6 Mar 2025 10:23:58 -0600
From: Maxwell Bland <mbland@motorola.com>
To: Kevin Brodsky <kevin.brodsky@arm.com>
Cc: linux-kernel@vger.kernel.org, Kevin Brodsky <kevin.brodsky@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mark Brown <broonie@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Jann Horn <jannh@google.com>, Jeff Xu <jeffxu@chromium.org>,
        Joey Gouly <joey.gouly@arm.com>, Kees Cook <kees@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Andy Lutomirski <luto@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Pierre Langlois <pierre.langlois@arm.com>,
        Quentin Perret <qperret@google.com>,
        "Mike Rapoport (IBM)" <rppt@kernel.org>,
        Ryan Roberts <ryan.roberts@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>, Will Deacon <will@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Qi Zheng <zhengqi.arch@bytedance.com>,
        linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org,
        x86@kernel.org
Subject: Re: [RFC PATCH v3 00/15] pkeys-based page table hardening
Message-ID: <a32cjyekuecoowzbitc2xykilvpu6l3jjtityp7x5hw7xbiysp@5l2lptwmqiug>
References: <20250203101839.1223008-1-kevin.brodsky@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250203101839.1223008-1-kevin.brodsky@arm.com>
X-Authority-Analysis: v=2.4 cv=Goi4+l1C c=1 sm=1 tr=0 ts=67c9cc20 cx=c_pps a=7qI18unSaIz3cJfMvNS4Ww==:117 a=7qI18unSaIz3cJfMvNS4Ww==:17 a=kj9zAlcOel0A:10 a=Vs1iUdzkB0EA:10 a=VwQbUJbxAAAA:8 a=11RNBK-KwymkfbY0LtUA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-GUID: UPFy7pc_UVTloSYjKx1_HeIwjZg_WXq9
X-Proofpoint-ORIG-GUID: UPFy7pc_UVTloSYjKx1_HeIwjZg_WXq9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-06_05,2025-03-06_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 impostorscore=0
 bulkscore=0 mlxlogscore=999 malwarescore=0 adultscore=0 priorityscore=1501
 lowpriorityscore=0 spamscore=0 phishscore=0 suspectscore=0 mlxscore=0
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2502100000
 definitions=main-2503060125

On Mon, Feb 03, 2025 at 10:18:24AM +0000, Kevin Brodsky wrote:
> This is a proposal to leverage protection keys (pkeys) to harden
> critical kernel data, by making it mostly read-only. The series includes
> a simple framework called "kpkeys" to manipulate pkeys for in-kernel use,
> as well as a page table hardening feature based on that framework
> (kpkeys_hardened_pgtables). Both are implemented on arm64 as a proof of
> concept, but they are designed to be compatible with any architecture
> implementing pkeys.

Hi Kevin,

This is awesome. When working on some of these problems, I also thought
of leveraging the POE feature, but was not sure of a good way to make
it work.

> Page tables were chosen as they are a popular (and critical) target for
> attacks, but there are of course many others - this is only a starting
> point (see section "Further use-cases"). It has become more and more
> common for accesses to such target data to be mediated by a hypervisor
> in vendor kernels; the hope is that kpkeys can provide much of that
> protection in a simpler manner. No benchmarking has been performed at
> this stage, but the runtime overhead should also be lower (though likely
> not negligible).

Some notes here, having implemented similar page table protections,
albeit using stage-2 page table permissions and a fault handler.

https://lore.kernel.org/all/2wf4kmoqqmod6njviaq33lbxbx6gvdqbksljxykgltwnxo6ruy@7ueumwmxxh72/

I wanted to know your thoughts on associating specific policies to
page table updates in cases where an adversary is able to corrupt
other state associated with parameters to the page table infrastructure
code, e.g.

arch/arm64/net/bpf_jit_comp.c
2417:		if (set_memory_rw(PAGE_MASK & ((uintptr_t)&plt->target),

Is this something we would assume is handled via the security_* hook
infrastructure, a shadow stack CFI method, or changing the kernel code
to reverify the data non-modularly, some combination of the above?

> - Pages in the linear mapping are assigned a pkey using set_memory_pkey().
>   This is sufficient for this series, but of course higher-level
>   interfaces can be introduced later to ask allocators to return pages
>   marked with a given pkey. It should also be possible to extend this to
>   vmalloc() if needed.

One of the interesting points here, acknowledged below, was that this
relies on having guarantees around the PC value/CFI of the function.
Since this is the baseline assumption, it feels natural that the
locking/unlocking would be associated into the existing CFI
instrumentation, since (from experience) point-patching each mutable
data structure allocation/deallocation is difficult.

> # Further use-cases
> 
> It should be possible to harden various targets using kpkeys, including:
> 
> - struct cred (enforcing a "mostly read-only" state once committed)
> 
> - fixmap (occasionally used even after early boot, e.g.
>   set_swapper_pgd() in arch/arm64/mm/mmu.c)
> 
> - SELinux state (e.g. struct selinux_state::initialized)
> 
> ... and many others.

Be wary that it is not just struct cred but pointers to struct cred.  We
quickly run into a problem of, for example, in updates to f_op,
bookkeeping which f_op is OK to have in the file, e.g., in Android's
6.1.x:

drivers/gpu/drm/i810/i810_dma.c
138:    file_priv->filp->f_op = &i810_buffer_fops;
144:    file_priv->filp->f_op = old_fops;

drivers/staging/android/ashmem.c
436:            vmfile->f_op = &vmfile_fops;

Where overwriting f_op is a "classic" bypass of protection systems like
this one.

I think this problem may be totally solvable if POE was integrated into
something like CFI, since we can guarantee only the code that sets f_op
to "vmfile_fops" can unlock/relock the file's page.

Maybe another approach would work better, though?

> # Open questions
> 
> A few aspects in this RFC that are debatable and/or worth discussing:
> 
> - There is currently no restriction on how kpkeys levels map to pkeys
>   permissions. A typical approach is to allocate one pkey per level and
>   make it writable at that level only. As the number of levels
>   increases, we may however run out of pkeys, especially on arm64 (just
>   8 pkeys with POE). Depending on the use-cases, it may be acceptable to
>   use the same pkey for the data associated to multiple levels.

Honestly, I associate each protected virtual page in stage-2 with a
unique tag (manually, right now, but Kees Cook has some magic that
does the same via alloc_tag.h), and this works really well to track
specific resources and resource modification semantics "over" a generic
protection ring.

I think, though, that the code you provided could be used to bootstrap
such a system by using the overlay to protect a similar page tag lookup
table, which then can provide the fine-grained protection semantics.

I.e. use this baseline to isolate a secure monitor system.

Hopefully that makes sense! (-:

> 
> - kpkeys_set_level() and kpkeys_restore_pkey_reg() are not symmetric:
>   the former takes a kpkeys level and returns a pkey register value, to
>   be consumed by the latter. It would be more intuitive to manipulate
>   kpkeys levels only. However this assumes that there is a 1:1 mapping
>   between kpkeys levels and pkey register values, while in principle
>   the mapping is 1:n (certain pkeys may be used outside the kpkeys
>   framework).

Another issue I'm not confident in is the assumption of adversary's
inability to manipulate system control registers. This is true in the
context of a Heki-like system (or any well-made HVCI), but not totally
true of a pure EL1 implementation?

> 
> - An architecture that supports kpkeys is expected to select
>   CONFIG_ARCH_HAS_KPKEYS and always enable them if available - there is
>   no CONFIG_KPKEYS to control this behaviour. Since this creates no
>   significant overhead (at least on arm64), it seemed better to keep it
>   simple. Each hardening feature does have its own option and arch
>   opt-in if needed (CONFIG_KPKEYS_HARDENED_PGTABLES,
>   CONFIG_ARCH_HAS_KPKEYS_HARDENED_PGTABLES).

There's so many pieces of data though/data structures! In this model,
you'd have a separate switch for thousands of types of data! But I do
think protecting PTs is the first step to a more complicated security
monitor, since it allows you to have integrity for specific physical
pages (or IPAs).
> 
> 
> Any comment or feedback will be highly appreciated, be it on the
> high-level approach or implementation choices!

Last note, I'd not totallllyyy trust the compiler to inline the
functions.... I've met cases where functions on memory protections
I expected to be inlined were not. I think __forceinline *may* work
here, vs standard "static inline", but am not confident/sure.

Hopefully the above is valuable at all. Thanks!

Maxwell Bland

