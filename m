Return-Path: <linux-kernel+bounces-311880-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 17AD3968EEB
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 22:43:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 82B6D1F2355C
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 20:43:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44E571A4E7F;
	Mon,  2 Sep 2024 20:43:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b="jIPbssxT"
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D822B1581F8
	for <linux-kernel@vger.kernel.org>; Mon,  2 Sep 2024 20:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725309788; cv=none; b=TmHXE9ZIFUeI0b6xzB040rX5yPvu8HBjqYAZHrCY204693G6BA699jgQ7qgJXyUS4BG035hl3GOXtO+L/nqZE3ZdNtNsOLqRUeYn8gem3xuRfZhYuizcLiRgRU/bskIPsLKCfstmZPj0oNvfdV7ev0UfzKBws9NGIjQwKX3nwwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725309788; c=relaxed/simple;
	bh=2pzx0cEcSe4li1KrxmXMQ9xUtR2Ujpwtv1QhY4L6EBM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AdKqX3Ri8jBttFGRItOROnnvYhhLk6xAu71LQu+HXpzsjzSE1pxKyAuXf5PTW1sr1f1Ez1QerSSSxJvCCBOKz4/ONwMx7M3U2QEq2YAPeAYfjlsl11qbna698//EbFsgtJr74NwDMRdqbja1kZ4JiK+0Dup+imEnRJQeV59jG3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io; spf=pass smtp.mailfrom=layalina.io; dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b=jIPbssxT; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=layalina.io
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2f50f1d864fso53016241fa.1
        for <linux-kernel@vger.kernel.org>; Mon, 02 Sep 2024 13:43:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20230601.gappssmtp.com; s=20230601; t=1725309785; x=1725914585; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZL7FkBuEHp0RB7JLTPCHyfRNqy0CmQ95XZXKOkuvJT0=;
        b=jIPbssxTTI1NLCAgu/Q79ruZCCP70kfTRkbTSmvchLp8gO1ai1Cmc4c9NWxXw83sIO
         xB4Q8aHbJyZiKU99BFGQqxV5XZRNDukhWilgz6TWj80lr6h16FWNrjkUq2Oh0j02er7n
         jLfRTDpGz2FXrkr0BoG7v3xSYs4ZwQSDADSXuN9z1Z+CpyL4Va8YX5mAQnnjzrdCq4If
         dzT9MDry6fPz6Fx/4PkoaWRvXa2N047EjbxmJLFFf/qhWlMaxlSOVXPvRJVWDV/MtzAy
         dmbzMDKP85dnpOB8zymrsd1jSxKRmiNQYIfBHAuwdwG12F1JtYF4zDk3Zk/E/GFC56t3
         m13A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725309785; x=1725914585;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZL7FkBuEHp0RB7JLTPCHyfRNqy0CmQ95XZXKOkuvJT0=;
        b=FPuCBwj/NW2iNWM0lc0tTsd4VpbOlRka/7loyNVzF2QylH5i7mVUpvy2A+gM3tPand
         04xM+jpmbrLut7Vn1IuLJPil3altBwxByxXfAnohsGgjSfux+z1maE+R//F+k183r8I+
         Xjc4Nr7k6iSmcZPct7RzD0zJBHUiFNEdZ1C4XUrfQcwortIlJ7uO3QgBgsy0zYikLJjr
         25roDNTX07jcXr9gPo9FYWmXena+oar3SUt+GRaa7+1dxuwwNnzSYYRkp0pzT7EYNjSh
         gZ43Y99ZTBqy9CmcmnjtMTAqt2DtN4Ew4yRmABAfpZDwnyOQHr3+qs3d3bdBB9qxLYRP
         2wPQ==
X-Forwarded-Encrypted: i=1; AJvYcCUX+YahVlc8AzN2jeYPdoL/EJtXUrNTbCS3ocPPdgO9x4qiI7evTSnS4Dc0o/ZYRMQSd/Nv4AIGfOctiHg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzH/wP+A9foykq4XJ0zo04joxLRRTskbgz+t83OZGxwCmxyjZcj
	FttNRZOWThUO43ek3JL4SMdAH2IXlqPxR5ALMHeqJI1Y4Utiabh11cefaNwGN44=
X-Google-Smtp-Source: AGHT+IFkOkpk8BJOobO5aqLxZe3h+clvdhm1jvoZFktYDp896OY0KvlM1qPoTYygnoA3KOmfuPJbPQ==
X-Received: by 2002:a05:6512:3054:b0:52e:7542:f471 with SMTP id 2adb3069b0e04-53546b34bb6mr9317552e87.29.1725309784653;
        Mon, 02 Sep 2024 13:43:04 -0700 (PDT)
Received: from airbuntu ([176.29.222.46])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8989215cb5sm597380366b.191.2024.09.02.13.43.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Sep 2024 13:43:04 -0700 (PDT)
Date: Mon, 2 Sep 2024 21:43:01 +0100
From: Qais Yousef <qyousef@layalina.io>
To: Vincent Guittot <vincent.guittot@linaro.org>
Cc: Christian Loehle <christian.loehle@arm.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Ingo Molnar <mingo@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Hongyan Xia <hongyan.xia2@arm.com>,
	John Stultz <jstultz@google.com>, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7] sched: Consolidate cpufreq updates
Message-ID: <20240902204301.v55w7id3d2kw64qy@airbuntu>
References: <20240728184551.42133-1-qyousef@layalina.io>
 <ca6b1db0-37d9-462e-87e4-d3bbd5eec7a3@arm.com>
 <CAKfTPtBWLe4hMBhJeSqvoW10dAF3Bgj+zcYGMgBfwUhkgytkEQ@mail.gmail.com>
 <CAKfTPtAJNjUe=4eQxq0M6==6O7dtJrw6rtwE6-xaWMJdSmfKcA@mail.gmail.com>
 <20240901175149.46yfk335niccmfq4@airbuntu>
 <CAKfTPtBahrD5L8CbB4BijAvnwq=yG375TWDUuEvNipyTDYGQTA@mail.gmail.com>
 <20240902125815.vu3s25ciib34eu3a@airbuntu>
 <CAKfTPtDr5nEHYJ0=_-3a6wVZ25TPoiohBNmhGBaZMCrYHydh8w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAKfTPtDr5nEHYJ0=_-3a6wVZ25TPoiohBNmhGBaZMCrYHydh8w@mail.gmail.com>

On 09/02/24 15:36, Vincent Guittot wrote:

> > If we have 1 CPU per PD, then relaxing affinity will allow it to run anywhere.
> > I am just this will be safe on all platforms of course.
> >
> > But yeah, I don't think this is a solution anyway but the simplest thing to
> > make it harder to hit.
> >
> > > The problem is that the 1st switch to task A will be preempted by
> > > sugov so the 1st switch is useless. You should call cpufreq_update
> > > before switching to A so that we skip the useless switch to task A and
> > > directly switch to sugov 1st then task A
> >
> > Can we do this safely after we pick task A, but before we do the actual context
> > switch? One of the reasons I put this too late is because there's a late call
> > to balance_calbacks() that can impact the state of the rq and important to take
> > into account based on my previous testing and analysis.
> 
> I don't have all cases in mind and it would need more thinking but
> this should be doable
> 
> >
> > Any reason we need to run the sugov worker as DL instead for example being
> > a softirq?
> 
> sugov can sleep

Hmm. I thought the biggest worry is about this operation requires synchronous
operation to talk to hw/fw to change the frequency which can be slow and we
don't want this to happen from the scheduler fast path with all the critical
locks held.

If we sleep, then the sugov DL task will experience multiple context switches
to perform its work. So it is very slow anyway.

IMO refactoring the code so we allow drivers that don't sleep to run from
softirq context to speed things up and avoid any context switches is the
sensible optimization to do.

Drivers that sleep will experience significant delays and I'm not seeing the
point of optimizing an additional context switch. I don't see we need to get
out of our way to accommodate these slow platforms. But give them the option to
move to something better if they manage to write their code to avoid sleeps.

Would this be a suitable option to move forward?

FWIW I did test this on pixel 6 which !fast_switch and benchmark scores are
either the same or better (less frame drops in UI particularly).

