Return-Path: <linux-kernel+bounces-177824-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C0E0B8C4505
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 18:23:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4C3B91F21F0B
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 16:23:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89A96155747;
	Mon, 13 May 2024 16:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OnqaZfKI"
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57821155353
	for <linux-kernel@vger.kernel.org>; Mon, 13 May 2024 16:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715617391; cv=none; b=H5HI2EiaYaCCWk8ylLHYeUkDOGsnJvMbHmDN6JE5HysMbVHdYvzpIGyPsmF8A0ZM7BlgFAj2JkVL6VQESlona/C+qXk3i4caV84BBq+NY+6xcn75fwM+z0EcdKh7UKQcjZc1B6or1RVGFWuTT3GgmcjPDfBt/sGrjj5PYgxoB1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715617391; c=relaxed/simple;
	bh=1FpidKHpJ6tC6uWua0hdyTTUiPlb0a/PUWUSgSZ6jrA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Aef527b4OkaRYQOhlFvPGdTcW2GsgkjYUz/G6D6yKTaVlzSnwvw/hSUjxausBMPqe5yw8LWd0+tI1mD4KSeT37dizVwLBBgD4pAT97yw6/NpNiK9C8quchQNqwhJQWFAgTQsjLiFk/3uXt28tUbWib5tU48Q7o8tr2RZSfOGXVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OnqaZfKI; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-43dfe020675so830761cf.0
        for <linux-kernel@vger.kernel.org>; Mon, 13 May 2024 09:23:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715617389; x=1716222189; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/fwn6UKi/1K0IWQMLBiFsBG9j5cvRpV6hNPVdi/9PdU=;
        b=OnqaZfKIANEkjcrAuRT54/MUPnM95qMIMwJ+WoSxjgZTtKGaS6ZUeMBWPKv8jnL6l6
         ZpVpm8lrBieXii+xIHSk6heqpWkI987e8ycp2PkKe+KjUXdELcoZBSpL7PQDsNzeN9T9
         88neQzSprnH4GsAVf6C+sxIqHTivj5NnLa7tGZZiHZm9ymlvYwGI4OmkF/uXWD1NWpeZ
         0HrZjfpRgE4VpboLlDa+ffNvanSJ9PrkhG1zN95DGFvZVkWUyHZ7lJ2uIW9lP91lETqx
         gqYCLXRB3euuN+kcj6drVbcBI5y3Gnsj92fr8CDV6G8MQCSJj4siRJGNm9fvwVRYum+w
         pI+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715617389; x=1716222189;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/fwn6UKi/1K0IWQMLBiFsBG9j5cvRpV6hNPVdi/9PdU=;
        b=QYALseXK3x4y7804FAe9MToUmmsMU2bqKxZHx327nOYLP3+SNRm6WsXJvpO8A7KJKT
         JR+yAYaIg0aKT8+cYaKu9SatkTOLaTE2Dm8Wtk3mv7D34K5/CpYcBkADLdCkIo/ghfHZ
         0SB3v5o7uAKWKvCRyNGTDAUiX/L/DjVNzkkbCKoALtLGochKXUflUYnBqWsw3HjJL7st
         8SifzuXVrPumVwv2O/q+a6BnpfbH2W3SlxR/xYhr593X3jyLGd8DMnBkXv7xoHszG41f
         WeTUGOe3fRoH3Y7KvkvxaRIwu2J7jhzb+9djVZCn77oMN8W6bg+EKXeeYNJM0Q2QqKN/
         mkaw==
X-Forwarded-Encrypted: i=1; AJvYcCUZr9cmAdSbQpUKadTs72WMehp33ZK67pYoMkklqruhXatqhIYbbd+qHz4s4lQA5KoV51mpAsuntikoe+eKVPPDPUvICMHLN1biJC1T
X-Gm-Message-State: AOJu0YwKaDmFPqmuAuAC4H6SYdNprQeuXEC8IAkcRfnD2VjXdjxvIA6K
	D89zqhHI0FSBUyZxJ/0EmgTiOvqdcFaQde+bMv5q4MU+ZVtOQ/1sBrNgih3/r/0HV4naYAACEXG
	KuGJYSyOhE+10zdepi+2Z0am4CKoscWe2klbs
X-Google-Smtp-Source: AGHT+IEN5gURnV/spOfCC6PRenvXXEfQixh++GvGxjfsy+XKRnlD1SHqctpBlOj0YTB0sRTHYkX2gGyvIHvTuKiSc2k=
X-Received: by 2002:a05:622a:98f:b0:43c:554e:b81 with SMTP id
 d75a77b69052e-43e0a28c3c5mr5057731cf.23.1715617389221; Mon, 13 May 2024
 09:23:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240502213507.2339733-1-irogers@google.com> <20240502213507.2339733-3-irogers@google.com>
 <fe41f9a7-5726-49d5-9bc6-70102d9680a1@infradead.org>
In-Reply-To: <fe41f9a7-5726-49d5-9bc6-70102d9680a1@infradead.org>
From: Ian Rogers <irogers@google.com>
Date: Mon, 13 May 2024 09:22:57 -0700
Message-ID: <CAP-5=fWHrX5AgH8=62f3=a-SSqUACXX1rkDZJ-WV1RcNieeHFA@mail.gmail.com>
Subject: Re: [PATCH v5 2/6] perf Document: Sysfs event names must be lower or
 upper case
To: Randy Dunlap <rdunlap@infradead.org>
Cc: Kan Liang <kan.liang@linux.intel.com>, Thomas Richter <tmricht@linux.ibm.com>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Jonathan Corbet <corbet@lwn.net>, 
	Jing Zhang <renyu.zj@linux.alibaba.com>, James Clark <james.clark@arm.com>, 
	Ravi Bangoria <ravi.bangoria@amd.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, May 12, 2024 at 3:08=E2=80=AFPM Randy Dunlap <rdunlap@infradead.org=
> wrote:
>
> Hi,
>
> On 5/2/24 2:35 PM, Ian Rogers wrote:
> > To avoid directory scans in perf it is going to be assumed that sysfs
> > event names are either lower or upper case.
> >
> > Signed-off-by: Ian Rogers <irogers@google.com>
> > Reviewed-by: Kan Liang <kan.liang@linux.intel.com>
> > ---
> >  .../ABI/testing/sysfs-bus-event_source-devices-events       | 6 ++++++
> >  1 file changed, 6 insertions(+)
> >
> > diff --git a/Documentation/ABI/testing/sysfs-bus-event_source-devices-e=
vents b/Documentation/ABI/testing/sysfs-bus-event_source-devices-events
> > index 77de58d03822..e7efeab2ee83 100644
> > --- a/Documentation/ABI/testing/sysfs-bus-event_source-devices-events
> > +++ b/Documentation/ABI/testing/sysfs-bus-event_source-devices-events
> > @@ -37,6 +37,12 @@ Description:       Per-pmu performance monitoring ev=
ents specific to the running syste
> >               performance monitoring event supported by the <pmu>. The =
name
> >               of the file is the name of the event.
> >
> > +             As performance monitoring event names are case
> > +             insensitive in the perf tool, the perf tool only looks
> > +             for lower or upper case event names in sysfs to avoid
> > +             scanning the directory. It is therefore required the
> > +             name of the event here is either lower or upper case.
> > +
>
> This is ambiguous to me. Is it clear to everyone else?
>
> "for lower or upper case event names":
>
> Is that a logical OR or an exclusive OR?
> "AbC" contains lower case or upper case characters. :)
>
> I think the code [static bool permitted_event_name()]
> implements an exclusive OR.
> The code also allows event names to contain numbers AFAICT.
> The documentation doesn't mention this.
>
> HTH.
>
> >               File contents:
> >
> >                       <term>[=3D<value>][,<term>[=3D<value>]]...

Sorry, this reads like a troll. Assuming good intentions, could you
propose a fix in the form of a patch? When a word is made upper or
lower case I believe it is generally assumed the operation applies to
all characters within the word, but I'm happy to see ambiguity cleared
up.

Thanks,
Ian

> --
> #Randy
> https://people.kernel.org/tglx/notes-about-netiquette
> https://subspace.kernel.org/etiquette.html

