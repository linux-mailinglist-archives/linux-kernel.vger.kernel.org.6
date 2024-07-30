Return-Path: <linux-kernel+bounces-267917-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 199BA941BC6
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 18:58:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 98E431F238E8
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 16:58:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 228EF189918;
	Tue, 30 Jul 2024 16:58:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jl9l2M87"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B0791898ED
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 16:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722358731; cv=none; b=PTd65n2gQt0EvxKleXcI2o30eYg6LNn9Er6GfQDu4BqYaCon7x1jMrOCwsaHgJ0xsZGO9M4Kxcctai6gl/Jzg+gMfGQdBJh3ySaAdweqzTbjGClSa7//+xXsJkQabNaWF3DlncaHrpXFgIw81ku88e4coMMePj28+/qoiWrY8Uc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722358731; c=relaxed/simple;
	bh=MakCGp2MWoAV0Xc0eI7OesuYOc4aL/IhFc+YGoVClfU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aVzwRWQIPDXugR+HG6SndAV3p9sjSUdl5uEkF4WRFtJIb2wxdHNLSi91S3CdTmrfDsSSgEHpg4Bag9dnSIab5FL30azcHW0gZ7D+GLoufV3ZIa8a6zlWR+qdWKw4kLVYYPVaCUEOUe+BVHumm4ynEKp32utlI61su48j3Lym1/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jl9l2M87; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1fd657c9199so2335ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 09:58:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1722358729; x=1722963529; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RVx5Mo1cNi2O2SneJHVsg+dKHPp4XLpaPWsYQ7yBQn4=;
        b=jl9l2M87d/q5Ua7i0XjNUaTg+HCoNtS9kGbINJ/rlkQIPlQO5/Gf3Qv16MEc4tzJIf
         5CW3b6r5nMFjt0B8WOI27SC5MluCZM+Zk5jkzn3yYq1k6wuvdVY+Lvem3jJA32HmADkS
         ldmc2dIyjo/zZ2jZ6MrnzaBfURsaIEIMPG1F/FQbQUoenWhmVWjxf2LO9zoo8SNjK9qU
         YS79aAGlIFeQoIxHyN/T90066JTGM1g9rwUtTDmBEqB16/nhguDvkJ5s8iWmiaRIG3Ok
         2TLrt8CUQxc5I5K97rDQMJYod5IjRnzwjxten3T0lrX7fex3XaxtsidpPAulKiMz/fPw
         y1BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722358729; x=1722963529;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RVx5Mo1cNi2O2SneJHVsg+dKHPp4XLpaPWsYQ7yBQn4=;
        b=bQpl4j6sW86rKR6bVcH6k2aNPWH/DwSE2e/FxkEtqkfdoppxJqaFX/iBW3Sx8T9QPH
         cq2SuHVvnpBKCiM68Gg8naJ3SqLopVDhzPr2mPRIO0mtV+/ybCnk/oQ0tfkkx1OSGUtx
         v9xGCEd7bPDpBZ1RtizFbWLFu/DE39k+eI/KTNgCJyMu5goj2j4PcIuZoEjSWSoxVs2U
         FE5r6d/UabxA4lRPgOKbKqBrh0Jiw8INoaDnzGZTociUYQbOr+AXU0+TmtYMTxOJu8OU
         iWoA5DDdaKuBNpFXOrI9s5KeeCMyAzqLDgUcrSAOMh12iJDLkdRxo11kcuMFzSXEKxyF
         zM/Q==
X-Forwarded-Encrypted: i=1; AJvYcCXKDrA5Li2kRFLWUGryYSc2UxrIEmnukoMvOK2bKu6wsisHTJfKszj6DuHns+15fBgekBcMl2A6n1BkLiOoj2+c5T+Z6yjIxpfcecFJ
X-Gm-Message-State: AOJu0Yz8ZiDDNLKTf6LsDssgynwAvRveJUgsqEYWC73fzAHJMRm698EH
	p7KZzAPQ2VvPkQqefcEm7MqWqcoGQ9rhZi9qFlgPZf8NRYG5YWSl4e2N0o8n8YB4ELbPYgQ5f7e
	FWrNA2FHjSXg8f+FcwoL3QVIHZIjLABsrknRQ
X-Google-Smtp-Source: AGHT+IHWa3ie9Q2PNThh8ofQ9H8dtp0S/XjFcJgO/021VlJ48CH8lxwBbO7gPRgQ4MD6TOY1mSNEoi6JZ+e8wyYUvxs=
X-Received: by 2002:a17:902:e546:b0:1fb:172a:f3d4 with SMTP id
 d9443c01a7336-1ff3784b8abmr3152005ad.8.1722358728382; Tue, 30 Jul 2024
 09:58:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240729181931.2870851-1-irogers@google.com> <ZqkWoQEyJcU5xBZG@google.com>
In-Reply-To: <ZqkWoQEyJcU5xBZG@google.com>
From: Ian Rogers <irogers@google.com>
Date: Tue, 30 Jul 2024 09:58:27 -0700
Message-ID: <CAP-5=fUcuG7M6R80uwviwP2j62KDceDRRQM=Qf721bPBK1KYWg@mail.gmail.com>
Subject: Re: [PATCH v2] perf cap: Tidy up and improve capability testing
To: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	James Clark <james.clark@arm.com>, Oliver Upton <oliver.upton@linux.dev>, 
	Leo Yan <leo.yan@linux.dev>, Changbin Du <changbin.du@huawei.com>, 
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 30, 2024 at 9:36=E2=80=AFAM Namhyung Kim <namhyung@kernel.org> =
wrote:
>
> On Mon, Jul 29, 2024 at 11:19:31AM -0700, Ian Rogers wrote:
> > Remove dependence on libcap. libcap is only used to query whether a
> > capability is supported, which is just 1 capget system call.
> >
> > If the capget system call fails, fall back on root permission
> > checking. Previously if libcap fails then the permission is assumed
> > not present which may be pessimistic/wrong.
> >
> > Add a used_root out argument to perf_cap__capable to say whether the
> > fall back root check was used. This allows the correct error message,
> > "root" vs "users with the CAP_PERFMON or CAP_SYS_ADMIN capability", to
> > be selected.
> >
> > Tidy uses of perf_cap__capable so that tests aren't repeated if capget
> > isn't supported, to reduce calls or refactor similar to:
> > https://lore.kernel.org/lkml/20240729004127.238611-3-namhyung@kernel.or=
g/
>
> I'm not familiar with the capability so it's hard to review the code but
> it'd be better to split the code for perf_cap__capable() and its usage.

There's an API change, passing the out arg if root checking was used,
so this would turn into a mess.

> > ---
> > v2: fix syscall number and '>' should have been '>=3D'
> >
> > Signed-off-by: Ian Rogers <irogers@google.com>
> > ---
> >  tools/perf/Makefile.config  | 11 -------
> >  tools/perf/builtin-ftrace.c | 44 ++++++++++++--------------
> >  tools/perf/util/Build       |  2 +-
> >  tools/perf/util/cap.c       | 63 ++++++++++++++++++++++++++-----------
> >  tools/perf/util/cap.h       | 23 ++------------
> >  tools/perf/util/symbol.c    |  8 ++---
> >  tools/perf/util/util.c      | 12 +++++--
> >  7 files changed, 81 insertions(+), 82 deletions(-)
[snip]
> > --- a/tools/perf/util/cap.c
> > +++ b/tools/perf/util/cap.c
[snip]
> > +bool perf_cap__capable(int cap, bool *used_root)
> > +{
> > +     struct __user_cap_header_struct header =3D {
> > +             .version =3D _LINUX_CAPABILITY_VERSION_3,
> > +             .pid =3D getpid(),
> > +     };
> > +     struct __user_cap_data_struct data[MAX_LINUX_CAPABILITY_U32S];
> > +     __u32 cap_val;
> > +
> > +     *used_root =3D false;
> > +     while (syscall(SYS_capget, &header, &data[0]) =3D=3D -1) {
> > +             /* Retry, first attempt has set the header.version correc=
tly. */
> > +             if (errno =3D=3D EINVAL && header.version !=3D _LINUX_CAP=
ABILITY_VERSION_3 &&
> > +                 header.version =3D=3D _LINUX_CAPABILITY_VERSION_1)
>
> It seems you can just check it with _VERSION1.

Similarly not familiar. Basically there used to be a data struct of 3
u32s in v1, v2 shouldn't exist, v3 turned the data from an array of
structs of size [1] to [2]. v3 has been present for 16 years as shown
by its magic number 0x20080522 (v2.6.26 iirc - can't find the comment
again). It seems a pretty safe bet that v3 is the version being used.
In old kernels if the versions don't match they just return EINVAL and
you have to try again like this loop:
https://fossd.anu.edu.au/linux/v2.6.14/source/kernel/capability.c#L43
```
if (get_user(version, &header->version))
  return -EFAULT;

if (version !=3D _LINUX_CAPABILITY_VERSION) {
  if (put_user(_LINUX_CAPABILITY_VERSION, &header->version))
    return -EFAULT;
   return -EINVAL;
}
```
So testing v3 is almost certainly what we want, what's going to work
and avoids a loop. In newer kernels the EINVAL isn't returned for a
mismatch and the code just does the right thing for whatever version
is requested.

> But I'm not sure about what this code does.  Who set the version
> correctly?  Is there any chance for an infinite loop?

The system call could return EINVAL with _LINUX_CAPABILITY_VERSION_1
and set the header.version to _LINUX_CAPABILITY_VERSION_1 again and
return EINVAL again, the kernel would be broken but it would lead to
an infinite loop.

Thanks,
Ian

