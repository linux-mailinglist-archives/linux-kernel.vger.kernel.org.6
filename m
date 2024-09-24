Return-Path: <linux-kernel+bounces-337432-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B2411984A0F
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 18:57:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 422251F22901
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 16:57:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BA7A1AC423;
	Tue, 24 Sep 2024 16:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UD7ku4q2"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAB571AB6E2
	for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 16:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727197068; cv=none; b=TkLRvAu/G/TGCH4it1czS1JFU9auDiTFuqY7Nk1IEP2ZyFtwPB8NeU0CkW0xpZw6OiMsGF2ayhmHKVaxWt654RRfWLa6otKe4riupBF/g3otcDReCQqiiVaLmQeU4LLEJ359Mld0CxG+HnPqkGqzNlxWfeyAR6FkgZpqKJ5X7Ik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727197068; c=relaxed/simple;
	bh=zstY32M94VZryIVPisbQkcDAiGXynfPJylInEQIvakc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cWpM42YdaIBUM2Uxx4nnXRA2ypHuNpLnbRVfyXGktfQaMytlOpv0uN++NMev0CKvB13MTdUBmKRkUYsrAneUqfSEk8rs/jV58V8Eelexs9ARt+RUGZV61O2M2Rk4hJklo8gfTQaIeKXtPkeVqKF7LZWczorHWMYRBqr6bzS8mhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UD7ku4q2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66D3BC4AF0B
	for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 16:57:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727197068;
	bh=zstY32M94VZryIVPisbQkcDAiGXynfPJylInEQIvakc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=UD7ku4q29kQJ7PVzhQXRh30OEB/Goe74rsM8Gf0Go+qVGyEpJqnOiFWwGyaeiL/gm
	 zJa3a3vZ2rlr0jq3FwFJeDxO+a75HCUAqHp50ANw3+YeT9VCBfX0Ge7xV9Py4kvs51
	 4s9fyrD8Vg2p5IoE/5senBx+mWwAdnMcrdbcu3wrD9EAW9EXfkns2XtKKPaqzmJAjl
	 67rQZo0fRhjRLE36STM4fT8ShuIrWtwov2cBhbuUVtkl6KMftJGCqQDyuIu7YsN7Xw
	 Oa/rnUUiqCHzzx/iKgH4LHyKSx4d0jIXss+Qo3QHG0pOrFDdK6wlsHR/994Fuy/bo5
	 WNPJdMC+tEp/A==
Received: by mail-il1-f169.google.com with SMTP id e9e14a558f8ab-3a0be4d803eso18179645ab.0
        for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 09:57:48 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVf4PYuWz3k+NxaQmg+ak3/VuMRTA7TrATRphlt1IZQGyyZ8bQ3OCFQ3cEw1+OFSWBHlZKAofeeF8GRN1M=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9+0W8RFJxpOauuxSKj7hrdSLXy9P4BRnzvH8gd0q9qdpg3GpG
	pXNyusDu263Ye2Df8R9iduUW0o2cGJT9qT13Kfzq6fcDQDRfPMnstpjELDUsAKMMdpHK4TsZvvQ
	DadOS51/o0i9hTFScrKPJXLjIQFU=
X-Google-Smtp-Source: AGHT+IEBtAtiHVV5tAquKBVykVcUtaeiBUT0zkN3jsxHxU4/FsR5cm8OwqgbdapeLQYpCRrEL3xnphhGhBHcYZZhcTY=
X-Received: by 2002:a05:6e02:178d:b0:39e:6e47:814d with SMTP id
 e9e14a558f8ab-3a26d6f98bcmr1675855ab.2.1727197067740; Tue, 24 Sep 2024
 09:57:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <daf2370f5456cbf1660bbdc13621559fb3f2f6cc.camel@linux.ibm.com>
 <Zq1NksrG9blyN-KR@slm.duckdns.org> <e3069da05fb1676f8faad88b9a4dfc4a6cef4175.camel@linux.ibm.com>
 <Zru5_UmEmWhNaPyo@slm.duckdns.org> <fa56b39990dd0b90f971018f5abb7352c60af3b1.camel@linux.ibm.com>
 <ZsTwoWJQcnsJhYbe@slm.duckdns.org> <3da12c96daecaa055c478816f5e86c7b44a04d53.camel@linux.ibm.com>
 <ZszKI2GA-8yparh_@slm.duckdns.org> <Zul6l-S_JulEnDQw@mtj.duckdns.org>
 <516106abdf5c922ee19dffd9eb69ea3f9e20e54a.camel@linux.ibm.com>
 <ZvGxlcMwFOmUBfr9@slm.duckdns.org> <CAADnVQ+OYuaS9wYa2_aF8XFo7LcaSKbCeLwfC_z9j1Qe-eV3nw@mail.gmail.com>
 <ab72231540149a7dd367cbf30d17b12af14c6387.camel@linux.ibm.com>
In-Reply-To: <ab72231540149a7dd367cbf30d17b12af14c6387.camel@linux.ibm.com>
From: Song Liu <song@kernel.org>
Date: Tue, 24 Sep 2024 09:57:36 -0700
X-Gmail-Original-Message-ID: <CAPhsuW4-rkKVwWeOLhkK5gX5zO0FND+bB4vR4dbT7O1G=ZJajg@mail.gmail.com>
Message-ID: <CAPhsuW4-rkKVwWeOLhkK5gX5zO0FND+bB4vR4dbT7O1G=ZJajg@mail.gmail.com>
Subject: Re: [sched_ext/for-6.11]: Issue with BPF Scheduler during CPU Hotplug
To: Aboorva Devarajan <aboorvad@linux.ibm.com>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>, Tejun Heo <tj@kernel.org>, 
	David Vernet <void@manifault.com>, LKML <linux-kernel@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, hbathini@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 24, 2024 at 5:00=E2=80=AFAM Aboorva Devarajan
<aboorvad@linux.ibm.com> wrote:
>
> On Tue, 2024-09-24 at 10:03 +0200, Alexei Starovoitov wrote:
> > On Mon, Sep 23, 2024 at 8:21=E2=80=AFPM Tejun Heo <tj@kernel.org> wrote=
:
> > > Hello,
> > >
> > > (cc'ing Alexei and Andrii for the BPF part)
> > >
> > > On Mon, Sep 23, 2024 at 08:26:32PM +0530, Aboorva Devarajan wrote:
> > > > Sharing the crash logs observed in PowerPC here for general referen=
ce, FYI:
> > > >
> > > > [ 8638.891964] Kernel attempted to read user page (a8) - exploit at=
tempt? (uid: 0)
> > > > [ 8638.892002] BUG: Kernel NULL pointer dereference on read at 0x00=
0000a8
> > > > [ 8638.892019] Faulting instruction address: 0xc0000000004e7cc0
> > > > [ 8638.892038] Oops: Kernel access of bad area, sig: 11 [#1]
> > > > [ 8638.892060] LE PAGE_SIZE=3D64K MMU=3DRadix SMP NR_CPUS=3D2048 NU=
MA PowerNV
> > > > [ 8638.892080] Modules linked in: nf_conntrack_netlink nfnetlink xf=
rm_user xfrm_algo xt_addrtype
> > > > br_netfilter xt_CHECKSUM xt_MASQUERADE xt_conntrack ipt_REJECT nf_r=
eject_ipv4 xt_tcpudp
> > > >  ip6table_mangle ip6table_nat iptable_mangle iptable_nat nf_nat nf_=
conntrack nf_defrag_ipv6
> > > > nf_defrag_ipv4 ebtable_filter ebtables vhost_vsock vmw_vsock_virtio=
_transport_common ip6tabl
> > > > e_filter ip6_tables vhost vhost_iotlb iptable_filter vsock bridge s=
tp llc kvm_hv kvm joydev
> > > > input_leds mac_hid at24 ofpart cmdlinepart uio_pdrv_genirq ibmpower=
nv opal_prd ipmi_powernv
> > > > powernv_flash uio binfmt_misc sch_fq_codel nfsd mtd ipmi_devintf ip=
mi_msghandler auth_rpcgss
> > > > jc42 ramoops reed_solomon ip_tables x_tables autofs4 raid10 raid456=
 async_raid6_recov async
> > > > _memcpy async_pq async_xor async_tx raid1 raid0 dm_mirror dm_region=
_hash dm_log mlx5_ib ib_uverbs
> > > > ib_core mlx5_core hid_generic usbhid hid ast i2c_algo_bit drm_shmem=
_helper drm_kms_hel
> > > > per vmx_crypto drm mlxfw crct10dif_vpmsum crc32c_vpmsum psample tls=
 tg3 ahci libahci
> > > > drm_panel_orientation_quirks
> > > > [ 8638.892621] CPU: 62 UID: 0 PID: 5591 Comm: kworker/62:2 Not tain=
ted 6.11.0-rc4+ #2
> > > > [ 8638.892663] Hardware name: 8335-GTW POWER9 0x4e1203 opal:skiboot=
-v6.5.3-35-g1851b2a06 PowerNV
> > > > [ 8638.892693] Workqueue: events bpf_prog_free_deferred
> > > > [ 8638.892735] NIP:  c0000000004e7cc0 LR: c0000000004e7bbc CTR: c00=
00000003a9b30
> > > > [ 8638.892798] REGS: c000000ea4cbf7f0 TRAP: 0300   Not tainted  (6.=
11.0-rc4+)
> > > > [ 8638.892862] MSR:  9000000000009033 <SF,HV,EE,ME,IR,DR,RI,LE>  CR=
: 42a00284  XER: 00000000
> > > > [ 8638.892915] CFAR: c0000000004e7bb8 DAR: 00000000000000a8 DSISR: =
40000000 IRQMASK: 1
> > > > [ 8638.892915] GPR00: c0000000004e7bbc c000000ea4cbfa90 c0000000028=
37f00 0000000000000005
> > > > [ 8638.892915] GPR04: 0000000000000015 0000000000000009 00000000000=
00009 c000000004840b00
> > > > [ 8638.892915] GPR08: ffffffffffffffff 00000000ffffe000 fffffffffff=
fffff 000001937b55db50
> > > > [ 8638.892915] GPR12: 0000000000200000 c000007ffdfac300 c0000000031=
b1fc8 0000000000010000
> > > > [ 8638.892915] GPR16: c00000000000018e 000000007fffffff 00000000000=
00000 000000000000e1c0
> > > > [ 8638.892915] GPR20: 61c8864680b583eb 0000000000000000 00000000000=
00000 00000000000de1d5
> > > > [ 8638.892915] GPR24: 0000000000000000 c000000003da4408 c000000003d=
a4400 c000000003da43f8
> > > > [ 8638.892915] GPR24: 0000000000000000 c000000003da4408 c000000003d=
a4400 c000000003da43f8
> > > > [ 8638.892915] GPR28: 0000000000000000 0000000000000000 00000000000=
00000 c000000ea4cbfa90
> > > > [ 8638.893350] NIP [c0000000004e7cc0] walk_to_pmd+0x80/0x240

With "BUG: Kernel NULL pointer dereference on read at 0x000000a8" (from abo=
ve),
it appears bpf_arch_text_invalidate() is racing with
text_area_cpu_down_mm(), which
sets cpu_patching_context.mm to NULL?

Am I going in the right direction?

> > > > [ 8638.893380] LR [c0000000004e7bbc] __get_locked_pte+0x4c/0xd0
> > > > [ 8638.893398] Call Trace:
> > > > [ 8638.893407] [c000000ea4cbfa90] [c000000ea4cbfb20] 0xc000000ea4cb=
fb20 (unreliable)
> > > > [ 8638.893429] [c000000ea4cbfaf0] [c0000000004e7bbc] __get_locked_p=
te+0x4c/0xd0
> > > > [ 8638.893457] [c000000ea4cbfb40] [c0000000000b1dd0] patch_instruct=
ions+0x130/0x630
> > > > [ 8638.893500] [c000000ea4cbfc10] [c000000000123180] bpf_arch_text_=
invalidate+0x80/0xd0
> > > > [ 8638.893552] [c000000ea4cbfc60] [c0000000003a7508] bpf_prog_pack_=
free+0x138/0x2f0
> > > > [ 8638.893584] [c000000ea4cbfd10] [c0000000003a7e38] bpf_jit_binary=
_pack_free+0x48/0xa0
> > > > [ 8638.893617] [c000000ea4cbfd50] [c000000000123258] bpf_jit_free+0=
x88/0x100
> > > > [ 8638.893667] [c000000ea4cbfd90] [c0000000003a9d70] bpf_prog_free_=
deferred+0x240/0x280
> > > > [ 8638.893725] [c000000ea4cbfde0] [c0000000001a6828] process_schedu=
led_works+0x268/0x520
> > > > [ 8638.893767] [c000000ea4cbfee0] [c0000000001a9ed0] worker_thread+=
0x3f0/0x590
> > > > [ 8638.893809] [c000000ea4cbff80] [c0000000001b37b0] kthread+0x1a0/=
0x1c0
> > > > [ 8638.893862] [c000000ea4cbffe0] [c00000000000d030] start_kernel_t=
hread+0x14/0x18
> > > > [ 8638.893913] Code: 3cc20157 3b63c4f8 3b45c500 3929c510 3b26c508 3=
940ffff e87b0000 e8ba0000
> > > > 81290000 e8d90000 38830010 7d494830 <e87d00a8> 7ce42a14 7d2948f8 7d=
073214
> > > > [ 8638.894003] ---[ end trace 0000000000000000 ]---
> > > > [ 8639.098185] pstore: backend (nvram) writing error (-1)
> > > > [ 8639.098205]
> > > > [ 8639.098215] note: kworker/62:2[5591] exited with irqs disabled
> > > > [ 8798.806603] ------------[ cut here ]------------
> > > > [ 8798.806631] WARNING: CPU: 62 PID: 3769 at kernel/kthread.c:76 kt=
hread_set_per_cpu+0x40/0xd0

This warning also seems relevant. Are running the work queue on a cpu
that is going away?

Thanks,
Song

