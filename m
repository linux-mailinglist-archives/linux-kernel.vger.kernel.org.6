Return-Path: <linux-kernel+bounces-194519-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3ACA48D3D7B
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 19:40:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4EE3B1C22234
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 17:40:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABAAB1607AA;
	Wed, 29 May 2024 17:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="yPef+7uH"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A34F615AAC8
	for <linux-kernel@vger.kernel.org>; Wed, 29 May 2024 17:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717004396; cv=none; b=dXZbhuiGhWJmYnNrbTHvjHvUjlTgNQj1wxFycnPesmg69rfmco9ijIO+KyUYyseVL7TyoIlPQjX7dxztrplcokloz3FYoil4/23fqQCCyf1ZDKqm4XoUdXBdpcmfXfzZ9OB6RRIQlibhqmFj1OGuonpuJFPbggplp3pYcK15NZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717004396; c=relaxed/simple;
	bh=dPaODdaskC3Z14J+MvHYIp7xKni4Ov9KWIQ6Fqm4cKM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Vc9PAk6dbsS8J8MpuXY7PAQasF4TCPXZPk8392PCDhy94TNDeQagmy1ZOmqKoGE488YvC0xkO31C6LOYnPeH9Ci391fMyY/DiOZ7fcAnhbwlMh8DmIpYBhymxFgllhofruMLTzTiyBGAEfklfFa50xES92p+KecIJX0C/jMpEUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=yPef+7uH; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1f61742a024so1225ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 29 May 2024 10:39:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1717004394; x=1717609194; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x1Hnu6+sAWXDANJYkQmUpq/a8QqEUWJbB5oEbNYob7E=;
        b=yPef+7uHhWCpvj/c4denPY9amSqxAH8FoRr8xklc9Wzwp/KV7Vojz5AZJkuWmpTzO2
         NSvWRylZO+8hwfI4O5yD28+SF0q+J5gEciGPAw1hjIPEWNxp+CiXc9xaL4cb9Q3yl7e1
         8RYLHmibKOZDgPig7YWhK5S613eLGHu9aLKRjc12Cts7wgCt8KWz/Drf1GYbubzBaiiZ
         qhnNT0gC+AMIxyrhu7e9YOOuNz9YhZVr0Oygdek2H+5SimTKc5foyihg/vkh2RTfTo34
         H6CrJZem7xKl/K0OHFvmxHqXBnVEJXs57xraHRlkZhFWSW3Ufp9Mx7zhahLjU/FtM3Zv
         y2Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717004394; x=1717609194;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x1Hnu6+sAWXDANJYkQmUpq/a8QqEUWJbB5oEbNYob7E=;
        b=CPuPUqfDTAPerZq6jKp4uV6ETQE8+WAAOr7FcXCVUb3kVSuduWXGo8WDIS/iP/LUyw
         vLmAYcK8maUg/x3+mPcTqRJQpk9c0b30XYVfOonAXMI6lZ+IwkUfQ6UAyoh4oP8HLSLc
         5xhnAuneb41A4IyTEgE9SLLsraUwl8MucMQXxsJwhjEtu2oU+bmU7DyPgYok2dS6viaX
         Tr9EiI4ZqKjpsi5/PD1AVxDVbYZ0Yl0BKFqooa0ZzZs6AOO03tKGp5fSkQkj6z08eQVe
         pP6YIhFKtM/CD3o/ILHGYD61wntusauTZY30HsF9U7PmAaJqTbNEXIZmEYpz3fHYXPsy
         MaEw==
X-Forwarded-Encrypted: i=1; AJvYcCUw0D+bqJd9tboBMSiyVVzQGPJZVPUVrgVhBZOSXtH87eaKwOU8x5WoFoNLNRywcjRIM8QxgetBnJv8rfDQWkSUY+CbXRmSmU4Js6/n
X-Gm-Message-State: AOJu0YyZvUBragcAhtIcZDwmdiUBdPxozPV/pohpVFIk+yu/7FRx1Rto
	3ZrNHwm5Q23GqhmFP6xgPqjZFBVPCw/ACtTQDTtTGkPyUlXnQVd1qHVmJFBrlbeyDCWpok1ajEG
	9LsO8Wr43gdxTA2YPvgG1ZSJunNl4Ikx1NIvL
X-Google-Smtp-Source: AGHT+IHXfICIUOJxALQx0hgaOBkKY8dXtkFMx2vf2R5hjHGERHrg/bfwc+B419+58oVkNFkkz/esJdYffHjRvLJ7QPU=
X-Received: by 2002:a17:902:8688:b0:1f3:2b46:47ce with SMTP id
 d9443c01a7336-1f4ecd25d50mr2407695ad.15.1717004393559; Wed, 29 May 2024
 10:39:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240510053705.2462258-1-irogers@google.com> <20240510053705.2462258-4-irogers@google.com>
 <35d6875b-9a28-4953-a187-b6659880ac66@arm.com>
In-Reply-To: <35d6875b-9a28-4953-a187-b6659880ac66@arm.com>
From: Ian Rogers <irogers@google.com>
Date: Wed, 29 May 2024 10:39:32 -0700
Message-ID: <CAP-5=fUbZRkoRN__ZE3YmzhM5HqQABZ7jHymgshZGDzT0LgqOg@mail.gmail.com>
Subject: Re: [PATCH v3 3/5] perf stat: Remove evlist__add_default_attrs use strings
To: James Clark <james.clark@arm.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	Ravi Bangoria <ravi.bangoria@amd.com>, Yang Jihong <yangjihong@bytedance.com>, 
	Ze Gao <zegao2021@gmail.com>, Leo Yan <leo.yan@linux.dev>, Song Liu <song@kernel.org>, 
	K Prateek Nayak <kprateek.nayak@amd.com>, Kaige Ye <ye@kaige.org>, 
	Yicong Yang <yangyicong@hisilicon.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 29, 2024 at 8:39=E2=80=AFAM James Clark <james.clark@arm.com> w=
rote:
>
>
>
> On 10/05/2024 06:37, Ian Rogers wrote:
> > add_default_atttributes would add evsels by having pre-created
> > perf_event_attr, however, this needed fixing for hybrid as the
> > extended PMU type was necessary for each core PMU. The logic for this
> > was in an arch specific x86 function and wasn't present for ARM,
> > meaning that default events weren't being opened on all PMUs on
> > ARM. Change the creation of the default events to use parse_events and
> > strings as that will open the events on all PMUs.
> >
> > Rather than try to detect events on PMUs before parsing, parse the
> > event but skip its output in stat-display.
> >
> > The previous order of hardware events was: cycles,
> > stalled-cycles-frontend, stalled-cycles-backend, instructions. As
> > instructions is a more fundamental concept the order is changed to:
> > instructions, cycles, stalled-cycles-frontend, stalled-cycles-backend.
> >
> > Closes: https://lore.kernel.org/lkml/CAP-5=3DfVABSBZnsmtRn1uF-k-G1GWM-L=
5SgiinhPTfHbQsKXb_g@mail.gmail.com/
>
> Taking a look at this one now. I think some example commands and outputs
> in the commit message would be helpful because there are quite a few
> different things mentioned in the closes link.
>
> But I'm assuming this is just for the command without specifying an event=
:
>
>   $ perf stat
>
> I didn't realise that wasn't working properly and I'd missed that Mark
> spotted it in that link.

Hi James,

Do you want to take on owning fixing this? My concern is that by using
event parsing:

+                               "context-switches,"
+                               "cpu-migrations,"
+                               "page-faults,"
+                               "instructions,"
+                               "cycles,"
+                               "stalled-cycles-frontend,"
+                               "stalled-cycles-backend,"
+                               "branches,"
+                               "branch-misses",

any of the names could conflict with something advertised on an ARM
PMU somewhere. Clearly cycles has already proved to be controversial
and broken for perf record on Neoverse.

Thanks,
Ian

