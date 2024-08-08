Return-Path: <linux-kernel+bounces-278842-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 72A0B94B58B
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 05:37:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 296401F22C23
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 03:37:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C92F6433C8;
	Thu,  8 Aug 2024 03:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CHe4vVhV"
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FC3F41E22
	for <linux-kernel@vger.kernel.org>; Thu,  8 Aug 2024 03:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723088259; cv=none; b=OE+ph2i65aXAvMGUf0Lc3Sa5mSz/q4JajV1NSOmKlY3khj+AV/7iJJV1ppMoUi1+1iczj7W6OblLOr0nk8PO9UEt+s/PAaQy0bMhAY9MCMzudLUewahfoimy86aoeJd9cMtZZzpwfO83mh35PJzMtcTLAOk+YqTScmXSEd7tVvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723088259; c=relaxed/simple;
	bh=h+jbuqu+ZudEFmzMNx6/MVVYfS60Qq6tz41Wyclfkf0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=V92t5iruR9mUEDcno7TKWz3SrDjVdsI7pGjHjKcT/SCEowIXsKiBdya1orKqoVlvUuL9W9yYMoMQdYKz590jF3I8lOzL5DKCwb9cQV/f10xFeDcyVvfSEv3psv/JHld7E4Ihsh9KNRzRRlMnxI5c2mv8gkCG1nlTWFuimerV3m4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CHe4vVhV; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5a18a5dbb23so5444a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 07 Aug 2024 20:37:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723088255; x=1723693055; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Em4gw4SlTGWJuwGRtZ6+lH6AITpuWoqignfU36p6K4E=;
        b=CHe4vVhVunkWGx8Slo0A5erW2qVdYgOLHhk69sRFwvQaireH0HtLZMvq9gm8S5UFTC
         57B7LC8BkW7EIRphnzJc50w+49FoijAHOZaXItsqNt/uos8XZ15dtYuc32HxXpAWkgde
         Na9h+kWyAXf+nphh2u/UKLYKHqEMuKagsM9TlA98PjpxEoIjntpQAr1BW0Q16ijPBriO
         F9BM7kuL7Hj4G6cf6Xb6N2JVYRkNsndE0dugaXvTUQeWHqkM792GI6kEgizi7AYdx+0S
         MTbSOGAZV2bZrDjq67jN9QcYIYH+ovC0o6h2fVIbFu9KxubURZ5/hAvqI/coXmbtkL4U
         bJfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723088255; x=1723693055;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Em4gw4SlTGWJuwGRtZ6+lH6AITpuWoqignfU36p6K4E=;
        b=cvkE0kErQgeoaPdmM4SZY5O1ipNsc+9+GiKjrLcDl/1DD0kr0cO2oplNyGW0uWPuye
         IPRDGovDxMPdDj0HvNVPD+gQqNWt2X9zIl1L3BL4j/RhdG7tjibgnRaFM8Wn1RYP5mGZ
         pJfMtKSSkWaSmSbLZyr03mPg3TnZStVlO6X6ld7dBxOwCj+JOVikvei+F8MqKYeWo3A8
         PGACfumXtfsPm6BcrHOqKHMj7f6embVNILyENukLH+l1VRbJBXOkH8y93DD4y17ZyeNM
         VDbPxq68cxK2W+PmHs6ivQPVwWp0aGuHnn2SBduMVjnaoi+R93JVi/WU300eA2cGh53X
         bnhA==
X-Forwarded-Encrypted: i=1; AJvYcCUA06YVKHvPgS+lP5guzkH3a5hKNIUlIVIGSq7/O8eqVkNBMO1jLzWdcP9XgHw4/bQt5/7YtqKY05tWGJ6bND7yLZEfGL8P2l5trdzG
X-Gm-Message-State: AOJu0YyeiKxovYv3jIBqpib8AsaaaOBtEUlh8pRHzCv0/VglDuxSQRXf
	kDScllMKVLgvYzrDEl0x5K9xWHQyEyzMvF6hzcOcNI/GbeQa82PQ+Jf4vnz/a7UqfYEsi4yQvkV
	XU/a9ffxvWYDH5l4JMTbiGQkzBO4CiSut90i5
X-Google-Smtp-Source: AGHT+IHvPKAgFj7UtvldEt4ITF86VCiiBhRZdL6zWiBOsFr6trO34b/kfhbvaMoPCV6QykXhGOz9WfKoQGbW6ssubds=
X-Received: by 2002:a05:6402:3593:b0:57c:c5e2:2c37 with SMTP id
 4fb4d7f45d1cf-5bbb1779ce9mr57823a12.3.1723088255210; Wed, 07 Aug 2024
 20:37:35 -0700 (PDT)
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
 <lhe2mky6ahlk2jzvvfjyongqiseelyx2uy7sbyuso6jcy3b2dq@7ju6cea62jgk> <CAHk-=wgTXVMBRuya5J0peujSrtunehRtzk=WVrm6njPhHrpTJw@mail.gmail.com>
In-Reply-To: <CAHk-=wgTXVMBRuya5J0peujSrtunehRtzk=WVrm6njPhHrpTJw@mail.gmail.com>
From: Jeff Xu <jeffxu@google.com>
Date: Wed, 7 Aug 2024 20:36:56 -0700
Message-ID: <CALmYWFtAenAQmUCSrW8Pu6eNYMcfDe9R4f87XgUxaO4gsfzVQg@mail.gmail.com>
Subject: Re: [PATCH 2/4] powerpc/mm: Handle VDSO unmapping via close() rather
 than arch_unmap()
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: "Liam R. Howlett" <Liam.Howlett@oracle.com>, Michael Ellerman <mpe@ellerman.id.au>, linux-mm@kvack.org, 
	linuxppc-dev@lists.ozlabs.org, akpm@linux-foundation.org, 
	christophe.leroy@csgroup.eu, jeffxu@chromium.org, 
	linux-kernel@vger.kernel.org, npiggin@gmail.com, oliver.sang@intel.com, 
	pedro.falcato@gmail.com, Kees Cook <keescook@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 7, 2024 at 8:21=E2=80=AFPM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Wed, 7 Aug 2024 at 16:20, Liam R. Howlett <Liam.Howlett@oracle.com> wr=
ote:
> >
> > Okay, I'm going to try one more time here.  You are suggesting to have =
a
> > conf flag to leave the vdso pointer unchanged when it is unmapped.
> > Having the close behind the conf option will not prevent it from being
> > unmapped or mapped over, so what you are suggesting is have a
> > configuration option that leaves a pointer, mm->context.vdso, to be
> > unsafe if it is unmapped if you disable checkpoint restore.
>
This is a new point that I didn't realize before, if we are going to handle
unmap vdso safely, yes, this is a bugfix that should be applied everywhere
for all arch, without CHECKPOINT_RESTORE config.

Do we need to worry about mmap(fixed) ? which can have the same effect
as mremap.

> We definitely do not want that kind of complexity. It makes the kernel
> just more complicated to have to deal with both cases.
>
> That said, I don't love how special powerpc is here.
>
> What we could do is to is
>
>  - stop calling these things "special mappings", and just admit that
> it's for different vdso mappings and nothing else (for some odd reason
> arm and nios2 calls it a "kuser helper" rather than vdso, but it's the
> exact same thing)
>
>  - don't do this whole indirect function pointer thing with mremap and
> close at all, and just do this all unapologetically and for all
> architectures in the generic VM layer together with "if (vma->vm_start
> =3D=3D mm->context.vdso)" etc.
>
> that would get rid of the conceptual complexity of having different
> architectures doing different things (and the unnecessary overhead of
> having an indirect function pointer that just points to one single
> thing).
>
> But I think the current "clean up the existing mess" is probably the
> less invasive one over "make the existing mess be explicitly about
> vdso and avoid unnecessary per-architecture differences".
>
> If people want to, we can do the unification (and stop pretending the
> "special mappings" could be something else) later.
>
>          Linus

