Return-Path: <linux-kernel+bounces-532041-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0469BA44829
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 18:33:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 29514881BAE
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 17:18:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B14F1DDC1A;
	Tue, 25 Feb 2025 17:15:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fh9qCHhd"
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D28D1993A3
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 17:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740503750; cv=none; b=JZZq80BKcl+3AMzBmuj9H5KquzMtEkIaGej/A1JWnlX5NbGCl1+Rc/mWJ1E2FrA+E3MNGT4Fr/c0+1b9DdqRRZMC/paHC/meuFkKYl61yatRICZw9gLHOAETziPyw1mID9pJ5bpyUhcZFarAtAsLVFDqDjO0ihkc8FES/C0D58E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740503750; c=relaxed/simple;
	bh=lkQvFVIvZQta0+aNOIT6AAw2R3T9dNrKkosqjbctdkA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=s+oDs3yHTiU5MSs+NnylyngmUPVeF2I9jlroUizov11prufEDzvyp82IrXmOclmrWCkMJY6+zPewtqRY8PoG7TjxXbAnqGM3HBiJj7MLSe75rGNCY6QaPw85g8/dQmV6Q+nA3KRKpv6vJ3pg8ylBIV6ejy9lOIf7Sk7S3J6tZrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=fh9qCHhd; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5ded1395213so9796687a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 09:15:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740503747; x=1741108547; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=FEK4xb/B08Bwt7c6wjhqP2Q9Ow5NOLQIal4ilKYegN4=;
        b=fh9qCHhdn3mUoV3ALcU5pJQop2TtIucoN/c6s1eceNfyRaoOoQ7cluSuTjVL553WmX
         jMDLZVSZ+2vVlohPqfmaPR8iDgzOQY44Zova8GuCkeu680ZbaDyaMnOyi7dOzWClHzo4
         qUJ+kXTR0dfqc94igV3F7LUJbB87WlYkXPIqb6Vkfh46clgIBGnNaOSq7Vxl8g2/7HQW
         r1eENgLusXxXAZMndLQzCKQJD8/ehLyXZ1mJtddPwUzNulyweHRPaKaGKWS3sisjccdd
         aB5uuyWvv+5W4W6ObElr3ya/1495CDvE2gq3Fj116FrrlOADZDYDDQmBCaESsk5QYOKO
         Dqlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740503747; x=1741108547;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FEK4xb/B08Bwt7c6wjhqP2Q9Ow5NOLQIal4ilKYegN4=;
        b=k10HtIcX1/bB8Nu3IRO63XWyKd0bAHPGojF5j7Y8ci7zLi8CDzGhhE+utDVZwHbWWm
         lbhypdh1aWoZLVU/pi8tltM8BGhS6ZnnZXPaOHO/2imYJVSKFJlxbEemoEdy20ynMzhG
         HzBqjqL2swNyL//06RG9hX/OGtUTTpEYCRTc/tLkSWonc3W+aqpJUAheFwV1HhOjBS8V
         j2hlmi3IzPv1SM9WJONO31VQ5d3U56NeblueNe78gzycNd16opKTFbFR0dKfAJpqmCbj
         7Db3ikr6HN516XkpoqbvTvr3ndBbtPUVscPm9wJTihjKHVVUBGKo5JulUq37GEd3DscZ
         OXWQ==
X-Forwarded-Encrypted: i=1; AJvYcCWplkmNHwPRVwr8LXRTu0sE1PLdvSthZZjravQnwdp44o7pJv6gmbNe6rSFkoBZdDHd/JzRnANkKMRL9gY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzK3ErJHcg7toweTtww4dgzQsiAE4k3rwllJD8zlUoFQuo8/lsz
	gW56sJ9mV/EbJBS+G5cnvo8kWuEmVB42RIgMHTVZG4wYC2/t8wGmy0Bi4WOcY/dQY6MkctTgjs2
	xWEig7oo9zfS9RrfdpUklFwy3mSQUFIOtwO7i6A==
X-Gm-Gg: ASbGncto7WjeUt9rSFBFJdgWtRg5LV5R9jpWH1aPR9CxfImeocbz5E+v/qb7BL4aXAN
	tg6et3pBtEyBl+K7yGU5MOkP5hvzxeGyWudDPzer86kwTjTj1hEAotmpOUNcsSnmTOOzLLIK0kF
	EvZ1D3g7Q0oFl+2XIMnuI9KT8YyEhEOdHenyrm
X-Google-Smtp-Source: AGHT+IGO+PuQkfrw24e9rTYkf6+kbTPyi2vcfG/Xugmqpr50mjP30AWfm7OjvZQPzYbxXrFYhU0lagUnZo69TH37vok=
X-Received: by 2002:a05:6402:2546:b0:5d0:aa2d:6eee with SMTP id
 4fb4d7f45d1cf-5e44a254bd1mr3814794a12.26.1740503747273; Tue, 25 Feb 2025
 09:15:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250221111226.64455-1-wuyun.abel@bytedance.com>
 <20250221111226.64455-3-wuyun.abel@bytedance.com> <CAKfTPtBzsX6GKZP_NGTONrkp96qx9uOHr0+XG7tC6ELy4tbHBg@mail.gmail.com>
 <6097164a-aa99-4869-b666-9dc7018c1f96@bytedance.com> <e1cfabab-1326-4cd8-a8a4-4b3fc4c1f7ec@linux.ibm.com>
 <9d9d7432-9a5d-4216-ac53-a0f333a35d8f@bytedance.com> <d1237acd-9e3c-4ab9-8628-31d98fcf7638@linux.ibm.com>
 <83f8b833-af79-4d77-a179-5065aec994dc@bytedance.com> <CAKfTPtBL4aPbEDOa8jJ+h2wQ9CLU80=0mQdrc07vfqBVswzAsg@mail.gmail.com>
 <ffda0c9a-0794-4080-921f-99f0c31e2d6c@bytedance.com>
In-Reply-To: <ffda0c9a-0794-4080-921f-99f0c31e2d6c@bytedance.com>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Tue, 25 Feb 2025 18:15:36 +0100
X-Gm-Features: AQ5f1JqxPM0CgSVKDWr65uY1rO8CJdxHzTxs7zyX1TrZ7HPr41tDRLzWuTzraaw
Message-ID: <CAKfTPtC-pSxpk9i1T4rgc8U7M-nYJ_fdJKaBJa-1dwi9+scTbg@mail.gmail.com>
Subject: Re: Re: [PATCH 2/2] sched/fair: Fix premature check of WAKEUP_PREEMPTION
To: Abel Wu <wuyun.abel@bytedance.com>
Cc: Madadi Vineeth Reddy <vineethr@linux.ibm.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>, 
	Dietmar Eggemann <dietmar.eggemann@arm.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
	Valentin Schneider <vschneid@redhat.com>, Josh Don <joshdon@google.com>, 
	Tianchen Ding <dtcccc@linux.alibaba.com>, 
	"open list:SCHEDULER" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Tue, 25 Feb 2025 at 07:29, Abel Wu <wuyun.abel@bytedance.com> wrote:
>
> On 2/24/25 9:47 PM, Vincent Guittot wrote:
> >
> > Or we should just remove it. I'm curious to know who used it during
> > the last couple of years ? Having in mind that lazy preemption adds
>
> TBH I have never used this feature. But since Phil mentioned a case
> in debugging DELAY_DEQUEUE, I think we'd better keep it, what do you
> think?

Yes. And we need to figure out how to deal with the below as well

>
> > another level as check_preempt_wakeup_fair()  uses it so sched-idle
> > tasks might not always be immediately preempted anyway.
>
> Right, thanks for mention that.
>
> >
> >
> >>
> >> Thanks,
> >>          Abel
> >>
>

