Return-Path: <linux-kernel+bounces-335654-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D1A2797E894
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 11:25:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5BB691F21023
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 09:25:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96C6849649;
	Mon, 23 Sep 2024 09:25:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SQ/xTLwC"
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BD32194A6F
	for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2024 09:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727083513; cv=none; b=BjoCe1mTPqnQNOFlKcUbha4moBXY2t5B3rEdG5f4P/cVTkzK//lQb1+LSRdX+YBDd38jOCDbeY6Y0hUXpAZt8T/leCX86EBjg0Txz1NK+LHac5UUnygiSz/0Zf1rL0hh3DN6Mjj2zsbfCG/jqshde2ZvwATnHyurWOBNcMiEPWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727083513; c=relaxed/simple;
	bh=v1QHDoOgmexyrfMU9NoNlKhk5cabPz+7ykUd04NhdaA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NIdvNoWPBb1L4YrNXBfObVIgYzDzqChXj/tE/KNJGU290cmdo8u3x7JIEc8RWnNZiVqVaMJTq1fesf/3YaBnaZr+R1b7fnt6ivD4YW1ahXzlQ9xKak8u+1SF1HXJrvu2ejTQCZB3dZVDy542rbt+N7pJqiND5Aj2BvzyRV+0xBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SQ/xTLwC; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-374c4c6cb29so4100342f8f.3
        for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2024 02:25:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727083508; x=1727688308; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zo/inl+dQkj4h/8JHayWlKE13Gh29+Qcnjfcg0oSMnk=;
        b=SQ/xTLwCGQsvs4JWws03utGCo+MvCOflKzRHQynH9eKeBxYwoJHWy227h1m8Jng2SJ
         duY/ak6cg3j2RP8ft9aO2gMvobQPr0dFwrnFZIUL/HoDI12Eo52Ne3u4KkyNo4lnzhY6
         wCGcHv+uXhKcWKpIKxzdK/0RRUvPl+fUuYnrFnQQG+B8RA1IBxQ4gA3LJrCa9EjH0dg4
         27QIrGxM1YXMtcr10OIMUQYIou9cZUnC2wRp2W4WoGCMO/XzzMCk8HmCxc2Stryn6NX7
         ROfZ8wtPfDCXBOfaA56occ0Y/i0qjmlV8oUncxQFY5ryZa8D2CRpDiiT5sXaON5gIYxm
         0olg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727083508; x=1727688308;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zo/inl+dQkj4h/8JHayWlKE13Gh29+Qcnjfcg0oSMnk=;
        b=eh38vXBJ1WIaEGviMsCtw8ReP0UCf1sQXNeRkWDGMZm62e6Pg67X9ZM8DR25ey5YKS
         IMN52N7jBqCqLgAb8OalWw663j+Hd7E46qc/yb0PojITmGuxy5eclJMG8oO0nezLdl5/
         bfAOZbp5bPwqs/LYTimgNJ42l7DnB6/UCmPvkHzc5FlB0C9PRspeIvOIgakemzIkalwL
         RpBpYzGYVE6ZihiNedRCnqIirD2/p2OduQc9uhYdX5AEFw6QjqB7xIKmCDz1gPb3yr3O
         BnsvkOEW830O/y71Ln622I1GYlNyDL3CsgYNNQlu1ClwX+RINNJEIKql6pRMrNs5RdKU
         AhAA==
X-Forwarded-Encrypted: i=1; AJvYcCVVCVWZdO27oHEQO2dDVVtqAwLPGjVObfzd8p89riFAj21Q6iiRk9lmpXWcgYeQCamMYNp+mKCRRT+tZoI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5eIoL9yYxMdi5K2k0RB/l3cENohSUu6JSSTs/2MXMY9A3OV9t
	t5zgdtjVtRCGBTysWsfHHLrvYNtwDioe6nIgXfHlWDc1GPbsUjl9QmmVxW74OoKPy6gXKR96HF/
	eiXey67KbSUuihzvYhXe3WCN8mGMJYapiNni3
X-Google-Smtp-Source: AGHT+IHx8d58x69Efb/u7PFGAQqvDWRxGlD0tGf0focGcku3t84Rjwu43AOhis6qf2wJYkTXSAOF08RL9gMyuD0uADw=
X-Received: by 2002:a5d:5585:0:b0:371:8e3c:5c with SMTP id ffacd0b85a97d-37a422532b6mr9309865f8f.7.1727083507425;
 Mon, 23 Sep 2024 02:25:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240816001216.26575-1-dakr@kernel.org> <20240816001216.26575-14-dakr@kernel.org>
 <a8c31bce-aac2-4ffe-8fab-2e68c9bab035@proton.me> <ZuIS0lBDyxsxuHwf@cassiopeiae>
In-Reply-To: <ZuIS0lBDyxsxuHwf@cassiopeiae>
From: Alice Ryhl <aliceryhl@google.com>
Date: Mon, 23 Sep 2024 11:24:54 +0200
Message-ID: <CAH5fLgh+4QHsiQZmKixhZ+e10fAO-gHfPi0Y8wsWBeiV8gyp0Q@mail.gmail.com>
Subject: Re: [PATCH v6 13/26] rust: alloc: implement kernel `Vec` type
To: Danilo Krummrich <dakr@kernel.org>
Cc: Benno Lossin <benno.lossin@proton.me>, ojeda@kernel.org, alex.gaynor@gmail.com, 
	wedsonaf@gmail.com, boqun.feng@gmail.com, gary@garyguo.net, 
	bjorn3_gh@protonmail.com, a.hindborg@samsung.com, akpm@linux-foundation.org, 
	daniel.almeida@collabora.com, faith.ekstrand@collabora.com, 
	boris.brezillon@collabora.com, lina@asahilina.net, mcanal@igalia.com, 
	zhiw@nvidia.com, cjia@nvidia.com, jhubbard@nvidia.com, airlied@redhat.com, 
	ajanulgu@redhat.com, lyude@redhat.com, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 11, 2024 at 11:59=E2=80=AFPM Danilo Krummrich <dakr@kernel.org>=
 wrote:
>
> On Tue, Sep 10, 2024 at 08:07:40PM +0000, Benno Lossin wrote:
> > On 16.08.24 02:10, Danilo Krummrich wrote:
> > > `Vec` provides a contiguous growable array type (such as `Vec`) with
> > > contents allocated with the kernel's allocators (e.g. `Kmalloc`,
> > > `Vmalloc` or `KVmalloc`).
> > >
> > > In contrast to Rust's `Vec` type, the kernel `Vec` type considers the
> > > kernel's GFP flags for all appropriate functions, always reports
> > > allocation failures through `Result<_, AllocError>` and remains
> > > independent from unstable features.
> > >
> > > Signed-off-by: Danilo Krummrich <dakr@kernel.org>
> > > ---
> > >  rust/kernel/alloc.rs      |   6 +
> > >  rust/kernel/alloc/kvec.rs | 629 ++++++++++++++++++++++++++++++++++++=
++
> > >  rust/kernel/prelude.rs    |   2 +-
> > >  3 files changed, 636 insertions(+), 1 deletion(-)
> > >  create mode 100644 rust/kernel/alloc/kvec.rs
> >
> > I noticed that you don't have a `pop` or `remove` function implemented,
> > I think it would be weird to have all the other functions but not those=
.
>
> I'd rather not add them for this series anymore. We can add them in subse=
quent
> patches, or wait until they're actually needed.
>
> I also already have some subsequent patches in the queue. For instance, i=
n Nova
> we'll need `Vec::resize` and `Vec::truncate`.

When this lands in rust-next, we should open good-first-issues for
these on the Rust-for-Linux bug tracker.

Alice

