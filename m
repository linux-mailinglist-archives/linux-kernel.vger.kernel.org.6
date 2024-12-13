Return-Path: <linux-kernel+bounces-445335-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A7F429F14BF
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 19:11:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C7A41162843
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 18:11:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A869D1E570B;
	Fri, 13 Dec 2024 18:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2I3KG5UE"
Received: from mail-il1-f175.google.com (mail-il1-f175.google.com [209.85.166.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 364B51E47BD
	for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 18:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734113448; cv=none; b=sEj9HhnlyJkBZGb2fktZhfnu/B0n2kzYSONK/1tUM6HDPh5/8ABA3ZkIacrTjrmbXFd1boFzwThnJtrAqSFf0hg2nNo7HInNcAvCWaFVnWieoGGzA158q+pexCjVhY3/+aBR3sgGeF5EbuL8mTTcG1YUCgAMRScwOG+n9NXe66Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734113448; c=relaxed/simple;
	bh=k0DPfjVaCNtHadVi817LIPEFiQPVpOq0Rk4KDTJHK1I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rf/rtbOYn783t2VHzyck/JZpzwdSE4cAF3G7z/o8FbxM+EElMvEZ5AaoNcCAIk6mNqGG642O+IXgOUasdr8kAZdcrfXDwMF0mhxzm9yN2crsRTwzJsDL/3uIHZyjX6sVKD3iopMMjVBU0UDC0jTiMpWD2z2W2zvphTbMXZELa+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2I3KG5UE; arc=none smtp.client-ip=209.85.166.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-il1-f175.google.com with SMTP id e9e14a558f8ab-3a815a5fb60so5485ab.0
        for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 10:10:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1734113444; x=1734718244; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b+hgaeTwc969Xr5cJMWCHi4YypA6NV2JJFX5XRvZhe0=;
        b=2I3KG5UEnCqmDXsgINIdqhTexwpAa777w+mBS1ayCxu5SVkU2DKqaJ3ysZAK9j7tbI
         95ATsD9+gk1tLR+4ldGrZa49qgwHBZqHF/E2tkZAohUGo/ooPPkLChewZ/m/N8z/7GUo
         m/aJYJRq4Fewv3a+PVVnVSs59Oo3RZPVAMPQXTAU6tUYEOyiQ69+zZ9dwmyXlw6jex9+
         aqT+XbR8geOoTy6kPqMC48jtSizRIVKxPGoaZY5ATfD9UlxaPRVmCNAIlIaaE8YASfwD
         xnEXv8rIcPV9XnrLUisD1wK1ktoeHO3VkHrif2NiQ361pTmGjrH6+Aj1MIMfpzUgduko
         CZHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734113444; x=1734718244;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b+hgaeTwc969Xr5cJMWCHi4YypA6NV2JJFX5XRvZhe0=;
        b=i++OhzCmyT6Err0/5ryJz0eVXbXIr3csBQ2KE+dhWk5IKxGQoOmVehfqG1+dzGrfFm
         NCxdFMGkdixaRvlqW4cayHKQLJBWVH19HbJlfjQLo3GDmSUMbDt7iCfC+iQzyYfsemf7
         9xkncJBZU5iIQe6vS4ry8JlkCjZuyELi75hnttTRqo/PvN+6mGaOS/xPeKX80RpiyIyb
         rz0mjAUSMElBKsTK6UaP/ARyGLQgrYlzcDJCu0dRkIK/ldWjvpXEQNOn2nW/xGHHc785
         XqximHqpC86MLNwvqJuT97TYUh/GCV894NbcIZas0MMSkLYajE3iC+0pB0NN0AM5yjiz
         0njQ==
X-Forwarded-Encrypted: i=1; AJvYcCUrLhOcXUMKZB38BlqWdPlXBiOTpz8ZUp5J42pgonBeqiHaWm01+1IJ29I7PDgZC/o5vfKNkUPjlCsXtTo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz597o18v4DtMSxgADOJP77BQznKqnsoZDSdgJJmYaVcjqyGZg/
	6TVfJdiDwXbz0a0tyA7WSdXFJLXj7Yl53EPips0oaskJtxBfSJVdewj6qYjJeOTfKsGHhyofqAM
	pSI95ucLY70WAQhfYagwLemWYmsIRxM83X0bQnLIhpdRZUXlgJu+f+2Y=
X-Gm-Gg: ASbGncv1nya0/y5csM+eCR+xwVC41MVVLXmc1jMse4tOvcpVS438w1qRG6S3dm9I4BD
	e3n5uW6vr0rB0EdfaJQXoHBzcu2dV1SboZ08lFBU=
X-Google-Smtp-Source: AGHT+IEpXVdotD7gPTZpVvNm6rDcuEI9+VbTUTPpjI0rSnYDYqUNwhT6bqW+G6X28rCmH0gCHBryuHlavZreyLNczUQ=
X-Received: by 2002:a05:6e02:20e5:b0:3a7:ddbb:1b19 with SMTP id
 e9e14a558f8ab-3b0290a08a1mr2949455ab.27.1734113444146; Fri, 13 Dec 2024
 10:10:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <Z1x3o0YoeZS2kQzr@x1>
In-Reply-To: <Z1x3o0YoeZS2kQzr@x1>
From: Ian Rogers <irogers@google.com>
Date: Fri, 13 Dec 2024 10:10:32 -0800
Message-ID: <CAP-5=fVBrssdqwz0YiJ9snKgEJSiAhMVpZcP=sNr6gGEwhMUsA@mail.gmail.com>
Subject: Re: [PATCH 1/1 next] perf tests switch-tracking: Set this test to run exclusively
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, Jiri Olsa <jolsa@kernel.org>, 
	Kan Liang <kan.liang@linux.intel.com>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 13, 2024 at 10:06=E2=80=AFAM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> This test was failing when run with the default 'perf test' mode, which
> is to run multiple regression tests in parallel.
>
> Since it checks system_wide mode, set it to run in exclusive mode.
>
> Cc: Adrian Hunter <adrian.hunter@intel.com>
> Cc: Ian Rogers <irogers@google.com>
> Cc: James Clark <james.clark@linaro.org>
> Cc: Jiri Olsa <jolsa@kernel.org>
> Cc: Kan Liang <kan.liang@linux.intel.com>
> Cc: Namhyung Kim <namhyung@kernel.org>
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> ---
>  tools/perf/tests/switch-tracking.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
>
> diff --git a/tools/perf/tests/switch-tracking.c b/tools/perf/tests/switch=
-tracking.c
> index 5cab17a1942e67d7..88a03bcbecb2b11f 100644
> --- a/tools/perf/tests/switch-tracking.c
> +++ b/tools/perf/tests/switch-tracking.c
> @@ -583,4 +583,11 @@ static int test__switch_tracking(struct test_suite *=
test __maybe_unused, int sub
>         goto out;
>  }
>
> -DEFINE_SUITE("Track with sched_switch", switch_tracking);
> +struct test_case tests__switch_tracking[] =3D {
> +        TEST_CASE_EXCLUSIVE("Track with sched_switch", switch_tracking),
> +        {       .name =3D NULL, }
> +};
> +struct test_suite suite__switch_tracking =3D {
> +        .desc =3D "Track with sched_switch",
> +        .test_cases =3D tests__switch_tracking,
> +};

With Ravi's change:
https://lore.kernel.org/lkml/20241210093449.1662-10-ravi.bangoria@amd.com/
This could be s/DEFINE_SUITE/DEFINE_SUITE_EXCLUSIVE/ , wdyt?

Thanks,
Ian

