Return-Path: <linux-kernel+bounces-217607-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D2BB790B225
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 16:33:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9C3D3B32C42
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 14:32:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1718F1B4C44;
	Mon, 17 Jun 2024 13:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UFbR6L+k"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51CC119B591
	for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2024 13:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718632065; cv=none; b=Sfw3RTsz03KUXiADdorXpxrsn4jcezoi7zXa8S8Y70OH77nZguJdYRsejWNWfT5/L/hbXKy2zeeyvAGu6qMkdg5OT5riLDzrLlj2FvSJ3QKvbb9WvDIhwrrQqKaUaX2jhZX1zYGKCt9nTWxJWNYzjiI6NovESuA7Xqw09/kRmf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718632065; c=relaxed/simple;
	bh=wWRAYn7Ii42QuGior+4MVW+laPzt0BX582bjd0B8LQ4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BTy2K/TS3z71QJnBPJaVsePD7lgS6S+2Rc5ZxdCJ8z08RL+QlO0rdjGmfWvXDmj9retB9rNvXkY1it3KPkH28i5t8nFFwvmsMG9XkFApITXG5isCzSO9NEJ2wnd9uRp/YmJoFlUiI9DmW7JlcBInzSbOLNQTuAUqySRj04YnZ1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UFbR6L+k; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DEC7DC4AF53
	for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2024 13:47:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718632064;
	bh=wWRAYn7Ii42QuGior+4MVW+laPzt0BX582bjd0B8LQ4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=UFbR6L+kwM9z40/S3ZRcr6bcwMsns9uH30KIG8J9kTSaAXHuNddMj01eKvLcW6q3P
	 93844GiNhFakKVL3DfXVKaUPgg94oo59tSzwFtbu8UQDlRFhD0pt+k5kUR8hAjZItV
	 agQzomqoK4UhSkgdP45QJQ9F6bEvgR+pR1weKpvHhFjQdfCUUk6Fjlo9p4sg62Qg5u
	 z4dIl/oxg8daPTIESuXahpWBHDRuUloXGi68TXysU7Md6vtWHGOrOUqtwcp2m/rfN2
	 WP079IsU19cWF1u7tU6Dm6HAYC/AWdpwfpLlnTQZkWW+3Nhu9PnMAmd7ep6rWxykg/
	 OX06Ui/wKjR9w==
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a6f0e153eddso566137166b.0
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2024 06:47:44 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWlaUcTHUCZzzzpCCgidLY90p0iCEdW8hjG5zJ5QrluCWpqfT7cf1BlpcX8USbg5HeX0yBlTZi6k+xfYO/HJ+pfYPqnJUrL60Ji6C/Q
X-Gm-Message-State: AOJu0YxQxIMatKUp3Q5cNarQMQq5/4NGITtadOFmEDxkYzWnvLV6y66s
	s7gh04A07t46dqJKAo0r2AWKZtGxGk2qco/uSG05VP5PDBIXU513JqKielVRv2tncya1VWuL4XK
	O0yqCq3fCIXuqE+1sqYsERyjDcxE=
X-Google-Smtp-Source: AGHT+IGu4spCnAR/gUgmgSjmW1JeI1VT2iAP/gZA99vnR6EUnwq6gHVnN3HyeQeD7JIrz+fqo/6hp8phZxj26Lckue8=
X-Received: by 2002:a17:907:a581:b0:a6f:76db:7c60 with SMTP id
 a640c23a62f3a-a6f76db8412mr504637266b.24.1718632063231; Mon, 17 Jun 2024
 06:47:43 -0700 (PDT)
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
 <CAAhV-H5Wz=U4kbX+tXt1qoCr6RaEDkzZXV7B=tgU_8o+X-NtVQ@mail.gmail.com>
 <a97cd0f2e2cac10253d6b5cdd0ace3db3b220535.camel@xry111.site>
 <CAAhV-H7hhh3Jes0jMrg82+KJCa7GQZW=F9bDtktFh=eazMDX9w@mail.gmail.com>
 <12099e6fb7ba377f3dcf6686e0b37200b9818708.camel@xry111.site>
 <CAAhV-H6j0WgN6QpHBYcdprdWBpcQq4ObYK5YcE=TVsDNxGFEtA@mail.gmail.com> <6e14e41b728437743fddebf78f7981ea15f6b8a8.camel@xry111.site>
In-Reply-To: <6e14e41b728437743fddebf78f7981ea15f6b8a8.camel@xry111.site>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Mon, 17 Jun 2024 21:47:32 +0800
X-Gmail-Original-Message-ID: <CAAhV-H5jLb1E87n=FcbmbH1ZXiEsxnNgLvxWUtCV9vFeaNW1ng@mail.gmail.com>
Message-ID: <CAAhV-H5jLb1E87n=FcbmbH1ZXiEsxnNgLvxWUtCV9vFeaNW1ng@mail.gmail.com>
Subject: Re: [PATCH] loongarch: Only select HAVE_OBJTOOL and allow ORC
 unwinder if the inline assembler supports R_LARCH_{32,64}_PCREL
To: Xi Ruoyao <xry111@xry111.site>
Cc: chenglulu <chenglulu@loongson.cn>, Jinyang He <hejinyang@loongson.cn>, 
	Nathan Chancellor <nathan@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	WANG Xuerui <kernel@xen0n.name>, Tiezhu Yang <yangtiezhu@loongson.cn>, 
	Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, Youling Tang <tangyouling@kylinos.cn>, 
	loongarch@lists.linux.dev, linux-kernel@vger.kernel.org, llvm@lists.linux.dev, 
	mengqinggang@loongson.cn, cailulu@loongson.cn, wanglei@loongson.cn, 
	luweining@loongson.cn, Yujie Liu <yujie.liu@intel.com>, 
	Heng Qi <hengqi@linux.alibaba.com>, Tejun Heo <tj@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 17, 2024 at 9:38=E2=80=AFPM Xi Ruoyao <xry111@xry111.site> wrot=
e:
>
> On Mon, 2024-06-17 at 21:11 +0800, Huacai Chen wrote:
>
>
>
> > > select HAVE_OBJTOOL if AS_HAS_EXPLICIT_RELOCS && AS_HAS_THIN_ADD_SUB =
&& !CC_IS_CLANG && !RUST
> > Maybe we needn't consider RUST here?
>
> Rustc does use $fp that objtool cannot handle as at now.  It can be
> demonstrated with an over-aligned type, similar to Clang:
>
> $ cat t.rs
> #[repr(C, align(64))]
> struct X(i32);
>
> extern { fn f(x: &X) -> i64; }
>
> #[no_mangle]
> fn g() -> i64 {
>     let x =3D X(114514);
>     unsafe {f(&x)}
> }
> $ rustc t.rs --emit=3Dasm --crate-type=3Dstaticlib -O
> $ grep fp t.s
>         st.d    $fp, $sp, 112
>         addi.d  $fp, $sp, 128
>         addi.d  $sp, $fp, -128
>         ld.d    $fp, $sp, 112
>
> The kernel uses rust-bindgen to generate some .rs file from C headers.
> And __attribute__((aligned(x))) is directly translated to
> repr(align(x)).  As __attribute__((aligned(x))) is very common in the
> kernel I expect objtool will fail to handle some object code from rustc.
My meaning is: the build robot doesn't enable RUST now (maybe I'm
wrong), and this problem will surely be fixed in future, so we can
make the condition as simple as possible.

Huacai

>
> > And can we think AS_HAS_THIN_ADD_SUB always imply
> > AS_HAS_EXPLICIT_RELOCS here?
>
> Maybe, AFAIK there's no assembler using thin add-sub but not explicit
> relocs.
>
> --
> Xi Ruoyao <xry111@xry111.site>
> School of Aerospace Science and Technology, Xidian University
>

