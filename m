Return-Path: <linux-kernel+bounces-537580-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7801EA48DB7
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 02:17:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6EDDC16E433
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 01:17:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2C521BC2A;
	Fri, 28 Feb 2025 01:16:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qmw1YwcG"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5DCE33E7
	for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 01:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740705415; cv=none; b=A+rSZdqW2/D8yp4OKBQNCMgf1SkymzxtQMnQzFiMGW551sX0RgWsm/lOreKXPZG33l7h93Ga3luPqTjnQoeo8SNHr+85zrjFVMnz0TCuOWOm7wisPQEHGGrnvBAqn4zywjTmXGx3a/jAznGNwcOfjAO1RK737WQAeNXRJGHBcgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740705415; c=relaxed/simple;
	bh=k2ZTSXkbreeSGSIlG8rK4tM65oAyxohT+aY/Zpn+8G8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Y0WPySiBQFW8u0axJnqlmuK/TOpB0j2wK2JcNBoznaVs/FGu3UJm7gpRP0CD2btyl69l4Yarihpe2xy0VW+d959FJ/ocq3HEsbRDdm0gEsQ6DjWi58tfNK3UDaDQiWt2K2yhLzSHBy45EIRSj8TfuQbq/m4eDFxqkzr2cbuLz5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qmw1YwcG; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-22117c396baso45245ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 17:16:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740705413; x=1741310213; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hsPN2U4i/7+tuUpMneffNky/ZJwaVylxgwYzLMQe4ZE=;
        b=qmw1YwcGuj3z9gq/D3lvs/CqsoDWZgqe1NPwyz48gu9dfs1NjOWnhBTk2VWj7MLbIn
         g2c/VD+U8VUQDmel/Nm58RM2ziUD1CUFxWH6/WZfMUUg7I6QhxwTadDE763Oxk070TeM
         qLnOltgDdJhyXAFDBrONwl5J3xy6307HFLRRUuaOeiRoWae+XSgYAjIES7fd4l4Ainli
         YpaWe5qaZd2A4ViHiXsHdus7grgrMJ3Vfzua9n/pmoFDCex7pOph5E8jWfjy5RgbYkOM
         39oKARf7Whb02/Gle52cg4dANUf9/IonDLDZ3khnYamBoXxO1dPlPjOr03GJ8Cto2Ztg
         ZyCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740705413; x=1741310213;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hsPN2U4i/7+tuUpMneffNky/ZJwaVylxgwYzLMQe4ZE=;
        b=EPmsRP5WBhhdDFR4ISl0vnKV9CCaT7j9wtKNtI1QqV2nQfZSogzkd2jgGAV6H2iVWO
         /pwaU7Fs1ynBmv+9i41T5inz8n7hOLq5XL5b6PAT5afnztgAGPQgLCmpXHGZkrFYDWM4
         ooG8X2i4uz3wzDlpVQPM0Q9Uqv3ahoQrRj4+awUVVZY8O7gziZv3yPrzGY2sAs2LRyeK
         9dk4lKWhOs79nOQjmec7E82FeEJfmGRU8r1xoshvulWSYYQCeTv2uWIYd5Z+lVzwFc5/
         zDkfIWtnz5y/fl7gNjotgWtZrk7oYcW8qziaqAjPvMGLmgVs+iYMnvHD5NFbmf6bvqe8
         kZbA==
X-Forwarded-Encrypted: i=1; AJvYcCWPtNMTDEJA9jyk5eFlTnGILPsIEzVm/Bu4ofA3gAq7gIGEP9x98Bt8IJKeDiWVPM/4pDjdlwL03LzELI8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxSZorycVn7Qq1HUpDjHwSAVOYAlYNtBt/28oua8YFNzm3yQeNP
	Cd4uFL+2YBh0uQgoz3Y7M4Z6ygnvgA+1a2RGErVHx6lfFFHieEGRTM3g1mu2KJ88DGNbRjDw7eO
	22BqVtOdkSy30e+EnjUDxWVwur40xam2QSi5y
X-Gm-Gg: ASbGncvy32qCkzJdGIETcfpBiNnOpj5eIOBfkCfxlIrzavu8Uya0T5J3JuodWRhAMLN
	UCdac7WorXIkrpV+e7q+aFGU3Mys6tOMrlD6lmTVv4rejCYseEGLV/Gf3Do6eiKgCJlH+qbwPBf
	dVX3S2TaVv
X-Google-Smtp-Source: AGHT+IGjsxqOFBcmRTJx0axfWN5ELYiIJ+SwJ4BMIK1X0w7I3rB0KIUrDWd5JBZC2HbVzjACEOoQt+oSTbTh5/687Ok=
X-Received: by 2002:a17:903:3289:b0:216:6ecd:8950 with SMTP id
 d9443c01a7336-2236cfcc5ddmr700695ad.19.1740705412715; Thu, 27 Feb 2025
 17:16:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250227215455.30514-1-acme@kernel.org> <20250227215455.30514-2-acme@kernel.org>
 <CAP-5=fUqLyCt4=4XgoCjTkmeO4yrHTvEU1Hw48-+S3Szi20x5g@mail.gmail.com> <CA+JHD924rCBDbK1f_7=0c-Pp_tPj7vcXjaMFQdE_OB6CGOTtUQ@mail.gmail.com>
In-Reply-To: <CA+JHD924rCBDbK1f_7=0c-Pp_tPj7vcXjaMFQdE_OB6CGOTtUQ@mail.gmail.com>
From: Ian Rogers <irogers@google.com>
Date: Thu, 27 Feb 2025 17:16:41 -0800
X-Gm-Features: AQ5f1Jo1sBou9b_zfA8EYzFZ41xR0ry6ciD03c5EBxSXzdStx_d5NoIEqsQqDCU
Message-ID: <CAP-5=fUd_0Pf1ceo7LFws_HBNdOxkSJYMDrGrKLd1_CChu5NxQ@mail.gmail.com>
Subject: Re: [PATCH 1/6] perf maps: Introduce map__set_kmap() for kernel maps
To: Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Ingo Molnar <mingo@kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>, James Clark <james.clark@linaro.org>, 
	Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Clark Williams <williams@redhat.com>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, 
	linux-perf-users <linux-perf-users@vger.kernel.org>, 
	Arnaldo Carvalho de Melo <acme@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
	Stephane Eranian <eranian@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 27, 2025 at 3:54=E2=80=AFPM Arnaldo Carvalho de Melo
<arnaldo.melo@gmail.com> wrote:
>
> On Thu, Feb 27, 2025, 8:27=E2=80=AFPM Ian Rogers <irogers@google.com> wro=
te:
>>
>> On Thu, Feb 27, 2025 at 1:55=E2=80=AFPM Arnaldo Carvalho de Melo
>> <acme@kernel.org> wrote:
>> >
>> > From: Arnaldo Carvalho de Melo <acme@redhat.com>
>> >
>> > We need to set it in other places than __maps__insert(), so that we ca=
n
>> > have access to the 'struct kmap' from a kernel 'struct map'.
>> >
>> > When building perf with 'DEBUG=3D1' we can notice it failing a consist=
ency
>> > check done in the check_invariants() function:
>> >
>> >   root@number:~# perf record -- perf test -w offcpu
>> >   [ perf record: Woken up 1 times to write data ]
>> >   [ perf record: Captured and wrote 0.040 MB perf.data (23 samples) ]
>> >   perf: util/maps.c:95: check_invariants: Assertion `map__end(prev) <=
=3D map__end(map)' failed.
>> >   Aborted (core dumped)
>> >   root@number:~#
>> >
>> > The investigation on that was happening bisected to 876e80cf83d10585
>> > ("perf tools: Fixup end address of modules"), and the following patche=
s
>> > will plug the problems found, this patch is just legwork on that
>> > direction.
>> >
>> > Acked-by: Namhyung Kim <namhyung@kernel.org>
>> > Cc: Adrian Hunter <adrian.hunter@intel.com>
>> > Cc: Ian Rogers <irogers@google.com>
>> > Cc: Ingo Molnar <mingo@kernel.org>
>> > Cc: James Clark <james.clark@linaro.org>
>> > Cc: Jiri Olsa <jolsa@kernel.org>
>> > Cc: Kan Liang <kan.liang@linux.intel.com>
>> > Cc: Peter Zijlstra <peterz@infradead.org>
>> > Cc: Stephane Eranian <eranian@google.com>
>> > Link: https://lore.kernel.org/lkml/Z74V0hZXrTLM6VIJ@x1
>> > Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
>> > ---
>> >  tools/perf/util/maps.c | 29 +++++++++++++++++++++--------
>> >  1 file changed, 21 insertions(+), 8 deletions(-)
>> >
>> > diff --git a/tools/perf/util/maps.c b/tools/perf/util/maps.c
>> > index 09c9cc326c08d435..e21d29f5df01c6f7 100644
>> > --- a/tools/perf/util/maps.c
>> > +++ b/tools/perf/util/maps.c
>> > @@ -428,11 +428,29 @@ static unsigned int maps__by_name_index(const st=
ruct maps *maps, const struct ma
>> >         return -1;
>> >  }
>> >
>> > +static void map__set_kmap(struct map *map, struct maps *maps)
>>
>> I'm not sure this is the right function name. The kmap is created when
>> the map is created, so perhaps `map__set_kmap_maps(..)` is more
>> accurate.
>>
>> Fwiw, kmap is:
>> ```
>> #define KMAP_NAME_LEN 256
>>
>> struct kmap {
>> struct ref_reloc_sym *ref_reloc_sym;
>> struct maps      *kmaps;
>> char      name[KMAP_NAME_LEN];
>> };
>> ```
>>
>> The name is pretty chunky, perhaps it should be a strdup-ed pointer.
>> ref_reloc_sym is used in the context of a machine, so perhaps there
>> should be a hashmap from map to ref_reloc_sym.
>> The kmaps variable seems to largely be unnecessary, things like
>> addr_location and map_symbol carry around a map and the associated
>> maps, so when kmaps is needed it was probably already one of the
>> arguments to the calling function and could have just been passed
>> through.
>> So I think there is a cleanup to:
>> 1) remove kmaps - just pass down an associated maps
>> 2) make ref_reloc_sym and name things looked up from a hashmap
>> 3) get rid of kmap altogether so that invariants don't need to be
>> maintained and issues like this shouldn't repeat.
>
>
> Can we work on these naming and further cleanups on top of this series?

The intention for the fwiw on the kmap stuff was to imply it is really
doing more than what this series does and can be follow up. The
function name is up to you and Namhyung as to whether it is worth
fixing in the series.

Thanks,
Ian

