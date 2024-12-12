Return-Path: <linux-kernel+bounces-442717-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E34F79EE0C3
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 09:01:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CA8C61621AC
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 08:01:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F28BC13D531;
	Thu, 12 Dec 2024 08:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NYlxKwrD"
Received: from mail-il1-f180.google.com (mail-il1-f180.google.com [209.85.166.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA224558BA
	for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 08:01:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733990474; cv=none; b=Muh3oSWAk2+sJt354C3wYkKS0gXJL1qqqnkQyahi7GZzyFiljM12RD5QsDybZHDSHS8lDQO2QzQtYUoA/raPTOGbC6L3G671jh6758tcLEvCih2CXOCpbhMM9GE7+4JegGIYS+Q1+WDE/nc1QEwjcYKCRO+ZLQbF27jxlXIlHf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733990474; c=relaxed/simple;
	bh=Dr+cz0+BDjHJiX3SZyGOwqdo6Z0WguMW6sZx5zWpjKk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LEd0+kCPG0nYfVhF74aDkMehF0UsZiDqVOfiTf+pJP1Ff28lYkEUoBGvUdtW/pUND+SdyN4RzPZmgvX5ozBmQXNQHEaQ5vqPptp/AuO0rrTvv64T0pQnPCy9jpIkKkSnHoSYsG9lYz8Equ/a0vw1jjA3d7MngHeSmSYqvdpcDRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NYlxKwrD; arc=none smtp.client-ip=209.85.166.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-il1-f180.google.com with SMTP id e9e14a558f8ab-3a9d0c28589so69175ab.0
        for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 00:01:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733990472; x=1734595272; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zGnkR63xNQ6iE8HARxg6I3n9l9ITyeS7X74GP6uMkOE=;
        b=NYlxKwrDqUiN31srAv3oIEM/XcQzxpOUxoVZR92pmBmhR8xaRkN6JN0Hdf0GDtZwmg
         rD7UEmH5aMxWWKkGMydfU8tGKSAUDw8WXjEAP9sqxBejzqVKJhjjPMHWYK55nZMHxALJ
         C3LKZcM0jEKMRNZiIcL/kH9DGP6KTSPqdl8Aibdyye6VbmQjetT9dK5eu6EoEPJBiHbc
         2YtGTp2dxLYcAd189aNoTnftcsQVCfeuT9r2+v1zyBvdGqRePFnylckmrjOxEVhnYazr
         lXSoubLdABZWIxmwfhEWy3MzKP2SmRU9+4ZuhdOdkrulOuByA0AVVHw3scnLq8ln8rdd
         NZCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733990472; x=1734595272;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zGnkR63xNQ6iE8HARxg6I3n9l9ITyeS7X74GP6uMkOE=;
        b=C5oVpryyd20F6VQVRR2lNVWkTgC6VxA+TcTgGBIUH+3QAdJ4lVNThEHroAN3n0CQLk
         BC2j96hFuyFd1lbMki9Fui0lzw4w9goFbh7R9iA15GqR5QEbb5W/CDrUzqEc4iGDzAnr
         Q/tlnX+W5ga62b1A3IrEYzpc+GQ3+G/PgoPHGH7a2zgsJ+GHR/IYjBAk5xjB2crrOuH5
         DaqbGBC8RXbNwUR8DvmtBCJBaG7VcFHh9WsoQLHLknhbORU+XvPih4aq1KuDzmv0vido
         fV7O7fx9Nqs1iYsWThfvZfVQX3kwuJ1kuc9LNeRfJmD2INGUAwecDBPtE0lKnxqBsdm+
         B36g==
X-Forwarded-Encrypted: i=1; AJvYcCXhqkSgoN3lElb2a4q630YQW1CTcSripHWe4PIqN8CwZ3U14d9iy5g71nZvQgnYVkWtJSy0uqdTTznwBt8=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywlnb5EAXUhmeyXJYclf6btG4LYkVocx+cnxLg/b2ww8nZUNPni
	PzZyjNFx2S9ODUl742PW5Ltls11LP9+mUEZN1CoYjZ5tgu/Wedv2IifmJuIGX9kiKkg4T/69E4x
	qGZLECU+xgEi0rcsvPOAjLPLq3O9bTLAj1cBocPcuFCAWgFp7MvTw
X-Gm-Gg: ASbGnctVWyzIJSOCXNuezPumFm+xe7KWpZ9e0MMlThjCGmaGNBQHrrsMOolrCkEF1gZ
	hMtKsEeJ8X9EOWQRH+u6M4AKqYI7znXTx5jWo0lA=
X-Google-Smtp-Source: AGHT+IGF/N6gjFtzv8jA7XxepjmFMkaNJvoKiN88LE+17oqBT3BkCjJ8+HegVao/zGpFfBSWTcBPW5GovIVhbzxvru4=
X-Received: by 2002:a05:6e02:12e2:b0:3a7:5be0:5a06 with SMTP id
 e9e14a558f8ab-3acdb2e94a4mr1463205ab.29.1733990471902; Thu, 12 Dec 2024
 00:01:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241112160048.951213-1-james.clark@linaro.org> <Z1iLqNmDyNH7fDpa@x1>
In-Reply-To: <Z1iLqNmDyNH7fDpa@x1>
From: Ian Rogers <irogers@google.com>
Date: Thu, 12 Dec 2024 00:01:00 -0800
Message-ID: <CAP-5=fUfPnkS0HS1dMx2uR-a4GPfk4E4nD85rUtRUbVcETtY9g@mail.gmail.com>
Subject: Re: [PATCH v3 0/5] perf stat: Fix trailing comma when there is no
 metric unit
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: James Clark <james.clark@linaro.org>, linux-perf-users@vger.kernel.org, 
	namhyung@kernel.org, tim.c.chen@linux.intel.com, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, "Liang, Kan" <kan.liang@linux.intel.com>, 
	Yicong Yang <yangyicong@hisilicon.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 10, 2024 at 10:42=E2=80=AFAM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> On Tue, Nov 12, 2024 at 04:00:40PM +0000, James Clark wrote:
> > The first commit is failing on Arm and I think the fix should stop more
> > trailing comma issues which keep happening.
> >
> > The second one I just noticed when looking at it. I don't feel strongly
> > about it so not sure if we should do it or not, but seems like the empt=
y
> > metric-units exclusion from the JSON should be consistent if we're goin=
g
> > to have it at all.
> >
> > Changes since v2:
> >   * Do more documentation and tidyups around struct outstate
>
> Ian, have you had the chance of going over this series?

It looks good to me, I particularly appreciate the additional
comments/documentation. Tested with sanitizers.

Tested-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> > Changes since v1:
> >   * Don't skip printing when the metric-unit string is empty but pass
> >     NULL instead of an empty string.
> >
> > James Clark (5):
> >   perf stat: Fix trailing comma when there is no metric unit
> >   perf stat: Also hide metric-units from JSON when event didn't run
> >   perf stat: Remove empty new_line_metric function
> >   perf stat: Document and simplify interval timestamps
> >   perf stat: Document and clarify outstate members
> >
> >  tools/perf/arch/x86/util/iostat.c             |   4 +
> >  .../tests/shell/lib/perf_json_output_lint.py  |  14 +-
> >  tools/perf/util/stat-display.c                | 242 ++++++++++--------
> >  tools/perf/util/stat-shadow.c                 |   5 +-
> >  4 files changed, 147 insertions(+), 118 deletions(-)
> >
> > --
> > 2.34.1

