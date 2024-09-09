Return-Path: <linux-kernel+bounces-320477-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A7694970AE3
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 03:05:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4F4881F21688
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 01:05:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C0C1B641;
	Mon,  9 Sep 2024 01:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M+ao+fkS"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF20B184F
	for <linux-kernel@vger.kernel.org>; Mon,  9 Sep 2024 01:05:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725843929; cv=none; b=Sn2vt1gXFzx6fn7F6qY5607oWKscQmutuizpgAetb/Aoae0O7Fseufsumws6T8VCyERRfgyqJVpvRhPCbj5db/CwOIGimP+6F4RekhNFkZXPJxM/At5rKeesJ2ExPgZKV7aary/MPe62gb3F14eetw0avJJPuMYgiKNM+Pu/sFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725843929; c=relaxed/simple;
	bh=KbGXoddUMv8tVgpHOzuLsp1Y9f2+g1Z2mKD35eOsmG4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gf5cAuAmDoH9XnhTNlQjoP4uLBlxwg/fVjbKg/uvcXip0Q0igSNc3Na1R/M2WmCLyVhCxwEAuTWtBwV7HLvLsEYSDNyI4fTM0rsa9dNnkTZI5dujhIKb48brrQKPp6E0CO2Ttrm8ZyyxQfCHV757+bty69U0MVyEir+EXdaIOAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M+ao+fkS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 878A4C4CEC3
	for <linux-kernel@vger.kernel.org>; Mon,  9 Sep 2024 01:05:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725843928;
	bh=KbGXoddUMv8tVgpHOzuLsp1Y9f2+g1Z2mKD35eOsmG4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=M+ao+fkSdbvSR1LKrZhO5JYsBGM7L2G4woKI9M6bYrJ3527PG/YSKr0xbTcavU5zl
	 Cb3Fy8yAdtBpHOA1AwHwconcskAKU6YAgmbeA5EIQ1Hx4/zA74INMf0U198kNzVfRI
	 tbGWYs7yhEa9a8JpdzAB+TohVbKJc0IPHeCu+F6QGKJQWHEtT0t8vHkGOpV/s5pldh
	 pOROC+YtPORF6OZZcAdxBrclpgh2WPnFYqOcOLDK4VlhbVwpmrkuJ7MJy/HiqJp+Hr
	 7g1/SGn6XOrIcsdCRZ9iANpbyIL7R0r4gBlpd//Wlib+qN3FXmchRMqh1CAbLMsymn
	 YB29ezBnj5Udg==
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5c24ebaa427so7374736a12.1
        for <linux-kernel@vger.kernel.org>; Sun, 08 Sep 2024 18:05:28 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUhNl7XvtVvTqz+CJo334+HNl594iYPqw6ERkpLxr6S2yi2uTSUyuPGkXYvS2PJ6Tz/XBNwUCeD/0qhPVs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy57v7oizfty+GRqSuiHnoGDSbJIiyJu17iIOo5hHzXUsDOv2HL
	wIrYKEBUAeZvKyy3DNuZUyXvdwb9AUmdu/wCvC6P6o2ygblfPigdBvTLATrjt7+9JSQNC49BVLP
	BfktRv6xOJuLHeN+NMDpoP0XO8rk=
X-Google-Smtp-Source: AGHT+IH8AH63UqVrIu0Y9NxMorp0PRx7ZvVEGeC9k+LaQZ5PSWisHqpL3cJh9I7v5UvkrtJwSJlAEEBiruEGhQgMYJY=
X-Received: by 2002:a05:6402:2808:b0:5bf:256a:a19e with SMTP id
 4fb4d7f45d1cf-5c3c1f74315mr19393826a12.4.1725843927158; Sun, 08 Sep 2024
 18:05:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240807085906.27397-1-yangtiezhu@loongson.cn>
 <20240807085906.27397-4-yangtiezhu@loongson.cn> <c75a2de763dc8ea42a734490936f198a6ad07349.camel@xry111.site>
In-Reply-To: <c75a2de763dc8ea42a734490936f198a6ad07349.camel@xry111.site>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Mon, 9 Sep 2024 09:04:58 +0800
X-Gmail-Original-Message-ID: <CAAhV-H79ToM4t_=b-teWT=2HVF8JcrwHYC+OeepXm51QjTw_eA@mail.gmail.com>
Message-ID: <CAAhV-H79ToM4t_=b-teWT=2HVF8JcrwHYC+OeepXm51QjTw_eA@mail.gmail.com>
Subject: Re: [PATCH v3 3/4] LoongArch: Set AS_HAS_THIN_ADD_SUB as y if AS_IS_LLVM
To: Xi Ruoyao <xry111@xry111.site>
Cc: Tiezhu Yang <yangtiezhu@loongson.cn>, Josh Poimboeuf <jpoimboe@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, loongarch@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 8, 2024 at 10:43=E2=80=AFPM Xi Ruoyao <xry111@xry111.site> wrot=
e:
>
> On Wed, 2024-08-07 at 16:59 +0800, Tiezhu Yang wrote:
> > When building kernel with "make CC=3Dclang defconfig", LLVM Assembler
> > is used due to LLVM_IAS=3D0 is not specified, then AS_HAS_THIN_ADD_SUB
> > is not set, thus objtool can not be built after enable it for Clang.
> >
> > config AS_HAS_THIN_ADD_SUB is to check whether -mthin-add-sub option is
> > available to know R_LARCH_{32,64}_PCREL are supported for GNU Assembler=
,
> > there is no this option for LLVM Assembler. The minimal version of Clan=
g
> > is 18 for building LoongArch kernel, and Clang >=3D 17 already supports
> > R_LARCH_{32,64}_PCREL, that is to say, there is no need to depend on
> > AS_HAS_THIN_ADD_SUB for Clang, so just set AS_HAS_THIN_ADD_SUB as y if
> > AS_IS_LLVM.
> >
> > Fixes: 120dd4118e58 ("LoongArch: Only allow OBJTOOL & ORC unwinder if t=
oolchain supports -mthin-add-sub")
> > Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
>
> This is what I wanted in
> https://lore.kernel.org/all/20240604150741.30252-1-xry111@xry111.site/.
Then which one is better?  AS_IS_LLVM or CC_IS_CLANG?

Huacai

>
> Reviewed-by: Xi Ruoyao <xry111@xry111.site>
>
> > ---
> >  arch/loongarch/Kconfig | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/arch/loongarch/Kconfig b/arch/loongarch/Kconfig
> > index 70f169210b52..e1b6cb306d4d 100644
> > --- a/arch/loongarch/Kconfig
> > +++ b/arch/loongarch/Kconfig
> > @@ -265,7 +265,7 @@ config AS_HAS_FCSR_CLASS
> >       def_bool $(as-instr,movfcsr2gr \$t0$(comma)\$fcsr0)
> >
> >  config AS_HAS_THIN_ADD_SUB
> > -     def_bool $(cc-option,-Wa$(comma)-mthin-add-sub)
> > +     def_bool $(cc-option,-Wa$(comma)-mthin-add-sub) || AS_IS_LLVM
> >
> >  config AS_HAS_LSX_EXTENSION
> >       def_bool $(as-instr,vld \$vr0$(comma)\$a0$(comma)0)
>
> --
> Xi Ruoyao <xry111@xry111.site>
> School of Aerospace Science and Technology, Xidian University

