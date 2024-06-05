Return-Path: <linux-kernel+bounces-202807-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 887C58FD16E
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 17:14:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 377A52841C5
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 15:14:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2D6C3F8E2;
	Wed,  5 Jun 2024 15:14:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xry111.site header.i=@xry111.site header.b="VXEsz3rT"
Received: from xry111.site (xry111.site [89.208.246.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA12827701
	for <linux-kernel@vger.kernel.org>; Wed,  5 Jun 2024 15:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.208.246.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717600447; cv=none; b=NFZ1nCG7J904rKIxyvuf9OWMCeP2tVDgu3MKMkSgO60D96BoX0uch6sJ9g0WdXDeMOwpN56cFwPts243ilpu0JtiaupIfe20Lb5QC618PFzcAxNcjiz/cCKA722kVL64upF9fYcYM27R9GN2+urqDnqvSSh8GsfDrmZutKqX+xg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717600447; c=relaxed/simple;
	bh=mQFUqIv9zc3pnfC96HatcYG8i6nsVQ6fWx4sEtvBbwo=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=UgG/8pQ4R7HO80yVg7eQLIHSG6NS2XkZq3BfihmAmw8qZu5gQBrKMT6Wkvf/I4GllriklvWKh2vaQNiRSmizoKLc6BfxFKsciaKd8eO34dv3SOcGdEuaCbKjEFQUNOPPrXcNUOohmG+mQ1vHHZYOFMNd4XUfjgpbj+og2hDhvV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xry111.site; spf=pass smtp.mailfrom=xry111.site; dkim=pass (1024-bit key) header.d=xry111.site header.i=@xry111.site header.b=VXEsz3rT; arc=none smtp.client-ip=89.208.246.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xry111.site
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xry111.site
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xry111.site;
	s=default; t=1717600430;
	bh=mQFUqIv9zc3pnfC96HatcYG8i6nsVQ6fWx4sEtvBbwo=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=VXEsz3rTPcEMnFy+dmEeswrgzdhYx/qh/+b0s0gOwyImKlb5eVFUoM3lZLqBOjL/O
	 KqW2gzGhuAfYMlZE8xHs4fW7JtI10rBEvYe77gVY3xUveWOcsJffTMCvMQy72tQ2wQ
	 iZn6U4DnN3u3XG4NnyMQNwcHN0/GLulnXgNeSNIc=
Received: from [127.0.0.1] (unknown [IPv6:2001:470:683e::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-384) server-digest SHA384)
	(Client did not present a certificate)
	(Authenticated sender: xry111@xry111.site)
	by xry111.site (Postfix) with ESMTPSA id 000E267238;
	Wed,  5 Jun 2024 11:13:45 -0400 (EDT)
Message-ID: <ada035690e446909c3cdbf9a43a92def96020615.camel@xry111.site>
Subject: Re: [PATCH] loongarch: Only select HAVE_OBJTOOL and allow ORC
 unwinder if the inline assembler supports R_LARCH_{32,64}_PCREL
From: Xi Ruoyao <xry111@xry111.site>
To: Nathan Chancellor <nathan@kernel.org>, Peter Zijlstra
 <peterz@infradead.org>
Cc: Huacai Chen <chenhuacai@kernel.org>, WANG Xuerui <kernel@xen0n.name>, 
 Tiezhu Yang <yangtiezhu@loongson.cn>, Nick Desaulniers
 <ndesaulniers@google.com>, Bill Wendling <morbo@google.com>, Justin Stitt
 <justinstitt@google.com>, Youling Tang <tangyouling@kylinos.cn>, Jinyang He
 <hejinyang@loongson.cn>,  loongarch@lists.linux.dev,
 linux-kernel@vger.kernel.org, llvm@lists.linux.dev, 
 mengqinggang@loongson.cn, cailulu@loongson.cn, wanglei@loongson.cn, 
 luweining@loongson.cn, Yujie Liu <yujie.liu@intel.com>, Heng Qi
 <hengqi@linux.alibaba.com>, Tejun Heo <tj@kernel.org>
Date: Wed, 05 Jun 2024 23:13:43 +0800
In-Reply-To: <444ec2031ef6ca016cbfa8dfedc51bddc8529ba7.camel@xry111.site>
References: <20240604150741.30252-1-xry111@xry111.site>
	 <20240605054328.GA279426@thelio-3990X>
	 <b55b8cb2c52f2c3701c83353586130b8dc237ee2.camel@xry111.site>
	 <20240605062548.GF279426@thelio-3990X>
	 <f8ef61773b0119b8573fc0fed9ad0a8b43061efd.camel@xry111.site>
	 <444ec2031ef6ca016cbfa8dfedc51bddc8529ba7.camel@xry111.site>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.2 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2024-06-05 at 21:18 +0800, Xi Ruoyao wrote:
> On Wed, 2024-06-05 at 18:57 +0800, Xi Ruoyao wrote:
> > On Tue, 2024-06-04 at 23:25 -0700, Nathan Chancellor wrote:
> > > On Wed, Jun 05, 2024 at 01:54:24PM +0800, Xi Ruoyao wrote:
> > > > On Tue, 2024-06-04 at 22:43 -0700, Nathan Chancellor wrote:
> > > > > For what it's worth, I have noticed some warnings with clang that=
 I
> > > > > don't see with GCC but I only filed an issue on our GitHub and ne=
ver
> > > > > followed up on the mailing list, so sorry about that.
> > > > >=20
> > > > > https://github.com/ClangBuiltLinux/linux/issues/2024
> > > > >=20
> > > > > Might be tangential to this patch though but I felt it was worth
> > > > > mentioning.
> > > >=20
> > > > The warnings in GCC build is definitely the issue handled by this p=
atch.
> > > > But the warnings in Clang build should be a different issue.=C2=A0 =
Can you
> > > > attach the kernel/events/core.o file from the Clang build for analy=
sis?
> > > > I guess we need to disable more optimization...
> > >=20
> > > Sure thing. Let me know if there are any issues with the attachment.
> >=20
> > Thanks!=C2=A0 I've simplified it and now even...
> >=20
> > .global test
> > .type test,@function
> > test:
> >=20
> > addi.d	$sp,$sp,-448
> > st.d	$ra,$sp,440
> > st.d	$fp,$sp,432
> > addi.d	$fp,$sp,448
> >=20
> > # do something
> >=20
> > addi.d	$sp,$fp,-448
> > ld.d	$fp,$sp,432
> > ld.d	$ra,$sp,440
> > addi.d	$sp,$sp,448
> > ret
> >=20
> > .size test,.-test
> >=20
> > is enough to trigger a objtool warning:
> >=20
> > /home/xry111/t1.o: warning: objtool: test+0x20: return with modified st=
ack frame
> >=20
> > And to me this warning is bogus?
>=20
> Minimal C reproducer:
>=20
> struct x { _Alignas(64) char buf[128]; };
>=20
> void f(struct x *p);
> void g()
> {
> 	struct x x =3D { .buf =3D "1145141919810" };
> 	f(&x);
> }
>=20
> Then objtool is unhappy to the object file produced with "clang -c -O2"
> from this translation unit:
>=20
> /home/xry111/t2.o: warning: objtool: g+0x50: return with modified stack f=
rame
>=20
> It seems CFI_BP has a very specific semantic in objtool and Clang does
> not operates $fp in the expected way.=C2=A0 I'm not sure about my conclus=
ion
> though.=C2=A0 Maybe Peter can explain it better.

Another example: some simple rust code:

extern { fn f(x: &i64) -> i64; }

#[no_mangle]
fn g() -> i64 {
    let x =3D 114514;
    unsafe {f(&x)}
}

It's just lucky GCC doesn't use $fp as the frame pointer unless there's
some stupid code (VLA etc) thus the issue was not detected.


--=20
Xi Ruoyao <xry111@xry111.site>
School of Aerospace Science and Technology, Xidian University

