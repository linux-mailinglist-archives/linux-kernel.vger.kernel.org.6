Return-Path: <linux-kernel+bounces-177779-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BFBA8C448B
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 17:49:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BBC091F22988
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 15:49:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9223915443D;
	Mon, 13 May 2024 15:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="N0OijpHl"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CB4E153BE6
	for <linux-kernel@vger.kernel.org>; Mon, 13 May 2024 15:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715615332; cv=none; b=pG9Y4vJGNxB2JsqYC7LBHMKKZAAOATJ9JnP3Ziq0cGj8J6M7XaYzME1AKpjplyWUmN/MmFpOEmmFTf55wC17xfCFLx9G42GH7CVZCOVL9gunzC3MMpc633dNrbfeLnOwgGOZJmmZ6QuRgPcKn+SU54ZJ56tzhMDy3Hza0cfvdRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715615332; c=relaxed/simple;
	bh=4PHST+75MmCsC59iF4Z7sYgddRT/S6IfMjcgvunmaa0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=apkwffrQUy0CXWe9OsLygUBTQ/MDFBZFc9qyo43hXNS9W5e8rpS3kR7NDOHTuUAdrAZxMdsEIE4LkXVIN8w80k6Va6TYtKmoBFmi8uHaX4A97bpzVbFGpW7ZEYo/sFcz3r0fqcd7eZht1c/IrB5W1SeKalxohq8PXzzVns3OURI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=N0OijpHl; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1ec76185c0fso264095ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 13 May 2024 08:48:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715615329; x=1716220129; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yYQ0gjixSfurkzUiaxNduoPe4FC+QiIMjqkq94QKpYA=;
        b=N0OijpHlS9ZaswLqjMNqSFLKS8TmbXrKgn0KxuuRM8aXSQz+C+UgQk87rXrEVbDVio
         e8Q9ReewOpIO7cPS/8aC1TD3Js3wBQKslURx/5VuFwAwY8kLKQhC/raR/0tQhOFIppyO
         BzE34TBvjVv5+s/0yDm9pDICNxW7OfwJACAKAy7swhalQE6H9QVfjKDqdCBCpLm7bUts
         NK7w0TF9j3oAk/rd1bDUxxfb85zHlNr46OIEpnPK4R0mvIe8shlNH0mYO0VS2BLgJTNW
         G2MllmdVjvc00favt/VWK+UFXbCD2volXSCwdcGYEMe2Gm7W0v+11PX6TZB7QBBYnrdo
         92HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715615329; x=1716220129;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yYQ0gjixSfurkzUiaxNduoPe4FC+QiIMjqkq94QKpYA=;
        b=BUCjmlVB7NkY8nP8G7c5Fz/on0aEbWvTNB6dU0Jxzt5HuEpREbAzD7Augz9JwLWS6K
         nrJ2QrBbFA0Y+XfMF+E4L/THQYSv9qVR+s1qQ5fzs8vFFe+3jcRwycuKAkrsWBUkPbyH
         QkXDl+LPJjfTM1P/pTKWZSbaMbVF0ksgt7WXjiptNhPtd+7Fe6eKWIFqPAOSxIiuFqCL
         Q7PPl0sesoEjGf21epOAD7thJhXENPkZN9AOFaOkDhUHGQBC0m5M6JbthfsifzpKbLZr
         sPhcD4jLYzVjJ9w6eq7yp7o1P2EEbYFK3EiooBkDjxi2l83kLxGQTXwz1ulV18NvM5ON
         xzyw==
X-Forwarded-Encrypted: i=1; AJvYcCXjU5o2yoZgFxZ3VLadcKZlQ1ACGmT+W3ngkZLU9dEzas5LMxXZjr08ZB6z/j5IMOPk5+Xoljj9xjcD1wr/Jw87gP0AErlB9YF2+f1d
X-Gm-Message-State: AOJu0YyLT8V5c+pTASLDwzatQazks09YmiRd9Hwgp/FaGbTbZnIDF2ay
	UxnAc6bFL9CpIdMLyJMrKr4AuSeBLdY0WfGCJRw5siVQeAAWsJ6WvdluxmbO7ik2HY/0FAkloaI
	6HVbVX0Z5aFuF9rKwn0Je7gdp7iuAX0YOli6G
X-Google-Smtp-Source: AGHT+IHFPeUwje6u46qQGp/yl62ewYxSbg8BroLP1qrZakkaZuri3+FL8GC0Bmy0hAkLluYgzs5xr2jZm4ojRCLZVhU=
X-Received: by 2002:a17:903:298c:b0:1e9:4b4:907b with SMTP id
 d9443c01a7336-1f05f661701mr3954125ad.6.1715615328876; Mon, 13 May 2024
 08:48:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240505031624.299361-1-irogers@google.com> <CAP-5=fVSAQOXbSfpSLTVkWcZKGx+LqiuC_ZkCxnc0iPtyfrzvQ@mail.gmail.com>
 <CAP-5=fXuneU6ockdzFcnLGqATKkEfvEuTa778Hj92rBmkbiS1w@mail.gmail.com> <34da7677-9c77-4efa-ae32-e0ef9a94013d@arm.com>
In-Reply-To: <34da7677-9c77-4efa-ae32-e0ef9a94013d@arm.com>
From: Ian Rogers <irogers@google.com>
Date: Mon, 13 May 2024 08:48:37 -0700
Message-ID: <CAP-5=fWwVNB0194npwSkW2RM0t0wYLrMKxTMXJAaquBZXRZjoA@mail.gmail.com>
Subject: Re: [PATCH v3 0/2] perf pmus: Sort/merge/aggregate PMUs like mrvl_ddr_pmu
To: Robin Murphy <robin.murphy@arm.com>
Cc: Thomas Richter <tmricht@linux.ibm.com>, Bhaskara Budiredla <bbudiredla@marvell.com>, 
	Bharat Bhushan <bbhushan2@marvell.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	James Clark <james.clark@arm.com>, Ravi Bangoria <ravi.bangoria@amd.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Will Deacon <will@kernel.org>, Stephane Eranian <eranian@google.com>, 
	Tuan Phan <tuanphan@os.amperecomputing.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 13, 2024 at 7:35=E2=80=AFAM Robin Murphy <robin.murphy@arm.com>=
 wrote:
>
> On 2024-05-10 8:15 pm, Ian Rogers wrote:
> > On Fri, May 10, 2024 at 11:13=E2=80=AFAM Ian Rogers <irogers@google.com=
> wrote:
> >>
> >> On Sat, May 4, 2024 at 8:16=E2=80=AFPM Ian Rogers <irogers@google.com>=
 wrote:
> >>>
> >>> The mrvl_ddr_pmu is uncore and has a hexadecimal address
> >>> suffix. Current PMU sorting/merging code assumes uncore PMU names
> >>> start with uncore_ and have a decimal suffix. Add support for
> >>> hexadecimal suffixes and add tests.
> >>>
> >>> v3. Rebase and move tests from pmus.c to the existing pmu.c.
> >>>
> >>> Ian Rogers (2):
> >>>    perf pmus: Sort/merge/aggregate PMUs like mrvl_ddr_pmu
> >>>    perf tests: Add some pmu core functionality tests
> >>
> >> Hi, these patches have been hanging around since March [1], it would
> >> be nice to either be landing them or getting feedback on what to fix.
> >>
> >> Thanks,
> >> Ian
> >>
> >> [1] https://lore.kernel.org/lkml/20240329064803.3058900-1-irogers@goog=
le.com/
> >
> > +Tuan Phan, Robin Murphy
> >
> > Here is another PMU with the same suffix convention/issue:
> > https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.gi=
t/tree/drivers/perf/arm_dmc620_pmu.c?h=3Dperf-tools-next#n706
>
> There are at least one or two more as well - certainly arm_smmuv3_pmu
> which I think may have been where this pattern first started. Now that
> we've finally done the right thing with the parent mechanism to provide
> a user-visible relationship of PMU instances to their corresponding
> Devicetree/ACPI devices, hopefully we can discourage any further use of
> this rather clunky trick of using the MMIO address as an identifier in
> the PMU name. However there's then also stuff like dwc_pcie_pmu which
> encodes a PCI ID as a hex suffix, so understanding hex suffixes in
> general might still be a reasonable idea for the tool, if the
> alternative would be maintaining a list of specific prefixes (even if
> that would be hoped to remain fairly small).

Thanks Robin, the problem that Kan identified was that IBM s390 have a
PMU called cpum_cf. So the _cf is a valid hex suffix. Maybe there
needs to be a minimum hex suffix length to deal with this. We made the
0x optional in perf "raw" events like `perf stat -e 'r12abcd'...` and
now we have the problem that the word `read` is both quite a desirable
perf event name and also a valid hex encoding. We prefer the event
name if it exists, but we have to make the code more complex to deal
with this. It would be nice if we were capturing the conventions in:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Doc=
umentation/ABI/testing
Like with the sysfs-bus-event_source-* files. I'll do a v4 of these
changes and see if I can do something to document the suffixes, would
be great to get an Acked-by/Tested-by.

Thanks,
Ian

> Thanks,
> Robin.

