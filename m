Return-Path: <linux-kernel+bounces-325120-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B8FCC97553A
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 16:27:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7FA52287092
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 14:27:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0812E19F12C;
	Wed, 11 Sep 2024 14:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="M1mZKwDD"
Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C912319EEA1
	for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 14:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726064815; cv=none; b=Ug5Si1jtjaYSJnuXf67MDNa0R/u9s6KVxj/nVJL7cLUd9x4mqGOlRh5VryXdgF0tP+tEyQLWDQgc6Z41zVkPvsXkqCWG5zWj5B28VoZP11MCT1hVrCwApAeTf0AU+biqLOKsVQbdt7H/pMqVGTdvgF5p/XMsp/9d2iqPi7ZCEeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726064815; c=relaxed/simple;
	bh=fKEQEHfUYvkxeOYLXoyZBvmWeUjto7+jEA+dTjpyjig=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=oUveMSS67iSxK0WII5at6NuyBWdnOs4TXEQ6MlEGVgNlIa2h7ueNuBOudLOfubdcfG1lG91fMdHfW7pqUbhFqhWYJ3SBvqVdg2/pOHbmtHGsXHw7d9fSbcRPDC4fTydS5qLEfyo9eMOsgpapqfaaMKevCd92yFCCC4XN848LPy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au; spf=pass smtp.mailfrom=ellerman.id.au; dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b=M1mZKwDD; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ellerman.id.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
	s=201909; t=1726064811;
	bh=7e0hIvnZ2WGzfCRGUxZpr1pnG85pXQrbK4xqcg3Yhw0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=M1mZKwDDObyrZmNqrYKAMuwe7H186HIc86Jlr8gU4/gmsSY+ZDzYGYFP7feC4ROae
	 HbcZgV6M6QtWc6J3IK1da6RnvSwVR76tJs8DcB0GYiwUPi611pOQ+x8gbiOT0J2s2I
	 a1eFHAt6lVDJzHNC/rK2VoyWWqFWyzyiaUGFhiOyK0/X7EnJZTDaVB/v4msCsj/cRT
	 1oQg+YayCgezeNbVDcagCbqr8gkklgpsAZM0T4JyUoX2DPebXFTzCdYZ389XOvL7pl
	 K6ENKlegb8IDXmNHbUhzWFXO8stthWzCZsGJYbVBuvJs6nO2ARYQbuiDxYYY0j9YmR
	 LitPaBO6Cq+hw==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4X3jZ25FGzz4x2d;
	Thu, 12 Sep 2024 00:26:50 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Venkat Rao Bagalkote <venkat88@linux.vnet.ibm.com>,
 peterz@infradead.org, tglx@linutronix.de
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, Sachin Sant
 <sachinp@linux.ibm.com>
Subject: Re: [PowerPC][linux-next-6.11-rc7-20240910] Kernel Warnings at
 kernel/jump_label.c:266
In-Reply-To: <ced64e0b-2ef7-48d6-b085-976aa878c017@linux.vnet.ibm.com>
References: <ced64e0b-2ef7-48d6-b085-976aa878c017@linux.vnet.ibm.com>
Date: Thu, 12 Sep 2024 00:26:49 +1000
Message-ID: <87wmjiqn9y.fsf@mail.lhotse>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Venkat Rao Bagalkote <venkat88@linux.vnet.ibm.com> writes:
> Greetings!!!
>
> I am observing kernel warnings while booting with
> linux-next-6.11-rc7-20240910 kernel. Below are the warnings.
>
> [=C2=A0=C2=A0 63.613506] WARNING: CPU: 20 PID: 214 at kernel/jump_label.c=
:266 static_key_dec+0x78/0x8c
> [=C2=A0=C2=A0 63.613518] Modules linked in: ext4 mbcache jbd2 dm_service_=
time sd_mod sg ibmvfc mlx5_core ibmvnic scsi_transport_fc ibmveth mlxfw psa=
mple dm_multipath dm_mirror dm_region_hash dm_log dm_mod fuse
> [=C2=A0=C2=A0 63.613542] CPU: 20 UID: 0 PID: 214 Comm: kworker/20:1 Not t=
ainted 6.11.0-rc7-next-20240910-auto #1
> [=C2=A0=C2=A0 63.613549] Hardware name: IBM,9080-HEX POWER10 (architected=
) 0x800200 0xf000006 of:IBM,FW1060.00 (NH1060_016) hv:phyp pSeries
> [=C2=A0=C2=A0 63.613556] Workqueue: cgroup_destroy css_free_rwork_fn
> [=C2=A0=C2=A0 63.613563] NIP:=C2=A0 c00000000048ca20 LR: c00000000048d060=
 CTR: c0000000005cb330
> [=C2=A0=C2=A0 63.613568] REGS: c00000005a1afa80 TRAP: 0700=C2=A0=C2=A0 No=
t tainted (6.11.0-rc7-next-20240910-auto)
> [=C2=A0=C2=A0 63.613573] MSR:=C2=A0 800000000282b033 <SF,VEC,VSX,EE,FP,ME=
,IR,DR,RI,LE>=C2=A0 CR: 24000884=C2=A0 XER: 20040001
> [=C2=A0=C2=A0 63.613586] CFAR: c00000000048c9cc IRQMASK: 0
> [=C2=A0=C2=A0 63.613586] GPR00: c00000000048d060 c00000005a1afd20 c000000=
0015f4300 c000000002faa440
> [=C2=A0=C2=A0 63.613586] GPR04: 0000000000000001 000000000000009e c000000=
0084bae00 000000000000009d
> [=C2=A0=C2=A0 63.613586] GPR08: 0000000000000000 0000000000000000 fffffff=
fffffffff c00000005b852780
> [=C2=A0=C2=A0 63.613586] GPR12: c0000000005cb330 c000000c7db7df00 c000000=
0001a779c c0000000084b27c0
> [=C2=A0=C2=A0 63.613586] GPR16: 0000000000000000 0000000000000000 0000000=
000000000 0000000000000000
> [=C2=A0=C2=A0 63.613586] GPR20: c000000c7b914300 c000000002de73c8 c000000=
0027b07a8 fffffffffffffef7
> [=C2=A0=C2=A0 63.613586] GPR24: 0000000000000402 c00000005b852780 c000000=
008eabc05 0000000000000010
> [=C2=A0=C2=A0 63.613586] GPR28: c000000002d2fac0 c00000000e9d6000 c000000=
070444000 c000000002faa440
> [=C2=A0=C2=A0 63.613633] NIP [c00000000048ca20] static_key_dec+0x78/0x8c
> [=C2=A0=C2=A0 63.613639] LR [c00000000048d060] __static_key_slow_dec_cpus=
locked+0x38/0xb4
> [=C2=A0=C2=A0 63.613645] Call Trace:
> [=C2=A0=C2=A0 63.613647] [c00000005a1afd20] [c00000005a1afd50] 0xc0000000=
5a1afd50 (unreliable)
> [=C2=A0=C2=A0 63.613653] [c00000005a1afd50] [c00000000048d124] static_key=
_slow_dec+0x48/0xb0
> [=C2=A0=C2=A0 63.613660] [c00000005a1afdc0] [c0000000005cb40c] mem_cgroup=
_css_free+0xdc/0x104
> [=C2=A0=C2=A0 63.613667] [c00000005a1afdf0] [c0000000002c4d58] css_free_r=
work_fn+0x70/0x394
> [=C2=A0=C2=A0 63.613673] [c00000005a1afe40] [c00000000019a7dc] process_on=
e_work+0x1fc/0x4dc
> [=C2=A0=C2=A0 63.613680] [c00000005a1afef0] [c00000000019b73c] worker_thr=
ead+0x340/0x504
> [=C2=A0=C2=A0 63.613686] [c00000005a1aff90] [c0000000001a78cc] kthread+0x=
138/0x140
> [=C2=A0=C2=A0 63.613691] [c00000005a1affe0] [c00000000000df98] start_kern=
el_thread+0x14/0x18
> [=C2=A0=C2=A0 63.613697] Code: 7c0004ac 7c074800 40820018 38600001 546306=
3e 4e800020 60000000 60000000 7ce93b78 4bffffa4 60000000 60000000 <0fe00000=
> 38600001 7c60189e 5463063e
> [=C2=A0=C2=A0 63.613711] ---[ end trace 0000000000000000 ]---
>
> Issue is introduced by the commit: de752774f38bb766941ed1bf910ba5a9f6cc6b=
f7

Which was:

  de752774f38b ("jump_label: Fix static_key_slow_dec() yet again")

And was already reported:

  https://lore.kernel.org/all/202409082005.393050e2-oliver.sang@intel.com/
  https://lore.kernel.org/all/20240910111111.2591-1-spasswolf@web.de

In today's linux-next (20240911) it has become:

  1d7f856c2ca4 ("jump_label: Fix static_key_slow_dec() yet again")

Can you test if the bug is fixed in today's linux-next?

cheers

