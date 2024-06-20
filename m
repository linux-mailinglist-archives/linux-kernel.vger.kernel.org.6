Return-Path: <linux-kernel+bounces-223547-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EC249114B3
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 23:33:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B93381C21E1F
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 21:33:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCC3459148;
	Thu, 20 Jun 2024 21:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="yhZn8M9W"
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 889DE74267
	for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2024 21:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718919172; cv=none; b=WLLVtibuEeFGekqS++/rhPkvzufH+/7bdjOmc1Eywmbx7DRUowguonJEjNBieojxDvYIKeELCZlNJDmbBKVrfJw6RyIFF/3Ec2xdXfuo5AZKevDNdb3nFvl0MzpzSz4WsXVdMuxLu56V2aK6GnXgc2mDE+w/wAJ2OmPmHgHDVos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718919172; c=relaxed/simple;
	bh=gFQflesCNTOjDK+P/0PgaP14um/Kwd341Od4dwd4knA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kh6sGqhmLFvF/uvgfwclu2B9tfYSIc3r0/1p3P6eo6XbkezmKgtfNUnkVjCALgMKXLvvdYFF6e82Eqdms2LYj5VwRcRRObHVCZbKMERxqXS9OFb4fbxTCcYWb61nqbNTfQwuim4WSU6b1ySNMBp/QcmZNttroGDsT2LT7BL8s9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=yhZn8M9W; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-57d16251a07so2206a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2024 14:32:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1718919169; x=1719523969; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=gFQflesCNTOjDK+P/0PgaP14um/Kwd341Od4dwd4knA=;
        b=yhZn8M9WH3Uv4A73CZlOzUEEaK/8MWgjz0BA3WfzhoxML1EZ/OnGQqS4u/sl0lk2Dq
         YboKn75sOw90fEniWH//NzX2mbAILu00l9DnlEVq1DM6ev8db2MoDq6SPpNvGR5ZJQu7
         h++G5orBChEsY+TM0ueLQSMY2RKt1MpxHLaCa7jHYUUYyu3LHlfhcXws1iGRhE4Ueyn6
         U3XmF7NbI+FuNr3J9gGwzlCBsikMmAmfBno+Vr0acsbg6Ml6Chea7zoBg1W5x702u5I5
         AFvMC6G0VzsZuJk84d8BI+tB+gv8/qBN91306evf/2eiRps2Rgq0CnqXfg0o0t0EJ1C4
         ujmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718919169; x=1719523969;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gFQflesCNTOjDK+P/0PgaP14um/Kwd341Od4dwd4knA=;
        b=f+hlzt3yBh/3igsvfkn5slzQujcuIehrz6Ikmjn4mepBkVpyVDzmQA4wFgnsHnB/05
         uPHlDstB2bbTDYoYz8O5x2g3c4XNHtm1qBq1YmvNE27ctBTV/rybXQVg/UFlc8R2sCoZ
         2K2evFoc761N57zhtkhMnH+mPAgIRWq1d2JKZAuL5eDYzLoXgYlzmPWMreZJE3w5DKTP
         UGEl7aZ6NbybG4HO+MYunZckq7uB/tQCWsGhXQa6rtkOar+0MfZxrdbkSPdcI7jwvvds
         7KqPma+XyAK9lJcifm7UqWWw3xgnEP1/O63uUZVd+ktzInvClrJg9DXYllnLCs4cYIN3
         MFvg==
X-Forwarded-Encrypted: i=1; AJvYcCWIOB+jpc8w9MiweMcT8ERiNOzix6oaOnaO7R0TSmszneqku5Z3Cpanh1JBrO2iNj1rKP1INoz7zG6Yk523d414g7z8Z0HCCuHjcRkR
X-Gm-Message-State: AOJu0YxqRiQ1o0fPae2K0kRZgHwnqKy5ic9sg1A6J9HwsazrWCwOP0N4
	tGEN50d9ARGLDWXWbMge4MYX0fsFYmw1p0+TQXosTcidILQ1uF14ZbiY593S1J9ysIodVI4ZhTi
	DhiFcAFgQJN0/qUpPfksMzpvBb1ACTVFxzhHR
X-Google-Smtp-Source: AGHT+IFTBgI2r7qC7aS+wsUY75lgPJkz8awTBnZPAM5/IG46XjbqsojWcboX38IEASQfheU7slw4GvuURS8zkBUXcyg=
X-Received: by 2002:a05:6402:34d3:b0:57c:d45d:7571 with SMTP id
 4fb4d7f45d1cf-57d2ec83536mr136203a12.6.1718919168670; Thu, 20 Jun 2024
 14:32:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240508223456.4189689-1-joshdon@google.com> <CAKfTPtAVg7_p4rXXfiO1=F1pjvAbL9V26qjHvtp2S6qBpp6LuQ@mail.gmail.com>
In-Reply-To: <CAKfTPtAVg7_p4rXXfiO1=F1pjvAbL9V26qjHvtp2S6qBpp6LuQ@mail.gmail.com>
From: Josh Don <joshdon@google.com>
Date: Thu, 20 Jun 2024 14:32:37 -0700
Message-ID: <CABk29NvB6fNLB7Ca1ogg5U4Nf-Y=5+=tnAwExr2F-MZritTmKw@mail.gmail.com>
Subject: Re: [PATCH] sched/fair: prevent unbounded task iteration in load balance
To: Vincent Guittot <vincent.guittot@linaro.org>
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
	Juri Lelli <juri.lelli@redhat.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
	Daniel Bristot de Oliveira <bristot@redhat.com>, Valentin Schneider <vschneid@redhat.com>, linux-kernel@vger.kernel.org, 
	Zhang Qiao <zhangqiao22@huawei.com>
Content-Type: text/plain; charset="UTF-8"

Hey Vincent,

> I went back in the archive to remember how I came up with this patch.
> I thought that it was fixing a problem raised by
> zhangqiao22@huawei.com but my memory was wrong and it isn't. Instead
> it's fixing a theoretical case described in the email thread:
> https://lore.kernel.org/lkml/20220818083133.GA536@vingu-book/
>
> So I wonder if it's worth adding a new debugfs entry for a case that
> nobody might have ever faced or at least complained about. I know that
> I asked you to go in this direction whereas you were originally
> proposing a revert. After more time to think about this, I'm no longer
> convinced that it's worth adding a new debugfs interface finally.
>
> I put some comments below but maybe it would be better to simply
> revert b0defa7ae03ec as nobody yet complains with this problem so far.
> Let see what other will say or if someone finally faced the problem
> but a revert may finally be a better option.

Sure, I have no problem with replacing this instead with a simple
revert of the original patch. It doesn't seem outlandish that someone
might see some benefit from this new interface, with a particularly
antagonistic set of threads and affinities. But, from my side I don't
have a strong preference either way.

I'll go ahead and send a revert :)

Best,
Josh

