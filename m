Return-Path: <linux-kernel+bounces-511640-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 32E02A32DA2
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 18:41:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DEC7216633F
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 17:41:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4BD425B66C;
	Wed, 12 Feb 2025 17:41:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Kklk7Pgl"
Received: from mail-il1-f181.google.com (mail-il1-f181.google.com [209.85.166.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9991920E310
	for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 17:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739382096; cv=none; b=WN8E5Ywzta//Gij5YMcmK7m4EnMjuNjx1NqGYowhSNDM0e8BT1C5sj9iRdZzXnrEInqx9luUw62jXWQxVNIG91kVFWtTPBC6Rq0VMrHUanLBy+XMdIMf/84PmodbsvusMJ6qCqjfHbRYn/UUBXx1Weor4o6fdoQwHPiMK+hNifc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739382096; c=relaxed/simple;
	bh=2ifwWhQTxxQiW7dj498V1n5a4KBtNGzB0N41R6fK8oA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hOQg7/sYiFqyuEd1rG5ym2V/dDgiQINp76V0bvOZq+267Fa4l+0Pbaqi4YMiETW/OXvKZoW6GcmbprxlsQhU4Z7DhrJX7G1FqTD8xg189PzeZeA2ZxtUzORuSB5UkOU/xywwPxVzTlwFVnOZfsZHEwTLRtJd4onAxc2WAu+ExCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Kklk7Pgl; arc=none smtp.client-ip=209.85.166.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-il1-f181.google.com with SMTP id e9e14a558f8ab-3d13fe99d03so192025ab.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 09:41:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739382093; x=1739986893; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NeXd2qd1PEvqx/l3JSlPWtr5yCxb0WRCNQDPWgVQ0Kk=;
        b=Kklk7PglehriuVyW/wG5Wk6V+0GWHzQEn0TTCli9NrI680U4VpyTTRzcYRW7cXm73l
         GBgOENUiFcE33Q7osH2CtoKQaTrkE8UhNgeTsC0hcCst3mpKI0D6C6O8Wn1INZonRl5k
         UnT8we9NpQZOx8+eY+SiYxFcPsNGkBpjS2/5vhZ7QBxAOWdUU+Xx6AhyDMijTZflgpCt
         g9Ex9qQBwc+Vmqo9gQDTa5/sYu4uYxjYR5km6bClQBv2092DMS6FmLtd/q+bT0B64T7q
         7Q0cDWfo7ogPLpInaYHK8dK4ASW48WUbCngFmgo6wKDmK052JTL5HOXD2ZtslJA6Xivu
         6uaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739382093; x=1739986893;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NeXd2qd1PEvqx/l3JSlPWtr5yCxb0WRCNQDPWgVQ0Kk=;
        b=u+ifkN746CyjnbhFzZ32luNwlUNPaHRGXGV1KzCP2498tHRj2Sza4ROupPVqDBNDBp
         RvSywUuOxmURVa5ktXkBPtBY6nKpvYeL3uhRIse4+ZoI97FSN14KBKQK0EjHZH+0J0Co
         SyZtkFB6U5lcNKdhoGBU3oV7A0BzB5lyiMRRHqoxe75OvxDoVjOaa4pItQ8eq/2J2o9N
         s+Y4AiS+2VWFxmb2YuMjw04yld0oiqBHWGmbNTdkGq2Bvz0E79tZn5Xudc4s9eiGF5iI
         hDJl3auuM+JNCtojOEQNfhVTsfdoiRcTBvyZs+XrfJwAwnDGm4cKrsSUBbNitnCxkkqP
         Mbzw==
X-Forwarded-Encrypted: i=1; AJvYcCXSvLipWr+AM8V9RKzfCiXpH4TYRjBUn6A/KAg/NcHqybSR1vBIY0nRa6aS/3h+Ud36wAidS0yQnPUKAhk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8Fh9GRoSiFMLowpkcDveGlBcYRfsxIyGP0qikDwjI2dgdU60d
	xwFEx1c+LhVGPSRTcwQK5EfwygIm7AvIPJpJLoDr/366Be4+mRHG8ooGOKDn5/1W5hWVOE2qp6W
	5FxvYj5s0HUHWiEuU5m3DWRMVgM5sXtSGLzSz0i4t9qCgeRtl39/3
X-Gm-Gg: ASbGncsGWjkbLgOoT7cOvf4c5E8gjy+7d8xQ8iTFwJRso8RMU2onLQnRCkTNh293Krb
	h0XT0r9s/Lfz3B9+l0mu1aLEE/YeUkZeBuppcuFUAZ8EJ7zCrIktXB9cdIQXETSbO+s0VPb12rZ
	Ygpv5S+CYFDUFgx2ZXTyrX4uN3
X-Google-Smtp-Source: AGHT+IG6ln2ls+6Cio1iDB94DvtDvdxN8J57O1VI0o2VYwaNeyMhRXZUVRYHBe/f6/+RK/lgkCetQ560EYq3lA0BMRc=
X-Received: by 2002:a05:6e02:2188:b0:3a7:a468:69df with SMTP id
 e9e14a558f8ab-3d17dd35fa4mr3758535ab.3.1739382093504; Wed, 12 Feb 2025
 09:41:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250212163859.1489916-1-james.clark@linaro.org>
In-Reply-To: <20250212163859.1489916-1-james.clark@linaro.org>
From: Ian Rogers <irogers@google.com>
Date: Wed, 12 Feb 2025 09:41:21 -0800
X-Gm-Features: AWEUYZlS7lomJpvNC0yKKIVS8FncUi7vMJdQti4JegYHkMOW8jnx6mWsb9BSOQo
Message-ID: <CAP-5=fWG8vkKypjJe5SZoPTsRpjG8WpgcAHcji9ipyFnkG2X=Q@mail.gmail.com>
Subject: Re: [PATCH] perf tests: Fix Tool PMU test segfault
To: James Clark <james.clark@linaro.org>
Cc: linux-perf-users@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, "Liang, Kan" <kan.liang@linux.intel.com>, 
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 12, 2025 at 8:39=E2=80=AFAM James Clark <james.clark@linaro.org=
> wrote:
>
> tool_pmu__event_to_str() now handles skipped events by returning NULL,
> so it's wrong to re-check for a skip on the resulting string. Calling
> tool_pmu__skip_event() with a NULL string results in a segfault so
> remove the unnecessary skip to fix it:
>
>   $ perf test -vv "parsing with PMU name"
>
>   12.2: Parsing with PMU name:
>   ...
>   ---- unexpected signal (11) ----
>   12.2: Parsing with PMU name         : FAILED!
>
> Fixes: ee8aef2d2321 ("perf tools: Add skip check in tool_pmu__event_to_st=
r()")
> Signed-off-by: James Clark <james.clark@linaro.org>

Thanks James, I'd assumed this had been covered by Kan and Namhyung.

Tested-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  tools/perf/tests/tool_pmu.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/tools/perf/tests/tool_pmu.c b/tools/perf/tests/tool_pmu.c
> index 187942b749b7..1e900ef92e37 100644
> --- a/tools/perf/tests/tool_pmu.c
> +++ b/tools/perf/tests/tool_pmu.c
> @@ -27,7 +27,7 @@ static int do_test(enum tool_pmu_event ev, bool with_pm=
u)
>         parse_events_error__init(&err);
>         ret =3D parse_events(evlist, str, &err);
>         if (ret) {
> -               if (tool_pmu__skip_event(tool_pmu__event_to_str(ev))) {
> +               if (!tool_pmu__event_to_str(ev)) {
>                         ret =3D TEST_OK;
>                         goto out;
>                 }
> @@ -59,7 +59,7 @@ static int do_test(enum tool_pmu_event ev, bool with_pm=
u)
>                 }
>         }
>
> -       if (!found && !tool_pmu__skip_event(tool_pmu__event_to_str(ev))) =
{
> +       if (!found && tool_pmu__event_to_str(ev)) {
>                 pr_debug("FAILED %s:%d Didn't find tool event '%s' in par=
sed evsels\n",
>                          __FILE__, __LINE__, str);
>                 ret =3D TEST_FAIL;
> --
> 2.34.1
>

