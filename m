Return-Path: <linux-kernel+bounces-372187-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C2E699A4569
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 20:06:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3FF491F22220
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 18:06:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75884204092;
	Fri, 18 Oct 2024 18:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Ousfqs3/"
Received: from mail-oa1-f49.google.com (mail-oa1-f49.google.com [209.85.160.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D246B2038BE
	for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 18:06:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729274795; cv=none; b=UsLtbbGaCv3LyKi9feDsz/UVRWGrNcEUMLth61lMNZA7+XKUUZLOuKCdOarO4355YonbWlgQFyM7heBSF/Iw7kiO4drYsYpwZ2dL+I91rh1E5wSl526xh7ql1LRmUheS1f1Zi7PdlrD0mQn7GeqIBMpd8AZ7vLLv0D7vgHbWKWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729274795; c=relaxed/simple;
	bh=9lHOP9DqWKfw/NySLCh66BbzYS8s6doBkSanVt6jRaY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nDsUgAMwaSW/Uo6HTOPhQPyApeVTq1/IoQOXJmmXDurWmmu4R0kyquEeFPoYO4ouwg8K0suL40nbzp+qfSzHPuR6rF6C4xaRK3EPcqCCoOHXeAnkg4m9MGfUXxI5NSohTCD68MZ2X4SXEKYquktwoCc0T6Ds4jMAI+RjXDD01SU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Ousfqs3/; arc=none smtp.client-ip=209.85.160.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-2884594d9f7so43599fac.1
        for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 11:06:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1729274793; x=1729879593; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4xdUFp2BJs4C+TugGVY1v+LpNLjlv9m1e/7lI0oYkHs=;
        b=Ousfqs3/1Xcy0d5iReq7dbpSFf9Bmqck6YE23McEO1bdd+ho3RiOm99Ar/dNSyj98i
         +cmhUIPBEDbOj5yENo8FBEBhxt+A7TptkRyll/llq/Yjku9fBrWHJ05udYNMNo/eu7rr
         PS/lcMqRZstQRlDm9fkHzfQfs2TED/VwGqeBw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729274793; x=1729879593;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4xdUFp2BJs4C+TugGVY1v+LpNLjlv9m1e/7lI0oYkHs=;
        b=O8qrk9DS2jbXhZSt8W9Oh9Jx+q6k+4UWaPVvl2hUC7ch7LglrsrsxF18qJ9ALO0A1T
         dhwirslMZpWlj2jQ87j2XJIl45ofLTU08KWbiqEMJcNfg/ZnA2LcDenPPDvcgpraxlVy
         qn/b+tBj5hkZmo5C13bCigO2VYJrSLsxGLbYIhVW+MfadQ3xReajOoZYTRI1Rz4BTxnF
         Z5fD1Up3cdQXNBnL46M4XKT9qhh2L4n7hHEpGE7sWygDXnUyz+GvS1h50rlUhHm7yTfZ
         fNHPIqNDZTCx/q3371/Ljsz94Pwy82r+Lkg87Lmug1I3Gil2hwdQWRoCCy3oLrXvxYqf
         WAQw==
X-Forwarded-Encrypted: i=1; AJvYcCU0BTOEJuKPDIl7UhjC7mpHeUSlyPv7awkHJdo1Nw+/jvwBI+DulyaLOjCiZK0Zotsm49R835xLeWTdElI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwODB1SKRPD12oBMdPbT6tQispC2Du7p7wkiEjufeTigiKy7CiL
	YjCnScknsF5FaOKCnoauDA9PE4foAZn8nythilbF33E6x9n47LdeMv0/D0lSj0okJqOFVo2c3jd
	3iiy98twsoBa5Qwu2e5CZUBtWEnGJFdhGJHft
X-Google-Smtp-Source: AGHT+IGiqYAsYbp2TuEnbpop10/Cv/Z2PACZd+MZbdFdWLD0k5JeofybCn+2idssVW0UDzrceUreh3xg83fY1LOa5g0=
X-Received: by 2002:a05:6870:5590:b0:27b:b2e0:6af with SMTP id
 586e51a60fabf-2892c22ff16mr852559fac.2.1729274792779; Fri, 18 Oct 2024
 11:06:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <e7ea2b84-8d10-40fe-a14f-837bca851ea9@lucifer.local>
 <fd927106-2fc3-4b96-8014-2c517229bc99@lucifer.local> <CABi2SkUpCf+aOa2sPED8CosG5ccqjFd7ouot8gXi9ECqsHiZhw@mail.gmail.com>
 <4944ce41-9fe1-4e22-8967-f6bd7eafae3f@lucifer.local> <CABi2SkUgDZtJtRJe+J9UNdtZn=EQzZcbMB685P=1rR7DUhg=6Q@mail.gmail.com>
 <CABi2SkVEMRHV3swrbb6M5RA6GQpFVVx855CGwdQ1xiz3tygiqA@mail.gmail.com>
 <f9b9422c-216d-422e-94b4-d8814b0b277e@lucifer.local> <CABi2SkWAv4LXvR1Wb1e31eyZ35JfyieXhDOq1bp_ZvHPLLg-qA@mail.gmail.com>
 <e0f440b0-5a45-4218-8c51-27f848c0617b@lucifer.local> <CABi2SkWNRTCC0LzDSuzgjC1tO=KF==5FXUnPHOrPzEG5abAeDg@mail.gmail.com>
 <1f8eff74-005b-4fa9-9446-47f4cdbf3e8d@sirena.org.uk>
In-Reply-To: <1f8eff74-005b-4fa9-9446-47f4cdbf3e8d@sirena.org.uk>
From: Jeff Xu <jeffxu@chromium.org>
Date: Fri, 18 Oct 2024 11:06:20 -0700
Message-ID: <CABi2SkV38U-ZCAq9W091zYkOM1m5e-C27YmVXdTCi-t+p_W_fQ@mail.gmail.com>
Subject: Re: [PATCH v3 4/5] selftests/mseal: add more tests for mmap
To: Mark Brown <broonie@kernel.org>, Muhammad Usama Anjum <usama.anjum@collabora.com>
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, akpm@linux-foundation.org, 
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org, 
	linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org, 
	pedro.falcato@gmail.com, willy@infradead.org, vbabka@suse.cz, 
	Liam.Howlett@oracle.com, rientjes@google.com, keescook@chromium.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Mark and Muhammad

On Fri, Oct 18, 2024 at 6:04=E2=80=AFAM Mark Brown <broonie@kernel.org> wro=
te:
>
> On Thu, Oct 17, 2024 at 12:49:40PM -0700, Jeff Xu wrote:
>
> > So it is not a problem with the MACRO, but where is it used ?
>
> >         ret =3D sys_mseal(ptr, size);
> >         FAIL_TEST_IF_FALSE(!ret);
>
> > Take this example, it would be
> > assert(!ret)
>
> The problem is that the macro name is confusing and not terribly
> consistent with how the rest of the selftests work.  The standard
> kselftest result reporting is
>
>         ksft_test_result(bool result, char *name_format, ...);
>
> so the result of the test is a boolean flag which is passed in.  This
> macro on the other hand sounds like a double negative so you have to
> stop and think what the logic is, and it's not seen anywhere else so
> nobody is going to be familiar with it.  The main thing this is doing is
> burying a return statement in there, that's a bit surprising too.
>
Thanks for explaining the problem, naming is hard. Do you have a
suggestion on a better naming?

> I'll also note that these macros are resulting in broken kselftest
> output, the name for a test has to be stable for automated systems to be
> able to associate test results between runs but these print
>
>                         ksft_test_result_fail("%s: line:%d\n",          \
>                                                 __func__, __LINE__);    \
>                         return;                                         \
>
> which includes the line number of the test in the name which is an
> obvious problem, automated systems won't be able to tell that any two
> failures are related to each other never mind the passing test.  We
> should report why things failed but it's better to do that with a
> ksft_print_msg(), ideally one that's directly readable rather than
> requiring someone to go into the source code and look it up.
>
I don't know what  the issue you described is ? Are you saying that we
are missing line numbers ? it is not. here is the sample of output:
Failure in the second test case from last:

ok 105 test_munmap_free_multiple_ranges
not ok 106 test_munmap_free_multiple_ranges_with_split: line:2573
ok 107 test_munmap_free_multiple_ranges_with_split
# Planned tests !=3D run tests (106 !=3D 107)

> A more standard way to write what you've got here would be to have the
> tests return a bool then have a runner loop which iterates over the
> tests:
>
>         struct {
>                 char *name;
>                 bool (*func)(void);
>         } tests[];
>
>         ...
>
>         for (i =3D 0; i < ARRAY_SIZE(tests); i++)
>                 ksft_test_result(tests[i].test(), tests[i].name);
>
> then the tests can just have explicit return statements and don't need
> to worry about logging anything other than diagnostics.
>
> Depending on how much you need to share between tests you might also be
> able to use kselftest_harness.h which fork()s each test into a separate
> child and allows you to just fault to fail if that's easier.
>
> > > We are writing unit tests in a test framework, let's use very well
> > > established industry practices please.
>
> Plus also the fact that we have a framework here...
>
> > > Also note that you don't even need to reinvent the wheel, there is a
> > > fully-featured test harness available in
> > > tools/testing/selftests/kselftest_harness.h with both ASSERT_xxx() an=
d
> > > EXPECT_xxx() helpers.
>
> > The EXPECT_xxx() doesn't take care of reporting though,  or maybe it
>
> I rather think people would've noticed if the test harness was so broken
> that it was unable to report failures.  If it is that broken we should
> fix it rather than open coding something else.

In general, I agree with those comments, but I would like to rely on
domain experts in test infra to recommend what to use, or is
acceptable.

In this case, I hope Muhammad, who reviewed this code in the first
place, can make recommendations on a replacement of this macro.

I would image the needs of something similar to FAIL_TEST_IF_FALSE is
common in selftest writing:

1> lightweight enough so dev can pick up quickly and adapt to existing
tests, instead of rewriting everything from scratch.
2> assert like syntax
3> fail the current test case, but continue running the next test case
4> take care of reporting test failures.

Thanks
-Jeff

