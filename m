Return-Path: <linux-kernel+bounces-520582-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A9F80A3ABC0
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 23:35:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 744E116A97F
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 22:34:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A68C1D7E5F;
	Tue, 18 Feb 2025 22:34:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ch6usJ1+"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67CA91B87EB
	for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 22:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739918087; cv=none; b=XiuyelThJQo12dD7ihhOObRqDUC2ef/6CO9UPtIh0P8CRX2ze5la+PLwEqgjY13Rl1dPDRCiQ0kJvYm47WzVROZEm97rtMRTVKIB880jShjXpuYKXd46BbtutPDWznTdf5pra5j1qOOvLhjQK+tfRp+rEuZmSXbaqb7oCkpnJQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739918087; c=relaxed/simple;
	bh=c9MCg23fFw/wwbwFWoLmtmEt2qSX634nqFWl7SGjvXc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=HOd8lpfgvAZS0eGKH1pPRUZM+r5TtO6hsEK+w/askJ+U8LZhazRN45lqvHRHJu7zdNIfns40t8Dc54O7/1NkqVTXb57M3XsfrmiSda6ROJAma8XiaN4yVrAHKlaYLTxxTXfWTU4YIcPFMNW4LS9d1A+V7nKLVytmCCLLTPSHQ1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Ch6usJ1+; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2212a930001so69900425ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 14:34:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739918085; x=1740522885; darn=vger.kernel.org;
        h=mime-version:user-agent:message-id:date:references:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=TZLHuC1Hi4yGX01nX6e056nsAoeCP8oBOZxASCblh0I=;
        b=Ch6usJ1+X4N0L8bChPSQRO0cWImdkIPIIMscOQvtNIIlTD4Dhu4ldWO8hwbZRYZ3+J
         wuiHqSVviyzxz49ZLFSvxr22IyWrUDeqy0BOWkEbtdMP0jlPdqSbsUBWej6ZDe2u6EOR
         6JHp2QB2F2YWjJAJ+dBr/zT3YdXXx1KBxiRwPo2d1B7ZjjiMeoAz7NlmSJTYvX/1Wz8L
         jva11ybSVLLWZ78b/hu8GX7rweBho5FztvFphcbIo6rAJwwSIafI+9H5luUHJYziAL8M
         5oE8SQtr05ducUf9HJZDYMsw4wuUX9hjRFSK8K/bBfDVKkqhlvVS3ZJFPxRhzO/WoCj2
         69gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739918085; x=1740522885;
        h=mime-version:user-agent:message-id:date:references:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TZLHuC1Hi4yGX01nX6e056nsAoeCP8oBOZxASCblh0I=;
        b=WplJub4ZDhL1L2nwv2yVFNNedD5KBSIcZaRmM77twPQJgUsbUlXIEX4VygCZ7sOpJ0
         c7gtn2y2xLPFjyHrEbYiin3MLBb8d5SyCkKH1zCWgKKYl1SS3853po9nWv/wYUR6sfSI
         bvo/JWuG1G2bvg89L8rugRlSG1xgmx/0zDHEP5XUWrAcgQj4PWxiKAleGZptsGMcRxs9
         ZYg9pzUKU2IqmSGAd7v11FAdg8vuyGdeS/nFaop8rKJ5jg1sR2grSGJ5m5vzUjSwLe+I
         SufvaawOS036vq0h4SAbPkxFCPy3fgDaq/R3xoZm+RG/CNVhWjJwaS/aAMd46XX46MZw
         B7Ug==
X-Forwarded-Encrypted: i=1; AJvYcCV9x8SzYLgUsXh5XsYuSvHzmAyUQGzYx5KzCLm6bYSx62q9Jvfngg6SyH4mYifxUXl1uH+Cb9BldY7mSwM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyDEmSRSLbKZZiW+w469u3ucDt/N4ODU7fllnDs8NcAb0/2baaN
	RUsCzCTaDNK/jxhoe30qBFf7kPuNbAxMoQS+LgW+MJd9lMcrAbIXAl0wsvBV1T12yZGr/y7t9AZ
	hrhMJ
X-Gm-Gg: ASbGncvs7hODwgvEJqYp67Jea442tu9sCmowwE1Vl9M1ce0Xg4C+y2pzRan1P2O+z0L
	DZllIWPGYF64K32mXGDFQAfiI1twGWymhk3eRj4zB60DdgO7IKRr+MtRmqqoLcILakU5Ki+SL2P
	WoOxApZJUfX72CVFdfe1UCCzrKs6gy/Boume2tOBe71t6d9h7WRvTgi4AvFPXTx5/iU+zqrgZnT
	8UCMdWES0IHgsGhDCme3ZAKJx7pUUMqQIUc2TY9Qpa0Y1LOWsOM0Sdiwam+biZjhA8T2tNJhTMj
	vt4atMbeHdMUkQ79NyCmxdwVuv/9Hy9WnFiVlkpdOAO+DsknIG7RMID8mIsg/0o1+u03qw==
X-Google-Smtp-Source: AGHT+IFYKz/EYn7TNybiJj1qW3okUbikhAGX/UJBob0S9X1x6mD9V3eaYo2eIvlon59gvNzDMcxedg==
X-Received: by 2002:a05:6a00:c9:b0:732:6221:7180 with SMTP id d2e1a72fcca58-732622171dfmr16003879b3a.5.1739918085461;
        Tue, 18 Feb 2025 14:34:45 -0800 (PST)
Received: from bsegall-glaptop.localhost (c-73-202-176-14.hsd1.ca.comcast.net. [73.202.176.14])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7324f64a39asm9321541b3a.69.2025.02.18.14.34.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Feb 2025 14:34:44 -0800 (PST)
From: Benjamin Segall <bsegall@google.com>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Anna-Maria Behnsen <anna-maria@linutronix.de>,  Frederic Weisbecker
 <frederic@kernel.org>,  linux-kernel@vger.kernel.org,  Eric Dumazet
 <edumazet@google.com>,  Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH] posix-timers: cond_resched() during exit_itimers()
In-Reply-To: <877c5nk4jw.ffs@tglx> (Thomas Gleixner's message of "Tue, 18 Feb
	2025 10:03:47 +0100")
References: <xm2634gg2n23.fsf@google.com> <877c5nk4jw.ffs@tglx>
Date: Tue, 18 Feb 2025 14:34:43 -0800
Message-ID: <xm26y0y22870.fsf@google.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Thomas Gleixner <tglx@linutronix.de> writes:

> On Fri, Feb 14 2025 at 14:12, Benjamin Segall wrote:
>> exit_itimers() loops through every timer in the process to delete it.
>> This requires taking the system-wide hash_lock for each of these locks,
>> and contends with other processes trying to create or delete timers.
>> When a process creates hundreds of thousands of timers, and then exits
>> while other processes contend with it, this can trigger softlockups on
>> CONFIG_PREEMPT=n.
>>
>> Ideally this will some day be better solved by eliminating the global
>> hashtable, but until that point mitigate the issue by doing
>> cond_resched in that loop.
>
> It won't help for a PREEMPT_NONE kernel because the loop will be equally
> long as before. Only the hash lock contention will be smaller, but that
> does not mean that mopping up 100k timers won't be able to take ages.

Yeah, it could just run into a new lock or other bottleneck, though it's
not immediately obvious to me what it would be (hash_lock isn't sharing
~any of the time in perf tracing, the obvious other locks like hrtimer
are sharded, etc). Just sharding the lock a bunch (leaving the actual
hashtable with the same cacheline sharing even) boosts the speed of my
synthetic contention test freeing 100k timers from 6s to 380ms (with
uncontended exit at 17ms), so I think it's realistic that avoiding
the shared lock/table might well do the job.

Of course nothing is stopping an even buggier application from
just creating more timers (and at that point starting to notice the
fixed hashtable size during timer_create)...

>
> We really need to get this PREEMPT_LAZY thing going and kill all of this
> cond_resched() nonsense.
>
> Thanks,
>
>         tglx

