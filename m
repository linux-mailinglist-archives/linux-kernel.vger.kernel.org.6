Return-Path: <linux-kernel+bounces-283653-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 50D6C94F75C
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 21:14:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0D8CA285FB3
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 19:14:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D3CB18FC75;
	Mon, 12 Aug 2024 19:14:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bGLpozc6"
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com [209.85.219.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4FD9C156
	for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2024 19:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723490051; cv=none; b=Feb1frbPYUn5TeBj2ZPc1T8fUsJShCRe4gaUIfenGIEdtVYfiYY7O/8Si8ZtNddfepHeAzIczBVM3M8V9LcpYRr6fsjXBE9yDX3hHeXkMyh5+vWnBpsy2RlZF0TohmM16Uf+tk2vlwnqMiQc/MyFOIIUd01S8H4RzxF+QkI7d9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723490051; c=relaxed/simple;
	bh=rn4vdmWNk+kmLQQXZmoziG9zRR/vNwbttfCmFwqVTGo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RslQcDQnd1fwSkCTG3U/3ntoF62jfI7MZPYhplc6WFOgjQ+C0FQC7fwLYEYXGV38zOY+u90uWCT0j574O1nZ3qqxvwe02YMcfEYJLW3pyjOtJv+QkrqilA9SCGtaJPXubzP3lWtO9D5BmKn5dXun7YSYH3g2z4bfvrYr/U1n6qw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bGLpozc6; arc=none smtp.client-ip=209.85.219.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-e0878971aa9so3330172276.0
        for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2024 12:14:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723490049; x=1724094849; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XtaSChf9uo0ybT1NoNPBaEDjGJ0lTbrthdw0OmWDFR0=;
        b=bGLpozc61nx7t3al4fwHQ1KGB157PFmIQzToZlv8zXvaBpYaGz8ENXsYhd2j/62q2R
         0UWSH7M+jrnsW782Ej/LlMzguympRrD+1NAPP9EVqEMZtY+aB+0nx/uKni5yeae3IC+e
         +ulcvCvU2gM2eeOzL6U6X35cupRYm53CYPRjsXcLOMzCETXfYkldy5GG0lWOnk4uBFQR
         VYN893RzbIavgYn2q85AsLtGIGJz5BG2+uj239/k3YnAsqXGiI9NAQmCLIF9A58xHpc+
         phfSgJYrlibeGrlUypmoYioaqPKJxlwsBchZAoEPMXks/KhiRYwSvzNOVoGBG+t+VBoc
         CFkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723490049; x=1724094849;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XtaSChf9uo0ybT1NoNPBaEDjGJ0lTbrthdw0OmWDFR0=;
        b=KZOqUm2alO2OqEhGv9plhmm3e1o0dkywf7w+zQ8+vRl5cbXH3Ujcpkhnxu6DkNorkM
         ncf0gemP59oXao9iKvduUxV21+WE/PiZ+roihLzEOgemgh0XKcmmgmR7JiZmKE44JVi6
         wBnqB1SXZrFGfdhBtT63mlx7s3bNKC2Feb61yXQtlm5Qm1zXKPCnTYeD7MSHwaPtOL/L
         cjQi2N3ybXCBEW8boyWFwwUnBPdXXcmSOts0/607vSYgDPzucyMnQ52D8Kxcsl7OStwF
         sPd3UnOHIfLClY4nVeDMVk+giqlpkpJrH3c7BlJsMUEcRtoEo7LV3X4PyffqCCtMqGZB
         UyOg==
X-Forwarded-Encrypted: i=1; AJvYcCUHhxNb7g7oyCC4ITB2GAPkROdLGpEFZAlfzOUyeUZ4bvqzr4lmFXq1EKQ3p+BaRBPiWoF35jaf9gn13YNhgPyfUWgoMwt7qBT3DsGK
X-Gm-Message-State: AOJu0Yw4oSQht2zgXDlziJFOasGdZIP8KPCd4gry/DqYK3VC2UDLqdDh
	2g205oRLoRJBSyGBvuRGZajWkLB7JCc3jG1ToUo4onm29C0eZRYjc6TCw48gI9XXgjR69Tpb3DK
	iT7GHDQaKHwY041UjvIfgcNZt69MhYIHcIVtp
X-Google-Smtp-Source: AGHT+IGGG5DMp+SVuP3f7HKlwVDWfFOHacaNaoNGeEutQ8erHBsQ7xws5Tes0AaQfBOG7bi0vHdccinZ9LgSUBIUaQU=
X-Received: by 2002:a05:6902:2e13:b0:e02:d8f1:5fe with SMTP id
 3f1490d57ef6-e1140ec05admr504243276.25.1723490048547; Mon, 12 Aug 2024
 12:14:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240812184455.86580-1-surenb@google.com> <CAJuCfpFFEa43D2qMkO_DpscYSAjKrvPo7b3hFMtxDrDAmo=fmg@mail.gmail.com>
In-Reply-To: <CAJuCfpFFEa43D2qMkO_DpscYSAjKrvPo7b3hFMtxDrDAmo=fmg@mail.gmail.com>
From: Suren Baghdasaryan <surenb@google.com>
Date: Mon, 12 Aug 2024 12:13:57 -0700
Message-ID: <CAJuCfpHgj4X9yEMsqoO5uNPT=C36rpQbK5ie959Qv1QE5xOChQ@mail.gmail.com>
Subject: Re: [PATCH 1/1] alloc_tag: mark pages reserved during CMA activation
 as not tagged
To: akpm@linux-foundation.org
Cc: kent.overstreet@linux.dev, hch@infradead.org, vbabka@suse.cz, 
	pasha.tatashin@soleen.com, souravpanda@google.com, keescook@chromium.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 12, 2024 at 12:11=E2=80=AFPM Suren Baghdasaryan <surenb@google.=
com> wrote:
>
> On Mon, Aug 12, 2024 at 11:44=E2=80=AFAM Suren Baghdasaryan <surenb@googl=
e.com> wrote:
> >
> > During CMA activation, pages in CMA area are prepared and then freed
> > without being allocated. This triggers warnings when memory allocation
> > debug config (CONFIG_MEM_ALLOC_PROFILING_DEBUG) is enabled. Fix this
> > by marking these pages not tagged before freeing them.
>
> This should also have:
>
> Fixes: d224eb0287fb "codetag: debug: mark codetags for reserved pages as =
empty"

And Cc: stable@vger.kernel.org # v6.10

Let me post v2 with these corrections...

>
> >
> > Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> > ---
> >  mm/mm_init.c | 10 ++++++++++
> >  1 file changed, 10 insertions(+)
> >
> > diff --git a/mm/mm_init.c b/mm/mm_init.c
> > index 75c3bd42799b..ec9324653ad9 100644
> > --- a/mm/mm_init.c
> > +++ b/mm/mm_init.c
> > @@ -2245,6 +2245,16 @@ void __init init_cma_reserved_pageblock(struct p=
age *page)
> >
> >         set_pageblock_migratetype(page, MIGRATE_CMA);
> >         set_page_refcounted(page);
> > +
> > +       /* pages were reserved and not allocated */
> > +       if (mem_alloc_profiling_enabled()) {
> > +               union codetag_ref *ref =3D get_page_tag_ref(page);
> > +
> > +               if (ref) {
> > +                       set_codetag_empty(ref);
> > +                       put_page_tag_ref(ref);
> > +               }
> > +       }
> >         __free_pages(page, pageblock_order);
> >
> >         adjust_managed_page_count(page, pageblock_nr_pages);
> >
> > base-commit: d74da846046aeec9333e802f5918bd3261fb5509
> > --
> > 2.46.0.76.ge559c4bf1a-goog
> >

