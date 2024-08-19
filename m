Return-Path: <linux-kernel+bounces-292107-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4090D956B2E
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 14:51:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DE5CC1F22C61
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 12:51:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5340C16B72B;
	Mon, 19 Aug 2024 12:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Xubo4009"
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 139751D696
	for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2024 12:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724071860; cv=none; b=QrHrakT3p9c6dhdlefl8gFxDMoMdw7nuJo1+KOyqobkoON8khIiSUan15a/GVnYSuGo9jIcPZGiECoKAmVqwZRd0IZIwEE717qAjv6IJsFpqlYwvSnngocw8Aq6WW40aV57asmuv+S1NY/Vcgq7/Oi2XLHyRB3nBd0WCy8kQKvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724071860; c=relaxed/simple;
	bh=SmJxeiNAmrUynGJJqO60V1gIIwQbOLQFvIC3TFSs3Z8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=T1dAINquCSl5klJnfK/FtjiWLBHZuhUE3W0F04hALgrAUi3t7O7+jkd9nGtzZsg4QxiSTq9I6WjidrRe44Y/n1Zm0CvbnUyD9nFQFoO4PlK7Ttt8AoFXcbNIr5fA9zKE5cA7oTeNEKaY9x0CFZrun4zhLkO1MS0ohCJ6g/DwB/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Xubo4009; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-2d3c08541cdso3107244a91.2
        for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2024 05:50:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1724071858; x=1724676658; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=SmJxeiNAmrUynGJJqO60V1gIIwQbOLQFvIC3TFSs3Z8=;
        b=Xubo4009Qrp9mX6UzWl+kh5BuWWwEVJmIA5KPeMJCSkDP/RMIsDICS1W6ZYYu1OYmI
         Rrw8C3aevogUDM1cDfwMbavD2O0Xx5tNuuned7EggOYhsLEByfYMFGNF7L47Efbc9k3j
         BmOyw6puafiQi2ezpUrGWZbnk0kXu4uKsWVe7kWJ5YvoIJ3t4xm+tQxq+KyceIx8zDTm
         HOiHJoHkp79SkrUf/VhwV6yllJ6WnmKKSjf5Zv8hIcR22CokQCZnLMQLHcM7XJ6VIM+E
         KdiwGxAhV5EhocRi5ClWZvyG1Jc+q3ONsmftTApKnYRze4SVfvlOco9TlIFcDnyzkZox
         ++wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724071858; x=1724676658;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SmJxeiNAmrUynGJJqO60V1gIIwQbOLQFvIC3TFSs3Z8=;
        b=jNjVtPKIAkQoRzaPULB3EUHJLUtmkac72e2rkVsN5UsTNG6xpr4JTFRHrWt7fVmu66
         tHwRFPCvr4ZqnIx2lNg0W9LIV9g47xxLgf38eMw0uZFYDjb9fu0oFQ6ejm2EXXdiZOET
         Cyxnbl3AEq6Pmab/puk3BTlZ9HedKAAAt2flBlZH1sDnKuKkUnM3u4NadMoXyr8gDUsJ
         JV+/HUm6TJoy9UnkWb9L2GIi7I6FFNS3+gX7pYRalj0DGXdvjBBj4oaPl+RhFoZDMopf
         r77uAPNNuP09g8K/b9HaM7DcgtKqRvFXVtGqb0o99KDTmZTOLVUB5vyCvi2jBaF4vYpv
         VogQ==
X-Forwarded-Encrypted: i=1; AJvYcCXtt/u5yTY4a1Zkn0h7qZOV9Ago1vOujE+r8kHhH98PvJfNELi4aaGWDTMeMSbnSqHEd+RfoUJADbzJMn8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJSjxT1aASvMD2E+fEntTMix+kkZ2x9fHlxDA1UJm4y15nGj/D
	I/dSTGZK2flS66BlKwiOl3McUiCiqjbq+nq9EPCuWZEko7imllGndeO9YP2FafO7oJtD8ma9AF4
	PtIXMzfTGSfCmjvPgb37hBxopeOeq0Adfo3yGsQ==
X-Google-Smtp-Source: AGHT+IHzHnh2t8tBQh2OqqO4K8t3vawm7ioO3DOfIUjak2j1vhsztsO4wnHohPq9SAobtbyK7fReugFq5+trJ3DSDh4=
X-Received: by 2002:a17:90b:3906:b0:2cf:fe5d:ea0f with SMTP id
 98e67ed59e1d1-2d4056a06c7mr8591910a91.22.1724071858250; Mon, 19 Aug 2024
 05:50:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240727102732.960974693@infradead.org> <20240727105030.514088302@infradead.org>
 <xhsmh7ccky4mr.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
 <20240813221806.GB10328@noisy.programming.kicks-ass.net> <CAKfTPtBD3iyR3XSssQDAU=vkPs70tZLukvbwPYpnSv63ra_-Ew@mail.gmail.com>
 <20240817230636.GB20319@noisy.programming.kicks-ass.net>
In-Reply-To: <20240817230636.GB20319@noisy.programming.kicks-ass.net>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Mon, 19 Aug 2024 14:50:47 +0200
Message-ID: <CAKfTPtAVibNv0Uuez6xk3U6nUG3yV0p6A5ToLfpT6yv-F4qgyQ@mail.gmail.com>
Subject: Re: [PATCH 19/24] sched/eevdf: Fixup PELT vs DELAYED_DEQUEUE
To: Peter Zijlstra <peterz@infradead.org>
Cc: Valentin Schneider <vschneid@redhat.com>, mingo@redhat.com, juri.lelli@redhat.com, 
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com, 
	mgorman@suse.de, linux-kernel@vger.kernel.org, kprateek.nayak@amd.com, 
	wuyun.abel@bytedance.com, youssefesmat@chromium.org, tglx@linutronix.de, 
	efault@gmx.de
Content-Type: text/plain; charset="UTF-8"

On Sun, 18 Aug 2024 at 01:06, Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Wed, Aug 14, 2024 at 02:59:00PM +0200, Vincent Guittot wrote:
>
> > > So the whole reason to keep then enqueued is so that they can continue
> > > to compete for vruntime, and vruntime is load based. So it would be very
> > > weird to remove them from load.
> >
> > We only use the weight to update vruntime, not the load. The load is
> > used to balance tasks between cpus and if we keep a "delayed" dequeued
> > task in the load, we will artificially inflate the load_avg on this rq
>
> So far load has been a direct sum of all weight. Additionally, we delay

it has been the sum of all runnable tasks but delayed tasks are not
runnable anymore. The task stays "enqueued" only to help clearing its
lag

> until a task gets picked again, migrating tasks to other CPUs will
> expedite this condition.
>
> Anyway, at the moment I don't have strong evidence either which way, and
> the above argument seem to suggest not changing things for now.
>
> We can always re-evaluate.

