Return-Path: <linux-kernel+bounces-340645-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E64398763B
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 17:08:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA7971F265AF
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 15:08:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 582BB14831C;
	Thu, 26 Sep 2024 15:08:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vMUGnHfj"
Received: from mail-il1-f170.google.com (mail-il1-f170.google.com [209.85.166.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A34FEAD5
	for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 15:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727363317; cv=none; b=dhj1+EVtmHw1hvx0QJpwDbaFAc1u307OYIZeE64xdiCyDpdt28m1zoWmihBzV0ElYzQ+MGDcT9l4j3aBNwKWoHSaiON8Jl28izm+G+hZFmURHs1utuuR+qSuM5xL1pMBP5Q71rVD0vPWemMihxAaUZl+UPcsdqzRUe7BmEK7WgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727363317; c=relaxed/simple;
	bh=JyoyHxKQD9Kwr5fcs+xm/CmkChCRExnaujr9I+wRTUc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=f+TNNKZrMBGdPh6uFqkfiFrJT5eNRwPdI46Y+qOa0r7EZDPsCoHSgDgMFx4hD0TfaI/IGBaKbvC6HcFPmFWVEIAsJF76AiLI86pUxv7pZakBmJk+WCX19KzDUmmBVod/FOD77CJKPo3yhmpEra/B++wbfnA90ZHFHv6xcsOOPnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vMUGnHfj; arc=none smtp.client-ip=209.85.166.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-il1-f170.google.com with SMTP id e9e14a558f8ab-3a1a662a633so293035ab.1
        for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 08:08:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727363315; x=1727968115; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Sqw39FJ5N7iyzE7OldGM0QX15IjljmEHm7ZyQhjns8Q=;
        b=vMUGnHfjxrwmcmrTIgm2FOPDCTxjMtfuohR/TnruAKyrtv8Yyn6pq9cu2WbxvNpiDi
         z0qJcBjMjJHkgwgcyQv7ZfeANyofQ0P+R+OwvoRz1YGsr//q82GLHIVN6yXhO14UNN2B
         ++/plu8WCFQik5lZRlrHBupHF9e6B00H2o8ujvUP4ljAGoLmQS6Q83FPH7zlG6Dp6hTy
         GX5v7CeBTApiH0yD46hRGCjKGKK/ILFx3VrcE8tiwAJ/kihcUKZEVzXYU1EytviWeQpe
         nWsPW3i+/YdPLayjcj1j6Rtxza/HTEA1gnsunfBZ4hkkN4cXm6UAVsjfSZgzGsha+qkw
         AvVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727363315; x=1727968115;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Sqw39FJ5N7iyzE7OldGM0QX15IjljmEHm7ZyQhjns8Q=;
        b=InyqrInaSWAHIEl1JNpjQ42AMN8lj3vjIv5SaLAI1KN9lLwJTil0+uzTO0oTR/wwg3
         UtLVlRTvX7Uj13HH7j2BnnZowqLoA7EFYrpDuskMyBKRY3RwHrAGt/4mLBa34YPSoO20
         8wWD+Hu0F/2kCMggHk4lBbxm3TlvnraiSvWELuNHSLVIPqE1x8M5lrTCc8MC6VnAJdJL
         IVKYAjGqrX8FUSDcGsheVXOR1DKhVGmv9bIeyT/3YjsMmTbPaUZgXoO3wEFo3UJ+SIs4
         G63C29pZNuHq3jHV60fQrKkGSuF+dWiHXAJUYdcOGmMfYEI5Z45IE5rtvCT8AvPQjyHL
         y4kw==
X-Forwarded-Encrypted: i=1; AJvYcCWcTedQ7tmcNWrH7oRbin7vxdvf1nlxfsIPb6jcJdvqdb0LRQo5CDBX1EhlEUrcdAL8d23rr5Cr4JkUc+A=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyj2/qfaI0srO69bgm/dkG/1g10N1wit73uQONXQVfcmwCXkqQy
	dycYrOeI87Y4+OXASzpplDc/5t3HrYAJn1qF/MOPMDEheC1tDEMu1vhYwITrO0ReispX1s9C7RZ
	v1BzICzibDS7RPIWDFGdUUyYYNwX9xaxymg/9
X-Google-Smtp-Source: AGHT+IF9qWP9inTYXeDlp/TQlxeWo7WHjsgYEXiJOQnoVVcu9AxstnMs++Fq3OP8K7LV8MxYBc4EhVYOhRFAIdUYH3U=
X-Received: by 2002:a05:6e02:b28:b0:3a0:926a:8d35 with SMTP id
 e9e14a558f8ab-3a31b665b0amr3914595ab.17.1727363314902; Thu, 26 Sep 2024
 08:08:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240924160418.1391100-1-irogers@google.com> <20240924160418.1391100-8-irogers@google.com>
 <ZvSrAv_6NUOVWJdD@google.com>
In-Reply-To: <ZvSrAv_6NUOVWJdD@google.com>
From: Ian Rogers <irogers@google.com>
Date: Thu, 26 Sep 2024 08:08:22 -0700
Message-ID: <CAP-5=fWvCoDx66xJhZ+bB0jC4tYOjqZh=jCf+APNg+hGvfyMbA@mail.gmail.com>
Subject: Re: [PATCH v1 07/11] perf probe: Move elfutils support check to libdw check
To: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	John Garry <john.g.garry@oracle.com>, Will Deacon <will@kernel.org>, 
	James Clark <james.clark@linaro.org>, Mike Leach <mike.leach@linaro.org>, 
	Leo Yan <leo.yan@linux.dev>, Guo Ren <guoren@kernel.org>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Nick Terrell <terrelln@fb.com>, 
	Guilherme Amadio <amadio@gentoo.org>, Changbin Du <changbin.du@huawei.com>, 
	"Steinar H. Gunderson" <sesse@google.com>, "Masami Hiramatsu (Google)" <mhiramat@kernel.org>, 
	Aditya Gupta <adityag@linux.ibm.com>, Athira Rajeev <atrajeev@linux.vnet.ibm.com>, 
	Masahiro Yamada <masahiroy@kernel.org>, Huacai Chen <chenhuacai@kernel.org>, 
	Bibo Mao <maobibo@loongson.cn>, Kajol Jain <kjain@linux.ibm.com>, 
	Anup Patel <anup@brainfault.org>, Shenlin Liang <liangshenlin@eswincomputing.com>, 
	Atish Patra <atishp@rivosinc.com>, Oliver Upton <oliver.upton@linux.dev>, 
	Chen Pei <cp0613@linux.alibaba.com>, Dima Kogan <dima@secretsauce.net>, 
	Alexander Lobakin <aleksander.lobakin@intel.com>, "David S. Miller" <davem@davemloft.net>, 
	Przemek Kitszel <przemyslaw.kitszel@intel.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, Yang Jihong <yangjihong@bytedance.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 25, 2024 at 5:30=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> =
wrote:
>
> On Tue, Sep 24, 2024 at 09:04:14AM -0700, Ian Rogers wrote:
> > The test _ELFUTILS_PREREQ(0, 142) is false for elfutils before
> > 2009-06-13, but that is 15 years ago and very unlikely. Add a test to
> > test-libdw.c and assume the libdw version is at least 0.142 to
> > simplify the build logic.
> >
> > Signed-off-by: Ian Rogers <irogers@google.com>
> > ---
> >  tools/build/feature/test-libdw.c | 10 +++++++++-
> >  tools/perf/util/probe-finder.c   |  2 --
> >  tools/perf/util/probe-finder.h   |  2 --
> >  3 files changed, 9 insertions(+), 5 deletions(-)
> >
> > diff --git a/tools/build/feature/test-libdw.c b/tools/build/feature/tes=
t-libdw.c
> > index 71c6f8e3b0ee..2fb59479ab77 100644
> > --- a/tools/build/feature/test-libdw.c
> > +++ b/tools/build/feature/test-libdw.c
> > @@ -41,8 +41,16 @@ int test_libdw_getcfi(void)
> >       return dwarf_getcfi(dwarf) =3D=3D NULL;
> >  }
> >
> > +int test_elfutils(void)
> > +{
> > +     Dwarf_CFI *cfi =3D NULL;
> > +
> > +     dwarf_cfi_end(cfi);
> > +     return 0;
> > +}
>
> I think it's the same as test_libdw_getcfi() and let's get rid of it.

The point of doing the change this way, and I think what's being
ignored, is that I am trying to simply replace an #if with a clearly
equivalent feature test - clearly equivalent as the #if guards use of
dwarf_cfi_end in the code. Merging test_elfutils with
test_libdw_getcfi is another cognitive step and I think it is fine as
follow up cleanup. Combining that step with the change here fails the
minimal meaningful change and tbh I think this is just bike shedding.

Thanks,
Ian

> Thanks,
> Namhyung
>
> > +
> >  int main(void)
> >  {
> >       return test_libdw() + test_libdw_unwind() + test_libdw_getlocatio=
ns() +
> > -            test_libdw_getcfi();
> > +            test_libdw_getcfi() + test_elfutils();
> >  }
> > diff --git a/tools/perf/util/probe-finder.c b/tools/perf/util/probe-fin=
der.c
> > index 78f34fa0c391..7434b38596b9 100644
> > --- a/tools/perf/util/probe-finder.c
> > +++ b/tools/perf/util/probe-finder.c
> > @@ -1379,10 +1379,8 @@ int debuginfo__find_trace_events(struct debuginf=
o *dbg,
> >       if (ret >=3D 0 && tf.pf.skip_empty_arg)
> >               ret =3D fill_empty_trace_arg(pev, tf.tevs, tf.ntevs);
> >
> > -#if _ELFUTILS_PREREQ(0, 142)
> >       dwarf_cfi_end(tf.pf.cfi_eh);
> >       dwarf_cfi_end(tf.pf.cfi_dbg);
> > -#endif
> >
> >       if (ret < 0 || tf.ntevs =3D=3D 0) {
> >               for (i =3D 0; i < tf.ntevs; i++)
> > diff --git a/tools/perf/util/probe-finder.h b/tools/perf/util/probe-fin=
der.h
> > index 3add5ff516e1..f0149d72310c 100644
> > --- a/tools/perf/util/probe-finder.h
> > +++ b/tools/perf/util/probe-finder.h
> > @@ -63,12 +63,10 @@ struct probe_finder {
> >       struct intlist          *lcache;        /* Line cache for lazy ma=
tch */
> >
> >       /* For variable searching */
> > -#if _ELFUTILS_PREREQ(0, 142)
> >       /* Call Frame Information from .eh_frame */
> >       Dwarf_CFI               *cfi_eh;
> >       /* Call Frame Information from .debug_frame */
> >       Dwarf_CFI               *cfi_dbg;
> > -#endif
> >       Dwarf_Op                *fb_ops;        /* Frame base attribute *=
/
> >       unsigned int            machine;        /* Target machine arch */
> >       struct perf_probe_arg   *pvar;          /* Current target variabl=
e */
> > --
> > 2.46.0.792.g87dc391469-goog
> >

