Return-Path: <linux-kernel+bounces-345650-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B73598B8A9
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 11:50:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8BAB5B21829
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 09:50:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E72A19DFB8;
	Tue,  1 Oct 2024 09:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AhtM/sWW"
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4560E2BAF1
	for <linux-kernel@vger.kernel.org>; Tue,  1 Oct 2024 09:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727776215; cv=none; b=GbTzc8lQMXQXJrRPwhLWlGQ79J9gxtvYUCCb6lJVdILLOU6w+OYkYnUNB1cPg0mu7mb4H4EPnBX2dHBQtHYX1+P3+gRE3a7M+0hBSg8GpE5Ai5naGA9+8S3noeTCxtTcOJ7YUVwnmAwYhCS9YNwKYJH93r+eR2XJVDvVXaHSveE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727776215; c=relaxed/simple;
	bh=slSD3cMwFoc3GZKV/aH55sboQWuTVBmhD8YXrbSbD58=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FMW1naAtjkGYejnoWtFlBio/vgAOmvgR4ixpDbZXPYXt9JjpinwyDB919dEmXeDqVanRj4a6RT9cUbsgu39wIoPZyMO8zYxx/vgoH+GLLex32TqZRm5QfWiApcQIIQuiRLL4hkHD5UTydEjoARE7Wq82UzTXOp7bbE0rls3X3cU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=AhtM/sWW; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-2db89fb53f9so3861890a91.3
        for <linux-kernel@vger.kernel.org>; Tue, 01 Oct 2024 02:50:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1727776213; x=1728381013; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=slSD3cMwFoc3GZKV/aH55sboQWuTVBmhD8YXrbSbD58=;
        b=AhtM/sWWjM6GC+Yj8Q8WstGqVrNXLguBekzFEA5WFv1Aqa4WxekBdFh9WjYaU00wvG
         oVeo/Jf4T/RGjyJK3Z9VELeHNKRL14wrKfx7NWEWHk8OmUk23GShlxz5hXlu0yzWoIQf
         GIJd05GF+yoHLxydiVAlhIG0i2AeUt7UWN/Iv+H5C9BSHE3keTEjndovquV1HOFVFFRD
         7g2nAexU/XnxCdCw/wSNr5Jphwv8QeLWPWR1F6LEzAb7J+lrPUEF7QEbvEz78YtBRfG+
         9sy2QSwpEy4e51O/60MHbxDjDjrAWzVr9Q90ZVtWl66uHODKlILD1BwzCZjH0jdvdQZh
         /W7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727776213; x=1728381013;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=slSD3cMwFoc3GZKV/aH55sboQWuTVBmhD8YXrbSbD58=;
        b=w/60o7UfCGY5SKFdBYofbdjDRiUs4GPyP3S1S985f3W1w/0oiKcD+laVgro0T1zO8H
         Ifzd3iZpLvmPUiyM3z5GyDycady27kDZkAPOJAHiNKusSNekkbHzdrpDKcuzRvuqcw/c
         x5WaRR5XEOSk3WxYzEovvn8a5F4mMUGYfnqhAG4cG8uSyXWicqvPkbjxIW3+eCeUCBfk
         VN9ItoKV16sBbO2v2xSL4OolaMqWGpoAFFy6YXk+1ihYgqRo2blHQD4QiSeDVkg05V71
         JOcPPsHAC4qdK70xW17GqlcdyOoMzSwhRlRiD1OoYHkQQZXihVfbHQ5HAV1cBKksR0SK
         lZ7w==
X-Forwarded-Encrypted: i=1; AJvYcCXFSpL801HS2r/zOtw9UzB9tNPF1kU3nRAFDDP+AjK3qGgDZ9uspNqppTFnIdiknsPvqoWhAL3Z6/SSHpE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwHk8gkLYxWOc97zxD6jc4zobEunBWZu69Zj+eMPdoCysuCazfl
	a6klLn24B4Xnn7jBkpb/vZQ5fYjsrSvT5lt4GtgwG/sgFF9lVh1iA1ceCOLtzkhFbmopzUU7NbC
	UWp5bQwz8mma4Nfo3xWmUiEJz1kXsgvGdy/WbIQ==
X-Google-Smtp-Source: AGHT+IHgq6n0FE7bpnxOkqyC+BjiPfQrMEmnps8Xcs8aKCMdZqTzbugmj4Cv5dBKPW+uFYm64ApoUAsbv7bJP/Egi1I=
X-Received: by 2002:a17:90a:55ce:b0:2e0:a926:19b1 with SMTP id
 98e67ed59e1d1-2e0b8ee65a8mr16355620a91.38.1727776213471; Tue, 01 Oct 2024
 02:50:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240829220427.2764399-1-joshdon@google.com> <CABk29Nv=Gj9H0dfvdV0E9us+jBnysoPXYoO-Rkn46rwGtg7=hA@mail.gmail.com>
In-Reply-To: <CABk29Nv=Gj9H0dfvdV0E9us+jBnysoPXYoO-Rkn46rwGtg7=hA@mail.gmail.com>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Tue, 1 Oct 2024 11:50:02 +0200
Message-ID: <CAKfTPtALrwODTP8ZunfKgun75mr5OVsXB_KMmLxeFxjyKkrCyg@mail.gmail.com>
Subject: Re: [PATCH] sched: fix warning in sched_setaffinity
To: Josh Don <joshdon@google.com>
Cc: Waiman Long <longman@redhat.com>, Ingo Molnar <mingo@redhat.com>, 
	Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>, 
	Dietmar Eggemann <dietmar.eggemann@arm.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
	Valentin Schneider <vschneid@redhat.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 30 Sept 2024 at 22:26, Josh Don <joshdon@google.com> wrote:
>
> On Thu, Aug 29, 2024 at 3:04=E2=80=AFPM Josh Don <joshdon@google.com> wro=
te:
> >
> > Commit 8f9ea86fdf99b added some logic to sched_setaffinity that include=
d
> > a WARN when a per-task affinity assignment races with a cpuset update.
> >
> > Specifically, we can have a race where a cpuset update results in the
> > task affinity no longer being a subset of the cpuset. That's fine; we
> > have a fallback to instead use the cpuset mask. However, we have a WARN
> > set up that will trigger if the cpuset mask has no overlap at all with
> > the requested task affinity. This shouldn't be a warning condition; its
> > trivial to create this condition.
> >
> > Reproduced the warning by the following setup:
> >
> > - $PID inside a cpuset cgroup
> > - another thread repeatedly switching the cpuset cpus from 1-2 to just =
1
> > - another thread repeatedly setting the $PID affinity (via taskset) to =
2
> >
> > Fixes: 8f9ea86fdf99b ("sched: Always preserve the user requested cpumas=
k")
> > Signed-off-by: Josh Don <joshdon@google.com>
>
> Gentle ping to bump this in case it got lost.

I have also been able to reproduce the race and the WARN with the
steps described in the commit description

Acked-and-tested-by: Vincent Guittot <vincent.guittot@linaro.org>

>
> I've also collected the following:
>
> Acked-by: Waiman Long <longman@redhat.com>
> Tested-by: Madadi Vineeth Reddy <vineethr@linux.ibm.com>
>
> Best,
> Josh

