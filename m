Return-Path: <linux-kernel+bounces-411122-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 934099CF35B
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 18:55:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5386F287B9B
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 17:55:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9C7E1D61A1;
	Fri, 15 Nov 2024 17:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dvehh1DR"
Received: from mail-il1-f169.google.com (mail-il1-f169.google.com [209.85.166.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D3F01D619D
	for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2024 17:55:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731693310; cv=none; b=Lm19SnR2yHc8hw3h8UMqxlAo/GDDacVZ24pAt4JRWCEODHp9uBu+r6eR+78m7wqZOH/AeqgOs9u53cAN9NHjKgLLSW+5GuEICMwlU/ruJJ19H9Nn8eOfEmyGylsFJ0R1exDm2td6kA13NKpwP/hdLZ8oViroiFan3HdM9PHY8O0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731693310; c=relaxed/simple;
	bh=Dc/5CWn5I9oj0IhCuyvb47QZKddMSwNPrXDwm06esJ0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sFmBNkK2TxUzyyIuBTJ/PCB+tYbYPUQBtAA1tpdWbi6x4ukF5oXqSoR1TCkyuehX8lb/hMVMALFVBGmnwYlIcz0cWzyKkKF5SqwS5AoDEEGF3vDV5N0JfMIdcYrh44moeSlcLasSsEeCuE3lcgX5KReLfNDGucLfpBnW3u2Gtso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dvehh1DR; arc=none smtp.client-ip=209.85.166.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-il1-f169.google.com with SMTP id e9e14a558f8ab-3a716d74c28so184625ab.1
        for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2024 09:55:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731693308; x=1732298108; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hnHS6ipKNUUpXk/6JmH9J/OJBc1PBR+N05vgPQHYS08=;
        b=dvehh1DR0/Di6XWMW+AmghMfE2Fk/Se9bNDiGSmgRjO16FUideu/VZKrJNKvxCgYKz
         0RPB+0SslcB9C9IQuhYsg/Q0lK1sYXw0DkvR2RVAqwjEkGK5u3BLE7NHN7OPyN40IcDh
         moMNd+v+v0uyVcnM3rKb6JyIN0Wp1JOR8EgmoE4jHcm0WN4ljT78XFPA1zjMvYea599t
         FvVvuukHCeiXAStKphDMgjW538oVpQKQ3fxk5NHOlHO+s3aztNJlMaYa0vwRI6RrBjEy
         sGHdQMcahXZQuFW4tR736xzcLwg8vs35OXZ87hA0a5nVdEXKBroL1p+h6heJ077ApVT1
         DDbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731693308; x=1732298108;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hnHS6ipKNUUpXk/6JmH9J/OJBc1PBR+N05vgPQHYS08=;
        b=aSI7Ul40RzBZjE6hGhbbG8zQTGKcZ8YZGLwVOrLnvLHayFLiD6S6k9rUZ1H1IP6xUj
         /TEKj3XObwq3omY7QyGA/l1u+4oTGL7nD8HzUnQ7hKSMdhP8ytS7bJwwc9n3O9CPmy3x
         fg40TL3s1Drg7R9iZ9XCYZQvG2Zw4BF+IUVTnt8SMa03C4cvLfEKJHmy+/5auNEnSy22
         8H9E4Wb3BW3vNXuAo8s+95h2QV+iewqOigk8GpRAbTSJrpVpY+w4d5XxQ+3rpSrueug2
         HFaBB9wFl7vHtBimUV6WrpmiFXCcZKkqmSr2NUKOqJkoEE2iE7bFo6X4ktA5z598zOMN
         u6ZQ==
X-Forwarded-Encrypted: i=1; AJvYcCVGxjFeTA4UYNKMNxRUp/CyUy/7l//AKvGZgmVGNW4pBz41ZWjysyIb3pwjk8KZEfpZ+kJpL5v2mh/2Q30=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5SqN/f03VO9PliuVIXIVXFC9DsP/It9E6kvudhtNZc0GYqguJ
	q+BkV+4RQqN2XLdGTLRLA944dSzEmiQJckJA0Htg27u5Wr12vvlrNerri2+xYKdfZL1tgT30lsQ
	uICsrI28MxH/T02weRxHOFmfeKLbZ/QafMwFz
X-Gm-Gg: ASbGnct/EMkWfzoYk6cpPPMtFon6MAgKSXX9vCP0mpHPl6s5E9dyvSsRagQYzh0mlIC
	A+XzNC71fllgoOru8v8/+L+0Oxk2TAh1O
X-Google-Smtp-Source: AGHT+IGFQN2nBXFYab64aGS4JtOZbQ+HWAGUOdHNwbOsju2UCSDpdaV9yh5k0nEy6/NghsRYHkioIry2Xz7RaFY58EI=
X-Received: by 2002:a05:6e02:1a0a:b0:3a7:319f:e486 with SMTP id
 e9e14a558f8ab-3a74f776eefmr581795ab.7.1731693308209; Fri, 15 Nov 2024
 09:55:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <Zzdtj0PEWEX3ATwL@x1>
In-Reply-To: <Zzdtj0PEWEX3ATwL@x1>
From: Ian Rogers <irogers@google.com>
Date: Fri, 15 Nov 2024 09:54:56 -0800
Message-ID: <CAP-5=fX7JZNmiaNDezExqGk9FMXdHihxvLNmnD8HHB3YCehemg@mail.gmail.com>
Subject: Re: perf test failures with tmp.perf-tools-next
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Kan Liang <kan.liang@linux.intel.com>, Namhyung Kim <namhyung@kernel.org>, 
	James Clark <james.clark@linaro.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 15, 2024 at 7:49=E2=80=AFAM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> With what is in tmp.perf-tools-next I'm getting:
>
>  11: Hwmon PMU                                                       :
>  11.1: Basic parsing test                                            : Ok
>  11.2: Parsing without PMU name                                      : FA=
ILED!
>  11.3: Parsing with PMU name                                         : FA=
ILED!
>  84: perftool-testsuite_probe                                        : FA=
ILED!
>  86: probe libc's inet_pton & backtrace it with ping                 : FA=
ILED!
>  96: perf stat tests                                                 : FA=
ILED!
>  97: perf all metricgroups test                                      : FA=
ILED!
>  98: perf all metrics test                                           : FA=
ILED!
> 117: perftool-testsuite_report                                       : FA=
ILED!
> 118: Add vfs_getname probe to get syscall args filenames             : FA=
ILED!
> 119: Use vfs_getname probe to get syscall args filenames             : FA=
ILED!
> 120: perf record tests                                               : FA=
ILED!
> 121: perf record LBR tests                                           : FA=
ILED!
> 128: Test data symbol                                                : FA=
ILED!
>
> root@x1:~# perf test -vv 11
>  11: Hwmon PMU                                                       :
>  11.1: Basic parsing test:
> --- start ---
> test child forked, pid 391389
> hwmon_pmu: not a hwmon type 'badtype' in file name 'badtype5_baditem'
> hwmon_pmu: not a hwmon item 'baditem' in file name 'humidity6_baditem'
> ---- end(0) ----
>  11.1: Basic parsing test                                            : Ok
>  11.2: Parsing without PMU name:
> --- start ---
> test child forked, pid 391390
> Testing 'temp_test_hwmon_event1'
> Using CPUID GenuineIntel-6-BA-3
> hwmon_pmu: not a hwmon file 'uevent'
> Not a hwmon file 'uevent'
> hwmon_pmu: not a hwmon file 'name'
> Not a hwmon file 'name'
> hwmon_pmu: not a hwmon file 'uevent'
> Not a hwmon file 'uevent'
> hwmon_pmu: not a hwmon file 'name'
> Not a hwmon file 'name'
> hwmon_pmu: not a hwmon file 'uevent'
> Not a hwmon file 'uevent'
> hwmon_pmu: not a hwmon file 'name'
> Not a hwmon file 'name'
> hwmon_pmu: not a hwmon file 'uevent'
> Not a hwmon file 'uevent'
> hwmon_pmu: not a hwmon file 'name'
> Not a hwmon file 'name'
> hwmon_pmu: not a hwmon file 'uevent'
> Not a hwmon file 'uevent'
> hwmon_pmu: not a hwmon file 'name'
> Not a hwmon file 'name'
> hwmon_pmu: not a hwmon file 'uevent'
> Not a hwmon file 'uevent'
> hwmon_pmu: not a hwmon file 'name'
> Not a hwmon file 'name'
> hwmon_pmu: not a hwmon file 'uevent'
> Not a hwmon file 'uevent'
> hwmon_pmu: not a hwmon file 'pwm1'
> Not a hwmon file 'pwm1'
> hwmon_pmu: not a hwmon file 'name'
> Not a hwmon file 'name'
> hwmon_pmu: removing event 'pwm1' that has no input file
> hwmon_pmu: not a hwmon file 'uevent'
> Not a hwmon file 'uevent'
> hwmon_pmu: not a hwmon file 'name'
> Not a hwmon file 'name'
> hwmon_pmu: not a hwmon file 'uevent'
> Not a hwmon file 'uevent'
> hwmon_pmu: not a hwmon file 'name'
> Not a hwmon file 'name'
> FAILED tests/hwmon_pmu.c:160 failed to parse event 'temp_test_hwmon_event=
1', err 1
> event syntax error: 'temp_test_hwmon_event1'
>                      \___ Bad event name
>
> Unable to find event on a PMU of 'temp_test_hwmon_event1'
> free(): invalid pointer
>
> ---- unexpected signal (6) ----
>  11.2: Parsing without PMU name                                      : FA=
ILED!
>  11.3: Parsing with PMU name:
> --- start ---
> test child forked, pid 391391
> Testing 'temp_test_hwmon_event1'
> Using CPUID GenuineIntel-6-BA-3
> hwmon_pmu: not a hwmon file 'uevent'
> Not a hwmon file 'uevent'
> hwmon_pmu: not a hwmon file 'name'
> Not a hwmon file 'name'
> hwmon_pmu: not a hwmon file 'uevent'
> Not a hwmon file 'uevent'
> hwmon_pmu: not a hwmon file 'name'
> Not a hwmon file 'name'
> hwmon_pmu: not a hwmon file 'uevent'
> Not a hwmon file 'uevent'
> hwmon_pmu: not a hwmon file 'name'
> Not a hwmon file 'name'
> hwmon_pmu: not a hwmon file 'uevent'
> Not a hwmon file 'uevent'
> hwmon_pmu: not a hwmon file 'name'
> Not a hwmon file 'name'
> hwmon_pmu: not a hwmon file 'uevent'
> Not a hwmon file 'uevent'
> hwmon_pmu: not a hwmon file 'name'
> Not a hwmon file 'name'
> hwmon_pmu: not a hwmon file 'uevent'
> Not a hwmon file 'uevent'
> hwmon_pmu: not a hwmon file 'name'
> Not a hwmon file 'name'
> hwmon_pmu: not a hwmon file 'uevent'
> Not a hwmon file 'uevent'
> hwmon_pmu: not a hwmon file 'pwm1'
> Not a hwmon file 'pwm1'
> hwmon_pmu: not a hwmon file 'name'
> Not a hwmon file 'name'
> hwmon_pmu: removing event 'pwm1' that has no input file
> hwmon_pmu: not a hwmon file 'uevent'
> Not a hwmon file 'uevent'
> hwmon_pmu: not a hwmon file 'name'
> Not a hwmon file 'name'
> hwmon_pmu: not a hwmon file 'uevent'
> Not a hwmon file 'uevent'
> hwmon_pmu: not a hwmon file 'name'
> Not a hwmon file 'name'
> FAILED tests/hwmon_pmu.c:160 failed to parse event 'temp_test_hwmon_event=
1', err 1
> event syntax error: 'temp_test_hwmon_event1'
>                      \___ Bad event name
>
> Unable to find event on a PMU of 'temp_test_hwmon_event1'
>
> ---- unexpected signal (11) ----
>  11.3: Parsing with PMU name                                         : FA=
ILED!
> root@x1:~#
>
>
>
> I'm working on removing the vfs_getname code from 'perf trace' so those
> will go away, probably there are patches fixing some of the other ones,
> I'll try and look after those, but probably later today I'll push what I
> have so that it gets exposure on linux-next.

I'm trying to repro the hwmon issue on tmp.perf-tools-next, with asan
root/non-root I get:
```
 11: Hwmon PMU                                                       :
11.1: Basic parsing test                                            : Ok
11.2: Parsing without PMU name                                      : Ok
11.3: Parsing with PMU name                                         : Ok
```
I'm trying more machines to try to get a reproduction.

Thanks,
Ian

