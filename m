Return-Path: <linux-kernel+bounces-520263-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 51D83A3A7AD
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 20:34:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 113DD3B3579
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 19:33:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79BE71E8347;
	Tue, 18 Feb 2025 19:32:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pW41pafg"
Received: from mail-il1-f181.google.com (mail-il1-f181.google.com [209.85.166.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ABE91E8335
	for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 19:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739907167; cv=none; b=l7t8LozPGF28vBhK+HVBFGRU+cXNO3jj2bTWyjxArC1rvMKD7CAz55HVR4SwM5VANmwqq3JLpYNMX775Lbboi5ZOtQNKXHs0uyYl4SLbecX0PhSmU06X9CJq1kC2A/IMbIiaf8GVnZexfgxMTrewE8mPcNbZ0ZtA7tYvHTMpAow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739907167; c=relaxed/simple;
	bh=OKg/vspZ1Pfm2scqsi+vbvKuo5N6IB7CpAe1dGcrZ/U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nyDnRv9yt4wVpmw1LTg6XE0T8uBb5Lgc3gVxMPoGeUovnh293tXv1l1eRCmCx6J8P4bAbdDWEXlzq1qsKhxpN6TVRJFDKAkT4D9QHEkOTfgTgGZdJuSBQfIWTNJ9pfuUwu7fBctvi/x9DIzticE1m99hG6LUvb8sBHTBammzmPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pW41pafg; arc=none smtp.client-ip=209.85.166.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-il1-f181.google.com with SMTP id e9e14a558f8ab-3d19702f977so575965ab.1
        for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 11:32:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739907165; x=1740511965; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ooa4Gr2vptHfgJIcnxNWosHyuLVSNNAjrC96CjjiTTM=;
        b=pW41pafgI7MBRiepMAheYan+s7F1OwPC+d/WgDUs1OxdcTZGbZm3FvQMT4VvU0g7p/
         d4n30I6kM8kE5YyNFslPvwr8tjCxeQor41OLVk/a68EuDRINSzq36neploSQqROMEKvs
         xE1YgL2YignvUvYR9bpJLUl9Zs/mgApuKjqaUYANhTz/pDWYcuVfqcGPXUYda96/Ways
         yWD+bOCYDPxeQaL1fsn3wCH+WW3aPufqJbF4zhiK2eJXPU/ox1ODEV+p54jQsu+dBPVI
         3Z+bUEe+7UyDNkzGkiSq2PG0arzIomL0XuUmsTuIyrADHI59TmgRwCK2FZrFrJsdE2j6
         sExA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739907165; x=1740511965;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ooa4Gr2vptHfgJIcnxNWosHyuLVSNNAjrC96CjjiTTM=;
        b=XCFYhmVGp/VxEHI83cw/o4Cf+/a009eY+RebtFBJCjBRz2O1WPuwfXbM/5IcJzsHOb
         U1nqigz90CJLym0vbKqXCO2U03EuPvAXhCeo4bDWzbnvy5g0rSiZtW2tv8fZ2FEFIJ5C
         FOAbh7eSSgF3tBYzqXFjg5QLyA1R5Dp6XFd0cGO27ODNz3MwZp/U67uOR2UQgHDdVZjm
         T9QYN3toPn7yhDkevYMeAOa+/kRtaVW3g0CY7SEohNEcR+FC+st5JHJNuh94fsLzSZfX
         8CfLnmCORDmONluWMw1O41VBc+xMhvf1Ie9WEe358RXavWk94caUa5BCt1H2CWWUcmNz
         DPeA==
X-Forwarded-Encrypted: i=1; AJvYcCUoioM9u0vY2llPEb6q4Qy1EYuQ8ZFaswu1MoRjN3dEfNog+at/Wze22fZIqAksXxIQIRIjmL5JXwTq6D0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzuaurXET2wkMeTszPrIjzzjtnlxXYTFWPQL5EMB7ppd64SE7Oy
	bWK0j+KrmAb0LYZ/jrQAIYQmwFLJ0aqOm4ZYakeSFbgX/O6U0Rcn1XzT48PbseMLKtBW9UAWl4m
	DinPun3MCG3Idqp1XfDfNsLBMtk22ADLRwhvL
X-Gm-Gg: ASbGncsAyDsN8jl/kvz9CI/+CthVq7nu7rt6mi458JAKJY4t5WJSrOLfHKe5VeGQqhU
	3V0BeQ/bU3gYRkrIOzZXY4DgvEyAuSe5Ir1VONjqFKyOCLLm6c59TbMCs2XRhjJxU87ERTID1I4
	aaSS0yraMX67RE/s9bjJYHL+3u
X-Google-Smtp-Source: AGHT+IEfTwsWcFCTwDnc/V7zN6ysPIDX3sfVxtdpYeKil4GEoDzJsTyfI98He7DJmryqH6XCyrbXhCHq8rzf6fIekmY=
X-Received: by 2002:a05:6e02:1fc3:b0:3d1:7948:faa2 with SMTP id
 e9e14a558f8ab-3d2b659147cmr214465ab.7.1739907165084; Tue, 18 Feb 2025
 11:32:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250213230009.1450907-1-howardchu95@gmail.com>
 <20250213230009.1450907-11-howardchu95@gmail.com> <CAH0uvohY6fBaJvMZNi-fcHEW1Dw7Zp5Q_+ZxNgcaaFary-3sWw@mail.gmail.com>
In-Reply-To: <CAH0uvohY6fBaJvMZNi-fcHEW1Dw7Zp5Q_+ZxNgcaaFary-3sWw@mail.gmail.com>
From: Ian Rogers <irogers@google.com>
Date: Tue, 18 Feb 2025 11:32:33 -0800
X-Gm-Features: AWEUYZmlcbrhdtnqBx4nDEFcPghfTNjaARpHHQeifLksN1EV1XK28ErudeI7wD8
Message-ID: <CAP-5=fXae_851WezB5rNkv6cp2DfAWobJ-cbehKy3eiFe8F9Ow@mail.gmail.com>
Subject: Re: [PATCH v15 10/10] perf test: Add direct off-cpu test
To: Howard Chu <howardchu95@gmail.com>
Cc: acme@kernel.org, namhyung@kernel.org, jolsa@kernel.org, 
	adrian.hunter@intel.com, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Ingo Molnar <mingo@redhat.com>, 
	James Clark <james.clark@linaro.org>, Kan Liang <kan.liang@linux.intel.com>, 
	Mark Rutland <mark.rutland@arm.com>, Peter Zijlstra <peterz@infradead.org>, 
	Arnaldo Carvalho de Melo <acme@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 13, 2025 at 3:04=E2=80=AFPM Howard Chu <howardchu95@gmail.com> =
wrote:
>
> Hello,
>
> On Thu, Feb 13, 2025 at 3:00=E2=80=AFPM Howard Chu <howardchu95@gmail.com=
> wrote:
> >
> > Why is there a --off-cpu-thresh 2000?
> >
> > We collect an off-cpu period __ONLY ONCE__, either in direct sample for=
m,
> > or in accumulated form (in BPF stack trace map).
> >
> > If I don't add --off-cpu-thresh 2000, the sample in the original test
> > goes into the ring buffer instead of the BPF stack trace map.
> >
> > Additionally, when using -e dummy, the ring buffer is not open, causing
> > us to lose a sample.
>
> Just noticed that this commit message is wrong, should be:
> """
> Add tests for direct off-cpu samples and --off-cpu-thresh option.
> """

Tested-by: Ian Rogers <irogers@google.com>
```
121: perf record offcpu profiling tests                              : Ok
```
I'd be tempted to keep the comments about why 2000 next to the actual
code rather than in the commit message. In the code the value is 12000
and not 2000 though?

Thanks,
Ian

