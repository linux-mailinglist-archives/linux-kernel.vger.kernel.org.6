Return-Path: <linux-kernel+bounces-527155-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48F8AA407FA
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Feb 2025 12:40:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 192667AB5B3
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Feb 2025 11:37:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00651209693;
	Sat, 22 Feb 2025 11:38:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=natalenko.name header.i=@natalenko.name header.b="fC8I3ywp"
Received: from prime.voidband.net (prime.voidband.net [199.247.17.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9B25208977
	for <linux-kernel@vger.kernel.org>; Sat, 22 Feb 2025 11:38:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.247.17.104
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740224293; cv=none; b=JW1l8wwVYP0MmBFbz1XMnjv2VCYq8XQrvKVWWnZ76hDdgQgR1UDMTGIc2Dy0B3Tk1hXwx0P63xUeFLlqJ2U9FV83xI8qq1rTXoIFJtb9HRBr0AgZlzzmAqvzLqb1uGpp8bXBH9e88w+SdIdoPbKlxxfb6UEeUTBRBIuN+ruLB1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740224293; c=relaxed/simple;
	bh=qyth9Oc4Wpb02qU3Te4lB8Rkf4rISc158oIM6uUGQuk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gHwD7FPzIQuMuYLfsl+eCXkQXx1ELYRcsye2UfQj8KvrD2Qv6Nfljk46GwXtj0Uw1z3NwMTR8oaEbBQbnbUO992GMPm8snLQvniuJpXpAnlp/c0n+ZPw6/tQjk1sHZXWQRjM1kqSIWFWneKHRyHrehSSb7WPAmI2BWIuAncT3IA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=natalenko.name; spf=pass smtp.mailfrom=natalenko.name; dkim=pass (1024-bit key) header.d=natalenko.name header.i=@natalenko.name header.b=fC8I3ywp; arc=none smtp.client-ip=199.247.17.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=natalenko.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=natalenko.name
Received: from spock.localnet (unknown [212.20.115.26])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by prime.voidband.net (Postfix) with ESMTPSA id E3D016312FC1;
	Sat, 22 Feb 2025 12:30:07 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=natalenko.name;
	s=dkim-20170712; t=1740223808;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ktOZKhfEfHmMYs+Ns1mcOIQBk4+2if98X80BLbm79UM=;
	b=fC8I3ywpAJWVJZiR674i1N17F0Z5r7XPwO+G60UlmKVCnnEHxwqxSEEQUPufgIzDfYji4l
	PohctQf/IaCVz4Ccf3rDw5TC35EJSBRYioO+9QFwy9m79Wkym5yMs627R/l/nSEFFs+5JJ
	A1iF8SG5aLnykbx1GoWN5EvfcOsZzug=
From: Oleksandr Natalenko <oleksandr@natalenko.name>
To: x86@kernel.org, Rik van Riel <riel@surriel.com>
Cc: linux-kernel@vger.kernel.org, bp@alien8.de, peterz@infradead.org,
 dave.hansen@linux.intel.com, zhengqi.arch@bytedance.com,
 nadav.amit@gmail.com, thomas.lendacky@amd.com, kernel-team@meta.com,
 linux-mm@kvack.org, akpm@linux-foundation.org, jackmanb@google.com,
 jannh@google.com, mhklinux@outlook.com, andrew.cooper3@citrix.com,
 Manali.Shukla@amd.com
Subject: Re: [PATCH v12 00/16] AMD broadcast TLB invalidation
Date: Sat, 22 Feb 2025 12:29:54 +0100
Message-ID: <5861243.DvuYhMxLoT@natalenko.name>
In-Reply-To: <20250221005345.2156760-1-riel@surriel.com>
References: <20250221005345.2156760-1-riel@surriel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart6129452.lOV4Wx5bFT";
 micalg="pgp-sha256"; protocol="application/pgp-signature"

--nextPart6129452.lOV4Wx5bFT
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"; protected-headers="v1"
From: Oleksandr Natalenko <oleksandr@natalenko.name>
To: x86@kernel.org, Rik van Riel <riel@surriel.com>
Subject: Re: [PATCH v12 00/16] AMD broadcast TLB invalidation
Date: Sat, 22 Feb 2025 12:29:54 +0100
Message-ID: <5861243.DvuYhMxLoT@natalenko.name>
In-Reply-To: <20250221005345.2156760-1-riel@surriel.com>
References: <20250221005345.2156760-1-riel@surriel.com>
MIME-Version: 1.0

Hello.

On p=C3=A1tek 21. =C3=BAnora 2025 1:52:59, st=C5=99edoevropsk=C3=BD standar=
dn=C3=AD =C4=8Das Rik van Riel wrote:
> Add support for broadcast TLB invalidation using AMD's INVLPGB instructio=
n.
>=20
> This allows the kernel to invalidate TLB entries on remote CPUs without
> needing to send IPIs, without having to wait for remote CPUs to handle
> those interrupts, and with less interruption to what was running on
> those CPUs.
>=20
> Because x86 PCID space is limited, and there are some very large
> systems out there, broadcast TLB invalidation is only used for
> processes that are active on 3 or more CPUs, with the threshold
> being gradually increased the more the PCID space gets exhausted.
>=20
> Combined with the removal of unnecessary lru_add_drain calls
> (see https://lkml.org/lkml/2024/12/19/1388) this results in a
> nice performance boost for the will-it-scale tlb_flush2_threads
> test on an AMD Milan system with 36 cores:
>=20
> - vanilla kernel:           527k loops/second
> - lru_add_drain removal:    731k loops/second
> - only INVLPGB:             527k loops/second
> - lru_add_drain + INVLPGB: 1157k loops/second
>=20
> Profiling with only the INVLPGB changes showed while
> TLB invalidation went down from 40% of the total CPU
> time to only around 4% of CPU time, the contention
> simply moved to the LRU lock.
>=20
> Fixing both at the same time about doubles the
> number of iterations per second from this case.
>=20
> Some numbers closer to real world performance
> can be found at Phoronix, thanks to Michael:
>=20
> https://www.phoronix.com/news/AMD-INVLPGB-Linux-Benefits
>=20
> My current plan is to implement support for Intel's RAR
> (Remote Action Request) TLB flushing in a follow-up series,
> after this thing has been merged into -tip. Making things
> any larger would just be unwieldy for reviewers.
>=20
> v12:
>  - make sure "nopcid" command line option turns off invlpgb (Brendan)
>  - add "noinvlpgb" kernel command line option
>  - split out kernel TLB flushing differently (Dave & Yosry)
>  - split up the patch that does invlpgb flushing for user processes (Dave)
>  - clean up get_flush_tlb_info (Boris)
>  - move invlpgb_count_max initialization to get_cpu_cap (Boris)
>  - bunch more comments as requested

Somehow, this iteration breaks resume from S3. I can see it even in a QEMU =
VM:

```
[   24.373391] ACPI: PM: Low-level resume complete
[   24.373929] ACPI: PM: Restoring platform NVS memory
[   24.375024] Enabling non-boot CPUs ...
[   24.375777] smpboot: Booting Node 0 Processor 1 APIC 0x1
[   24.376463] BUG: unable to handle page fault for address: ffffffffa3ba4d=
60
[   24.377383] #PF: supervisor write access in kernel mode
[   24.377912] #PF: error_code(0x0003) - permissions violation
[   24.378413] PGD 25427067 P4D 25427067 PUD 25428063 PMD 8000000024c001a1
[   24.379020] Oops: Oops: 0003 [#1] PREEMPT SMP NOPTI
[   24.379503] CPU: 1 UID: 0 PID: 0 Comm: swapper/1 Kdump: loaded Not taint=
ed 6.14.0-pf0 #1 161e4891fb5044b2d7438cd1852eeaac0cdffab5
[   24.380650] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS unk=
nown 02/02/2022
[   24.381400] RIP: 0010:get_cpu_cap+0x39b/0x4f0
[   24.381810] Code: 08 c7 44 24 08 00 00 00 00 48 8d 4c 24 0c e8 3c 00 04 =
00 90 8b 44 24 04 89 43 64 0f b7 44 24 0c 83 c0 01 81 7b 24 09 00 00 80 <66=
> 89 05 0e ab 8b 01 0f 86 18 fd ff ff c7 44 24 14 00 00 00 00 4c
[   24.383629] RSP: 0000:ffffafbec00efe70 EFLAGS: 00010012
[   24.384155] RAX: 0000000000000001 RBX: ffff8b3fbcb19020 RCX: 00000000000=
01001
[   24.384862] RDX: 0000000000000000 RSI: ffffafbec00efe74 RDI: ffffafbec00=
efe78
[   24.385603] RBP: ffffafbec00efe88 R08: ffffafbec00efe70 R09: ffffafbec00=
efe7c
[   24.386318] R10: 0000000000002430 R11: ffff8b3fa5428000 R12: ffffafbec00=
efe8c
[   24.387014] R13: ffffafbec00efe84 R14: ffffafbec00efe80 R15: ffffafbec00=
efe70
[   24.387713] FS:  0000000000000000(0000) GS:ffff8b3fbcb00000(0000) knlGS:=
0000000000000000
[   24.388502] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   24.389074] CR2: ffffffffa3ba4d60 CR3: 0000000025422000 CR4: 00000000003=
50ef0
[   24.389769] Call Trace:
[   24.390020]  <TASK>
[   24.392234]  identify_cpu+0xd4/0x890
[   24.392593]  identify_secondary_cpu+0x12/0x40
[   24.393032]  smp_store_cpu_info+0x49/0x60
[   24.393430]  start_secondary+0x7f/0x140
[   24.393810]  common_startup_64+0x13e/0x141
[   24.394218]  </TASK>

$ scripts/faddr2line arch/x86/kernel/cpu/common.o get_cpu_cap+0x39b
get_cpu_cap+0x39b/0x500:
get_cpu_cap at =E2=80=A6/arch/x86/kernel/cpu/common.c:1063

1060         if (c->extended_cpuid_level >=3D 0x80000008) {
1061                 cpuid(0x80000008, &eax, &ebx, &ecx, &edx);
1062                 c->x86_capability[CPUID_8000_0008_EBX] =3D ebx;
1063                 invlpgb_count_max =3D (edx & 0xffff) + 1;
1064         }
```

Any idea what I'm looking at?

Thank you.

> v11:
>  - resolve conflict with CONFIG_PT_RECLAIM code
>  - a few more cleanups (Peter, Brendan, Nadav)
> v10:
>  - simplify partial pages with min(nr, 1) in the invlpgb loop (Peter)
>  - document x86 paravirt, AMD invlpgb, and ARM64 flush without IPI (Brend=
an)
>  - remove IS_ENABLED(CONFIG_X86_BROADCAST_TLB_FLUSH) (Brendan)
>  - various cleanups (Brendan)
> v9:
>  - print warning when start or end address was rounded (Peter)
>  - in the reclaim code, tlbsync at context switch time (Peter)
>  - fix !CONFIG_CPU_SUP_AMD compile error in arch_tlbbatch_add_pending (Ja=
n)
> v8:
>  - round start & end to handle non-page-aligned callers (Steven & Jan)
>  - fix up changelog & add tested-by tags (Manali)
> v7:
>  - a few small code cleanups (Nadav)
>  - fix spurious VM_WARN_ON_ONCE in mm_global_asid
>  - code simplifications & better barriers (Peter & Dave)
> v6:
>  - fix info->end check in flush_tlb_kernel_range (Michael)
>  - disable broadcast TLB flushing on 32 bit x86
> v5:
>  - use byte assembly for compatibility with older toolchains (Borislav, M=
ichael)
>  - ensure a panic on an invalid number of extra pages (Dave, Tom)
>  - add cant_migrate() assertion to tlbsync (Jann)
>  - a bunch more cleanups (Nadav)
>  - key TCE enabling off X86_FEATURE_TCE (Andrew)
>  - fix a race between reclaim and ASID transition (Jann)
> v4:
>  - Use only bitmaps to track free global ASIDs (Nadav)
>  - Improved AMD initialization (Borislav & Tom)
>  - Various naming and documentation improvements (Peter, Nadav, Tom, Dave)
>  - Fixes for subtle race conditions (Jann)
> v3:
>  - Remove paravirt tlb_remove_table call (thank you Qi Zheng)
>  - More suggested cleanups and changelog fixes by Peter and Nadav
> v2:
>  - Apply suggestions by Peter and Borislav (thank you!)
>  - Fix bug in arch_tlbbatch_flush, where we need to do both
>    the TLBSYNC, and flush the CPUs that are in the cpumask.
>  - Some updates to comments and changelogs based on questions.
>=20
>=20
>=20


=2D-=20
Oleksandr Natalenko, MSE
--nextPart6129452.lOV4Wx5bFT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEZUOOw5ESFLHZZtOKil/iNcg8M0sFAme5tTIACgkQil/iNcg8
M0uvXxAA7+ZgxXx4L/yEf4PhQTzMx6y91fs6wXJtsjppRKBWKhZsTwJoF2LEXgNw
8JYFOb+VLQsAWIYz3rwrQQyFFj4sAtKj0Td7qCDyjevTtzJlVNgW5CE4UFN2hfCi
jQ75pbV0j98lxETJBtvcWIAWWaq9+IX2kdWwcWQFb7iRk2BaGTxO6pTb+DLxqvmM
slIkNeLMs8FeV0pd2cXtDBfMWIU2bKbL2S6DbuLVgE0sa0jask03HDtpZF5ES5yU
qAfIThM5PtEirdSoOCKfu26UwAU7Jxvv0XivPTsLiRu+uoKQ6jWQ6x/Nvw+Yw4p2
36rM1a0WsdLY4bVg54LEs8qWCJnL/wWKiVy35IxfF+OSFpL+uZtOJjyH808IA+CV
J2ozvKIqaLXN4+Fw+LgjdzH5xIeL9eP/klF3hV5m/OVjO7vd1bxFz5HzbRq918if
v80jxLHjXQpY32Qfl0W0YLZVdm6G5oWhGU1N8rrhs6xv4HW96HjZwpKJxYTIQR+i
pyGXJxWPmqgr+UdnzsDw0IkNt0ElFDxpG1aMqIjD0ltD1SyYlL+o/JIV5p6Lnami
4antcNB7BqmoCFLm/ninoidG5Aio3zyAbIG08X5En/pYnTxQON9c1ZgW3vnDL2IG
zOZ4pYQt9KoaJRKSmN0PYqEHK3MJV4EECJshxl1u7dzfpJ+AcSc=
=f2BY
-----END PGP SIGNATURE-----

--nextPart6129452.lOV4Wx5bFT--




