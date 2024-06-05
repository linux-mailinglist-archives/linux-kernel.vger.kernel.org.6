Return-Path: <linux-kernel+bounces-201774-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 67FEA8FC301
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 07:25:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E84A81F2294A
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 05:25:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93B8613AD14;
	Wed,  5 Jun 2024 05:25:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xry111.site header.i=@xry111.site header.b="C1kOPM9Z"
Received: from xry111.site (xry111.site [89.208.246.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7B298830
	for <linux-kernel@vger.kernel.org>; Wed,  5 Jun 2024 05:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.208.246.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717565126; cv=none; b=QsI2vyPlDZYN4uIbIk20G+Am5IvWreiohj7esIEelmIGAhfdWPI0WIDzUZsT/CkyKWvuVHkK9gPgKYAfuLZugLF3tb6k+fxOBuMHZjnnmr2dBsjM3ti2aCZheWSwR+zZ2NF4WHv4CDUni1yvYYAWI/bUqLM0Kk0L6B+tKEukaMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717565126; c=relaxed/simple;
	bh=VRuDfJneumWnl369xh8UUhc6D/Qt40FIaMU22iAgxc0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=DYPpUp8ev4u3bIrg13X6YfwBjiZ72Ij1wo6cHy5xepWN4qSyZ1HTFcxveoCi2TyjXqfemMw7IDyH7Jbpl3HFna6PdGwNceoGgIQ4WfADb/Vh0ETcXKoOGT/VxjaFdtIVA8nsatVU4pUTzu4O59j1ACRn6HF4IX1ITOO3lIQtoGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xry111.site; spf=pass smtp.mailfrom=xry111.site; dkim=pass (1024-bit key) header.d=xry111.site header.i=@xry111.site header.b=C1kOPM9Z; arc=none smtp.client-ip=89.208.246.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xry111.site
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xry111.site
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xry111.site;
	s=default; t=1717565124;
	bh=VRuDfJneumWnl369xh8UUhc6D/Qt40FIaMU22iAgxc0=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=C1kOPM9Z5lr9YuVFxHURS2J57RGfScgiMrME9zt+1RJ3Xqg1jQfOV+6gSWGKPWxEk
	 6BlroFjj4595fz0U8oOvwozQlXpUuqnb6pttzKHhFaU+xF2DPl2bYzBmQvRKqMNTIb
	 JlmzQq8nHX+ZC2+JHWosDYzVnw2SgenSRHFER68I=
Received: from [IPv6:240e:358:111d:4300:dc73:854d:832e:6] (unknown [IPv6:240e:358:111d:4300:dc73:854d:832e:6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-384) server-digest SHA384)
	(Client did not present a certificate)
	(Authenticated sender: xry111@xry111.site)
	by xry111.site (Postfix) with ESMTPSA id A600866FAC;
	Wed,  5 Jun 2024 01:25:14 -0400 (EDT)
Message-ID: <f72abf3b624107361ec4de0fe72be3bf4a3da539.camel@xry111.site>
Subject: Re: [PATCH] loongarch: Only select HAVE_OBJTOOL and allow ORC
 unwinder if the inline assembler supports R_LARCH_{32,64}_PCREL
From: Xi Ruoyao <xry111@xry111.site>
To: Huacai Chen <chenhuacai@kernel.org>
Cc: WANG Xuerui <kernel@xen0n.name>, Tiezhu Yang <yangtiezhu@loongson.cn>, 
 Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers
 <ndesaulniers@google.com>, Bill Wendling <morbo@google.com>, Justin Stitt
 <justinstitt@google.com>, Youling Tang <tangyouling@kylinos.cn>, Jinyang He
 <hejinyang@loongson.cn>,  loongarch@lists.linux.dev,
 linux-kernel@vger.kernel.org, llvm@lists.linux.dev, 
 mengqinggang@loongson.cn, cailulu@loongson.cn, wanglei@loongson.cn, 
 luweining@loongson.cn, Yujie Liu <yujie.liu@intel.com>, Heng Qi
 <hengqi@linux.alibaba.com>, Tejun Heo <tj@kernel.org>
Date: Wed, 05 Jun 2024 13:25:10 +0800
In-Reply-To: <CAAhV-H74=aQqMe3Bh5xn1VQCrcK7eHk1baKj1L+74=o=-8V_6g@mail.gmail.com>
References: <20240604150741.30252-1-xry111@xry111.site>
	 <CAAhV-H7CF5wUSj5qfSs-+YTUrB2R9STO7LLu7LG2RpsYE719Og@mail.gmail.com>
	 <80c92f7d283444e493ba1236cf228a5deca6c32d.camel@xry111.site>
	 <CAAhV-H74=aQqMe3Bh5xn1VQCrcK7eHk1baKj1L+74=o=-8V_6g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.2 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2024-06-05 at 13:21 +0800, Huacai Chen wrote:
> On Wed, Jun 5, 2024 at 12:38=E2=80=AFPM Xi Ruoyao <xry111@xry111.site> wr=
ote:
> >=20
> > On Wed, 2024-06-05 at 09:52 +0800, Huacai Chen wrote:
> > > Hi, Ruoyao,
> > >=20
> > > On Tue, Jun 4, 2024 at 11:08=E2=80=AFPM Xi Ruoyao <xry111@xry111.site=
> wrote:
> > > >=20
> > > > GAS <=3D 2.41 does not support generating R_LARCH_{32,64}_PCREL for
> > > > "label - ." and it generates R_LARCH_{ADD,SUB}{32,64} pairs instead=
.
> > > > objtool cannot handle R_LARCH_{ADD,SUB}{32,64} pair in __jump_table
> > > > (static key implementation) and etc. so it will produce some warnin=
gs.
> > > > This is causing the kernel CI systems to complain everywhere.
> > > >=20
> > > > For GAS we can check if -mthin-add-sub option is available to know =
if
> > > > R_LARCH_{32,64}_PCREL are supported.
> > > I think we should give a chance to toolchains without the
> > > -mthin-add-sub option, so I hope Tiezhu can resubmit this patch to
> > > solve this problem.
> > > https://lore.kernel.org/loongarch/1690272910-11869-6-git-send-email-y=
angtiezhu@loongson.cn/
> >=20
> > It only handles .discard.{un,}reachable but not __jump_table.
> > __jump_table is our main issue here.=C2=A0 And I don't see a quick way =
to
> > make -mno-thin-add-sub work for __jump_table because we really need to
> > resolve the relocation for __jump_table instead of simply skipping it.
> =C2=A0__jump_table is disabled now, so we can only solve=C2=A0 -mno-thin-=
add-sub
> at present, and the next step is __jump_table.

No, -fno-jump-table does not disable __jump_table.  __jump_table is from
static key implementation in arch/loongarch/include/asm/jump_label.h,
not generated by the compiler.

And the problem of __jump_table is exact with -mno-thin-add-sub.  It
reads:

#define JUMP_TABLE_ENTRY                \
     ".pushsection  __jump_table, \"aw\"    \n\t"   \
     ".align    3           \n\t"   \
     ".long     1b - ., %l[l_yes] - .   \n\t"   \
     ".quad     %0 - .          \n\t"   \
     ".popsection               \n\t"

The "1b - ." and "%0 - ." things produce different relocs with -mno-
thin-add-sub and -mthin-add-sub.  The objtool can only handle the relocs
from -mthin-add-sub here.

--=20
Xi Ruoyao <xry111@xry111.site>
School of Aerospace Science and Technology, Xidian University

