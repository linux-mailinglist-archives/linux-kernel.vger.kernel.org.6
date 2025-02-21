Return-Path: <linux-kernel+bounces-526121-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F6B1A3FA41
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 17:10:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B04BB7AB1E7
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 16:03:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 972DD22332B;
	Fri, 21 Feb 2025 15:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="Fyi8vVw9"
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0CD821170E
	for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 15:58:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740153497; cv=none; b=cVtzBYQ9jgch3NZuhCMYlZTFLR720zIg1QTwO+1CVz49lrBCWQYaF16Q4sWVH0oiv6pUh9BX6Dc3/hSGoY+jNOpztgMwFLOgipou3Ywr0Fm58pgdnG8EHOuWo3Ic3OfQoffBb+fa6lVHGsmH2mIOQ7Fasb6ZlAzW3mTQxkfoy90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740153497; c=relaxed/simple;
	bh=//L1C5Ks/H10EmkSZyQhaj8jYD4OCALEp8yeUn5ekD0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kRGXU61in9vlnnnsiFRId2Bp7oPCr7LmdFQf1/CiXLCB5CLxpzrQ0xzSpDOGbke23vTnbuS9OQ+XhjSDaFgZ/yP40lSt/AnYRm+u+mBZReCM+yM6uf5t1aJaNIDsMquE1o8SvYocLlCieoeGcHZgfv2NdOOPcH7b/T1JaKJ29vM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=Fyi8vVw9; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-2fbfe16cbf5so560466a91.0
        for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 07:58:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1740153495; x=1740758295; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FzH4mBzUZG/VM1IvpFl7X2mx5yrtA4S1cGmaADqasjo=;
        b=Fyi8vVw9swoJpiu4Zma5R+YDlNO4I4KLH6MmW/DqDiF5sYLzDEJmVW8AEdTvPuKCJ4
         VG1k2XyNx4aFsBQT9skwWQNUzZI5o28Pb7+Qvk5tH03PytehIC2Oi6kUFF6x+hsNMRyE
         VMFZTDNthlhAA3td+fnx0q16L2InAgLZ4248fdqKEAm7cxWVAyC6WTSf6qJ0FUepRJmx
         0Orrl9nSG3A+20ZBzMfI24D8Ex/NXA90WozmubEvaBQL+QROEkeh45N2Y4IUY9KWEr6M
         lUsa1dwjoC8/vR507p03Rsklnn51S4wiJLKz/K2TWxZRHPXaajxFgBwiKQXZTw9a33hQ
         DS3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740153495; x=1740758295;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FzH4mBzUZG/VM1IvpFl7X2mx5yrtA4S1cGmaADqasjo=;
        b=oWgo6lg7pA7ivaPEO3SN8Fj42NidIXljAPAEpY0F1eG19e6CJz/8WP7Ztpy1I4Z6R7
         Vb0ri+fIMTsNuJt20O+rRX579SDcvYKUBoz89YIYnkFMm2mbOqEcQXzpxcpLs+QiNgjN
         LQM7/ZITRV5De/l4vdJAI4wOq7XME6OivxXJNtjNTtohORT7+dMb6UM6sQ5HJ9Imh6QI
         wBJTCzdYq5kLPWt7Ee9u/rHw49G6qbbdW9IKvJAkt/RuY5ZIk76JiJTTsUFf48VZ4Wmw
         6b1ErToqDREhnhjhBiUhqimCPhLbiFPybuysGKihhKxs6O3bQjDo6I8/w2a4sdJ2+S2X
         0e+g==
X-Forwarded-Encrypted: i=1; AJvYcCX3ffIyYRydLyvqvpJ0nFiMHuYAAWLwjjiRcUAwrAvZo2nx4srZt3x8c8qm05XK1Mx6mP3S/D5Sw7Nmv/s=@vger.kernel.org
X-Gm-Message-State: AOJu0YzDybdG5oT5tdTXkJNZhsTgo0RBixbzJKp+P2rg6UZ7UOg0MW7C
	DXRfFbyEnThHPAlpI9AMH3XpvHimXLQSB5AhjikRiJ7rA1a34+h9omMuEObHQ8k=
X-Gm-Gg: ASbGncuq2sNIyAszC9IvpJ03a66v4LKaOD+jkQNYo+VrkCtQSZt6Og+Ftxe07pZuAz/
	mgxSbEKQZ4Ev01FQl0tr4n1FjQAPcbT+G5DZQgEil9e+LO+RKqN6f5X2TzQ+hvyw/95CoLLlkma
	W+R9THoztcOBo//CkHpnQuZru+3YQbm3eS+XhCZkYK87jrMIfKRK0IOdVPad4zlCepxqFeN7lxH
	PM1xZwanlJW14dLgV3Mkd3qjTbeOhjDp2DIdIUsaapGYfNtgo6QR1UUQ9ejTeAlUn8vJOoPH/0l
	juPX9KXUZRc/ZIxP7K0NsFVNVzrrlXOjJ2bMZJ2CXPf/3y9RgWQGfagK+oOWdS8cMdyfDkvf+U+
	JHpl3KqYhP+OQkw==
X-Google-Smtp-Source: AGHT+IELh9Wt1O7g5djzWOWAdKQK5tMIZlIxTyNgDd9ySXUlQZQSkyuX2oRq7bK6YU6j9mWrP2bhmg==
X-Received: by 2002:a17:90b:3e81:b0:2fa:6055:17e7 with SMTP id 98e67ed59e1d1-2fce7b1a435mr2353156a91.8.1740153495062;
        Fri, 21 Feb 2025 07:58:15 -0800 (PST)
Received: from [10.200.58.71] (151.240.142.34.bc.googleusercontent.com. [34.142.240.151])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2fceb02d985sm1553554a91.6.2025.02.21.07.58.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Feb 2025 07:58:14 -0800 (PST)
Message-ID: <6097164a-aa99-4869-b666-9dc7018c1f96@bytedance.com>
Date: Fri, 21 Feb 2025 23:57:57 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Re: [PATCH 2/2] sched/fair: Fix premature check of
 WAKEUP_PREEMPTION
Content-Language: en-US
To: Vincent Guittot <vincent.guittot@linaro.org>
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 Juri Lelli <juri.lelli@redhat.com>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
 Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>,
 Josh Don <joshdon@google.com>, Tianchen Ding <dtcccc@linux.alibaba.com>,
 "open list:SCHEDULER" <linux-kernel@vger.kernel.org>
References: <20250221111226.64455-1-wuyun.abel@bytedance.com>
 <20250221111226.64455-3-wuyun.abel@bytedance.com>
 <CAKfTPtBzsX6GKZP_NGTONrkp96qx9uOHr0+XG7tC6ELy4tbHBg@mail.gmail.com>
From: Abel Wu <wuyun.abel@bytedance.com>
In-Reply-To: <CAKfTPtBzsX6GKZP_NGTONrkp96qx9uOHr0+XG7tC6ELy4tbHBg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/21/25 7:49 PM, Vincent Guittot Wrote:
> On Fri, 21 Feb 2025 at 12:12, Abel Wu <wuyun.abel@bytedance.com> wrote:
>>
>> Idle tasks are by definition preempted by non-idle tasks whether feat
>> WAKEUP_PREEMPTION is enabled or not. This isn't true any longer since
> 
> I don't think it's true, only "sched_idle never preempts others" is
> always true but sched_feat(WAKEUP_PREEMPTION) is mainly there for
> debug purpose so if WAKEUP_PREEMPTION is false then nobody preempts
> others at wakeup, idle, batch or normal

Hi Vincent, thanks for your comment!

The SCHED_IDLE "definition" of being preempted by non-idle tasks comes
from commit 6bc912b71b6f ("sched: SCHED_OTHER vs SCHED_IDLE isolation")
which said:

	- no SCHED_IDLE buddies
	- never let SCHED_IDLE preempt on wakeup
	- always preempt SCHED_IDLE on wakeup
	- limit SLEEPER fairness for SCHED_IDLE

and that commit let it be preempted before checking WAKEUP_PREEMPTION.
The rules were introduced in 2009, and to the best of my knowledge there
seemed no behavior change ever since. Please correct me if I missed
anything.

Best Regards,
	Abel


