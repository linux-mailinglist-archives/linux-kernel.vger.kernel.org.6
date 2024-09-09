Return-Path: <linux-kernel+bounces-320654-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D01A7970DC2
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 08:14:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 07FB51C21E46
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 06:14:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB56B176AD4;
	Mon,  9 Sep 2024 06:14:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xry111.site header.i=@xry111.site header.b="H1+IEvuu"
Received: from xry111.site (xry111.site [89.208.246.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBB75175D38
	for <linux-kernel@vger.kernel.org>; Mon,  9 Sep 2024 06:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.208.246.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725862447; cv=none; b=ujDZUnX9+YJtrCD75pfCGVptitvFVa7n8Qg1Visgf89OnyKlYiRFknRt7hw9cYlyQRVXKsaqHbrtGuFXsaqwcuKN2Fu9peHrVE2LynZXPAzu3wyj4m/o5oZL9HDpSTuVCk09y3OCVa/R1n3AunwYG3eNzY9Fq8xQ4UJ7YLSQrTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725862447; c=relaxed/simple;
	bh=fmzElHuSLUBfIJGFvFgAeN9qQ+wZsIfefnRlpynSBv8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=r24IUdX1SafNvCRj2Uaqk9wQL0VhYNgMcBcSiUC7KAeeDRmiilTzvKeAZjtBAwAae++lG3+qDmnC41ohFsVpp8JioOfo4i1mS+uL/iOcZMogT/Fv5B0l20mDWHrLwON4PXs7chlV6h18ZIoW393EM0jYEN8ysUFXyDEp9F9fFBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xry111.site; spf=pass smtp.mailfrom=xry111.site; dkim=pass (1024-bit key) header.d=xry111.site header.i=@xry111.site header.b=H1+IEvuu; arc=none smtp.client-ip=89.208.246.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xry111.site
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xry111.site
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xry111.site;
	s=default; t=1725862443;
	bh=fmzElHuSLUBfIJGFvFgAeN9qQ+wZsIfefnRlpynSBv8=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=H1+IEvuugsbp9AkeDlieaLMjybuy5Rd6CfgJUM15EexYB/M/cFgwkzcdbOY55I+qT
	 rJqZcmQZTabl0w810yZjgklk6ZaJp4h7Mv+wn8Du2LuetbdQy7jjvqTUAjlDU0NthI
	 qcqb5NqUuZ/JvK0BBqtGx89tuSxRCWTxpd5dvxxQ=
Received: from [IPv6:240e:358:1197:300:dc73:854d:832e:2] (unknown [IPv6:240e:358:1197:300:dc73:854d:832e:2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (secp384r1) server-digest SHA384)
	(Client did not present a certificate)
	(Authenticated sender: xry111@xry111.site)
	by xry111.site (Postfix) with ESMTPSA id A95F666D29;
	Mon,  9 Sep 2024 02:14:00 -0400 (EDT)
Message-ID: <79f74b9c3df579fb8f22276c8dfe7196221e806e.camel@xry111.site>
Subject: Re: [PATCH v3 3/4] LoongArch: Set AS_HAS_THIN_ADD_SUB as y if
 AS_IS_LLVM
From: Xi Ruoyao <xry111@xry111.site>
To: Huacai Chen <chenhuacai@kernel.org>
Cc: Tiezhu Yang <yangtiezhu@loongson.cn>, Josh Poimboeuf
 <jpoimboe@kernel.org>,  Peter Zijlstra <peterz@infradead.org>,
 loongarch@lists.linux.dev, linux-kernel@vger.kernel.org
Date: Mon, 09 Sep 2024 14:13:55 +0800
In-Reply-To: <CAAhV-H79ToM4t_=b-teWT=2HVF8JcrwHYC+OeepXm51QjTw_eA@mail.gmail.com>
References: <20240807085906.27397-1-yangtiezhu@loongson.cn>
	 <20240807085906.27397-4-yangtiezhu@loongson.cn>
	 <c75a2de763dc8ea42a734490936f198a6ad07349.camel@xry111.site>
	 <CAAhV-H79ToM4t_=b-teWT=2HVF8JcrwHYC+OeepXm51QjTw_eA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2024-09-09 at 09:04 +0800, Huacai Chen wrote:
> On Sun, Sep 8, 2024 at 10:43=E2=80=AFPM Xi Ruoyao <xry111@xry111.site> wr=
ote:
> >=20
> > On Wed, 2024-08-07 at 16:59 +0800, Tiezhu Yang wrote:
> > > When building kernel with "make CC=3Dclang defconfig", LLVM Assembler
> > > is used due to LLVM_IAS=3D0 is not specified, then AS_HAS_THIN_ADD_SU=
B
> > > is not set, thus objtool can not be built after enable it for Clang.
> > >=20
> > > config AS_HAS_THIN_ADD_SUB is to check whether -mthin-add-sub option =
is
> > > available to know R_LARCH_{32,64}_PCREL are supported for GNU Assembl=
er,
> > > there is no this option for LLVM Assembler. The minimal version of Cl=
ang
> > > is 18 for building LoongArch kernel, and Clang >=3D 17 already suppor=
ts
> > > R_LARCH_{32,64}_PCREL, that is to say, there is no need to depend on
> > > AS_HAS_THIN_ADD_SUB for Clang, so just set AS_HAS_THIN_ADD_SUB as y i=
f
> > > AS_IS_LLVM.
> > >=20
> > > Fixes: 120dd4118e58 ("LoongArch: Only allow OBJTOOL & ORC unwinder if=
 toolchain supports -mthin-add-sub")
> > > Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
> >=20
> > This is what I wanted in
> > https://lore.kernel.org/all/20240604150741.30252-1-xry111@xry111.site/.
> Then which one is better?=C2=A0 AS_IS_LLVM or CC_IS_CLANG?

AS_IS_LLVM should be better because when "make LLVM=3D1 LLVM_IAS=3D0" we
still need to check against gas from binutils.

--=20
Xi Ruoyao <xry111@xry111.site>
School of Aerospace Science and Technology, Xidian University

