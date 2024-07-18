Return-Path: <linux-kernel+bounces-256012-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8847F9347C1
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 07:57:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AB2701C215EF
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 05:57:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 658C04CE13;
	Thu, 18 Jul 2024 05:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bqRX8rOp"
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14CC34D8A8
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2024 05:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721282221; cv=none; b=T1wN7iFWyYFc4BTxub0JQ2+BL+BztLf7V7SILXKzUR1YJvnPUWwYeLYIkWsQDYbH3fWzAujYPkqjm9e1np6yOLIuzhZ92Eimeo0Z0MAd9DcfDTqhphoqUIqQc8HzPCVjSAiH2mgAAqkVABzjmtxdAdABv2zw5XJtYIU5/wwo25g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721282221; c=relaxed/simple;
	bh=IkxjzDIvz4Z+I10a+tUE0LHtAbzXT49fuI6je2Ip4zI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Wn+8H0Tfrbb/4Bcke0n9ECITlIgRoB9/eEmuy5VPHkX0LYdLK09J39+0IRb1MURjSHpHzSncvNnIARI1zK3h1m0psb6ZBo3LvE4GbaxytPeCPWd9LU3zv/iEkDuoqhfpZyAlYhJxfVd9z3HAoYdIKaFJ/5Lm3kjFd3dFXkUEiSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bqRX8rOp; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-44e534a1fbeso133851cf.1
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 22:56:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1721282218; x=1721887018; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=rbz4NsbT2uFdigt1TV41To2Gc3aXqFKWev2oXMI220Q=;
        b=bqRX8rOp8fcPd7HhqnLSz5Ny7UDvrYUl2U+605YrYOiiUfSX+Ii4M9W4+Dp2ANOjmJ
         Ot7sjMcpoh/dRHqN/oWTTQT03H/mM5oWl5sh9Rtfueu2w4RfQWdOKEDWbvMJWaPS91fU
         CIKYC3Jxjm+rx/Y/UjuKa3GGzVu1R5kGV5GY6Qcuaxt8+smZTPzyhUSIx2d5bR4ussI4
         X/YcfdYJaWUzX0byMjgURnfGy4iH3wWO6Dznd9NERpnXpKp1/W8PB57G1VR4uCh4QC6d
         FCdaWPIHApcUQlu6OoBX7PbF1XxvypqkZD4wqL0W2rv4sPHtsy0X85fHLUyVenzy4tGF
         g6gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721282218; x=1721887018;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rbz4NsbT2uFdigt1TV41To2Gc3aXqFKWev2oXMI220Q=;
        b=shJ67c88Qrh5mGX9tXz79BwZ2g6pEwWZ56M5REeU+nBYN+48qtKlK0uAr0dJyHzJk8
         D7ny/uPFcwJjDRgTaiqszPqRmGl4+A98MESPkq1WEY4YprwLBRDu8iZPzJdPZIyQjMKf
         r7swvdPhBhKRK3tnKYfp3J0O9fsUFFDpbBeP0pAKreemGkc3OM1PVUsWwEktF/ETDk8G
         +or0KrBWVHpDE/zkyfB3qYI2d7PTQR0ePexIQBNhSAXJPJmrgy5CzddY8f8ogIGQ44jW
         6kTnYHqp1F+Ie9BdH1oT9HjKnvwBDLTMwPtDx+TyX6pQLmKvFWDLj/n6ViuBBbYjDkkE
         lZrw==
X-Forwarded-Encrypted: i=1; AJvYcCU+a35s7CXA8l7V2nhOY20ShNE09l3BsYi6NHBQvWocUCmTg3CAxxn3O2WVwk8wtkLmuQE4N5bZ2ovXjQB7Tfv3A5V5XqgkKABN8vl3
X-Gm-Message-State: AOJu0YyA8xj15WyN7mQy9maV34qM2Qluv152Hvxt4YNtOQqpXmrJ+9hc
	sVWR2xoeEXBLhfhFW5E9z0+P2y+w0MEP9qzj5/md2t08QfXeTnNG31xpyw3QAHzL3FzSN5dbWHh
	lsG8XTqniaqrN83LYzlusaDYwTqUsCZqqgQMQ
X-Google-Smtp-Source: AGHT+IFaxTO0drQmMqrLdUudcWVqMNKzfV+C4eC8p8an2z9TYGW9yxRNxlJ+dAGGQChJNxHn84hLcrZEkdw1cOaIC0g=
X-Received: by 2002:a05:622a:4d06:b0:447:e4cb:bf50 with SMTP id
 d75a77b69052e-44f91ae2480mr1410111cf.8.1721282217902; Wed, 17 Jul 2024
 22:56:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240717210047.work.412-kees@kernel.org> <a5005f1e-5bbc-49f2-bd1f-4c4878b98d26@nvidia.com>
 <202407171510.88EECF3857@keescook>
In-Reply-To: <202407171510.88EECF3857@keescook>
From: David Gow <davidgow@google.com>
Date: Thu, 18 Jul 2024 13:56:46 +0800
Message-ID: <CABVgOSmHBUrGzaACggEQhisrPqXGcL7j=SvsAsh0_=SAzCMjQA@mail.gmail.com>
Subject: Re: [PATCH] Documentation: KUnit: Update filename best practices
To: Kees Cook <kees@kernel.org>
Cc: John Hubbard <jhubbard@nvidia.com>, Brendan Higgins <brendan.higgins@linux.dev>, 
	Rae Moar <rmoar@google.com>, Jonathan Corbet <corbet@lwn.net>, 
	Linus Torvalds <torvalds@linux-foundation.org>, linux-kselftest@vger.kernel.org, 
	kunit-dev@googlegroups.com, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 18 Jul 2024 at 06:11, Kees Cook <kees@kernel.org> wrote:
>
> On Wed, Jul 17, 2024 at 02:16:30PM -0700, John Hubbard wrote:
> > On 7/17/24 2:00 PM, Kees Cook wrote:
> > > Based on feedback from Linus[1], change the suggested file naming for
> > > KUnit tests.
> > >
> > > Link: https://lore.kernel.org/lkml/CAHk-=wgim6pNiGTBMhP8Kd3tsB7_JTAuvNJ=XYd3wPvvk=OHog@mail.gmail.com/ [1]
> > > Signed-off-by: Kees Cook <kees@kernel.org>
> > > ---
> > > Cc: David Gow <davidgow@google.com>
> > > Cc: Brendan Higgins <brendan.higgins@linux.dev>
> > > Cc: Rae Moar <rmoar@google.com>
> > > Cc: Jonathan Corbet <corbet@lwn.net>
> > > Cc: Linus Torvalds <torvalds@linux-foundation.org>
> > > Cc: linux-kselftest@vger.kernel.org
> > > Cc: kunit-dev@googlegroups.com
> > > Cc: linux-doc@vger.kernel.org
> > > ---
> > >   Documentation/dev-tools/kunit/style.rst | 21 +++++++++++++--------
> > >   1 file changed, 13 insertions(+), 8 deletions(-)
> > >
> > > diff --git a/Documentation/dev-tools/kunit/style.rst b/Documentation/dev-tools/kunit/style.rst
> > > index b6d0d7359f00..761dee3f89ca 100644
> > > --- a/Documentation/dev-tools/kunit/style.rst
> > > +++ b/Documentation/dev-tools/kunit/style.rst
> > > @@ -188,15 +188,20 @@ For example, a Kconfig entry might look like:
> > >   Test File and Module Names
> > >   ==========================
> > > -KUnit tests can often be compiled as a module. These modules should be named
> > > -after the test suite, followed by ``_test``. If this is likely to conflict with
> > > -non-KUnit tests, the suffix ``_kunit`` can also be used.
> > > -
> > > -The easiest way of achieving this is to name the file containing the test suite
> > > -``<suite>_test.c`` (or, as above, ``<suite>_kunit.c``). This file should be
> > > -placed next to the code under test.
> > > +Whether a KUnit test is compiled as a separate module or via an
> > > +``#include`` in a core kernel source file, the files should be named
> > > +after the test suite, followed by ``_test``, and live in a ``tests``
> >
> > I read the previous discussion in the other thread and thought about it.
> > And ran some kunit tests on baremetal. Delightful! I love this approach.
> >
> > However! It is rather distinct and not just any old test module. Kunit
> > has clear conventions and behavior.

I fear the conventions and behaviour aren't _quite_ as clear as would
be ideal (for both good and bad reasons). In particular:
- Tests which don't use KUnit nevertheless are starting to have some
KUnit-like behaviour (e.g., KTAP-formatted output); and
- There exist some non-unit tests (e.g., slower integration-y tests)
which nevertheless use the KUnit framework

When we last discussed the naming scheme, one proposal was to use
_kunit only for tests which were fully "unit" tests (excluding the
last batch), though now that we have the 'speed' attribute and
similar, I don't think that's as useful as it once was.

> > As such, I have quickly become convinced that distinct naming is
> > required here. So I'd like to suggest going with the the suffix:
> >
> >     _kunit
> >
> > ...unconditionally. After all, sometimes you'll end up with that
> > anyway, so clearly, the _test suffix isn't strictly required.
> >
> > And given that we are putting these in tests/ , a _test suffix is
> > redundant.
> >
> > Yes?
>
> I would agree. David, what do you think? I realize drm already does
> tests/*_test.c, but it does seem like better information density to use
> the tests/*_kunit.c pattern by default?

I personally don't mind either way. Other than the argument that KUnit
is simply an implementation detail (and that renaming things makes
porting tests to KUnit slightly more annoying), I don't think there's
anything wrong with using _kunit, and it would give users an easier
way to know if they can use KUnit tooling with it.

Let's do _kunit by default, then.

-- David

