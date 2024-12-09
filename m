Return-Path: <linux-kernel+bounces-438362-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B8859EA02F
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 21:21:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B7619282B94
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 20:21:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D9A419924D;
	Mon,  9 Dec 2024 20:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TKhbLVJj"
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49B6B137930
	for <linux-kernel@vger.kernel.org>; Mon,  9 Dec 2024 20:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733775674; cv=none; b=A+KycoO/d5+oCKJLj29C1DM5xvzi9MmPkWu1KY/0QIs2RU35vMjM1t8n3f4u8vesPRB5+RciU0N+gQn4DEYitHYiC/KOd9tnj2T7fGA7wE8YE/IWWCznUzZ2NA01aLDnlmNQT4oIt2Oql3XJ7RD0JIBGSRL7uMQveDBvMhPEywY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733775674; c=relaxed/simple;
	bh=EXcgV1S+rvIACYSeHU8ZfUEgP9dzRF+3P+4Vfj9zF10=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FNgiMeQYvTd5aodZKUM5noz88Ngd5fo3jsIhb4/0LQMLvYLl46N8huD4ad9vMRRuT5WKxM7h4G7rZKSRl79Lj9EyTs6i0HUIl/eKCcaJEyOXpiZXlyq0FgEWnKdXeYCIipOy/6UzMIXklBx8gLq3InO+s04nH96kltpFpOhLF2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TKhbLVJj; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-4674a47b7e4so10861cf.1
        for <linux-kernel@vger.kernel.org>; Mon, 09 Dec 2024 12:21:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733775672; x=1734380472; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Of2KCk2IQ25clcxVIJ7klu0CYCadcSaemKVjHO/P0k4=;
        b=TKhbLVJju0uQBV/Pz3ziFXUU9AdCc3Gq93/hB/yc9RTFdG0mfkB57uRRZg+hyXUXrM
         0sncpZKtHWxZfZ01gUymu6t7g5gy86y/MhNT5SmC7r9Jfek0XDkmigHVO3vvowp5/a1S
         8rJDlm3ipOV0nLfdOKxMJFP2dUAHOsTcmx+pO+CDGwtkfKEBuTUw9MFJ/m4Gxa6KGAzf
         bcjzIi3nViWA01LlzeCN3czGAnky+s2JICgB2jlEyinBRJKc9gal8jSEkmzCDlAkCfSH
         cYcMAW4I8Wh64VrvzCLMViUK3R9xsakUry+y+iTD4qh53t71RdcXwf+eWzNwi2P1n+0Q
         YTfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733775672; x=1734380472;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Of2KCk2IQ25clcxVIJ7klu0CYCadcSaemKVjHO/P0k4=;
        b=XWt3tg+9CvA+zMWLckDx2mgufA42TFsmSPMX5L4wkxOR4+Ifu5XMPe9j2THButVAZf
         LdPP5SJ61eY3/DkOgGE+EJUK22kBYyHmL6npUOdVN9Ot39wL+Q6Ae2TkwCpL/ax1eiTn
         5DVjUbAH28+rFOrX16qD8VzjKBab3zI1Kqp8KMB3sLxBGSgQGOJwQeDmYvsgBZTFkfTW
         P8dE8eeOYqRykeX/eOmmR84QJeEPU7v7luzpYt557LfdWlO+JH8OPc2lcbYaoztpXGl8
         p+H4HctgKmTQNVTNupbVzr9JLCcCMo+wofLMMYMg0eeYBh1SzHqQ+oQPRVo6rtFg7Ub6
         gzYg==
X-Forwarded-Encrypted: i=1; AJvYcCUJNot63HW7oLnb8sqrw1qGAzoyVuBGcBcGIkSJ5ahUh1nCvI2eT/DaalcYCRlILchRiopERvhSJ6XhyOM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxme/pIVd6TIHq+/GLMjRwcT0VTCRQeU1CG/c39Mh2iAtGDUj2P
	PhurOewQkizj/u4r3fMCxLiEWeqKeoC6IdaDlfc0RBpOBVPWM0MWO05w5GHPIiJOzI1zFZjlT+4
	XZTZ4Tvq2nXts5VNu6zMKeE1NGG0eJLjVO8Su
X-Gm-Gg: ASbGncszz5Wu3Bn0Yeoq5p3E3bwtum7RQBUOQH8qgyOro/1NG4W7KDo6CeQHHGf2DC6
	PpUcaNayEnPopxOm5D0fz+dZkF5uARUeStNQ=
X-Google-Smtp-Source: AGHT+IEWiyxZkRtSna1covNvDAZ+NAGWBqGB+7GP8aCZuVYqIiAKqAXlmJ9Fm/zPneHDfoMgU+mfamydLRIET0c1cu4=
X-Received: by 2002:a05:622a:5511:b0:466:94a1:519e with SMTP id
 d75a77b69052e-46776179b1dmr712461cf.16.1733775671995; Mon, 09 Dec 2024
 12:21:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241209132941.58021bb7@canb.auug.org.au> <20241209110842.GM21636@noisy.programming.kicks-ass.net>
 <20241209114524.a150aba86198e6f0fc9afcbc@linux-foundation.org>
In-Reply-To: <20241209114524.a150aba86198e6f0fc9afcbc@linux-foundation.org>
From: Suren Baghdasaryan <surenb@google.com>
Date: Mon, 9 Dec 2024 12:21:00 -0800
Message-ID: <CAJuCfpFTeom8u6nb8z1+BF+1B3rChUqfvgp29h3yqFWVAu5nJw@mail.gmail.com>
Subject: Re: linux-next: duplicate patches in the tip tree
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Stephen Rothwell <sfr@canb.auug.org.au>, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, 
	Linux Next Mailing List <linux-next@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 9, 2024 at 11:45=E2=80=AFAM Andrew Morton <akpm@linux-foundatio=
n.org> wrote:
>
> On Mon, 9 Dec 2024 12:08:42 +0100 Peter Zijlstra <peterz@infradead.org> w=
rote:
>
> > On Mon, Dec 09, 2024 at 01:29:41PM +1100, Stephen Rothwell wrote:
> > > Hi all,
> > >
> > > The following commits are also in the mm tree as different commits
> > > (but the same patches):
> > >
> > >   96450ead1652 ("seqlock: add raw_seqcount_try_begin")
> > >   eb449bd96954 ("mm: convert mm_lock_seq to a proper seqcount")
> > >
> > > These are commits
> > >
> > >   46dbe8ab1205 ("seqlock: add raw_seqcount_try_begin")
> > >   5f0d64389e1f ("mm: convert mm_lock_seq to a proper seqcount")
> > >
> > > from the mm-unstable branch of the mm tree.  The latter ones are alre=
ady
> > > causing conflicts.
> >
> > Why is this in -mm ?
>
> Because
> https://lore.kernel.org/all/20241206225204.4008261-1-surenb@google.com/T/=
#u
> needs it.
>
> > I agreed with Suren I'd take them through
> > tip/perf/core to go along with Andrii's uprobe patch that relies on
> > them.

Both trees now have changes depending on those patches. If we can't
have them in both trees then I can rework my last patchset in the mm
tree to use old seqcount code and not require those patches, but we
will have to deal with the merge conflicts later.

