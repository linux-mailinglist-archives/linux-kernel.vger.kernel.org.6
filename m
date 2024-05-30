Return-Path: <linux-kernel+bounces-195287-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD0098D4A15
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 13:11:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 69A58282133
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 11:10:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 189CF16F830;
	Thu, 30 May 2024 11:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b="KA06aF0U"
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BCDB16F0E8
	for <linux-kernel@vger.kernel.org>; Thu, 30 May 2024 11:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717067450; cv=none; b=YzJYhIT03grblcoOTjrNcUmqsK/YxzAdNhX46fGyrqnsgYtztVvHWzO0HOGaVk8sNEDQODPkvBnzU/p7sBuFyBeExcgEGYmgCOjt43iOD8cIp3aGY5eTd3x328/XVv2kMoHajtIiFo1O8ywlBNamR1wB/q4q+t+AaEP3zSML4yA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717067450; c=relaxed/simple;
	bh=6cQQT1iNHkPNVZ1fV3a9CoRBkW4GBeWmVMJ7xh+x3P4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bE0rrb7CiksKcomVdV28DFSgGKNNKQCv0vPos28/3vFQ9VgxgZwmnIJi+HYyQ28KiwC/wE6sOxMOqTuUmHM+zwbx21vwGKh6QnVc0mWN98gY1e//nmlWLjZO38EcRu9e8DL5GNWQUXXMoFH96LM9uh+PLg8xOmchWcg4RsAwDwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io; spf=pass smtp.mailfrom=layalina.io; dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b=KA06aF0U; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=layalina.io
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-35dc04717a1so518010f8f.2
        for <linux-kernel@vger.kernel.org>; Thu, 30 May 2024 04:10:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20230601.gappssmtp.com; s=20230601; t=1717067446; x=1717672246; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Kiy02xbpkVoe0jsA57DQLD//qIOyPVkR19TcyOZjzlw=;
        b=KA06aF0UxXX6gvPHAi5VEaG8RTIwT1rANECvghtsv0echx0y6+rrUGuuOE+WV4IRS2
         1wn+zXckFKQi5kSxJgsjaBlu8L6HkwNaNyM1CCKQkKPjo/HD2odYWYsf2jq4v4pUn+Ao
         0VOCEttYmYJoooRTWrRTLY2qiejUW/ynlI+sNslT+nyMmy3b2C3RjIXC2WvWGnodAvQP
         YnIsxnTh2YITS2prbeZSnNy2CxxuU0ljpgu0Fm7/Cr6JsQ27RN6KxNf2qb81IKkcDRSS
         umRZozZpRCFGN+gVIJ+/MrLC08KfuJGLDp5+ZVYQZpiivn6wRN4gRYXzV/qD8gDvgWiR
         O8Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717067446; x=1717672246;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Kiy02xbpkVoe0jsA57DQLD//qIOyPVkR19TcyOZjzlw=;
        b=oOppDku7GW14MfrCcZBsIrITttoiCKK/McHgHGVZ5wGGvo31+gUbLCvJgkiKHCSddp
         tzFfdeSkcSJ6ONTlgP3PWrzR2bPEsMjiutfGgsC6bBTI+ywZzeS2xPZ3Hx6dfzNoKiA3
         KPvek8vebEhxGN27ELY7ocFD61ZLqXekDvmiKMsD3xiD6Fdifw+5MQJ2Q/E566Q1o9VP
         jV+K2oCq3SmUpexMJUBXSAsRTvXTeKvMNOh5P1ikOZ97FheRihupQe0KBCrx6ciwrxrd
         gYjSHmRd1Kav7RWUfPhAGQ+3JtzoenXsJsXjuNT7hc2VurB0Xz7D1E6/NLH/qz2KLtGi
         vsew==
X-Forwarded-Encrypted: i=1; AJvYcCUWKmFrzN3lbUZiPASA0lfMfKxQO4+zj3zAT4yHAe86kPPO/vZVwbfN4ZLShACNdsNauxWfwnvqtJRzgS6OJ9CuVSq369DbnaidiSJR
X-Gm-Message-State: AOJu0YwzSLF8eI9QNNv9gKzqVx04bpvY5g3QYUR6sqZLFVU4kYBgPQ7w
	nEeFek4KbqJbN7VEZGPqXZ3xdQvtafPNrB2SYF97OGmEW5mOYdS4A3F7eJpcHy4=
X-Google-Smtp-Source: AGHT+IGchwI3vGbp2XfZ0nNpV0truuCoIeo7BGZQIyTNoxwDO/cF3FCmMTdbSH9KXzYGNrWg5l0NwA==
X-Received: by 2002:a5d:6acd:0:b0:354:faec:c9e4 with SMTP id ffacd0b85a97d-35dc00c7d46mr2029957f8f.60.1717067446409;
        Thu, 30 May 2024 04:10:46 -0700 (PDT)
Received: from airbuntu (host81-157-90-255.range81-157.btcentralplus.com. [81.157.90.255])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-357ad6c2fabsm13518620f8f.83.2024.05.30.04.10.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 May 2024 04:10:45 -0700 (PDT)
Date: Thu, 30 May 2024 12:10:44 +0100
From: Qais Yousef <qyousef@layalina.io>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Ingo Molnar <mingo@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Daniel Bristot de Oliveira <bristot@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Jens Axboe <axboe@kernel.dk>, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	linux-mm@kvack.org, Phil Auld <pauld@redhat.com>
Subject: Re: [PATCH v2] sched/rt: Clean up usage of rt_task()
Message-ID: <20240530111044.d4jegeiueizvdjrg@airbuntu>
References: <20240515220536.823145-1-qyousef@layalina.io>
 <20240521110035.KRIwllGe@linutronix.de>
 <20240527172650.kieptfl3zhyljkzx@airbuntu>
 <20240529082912.gPDpgVy3@linutronix.de>
 <20240529103409.3iiemroaavv5lh2p@airbuntu>
 <20240529105528.9QBTCqCr@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240529105528.9QBTCqCr@linutronix.de>

On 05/29/24 12:55, Sebastian Andrzej Siewior wrote:
> On 2024-05-29 11:34:09 [+0100], Qais Yousef wrote:
> > > behaviour. But then it is insistent which matters only in the RT case.
> > > Puh. Any sched folks regarding policy?
> > 
> > I am not sure I understood you here. Could you rephrase please?
> 
> Right now a SCHED_OTHER task boosted to a realtime priority gets
> slack=0. In the !RT scenario everything is fine.
> For RT the slack=0 also happens but the init of the timer looks at the
> policy instead at the possible boosted priority and uses a different
> clock attribute. This can lead to a delayed wake up (so avoiding the
> slack does not solve the problem).
> 
> This is not consistent because IMHO the clock setup & slack should be
> handled equally. So I am asking the sched folks for a policy and I am
> leaning towards looking at task-policy in this case instead of prio
> because you shouldn't do anything that can delay.

Can't we do that based on is_soft/is_hard flag in hrtimer struct when we apply
the slack in hrtimer_set_expires_range_ns() instead?

(not compile tested even)

diff --git a/include/linux/hrtimer.h b/include/linux/hrtimer.h
index aa1e65ccb615..e001f20bbea9 100644
--- a/include/linux/hrtimer.h
+++ b/include/linux/hrtimer.h
@@ -102,12 +102,16 @@ static inline void hrtimer_set_expires(struct hrtimer *timer, ktime_t time)
 
 static inline void hrtimer_set_expires_range(struct hrtimer *timer, ktime_t time, ktime_t delta)
 {
+       if (timer->is_soft || timer->is_hard)
+               delta = 0;
        timer->_softexpires = time;
        timer->node.expires = ktime_add_safe(time, delta);
 }
 
 static inline void hrtimer_set_expires_range_ns(struct hrtimer *timer, ktime_t time, u64 delta)
 {
+       if (timer->is_soft || timer->is_hard)
+               delta = 0;
        timer->_softexpires = time;
        timer->node.expires = ktime_add_safe(time, ns_to_ktime(delta));
 }

