Return-Path: <linux-kernel+bounces-280039-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9407B94C4E8
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 20:52:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0C86CB25693
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 18:52:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A45C914830A;
	Thu,  8 Aug 2024 18:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GSxuQbLn"
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40FE913774A
	for <linux-kernel@vger.kernel.org>; Thu,  8 Aug 2024 18:52:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723143168; cv=none; b=sijBAIe2L2/1BT+dpL6RvrYFRVrJuUDEjAX3Okv9gEjW149fLSkvxLMqpS+b7VHh7zAwj/vPMLSBxqnF5//GTTaPwVeZWosdb5meE9pgxxaFnVX7TNgXKTHoaRkvJV5gVFQpkU0wioiEoQE5QQNgmj6SYajHjfdf0DtLBaZNVqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723143168; c=relaxed/simple;
	bh=FN36uBbCXXGcwL7Wz/H4LuG1T8k/XyGLhMYn63AOXnw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=HQYTEgH+AlWcb5yrlINHsMB6WPZmkIrTsSWNcCTdOIftUeOQc7AR1Ar1hUa5SVg4PZrsiLAaNsXW+2EvsoFPPiTXdiPf1hjQsmrOoTzAMcuU7TNU4OMkVqtbBDh0um9aHso5r/ofZc92XtRl5lrDwcgei4qKaxWX5lWoGlIGd98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GSxuQbLn; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5a18a5dbb23so311a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 08 Aug 2024 11:52:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723143165; x=1723747965; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DTr7QPxZOv6ZANTvHJnD7itspZcoPGqbySruN9g+g4c=;
        b=GSxuQbLnIOgcxXFsqlgSoLA0HaZVnd2Hq+OdmfCgHwjEIu2MYew9tW5PTTvTMWZLMp
         iITmF2RCUsp2eD93UpZOwbgdbQWTKEJmtLJMZ30lnWpO62btbAaW0CqRd0U9B6jzJyBl
         66pWgrLL/shyAD6LePQ07vG7CBbo4qSXCgZnXSD5rwA+8Nmlj2l6jXA6q9XmhaW0O5Td
         h3gvf2WPDsM6AtoS/yJdqKVwRVmL+XIshaJfq6fqnWfEtwATOUy87yJhzKFqO+3FsCf+
         sDUIMw9U3PE+t1gKnIvfYpJcnP8Ky63bbYj1qyKqFuzhwh8OYm+p/N3pY+/6vvI2IG9/
         ttfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723143165; x=1723747965;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DTr7QPxZOv6ZANTvHJnD7itspZcoPGqbySruN9g+g4c=;
        b=wUDKknbFncAHBxf0OPfbP2x2K4msjVdjS+LMOcnf7rHjra706dZ6wW9lwa0GU2MTSN
         ZHPL6Om4P9jjz1JbKtRdNybf8D71B1qULBsfZnIT+7JiLsSUqbMnB8k1NIM6R/BeAN10
         2ygkbYZsHrr6rxylPCznA7isQ5nITxpckdmP+XiWlyqmTySIv/hHrHguncr/p7jpKiZ4
         X8acovkpETvfSBUp8/W0BYA4xbYmVozXJuZR8jVyEZGEJ4Cf0U1M7UHv7lezpluy4tSq
         l9ejRaxsvTTIJQ45eLTyAzIoe7u2JzZnNSRV25LsLDo/S5uO0lNPw26mIy+a3ZfvjM7p
         fKvQ==
X-Forwarded-Encrypted: i=1; AJvYcCXQNQrsM36lVfx9SP3Wv3spRuc4/JysxhECP++CMVzKX2I4yYN9G79XYN7f905hJLcQldGWEBETfs71igc90acxoymHhVWgV30eB7dV
X-Gm-Message-State: AOJu0YyZtbRoV8tuN0yEZaZoUfSG6L+XK9r1YUVBN9ApsupKl/jXzsk8
	azDK+vfrtLWpmHjJnvn3cnPc3+Xplq0ZRrrGYsnERnynEeT9bGfFsvbDPtqvQVkC/abAFPyiqxa
	Jw+5B0lYW6d0TIswsglTz3D/O+eqOl6DGKhXX
X-Google-Smtp-Source: AGHT+IFCgJzX0rsSfextMUWKoTY+8ON0bM39EuVj+wqU5VsofAbRLMRUfcqJbeBCecOmrdKT/V+64+NhNCnphbPoezs=
X-Received: by 2002:a05:6402:268f:b0:58b:93:b624 with SMTP id
 4fb4d7f45d1cf-5bbbc7c62c2mr22073a12.1.1723143165252; Thu, 08 Aug 2024
 11:52:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CALmYWFsCrMxkA1v58fJxtyGR15ZGxmSP8x7QC=oeKwzcwGL76A@mail.gmail.com>
 <gtz7s4eyzydaomh2msvfhpemhiruexy53nutd3fwumqfpos7v5@4fnqun2olore>
 <CALmYWFvqoxyBf4iP7WPTU_Oxq_zpRzvaBOWoHc4n4EwQTYhyBA@mail.gmail.com>
 <babup6k7qh5ii5avcvtz2rqo4n2mzh2wjbbgk5xeuivfypqnuc@2gydsfao3w7b>
 <CALmYWFsAT+Cb37-cSTykc_P7bJDHmFa7mWD5+B1pEz73thchcQ@mail.gmail.com>
 <lhe2mky6ahlk2jzvvfjyongqiseelyx2uy7sbyuso6jcy3b2dq@7ju6cea62jgk>
 <CAHk-=wgTXVMBRuya5J0peujSrtunehRtzk=WVrm6njPhHrpTJw@mail.gmail.com>
 <CALmYWFtAenAQmUCSrW8Pu6eNYMcfDe9R4f87XgUxaO4gsfzVQg@mail.gmail.com>
 <6i3f5bvcppm4bkpphcb7sxsopmeani5mg5irytc3nr464p24ka@jpno77j7cgyd>
 <CALmYWFvXKdfyvZTfu9D4GdBgeVHzLR2rXshqZMFPjU+FuAHJkQ@mail.gmail.com> <mayqavxl6vpod2tcgb6f727dqcbifaubfgeiiy2sdfsqhwrgej@tbm72lvz2lof>
In-Reply-To: <mayqavxl6vpod2tcgb6f727dqcbifaubfgeiiy2sdfsqhwrgej@tbm72lvz2lof>
From: Jeff Xu <jeffxu@google.com>
Date: Thu, 8 Aug 2024 11:52:07 -0700
Message-ID: <CALmYWFux0UbdX2WObsy5kiEMvgKThoKrShpCVpC6CVa2PuNSnA@mail.gmail.com>
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

On Thu, Aug 8, 2024 at 11:46=E2=80=AFAM Liam R. Howlett <Liam.Howlett@oracl=
e.com> wrote:
>
> * Jeff Xu <jeffxu@google.com> [240808 14:37]:
> > On Thu, Aug 8, 2024 at 11:08=E2=80=AFAM Liam R. Howlett <Liam.Howlett@o=
racle.com> wrote:
> > >
> > > * Jeff Xu <jeffxu@google.com> [240807 23:37]:
> > > > On Wed, Aug 7, 2024 at 8:21=E2=80=AFPM Linus Torvalds
> > > > <torvalds@linux-foundation.org> wrote:
> > > > >
> > > > > On Wed, 7 Aug 2024 at 16:20, Liam R. Howlett <Liam.Howlett@oracle=
.com> wrote:
> > > > > >
> > > > > > Okay, I'm going to try one more time here.  You are suggesting =
to have a
> > > > > > conf flag to leave the vdso pointer unchanged when it is unmapp=
ed.
> > > > > > Having the close behind the conf option will not prevent it fro=
m being
> > > > > > unmapped or mapped over, so what you are suggesting is have a
> > > > > > configuration option that leaves a pointer, mm->context.vdso, t=
o be
> > > > > > unsafe if it is unmapped if you disable checkpoint restore.
> > > > >
> > > > This is a new point that I didn't realize before, if we are going t=
o handle
> > > > unmap vdso safely, yes, this is a bugfix that should be applied eve=
rywhere
> > > > for all arch, without CHECKPOINT_RESTORE config.
> > > >
> > > > Do we need to worry about mmap(fixed) ? which can have the same eff=
ect
> > > > as mremap.
> > >
> > > Yes, but it should be handled by vm_ops->close() when MAP_FIXED unmap=
s
> > > the vdso.  Note that you cannot MAP_FIXED over half of the vma as the
> > > vm_ops->may_split() is special_mapping_split(), which just returns
> > > -EINVAL.
> > >
> > The may_split() failure logic is specific to vm_special_mapping, right =
?
>
> Not really, it's just what exists for these vmas vm_ops struct.  It's
> called on every vma for every split in __split_vma().
>
> >
> > Do we still need to keep vm_special_mapping struct , if we are going to
> > treat  special vma as normal vma ?
>
> No, just set the vm_ops may_split to something that returns -EINVAL.
>
OK, that makes sense.

Thanks

