Return-Path: <linux-kernel+bounces-177946-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 431758C468E
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 19:57:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EBF04280ECD
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 17:57:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B6A629D05;
	Mon, 13 May 2024 17:57:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="Z3/55x4T"
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3B8B374F1
	for <linux-kernel@vger.kernel.org>; Mon, 13 May 2024 17:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715623056; cv=none; b=DlL7ZGQgQc+RPflITO7Efcafq76SAjyaei4YcAq9GVQT6muJVW8hMu+xXipv1F1XJ5vn/J5xb0z6ZapEoqnKBOWMQyDZ3zQHSpen59QmawDNWfUEzVuaBMq2F4+Ue6+2bt+NjCfTbPwRSMlU6731Yyy3YTodOkINrGEgvsNOwZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715623056; c=relaxed/simple;
	bh=bgnQB6pDQ1o6NMmJUotHEuCPzygOqv3kv/whAgKaXYQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OM88/p+zwi/HsfL2GtfFfXNW6paWrB9kATduV/SsURu+XqII2G8VzOmCJlXiZAv63Nh3qtEPbuyXEUZNDu8t7+XbTrpTQ/U8WtC9oQXBqtgzAdITkLUxrlTKHHY/q89k8my/DPzQKbu5K0Tld3mqNkWgis3aMhuVuIvLpB0Ykhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Z3/55x4T; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-43df9ac3ebcso807021cf.0
        for <linux-kernel@vger.kernel.org>; Mon, 13 May 2024 10:57:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715623054; x=1716227854; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LBCsqGYM5KicJoYZjjkcCVARmL8Eh32Kqb22e3nbOs0=;
        b=Z3/55x4TgZOm/dwiEVhE5KgiaTDtUbxMrtzHlyjyXWMB16KV9JX2CRV6a4fWJFPTR4
         pSyx7TUqI+CqIcNb6uINnlrWKBfVoVGwlG//fadiLbuzBMOyDMcE5Cp3cIIyydqZMDnZ
         QjKgZ2pc4ts31i1mmxFktnAs7V3M8bAHHxpbvWs6HgrxNfjCNBQU0ZwjtPahIgF9n+KN
         JT6SGL+B9YeCdpfnUVa/IwSztn3Rvyt8RTGkek2DpmVYYdmXOWCO8x8kTCQC76QltcGL
         hirksxPJlVT0RdvsBc1UbHtV357FVKNUJETwOF0Cf19kaCYaz/6svhc4XVyoGKI9KYS8
         Hunw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715623054; x=1716227854;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LBCsqGYM5KicJoYZjjkcCVARmL8Eh32Kqb22e3nbOs0=;
        b=Xw+AuB7lUuUjggaksh8GS3RPgn8lZIV6ybRuo3gODWlCCmWtn5dGf4F5RQyJ7vXGzQ
         N1Fii4/Tuki+URzsX1asodc3Ltd/d07BGlIBBi0NJIg8AYmUsWEMhoA6hQe5krt0Bpln
         PrS4Z1FpvGyBNKxSkAmwIM3mi6iNjKX1cf1tzhBxzxvY0xiQY0zrOWMJO1oFbhS5LoEo
         mhxY9mDmOceu0ViC5TohbHvqHKvgKpcIX1oFDvElz6s0zAO7Hd9Q8FJIR0q+P5Q6H4fN
         6CRrcoP0IV4QyCbB7+xx34FX70u2NKcZHiKCSZz4jQUe0bxxc7XtFXfWhaGEDgKERIbD
         KRpg==
X-Forwarded-Encrypted: i=1; AJvYcCWGZJ9yQTOUuR9mg+LmNU076IAUGRukyB2y+kEG7b8yEII8b1gN9pgpkx+KIiP+Z5KyFWdQgb88eT743rzP5BN9ME3bItVo1+2n7cQL
X-Gm-Message-State: AOJu0YzLg3LHdKe1Rh9HMW/1osK5MvyuuFm5EIaDZBvxfCWb0a7voWwT
	z+VU6tyoTGY8H86Kbrw7l5H/c3uoR81gXqXaKyZ0Cl7q3O09zO+D8WG2gUDa0YCg13DQbwQfUir
	e8z09L19GoU3y2htMsgJl52JtN9Gd1xd5eaJj
X-Google-Smtp-Source: AGHT+IGV1CJCJRDtrd8AlAO7lzQmHi37OM/lEj/wh3mYpOPPwfuF5+C4ZSmUB0UGlCpCmiSWnyVdoFsyuOOEGt8u8dU=
X-Received: by 2002:a05:622a:5a8c:b0:43a:db8d:4a22 with SMTP id
 d75a77b69052e-43e0a1c21aemr6639491cf.11.1715623053572; Mon, 13 May 2024
 10:57:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240506081648.3890067-1-yangjihong@bytedance.com>
 <CAP-5=fXYH4JnfQH98vPRttViBfYAWGA-aoGXO7q+R_Wt8AqFSw@mail.gmail.com> <a476b77f-4d7d-4dbb-b58f-cfc39c07e91e@bytedance.com>
In-Reply-To: <a476b77f-4d7d-4dbb-b58f-cfc39c07e91e@bytedance.com>
From: Ian Rogers <irogers@google.com>
Date: Mon, 13 May 2024 10:57:22 -0700
Message-ID: <CAP-5=fU732_JAn6k24+NfbHReV9uFVSNztJn+g_u+yx94nbaZg@mail.gmail.com>
Subject: Re: [PATCH] perf build: Specify libtraceevent dir to rpath for
 asan/msan build
To: Yang Jihong <yangjihong@bytedance.com>
Cc: peterz@infradead.org, mingo@redhat.com, acme@kernel.org, 
	namhyung@kernel.org, mark.rutland@arm.com, alexander.shishkin@linux.intel.com, 
	jolsa@kernel.org, adrian.hunter@intel.com, kan.liang@linux.intel.com, 
	james.clark@arm.com, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 13, 2024 at 12:53=E2=80=AFAM Yang Jihong <yangjihong@bytedance.=
com> wrote:
>
> Hello,
>
> On 5/9/24 07:18, Ian Rogers wrote:
> > On Mon, May 6, 2024 at 1:17=E2=80=AFAM Yang Jihong <yangjihong@bytedanc=
e.com> wrote:
> >>
> >> perf built by asan/msan will not search for shared libraries in the
> >> -L directory. For cross-compilation, we assume that sanitizers is
> >> generally not enabled and add libtraceevent dir to rpath in a simple w=
ay.
> >>
> >> 1. msan build
> >>
> >> Before:
> >>    $ make -C tools/perf O=3D/tmp/perf DEBUG=3D1 EXTRA_CFLAGS=3D"-O0 -g=
 -fno-omit-frame-pointer -fsanitize=3Dmemory -fsanitize-memory-track-origin=
s" CC=3Dclang CXX=3Dclang++ HOSTCC=3Dclang NO_LIBELF=3D1 BUILD_BPF_SKEL=3D0=
 NO_LIBPFM=3D1 LIBTRACEEVENT_DIR=3D/opt/libtraceevent
> >>    ...
> >>    $ /tmp/perf/perf
> >>    /tmp/perf/perf: error while loading shared libraries: libtraceevent=
so.1: cannot open shared object file: No such file or directory
> >>
> >> After:
> >>    $ make -C tools/perf O=3D/tmp/perf DEBUG=3D1 EXTRA_CFLAGS=3D"-O0 -g=
 -fno-omit-frame-pointer -fsanitize=3Dmemory -fsanitize-memory-track-origin=
s" CC=3Dclang CXX=3Dclang++ HOSTCC=3Dclang NO_LIBELF=3D1 BUILD_BPF_SKEL=3D0=
 NO_LIBPFM=3D1 LIBTRACEEVENT_DIR=3D/opt/libtraceevent
> >>    ...
> >>    $ /tmp/perf/perf --build-options
> >>    perf version 6.9.0-rc5
> >>    <SNIP>
> >>             libtraceevent: [ on  ]  # HAVE_LIBTRACEEVENT
> >>    <SNIP>
> >>
> >>   2. asan build
> >>
> >> Before:
> >>    $ make DEBUG=3D1 EXTRA_CFLAGS=3D'-fno-omit-frame-pointer -fsanitize=
=3Daddress' LIBTRACEEVENT_DIR=3D/opt/libtraceevent
> >>    ...
> >>    $ ./perf
> >>    ./perf: error while loading shared libraries: libtraceevent.so.1: c=
annot open shared object file: No such file or directory
> >>
> >> After:
> >>     $ make DEBUG=3D1 EXTRA_CFLAGS=3D'-fno-omit-frame-pointer -fsanitiz=
e=3Daddress' LIBTRACEEVENT_DIR=3D/opt/libtraceevent
> >>     ...
> >>     $ ./perf --build-options
> >>     perf version 6.9.0-rc5
> >>     <SNIP>
> >>              libtraceevent: [ on  ]  # HAVE_LIBTRACEEVENT
> >>     <SNIP>
> >>
> >> Signed-off-by: Yang Jihong <yangjihong@bytedance.com>
> >> ---
> >>   tools/perf/Makefile.config | 4 ++++
> >>   1 file changed, 4 insertions(+)
> >>
> >> diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
> >> index 7f1e016a9253..a9a923358604 100644
> >> --- a/tools/perf/Makefile.config
> >> +++ b/tools/perf/Makefile.config
> >> @@ -188,6 +188,10 @@ TRACEEVENTLIBS :=3D -ltraceevent
> >>   ifdef LIBTRACEEVENT_DIR
> >>     LIBTRACEEVENT_CFLAGS  :=3D -I$(LIBTRACEEVENT_DIR)/include
> >>     LIBTRACEEVENT_LDFLAGS :=3D -L$(LIBTRACEEVENT_DIR)/lib
> >> +  # Specify rpath for asan/msan build. Generally, cross-compilation w=
ill not enable sanitizers.
> >> +  ifeq ($(findstring -fsanitize=3D,${EXTRA_CFLAGS}),-fsanitize=3D)
> >> +    LIBTRACEEVENT_LDFLAGS +=3D -Wl,-rpath,$(LIBTRACEEVENT_DIR)/lib
> >> +  endif
> >
> > Thanks for this! I found I need the following to make it work:
> > ```
> > diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
> > index a9a923358604..bcf4ab292462 100644
> > --- a/tools/perf/Makefile.config
> > +++ b/tools/perf/Makefile.config
> > @@ -190,7 +190,11 @@ ifdef LIBTRACEEVENT_DIR
> >    LIBTRACEEVENT_LDFLAGS :=3D -L$(LIBTRACEEVENT_DIR)/lib
> >    # Specify rpath for asan/msan build. Generally, cross-compilation
> > will not enable sanitizers.
> >    ifeq ($(findstring -fsanitize=3D,${EXTRA_CFLAGS}),-fsanitize=3D)
> > -    LIBTRACEEVENT_LDFLAGS +=3D -Wl,-rpath,$(LIBTRACEEVENT_DIR)/lib
> > +    ifeq (${IS_64_BIT}, 1)
> > +      LIBTRACEEVENT_LDFLAGS +=3D -Wl,-rpath,$(LIBTRACEEVENT_DIR)/lib64
> > +    else
> > +      LIBTRACEEVENT_LDFLAGS +=3D -Wl,-rpath,$(LIBTRACEEVENT_DIR)/lib
> > +    endif
> >    endif
> > endif
> > FEATURE_CHECK_CFLAGS-libtraceevent :=3D $(LIBTRACEEVENT_CFLAGS)
> > ```
> >
> > My libtraceevent build command is:
> > $ make EXTRA_CFLAGS=3D"-O0 -g -fsanitize=3Daddress" DESTDIR=3D~/libtrac=
e install
> My build environment only uses make, not make install, so the library
> path is lib, not lib64, which leads to this difference.
>
>    # cd /opt/libtraceevent
>    # CROSS_COMPILE=3Daarch64-linux-gnu- make
>
> In order to be compatible with both situations, would it be better for
> us to also add the lib64 path to -L and rpath?
>
> I have sent the v2 version and added it to path2. Please help me see if
> this solution is OK:
> https://lore.kernel.org/all/20240513074910.1660373-1-yangjihong@bytedance=
com/

That fixed the issue for me. Thanks!

Ian

>
> Thanks,
> Yang

