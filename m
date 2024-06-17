Return-Path: <linux-kernel+bounces-217586-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD63990B1CE
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 16:26:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D314A1C23185
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 14:26:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BC2D1ABCBA;
	Mon, 17 Jun 2024 13:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xry111.site header.i=@xry111.site header.b="U+3Yx4vN"
Received: from xry111.site (xry111.site [89.208.246.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B1C3198853
	for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2024 13:38:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.208.246.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718631504; cv=none; b=DthjxFGlvcBGnGFQTsyWOO/6jFfek+LpHgXTNpZECzvvci2yPcPG/P70GNofW+ID8rKi36zuQqctLZt9K0T+Xw7Z7dzgleB3rc2J5jQKzrun992oPWujOpo5BqVbpLkVEvQxBC4yKDnBAVeKC64FkLhWsIF6LInhkcLFXjsVM5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718631504; c=relaxed/simple;
	bh=akWFXFL9APSeZUybdYwbaKWZJ+YSl23R6WS8xUNuMz4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=NkZkdBzpyc90bOfTj+gHW2141xYoIvHZULn3wID6n20IL0oz3AbK/VZa2fl5sb/60pBwO3stH0E2UE4Hc+bSPdTQKEBzRpftBm3iUOt0VaDRs+1RDXR4GKl2Tpjk6cANOfwndbz2rl+pd0KnjsBxXCYfwJtjh8WxuQ8Bb9dmhZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xry111.site; spf=pass smtp.mailfrom=xry111.site; dkim=pass (1024-bit key) header.d=xry111.site header.i=@xry111.site header.b=U+3Yx4vN; arc=none smtp.client-ip=89.208.246.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xry111.site
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xry111.site
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xry111.site;
	s=default; t=1718631496;
	bh=akWFXFL9APSeZUybdYwbaKWZJ+YSl23R6WS8xUNuMz4=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=U+3Yx4vNAiPitIxm1W3qEsYpkCOC/D0rM4UzLSFkheUmCZ0efYVicNfA8w8l14WGx
	 ZTJB4/Ecew6fjurxAgwvnX5+Ee1AByQjroNY9Jz0NY0Hf8sqFuZV3f0W7DOGLr0Dzu
	 8YQ20DhF2cA1vtYDSa4dP/QbH4weuk2FPW8NlVRA=
Received: from [127.0.0.1] (unknown [IPv6:2001:470:683e::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-384) server-digest SHA384)
	(Client did not present a certificate)
	(Authenticated sender: xry111@xry111.site)
	by xry111.site (Postfix) with ESMTPSA id C2D1566A19;
	Mon, 17 Jun 2024 09:38:10 -0400 (EDT)
Message-ID: <6e14e41b728437743fddebf78f7981ea15f6b8a8.camel@xry111.site>
Subject: Re: [PATCH] loongarch: Only select HAVE_OBJTOOL and allow ORC
 unwinder if the inline assembler supports R_LARCH_{32,64}_PCREL
From: Xi Ruoyao <xry111@xry111.site>
To: Huacai Chen <chenhuacai@kernel.org>, chenglulu <chenglulu@loongson.cn>
Cc: Jinyang He <hejinyang@loongson.cn>, Nathan Chancellor
 <nathan@kernel.org>,  Peter Zijlstra <peterz@infradead.org>, WANG Xuerui
 <kernel@xen0n.name>, Tiezhu Yang <yangtiezhu@loongson.cn>,  Nick
 Desaulniers <ndesaulniers@google.com>, Bill Wendling <morbo@google.com>,
 Justin Stitt <justinstitt@google.com>,  Youling Tang
 <tangyouling@kylinos.cn>, loongarch@lists.linux.dev,
 linux-kernel@vger.kernel.org,  llvm@lists.linux.dev,
 mengqinggang@loongson.cn, cailulu@loongson.cn,  wanglei@loongson.cn,
 luweining@loongson.cn, Yujie Liu <yujie.liu@intel.com>,  Heng Qi
 <hengqi@linux.alibaba.com>, Tejun Heo <tj@kernel.org>
Date: Mon, 17 Jun 2024 21:38:08 +0800
In-Reply-To: <CAAhV-H6j0WgN6QpHBYcdprdWBpcQq4ObYK5YcE=TVsDNxGFEtA@mail.gmail.com>
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
	 <329dac82e09dfc75e77ae93ebbeacdec1dc9ff7f.camel@xry111.site>
	 <CAAhV-H5Wz=U4kbX+tXt1qoCr6RaEDkzZXV7B=tgU_8o+X-NtVQ@mail.gmail.com>
	 <a97cd0f2e2cac10253d6b5cdd0ace3db3b220535.camel@xry111.site>
	 <CAAhV-H7hhh3Jes0jMrg82+KJCa7GQZW=F9bDtktFh=eazMDX9w@mail.gmail.com>
	 <12099e6fb7ba377f3dcf6686e0b37200b9818708.camel@xry111.site>
	 <CAAhV-H6j0WgN6QpHBYcdprdWBpcQq4ObYK5YcE=TVsDNxGFEtA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.2 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2024-06-17 at 21:11 +0800, Huacai Chen wrote:



> > select HAVE_OBJTOOL if AS_HAS_EXPLICIT_RELOCS && AS_HAS_THIN_ADD_SUB &&=
 !CC_IS_CLANG && !RUST
> Maybe we needn't consider RUST here?

Rustc does use $fp that objtool cannot handle as at now.  It can be
demonstrated with an over-aligned type, similar to Clang:

$ cat t.rs
#[repr(C, align(64))]
struct X(i32);

extern { fn f(x: &X) -> i64; }

#[no_mangle]
fn g() -> i64 {
    let x =3D X(114514);
    unsafe {f(&x)}
}
$ rustc t.rs --emit=3Dasm --crate-type=3Dstaticlib -O
$ grep fp t.s
	st.d	$fp, $sp, 112
	addi.d	$fp, $sp, 128
	addi.d	$sp, $fp, -128
	ld.d	$fp, $sp, 112

The kernel uses rust-bindgen to generate some .rs file from C headers.=20
And __attribute__((aligned(x))) is directly translated to
repr(align(x)).  As __attribute__((aligned(x))) is very common in the
kernel I expect objtool will fail to handle some object code from rustc.

> And can we think AS_HAS_THIN_ADD_SUB always imply
> AS_HAS_EXPLICIT_RELOCS here?

Maybe, AFAIK there's no assembler using thin add-sub but not explicit
relocs.

--=20
Xi Ruoyao <xry111@xry111.site>
School of Aerospace Science and Technology, Xidian University

