Return-Path: <linux-kernel+bounces-561334-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E130CA6102F
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 12:40:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2326F1B60DCE
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 11:40:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF20A1FDE2B;
	Fri, 14 Mar 2025 11:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="CTS+7R3N"
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7D091FDA9C
	for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 11:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741952355; cv=none; b=ZNEPEoIik3gXGpc/fNDnQyq0r5UgZH1pBtKnAMlowNK7a8qux/Cgy92reMYhj+CBifcpIoO8Y3l7ceUx3KAAsZD8men7rtYrbI+/jfuQ5uH/Hdiuu7j7fdrI4zbSiiomOPnCxKAWGtg/yalfIzWGWYZb18gB2po7aWvesnVgVBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741952355; c=relaxed/simple;
	bh=BoDIagD7QUSyOchniBMxTQlXR/twZLW5jrIcQCEfULk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WKMzaUp96jOOoB1EHW369wggUlsnFnHtc+OvDykwjqnyPL4tP+vo85xZPT7DvW2Vf5Ncx3LvvAaQaOsHDBDmJiIixILMWc6uNE9EHDmNYYtLRzgAGBMK8mnfA4RWM/HME9dA1A4UXAd74FtOLKM1AEVxnvWYy1733glm1EIrrbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=CTS+7R3N; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-223594b3c6dso38900605ad.2
        for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 04:39:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1741952353; x=1742557153; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=inm6tTxtMy53r2CmDlHgGLirJS4F6Ym9arSBIz9KTZ8=;
        b=CTS+7R3NtAO9wO/yc6OCiLC1DacowQafDYHzNWewtdQF/Gwbgk4LR5hsTzQkLfUBRM
         cAvrHtlfTBENkXDSc2sKx9NZfXwffrFko1AJLmvEvD3utC+9C9oJTpQeeobfatSnL1Ok
         J7Mb3UViytqkCBRlX32Ak8tWKpsP7egnWOnjLOT6g505D23EXo5UBF0vdY6bGm/Yn3jY
         y3uqneWI4yKLavZ3gEOQ9cFDgLmkq++mhRQTLU3bQ0Hqyo4QziGwKJ6cZKfFRlJk2Ber
         WrhDv/gZCPJEgG+uPPlfAtDjerH4EW9ambnw3B005GIvbPMBF80hAdIrqMxalVnLoyq0
         1M1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741952353; x=1742557153;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=inm6tTxtMy53r2CmDlHgGLirJS4F6Ym9arSBIz9KTZ8=;
        b=NkQzRfqik8zmxiZyo91BVn3PpH3Rtkj9L+PAccgMdjXUFNTi3Q9Kg6kkWkNCv4Bi7G
         jjkGEjvMRQFTGR1bE0v8Uz5eMdq4bfLmoFD/NXoZoGNtGNrRXaC4KGBY+Rt4a/BdYWYu
         KO141qUsfbhb0E3PeKKLxZYjgAE9xHAng0rslm8DM5ydatZAQMwbb3qj/lD0j4KMdhJ0
         ij6hItirjyE10mXgS3cqhCLqogMA3k9S8Cp9H4BpAAi1iFjcDvGaf3BdzbpIYIs3je50
         iMcQsIIENz+mTDhy24NYhbVbF/i2gwIIwZxUXgSwWxMJ4m7myfzHHzsrwUVOeFei/W0U
         BHuA==
X-Forwarded-Encrypted: i=1; AJvYcCX+46/vtpmH02RW7V0T4EeYK2eUUS923Hsc0a+la+oNEpaGj8S1E8/4Qq7IE/ym3iiPHhstCVXZSEA94xQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+gKDilS713ty5aUYkncF47xSXjfr9e9Cz87V1FLQ5M/HDt8C6
	0B69CLfCiRMe+GGahtKwJanTazbLRBISHRBsA5Lxk2/uiwRljJ/LtJ249oCvWA==
X-Gm-Gg: ASbGncts5Df7jPhs62S3m0KdkyFXhWq3WLN7si6g/iPsyQWDBLQxk7kSqxFFoO9/MmP
	ecT+KA3sGUv7vJjux02sk1v4eJ8Om76u5jjcwnaq7nZI/DwAT1jw3g6OICD6wEB03ecIwF6vTZm
	RpwoPqo7Ls/SriPTD7NwYbc+aton0CHuI7y7i+nk5m28HoxAz5GX3SVi9K5RTUNB3/znGmqOOEd
	6k959kkWuSJHoRy8zLWR91Xf6qbuyrLP02JmqK8OIpjPAtvCqu45t022d5KLorhEGs/wxhhKt/Q
	aUogiMtW/5cV/fEoNKREKmjwromI3Xe6GrPKp6RFjNJG
X-Google-Smtp-Source: AGHT+IF7w7L8XRHkSUaKbyUdtIJ0rhKumnK+zvsMdnEt9n7186X5Jt7AV86I0qlEFrH32/njdQeWEQ==
X-Received: by 2002:a17:903:191:b0:224:1d0c:ca00 with SMTP id d9443c01a7336-225e0a6e2c2mr30152345ad.23.1741952352566;
        Fri, 14 Mar 2025 04:39:12 -0700 (PDT)
Received: from bytedance ([115.190.40.11])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-225c688e15fsm27034035ad.18.2025.03.14.04.39.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Mar 2025 04:39:12 -0700 (PDT)
Date: Fri, 14 Mar 2025 19:39:04 +0800
From: Aaron Lu <ziqianlu@bytedance.com>
To: K Prateek Nayak <kprateek.nayak@amd.com>
Cc: Valentin Schneider <vschneid@redhat.com>,
	Ben Segall <bsegall@google.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Josh Don <joshdon@google.com>, Ingo Molnar <mingo@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	linux-kernel@vger.kernel.org, Juri Lelli <juri.lelli@redhat.com>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>, Mel Gorman <mgorman@suse.de>,
	Chengming Zhou <chengming.zhou@linux.dev>,
	Chuyi Zhou <zhouchuyi@bytedance.com>
Subject: Re: [External] Re: [RFC PATCH 7/7] sched/fair: Make sure cfs_rq has
 enough runtime_remaining on unthrottle path
Message-ID: <20250314113904.GG1633113@bytedance>
References: <20250313072030.1032893-1-ziqianlu@bytedance.com>
 <CANCG0Gf2ZbnffwNVoBSu_+y4sq0MoMYPwwgsnfg53Pf2enwJZw@mail.gmail.com>
 <947ab5ab-3fbe-4a5c-bff5-6c257c7c5ba1@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <947ab5ab-3fbe-4a5c-bff5-6c257c7c5ba1@amd.com>

On Fri, Mar 14, 2025 at 09:48:00AM +0530, K Prateek Nayak wrote:
> Hello Aaron,
> 
> On 3/13/2025 12:52 PM, Aaron Lu wrote:
> > It's possible unthrottle_cfs_rq() is called with !runtime_remaining
> > due to things like user changed quota setting(see tg_set_cfs_bandwidth())
> > or async unthrottled us with a positive runtime_remaining but other still
> > running entities consumed those runtime before we reach there.
> > 
> > Anyway, we can't unthrottle this cfs_rq without any runtime remaining
> > because task enqueue during unthrottle can immediately trigger a throttle
> > by check_enqueue_throttle(), which should never happen.
> > 
> > Signed-off-by: Aaron Lu <ziqianlu@bytedance.com>
> > ---
> >   kernel/sched/fair.c | 13 +++++++++++++
> >   1 file changed, 13 insertions(+)
> > 
> > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > index be96f7d32998c..d646451d617c1 100644
> > --- a/kernel/sched/fair.c
> > +++ b/kernel/sched/fair.c
> > @@ -6058,6 +6058,19 @@ void unthrottle_cfs_rq(struct cfs_rq *cfs_rq)
> >   	struct cfs_bandwidth *cfs_b = tg_cfs_bandwidth(cfs_rq->tg);
> >   	struct sched_entity *se = cfs_rq->tg->se[cpu_of(rq)];
> > 
> > +	/*
> > +	 * It's possible we are called with !runtime_remaining due to things
> > +	 * like user changed quota setting(see tg_set_cfs_bandwidth()) or async
> > +	 * unthrottled us with a positive runtime_remaining but other still
> > +	 * running entities consumed those runtime before we reach here.
> > +	 *
> > +	 * Anyway, we can't unthrottle this cfs_rq without any runtime remaining
> > +	 * because any enqueue below will immediately trigger a throttle, which
> > +	 * is not supposed to happen on unthrottle path.
> > +	 */
> > +	if (cfs_rq->runtime_enabled && !cfs_rq->runtime_remaining)
> 
> Should this be "cfs_rq->runtime_remaining <= 0" since slack could have
> built up by that time we come here?

Absolutely!
Thanks for pointing this out.

Best regards,
Aaron

> > +		return;
> > +
> >   	cfs_rq->throttled = 0;
> > 
> >   	update_rq_clock(rq);
> 
> -- 
> Thanks and Regards,
> Prateek
> 

