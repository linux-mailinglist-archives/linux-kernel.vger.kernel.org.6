Return-Path: <linux-kernel+bounces-266054-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AB89393F9E2
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 17:54:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BD9191C21B47
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 15:54:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E457C15A87C;
	Mon, 29 Jul 2024 15:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oxv/F4LL"
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A1051598EE
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 15:54:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722268443; cv=none; b=Y+VElernELBJMoBhVYwuARfKHK6wkUyJRRhpWwOhVQ+W4iiCtcgfySZDnMpAP2sVga1M/1PdpnvWEQZwm6Y1vSUXF/NUVPuTFdQkaDqQdEh7yGtV7aGMJvaj+5YxLHWJrV1MhyTckr1WyHv69XdGddyWVm8v7BhPxmjm05MwI7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722268443; c=relaxed/simple;
	bh=vit//5frB+Bxo4uCQ9TaphFpIjNsNOImUZUDRYyDM/I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=X2czSC44Gh3wckhUTElAcp5S01oVYVCaOGAocwnTANjDP4rM7yHSTSA9VufpLDcCmgHHS3fCOw9W4KI2ZQXIdw+1yMQSja9Dfd31unuNcF0L63m6JK39CwQQYJxRVuP2tqrKRKlq5/MEKTLdy/hgtjWM1RvB3sawR6fU+31mMEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=oxv/F4LL; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-44fe76fa0b8so402841cf.0
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 08:54:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1722268440; x=1722873240; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G7NVQIGmQXJU9zMY7yOvP9B85E2qvUl+m8Pl4MaC7co=;
        b=oxv/F4LLxy+vbJLTZDaX/oqMNYAmd9nPH/gfq/uEWK4IW/BDclXna8qBS8gsmmkWAD
         9DXQH7/J8cS2NLjAAcg6NyyPPVd45ucO/z1f425miSfV7CLxCsA1h+zXvRLDBoV0TaG0
         tZ2JpbvrbFV57Z0xIV5lAOCV2BQKxhdbmMTSegslJ8XLMS52hgtMwChQkc7pd8GojCoD
         EZ6C1lgtWh2V7IHhpJ+oqpn3/Xtl015AmqHtAypmrgJ6yAg2Re3CnIVBkQ/ySvN+ts3b
         9/F9N9STfw1lP0k3HGfNITP7Nc4WKMubSuIBNPSG+/Wo5z/hOhTmeXQK9tuevDESEUK+
         kE3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722268440; x=1722873240;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G7NVQIGmQXJU9zMY7yOvP9B85E2qvUl+m8Pl4MaC7co=;
        b=cLjf+k6Ts79DVsaSJmOU1F+4j5bwuUPC7YOTzlSkSmmBc0J7l9z79TzFfP/2N1PPjE
         DD5PqDA6NdlaLxZGeY977BwYh2mJlGoOK1kGpQccrxyd+PJy4al6uh1mxR9avwPQ1IVi
         nVaQ8fNTJrFQFQEovRjd2UqvKbDDC1WbYZhVgbqLcWKd8oGYTsdOd4Wo2GDtdtKvcKSG
         BTD80OUJp0zKVbBcPKAQgp3oE95YYaGo5iKTrb60FToPhoAnkxENiivTFm/5Yw9m+J6z
         2E0ymtwq8wM2OlLAXZpf0K043maWypE8eWwOnEbt5LH+eG/UoonPseX473JlEhJJ7qYu
         +URw==
X-Forwarded-Encrypted: i=1; AJvYcCU5Ej2LMptgDeJVeTYtOspNY1LuhFOU1xMLBm7wHP88qRk+pnZxFSWhTGOZWEwgidVwMEIxjX8oBG7D7meX+Q6kYjkImRfQ8VQa5CFI
X-Gm-Message-State: AOJu0YzIDX64iikerP2UVmUGb2YdmvDl2i2/1kcDZZzSKzmF11p1izxj
	j5SHf44+v+R1y5wwe3/xM/wg74lmOETL8Vqrlrn5yk4Z/L7hzsTjNrT5QqSKerTSklVkuoxGS9+
	YlUG22R4fuDy5+4vHI0MoqhZzsgw1TM/UuAaL
X-Google-Smtp-Source: AGHT+IGtbd0iBqee7SwSoc94TJ7CIzVF+bo02bFcdiIhIU5AVsKcZ+YG/U7J2gyGGtrfLKplipYfybTILWWzXf+wdc0=
X-Received: by 2002:a05:622a:303:b0:44f:e12e:3015 with SMTP id
 d75a77b69052e-450329acd26mr220951cf.25.1722268439856; Mon, 29 Jul 2024
 08:53:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240727175919.1041468-1-linux@treblig.org> <CAP-5=fW+VbDaFV+YQCMMKYzrraMLLuVqb=BChL0o=-D5Y=4N_w@mail.gmail.com>
 <ZqewJ6oIprdRY8C5@gallifrey>
In-Reply-To: <ZqewJ6oIprdRY8C5@gallifrey>
From: Ian Rogers <irogers@google.com>
Date: Mon, 29 Jul 2024 08:53:48 -0700
Message-ID: <CAP-5=fUHVZDS9y4Bm=OesD5qpHHv7qqo2ALU70EPdS5WiQs1-w@mail.gmail.com>
Subject: Re: [PATCH] perf test pmu: Remove unused test_pmus
To: "Dr. David Alan Gilbert" <linux@treblig.org>, Nick Desaulniers <ndesaulniers@google.com>, llvm@lists.linux.dev
Cc: kan.liang@linux.intel.com, acme@kernel.org, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 29, 2024 at 8:07=E2=80=AFAM Dr. David Alan Gilbert
<linux@treblig.org> wrote:
>
> * Ian Rogers (irogers@google.com) wrote:
> > On Sat, Jul 27, 2024 at 10:59=E2=80=AFAM <linux@treblig.org> wrote:
> > >
> > > From: "Dr. David Alan Gilbert" <linux@treblig.org>
> > >
> > > Commit aa1551f299ba ("perf test pmu: Refactor format test and exposed
> > > test APIs") added the 'test_pmus' list, but didn't use it.
> > > (It seems to put them on the other_pmus list?)
> > >
> > > Remove it.
> > >
> > > Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
> >
> > Strange that the compiler doesn't warn about unused stuff like this,
> > we get unused variables within a function and unused static
> > functions...
>
> The problem is that LIST_HEAD initialises the list to point to itself;
> so it *is* used - but only in it's own initialiser.
> I did file:
>    https://gcc.gnu.org/bugzilla/show_bug.cgi?id=3D115027

Nice, the bug already has a fix - good work! Hopefully clang can follow sui=
t.

> > Reviewed-by: Ian Rogers <irogers@google.com>
>
> Thanks,
>
> > Possibly:
> > Fixes: aa1551f299ba ("perf test pmu: Refactor format test and exposed
> > test APIs")
>
> Given it's got no actual effect other than a few bytes
> saved, I'm not sure it's worth the Fixes.

Ack. I mention it so the maintainers can make a decision about fixing
in 6.11 (still in rc stage) or whether to hold for 6.12. It seems
pretty safe either way, but for 6.11 probably better to have a fixes
tag. If the GCC warning becomes a thing there's a chance the code
won't build without the fix :-)

Thanks,
Ian

> Dave
>
> > Thanks,
> > Ian
> >
> > > ---
> > >  tools/perf/tests/pmu.c | 3 ---
> > >  1 file changed, 3 deletions(-)
> > >
> > > diff --git a/tools/perf/tests/pmu.c b/tools/perf/tests/pmu.c
> > > index 40132655ccd1..0b2f04a55d7b 100644
> > > --- a/tools/perf/tests/pmu.c
> > > +++ b/tools/perf/tests/pmu.c
> > > @@ -18,9 +18,6 @@
> > >  #include <sys/stat.h>
> > >  #include <sys/types.h>
> > >
> > > -/* Fake PMUs created in temp directory. */
> > > -static LIST_HEAD(test_pmus);
> > > -
> > >  /* Cleanup test PMU directory. */
> > >  static int test_pmu_put(const char *dir, struct perf_pmu *pmu)
> > >  {
> > > --
> > > 2.45.2
> > >
> --
>  -----Open up your eyes, open up your mind, open up your code -------
> / Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy  \
> \        dave @ treblig.org |                               | In Hex /
>  \ _________________________|_____ http://www.treblig.org   |_______/

