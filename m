Return-Path: <linux-kernel+bounces-212297-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A1E5905DF2
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 23:47:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A17AAB23D22
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 21:47:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F03E1292FF;
	Wed, 12 Jun 2024 21:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tvGJgy3f"
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4768A86252
	for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 21:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718228817; cv=none; b=o57hhWEqmqjeSeNNx4OmGKTGDVoKILQrEIGd3/qPeJIbNcx2hC1xbK1Dv1Mw9S8lKhvu2w8HRhcHlHf3724elRdgaM+/ByIS1lvQu+rgPMnGd+hgsOS2GqcPSLohEnJT8YUWjsUKxO3UFQixOTngPjNcCjgM9u8i+C9hgDqDlwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718228817; c=relaxed/simple;
	bh=+InWqwc59WaX46vE5AxcsSfl1jFryAeQ5J5u3z8pMrY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YqRfA8GZzllZuDE6AtF9UMcIuZiMXUXK3eVFrPZFLhQ5LTVJ56TlZiremVRVY4giYRNBLiGX7zpYCRYteQMw6LBP9WHQRa76d5oLhATQZIvE8ZNI7akdpKscGTisGk27oNwSy/DBlG/+xla4BDlP/2TqF1kA+NFHQxRhOANoAPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tvGJgy3f; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-4405cf01a7fso58571cf.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 14:46:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1718228815; x=1718833615; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XGFO/gWpjWxRc6zdNFKUtA+WWgn2yoVFVUtmjvc0LMM=;
        b=tvGJgy3fw1wjv83IS6iWRyxq+V76Z471ZFGQD1m/yrydchGf+5EG5EDf9yGr4ivrw/
         vg1szCuPNLu+woaO2eW+tjX6MQn8106h9wFyORHWJN/+7lh4nNojjrjbC0x9/loSPOs/
         eQFETMITZHkmJ3gnSLTIms7qMHB8Ky5SRn7yWgfp4gEclZnyoIAq6lTiV5pHFjyVktXU
         xJ7YQSVR8wdT2+E65LKV7mcK012En0KgwZkuAMp+j3H8ISIkMH2Rb09jFMcZx4vlDdKx
         bjl/sBtS2EY2WRiwM9V4KP602Yw1hcnJO5YmjaN5hjpwYRlzkMT1Z64EGxfG6GKnDgLz
         zHPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718228815; x=1718833615;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XGFO/gWpjWxRc6zdNFKUtA+WWgn2yoVFVUtmjvc0LMM=;
        b=NgoipcgDZ3LJ4mSjdMEBDGCkRE4tygCEexS+PbGae+Kq/AC8wM/Cn1tWBGa7FYP9uB
         Mk8jj13VxOJRKc9abL5nHgmt/72eN9iODMq57YNUeXlfYZknG0JJpewcHV2+0OAykqLH
         LXxtdfnzNol6xbpwjejTygfaiHN+xTWTVu/fXO3adQvNL6KvhhyTF3RBTNfSEEGZu90X
         LG4bwiaSa15CgzDwk+A9Oi6SQYU8hk1BrSDY87SVqQYPzedMWfhEpBrv2kaoCbwxzQde
         Jate8Xc+y7l3Jozcb540r8xS/ru7URKipV7EL9zakrtxi1L+pxp7Yj72BmIBJ1NzIZsr
         NHZg==
X-Forwarded-Encrypted: i=1; AJvYcCW8AcszqHaYVkWP+u0LO2xeGSwE3i2aUWKozMf/kKT9VSGzVHQD2CW6TOqa+5X96emoop9i3eDp4tZhnZ1YtpyOFSuIpmStOIv/gRTt
X-Gm-Message-State: AOJu0YzXUf20zeE8zTBbktb7l5c8c4TAyjoAr6lgT5it/H5dz0uSbd1d
	nI89GG+xnzVyIJOWtrE/0V47Onu0SE5VFrpZnpnVRnRoJiMUj7IA9Dsrls0i/y9326eTtA2jNEl
	yuLv9gQ3Eug8wAM1ZFb0yfArjNpr+eQezOiYV
X-Google-Smtp-Source: AGHT+IF7kA7jzJbe/avrLLkOmazBUAeVUG1MPaJsw0sfB3QphtF3xLPAgEAF+B2A3ZPJawxP8BglPYnijgmcaHbwINE=
X-Received: by 2002:a05:622a:1b17:b0:43e:cb4:1d10 with SMTP id
 d75a77b69052e-441a1272b40mr740741cf.14.1718228814988; Wed, 12 Jun 2024
 14:46:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240525013021.436430-2-irogers@google.com> <202405311548.1e881dea-oliver.sang@intel.com>
 <CAP-5=fX7ZyT82=W8uSZbT7c76E5+1JaoR5-y_gcj7A_=Js1YfA@mail.gmail.com>
 <Zl3Q7AtOWY8ZCcg8@xsang-OptiPlex-9020> <CAP-5=fU=UPpZTULuyZm=Ep0Ri6SdTciL5kqpciUfnWyDvz6HZg@mail.gmail.com>
In-Reply-To: <CAP-5=fU=UPpZTULuyZm=Ep0Ri6SdTciL5kqpciUfnWyDvz6HZg@mail.gmail.com>
From: Ian Rogers <irogers@google.com>
Date: Wed, 12 Jun 2024 14:46:43 -0700
Message-ID: <CAP-5=fV5Qdu5iH_DKeAXQfEmQN9SmxCViSgbOCvAmN529WoeOw@mail.gmail.com>
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

On Mon, Jun 3, 2024 at 8:46=E2=80=AFAM Ian Rogers <irogers@google.com> wrot=
e:
>
> On Mon, Jun 3, 2024 at 7:19=E2=80=AFAM Oliver Sang <oliver.sang@intel.com=
> wrote:
[...]
> > I tried below patch
> >
> > commit a79a41133a41adc2d69c8f603c7d880b3796cbf7
> > Author: 0day robot <lkp@intel.com>
> > Date:   Mon Jun 3 16:35:45 2024 +0800
> >
> >     fix from Ian Rogers: invoke "diff -w -u" instead of "diff -u"
> >
> > diff --git a/tools/perf/pmu-events/Build b/tools/perf/pmu-events/Build
> > index c3fa43c497069..54d19b492db5c 100644
> > --- a/tools/perf/pmu-events/Build
> > +++ b/tools/perf/pmu-events/Build
> > @@ -39,7 +39,7 @@ $(TEST_EMPTY_PMU_EVENTS_C): $(JSON) $(JSON_TEST) $(JE=
VENTS_PY) $(METRIC_PY) $(ME
> >
> >  $(EMPTY_PMU_EVENTS_TEST_LOG): $(EMPTY_PMU_EVENTS_C) $(TEST_EMPTY_PMU_E=
VENTS_C)
> >         $(call rule_mkdir)
> > -       $(Q)$(call echo-cmd,test)diff -u $? 2> $@ || (cat $@ && false)
> > +       $(Q)$(call echo-cmd,test)diff -w -u $? 2> $@ || (cat $@ && fals=
e)
> >
> >  $(PMU_EVENTS_C): $(JSON) $(JSON_TEST) $(JEVENTS_PY) $(METRIC_PY) $(MET=
RIC_TEST_LOG) $(EMPTY_PMU_EVENTS_TEST_LOG)
> >         $(call rule_mkdir)
> >
> >
> > but make still failed. I still saw below in our build log
> >
> > --- pmu-events/empty-pmu-events.c       2024-06-03 08:41:16.000000000 +=
0000
> > +++ pmu-events/test-empty-pmu-events.c  2024-06-03 13:47:19.522463482 +=
0000
> > @@ -136,7 +136,7 @@
> >  { 2623 }, /* M3\000\0001 / M3\000\000\000\000\000\000\000\00000 */
> >  { 2078 }, /* cache_miss_cycles\000group1\000dcache_miss_cpi + icache_m=
iss_cycles\000\000\000\000\000\000\000\00000 */
> >  { 1947 }, /* dcache_miss_cpi\000\000l1d\\-loads\\-misses / inst_retire=
d.any\000\000\000\000\000\000\000\00000 */
> > -{ 2011 }, /* icache_miss_cycles\000\000l1i\\-loads\\-misses / inst_ret=
iredany\000\000\000\000\000\000\000\00000 */
> > +{ 2011 }, /* icache_miss_cycles\000\000l1i\\-loads\\-misses / inst_ret=
ired.any\000\000\000\000\000\000\000\00000 */
> >
> >  };
> >
> >
> > I will try to get generated test-empty-pmu-events.c tomorrow.
>
> Thanks Oliver, if you could get the environment variables that would
> probably also be useful.

Hi Oliver, any update on this?

Thanks,
Ian

