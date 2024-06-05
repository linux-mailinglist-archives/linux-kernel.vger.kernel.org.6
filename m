Return-Path: <linux-kernel+bounces-202227-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 771638FC98F
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 12:58:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E6A14283595
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 10:58:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78353192B6C;
	Wed,  5 Jun 2024 10:58:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xry111.site header.i=@xry111.site header.b="Pt+EczlE"
Received: from xry111.site (xry111.site [89.208.246.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D4A11922F2
	for <linux-kernel@vger.kernel.org>; Wed,  5 Jun 2024 10:57:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.208.246.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717585080; cv=none; b=nWTwXRsMYwqtd1ZKhiESGvpnHAgCQRfrH0vnnIBJWyzbp+ECo7qYvnh9FV7a4w/z3KXSSGnxaw/ZNvwhrkFK4AHSmFF2yR5BGUYQrxRQWO+pTuGLglEEm6rf7SyEtcV4XLFiMZU1qpeSUdF0y3Wb3WsBzN0wtC1mdxaflQVmBRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717585080; c=relaxed/simple;
	bh=hPb5APVEuShjZ0fECZcArGF+7UZ+UhYfRq1FN7lXc7Q=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=tIchFeBnMdRcM0Kp3epR0SM6tA2IFjvGiw5o/DbfwqritobzEcslIF2q8eAnkOevbPhDfXgDCYd7ZKo2y6vq/Je5+nM8dWWvo1xDuLHEj1fv/G8XHIvZcFr0gCIOrtNGgauvhb4moVTaAYBhb1WfNpLb2jW5FsV2ZCkUgT/kiBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xry111.site; spf=pass smtp.mailfrom=xry111.site; dkim=pass (1024-bit key) header.d=xry111.site header.i=@xry111.site header.b=Pt+EczlE; arc=none smtp.client-ip=89.208.246.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xry111.site
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xry111.site
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xry111.site;
	s=default; t=1717585075;
	bh=hPb5APVEuShjZ0fECZcArGF+7UZ+UhYfRq1FN7lXc7Q=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=Pt+EczlE1/j2ufTJEPBVRoyXoeQYFwpeOmvCd4T+/sNXIgZjaSE+nzxWDUMBry4Zh
	 A0emczzNASoAe9HQ/KsJajS8DVxNbduZFLelbwHzUdKsItbdtaEqPlG34OPGtrHX7D
	 sYiLux6WzJiTp+Rx0aWJAf6FN5mgwdQnArghGQh8=
Received: from [127.0.0.1] (unknown [IPv6:2001:470:683e::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-384) server-digest SHA384)
	(Client did not present a certificate)
	(Authenticated sender: xry111@xry111.site)
	by xry111.site (Postfix) with ESMTPSA id EAC5766AF3;
	Wed,  5 Jun 2024 06:57:51 -0400 (EDT)
Message-ID: <f8ef61773b0119b8573fc0fed9ad0a8b43061efd.camel@xry111.site>
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
Date: Wed, 05 Jun 2024 18:57:50 +0800
In-Reply-To: <20240605062548.GF279426@thelio-3990X>
References: <20240604150741.30252-1-xry111@xry111.site>
	 <20240605054328.GA279426@thelio-3990X>
	 <b55b8cb2c52f2c3701c83353586130b8dc237ee2.camel@xry111.site>
	 <20240605062548.GF279426@thelio-3990X>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.2 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2024-06-04 at 23:25 -0700, Nathan Chancellor wrote:
> On Wed, Jun 05, 2024 at 01:54:24PM +0800, Xi Ruoyao wrote:
> > On Tue, 2024-06-04 at 22:43 -0700, Nathan Chancellor wrote:
> > > For what it's worth, I have noticed some warnings with clang that I
> > > don't see with GCC but I only filed an issue on our GitHub and never
> > > followed up on the mailing list, so sorry about that.
> > >=20
> > > https://github.com/ClangBuiltLinux/linux/issues/2024
> > >=20
> > > Might be tangential to this patch though but I felt it was worth
> > > mentioning.
> >=20
> > The warnings in GCC build is definitely the issue handled by this patch=
.
> > But the warnings in Clang build should be a different issue.=C2=A0 Can =
you
> > attach the kernel/events/core.o file from the Clang build for analysis?
> > I guess we need to disable more optimization...
>=20
> Sure thing. Let me know if there are any issues with the attachment.

Thanks!  I've simplified it and now even...

.global test
.type test,@function
test:

addi.d	$sp,$sp,-448
st.d	$ra,$sp,440
st.d	$fp,$sp,432
addi.d	$fp,$sp,448

# do something

addi.d	$sp,$fp,-448
ld.d	$fp,$sp,432
ld.d	$ra,$sp,440
addi.d	$sp,$sp,448
ret

.size test,.-test

is enough to trigger a objtool warning:

/home/xry111/t1.o: warning: objtool: test+0x20: return with modified stack =
frame

And to me this warning is bogus?

--=20
Xi Ruoyao <xry111@xry111.site>
School of Aerospace Science and Technology, Xidian University

