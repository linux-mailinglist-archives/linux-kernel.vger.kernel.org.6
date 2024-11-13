Return-Path: <linux-kernel+bounces-408439-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 43D139C7EE1
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 00:41:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C8E1E1F21C4A
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 23:41:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B13FA18C926;
	Wed, 13 Nov 2024 23:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="j5IOoWj5"
Received: from mail-il1-f175.google.com (mail-il1-f175.google.com [209.85.166.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C556018C91E
	for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 23:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731541254; cv=none; b=SsZ4f/onFJK5RxfAleDcaT9MlYos7aEDbNsNfcT/MThPc+ycnJ3LAnMOYiBuj7HAKLtV5ZN/PftviKUXMZ4jKZMJ9tNmnquwm1aIMgi6Ou0kkbwM6W5n/7NeZs4FZbQPwjBMfGBS6cR6oLwcAnR3oslSmKF3iJ8KuxBHmX+gHvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731541254; c=relaxed/simple;
	bh=n8nBYFsvDBCotCg58+sOi96R9rXZN7f73l2S1Mi5FS0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=O/0HYG6E5cQgNTMrTmnb28s3fgkilRqXwzTpqQdvtDheyHEdynTOnCVeJgnm28Imja3n22cLognFK2An0LbIdugdqmIzZZIdgDEDjIIOkp5sY174u/EnQofHEPTjwEWeCCmOb1Qu8js21Sfld6G+VB1lh++bF+iPX45QS0rH9Gw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=j5IOoWj5; arc=none smtp.client-ip=209.85.166.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-il1-f175.google.com with SMTP id e9e14a558f8ab-3a4e4776f79so26245ab.0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 15:40:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731541251; x=1732146051; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n8nBYFsvDBCotCg58+sOi96R9rXZN7f73l2S1Mi5FS0=;
        b=j5IOoWj577d0DjPAmKaqOE8qVMYcOi+KfY2JqooE6UTS6ZXeCXxAG9X4//BcyRAOor
         DzxG0p7CU1jUxvXP1CIyuvwGmmLKPbregpqhB7doECuCBt9mgbtZxGhQtfU/7ZRUIs9W
         f3a++xFe2uDQusom/FbaeLQPUUen6pdBwVk4HjqKIT2Zsi5jMjg9P5jgo3ufGH5A9A1/
         ZHHM+A2/WwZA4oElIuuFbzD02F77bAGoo7CGsVcejab1Up7Yp0knnanSuNfZNriri/R/
         PjDNHzobtdrFmOYhosIdgF1JhBs9G6qTitDU0FRUEgBZ1sVTYTf94Te4FjIhXTyQEWSd
         +giw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731541251; x=1732146051;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n8nBYFsvDBCotCg58+sOi96R9rXZN7f73l2S1Mi5FS0=;
        b=uV+3ENfCx0TUHSlWLmo+eJI64LV8fAvpRU8dvO52R3rwWtMryiQeWIaO9bxghfZYV1
         Q6DQRWTG2+3avE50rQgxSXmQoDc044BvjIIf5i/MOvCLD/cuSHFeXewfYMzfbSF/QoLW
         TC9HXcb1sRVljA1Q+R9OYq08DaJuFucUeJyA48sBlOG1/P8hU/9iXT9ale/TAPzgJj99
         b5VvbBSLw2uk+BV+WCA2yDFDTVWVrS2KL8cT29qzZaRsGvvhNWJXZYyypT4HeE6TkOwA
         YrKw2WUCPMqlDfxaApq30igv9Qz02nTDQa2A0zdQWdlxd7a0KstTaOzpeZ80cfQ6CKn0
         JY7Q==
X-Forwarded-Encrypted: i=1; AJvYcCUVuX9lDzXILiPeLMI513GstzXcnkWh8nPuSg2m5eT7agz4NmTc9pIxAWbPe4pDJGIAZtE9PxMocrQl9mA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyX/rab4o280mRYV0qRQuyCMipN84jupuBPtGf166srICq2Lqv3
	UCCoDp4CwLGFxRceMdW2f+LgI0sS4X63gBcPXOFvmI8hFnISyez2BAWdi+BkXLiVK1d29rTjF6m
	6r7gQoUa6qDOYij4WHmFsHZROfsoSioqSclqb
X-Gm-Gg: ASbGncveLDfUMUII1/pWI9NjnZ7s0vw1iRhom4jq9RfFQD4/lMrF5ddUMHr0BnaYZqR
	VtnsrOhFDMipmwDt07Cl+htl9tWFwUX4H3ends6D8DW09T85nEONNWoyQlYYK8rQ=
X-Google-Smtp-Source: AGHT+IEv/AxbLCrxL3qYhb4sdLAHJGoF9BYLR+kiCSSJ6XRxxnDn753DPoPlPrCyzeYVNz2q75bxxZw6sJpXgwiONm0=
X-Received: by 2002:a05:6e02:1d82:b0:3a1:a90f:74c6 with SMTP id
 e9e14a558f8ab-3a71f743df0mr386015ab.21.1731541250616; Wed, 13 Nov 2024
 15:40:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240926175035.408668-1-irogers@google.com> <bbbd024c-d2df-47ea-9587-f68e5bc45962@linux.intel.com>
 <CAP-5=fVX5wypmAAhR8LsE4nSWp5BmN_qhGf9+WCh2bebNcGYTg@mail.gmail.com> <07ee39aa-309f-4414-aee0-cc5b86a66af7@linux.intel.com>
In-Reply-To: <07ee39aa-309f-4414-aee0-cc5b86a66af7@linux.intel.com>
From: Ian Rogers <irogers@google.com>
Date: Wed, 13 Nov 2024 15:40:39 -0800
Message-ID: <CAP-5=fWP7-CjuJXRfdxD1mfAXtdwiq3e=j5i=ia7_UAKQAE+Gw@mail.gmail.com>
Subject: Re: [PATCH v4 00/22] Python generated Intel metrics
To: "Liang, Kan" <kan.liang@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Perry Taylor <perry.taylor@intel.com>, 
	Samantha Alt <samantha.alt@intel.com>, Caleb Biggers <caleb.biggers@intel.com>, 
	Weilin Wang <weilin.wang@intel.com>, Edward Baker <edward.baker@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 6, 2024 at 8:47=E2=80=AFAM Liang, Kan <kan.liang@linux.intel.co=
m> wrote:
>
>
>
> On 2024-10-09 12:02 p.m., Ian Rogers wrote:
> > On Fri, Sep 27, 2024 at 11:34=E2=80=AFAM Liang, Kan <kan.liang@linux.in=
tel.com> wrote:
> >>
> >>
> >>
> >> On 2024-09-26 1:50 p.m., Ian Rogers wrote:
> >>> Generate twenty sets of additional metrics for Intel. Rapl and Idle
> >>> metrics aren't specific to Intel but are placed here for ease and
> >>> convenience. Smi and tsx metrics are added so they can be dropped fro=
m
> >>> the per model json files.
> >>
> >> Are Smi and tsx metrics the only two metrics who's duplicate metrics i=
n
> >> the json files will be dropped?
> >
> > Yes. These metrics with their runtime detection and use of sysfs event
> > names I feel more naturally fit here rather than in the Intel perfmon
> > github converter script.
> >
> >> It sounds like there will be many duplicate metrics in perf list, righ=
t?
> >
> > That's not the goal. There may be memory bandwidth computed in
> > different ways, like TMA and using uncore, but that seems okay as the
> > metrics are using different counters so may say different things. I
> > think there is an action to always watch the metrics and ensure
> > duplicates don't occur, but some duplication can be beneficial.
>
>
> Can we give a common prefix for all the automatically generated metrics,
> e.g., general_ or std_?
> As you said, there may be different metrics to calculate the same thing.
>
> With a common prefix, we can clearly understand where the metrics is
> from. In case, there are any issues found later for some metrics. I can
> tell the end user to use either the TMA metrics or the automatically
> generated metrics.
> If they count the same thing, the main body of the metric name should be
> the same.

I'm reminded of the default events where some of the set fail on AMD,
and of AMD calling their topdown like metrics things like PipelineL1
and PipelineL2 rather than the Intel names of TopdownL1 and TopdownL2.
Like you I have a desire for consistent naming, it just seems we
always get pulled away from it.

I'm going to post a v5 of these changes, we carry them in:
https://github.com/googleprodkernel/linux-perf
but I'll not vary the naming for now.

Thanks,
Ian

