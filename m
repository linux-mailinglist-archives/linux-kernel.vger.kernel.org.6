Return-Path: <linux-kernel+bounces-385628-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E11B9B3999
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 19:51:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4016C1C220B0
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 18:51:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65C311DF728;
	Mon, 28 Oct 2024 18:51:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="L2EIBkbD"
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D026F1DE4DE
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 18:51:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730141494; cv=none; b=WhWAD8i/a41P9/SOp8Eb9jmZ18QxxunXJGfI8JUMlUeW97JtLLRpqLXGRDBrCghux3kWXU+FBD//lOgYE0LvrLtKWXw5lmf2eE496Y1zqO5wG/ttZG3chEp+uJWOQiFS+vlIDGt4IqyzeJiug72O0xcwLXj3b64lcUvtoCYUEqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730141494; c=relaxed/simple;
	bh=0oHYatCo0X5riZNKSvxEk54pzXE6TAl/4MlEwJmHLyg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ClyOqmuOKhOT4QTqGrBvUETVfSvVzAF5O9GgahsVXEZ8XubKn34G/l7oXRqj6XJYVNxIBzry77sGo4LJ7Vec0+SgxdBz41S3R9+PnZ+p7XIBlDI7xknjneJPBSc7AJPRtGzK4dFd3WYdYAXfeaT2maa+Zlm9vhwX3rqYYyZU6nU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=L2EIBkbD; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-4608dddaa35so52711cf.0
        for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 11:51:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730141492; x=1730746292; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FsGymSckWWFG2M28oSHVo5x5qB69G8wLbxX80Gagvk8=;
        b=L2EIBkbDjN95jEZ+mEdCRVfJ50ThmO7o0vBVrhUSyaOtpFZZiQoU89MbYc0U9T6V+o
         xEGZrBM43MGaMTLoPjfQvhUqTmGSBzzHUntxQmh9RHG+RgJgY/O06hbJWVsgQ2sdf4xj
         tgArIJIRDPbW2hB6537ssBnArcNWFenPGlNGEW++EZtpbrKpZuvZF5NeTNkH28ymsKKR
         fA2d7DZzGGFeApw/pYlo/qy2lX6ZV5zusWJEGGbSI8UMHhZMiIVjsc29xxJSsnsSjNJn
         0UfZwyU0MnZRM/Tenq7wgMTuXBu+1m6fIvDB6oRvFIswV5yRfVtwWS7wmNlZqozcInzv
         DURg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730141492; x=1730746292;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FsGymSckWWFG2M28oSHVo5x5qB69G8wLbxX80Gagvk8=;
        b=sig1plkTPQWcyLUcnlrNfYniR2NFym509RBp4jaKWCCOgGaAvwZSIzFteb5IDkJ7vX
         oXyb3yXYmxwOXrlQJiOYQNr0OmkOid7EbuAOKZsdtdKYHRUDjVimfgxUDcxfIrJYrg4e
         +zP+0xAZp8b0A6oJJ5EadilgpaIB88pNib2qXUY9P5pbTVmlIZb/gxBZuDz60KzNSrdp
         4WKOUpOiCnr5dqSikYV51I5pyTgYrPk2Pk/8TZ7dM2fCbBPtEU2BFaAzzu7BN3BXzpmR
         n/LVH2dq25caeiLx/pAG43I0sPxiE4XFxCHSOEqT7bFqy5Dmg3Pmf8GLgN9OU7FOzq/t
         DoJQ==
X-Forwarded-Encrypted: i=1; AJvYcCWjWixbk7dDUkA1QnLpBQeIoCCRI1GpLg6KT5YwDyek4cQL6fZ6YzCyafhAo1Ad5EkNAHs+lAUUCp4201Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx20s4ZT8siTWZ2vUQCOuPAAklY0dAfUuLAyZm34LEp6qi7pOAO
	Yaden5HMg18f53pJXrCZQ25VGhswEmnt8bkfjsa+alrV1wZ/wnYyfRaCfjVxa00DyfGbrwXl/Hv
	b2m0JUgmE0ZDmgh+PfdsBkud82Q8NSzN9fUBtIf1LucT31kJ1BPbt
X-Google-Smtp-Source: AGHT+IGucYFQpDnR73oHvNPQyEJZmEltS4w0TfwYJTXmq7umtAwzRsH+cXSuxB6sDSKEKyYnjUZozfwTnK+3uzFmGpI=
X-Received: by 2002:a05:622a:13d4:b0:461:4898:8614 with SMTP id
 d75a77b69052e-46165196f77mr312051cf.27.1730141491335; Mon, 28 Oct 2024
 11:51:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241028141818.622917-1-arnd@kernel.org> <Zx-iJZznoi_RhLWO@kernel.org>
In-Reply-To: <Zx-iJZznoi_RhLWO@kernel.org>
From: Suren Baghdasaryan <surenb@google.com>
Date: Mon, 28 Oct 2024 11:51:20 -0700
Message-ID: <CAJuCfpGDxLJQosX__Sbd9cRXj=ykG3TMRyvKES6JF34oxY6TzQ@mail.gmail.com>
Subject: Re: [PATCH] alloc_tag: hide execmem_vmap() on !MMU
To: Mike Rapoport <rppt@kernel.org>
Cc: Arnd Bergmann <arnd@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, Arnd Bergmann <arnd@arndb.de>, 
	Luis Chamberlain <mcgrof@kernel.org>, Song Liu <song@kernel.org>, 
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 28, 2024 at 7:43=E2=80=AFAM Mike Rapoport <rppt@kernel.org> wro=
te:
>
> On Mon, Oct 28, 2024 at 02:18:09PM +0000, Arnd Bergmann wrote:
> > From: Arnd Bergmann <arnd@arndb.de>
> >
> > The newly added function fails to link on nommu kernels, but is also
> > not needed there:
> >
> > ld.lld-20: error: undefined symbol: __get_vm_area_node
> > >>> referenced by execmem.c
> > >>>               mm/execmem.o:(execmem_vmap) in archive vmlinux.a
> > >>> referenced by execmem.c
> > >>>               mm/execmem.o:(execmem_vmap) in archive vmlinux.a
> >
> > Fixes: 57bc3834fb6f ("alloc_tag: populate memory for module tags as nee=
ded")
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> > ---
> >  mm/execmem.c | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/mm/execmem.c b/mm/execmem.c
> > index 5c0f9f2d6f83..b04cfece7356 100644
> > --- a/mm/execmem.c
> > +++ b/mm/execmem.c
> > @@ -368,6 +368,7 @@ void execmem_free(void *ptr)
> >               vfree(ptr);
> >  }
> >
> > +#ifdef CONFIG_MMU
> >  struct vm_struct *execmem_vmap(size_t size)
> >  {
> >       struct execmem_range *range =3D &execmem_info->ranges[EXECMEM_MOD=
ULE_DATA];
> > @@ -383,6 +384,7 @@ struct vm_struct *execmem_vmap(size_t size)
> >
> >       return area;
> >  }
> > +#endif
>
> Nit: there is already #ifdef CONFIG_MMU block in execmem.c, better to mov=
e
> execmem_vmap() there
>
> Other than that
>
> Acked-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

Thanks for the fix but execmem_vmap() is used if
CONFIG_MEM_ALLOC_PROFILING=3Dy. Please give me an hour to post a fix
dealing with that.

>
> >  void *execmem_update_copy(void *dst, const void *src, size_t size)
> >  {
> > --
> > 2.39.5
> >
>
> --
> Sincerely yours,
> Mike.

