Return-Path: <linux-kernel+bounces-271627-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E6BFF9450E4
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 18:41:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 68BDA1F2A3D2
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 16:41:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33B3F1B9B28;
	Thu,  1 Aug 2024 16:36:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HfqTpCpW"
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E96871B4C41
	for <linux-kernel@vger.kernel.org>; Thu,  1 Aug 2024 16:36:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722530208; cv=none; b=hVfGOZMczKVFBwRgfhLADLPzEcYJCZpfeqoiZofoMVlgSr4Fy/rUk1N7fk9Fq2NmZNaZ1rowGQ1a3RfrMqSWuhxvvuASm063nxmJ94O2QB1T/EFfQN9J94dMxVK3BPlDGp+ksikd7ICIWj4NWqSRE/pSayHuDDyr5w6yZK9ESyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722530208; c=relaxed/simple;
	bh=OG/jwS7BzUVW4y7HgBRY73kTyznyX09mnP/1OTYwgAg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nXomJOCFRKbJqGPsuGGpIeQwal/jIuAFO2gj8PooVyawCL5A8mqMakWChRv8fM8Hjy0ZJdXKM5gc/rRTEEx0OL03NYwKLojt0FYDHCqwi2DFCqi7jzlBg+SBRntQzOVj7p4h6uB67CC1bCyaAmBccXACgcmk/fi+gMbDiq9FA1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HfqTpCpW; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-2cd5e3c27c5so4947342a91.3
        for <linux-kernel@vger.kernel.org>; Thu, 01 Aug 2024 09:36:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722530206; x=1723135006; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cxpEU9Yeh5+pLKg2uP/RYohGRqYXn8DWPvuZs2VkMTY=;
        b=HfqTpCpWGV0zYSPjqJLeOxM8iZ8W+5cKAJF/YK56exw7YcuF1Jw2edrTd9OPg/5crM
         TptSV1px+XokMPDEDLKNZlriQQEu4OKGVkdznPDUGAnDgc6j4ABHpPn7/ArtSb6SUF+p
         ee35SMlhRTWHEOYwVELuh3LxpGY6LZbyAYrGIY/BQUiKOuKjZIkH9RUJIsJUc35rmZxv
         Uv7Bcp2fohqhHgX+bBSTttAXO2nyBYp3JVQiLoOGX+wQlDwHyUlrf/J15BO4oTjq1amD
         HMcx8N5ZXChWNpa9MwsV1pnHXz9oYQUTXAdfRA/FNI0lsIk4/YEs9vhE+GxOw35/bGYa
         UZnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722530206; x=1723135006;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cxpEU9Yeh5+pLKg2uP/RYohGRqYXn8DWPvuZs2VkMTY=;
        b=S8tOCRRQIIyqCo+lrnwfXbCH7bV7yKywobTN+m1EiaCaq/Z3SQKLCbJP+sMDerzfzE
         K1zu1zEXzP+I09AjCYmfxPpz05cWRcgQ/4517MTjBVBPhLPmJ8ohRWgi+7i6CnTxQveY
         PmgEdeRN7fKZrPBuqzN4dfJOro6Ye4yexsOUOTatFTjDEWLKtvvXPjMcd01gMHqo4EWF
         7pcFgJTWiDwWiQ2XIMowI7/kVQyYkiluOT4oGx98w+Rmki30lb4UXrZXogc75zrKmnmW
         y/RWKYxOZlZFKb3TEPEkRTVFfwR0joCuEQgRAnVMGTJJFVOTAsOCagrNyyEqWm+JSza8
         5lBQ==
X-Forwarded-Encrypted: i=1; AJvYcCVp6BfOIws+W7RHfrGmw2EP0sI8DEqCmUIUp+zva2WErijeWd3nCsJr2NAdscu2NL8WlcmK0bACQuDmXhppHKms9mny+0O6fBKz0N0c
X-Gm-Message-State: AOJu0YwrSY7+Le9PKEKDCiQ7QnTf2IK8Ah45sTDB+WNxV6IaLRuj+Sqm
	xRoUiFcUU0kzJBk0PS0KZbUQ28t2A4VCUKGdVbtRS16qSZz2zMdH
X-Google-Smtp-Source: AGHT+IHobWv3hnKDqINrivdEgOL2PkdC1NSAMHa/I3u68NviKn1HnXyQedA731Ruaa+g5kjsQhCiew==
X-Received: by 2002:a17:90b:1d04:b0:2c9:8380:e97b with SMTP id 98e67ed59e1d1-2cff93c5fcemr1016153a91.4.1722530175872;
        Thu, 01 Aug 2024 09:36:15 -0700 (PDT)
Received: from localhost (dhcp-141-239-149-160.hawaiiantel.net. [141.239.149.160])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2cffaf69d6asm142215a91.2.2024.08.01.09.36.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Aug 2024 09:36:15 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date: Thu, 1 Aug 2024 06:36:14 -1000
From: Tejun Heo <tj@kernel.org>
To: Qais Yousef <qyousef@layalina.io>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	linux-kernel@vger.kernel.org, David Vernet <void@manifault.com>,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Vincent Guittot <vincent.guittot@linaro.org>
Subject: Re: [GIT PULL] sched_ext: Initial pull request for v6.11
Message-ID: <Zqu5fgU73-tDMk1d@slm.duckdns.org>
References: <ZpWjbCQPtuUcvo8r@slm.duckdns.org>
 <20240725011907.3f5ropfai3xoy3l3@airbuntu>
 <ZqmRveI2HDK0BkDi@slm.duckdns.org>
 <20240801131735.rihobmnwszsqrdxw@airbuntu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240801131735.rihobmnwszsqrdxw@airbuntu>

Hello,

On Thu, Aug 01, 2024 at 02:17:35PM +0100, Qais Yousef wrote:
> > You made the same point in another thread, so let's discuss it there but
> 
> Don't you think it's a bit rushed to include this part in the pull request?

Not really. It seems pretty straightforward to me.

> > it's not changing the relationship between schedutil and sched class.
> > schedutil collects utility signals from sched classes and then translates
> > that to cpufreq operations. For SCX scheds, the only way to get such util
> > signals is asking the BPF scheduler. Nobody else knows. It's loading a
> > completely new scheduler after all.
> 
> But you're effectively making schedutil a userspace governor. If SCX wants to
> define its own util signal, wouldn't it be more appropriate to pair it with
> user space governor instead? It makes more sense to pair userspace scheduler
> with userspace governor than alter schedutil behavior.

The *scheduler* itself is defined from userspace. I have a hard time
following why utilization signal coming from that scheduler is all that
surprising. If user or the scheduler implementation want to pair it up with
userspace governor, they can do that. I don't want to make that decision for
developers who are implementing their own schedulers.

...
> That's not how I read it. It supposed to be for things that alter the kernel
> spec/functionality and make it not trust worthy. We already have a taint flag
> for overriding ACPI tables. Out of tree modules can have lots of power to alter
> things in a way that makes the kernel generally not trust worthy. Given how
> intrusively the scheduler behavior can be altered with no control, I think
> a taint flag to show case it is important. Not only for us, but also for app
> developers as you don't know what people will decide to do that can end up
> causing apps to misbehave weirdly on some systems that load specific scheduler
> extensions. I think both of us (kernel and app developers) want to know that
> something in the kernel that can impact this misbehavior was loaded.

We of course want to make sure that developers and users can tell what
they're running on. However, this doesn't really align with why taint flags
were added and how they are usually used, and it's unclear how the use of a
taint flag would improve the situation on top of the existing visibility
mechanisms (in the sysfs and oops messasges). Does this mean loading any BPF
program should taint the kernel? How about changing sysctls?

> > It's the same as other BPF hooks. We don't want to break willy-nilly but we
> > can definitely break backward compatibility if necessary. This has been
> > discussed to death and I don't think we can add much by litigating the case
> > again.
> 
> Was this discussion on the list? I haven't seen it. Assuming the details were
> discussed with the maintainers and Linus and there's an agreement in place,
> that's good to know. If not, then a clarity before-the-fact is better than
> after-the-fact. I think the boundaries are very hazy and regressions are one of
> the major reasons that holds up the speed of scheduler development. It is very
> easy to break some configuration/workload/system unwittingly. Adding more
> constraints that are actually harder to deal with to the mix will make our life
> exponentially more difficult.

I wasn't a first party in the discussions and don't have good pointers.
However, I know that the subject has been discussed to the moon and back a
few times and the conclusion is pretty clear at this point - after all, the
multiple ecosystems around BPF have been operating this way for quite a
while now. Maybe BPF folks have better pointers?

Thanks.

-- 
tejun

