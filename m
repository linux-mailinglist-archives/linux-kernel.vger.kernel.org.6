Return-Path: <linux-kernel+bounces-288347-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A723F953911
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 19:35:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C6DAD1C25255
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 17:35:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 177864D8C3;
	Thu, 15 Aug 2024 17:35:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="2fk/tckh"
Received: from mail-io1-f52.google.com (mail-io1-f52.google.com [209.85.166.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83883A5F
	for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2024 17:35:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723743343; cv=none; b=VG6kYiKImSoG1A7Rh9FIaONggYQir+xx4+E7zE3BdcC4OsuQVZKuSJ7Fe2xhDjNab1eZc9s+dzAtdOooCnqRo0kRPCrEeZ36xagxSq4fyprxCCriT9rJ5lllXGx7FEgTHaknyYwZfE/8JNX1CoJmOfZZZwzVfio1OHnXCEmdZB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723743343; c=relaxed/simple;
	bh=yTQ3x9UK8HBDNuDJlzJOqJNNTmm6uXlvMqRj0y1jNzU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NTCJZRM6G0FBCVQ5gCEgrbBTme8uCQ6cZeIVZUDVeiMw4C67R3eGKIthfav1zZHCFmM9htStCe63yxLS7Hu+PE8Ep7Y4rMM9zikUZjFd3mwnh1r2DtzottZK5uinzpCKZ1TAC6Lrm1sHvfdrOQZSmFlR7IdpmmZvqGZcpCpeu24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=2fk/tckh; arc=none smtp.client-ip=209.85.166.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f52.google.com with SMTP id ca18e2360f4ac-81f8d55c087so5434539f.2
        for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2024 10:35:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1723743341; x=1724348141; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2U1MzKHB39OLu5TW/dEOIFFTFZ/Iz79ypoKHI4vCvHs=;
        b=2fk/tckhwHrgEPxypfU57kGwGU79+ji1zWxkBnG+t2cczJnyCfZy2W4Ojwn4f0/U5d
         VM9DJIx0d5RN7w4CcgODgkQ18seVXLstHSfsAaQUZS5zw6gdQVr+xcbgCjqKKGKiNcAw
         V5fALKlo/YAEE8ho6hnBvhlYY2coj1fgdHzzwzxBokTNwTGTXCgu/WwJh0Eicsdlcuum
         wQ1nrNXo7Igvh42zh3LcplUcxH5V0gBzIYMHvVa0sI96Ok/iCwv1m97AjBujczK2UJ8Q
         xdICV1pLGQym7JPgWs14OXr8QPjZNKqPZhjgkfKL7rNkSdqVqv1WxnnyQh03ZPCYlkQw
         BsOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723743341; x=1724348141;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2U1MzKHB39OLu5TW/dEOIFFTFZ/Iz79ypoKHI4vCvHs=;
        b=CoBzd+ZgZ0vcTaap3+Our67pKV4wAXkFO/tYXD9int1B3C2OB25Gt03CLVCKsQp08I
         N5YpjvpKcWz2t+ZYxhJ6p01/67d6WXlDjSiofH+8IUBP4I67N/ZXM9q40WRTkHQdFZvj
         WFbkZpPslnua7AfC1SmDTitgZAkWoOerG5InEhAcMaIDI2fSAP5Od6FZy6JIYyS2xzIX
         s4Lg9b4DocpzzqSdN37qIYhJL7Diy4WNn71H/nRU1nCaSLHCkwU/c4wZM0BL1k52aN3g
         kD01UXGmA/fqXEFNpZNGW9IxlgfGenGGcaaKOvTflLEO6nZVcODKBSqY+7F6OuOnY1ad
         id4w==
X-Forwarded-Encrypted: i=1; AJvYcCXXzm8iOqmReF77U1yLMwuA+PUtWHCZv/LsOPEkCof/l9LwHbRI+v2So4CW0VjUYAbwvEVtE0w/OUFkAwL3P4WxOJx2bCW9BhEPoplF
X-Gm-Message-State: AOJu0Yyy09gZ1Ev3MyDeZgYzXsAFyVhIQGC/AoJIC/Z0eM/0t6u1KrmJ
	GyNyL0zn4xrRYAzFT42Onc4mdByIoOxPtB4XX8QdKjtt4AYyTiZVUVraBmuqKCo=
X-Google-Smtp-Source: AGHT+IE5ACwMUbOKC8B7NJcnH44RVQzKIjxHde1N8h+vFIG7O/NuCcv1jNns9/9MwYQlU/mxJD+4BA==
X-Received: by 2002:a5d:9f4d:0:b0:7f6:85d1:f81a with SMTP id ca18e2360f4ac-824f26e3004mr33789339f.2.1723743340509;
        Thu, 15 Aug 2024 10:35:40 -0700 (PDT)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4ccd6e9395csm617646173.38.2024.08.15.10.35.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Aug 2024 10:35:40 -0700 (PDT)
Message-ID: <8db12b3d-08f7-4c3e-a403-177285b0bcec@kernel.dk>
Date: Thu, 15 Aug 2024 11:35:38 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] softirq: remove parameter from action callback
To: Caleb Sander Mateos <csander@purestorage.com>,
 "Paul E. McKenney" <paulmck@kernel.org>,
 Frederic Weisbecker <frederic@kernel.org>,
 Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
 Joel Fernandes <joel@joelfernandes.org>,
 Josh Triplett <josh@joshtriplett.org>, Boqun Feng <boqun.feng@gmail.com>,
 Uladzislau Rezki <urezki@gmail.com>, Steven Rostedt <rostedt@goodmis.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Lai Jiangshan <jiangshanlai@gmail.com>, Zqiang <qiang.zhang1211@gmail.com>,
 Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 Juri Lelli <juri.lelli@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>, Ben Segall
 <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
 Valentin Schneider <vschneid@redhat.com>,
 Anna-Maria Behnsen <anna-maria@linutronix.de>,
 Thomas Gleixner <tglx@linutronix.de>,
 Andrew Morton <akpm@linux-foundation.org>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 rcu@vger.kernel.org, netdev@vger.kernel.org
References: <0f19dd9a-e2fd-4221-aaf5-bafc516f9c32@kernel.dk>
 <20240815171549.3260003-1-csander@purestorage.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20240815171549.3260003-1-csander@purestorage.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/15/24 11:15 AM, Caleb Sander Mateos wrote:
> When softirq actions are called, they are passed a pointer to the entry
> in the softirq_vec table containing the action's function pointer. This
> pointer isn't very useful, as the action callback already knows what
> function it is. And since each callback handles a specific softirq, the
> callback also knows which softirq number is running.
> 
> No softirq action callbacks actually use this parameter, so remove it
> from the function pointer signature. This clarifies that softirq actions
> are global routines and makes it slightly cheaper to call them.
> 
> v2: use full 72 characters in commit description lines, add Reviewed-by

No need to resend because of it, but the changelog bits go below the ---
line, not in the commit message. Whoever applies can just take care of
that.

-- 
Jens Axboe


