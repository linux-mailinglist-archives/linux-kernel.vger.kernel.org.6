Return-Path: <linux-kernel+bounces-516070-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F260A36C9C
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Feb 2025 09:24:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 41316170C03
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Feb 2025 08:24:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B4371922DE;
	Sat, 15 Feb 2025 08:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ONDnj+DW"
Received: from out-182.mta0.migadu.com (out-182.mta0.migadu.com [91.218.175.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A349D531
	for <linux-kernel@vger.kernel.org>; Sat, 15 Feb 2025 08:24:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739607854; cv=none; b=X5Y3T2Hx35DgMrbJlPDHqfGGXsnCG+LfxrrXsHnhji33pi73JPWmDD5gnitvOXpYvyMbM7gcb3eID+v4p2o+wsj3yzuIZcQ+OM0CUlhSSLJqR4mS7gEAb74nMOqoFvHxZ6nn/CVVkh1Gy+guu4SnId1hijY6GOobs3+lPLLHzHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739607854; c=relaxed/simple;
	bh=rdSKbbowuaC1k0JdIAz968nF++zG2YTQpuC1grZhOhc=;
	h=MIME-Version:Date:Content-Type:From:Message-ID:Subject:To:Cc:
	 In-Reply-To:References; b=iI5XdUjesKc+VxyiyLaqNn8pI4WpmzGrF3jvIjHcpHZ4adb3JXt2I0DDR16imwKeKCxPkXUN3e12NthEf3ZhFuwzm+4sxxWrfY39EUhz+3Px03DpdhpPKKHRRSagG9d21l0QyKKvnnWBFqvUNSznpis8yCERoxPZmLHjYoDbvo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ONDnj+DW; arc=none smtp.client-ip=91.218.175.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1739607848;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rdSKbbowuaC1k0JdIAz968nF++zG2YTQpuC1grZhOhc=;
	b=ONDnj+DW0Vk+1xIOKRX2gMsrKjF7m0YXCLxenLBymWKk3cm4A4jncD3elBlF9/i55HR33o
	8RMxKFdurvaBGlhVgsL6TFMoDG+PenGnCJgUVr23zt9xANhxbBwNyu2P1ot9TAufkbg6Pa
	3KKLOhMxGbwJtvebL/0xEmWkDjqBiWs=
Date: Sat, 15 Feb 2025 08:24:07 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Yosry Ahmed" <yosry.ahmed@linux.dev>
Message-ID: <8bda689f466f7426df696ec52648592f262091bb@linux.dev>
TLS-Required: No
Subject: Re: [PATCH v2] mm: Fix possible NULL pointer dereference in
 __swap_duplicate
To: "gaoxu" <gaoxu2@honor.com>, "Andrew Morton" <akpm@linux-foundation.org>,
 linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org, "Suren  Baghdasaryan" <surenb@google.com>,
 "Barry Song" <21cnbao@gmail.com>, "yipengxiang" <yipengxiang@honor.com>
In-Reply-To: <afecae337e5b4b2b8ce4e5a591957f89@honor.com>
References: <afecae337e5b4b2b8ce4e5a591957f89@honor.com>
X-Migadu-Flow: FLOW_OUT

February 14, 2025 at 10:52 PM, "gaoxu" <gaoxu2@honor.com> wrote:



>=20
>=20Add a NULL check on the return value of swp_swap_info in __swap_dupli=
cate
>=20
>=20to prevent crashes caused by NULL pointer dereference.
>=20
>=20The reason why swp_swap_info() returns NULL is unclear; it may be due=
 to
>=20
>=20CPU cache issues or DDR bit flips. The probability of this issue is v=
ery
>=20
>=20small, and the stack info we encountered is as follows=EF=BC=9A
>=20
>=20Unable to handle kernel NULL pointer dereference at virtual address
>=20
>=200000000000000058
>=20
>=20[RB/E]rb_sreason_str_set: sreason_str set null_pointer
>=20
>=20Mem abort info:
>=20
>=20 ESR =3D 0x0000000096000005
>=20
>=20 EC =3D 0x25: DABT (current EL), IL =3D 32 bits
>=20
>=20 SET =3D 0, FnV =3D 0
>=20
>=20 EA =3D 0, S1PTW =3D 0
>=20
>=20 FSC =3D 0x05: level 1 translation fault
>=20
>=20Data abort info:
>=20
>=20 ISV =3D 0, ISS =3D 0x00000005, ISS2 =3D 0x00000000
>=20
>=20 CM =3D 0, WnR =3D 0, TnD =3D 0, TagAccess =3D 0
>=20
>=20 GCS =3D 0, Overlay =3D 0, DirtyBit =3D 0, Xs =3D 0
>=20
>=20user pgtable: 4k pages, 39-bit VAs, pgdp=3D00000008a80e5000
>=20
>=20[0000000000000058] pgd=3D0000000000000000, p4d=3D0000000000000000,
>=20
>=20pud=3D0000000000000000
>=20
>=20Internal error: Oops: 0000000096000005 [#1] PREEMPT SMP
>=20
>=20Skip md ftrace buffer dump for: 0x1609e0
>=20
>=20...
>=20
>=20pc : swap_duplicate+0x44/0x164
>=20
>=20lr : copy_page_range+0x508/0x1e78
>=20
>=20sp : ffffffc0f2a699e0
>=20
>=20x29: ffffffc0f2a699e0 x28: ffffff8a5b28d388 x27: ffffff8b06603388
>=20
>=20x26: ffffffdf7291fe70 x25: 0000000000000006 x24: 0000000000100073
>=20
>=20x23: 00000000002d2d2f x22: 0000000000000008 x21: 0000000000000000
>=20
>=20x20: 00000000002d2d2f x19: 18000000002d2d2f x18: ffffffdf726faec0
>=20
>=20x17: 0000000000000000 x16: 0010000000000001 x15: 0040000000000001
>=20
>=20x14: 0400000000000001 x13: ff7ffffffffffb7f x12: ffeffffffffffbff
>=20
>=20x11: ffffff8a5c7e1898 x10: 0000000000000018 x9 : 0000000000000006
>=20
>=20x8 : 1800000000000000 x7 : 0000000000000000 x6 : ffffff8057c01f10
>=20
>=20x5 : 000000000000a318 x4 : 0000000000000000 x3 : 0000000000000000
>=20
>=20x2 : 0000006daf200000 x1 : 0000000000000001 x0 : 18000000002d2d2f
>=20
>=20Call trace:
>=20
>=20 swap_duplicate+0x44/0x164
>=20
>=20 copy_page_range+0x508/0x1e78
>=20
>=20 copy_process+0x1278/0x21cc
>=20
>=20 kernel_clone+0x90/0x438
>=20
>=20 __arm64_sys_clone+0x5c/0x8c
>=20
>=20 invoke_syscall+0x58/0x110
>=20
>=20 do_el0_svc+0x8c/0xe0
>=20
>=20 el0_svc+0x38/0x9c
>=20
>=20 el0t_64_sync_handler+0x44/0xec
>=20
>=20 el0t_64_sync+0x1a8/0x1ac
>=20
>=20Code: 9139c35a 71006f3f 54000568 f8797b55 (f9402ea8)
>=20
>=20---[ end trace 0000000000000000 ]---
>=20
>=20Kernel panic - not syncing: Oops: Fatal exception
>=20
>=20SMP: stopping secondary CPUs
>=20
>=20The patch seems to only provide a workaround, but there are no more
>=20
>=20effective software solutions to handle the bit flips problem. This pa=
th
>=20
>=20will change the issue from a system crash to a process exception, the=
reby
>=20
>=20reducing the impact on the entire machine.
>=20
>=20Signed-off-by: gaoxu <gaoxu2@honor.com>
>=20
>=20Reviewed-by: Yosry Ahmed <yosry.ahmed@linux.dev>


I did not review this patch, I only made a suggestion. Please only add Re=
view tags when explicitly given.

