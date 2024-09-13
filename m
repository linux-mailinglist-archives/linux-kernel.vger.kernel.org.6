Return-Path: <linux-kernel+bounces-328818-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 168A397894A
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 22:06:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A9E751F241FB
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 20:06:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B0C114EC60;
	Fri, 13 Sep 2024 20:05:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="03l3JB0o"
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BA0E136E01
	for <linux-kernel@vger.kernel.org>; Fri, 13 Sep 2024 20:05:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726257947; cv=none; b=VYXKNJJzuNHSOHDBE4ayaiejgnI1voWSJ9DO4dLp+nHdqlC7zQmBwNiTaxGBsxUXHwfSxuG/e8vTljvXcpza4TpsiQhXcOKeJoua7cOy+D+dJwnJfKBxdbA8K5KxnizPBg1k5+RdFAsnIuLTpd+cvbzLs0fSqPNa3JivFARZMzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726257947; c=relaxed/simple;
	bh=JasvM0cGQ6Kp6s1RW9fXNSm51k0TxuA8UQb6JqCiRFE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Y//pKh6GhQNx+5IsAAcOcAQuyvrFezgJfOd6IFTgbr1QRwwWjdZqSBPbf86y5HYWNsGl/MHsPcREJC31yWbMgh4wjLaJTy+20OF3ObY8aIwAaXokRvCo8E23kerfcVkch+CEFZzVlm8ceP/6OxcPCTbth3agVK9DkozL19Mhk+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=03l3JB0o; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-4582fa01090so63711cf.0
        for <linux-kernel@vger.kernel.org>; Fri, 13 Sep 2024 13:05:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1726257945; x=1726862745; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=428AI888COZr85p2dtQB4DhBQ69x1Du1oaYIZ9Pz7II=;
        b=03l3JB0oHV2Hzye+RjF0fXtSXBf8IdJKdJpZEGnUWf765simsQiTi79LODJOhCO41f
         k4AU+BVfkSgbft9guX75yRJ6kRfXrewdiAYsZzPiC3JjXtHP6z4+LUuCcstFCCFsicIZ
         k27rF8uiuEU8rFr5gCNKITx/XY0eIw0nIj02hbY+cvY4ySBvGVjnIbiV3WarSxaPiqEd
         n3WfMe/hAIAxFyIF23cT4cqxxId+MH/LhaHCAMraH0skq84ySZ9Ex3xO8+8Ba1Z7byM2
         N5tllqqSNqBu75Za+IkBl9Ndpe2GfKqt2yO0sxaojazkPuTspH3al+YVfg09Gcl9t3lw
         FXOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726257945; x=1726862745;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=428AI888COZr85p2dtQB4DhBQ69x1Du1oaYIZ9Pz7II=;
        b=RBnEULNZzq/K9iq13JvKi3V4gnQDTUV4bv6c8NVANfPrlTHgzVQ2J9h5sLwmnQc4kQ
         CQ9Y/qvOd76ZfRgO/RcOEhmqe4PT1+r671VDsvexA8UVJNr604boXNoU1xq4BbZYEl2v
         rtL4Z7EtMODYpnxaAexhmzcWzBRNJeC6TvsFu4fTc15KDO7Z7Hvr++fGm3As+TEaCiND
         JoDDz+UDUq21kk0dnXufnDxOohvYeSM97pgKXzN59lTUoOTgdCJJFV/VpHsDYKggBSAI
         4Ay19V+A5gD3kTWNT8NsDucuAaTAIKd4jy/ASB01ZYLkE1QiU8RQoJFPdOlR7ez49q62
         E6Fw==
X-Forwarded-Encrypted: i=1; AJvYcCWULIP2FBJUv4vr3blR0RDsDatIlZBM6c2f2MuXmDuRastZwgmlwRR408EYITIpVcrpODCA1FJz32p1sVs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwE4RDS/+mYauYhWnQ0aHThqriW/aDoIFqrQft0hpt40lZBKFa8
	TJ3ugET/UuW91oPAHvod9yokBvUd0WBc3fxsB+luXg/+e9agyHoyly8jzJm2Tcl4LK+n+DM9+wP
	wJM5oJYdx+J0zYDt1NP0QcuVAgBz3Jyv2PR73
X-Google-Smtp-Source: AGHT+IF5n1mXupbErXFG4ufgiVBKgZXbeEDAnZXN3Paf7T9SpKrEw2qr89Hq947jCuTgHivZFmuNQ00T2DIMXKQJkVo=
X-Received: by 2002:a05:622a:34a:b0:456:7ef1:929d with SMTP id
 d75a77b69052e-4586079cda4mr8791071cf.12.1726257944603; Fri, 13 Sep 2024
 13:05:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240913125302.0a06b4c7@canb.auug.org.au> <20240912200543.2d5ff757@kernel.org>
 <20240913204138.7cdb762c@canb.auug.org.au> <20240913083426.30aff7f4@kernel.org>
 <20240913084938.71ade4d5@kernel.org> <913e2fbd-d318-4c9b-aed2-4d333a1d5cf0@cs-soprasteria.com>
 <CAHS8izPf29T51QB4u46NJRc=C77vVDbR1nXekJ5-ysJJg8fK8g@mail.gmail.com> <20240913113619.4bf2bf16@kernel.org>
In-Reply-To: <20240913113619.4bf2bf16@kernel.org>
From: Mina Almasry <almasrymina@google.com>
Date: Fri, 13 Sep 2024 13:05:32 -0700
Message-ID: <CAHS8izNSjZ9z2JfODbpo-ULgOcz1dGe5xe7_LKU-8LzJN_z-iw@mail.gmail.com>
Subject: Re: linux-next: build failure after merge of the net-next tree
To: Jakub Kicinski <kuba@kernel.org>, Matthew Wilcox <willy@infradead.org>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, christophe.leroy2@cs-soprasteria.com, 
	David Miller <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>, 
	Networking <netdev@vger.kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, 
	Linux Next Mailing List <linux-next@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	"linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 13, 2024 at 11:36=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> w=
rote:
>
> On Fri, 13 Sep 2024 09:27:17 -0700 Mina Almasry wrote:
> > diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
> > index 5769fe6e4950..ea4005d2d1a9 100644
> > --- a/include/linux/page-flags.h
> > +++ b/include/linux/page-flags.h
> > @@ -239,8 +239,8 @@ static inline unsigned long _compound_head(const
> > struct page *page)
> >  {
> >         unsigned long head =3D READ_ONCE(page->compound_head);
> >
> > -       if (unlikely(head & 1))
> > -               return head - 1;
> > +       if (unlikely(head & 1UL))
> > +               return head & ~1UL;
> >         return (unsigned long)page_fixed_fake_head(page);
> >  }
> >
> > Other than that I think this is a correct fix. Jakub, what to do here.
> > Do I send this fix to the mm tree or to net-next?
>
> Yes, please, send this out and CC all the relevant people.
> We can decide which tree it will go into once its reviewed.
>
> Stephen, would you be willing to slap this on top of linux-next for now?
> I can't think of a better bandaid we could put in net-next,
> and it'd be sad to revert a major feature because of a compiler bug(?)

Change, got NAKed:
https://lore.kernel.org/netdev/ZuSQ9BT9Vg7O2kXv@casper.infradead.org/

But AFAICT we don't really need to do this inside of mm, affecting
things like compound_head. This equivalent change also makes the build
pass. Does this look good?

diff --git a/include/net/netmem.h b/include/net/netmem.h
index 8a6e20be4b9d..58f2120cd392 100644
--- a/include/net/netmem.h
+++ b/include/net/netmem.h
@@ -100,7 +100,15 @@ static inline netmem_ref net_iov_to_netmem(struct
net_iov *niov)

 static inline netmem_ref page_to_netmem(struct page *page)
 {
-       return (__force netmem_ref)page;
+       /* page* exported from the mm stack would not have the LSB set, but=
 the
+        * GCC 14 powerpc compiler will optimize reads into this pointer in=
to
+        * unaligned reads as it sees address arthemetic in _compound_head(=
).
+        *
+        * Explicitly clear the LSB until what looks like a GCC compiler is=
sue
+        * is resolved.
+        */
+       DEBUG_NET_WARN_ON_ONCE((unsigned long)page & 1UL);
+       return (__force netmem_ref)page & ~1UL;
 }

--
Thanks,
Mina

