Return-Path: <linux-kernel+bounces-192831-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F81F8D22D6
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 19:57:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 13DFD1F24A50
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 17:57:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFEE94596E;
	Tue, 28 May 2024 17:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="epfvodyS"
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EFB43E478
	for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 17:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716919015; cv=none; b=ZTO20DgSHQu6a4uLc+cvJXzn6sI94OMqQ0clB2npthk2+Hzf5iIRD0XyQgZi2BiZ29HcbxFKL8Nq/rXw4GZKVHrRycz2o/+mEi195zveVXU2+KNJE4qorwET5X3My0VYKYy45ujSq512QvBIYhT6SSa1D4NtcVkJMh84aqhZo48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716919015; c=relaxed/simple;
	bh=RsvjGM9JTcVgBiBSDa/jqsgorhKnTlBpTCld5EUEWJw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=t0BvtBNjrxMiGuQpG/8y5mXX8VXelKPDaOcIfvXLfBNI3+ISoWShwJyzln8ZB1KhbHv6CquWCRuYjduetqaOuXZeaGTqJobp9AD13pca2YhX43oh8stOP615rqBeeX1xNYNviVUm1GUiu/ANxUy0rA3c8JyQ2iqmxSIGmve7688=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=epfvodyS; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-572f6c56cdaso2052a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 10:56:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1716919012; x=1717523812; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SKUGqqWPr9TLGGPFQ1drx41emUhb6B1gi66jgb5MsYE=;
        b=epfvodySPIQTb1tAZd2f5Q1CTGkiP2uoI0M4xgAzg9uLlCdiODGQZ0T1vE+NnZWpgd
         tm3/FSFjlSPIg60/ZiZH2icW7y883G00So8DSnuHmpTDZvgEBESxIZn/b0RXBzseofOA
         ZT0Me++u6iBpOYUBDzv909as9oY1xXU2Bw7KAwMMYdY5Q2rLjKmFpFbadXC+WHHYkSqr
         RETDMrlAetozmltE0I+PjX2qb3J2DT2Vab7gT0Zfyv7tHMf2A0Xr8sFrFGLbBmZyAtPz
         SE049xy8FzMkF4UySMSx2dpd7ELEKVusIHKSMg4HRmVcV7E+UOi3e6QmGGI1QufjcGBb
         CSIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716919012; x=1717523812;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SKUGqqWPr9TLGGPFQ1drx41emUhb6B1gi66jgb5MsYE=;
        b=uWVgMCRI23c/mNWZpSS4I6Hq0mFBUK4pQNykEQ7N8ceU8TmMk7dPiqUVKWZE8ytnuE
         aexwBmFxN7Xvz4Zm/ypU51MQGYmyeo/I0oWLF8DHSdqyY4Onp07L15zo72Ej2Az+o66s
         E0lHPvqMQmtBOGX5FTzz8+rNPk7E51kqgH26nT7nveCLa6VA02WNJyXotyOO/+DcrDQc
         PoydynHxgqJCOJfN8apf5CG5lJRjtdWCPDdVV5aG+FL+DycqHddvGA9599UOvM/CHtqK
         cCWLg5a3jjHQa728p5lC5YyVnqXCH3iuZD3dg2lVFQ0GXFkVQbLBqaDl4TCi7laLlPel
         vzfQ==
X-Forwarded-Encrypted: i=1; AJvYcCUgd35U4ZRBcaMJyRGNvwY8yzMhVZFDoyC0ftSzeUm1P2UFXVnt3lKAHj/9e/K0tJwbpGTQmr7XMb37+g83srhUoqKANFMVv/8Rtfkn
X-Gm-Message-State: AOJu0Yzu7EvlUbnf6WT4s4u+RRU6bc1Y9jnFs29piwQisStRBZvhu1hY
	I7XlTzJnRAAeiHcsmqIOaQ6GDFNOiEfIEOQlrS3mJ1P4t/ckvs/lFYJ+++Yqdc9+zN9Mf+TeApR
	1K6qoBwoXjn8Q2z0DiOUhAjtMiN6m0PGkuMLcADT7aJ57MV1Xviej6Dg=
X-Google-Smtp-Source: AGHT+IEcFSGFLA92N67hRJZZKfuUP54ChZWVp/fzQzI9F+ne83J/6+p0ouLE12hyW7IobvfLf4GWEsYmji6NaeNQTP4=
X-Received: by 2002:a05:6402:13d4:b0:574:ea5c:fa24 with SMTP id
 4fb4d7f45d1cf-57a02766876mr11029a12.3.1716919011421; Tue, 28 May 2024
 10:56:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240513191544.94754-1-pobrn@protonmail.com> <CALmYWFt7MYbWrCDVEKH4DrMQGxaXA2kK8qth-JVxzkvMd6Ohtg@mail.gmail.com>
 <20240522162324.0aeba086228eddd8aff4f628@linux-foundation.org>
 <1KDsEBw8g7ymBVpGJZp9NRH1HmCBsQ_jjQ_jKOg90gLUFhW5W6lcG-bI4-5OPkrD24RiG7G83VoZL4SXPQjfldsNFDg7bFnFFgrVZWwSWXQ=@protonmail.com>
 <08450f80-4c33-40db-886f-fee18e531545@app.fastmail.com> <CALmYWFv9dK5ZPzwx3WCLMXzuuDadvFxh84+8rrT7aL105+ZZAQ@mail.gmail.com>
 <20240524.160158-custard.odds.smutty.cuff-caukvmB4EWP9@cyphar.com>
In-Reply-To: <20240524.160158-custard.odds.smutty.cuff-caukvmB4EWP9@cyphar.com>
From: Jeff Xu <jeffxu@google.com>
Date: Tue, 28 May 2024 10:56:12 -0700
Message-ID: <CALmYWFs18vUwXx5p-VxNO5BZ0wvaHE54cG8n_+UdAL5-etAK=w@mail.gmail.com>
Subject: Re: [PATCH v1] memfd: `MFD_NOEXEC_SEAL` should not imply `MFD_ALLOW_SEALING`
To: Aleksa Sarai <cyphar@cyphar.com>, Jeff Xu <jeffxu@chromium.org>
Cc: David Rheinsberg <david@readahead.eu>, =?UTF-8?B?QmFybmFiw6FzIFDFkWN6ZQ==?= <pobrn@protonmail.com>, 
	Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	dmitry.torokhov@gmail.com, Daniel Verkamp <dverkamp@chromium.org>, hughd@google.com, 
	jorgelo@chromium.org, skhan@linuxfoundation.org, 
	Kees Cook <keescook@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Aleksa,

On Fri, May 24, 2024 at 9:12=E2=80=AFAM Aleksa Sarai <cyphar@cyphar.com> wr=
ote:
>
> On 2024-05-23, Jeff Xu <jeffxu@google.com> wrote:

> > Regarding vm.memfd_noexec, on another topic.
> > I think in addition to  vm.memfd_noexec =3D 1 and 2,  there still could
> > be another state: 3
> >
> > =3D0. Do nothing.
> > =3D1. This will add MFD_NOEXEC_SEAL if application didn't set EXEC or
> > MFD_NOEXE_SEAL (to help with the migration)
> > =3D2: This will reject all calls without MFD_NOEXEC_SEAL (the whole
> > system doesn't allow executable memfd)
> > =3D3:  Application must set MFD_EXEC or MFD_NOEXEC_SEAL explicitly, or
> > else it will be rejected.
> >
> > 3 is useful because it lets applications choose what to use, and
> > forces applications to migrate to new semantics (this is what 2 did
> > before 9876cfe8).
> > The caveat is 3 is less restrictive than 2, so must document it clearly=
.
>
> As discussed at the time, "you must use this flag" is not a useful
> setting for a general purpose operating system because it explicitly
> disables backwards compatibility (breaking any application that was
> written in the past 10 years!) for no reason other than "new is better".
>
Are you referring to ratcheting in the sysctl in my original patch or
is this something else ?
I do not disagree with your change of  "removing the ratcheting" from
the admin point of view.

> As I suggested when we fixed the semantics of vm.memfd_noexec, if you
> really want to block a particular flag from not being set, seccomp lets
> you do this incredibly easily without acting as a footgun for admins.

seccomp can but it requires more work for the container, e.g.
container needs to allow-list all the syscalls. I'm trying to point
out that seccomp might not cover all user-cases.

"ratcheting" in the vm.memfd_noexec is lightweight  and can be applied
to the sandbox  of the container in advance, but since admin doesn't
like ratcheting in sysctl, maybe prctl or LSM are ways to implement
such restriction.

> Yes, vm.memfd_noexec can break programs that use executable memfds, but
> that is the point of the sysctl -- making vm.memfd_noexec break programs
> that don't use executable memfds (they are only guilty of being written
> before mid-2023) is not useful.
>
> In addition, making 3 less restrictive than 2 would make the original
> restriction mechanism useless. A malicious process could raise the
> setting to 3 and disable the "protection" (as discussed before, I really
> don't understand the threat model here, but making it possible to
> disable easily is pretty clearly).
> You could change the policy, but now
> you're adding more complexity for a feature that IMO doesn't really make
> sense in the first place.
>
The reason of 3 is help with migration (not for threat-model), e.g. a
container can force every apps run in the container migrates their
memfd_create  to use either MFD_EXEC or MFD_NOEXEC_SEAL.
But I understand what you mean, with current code,  adding 3 would
cause more confusion to vm.memfd_noexec. Perhaps a new sysctl or prctl
is the way to go if the app wants to force migration.
In the hinder sight: two sysctls would work betters:  the first deal
with migration, the second enforces NO_EXEC_SEAL.

Thanks
-Jeff


> > -Jeff
> >
> > > Reviewed-by: David Rheinsberg <david@readahead.eu>
> > >
> > > Thanks
> > > David
>
> --
> Aleksa Sarai
> Senior Software Engineer (Containers)
> SUSE Linux GmbH
> <https://www.cyphar.com/>

