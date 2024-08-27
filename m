Return-Path: <linux-kernel+bounces-304052-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0501E961931
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 23:29:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 83281B21F4D
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 21:29:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD42F1D365F;
	Tue, 27 Aug 2024 21:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aeS5pCiu"
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FA4418859A
	for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2024 21:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724794164; cv=none; b=gNbOY8b6L5HB8J6YFjuUjrq08bXDIwIznRuIZFOv0KKvNHHLBFGCpJo/WNUK1yd1rrQe0rAqRG7XJx1+iGMrua50rfC7F8Zw2PRs46Sm5CPnCJQCaO0cRewQYX/chfY7GPCH5hXd8gFqlYlIejfb/mFnHlso5/4M8RQIjUew19U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724794164; c=relaxed/simple;
	bh=R4HLYZ+UViFtWMxsFQtEArNLC47KC7MUZLfJAYG+8L4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rW4SC153e6kE8+C8m0WhiTnuka9c8Wj2wyPmUwefD5uBnFS5u+Wj+QpTAxPUC/j7bEXYd4QOuCQ3kK1oLgrofrxQi1Ofl3ewc4aAxxXG5njBN6NA9+B1KEhRiAqQlBBUbom5+S0fnvZDvh0RNzFkStjcNjx8T+VPwHxUgvWBH0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=aeS5pCiu; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-45029af1408so34591cf.1
        for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2024 14:29:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1724794162; x=1725398962; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JTy0kGwiDI5gZsttd0+HgzSva3UgwhiIE4UArdRmSDM=;
        b=aeS5pCiuowoHxtLK1uLaxQFgn0S9/UUkG4cyjsTu0vFAHjaSxLxZBTI9B0nNoV84/7
         glSfv3Kt4oEk8mvvCA6HlDqlZqXxjxELAWkTr0LvLQM64ScXv0EalOW06F3n1g2YeSAk
         ekwbfbG8ZM364aQ2F4mIxU9E+RS3YhL9fjdkU1QlUYvi6/D6Ljv9cw4zeLlXsGGL9iP6
         cwyJHXwQ3L2/lwySjIy4Qj3NAmCOXJCckw96i/ddgwH83iZojIqqn77hTQ/QgYBBYy0T
         D6/q8DppXHIG4/5VspQ2+/CXbMzTpSdkpDvDqOO821HxyBT2Pwgh8C4tFsbFDEfyi1ob
         6v+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724794162; x=1725398962;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JTy0kGwiDI5gZsttd0+HgzSva3UgwhiIE4UArdRmSDM=;
        b=aF+7vD2SrmpAB0GZcJHln5Y2TSdFpWPn+jveJJklv17FQckMxLfVw4A8/pt63lrOeE
         ISQv9oM3gdBji6rKajZ2iVywOa1jpt3Fp+86e/pCunaN0GTIQDvaJ/m4bPwYkK+b6DX7
         nQRJOd7tcAUBavoRp62Mak66N6tn8xRBdvUsCZxg3r+SEFsSzQyd/YqalKwF+1xP2jaQ
         NnfXrFuDUHURuOfmYo3+nrt5L8+9B/V3v1RvmtPmo/qHMIKobPwWC+Kn2yt0Ec0s1yUl
         u2rtk1uyU++ymfglrk7fsACWZrQIeRKdjH6j6pXiVTHYyKREiUbR68dK6HWGneI39zTg
         +K3w==
X-Forwarded-Encrypted: i=1; AJvYcCWqFcp+1lOfL1O4LnsWdNmzDiq9Sn5k0+rKdlZwCAT2N5SEsJbzRI+/zYMUjZVBn3zn7Kc8haiWOWQjZoQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yygcd6RIQgBaG5iU10guFbhold4TLTkajrg8MJA5Y6pijNAx9i5
	QmrDQITpk/HVeMRmG4TrJYRRv1SbQGrNCEcd4z1VNQVwsZxheROGllpyc0AKiCRwdaFHXG7eqHN
	6OdmVUNHyt+2N9uRMVVlUyEkO1njMGLq3T3uN
X-Google-Smtp-Source: AGHT+IESYT6ErEPekdnM4JPG1QAmj//Y4YNR4GKOjrbinkZvJAz7qCJ6vDkOQJqXUvV1BbfJh1Ad0J1bwqMfl5vfrVg=
X-Received: by 2002:a05:622a:2cc:b0:44f:9e0f:bc41 with SMTP id
 d75a77b69052e-4566e2c44a8mr191491cf.27.1724794161723; Tue, 27 Aug 2024
 14:29:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240815173903.4172139-21-samitolvanen@google.com>
 <20240815173903.4172139-24-samitolvanen@google.com> <d63ddefe-a6f6-4a5b-9330-11438fca8f9f@suse.com>
In-Reply-To: <d63ddefe-a6f6-4a5b-9330-11438fca8f9f@suse.com>
From: Sami Tolvanen <samitolvanen@google.com>
Date: Tue, 27 Aug 2024 21:28:42 +0000
Message-ID: <CABCJKud2za5o19O4XuE-jxuevwQLZPd+CdoB5tMHCgtG2Q2upQ@mail.gmail.com>
Subject: Re: [PATCH v2 03/19] gendwarfksyms: Add address matching
To: Petr Pavlu <petr.pavlu@suse.com>
Cc: Masahiro Yamada <masahiroy@kernel.org>, Luis Chamberlain <mcgrof@kernel.org>, 
	Miguel Ojeda <ojeda@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Matthew Maurer <mmaurer@google.com>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Wedson Almeida Filho <wedsonaf@gmail.com>, Gary Guo <gary@garyguo.net>, Neal Gompa <neal@gompa.dev>, 
	Hector Martin <marcan@marcan.st>, Janne Grunau <j@jannau.net>, Asahi Linux <asahi@lists.linux.dev>, 
	linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-modules@vger.kernel.org, rust-for-linux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Petr,

On Tue, Aug 27, 2024 at 12:40=E2=80=AFPM Petr Pavlu <petr.pavlu@suse.com> w=
rote:
>
> On 8/15/24 19:39, Sami Tolvanen wrote:
> > +static inline u32 symbol_addr_hash(const struct symbol_addr *addr)
> > +{
> > +     return jhash(addr, sizeof(struct symbol_addr), 0);
>
> I would be careful and avoid including the padding between
> symbol_addr.section and symbol_addr.address in the hash calculation.

Good catch. I'll fix this in the next version.

> > +static int elf_for_each_symbol(int fd, elf_symbol_callback_t func, voi=
d *arg)
> > +{
> > +     size_t sym_size;
> > +     GElf_Shdr shdr_mem;
> > +     GElf_Shdr *shdr;
> > +     Elf_Data *xndx_data =3D NULL;
> > +     Elf_Scn *scn;
> > +     Elf *elf;
> > +
> > +     if (elf_version(EV_CURRENT) !=3D EV_CURRENT) {
> > +             error("elf_version failed: %s", elf_errmsg(-1));
> > +             return -1;
> > +     }
> > +
> > +     elf =3D elf_begin(fd, ELF_C_READ_MMAP, NULL);
> > +     if (!elf) {
> > +             error("elf_begin failed: %s", elf_errmsg(-1));
> > +             return -1;
> > +     }
> > +
> > +     sym_size =3D gelf_getclass(elf) =3D=3D ELFCLASS32 ? sizeof(Elf32_=
Sym) :
> > +                                                   sizeof(Elf64_Sym);
> > +
> > +     scn =3D elf_nextscn(elf, NULL);
> > +
> > +     while (scn) {
> > +             shdr =3D gelf_getshdr(scn, &shdr_mem);
> > +
> > +             if (shdr && shdr->sh_type =3D=3D SHT_SYMTAB_SHNDX) {
> > +                     xndx_data =3D elf_getdata(scn, NULL);
> > +                     break;
> > +             }
> > +
> > +             scn =3D elf_nextscn(elf, scn);
> > +     }
> > +
> > +     scn =3D elf_nextscn(elf, NULL);
> > +
> > +     while (scn) {
> > +             shdr =3D gelf_getshdr(scn, &shdr_mem);
> > +
> > +             if (shdr && shdr->sh_type =3D=3D SHT_SYMTAB) {
> > +                     Elf_Data *data =3D elf_getdata(scn, NULL);
> > +                     unsigned int nsyms =3D data->d_size / sym_size;
>
> I think strictly speaking this should be:
> size_t nsyms =3D shdr->sh_size / shdr->sh_entsize;
> .. and the code could check that shdr->sh_entsize is same as what
> gelf_fsize(elf, ELF_T_SYM, 1, EV_CURRENT) returns.

Sure, I can change this. I'm not sure if there's a situation where the
current calculation wouldn't result in the exact same result though.

> > +                     unsigned int n;
> > +
> > +                     for (n =3D 0; n < nsyms; ++n) {
>
> The first symbol in the symbol table is always undefined, the loop can
> start from 1.

Ack.

> Alternatively, since elf_for_each_symbol() ends up in the entire series
> being used only with process_symbol() which skips symbols with the local
> binding, the function could be renamed to elf_for_each_global_symbol()
> and start the loop from shdr->sh_info.

Patch 15 ("Add support for declaration-only data structures") actually
also needs to process local symbols, so we can't skip them completely.

Sami

