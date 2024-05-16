Return-Path: <linux-kernel+bounces-181302-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C6628C7A22
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 18:12:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3DD551C22698
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 16:12:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27D2914D71E;
	Thu, 16 May 2024 16:12:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QQz9+USn"
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EC8614D707
	for <linux-kernel@vger.kernel.org>; Thu, 16 May 2024 16:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715875967; cv=none; b=f3b1MQ39E1n6UjPLw1+yRZ+DwmYgDpz8Obd8XOAMNHGFCMyFAElDfDiKPDB2Aq1OoshIccaAyEEbxDPYC/WEwm4eX8Rays3q2ZCOtNbuhYDf7aQgyE0tYY2EJvoVGhOGwZItDMU+vz7l6j00ntyucgVqfr0966DchpKrvcnvVJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715875967; c=relaxed/simple;
	bh=EDVDStN9akIll0ya820KZNeIn7ir4olgOtXijBH6aOg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tup+S8XS3O+VVF3QsXv+NoYJZVicyO9js13y3YCTmAhSDe9hF4MecUb4TdUVAZSnU1wLVHzZt1tQ3+LnzbkY7/aB/LSgej0iyXOoHYXIhBc/pSMjPkhIP4nWI6T2iPE/bzIeggp4lh/KA/YQ8llK7jTeXpvrtSdMu9qMVTVegno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QQz9+USn; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-43e1581e81cso31459781cf.3
        for <linux-kernel@vger.kernel.org>; Thu, 16 May 2024 09:12:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715875965; x=1716480765; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=EDVDStN9akIll0ya820KZNeIn7ir4olgOtXijBH6aOg=;
        b=QQz9+USnTDYFWNZgI5ivdSAACTsh/KANVCTKfAUvb8ou3ZMgq8UMHdkKlxvbl1KYCU
         4VRCY7BfWZST0A0K/DTZkxdekHb7sPlX6gcSTmNIjGkhAyfXvRmL0RfAlLCyCag9ip0Q
         jR1MEq9v5mQpoFV/cpTkrQNy7nHGuRw4KEFaE8oRZ9eDSfFSf7Y/oaaV8DIzqWpt5oiW
         LEZXU8nXTd4k/+mPxwqRoRhCmRdgPAX4rWX+CGRRBDP9Ne/07ZPg8r6X3+IrpkrRntML
         /BR71trOPmQEX1941Ky1+MligW8dMiOoXJxmESoRNJrd7tJzWkkZ5OdKuXD3hq/vO6Oq
         oPLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715875965; x=1716480765;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EDVDStN9akIll0ya820KZNeIn7ir4olgOtXijBH6aOg=;
        b=PlVIZfZ9BA4Ve7X6EiAe3llsrZlrTlGPTal0mdxs+qrMJQBSb9w9VvO7hcgdqtoM5n
         68KukHdCJ/OqX0gVTZp1mK204IBWsSSfZcirv+TMv+Moa7snJmtPMCGkbIjs9QJKcWKW
         dMG1qtWqpZ2naMVWqHlYcOm/LDfosj3fn0pH2tYLYX/KgPqUjMGkFx2v01PE2eLoFwbn
         8kxSLk7J3qudDh435y31u69GO6kwHc8oNuGcVjEm9wBtGDt/6ykZ9bSTFQ6BBMv72tlV
         1Hxadaf/gR9jOp15qs4H472nvyODrgSzh86uzowClFS/cAvzdDotC0cryUuJ7TzU9uev
         xYbA==
X-Forwarded-Encrypted: i=1; AJvYcCUYNR/4X5Rvo+t2mN6mH/MgQobovckuDUvPnxaPY9+uq32UDr3ZBd+S1T7GEQxqnLs0OPRD8ExjGXwxOa9wj1ECBk7voKer44BfF76C
X-Gm-Message-State: AOJu0YxSHYCBhwdf2FLj6AkaYkMvI96FJKtD8zeqVlf45ebeblZYDQvA
	0O6qhks9xfD3JsODhvAd30nJn3ORIUmDrZD51jJytFsMEr91KnATDOXviiDZX0TLDXFp6s+SjEm
	Wspwm5zuZXV82j08fusz1QSW1Kdk=
X-Google-Smtp-Source: AGHT+IFaEJ8GHCyu3non5YHI6ttPcdFCQtu47m9l4CWqBdVjbODGX809oQyAj1OqF4j3CWyKqDFe5cMvI7CnUOWr/ZY=
X-Received: by 2002:ac8:7c45:0:b0:43a:ffa5:3f24 with SMTP id
 d75a77b69052e-43dfdba9604mr246255961cf.58.1715875965116; Thu, 16 May 2024
 09:12:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240516075628.GC22557@noisy.programming.kicks-ass.net>
 <CAM7-yPRHp3tiZjuBTesdRQoU8WJNg1scon_txS_6R-pZq9MXHw@mail.gmail.com>
 <20240516084911.GF22557@noisy.programming.kicks-ass.net> <ZkXtHv+fHUD2+lFJ@lothringen>
 <CAM7-yPTSq0CSmRsTpeXwzhFk77gfwUK_LZKnbgo4NPk5zPCaAg@mail.gmail.com>
 <20240516140003.GJ22557@noisy.programming.kicks-ass.net> <ZkYW48dTX2FH5NaD@lothringen>
 <20240516144504.GL22557@noisy.programming.kicks-ass.net> <ZkYgG9KYMpUPeJsM@lothringen>
 <20240516151953.GM22557@noisy.programming.kicks-ass.net> <ZkYnKAd1Qy+yvjDY@lothringen>
In-Reply-To: <ZkYnKAd1Qy+yvjDY@lothringen>
From: Yun Levi <ppbuk5246@gmail.com>
Date: Thu, 16 May 2024 17:12:33 +0100
Message-ID: <CAM7-yPRjjCS7VDz5-X4Z5gBCymoCMxGc+okL7+2WZiHM7D0C_w@mail.gmail.com>
Subject: Re: [PATCH v4] time/tick-sched: idle load balancing when nohz_full
 cpu becomes idle.
To: Frederic Weisbecker <frederic@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Joel Fernandes <joel@joelfernandes.org>, 
	Vineeth Pillai <vineeth@bitbyteword.org>, Vincent Guittot <vincent.guittot@linaro.org>, 
	Dietmar Eggemann <dietmar.eggemann@arm.com>, anna-maria@linutronix.de, mingo@kernel.org, 
	tglx@linutronix.de, Markus.Elfring@web.de, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> > Yes, but stronger, as long as the CPU is part of a load-balance domain,
> > it must not disable the tick while running anything.
> >
> > that is, NOHZ_FULL must not become active unless it's running on a
> > single CPU partition.
>
> I like the idea but I'm afraid to introduce regressions while doing so,
> with people currently using nohz_full without proper partionning...

But I wonder when nohz_full cpu enters *idle".

If the cpuidle governor selects an idle state which wants "stop_tick",
If nohz_full cpu is still in sched domain, should it disable tick or not?

