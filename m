Return-Path: <linux-kernel+bounces-526547-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EFDDA4000F
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 20:54:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 025BD3BD9F5
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 19:54:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB2302475C2;
	Fri, 21 Feb 2025 19:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YX29Dsk5"
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E430A1EBA0C
	for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 19:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740167684; cv=none; b=mjQk6Zj5U5XO5GPUjWxFFhYw5Reusro2tWVqBRImPWdz0EkYtAQxJMq3B2UcBEVdxxoJyP7uLsq57mdhwO00fudkEz01MJ6jnwVl1AKyNoySgg59PJw/LMyUdsemGr2nuBjCm4f0xXPJbYzigBx2S6hiLmy1Lcj8KhW/coVe4N0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740167684; c=relaxed/simple;
	bh=Cdj7QFmZWIWsP73cueHtTzjl7arIGxQKjHw2vMjaWuw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PKGkIuvmW4Wu6sLKPKSGcCzJdDbroQ281eJxr6JB4x2D9By6FcEdL45M5oStOIPrV9Pio9jE/XU7lOSH4WIfbio6klDAVND8C8DF8CbszIuuu/ZiWXbnPMyeNBcA3DaD3fBpnbSYK//CrUW2BgJnkSu/eUqTT/NcjDvP5ucm/ec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YX29Dsk5; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-471fbfe8b89so57111cf.0
        for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 11:54:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740167682; x=1740772482; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Cdj7QFmZWIWsP73cueHtTzjl7arIGxQKjHw2vMjaWuw=;
        b=YX29Dsk5yIOvQ/SbyScZjMBPlZOC7vXSLfzqPJzAEh8rebI2BGENbe8o0yE11AZUUn
         qRE0AmNDEamszyJtK1ISXbWWDqT7ozx7TJEzrBQ4Cvsgbce5Ns0CqHtbGyvEGhYZvER/
         BYBedB+2R6pd8eMYXD5jp4ulHZHRf0UoJKZz/tvbOHK78NP69pAx4KtdkvD/wks1QLWw
         mBl6W2h+tSO1Bup2lX8Z6XEOx0eXAAN9rzE6XtbPXZ6GGxlzt1DLFoJKD35L1zrQDuZK
         XXuN8Z3qqbx4d5mrAAd+86nlgsW/xwC2QDQ9grF28W+apYjRie7RkRfgA1NsxtHUhqjt
         Cd5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740167682; x=1740772482;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Cdj7QFmZWIWsP73cueHtTzjl7arIGxQKjHw2vMjaWuw=;
        b=N5rqxnhmZKVHb2P644KZKc3n9UHPA/jgiCZCgg053z1vWmdTViMCNj+nok1nJp/4T5
         9qGVeSzztN+eGu9wO5uvczdg8A2Lgcqs9pIXZ/aXip+dxvsXE6Px+uPPoUtXeHgVYvxR
         uUKa2C/gxMBjhooOz9xr9gVlBBd/8neyvjFPs/t/G/z+xU4tnJ1XmgYuHeBmeiAEjXXz
         zvrBEZEW2Y2Bu/kwMaNNs3zaZ9DPF9diCj6t0maiNDYFVwAMQKmI5ud/3nmnWSBu5LkT
         onlQL6zlOlUaMl+bUC4X/OxvsjceJ/zH4wCLWJnrX7NUAElQHMdJCI9PX6V+/2rZOlPA
         o/7w==
X-Forwarded-Encrypted: i=1; AJvYcCXz4eu57z9PiSZlfbiL2FsEpLhcTYZ/zFBQ1Q/KWQ+OqGW1XyxRuFw/AiMeC+PoA6HLX26B/auhJxr0ZtM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzBWRZzPNcgRiPf8l2olVf6ZMzTMKMe39gjRT4ENEy21WSpD2tG
	Swsk8mAGkQocIjmyAVrXaPoFhVQjucSr9NhsZQdCs3ytcAQIv3FrDRAhz9Wf6NBHyz0uj7WDpDa
	bqyc+ATAF1cMym+e4F9YvfaYqFvt9clLPxChc
X-Gm-Gg: ASbGnctzl2wt2D0KYteAKz6VRwszsDZ8AFsX4bSsn1xFq1bJZ7/4L6jZ25quJtXTJ2G
	y0yE2DmDTko/9+V/YNiNCqXJu5gok8PZ5wV0xJBeXfUuKlXHFK6Pp78bjaVLed7CmqWmR3JLi/W
	ca7kx8YrxY
X-Google-Smtp-Source: AGHT+IHZSx4Vf+dNOAAorW58k8+z5I2yMpCXb5lQXVnunPf1zQPBQuCWxasZVFELP+z2t3KGDpTAh27n5pBEtj67qNs=
X-Received: by 2002:ac8:4085:0:b0:471:fb3a:5bfb with SMTP id
 d75a77b69052e-472335ca333mr233501cf.1.1740167681508; Fri, 21 Feb 2025
 11:54:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250221111226.64455-1-wuyun.abel@bytedance.com> <20250221111226.64455-2-wuyun.abel@bytedance.com>
In-Reply-To: <20250221111226.64455-2-wuyun.abel@bytedance.com>
From: Josh Don <joshdon@google.com>
Date: Fri, 21 Feb 2025 11:54:30 -0800
X-Gm-Features: AWEUYZn0iHKSbPtDF3NPV03ce2HSdhgVwhJErYQLK9HjAZKm_GU65QRAp6WZOOI
Message-ID: <CABk29Ns=Jqb2c5gcEMr7uBnDZ7S_xWp5tUmrX=T8pHrg5RmeDQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] sched/fair: Do not let idle entities preempt others
To: Abel Wu <wuyun.abel@bytedance.com>
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
	Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>, 
	Dietmar Eggemann <dietmar.eggemann@arm.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
	Valentin Schneider <vschneid@redhat.com>, Tianchen Ding <dtcccc@linux.alibaba.com>, 
	"open list:SCHEDULER" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 21, 2025 at 3:12=E2=80=AFAM Abel Wu <wuyun.abel@bytedance.com> =
wrote:
>
> A task with SCHED_IDLE policy doesn't preempt others by definition, and
> the semantics are intended to be preserved when extending to cgroups
> introduced in commit 304000390f88 ("sched: Cgroup SCHED_IDLE support").
>
> But current implementation allows idle entities to preempt each other
> on wakeup, which seems not behave as expected especially after
> commit faa42d29419d ("sched/fair: Make SCHED_IDLE entity be preempted in =
strict hierarchy")
> so fix this by explicitly skip wakeup preemption for idle entities.

Thanks, looks good to me.

Reviewed-by: Josh Don <joshdon@google.com>

