Return-Path: <linux-kernel+bounces-320271-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 76FD7970837
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Sep 2024 16:49:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 203FE1F21CE9
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Sep 2024 14:49:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB5A8171658;
	Sun,  8 Sep 2024 14:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xry111.site header.i=@xry111.site header.b="NG2S5lLm"
Received: from xry111.site (xry111.site [89.208.246.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B192516630E
	for <linux-kernel@vger.kernel.org>; Sun,  8 Sep 2024 14:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.208.246.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725806937; cv=none; b=rgre6JsWZWu9AJcOohg69oFZh3ORQxdGZfoi8LubN/2BiblVL+JEVMT7bNM+0dHVsfSqTuMH5jtY+4sK1cDxoy4P0izicy29VMrDczxrjlj2lqM7GISXva/Rh1wUgzu4wwUip4SzGmyLkw8bRIK5DjnRYuoEf8nctQJ58guUyi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725806937; c=relaxed/simple;
	bh=b9ZHpPU7fHgDP46JdtdbnVn5kDILGONuZcMcJ+8oFAU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=uVL2c+tggqYQy3q6lI3gNsrRUaJ3/z/ePRmOtGF1WuM0V5rfWqy3yc1fOAoZV0rQJjdy7JxOvwu3odJ7E6giJxRSE5GBQknIlZFZN7XKJoe3s2TcIiWCwThDMbsUXXpfZJcMEaLTmKxoTkxt0Oyyg/AlfeG5Og1gYE9+ZGLxl80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xry111.site; spf=pass smtp.mailfrom=xry111.site; dkim=pass (1024-bit key) header.d=xry111.site header.i=@xry111.site header.b=NG2S5lLm; arc=none smtp.client-ip=89.208.246.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xry111.site
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xry111.site
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xry111.site;
	s=default; t=1725806569;
	bh=0nBvIXI1Xrh+4qFlXlqkpL124CaVlEGXUIHWyQUvX/Y=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=NG2S5lLmOLYyQt9beGGyX8udhsnnxLlHDkox/MJxR5iD2XfMc5/XRZPdPlZvrsuSL
	 pcDe7KKZFj4f7GI4G8esCbVTfNPwtlZfYaKOoHi+KaXsEpBJV+7ewmK6UT8o0RMjUI
	 ngEBCGNdNsmg/UPsM5TOHNOCYEk749TydgR7pwbo=
Received: from [192.168.124.11] (unknown [113.200.174.95])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (secp384r1) server-digest SHA384)
	(Client did not present a certificate)
	(Authenticated sender: xry111@xry111.site)
	by xry111.site (Postfix) with ESMTPSA id 87182673D9;
	Sun,  8 Sep 2024 10:42:48 -0400 (EDT)
Message-ID: <c75a2de763dc8ea42a734490936f198a6ad07349.camel@xry111.site>
Subject: Re: [PATCH v3 3/4] LoongArch: Set AS_HAS_THIN_ADD_SUB as y if
 AS_IS_LLVM
From: Xi Ruoyao <xry111@xry111.site>
To: Tiezhu Yang <yangtiezhu@loongson.cn>, Josh Poimboeuf
 <jpoimboe@kernel.org>,  Peter Zijlstra <peterz@infradead.org>, Huacai Chen
 <chenhuacai@kernel.org>
Cc: loongarch@lists.linux.dev, linux-kernel@vger.kernel.org
Date: Sun, 08 Sep 2024 22:42:45 +0800
In-Reply-To: <20240807085906.27397-4-yangtiezhu@loongson.cn>
References: <20240807085906.27397-1-yangtiezhu@loongson.cn>
	 <20240807085906.27397-4-yangtiezhu@loongson.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2024-08-07 at 16:59 +0800, Tiezhu Yang wrote:
> When building kernel with "make CC=3Dclang defconfig", LLVM Assembler
> is used due to LLVM_IAS=3D0 is not specified, then AS_HAS_THIN_ADD_SUB
> is not set, thus objtool can not be built after enable it for Clang.
>=20
> config AS_HAS_THIN_ADD_SUB is to check whether -mthin-add-sub option is
> available to know R_LARCH_{32,64}_PCREL are supported for GNU Assembler,
> there is no this option for LLVM Assembler. The minimal version of Clang
> is 18 for building LoongArch kernel, and Clang >=3D 17 already supports
> R_LARCH_{32,64}_PCREL, that is to say, there is no need to depend on
> AS_HAS_THIN_ADD_SUB for Clang, so just set AS_HAS_THIN_ADD_SUB as y if
> AS_IS_LLVM.
>=20
> Fixes: 120dd4118e58 ("LoongArch: Only allow OBJTOOL & ORC unwinder if too=
lchain supports -mthin-add-sub")
> Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>

This is what I wanted in
https://lore.kernel.org/all/20240604150741.30252-1-xry111@xry111.site/.

Reviewed-by: Xi Ruoyao <xry111@xry111.site>

> ---
> =C2=A0arch/loongarch/Kconfig | 2 +-
> =C2=A01 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/arch/loongarch/Kconfig b/arch/loongarch/Kconfig
> index 70f169210b52..e1b6cb306d4d 100644
> --- a/arch/loongarch/Kconfig
> +++ b/arch/loongarch/Kconfig
> @@ -265,7 +265,7 @@ config AS_HAS_FCSR_CLASS
> =C2=A0	def_bool $(as-instr,movfcsr2gr \$t0$(comma)\$fcsr0)
> =C2=A0
> =C2=A0config AS_HAS_THIN_ADD_SUB
> -	def_bool $(cc-option,-Wa$(comma)-mthin-add-sub)
> +	def_bool $(cc-option,-Wa$(comma)-mthin-add-sub) || AS_IS_LLVM
> =C2=A0
> =C2=A0config AS_HAS_LSX_EXTENSION
> =C2=A0	def_bool $(as-instr,vld \$vr0$(comma)\$a0$(comma)0)

--=20
Xi Ruoyao <xry111@xry111.site>
School of Aerospace Science and Technology, Xidian University

