Return-Path: <linux-kernel+bounces-280013-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6924B94C487
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 20:37:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 186561F27247
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 18:37:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D0E414D6EB;
	Thu,  8 Aug 2024 18:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Co8/ikxR"
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F08BE13D63E
	for <linux-kernel@vger.kernel.org>; Thu,  8 Aug 2024 18:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723142218; cv=none; b=Fgls0nX7P5p4RvDdYA1Bnwes0ZlxmvbqEnF7jXqsJHd4mWYQB1ARl+HqOJ/cIzDUKbY4lNe/Rz6hKnRIuaGQQ6MPhhUITMlEiOkEEMI6RKwC72fxjM/P32/4EIo9bMjqO7JUkG4MYkmjObShHgJyDtQWgTSRdVzzK9lRs8vyhFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723142218; c=relaxed/simple;
	bh=VlLUMqsPKHjYynux8QgqXV76m4Utqoi7re4SUALKn4c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=t2xipKpx0LdF/ZZvbxfmASUrW17R+eB57uIxwZL9mSnKI6yJ+qCMDPWOSFf89wgzP/tjIzkPGgkvVvCP4cmdbMSUpoRG8dOxmybsQiU6V8hQvHJUwxzS/sjIkTucwwxlkbKcgbVpF8xfq8EEPZSNja6I7vhTj70l5H1ENQXdFak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Co8/ikxR; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5a1b073d7cdso469a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 08 Aug 2024 11:36:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723142215; x=1723747015; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AUiHQdGUYRTRZksaVvFbHULoWNzG0269iJwVT5/7aW0=;
        b=Co8/ikxRIqCN925u7WE9vm1inqQy2VGZVmNrW7mzTFeVeANP/P2qZbVzIDlxlrYwfV
         7Va7dtI0CaJntR3w2yJlN9BTfBczQkJHjAZJvLUxm0IHZZgT62wpNW6RfBkzQ/GQz6Sl
         l/DRzytDv956doMC1FPozPkOD8hfXGB0uKP6xrizBoEdzv/igtOl6F5wQCJ5aKgcj90y
         DmL5HLsRk6aqeZNqb5bIS0jUJHirGT5tRJqKfW4oFWdUjUBCA7CN3bIrfKnkFXDb1HwP
         DWGA4RREpywbKB/hHnY/hZ7dQq2ySUwf45/e2VxvyoFpyZhxseGYY6cchRjyUfE+dCHj
         YFuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723142215; x=1723747015;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AUiHQdGUYRTRZksaVvFbHULoWNzG0269iJwVT5/7aW0=;
        b=t2rcLtoT5oxIrWgZLqJRKGnR7k7jCA81NSy4n6gT3MHvsAjRxX/rbsMvjVA0eRR8yW
         dqnWNhkzXELA4Nj832BDUOWj9y+wgKme3mEahf4QHnPzGbWncH2UsdMjMLY/DrtYI4qd
         fLvupBS6P32Ot9i6vbXMLAjrI7tzY2eUOdJLttUBPPhcGGyV4/9o4KPN5wnmeJMa1KDk
         d9d5n6vLJEosV9hZq+lAtfC5OAH+1gbHpmPMlk19K1FvS6X9vh+9RkgFbYvDZDn8bKPx
         DKr3JccGKLT+yBwRR5axUHinScgePI7pdQ/R4PODrmcQDmsiJfS9VvxVS5z4+6TXgNt/
         XqqA==
X-Forwarded-Encrypted: i=1; AJvYcCW9aGuP/h5BHMoGpia+Ehe3iICfaFnen1Z+OdkwrbeyJDV/vxpBWuzq56MW3DPKCZ4m2ErF+sSRckwDv0J4Xjdo6rauXD/JuthSe9xB
X-Gm-Message-State: AOJu0Yz6907DYL268kGC+zySFPjyy1wMyfjNolzidNfXNLkgMQmpsUjU
	APPe/Imf09B2V469uvwYp3X5aG9pqSyNhSMPZ59a7XuNOfGUXnA1IVQT1Z803Feewdb6Gal4yoM
	9M+HW0r8bP8XvZ0jnOItG8ggTFeafmqi+CFrr
X-Google-Smtp-Source: AGHT+IF76YCRlol+VaBff83BpYeNuFvu+aIiNuVvaKlOiVPlqg9lL9OA9dYb+7cLVxCzSEDJLygo9YoZhUgovQLCQ1E=
X-Received: by 2002:a05:6402:27d4:b0:57d:436b:68d6 with SMTP id
 4fb4d7f45d1cf-5bbbc8a8c0dmr16476a12.7.1723142214918; Thu, 08 Aug 2024
 11:36:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240807124103.85644-1-mpe@ellerman.id.au> <20240807124103.85644-2-mpe@ellerman.id.au>
 <CALmYWFsCrMxkA1v58fJxtyGR15ZGxmSP8x7QC=oeKwzcwGL76A@mail.gmail.com>
 <gtz7s4eyzydaomh2msvfhpemhiruexy53nutd3fwumqfpos7v5@4fnqun2olore>
 <CALmYWFvqoxyBf4iP7WPTU_Oxq_zpRzvaBOWoHc4n4EwQTYhyBA@mail.gmail.com>
 <babup6k7qh5ii5avcvtz2rqo4n2mzh2wjbbgk5xeuivfypqnuc@2gydsfao3w7b>
 <CALmYWFsAT+Cb37-cSTykc_P7bJDHmFa7mWD5+B1pEz73thchcQ@mail.gmail.com>
 <lhe2mky6ahlk2jzvvfjyongqiseelyx2uy7sbyuso6jcy3b2dq@7ju6cea62jgk>
 <CAHk-=wgTXVMBRuya5J0peujSrtunehRtzk=WVrm6njPhHrpTJw@mail.gmail.com>
 <CALmYWFtAenAQmUCSrW8Pu6eNYMcfDe9R4f87XgUxaO4gsfzVQg@mail.gmail.com> <6i3f5bvcppm4bkpphcb7sxsopmeani5mg5irytc3nr464p24ka@jpno77j7cgyd>
In-Reply-To: <6i3f5bvcppm4bkpphcb7sxsopmeani5mg5irytc3nr464p24ka@jpno77j7cgyd>
From: Jeff Xu <jeffxu@google.com>
Date: Thu, 8 Aug 2024 11:36:16 -0700
Message-ID: <CALmYWFvXKdfyvZTfu9D4GdBgeVHzLR2rXshqZMFPjU+FuAHJkQ@mail.gmail.com>
Subject: Re: [PATCH 2/4] powerpc/mm: Handle VDSO unmapping via close() rather
 than arch_unmap()
To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, Jeff Xu <jeffxu@google.com>, 
	Linus Torvalds <torvalds@linux-foundation.org>, Michael Ellerman <mpe@ellerman.id.au>, linux-mm@kvack.org, 
	linuxppc-dev@lists.ozlabs.org, akpm@linux-foundation.org, 
	christophe.leroy@csgroup.eu, jeffxu@chromium.org, 
	linux-kernel@vger.kernel.org, npiggin@gmail.com, oliver.sang@intel.com, 
	pedro.falcato@gmail.com, Kees Cook <keescook@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 8, 2024 at 11:08=E2=80=AFAM Liam R. Howlett <Liam.Howlett@oracl=
e.com> wrote:
>
> * Jeff Xu <jeffxu@google.com> [240807 23:37]:
> > On Wed, Aug 7, 2024 at 8:21=E2=80=AFPM Linus Torvalds
> > <torvalds@linux-foundation.org> wrote:
> > >
> > > On Wed, 7 Aug 2024 at 16:20, Liam R. Howlett <Liam.Howlett@oracle.com=
> wrote:
> > > >
> > > > Okay, I'm going to try one more time here.  You are suggesting to h=
ave a
> > > > conf flag to leave the vdso pointer unchanged when it is unmapped.
> > > > Having the close behind the conf option will not prevent it from be=
ing
> > > > unmapped or mapped over, so what you are suggesting is have a
> > > > configuration option that leaves a pointer, mm->context.vdso, to be
> > > > unsafe if it is unmapped if you disable checkpoint restore.
> > >
> > This is a new point that I didn't realize before, if we are going to ha=
ndle
> > unmap vdso safely, yes, this is a bugfix that should be applied everywh=
ere
> > for all arch, without CHECKPOINT_RESTORE config.
> >
> > Do we need to worry about mmap(fixed) ? which can have the same effect
> > as mremap.
>
> Yes, but it should be handled by vm_ops->close() when MAP_FIXED unmaps
> the vdso.  Note that you cannot MAP_FIXED over half of the vma as the
> vm_ops->may_split() is special_mapping_split(), which just returns
> -EINVAL.
>
The may_split() failure logic is specific to vm_special_mapping, right ?

Do we still need to keep vm_special_mapping struct , if we are going to
treat  special vma as normal vma ?


> Thanks,
> Liam

