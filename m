Return-Path: <linux-kernel+bounces-181047-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 101A78C76C2
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 14:44:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B78281F21DA8
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 12:44:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 062FF145FF9;
	Thu, 16 May 2024 12:44:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JTMEdYqI"
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E58BD335B5
	for <linux-kernel@vger.kernel.org>; Thu, 16 May 2024 12:44:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715863443; cv=none; b=swJgpIAXXX4BFTSVNUhjgESmZhSikbV3HwYTN9w+IIPxSH3FojLzTy2qn6bA5UhIqX05HqrL9xt0/7m0FP7cH2dqxzUEzlPTgoJrzLQp2f9Nx8xoLNSmok0v8qWR4voLjwQLhrWaoCtNd+10CSFxdReOCxFHLN5x8+ukKPFFqa4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715863443; c=relaxed/simple;
	bh=ZE+ZF476CDghs+ffsIPZ9mw9R4UOZsjwNbsbIKcpz1w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Bk69xYSHz3uhy8c9pn93GVIcs9axQkpMQT57dZJvoMzx20mkSAqQ89eSS8VpBL20080Cnez9ikm52kK+S8xfJqYEe07Nq3ZMExPnuf1UPtqZv3ZFpn0ttnLY6T0U/ELRRBBG6ja8x0xy18LsL1gzqGtUx8WmGWdTQRv3/d0cOic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JTMEdYqI; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-61df496df01so65786697b3.3
        for <linux-kernel@vger.kernel.org>; Thu, 16 May 2024 05:44:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715863441; x=1716468241; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=EymfovAPaOqIf8lLoq7gmRWeAEinSnJKTksVAj9AZKo=;
        b=JTMEdYqIougv3WeyatidM6S2Yye56KbE+YFYNjB3QPhMIQGZ2ZK6N3ox82q3fJRUIG
         QpCgW8DTKsAwrkzKsWH92J2zpLISpSfWl6KGG8uo/xT19IPZLvCdFsMkmkpW6w0flC1X
         ZmK9X91GF2QwCPwtfhk4ikACw7QoZ8ObarcX49SRPeWzGzspifCGqiIojHY3bFq3Crdf
         44bOsc20ZD4WCjFn4xVAdU2pDOZT3LrMphCjbJAMhmIuREWmnpWJRfrnGSjF0F82X5mo
         CUwbJ2XJrcDKbziJQcW0Kk4vFtdCIERF79LUV303Y51xCaFDLN4av+O4B2mZy1p9DZTa
         TEqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715863441; x=1716468241;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EymfovAPaOqIf8lLoq7gmRWeAEinSnJKTksVAj9AZKo=;
        b=Nl7xcrMcVHxR3hJwR2XT8qVs7O7drhKnSouhk8Sx6rj+/34jWyXs7/mEp0b6m87iC1
         n3o7nKyD06186m8IDsapY/GA5CyFgyFtAk2J0b2D3kzD/+Iqlj130qSQs9cIgnkpsbJA
         O0uVQuuKyPZoDyvX8EnLm2CeWJokB6TjvFmCjDJLMyjcRI4A+XGSNk2XGle8ltBKZrG+
         Y2XCbuLwyr1BWy3FVh3O9dWfi4N7yEw/Zp7Teesn1JR3hvFKwCvSsolIfUvOrWfmAY8T
         rT1iUP0SW4DoXkjOvvlgQGUx1IEgM3EUI1hoP9N+oQ9+3E7gHlMSnjXMIB1qFiXPI8dn
         onFg==
X-Forwarded-Encrypted: i=1; AJvYcCVXYtUS0TgBM6UpzZ8uOfhTCbhB3UWc55kfcFvUKaEr7My3zMFZTU/YAPD+u80OUwZLvv1oWyIUk0UPCu8Ffz6s0fbP1qGrPtKKRdQ0
X-Gm-Message-State: AOJu0YzBYORfr48p3q3OBEz1DJB63SeMfgM7YNJYGYadFGpT/zdq0LJ7
	8aQ6obbtwDrWuKse5yCsBSL3qoM8kmCW8p2Im6nqWymBJ1sb+Wtqx/MeYZfCwcux2eAYhNh+LJ9
	Um/IoRdG0+V8RmlERpblvC3dpi1I=
X-Google-Smtp-Source: AGHT+IHrI4jUCBjRCHqP9QayOPeWRyo8ofuG56YrsuCTAfjHbvJRAr755l0rsEWgiQEQUHsbKKLr3SoU5r7UWiIXUck=
X-Received: by 2002:a81:6d05:0:b0:611:26e0:f24b with SMTP id
 00721157ae682-622aff3c05emr181789987b3.9.1715863440861; Thu, 16 May 2024
 05:44:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240508172621.30069-1-ppbuk5246@gmail.com> <20240509092931.35209-2-ppbuk5246@gmail.com>
 <ZkU8lm2tjm_r9FpZ@pavilion.home> <20240516075628.GC22557@noisy.programming.kicks-ass.net>
 <CAM7-yPRHp3tiZjuBTesdRQoU8WJNg1scon_txS_6R-pZq9MXHw@mail.gmail.com>
 <20240516084911.GF22557@noisy.programming.kicks-ass.net> <ZkXtHv+fHUD2+lFJ@lothringen>
In-Reply-To: <ZkXtHv+fHUD2+lFJ@lothringen>
From: Yun Levi <ppbuk5246@gmail.com>
Date: Thu, 16 May 2024 13:43:49 +0100
Message-ID: <CAM7-yPTSq0CSmRsTpeXwzhFk77gfwUK_LZKnbgo4NPk5zPCaAg@mail.gmail.com>
Subject: Re: [PATCH v4] time/tick-sched: idle load balancing when nohz_full
 cpu becomes idle.
To: Frederic Weisbecker <frederic@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Joel Fernandes <joel@joelfernandes.org>, 
	Vineeth Pillai <vineeth@bitbyteword.org>, Vincent Guittot <vincent.guittot@linaro.org>, 
	Dietmar Eggemann <dietmar.eggemann@arm.com>, anna-maria@linutronix.de, mingo@kernel.org, 
	tglx@linutronix.de, Markus.Elfring@web.de, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> > > > As such, I don't think the HK_TYPE_SCHED check in
> > > > nohz_balance_enter_idle() actually makes sense, the on_null_omain()
> > > > check a little below that should already take care of things, no?
> > >
> > > IIUC,
> > > currently, whether cpu belongs on domain or null is determined by
> > > HK_DOMAIN_FLAGS
> >
> > No! you can create NULL domains without any of the HK nonsense. Both
> > isolcpus and cpusets can create single CPU partitions.

Yes. However what I said, nohz_full cpu isn't on null_domain
unless it was configured by cpusets.
even with option "nohz_full="

> > > However, when "nohz_full=" is used, it still on HK_DOMAIN, so it
> > > belongs to sched_domain
> > > so, it couldn't be filtered out by on_null_domain().
> > >
> > > unless "isolcpus=domain" or "isolcpus={cpu_list}", it's on null domain.
> > > with "isolcpus=tick", it participates sched_domain.
> >
> > Frederic ?!? You can use nohz_full without isolcpus? That makes no
> > sense. If you do that you get to keep the pieces.
>
> I fear you can yes, even though most users combine it with isolcpus. I
> know, that interface is terrible but it dates from times when we weren't
> sure about all the potential usecases of nohz_full. There was a possibility
> that HPC could just want to reduce ticks without all the hard and costly
> isolation around. But all the usecases I have witnessed so far in ten years
> involved wanting 0 noise after all...


If I make you annoyed I'm sorry in advance but let me clarify please.

1. In case of none-HK-TICK-housekeeping cpu (a.k.a nohz_full cpu),
    It should be on the null_domain. right?

2. If (1) is true, when none-HK-TICK is set, should it set none-HK-DOMAIN
    to prevent on any sched_domain (cpusets filter out none-HK-DOMAIN cpu)?

3. If (1) is true, Is HK_SCHED still necessary? There seems to be no use case
    and the check for this can be replaced by on_null_domain().

Many thanks!

