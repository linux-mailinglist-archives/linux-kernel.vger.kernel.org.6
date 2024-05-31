Return-Path: <linux-kernel+bounces-196066-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BCFD08D56CA
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 02:15:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DDED61C23C94
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 00:15:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25B28EC0;
	Fri, 31 May 2024 00:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b="Mvh9XmQa"
Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A377B360
	for <linux-kernel@vger.kernel.org>; Fri, 31 May 2024 00:14:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717114499; cv=none; b=LAh7RCqM+8YEhlJ4+CQi6Cq5VeqYbalskrl3SUfox8dm1FmzeCvB2m1KPHMXQQ3mxuJYhH+z3e1OQHhOxS740VoHu4EvayXT4KzcEuiybzhJPhYL8Wr7QL7/QDyDNQtjKLNeFTa3leh2kBtyQs7q9YHWAlmOZNtVY+wq3j/lZwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717114499; c=relaxed/simple;
	bh=YlITfRGBGkiGQh2yf2/+rH6KbsrWEjN3IQxGzASO3WU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=o8qOO65jdsPTngZCMgBTlo/itQzElQeD1sEXaO0fs9dWAtpdzF8yvKPAyDOQwZDNijs1b8VB3WFKCDOIeVjJnPAJoAqEDjDKwyOt72UGaG//9mjQRom7+hfWcDfYzwp85CDn5Z8sRV7Ab2ju+A2zwIix4tYiUIyppnefOVvfJ3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b=Mvh9XmQa; arc=none smtp.client-ip=209.85.210.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-6f8d0a00a35so409703a34.2
        for <linux-kernel@vger.kernel.org>; Thu, 30 May 2024 17:14:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen-com.20230601.gappssmtp.com; s=20230601; t=1717114497; x=1717719297; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=YlITfRGBGkiGQh2yf2/+rH6KbsrWEjN3IQxGzASO3WU=;
        b=Mvh9XmQaBMDZYrSgJZQ/XsN7HJrFQtFCGWhQ5JX+uzN9iom+YUyQGSGfEQIBrRQRpU
         KLiKViVidBTPCjeZKGriRRYVlZrLwFrFDOztuygIYXsE210zGXPMzmlifzqYcxL00lPg
         esWDqlvCE8pvgqsIiaoYO0bIhMIy92P2CarfQnEntuSTlTpvhXHyjH3errNlMh6FfBCm
         LJks1/V1xErhIVJYIZOaWSZcF59u83tp7qO6ot8HmksVscFeIPteykG14jiQPxywyi4N
         s9OzuK7+27lQbDllPysg/Md7ITxp6UFyUknYxYKqfh0UcCCjxZ5nEDZJvKQxp14rW0qi
         aNKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717114497; x=1717719297;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YlITfRGBGkiGQh2yf2/+rH6KbsrWEjN3IQxGzASO3WU=;
        b=AkEraAWXgotj3UL7eTXaFj2bG7OEmrb8qruc3cjXCEA7SeZAw6liV3D21qN5pz2sxr
         2LNQ2KA/V1hqBn//fH6huxR3T8+qQSCCHyZEbcMwJaRjzmWbhDEj00ipiiprnBeJdMq1
         k1WioHGrnwUiiedNUVJ/B+q07VvUk+h7ch0ZGAV1DCWlMsLSfdcorxN5+Xfo7pKfc3Y7
         2HmaKPcNZKV93FvLBphVoAG/sz+Sh/5DhJI2VdDhLDfPgMV9JQ9/uBKyHpm3I8162gt9
         Ramdle5kEOXJsTMyYn7COwUwIvYYHK0L9Yhl59uzrojWyD7+OAuC8398n/8ygVyjkAu+
         UDmA==
X-Forwarded-Encrypted: i=1; AJvYcCWByV2TRIpaqgB1MzSK/uM+WkHiMg5KwqhsBA+lo0E+/TpSyMpD0qmZ4xTlYjb6EPKmi4HPz6eYJwk8ZH7/IAmzcPMHEZiLkj+dkFLs
X-Gm-Message-State: AOJu0Yy/GRNHImQRVLOimbIcEG/pjnDPhFlvG17ZJ8iP3WHScJRiY3vQ
	BEkOOxEVkVyl1MmksXVIfAmzV3egvuawVo+nhQvs9AVQIOzZAexFebqelDRyk1+VkCBkq77Lqvf
	IMMXit/h30TUeTroQvQZCDqCwznUAVjqIlDlXwQ==
X-Google-Smtp-Source: AGHT+IHIuwRQeRk5CYGQyxuRuiWFvJgO1VzcacllnlVILGDdy4DHdL8jJjRKfKHzE5KSa34bYlFWdG8b8BCrZGY7GeI=
X-Received: by 2002:a9d:4e94:0:b0:6f1:17ef:ef11 with SMTP id
 46e09a7af769-6f911f48505mr375247a34.22.1717114496660; Thu, 30 May 2024
 17:14:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240530170259.852088-1-pasha.tatashin@soleen.com> <cq7537bswpnbsmeiw3rh4ffrgqky4iufsaurukpk2flxts6jcu@6ctttkclvf3f>
In-Reply-To: <cq7537bswpnbsmeiw3rh4ffrgqky4iufsaurukpk2flxts6jcu@6ctttkclvf3f>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Thu, 30 May 2024 20:14:17 -0400
Message-ID: <CA+CK2bCuiDAv05Xu6OuKB=gqJ5NM20F_uUyJV8E=XH=r47ik=Q@mail.gmail.com>
Subject: Re: [PATCH v3] vmstat: Kernel stack usage histogram
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: akpm@linux-foundation.org, jpoimboe@kernel.org, kent.overstreet@linux.dev, 
	peterz@infradead.org, nphamcs@gmail.com, cerasuolodomenico@gmail.com, 
	surenb@google.com, lizhijian@fujitsu.com, willy@infradead.org, vbabka@suse.cz, 
	ziy@nvidia.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"

Hi Shakeel,

> Couple of questions:
>
> 1. In future with your on-demand kstack allocation feature, will these
> metrics still be useful? (I think so but I want to know your take)

It depends on how on-demand allocation is implemented. On hardware
that supports faults on kernel stacks, we will have other metrics that
show the total number of pages allocated for stacks. On hardware where
faults are not supported, we will most likely have some optimization
where only some threads are extended, and for those, these metrics
will still be very useful.

> 2. With on-demand kstack allocation, the stack_not_used() needs to be
> changed to not cause the allocation, right?

This is correct, in my WIP dynamic kernel tasks RFCv2 patch series, I
have an optimized version of stack_not_used() that uses the number of
allocated pages in the partially filled vmap to determine the last
stack address.

> 3. Does the histogram get updated on exit only? What about long running
> kernel threads whose will never exit?

Yes, for performance reasons, the histogram is updated only on exit.
It would be too expensive to calculate for all running tasks. However,
it could be extended to be queried on demand via a debugfs interface
for all running threads. On machines where jobs come and go over time,
this histogram will show the actual stack usage distribution.

Thank you,
Pasha

> thanks,
> Shakeel

