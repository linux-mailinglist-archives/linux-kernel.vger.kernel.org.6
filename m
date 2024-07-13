Return-Path: <linux-kernel+bounces-251416-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EF2E69304A9
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jul 2024 11:10:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 78DED1F21DF1
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jul 2024 09:10:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8D4949637;
	Sat, 13 Jul 2024 09:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xry111.site header.i=@xry111.site header.b="fwVb40yW"
Received: from xry111.site (xry111.site [89.208.246.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFD5A1B960
	for <linux-kernel@vger.kernel.org>; Sat, 13 Jul 2024 09:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.208.246.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720861831; cv=none; b=TQW1BQL0l8E53gmcEbzlZgIejMF+DF9TVuMlwwbrfoC0+Oh5F/pK6reTVBALjnT3yewpTeffLwcMawE3DuuCiMZ9a5nSJ6PC4uMhhS+ClYVAYuXbo0KiDhToJ2Przj2hhBQZoBL6bv6+Jjw9kv3yEc655xE+nHN/jeUA0IVMXYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720861831; c=relaxed/simple;
	bh=mWHp3Nx8+9JOgCrSKbu8tmKJaLPVPRCP0ARmlUfugkQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=bnVdNz3yHpK4QD2dqGpsdNb3iLj9uIGfzuV1E4GS2zqdNlJx8aB9bltIkvatMDLLjuREpuABiXAnTsGQtO0WxNIIxGs4lnWQqeZ16bKUvtcv3jNopUAxXXuTn+PmeUx6B1e9shQzsnwfiMS1MqY4G9aNDdpD3BMI3c7YXsI7F74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xry111.site; spf=pass smtp.mailfrom=xry111.site; dkim=pass (1024-bit key) header.d=xry111.site header.i=@xry111.site header.b=fwVb40yW; arc=none smtp.client-ip=89.208.246.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xry111.site
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xry111.site
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xry111.site;
	s=default; t=1720861826;
	bh=mWHp3Nx8+9JOgCrSKbu8tmKJaLPVPRCP0ARmlUfugkQ=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=fwVb40yWACAR8SL/bAmEY0FMZiN7rLTgrHEZnzG/by76RaU7i7qeegQTHMxLM/S8h
	 EJJLeJ62DXTs+AO7d1uxrBdpZri2yVnd688feLNXRKzlDcyxFAy768mFhXaJBQzVjd
	 IPJvbydDtb+iALMm+3BBTl5pXrfKEvTyNcYbvUd0=
Received: from [192.168.124.13] (unknown [113.200.174.50])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-384))
	(Client did not present a certificate)
	(Authenticated sender: xry111@xry111.site)
	by xry111.site (Postfix) with ESMTPSA id 452F9660BE;
	Sat, 13 Jul 2024 05:10:23 -0400 (EDT)
Message-ID: <ae3ff9787e9d3f41b71e8e4168610a01d5304371.camel@xry111.site>
Subject: Re: [RFC PATCH 4/4] LoongArch: Remove -fno-jump-tables for objtool
From: Xi Ruoyao <xry111@xry111.site>
To: Tiezhu Yang <yangtiezhu@loongson.cn>, Josh Poimboeuf
 <jpoimboe@kernel.org>,  Peter Zijlstra <peterz@infradead.org>, Huacai Chen
 <chenhuacai@kernel.org>
Cc: loongarch@lists.linux.dev, linux-kernel@vger.kernel.org
Date: Sat, 13 Jul 2024 17:10:20 +0800
In-Reply-To: <0adc4126e7fbb8fcf84bae67ebe39ff6da4721cd.camel@xry111.site>
References: <20240712091506.28140-1-yangtiezhu@loongson.cn>
	 <20240712091506.28140-5-yangtiezhu@loongson.cn>
	 <0adc4126e7fbb8fcf84bae67ebe39ff6da4721cd.camel@xry111.site>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2024-07-12 at 17:49 +0800, Xi Ruoyao wrote:
> On Fri, 2024-07-12 at 17:15 +0800, Tiezhu Yang wrote:
> > -ifdef CONFIG_OBJTOOL
> > -KBUILD_CFLAGS			+=3D -fno-jump-tables
> > -endif
> > +KBUILD_AFLAGS			+=3D $(call cc-option,-mannotate-tablejump) $(call cc-=
option,-Wa$(comma)-mannotate-tablejump)
> > +KBUILD_CFLAGS			+=3D $(call cc-option,-mannotate-tablejump) $(call cc-=
option,-Wa$(comma)-mannotate-tablejump)
>=20
> KBUILD_AFLAGS isn't needed, and $(call cc-option,-Wa$(comma)-mannotate-
> tablejump) will always expand to nothing because the assembler does not
> have -mannotate-tablejump.
>=20
> The assembler never creates a jump table itself.

BTW have you discussed with Lulu about the -mannotate-tablejump patch?=20
I guess maybe an intra-Loongson discussion would be helpful.

--=20
Xi Ruoyao <xry111@xry111.site>
School of Aerospace Science and Technology, Xidian University

