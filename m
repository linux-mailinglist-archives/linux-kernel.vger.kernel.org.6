Return-Path: <linux-kernel+bounces-546266-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 64DF5A4F88B
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 09:17:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A98F218915BC
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 08:18:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 938831F8677;
	Wed,  5 Mar 2025 08:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lEOTnVJJ"
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32A8B1F4720
	for <linux-kernel@vger.kernel.org>; Wed,  5 Mar 2025 08:17:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741162664; cv=none; b=pmdroII/ypDw3UC+xiVgeHj++1CelJ5kUAnIc2kj/OZfkVW/yZHkkNd+KbjOteMPtHNYPhjoeXraVzF6Nxb2gB4OUNDpuVHIMwjT/Wmf6oy1KYuEvOLcNsmL9CxAIjDLZWVfSrw1+OqWNzIpg1RafMQur/ZUTmFpQo7uGRACmwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741162664; c=relaxed/simple;
	bh=vcGEIoc9wmDs79ktQAByYkrcB1clkMgF+0QKb1CD3bE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dq+KYnIM3Gfbb3qiJwza8zeOoTi1jY4iN6zodICbhil0cNF+7eopHU6j6pZij4KDuC4OvXSVepOavjd64iziMXm1ZHe9pk9EpyfiZIT34F5jc0ZdtFNcGiiwCZ8jgoCm06q3yn5HVdZzoILWCb3CXSSBJQh5oAqHxB9fd5MA0gA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=lEOTnVJJ; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-abf628d653eso560741166b.0
        for <linux-kernel@vger.kernel.org>; Wed, 05 Mar 2025 00:17:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741162660; x=1741767460; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vcGEIoc9wmDs79ktQAByYkrcB1clkMgF+0QKb1CD3bE=;
        b=lEOTnVJJ4JT7hVtbcV/cOW6oiBDHVoltJeerSZhHmZ38u9u432NciyIZ0EJkWpmkQA
         HFi3WHkiHUZ3nBpMlMRgvPrHTq9TprRUIiNYWOqPBUUqh6JOQQ0BOelnrvKeXXpLlN7b
         u+56pO9PTSBA0ic79zvLSPHKnsaMAs5It5n9ex7Dgxsp6grgVTJWU9vzeHnnsV4cZI8M
         EG93gjWHHwCEt6UW0XlQlc5W2UZLwkjQuNiQA2aOctBhm37dqtm3Dzk3ywC73o5qgdvA
         l34FJcFvdYasgEXsG30ttougTc8WtEF0ftSAY14Pp/wOXMmFTQdB1ksMH6LB8y1Y0j4b
         W1KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741162660; x=1741767460;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vcGEIoc9wmDs79ktQAByYkrcB1clkMgF+0QKb1CD3bE=;
        b=MXBcfwH5roLx/kdwCwcN1Nqh4MTiaVrf3mlA0ni4hU7qND4sJC+yz7bHiN1z9jmNVR
         EEN1Uo923zndUlslmo79hyFMPpqpp6di/0URWpSScFpYSdIyhfW9yTtFyvVmdNMnf1Z+
         7DYmKeozPgtDh3fnAc8lCyt4wBHXMnZusAhEaoGcIiPMlksJR8p4mjfIIcjmnclXM8uj
         H0kJJEApOmekcZ2F4lYY4vqJnG4ajnhwkZrT3VldFVOOePu9XMonRVgZ/SSDRCGoxL49
         LgkswBhNwEDXapSZ2e3c51SbSZDZbSt9OyqBi0Vymz/Fz/PRe7IF4MpacGmOuyo/U4It
         14GA==
X-Forwarded-Encrypted: i=1; AJvYcCXWLIM0HO6A/RRHtA7pNDt3Q8jLS6zCxfwvnDQTEvi6T9bt7k0WZ3uHXc751lh0s2RtdAM9HlrAoL0+qCY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxEKggJRQbx+QFLQBZIi3c+/wKUfDk0RX8YGQM/OzGyOsSJmC/z
	IJXdiiuuU8d9xA89/o4BOeRTljORVwimvNNkOQQjcE6wfiANyjR5MCfOjI6msKYqdXzIvSryGWv
	JC3u8SA96qOfWz5X0O9FiWMAEzCnjUEro5OuWAA==
X-Gm-Gg: ASbGnctV9oLN/bQnDpphaerWHaV3dgDN1bU1ByOiGQv792jUu0rCuCB9guNpnOZRF/n
	rXOl8x5cQR4mTJDfgorcWgb7vwNFYW9wF+beYXz1zYH0E6cYRutCzGUy6SsAwmbHB8d4G66abg3
	nIJiYCeCGMSSUM04Qj+gXwcwW+ZCfjtqpU5kI1/98S0EHtc8MfqCqcCjU=
X-Google-Smtp-Source: AGHT+IEwZ0V5j3sfTjf4uAsJrKtaGmo6/U3Ly5JasGKZTobPzrL9CMjyuO0uUfW8rk1IdcKtFLT5R5LYh+TMgFOTlKQ=
X-Received: by 2002:a17:906:478f:b0:abf:6f87:670e with SMTP id
 a640c23a62f3a-ac20d8c833cmr176738166b.22.1741162660345; Wed, 05 Mar 2025
 00:17:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250303105241.17251-1-xuewen.yan@unisoc.com> <20250303120021.GA11590@noisy.programming.kicks-ass.net>
 <CAB8ipk-pmSGoaxtMGhcvn7MmSEibvQDbCDgjp9iEDTzG5=_L7g@mail.gmail.com>
In-Reply-To: <CAB8ipk-pmSGoaxtMGhcvn7MmSEibvQDbCDgjp9iEDTzG5=_L7g@mail.gmail.com>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Wed, 5 Mar 2025 09:17:28 +0100
X-Gm-Features: AQ5f1Jrs6iZ7BhBSuUeLE4Rx-MSwcPVFCqJAcOSm5AMzjIeeAWygEAU7LH-nobg
Message-ID: <CAKfTPtBahSErKvd5y698v7+EZYGkT95dbO0LumZAWD=ut1vj3Q@mail.gmail.com>
Subject: Re: [RFC PATCH V2 0/3] sched/fair: Fix nr-running vs delayed-dequeue
To: Xuewen Yan <xuewen.yan94@gmail.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Xuewen Yan <xuewen.yan@unisoc.com>, mingo@redhat.com, 
	juri.lelli@redhat.com, dietmar.eggemann@arm.com, rostedt@goodmis.org, 
	bsegall@google.com, mgorman@suse.de, vschneid@redhat.com, 
	linux-kernel@vger.kernel.org, ke.wang@unisoc.com, di.shen@unisoc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 4 Mar 2025 at 02:56, Xuewen Yan <xuewen.yan94@gmail.com> wrote:
>
> Hi Peter
>
> On Mon, Mar 3, 2025 at 8:00=E2=80=AFPM Peter Zijlstra <peterz@infradead.o=
rg> wrote:
> >
> > On Mon, Mar 03, 2025 at 06:52:38PM +0800, Xuewen Yan wrote:
> > > Delayed dequeued feature keeps a sleeping sched_entitiy enqueued unti=
l its
> > > lag has elapsed. As a result, it stays also visible in rq->nr_running=
.
> > > However, sometimes when using nr-running, we should not consider
> > > sched-delayed tasks.
> > > This serie fixes those by adding a helper function which return the
> > > number of sched-delayed tasks. And when we should get the real runnab=
le
> > > tasks, we sub the nr-delayed tasks.
> > >
> >
> > Is there an actual performance improvement? Because when a runqueue
> > looses competition, delayed tasks very quickly dissipate.
>
> At the moment, I don't have very detailed test data. I've been
> studying delay-dequeue carefully recently, and these are the issues I
> feel might need modification as I go through the code.

Patch 1 makes sense for me but I'm less convinced by patch 2 and 3. As
Peter also mentioned, the state where cpu_rq(cpu)->nr_running =3D=3D
cfs_h_nr_delayed(cpu_rq(cpu)) is really transient as they will be
picked as soon as the last runnable task will be dequeued

>
> Thanks!
>
> BR

