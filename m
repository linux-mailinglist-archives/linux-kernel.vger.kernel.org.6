Return-Path: <linux-kernel+bounces-192834-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 674E98D22DF
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 19:59:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1B61F2869CB
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 17:59:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E6D547F60;
	Tue, 28 May 2024 17:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="A+/+Clto"
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCB1E45978
	for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 17:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716919188; cv=none; b=ZPs0dVFTlrrB9KCXfHZ4VJGGM5SNEFG2JiRc15EjTHl9Ix51jBplHfgaBctkfD32a5z88fKda6CNcReBsuj6LePJRD9s0q5WZR6VvomeQQjo/xUSJwdsHpTUCNx5oo9sxIa/9EHD0EtclA2I7pKfKx8XhzBZb/Jey/F/Kw7+h10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716919188; c=relaxed/simple;
	bh=72WsRYhKuUKJMpOR7EBqv7G/wkvArhvNvja90/TzAy4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=C/z5OUrS4UzAGxBPlWSCapqiyhi8C6Bt1C16jNgPUzvM3IwssldkAsS1BoRbZRxrZHcUUk6jFNqhe5FV1kQOxlA2piONvGVlC1d0449CadpH6dsVFVrwJ2WebHT4W2CVzC7nBnQ95r+xouDnHhR30vv87HsT/8NYnDF4649U1iA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=A+/+Clto; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-579ce5fbeb6so1738a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 10:59:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1716919185; x=1717523985; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u1Fj0jA4xvnb6MvCjHyiX5Ob+tMjMXGvJSSTYFMvZUk=;
        b=A+/+CltoBO4es5oUOvikG/xiVd4F+fp8FJknEC1PCvAapP0dAdZ0BxHNCoo059n3fL
         eppNYhnnSOp6Fs4K5RXFJWSg3pK3+4yX7xFi2ekCrZx7tZft9EexyOoVln3NPkX0sQ7n
         C7KbWGPRJOKqQIrggVBZ9Z/Nc+9oBJFtaNgG0xssqCgZnoyrosGehX3cu7uO+K1MSIWB
         NUOuseE8YyrpW+x4tYrA1FGBFKo9n1eIO5WURQMBLHUeShf0CTptp2bsqisQ+LZPbDRK
         XFoo5WEKx/b8RZkwiPGjAGJK9p6AMN/0GcT+z1eyDnyz1JnOMLa0nh306yQUJ8MeJcUZ
         vSmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716919185; x=1717523985;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u1Fj0jA4xvnb6MvCjHyiX5Ob+tMjMXGvJSSTYFMvZUk=;
        b=m6LcOVx0PxuGLnVOUKNwgOzfjaa0hyBoaDoOGdV9EGyqgTnRS4dkWmMDFkb9liuA1w
         2M1kOb4NeyrKL+bpgj14r+hjAoSwUxdqjd6eKGnaWafei8yyYLDX5n25WZb5fWSUM/+A
         jRbsYMwqoa3IrnLet/7oYvDVDE7FDXbL3+Clj11o7Je94ELwqWoxa/PFu+7aI5A+ww04
         eQ9VaVmH3v4+d3oYrsAuAa7AzaqcfzR7qmjPgvJaM96GQ7LfEjM8JuBOcmTrexnd/04Y
         9h/V66bKeii090++EPaQN4SvKl2gLmo4zA/xrmV0SGehEGrtXKh0DrZAyBR0hVYQfLhC
         /p5Q==
X-Forwarded-Encrypted: i=1; AJvYcCVzI8JQYBOPUtfWjsdD81eYm0iTFXrr/g696jamu3kscQxMf8ZeqWzwDHEgqZLD8uxwMPOcxEC2Co7lInHajtShi7l36fo/ee3WG5Kk
X-Gm-Message-State: AOJu0YwmdVRzpDW1fuRGiv+UGEmWs4Fhz5GjahndVcdasTZcORxOOwBK
	/lHXxDkY5Hr6jWuMHgaWczgi81ThCHducgguNCkF102nfhQxOwEO/urHrBf5y7yYnPYPQBQ5Ddz
	5uv/b9JX7VKzsY/62KEZa8QBMYhv0Mcb+h7c=
X-Google-Smtp-Source: AGHT+IGJqOi1xS3B+ok1xdaUbGB4iWRTymvvpz7+ZUp8pp7Hlw/1kIDQEPcxbHVl6fe64hlWwTSkckBfdjI8U6vQW7s=
X-Received: by 2002:a50:ec93:0:b0:572:e6fb:ab07 with SMTP id
 4fb4d7f45d1cf-57a027edcafmr10452a12.7.1716919183916; Tue, 28 May 2024
 10:59:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240515193610.2350456-1-yabinc@google.com> <CAM9d7cjmJHC91Q-_V7trfW-LtQVbraSHzm--iDiBi7LgNwD2DA@mail.gmail.com>
In-Reply-To: <CAM9d7cjmJHC91Q-_V7trfW-LtQVbraSHzm--iDiBi7LgNwD2DA@mail.gmail.com>
From: Yabin Cui <yabinc@google.com>
Date: Tue, 28 May 2024 10:59:30 -0700
Message-ID: <CALJ9ZPML-QNcsJfo6tBMfmJzb=wF1qQsMFTbNvtRwH-++J1a2g@mail.gmail.com>
Subject: Re: [PATCH v5 0/3] perf/core: Check sample_type in sample data saving
 helper functions
To: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 22, 2024 at 9:27=E2=80=AFAM Namhyung Kim <namhyung@kernel.org> =
wrote:
>
> Hello,
>
> On Wed, May 15, 2024 at 12:36=E2=80=AFPM Yabin Cui <yabinc@google.com> wr=
ote:
> >
> > Hello,
> >
> > We use helper functions to save raw data, callchain and branch stack in
> > perf_sample_data. These functions update perf_sample_data->dyn_size wit=
hout
> > checking event->attr.sample_type, which may result in unused space
> > allocated in sample records. To prevent this from happening, this patch=
set
> > enforces checking sample_type of an event in these helper functions.
> >
> > Thanks,
> > Yabin
> >
> >
> > Changes since v1:
> >  - Check event->attr.sample_type & PERF_SAMPLE_RAW before
> >    calling perf_sample_save_raw_data().
> >  - Subject has been changed to reflect the change of solution.
> >
> > Changes since v2:
> >  - Move sample_type check into perf_sample_save_raw_data().
> >  - (New patch) Move sample_type check into perf_sample_save_callchain()=
.
> >  - (New patch) Move sample_type check into perf_sample_save_brstack().
> >
> > Changes since v3:
> >  - Fix -Werror=3Dimplicit-function-declaration by moving has_branch_sta=
ck().
> >
> > Changes since v4:
> >  - Give a warning if data->sample_flags is already set when calling the
> >    helper functions.
> >
> > Original commit message from v1:
> >   perf/core: Trim dyn_size if raw data is absent
> >
> > Original commit message from v2/v3:
> >   perf/core: Save raw sample data conditionally based on sample type
> >
> >
> > Yabin Cui (3):
> >   perf/core: Save raw sample data conditionally based on sample type
> >   perf/core: Check sample_type in perf_sample_save_callchain
> >   perf/core: Check sample_type in perf_sample_save_brstack
>
> Acked-by: Namhyung Kim <namhyung@kernel.org>
>
> Thanks,
> Namhyung
>

Hi performance events subsystem maintainers,

The v5 patches were modified based on Peter's comments on the v4
patches. I'd be grateful if you could take a look when you have a
moment.
Thank you for your time and consideration.

Thanks,
Yabin

> >
> >  arch/s390/kernel/perf_cpum_cf.c    |  2 +-
> >  arch/s390/kernel/perf_pai_crypto.c |  2 +-
> >  arch/s390/kernel/perf_pai_ext.c    |  2 +-
> >  arch/x86/events/amd/core.c         |  3 +--
> >  arch/x86/events/amd/ibs.c          |  5 ++---
> >  arch/x86/events/core.c             |  3 +--
> >  arch/x86/events/intel/ds.c         |  9 +++-----
> >  include/linux/perf_event.h         | 26 +++++++++++++++++-----
> >  kernel/events/core.c               | 35 +++++++++++++++---------------
> >  kernel/trace/bpf_trace.c           | 11 +++++-----
> >  10 files changed, 55 insertions(+), 43 deletions(-)
> >
> > --
> > 2.45.0.rc1.225.g2a3ae87e7f-goog
> >

