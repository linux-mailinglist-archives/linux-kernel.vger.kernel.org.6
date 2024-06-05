Return-Path: <linux-kernel+bounces-201789-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A40FD8FC32D
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 07:54:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 442B21F22E7F
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 05:54:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4ADBB21C186;
	Wed,  5 Jun 2024 05:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xry111.site header.i=@xry111.site header.b="b1gQf3KU"
Received: from xry111.site (xry111.site [89.208.246.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6767E5916B
	for <linux-kernel@vger.kernel.org>; Wed,  5 Jun 2024 05:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.208.246.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717566873; cv=none; b=QG20+NX2mwRLTISdgtZJGPXPGOgA9fCwrSa0znsHKeJANS35wfkYEOWtpadRZifKvOXN77dugYzTIVbjhpxnGkEjJdXPmB7sDJygf8gJNU+/x/YTD49L2GjA6SRz1Xv+fLmmhnyHIy6YVh+Gg3BnT0Kk+AzQlyrMOwDVNwV7+MA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717566873; c=relaxed/simple;
	bh=EspUqG4ttGTIApJuU4Zyr3ByWO1L6W7xAoo5CHf9MUs=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=SX4hWcuYGi4wH98xG83y4TcOK3/9c1rypv/1Q3jisytPwtLAPbTFycKRCX0va6LFBFRYPSVnMsYLHekGQtzFVAlrXLzVkpg8waSQBv4/9tw7Daxdpz8EBMLRiYuwJoXhEG3aGIN4Knzn23JIBShK87yzLUDKrO7uUSQ1fUJCXWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xry111.site; spf=pass smtp.mailfrom=xry111.site; dkim=pass (1024-bit key) header.d=xry111.site header.i=@xry111.site header.b=b1gQf3KU; arc=none smtp.client-ip=89.208.246.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xry111.site
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xry111.site
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xry111.site;
	s=default; t=1717566869;
	bh=EspUqG4ttGTIApJuU4Zyr3ByWO1L6W7xAoo5CHf9MUs=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=b1gQf3KU771VjhSnDDt5+ombnMhT0RnQ7/bP4vcpki3LkuXiJXeywCbgIjPP7knIp
	 BVN8yXdvaHlOWN7w6j9iaLlFSt8aaJ1VTU5hefEyDDLMLJGt1P3R8NpJAlrMCaG+FE
	 Dc1uqOas9u+c5PkNSkcq0PYTOS5sWJVLGlZu6m5w=
Received: from [127.0.0.1] (unknown [IPv6:2001:470:683e::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-384) server-digest SHA384)
	(Client did not present a certificate)
	(Authenticated sender: xry111@xry111.site)
	by xry111.site (Postfix) with ESMTPSA id AF40066ADA;
	Wed,  5 Jun 2024 01:54:25 -0400 (EDT)
Message-ID: <b55b8cb2c52f2c3701c83353586130b8dc237ee2.camel@xry111.site>
Subject: Re: [PATCH] loongarch: Only select HAVE_OBJTOOL and allow ORC
 unwinder if the inline assembler supports R_LARCH_{32,64}_PCREL
From: Xi Ruoyao <xry111@xry111.site>
To: Nathan Chancellor <nathan@kernel.org>
Cc: Huacai Chen <chenhuacai@kernel.org>, WANG Xuerui <kernel@xen0n.name>, 
 Tiezhu Yang <yangtiezhu@loongson.cn>, Nick Desaulniers
 <ndesaulniers@google.com>, Bill Wendling <morbo@google.com>, Justin Stitt
 <justinstitt@google.com>, Youling Tang <tangyouling@kylinos.cn>, Jinyang He
 <hejinyang@loongson.cn>,  loongarch@lists.linux.dev,
 linux-kernel@vger.kernel.org, llvm@lists.linux.dev, 
 mengqinggang@loongson.cn, cailulu@loongson.cn, wanglei@loongson.cn, 
 luweining@loongson.cn, Yujie Liu <yujie.liu@intel.com>, Heng Qi
 <hengqi@linux.alibaba.com>, Tejun Heo <tj@kernel.org>
Date: Wed, 05 Jun 2024 13:54:24 +0800
In-Reply-To: <20240605054328.GA279426@thelio-3990X>
References: <20240604150741.30252-1-xry111@xry111.site>
	 <20240605054328.GA279426@thelio-3990X>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.2 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2024-06-04 at 22:43 -0700, Nathan Chancellor wrote:
> On Tue, Jun 04, 2024 at 11:07:41PM +0800, Xi Ruoyao wrote:
> > GAS <=3D 2.41 does not support generating R_LARCH_{32,64}_PCREL for
> > "label - ." and it generates R_LARCH_{ADD,SUB}{32,64} pairs instead.
> > objtool cannot handle R_LARCH_{ADD,SUB}{32,64} pair in __jump_table
> > (static key implementation) and etc. so it will produce some warnings.
> > This is causing the kernel CI systems to complain everywhere.
> >=20
> > For GAS we can check if -mthin-add-sub option is available to know if
> > R_LARCH_{32,64}_PCREL are supported.
> >=20
> > For Clang, we require Clang >=3D 18 and Clang >=3D 17 already supports
> > R_LARCH_{32,64}_PCREL, so we can always assume Clang is fine for
> > objtool.
>=20
> For what it's worth, I have noticed some warnings with clang that I
> don't see with GCC but I only filed an issue on our GitHub and never
> followed up on the mailing list, so sorry about that.
>=20
> https://github.com/ClangBuiltLinux/linux/issues/2024
>=20
> Might be tangential to this patch though but I felt it was worth
> mentioning.

The warnings in GCC build is definitely the issue handled by this patch.
But the warnings in Clang build should be a different issue.  Can you
attach the kernel/events/core.o file from the Clang build for analysis?
I guess we need to disable more optimization...

I personally hate "pessimizing the code generation just for debugging"
with a passion so I never enabled objtool on LoongArch, thus I didn't
notice the issue.

--=20
Xi Ruoyao <xry111@xry111.site>
School of Aerospace Science and Technology, Xidian University

