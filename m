Return-Path: <linux-kernel+bounces-439654-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90E3C9EB242
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 14:52:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DF702165888
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 13:52:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D09D1AA1FE;
	Tue, 10 Dec 2024 13:52:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Jt867Xw8"
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B85BC1AA1E0
	for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 13:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733838749; cv=none; b=XL7T7eUarLk2C8k0MbHg8hT+R5A2vuFWHJ6UB522fHB9YlCAW5qw2yE7H8ZUpxkK+cu+mXOg0yv2oCaMJD0M0DKyo9IzSxsAWSKAaZHa+Wwu2GSWkiOdcEkgRsEQhD52hQ+wf9JDEKvCuxykxpTyKWSHhZqlcxhZ5okQOgDmSXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733838749; c=relaxed/simple;
	bh=eTvs5riH8tSrK6NhT+XShii162RwKvN3oQT3o2VTsl8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JFqYL46e+WScYG0UJX425GWQoGx4/Y6LwPV/ogdtAMHOZ5zq/X80YpVdUATpWTYz1jqcfi+MnAud/l0hN2POBDyGVus3uCY31t6o6H0X0nLhx/0tLD0b5H31IG6klvaGz4ufr9Fv5a4sSBGeTP52drNs1EQHIRRZIxV+iGD8wjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Jt867Xw8; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-385e27c75f4so4153325f8f.2
        for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 05:52:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1733838746; x=1734443546; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Lhx1xbgYInSsXWN8qyC5hVEOzsd3WRPdyx4lY/Rs4X8=;
        b=Jt867Xw8UjHxLAIysofXhNwziIdPkyFv2FDkQAp/jnfQNTzoUHNN/d5oQ7jXMahD3p
         TvXI0h44kGk5hdBAQB+PLyfsAlXIjFcN3tOU4Yt/HtVN9ARwWBpJM98kGz2rjz4YLsbP
         7cMxPhYDekv6Cw1T3+CSw2O9YMsS7KY2Eo5lSBhFqGahGCcfo5wPXKvgL/pa9ZX7gZpB
         4TTryZDknioMPkNODLh+zIo9uSgUGU6uGONmYFGIZyVXLMDbMJm2QEG7zoWqz694aXs7
         Sna6qIRc9Nqq6KbgSKKnUUMwGjxSiWmeh7AdtdRnSz1yJkQ1LtyDnZhkXCweDH5RymHa
         kI/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733838746; x=1734443546;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Lhx1xbgYInSsXWN8qyC5hVEOzsd3WRPdyx4lY/Rs4X8=;
        b=AMVlz3UqN95IG9V6N2hYJj1q+Ko7AV2bjabs6qdLoMECH6VY124dsDVArptIX2xX0S
         Ubg708HcoAdKa0uiMkYd9v+GjmPcrHIYZovKCmuKYyaa4fnKCPCIzyaKvJ8WMbTWoHN5
         IOeeHhRwhOwUwB/TYGkcyVirW2Qvuy+Q2e1EfPc2PXjHNxdzGnc1bMdJJ1xRGlY31NYc
         Og5R9Vgw7sjlbNDdkssSsC2eW95olg8UMobolUIYMNbeG/I7FIpa8lhhRdlzu1N+edPu
         1iqSIHAyN5ZddQOj1FPUMIWgUbZqMlkyNhtdBsqXSIXG3KoYNw7f7s6CDepEGJ8NuM6P
         v7cA==
X-Forwarded-Encrypted: i=1; AJvYcCUeUcMU6kHUO9evzWNlANOadJX5DbKrdGlwPfWzHZd8J2KJkqMbC93C7bwOY+s/gQflAItvJbElTbQoc5U=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5TMm4qk5ySBmBg0R9Lgr+P6z9VpebRoS6bX3voE8m5DQog+Z1
	VtK5u2tTY0MVncNhv8urTM8xpL89LkSatQv174+f4Vfx6LhOOwnlfWMZ1B0XVIU=
X-Gm-Gg: ASbGnctu/+NMb9hSpUZuJnv0iysiLnSaoFkfncUmKae+KLKwu7ZyVGUlWpNiMvJzbaS
	83NEBXVlF7/JNUTPssFw4916f0Pk9lIQFnLyCQrsS1kFRqNS1tvveOPFKMVO5c6uSD7YOeQSZcH
	Kyhdyzw7stN1xHMn34oF0H/4nk1k+CmVb1zzcxfYlVuxotJbAKsw6LTCDJP8foYZPrWVQoO5dJC
	YhZ1kRG7RW34TwVrkADppi/n7sHs4e2MYhL+mP1xor0o9f6KQAdNPoAbQ==
X-Google-Smtp-Source: AGHT+IHWpMN+fVfSVKuGOy0PyOh+ZtL2oZY0kTB/HI7meXZfOL2asRPIibq5YY2frWH9ySWGPM1agg==
X-Received: by 2002:a05:6000:1f8c:b0:385:f0dc:c9f4 with SMTP id ffacd0b85a97d-386453d6a9cmr3568988f8f.20.1733838746047;
        Tue, 10 Dec 2024 05:52:26 -0800 (PST)
Received: from [10.100.51.161] ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-435d4cd4a78sm17722155e9.28.2024.12.10.05.52.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Dec 2024 05:52:25 -0800 (PST)
Message-ID: <21f75fd1-58f3-4c80-8527-55282518c802@suse.com>
Date: Tue, 10 Dec 2024 14:52:23 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] preempt: Move PREEMPT_RT before PREEMPT in vermagic.
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-rt-devel@lists.linux.dev, Ben Segall <bsegall@google.com>,
 Clark Williams <clrkwllms@kernel.org>, Daniel Gomez <da.gomez@samsung.com>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>, Ingo Molnar <mingo@redhat.com>,
 Juri Lelli <juri.lelli@redhat.com>, Luis Chamberlain <mcgrof@kernel.org>,
 Mel Gorman <mgorman@suse.de>, Peter Zijlstra <peterz@infradead.org>,
 Petr Pavlu <petr.pavlu@suse.com>, Sami Tolvanen <samitolvanen@google.com>,
 Steven Rostedt <rostedt@goodmis.org>,
 Valentin Schneider <vschneid@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Thomas Gleixner <tglx@linutronix.de>
References: <20241205160602.3lIAsJRT@linutronix.de>
Content-Language: en-US
From: Petr Pavlu <petr.pavlu@suse.com>
In-Reply-To: <20241205160602.3lIAsJRT@linutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/5/24 17:06, Sebastian Andrzej Siewior wrote:
> Since the dynamic preemption has been enabled for PREEMPT_RT we have now
> CONFIG_PREEMPT and CONFIG_PREEMPT_RT set simultaneously. This affects
> the vermagic strings which comes now PREEMPT with PREEMPT_RT enabled.
> 
> The PREEMPT_RT module usually can not be loaded on a PREEMPT kernel
> because some symbols are missing.
> However if the symbols are fine then it continues and it crashes later.
> The problem is that the struct module has a different layout and the
> num_exentries or init members are at a different position leading to a
> crash later on. This is not necessary caught by the size check in
> elf_validity_cache_index_mod() because the mem member has an alignment
> requirement of __module_memory_align which is big enough keep the total
> size unchanged. Therefore we should keep the string accurate instead of
> removing it.
> 
> Move the PREEMPT_RT check before the PREEMPT so that it takes precedence
> if both symbols are enabled.
> 
> Fixes: 35772d627b55c ("sched: Enable PREEMPT_DYNAMIC for PREEMPT_RT")
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

Reviewed-by: Petr Pavlu <petr.pavlu@suse.com>

I'm going to wait for a few days if others want to comment and then plan
to take this through the modules tree for 6.13-rcX fixes.

[Luis asked me to look after the modules tree for a while, with the plan
to rotate it.]

-- 
Thanks,
Petr

