Return-Path: <linux-kernel+bounces-378435-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 65CD29AD025
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 18:23:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 865A61C216FA
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 16:23:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F7E1DDAB;
	Wed, 23 Oct 2024 16:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RZ2OEVlk"
Received: from mail-il1-f180.google.com (mail-il1-f180.google.com [209.85.166.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3680F1CF5CB
	for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 16:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729700519; cv=none; b=KYXEcCvSMQ7Z1VyzOz6W+fR3WKvlnZgjM8cWVjb1eUf6/Edp4Gf1EndEXJgcjkD/rB1q4xQCRFU8peG68OnqkuuJLmaSehoYcINordcWL3y6VNQ4AAYBfiz7sCkShzD7EjbrNgWZYn2krfXqztxodNZW9N0cPiVYlYiv9hETLf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729700519; c=relaxed/simple;
	bh=/6sJmUbVa075/2cJK4skj7BHysXq7tGj2B1qeBXMgJM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lOG2b3MEEzswT30MTZ817HQRyEChLHZ+cVStixAHGYm9q4q1TVgLxnIsMqK9ObZ0Jg2c3HP+uo9lvLUv3pR/IZsFCx3L6x8qSGx16qPJqfC4pIWMkWhEvsaRrPhKrZd2UwNprdTaCOcy4xontVgDIeWasCmfbtu9rIPRyDRzjcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RZ2OEVlk; arc=none smtp.client-ip=209.85.166.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-il1-f180.google.com with SMTP id e9e14a558f8ab-3a3b3f4b599so292025ab.0
        for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 09:21:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729700517; x=1730305317; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z6gVVsJsEbQ5uCM8tNUGaNGrvWYSjGgtsnkcn53KQus=;
        b=RZ2OEVlkS8Qg9ta/me4PXLhdjRt1NJCD0l8cSqfeH3WR5hkUhSpP9VlN5XnyaM3jo2
         FGmLW1FEzsjLePd8ACI/UEuHFp+JsN5SS7s/9a6sxaPJpvNb6QqEYbeUZkeKrUsdpDtH
         mWELHDzmH8+2RbVuX66GUDTLIABgI9hNWAO00bosKZubpcVj/56BwnaV0HLbFdgTRBOn
         OwHsIeXCajGgqbelXRii3RuJNtvFFzM1I1eT4e2YDayV+QOQDHqinL0JlHpETOM0pssf
         SScJmBPf0yrFjNUDa9S+6HzV6wRcE0GhZBfsvcJB/HwT2s3u+L8jpFz3WxJXu09r8VIO
         5Ijg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729700517; x=1730305317;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z6gVVsJsEbQ5uCM8tNUGaNGrvWYSjGgtsnkcn53KQus=;
        b=b3GRme6r1yeWWh+vKh7WIWZoREngGqox2PGXpPxhbmhfjr5fjKcL7v/p6pwJZJ0VOa
         n8xhvXx2CBoqDJcVhpHz3+X3wBbRewp375y5GPFFxVlcy4jZANVdzIbPmOmm7PIj9RgJ
         c6DeGUKk+uROb8cbJ7PzIrsoSEwtbZhemaNspjjoKv7MtVwJ7cCwQFvUAf3TMKgPv8Ps
         +ZDvHIPQvyswhtIJqe2bh9XwtW8OmEHnE1GmGkTI0i5rsanIj8y07ZTAtmBsX1Ujt/LR
         enr3CWmw8ClMvOZg0ZKigB44/jIMGNsEwzS2LtAWV3igLiDwhY5Wrh7ITVCmm36/RsVO
         fYBg==
X-Forwarded-Encrypted: i=1; AJvYcCXwbsSZZ3dJ+sVo+6cmbfilKS0pIIs4D5uaml43KSfPldlplzp+NCVE1pSM9e/JvWPAd0h/s1QdAXa8nog=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywh8lrYy9WzcqjSBgQ4LJdWfnqYCAbG4gkvwhKdI/oE53qHp9h0
	n0whbkX/m7IkYBH10GgP+DrZ41LkmYoZHWxQom/nIGNRBLMwJntQLjHDBXvHHc3KmXElIoV59Uj
	oenv814D2UxTOztIB7GUNTRZnbt4qF6FCRguX
X-Google-Smtp-Source: AGHT+IFSL7h1IhoUU7h89vmOMfDp8CfdFyRlLwTeLT/Y7+saBJThEWlI34jE8UgigUDaIJKy+4dJbuNgR18sZY3+uJE=
X-Received: by 2002:a05:6e02:17c8:b0:3a3:dab0:2399 with SMTP id
 e9e14a558f8ab-3a4dc308c56mr503505ab.27.1729700517163; Wed, 23 Oct 2024
 09:21:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240606044959.335715-1-irogers@google.com> <c7d6eedb-7c5e-4411-a83f-4328dc75ec46@linux.intel.com>
 <CAP-5=fXY2Ofr_GRc7Mq7BfoR+2150o8e1JeyGctcGPRG70DqPg@mail.gmail.com> <060b220d-f7d6-4594-9b2b-e878a2ba98c6@arm.com>
In-Reply-To: <060b220d-f7d6-4594-9b2b-e878a2ba98c6@arm.com>
From: Ian Rogers <irogers@google.com>
Date: Wed, 23 Oct 2024 09:21:45 -0700
Message-ID: <CAP-5=fU+pigNLi+cTFwEmyG5tO+JHTGDgWh1sYbCiX5TppdLnQ@mail.gmail.com>
Subject: Re: [RFC PATCH v2] perf Documentation: Describe the PMU naming convention
To: Robin Murphy <robin.murphy@arm.com>
Cc: "Liang, Kan" <kan.liang@linux.intel.com>, Randy Dunlap <rdunlap@infradead.org>, 
	Tuan Phan <tuanphan@os.amperecomputing.com>, Thomas Richter <tmricht@linux.ibm.com>, 
	Bhaskara Budiredla <bbudiredla@marvell.com>, Bharat Bhushan <bbhushan2@marvell.com>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@arm.com>, 
	Ravi Bangoria <ravi.bangoria@amd.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Will Deacon <will@kernel.org>, 
	Stephane Eranian <eranian@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 23, 2024 at 2:34=E2=80=AFAM Robin Murphy <robin.murphy@arm.com>=
 wrote:
>
> On 2024-10-23 5:06 am, Ian Rogers wrote:
> > On Thu, Jun 6, 2024 at 11:15=E2=80=AFAM Liang, Kan <kan.liang@linux.int=
el.com> wrote:
> >>
> >>
> >>
> >> On 2024-06-06 12:49 a.m., Ian Rogers wrote:
> >>> It is an existing convention to use suffixes with PMU names. Try to
> >>> capture that convention so that future PMU devices may adhere to it.
> >>>
> >>> The name of the file and date within the file try to follow existing
> >>> conventions, particularly sysfs-bus-event_source-devices-events.
> >>>
> >>> Signed-off-by: Ian Rogers <irogers@google.com>
> >>> Reviewed-by: Randy Dunlap <rdunlap@infradead.org>
> >>> ---
> >>>   .../testing/sysfs-bus-event_source-devices    | 24 ++++++++++++++++=
+++
> >>>   1 file changed, 24 insertions(+)
> >>>   create mode 100644 Documentation/ABI/testing/sysfs-bus-event_source=
-devices
> >>>
> >>
> >> Reviewed-by: Kan Liang <kan.liang@linux.intel.com>
> >
> > Thanks for all the reviews. Could we land this?
>
> Hmm, it's not always going to be strictly true as written though - we
> will also have cases where multiple PMU instances owned by the same
> driver don't all support the same events/filters/etc., and/or are
> entirely unrelated such that the same event encoding may mean completely
> different things. I've just landed a driver where not only are the
> instances going to be heterogeneous (since it's for arbitrary bits of
> interconnect), but for hierarchy reasons the most logical place to put
> the instance ID in the name wasn't even at the end :(

Right, I was trying to capture what the tool is doing and trying to
encompass the problems hex suffix create. Another example of that
problem recently burning us is ARM's PMU naming of armv8_pmuv3_a53
means the a53 looks like a hex suffix. When ARM release a model with a
3 digit number will the naming break? Wrt filters, I wonder if there
should be testing, bugs, etc. The wildcard matching will likely do its
thing and I think the failures should be predictable and descriptive,
like an event used a format that a PMU doesn't support, but I'm not
sure if we should do improvements in `perf list` where we try to
deduplicate PMUs. Perhaps the deduplication should be smarter.


> FWIW I think if we want to nail down a strict ABI, it would seem more
> robust to have an explicit attribute to describe underlying PMU
> properties like whether instances do represent identical "slices" or
> not. The hex suffix thing is already proving how fragile names alone are
> liable to be.

Agreed. Does this mean we shouldn't land this? I worry that LKML is
the home of bike shedding conversations and we're likely to bike shed
trying to achieve 'perfect' while something 'good' would have value
today.

Thanks,
Ian

> >>> diff --git a/Documentation/ABI/testing/sysfs-bus-event_source-devices=
 b/Documentation/ABI/testing/sysfs-bus-event_source-devices
> >>> new file mode 100644
> >>> index 000000000000..79b268319df1
> >>> --- /dev/null
> >>> +++ b/Documentation/ABI/testing/sysfs-bus-event_source-devices
> >>> @@ -0,0 +1,24 @@
> >>> +What: /sys/bus/event_source/devices/<pmu>
> >>> +Date: 2014/02/24
> >>> +Contact:     Linux kernel mailing list <linux-kernel@vger.kernel.org=
>
> >>> +Description: Performance Monitoring Unit (<pmu>)
> >>> +
> >>> +             Each <pmu> directory, for a PMU device, is a name
> >>> +             optionally followed by an underscore and then either a
> >>> +             decimal or hexadecimal number. For example, cpu is a
> >>> +             PMU name without a suffix as is intel_bts,
> >>> +             uncore_imc_0 is a PMU name with a 0 numeric suffix,
> >>> +             ddr_pmu_87e1b0000000 is a PMU name with a hex
> >>> +             suffix. The hex suffix must be more than two
> >>> +             characters long to avoid ambiguity with PMUs like the
> >>> +             S390 cpum_cf.
> >>> +
> >>> +             Tools can treat PMUs with the same name that differ by
> >>> +             suffix as instances of the same PMU for the sake of,
> >>> +             for example, opening an event. For example, the PMUs
> >>> +             uncore_imc_free_running_0 and
> >>> +             uncore_imc_free_running_1 have an event data_read;
> >>> +             opening the data_read event on a PMU specified as
> >>> +             uncore_imc_free_running should be treated as opening
> >>> +             the data_read event on PMU uncore_imc_free_running_0
> >>> +             and PMU uncore_imc_free_running_1.
>

