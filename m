Return-Path: <linux-kernel+bounces-432102-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BCD19E451D
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 20:54:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3DA622829B8
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 19:54:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0C811F03D2;
	Wed,  4 Dec 2024 19:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ojGGbQcW"
Received: from mail-il1-f179.google.com (mail-il1-f179.google.com [209.85.166.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 959981F03C2
	for <linux-kernel@vger.kernel.org>; Wed,  4 Dec 2024 19:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733342073; cv=none; b=q1ho+EEPwjl9V8AKCZ50m3mnojQCEqio6FghVt3LaStSIcAYTRky3KzdW+zWAcSMjP29q1+CVnZdAQqDHdQkYNKjN073O/jLG2Qr55wYtzV2WUyXkoJpIJyFa83VRYrDR6DvwWI7yZzxx5j1j/Vbm1wtcjSCOHh/TImvvPep/E4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733342073; c=relaxed/simple;
	bh=NCb3UXTZuke/KXB7dhkw3bbUTNrL5acQl/Jk89k8fBo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lQz93CeSKbaBeG3fRmwCjAbIJECgbMPiL37l+Vak+nuh1uZdr1Ozxg/M2VzbF6xGC3BdT30I9FUMh3QoPzO/R+alqBsepCUrlQfXSeVhPFOZqt902y6oLUWsVBW3W536U49XAc3lDMTGs+ZBJG9tPcZMdUoLk6P8LH6jLsAj3kU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ojGGbQcW; arc=none smtp.client-ip=209.85.166.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-il1-f179.google.com with SMTP id e9e14a558f8ab-3a77ab3ebfaso19045ab.1
        for <linux-kernel@vger.kernel.org>; Wed, 04 Dec 2024 11:54:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733342071; x=1733946871; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NCb3UXTZuke/KXB7dhkw3bbUTNrL5acQl/Jk89k8fBo=;
        b=ojGGbQcWeP3r9Xw9pVVWPCUi15GfkzCIpeK3R/FA4ZjMBbfgeKd2sPxcbQXBxaulo4
         7ZoBaBnCeV9dUrMUt7lD+nWFno8qoVHR+Me3xMMeu6TNSaHO/z4JuvmkoTSue7aH4gkN
         azY6JefHEhHc18sueSluFuZxrDyAzQ5ZfTiLUTUAD48DvgZzxwnx6l8C/pdJpU+bnjsI
         bWcyMtEHCumPcJ6l3+MsZdRyK4k7eTWhO2LnPoMchKj6jBu7ZUHiJJlbKDCuOI1JEfld
         ofEa6m+1z9A2ZI/2mY+rzKnzOAkSe8uiZOgA3nmb2Xzgf+7rxQogAtexKoYAJ+Of2aE8
         HTwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733342071; x=1733946871;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NCb3UXTZuke/KXB7dhkw3bbUTNrL5acQl/Jk89k8fBo=;
        b=aIkO3n6XBsOrZRRFidPscoUlDhJV8x/952tPGXLqfPx8xy71tDuRFiVoYm6gBRQpcG
         ahF6FIi9OiUDklvLsKe4D0T6FVrztg5RqGbGRCRogc/gt8vgNnLnBIGPQEU0C0t5VCmm
         aALvzeMqJtBrbZtWZcpAdIOnBfwoBFzIwzVIICp/UnWdN4SiNnk7SKFhbnG9TmQGjuV/
         kaQeh61U9Rwqkm8FlnYkjkSbUsyPz89m/DT66nF03ICzSpUIXapNsVXFZBK9UiVhTIh1
         07TF22Fme6FHZhNy+K3vzmHvqyMwVKrekDazH5Js30dBLvj+dPVtlI0RqvZ/hCJ/Xmgi
         4Hlg==
X-Forwarded-Encrypted: i=1; AJvYcCX+EBRO62j5G+9L7yPkL11hD/FvOT+JdoDXVgLwWZUlRZ10V+XV9wxyFYzWPoJPztk3npuwW/csJxcmRUc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzqNxgmWM4AzrohRktY9Qs71G1XHpcGYreX+3YMcrVcrMEwtqhs
	rxf8GfOq2VpbGZ7GZ1a2Z0ODwrfLa0ru/K8QaEaaTxEX0N89yH/fj+1a8zE3x/karNSLhXvhXTm
	EqN9q75+fl1woIvpmVFoZrnVYsj7UlenCJpNV
X-Gm-Gg: ASbGncvPZSQRbSWPcrBtKAL/mKZ1vYOjK5IzaRg+aozuGFVu1FA0g5vFKaDSNHE5O8n
	e8qQwAm4vvvl5/9ms4B0jvzBPrLqoH+L8
X-Google-Smtp-Source: AGHT+IH0+K8UgFv5k5HW39jYjWkgbktV38bY29Y1wZ3mF2Qk/8GKySXtYSZ8ExRC8GmAc+hoLzIUSUNJC4VMOGbrX5E=
X-Received: by 2002:a05:6e02:3312:b0:3a7:d763:902a with SMTP id
 e9e14a558f8ab-3a808569c7bmr332615ab.23.1733342069611; Wed, 04 Dec 2024
 11:54:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241128133553.823722-1-yangjihong@bytedance.com>
 <Z0jPPRA8JXSrwyaC@x1> <Z04qmNnt86zcGE5Q@google.com> <ff9bc82e-669b-44b7-a02c-f5c704c0cd9b@bytedance.com>
In-Reply-To: <ff9bc82e-669b-44b7-a02c-f5c704c0cd9b@bytedance.com>
From: Ian Rogers <irogers@google.com>
Date: Wed, 4 Dec 2024 11:54:18 -0800
Message-ID: <CAP-5=fVocYqEbv6P=UP7rQCUhZHSmJZ3GGE08koTMG2rWWumgA@mail.gmail.com>
Subject: Re: [External] Re: [RFC 00/12] perf record: Add event action support
To: Yang Jihong <yangjihong@bytedance.com>
Cc: Namhyung Kim <namhyung@kernel.org>, Arnaldo Carvalho de Melo <acme@kernel.org>, peterz@infradead.org, 
	mingo@redhat.com, mark.rutland@arm.com, alexander.shishkin@linux.intel.com, 
	jolsa@kernel.org, adrian.hunter@intel.com, kan.liang@linux.intel.com, 
	james.clark@arm.com, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 4, 2024 at 12:35=E2=80=AFAM Yang Jihong <yangjihong@bytedance.c=
om> wrote:
>
> Hello,
>
> On 12/3/24 05:46, Namhyung Kim wrote:
> > Hello,
> >
> > On Thu, Nov 28, 2024 at 05:14:53PM -0300, Arnaldo Carvalho de Melo wrot=
e:
> >> On Thu, Nov 28, 2024 at 09:35:41PM +0800, Yang Jihong wrote:
> >>> In perf-record, when an event is triggered, default behavior is to
> >>> save sample data to perf.data. Sometimes, we may just want to do
> >>> some lightweight actions, such as printing a log.
> >>
> >>> Based on this requirement, add the --action option to the event to
> >>> specify the behavior when the event occurs.
> >>
> >> 'perf record' is centered on saving data to disk without processing
> >> events, while it has sideband events for some needs, like processing B=
PF
> >> related events (PERF_RECORD_BPF_EVENT to catch PERF_BPF_EVENT_PROG_LOA=
D
> >> and UNLOAD), doing things in a "live" way as your patchkit does seems
> >> more appropriate to do in 'perf trace' :-)
> >
> > Agreed, 'perf trace' looks like a better place as you seem to target
> > tracepoint events mostly.
> >
> Okay, will do it in 'perf trace'.
>
> Attaching to a kprobe events will also be supported in the future.

Hi Yang,

Just some extra information in case it is useful on python scripting,
which could be reused to avoid writing a new interpreter as in this
series. There are quite a few perf script examples here:
https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tr=
ee/tools/perf/scripts/python?h=3Dperf-tools-next
There are also standalone scripts here including for tracepoints:
https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tr=
ee/tools/perf/python?h=3Dperf-tools-next
One of the things missing for standalone scripts was being able to
conveniently parse events - you'd need to manually determine PMU type
and config values. That is fixed in this reviewed but not merged
series:
https://lore.kernel.org/lkml/20241119011644.971342-1-irogers@google.com/

I'd like to see the python code improved as it allows quicker command
creation like your example. Another example I'd recently tweaked is:
https://lore.kernel.org/lkml/20241119180130.19160-1-irogers@google.com/
Ultimately I think it would be nice to be creating tools using UIs
like textualize:
https://www.textualize.io/
and our Gecko Google summer-of-code project was an improvement here:
https://lore.kernel.org/lkml/ZOrsiZA+C0zbWEQS@yoga/

Other than basic functionality, perf's python support could be
improved in a number of ways that we've discussed in office hours or
on the list. Some things that come to mind:
1) The perf script callback mechanism doesn't feel particularly
pythonic, generators or coroutines could be better.
2) We should probably have more library python code rather than adding
new functions to `tools/perf/util/python.c` - I may do this to add
type hints for mypy. If we could have a subset that works without the
C code then it could be a basis for `perf.data` file analysis not tied
to Linux, or `pip install`-able. There is a similar library with
simpleperf, but shipping something with the perf codebase means we can
keep the file format and library synchronized.
3) We'd like to reduce the number of dependencies `perf` as a command
has, and libpython is a big one. Something `uftrace` did was dlopen
libpython to avoid needing to link against it. A project similarly
rethinking python binding with C code is HPy.

Thanks,
Ian

