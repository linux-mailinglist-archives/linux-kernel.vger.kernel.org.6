Return-Path: <linux-kernel+bounces-180651-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 95A078C7158
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 07:30:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 35ABF1F240E4
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 05:30:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5185519BA6;
	Thu, 16 May 2024 05:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YTiVap5v"
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3988D11721
	for <linux-kernel@vger.kernel.org>; Thu, 16 May 2024 05:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715837405; cv=none; b=dhJTu8oBSGskAr+6rTfDWSqz9Yuq99sLk1Y9QQFw/hcktWvX66L+tA0ijdojZm6rpGbQsQhAN7vOx32jreAvuzYgv/z9rSJD5+kWLvBGVrCKE3Kbvyg6u8LGMP71DSK28qJY2uh4gLXSGw1gYlijAm6ArtGjO2I0om1kZne96IQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715837405; c=relaxed/simple;
	bh=eKDCkK0DTfyfj/pWYUGq+fxwyQbBNz24825IBhsCjzs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bbkYdT+xFZUDZaC+dl9XCAyW3/BvX6fjFT5KcfzUnjKbzaL+KGKR/l/nSc5L6n0jvlTR3ZKN4cdQ/hnvqhqlwlm8PmBKdCT36nQdGcqTpMt+NFt+oQ9sOstJImmOhot7a67KJjogbuYKtZZGBd2sZStqffjHDwhTIUuB7xOd8qw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YTiVap5v; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-43e1d15a46eso23981871cf.0
        for <linux-kernel@vger.kernel.org>; Wed, 15 May 2024 22:30:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715837403; x=1716442203; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=BVGQozMvMz8miufFeIIHtZzqcvz+Cbv+dMVS9WyG6rc=;
        b=YTiVap5veGBGagG6N1B+CjCQr4g8q5ObpyeUOIymbJ2pkjuUNNSB/x3tB8df8USOW4
         zn0/eMCE1BB7zDGDDtq7WNBBHrJVhx3ZXXFysBtIbhZfdhMYZukKpOkNuMNYbqDtYFFm
         bUALHIUujLBmwlwL3CPQBHFPLzMhnb2zSzjSndTCfXW4tE0yDTNS7YdyUjkmGqoxHglE
         qTjhoffoheVZKr7DtfyYb6xMaQL6z/O5hFrYMDMtAlXvn78JT8QUSYmrdwzik2bfsGKv
         mivk+XtZYAbSBNwokwNE1eqVXcG20+8C0VTHgzrbsK+tvEcykzxJDr7pZbgqc72obEjo
         zuug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715837403; x=1716442203;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BVGQozMvMz8miufFeIIHtZzqcvz+Cbv+dMVS9WyG6rc=;
        b=UgkmN0XtzISl/+tqCwq3skE8uqY0LkGilnJS4eDHfcmjW4WYi8Hb2PiRVJgGDBYgDy
         VHipE2dvQp6ZPDLJkhUZFtGYnGXrKBRmpyQLEG9ttkQRsSTLUu1xmQQ182zaD5n1WwwX
         Ul0xKg/iKALxF1qDGtnM2rJ8k/P2BoBcvDv0C0dN14wnGOIAx8MWUvlav3YIfirzZITD
         04dpa9zooRB9ZRqalm1eDrqqrlV3SA36C0aDblUHj847F9fYDdLCuit+NvFuHuOEBN3D
         uXpxjnyTRSlaofrbXJXg89pInoRsR1+zYCbfghGP9e/4kjWBa4B2zivBOizRlIl0hQ9B
         dHWA==
X-Forwarded-Encrypted: i=1; AJvYcCWYAypBT9roQwKNKYAPqizmQYdZkpnDszXLT5p7a1LWmtBjXpgxW3OGpsILyIjrtuuyhps9txd2WmiGp/ysB+21C6rjtPF4RN2RD7NG
X-Gm-Message-State: AOJu0YyhiSxiG4BSNYIpoQtSAoMjt0PRy6/waPXJn3bCcvME4DqZvfCU
	4Ulut7/JgXp963nzq2s9tUW+2p4viIAwVlnBT4LQsqbDQ7wJ/9e+lcHQaXxboPjF6Z6l3rZemKP
	JP/1vw1RLXPe1ATmDGC2uDjJLzbs=
X-Google-Smtp-Source: AGHT+IF+S5LF+4rA+mIWgKMIwCm+IWdHCA+fS+XqkD1fxg+9tyjT+de2hQwvq3ogy07EABAAn59+kyAGSMEXRyLSUrQ=
X-Received: by 2002:ac8:7f0a:0:b0:43d:f8a0:5802 with SMTP id
 d75a77b69052e-43dfdb72db3mr228880131cf.63.1715837402980; Wed, 15 May 2024
 22:30:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240508172621.30069-1-ppbuk5246@gmail.com> <20240509092931.35209-2-ppbuk5246@gmail.com>
 <ZkU8lm2tjm_r9FpZ@pavilion.home>
In-Reply-To: <ZkU8lm2tjm_r9FpZ@pavilion.home>
From: Yun Levi <ppbuk5246@gmail.com>
Date: Thu, 16 May 2024 06:29:51 +0100
Message-ID: <CAM7-yPToeHY_8vjE7KSa+jmsfmCknUAL2WP8m-S3EpD52-wGCA@mail.gmail.com>
Subject: Re: [PATCH v4] time/tick-sched: idle load balancing when nohz_full
 cpu becomes idle.
To: Frederic Weisbecker <frederic@kernel.org>
Cc: Joel Fernandes <joel@joelfernandes.org>, Vineeth Pillai <vineeth@bitbyteword.org>, 
	Vincent Guittot <vincent.guittot@linaro.org>, Peter Zijlstra <peterz@infradead.org>, 
	Dietmar Eggemann <dietmar.eggemann@arm.com>, anna-maria@linutronix.de, mingo@kernel.org, 
	tglx@linutronix.de, Markus.Elfring@web.de, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

HI. Frederic!

Thanks for your reply.

> 1) Is Idle load balancing actually relevant for nohz_full? HK_TYPE_MISC already
>    prevent those CPUs from becoming idle load balancer. They can still be
>    targets for load balancing but nohz_full CPUs are supposed to run only one
>    task.

I'm not sure nohz_full cpu is really relevant with Idle load balancing.
However, I couldn't find any reason it shouldn't participate Idle load
balancing.
And about HK_TYPE_MISC, this is half true when it sets with
"nohz_full=" options,
if nohz_full cpu is set via "isolcpus=nohz," it's still in HK_TYPE_MISC mask
so find_ilb() doesn't prevent entering idle load balance.

> 2) This is related to previous point: HK_TYPE_SCHED is never activated. It would
>    prevent the CPU from even beeing part of idle load balancing. Should we
>    remove it or plug it?

IMHO,  If we want to prevent nohz_full cpu entering, I should set with
HK_TYPE_TICK | HK_TYPE_SCHED together.
Because, find_new_ilb()'s comment say
" HK_TYPE_MISC CPUs are used for this task, because HK_TYPE_SCHED is
not set anywhere yet."
or integrate with HK_TYPE_TICK....? removing HK_TYPE_SCHED in the hk list...

It depends on ilb relevant for nohz_full...
If it is, Idle load balance could be controlled with HK_TYPE_SCHED.
If it doesn't ,IMHO, It seems better to remove HK_TYPE_SCHED and check
with HK_TYPE_SCHED.

> 4) Why is nohz_balance_exit_idle() called from the tick and not from the idle
>    exit path? Is it to avoid overhead?

> I'm adding some scheduler people in Cc who might help answer some of those
> questions.
..

Thanks :)

