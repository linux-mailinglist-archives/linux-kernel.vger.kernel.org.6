Return-Path: <linux-kernel+bounces-227103-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CEE21914863
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 13:20:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 23F5FB2491D
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 11:20:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09421139590;
	Mon, 24 Jun 2024 11:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YwG9AEXR"
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEB3D139CE3
	for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 11:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719227993; cv=none; b=PlnSysRFIep74YXZV/2YWkzyeh6a2a5LNJ8G00Uz+BNZc4Us1MwjO2pR8zChd+achVC3hsO5/PqK/gYfAf/hgna/Jb94ItGMYw3tjo1kj0R+r+E4KpMbKsuw5FM9WlcFeu4jS5oRixJpWVijWEKdIm0AiuG3ZXnYXXD6IKVTzQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719227993; c=relaxed/simple;
	bh=SAr4cJfmC6RoNYKlZAxW3yB5zFcKNRsCXERdwsVtOnk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PZnTArCL4+mQho/vLKAgz3hTrCdP6tszHNdatGfaggxNpJzDGkqHdIjODnR7fButWLuabEKhyzUYm+j12wYQE1EqTex4ovukcq+nvyqv3dVu2jmfRXOhkpGvj2RKOOjisnBSDp31ChhFE9O3dTpV579aDc+X9k1N2dai701Xdh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YwG9AEXR; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a724b9b34b0so114112366b.1
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 04:19:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719227990; x=1719832790; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QtiiyyzQAKS/lcFM9z6EzA+bOSqBDNBJ3Poti69yLCc=;
        b=YwG9AEXR9bI7bIKHGsZEkVet27vOjsZJ2nH83t6/LH6Gn3AUDll0CO+D/gHODEaB1H
         hyFxR2HUXa3hfvkW4pckmgvyYEMWj+PLKXUIKMFjSvzFyJMrP4xZCVs7sirveBvqTT/f
         B3DiCcpe0o/mLnUAxijw273yi5GWRLNrMMMzm7yDZnq0vzmkKmldXdNml/pDU9iSo+eq
         TJjWgp1+uN23Gd1yAvmfuI72fGlQVqOZg/V6AAoz9ltolViKKLCx49IFc/RuvOGeZpzB
         UmU3yF1EjuFHTnRJfMkcvIhdMRmnNQrPbboMC5hWkXl2M/v3tVazPBg+g9a6COwh5n1M
         xz8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719227990; x=1719832790;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QtiiyyzQAKS/lcFM9z6EzA+bOSqBDNBJ3Poti69yLCc=;
        b=eQZ6hnDRNmV1KajKgfJAx2ewXvSo8geI/Aa6f/cPB7TklfOYk8oZRqQoQAa7HXCoch
         /HoM0yg5zdsbTE7NQbfTvfIiKkh/iL9QqxqltBV49VcvlaV06MhhLeleKz6Laws6q3bU
         Z9jcBpVWVP9ECsHQmk4j2kuEAQHq/BfCGLS+ogIaD4rnw6oS0HQAmzGIna6fBqgkijXk
         9cFMhvF+YlHcMc0WQ8ipESVAHZ72bKx4znDQ5GfPCJArnSFCqZTNtvITqjAea55vHKSW
         WOCeLh9JAKUgqLyI1Olal1WpOk+WOXXXZ18xMmkSET1WBkQFY84c5M3nfP4kYEhAHPMO
         /mEg==
X-Forwarded-Encrypted: i=1; AJvYcCXZyVhb2u2f7FTMfTYwSVgEIguJU9cR+bScmzhJQCLifXWmIWNvvmSpt9MeSZl5AjmhFk7r90S9bAur7HnWeKrRhlZmIH8NTNijmCkT
X-Gm-Message-State: AOJu0Yw5j+7Jkt9WIks8/KjTeNhCVu6mz86JPi2ZtTw3ef2mIs03o435
	ShuVX+c0t3c+MkIZdpBC35gJu3gt/b5/Dw9eN8mOlpTWqdOgLQZ5dKfaLUgartJm+kZ7nq+ORs8
	ZqDLbMMqO8ahbUc3eHuRcufn8KOjt3T6yc6y3
X-Google-Smtp-Source: AGHT+IFavRgHxzHIAZkbbnuFyxT0f9TWW9WFMLzRWqUYDWU5kX1mW+mvPQnsacbG3JdWCH0dOiHxRSQ3dM2cuq7JYw0=
X-Received: by 2002:a17:906:9c92:b0:a72:5598:f05b with SMTP id
 a640c23a62f3a-a725598f319mr148564366b.9.1719227989488; Mon, 24 Jun 2024
 04:19:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240418012835.3360429-1-yosryahmed@google.com>
 <CAJD7tkZmDQi2HBOxe5u-Lji88NDuZKCQ_=N_O5aE1nq23aUPqw@mail.gmail.com>
 <9531f1fc-f91e-40ce-9432-5bcbba2fe2f7@intel.com> <CAJD7tkb7wz2P17pehTQtqjueMUxGaUOpFwzoQr_V39npOwuy7g@mail.gmail.com>
 <CAJD7tkaVDrc=vioidZHM6KfdCqrCDt-HXn-RussNS145M1fNgg@mail.gmail.com>
In-Reply-To: <CAJD7tkaVDrc=vioidZHM6KfdCqrCDt-HXn-RussNS145M1fNgg@mail.gmail.com>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Mon, 24 Jun 2024 04:19:11 -0700
Message-ID: <CAJD7tkbve6kKheCO5ZnqOgU_m6m-DaJH1nG=87EnF+L5HYX2kQ@mail.gmail.com>
Subject: Re: [PATCH tip:x86/mm v3 1/3] x86/mm: Use IPIs to synchronize LAM enablement
To: Dave Hansen <dave.hansen@intel.com>
Cc: x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, 
	"H. Peter Anvin" <hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, 
	Rick Edgecombe <rick.p.edgecombe@intel.com>, Andrew Morton <akpm@linux-foundation.org>, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 3, 2024 at 3:20=E2=80=AFPM Yosry Ahmed <yosryahmed@google.com> =
wrote:
>
> On Thu, May 9, 2024 at 11:28=E2=80=AFAM Yosry Ahmed <yosryahmed@google.co=
m> wrote:
> >
> > On Thu, May 9, 2024 at 11:22=E2=80=AFAM Dave Hansen <dave.hansen@intel.=
com> wrote:
> > >
> > > On 5/6/24 07:37, Yosry Ahmed wrote:
> > > > The merge window is approaching, is this patchset ready to be picke=
d
> > > > up? Is any further action needed?
> > >
> > > Yosry, the merge window is when we send content to Linus.  We general=
ly
> > > create that content weeks or months before the merge window.
> >
> > Right. The patch series has been idle for a long time so I assumed it
> > was going to be picked up for this merge window, but given how close
> > we have gotten I think we're past this now.
> >
> > That's fine, I am just trying to get some clarity on whether anything
> > else needs to be done for this to be in a mergeable state.
> >
> > >
> > > The best action on your here would be to touch base with Andy and mak=
e
> > > sure he's on board with the solution you think he suggested.
> >
> > I have been slightly pinging the series and/or resending every once in
> > a while, trying not to be too annoying :) Hopefully Andy will voice
> > his opinion.
>
> Hey Dave,
>
> I have tried reaching out to Andy on and off list, and didn't have any
> luck unfortunately :/
>
> Is there any way we can still make progress on getting the fixes in
> this series merged?

Friendly ping on this :)

