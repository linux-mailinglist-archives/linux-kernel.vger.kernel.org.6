Return-Path: <linux-kernel+bounces-201749-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 223948FC2C6
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 06:38:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C27C11F231E1
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 04:38:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6654612D758;
	Wed,  5 Jun 2024 04:38:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xry111.site header.i=@xry111.site header.b="lLF9US43"
Received: from xry111.site (xry111.site [89.208.246.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72C8663B
	for <linux-kernel@vger.kernel.org>; Wed,  5 Jun 2024 04:38:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.208.246.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717562299; cv=none; b=XaEROXq+pr2egx9kDg77MqhDDYqPLajCZsarukU0k10IBQ25PbAzMr7Xz8bh6HdBNJelK5UI3DmMYDSu32NHdai/sgmkrOFRImWr6a7glEobad5fSZCKA8O2/wTcFwtCbW+5cH28j2DIBhpfHhI7ZvgRSMhbMnjhADJn33ClEnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717562299; c=relaxed/simple;
	bh=Cg3KFkgg0IOfj7ddIb/8BLHSkMNVj+t8SMEFfpN9xSo=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=e2+ezYlCbCgpKAEiYdbP/ytnAxSpP45mgIPs4yKR/e82w95j3XFGO3XFNbIyu7XPk2qSV9Qj2oi1XBH729Rvo82hOULxxHIQR8iotuNRBFCYeh0vvmcwJHyHs8fiBTjv93Yi7PIo1VVvyhmcZq6sZ7e/d7a0qRYlQmkQ5xjSNhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xry111.site; spf=pass smtp.mailfrom=xry111.site; dkim=pass (1024-bit key) header.d=xry111.site header.i=@xry111.site header.b=lLF9US43; arc=none smtp.client-ip=89.208.246.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xry111.site
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xry111.site
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xry111.site;
	s=default; t=1717562296;
	bh=Cg3KFkgg0IOfj7ddIb/8BLHSkMNVj+t8SMEFfpN9xSo=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=lLF9US43fGzsWKCKi2derrneysNWJHXUzil7jf7k3wR19Jh6BFhqX1sJkglC9byhd
	 kog37QTcTxO6+SJiE28UCAfgwKdt/iuNKziV+jwMrCWv2dOacARrF/R0Mrz+2aOZsz
	 QnG2mYB+n2uzm+tz49E1cJWh24YNrC7ac6Y+vkdQ=
Received: from [IPv6:240e:358:111d:4300:dc73:854d:832e:6] (unknown [IPv6:240e:358:111d:4300:dc73:854d:832e:6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-384) server-digest SHA384)
	(Client did not present a certificate)
	(Authenticated sender: xry111@xry111.site)
	by xry111.site (Postfix) with ESMTPSA id 0793666A81;
	Wed,  5 Jun 2024 00:38:07 -0400 (EDT)
Message-ID: <80c92f7d283444e493ba1236cf228a5deca6c32d.camel@xry111.site>
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
Date: Wed, 05 Jun 2024 12:38:03 +0800
In-Reply-To: <CAAhV-H7CF5wUSj5qfSs-+YTUrB2R9STO7LLu7LG2RpsYE719Og@mail.gmail.com>
References: <20240604150741.30252-1-xry111@xry111.site>
	 <CAAhV-H7CF5wUSj5qfSs-+YTUrB2R9STO7LLu7LG2RpsYE719Og@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.2 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2024-06-05 at 09:52 +0800, Huacai Chen wrote:
> Hi, Ruoyao,
>=20
> On Tue, Jun 4, 2024 at 11:08=E2=80=AFPM Xi Ruoyao <xry111@xry111.site> wr=
ote:
> >=20
> > GAS <=3D 2.41 does not support generating R_LARCH_{32,64}_PCREL for
> > "label - ." and it generates R_LARCH_{ADD,SUB}{32,64} pairs instead.
> > objtool cannot handle R_LARCH_{ADD,SUB}{32,64} pair in __jump_table
> > (static key implementation) and etc. so it will produce some warnings.
> > This is causing the kernel CI systems to complain everywhere.
> >=20
> > For GAS we can check if -mthin-add-sub option is available to know if
> > R_LARCH_{32,64}_PCREL are supported.
> I think we should give a chance to toolchains without the
> -mthin-add-sub option, so I hope Tiezhu can resubmit this patch to
> solve this problem.
> https://lore.kernel.org/loongarch/1690272910-11869-6-git-send-email-yangt=
iezhu@loongson.cn/

It only handles .discard.{un,}reachable but not __jump_table.=20
__jump_table is our main issue here.  And I don't see a quick way to
make -mno-thin-add-sub work for __jump_table because we really need to
resolve the relocation for __jump_table instead of simply skipping it.

--=20
Xi Ruoyao <xry111@xry111.site>
School of Aerospace Science and Technology, Xidian University

