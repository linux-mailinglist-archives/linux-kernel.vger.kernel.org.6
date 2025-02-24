Return-Path: <linux-kernel+bounces-529158-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A3DC3A42081
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 14:25:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 044503AA684
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 13:23:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A73D24BC09;
	Mon, 24 Feb 2025 13:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PgM0ZJ65"
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7E3E24886A
	for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 13:23:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740403388; cv=none; b=BwKVZtZOo1xX17INDGn7bTC2IOAuTdOup4ZKc51n7b7rd05NouEVS1AEifitMjDvrzZ/CXS2sd0P5ELxCNPvaYtqH46TTMNRDtTfcgXBEuypf5LTLVCrdlebaKNZzHLM8M6JYLND7k4llGLs/9dguG+ymaavLndDxngMT49mKGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740403388; c=relaxed/simple;
	bh=ErUgAARBewBWeoNkYTRCi8YwJ8tj34TiI76a1eD/xfM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uUZEOJoAPh+RJHdap0PksGKXT8SB5RVm3sKViAnUrv77AQHaZGxEYo7JWP3V4Z3f9FG70e6l2iyqCcMu92vEyAnW6pd6EDvUB8XVsoCsmEMvqa3ahHSgcBeEUcpRXsahEd4J5sC7s20Um1ntvh3CVlhytMkhhOgxIZ0xilfoNaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PgM0ZJ65; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-307325f2436so42366181fa.0
        for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 05:23:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740403385; x=1741008185; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ErUgAARBewBWeoNkYTRCi8YwJ8tj34TiI76a1eD/xfM=;
        b=PgM0ZJ65DY8+yWJKyrJC1HqJYGRmYh/+Vl/BIU+6CXim97WskGLPyHk/wgFy/5fmWL
         z2gg8US0ww5qmW3y6vnTlwTqdm/BEjVYUf3CYa+X4NSSomIl8qn9tJNV/b1sCzxmU5b+
         WRxPPQ4gPhQ0HRCoBq7YDeLM76byKfWkaCDSadJY9IQB87fJ412FeMwvMQ/5SJTNwHlx
         l7NinsUQQh1BHlPzGgriCniCgFAbaTKKtSm0Nk2yK+hBrd1tmZ3iOxlpTctzhTq/seYL
         2bt5jWXcoFlhTjQi2j0sIcrFYsM3+dB8TvJRSVCmatvOLs00mvU7FDs5WYRD7jp9f0yo
         R0aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740403385; x=1741008185;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ErUgAARBewBWeoNkYTRCi8YwJ8tj34TiI76a1eD/xfM=;
        b=se1cH6Ryc0ttBcA4q8ILcfZIVwDeeMEq3x1QSA4uKUcJZmjmdLdWPizr7TwdombOhg
         KHtrrQfxywkrgrEFofWfGhocCKJKBcUEeEk8y0HX+8MbaeJKXYAaXYejvhBHv4mGRSMS
         rcwqe902VxdLdRB3EoStWsAYqBmqLvXSxX9x4e1sl1UJUxaMTct3whBl94pdVdP8VEx9
         g5fGJSVxt0IYIwDqTty2kic/+4d7RhidGjzpygs7EkGBtwk80wY1oqXV42flXzcvupJD
         wx0ToyeyJ08G6oKkI9GNkyja4aXjU3PBXGjlWF9dNHEJgEZ2zzdcdU3myyr0lllTwurk
         8KyQ==
X-Forwarded-Encrypted: i=1; AJvYcCWPrBEBiQCzmZCxBhTcGDcolq7DNscXraD2eRfxIxwAlBNhEqK+s4itpq2GDaLaKH0AqzoWW3p4iZkE42E=@vger.kernel.org
X-Gm-Message-State: AOJu0YzvU1vxmYk7n71OT6FoNYOVC9S4euzNhTMz6VAv0PWEEobtpxLI
	HFaGigN4C5kH14UQ3OkiEmU6ZNvX/5zqWoiYyfGeUWUjayK1BlkI+Iw5sdA5uFycmTlLk7OTfyU
	NiBgxAJ1OK/gmeCj+UP/rAZGYbG7BrqGDGQSj
X-Gm-Gg: ASbGnctCOj5+9936SqyD5zII7HyCSovYPTcTq2QdcH0AN7/mIM1k3xd+ihJdtCKqZoL
	02eDIvXjQOvxTvPEdeLSGClKWUUmXjOw5gWnYq4BUy8wkKH5qka2TVEX341Ej7b6kkO0rr35L4p
	+Rx6pDWVU3477GTNzsdm9vxPIYuJ4yrzSdP+IV
X-Google-Smtp-Source: AGHT+IGQMsq5fi0y5O7l1P+3Gls4exy5iGv73U6ohJfPykTLkpFyKQAln9GpO9U2FD2RKDa6pnnist6aEYYakHyUuaY=
X-Received: by 2002:a2e:3a12:0:b0:308:f4cc:951b with SMTP id
 38308e7fff4ca-30a599868e9mr42592141fa.23.1740403384552; Mon, 24 Feb 2025
 05:23:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1739790300.git.dvyukov@google.com> <1f0cd73072eb321fb5f6993cbcb9b2e67ba6355d.1739790300.git.dvyukov@google.com>
 <61d5d657-7d70-4140-9c8e-981e6db8a6f6@intel.com>
In-Reply-To: <61d5d657-7d70-4140-9c8e-981e6db8a6f6@intel.com>
From: Dmitry Vyukov <dvyukov@google.com>
Date: Mon, 24 Feb 2025 14:22:53 +0100
X-Gm-Features: AWEUYZme-vEEUn1Sy-5jnhKmmULBqwx0ajAhB8RzxW1Bjmrf1yoFtm_E6zf4_6E
Message-ID: <CACT4Y+bDz4oSLdy1u9PhS43PGeYE9RbEX7NG-iM-VcvYEWBymw@mail.gmail.com>
Subject: Re: [PATCH 4/4] selftests/rseq: Add test for rseq+pkeys
To: Dave Hansen <dave.hansen@intel.com>
Cc: mathieu.desnoyers@efficios.com, peterz@infradead.org, boqun.feng@gmail.com, 
	tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, 
	dave.hansen@linux.intel.com, hpa@zytor.com, aruna.ramakrishna@oracle.com, 
	elver@google.com, "Paul E. McKenney" <paulmck@kernel.org>, x86@kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 21 Feb 2025 at 18:24, Dave Hansen <dave.hansen@intel.com> wrote:
>
> On 2/17/25 03:07, Dmitry Vyukov wrote:
> > +++ b/tools/testing/selftests/rseq/pkey_test.c
>
> There's also a:
>
> tools/testing/selftests/mm/protection_keys.c
>
> The main thing that will get you is testing with a bunch of different
> pkey values and also a few different memory types including huge pages.
> It also keeps an eye on PKRU consistency by keeping a shadow. So if, for
> instance, the rseq code forgot to restore PKRU, that code would be
> likely to catch it. It's caught a few bugs during development for me
> when PKRU was getting wrongly-munged.
>
> But, I'm not picky about selftests. Any test is better than no test. So,
> whatever you decide to do:
>
> Acked-by: Dave Hansen <dave.hansen@linux.intel.com>

I dunno. It also depends on the rseq helper header and helper source
file that is currently compiled into tests only by rseq Makefile.
v2 of the test was already checking that the pkey register wasn't messed with.
But I had to rework the test for v3/v4.

