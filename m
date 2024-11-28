Return-Path: <linux-kernel+bounces-424554-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 478DD9DB5C2
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 11:33:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 33D00B2724E
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 10:32:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B63AE158874;
	Thu, 28 Nov 2024 10:32:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PQpAm0uw"
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F153155A25
	for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2024 10:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732789963; cv=none; b=KzXcSHTItU6R3kdR7aePE09QhexlJEskyIv/S0CwzvT7/RayGM1cx8EiTF7pK2s19P406qUjSYU+reM6Nw/hV/H89nb38WV0Py0wIzkAppd/USVPNOB9+2G8GnqWQDJbThA4V1ZvUlxL6O+F2PL7akY+BoN6om7krMYcFPfg3dg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732789963; c=relaxed/simple;
	bh=k97Fljrat4fJca+lSRfnK8THalpUsT4kOzuH6apFu24=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TjAYsxhgaBFDZJxNI1eJJawsfoe+epu/WsJAOCSvXxwkx4Ts0ndUr7jgdXMKca5Zhxq4giflb3MIdTRzuO0e7K1SFg3dD831+eFWFHmsMIntsnpZIcRXXFglL6BJCmjEqPl7PUP9FYDX9N54qB/BvKLJq7NotLI5Ej7IIA5ktis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=PQpAm0uw; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-2ee153ec651so555756a91.0
        for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2024 02:32:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732789961; x=1733394761; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=TYdaa/DIBuyQgC5GkVlGb3y6FcXP9nQSsNbG84HxtFk=;
        b=PQpAm0uwbnC1fHKYGd0clxc//Iivqa/eAq7HgF9evobI1dgmInbTKrl0OYp+fSQlg4
         eBqnnryY8TocokSVIaGVmbquzDJEzIeMS+tFjumbg7opOx1SgQJ0+xnanxK93kDgFDYu
         9npsNYTAiUfLt+RcUSJ69Mx0pHeho+UiimepJ2yMSCQ3hwz+qNwVdKjVy2tTQi30Xyio
         whxo35DFhFftmXmb6bQaDBREVmXA7YBftQmQ1IDzSfsngHhK1FVW9LIFZXC4Pf9EsvZo
         4m9l0dPSfsRkUwTNhBvHQbBoNMp2JmRMJSN+p+1WZbGngbIh5YrEfDbIqAFe16PKYfBO
         8KkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732789961; x=1733394761;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TYdaa/DIBuyQgC5GkVlGb3y6FcXP9nQSsNbG84HxtFk=;
        b=vxrLnPBmthddvQSZuaqb7PeFxDuOnL+1BHLuHLAaSapJO5BbkiitE++aHBnu2jKuSs
         ujPAT0BnqPKqSJX+llWsGZMITHCwDdedZPN1qkSilpcjuN8xFhqh3++nGkES/uNr+q0m
         ipTxSY/yNbOD8kYOBVbx7WS+qg5rqe3LfzCWvRHgMg0NWQFBV1DsLK7bE7i4jyGSruAy
         pY2RyEgIF+t7nE/tKe5mnNDXmq+8viOQDWI/DicT3CO0t2YEzQFHMFQrOoKCUwdx4Xo7
         Oxblmt0/0jHv2b5/1Tq0123RpG2NbnNN5qy4ebA1q586SrQj87/YU28sYQRRt033FJd8
         OxEg==
X-Forwarded-Encrypted: i=1; AJvYcCU0S2lOlUJQweN9si9CldzJarKhI3INhJ/teWSnofN8+z8+Rc7PIJla8gLZDPff69fmJJk+WqaGy410ADU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzfXMniO0jEmtP571LQ5bN/2DhLOLVzJtDYPh0kSqGzZkrSolsF
	j4uZm8R19JQ8F9dzrfItBqemEpNnPdKabioqvI7UtDpkxePgtU47FeNVd+Dmd3cJu69JYqQqpfr
	WSo8EsSpISEtNFcQpZ+X7ic3KeCC2B5uN93zAmg==
X-Gm-Gg: ASbGncsFehGNhdYJO6kE+pQE6Zn2WY5+uYDelaWlyVH9Zw25Wk3Q9I3demOmRmbNP4F
	ltF04ktqADxR1kofdztlEua3RDKNiG8ufYxt/jy85h0Y9bQI3shQiddAetgI=
X-Google-Smtp-Source: AGHT+IGtRew9wNbW+qj4I4/4DKAWOAOllEr1d0Tgmr9ZbsOh6yJfqWq1WRpSYaYMJydxlyxw3eFcTW/Bs5s+yesUr9w=
X-Received: by 2002:a17:90b:1810:b0:2ea:b2d7:4a3b with SMTP id
 98e67ed59e1d1-2ee08eb1c52mr9788003a91.12.1732789960956; Thu, 28 Nov 2024
 02:32:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241128092750.2541735-1-vincent.guittot@linaro.org>
 <20241128092750.2541735-7-vincent.guittot@linaro.org> <20241128100348.GC24400@noisy.programming.kicks-ass.net>
 <20241128101517.GA12500@noisy.programming.kicks-ass.net>
In-Reply-To: <20241128101517.GA12500@noisy.programming.kicks-ass.net>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Thu, 28 Nov 2024 11:32:29 +0100
Message-ID: <CAKfTPtAexBEDeG8vR2Hf_6fh_uiGCUooeBj6vCYRn8LGEVt+kg@mail.gmail.com>
Subject: Re: [PATCH 6/9] sched/fair: Removed unsued cfs_rq.h_nr_delayed
To: Peter Zijlstra <peterz@infradead.org>
Cc: mingo@redhat.com, juri.lelli@redhat.com, dietmar.eggemann@arm.com, 
	rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de, vschneid@redhat.com, 
	linux-kernel@vger.kernel.org, kprateek.nayak@amd.com, pauld@redhat.com, 
	efault@gmx.de, luis.machado@arm.com
Content-Type: text/plain; charset="UTF-8"

On Thu, 28 Nov 2024 at 11:15, Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Thu, Nov 28, 2024 at 11:03:48AM +0100, Peter Zijlstra wrote:
> > On Thu, Nov 28, 2024 at 10:27:47AM +0100, Vincent Guittot wrote:
> > > h_nr_delayed is not used anymore. We now have
> > > - h_nr_running which tracks tasks ready to run
> > > - h_nr_enqueued which tracks enqueued tasks either ready to run or delayed
> > >   dequeue
> >
> > Oh, now I see where you're going.
> >
> > Let me read the lot again, because this sure as hell was a confusing
> > swizzle.
>
> So the first patch adds h_nr_delayed.
>
> Then confusion

I started from your patch that adds h_nr_delayed and added on top the
steps to move to h_nr_enqueued and h_nr_running to make it easier to
understand the changes

>
> Then we end up with:
>
>  h_nr_enqueued = h_nr_running + h_nr_delayed
>
> Where h_nr_enqueued is part of rq->nr_running (and somewhere along the
> way you rename and remove some idle numbers).
>
> Can't we structure it like:
>
>   - add h_nr_delayed
>   - rename h_nr_running to h_nr_queued
>   - add h_nr_runnable = h_nr_queued - h_nr_delayed
>   - use h_hr_runnable
>   - remove h_nr_delayed
>
>   - clean up idle muck
>

I can reorder the patches following the above

>
> And I'm assuming this ordering is because people want h_nr_delayed
> backported. Because the even more sensible order would be something
> like:
>
>  - rename h_nr_running into h_nr_queued
>  - add h_nr_runnable (being h_nr_queued - h_nr_delayed, without ever
>    having had h_nr_delayed).
>  - use h_nr_runnable
>
>  - clean up idle muck
>
>

