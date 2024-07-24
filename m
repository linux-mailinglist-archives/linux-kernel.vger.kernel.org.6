Return-Path: <linux-kernel+bounces-261543-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C9C8593B893
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 23:35:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 475C5286663
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 21:35:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DA6A13A863;
	Wed, 24 Jul 2024 21:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b="hDmju0M/"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45EDE2AE6C
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2024 21:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721856934; cv=none; b=RPZOiMXpGESmMH5+1zWpbz0P6EBGMUb1x45eZbNeCZiD2YnHKDdJtENVBmqs2ZyB20vpbHm8I8s6GNEY8Qf5XI1/JvK9H8q4FQoRl4bBb6tSR8fEPVHfajgiXNdb+1hjjgkZ+dQ0KzDZUT/PsYQvJ1+StlTQoHYn9W/2xT7i+cM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721856934; c=relaxed/simple;
	bh=HlKzIvbFppXitc4BqKMA72fKGFNmu+AotnZyD/Qcqgs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IOlrL1jEHn5h8nlbNumaDEGOJxPzV+X1L5GGgtW8OipAosAXUtryCi63QmHTEmEpqQzShmCfyr/h5XJ00I8Psw59n+rH/v9k0Vgu1sb8to3FbZu7OXhvFmtFrUGT9C2dJxjCog6Ghx9lNVwe7ESa8KYF740EOsulXJYfG3WCplI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io; spf=pass smtp.mailfrom=layalina.io; dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b=hDmju0M/; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=layalina.io
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4267300145eso2045555e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2024 14:35:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20230601.gappssmtp.com; s=20230601; t=1721856932; x=1722461732; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=zofhhb9/Kwl1wS0JEra+p05fuClt33yVyCbzQtUwVho=;
        b=hDmju0M/a+CLHYfpG4fKp17OuvvkfhLdy1+ncZnsQz4uKLAxbagBuZ25RKpPdhV9e3
         IA8klxAmNo4PI1hp4Y35prVgsZYANNQtRoMofrLndhrFgDBjDZ2zfCK8pb6zfsodJQ6Q
         XqNjGrnmzwmuATja63aEd/25YQ04VXdsu2Gvc/opoECeOBuWPpH2oxdj+cEW6vTbtT+W
         nX/4f1nQWzytkGiDCuNmbFreID/sapBl2ldCUn4GkWkE0iagFD+BkTYB4OkL3cnq05eG
         yjNJhBX2vGLrEZSFjS+KnMUoUW1dkuUVTmvBkhqoYh/mhxZfH5VE3GC2eIxIJAsBofV2
         tL2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721856932; x=1722461732;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zofhhb9/Kwl1wS0JEra+p05fuClt33yVyCbzQtUwVho=;
        b=Gon52wma5KHR246jKtqdWG/oOKjahKFZuNzbWaWt7trH9ALHsw8qqQ6d+ox4sGp07L
         AbRs0qlCm81seBYzpVzl/BU034XjyPw2/HRlBPLtVO/czhYB+ByKFI7qC/UvhAEMvmOw
         BlozXK+hN9wDjH6FeMkoZLfItlXUNsRram8ifbjws+EE6tXEzCgTl4TF3YAGbeLa3/Vy
         /HDtbMSPSqK7PQ9/OuckPPHcZ/T7Z5rXg+6VyIee9c8QkwwougfV7+dwb7hST2RgjZwV
         xNwkKoJDryQnqhrK4Ay87UwKTueiSD/b33UDeAfUt+Ovn8kuMNfQhJlcVhY0vwgpMpNS
         AMQw==
X-Forwarded-Encrypted: i=1; AJvYcCXgfvxG6M5ofcXm1zdkpkDMMRH4Df+wQ0swXxofZtdMCAuI4fTW/XoZudn4Ilar9R7iKunSN22htmG1sR56mRyXKsc7SxpILXtbGhhK
X-Gm-Message-State: AOJu0YzC3LlJoaDp45DWCl0+sSVNJ8Ps1tWxhAg3seOuta46sqS6a9Bq
	7T0orXnZTgMgTJMqJoFZ8yXMHtXD5OGqNwyNZv807JM0ItfzBEW7b4HlpMGOa4Q=
X-Google-Smtp-Source: AGHT+IEYwCbH3Hzxsb3zutI7NDoyDkJ8JF/wQ3MZoumJYLLfIxCct6YajlPAgakl0dTiI09n3HQzRg==
X-Received: by 2002:a05:600c:4e90:b0:426:59d3:8cae with SMTP id 5b1f17b1804b1-42806b87ef4mr95385e9.13.1721856931691;
        Wed, 24 Jul 2024 14:35:31 -0700 (PDT)
Received: from airbuntu (host81-157-90-255.range81-157.btcentralplus.com. [81.157.90.255])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-427f93594e7sm46683585e9.8.2024.07.24.14.35.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jul 2024 14:35:31 -0700 (PDT)
Date: Wed, 24 Jul 2024 22:35:30 +0100
From: Qais Yousef <qyousef@layalina.io>
To: Xuewen Yan <xuewen.yan94@gmail.com>
Cc: Ingo Molnar <mingo@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	linux-kernel@vger.kernel.org, Lukasz Luba <lukasz.luba@arm.com>,
	Wei Wang <wvw@google.com>, Rick Yiu <rickyiu@google.com>,
	Chung-Kai Mei <chungkai@google.com>,
	Xuewen Yan <xuewen.yan@unisoc.com>,
	John Stultz <jstultz@google.com>
Subject: Re: [PATCH 2/3] sched/fair: Generalize misfit lb by adding a misfit
 reason
Message-ID: <20240724213530.akr2ghuzabz3mfxw@airbuntu>
References: <20231209011759.398021-1-qyousef@layalina.io>
 <20231209011759.398021-3-qyousef@layalina.io>
 <CAB8ipk9+4p29iE8HSiRrcc8DanCcO2U3+HRVY5LXLJRWXFMpOw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAB8ipk9+4p29iE8HSiRrcc8DanCcO2U3+HRVY5LXLJRWXFMpOw@mail.gmail.com>

Hi Xuewen

On 07/17/24 16:26, Xuewen Yan wrote:
> Hi Qais
> 
> On Sat, Dec 9, 2023 at 9:19 AM Qais Yousef <qyousef@layalina.io> wrote:

> > @@ -11008,6 +11025,7 @@ static struct rq *find_busiest_queue(struct lb_env *env,
> >                  * average load.
> >                  */
> >                 if (env->sd->flags & SD_ASYM_CPUCAPACITY &&
> > +                   rq->misfit_reason == MISFIT_PERF &&
> 
> In Android, I found this would cause a task loop to change the CPUs.
> Maybe this should be removed. Because for the same capacity cpus, we
> should skip this cpu when nr_running=1.

Could you explain a bit more? Are you saying this is changing the behavior for
some use case? The check will ensure this path is only triggered for misfit
upmigration. Which AFAICT the only reason why this path was added.

The problem is that to implement another misfit reason, the check for
capacity_greater() is not true except for MISFIT_PERF. For MISFIT_POWER, we
want the CPU to be smaller.

I think Vincent is working on a better way to handle all of this now.

> 
> >                     !capacity_greater(capacity_of(env->dst_cpu), capacity) &&
> >                     nr_running == 1)
> >                         continue;

