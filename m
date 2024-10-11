Return-Path: <linux-kernel+bounces-360698-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1589A999E27
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 09:43:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B49CF1F24123
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 07:43:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 424E2209F5E;
	Fri, 11 Oct 2024 07:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="O7HB6qYd"
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00EDD209F46
	for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 07:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728632590; cv=none; b=jUCJ8NvON4dCmsXMnY5Gf4L7lHgM2z66hWG5y8EKyQ1nr033yCkUsR3ZzIGKVJzUabUyI/o2SzO30uDrD/iQeCXsz+h8mOMfbj41nWjsn0IdJWpe1EiwyiuX+yQi/+mFHidcPmR4fRnGepWJjpjasW71OI8MB60UO2d5ZRW1O9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728632590; c=relaxed/simple;
	bh=I72W5/47T3MPbwQO0JwIp3qY15d1Kv0wv4dzjHfGKyo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iGP4Nm+Vk95iRJ9egq/ga8V/jepleeQa9hMUlpQuktp+7FLiMwhwooCn6mNkFYsw2OESsUMHbx2h6OM0qH6YlKn/OqLDOHdFjsMD2RzE13B9JJCG2vSYeBa2skkPcoRVGQvFd+qxJd0sK4Lool3tUbOg9bOO7j/RiwQZh3TMq5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=O7HB6qYd; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2fad6de2590so25663251fa.0
        for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 00:43:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1728632587; x=1729237387; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ynf/vTcEr5Vk9oZMDpk7UymPcv7siRgtJH7xtCNjIoY=;
        b=O7HB6qYdlgaIxAuXRM2EfhzN8yE/QqOe63v+flHZ/x5EtMRu9B+yH55O8F7PpshqB4
         JuSxyldC+5jtHko1VxGLG9T1zJafQhtbWcMwYKDxnN4JhHYQhgJmQqN0mROBiZCBOOi0
         ZuJqaMdxHNmcp4cFY9C6a2wvJQ/AqxhLYLW1I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728632587; x=1729237387;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ynf/vTcEr5Vk9oZMDpk7UymPcv7siRgtJH7xtCNjIoY=;
        b=bbPg8VYV/V6Y7MDOpaamN7OeFgcTmU/eKSaPlNUdMl6nvFNDJMkkiDeDs5nK/twDcC
         1pF7lkrwG2rvzIM1iWwqqURnctLw7DJksomPASMPwcvBUhb75THFHBS6g4K6tTB18RUY
         r9JkIjfhpiet4gL/R3IDtA1u0nr57kIXNUXFiRE8zVhbQxiqJmBc0W/Z6PWp69Fe6h6L
         w9d4sUxMPws4F1JtzZUME0bETG488LjrD0sg4E1ZwJ8ec+dXAG9nqfW5MmEwiAs9DsKD
         q8Ap2nuHZJEokWyh+nbFBaZqdBLw25rXOYGT412UP4IjsGoH0obPgZVgFXhWyVJtgdrb
         RGSQ==
X-Forwarded-Encrypted: i=1; AJvYcCWCnlGHYUtu9DKxsnCAh0cwdB1RTMz7nPGK3SvMc9f6k+rGAfZLlNSY7MKS+ph7ZDmjt8LoeFat3pQ1tJs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzRGa+WMd8EW7z/PZTlO+7hx7bRHaEoi3Uv8uy5cnrYCA9r9XwM
	R8Y+ccSLM0wXhwrZ4/WtBq7OCGJuTeJjaFHdd65/yvgTR0R/C5KM2ZFEypAKcsgBbRATHAA/BUY
	+VO3gNut+awXoy6Js87NUhIJcVLzZ93mMmG4B
X-Google-Smtp-Source: AGHT+IHiw3cjPkFjmzJXLfZ0q2VjdBVBPiSkTKGMSKIMgEgi4ot2t2ZiOCLGz9/vhAgLZW/ukTZKqe+kvgFm+WuJgZQ=
X-Received: by 2002:a05:651c:210f:b0:2fa:c59d:1af7 with SMTP id
 38308e7fff4ca-2fb326feb98mr11085211fa.9.1728632586997; Fri, 11 Oct 2024
 00:43:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241011064427.1565287-1-dualli@chromium.org> <20241011064427.1565287-2-dualli@chromium.org>
 <2024101149-steadfast-skater-c567@gregkh>
In-Reply-To: <2024101149-steadfast-skater-c567@gregkh>
From: Li Li <dualli@chromium.org>
Date: Fri, 11 Oct 2024 00:42:56 -0700
Message-ID: <CANBPYPgyfZ0Jv2GEDsssvNx8=pcmn9p+K76uRwBSXhiVHGNPDg@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] binder: report txn errors via generic netlink
To: Greg KH <gregkh@linuxfoundation.org>
Cc: dualli@google.com, corbet@lwn.net, arve@android.com, tkjos@android.com, 
	maco@android.com, joel@joelfernandes.org, brauner@kernel.org, 
	cmllamas@google.com, surenb@google.com, arnd@arndb.de, masahiroy@kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, hridya@google.com, 
	smoreland@google.com, kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 10, 2024 at 11:51=E2=80=AFPM Greg KH <gregkh@linuxfoundation.or=
g> wrote:
>
> On Thu, Oct 10, 2024 at 11:44:27PM -0700, Li Li wrote:
> > From: Li Li <dualli@google.com>
> >
> > Frozen tasks can't process binder transactions, so sync binder
> > transactions will fail with BR_FROZEN_REPLY and async binder
> > transactions will be queued in the kernel async binder buffer.
> > As these queued async transactions accumulates over time, the async
> > buffer will eventually be running out, denying all new transactions
> > after that with BR_FAILED_REPLY.
> >
> > In addition to the above cases, different kinds of binder error codes
> > might be returned to the sender. However, the core Linux, or Android,
> > system administration process never knows what's actually happening.
> >
> > This patch introduces the Linux generic netlink messages into the binde=
r
> > driver so that the Linux/Android system administration process can
> > listen to important events and take corresponding actions, like stoppin=
g
> > a broken app from attacking the OS by sending huge amount of spamming
> > binder transactions.
> >
> > To prevent making the already bloated binder.c even bigger, a new sourc=
e
> > file binder_genl.c is created to host those generic netlink code.
> >
> > Signed-off-by: Li Li <dualli@google.com>
> > ---
> >  Documentation/admin-guide/binder_genl.rst |  69 ++++++
>
> You add a file but not to the documentation build?  Did you test-build
> the documentation to see where it shows up at?
>
My bad. I met this [1] error when building the doc and forgot to add
Documentation/admin-guide/index.rst. Will fix this in v3, along with
other fixes.

[1] https://lore.kernel.org/lkml/20241008095808.1ee10054@canb.auug.org.au/T=
/

