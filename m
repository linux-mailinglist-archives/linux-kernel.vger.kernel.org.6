Return-Path: <linux-kernel+bounces-201762-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 99CB28FC2F1
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 07:21:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A29D91C23E03
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 05:21:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F48F13AD07;
	Wed,  5 Jun 2024 05:21:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CGHMd/34"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD47710E5
	for <linux-kernel@vger.kernel.org>; Wed,  5 Jun 2024 05:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717564893; cv=none; b=amFy3ejzXHrnGmyYpFQx/XMTZkOPAJIAOWRz7+fz9KnZwENxzcqrmJr5BbnK6J5Oj9h8mFBBHqzz5U48wcX4PXFyvOIZxjJg250655m6wBPGN+KxizDWwNvkle3aYGiBBd2+kVJE+Z6v97NX72ugYT30d1PM7i9OPpWXtY/9KKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717564893; c=relaxed/simple;
	bh=zw+wXwfFvRUboT2dj0TLCNoLbvaP67u7v3CcKMrXI8I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=B7BI8K82pRz4JP2huSJfh5sanu4bt/ICVZNQ3BkQIgn3DMBu4vAYeujs63Yx+o7zoFf0nBR6WhNgOEVGyiokiZH2BxuLmZqaqfsHQ5OMUC8WuQ77fZC+CDW2M103YU56Xu1Qa7hvtxSTNuVE/H7AyDk3FAGZ9cvWfwX3bLNZGvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CGHMd/34; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F6CDC4AF0E
	for <linux-kernel@vger.kernel.org>; Wed,  5 Jun 2024 05:21:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717564893;
	bh=zw+wXwfFvRUboT2dj0TLCNoLbvaP67u7v3CcKMrXI8I=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=CGHMd/34duszm+YfpTbB0B0nKbeOKasqLfFoJ5b32ydAJvvV49JcNfXqzVb1Cyort
	 17JPMVP1fzoVLVtCmzoVgeVobmC1Q3SfuoJhrlxoQmBQif5VO6Q/c0ZVlwM38+AHQx
	 h0hjcjfNXsMcTtV8Q9eTEnW55bAVQc7DwuRRZ5e3Tx9B/YfXEUqNu908ylvc6DaqmL
	 8JvLp48i8P76KRj9uNSGgF7KjS4qQR+8LlP7cUe3RvhOpCjwE6tYixsP05wllKgfTS
	 xUozsh6AwcfukzhRppYHG3p/X9BUPEbGN1EF9jT0PX2s+pF7Yb3wDjGrJQZFcg2iEZ
	 /w+P7lXu0DTTQ==
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a68a4a9946cso428152266b.1
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jun 2024 22:21:33 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXh1KnZ8rr5wv9GqkLUdIjWvoHqEZn3FLKV8UUBhg2k5IEaqaqjAtOnaq7+bqveZcopl739AGX9l6kiX19gnzIbiz9e9tgR84bdH03/
X-Gm-Message-State: AOJu0YykG6P9Y/hTddg6MbjvOvUzF5gxctJBXna1bxNv9ExsFoGT1VfH
	iWqgLxRejRqysWLk8C4yFVUMAuKuXkeLVMJlSmN9lU9qJX204to6uxWb9qE/Mu9BZ88SYNqVS4g
	US4SjHFwGmn63DhZtDjKwSJSPl6A=
X-Google-Smtp-Source: AGHT+IG/Ux9c7Rj8+CTPmNazfXB2wlPS9ODy942J0Ys0ZzQ5w1vmU7ZOrQIbuiYJbSmv4blTFqeVLVKJBO6UcLUtht0=
X-Received: by 2002:a17:907:502:b0:a52:65bd:a19a with SMTP id
 a640c23a62f3a-a69a024cf7bmr70415366b.57.1717564891757; Tue, 04 Jun 2024
 22:21:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240604150741.30252-1-xry111@xry111.site> <CAAhV-H7CF5wUSj5qfSs-+YTUrB2R9STO7LLu7LG2RpsYE719Og@mail.gmail.com>
 <80c92f7d283444e493ba1236cf228a5deca6c32d.camel@xry111.site>
In-Reply-To: <80c92f7d283444e493ba1236cf228a5deca6c32d.camel@xry111.site>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Wed, 5 Jun 2024 13:21:21 +0800
X-Gmail-Original-Message-ID: <CAAhV-H74=aQqMe3Bh5xn1VQCrcK7eHk1baKj1L+74=o=-8V_6g@mail.gmail.com>
Message-ID: <CAAhV-H74=aQqMe3Bh5xn1VQCrcK7eHk1baKj1L+74=o=-8V_6g@mail.gmail.com>
Subject: Re: [PATCH] loongarch: Only select HAVE_OBJTOOL and allow ORC
 unwinder if the inline assembler supports R_LARCH_{32,64}_PCREL
To: Xi Ruoyao <xry111@xry111.site>
Cc: WANG Xuerui <kernel@xen0n.name>, Tiezhu Yang <yangtiezhu@loongson.cn>, 
	Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, 
	Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
	Youling Tang <tangyouling@kylinos.cn>, Jinyang He <hejinyang@loongson.cn>, 
	loongarch@lists.linux.dev, linux-kernel@vger.kernel.org, llvm@lists.linux.dev, 
	mengqinggang@loongson.cn, cailulu@loongson.cn, wanglei@loongson.cn, 
	luweining@loongson.cn, Yujie Liu <yujie.liu@intel.com>, 
	Heng Qi <hengqi@linux.alibaba.com>, Tejun Heo <tj@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 5, 2024 at 12:38=E2=80=AFPM Xi Ruoyao <xry111@xry111.site> wrot=
e:
>
> On Wed, 2024-06-05 at 09:52 +0800, Huacai Chen wrote:
> > Hi, Ruoyao,
> >
> > On Tue, Jun 4, 2024 at 11:08=E2=80=AFPM Xi Ruoyao <xry111@xry111.site> =
wrote:
> > >
> > > GAS <=3D 2.41 does not support generating R_LARCH_{32,64}_PCREL for
> > > "label - ." and it generates R_LARCH_{ADD,SUB}{32,64} pairs instead.
> > > objtool cannot handle R_LARCH_{ADD,SUB}{32,64} pair in __jump_table
> > > (static key implementation) and etc. so it will produce some warnings=
.
> > > This is causing the kernel CI systems to complain everywhere.
> > >
> > > For GAS we can check if -mthin-add-sub option is available to know if
> > > R_LARCH_{32,64}_PCREL are supported.
> > I think we should give a chance to toolchains without the
> > -mthin-add-sub option, so I hope Tiezhu can resubmit this patch to
> > solve this problem.
> > https://lore.kernel.org/loongarch/1690272910-11869-6-git-send-email-yan=
gtiezhu@loongson.cn/
>
> It only handles .discard.{un,}reachable but not __jump_table.
> __jump_table is our main issue here.  And I don't see a quick way to
> make -mno-thin-add-sub work for __jump_table because we really need to
> resolve the relocation for __jump_table instead of simply skipping it.
 __jump_table is disabled now, so we can only solve  -mno-thin-add-sub
at present, and the next step is __jump_table.

Huacai
>
> --
> Xi Ruoyao <xry111@xry111.site>
> School of Aerospace Science and Technology, Xidian University
>

