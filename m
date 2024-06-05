Return-Path: <linux-kernel+bounces-202694-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F153D8FCFA8
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 15:41:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 887071F26AD7
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 13:41:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D80F31957E4;
	Wed,  5 Jun 2024 13:18:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xry111.site header.i=@xry111.site header.b="K/QYeyeS"
Received: from xry111.site (xry111.site [89.208.246.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA5B719924D
	for <linux-kernel@vger.kernel.org>; Wed,  5 Jun 2024 13:18:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.208.246.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717593500; cv=none; b=mqvaroFVInEoNinLmr3/3TRes5KcocWS/uGNk0LC9fMkJm59aXbjucOEYAaFyV0tqg/LaHdpyM6+Tq3R7Lxf+f4HJaJqzX7jYlnG5HPnRUgP4V/QtCikaoXulnUaxgRpJrGt7OfbHvxvLNnTQjK+cqSXhk6FJNPya3LoDaeXd78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717593500; c=relaxed/simple;
	bh=aSGeY//DKOc9pUfHYgBFU7c6uqdrSP0BOyUSG+ubbnc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=eItNdB7BXDgUCq4kU9fi2ESslBlHzKd6GgPdnpBr8JUHLJaBk03bgW+ywjN9nBvzOo8ps79oFIZrruB/pP44g+lKK4KxxL8icW7cuCrRwaJ6khFSeBbhHtEYprG5f9ILuFOM3k+fNTkuxNwLw8TOpRHvibYMnaxBCNmaHT0lbZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xry111.site; spf=pass smtp.mailfrom=xry111.site; dkim=pass (1024-bit key) header.d=xry111.site header.i=@xry111.site header.b=K/QYeyeS; arc=none smtp.client-ip=89.208.246.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xry111.site
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xry111.site
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xry111.site;
	s=default; t=1717593493;
	bh=aSGeY//DKOc9pUfHYgBFU7c6uqdrSP0BOyUSG+ubbnc=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=K/QYeyeSpUarJlYgGgAyIAl4Fd+JhbABsGC8TCH2Hn4w42JBjAcm37/+UPyjiPAiS
	 FXqo2AgIrAo3JpeegFXyKyanW+LLvUOsnxx66xVFVXJVJCEME/Rclz++AQPGIMeI5U
	 CkSNEPqyletl8w4nPPNuC6JwFEfS5d5LgrHDLEpE=
Received: from [192.168.124.13] (unknown [113.140.11.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-384) server-digest SHA384)
	(Client did not present a certificate)
	(Authenticated sender: xry111@xry111.site)
	by xry111.site (Postfix) with ESMTPSA id E912F6760C;
	Wed,  5 Jun 2024 09:18:08 -0400 (EDT)
Message-ID: <444ec2031ef6ca016cbfa8dfedc51bddc8529ba7.camel@xry111.site>
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
Date: Wed, 05 Jun 2024 21:18:06 +0800
In-Reply-To: <f8ef61773b0119b8573fc0fed9ad0a8b43061efd.camel@xry111.site>
References: <20240604150741.30252-1-xry111@xry111.site>
	 <20240605054328.GA279426@thelio-3990X>
	 <b55b8cb2c52f2c3701c83353586130b8dc237ee2.camel@xry111.site>
	 <20240605062548.GF279426@thelio-3990X>
	 <f8ef61773b0119b8573fc0fed9ad0a8b43061efd.camel@xry111.site>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.2 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2024-06-05 at 18:57 +0800, Xi Ruoyao wrote:
> On Tue, 2024-06-04 at 23:25 -0700, Nathan Chancellor wrote:
> > On Wed, Jun 05, 2024 at 01:54:24PM +0800, Xi Ruoyao wrote:
> > > On Tue, 2024-06-04 at 22:43 -0700, Nathan Chancellor wrote:
> > > > For what it's worth, I have noticed some warnings with clang that I
> > > > don't see with GCC but I only filed an issue on our GitHub and neve=
r
> > > > followed up on the mailing list, so sorry about that.
> > > >=20
> > > > https://github.com/ClangBuiltLinux/linux/issues/2024
> > > >=20
> > > > Might be tangential to this patch though but I felt it was worth
> > > > mentioning.
> > >=20
> > > The warnings in GCC build is definitely the issue handled by this pat=
ch.
> > > But the warnings in Clang build should be a different issue.=C2=A0 Ca=
n you
> > > attach the kernel/events/core.o file from the Clang build for analysi=
s?
> > > I guess we need to disable more optimization...
> >=20
> > Sure thing. Let me know if there are any issues with the attachment.
>=20
> Thanks!=C2=A0 I've simplified it and now even...
>=20
> .global test
> .type test,@function
> test:
>=20
> addi.d	$sp,$sp,-448
> st.d	$ra,$sp,440
> st.d	$fp,$sp,432
> addi.d	$fp,$sp,448
>=20
> # do something
>=20
> addi.d	$sp,$fp,-448
> ld.d	$fp,$sp,432
> ld.d	$ra,$sp,440
> addi.d	$sp,$sp,448
> ret
>=20
> .size test,.-test
>=20
> is enough to trigger a objtool warning:
>=20
> /home/xry111/t1.o: warning: objtool: test+0x20: return with modified stac=
k frame
>=20
> And to me this warning is bogus?

Minimal C reproducer:

struct x { _Alignas(64) char buf[128]; };

void f(struct x *p);
void g()
{
	struct x x =3D { .buf =3D "1145141919810" };
	f(&x);
}

Then objtool is unhappy to the object file produced with "clang -c -O2"
from this translation unit:

/home/xry111/t2.o: warning: objtool: g+0x50: return with modified stack fra=
me

It seems CFI_BP has a very specific semantic in objtool and Clang does
not operates $fp in the expected way.  I'm not sure about my conclusion
though.  Maybe Peter can explain it better.

--=20
Xi Ruoyao <xry111@xry111.site>
School of Aerospace Science and Technology, Xidian University

