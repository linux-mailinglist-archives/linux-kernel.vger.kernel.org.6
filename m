Return-Path: <linux-kernel+bounces-556513-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 58DBAA5CAF8
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 17:35:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9956017961A
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 16:35:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D693326039A;
	Tue, 11 Mar 2025 16:35:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WVl6VZFl"
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A9F0260378
	for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 16:35:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741710943; cv=none; b=dHzEP9fEA7/8bzJ1K6/npHaTgD47PyC2RQ0R6WfjGGWUqSPt+2RGXqLxscl4QWxFAv9e/Jt0N3kaXPxchw0tsEcRVeyPPM8iC/LxwK3psRU6Thb7C8pi1CU5WMTvZ8jB3MMaE8v9tJsKwtBrsCaxv9VawTXJB2O4CQASW2/Puvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741710943; c=relaxed/simple;
	bh=YH94RY01QlOuT/Zb1gSEI5tCi3DWgTYhx5iGmc0LtB0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mt8BDd3CtMmOo/wgzPuet4t0jO9ZOnBo7YRYW8Vzp3/LAb3Sr+BPMmQu0NtthDHfEfM9kJKE5/TL0+kbkFxpURlUP5UdLJEe3MKpIbe4WZtlBoETvy9d8W4FXiW2mM5TiMI1xu4Jhu4eiBiK8U+5RvDUDpV3mLHF1srxlCLMC3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=WVl6VZFl; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-abec8b750ebso964531266b.0
        for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 09:35:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741710939; x=1742315739; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=YH94RY01QlOuT/Zb1gSEI5tCi3DWgTYhx5iGmc0LtB0=;
        b=WVl6VZFlqAN/qjFaAsKi9FagPQR3/+0UUM0mUXJm6CblcVt0QZNhx8k1xrNM2q9NZa
         5HDlHqvmTTkXEawRyY/EAGGIjug7PwLtfsuTq0eSneq4xALqzJpfhewSAt85Q3TLo2eh
         LvFgVLECc7SpRAvDFIJ2rfMq/hC2C90z3GcxYQu5Fl7rOQWlQrty0cfOuYE+ltqSvzFl
         /ELLGo/i8rciH4dCBGptlWJtL/o3AHf5DbW3SnuiJZWFgq8UV53jq7+scWmfKt9c6aDp
         mBY4sWu72w4pa78iWBhSaHdktRfCe4rM/X2JW5yXq5kr5mil4+xX5UnQnRCl3q81uVJW
         IeaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741710939; x=1742315739;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YH94RY01QlOuT/Zb1gSEI5tCi3DWgTYhx5iGmc0LtB0=;
        b=ClxfLjCU3r6+LHlNgqbUguSo3AEByUm+mbiXHDcXpM7MlNo04/ccGu+YRxWZskDVK1
         SKTbmYrtTlRO6eg+YWOQ6yUR0x1BK/GzUtQGR/vZSUiCqWZD0P5IbXPh+A+JRJGTZa4b
         lBY4lUP93qmIyUCdk71fvUj9DOmAo4CRS9GzVeBQbVBANZrS++gZ0w39FRgbeV7bld0R
         GJHpYPqG1NCofjxEVSFP28zc7JUjaVMw27HAA/4r/lwoTa0xkTE13BNtMWwaZTEUVViN
         2GCPhLFAl9UpdrZqVPWq6YfUefYptfygDUdlGQJzI9nnFoLLGw4TQTS0nZ98G/NcO6ke
         ikjQ==
X-Forwarded-Encrypted: i=1; AJvYcCXz/osQmtSmw8m5MvUqwpKluAOjGg6V0FEk6SYBY1uiArBWNou7ohqziDqrxRbbEAKe7irRVewF3cykEHQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3wTkDjIKYPBM3ijRs8ofmAuacyAv30MbzS6jqsrbGFxQsv8tx
	ORFDOC+lexyBjVy8X4sZ6QBua82RfCgK3kMZosaJunTkVFVvNN57TlYygTyTzQNBZEQ6YLYyMBs
	mkTR0tww3QGxUMUZ00AN+8YVYhBS04c5wFzCdfg==
X-Gm-Gg: ASbGncvP5S61+1LSfI6MdiqXRvMP5BIg9VAOy57uUkFbEFDTM+3qaOp0ajpDJ93RL+F
	gH74Qp3IZ5Qx7fF3nUeyR5fcER23bYfBwY20Njrz8ntZ6LzvM2JxgQUVj76aqHJ3WvYWIAxrFqj
	Vu4k4la4KLFPEKHvo8eCeA98r7J/T9USF+PINC7+pu4gTfooa404GBpVk=
X-Google-Smtp-Source: AGHT+IEBoqu1wBzPhkT+HTNtgDy4DjfvjEvB904ckPw4RxalBrogme2Qo3stOfn8n5UA7m3WWCDxBT8cx2o2ZwvNYGY=
X-Received: by 2002:a17:907:74a:b0:abf:727e:aa6b with SMTP id
 a640c23a62f3a-ac25273a8e5mr2505417466b.11.1741710938753; Tue, 11 Mar 2025
 09:35:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250306162635.2614376-1-dietmar.eggemann@arm.com>
 <CAKfTPtCfd_=gm7rsT_qBL8pw5uybEvYH4N2tvxpKndxxi4L7oA@mail.gmail.com> <8ddd7bb2-3a18-48b5-85c6-23263134308a@arm.com>
In-Reply-To: <8ddd7bb2-3a18-48b5-85c6-23263134308a@arm.com>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Tue, 11 Mar 2025 17:35:26 +0100
X-Gm-Features: AQ5f1JrAwTzSCpMd7nF4ODmoDcm4mYknyHqx444OKOXCOY--d0hFRkmiII6Wv00
Message-ID: <CAKfTPtD9DwWquFN6G8BXAii7HH5zJeEXiUjE8ma-eHdEqeHzdw@mail.gmail.com>
Subject: Re: [PATCH] /sched/core: Fix Unixbench spawn test regression
To: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
	Juri Lelli <juri.lelli@redhat.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
	Valentin Schneider <vschneid@redhat.com>, Hagar Hemdan <hagarhem@amazon.com>, linux-kernel@vger.kernel.org, 
	wuchi.zero@gmail.com
Content-Type: text/plain; charset="UTF-8"

On Mon, 10 Mar 2025 at 16:29, Dietmar Eggemann <dietmar.eggemann@arm.com> wrote:
>
> On 10/03/2025 14:59, Vincent Guittot wrote:
> > On Thu, 6 Mar 2025 at 17:26, Dietmar Eggemann <dietmar.eggemann@arm.com> wrote:
> >>
> >> Hagar reported a 30% drop in UnixBench spawn test with commit
> >> eff6c8ce8d4d ("sched/core: Reduce cost of sched_move_task when config
> >> autogroup") on a m6g.xlarge AWS EC2 instance with 4 vCPUs and 16 GiB RAM
> >> (aarch64) (single level MC sched domain) [1].
> >>
> >> There is an early bail from sched_move_task() if p->sched_task_group is
> >> equal to p's 'cpu cgroup' (sched_get_task_group()). E.g. both are
> >> pointing to taskgroup '/user.slice/user-1000.slice/session-1.scope'
> >> (Ubuntu '22.04.5 LTS').
> >
> > Isn't this same use case that has been used by commit eff6c8ce8d4d to
> > show the benefit of adding the test if ((group ==
> > tsk->sched_task_group) ?
> > Adding Wuchi who added the condition
>
> IMHO, UnixBench spawn reports a performance number according to how many
> tasks could be spawned whereas, IIUC, commit eff6c8ce8d4d was reporting
> the time spend in sched_move_task().

But does not your patch revert the benefits shown in the figures of
commit eff6c8ce8d4d ? It skipped sched_move task in do_exit autogroup
and you adds it back


>
> [...]

