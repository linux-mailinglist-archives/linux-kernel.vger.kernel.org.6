Return-Path: <linux-kernel+bounces-527511-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D26C7A40C2C
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Feb 2025 00:48:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E03431899DBB
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Feb 2025 23:48:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B66EB2045A5;
	Sat, 22 Feb 2025 23:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b="EJumn34/"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5479E202C24
	for <linux-kernel@vger.kernel.org>; Sat, 22 Feb 2025 23:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740268080; cv=none; b=QQBhzQOTEJ4oO3M3W4Cz0F5r62RZJlXg0/R+jH7lC+FXkefNU69ioZbIDSBBPWH8UxfIiU2Plyvo+w8GhIiw7zHSV0YqGIG24dyHLltdwRjw5bZM4sHvC78anE3ekluNXyD78jCZFKldU8/xvfKT9QuVsFEEm6MQGrI+GcCB7cE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740268080; c=relaxed/simple;
	bh=h1O7BtV4AvvJbMc/RbhsPCxDAno9eXmHjqp84NP+Lrg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WgXjcB4lPrYY6gn/opWi8RkNOkPd/hWZIb/o0IbLiHW2BPFAPQmF3squ/t2qL8TaGx7c8Y/wm8utCWy6wQR+zD/4EHb92UzVTgzWd/HXVgBXd5NGzwe2+6SkcYNxX/Z3Srjwa22bcj/OqSAm0kVInDMSoUKpiVohxRrasCxueu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io; spf=pass smtp.mailfrom=layalina.io; dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b=EJumn34/; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=layalina.io
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4393dc02b78so22157595e9.3
        for <linux-kernel@vger.kernel.org>; Sat, 22 Feb 2025 15:47:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20230601.gappssmtp.com; s=20230601; t=1740268076; x=1740872876; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=IW+XFUQIismQw6gzhwnGYxNSoG/sgVyzbZ5an6zEu6Y=;
        b=EJumn34/uWdz33Qe/nyg/1YBDqmIn+uJVS6upATpdy+s4ibQKU/PrNZmHGqm69UYDy
         sutiSYzN/leXAwdaCrwCfSZp2OqeZRRTar/ue3Q+Nawx4chW0WP7dVLdcfjli5BPUmOK
         hXgzVk0z4P5fJ+zkPy+YFiI5Q44MnqKMPx4GZ17IIG6I/VhmaO5C1eOThY+84gxNBgCO
         TaUsgdHnTGk/WefsIntq+Hv4B29cShU8i+l4QNzY3SXZa208Nw0dC+HtGGqMfA+bKQmC
         QIJMsf0F5JoKqZVOhGUvon1MJ8HwwnoBSDI1qyDVRqFk2k4YwoNokrH95r1hhHD4h/BR
         fQUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740268076; x=1740872876;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IW+XFUQIismQw6gzhwnGYxNSoG/sgVyzbZ5an6zEu6Y=;
        b=XEJ5WDL28EyBPB43fhTKZIzHjQG42RMA1+c9soZOrwKTuiWFafndgDCKn/4I0gl9rI
         x5wzWbdK/R503P8d/I1z5Rfu8/N0DylTOUOM8U/YdQMVDMJlRlkHAlMdtir04sTyfi9y
         F4jQssqyx/sWhAkEGlNBwCztg3/+h4gLcrIW+OD+b050uivDwKokqc5URNxHAq9r6/LA
         lb2aPewH4sn6lEmm2YYV7RSK5j3tdQktyg9bkvYwona/V32a72lTI5Lg23MGgUNl6EzY
         jMMtkr4mkAhos8Lw/PjuHbTLq5Z2mQ3Y9VC5M7yE2+T48kJeX4F7UQHYhb6BEJANwcLz
         o83g==
X-Forwarded-Encrypted: i=1; AJvYcCWuFOv+AkZkqKxOU554TgcDD4qq8C+wbXqy4kK6m63nLwJELuFmHUvlxnjZlcLE/nifbjIWEXXpOOnGKzk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxmVpvNmZ+uGOA8wRVkM8R+wSucfVCjGTegl6bjbINHaRA/p5zS
	yq/mpEn4VSDxXQKnZOuCyULZiuahts6VDK/Pzv60Jn9AztnL2hsQDPXiLIQg+kI=
X-Gm-Gg: ASbGncvsb68IcVBnwUQdJjNZLkyX5EbnASqcZcKXL5x6Gb2YhppriP1zJAhQGN3Znu+
	r/qEdLdtswspl8ZF9MgmHOVOipwIw7ySFCmHw8idy0av396wj6hkUEIpnX6whHfbKgbyLk2wDrr
	pZv0tU5E0xMktm0EPAX2dhBl94xNwYK2C+1Wdam1dIp6NDg1kofw0A9zzaAXzgmYvZqhkLRThrd
	uUNoT3PemN4YwH+ixUXY9tJDjgcPiSCkv2y4JDWwrHkL7gbFn8RHdO3ycKQOXErEVskg5ORmVxH
	UBBG3M0WyzCynDXSiCUh
X-Google-Smtp-Source: AGHT+IGZTIQxYg71XgJqv1vvEyOJCEOBpP6FMuxnKZLw8Lb5u/WRZMO8spt71+/SxTJfqSOpojXnNA==
X-Received: by 2002:a5d:698c:0:b0:38f:2a5e:f169 with SMTP id ffacd0b85a97d-38f6f08639bmr4663882f8f.37.1740268076546;
        Sat, 22 Feb 2025 15:47:56 -0800 (PST)
Received: from airbuntu ([46.186.201.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-439b02d5147sm60243745e9.10.2025.02.22.15.47.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Feb 2025 15:47:56 -0800 (PST)
Date: Sat, 22 Feb 2025 23:47:49 +0000
From: Qais Yousef <qyousef@layalina.io>
To: David Laight <david.laight.linux@gmail.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	John Stultz <jstultz@google.com>,
	Saravana Kannan <saravanak@google.com>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Kconfig.hz: Change default HZ to 1000
Message-ID: <20250222234749.swpcspu2x3htapck@airbuntu>
References: <20250210001915.123424-1-qyousef@layalina.io>
 <20250216190540.254512a5@pumpkin>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250216190540.254512a5@pumpkin>

On 02/16/25 19:05, David Laight wrote:
> On Mon, 10 Feb 2025 00:19:15 +0000
> Qais Yousef <qyousef@layalina.io> wrote:
> 
> > The frequency at which TICK happens is very important from scheduler
> > perspective. There's a responsiveness trade-of that for interactive
> > systems the current default is set too low.
> 
> The problem I see is that most people use a kernel from one of the distributions.
> So you need to persuade them to change their default.
> Change the default 'default' won't necessarily have any effect.

True to some extent. I think Debian [1] relies on kernel's default, which is
a big distro. But the worry goes beyond that. I think 1K HZ is the modern
sensible default for all users. It shouldn't cause power issue given NOHZ and
other improvements. And the logic for context switch etc is no longer valid
IMHO.  Based on sched_ext saga it shows that people care a lot more on spending
more time to do the right decision given the complexity of today's systems. And
the systems I work on (mobile phones) I don't see impact on throughput. So IMHO
both sides of the arguments are no longer valid, but we continue to get common
discussions about latencies. This won't solve all problems, but will hopefully
send the right message to ensure most users switch to this too and address one
of the root causes for this common 'complaint'.

> 
> OTOH if you decouple the timer interrupt rate from HZ (or jiffies)
> then it becomes possible to boot time (or even run-time) change
> the timer interrupt rate.
> 
> So it makes much more sense to fix 'jiffies' as a 1ms counter and then
> configure the timer interrupt to be a number of ms/jiffies.
> 
> This would be similar all the simplifications that came about by making
> the high precision timestamps (etc) ns regardless of the actual
> resolution on any specific hardware.

Agreed. John is trying to do something similar but review comments show cased
teething issues. I did spend a long time working on converting HZ to be
a variable and switched a large number of users - but lost all this work sadly
when my machine died and forgot to push..

I think moving the default to follow what most folks should really be using is
the right thing for now IMHO. It doesn't force anyone to make an alternate
choice if they think they know really better.

[1] https://salsa.debian.org/kernel-team/linux/-/blob/debian/latest/debian/config/config#L6389

