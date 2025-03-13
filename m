Return-Path: <linux-kernel+bounces-558926-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F3C6A5ED32
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 08:42:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B6F48178F07
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 07:42:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A332025FA1C;
	Thu, 13 Mar 2025 07:42:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="Z22NxKnB"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 516DA25F994
	for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 07:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741851728; cv=none; b=Q5uYXwaUA1XJnC2g8jAk5d37hA9X8EwWiitkrQVpKSKBTk3nz4k8cDfnLHwpv7JVmQfVZ2hXnzwlKS7gkn637QII4838gbTUVM9s9+Gj7loApoI2L9230BQJ0njnImA6dxSYA/vPnzBsxcQhjZrOHna6hH0ZGZp44C00Dpn/pHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741851728; c=relaxed/simple;
	bh=nCVSqnEnx2Q/KY53E84r+b994K82QxscFMOX7J1DrCU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ny/8qSp7d1AYo0T3/8Drigedm1MiaiW7tG0n3/VirDI1cmvr3BtzTihTW9iO4pkvNVT3SME/Lzz8k39Zqcy6yH/gl5ABuHPCYUBgM+duKyA32QQeGhANoBqF1U0LrU7bqc5WeIC10jY2gBh7bxjJ5rR1PG1R5JjcUft5GLcoJaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=Z22NxKnB; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2217875d103so1751195ad.3
        for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 00:42:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1741851724; x=1742456524; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=q1AqZM/yTtIvBRuNHjGI32yWuT8xS936jXlX7O3zs8I=;
        b=Z22NxKnBUkc41t+uOk0VLHsB2LTWe60/UT3fZx4+YeBo3TpArxZt1DKTX3RvVvHtp/
         mX1S3Q8AZIUFQCcZAAy0L5W7mg25B7yLfgGnXI+tS+uCv84+aJHMh6Mr6O0uLRaowoCz
         DpiF3akCBNc3Mpfr7l4EOx5BBnU0x5rzoAS44AXLDJgwl7Gt0jEk/p3azT8rdPXX02yw
         c0EvtchotV/ALLnATx7aDMajKaSSKEn+ZooFGovuZr0PC2fxRXoqOe5IcgeXHDSYZiBC
         jElpjYBzM45WQY8IR7MvuHdeBgWTiSr7m5lU8RmAvd+uY8z7WIZy2oRJU2F1FCQy9ABt
         wV5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741851724; x=1742456524;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=q1AqZM/yTtIvBRuNHjGI32yWuT8xS936jXlX7O3zs8I=;
        b=dZKPCuUeGh5ALVmD47HstFSENc9i5CxIjqRwLzDz3612abLypUEnGcM9DsuMgHevCH
         lPX1VQ5ya3ZHP09aL+Wg5mtj5IXM9eGNS9web1mv+LJsWWBp9Y7UaRxEF/UgJTYJ8x0/
         qiU/fQ6Lj3bSa+jUD6B1AtniOeWWtXcTpE6mHZm+zycOBBQyI3hv0Sfq5ONhso7IkQgV
         QCbDmC14fXDvr+MEqHbYiTv1nFYXxr/GlQ5Lxc65T94Z+MvxW7gBL94E+4D5qnv5ddVN
         Bgzbplag01drrZ2pKkHS6DGm0LHX2NZ/cf6zADdp/WRdYwm8YtEA9mwvQ4nbKbiJ07UN
         qp5w==
X-Forwarded-Encrypted: i=1; AJvYcCUeu21+m6tYetSli49jBXhYVKo8dmH28oQLqSKxhfkn4c+M3eavPq/rjSnrOLZJW98AmsdHer2o/rHS2jE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxtwYpUt6BJ0D/kaMmeP4/a6VGIaTe/TnjWRO25NDy6Dd/XiUCf
	IXtEyiZKpvJwAhkkbxwqonMZollFr6nNImqevBAUTiraMwR+Er5h/7W3YJE4JsY=
X-Gm-Gg: ASbGncubbLuwsUUpwsKms8yKs/kTx9XJolO86Q6zH2yyaFGrfiJ4nh3rMohrr+ZhBgx
	RAETWcXK5P3+8WzFNZrE8LT2sGVZbXfRh8xcL1IX9E2DvnKo3XDOzscRsp50atQSOkx2Y71lQhO
	s+NffOsPjR5QEWg0cUSXXJ1/MSrhee1Q7dyAXNAhiq+3VLAwR8ZStJhv3/cWZr2i9cGrUEHnJqr
	nghmd5smM0pKGz9KZfd0sqGA+NN0nEdiOVkXtaiumMRebuhGo7HTy2utWlT6Z/SRIjLK1UW3L9a
	VXNDLXf5E6uYRw/Jkh/ZZEpKxhrSVkOTAsteGCOlIrEn7a+TEI7Q2GOmk3Dwqu5cFnE=
X-Google-Smtp-Source: AGHT+IGeza8+M0LoZPe/4OuNWc5AWIUs5PETp0dbUUWDaRzBR5u1fSUJ5L/tnl3wUZCAlZcH5fkzqA==
X-Received: by 2002:a05:6a00:1389:b0:736:4d90:f9c0 with SMTP id d2e1a72fcca58-736eb9c3cacmr5291607b3a.1.1741851724170;
        Thu, 13 Mar 2025 00:42:04 -0700 (PDT)
Received: from [10.254.33.33] ([139.177.225.226])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-737113d71fbsm728704b3a.0.2025.03.13.00.41.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Mar 2025 00:42:03 -0700 (PDT)
Message-ID: <fffe9509-6260-43e9-95e6-f4aa6780bb7a@bytedance.com>
Date: Thu, 13 Mar 2025 15:41:57 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Re: [RFC PATCH 2/2] sched/fair: Do not specialcase SCHED_IDLE
 cpus in select slowpath
Content-Language: en-US
To: Josh Don <joshdon@google.com>
Cc: K Prateek Nayak <kprateek.nayak@amd.com>, Ingo Molnar <mingo@redhat.com>,
 Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
 Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>,
 Tianchen Ding <dtcccc@linux.alibaba.com>,
 "open list:SCHEDULER" <linux-kernel@vger.kernel.org>,
 Viresh Kumar <viresh.kumar@linaro.org>
References: <20250310074044.3656-1-wuyun.abel@bytedance.com>
 <20250310074044.3656-3-wuyun.abel@bytedance.com>
 <CABk29Ns9wq+mB5mAfu72gi3RZkNdwzXmkZSq3FQpKkTEH23dgw@mail.gmail.com>
 <2c8c4cdb-e9b7-40f3-aa83-d82676641162@bytedance.com>
 <CABk29Ntuzux+AYEhuDO0EPKEupAEsQ+=OwfSi8VrtUmUXZbHEQ@mail.gmail.com>
From: Abel Wu <wuyun.abel@bytedance.com>
In-Reply-To: <CABk29Ntuzux+AYEhuDO0EPKEupAEsQ+=OwfSi8VrtUmUXZbHEQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 3/13/25 3:24 AM, Josh Don wrote:
> On Tue, Mar 11, 2025 at 9:43 AM Abel Wu <wuyun.abel@bytedance.com> wrote:
> [snip]
>> False positives are possible, but the possibility can be reduced by
>> optimizing blooming setup.
> 
> An interesting approach, thanks for sharing. Not that it matters
> (given that we're not pursuing this now), but just to call out that
> this has poor scaling with large cgroup hierarchies and updates to
> cgroup idle state, so in an actual implementation it would be ideal to
> do the updates asynchronously from sched_group_set_idle (ie. via a
> kworker).

Good idea. Async update makes sense since sched_idle_cpu() is not
required 100% correct, and with this we also can join several updates
into one.

> 
> We could also greatly simplify this down if we assume certain
> contrived setups, for example if we assume we primarily care about
> sched_idle cpu preemption against only root-level sched_idle cgroups
> (as everything inside a root-level sched_idle cgroup is trivially
> preemptible by a task from another hierarchy). But obviously your
> cgroup setup doesn't fall under this category, so it is not very
> useful.
> 
>> I chose the simplest way for now to workaround the issue we encountered,
>> while I am still trying to do something to get rid of sched_idle_cpu().
>> Thoughts?
> 
> That sounds reasonable to me.
> 
> Reviewed-by: Josh Don <joshdon@google.com>

Thanks!


