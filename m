Return-Path: <linux-kernel+bounces-416986-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8071A9D4D44
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 13:57:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 03C26B228D7
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 12:57:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BA861D7E52;
	Thu, 21 Nov 2024 12:57:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dkzw/x8t"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D95F91D319B
	for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2024 12:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732193829; cv=none; b=Y6GHzu7hiE10cdb0clSEYiW58eEXn6CO/RGE+HQTjjSO6fbSw6oLZw1Erpy8XjJyBFhZ6g267KM6pCdnBOkzpF2TMguaJr0jx8V2t9RouoSOd2Ev+jcbAgGYzbhX8MEV4AHCr6O7IZ8DiCfbxngZm4hlBTMN5fTb9XfQjJ8NNAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732193829; c=relaxed/simple;
	bh=LYY/0gO/5DyKnWfzScgnq6I79pY/6xxS/jTgq1IPRuo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dyDB7pUdtH/zvPaQizG/GDiXGm/dYE7sJVm/0Ck10JMLGFXeJYA1MdJQ4F+kCVkrge322MGYFsWSVC9Fr1+wglKy6jtfHcrUnwfysgivuMbEvgL8yy9JU2GMC6zxcFL3V0s/iXXMbsy4Gwn5LNfC2BsllsTL1gZv3JVC2EowHok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dkzw/x8t; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA97EC4CED6
	for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2024 12:57:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732193829;
	bh=LYY/0gO/5DyKnWfzScgnq6I79pY/6xxS/jTgq1IPRuo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=dkzw/x8tUGWYqIq+QooajqTdmlbLSZe6X9aNUZm/us8wK3WtPn+e5ZmKnw7DP3m9C
	 KADyX+6Mp0B+R9lbO1lzoWxigJl6IHhCTx5GzY5N+zhHkEWBAq9qPY33gsiqkVEuXR
	 DjXdvNDRdfSZlEqiovKPC1kD0teJ9ig0A4tTuas5RGlfIkckp7CFGRATpuIgi8Vvl8
	 V8QkpWTgT50GUpcCu76czPdog0HfsnWkNBnoaFxc+Oe8xfV2N/2pYL5Iw7eVN76SPo
	 qhSmeXzXH5UgNPmHUQt9RHW8/ZiAkwAfIF2ebn3lw3XthX0EKB3HVqnBisTNGFum3G
	 ZjHrPB8UJK2LQ==
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a99f3a5a44cso131948966b.3
        for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2024 04:57:09 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWruGwpNdVM1oMYmw14a7fy4iCi9fqVeQTvKi3plHwAQ39ux8yVY9OgG992ljy8XxivYdObKGkKEEEtUqw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1ctvzTHcVYIOVYFlJ+/2oVeTaFf26c96fm28Jp2uR6NLsan5F
	6GCajWz0ZAFC7pYaxU1wmzfFPP8UzCHYR2RNP6Vy9UYQbSRfwJqABp7QSEvm8VH5fj6ABRSOZOH
	iUZheBTD7Y5gvO5DgCsIvSXAKAyA=
X-Google-Smtp-Source: AGHT+IGSGOgiABiF9MbQE+CEekd/m4kgMGo/J+sBuZ9FLAP9ewe8HCkjDj5sRi2yQqJvv5iig+FNcPNulhLqw5n1PK0=
X-Received: by 2002:a17:907:2dac:b0:aa4:8186:5bea with SMTP id
 a640c23a62f3a-aa4dd580bb3mr569188866b.35.1732193828220; Thu, 21 Nov 2024
 04:57:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241119065655.21123-1-yangtiezhu@loongson.cn>
 <20241119065655.21123-6-yangtiezhu@loongson.cn> <c21f145f-c63d-ca37-b13b-2599d91492e8@loongson.cn>
In-Reply-To: <c21f145f-c63d-ca37-b13b-2599d91492e8@loongson.cn>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Thu, 21 Nov 2024 20:56:55 +0800
X-Gmail-Original-Message-ID: <CAAhV-H5b2=UPzW2W-etkBpCDoRUE+XrTdZNj-L1v2pozHXNmiQ@mail.gmail.com>
Message-ID: <CAAhV-H5b2=UPzW2W-etkBpCDoRUE+XrTdZNj-L1v2pozHXNmiQ@mail.gmail.com>
Subject: Re: [PATCH v3 05/10] objtool: Handle unreachable entry of rodata
To: Jinyang He <hejinyang@loongson.cn>, wanglei@loongson.cn
Cc: Tiezhu Yang <yangtiezhu@loongson.cn>, Josh Poimboeuf <jpoimboe@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, loongarch@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi, Jinyang,

On Tue, Nov 19, 2024 at 6:47=E2=80=AFPM Jinyang He <hejinyang@loongson.cn> =
wrote:
>
> On 2024-11-19 14:56, Tiezhu Yang wrote:
>
> > When compling with Clang on LoongArch, there exists unreachable entry
> > of rodata which points to a nop instruction after the function return
> > instruction, this is generated by compiler to fill the non-existent
> > switch case, just skip the entry when parsing the relocation section
> > of rodata.
> >
> > This is preparation for later patch on LoongArch, there is no effect
> > for the other archs with this patch.
> >
> > Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
> > ---
> >   tools/objtool/check.c | 8 ++++++++
> >   1 file changed, 8 insertions(+)
> >
> > diff --git a/tools/objtool/check.c b/tools/objtool/check.c
> > index eb4c89501493..17df3738e087 100644
> > --- a/tools/objtool/check.c
> > +++ b/tools/objtool/check.c
> > @@ -2136,6 +2136,14 @@ static int add_jump_table(struct objtool_file *f=
ile, struct instruction *insn,
> >               if (!dest_insn)
> >                       break;
> >
> > +             /* Handle the special cases compiled with Clang on LoongA=
rch */
> > +             if (file->elf->ehdr.e_machine =3D=3D EM_LOONGARCH &&
> > +                 reloc->sym->type =3D=3D STT_SECTION && dest_insn->typ=
e =3D=3D INSN_NOP &&
> Why it points to NOP, and whether it could be some other instruction
> (e.g. break)?
> It seems fragile. I think it should fix in Clang.

As discussed with Tiezhu and the developer of Clang compiler (Wang
Lei), this is just the implementation of Clang, the non-existent
switch case is filled in the jump table, the table entry points to a
position after the function return instruction, this is not an issue
for Clang.

Currently, objdump the object files of Linux kernel shows that the
position is a nop instruction.

But it is not necessary to check the position is a nop instruction, it
only needs to check whether the position is after the function return
instruction, so "dest_insn->type =3D=3D INSN_NOP" can be removed. I will
modify it when applying the patch.

Other patches seem to have no fundamental issues.

Huacai

> > +                 (!insn_func(dest_insn) || insn_func(dest_insn)->pfunc=
 !=3D pfunc)) {
> > +                     prev_offset =3D reloc_offset(reloc);
> > +                     continue;
> > +             }
> > +
> >               /* Make sure the destination is in the same function: */
> >               if (!insn_func(dest_insn) || insn_func(dest_insn)->pfunc =
!=3D pfunc)
> >                       break;
>

