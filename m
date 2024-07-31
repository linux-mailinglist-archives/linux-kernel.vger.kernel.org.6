Return-Path: <linux-kernel+bounces-268391-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FE8A942413
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 03:12:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7587BB20F5F
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 01:12:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 841348BFC;
	Wed, 31 Jul 2024 01:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eXagFdzv"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59CD5748F
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 01:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722388313; cv=none; b=GkxoVemip0sLE+Gms1QrhwYcomsn/wZTCnhLb118xinL7GoRyItX3lyJLrOQiTDUbBxplVmy0n4VyCBXc65UUbUHHI2G1K5a9If2msXJ24ESPasEjtm5dJNTi0EqBqWOPr+BmNJgzgyPOi1AQV7nfxAhDWuwysxB0NTobRQ2BCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722388313; c=relaxed/simple;
	bh=ikRvxobFRBm111pVVm0kPucSn1Ty9JxTz/n2K/u3tng=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sWZdIrnHgvsnAbDqZZRmrJpHK3drfuDXbZW3qasTzGZx0ejyR8Ts/+fNmmdi6q879jt2qhQ+MoiCYQYMtUqcB1tpdszQ7Zs1xSe6I40wJyEDSsDQ556z8SkqE0G4XfvUISvZ7QCLNCLbRDmuiPzhomIraA56l4BixQfWHQo5RRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eXagFdzv; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1fec34f94abso37671215ad.2
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 18:11:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722388311; x=1722993111; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kv/ffK3asL/lPpF8mddOqkl5o5NauV4qTRmHByxLaXk=;
        b=eXagFdzvY7hrszJp/jWW3IDlVeY6VF0xsLRxZJDEin4Iw+BK7VLcth9mF4cG7tG6be
         UQUl55zxHsHCYQ7AMAePuMWtKE17obzikTpaf0y4qdy9u/cBN8K6225Kcv5Pujn3eYk+
         GGOvj4TTNPIg4KS0IPZJC9b1ItrxM0FdABCYVXtExNka4sPYVZB9JkyNqSrcikQ0RFzQ
         Th24a61JAoC//MI+hKeUjZgMUJAKWIxKX8KtYDDOwb5ds3B0f+BwU3/hXbdAAZlgWQj3
         Q+1v3bpsRF+XYcfX3DIsk5b0wWlleSsDZj7zkKnasNJ1Rn4KuKfl4LEwRuRHQhY2VIJp
         lelg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722388311; x=1722993111;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kv/ffK3asL/lPpF8mddOqkl5o5NauV4qTRmHByxLaXk=;
        b=Thxhwu12mhCApe1vyUJDjAV4fqvhIa+aXf91V/aTmddYKdioqINNJg17dfPg5/P5ds
         BN9PPpXjkga/SsRi5us6MkViTSQzsWoJ3s/inCEFRW1/107upcHBTRLQmKgV/eOFkxB4
         ZqYeO/znpICgCwFoQ9CzItVfGZUutj3/X/DLy7sNbo2IoWC0j8MF8g9LN+XB8AhjMruD
         1BxiBmhzAhr46XEMG2wvHgOeRyijTn6ChO16x6I1H3Jn9M2sqNBiayVjRahxncI0aokd
         AmFzT4+JeYVFdCnFUhZ8Pw1W5kK7he/HYUM1kqJt7GqIEvrA6ZZPE1p/iRV2jkXxyxGE
         uHsw==
X-Forwarded-Encrypted: i=1; AJvYcCX9YTCeb+EviC2XdtcjIIhaU3csF8FNeE1EBPCqKA3Fpa7FOpHd9nvWrv5POPMlYcCRUxC9G3a9Iv+rFrSfF7aoY/R+P+XOHmIFSa2a
X-Gm-Message-State: AOJu0YzgiiiM2o7jPYgctHXOwNb933O2+seUFxHfCQUQRs3hf8PUod9w
	SW7WcF/rMRcnXdnRFBa44suGn5QZThK/tNgYBMu2pZgPON408kXGABR9Gg==
X-Google-Smtp-Source: AGHT+IFz9yQm1xq5n96Wlk01M+e3ii63OfaWp7kTO5EMeBCrlmGpabQxJNVHu2XAxSl/Q9NndC37fA==
X-Received: by 2002:a17:902:e805:b0:1fa:7e0:d69a with SMTP id d9443c01a7336-1ff048e228bmr110377905ad.46.1722388311490;
        Tue, 30 Jul 2024 18:11:51 -0700 (PDT)
Received: from localhost (dhcp-141-239-149-160.hawaiiantel.net. [141.239.149.160])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fed7ff072asm108063935ad.296.2024.07.30.18.11.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jul 2024 18:11:51 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date: Tue, 30 Jul 2024 15:11:49 -1000
From: Tejun Heo <tj@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Qais Yousef <qyousef@layalina.io>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	linux-kernel@vger.kernel.org, David Vernet <void@manifault.com>,
	Ingo Molnar <mingo@redhat.com>, Alexei Starovoitov <ast@kernel.org>,
	Vincent Guittot <vincent.guittot@linaro.org>
Subject: Re: [GIT PULL] sched_ext: Initial pull request for v6.11
Message-ID: <ZqmPVUw8htIwkvRb@slm.duckdns.org>
References: <ZpWjbCQPtuUcvo8r@slm.duckdns.org>
 <20240725011907.3f5ropfai3xoy3l3@airbuntu>
 <20240730090443.GI33588@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240730090443.GI33588@noisy.programming.kicks-ass.net>

Hello,

On Tue, Jul 30, 2024 at 11:04:43AM +0200, Peter Zijlstra wrote:
> >  #ifdef CONFIG_NO_HZ_COMMON
> > -static bool sugov_cpu_is_busy(struct sugov_cpu *sg_cpu)
> > +static bool sugov_hold_freq(struct sugov_cpu *sg_cpu)
> >  {
> > -	unsigned long idle_calls = tick_nohz_get_idle_calls_cpu(sg_cpu->cpu);
> > -	bool ret = idle_calls == sg_cpu->saved_idle_calls;
> > +	unsigned long idle_calls;
> > +	bool ret;
> > +
> > +	/*
> > +	 * The heuristics in this function is for the fair class. For SCX, the
> > +	 * performance target comes directly from the BPF scheduler. Let's just
> > +	 * follow it.
> > +	 */
> > +	if (scx_switched_all())
> > +		return false;
> 
> This one does seem really weird. It makes schedutil behave significantly
> different from the BPF pov depending on if you have this partial mode on
> or not.
> 
> So I would really like this to be reconsidered as I agree with Qais,
> things should be consistent.

I replied in the other thread and Vincent raised it too. To reiterate, when
switched_all(), if we want to keep accumulating util signal from the fair
class, we need to keep calling fair's update_blocked_averages() so that the
value can decay. We can but it seems silly to keep calling it to decay it to
zero when we know it's becoming and staying zero.

Thanks.

-- 
tejun

