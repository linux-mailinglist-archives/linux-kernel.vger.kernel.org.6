Return-Path: <linux-kernel+bounces-398658-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B9D19BF447
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 18:29:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DAC2328575D
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 17:29:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73D55206948;
	Wed,  6 Nov 2024 17:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="i5i8jk1K"
Received: from mail-il1-f175.google.com (mail-il1-f175.google.com [209.85.166.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A54F206941
	for <linux-kernel@vger.kernel.org>; Wed,  6 Nov 2024 17:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730914152; cv=none; b=JN6M0+2/umuuBSBcndLkF1QAm8NUOKHCqTFkBP1562OsOzHhRKDskCVe+FIJUnpjKZG8k3gRiuWmxIxHfCFwoqhz6unG5XNJW3voCZvtjd98DEg1d8mdO/v8nJzKzWpV1XLdh348f+PCLzaTmAio55GzZL+RQK7o33hzUlYH7qg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730914152; c=relaxed/simple;
	bh=Js4xf9bjePQ7YFFhaBShMODMGHdgaF7gn0ytc8NoTvY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nM2l+tcCU9LKMfnDSJvmb9+7DkSjWCPJTM85F4hAEUeHIXiFfEgVbFqlCoHm8CjjbwCHFq0dDzMbneKpqHuEy9XedB6XwEX58iIhzVrRLClIqMYqR23Rp65Aaevm3kuuSbjzQ9RX650C6bYLY29jN7qkMNDfl2kpQUmZFVKbNa4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=i5i8jk1K; arc=none smtp.client-ip=209.85.166.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-il1-f175.google.com with SMTP id e9e14a558f8ab-3a3b28ac9a1so269245ab.1
        for <linux-kernel@vger.kernel.org>; Wed, 06 Nov 2024 09:29:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730914150; x=1731518950; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=teDWCAC+SsPNKfZDGmf1mQnLJlQp1SAmCbKNEmulZa0=;
        b=i5i8jk1KOE3ZFT2oeFwXEueaa+4bEuyvxjTPA6huD7weWGn3ueBRDDCMojW8+6F4uO
         ghF1tMBRcCuowIrI5eaY0Ww3+Z4kpYl6RDiTu/gJCaC/LhIMy+tr3qMBPDuKYWuU2LyI
         JlyhiTPvnBu8e4zbHL5UyagmT5w1mXboxqDUjIOlVqp70Y5mtx/yl1WA1AT50zXw31bd
         5hieoD5Pj7/Ft6vi5YXAjJbdbz8JpSta+Zxy+ZM8RZGUElZAcrBLNFB2Gor4TmK7W+Ap
         TDs8L5ntQTO6tFcDCrPlLrtoXVhkPTWDPWsRgH0vCB2EJTo9ggvVq/Jd+ZOvKiu3g1fl
         j6Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730914150; x=1731518950;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=teDWCAC+SsPNKfZDGmf1mQnLJlQp1SAmCbKNEmulZa0=;
        b=EzC9CqQw7PiR6MxQQRoAeRjCxGE5Czv4PmAheuMYZ7zasFdYuucwYkerYRZgw1pn6p
         Jdm6g4UT//yH403cD7ZYJTsja7pCQVdPVV5rhsXkDsWfuRb8r2b5W/IkMGSG8K7/PPIh
         YXJnsE8BlBT5pp5jmjU8a4wzt4WO1CDmwQtOCvPS7yNYPsM+2EIEBSKVgAxYJcOMBdLt
         +rcbG+PvLq240Lls3BRw9uOC/DrtXwvOmKPNsy8A4CtJn4J/lw06/2Fs5ipcE3UmtdKg
         gIh7bsA+NZtc21d1PjKo/QzHcl49VyjBaBa2pXheNA3c9UxAJ9f40QUVzpCfj7z3TOm5
         mMAg==
X-Forwarded-Encrypted: i=1; AJvYcCWjEq1vvqbP5NwEjSiJHEPrzHdElDfWkabKbUY2YCxkJokX/wOYec7YIQ0gfJTky/Zxt5Ok+bg7D4X7c/w=@vger.kernel.org
X-Gm-Message-State: AOJu0YxX/U7U7TVgIv1oI7oRMJTmC04NedcosTbPNZ2fstiKr1Sc0Vnv
	MkjY2wNR0CDjIioudRvDE9SpMjUqcVMGKJ6b/82s0txWsjo8EfQmtvxqgIDXhS2kcdoLGxx7M0Z
	ynf+Wb029E01B3fjyFSkgDOilbIbBUQMSWB1b
X-Gm-Gg: ASbGncvBOR6AsKKgiLkit1amP0Wk1l9C19CpyXrUpXPyl3C5SZkBELM9XP96cfpAXMI
	K2+B98DkU4SXaBb1kKGzNVOvshqPZGFw1mjX4C7+JmXT8c1AUHDzWNfP0f7zXcsM=
X-Google-Smtp-Source: AGHT+IH+pqRdAphMkhb+luRB44r6bMNk9ISZ0EBRdYi0HWpiCxWijfTal5pLT+eibz9N193imWzcDdOEn3SXagF4YGA=
X-Received: by 2002:a05:6e02:1c29:b0:3a0:a224:eb2c with SMTP id
 e9e14a558f8ab-3a6e7a6de76mr736005ab.25.1730914150297; Wed, 06 Nov 2024
 09:29:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241022174838.449862-1-irogers@google.com> <20241022174838.449862-2-irogers@google.com>
 <ZxmHOkp1USQCujM-@google.com>
In-Reply-To: <ZxmHOkp1USQCujM-@google.com>
From: Ian Rogers <irogers@google.com>
Date: Wed, 6 Nov 2024 09:28:58 -0800
Message-ID: <CAP-5=fXTiHY6-Tb5kLGxQq7MGmW_qQpM9ZYV3Oaz=hyfw0sxYg@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] perf test: Skip annotate test for sanitizer builds
To: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	Thomas Richter <tmricht@linux.ibm.com>, James Clark <james.clark@linaro.org>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 23, 2024 at 4:31=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> =
wrote:
>
> On Tue, Oct 22, 2024 at 10:48:38AM -0700, Ian Rogers wrote:
> > Symbols vary and the test breaks.
> >
> > Closes: https://lore.kernel.org/lkml/CAP-5=3DfU04PAN4T=3D7KuHA4h+po=3Do=
Ty+6Nbee-Gvx9hCsEf2Lh0w@mail.gmail.com/
> > Signed-off-by: Ian Rogers <irogers@google.com>
> > ---
> >  tools/perf/tests/shell/annotate.sh | 6 ++++++
> >  1 file changed, 6 insertions(+)
> >
> > diff --git a/tools/perf/tests/shell/annotate.sh b/tools/perf/tests/shel=
l/annotate.sh
> > index 1590a37363de..199f547e656d 100755
> > --- a/tools/perf/tests/shell/annotate.sh
> > +++ b/tools/perf/tests/shell/annotate.sh
> > @@ -4,6 +4,12 @@
> >
> >  set -e
> >
> > +if perf check feature -q sanitizer
> > +then
> > +  echo "Skip test with sanitizers due to differing assembly code"
>
> I don't think it's because of different assembly code.
> It should be the return value from ASAN leak detector.
>
> Maybe we can enable it using "ASAN_OPTIONS=3Ddetect_leaks=3D0"?
> Probably with a comment that mentions we don't call
> perf_session__delete() in perf annotate for a performance reason.

So doing things like not deleting things for performance reasons is
okay but should be guarded by an "#ifndef NDEBUG" or worse case
"#ifndef LEAK_SANITIZER", not always be on. The comment about a
performance optimization belongs there. We should be trying to avoid
disabling sanitizers in tests as otherwise we're missing the benefits
of sanitizers. I'll see if doing this can to avoid the test skipping.
It'd be nice if other people tested with sanitizers. I think we still
want the features for if we get other issues in the future.

Thanks,
Ian

