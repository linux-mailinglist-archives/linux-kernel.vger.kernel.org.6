Return-Path: <linux-kernel+bounces-217179-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 933DA90AC8C
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 13:04:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1D18E1F23525
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 11:04:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 784B819069B;
	Mon, 17 Jun 2024 11:03:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b="AdSe1kuB"
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC3AD381A1
	for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2024 11:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718622233; cv=none; b=MM/fXZMDclVZt6Xr7DxZFgKS099sm7UjJ7ovsjoCNSP/1npgiMuKWxcrfgAG4jWS0OsI4uyEyYqTIZIzaHDQCeWu+wKjtpIo9eLVPELHrg/fThlJ0KvKDlA27JvbCJjRk1tyBrtxEsUEt4xYIPBsMVjSKicNxMPz0171Ovd+QTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718622233; c=relaxed/simple;
	bh=XHe6rv1MpYBSa+Mt6pzf+eG/Y/znxxbmr96cmN4mCDk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fLcSTZBBV8jKSHdBo27v/YW7DeqTnsTzEaex70T2mopOE1EMzWY0rOAZ7Wdgwr8MQkkjZM0nghXkcOt3i6iZl+ZMDhqSQdxovFjSiZBbhksTInPpexDQI+qd/wLGx9NfpAcCwQmkhb0sN8nu+609lwO7DD3YWFiFNlAASP7TK0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io; spf=pass smtp.mailfrom=layalina.io; dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b=AdSe1kuB; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=layalina.io
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-52c8342af5eso4503031e87.3
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2024 04:03:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20230601.gappssmtp.com; s=20230601; t=1718622230; x=1719227030; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=cnrEAgmCGZ8eT4SPyQ/ikR+mYDl+xm5NyyJ0BeqIo60=;
        b=AdSe1kuBc+NuRB9c182eOfQyHBtVCGshAW9XyQLIAaeTOoMCtHaLbGtfpbDhdWwUMc
         /PYqQnAG4TNnWFUxyEGs/ia0wzRuxNbl1QjP2ig+4H77dw4j0NUWIj2q5FNYXQDdh1sj
         KJm5XTu3aWegyEDg6M3T1d5MHWma4VQIMUpF0mmhbIrGxaB/7F/26hygK/mcJFqeLW+1
         F8CHm7HTqmOOKc1VDdOwnv/UL1ty1qtfPatR1dhZmCg96yLY1+iDGwLO4wz+4hWKRJzn
         8fh+7SaOoUe+RhUHfBcWrDnMzH91UeUmnG85jDb9Pp+IUvpTYCi/Xk6g1s4/xoZ9cOFH
         DdHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718622230; x=1719227030;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cnrEAgmCGZ8eT4SPyQ/ikR+mYDl+xm5NyyJ0BeqIo60=;
        b=wXkxTCYeX8MVjjve84mXnkvGJOq5soXMUH/MsrGYJbjU2a9AgAcEhiRJCFkyLhHwjN
         TuXCxWFup2zLmpUY8MGQ9V6lgjeakL9ErrLLkhnzmE+yEBVc7Xan6oyvSwHj5Z04L4nG
         EKECplMZ+AZ7Uw5KJh1h02rdjly4i8PBoSKH670V0gFlYbeVSDV8gG6pGN6wjzPVrI9q
         y7ZZu171/zMWUZW8Xu4E4rtRRBFCY9ptijJ44VkViYavpN7OjxVRqVc+qC2QdtqkDfMm
         zoVireaLVt+3x56f+N4xUFY0IXUNYuJEsTlYHqS8la6i0IrE4+HHOWbpBBqTLPakNUbI
         rYkQ==
X-Forwarded-Encrypted: i=1; AJvYcCUp96Usap+3+8p/gyePosRK390SfDh67jlORvF7mFDZL63Y/RVH026pXou8tQDN6WV+t5NzT4yCcwzgDbIPyKleXuITOJ+eWcYvtj/N
X-Gm-Message-State: AOJu0YxZ86m1FnjMA+8zFIXe5OnR76VrvKmZWVWB8VNbsdbCA4BaZSFG
	F42YqPXffpzEU5EN80a2DGTXbnj2GCoVUewzimlCeKF44FAzCy/gCT4Toq9W+WQ=
X-Google-Smtp-Source: AGHT+IGRyD5Y9cfdFlHIRF5cLz5ElDkrxpQElmYKzRwP7fqAcoTbWBKETyf7X4XpDZNPL7KXuAFInQ==
X-Received: by 2002:a19:5e4c:0:b0:52b:c12e:b226 with SMTP id 2adb3069b0e04-52ca6e9a36dmr5256140e87.68.1718622229740;
        Mon, 17 Jun 2024 04:03:49 -0700 (PDT)
Received: from airbuntu (host81-157-90-255.range81-157.btcentralplus.com. [81.157.90.255])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-422f602ee95sm159457825e9.13.2024.06.17.04.03.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jun 2024 04:03:49 -0700 (PDT)
Date: Mon, 17 Jun 2024 12:03:48 +0100
From: Qais Yousef <qyousef@layalina.io>
To: Xuewen Yan <xuewen.yan94@gmail.com>
Cc: Xuewen Yan <xuewen.yan@unisoc.com>, vincent.guittot@linaro.org,
	mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
	mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
	vincent.donnefort@arm.com, ke.wang@unisoc.com,
	linux-kernel@vger.kernel.org, christian.loehle@arm.com
Subject: Re: [PATCH] sched/fair: Prevent cpu_busy_time from exceeding
 actual_cpu_capacity
Message-ID: <20240617110348.pyofhzekzoqda7fo@airbuntu>
References: <20240606070645.3295-1-xuewen.yan@unisoc.com>
 <20240609225520.6gnmx2wjhxghcxfo@airbuntu>
 <CAB8ipk-9EVgyii3SGH9GOA3Mb5oMQdn1_vLVrCsSn1FmSQieOw@mail.gmail.com>
 <20240616222003.agcz5osb2nkli75h@airbuntu>
 <CAB8ipk-ejDKQTr8nAmK9MkhL2Ra=0J==p3Q+U-4K18G6MeJhQw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAB8ipk-ejDKQTr8nAmK9MkhL2Ra=0J==p3Q+U-4K18G6MeJhQw@mail.gmail.com>

On 06/17/24 15:27, Xuewen Yan wrote:
> Hi Qais,
> 
> On Mon, Jun 17, 2024 at 6:20 AM Qais Yousef <qyousef@layalina.io> wrote:
> >
> > On 06/12/24 16:11, Xuewen Yan wrote:
> > > Hi Qais
> > >
> > > On Mon, Jun 10, 2024 at 6:55 AM Qais Yousef <qyousef@layalina.io> wrote:
> > > >
> > > > On 06/06/24 15:06, Xuewen Yan wrote:
> > > > > Because the effective_cpu_util() would return a util which
> > > > > maybe bigger than the actual_cpu_capacity, this could cause
> > > > > the pd_busy_time calculation errors.
> > > > > So clamp the cpu_busy_time with the eenv->cpu_cap, which is
> > > > > the actual_cpu_capacity.
> > > >
> > > > I actually think capping by pd_cap is something we should remove. Saturated
> > > > systems aren't calculated properly especially when uclamp_max is used.
> > > >
> > > > But this might a bigger change and out of scope of what you're proposing..
> > >
> > > I agree, there are other things to consider before doing this.
> > >
> > > >
> > > > Did this 'wrong' calculation cause an actual problem for task placement?
> > > > I assume the pd looked 'busier' because some CPUs were too busy.
> > >
> > > This will not only affect calculations in scenarios with high temperatures.
> > > Sometimes, users will set scalimg_max_freq to actively limit the CPU frequency,
> > > so that even if the CPU load is large, the CPU frequency will not be very high.
> > > At this time, even if tasks are placed on other CPUs in the same PD,
> > > the energy increment may not be too large, thus affecting core selection.
> > >
> > > >
> > > > Was the system in overutilzied state? Usually if one CPU is that busy
> > > > overutilized should be set and we'd skip EAS - unless uclamp_max was used.
> > >
> > > As Christian said, This case occurs not only in the overutil scenario,
> > > this scenario holds true as long as the actual-cpu-capacity caused by
> > > the reduction in max cpu frequency is smaller than the cpu util.
> >
> > Hmm. Sorry I might be thick here, but shouldn't fits_capacity() use
> > capacity_of() which should return capacity based on get_actual_cpu_capacity()
> > to compare if we are overutilized? If we are higher than this value that you
> > need to cap, then the CPU must be overutilized and we shouldn't be in feec() in
> > the first place, no? Unless the rq is capped with uclamp_max that is.
> 
> Sorry, I miss the "fits_capacity() use capacity_of()", and without
> uclamp_max, the rd is over-utilized,
> and would not use feec().
> But I notice the uclamp_max, if the rq's uclamp_max is smaller than
> SCHED_CAPACITY_SCALE,
> and is bigger than actual_cpu_capacity, the util_fits_cpu() would
> return true, and the rd is not over-utilized.
> Is this setting intentional?

Hmm. To a great extent yes. We didn't want to take all types of rq pressure
into account for uclamp_max. But this corner case could be debatable.

Is this the source of your problem? If you change util_fits_cpu() to return
false here, would this fix the problem you're seeing?

> 
> >
> > I generally think our current definition of overutilized is wrong and the use
> > case you're talking about should hold true if it's just a single CPU that is
> > overutilized. But I can't see how you end up in feec() if the util is higher
> > than the CPU in our current code base.
> >
> > What did I miss?
> >
> > And should effective_cpu_util() return a value higher than
> > get_actual_cpu_capacity()?
> 
> I also thought about changing this at first, but because this function
> is called in many places,
> I am not 100% sure that changing it will not have any unexpected consequences,
> so I only changed feec():)

Yes I had similar doubts. But the question had to be asked :-)

