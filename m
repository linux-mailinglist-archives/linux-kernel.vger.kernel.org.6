Return-Path: <linux-kernel+bounces-336246-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8997C97F107
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 21:04:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2171228214D
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 19:04:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F23B11862F;
	Mon, 23 Sep 2024 19:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LW7z0icO"
Received: from mail-il1-f177.google.com (mail-il1-f177.google.com [209.85.166.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01BD16BB4B
	for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2024 19:01:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727118097; cv=none; b=RJElXbCiCQ5vTyowQSBRpie/LE/9SdMF3/XDPsWfZIOttpIRpIDqDNaRRwqWbaxgRU6DhV/17AdbJqGb5i7N0ASSFLwGxQ7IwFydJ9CjSLlrZ0UURBtyWz3NRGX+6KBMYtuKsSh5LgSmf0T4GdXWrbWc22cyu034F4Htk0rA4u8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727118097; c=relaxed/simple;
	bh=B2/RdoQY7Z+itgFh54Q2SY1jX2NKjIOcuSFCkqrM77Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pbmOcnaxPIUWfVFge5nNliR8ghcyGSjgsL9FtkpDcQ8OFGbwazbb+TI4FRn/ZFZaF04FmUm+mQtM92xOGrYUqLHJDzh9yMAOxVj/og/G1CM3Fm0wWWZYNAJTGd1IC8KafbikGqaJumEQMHt5YdJ4gImL/OWLi5JaK0mj2F5ee9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LW7z0icO; arc=none smtp.client-ip=209.85.166.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-il1-f177.google.com with SMTP id e9e14a558f8ab-3a0cb374167so28125ab.1
        for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2024 12:01:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727118095; x=1727722895; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B2/RdoQY7Z+itgFh54Q2SY1jX2NKjIOcuSFCkqrM77Q=;
        b=LW7z0icOR/s79/JT8GtLorCOkZrDtJREIUV/l+1NBxpwZy75MMslTL/sUW0dbVJZKs
         09a6IQEyM8fbhYq0gmp/XcGn8XWxxxPdmfxD9uhuAnW/lNpeLVdLY3OcdRsn5psA8qRo
         oJP4AHbIcgrNwlZUqF7YK7D0lQHof8B/I4Q0In/uO4krnOptB8Qg/mCxoQl1zNUvfLaW
         E0QwF/5V/0oUXDIMewFQp/ITBf7V8G1ezbyE8YIxd/4zulz34sRGXGRUxJ7UNoIvAWpy
         MsTttmOx1pcsrimAMm2n/BkjFLdWub9CS4/wIR2cYWSQxSTv4ooa0SWsLPWZuhHeo8jV
         foFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727118095; x=1727722895;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B2/RdoQY7Z+itgFh54Q2SY1jX2NKjIOcuSFCkqrM77Q=;
        b=eb6Bnwq64ZXxpUWPY/6xVUyXg840lAzjp3SI8Cy+xWbb4NdbPshmUc1QzbTn9rdeTy
         vvFMCnJv6qEeauMEPtQtzMdf6nywrNYAOj54xLkvprR1NPI3k8L40epZ0wvGV4aC4G+l
         gDf7NTrvBvhwVjWMU4r0XaJJ1Usn0XJnVfC4upEvIw8rz5zYstbGW1YqrkJtclfU/4t9
         hQvDhnYU5RQ7R2nl3sROkxDCOxGgNNi6I0tp13g5L/Ao2W8cvRjKdefTre8ROvuU2Gl5
         gbN5zCZr+5jcPJUvTnLu6+qS0T6UpQVT/wEnez7RU5GMeENT6mVC7RGOiPu5d0314yK0
         b0hA==
X-Forwarded-Encrypted: i=1; AJvYcCVjhxtTDt1BttPBYGpnbGq0vg7MFxi5b/BY6/ztmzMzhIN30x44deNx/SiXKxzFZ1p4mvr6TdYuCDpAL9Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YyB9cujABMG9RRir/Cl3/sqatryL0qGxKpLKuCrg/w9jAxTp6i/
	71nfFPsJuacBoQ5YLtYdEp+ZQ0BK/SO8FRbNfdJWrm4tXvF6X4jN1+kLXSutfeIaEqDehv9GAhZ
	fIFj5/08mBQ1O/CjvA4GLpLTfOQlW45fCycJg
X-Google-Smtp-Source: AGHT+IH1FtFv+Bh0wXozJpze+D8RaKOIbhKzlrUVEuEq8laEBjkD4NrTvtVKpkKT2+iv2IaNbUKmVFnSsUXY7lNl6U8=
X-Received: by 2002:a05:6e02:1fea:b0:398:fc12:d70f with SMTP id
 e9e14a558f8ab-3a1a3e54f5bmr624195ab.0.1727118094854; Mon, 23 Sep 2024
 12:01:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240912182757.762369-1-irogers@google.com> <ZuM9zc71XXXZ3eRZ@x1> <CAP-5=fUCVa3VoByKUFDp8Q+M2ZOTdy7ccL7Ter8E8dSE368KAA@mail.gmail.com>
In-Reply-To: <CAP-5=fUCVa3VoByKUFDp8Q+M2ZOTdy7ccL7Ter8E8dSE368KAA@mail.gmail.com>
From: Ian Rogers <irogers@google.com>
Date: Mon, 23 Sep 2024 12:01:23 -0700
Message-ID: <CAP-5=fX9FO70B2Z4jp50owX-Lr3sAuECje+0s13tc9C9s1v+jw@mail.gmail.com>
Subject: Re: [PATCH v1] perf vdso: Missed put on 32-bit dsos
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 12, 2024 at 12:31=E2=80=AFPM Ian Rogers <irogers@google.com> wr=
ote:
>
> On Thu, Sep 12, 2024 at 12:15=E2=80=AFPM Arnaldo Carvalho de Melo
> <acme@kernel.org> wrote:
> >
> > On Thu, Sep 12, 2024 at 11:27:57AM -0700, Ian Rogers wrote:
> > > If the dso type doesn't match then NULL is returned but the dso shoul=
d
> > > be put first.
> >
> > I guess we can add:
> >
> > Fixes: f649ed80f3cabbf1 ("perf dsos: Tidy reference counting and lockin=
g")
> >
> > ?
>
> Yep, that's the one that added the reference count increment.

Noticed this isn't in the tree yet, do I need to resend for the fixes tag?

Thanks,
Ian

