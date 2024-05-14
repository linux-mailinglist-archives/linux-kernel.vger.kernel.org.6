Return-Path: <linux-kernel+bounces-179208-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 750D28C5D0A
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 23:56:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9934C1C20EF6
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 21:56:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 000FD181BBF;
	Tue, 14 May 2024 21:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GMBEW8ev"
Received: from mail-vs1-f53.google.com (mail-vs1-f53.google.com [209.85.217.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF4B6181BA3
	for <linux-kernel@vger.kernel.org>; Tue, 14 May 2024 21:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715723768; cv=none; b=n76POCvsmGwHG6vpQ0yyWrN5ffvf7qlq59DW60spBtM4agD2fIhTUqGnCF7ELKbooavjfQICwUWhJr0NVjTKk99J1+ZM8rpu7CGpUogeBUDZMZXajIzWPoK+TgUMbUt63K+HJ1DUEodwvKG73gSE63Mc9yMoziTwWa+gpeqgBAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715723768; c=relaxed/simple;
	bh=uEXWYNYp7VhpTZUElvU88fXfy1QSJP/hcRQ//97RtxM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eZFxOujGOMHjSPUMByqT9duogOC0F7c7fUSaJMj2dEBdZIXC+AmjFU/aKauw/ZVW7rnjWi5lYCmCUvYukfXQHp+Wbhgq79CLcHrWgcAjYXOmUATYrhYbKIPfZDRzGfbbRsTqg2A0c1GGZg8VlmxtjWHXtafHYI2+2DPYEKeHdz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GMBEW8ev; arc=none smtp.client-ip=209.85.217.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f53.google.com with SMTP id ada2fe7eead31-47f158ca5a7so2476625137.1
        for <linux-kernel@vger.kernel.org>; Tue, 14 May 2024 14:56:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715723765; x=1716328565; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VqnUZ1TYuNAyNcXd26loTgoWFylrwHFb/LkAEYuc1fU=;
        b=GMBEW8evRdWOxxt0RVleAFZKxyNr7DBmDQMHOzexyi74Kxg9whFqncpWg3hKpbIM0E
         IovGo206t5WIi1r7dF3715pGTlAxkXGGqiqakf3N5m/P38Qn9IzMU37Z2P79n7xqlpUP
         8mu4TdPrFdqe10nVKintXodL/hsgAuI45T22vQHf9hVlOVQKXYFOb26Q9eAt1+OEbe/S
         i79eapeeK5/4DV01H8DbSie9HO0CtXnt4RK3GtFc6iL2CBRNoOIfx3hQ7QHud8qFlKKx
         fCQcAINl0ywK+rxP+h3Z3NHohBfVhfe7jHjktAyiDHWm4bhaWyR0786tGjelxc3AP+bI
         YGew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715723765; x=1716328565;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VqnUZ1TYuNAyNcXd26loTgoWFylrwHFb/LkAEYuc1fU=;
        b=PiS2hP6QIZLsdpeZbO2OKzCM7ntYbFUadaXZGReUyut3uBbxqM4JLKx3rSwT7xKpRz
         x7QraCf9taU7PTiJG+hvths9yqeOgJAL1ewjTBY+CW1o2hDcJNcgL3aZPhGB4tWzXIcR
         Xn+VyWXIzshMOqk1Yo0fC7/yybGLwOvzU/J4khl/TZfpaQcqxDjmxPmV+cSPyvXWn2Ou
         UkuFt0QB5St+ayP10/wctjPCXF+sBJUUv8zXuYg4rceu57c+6/kRluqUbmS1ueqSKMJS
         9Oodlk2X2tT+/wm1ImHlI7+Wxlzxh+9C+G57cJYUx2PGK0Jhj40ee2OvCGebnXDJRslu
         wtlg==
X-Forwarded-Encrypted: i=1; AJvYcCWXg3rL+k7XSW4DmGFww2KqAw3IhpuJ6QQymNkLnCSfvb+JoPsxDgOeEw3ik1yMQmB/Yo71qHQzzSPLwHK94ZKbZ1zPlMgmhrvMIOPb
X-Gm-Message-State: AOJu0Yyxhw63vUy6L4xSxzdvpkbEAIjzUoevhuSkVka0NCz4SXnnR0/D
	vjEobng/F9Ssb/A1Yc0v9r7gYhMEMRm8EIvE+gtyzcEa0DfLz5kgiYSvSE1IteC9EQEogzP/iyD
	27psr3qKOIDl912aJO6pDW3Mk8RA=
X-Google-Smtp-Source: AGHT+IGLzOBgHUY87f8e0Twy3+9pCPi3j15GjRmTqzdayIiiA3rorIR2aVB42ywo9o9J/htubvmkklO3I3olKk/wmao=
X-Received: by 2002:a05:6102:951:b0:47c:122b:a3bd with SMTP id
 ada2fe7eead31-48077db7661mr15052080137.2.1715723765650; Tue, 14 May 2024
 14:56:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240511035435.1477004-1-linmiaohe@huawei.com>
 <20240514141439.55fba39c81c1af55c9a100e1@linux-foundation.org>
 <CAHbLzkq+NBjwjSvU1fQe56nLf5mmGp65TH8hDpb66EFLENctKA@mail.gmail.com> <20240514144204.88790f125b0275ef68acf6de@linux-foundation.org>
In-Reply-To: <20240514144204.88790f125b0275ef68acf6de@linux-foundation.org>
From: Yang Shi <shy828301@gmail.com>
Date: Tue, 14 May 2024 15:55:52 -0600
Message-ID: <CAHbLzkpQvr2K5yxwmtoHsj_UJ78ak=m-YdZxk=vpnPJ8iZdncw@mail.gmail.com>
Subject: Re: [PATCH -rc7] mm/huge_memory: mark huge_zero_page reserved
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Miaohe Lin <linmiaohe@huawei.com>, nao.horiguchi@gmail.com, xuyu@linux.alibaba.com, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 14, 2024 at 3:42=E2=80=AFPM Andrew Morton <akpm@linux-foundatio=
n.org> wrote:
>
> On Tue, 14 May 2024 15:28:12 -0600 Yang Shi <shy828301@gmail.com> wrote:
>
> > On Tue, May 14, 2024 at 3:14=E2=80=AFPM Andrew Morton <akpm@linux-found=
ation.org> wrote:
> > >
> > > On Sat, 11 May 2024 11:54:35 +0800 Miaohe Lin <linmiaohe@huawei.com> =
wrote:
> > >
> > > > When I did memory failure tests recently, below panic occurs:
> > > >
> > > >  kernel BUG at include/linux/mm.h:1135!
> > > >  invalid opcode: 0000 [#1] PREEMPT SMP NOPTI
> > > >  CPU: 9 PID: 137 Comm: kswapd1 Not tainted 6.9.0-rc4-00491-gd5ce28f=
156fe-dirty #14
> > > >
> > > > ...
> > > >
> > > > --- a/mm/huge_memory.c
> > > > +++ b/mm/huge_memory.c
> > > > @@ -208,6 +208,7 @@ static bool get_huge_zero_page(void)
> > > >               __free_pages(zero_page, compound_order(zero_page));
> > > >               goto retry;
> > > >       }
> > > > +     __SetPageReserved(zero_page);
> > > >       WRITE_ONCE(huge_zero_pfn, page_to_pfn(zero_page));
> > > >
> > > >       /* We take additional reference here. It will be put back by =
shrinker */
> > > > @@ -260,6 +261,7 @@ static unsigned long shrink_huge_zero_page_scan=
(struct shrinker *shrink,
> > > >               struct page *zero_page =3D xchg(&huge_zero_page, NULL=
);
> > > >               BUG_ON(zero_page =3D=3D NULL);
> > > >               WRITE_ONCE(huge_zero_pfn, ~0UL);
> > > > +             __ClearPageReserved(zero_page);
> > > >               __free_pages(zero_page, compound_order(zero_page));
> > > >               return HPAGE_PMD_NR;
> > > >       }
> > >
> > > This causes a bit of a mess when staged ahead of mm-stable.  So to
> > > avoid disruption I staged it behind mm-stable.  This means that when
> > > the -stable maintainers try to merge it, they will ask for a fixed up
> > > version for older kernels so you can please just send them this
> > > version.
> >
> > Can you please drop this from mm-unstable since both I and David
> > nack'ed a similar patch in another thread.
> > https://lore.kernel.org/linux-mm/20240511032801.1295023-1-linmiaohe@hua=
wei.com/
>
> That appears to link to the incorrect email thread?

I meant that patch is actually same with this one. Just used folio
interface instead of page. I'm not sure why Miaohe posted two. Maybe
target to different version.

