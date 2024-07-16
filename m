Return-Path: <linux-kernel+bounces-254077-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 192DD932E5A
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 18:30:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 97A581F230BB
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 16:30:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2802719E7D8;
	Tue, 16 Jul 2024 16:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NOSUw6O0"
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D178719AD8A
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2024 16:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721147415; cv=none; b=E9snu4XIWu5IWFQlg2chCAXCXqLwGY4uSZDTyf8dkcUcETxhrOjZJwqpBg8qLrYaQyhvTm/cWdMsiQlbIpbQ3cEOGAItcPi5iRXSlbEzwbqhitgEiIcsv+QuoHnYz4IK5xjH4+WFFhfaM4ioi0lGGSvfV5X7nxr5euFQWfVW7/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721147415; c=relaxed/simple;
	bh=HjEDUAiJxPkx6bde3zHEuPs00PloqBq2bc9qBY9rfM8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pcipo+rdmDM1eua4IxfQBQ+Xyiy5B+buZF1vCCokooQLfPrj+UBVNgQjM+uvNqABVHRxf7FnORoCsSDotIfzQfWgLvyR85wgtwcCWDlXVKB1xqeHNEw9c/YiyMIepL0w8B3oWRt5928ISomU0u5Xv5S8PT87GFuKw1qSoSce4i0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NOSUw6O0; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-447df43324fso361401cf.1
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2024 09:30:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1721147413; x=1721752213; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VVDikK0mfQ+MdnU6b4mFCa68m5XsBhoAdIlxz7uPE5M=;
        b=NOSUw6O0qV0DHhmA8jDTodIl1UnQH6+ySdKkExE8H3FiRttyYpiD7GdCMtFSAJMesC
         HD8qoXLh2b9xB3o2oYdCXQ6XKeaxTwiiBZLf21MWG0Riy3orXfJLnv6/CejN7Ncn/PtD
         JNnsXJw07Z679/JW/Xw3nGbWbIrGY3nQIysg+jcEziqRCCg4gjCa+9IcQYqhw5SOy9aI
         uv+IVI9DQysyQT3gM7UbBJY+rKIfYBWSMvYEFb/ZXSLBeQkNmsXQSSx1iNNPwopOD+rE
         MKJvTUxQD/wJvU7z3ZEKfYKtgDA7AlcWHv02V4wiquAUGs8jtBnIfDfL7kZvtgdk/SPB
         Ouzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721147413; x=1721752213;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VVDikK0mfQ+MdnU6b4mFCa68m5XsBhoAdIlxz7uPE5M=;
        b=syCPcqLblCd2E0BKsJ/ovdXg0grTJ80Ra+NGIpjPeGgvphq3VM59FajibW1SLq+n0m
         sOZcQgsj29iDtBIax6Pt4RtM2kuyHgXj8uJqPVAhdHaipX7IYtmiGS7Bse3C41v8Ov08
         UVOPYtwzzq+qzo7F4PfqpaLBwmt2pgmRMMoteanUrGre6HvZh1MAykLWXsqSOlkuZDeK
         poYqlh7qG4fPVlvLGzpRaMfWP9e0DQdOtxJOZat+ki335tUAWtifZWm8IP1JSAxu0E8X
         MO1aiO0GCX3c2oWOthMUvCIRgkbTnB1vJBWP4ct+0+dx81r8QUOXLBjLUCgVToEZcZhn
         arfA==
X-Forwarded-Encrypted: i=1; AJvYcCW1GHADOANLRhEmmsYSKXhdyghB03y0bhELuKf7bWth73gyElCKwCHas3wMHKtaPYof8JtDHMcZDpnhY1jLk07+px/Z22YBSIE9bbM9
X-Gm-Message-State: AOJu0YzU+Xi3TaVYN8RV8EagSz59aenh4gz6EgStUiGwvmiHaS11DFbz
	H3r9z9kcFCV2V6V/eJ/uIdBmTH3fD2BHOcz0q1ze7KZcKyVDqxdj7RCveG+HYDkYaSPScDkax5L
	nW3wTEXQobaO2Vw68gMJQuucIVcSOj0JqrAww
X-Google-Smtp-Source: AGHT+IEsEQmBURrDuQHXpn3lWUafOF8UalNb41rPuznZouUH6vnroYjdc7AUpIufro89FRUAQsmDm/s1LEWDZhKbs44=
X-Received: by 2002:a05:622a:401b:b0:447:e2f0:4d17 with SMTP id
 d75a77b69052e-44f7b928895mr3160571cf.7.1721147412506; Tue, 16 Jul 2024
 09:30:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240716132951.1748662-1-kan.liang@linux.intel.com>
In-Reply-To: <20240716132951.1748662-1-kan.liang@linux.intel.com>
From: Ian Rogers <irogers@google.com>
Date: Tue, 16 Jul 2024 09:30:01 -0700
Message-ID: <CAP-5=fVZVU7kMOHz7CC7O1+2dX844dHqhqMebzEKWMA=59am-g@mail.gmail.com>
Subject: Re: [PATCH] perf jevents: Don't stop at the first matched pmu when
 searching a events table
To: kan.liang@linux.intel.com
Cc: acme@kernel.org, namhyung@kernel.org, adrian.hunter@intel.com, 
	peterz@infradead.org, mingo@kernel.org, linux-kernel@vger.kernel.org, 
	kernel test robot <oliver.sang@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 16, 2024 at 6:29=E2=80=AFAM <kan.liang@linux.intel.com> wrote:
>
> From: Kan Liang <kan.liang@linux.intel.com>
>
> The "perf all PMU test" fails on a Coffee Lake machine.
>
> The failure is caused by the below change in the commit e2641db83f18
> ("perf vendor events: Add/update skylake events/metrics").
>
> +    {
> +        "BriefDescription": "This 48-bit fixed counter counts the UCLK c=
ycles",
> +        "Counter": "FIXED",
> +        "EventCode": "0xff",
> +        "EventName": "UNC_CLOCK.SOCKET",
> +        "PerPkg": "1",
> +        "PublicDescription": "This 48-bit fixed counter counts the UCLK =
cycles.",
> +        "Unit": "cbox_0"
>      }
>
> The other cbox events have the unit name "CBOX", while the fixed counter
> has a unit name "cbox_0". So the events_table will maintain separate
> entries for cbox and cbox_0.
>
> The perf_pmus__print_pmu_events() calculates the total number of events,
> allocate an aliases buffer, store all the events into the buffer, sort,
> and print all the aliases one by one.
>
> The problem is that the calculated total number of events doesn't match
> the stored events in the aliases buffer.
>
> The perf_pmu__num_events() is used to calculate the number of events. It
> invokes the pmu_events_table__num_events() to go through the entire
> events_table to find all events. Because of the
> pmu_uncore_alias_match(), the suffix of uncore PMU will be ignored. So
> the events for cbox and cbox_0 are all counted.
>
> When storing events into the aliases buffer, the
> perf_pmu__for_each_event() only process the events for cbox.
>
> Since a bigger buffer was allocated, the last entry are all 0.
> When printing all the aliases, null will be outputted, and trigger the
> failure.
>
> The mismatch was introduced from the commit e3edd6cf6399 ("perf
> pmu-events: Reduce processed events by passing PMU"). The
> pmu_events_table__for_each_event() stops immediately once a pmu is set.
> But for uncore, especially this case, the method is wrong and mismatch
> what perf does in the perf_pmu__num_events().
>
> With the patch,
> $ perf list pmu | grep -A 1 clock.socket
>    unc_clock.socket
>         [This 48-bit fixed counter counts the UCLK cycles. Unit: uncore_c=
box_0
> $ perf test "perf all PMU test"
>   107: perf all PMU test                                               : =
Ok
>
> Reported-by: kernel test robot <oliver.sang@intel.com>
> Closes: https://lore.kernel.org/all/202407101021.2c8baddb-oliver.sang@int=
el.com/
> Fixes: e3edd6cf6399 ("perf pmu-events: Reduce processed events by passing=
 PMU")
> Signed-off-by: Kan Liang <kan.liang@linux.intel.com>

Awesome sauce, thanks!

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  tools/perf/pmu-events/jevents.py | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tools/perf/pmu-events/jevents.py b/tools/perf/pmu-events/jev=
ents.py
> index ac9b7ca41856..97a3b018f865 100755
> --- a/tools/perf/pmu-events/jevents.py
> +++ b/tools/perf/pmu-events/jevents.py
> @@ -923,7 +923,7 @@ int pmu_events_table__for_each_event(const struct pmu=
_events_table *table,
>                          continue;
>
>                  ret =3D pmu_events_table__for_each_event_pmu(table, tabl=
e_pmu, fn, data);
> -                if (pmu || ret)
> +                if (ret)
>                          return ret;
>          }
>          return 0;
> --
> 2.38.1
>

