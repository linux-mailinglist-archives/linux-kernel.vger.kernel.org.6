Return-Path: <linux-kernel+bounces-340035-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 53A75986DCD
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 09:36:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 844B81C2183E
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 07:36:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AE5B18E02F;
	Thu, 26 Sep 2024 07:36:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eTnynSta"
Received: from mail-pg1-f196.google.com (mail-pg1-f196.google.com [209.85.215.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60D8918C357
	for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 07:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727336199; cv=none; b=Gpy6CJIOOsRiBe6LoK8sVz20/y+ZWfaASDAJJtcw1Xdj/siWTxtZ1KAG1lK//54kI/l7u7hAPjBvbVvxAqrTp8DiqJAmYXpcva4O7+FlJIwx0uXI4u6PQUveg1gw8bWOrhyDL/r5WRUVkJ7uAijwEaBzu7AEwnL9CyupNUgDs4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727336199; c=relaxed/simple;
	bh=KyjkICxZouOAPwBnSX49Ui60Y7kCj2q+gfNXbd4lbn4=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=Wvgk8GS+YhbT9CNj/2+qz34NvEYp9pC1uUrlAyf4ulIljPyXucXYk/Njj7tmcLfQjgtJu+RtJTQbarmkAo6p7J2Vw7N3/3UMBNwkq7BkE5D4nbeAlJXn0IBr+2xTFvdEzZgq2uZZ3xKJfIlW2dOODDPysGO8Rgwerv2PJgnFzw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eTnynSta; arc=none smtp.client-ip=209.85.215.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f196.google.com with SMTP id 41be03b00d2f7-7e6ba3f93fdso374071a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 00:36:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727336198; x=1727940998; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:references:to:from:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CUhtjgzHqBhaPhspTk38I4rqCZlG6IWAAoxzm8qRfnA=;
        b=eTnynStaRj9vuKvwOuS+8sP4y0To0Swfx9IpR89dcicSOhURDuDHnrVw+uoZqlHX6e
         64k+AFwmsa711fBZT2QKBEJqzDDhv0OcMCEzarnId/y0KJcbkMe7p3ZcmcXrUtePdUkq
         amCG9lysGeA169w4iWGpsQlURtm1kALY3m9qr/apTa1e/TgyNMDdxCetyGPBoQ+qCLmb
         R9j/G7fkhb5pvvBnJDPPkqJtYIa++MNCj1aBCuKytO0pwViUjqevTXbSUBW13LpbkUi1
         gRXK+LNkSjsVGI/nrNP4PWsS+8/AXfZUPKgsOwYf9Pc6LnG8UlHF78DYQfA2ZwSDyvK5
         SuBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727336198; x=1727940998;
        h=content-transfer-encoding:in-reply-to:references:to:from:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=CUhtjgzHqBhaPhspTk38I4rqCZlG6IWAAoxzm8qRfnA=;
        b=mLtNEd15Zs3nLX+E5EoA0MadNWZNvMIAS7i2cxHad8tlnGaBFlJDR91qw4IH23HJ9t
         U/HFT/qE5sk9907U+pDNP4urXfjAHYNXcmL9UDPQgKBA/2G5+3ZmXw3BaRfdugrrYpqw
         d/GFcob4Tb/D562waQLo9qjyfUanXOBl/Bsjxvdup1YcXuUcX60JtHT3X2N02F36h2Yf
         VnpPA4V77eRLOOoWv386CmHpUMnw4f0q7+eeE8dS24kcKPy1BJba6BBjd8Ea9STnODCN
         SOJXjoW0OlUZrbWW4WYMoOPMEkBeL7oKG7yQZmX/d4jt4nvERHOKdOsVZEPoE7bSFcgm
         GAqQ==
X-Forwarded-Encrypted: i=1; AJvYcCUJAbqeIFKmbUGb02pxcqpLm5ztLwy5Y29FrCZOdwWmOkXpoEcM7Dmj0pUyaXagn9SttokM6F7b1XpTXQU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzAJHRYiwriXDv6OL7kMrKv5mf9IHQ4qlN5kfYff2NqBDp+4kOu
	YZGhcq81AplyQcjQFHHg9ecIybfRP9/R+Rf2rrXa3zmJ9H09+Tel
X-Google-Smtp-Source: AGHT+IGxOO1IxxaVKZWg9ZAl5UsDoLDjWVNiFtd5HFfHGy4ysyn+60fTe3eFQF4v0zi/LI5NlAKj+g==
X-Received: by 2002:a05:6a21:3941:b0:1c6:a65f:299 with SMTP id adf61e73a8af0-1d4d4ac640emr7257901637.21.1727336197507;
        Thu, 26 Sep 2024 00:36:37 -0700 (PDT)
Received: from [198.18.0.1] ([2a09:bac5:398e:16dc::247:90])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20af16e6be7sm33588945ad.12.2024.09.26.00.36.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Sep 2024 00:36:37 -0700 (PDT)
Message-ID: <ae5472f6-2748-4fec-b688-6d5d34104ecb@gmail.com>
Date: Thu, 26 Sep 2024 15:36:34 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RESEND PATCH] sched: Fix the comment error in the
 wait_task_inactive interface.
From: hupu <hupu.gm@gmail.com>
To: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 Juri Lelli <juri.lelli@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
 Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>,
 linux-kernel@vger.kernel.org
References: <be57ed09-83d9-48a0-bfcc-d22ce39ad17d@gmail.com>
In-Reply-To: <be57ed09-83d9-48a0-bfcc-d22ce39ad17d@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


 > The previous comment was incorrect because "task_on_cpu" only care about
 > p->on_cpu and does not care whether the runqueue has changed or not,
 > especially on SMP systems. In addition, task_on_cpu returns true
 > instead of false when p is running on a CPU.
 >
 > Signed-off-by: hupu<hupu.gm@gmail.com>
 > ---
 >   kernel/sched/core.c | 4 ++--
 >   1 file changed, 2 insertions(+), 2 deletions(-)
 >
 > diff --git a/kernel/sched/core.c b/kernel/sched/core.c
 > index f3951e4a55e5..05b231a18440 100644
 > --- a/kernel/sched/core.c
 > +++ b/kernel/sched/core.c
 > @@ -2129,8 +2129,8 @@ unsigned long wait_task_inactive(struct 
task_struct *p, unsigned int match_state
 >            * NOTE! Since we don't hold any locks, it's not
 >            * even sure that "rq" stays as the right runqueue!
 >            * But we don't care, since "task_on_cpu()" will
 > -         * return false if the runqueue has changed and p
 > -         * is actually now running somewhere else!
 > +         * return true as long as p is running on a CPU,
 > +         * regardless of any changes to the runqueue.
 >            */
 >           while (task_on_cpu(rq, p)) {
 >               if (!task_state_match(p, match_state))
 > -- 2.17.1
 >

Dear Maintainers:
It's been a few days since the patch submission. Is there any progress?

I found that the original comments might be incorrect. If a task is 
running on another CPU,
task_on_cpu() should return true, not false as mentioned in the 
comments, and this is
unrelated to any changes in the runqueue.

Maybe I'm misreading this, but can you help me point it out? I look 
forward to discussing
with you.

Best regards.


