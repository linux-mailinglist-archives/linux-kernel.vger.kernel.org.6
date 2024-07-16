Return-Path: <linux-kernel+bounces-253196-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 99ED1931E09
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 02:23:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 51F30282CD7
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 00:23:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 507B381E;
	Tue, 16 Jul 2024 00:23:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SK7S/O+h"
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 156B5182
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2024 00:23:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721089427; cv=none; b=jvCGrZIsa8g8zEdxSh0O8/+H8gbcsWwGs35iQuTmyhm6HR90JRPKh7akgFT1ghq4phmrWREfGXbjzhRjlxlnwFk5Uy6i9ZDDUQ37FHHeLwmjAK2z6BQBAXK9D0TW49fRWFkvdg9Kky3eIgTvrkdKMFat9i1nOPh1r9DYblM2X6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721089427; c=relaxed/simple;
	bh=w+9uP3NYMGiGGm8C01qAIjXCvPwsduD/KyZg9fbAvdc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bCKETjSbxKoYuVFb3zEk5vWIZR0reKxdztmqCH1UwWwlxh2Wz2+xkZ2Pw+wIQP3N9u88wbQbD+UBKVz9wdy1MSzGKvSX2anAVTSQyMvpRmOxwI/oOxVgUFI9kmntRGY1FKM2CwjZWCWCrcqNZCmW9RJiIrj6ilSvD3n/fj4wYog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SK7S/O+h; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-447df43324fso88381cf.1
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2024 17:23:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1721089425; x=1721694225; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=atOyFauWlMezUFieUVAk0q6tNEF19uog8150eFOHK5o=;
        b=SK7S/O+h0WVibjzp45o+hAVxNfaafgMdhTkGHp65ZtTX8IDjHFBFZoPnTPjsz9TSKU
         ucaIYXqraXLFQ1ECdr2RQmiaqXxiSmShTApi4XQFtqMls89/7v5wWXao2haOx97LBNpW
         iyaFuiGlxPnTn6bWN3u4TYnEO1hTbCw4PExaFpPYiWQCsXrepkdtLGXB35OYS+Ii1/OC
         rJSLLW9D565xy5o3Ff3j8ERdFKkTlTHQU5ZG3QYdT2THvOlxp6CGG2V8Luutz6bftRt6
         gc24WNIb1MfrbcaAzlGdf1l+trPvyKuiIuIP0/3vw/hpiW+93mlfeNVxz623fMlwW9fS
         LhlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721089425; x=1721694225;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=atOyFauWlMezUFieUVAk0q6tNEF19uog8150eFOHK5o=;
        b=O5xRQYA/KszXseqyTj92gS5G3R2ZgU/nA5lUiU9Y9w9ggNYoeI653vLdfV5/PEPqnk
         ZR30vF1wrSgP4yNST/KtDI1Uyl6qvEdfeCa7vgIltWm+ikuFpqWfu9L1NJBK+sly/UUG
         oZ2O3lFUN+TFpPlgLbMYOSZOuLTUbjB+OUE90aHamsIxxKqpsSZJgAL4RjhCWBHQn2fJ
         lNtu1ns1Z4Fzp92W8Nl+0lL1hvXs9IoHhl4j6pq5VmLBdKDh3bJ5L9hEaE98HW9EIkAj
         TdejStvCSPuHML+kZ+U0FnZbHJSiP43O2EUK72kNbCUBbAMiWgLWFFmlswChoyoynob7
         woYg==
X-Forwarded-Encrypted: i=1; AJvYcCUZ9mNjsULVkm9MHTuHhLdf16Ljr1oatO6V9HBBp5wMhCLjzlAb3LSv3PcMLpLPgNpOSwO7G9KnLI3mcrIOqIHXD+bDtKeP7XFEdJln
X-Gm-Message-State: AOJu0YwIEogZOGk1/gDQxb4PWUFz2rRjrLkpnzioTe1uqs6se674o65u
	WlqvFC/9r9wA3av3A1Hj/5dsijuiHSRL7aY3L0vkdM6/Yx4xaLgjZkG+PazHHAqSaz5cp833pFd
	BbJHWP0MsZG8ZkdyxOVxkecPVdQx03kLBCwsl
X-Google-Smtp-Source: AGHT+IE/kw/J8yKZw6NIetUbx7QF0zylSsoXWZkbL5jj7VHdECRTorHmo1jZJ3C3EkNfgS8fl+Q/Qni/Y4/oltYoqD8=
X-Received: by 2002:a05:622a:40cc:b0:447:e6c6:bd3 with SMTP id
 d75a77b69052e-44f7b93f886mr738431cf.21.1721089424804; Mon, 15 Jul 2024
 17:23:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240525013021.436430-2-irogers@google.com> <202405311548.1e881dea-oliver.sang@intel.com>
 <CAP-5=fX7ZyT82=W8uSZbT7c76E5+1JaoR5-y_gcj7A_=Js1YfA@mail.gmail.com>
 <Zl3Q7AtOWY8ZCcg8@xsang-OptiPlex-9020> <CAP-5=fU=UPpZTULuyZm=Ep0Ri6SdTciL5kqpciUfnWyDvz6HZg@mail.gmail.com>
 <CAP-5=fV5Qdu5iH_DKeAXQfEmQN9SmxCViSgbOCvAmN529WoeOw@mail.gmail.com> <ZmphzTKiDDYkPPP+@xsang-OptiPlex-9020>
In-Reply-To: <ZmphzTKiDDYkPPP+@xsang-OptiPlex-9020>
From: Ian Rogers <irogers@google.com>
Date: Mon, 15 Jul 2024 17:23:32 -0700
Message-ID: <CAP-5=fUUnnL18x_mdQdaCePOSbk5VWP3jfAS44n7qahD7pja5Q@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] perf jevents: Autogenerate empty-pmu-events.c
To: Oliver Sang <oliver.sang@intel.com>
Cc: oe-lkp@lists.linux.dev, lkp@intel.com, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Weilin Wang <weilin.wang@intel.com>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	Jing Zhang <renyu.zj@linux.alibaba.com>, John Garry <john.g.garry@oracle.com>, 
	Sandipan Das <sandipan.das@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 12, 2024 at 8:07=E2=80=AFPM Oliver Sang <oliver.sang@intel.com>=
 wrote:
> > > > but make still failed. I still saw below in our build log
> > > >
> > > > --- pmu-events/empty-pmu-events.c       2024-06-03 08:41:16.0000000=
00 +0000
> > > > +++ pmu-events/test-empty-pmu-events.c  2024-06-03 13:47:19.5224634=
82 +0000
> > > > @@ -136,7 +136,7 @@
> > > >  { 2623 }, /* M3\000\0001 / M3\000\000\000\000\000\000\000\00000 */
> > > >  { 2078 }, /* cache_miss_cycles\000group1\000dcache_miss_cpi + icac=
he_miss_cycles\000\000\000\000\000\000\000\00000 */
> > > >  { 1947 }, /* dcache_miss_cpi\000\000l1d\\-loads\\-misses / inst_re=
tired.any\000\000\000\000\000\000\000\00000 */
> > > > -{ 2011 }, /* icache_miss_cycles\000\000l1i\\-loads\\-misses / inst=
_retiredany\000\000\000\000\000\000\000\00000 */
> > > > +{ 2011 }, /* icache_miss_cycles\000\000l1i\\-loads\\-misses / inst=
_retired.any\000\000\000\000\000\000\000\00000 */

Hi Oliver,

I tried to reproduce the problem by installing more locales on my
machine, setting the environment variables, checking my environment
variables, etc. I couldn't reproduce it. Looking more closely at the
diff above and the other diffs in your email something strange appears
to be happening around dots.

From:
 --- pmu-events/empty-pmu-events.c
we know the minus lines are those from the files in this patch series.
From:
+++ pmu-events/test-empty-pmu-events.c
we know the plus lines are those generated by jevents.py.

In the diff output above the "inst_retired.any" doesn't match
"inst_retiredany" (no dot before the word "any"). The repository file
pmu-events/empty-pmu-events.c is missing the dot in the event name but
jevents.py is generating it, hence the diff. But looking at
pmu-events/empty-pmu-events.c in:
https://lore.kernel.org/lkml/20240525013021.436430-2-irogers@google.com/
The dot is present.

I think what is happening is that when you apply the patches for some
reason the dots are being consumed in
tools/perf/pmu-events/empty-pmu-events.c, the build then informs you
of this by failing. The locales idea was a red herring and this has
something to do with how you apply patches.

Does this make sense? Perhaps you can try testing the patches in an
ordinary client applying the patches using something like "b4 am
20240525013021.436430-1-irogers@google.com". At the moment I think the
patch series is good and I don't have a way to fix what I think the
problem is, with how you applied the patches.

Thanks,
Ian

