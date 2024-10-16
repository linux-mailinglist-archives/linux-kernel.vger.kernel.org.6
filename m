Return-Path: <linux-kernel+bounces-368131-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 38AA99A0B8B
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 15:35:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC15A284758
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 13:35:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08E0020B1EA;
	Wed, 16 Oct 2024 13:35:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nB8SeYFY"
Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA2DC207A3B
	for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 13:35:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729085742; cv=none; b=r9v1z5sA7WJoTPsRj7Ne2vnKqfCe+gJ7RUAH5LjktxW6/P3Fwki5riZCqJL8q9cZ7GDf+xl4GHbPb7rTO5jiZfLg6v1fbeM7q+lWfNfWpKzf4iJgbOBhpy1lfpRzyqzsFk2G/dODBUBZjVQyQzHt3QfCvX5UHOZor7WRQZMb0BI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729085742; c=relaxed/simple;
	bh=W7igrC/eK2v9PvQJY3vqt5RVCwQ9nvtig+iwdm+6N48=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XzlrfEGEParCnkMjb6llRd3oXOL52C9x5gN9akpgilPJD69NuraHfSNAeuaXO2P3Oq8egVg3kcLKDXNMMyu45HyAuXNOEjrFg/37UTb9zY/Cfe6upHupJT697mwUk+v7bN9YEr5rNNz+K+JD6nkiIhPnQ6RKtM5hzlHnKxBlGsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nB8SeYFY; arc=none smtp.client-ip=209.85.167.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-oi1-f178.google.com with SMTP id 5614622812f47-3e5ef9e795bso932513b6e.0
        for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 06:35:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729085740; x=1729690540; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RGFMMPXEklcwVgl1501lsYrVn6gGilFzAu+XllYmFno=;
        b=nB8SeYFYJUenPLbOqgQGE6STzfvRJNQeM8oj0Ttsle20JzbLVSIuAThnro+rPaPypn
         S7OLC1x/iT3oTZkLT8sMCeru47U19/iMI0TxNWp/iiUheJqAMvlyviG76i3e8D0eknoN
         fiVS/iJKNfpGEHQsMZ20ADqWWNd/QpeLWZfDi9GGIjKtXfOIWzHSHg1brOoml67Y2GmB
         sKaCGT79ffDgQL9Vzw5dUOHw75kOKKAGA2mSys8GmWWw2NGzBQds8yzTETcIgAkUkg/8
         ij8lP7tLezTuFu2M18kMvJKVLfluAUMYmzoDn1jp5DDnnYgv+/9r1nXS3KYdZrVNeZfb
         GBaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729085740; x=1729690540;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RGFMMPXEklcwVgl1501lsYrVn6gGilFzAu+XllYmFno=;
        b=RhewyYjYa74QJAWtTHqv3j5ZLHoyvaNYFTx3paksPNHVPfzGycaE8gUW0p444/qKv/
         pZ6XcC5FM2uBSJaA2jAfYxhkqWEmtzxn103zTtz6Q8mJJ0a8fIe7KPofuxl+tVdhxj+t
         CraWsQBFAvyzBrHTr3WptiJJm1lX8ut5+TQXPzvuBWaM08uog5LTbT1VMAixl1fQ4Tfd
         IEDTtqlDw8S212AGojlWtvZvZhI1EkQxlK2xQl6HLGM1zNZgsuPIAo/MsgVzPchMRREc
         9DOyIIHoC6jQw5ZWmWxOD31uq4jBk/AGG7fqyAHfVI8nOOp9mU0J8PzuLdbfCoIOHu7A
         C2ZQ==
X-Forwarded-Encrypted: i=1; AJvYcCWPp12H0LarLyFbUmcbkaLvG/3XlosUMOY5ljhxYSuLiULiOjq89dhYU17CcdYfqMd5/SDX6QvF5pyYz/0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx05V0p4RbqwWnpK7SsiRcELj+GOk+2+RAYZrJf9tj2oNEqRQvE
	PnsXfO3VqC3lZa4FUmQ3DhOdRilh0PK5ysDHZezchwfM2lqrMmEtanEvZ/BTdNpXhZA1RQLNXn/
	9ohBTLvyqkm7pu5w8fXHiPTCZOPC+gqAY0nLt
X-Google-Smtp-Source: AGHT+IEo2nUPwW3QYnS5NjXSEN6olMWQdzd+0ZaH/E4OSj3fWe9ng8TxJ6S34oZl/m/kvu2FLQCs6M+Xsq0azbm+z1E=
X-Received: by 2002:a05:6808:1905:b0:3e0:6864:52d5 with SMTP id
 5614622812f47-3e5f02584d7mr3874075b6e.27.1729085739815; Wed, 16 Oct 2024
 06:35:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241015140159.8082-1-tttturtleruss@hust.edu.cn>
 <CAD-N9QWdqPaZSh=Xi_CWcKyNmxCS0WOteAtRvwHLZf16fab3eQ@mail.gmail.com>
 <CANpmjNOg=+Y-E0ozJbOoxOzOcayYnZkC0JGtuz4AOQQNmjSUuQ@mail.gmail.com> <c19c79ea-a535-48da-8f13-ae0ff135bbbe@stanley.mountain>
In-Reply-To: <c19c79ea-a535-48da-8f13-ae0ff135bbbe@stanley.mountain>
From: Alexander Potapenko <glider@google.com>
Date: Wed, 16 Oct 2024 15:34:58 +0200
Message-ID: <CAG_fn=UZwpvANRFqgXX+RA3ZO_KLAcQFs0kjeim0Y75GoAgJ8g@mail.gmail.com>
Subject: Re: [PATCH] docs/dev-tools: fix a typo
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Marco Elver <elver@google.com>, Dongliang Mu <mudongliangabcd@gmail.com>, 
	Haoyang Liu <tttturtleruss@hust.edu.cn>, Dmitry Vyukov <dvyukov@google.com>, 
	Jonathan Corbet <corbet@lwn.net>, hust-os-kernel-patches@googlegroups.com, 
	kasan-dev@googlegroups.com, workflows@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 16, 2024 at 3:30=E2=80=AFPM Dan Carpenter <dan.carpenter@linaro=
.org> wrote:
>
> On Tue, Oct 15, 2024 at 04:32:27PM +0200, 'Marco Elver' via HUST OS Kerne=
l Contribution wrote:
> > On Tue, 15 Oct 2024 at 16:11, Dongliang Mu <mudongliangabcd@gmail.com> =
wrote:
> > >
> > > On Tue, Oct 15, 2024 at 10:09=E2=80=AFPM Haoyang Liu <tttturtleruss@h=
ust.edu.cn> wrote:
> > > >
> > > > fix a typo in dev-tools/kmsan.rst
> > > >
> > > > Signed-off-by: Haoyang Liu <tttturtleruss@hust.edu.cn>
> > > > ---
> > > >  Documentation/dev-tools/kmsan.rst | 2 +-
> > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > >
> > > > diff --git a/Documentation/dev-tools/kmsan.rst b/Documentation/dev-=
tools/kmsan.rst
> > > > index 6a48d96c5c85..0dc668b183f6 100644
> > > > --- a/Documentation/dev-tools/kmsan.rst
> > > > +++ b/Documentation/dev-tools/kmsan.rst
> > > > @@ -133,7 +133,7 @@ KMSAN shadow memory
> > > >  -------------------
> > > >
> > > >  KMSAN associates a metadata byte (also called shadow byte) with ev=
ery byte of
> > > > -kernel memory. A bit in the shadow byte is set iff the correspondi=
ng bit of the
> > > > +kernel memory. A bit in the shadow byte is set if the correspondin=
g bit of the
> > >
> > > This is not a typo. iff is if and only if
> >
> > +1
> >
> > https://en.wikipedia.org/wiki/If_and_only_if
> >
>
> Does "iff" really add anything over regular "if"?  I would have thought t=
he
> "only if" could be assumed in this case.  Or if it's really necessary the=
n we
> could spell it out.

I think you are actually right, "if" should be just as fine in this case.

> regards,
> dan carpenter
>


--=20
Alexander Potapenko
Software Engineer

Google Germany GmbH
Erika-Mann-Stra=C3=9Fe, 33
80636 M=C3=BCnchen

Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Liana Sebastian
Registergericht und -nummer: Hamburg, HRB 86891
Sitz der Gesellschaft: Hamburg

