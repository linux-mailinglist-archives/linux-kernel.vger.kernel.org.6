Return-Path: <linux-kernel+bounces-413814-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 489839D1F1B
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 05:05:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F0E7C280DA6
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 04:05:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD11D13DBA0;
	Tue, 19 Nov 2024 04:05:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vnK4oaL3"
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 481622AF0A
	for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2024 04:05:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731989107; cv=none; b=IcnI9SMDdnHymnCdoXzYa+J9C6XWhQEE4Kp6H5hFJexxxSCyfIcC/q7X4s3ZVT4pxy3jdislHca6VKsBJelOF7h6+9AoOGuomDDGYieY308QzKl4CVYa4ASgnqMqKeuVq/wIK5Cbsu3WgkZzrOCt6ZwtVhhD6jyaUHv0M5FMVGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731989107; c=relaxed/simple;
	bh=Ls0c6hxo1LYpD53Wg8nzeDMo2SNbv6rcWqVy0pBauA4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BZhRuWYJad06fx84prUnlyNJsHX3dcVXNEbW7fxqdovYZUPUXT94owmh5k5dvaPZxruturxpBf6OTvXW9wfXOTq6yXmhO70sItgLTXr2YUt3g+8cn7lSp1uHYTcmJDKQNLrfdNWjiz9qk/PZWlPGLIwvtEpocdPUxX7L4y716N4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vnK4oaL3; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-539ee1acb86so2612125e87.0
        for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2024 20:05:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731989103; x=1732593903; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FZ9pFUxaJX1/gPVsruUQ5uy3guXkarxI7ZXu/GcKSu4=;
        b=vnK4oaL3Iqd+w7RqJ8I78hdmg9PeEdrlI99A/VY6yzio7AHNKpXUg5jXWOYZWFFWBM
         hbI0PI6meYswnT5w7dtGmccV0KK7cmkoiRZf+gQNzu/S2Zc8Te6KV4C6ZCoy0aoidsH6
         lyA3DyrrJK+R6axgcIBkW83jK2k1Z7ZTyiycRseWa9nwpAek1rxBVpoXX8boMaQ2+GrA
         f6O1xzwdkSXy/TjrskP5IG3BAx6QSKy7Qa16CcQSnAFbUfLRAdwsJtj3POQQM0qCZC+m
         7nFVYlDExpVItREgKwZo573GqEvIXJ50ArGy6NvLBRfyazcW7N+GuDmJMXMGzz99SnpJ
         ykwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731989103; x=1732593903;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FZ9pFUxaJX1/gPVsruUQ5uy3guXkarxI7ZXu/GcKSu4=;
        b=v6pIAgIi+jPsaD5XxxI9X1QK4DKdo05pIpiMA8eGVa8z1rPQPpD2c50wzjJxCRh7bu
         6E9oBkbxwXnEFEVctJhM0zRZ+Z/ugpsvABSQXDLbyOTfy97vEywy/bgP9LdvQIEvR/fi
         fon79oGtYUueoSn1gHjbMSrPb3sStKTDghUz+h3hgFXUBT0tbyEjAKCVQ7JC1sDI67cD
         yxJ1sNy9SXz/oDx9DaPrKIfyLIfk/ykxWTkn/w9KeaABEf239TncQ6aQXlsuCFVUH8Jc
         Bn5LlWoEx2d6K0zhoHc4MR/GT58vgCJw3ym0q1uGH3nUvTlYd5Wp1ZiPe/gFTDQ6Kwqw
         UmFw==
X-Forwarded-Encrypted: i=1; AJvYcCUalcQrcB/BFFjmogTmDVzQmDCJvvscFYCZT7ejFfHVJ9S6QAVgBAWaGGw+vPpDsFCydyfgIKkxwvURGwg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwGTOsqC3KLS3cjWhv/gGQYHk21qWGZw50IPBa/514F3+yGRqLL
	IcI3pc+RCMLr8whQq+kflwAJ7cgy8ERIxVz38wKS1wiHsR2ZFYWE7Kj5mKh1RH1hmDAU6+SzZII
	ChcO8TET0DNw9/97ZZqpgUYzjD33bnn1+7NRm
X-Google-Smtp-Source: AGHT+IFCu5sEQjf49bdlmV/a6QYkxnIRK7AxJrNtSW+3ibMu5+tynA/LiKjy8dLqDBQlWZP2ar4D0LMBotS2tjR6A54=
X-Received: by 2002:a05:6512:e95:b0:536:a275:9d61 with SMTP id
 2adb3069b0e04-53dab29adcdmr5218727e87.21.1731989103093; Mon, 18 Nov 2024
 20:05:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241114220921.2529905-1-saravanak@google.com>
In-Reply-To: <20241114220921.2529905-1-saravanak@google.com>
From: Saravana Kannan <saravanak@google.com>
Date: Mon, 18 Nov 2024 20:04:26 -0800
Message-ID: <CAGETcx-NEjg5GwEMyz7C88ZhBrpFd55Md05Wez4kurvmdaWabQ@mail.gmail.com>
Subject: Re: [PATCH v1 0/5] Optimize async device suspend/resume
To: "Rafael J. Wysocki" <rafael@kernel.org>, Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Ingo Molnar <mingo@redhat.com>, 
	Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>, 
	Vincent Guittot <vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
	Valentin Schneider <vschneid@redhat.com>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, Marek Vasut <marex@denx.de>, Bird@google.com, 
	Tim <Tim.Bird@sony.com>, kernel-team@android.com, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 14, 2024 at 2:09=E2=80=AFPM Saravana Kannan <saravanak@google.c=
om> wrote:
>
> A lot of the details are in patch 4/5 and 5/5. The summary is that
> there's a lot of overhead and wasted work in how async device
> suspend/resume is handled today. I talked about this and otther
> suspend/resume issues at LPC 2024[1].
>
> You can remove a lot of the overhead by doing a breadth first queuing of
> async suspend/resumes. That's what this patch series does. I also
> noticed that during resume, because of EAS, we don't use the bigger CPUs
> as quickly. This was leading to a lot of scheduling latency and
> preemption of runnable threads and increasing the resume latency. So, we
> also disable EAS for that tiny period of resume where we know there'll
> be a lot of parallelism.
>
> On a Pixel 6, averaging over 100 suspend/resume cycles, this patch
> series yields significant improvements:
> +---------------------------+-----------+----------------+------------+--=
-----+
> | Phase                     | Old full sync | Old full async | New full a=
sync |
> |                           |               |                | + EAS disa=
bled |
> +---------------------------+-----------+----------------+------------+--=
-----+
> | Total dpm_suspend*() time |        107 ms |          72 ms |          6=
2 ms |
> +---------------------------+-----------+----------------+------------+--=
-----+
> | Total dpm_resume*() time  |         75 ms |          90 ms |          6=
1 ms |
> +---------------------------+-----------+----------------+------------+--=
-----+
> | Sum                       |        182 ms |         162 ms |         12=
3 ms |
> +---------------------------+-----------+----------------+------------+--=
-----+
>
> There might be room for some more optimizations in the future, but I'm
> keep this patch series simple enough so that it's easier to review and
> check that it's not breaking anything. If this series lands and is
> stable and no bug reports for a few months, I can work on optimizing
> this a bit further.
>
> Thanks,
> Saravana
> P.S: Cc-ing some usual suspects you might be interested in testing this
> out.
>
> [1] - https://lpc.events/event/18/contributions/1845/
>
> Saravana Kannan (5):
>   PM: sleep: Fix runtime PM issue in dpm_resume()
>   PM: sleep: Remove unnecessary mutex lock when waiting on parent
>   PM: sleep: Add helper functions to loop through superior/subordinate
>     devs
>   PM: sleep: Do breadth first suspend/resume for async suspend/resume
>   PM: sleep: Spread out async kworker threads during dpm_resume*()
>     phases
>
>  drivers/base/power/main.c | 325 +++++++++++++++++++++++++++++---------

Hi Rafael/Greg,

I'm waiting for one of your reviews before I send out the next version.

-Saravana

>  kernel/power/suspend.c    |  16 ++
>  kernel/sched/topology.c   |  13 ++
>  3 files changed, 276 insertions(+), 78 deletions(-)
>
> --
> 2.47.0.338.g60cca15819-goog
>

