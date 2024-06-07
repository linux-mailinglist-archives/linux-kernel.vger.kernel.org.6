Return-Path: <linux-kernel+bounces-205602-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5460E8FFE02
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 10:29:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D47082830A6
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 08:29:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DC3A15B0FF;
	Fri,  7 Jun 2024 08:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xry111.site header.i=@xry111.site header.b="MHI9wAYF"
Received: from xry111.site (xry111.site [89.208.246.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF82B15B0F6
	for <linux-kernel@vger.kernel.org>; Fri,  7 Jun 2024 08:29:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.208.246.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717748969; cv=none; b=A7npU6gAeqMWKNc+meOlB3bFOS9/WRo4oiOdxivggo+gRVGz7CMDHQ3B0IlPEzLFaW33mtkATFeLwqP+PGCH2tgMcp0P8c9ni5SL/ZAnjuaRU5QtcNaJRXlppybjYveIwEJcKd0y9UqkAZmqCY9gjJ2y6C/5S0ePMl6WNQl4RBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717748969; c=relaxed/simple;
	bh=aK10eVoy1pHPzRBaMWuJDogzvbBebhllculFYvTNhSk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=UXP0NDNDvcopAk1elfgB2yz82qkPhhIOk+jBTKd3DpsOErVtNZcbKAu+ycwxEUKT0By7ECQXtzhEq6CuXYH+FIk5oUq5JGscxk+F6wmyWLOgAJLh4YfLss6llf1ye7qGXW9ymjiZuetZTgN++CdWNcS5VXWi3bgIkwpqjpY+K9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xry111.site; spf=pass smtp.mailfrom=xry111.site; dkim=pass (1024-bit key) header.d=xry111.site header.i=@xry111.site header.b=MHI9wAYF; arc=none smtp.client-ip=89.208.246.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xry111.site
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xry111.site
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xry111.site;
	s=default; t=1717748954;
	bh=aK10eVoy1pHPzRBaMWuJDogzvbBebhllculFYvTNhSk=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=MHI9wAYFhtYurtAizVkehIHAmwceOkFYntOBS7R63hOUkb1teR2c/+603lWI4bevD
	 RZDCTUB1xIGLwYx0xEqV7cLsfKATMUsDTzbYxeJf2S929RFhEZs1sysIK6CKsxwti8
	 jCyoVTysq/k2e41RpmIF0+lfXv0iohfCf9AEUX8s=
Received: from [127.0.0.1] (unknown [IPv6:2001:470:683e::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-384) server-digest SHA384)
	(Client did not present a certificate)
	(Authenticated sender: xry111@xry111.site)
	by xry111.site (Postfix) with ESMTPSA id 359A76709A;
	Fri,  7 Jun 2024 04:29:11 -0400 (EDT)
Message-ID: <329dac82e09dfc75e77ae93ebbeacdec1dc9ff7f.camel@xry111.site>
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
Date: Fri, 07 Jun 2024 16:29:09 +0800
In-Reply-To: <2bd6ae20-ec56-c1a2-c5dd-e8c978a376d3@loongson.cn>
References: <20240604150741.30252-1-xry111@xry111.site>
	 <20240605054328.GA279426@thelio-3990X>
	 <b55b8cb2c52f2c3701c83353586130b8dc237ee2.camel@xry111.site>
	 <20240605062548.GF279426@thelio-3990X>
	 <f8ef61773b0119b8573fc0fed9ad0a8b43061efd.camel@xry111.site>
	 <444ec2031ef6ca016cbfa8dfedc51bddc8529ba7.camel@xry111.site>
	 <ada035690e446909c3cdbf9a43a92def96020615.camel@xry111.site>
	 <82b7e6ea-c2cb-6364-ebe9-bff928028408@loongson.cn>
	 <1c132209a612e2e8953f0b458fc01853120db9a9.camel@xry111.site>
	 <2bf11cd2-8449-acda-f5ad-659c38cb018e@loongson.cn>
	 <96a2e8a80c06772b64fcbdba42e1dae2d68a53a7.camel@xry111.site>
	 <2bd6ae20-ec56-c1a2-c5dd-e8c978a376d3@loongson.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.2 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2024-06-07 at 15:14 +0800, Jinyang He wrote:
> > =C2=A0=C2=A0=C2=A0=C2=A0 Note: on RISC-V and LoongArch, the stack slot =
for the previous frame
> > =C2=A0=C2=A0=C2=A0=C2=A0 pointer is stored at fp[-2] instead of fp[0]. =
See [Consider
> > =C2=A0=C2=A0=C2=A0=C2=A0 standardising which stack slot fp points
> > =C2=A0=C2=A0=C2=A0=C2=A0 to](https://github.com/riscv-non-isa/riscv-elf=
-psabi-doc/issues/18)
> > =C2=A0=C2=A0=C2=A0=C2=A0 for the RISC-V discussion.
>=20
> In most cases the $fp is saved at cfa-16. But for va args, something
> becomes different at LoongArch (I do not know the case of riscv), the
> $fp isn't saved at cfa-16. (e.g. printk?)

Oops indeed.  Even with a very simple case:

int sum(int a, int b) {
	return a + b;
}

with -fno-omit-frame-pointer we get:

sum:
	addi.d	$r3,$r3,-16
	st.d	$r22,$r3,8
	addi.d	$r22,$r3,16
	ld.d	$r22,$r3,8
	add.w	$r4,$r4,$r5
	addi.d	$r3,$r3,16
	jr	$r1

So for leaf functions (where we don't save $ra) $fp is saved at cfa-8.

> I feel that the update_cfi_state should be arch specific. I believe
> that some logic can be reused, but each arch may have its own logic.

I agree it now.

--=20
Xi Ruoyao <xry111@xry111.site>
School of Aerospace Science and Technology, Xidian University

