Return-Path: <linux-kernel+bounces-450022-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DF9859F5973
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 23:19:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 729E81635D6
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 22:19:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAE411F8ADD;
	Tue, 17 Dec 2024 22:18:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jrhvA2TP"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06E8C1CBE87;
	Tue, 17 Dec 2024 22:18:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734473937; cv=none; b=OUInVx+zUIX8EZ/sKZEO9PNOFbNQmPXEGfE0ywl0UHMK59nUugzlzpj9tYRit0N0AoCnNkFcB5Nv4ZpBnMKeHKb1Wy81DYap4NhHNSF1Y1FuhQHeQZibrUW3p627Kng4BudlK9KOC4c60yXq5Cl8rQbK3ucsXSlscsb5Rj1LZwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734473937; c=relaxed/simple;
	bh=+cDN887R3QTVEjX6KEQYRZ2FEBrq1PPQJHjIoIcdQkA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Owg72i1FZNofmErfBRFVg1UF3Bskqj9Est3lh+rYOQd8vwGLtD8EUXaWLTFsO3ZdwT1GU63o8NF3lRo8Y80GA2cSrfSbSBWdL0Rbgy6Qlo6CHXWZVOdw9AU98BDKyP+t85CMd+MgJSjslaJuGNgdxS2HTOfS7XmYpCOh+f2WJsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jrhvA2TP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 675F1C4CED3;
	Tue, 17 Dec 2024 22:18:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734473936;
	bh=+cDN887R3QTVEjX6KEQYRZ2FEBrq1PPQJHjIoIcdQkA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jrhvA2TPhEHiyGY1AEBOf7bjQ40LICdGm6WCX/VlYN5Iipffw5mlwiGh5DY4DnTzD
	 lTB+Iq+8zQz6mmCS9XLoFlWsTvHa/DcUQC/Kkgc8uaNZUNMnOEmid7ouP5lz+tsFoS
	 1dWUKe4a+LbNzee2vMvGYtegnaYDNAR7mzeuYJNiHMVK02Sw2PJFdFIiGbvGyXOZ/n
	 2TRQ2AxRP8vHrSG6xUY7IAWVDgVaF6Ic6qP+rDBUaMGR3QyFwmWc6uuII24/BSLGKk
	 pose5P2JOBVQ4QcFDKoKlbTH4f9P069F0Xa+u+jBXZVk/ZTOz0FVnAA7xEKHVmyvP4
	 /LmWOy4Vfx2tQ==
Date: Tue, 17 Dec 2024 14:18:53 -0800
From: Kees Cook <kees@kernel.org>
To: jeffxu@chromium.org
Cc: akpm@linux-foundation.org, keescook@chromium.org, jannh@google.com,
	torvalds@linux-foundation.org, adhemerval.zanella@linaro.org,
	oleg@redhat.com, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org, linux-mm@kvack.org,
	jorgelo@chromium.org, sroettger@google.com, ojeda@kernel.org,
	adobriyan@gmail.com, anna-maria@linutronix.de, mark.rutland@arm.com,
	linus.walleij@linaro.org, Jason@zx2c4.com, deller@gmx.de,
	rdunlap@infradead.org, davem@davemloft.net, hch@lst.de,
	peterx@redhat.com, hca@linux.ibm.com, f.fainelli@gmail.com,
	gerg@kernel.org, dave.hansen@linux.intel.com, mingo@kernel.org,
	ardb@kernel.org, Liam.Howlett@oracle.com, mhocko@suse.com,
	42.hyeyoo@gmail.com, peterz@infradead.org, ardb@google.com,
	enh@google.com, rientjes@google.com, groeck@chromium.org,
	mpe@ellerman.id.au, Vlastimil Babka <vbabka@suse.cz>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Andrei Vagin <avagin@gmail.com>,
	Dmitry Safonov <0x7f454c46@gmail.com>,
	Mike Rapoport <mike.rapoport@gmail.com>,
	Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
Subject: Re: [PATCH v4 1/1] exec: seal system mappings
Message-ID: <202412171248.409B10D@keescook>
References: <20241125202021.3684919-1-jeffxu@google.com>
 <20241125202021.3684919-2-jeffxu@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241125202021.3684919-2-jeffxu@google.com>

On Mon, Nov 25, 2024 at 08:20:21PM +0000, jeffxu@chromium.org wrote:
> Seal vdso, vvar, sigpage, uprobes and vsyscall.
> 
> Those mappings are readonly or executable only, sealing can protect
> them from ever changing or unmapped during the life time of the process.
> For complete descriptions of memory sealing, please see mseal.rst [1].
> 
> System mappings such as vdso, vvar, and sigpage (for arm) are
> generated by the kernel during program initialization, and are
> sealed after creation.
> [...]
>  
> +	exec.seal_system_mappings = [KNL]
> +			Format: { no | yes }
> +			Seal system mappings: vdso, vvar, sigpage, vsyscall,
> +			uprobe.
> +			- 'no':  do not seal system mappings.
> +			- 'yes': seal system mappings.
> +			This overrides CONFIG_SEAL_SYSTEM_MAPPINGS=(y/n)
> +			If not specified or invalid, default is the value set by
> +			CONFIG_SEAL_SYSTEM_MAPPINGS.
> +			This option has no effect if CONFIG_64BIT=n

I know there is a v5 coming, but I wanted to give my thoughts to help
shape it based on the current discussion threads.

The callers of _install_special_mapping() cover what is mentioned here.
The vdso is very common (arm, arm64, csky, hexagon, loongarch, mips,
parisc, powerpc, riscv, s390, sh, sparc, x86, um). For those with vdso,
some also have vvar (arm, arm64, loongarch, mips, powerpc, riscv, s390,
sparc, x86). After that, I see a few extra things, in addition to
sigpage and uprobes as mentioned already in the patch:

arm sigpage
arm64 compat vectors (what is this for arm?)
arm64 compat sigreturn (what is this for arm?)
nios2 kuser helpers
uprobes

As mentioned in the patch, there is also the x86_64 vsyscall mapping which
eludes a regular grep since it's not using _install_special_mapping() :)

So I guess the question is: can we mseal all of these universally under
a common knob? Do the different uses mean we need finer granularity of
knob, and do different architectures need flexibility here too? The
patch handles the arch question with CONFIG_ARCH_HAS_SEAL_SYSTEM_MAPPINGS
(which I think will be renamed with s/SEAL/MSEAL/ if I am following the
threads). This seems a good solution to me. My question is
about if sigpage, vectors, and sigreturn can also be included? (It seems
like the answer is "yes", but I didn't see mention of the arm64 compat
mappings.)

Linus has expressed the desire that security features be available by
default if they don't break existing userspace and that they be compiled
in if possible (rather than be behind a CONFIG) so that code paths are
being exercised to gain the most exposure to finding bugs. To that end,
it's best to have a kernel command line to control it if it isn't safe
to have always enabled. This is how we've handled _many_ features so that
the code is built into the kernel, but that end users (e.g. distro users)
can enable/disable a feature without rebuilding the entire kernel.

For a "built into the kernel but default disabled unless enabled at boot
time" example see:

config RANDOMIZE_KSTACK_OFFSET
        bool "Support for randomizing kernel stack offset on syscall entry" if EXPERT
        default y
        depends on HAVE_ARCH_RANDOMIZE_KSTACK_OFFSET
...
config RANDOMIZE_KSTACK_OFFSET_DEFAULT
        bool "Default state of kernel stack offset randomization"
        depends on RANDOMIZE_KSTACK_OFFSET
...
#ifdef CONFIG_RANDOMIZE_KSTACK_OFFSET
DEFINE_STATIC_KEY_MAYBE_RO(CONFIG_RANDOMIZE_KSTACK_OFFSET_DEFAULT,
                           randomize_kstack_offset);
...
early_param("randomize_kstack_offset", early_randomize_kstack_offset);


For an example of the older "not built into the kernel but when built in
can be turned off at boot time" that predated Linus's recommendation see:

config HARDENED_USERCOPY
        bool "Harden memory copies between kernel and userspace"
...
static DEFINE_STATIC_KEY_FALSE_RO(bypass_usercopy_checks);
...
__setup("hardened_usercopy=", parse_hardened_usercopy);

(This should arguably be "default y" in the kernel these days, but
whatever.)

So, if we want to have a CONFIG_MSEAL_SYSTEM_MAPPINGS at all, it should
be "default y" since we have the ...ARCH_HAS... config already, and then
add a CONFIG_MSEAL_SYSTEM_MAPPINGS_DEFAULT that is off by default (since
we expect there may be userspace impact) and tie _that_ to the kernel
command-line so that end users can use it, or system builders can enable
CONFIG_MSEAL_SYSTEM_MAPPINGS_DEFAULT.

For the command line name, if a namespace is desired, I'd agree that
naming this "mseal.special_mappings" is reasonable. It does change process
behavior, so I'm also not opposed to "process.mseal_special_mappings", and
it happens at exec, so "exec.mseal_special_mappings" is fine by me too.
I think the main question would be: will there be other things under the
proposed "mseal", "process", or "exec" namespace? I'd like to encourage
things being logically grouped since we have SO MANY already. :)

Also from discussions it sounds like there may need to be even finer-gain
control, likely via prctl, for dealing with the CRIU case. The proposal
is to provide an opt-out prctl with CAP_CHECKPOINT_RESTORE? I think this
is reasonable and lets this all work without a new CONFIG. I imagine it
would look like:

criu process (which has CAP_CHECKPOINT_RESTORE):
	- prctl(GET_MSEAL_SYSTEM_MAPPINGS)
	- if set:
		- remember we need to mseal mappings
		- prctl(SET_MSEAL_SYSTEM_MAPPINGS, 0)
		- re-exec with --mseal-system-mappings (or something)
	- perform the "fork a tree to restore" work
	- in each child, move around all the mappings
		- if we need to mseal mappings:
			- prctl(SET_MSEAL_SYSTEM_MAPPINGS, 1)
			- mseal each system mapping
		- eventually drop CAP_CHECKPOINT_RESTORE
		- become the restored process

Does that all sound right? If so I think Jeff has all the details needed
to spin a v5.

-Kees

-- 
Kees Cook

