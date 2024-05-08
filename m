Return-Path: <linux-kernel+bounces-172583-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C1C908BF3FB
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 03:18:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 582AA1F212F7
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 01:18:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7778B664;
	Wed,  8 May 2024 01:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Bl9o57tS"
Received: from mail-il1-f179.google.com (mail-il1-f179.google.com [209.85.166.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A4678C1D
	for <linux-kernel@vger.kernel.org>; Wed,  8 May 2024 01:18:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715131081; cv=none; b=XlUC4dtBg4X7twGNIm2LTHA2xkRoQcDY2rzWXEzVfT6ZOn3Mv3iWZQfNYbUeK98U467iqdfHi2M+OcpKb87wxos+elv5oRBxiLanz4JxIvvnN+rWHdf5OC0ic+T/htGPVb+BRNLgqhkOAOX5RIEcp/atVN8bBFbQ7ZUcXdmmf/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715131081; c=relaxed/simple;
	bh=lU4K+YQogUbUsnBfG3NNfnWjg0twdDGt5SBtLLxhFNw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pksPHvVEJEltd6Qd5EuXK9GqRz/TwB45JmetI0zm86y5Wgh3U+gQ3SXPGTUcoJMu9ir1ZrDHzCdtw5IBr41MT0aoM0WT5pmx/FCg3thkn7aEdj8pEO3+1c/t920KkRO3+qYR397heNdJ/iiEZeGJoCIrTrCtRjGAyssAJ/ZCFqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Bl9o57tS; arc=none smtp.client-ip=209.85.166.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-il1-f179.google.com with SMTP id e9e14a558f8ab-36c670757aaso29805ab.1
        for <linux-kernel@vger.kernel.org>; Tue, 07 May 2024 18:18:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715131079; x=1715735879; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E61N4amXuh7VFXvwkeviInZfYjjo6QzIfwyPvrMCCcw=;
        b=Bl9o57tS40e+ehYxJ1unbKKMxFZVxNpbSeS/QNROZfx/8/IhfwDSqFlg68kPSiLa3B
         hlkolYnSdY/6Ff4d+73vyCtC6qOlcvyt+2lNg+KE15bsqNr76SHLrgtGew+QUKR1GwhR
         hASPuRnOyKMEFJE3xkw0tWlKU5fWV63fHQnY/9xNOB/Z4ilW1dohHVKcPdisprGMiLnz
         k7l+AoKvnT0dAch+raPipWbeqrlbRKhF4pRmvllWR+dBWAVSG0JKGbEMOSLZRH0Cf7uK
         HpF1kPv5+r/Jpj7MSEKwztVZImNXzQBKCk2N8WV1GlqGXEYMxK3xad0g6K6kCb+yyO8S
         sckQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715131079; x=1715735879;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E61N4amXuh7VFXvwkeviInZfYjjo6QzIfwyPvrMCCcw=;
        b=LeFtwsm5MV5aUvpgDLhvMtjJX+QJINy5lfdXU8yl53ZMnsrKbHR5wSQhDwKABmUKj2
         5H8absaw0hg/JG6kDwwX2gY9fr9lThJHHOg41b5qnCoGy48/RMQyuOao9mDnaHGJIlwu
         8f/6iHBwh9mgffKr5tCQkWuFFMgw6UyyPt+Zl0LUeCXvtubJ+hvbMfV8B9n4JcRU4Jdi
         CPFZPQaPhngzEswLVaXgOqr7JsrbaUooBN6ywLCEbPqA6ABkNHUktQR5MleQRcxHeR8w
         Od0pmZdeJcMNCe7Y2MiERExBMybR466niqbqBKYrETFdarBOm6osXN4zJBWyB7r3PHXb
         m1ng==
X-Forwarded-Encrypted: i=1; AJvYcCVp95PzeA66bt4uLRipdi5Qg3hmJL93Yv5QeBO+g/31JTyRwugSbZdjYlB5lFX1JO8bwbKdDyt5vdWbhPTvvFtCKGpr+MOT96tGC1Ef
X-Gm-Message-State: AOJu0YxEFFUHSSMYCFxsHVD67fsynqq6axindhUF3C+BFcQzckqPF+45
	XpG/oQekTtRCkPHxDge9IMEAdOC1Ph5PjkvWXczL+PXbXhDAiHqEFlfhkuLqPvw/doLnlFlKFvj
	5srSm3JnGCPt1nVphskRmW6UL+S5YTCdY5vGM
X-Google-Smtp-Source: AGHT+IFBz2W1yTDMxub+q7KowdMvJNhvJCXzRPvm1KP8cXNpVbqEhvCyff1MhD6Ly+rCmFpk7cKugA6/tNh04s2sLJQ=
X-Received: by 2002:a05:6e02:1ca5:b0:36c:5f5a:b90c with SMTP id
 e9e14a558f8ab-36cafeb96fdmr757955ab.23.1715131079449; Tue, 07 May 2024
 18:17:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240507183545.1236093-1-irogers@google.com> <20240507183545.1236093-2-irogers@google.com>
 <ZjqNKPgWR7mBFaV4@x1> <ZjqNjrJ2ElrT11iB@x1> <CAP-5=fUsQwKsCi3us+dp-Tj+PayNPrYTqTQeo-YLbvSuOt1=9w@mail.gmail.com>
 <ZjqXa25BnFncJmw-@x1> <ZjqYD-q7EqQW6hVE@x1> <CAP-5=fVRBXv0H3vRNYO_uwWsNGvBxWVXd78UOu0QvGK04+bERw@mail.gmail.com>
 <CA+JHD90W7PLBx=SEL9+7-_=LkjaMu4YM1S3kJ2oSkAYoHE7hPw@mail.gmail.com>
In-Reply-To: <CA+JHD90W7PLBx=SEL9+7-_=LkjaMu4YM1S3kJ2oSkAYoHE7hPw@mail.gmail.com>
From: Ian Rogers <irogers@google.com>
Date: Tue, 7 May 2024 18:17:47 -0700
Message-ID: <CAP-5=fU1E4xY-DEpSh0ThGj+y4hmGHD9sMF_FPFBpAUuK6Pt3Q@mail.gmail.com>
Subject: Re: [PATCH v1 1/8] perf ui browser: Don't save pointer to stack memory
To: Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	Oliver Upton <oliver.upton@linux.dev>, James Clark <james.clark@arm.com>, 
	Tim Chen <tim.c.chen@linux.intel.com>, Yicong Yang <yangyicong@hisilicon.com>, 
	K Prateek Nayak <kprateek.nayak@amd.com>, Yanteng Si <siyanteng@loongson.cn>, 
	Sun Haiyong <sunhaiyong@loongson.cn>, Kajol Jain <kjain@linux.ibm.com>, 
	Ravi Bangoria <ravi.bangoria@amd.com>, Li Dong <lidong@vivo.com>, Paran Lee <p4ranlee@gmail.com>, 
	Ben Gainey <ben.gainey@arm.com>, Andi Kleen <ak@linux.intel.com>, 
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, 
	linux-perf-users <linux-perf-users@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 7, 2024 at 6:07=E2=80=AFPM Arnaldo Carvalho de Melo
<arnaldo.melo@gmail.com> wrote:
>
>
>
> On Tue, May 7, 2024, 9:51 PM Ian Rogers <irogers@google.com> wrote:
>>
>> On Tue, May 7, 2024 at 2:07=E2=80=AFPM Arnaldo Carvalho de Melo <acme@ke=
rnel.org> wrote:
>> >
>> > On Tue, May 07, 2024 at 06:04:43PM -0300, Arnaldo Carvalho de Melo wro=
te:
>> > > On Tue, May 07, 2024 at 01:48:28PM -0700, Ian Rogers wrote:
>> > > > On Tue, May 7, 2024 at 1:22=E2=80=AFPM Arnaldo Carvalho de Melo <a=
cme@kernel.org> wrote:
>> > > > >
>> > > > > On Tue, May 07, 2024 at 05:20:59PM -0300, Arnaldo Carvalho de Me=
lo wrote:
>> > > > > > On Tue, May 07, 2024 at 11:35:38AM -0700, Ian Rogers wrote:
>> > > > > > > ui_browser__show is capturing the input title that is stack =
allocated
>> > > > > > > memory in hist_browser__run. Avoid a use after return by str=
dup-ing
>> > > > > > > the string.
>> > > > > >
>> > > > > > But everything happens in that context, i.e. hist_brower__run(=
) will
>> > > > > > call ui_browser__ methods and then exit.
>> > > > > >
>> > > > > > We end up having browser->title pointing to returned stack mem=
ory
>> > > > > > (invalid) but there will be no references to it, no?
>> > > > > >
>> > > > > > If we return to hist_browser__run() we then call ui_browser__s=
how
>> > > > > > passing a new title, for "live" stack memory, rinse repeat. Or=
 have you
>> > > > > > noticed an actual use-after-"free"?
>> > > > >
>> > > > > And I'll take the patch, I'm just trying to figure it out if it =
fixed a
>> > > > > real bug or if it just makes the code more future proof, i.e. to=
 avoid
>> > > > > us adding code that actually uses invalid stack memory.
>> > > >
>> > > > My command line using tui is:
>> > > > $ sudo bash -c 'rm /tmp/asan.log*; export
>> > > > ASAN_OPTIONS=3D"log_path=3D/tmp/asan.log"; /tmp/perf/perf mem reco=
rd -a
>> > > > sleep 1; /tmp/perf/perf mem report'
>> > > > I then go to the perf annotate view and quit. This triggers the as=
an
>> > > > error (from the log file):
>> > > > ```
>> > >
>> > > Thanks, it is indeed a bug, I'll keep that Fixes tag, people interes=
ted
>> > > in the full details can hopefully find this message going from the L=
ink:
>> > > tag.
>> >
>> > Nah, I added your explanation to the cset log message.
>>
>>
>> Okay, I found I needed this to avoid a segv introduced by this patch:
>> ```
>> diff --git a/tools/perf/ui/browser.c b/tools/perf/ui/browser.c
>> index c4cdf2ea69b7..19503e838738 100644
>> --- a/tools/perf/ui/browser.c
>> +++ b/tools/perf/ui/browser.c
>> @@ -203,7 +203,7 @@ void ui_browser__refresh_dimensions(struct
>> ui_browser *browser)
>> void ui_browser__handle_resize(struct ui_browser *browser)
>> {
>>        ui__refresh_dimensions(false);
>> -       ui_browser__show(browser, browser->title, ui_helpline__current);
>> +       ui_browser__show(browser, browser->title ?: "", ui_helpline__cur=
rent);
>>        ui_browser__refresh(browser);
>> }
>> ```
>> I also found a use-after-free issue with patch 5. I'll send a v2.
>>
>> Please send a fix, it's already in perf-tools-next.
>

Okay. It looks like you accidentally pushed tmp.perf-tools.next, that
is a .next rather than a -next (dot not dash). I'll work from
perf-tools-next.

Thanks,
Ian

> Thanks,
>
> - Arnaldo
>
>> Thanks,
>> Ian
>>
>> > Thanks,
>> >
>> > - Arnaldo

