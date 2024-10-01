Return-Path: <linux-kernel+bounces-346442-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F6B398C4CC
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 19:51:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 47AFE283C68
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 17:51:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B8BF1CB338;
	Tue,  1 Oct 2024 17:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BBNV/z0J"
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5879615E97
	for <linux-kernel@vger.kernel.org>; Tue,  1 Oct 2024 17:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727805093; cv=none; b=KqZB9+JLnfEhowveJXR0Y+wPLM+LHg74ECGO2NiUV8H4N9Ac8E8CwEW21Bap9PCu36kANBncGVQ8dzXGQ3jZIuNaNQTh2otZVDh8qMPaKRPVaCwO91u8NdYNqvAUBch9K78uMLmZc0LfefYrOazOn/S1hHV5nfWHasME5QE2yPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727805093; c=relaxed/simple;
	bh=Puss9BApr+1hY17Nh1/Ex/QuAcadkHt7STsLRGAd9+I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=axNzFIQzwyxLr/t/r+trt3pR5EozeVKceS4wGdJse3Not8HnQrXROnAVbwoa30XLlf3eGuBWl/9Fd399akR1WcSav37T5cZamgEarOI8c94zPgXdL1w5VV3aqQ40QD5mUADJA8xwN3HTZoAiW0zbp+i0FrZRHUoTyEx7fhjwWqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BBNV/z0J; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a8d446adf6eso93541266b.2
        for <linux-kernel@vger.kernel.org>; Tue, 01 Oct 2024 10:51:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727805090; x=1728409890; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ye0kEfU3+35oGGuSLCTNEwH0CZtLF6Z8wI8wFhyQKTY=;
        b=BBNV/z0JEQPa8UhZ2pVRLnwe0P4dOsFpRcoyEf2hDjvGRWIkR3rU6h/OQM/SKLf5y9
         DN7obGVdjqvobO3hGnIcMHws0ZaJyIyqyKkNJRC8LHGaxf4q+xjU+WCMAh71ShAqd0RP
         V1VTphgSBHZRiSFejCIwgUgZDA6GRsFyiVvM900+VDUP7M3ytov5yAIuj7a2ZAj7N5Cx
         4AzV+W6WYn52JWt3rVOAty6Ecfa0SoE+ZK/ObZ5zDoV4flQsNXS0jh+XiHkfKsWl1zrd
         cOvudDxDOBwZsj+N1FcwLqfSQolMWr+tBYBlmETFqoL7/uZTeNrTrf/EWVZPfxq5veTn
         fQxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727805090; x=1728409890;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ye0kEfU3+35oGGuSLCTNEwH0CZtLF6Z8wI8wFhyQKTY=;
        b=utM22hUJ6GCcW21t1s2lawoLc6BEJMqQo61agencr4r25GvXixF2nt3edzjMKpthvi
         i5YaBf2yyhy8sdvi+SJGlfS4D0iBi5z0ZhhFOG03/GzLJJThmgWrb6XcppiGH3EC/hp6
         r0Ctl8ut2m8gDgFhP2IQR2hq4hH46OTfGlB9n5Id/Gqqpq/Pfy0WoWpjZNlLs1WQ3ifO
         2XHXdapCbdj7PihwqwiL4IgDmo3TjyK2ZBZ9sgLeVmM3dTGCJEFNtQls4rpLWsF0spkp
         bAHO/c3AMA/xzOooYLX/zV9zGNHxPil/BUsVo4BFtSJ82Y9lxPrk23Wdqbf0N2jkbXHf
         YR9A==
X-Forwarded-Encrypted: i=1; AJvYcCUjCI/rJk5z/A+7rsMI0eG+F6/+FvAFBD87mXqLJS0ibpBL8ve/gIZQbkXZXo8PRpSW8ABFePjNA+5THG4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzYp3kUUrJELa8+qGPr5T2KyiyH9anaM2kLuQ05TlXQgtu0cXgO
	qFEYMK09KiYzxvYvmAM4+xozqOs/R1xaVK0O/z1kjWo72xOJQVq6yLylgRevLw==
X-Google-Smtp-Source: AGHT+IFyIi8su5g/oEpMlyVfp6vas55+Z8tWlE/fajE+DUoy4S5abw1D2sCXwFzQtjvRDxYDc1OMQg==
X-Received: by 2002:a17:907:944f:b0:a91:158f:6693 with SMTP id a640c23a62f3a-a98f82008e9mr44929066b.9.1727805089357;
        Tue, 01 Oct 2024 10:51:29 -0700 (PDT)
Received: from google.com (118.240.90.34.bc.googleusercontent.com. [34.90.240.118])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a93c27773cbsm739409766b.45.2024.10.01.10.51.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Oct 2024 10:51:29 -0700 (PDT)
Date: Tue, 1 Oct 2024 17:50:47 +0000
From: Quentin Perret <qperret@google.com>
To: Vincent Guittot <vincent.guittot@linaro.org>
Cc: mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
	mgorman@suse.de, vschneid@redhat.com, lukasz.luba@arm.com,
	rafael.j.wysocki@intel.com, linux-kernel@vger.kernel.org,
	qyousef@layalina.io, hongyan.xia2@arm.com
Subject: Re: [RFC PATCH 4/5] sched/fair: Use EAS also when overutilized
Message-ID: <Zvw2O4JGBpMXwOZA@google.com>
References: <20240830130309.2141697-1-vincent.guittot@linaro.org>
 <20240830130309.2141697-5-vincent.guittot@linaro.org>
 <Zu2gHOv7mqArWXLZ@google.com>
 <CAKfTPtCvwPq+8pQcTZePiee9EXxKAQS=J57X2OavWFrQwkDt5A@mail.gmail.com>
 <ZvUlB8s-zIkDQji7@google.com>
 <CAKfTPtAzG7u0+e=8skMhnCETVxbDTOxT-zLaoqUXB-Zz5=4t+A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKfTPtAzG7u0+e=8skMhnCETVxbDTOxT-zLaoqUXB-Zz5=4t+A@mail.gmail.com>

On Tuesday 01 Oct 2024 at 18:20:03 (+0200), Vincent Guittot wrote:
> With commit 50181c0cff31 ("sched/pelt: Avoid underestimation of task
> utilization"), the util_est remains set the value before having to
> share the cpu with other tasks which means that the util_est remains
> correct even if its util_avg decrease because of sharing the cpu with
> other task. This has been done to cover the cases that you mention
> above whereboth util_avg and util_est where decreasing when tasks
> starts to  share  the CPU bandwidth with others

I don't think I agree about the correctness of that util_est value at
all. The above patch only makes it arbitrarily out of date in the truly
overcommitted case. All the util-based heuristic we have in the
scheduler are based around the assumption that the close future will
look like the recent past, so using an arbitrarily old util-est is still
incorrect. I can understand how this may work OK in RT-app or other
use-cases with perfectly periodic tasks for their entire lifetime and
such, but this doesn't work at all in the general case.

> And feec() will return -1 for that case because util_est remains high

And again, checking that a task fits is broken to start with if we don't
know how big the task is. When we have reasons to believe that the util
values are no longer correct (and the absence of idle time is a very
good reason for that) we just need to give up on them. The fact that we
have to resort to using out-of-date data to sort of make that work is
just another proof that this is not a good idea in the general case.

> the commit that I mentioned above covers those cases and the task will
> not incorrectly fit to another smaller CPU because its util_est is
> preserved during the overutilized phase

There are other reasons why a task may look like it fits, e.g. two tasks
coscheduled on a big CPU get 50% util each, then we migrate one away, the
CPU looks half empty. Is it half empty? We've got no way to tell until
we see idle time. The current util_avg and old util_est value are just
not helpful, they're both bad signals and we should just discard them.

So again I do feel like the best way forward would be to change the
nature of the OU threshold to actually ask cpuidle 'when was the last
time there was idle time?' (or possibly cache that in the idle task
directly). And then based on that we can decide whether we want to enter
feec() and do util-based decision, or to kick the push-pull mechanism in
your other patches, things like that. That would solve/avoid the problem
I mentioned in the previous paragraph and make the OU detection more
robust. We could also consider using different thresholds in different
places to re-enable load-balancing earlier, and give up on feec() a bit
later to avoid messing the entire task placement when we're only
transiently OU because of misfit. But eventually, we really need to just
give up on util values altogether when we're really overcommitted, it's
really an invariant we need to keep.

Thanks,
Quentin

