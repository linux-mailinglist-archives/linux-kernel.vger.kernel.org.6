Return-Path: <linux-kernel+bounces-534726-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E82EA46A7D
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 19:59:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E64383A5B65
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 18:59:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BAF4236A74;
	Wed, 26 Feb 2025 18:59:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="awfWdQSD"
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B17621D5AE
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 18:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740596357; cv=none; b=q86VsINKcybzTntfZQ/E5FwOiXgUgj59EnibS9CnhJvtDWpu2/U81H35+iBa899+cQXbgDGwBqNbqd9jrtw4HNhbZPrBcyoAUWSZaVfOEZEHRUgHt45HdsAUNkqrj0Arkno/qrDVrw0cXMPvZvuYusyvtY0gPgem6hU8q7yOcZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740596357; c=relaxed/simple;
	bh=Vq6ju6Efvuog+pt/BMbADghexLEpZui3HIkAPqULHIE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Y0RLrSz8zPdiaQs/G4rQQ70k4V6/DAMAPxWDvXcWeTsKBCyfakNjvDrzCCkce9Nl/yvCalqmZsAynLHES+gCe+NFhTcU2Osr9zbIZXx46WH6lhh66oL3Ge3QJ6i7RF2G92efHbGFtjTmIHSFwgPMmitu39/CFwQqxgIiXqEVr2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=awfWdQSD; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-471f1dd5b80so16191cf.1
        for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 10:59:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740596354; x=1741201154; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rV9IkadFWsLArlHr8bxQUoPfxAbRVfmTh+DzYDsIeo8=;
        b=awfWdQSDlx+5M/fUBI0G5biFoPy5EJKBjxBp6lXHNdQHRpnGhibc7oOL6pDqU6o/CY
         x3FUROfmLqTg2prnDKVLrGEHPdvh0BTlNbjckggbMasRWCS3QIb62TRHVpKxooMlTz/O
         tqGi/F64Z7ZzeHMCAyRqGmcMRrUhx5ufmHpnXz0vuFumfIssrm5v79lGXVM9jLr/Z2LH
         hMkEQ1/1VYi8Y1h2XcicCV4bAVFyf2NUX21ac1rs9HbFHJRr3zNdaMsHuO9luFmISc8x
         Eiy5w/57ynedve++FK68BfSD8wv930qa3xR0AUMmPvUPEM/zcrXLVa5mXfRr5gT4eGRz
         Ha5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740596354; x=1741201154;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rV9IkadFWsLArlHr8bxQUoPfxAbRVfmTh+DzYDsIeo8=;
        b=pCjFyFTi/T+/MFd3sG3bYzn88+sZOPVTOMVRTWNjQHtAzqizizbVD6ci4GfSymMqxI
         rfoXUlxISBcPDhE6d2Gz+Yk5t2DKBlR9yj20wBNCnhtsxjJI/tgewFiIId35CRAZdak9
         ONalF8yQ6tJIbAOxHUirR1qAoDOazNZbSHxEh9bR9k1c05ODmBTpVzjaSaAFMfANtnR8
         Lyl7CVi8smtQMo89h+XmK7v6Xer7KGOBl3ylIeSVlWkjJic0yItOTdsiDXQ0I4UpMkuV
         iiAVtnUVaGNqpjae/e//g2qYF1TuT6b2/hdAkn7OEueBgLnBfgYOUjZ6Ock+ztRB02f5
         3gNQ==
X-Forwarded-Encrypted: i=1; AJvYcCW8jKpC8LFPsOX6g8PXu8pn1Yljc/Ynw7sNdD+ls2ZkA0MSwaw5oSF9M7I7/PLXntjxk/T61iS4RbTN65c=@vger.kernel.org
X-Gm-Message-State: AOJu0YxIP6ICkf/CkMq3tiXX+M5Ba5jvfDXHHc1BjUNaPLJo/PE2m4Xb
	8iQ7Ugxu/e0FPdXMAcaREV3FMbKbuA/z3kWgqC7TaxPCbsb/z9qUyp3Rr0NzkYsRB0DwjiYmvwR
	cpq6FwGeDsyhGrFyq5e68+rHuaPbz+N+eTa+W
X-Gm-Gg: ASbGncvXeHSD/XNbcXKH2DsYOJDI9JUgYcE0iXV57jJZBozvgI040RCxKfa3TuLdA7H
	s6tuVZSCCVaPeLtjmCqMNSEpcqzN+f3K198JfrIRNro5cTRnJ6iXlg537fPUOC+XC8dOHnAuJ/e
	2L060IhvMxlRZq3ZYlrrxo+xWLkOCe2FMKhR8A
X-Google-Smtp-Source: AGHT+IHsOzrgXCSNO/JOiX20wPAZj8bs/dEsCWNe2+L5a3wJa/se8gmIkkOfUuA5nOJlL+S191/tRroz4+19Vle9/f0=
X-Received: by 2002:a05:622a:60b:b0:472:7e8:a788 with SMTP id
 d75a77b69052e-4742e0f1629mr159311cf.12.1740596352320; Wed, 26 Feb 2025
 10:59:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250225204613.2316092-1-surenb@google.com> <hdcrjkqb4cevovpw5xprkh7ohykqay5ew27sbtpzg2k7vrm7mx@6ircmivkmkgv>
 <CAJuCfpGu3Gx-kCChgQjZMQNOxU=CqzkHuoghfNmbv+Q1UKYPxA@mail.gmail.com>
 <Z78-YdCGtbV61x_Z@casper.infradead.org> <CAJuCfpFykPaU0XBPBdfnVzvYGK8k_KW7KAEeh2ROyibkuquJFg@mail.gmail.com>
In-Reply-To: <CAJuCfpFykPaU0XBPBdfnVzvYGK8k_KW7KAEeh2ROyibkuquJFg@mail.gmail.com>
From: Suren Baghdasaryan <surenb@google.com>
Date: Wed, 26 Feb 2025 10:59:01 -0800
X-Gm-Features: AWEUYZnMlDxNde9kN15MMA6yX02fUGcPfWxSIB1NIXSIYDSCauDYwoderXQdXBk
Message-ID: <CAJuCfpFSYG3cTxP+B4XrWY2=jGd3fdEG6h-kb0G4R8n9DGtwcQ@mail.gmail.com>
Subject: Re: [PATCH 1/1] userfaultfd: do not block on locking a large folio
 with raised refcount
To: Matthew Wilcox <willy@infradead.org>
Cc: "Liam R. Howlett" <Liam.Howlett@oracle.com>, akpm@linux-foundation.org, 
	lokeshgidra@google.com, aarcange@redhat.com, 21cnbao@gmail.com, 
	v-songbaohua@oppo.com, david@redhat.com, peterx@redhat.com, 
	lorenzo.stoakes@oracle.com, hughd@google.com, jannh@google.com, 
	kaleshsingh@google.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 26, 2025 at 8:22=E2=80=AFAM Suren Baghdasaryan <surenb@google.c=
om> wrote:
>
> On Wed, Feb 26, 2025 at 8:16=E2=80=AFAM Matthew Wilcox <willy@infradead.o=
rg> wrote:
> >
> > On Wed, Feb 26, 2025 at 08:11:25AM -0800, Suren Baghdasaryan wrote:
> > > On Wed, Feb 26, 2025 at 6:59=E2=80=AFAM Liam R. Howlett <Liam.Howlett=
@oracle.com> wrote:
> > > > Reversing the locking/folio_get() is okay because of the src_ptl sp=
in
> > > > lock, right?  It might be worth saying something about it in the
> > > > comment?
> > >
> > > That is correct. We take both folio lock and refcount before we drop
> > > PTL. I'll add a comment. Thanks!
> >
> > In the commit message, not in the code, please.
>
> Ack.

I posted v2 at https://lore.kernel.org/all/20250226185510.2732648-2-surenb@=
google.com/
as part of a pachset which includes the fix for PTE unmapping that
Peter reported. Patchset is rebased over mm-hotfixes-unstable which
includes Barry's fix to the nearby code. This avoids merge conflicts.

