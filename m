Return-Path: <linux-kernel+bounces-362645-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AD2A999B794
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Oct 2024 01:01:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5C40D1F2191D
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Oct 2024 23:01:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73F8F14AD02;
	Sat, 12 Oct 2024 23:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="Fix23e89"
Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6AA922083
	for <linux-kernel@vger.kernel.org>; Sat, 12 Oct 2024 23:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728774077; cv=none; b=UqBFEPGpvJoGfjOxjmvrTOrljtT/WxpU3nkgAZtQGY71oFu9b4LQPkUd1BU7pNTdEJVaneeN77I8C0CP+62tjqm47P0s3iwC8SCkryCQCD7lQLFpIcqWfNQriVu0RY/AR4TpwH9NLOZmM7VTD71+SSvaN+1pXifYE6Np2VcpDHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728774077; c=relaxed/simple;
	bh=co5GXOxu90k1lK24uqnvtMiwx0+ODa5nauKbgKgnWIY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=RPoo3C9mEJ7PiJAvjyzfk9zd0pvWG/Gz3Qj+XJr8e964cgujksj1u35kLhBV9LKIjYtH6Orc8SXJCfkEwRKapLm2dm3aRgJ2cRvLM80JXsqAcqV/H+gjLXDFoqc0AowkTqwBL8hW2cW94zqUoQbzFjWH2GwBGrIU3HaEhX5+aY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au; spf=pass smtp.mailfrom=ellerman.id.au; dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b=Fix23e89; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ellerman.id.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
	s=201909; t=1728774072;
	bh=4aU2nl6tLvom+i+sZeM7Uw3RWtjRV1QtoP+sWiq08zY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=Fix23e89gyJdW6xHHRlrS3tJfuy1H2o9HEepS+pomfJuTaf4GCjlnk6B3r4hS2kpT
	 CTI6ZgP9Mvr0cRxVKTlU0ugjoCw264aEYgdl0IdqBE6/hwW+H6gxC7ut4FmVm7h8Ms
	 a6AYR4p0TPVh5osyW3jwzKe7R5zJHPJx1VhRymgL84+9O7o11NCh3nFnjKo4sEqAVX
	 Mt71Q665b5G6L0u9sMyjLdG8NGzrDHTqV4Lo93QD7+Cs0W3/KIQ15h13vMOm/QO+Py
	 WgXCAeb/c5ToOqQyPe2leZ3hQKOT+OR6Qi6xR4k8yNfPqjsndso5oqdBL6Bd7vMHws
	 OMb20AplXi+8Q==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4XQzWC4jw2z4x8Q;
	Sun, 13 Oct 2024 10:01:11 +1100 (AEDT)
From: Michael Ellerman <patch-notifications@ellerman.id.au>
To: Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, Naveen N Rao <naveen@kernel.org>, Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
In-Reply-To: <2b851399bd87e81c6ccb87ea3a7a6b32c7aa04d7.1728118396.git.christophe.leroy@csgroup.eu>
References: <2b851399bd87e81c6ccb87ea3a7a6b32c7aa04d7.1728118396.git.christophe.leroy@csgroup.eu>
Subject: Re: [PATCH] powerpc/8xx: Fix kernel DTLB miss on dcbz
Message-Id: <172877404775.499764.16227434899101631721.b4-ty@ellerman.id.au>
Date: Sun, 13 Oct 2024 10:00:47 +1100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

On Sat, 05 Oct 2024 10:53:29 +0200, Christophe Leroy wrote:
> Following OOPS is encountered while loading test_bpf module
> on powerpc 8xx:
> 
> [  218.835567] BUG: Unable to handle kernel data access on write at 0xcb000000
> [  218.842473] Faulting instruction address: 0xc0017a80
> [  218.847451] Oops: Kernel access of bad area, sig: 11 [#1]
> [  218.852854] BE PAGE_SIZE=16K PREEMPT CMPC885
> [  218.857207] SAF3000 DIE NOTIFICATION
> [  218.860713] Modules linked in: test_bpf(+) test_module
> [  218.865867] CPU: 0 UID: 0 PID: 527 Comm: insmod Not tainted 6.11.0-s3k-dev-09856-g3de3d71ae2e6-dirty #1280
> [  218.875546] Hardware name: MIAE 8xx 0x500000 CMPC885
> [  218.880521] NIP:  c0017a80 LR: beab859c CTR: 000101d4
> [  218.885584] REGS: cac2bc90 TRAP: 0300   Not tainted  (6.11.0-s3k-dev-09856-g3de3d71ae2e6-dirty)
> [  218.894308] MSR:  00009032 <EE,ME,IR,DR,RI>  CR: 55005555  XER: a0007100
> [  218.901290] DAR: cb000000 DSISR: c2000000
> [  218.901290] GPR00: 000185d1 cac2bd50 c21b9580 caf7c030 c3883fcc 00000008 cafffffc 00000000
> [  218.901290] GPR08: 00040000 18300000 20000000 00000004 99005555 100d815e ca669d08 00000369
> [  218.901290] GPR16: ca730000 00000000 ca2c004c 00000000 00000000 0000035d 00000311 00000369
> [  218.901290] GPR24: ca732240 00000001 00030ba3 c3800000 00000000 00185d48 caf7c000 ca2c004c
> [  218.941087] NIP [c0017a80] memcpy+0x88/0xec
> [  218.945277] LR [beab859c] test_bpf_init+0x22c/0x3c90 [test_bpf]
> [  218.951476] Call Trace:
> [  218.953916] [cac2bd50] [beab8570] test_bpf_init+0x200/0x3c90 [test_bpf] (unreliable)
> [  218.962034] [cac2bde0] [c0004c04] do_one_initcall+0x4c/0x1fc
> [  218.967706] [cac2be40] [c00a2ec4] do_init_module+0x68/0x360
> [  218.973292] [cac2be60] [c00a5194] init_module_from_file+0x8c/0xc0
> [  218.979401] [cac2bed0] [c00a5568] sys_finit_module+0x250/0x3f0
> [  218.985248] [cac2bf20] [c000e390] system_call_exception+0x8c/0x15c
> [  218.991444] [cac2bf30] [c00120a8] ret_from_syscall+0x0/0x28
> 
> [...]

Applied to powerpc/fixes.

[1/1] powerpc/8xx: Fix kernel DTLB miss on dcbz
      https://git.kernel.org/powerpc/c/8956c582ac6b1693a351230179f898979dd00bdf

cheers

