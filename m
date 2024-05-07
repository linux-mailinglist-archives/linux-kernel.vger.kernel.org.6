Return-Path: <linux-kernel+bounces-171469-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7D458BE4B8
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 15:52:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 265E71C24358
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 13:52:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53D1415E7EE;
	Tue,  7 May 2024 13:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QmD0p47D"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30C6A15E5D2
	for <linux-kernel@vger.kernel.org>; Tue,  7 May 2024 13:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715089856; cv=none; b=Q2/zHsxoLJSDLQ6UcOGh94o7onCsfm4mLZZ5lea2FJ7flkZOvxq3Y8ykntlQkF0TytbaL8yqGKcmbYXrKB+RolkKQUvaGhF7k2QSUhR+rnRRAdJGaBzkgcCDo6whz45WHKCSnv5e1jr3YhbVStx1EFYmRsoUYKEtjdHwwmvhvlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715089856; c=relaxed/simple;
	bh=TIJT24/Y/Kk/+RWnfVxsYYSG3i19tMA8dCXENC479kk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=AApEq/zgpLJZfQqRhysywEgB0c3EJQzY2M90tAXP64m9w+klz6ubxEwWoZVJLLCdrHVTiNqrm+NSVicUuv+wnWjfLMFZy7t3ixw5mhX80HQSz9rORU9FPEYw6wSCaVF38EfOJNVDJT3D3uScc/hpXOhmJkq1oIiCu2rBnyOXsC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QmD0p47D; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1715089854;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xTODE9eHYN04ukhQbjsh3NfbLHwJO8ke2b2LYl5imOw=;
	b=QmD0p47DDS36/tfeC5lWnhS7wPjlFyFUuQuyQ1PUICB+0jCs5kc2Ebd7/bxnWYz0VFU+W4
	CJ37UVS/Ci04hPYRuogNRpXfQ9385roCkttFjGzylYiZFArnv1g6XT2s0ohFbb9jyng0hH
	IYE14Semdk4ryGT7QMn8Ia+LOaAUoqg=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-621-dX8X3nD6PhiqEpoAJTwV_g-1; Tue, 07 May 2024 09:50:52 -0400
X-MC-Unique: dX8X3nD6PhiqEpoAJTwV_g-1
Received: by mail-lf1-f71.google.com with SMTP id 2adb3069b0e04-51f90454688so2568625e87.3
        for <linux-kernel@vger.kernel.org>; Tue, 07 May 2024 06:50:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715089851; x=1715694651;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xTODE9eHYN04ukhQbjsh3NfbLHwJO8ke2b2LYl5imOw=;
        b=ncLbk+9lp7B8TwvsrxQzsYNzmTXP9DLpb2cIzDqhKgzHiuzUhwZ2jyak2+Xvy4qEOz
         llp29vDxmB0vvavDjxrEl0zRFilEkmRV4ZZC+3Ue1z3y8/c4je+t9kGW0p6KXcUZSV12
         HKwl+BMuphrhwezMIvC/UCl2NpnoYbnf8l/BrykstbVSv7P3Ekjln6W1bwSdyQFK1Hdl
         yspeZAgwlmZbnLI/RNGtKV9GzgJ5upjUQN3lYPQwfwa5P3Zmgtao6chnGcBHgTCoA8/6
         e0lpjP7YJr8W2pre+Cv1c6NJwXPiLgMINVEgcv3Ebhz79NayQ+T++csyHLv+O+QlQ3ZQ
         Fa+w==
X-Gm-Message-State: AOJu0YyoBJYZx+026erVnCrr0fPNdeYW9HvWSVWAhyqN2qyvd/a5eEMz
	QpCEPSHz4nS2oLu/D66HADB2iEpwQjU0jsDK79RxSOwJ+hbrz5jY/PSTOajxHxjxcCrL+RY8XLq
	f+9f20NgqyX8/LWEqpwRf1kyupu7WyeG3wq/VxgDK5HMYo5gWoW7yUNFySmQVLA==
X-Received: by 2002:a05:6512:1588:b0:518:b283:1078 with SMTP id bp8-20020a056512158800b00518b2831078mr14091445lfb.26.1715089851188;
        Tue, 07 May 2024 06:50:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHv9UwS+EKurT0TjqicSwHazMqzSvX4nL5tG19yPraKVt7fxXPC1+UwQnvq4wdl4VKNZqfd2w==
X-Received: by 2002:a05:6512:1588:b0:518:b283:1078 with SMTP id bp8-20020a056512158800b00518b2831078mr14091422lfb.26.1715089850709;
        Tue, 07 May 2024 06:50:50 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id ek10-20020a056402370a00b00572033ec969sm6344723edb.60.2024.05.07.06.50.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 May 2024 06:50:50 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 6C3FE1275DC8; Tue, 07 May 2024 15:50:49 +0200 (CEST)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, "David S. Miller"
 <davem@davemloft.net>, Boqun Feng <boqun.feng@gmail.com>, Daniel Borkmann
 <daniel@iogearbox.net>, Eric Dumazet <edumazet@google.com>, Frederic
 Weisbecker <frederic@kernel.org>, Ingo Molnar <mingo@redhat.com>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Peter
 Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>,
 Waiman Long <longman@redhat.com>, Will Deacon <will@kernel.org>, Alexei
 Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, Eduard
 Zingerman <eddyz87@gmail.com>, Hao Luo <haoluo@google.com>, Jesper
 Dangaard Brouer <hawk@kernel.org>, Jiri Olsa <jolsa@kernel.org>, John
 Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 Stanislav Fomichev <sdf@google.com>, Yonghong Song
 <yonghong.song@linux.dev>, bpf@vger.kernel.org
Subject: Re: [PATCH net-next 14/15] net: Reference bpf_redirect_info via
 task_struct on PREEMPT_RT.
In-Reply-To: <20240507105731.bjCHl0YH@linutronix.de>
References: <20240503182957.1042122-1-bigeasy@linutronix.de>
 <20240503182957.1042122-15-bigeasy@linutronix.de> <87y18mohhp.fsf@toke.dk>
 <20240507105731.bjCHl0YH@linutronix.de>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Tue, 07 May 2024 15:50:49 +0200
Message-ID: <874jb9ohmu.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Sebastian Andrzej Siewior <bigeasy@linutronix.de> writes:

>> > +static inline struct bpf_redirect_info *bpf_net_ctx_get_ri(void)
>> > +{
>> > +	struct bpf_net_context *bpf_net_ctx = bpf_net_ctx_get();
>> > +
>> > +	if (!bpf_net_ctx)
>> > +		return NULL;
>> 
>> ... do we really need all the NULL checks?
>> 
>> (not just here, but in the code below as well).
>> 
>> I'm a little concerned that we are introducing a bunch of new branches
>> in the XDP hot path. Which is also why I'm asking for benchmarks :)
>
> We could hide the WARN behind CONFIG_DEBUG_NET. The only purpose is to
> see the backtrace where the context is missing. Having just an error
> somewhere will make it difficult to track.
>
> The NULL check is to avoid a crash if the context is missing. You could
> argue that this should be noticed in development and never hit
> production. If so, then we get the backtrace from NULL-pointer
> dereference and don't need the checks and WARN.

Yup, this (relying on the NULL deref) SGTM :)

-Toke


