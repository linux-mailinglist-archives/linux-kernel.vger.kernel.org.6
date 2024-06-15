Return-Path: <linux-kernel+bounces-215803-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C44D490972D
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jun 2024 11:06:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 72FB11F22E5E
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jun 2024 09:06:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCA0B20DC5;
	Sat, 15 Jun 2024 09:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xry111.site header.i=@xry111.site header.b="jkFdBCVR"
Received: from xry111.site (xry111.site [89.208.246.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B636618EB8
	for <linux-kernel@vger.kernel.org>; Sat, 15 Jun 2024 09:05:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.208.246.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718442354; cv=none; b=X5rbhJ7+Z4L+rQYwZY2ULMRPps+HHj5JMEgXyShnOUcLpmu1MRTbidg6YzDP53TjxtidRsafncq+GUmJ23DVFPeCfqJ6rpJy/rI+1YnczwMQ/WhfCXcOyv7160Bu88z5xV9c7yzfa5u3LpVkLuN7x9OcpgXfLfPMW0OEd2rsBB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718442354; c=relaxed/simple;
	bh=+woalqluYddgV4dzazx+XMw4WWHzePo+9ZVQhAcUr6w=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=quHRe648Y6fgIW6OZzf60gOgD2e6Uu/kTBVFfUb3zovTcI8OrkXlxKlWh8B4kNl35XvjK1BSiqHs2ToQH+035E+9KUHHONC8KlCVp8JIJgh/rkJH2qJxzY3aGoB9LW8+uBEf0UFEG0stQ5rI59Djd4zVFYycnmy1MefkxU6DKis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xry111.site; spf=pass smtp.mailfrom=xry111.site; dkim=pass (1024-bit key) header.d=xry111.site header.i=@xry111.site header.b=jkFdBCVR; arc=none smtp.client-ip=89.208.246.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xry111.site
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xry111.site
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xry111.site;
	s=default; t=1718441627;
	bh=+woalqluYddgV4dzazx+XMw4WWHzePo+9ZVQhAcUr6w=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=jkFdBCVRTA1LqvIM9DQfjq79SO3h5QmqvIhHQj4gwhNWMZ5E2KWAOYcJoSG6nRFSD
	 T45UqgB0bM9/8DD7jEtub7l3PwEP5Bh1n/n1jTf5Vg9L5VDAdtt9VUqbICmXsEGENU
	 gLEuxcIQKMEq5bb/6UgM2mM72iQqPoYYRRXzBiic=
Received: from [192.168.124.13] (unknown [113.200.174.91])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-384) server-digest SHA384)
	(Client did not present a certificate)
	(Authenticated sender: xry111@xry111.site)
	by xry111.site (Postfix) with ESMTPSA id D4DE367451;
	Sat, 15 Jun 2024 04:53:42 -0400 (EDT)
Message-ID: <a97cd0f2e2cac10253d6b5cdd0ace3db3b220535.camel@xry111.site>
Subject: Re: [PATCH] loongarch: Only select HAVE_OBJTOOL and allow ORC
 unwinder if the inline assembler supports R_LARCH_{32,64}_PCREL
From: Xi Ruoyao <xry111@xry111.site>
To: Huacai Chen <chenhuacai@kernel.org>
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
Date: Sat, 15 Jun 2024 16:53:39 +0800
In-Reply-To: <CAAhV-H5Wz=U4kbX+tXt1qoCr6RaEDkzZXV7B=tgU_8o+X-NtVQ@mail.gmail.com>
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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.2 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sat, 2024-06-15 at 16:45 +0800, Huacai Chen wrote:
> Hi, Ruoyao and Jinyang,
>=20
> On Fri, Jun 7, 2024 at 4:29=E2=80=AFPM Xi Ruoyao <xry111@xry111.site> wro=
te:
> >=20
> > On Fri, 2024-06-07 at 15:14 +0800, Jinyang He wrote:
> > > > =C2=A0=C2=A0=C2=A0=C2=A0 Note: on RISC-V and LoongArch, the stack s=
lot for the previous frame
> > > > =C2=A0=C2=A0=C2=A0=C2=A0 pointer is stored at fp[-2] instead of fp[=
0]. See [Consider
> > > > =C2=A0=C2=A0=C2=A0=C2=A0 standardising which stack slot fp points
> > > > =C2=A0=C2=A0=C2=A0=C2=A0 to](https://github.com/riscv-non-isa/riscv=
-elf-psabi-doc/issues/18)
> > > > =C2=A0=C2=A0=C2=A0=C2=A0 for the RISC-V discussion.
> > >=20
> > > In most cases the $fp is saved at cfa-16. But for va args, something
> > > becomes different at LoongArch (I do not know the case of riscv), the
> > > $fp isn't saved at cfa-16. (e.g. printk?)
> >=20
> > Oops indeed.=C2=A0 Even with a very simple case:
> >=20
> > int sum(int a, int b) {
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return a + b;
> > }
> >=20
> > with -fno-omit-frame-pointer we get:
> >=20
> > sum:
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 addi.d=C2=A0 $r3,$r3,-16
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 st.d=C2=A0=C2=A0=C2=A0 $r22,=
$r3,8
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 addi.d=C2=A0 $r22,$r3,16
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ld.d=C2=A0=C2=A0=C2=A0 $r22,=
$r3,8
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 add.w=C2=A0=C2=A0 $r4,$r4,$r=
5
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 addi.d=C2=A0 $r3,$r3,16
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 jr=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 $r1
> >=20
> > So for leaf functions (where we don't save $ra) $fp is saved at cfa-8.
> >=20
> > > I feel that the update_cfi_state should be arch specific. I believe
> > > that some logic can be reused, but each arch may have its own logic.
> >=20
> > I agree it now.
> What is the conclusion about the clang part now? And for the original
> -mno-thin-add-sub problem, do you have some way to fix it in the root?
> I think we needn't rush, there are some weeks before 6.10 released.

To me for now we should just make OBJTOOL and ORC depend on BROKEN and
backport to stable...

Even if we can fix both the -mno-thin-add-sub problem and the frame
pointer problem in these weeks, they'll be some nontrivial large change
and improper to backport.  Thus we have to admit objtool doesn't really
work for old releases and mark it broken.


--=20
Xi Ruoyao <xry111@xry111.site>
School of Aerospace Science and Technology, Xidian University

