Return-Path: <linux-kernel+bounces-396658-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BB899BD031
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 16:16:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BE7AA1C21930
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 15:16:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1B361D9340;
	Tue,  5 Nov 2024 15:16:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FcVvTAA7"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A889145027
	for <linux-kernel@vger.kernel.org>; Tue,  5 Nov 2024 15:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730819771; cv=none; b=dAwKYO9C4pE1hMOOYmwYTFc3tGWbMr1OuKL5qS4G0aVj79gvzMJZqqAGcKbCpuQ88SJSgts2XGWIz9MeL4lKjiFxyanUGp2/vfGs10PC4Zl8v1BFbosE7anhAjTCN9bR8pXfOc8aczMYLsDIjxgcqs+eliNBzQcqlsI92BxRx4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730819771; c=relaxed/simple;
	bh=1Dt5hWQ7GU/7KWHFg3LvSPS91sfOalR75iy3I5MrfiQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ePctUo0KDpoe/fbJh69tgZgELsQcBYyP/r53bwrSoQKqm1svnuKEvLIULAhe+RCtLFcEz1JPdGFkzyRymLHpoUFS0oX/dmoEbJTOewG7gCw39IiaqHgi+0D9gCaUnUKICHhA/LUPCp/9anvAhVgBFT1xHfuHEV8LntI4ZO8/ArA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FcVvTAA7; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-20ca4877690so187405ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 05 Nov 2024 07:16:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730819769; x=1731424569; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2oDcNBRJoF3ugJNaCQ1ePXTBFE41nZYUKBeotgqI//c=;
        b=FcVvTAA7wWwmjynApdjdp0w+U/oLegexP+HopqcuncBLamK/iU/Pp6datSCBlx4pKE
         0y3ugeC6NbgbM/hyJ0hYCXTVicwu1q5cVqTf1V2mwUiNcEr0NWAr+A+fw54JoCGRrZDZ
         uYXmz5LZV59SaxgJrljnt8HBb1Fyw69V1uS1WbMV+wsT0n0YErDg2daRjqNA6SUipIY8
         raQskZXpZR2Bl9dDBKunthqnXeXmVQKUA3CfFW7uIzCBI1xMCGNXutNNrp+JqR67+aZp
         TY/d5eQG6PiwiT80aPUpjvSCqs9wUpXTJl8j6NpjgCl2U/bkbBorkPEUUJAD48yrn9Gn
         q7Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730819769; x=1731424569;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2oDcNBRJoF3ugJNaCQ1ePXTBFE41nZYUKBeotgqI//c=;
        b=ItnkLstNFPvYxjDmU1wKaAMbE/mPgk09/rKCRenypkN7Pf/obqNi6+IyRn5kqA4QSn
         zmEDxdqwu8rb2rHQBPdFTq+HkD2m5IdBvfJzxLUq1sU7o6gzTRgFWkTMFqb6oI4Aze/E
         pwFoIS7DtrxPdT8Xz7v+F3TPoM/st6MAraCkcXMln1kawIe78cF0M8F+G7c/E1UJCGaS
         4aASXPqRx3roGR55wNzmNya7Cy6hnwlS/A/ANp8jbmNW+VPJd5NzLxOkQqAqZKjBCRBg
         FYhptUCrXSufYnFgKSOy1oNwNl0ujU70Iq4o1NnjFzcLcV2wKCl5oIpG+ETjAmW/jlPl
         flog==
X-Forwarded-Encrypted: i=1; AJvYcCUwZf7LNC6WFdzmihfU023hJLytX2YZGSXpEvrsrS6Jo8sSTaTHUr30Itu2u0FDfyQxNWltC1QoMXI+fV4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxsqfBGWaWK9cmNrmuqr6/0r+N72wKV8H1i74bNYFZ6NxrK2AlZ
	jnAZSSjxY6smS7T6LNcQlMg4PuFtVvP99QJOXwdF0sZPqMZbfycIcD7VAiZpzEVl44GLyCaSm0E
	NXN0EXADt1yQdIW/yN+O97fNR5ofeY9fCl22c
X-Gm-Gg: ASbGncvV8LtQp6LpJBKtzJfvkKYUugvtC1rc68HuCGpGYMolowIf1o3/L5zjZ7oHjly
	pIud2tnminal3uCFCiKHOwdZwrx+tADaN
X-Google-Smtp-Source: AGHT+IFsWHd8VJEr3yLTzOH0IktdtyiMppn2MXA6qRraCO2x0crqW6EqIf9lj8ztOwkuN7YOToyYAUyvfifTkom4QbI=
X-Received: by 2002:a17:902:ea08:b0:20c:a55b:aef1 with SMTP id
 d9443c01a7336-2115e1e82f7mr2553575ad.6.1730819768663; Tue, 05 Nov 2024
 07:16:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241031223948.4179222-1-ctshao@google.com> <20241031223948.4179222-2-ctshao@google.com>
 <20241105122423.GJ24862@noisy.programming.kicks-ass.net>
In-Reply-To: <20241105122423.GJ24862@noisy.programming.kicks-ass.net>
From: Ian Rogers <irogers@google.com>
Date: Tue, 5 Nov 2024 07:15:56 -0800
Message-ID: <CAP-5=fVMb_hqhT7RW9o5p7qREM1QVHSsnb1dXG7Oh+v4XdN-rA@mail.gmail.com>
Subject: Re: [PATCH 2/3] perf: Reveal PMU type in fdinfo
To: Peter Zijlstra <peterz@infradead.org>
Cc: Chun-Tse Shao <ctshao@google.com>, linux-kernel@vger.kernel.org, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Liang@google.com, Kan <kan.liang@linux.intel.com>, 
	Ze Gao <zegao2021@gmail.com>, Yang Jihong <yangjihong1@huawei.com>, 
	Weilin Wang <weilin.wang@intel.com>, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 5, 2024 at 4:24=E2=80=AFAM Peter Zijlstra <peterz@infradead.org=
> wrote:
>
> On Thu, Oct 31, 2024 at 10:39:44PM +0000, Chun-Tse Shao wrote:
> > It gives useful info on knowing which PMUs are reserved by this process=
.
> > Also add extra attributes which would be useful.
> >
> > ```
> > Testing cycles
> > $ ./perf stat -e cycles &
> > $ cat /proc/`pidof perf`/fdinfo/3
> > pos:    0
> > flags:  02000002
> > mnt_id: 16
> > ino:    3081
> > perf_event-orig_type:   0
> > perf_event-attr.config1:        0
> > perf_event-attr.config2:        0
> > perf_event-attr.config3:        0
> >
> > Testing L1-dcache-load-misses//
> > $ ./perf stat -e L1-dcache-load-misses &
> > $ cat /proc/`pidof perf`/fdinfo/3
> > pos:    0
> > flags:  02000002
> > mnt_id: 16
> > ino:    1072
> > perf_event-attr.type:   3
> > perf_event-attr.config: 65536
> > perf_event-attr.config1:        0
> > perf_event-attr.config2:        0
> > perf_event-attr.config3:        0
> > ```
>
> First time I hear about fdinfo.. How much of an ABI is this, and why
> this random selection of the perf_event_attr structure? What if someone
> else wants something and then we change it. Will this then break ABI?

Hi Peter,

There is a man page describing normal use of fdinfo:
https://man7.org/linux/man-pages/man5/proc_pid_fdinfo.5.html
I came across it wanting to implement a DRM PMU similar to the
(unmerged) hwmon PMU:
https://lore.kernel.org/all/20241022180623.463131-1-irogers@google.com/
The DRM extension to fdinfo isn't described in the man page so I
propose it in these patches:
https://lore.kernel.org/all/20241101211830.1298073-4-irogers@google.com/
Where DRM describes its fdinfo ABI here:
https://docs.kernel.org/gpu/drm-usage-stats.html
An example implementation is:
https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git/tree/drivers/gp=
u/drm/amd/amdgpu/amdgpu_fdinfo.c

> How much of an ABI is it?
I suspect that it is similar in this regard to anything in /proc, such
as /proc/pid/maps. /proc/pid/maps has been changed by things like
disabling the showing of "[stack:tid]" information, but generally it
stays the same. Adding information is obviously intended.

> Why this selection of perf_event_attr?
For the EBUSY warning perf_event-attr.type would suffice. I'd been
nagging for additional information for the sake of debugging. It gets
a little harder to print some values as they are in unions. These
values at least make a start.

> What if someone else wants something and then we change it. Will this the=
n break ABI?
I don't think so. I can imagine lots of other information to be gained
through the API, like the hw_perf_event state.

Thanks,
Ian

