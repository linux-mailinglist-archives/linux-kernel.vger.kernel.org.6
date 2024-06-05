Return-Path: <linux-kernel+bounces-203084-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 316058FD633
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 21:06:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B788EB222B6
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 19:06:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03BA913AD22;
	Wed,  5 Jun 2024 19:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xry111.site header.i=@xry111.site header.b="NUG7dJI0"
Received: from xry111.site (xry111.site [89.208.246.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BCDB1EB27
	for <linux-kernel@vger.kernel.org>; Wed,  5 Jun 2024 19:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.208.246.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717614360; cv=none; b=p8htz40xRQ9HndfpbSGl/gWan/V2kg+EPBoGDUK9F/+km6E+mokmhmGFMfND9lhJZROXMyMa0U1qonbGd2sKoP1B5xjJ+/cp58/Hw5laW+gz8e5UzrzmfgP0MmeJ4/WmeDv14FYPura8n/eJbshdkit7PmGPSpcx8Wur3n5lHuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717614360; c=relaxed/simple;
	bh=Ce36X2cTUtKRp4XTVyTLX9lqpwhRE2M6qyo6ifMz/3E=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=JTsciG1Z19QHbWj82FGY/2PINd7L+XnwDpsb/Hmfi51klcYpeC4CyN2G4pVCecgnFolCP6eEJwbre4MKa1UwyqGV9CgALa9U9AKsUqyGY2WQKQkP3H9ZrXVqqrZx78oUzqFLuLCsm0kd17POB8lccPxE3CL+lkvgvtnHw4KZ370=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xry111.site; spf=pass smtp.mailfrom=xry111.site; dkim=pass (1024-bit key) header.d=xry111.site header.i=@xry111.site header.b=NUG7dJI0; arc=none smtp.client-ip=89.208.246.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xry111.site
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xry111.site
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xry111.site;
	s=default; t=1717614355;
	bh=Ce36X2cTUtKRp4XTVyTLX9lqpwhRE2M6qyo6ifMz/3E=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=NUG7dJI0TZhq3N24yuUjWEb/1BemaYA0qTnft/6rhAwhurP9cWQm30U6C6FUij9oT
	 i/9O+75Zon9/mP70/IY+zpr5G0esJ6PK6asMLdiLm7rXnh24EDI97pA/ik8sdCG4cO
	 l37Eqj8uct9cvswqrRg5EghtyT124LeGjVvySKG4=
Received: from [IPv6:240e:358:111d:4300:dc73:854d:832e:6] (unknown [IPv6:240e:358:111d:4300:dc73:854d:832e:6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-384) server-digest SHA384)
	(Client did not present a certificate)
	(Authenticated sender: xry111@xry111.site)
	by xry111.site (Postfix) with ESMTPSA id 6D50766DF6;
	Wed,  5 Jun 2024 15:05:47 -0400 (EDT)
Message-ID: <1c132209a612e2e8953f0b458fc01853120db9a9.camel@xry111.site>
Subject: Re: [PATCH] loongarch: Only select HAVE_OBJTOOL and allow ORC
 unwinder if the inline assembler supports R_LARCH_{32,64}_PCREL
From: Xi Ruoyao <xry111@xry111.site>
To: Jinyang He <hejinyang@loongson.cn>, Nathan Chancellor
 <nathan@kernel.org>,  Peter Zijlstra <peterz@infradead.org>
Cc: Huacai Chen <chenhuacai@kernel.org>, WANG Xuerui <kernel@xen0n.name>, 
 Tiezhu Yang <yangtiezhu@loongson.cn>, Nick Desaulniers
 <ndesaulniers@google.com>, Bill Wendling <morbo@google.com>, Justin Stitt
 <justinstitt@google.com>, Youling Tang <tangyouling@kylinos.cn>,
 loongarch@lists.linux.dev,  linux-kernel@vger.kernel.org,
 llvm@lists.linux.dev, mengqinggang@loongson.cn,  cailulu@loongson.cn,
 wanglei@loongson.cn, luweining@loongson.cn, Yujie Liu
 <yujie.liu@intel.com>, Heng Qi <hengqi@linux.alibaba.com>, Tejun Heo
 <tj@kernel.org>
Date: Thu, 06 Jun 2024 03:05:41 +0800
In-Reply-To: <82b7e6ea-c2cb-6364-ebe9-bff928028408@loongson.cn>
References: <20240604150741.30252-1-xry111@xry111.site>
	 <20240605054328.GA279426@thelio-3990X>
	 <b55b8cb2c52f2c3701c83353586130b8dc237ee2.camel@xry111.site>
	 <20240605062548.GF279426@thelio-3990X>
	 <f8ef61773b0119b8573fc0fed9ad0a8b43061efd.camel@xry111.site>
	 <444ec2031ef6ca016cbfa8dfedc51bddc8529ba7.camel@xry111.site>
	 <ada035690e446909c3cdbf9a43a92def96020615.camel@xry111.site>
	 <82b7e6ea-c2cb-6364-ebe9-bff928028408@loongson.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.2 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2024-06-05 at 23:47 +0800, Jinyang He wrote:
> In our 419 repo this func has been renamed arch_update_insn_state (, now =
it
> should be arch_update_cfi_state) and give some actions to deal with the
> frame pointer case. If we support it we may deal with some case but for=
=20
> clang...
>=20
> .global test
> .type test,@function
> test:
>=20
> addi.d=C2=A0 $sp,$sp,-448
> st.d=C2=A0=C2=A0=C2=A0 $ra,$sp,440
> st.d=C2=A0=C2=A0=C2=A0 $fp,$sp,432
> addi.d=C2=A0 $fp,$sp,448
>=20
> # do something=C2=A0 <- not change $sp

This is simplified.  In the real code $sp is changed, something like:

bstrins.d $sp, $zero, 5, 0

$fp is needed to allow restoring $sp after realigning $sp for some local
over-aligned variables, as demonstrated by this example:

struct x { _Alignas(64) char buf[128]; };

void f(struct x *p);
void g()
{
	struct x x =3D { .buf =3D "1145141919810" };
	f(&x);
}

GCC does not align $sp, it produces the aligned address for x from an
unaligned $sp instead:

addi.d $a0, $sp, 63
srli.d $a0, $a0, 6
slli.d $a0, $a0, 6

thus there's no need to use $fp.

/* snip */

> <- restore regs from non-cfa ?
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ld.d=C2=A0=C2=A0=C2=A0 $=
ra, $sp, 8=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 # 8-byte Folded R=
eload=C2=A0=20

/* snip */

> Maybe Clang have anything wrong?

I don't think we must restore regs based on $fp just because CFA is
based on $fp.  The .cfi directives only provides *one* possible way to
restore the regs.  This way is convenient to the unwinder, but not
necessarily convenient to the CPU thus the real instruction sequence can
use a different way.  They only need to be "equivalent", not necessarily
"exactly same."

Also note that .cfi_* directives are completely irrelevant for objtool.
THe objtool synthesizes the ORC unwind info from the machine
instructions, not the DWARF unwind info coded with .cfi_*.

The entire point of ORC is avoiding DWARF.  It's even named ORC because
ORC and DWARF are sworn enemies in some tales.

--=20
Xi Ruoyao <xry111@xry111.site>
School of Aerospace Science and Technology, Xidian University

