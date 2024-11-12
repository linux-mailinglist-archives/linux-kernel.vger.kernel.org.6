Return-Path: <linux-kernel+bounces-406636-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B8449C61A0
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 20:37:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D6F911F226D2
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 19:37:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 616C7219CA0;
	Tue, 12 Nov 2024 19:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ts3BXFmp"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A03420ADE5
	for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 19:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731440221; cv=none; b=UADpIVkdylqfxV+nlxYZHVSLNQc43nzOsB12tl8Kw0x8BnCZBCG0Xt6ugcVnlk1BXEDJRIiZZAmRU0rHLF3C3vcijN91XVv4NPcp+UcA+TOxYtqj2b+E2bg3Xj9RNMuZUAkndRyp8wzbcSgwHwWJYKFjGvPan1lXlkSBpaKfOuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731440221; c=relaxed/simple;
	bh=O7DCfxLNIjwrCueTIP4Z+l3hI1xzaNRDEQ+l2VDaSOM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=R1dsWmc7/kMXecFBs93DbTTXM55YX2c3usIZOyWAnQOQlDrBqNVahoHQnl+7L+k4Ka6e3xTI8sU9iXW3VamIcc7UEmtkDGluykp89TOQUHorJ8U0bPN72vYS7hs68ck2NzlC/RlYWhYSf8jIICs4tAdOJ8XZKFhRlbrvBMDajC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ts3BXFmp; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731440218;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CjDs1uVD5LcAdcMcEag2yGHlBTAQ4ZFwPkuS7Zep/7A=;
	b=Ts3BXFmppHEesyeTJzI02VmktODsUIacYN4vDbqQd5yggrC6zvY4dUMevSBP8rqe3ZbjU9
	AFTW+hGVpZcdYqq2VKuwehbD/RF+dFYlE2ahZQIo9t8zaUutv5C6e6x80czDd/IKjQVnST
	v0QmM6eGqM4W6ebC9LF36wf/o2FlUYU=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-278-yOcHXTryO6OfCcOmsVOHRw-1; Tue, 12 Nov 2024 14:36:56 -0500
X-MC-Unique: yOcHXTryO6OfCcOmsVOHRw-1
X-Mimecast-MFC-AGG-ID: yOcHXTryO6OfCcOmsVOHRw
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-6cbf76b01deso94299996d6.2
        for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 11:36:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731440216; x=1732045016;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CjDs1uVD5LcAdcMcEag2yGHlBTAQ4ZFwPkuS7Zep/7A=;
        b=w8H3pemMjpwwJAjpI03cu4DvbiCy3fRV+n4ZoMs8p02kcWlGS5cCxpy1v//DZew/1Q
         Gg3yYUlKQw6yFbXE06fewUFG2NDZtvwFSCblbdkZvG+7onGF9kCG7oJlNKQDHK4BRsxY
         sPCLJlq3yWNL5uy9EEIOHAllkJyBjSCdvZ5XrQyZtCmCX+qQyjZw6zYX2PZTX1ICLY4A
         NmlyE1JAKuHhb5uTrcThbKJiWhrk0aQ11siaziHZzFDLvYl5IVT35jlk87qbEZSlGL+o
         RlaBJVcgJCWXFyx5sxpZXFKGaf1ZUNoVkfnBqu1L70VH7awU9CRJaThcb+MVm9Ell1IR
         kEMg==
X-Forwarded-Encrypted: i=1; AJvYcCXMM+Rmqfg8DFCO1Lq7N9sHzuYyhCgle26VG/HaHAodFMQCwqiIPlYuNzQuuPanxS5KRyz9noAfOQwIxB0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyGa7YWjkSYhQUItpyDZ9KGbZ8QEBeEvQo93hjP0xcIxtv4iXRz
	9bi4Obf6maF0+d2Rl4a2VSW5v4zy0IGk7Edi6KYd2vh6kaNQMWy9/MPONhabtiq2pTlbycGeEnR
	JH8yayXw/hqBH/OrPtZ1OclSQpuo2bB66TZ1SVn00wqzK70qqW0zglwiocDdmWw==
X-Received: by 2002:a05:6214:4909:b0:6cb:d512:e6e6 with SMTP id 6a1803df08f44-6d39e12e459mr225840266d6.23.1731440216243;
        Tue, 12 Nov 2024 11:36:56 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF1EIIGXTnIdaiArjVBMT7oIJoOZkcHkKo0u0kUztGcBK1Xhlva/oXoFZG4eDiT0EjZb8zefA==
X-Received: by 2002:a05:6214:4909:b0:6cb:d512:e6e6 with SMTP id 6a1803df08f44-6d39e12e459mr225840066d6.23.1731440216031;
        Tue, 12 Nov 2024 11:36:56 -0800 (PST)
Received: from vschneid-thinkpadt14sgen2i.remote.csb (213-44-141-166.abo.bbox.fr. [213.44.141.166])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d3961f4d37sm74519616d6.51.2024.11.12.11.36.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Nov 2024 11:36:55 -0800 (PST)
From: Valentin Schneider <vschneid@redhat.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org,
 llvm@lists.linux.dev, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra
 <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>, Vincent
 Guittot <vincent.guittot@linaro.org>, Dietmar Eggemann
 <dietmar.eggemann@arm.com>, Steven Rostedt <rostedt@goodmis.org>, Ben
 Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, Nathan
 Chancellor <nathan@kernel.org>, Nick Desaulniers
 <ndesaulniers@google.com>, Bill Wendling <morbo@google.com>, Justin Stitt
 <justinstitt@google.com>
Subject: Re: [PATCH v1 1/1] sched/fair: Mark cfs_bandwidth_used() and
 m*_vruntime() with __maybe_unused
In-Reply-To: <ZzNx4D5lWVhTG7bk@smile.fi.intel.com>
References: <20240905171210.267626-1-andriy.shevchenko@linux.intel.com>
 <xhsmh7c98d65h.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
 <ZzNx4D5lWVhTG7bk@smile.fi.intel.com>
Date: Tue, 12 Nov 2024 20:36:52 +0100
Message-ID: <xhsmh1pzgckh7.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 12/11/24 17:18, Andy Shevchenko wrote:
> On Tue, Nov 12, 2024 at 12:48:42PM +0100, Valentin Schneider wrote:
>> On 05/09/24 20:12, Andy Shevchenko wrote:
>> > When cfs_bandwidth_used() is unused, it prevents kernel builds
>> > with clang, `make W=1` and CONFIG_WERROR=y:
>> >
>> > kernel/sched/fair.c:526:19: error: unused function 'max_vruntime' [-Werror,-Wunused-function]
>> >   526 | static inline u64 max_vruntime(u64 max_vruntime, u64 vruntime)
>> >       |                   ^~~~~~~~~~~~
>> > kernel/sched/fair.c:6580:20: error: unused function 'cfs_bandwidth_used' [-Werror,-Wunused-function]
>> >  6580 | static inline bool cfs_bandwidth_used(void)
>> >       |                    ^~~~~~~~~~~~~~~~~~
>> >
>> > Fix this by marking them with __maybe_unused (all cases for the sake of
>> > symmetry).
>> >
>> 
>> I assume that's with CONFIG_CFS_BANDWIDTH=n? Looks like
>> cfs_bandwidth_used() uses are tucked away under helpers that themselves
>> only really do something for CONFIG_CFS_BANDWIDTH=y, so you could remove
>> the CONFIG_CFS_BANDWIDTH=n definition of cfs_bandwidth_used() directly.
>
> Thanks for looking into this!
>
>> This compiles:
>
> okay, consider then my patch as a report. Can you submit your version as you
> seems much more familiar with this code than me?

Sure, I'll add this to my todolist.


