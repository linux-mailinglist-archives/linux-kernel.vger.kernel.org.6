Return-Path: <linux-kernel+bounces-549264-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC43FA55002
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 17:02:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3B3AB3A66BF
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 16:02:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1DF219B5B4;
	Thu,  6 Mar 2025 16:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Im1WvO6k"
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E06731A89
	for <linux-kernel@vger.kernel.org>; Thu,  6 Mar 2025 16:02:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741276949; cv=none; b=MkFbxd6QnPLhkUQlfUSMou5f94X4JIwYd+Qmw6uCH8MqwPXLET+Xht72xoO50a/2KJM1dcwv1yH7J3nCTo/8uOoqTRxVPOA8mz46R63BtNhcmICEBpzF23JaYg+B068Y++WkxBLTAeeRyxzpomminywQz4uQcI0CNtDo7SZaEKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741276949; c=relaxed/simple;
	bh=6aKgQ+tug2/1fc1q/T01kVpV17q2c5r3wjQoFm7zsF4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mAm58qzqLW1RpagFfkMngl+fpdUzVoQwOOdc2EbU3Hda3esylt/JZFGXaCQxSTn5kLg4s2ofF3eyB6Hl5fMVglbpDehjrB/tVHbgliDvT+oquQ4QNATrqpGfLWitwXd0XE7mTg9H1mCN3flYHYgjth33IMWfjuYLTSAjqxJJxaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Im1WvO6k; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-6e8f254b875so6391896d6.1
        for <linux-kernel@vger.kernel.org>; Thu, 06 Mar 2025 08:02:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741276945; x=1741881745; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uMo/M/d0EFIcvJgavIcd9kpQdMrMPexMxRrHFLPNiR4=;
        b=Im1WvO6k745BRyomEtOi0hyirMxpv1cuQ2QxLiqWaP9dkj5qKSrvkqgtBxUou13fUg
         FTG1aYOiIibnu+Qk4MARgpffMUUArOWb7HkeW8gS5OY3xBuAVZCtVeAI9qZruH9QqcBD
         bPIbiUWUoapNz3O5TPcAtLWxus6ebyJnewxEsfKccK6KQUEDoJKYyGwUpYoNFhkOoYTD
         heUyBVACk/COHH3dx31gwlEis2Jb/Kvbj1fcVqvgatlhPeeKtKHqUuFhvSnaAZDSi2UF
         Yb5uuqv7CJnW0yUPfPL65krGFke78RxqlUQf27T0tyLwjG11nwlxF6hB5VgS954N4dyf
         dQ2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741276945; x=1741881745;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uMo/M/d0EFIcvJgavIcd9kpQdMrMPexMxRrHFLPNiR4=;
        b=qPqwRBGTi7iw6XHs3w/bu+XvUcZPaShxg5tzkyshATadA9CzdNqIZWy6RZNVoHvDLL
         7dhmfUKFfpL2QcdTMyb7GUtKyv2Hy8f8FK6QsXVPsUgXDWV4RXfyyqiB2eBUJxCkm3Ql
         r2WCn6jmxplBjLKd0RCakfm204khMmlboxnEs21vd6MbV0cEsXa4639CXkoGc/AXl9wA
         kT6FZsO9r0oOEMvzSRk+w8+yu2IfH0qoqTVhtzXQbCtj8wjpOBpVG6+ZFyFVbzgGQjAU
         b3cpJ8JSDYzqMAf1pxGl4HmlEpAWWOXTWgDD2Rpa8GdC+XAx2cM8YEijY6vD/dD5cUoy
         hN3A==
X-Forwarded-Encrypted: i=1; AJvYcCVRY/H/8KtLu4/uhk0HNFWN9aSrA9w8rcRW5agC7iVIfAiPKEEbsv6mddamC0awwZy30BDXrwijaFzl818=@vger.kernel.org
X-Gm-Message-State: AOJu0YwjI3TerKk0ePQ+keFVTt9B28m1nFDEA6D+ZGW5KTG0tkTP5hr3
	QtJHKfrtMn9mtGcjtezCuYMHrJwK+VE1HS7KGZRqrnUhuXmdiJW3kBER2iGKc6TCc0qc0JEbWIo
	RDajAW9ozF4wiiW6uga/2z+/rbuT85akloefe
X-Gm-Gg: ASbGnct8Pt/D43xhH+M4Eo/CZ/PVqKdNtqGK2AUh7NQ0iajZqSU7skSHNDOvOPmlUNq
	u7WhKey59TaFMURy9Cr++MDHM4kKPycpF2YRXNPL34eLqGqS4INXbQ/8gwPIytbdSwdb9F1kAWg
	QwCUS4reWehlNn1gB1Ho0OI7RTTg9czeip6VVjaYBMr37BMedIDWacDbZc
X-Google-Smtp-Source: AGHT+IGX/E2PHF/+YLwoVkYYiH/aSpMz8sD+kNIhAFRSQzVHlUIXuGHEMDAwEmby3tNrlm1sVt67699NsHmIFr4orEo=
X-Received: by 2002:a05:6214:d05:b0:6e6:6699:7e58 with SMTP id
 6a1803df08f44-6e8e6d1551fmr101937866d6.1.1741276945215; Thu, 06 Mar 2025
 08:02:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250306002933.1893355-1-rmoar@google.com> <CABVgOSkwrb36rrhH3H17fhYOnywhTgTh06aDaKXT4jZp474sRQ@mail.gmail.com>
 <CA+i-1C12kG9t=jqnVaKnvN4xCn58cTeph4QHOTL0+eg98rn52w@mail.gmail.com>
In-Reply-To: <CA+i-1C12kG9t=jqnVaKnvN4xCn58cTeph4QHOTL0+eg98rn52w@mail.gmail.com>
From: Rae Moar <rmoar@google.com>
Date: Thu, 6 Mar 2025 11:02:13 -0500
X-Gm-Features: AQ5f1JqAFBgL17msmF4WXZwSYJ4ufzR46Gs0RyKsZz7of0uvV6CYwmBsv3o3TjM
Message-ID: <CA+GJov5kKD+QX+kdEG3LQun=zo_aPwbA7=1NUw0dTLSGg-h=mw@mail.gmail.com>
Subject: Re: [PATCH] kunit: tool: Fix bug in parsing test plan
To: Brendan Jackman <jackmanb@google.com>
Cc: David Gow <davidgow@google.com>, shuah@kernel.org, linux-kselftest@vger.kernel.org, 
	kunit-dev@googlegroups.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 6, 2025 at 7:26=E2=80=AFAM Brendan Jackman <jackmanb@google.com=
> wrote:
>
> On Thu, 6 Mar 2025 at 10:00, David Gow <davidgow@google.com> wrote:
> >
> > On Thu, 6 Mar 2025 at 08:29, Rae Moar <rmoar@google.com> wrote:
> > >
> > > A bug was identified where the KTAP below caused an infinite loop:
> > >
> > >  TAP version 13
> > >  ok 4 test_case
> > >  1..4
> > >
> > > The infinite loop was caused by the parser not parsing a test plan
> > > if following a test result line.
> > >
> > > Fix bug to correctly parse test plan and add error if test plan is
> > > missing.
> > >
> > > Signed-off-by: Rae Moar <rmoar@google.com>
>
> Thanks for taking a look at this Rae! I tried to take a look myself
> but I could not really get a grip on the parsing logic in the time I
> had.
>
> > Thanks for looking into this: I don't think we want to unconditionally
> > error if there's no test plan, though. Pretty much no parameterised
> > tests include one -- it's not always possible to know how many tests
> > there'll be in advance -- so this triggers all of the time.
> >
> > Maybe we can only include an error if we find a test plan line after
> > an existing result, or something?
>
> Since I reported this bug, I discovered that the example above is in
> fact valid TAP:
>
> > The plan [...] must appear once, whether at the beginning or end of the=
 output.
>
> From https://testanything.org/tap-version-13-specification.html

Hi!
This brings up an interesting question because the parser has been
mainly geared towards parsing KTAP
(https://docs.kernel.org/dev-tools/ktap.html) rather than TAP.
(Although we do try to have backwards compatibility with TAP v14
"Subtest" lines)

For example,

TAP version 13
1..1
  TAP version 13
  1..1
  ok 1 test_case
ok 1 test_suite

This would be accepted by the parser without error because it is valid
KTAP even though it is not valid TAP v13.

The scenario above that caused the infinite loop would be incorrect
KTAP (which requires the test plan to follow a version line) but
correct TAP v13. So do we accept it without error? Ideally, we would
parse based on the version given in the version line.

Just an interesting thought. Either way, I will remove the error for
now as our parameterized tests don't properly produce a test plan,
which causes errors.

Thanks!
-Rae

