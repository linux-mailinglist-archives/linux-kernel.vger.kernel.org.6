Return-Path: <linux-kernel+bounces-215811-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB8C0909742
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jun 2024 11:33:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F35401C21885
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jun 2024 09:33:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C090241E7;
	Sat, 15 Jun 2024 09:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rfBFLmRb"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9769F1BC20
	for <linux-kernel@vger.kernel.org>; Sat, 15 Jun 2024 09:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718443995; cv=none; b=SF3mm+Pqq+/2A76JcnbeWx91FHlITj6rTqdO55RQVD2X5QHnCgDClHQO1TcRsMdBncLouuaIH8I5NrG/7dwdwtSsDD4yilr9j5OVUakSvpQ3SpdJ4FOq2qfMV+ShaMguMA96rZ/10osK6jBzSEgEwkfBmBvc3cdBaK1fUVX+Ntg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718443995; c=relaxed/simple;
	bh=bc/4Tso4iRzwTk7+zSbemISLUV6nGZBGzfAmqNVY59g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=l++u7OdGoZr9Gw7KVQPzQyYDOEKcrq1UjnvpfxJ6WvYLFb2B804Ck14dLk6XgdiFxEfR7Wva1OeOnKf8TOyoASjQqrGCfvxE5y8sCU8cFgG6Uh9hMttFjSyldiGScOeMfgnhxE8/BXD6A9lbY6JvgwVUwOeQ8c5ZrodpLz/bkxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rfBFLmRb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22981C4AF1A
	for <linux-kernel@vger.kernel.org>; Sat, 15 Jun 2024 09:33:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718443995;
	bh=bc/4Tso4iRzwTk7+zSbemISLUV6nGZBGzfAmqNVY59g=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=rfBFLmRbcYnoj+61ZEMp+Z5GwifgAx7DGspwyRk9vBKukG7kOAbVcbXSJma2MzF0Y
	 vCQqjeIj8QbDMqSWRY7KBBhKAOMgQ75eVZlpoAUS7xa6sOSwZbXwhqfm9Z6keh58DK
	 UXxK9j4OVXmdswAvARW20YbrSMbyKkTGFGtx0btdBD+1DziLFkmLy1vp13pfYROcb3
	 V4bUFM6snfO1knltzXJnymxtfc7nrnThbpWgcSx7oA3nbkL+wwqWoIbjKMlw6tMqYL
	 5eS+u9A/P+JNsKdm6SRvAcWdecTCVrphQ7ldFk0nxBXMdi+Xcr75hcjoGtz36s5jBa
	 AQ99irCVhkwvQ==
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a6f09eaf420so349301366b.3
        for <linux-kernel@vger.kernel.org>; Sat, 15 Jun 2024 02:33:14 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXeQsXL5BEdMMinhEndLFtxx4JydvuM3Pk906OiPoUSYivVJnULLNMPshAcXJ/mvZDdiHk46lX7W3PkxLE8UilsRe9RnN2U13NbaETg
X-Gm-Message-State: AOJu0Yxb3szKZD3RVKi27WQ/gGhKE8sgWtrc/z9Z+G5k4jHwaicCLMpt
	KG+YEALcbaXj68YPGTe5csPcnXGVfcL7u/UlMgkDuZIbiM5KlLrZzFoVGeYf/JpESZWqfnEvdm2
	vCBrU4csXzOLFk9Bq9ZwSCQ6XzWM=
X-Google-Smtp-Source: AGHT+IF5m0HmRjk9vt1VeOMxfpLqhSGVZgMyBx4nmfoGhafEDfO8XUD4p5rOnEYmsUvgaoy+e743j4lvpC7/ieTi5zw=
X-Received: by 2002:a17:907:d303:b0:a6f:6803:57d2 with SMTP id
 a640c23a62f3a-a6f6803596cmr268616866b.53.1718443993585; Sat, 15 Jun 2024
 02:33:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240604150741.30252-1-xry111@xry111.site> <20240605054328.GA279426@thelio-3990X>
 <b55b8cb2c52f2c3701c83353586130b8dc237ee2.camel@xry111.site>
 <20240605062548.GF279426@thelio-3990X> <f8ef61773b0119b8573fc0fed9ad0a8b43061efd.camel@xry111.site>
 <444ec2031ef6ca016cbfa8dfedc51bddc8529ba7.camel@xry111.site>
 <ada035690e446909c3cdbf9a43a92def96020615.camel@xry111.site>
 <82b7e6ea-c2cb-6364-ebe9-bff928028408@loongson.cn> <1c132209a612e2e8953f0b458fc01853120db9a9.camel@xry111.site>
 <2bf11cd2-8449-acda-f5ad-659c38cb018e@loongson.cn> <96a2e8a80c06772b64fcbdba42e1dae2d68a53a7.camel@xry111.site>
 <2bd6ae20-ec56-c1a2-c5dd-e8c978a376d3@loongson.cn> <329dac82e09dfc75e77ae93ebbeacdec1dc9ff7f.camel@xry111.site>
 <CAAhV-H5Wz=U4kbX+tXt1qoCr6RaEDkzZXV7B=tgU_8o+X-NtVQ@mail.gmail.com> <a97cd0f2e2cac10253d6b5cdd0ace3db3b220535.camel@xry111.site>
In-Reply-To: <a97cd0f2e2cac10253d6b5cdd0ace3db3b220535.camel@xry111.site>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Sat, 15 Jun 2024 17:33:02 +0800
X-Gmail-Original-Message-ID: <CAAhV-H7hhh3Jes0jMrg82+KJCa7GQZW=F9bDtktFh=eazMDX9w@mail.gmail.com>
Message-ID: <CAAhV-H7hhh3Jes0jMrg82+KJCa7GQZW=F9bDtktFh=eazMDX9w@mail.gmail.com>
Subject: Re: [PATCH] loongarch: Only select HAVE_OBJTOOL and allow ORC
 unwinder if the inline assembler supports R_LARCH_{32,64}_PCREL
To: Xi Ruoyao <xry111@xry111.site>
Cc: Jinyang He <hejinyang@loongson.cn>, Nathan Chancellor <nathan@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, WANG Xuerui <kernel@xen0n.name>, 
	Tiezhu Yang <yangtiezhu@loongson.cn>, Nick Desaulniers <ndesaulniers@google.com>, 
	Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
	Youling Tang <tangyouling@kylinos.cn>, loongarch@lists.linux.dev, 
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev, mengqinggang@loongson.cn, 
	cailulu@loongson.cn, wanglei@loongson.cn, luweining@loongson.cn, 
	Yujie Liu <yujie.liu@intel.com>, Heng Qi <hengqi@linux.alibaba.com>, 
	Tejun Heo <tj@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jun 15, 2024 at 4:54=E2=80=AFPM Xi Ruoyao <xry111@xry111.site> wrot=
e:
>
> On Sat, 2024-06-15 at 16:45 +0800, Huacai Chen wrote:
> > Hi, Ruoyao and Jinyang,
> >
> > On Fri, Jun 7, 2024 at 4:29=E2=80=AFPM Xi Ruoyao <xry111@xry111.site> w=
rote:
> > >
> > > On Fri, 2024-06-07 at 15:14 +0800, Jinyang He wrote:
> > > > >      Note: on RISC-V and LoongArch, the stack slot for the previo=
us frame
> > > > >      pointer is stored at fp[-2] instead of fp[0]. See [Consider
> > > > >      standardising which stack slot fp points
> > > > >      to](https://github.com/riscv-non-isa/riscv-elf-psabi-doc/iss=
ues/18)
> > > > >      for the RISC-V discussion.
> > > >
> > > > In most cases the $fp is saved at cfa-16. But for va args, somethin=
g
> > > > becomes different at LoongArch (I do not know the case of riscv), t=
he
> > > > $fp isn't saved at cfa-16. (e.g. printk?)
> > >
> > > Oops indeed.  Even with a very simple case:
> > >
> > > int sum(int a, int b) {
> > >         return a + b;
> > > }
> > >
> > > with -fno-omit-frame-pointer we get:
> > >
> > > sum:
> > >         addi.d  $r3,$r3,-16
> > >         st.d    $r22,$r3,8
> > >         addi.d  $r22,$r3,16
> > >         ld.d    $r22,$r3,8
> > >         add.w   $r4,$r4,$r5
> > >         addi.d  $r3,$r3,16
> > >         jr      $r1
> > >
> > > So for leaf functions (where we don't save $ra) $fp is saved at cfa-8=
.
> > >
> > > > I feel that the update_cfi_state should be arch specific. I believe
> > > > that some logic can be reused, but each arch may have its own logic=
.
> > >
> > > I agree it now.
> > What is the conclusion about the clang part now? And for the original
> > -mno-thin-add-sub problem, do you have some way to fix it in the root?
> > I think we needn't rush, there are some weeks before 6.10 released.
>
> To me for now we should just make OBJTOOL and ORC depend on BROKEN and
> backport to stable...
But this patch allows clang to build objtool, which seems broken, too.

>
> Even if we can fix both the -mno-thin-add-sub problem and the frame
> pointer problem in these weeks, they'll be some nontrivial large change
> and improper to backport.  Thus we have to admit objtool doesn't really
> work for old releases and mark it broken.
I don't like to disable objtool, unless there is no better solution.
And it seems there has already been some "large fix" in objtool's
history.

Huacai

>
>
> --
> Xi Ruoyao <xry111@xry111.site>
> School of Aerospace Science and Technology, Xidian University

