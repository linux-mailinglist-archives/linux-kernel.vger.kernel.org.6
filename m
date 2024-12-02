Return-Path: <linux-kernel+bounces-428166-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 40D2A9E0AE2
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 19:21:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 10491164051
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 18:20:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FAC31DDC19;
	Mon,  2 Dec 2024 18:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sh/Gsxzo"
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F39D70814
	for <linux-kernel@vger.kernel.org>; Mon,  2 Dec 2024 18:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733163656; cv=none; b=oVs6TdxfZWAICypeUzvDeMwR23ahmToNWpbtOkDzVjZ7lbbSLGEbDRcO6SB2xMXZckUso2ozSoPm7Vcm9BP6sVL1QjuSkR76yV7YdiHe9xGUZcO0B8MW1axZrieuystlcKhECQyB6LJVqHoADxczfZ0yCX1BrHCP/1tBbGKiqHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733163656; c=relaxed/simple;
	bh=uFwq90+lMU8mVw6V54IrcusVTE8Aqkyi9aFWaNmbwsE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UBkDtroFVDo3SolTq8nlLdkF5FVDEERK9NVvnd/Ex6gL0TfgEjOdlHTcZJZr5/5Y8DrJfrBGvxH1wH2oY9So3ZzdRScag7XobBrwUTL32zt0I+owKg1Xf/7+afhLpoPIjze30EEAk75OWLee6+gswPluSBhY1Ac5KO/xQ+ms5xY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=sh/Gsxzo; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-4668194603cso1007091cf.1
        for <linux-kernel@vger.kernel.org>; Mon, 02 Dec 2024 10:20:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733163654; x=1733768454; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=28XI+BDfImJSG+QVCqY4OmNHFKGjBLOdzMFLQlLfjWY=;
        b=sh/Gsxzo6G172sDSSj4oP7PeobZ3Z8erTkhB6nYsRCBQwVcQ9BxV6y8mP1u0Ox8RDb
         ZC8EHZ5zVwt5Xbok/E2rSYPOt4vB47cmeEV0yliezW2DEC7wZd2dtqFZcMyGFBUwXb+T
         3An4pryNg9oqfA9r79h4Epg0lQQ+pFx2i1k1SAE15Z300031y6pJdQAxFMhvP+qWK5+A
         BAu2zlBqC1be8iJqj8pSwXjJuti5/OMDoazCjlvKA060fC8txKI5vtQs55hyPX5Vurq9
         qh0JdNPi9oO2Ez2tsRm1b/jhvSUakDLijIXGzFwTtuCJ2KTsNr5sXEYPti0Tlk357sh7
         BcEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733163654; x=1733768454;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=28XI+BDfImJSG+QVCqY4OmNHFKGjBLOdzMFLQlLfjWY=;
        b=JJrbNCv2LYEm9oA76ifNz5fqGGnf9qLLaWOzQknKBi+D8mOsk1XO7iPrHjkxniuwNS
         EKBf0F6CVRRMd6tgcDtbch9gWnKBKkmSE3eK0l0XUbL16HpKbECNQMGW8F05DrMapq7O
         KimSSPd7Psn0TM8Yi7dUGDJ4kmr2jhui0WjgtnZcTyTvogBqoI9jMF2JwCeCKe2iNJak
         j7zzz9i7tyJwIxYMul5fQIrXHQxdvVuuJxC/4oCMr7UZXlLOPYBAuikD0IOjY22JbQ8R
         vZbBT7TaUpQ1O89itRpTs3mmhCj0ySZISx4bzn4exXStu4HRyEi/8ygf4WVxnkHTNnql
         1xVA==
X-Forwarded-Encrypted: i=1; AJvYcCUDGE7fiBsrmTHwtJKmFDMZjjhV61jGXwcR0dEoG4Fsas9ORK05MgSXmfjzLxuYz9FQBRu4DwAkugF1KWU=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywoq5bIQws3actWvINdARCiJHjLzXSVFdXOk+X6nhhTYL9EQatC
	8zx6UgGVUcbrbM/mCK1gpW75ZZOkY3c1ykSFW4xLdvYIp0i3TsgypxK/dSa6H130LVETFABjEtP
	bHSjy1p4aIHkdsnD7F4REeR7NBM5UcVq8iuRJ
X-Gm-Gg: ASbGncuavb2ZIDx3n8utOf6tFZmHJ4UiDCVwWO5xjPw4Xdx1NcuxKDJ0dDUCNZAkj7H
	BKmKZzta17Cvh5F9IIEyaHfy7c5odoG95cd+QmF4p6fJfxhBwJmGpRsVeTi+/Xw==
X-Google-Smtp-Source: AGHT+IHtm40jpUNDpfP1EU60JeetrmcNu1qiT/IXO8OWuLgPNpRNyllv6KKV2oasp8tc27sL22WShZ7+/gLs61Hcu40=
X-Received: by 2002:a05:622a:5b0e:b0:466:8f39:fc93 with SMTP id
 d75a77b69052e-466c3ead405mr11680921cf.3.1733163653973; Mon, 02 Dec 2024
 10:20:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241126173409.3728585-1-xur@google.com> <alpine.DEB.2.21.2412021751110.30050@angie.orcam.me.uk>
In-Reply-To: <alpine.DEB.2.21.2412021751110.30050@angie.orcam.me.uk>
From: Rong Xu <xur@google.com>
Date: Mon, 2 Dec 2024 10:20:42 -0800
Message-ID: <CAF1bQ=QRYu5-CY_r7wUcku9WT8sXmD47VW42eHWGNE3bZfr4Dw@mail.gmail.com>
Subject: Re: [PATCH v2] [MIPS] Place __kernel_entry at the beginning of text section
To: "Maciej W. Rozycki" <macro@orcam.me.uk>
Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>, Masahiro Yamada <masahiroy@kernel.org>, 
	Klara Modin <klarasmodin@gmail.com>, Christophe Leroy <christophe.leroy@csgroup.eu>, 
	Michael Ellerman <mpe@ellerman.id.au>, Nicolas Schier <nicolas@fjasle.eu>, 
	Chris Packham <chris.packham@alliedtelesis.co.nz>, linux-mips@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Sure. I'll send a separate patch for this format change (not v3 as
this patch was already submitted).

Thanks!

-Rong

On Mon, Dec 2, 2024 at 9:58=E2=80=AFAM Maciej W. Rozycki <macro@orcam.me.uk=
> wrote:
>
> On Tue, 26 Nov 2024, Rong Xu wrote:
>
> > diff --git a/arch/mips/kernel/head.S b/arch/mips/kernel/head.S
> > index e90695b2b60e..c7528d96dd1a 100644
> > --- a/arch/mips/kernel/head.S
> > +++ b/arch/mips/kernel/head.S
> > @@ -59,6 +59,7 @@
> >  #endif
> >       .endm
> >
> > +     __HEAD
> >  #ifndef CONFIG_NO_EXCEPT_FILL
> >       /*
> >        * Reserved space for exception handlers.
>
>  A new line would be preferable afterwards so as to visually separate the
> directive from the conditional part that follows.  It looks messy as it
> stands (and we have prior art further down the file with __REF).  Please
> send a fix.
>
>   Maciej

