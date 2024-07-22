Return-Path: <linux-kernel+bounces-258887-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B541938DBD
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 12:57:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 52490281B0E
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 10:57:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0008D16CD00;
	Mon, 22 Jul 2024 10:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UMjtZfYd"
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA55816C852
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 10:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721645867; cv=none; b=PfZvpkpVBO06niPv23msAQ4zX3595PkPhK8PFQUzwCngDx9s6wWWfUfNJEy9lI7S6CQ046zBsJbN/PEb9oelSNnCK/JQqkChczFetgwytpAmftGo7MrUpiWnvQRJVXCua+7JoLbvyBBErn+6465Xpl8Kyxv1aVd1O5DV+A2x+HY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721645867; c=relaxed/simple;
	bh=haqflt8x3jSnpNCu5jIiqagI6dEE5eBn+xf1bw5atBM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QromgoYzlO7kzgU5436v21DGezGeUiZjaJ4fRxFXz/Ux0h6qjGMO1NVEGoYBdmqC08y7+CXRZp+qmiPGzyTIdRG8cQ+jy2j1bHwcCGsvEzg6TLPK9MC/VVEot4YrtpALBb+bNkiUt5pEAU9GKf43iLT6BuzUITOJO5dIrZElUSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UMjtZfYd; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-3684eb5be64so1942077f8f.3
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 03:57:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1721645864; x=1722250664; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T0ODjTpicd4m2zr4DwT7zrtDEMSSzcbc69tUjbmcV7c=;
        b=UMjtZfYdjwT1VoUmGWz/3rgSdDjopAxaasohMFChgPDAJT8imKc9j+lRbIpon1B9Za
         riHqmOL8uA/cfU15/IdXOWRQf6yim+ZqzK6cWgnh9gPoa3b3oE0+Awha2fkLyHgL2EyC
         xMKR+nuyrvEK6oshWhJTOadvDQU9F/gOW6n9hXFLsl1TYGKnJ23Kqq8VA2PZ/yz4M/uD
         oeISt1Ahhr4/x1heKpvXTV9CjiCgMO2V3gHNOEFRwhsB5s7KsP8EowLqKF4/39KS+81j
         dFkhxs2v/AcD43kF9kkD/phXnRj/XJlktUp1VGkSjf1ooYZO7O7MJgoT2373TXWYwWRA
         KN0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721645864; x=1722250664;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T0ODjTpicd4m2zr4DwT7zrtDEMSSzcbc69tUjbmcV7c=;
        b=wJQPP0GFeZkKZ762niG8fPoFvyGWZq7oIm/GWMarOPFm2Uub6/YuWQarQSykxfuy35
         j1VHis+BTqRj3FvyhCK803Ki9npnhebkap+oWRT6nISJMaJBfxABT3+FFLEPLW7v6Pt8
         8nbPnGYvElzdrTyz/S9zKHD+skiihyPSS+LRJvEtjZYpRDlYztis7yLpsryn8ZSBDNJ7
         pGFPWCj4rs0+2Ku/wfo4Hu0/fmt+z66X1C9L8d1F7QxjT42k1DA9a9SKrgxF4txOqPJq
         Bfkofy/p/B18zWFVi3W0xvFkAznKXTzt4vlJr/eeVkqN06Qj+iFFE8TWomcvFl3IfIeO
         C/YA==
X-Forwarded-Encrypted: i=1; AJvYcCXV1ju2zXCzRbv+RarkXfEaAqvhGq2FlR3sAdEgG5qJh8dwivfd0XIV3/4dFXUpFuWsd6ZtUwpYrRfzsd4T3PemXBY0XMF3I1ejRBb0
X-Gm-Message-State: AOJu0YxVV4J5n57i6S0v5WB4zIm/fM0wZBYBE26JHjgJt3a8pL6QNIMn
	cQLl4h3fmsl2H9V+VAn6FSVFXgD1v9dQOlVGv+5BcPwLk1yKCRFA96/MI4XbHrhcQvN/EVc/3m1
	H4LtGhZsd4nHEq3PA5HqlSQBsSCEDWykqsS3B
X-Google-Smtp-Source: AGHT+IGbbn8hTDpTxgC41P72NNiUMy0Tx8UmdvDkjWcBbdPjYIGsTHUwOTuwYjnoBQc08K7nS60rKwo0jBpITT/Wr4o=
X-Received: by 2002:a5d:630e:0:b0:367:998a:87b3 with SMTP id
 ffacd0b85a97d-369bbbc0796mr4050235f8f.28.1721645863630; Mon, 22 Jul 2024
 03:57:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <000000000000601513061d51ea72@google.com> <20240716042856.871184-1-cmllamas@google.com>
 <CAHRSSEwkXhuGj0PKXEG1AjKFcJRKeE=QFHWzDUFBBVaS92ApSA@mail.gmail.com>
In-Reply-To: <CAHRSSEwkXhuGj0PKXEG1AjKFcJRKeE=QFHWzDUFBBVaS92ApSA@mail.gmail.com>
From: Alice Ryhl <aliceryhl@google.com>
Date: Mon, 22 Jul 2024 12:57:31 +0200
Message-ID: <CAH5fLgjP2uOJRKCpFrwGn7X3Gw=r=wCibejp59JhupDX+QA5fg@mail.gmail.com>
Subject: Re: [PATCH] binder: fix descriptor lookup for context manager
To: Todd Kjos <tkjos@google.com>
Cc: Carlos Llamas <cmllamas@google.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	=?UTF-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>, 
	Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>, 
	Joel Fernandes <joel@joelfernandes.org>, Christian Brauner <brauner@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, linux-kernel@vger.kernel.org, kernel-team@android.com, 
	syzkaller-bugs@googlegroups.com, stable@vger.kernel.org, 
	syzbot+3dae065ca76952a67257@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 16, 2024 at 7:40=E2=80=AFPM Todd Kjos <tkjos@google.com> wrote:
>
> On Mon, Jul 15, 2024 at 9:29=E2=80=AFPM Carlos Llamas <cmllamas@google.co=
m> wrote:
> >         /* 0 is reserved for the context manager */
> > -       if (node =3D=3D proc->context->binder_context_mgr_node) {
> > -               *desc =3D 0;
> > -               return 0;
> > -       }
> > +       offset =3D (node =3D=3D proc->context->binder_context_mgr_node)=
 ? 0 : 1;
>
> If context manager doesn't need to be bit 0 anymore, then why do we
> bother to prefer bit 0? Does it matter?
>
> It would simplify the code below if the offset is always 0 since you
> wouldn't need an offset at all.

Userspace assumes that sending a message to handle 0 means that the
current context manager receives it. If we assign anything that is not
the context manager to bit 0, then libbinder will send ctxmgr messages
to random other processes. I don't think libbinder handles the case
where context manager is restarted well at all. Most likely, if we hit
this condition in real life, processes that had a non-zero refcount to
the context manager will lose the ability to interact with ctxmgr
until they are restarted.

I think this patch just needs to make sure that this scenario doesn't
lead to a UAF in the kernel. Ensuring that userspace handles it
gracefully is another matter.

Alice

