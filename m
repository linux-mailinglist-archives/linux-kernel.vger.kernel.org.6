Return-Path: <linux-kernel+bounces-336722-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 531B1983FD2
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 10:03:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7D5121C2264C
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 08:03:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B6271494D4;
	Tue, 24 Sep 2024 08:03:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J7Rtgk6m"
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9724142E67
	for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 08:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727164995; cv=none; b=rSAf+ulwKF0L4faTH4Of5gRdzEzMLF6FmLKV0xcVt8EPn1CWBtieAxDQvykOXp9eKyomGXqEwxrywDfoAoafuvLZ2Fg9Qel07o+jxyX4zP2R+eRY01uYCaWJMn1pDGmRy9mZOJfhuYd5Q/UuH0BUb1N6NnugYkzRB7Fz/t36hfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727164995; c=relaxed/simple;
	bh=DMiUZPnXjb4C5IZwmsQee4DJVzNjpxV8BKMj+8oFwog=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XWPsAZ8T6EDqDGreVamSDSUj4YUCSNUifYMjbqH4YzyQYlV9t8TE5A1Ds9FJt4JsuoyjhLE5XhL+V7clC6xsiDjpV5M6cAo1PruZfTqAnKQhaZb5EEJSnH2t10N7iNpUlBZBDGrvzpBuj+9JAgDG/mXK67zbxCNPpyHOU1aM1RI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J7Rtgk6m; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-375e5c12042so2757712f8f.3
        for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 01:03:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727164992; x=1727769792; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d6jf9zfZvVuSrAo4AaUP9SmSxCWvK0O8C0dU1gcvsLQ=;
        b=J7Rtgk6mx1LKm3CJDtVe52q1K19yDlel98JjTqMlbl0N1Jixe+yZj8t2jCEaEfG0a1
         mBBszmhlgrUupdKboIVboYhp/cw+HX8pWUOda/HnNZlMiR4YidJtI/g5jIcKX3VLyRfe
         KadvjDTyy3JImD2/9eo35GsdWctFCrvlfb8GXeHyv+n6phYtlWdRDrRf+TNex5yyaMMH
         EddI1HHYG6AJas7S7kXfc8qchqkscseQxL81cc1i+5dyJm4GBbPCgYJipNkpz2+xs09D
         qy3Rgy2XWqU34m9fambZ1NcjZJEV2yJnc8aqnN5a6+l6K3C36TP1rFDPtaS5fp3oGnfJ
         w9lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727164992; x=1727769792;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d6jf9zfZvVuSrAo4AaUP9SmSxCWvK0O8C0dU1gcvsLQ=;
        b=sgsXBFLuXoaAqC5m0Wg3LC82fuinlDeZdn18XeeayUbFcmPtvbOeuRgU23v0LYBiA2
         dXmwzVpF9O3rwGUzyB5f8QLNNvSAA2eTvdVzmy0l6dvoc0+i+npV0OF/05cBezr9Z5lA
         PP75umrI5xxa+J4nVaXBifdx7y1p8pCem13YkQVp8SHrTNWYFyqLqKFSHn6YMfkZZH65
         0Um9cYZDGXcjw2PI55rZLqJjIHm3ZcTved0O+VSGuz9LMlAi16O01+fzgDY/K6sZFTQd
         gQOnB7/qvdYTnpbppftFFVlVrhWNbIVEFkYipLgI9mRSnnFwrmyp0RXHMrdmvrhyJii0
         0emg==
X-Forwarded-Encrypted: i=1; AJvYcCXOzjB3srWfhs0Jz/M/4ETt8f2Gn1iVFmGaWEDp0+0hXn5cbA6JFZIL7hhpV8aCvZkEiBDdN8RqlL3MPVw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyy5ufvjYRkE/xBlIVE4Qqg2x46tp3D32X3w91eO5AABH5jDFbH
	fUqIj26pixF+LvruMJSTBgpPRs345CtSbwHi+OY7Ntq6JMb4eC91bSJHC73WOYUJ0GRqdzZcUZv
	oBKHsvBPPUCGIhWDKz0eGlCsB9MRQfE0u/JM=
X-Google-Smtp-Source: AGHT+IFg05l6AqWc8wxp4R+FVtbU/elAmC5UJpJ6dqfcOr4pKe3TbnLcvnosuswmhM88Zl69f9duXCvwf9IRVt46Q6w=
X-Received: by 2002:adf:fa41:0:b0:374:bfc4:b62f with SMTP id
 ffacd0b85a97d-37a4225215fmr7560988f8f.3.1727164991712; Tue, 24 Sep 2024
 01:03:11 -0700 (PDT)
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
 <516106abdf5c922ee19dffd9eb69ea3f9e20e54a.camel@linux.ibm.com> <ZvGxlcMwFOmUBfr9@slm.duckdns.org>
In-Reply-To: <ZvGxlcMwFOmUBfr9@slm.duckdns.org>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 24 Sep 2024 10:03:00 +0200
Message-ID: <CAADnVQ+OYuaS9wYa2_aF8XFo7LcaSKbCeLwfC_z9j1Qe-eV3nw@mail.gmail.com>
Subject: Re: [sched_ext/for-6.11]: Issue with BPF Scheduler during CPU Hotplug
To: Tejun Heo <tj@kernel.org>
Cc: Aboorva Devarajan <aboorvad@linux.ibm.com>, David Vernet <void@manifault.com>, 
	LKML <linux-kernel@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 23, 2024 at 8:21=E2=80=AFPM Tejun Heo <tj@kernel.org> wrote:
>
> Hello,
>
> (cc'ing Alexei and Andrii for the BPF part)
>
> On Mon, Sep 23, 2024 at 08:26:32PM +0530, Aboorva Devarajan wrote:
> > Sharing the crash logs observed in PowerPC here for general reference, =
FYI:
> >
> > [ 8638.891964] Kernel attempted to read user page (a8) - exploit attemp=
t? (uid: 0)
> > [ 8638.892002] BUG: Kernel NULL pointer dereference on read at 0x000000=
a8
> > [ 8638.892019] Faulting instruction address: 0xc0000000004e7cc0
> > [ 8638.892038] Oops: Kernel access of bad area, sig: 11 [#1]
> > [ 8638.892060] LE PAGE_SIZE=3D64K MMU=3DRadix SMP NR_CPUS=3D2048 NUMA P=
owerNV
> > [ 8638.892080] Modules linked in: nf_conntrack_netlink nfnetlink xfrm_u=
ser xfrm_algo xt_addrtype
> > br_netfilter xt_CHECKSUM xt_MASQUERADE xt_conntrack ipt_REJECT nf_rejec=
t_ipv4 xt_tcpudp
> >  ip6table_mangle ip6table_nat iptable_mangle iptable_nat nf_nat nf_conn=
track nf_defrag_ipv6
> > nf_defrag_ipv4 ebtable_filter ebtables vhost_vsock vmw_vsock_virtio_tra=
nsport_common ip6tabl
> > e_filter ip6_tables vhost vhost_iotlb iptable_filter vsock bridge stp l=
lc kvm_hv kvm joydev
> > input_leds mac_hid at24 ofpart cmdlinepart uio_pdrv_genirq ibmpowernv o=
pal_prd ipmi_powernv
> > powernv_flash uio binfmt_misc sch_fq_codel nfsd mtd ipmi_devintf ipmi_m=
sghandler auth_rpcgss
> > jc42 ramoops reed_solomon ip_tables x_tables autofs4 raid10 raid456 asy=
nc_raid6_recov async
> > _memcpy async_pq async_xor async_tx raid1 raid0 dm_mirror dm_region_has=
h dm_log mlx5_ib ib_uverbs
> > ib_core mlx5_core hid_generic usbhid hid ast i2c_algo_bit drm_shmem_hel=
per drm_kms_hel
> > per vmx_crypto drm mlxfw crct10dif_vpmsum crc32c_vpmsum psample tls tg3=
 ahci libahci
> > drm_panel_orientation_quirks
> > [ 8638.892621] CPU: 62 UID: 0 PID: 5591 Comm: kworker/62:2 Not tainted =
6.11.0-rc4+ #2
> > [ 8638.892663] Hardware name: 8335-GTW POWER9 0x4e1203 opal:skiboot-v6.=
5.3-35-g1851b2a06 PowerNV
> > [ 8638.892693] Workqueue: events bpf_prog_free_deferred
> > [ 8638.892735] NIP:  c0000000004e7cc0 LR: c0000000004e7bbc CTR: c000000=
0003a9b30
> > [ 8638.892798] REGS: c000000ea4cbf7f0 TRAP: 0300   Not tainted  (6.11.0=
-rc4+)
> > [ 8638.892862] MSR:  9000000000009033 <SF,HV,EE,ME,IR,DR,RI,LE>  CR: 42=
a00284  XER: 00000000
> > [ 8638.892915] CFAR: c0000000004e7bb8 DAR: 00000000000000a8 DSISR: 4000=
0000 IRQMASK: 1
> > [ 8638.892915] GPR00: c0000000004e7bbc c000000ea4cbfa90 c000000002837f0=
0 0000000000000005
> > [ 8638.892915] GPR04: 0000000000000015 0000000000000009 000000000000000=
9 c000000004840b00
> > [ 8638.892915] GPR08: ffffffffffffffff 00000000ffffe000 fffffffffffffff=
f 000001937b55db50
> > [ 8638.892915] GPR12: 0000000000200000 c000007ffdfac300 c0000000031b1fc=
8 0000000000010000
> > [ 8638.892915] GPR16: c00000000000018e 000000007fffffff 000000000000000=
0 000000000000e1c0
> > [ 8638.892915] GPR20: 61c8864680b583eb 0000000000000000 000000000000000=
0 00000000000de1d5
> > [ 8638.892915] GPR24: 0000000000000000 c000000003da4408 c000000003da440=
0 c000000003da43f8
> > [ 8638.892915] GPR24: 0000000000000000 c000000003da4408 c000000003da440=
0 c000000003da43f8
> > [ 8638.892915] GPR28: 0000000000000000 0000000000000000 000000000000000=
0 c000000ea4cbfa90
> > [ 8638.893350] NIP [c0000000004e7cc0] walk_to_pmd+0x80/0x240
> > [ 8638.893380] LR [c0000000004e7bbc] __get_locked_pte+0x4c/0xd0
> > [ 8638.893398] Call Trace:
> > [ 8638.893407] [c000000ea4cbfa90] [c000000ea4cbfb20] 0xc000000ea4cbfb20=
 (unreliable)
> > [ 8638.893429] [c000000ea4cbfaf0] [c0000000004e7bbc] __get_locked_pte+0=
x4c/0xd0
> > [ 8638.893457] [c000000ea4cbfb40] [c0000000000b1dd0] patch_instructions=
+0x130/0x630
> > [ 8638.893500] [c000000ea4cbfc10] [c000000000123180] bpf_arch_text_inva=
lidate+0x80/0xd0
> > [ 8638.893552] [c000000ea4cbfc60] [c0000000003a7508] bpf_prog_pack_free=
+0x138/0x2f0
> > [ 8638.893584] [c000000ea4cbfd10] [c0000000003a7e38] bpf_jit_binary_pac=
k_free+0x48/0xa0
> > [ 8638.893617] [c000000ea4cbfd50] [c000000000123258] bpf_jit_free+0x88/=
0x100
> > [ 8638.893667] [c000000ea4cbfd90] [c0000000003a9d70] bpf_prog_free_defe=
rred+0x240/0x280
> > [ 8638.893725] [c000000ea4cbfde0] [c0000000001a6828] process_scheduled_=
works+0x268/0x520
> > [ 8638.893767] [c000000ea4cbfee0] [c0000000001a9ed0] worker_thread+0x3f=
0/0x590
> > [ 8638.893809] [c000000ea4cbff80] [c0000000001b37b0] kthread+0x1a0/0x1c=
0
> > [ 8638.893862] [c000000ea4cbffe0] [c00000000000d030] start_kernel_threa=
d+0x14/0x18
> > [ 8638.893913] Code: 3cc20157 3b63c4f8 3b45c500 3929c510 3b26c508 3940f=
fff e87b0000 e8ba0000
> > 81290000 e8d90000 38830010 7d494830 <e87d00a8> 7ce42a14 7d2948f8 7d0732=
14
> > [ 8638.894003] ---[ end trace 0000000000000000 ]---
> > [ 8639.098185] pstore: backend (nvram) writing error (-1)
> > [ 8639.098205]
> > [ 8639.098215] note: kworker/62:2[5591] exited with irqs disabled
> > [ 8798.806603] ------------[ cut here ]------------
> > [ 8798.806631] WARNING: CPU: 62 PID: 3769 at kernel/kthread.c:76 kthrea=
d_set_per_cpu+0x40/0xd0
> > [ 8798.806653] Modules linked in: nf_conntrack_netlink nfnetlink xfrm_u=
ser xfrm_algo xt_addrtype
> > br_netfilter xt_CHECKSUM xt_MASQUERADE xt_conntrack ipt_REJECT nf_rejec=
t_ipv4 xt_tcpudp ip6table_mangle
> > ip6table_nat iptable_mangle iptable_nat nf_nat nf_conntrack nf_defrag_i=
pv6 nf_defrag_ipv
> > -----------------------------------------------------------------------=
-------------------
> >
> > We will look at this issue as it is specific to PowerPC.
>
> This does look like a bug in BPF proper.

powerpc doesn't have bpf trampolines, struct-ops and
all the plumbing necessary to run sched-ext.

Aboorva,

please help test this patch set instead that is trying to add it:
https://lore.kernel.org/all/20240915205648.830121-1-hbathini@linux.ibm.com/

