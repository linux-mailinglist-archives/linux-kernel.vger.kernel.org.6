Return-Path: <linux-kernel+bounces-333577-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C891497CAE7
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 16:22:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 06DDB1C2314D
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 14:22:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3FA81A0711;
	Thu, 19 Sep 2024 14:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="fBPcRq2S"
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FE8E1A070D
	for <linux-kernel@vger.kernel.org>; Thu, 19 Sep 2024 14:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726755720; cv=none; b=l9qMD8XB7Eywx+jtvmpyD2njqeJIh3NgOh+HSBzfFKYlHSKO9XoA31mHDWYr4t+B1FFQqFqjIyKMLxI2xNkELu4pLCx8Pqw3KA14vaC8DhqEMiFvDrRsgmntaZM5YoIf40CnJdasoOwdQmlS1yKlw7lEKFWz8TD5VrRJtWzbMcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726755720; c=relaxed/simple;
	bh=EG19uk4anwjgPAwhmxOvnDB/r3ED91HytRD3gv6bjK8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ImPyBrw0bifrBcOaxhSyxVgZ7w4oHdNtdy+plFQQ+dU5TdMkXSmNh9dMFTLDmwyG+EGuh4AjHCRtimH/i3auPIcU9HeMNU7I7fxtxe988cCYWmkaHjuPWSpBQEcHA3FqEmBprpVg+ByEnfnIvOS4rpZlxAtocvYXdg0PejM14rE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=fBPcRq2S; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-5356aa9a0afso1551721e87.2
        for <linux-kernel@vger.kernel.org>; Thu, 19 Sep 2024 07:21:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1726755716; x=1727360516; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=cMMz1PNX68fmg9+skh8c5Nu7ndZ0JGeQo3cBldmTxJE=;
        b=fBPcRq2SRsdveeY/epVJ63XT94PGlH/GITPRrho20eNIFCh2BlZni6KM85xT2zQ0mx
         W8Jl2AP3tCgHboJ95SFClnaiYtz666jzVJJx/0Ax+n0jLwLJv7v7dLTWCqc0YzazG4TG
         MHGQQcWkkxeTvwMkmHsEjXsIoztozNQ3AQ68k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726755716; x=1727360516;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cMMz1PNX68fmg9+skh8c5Nu7ndZ0JGeQo3cBldmTxJE=;
        b=ngQGbmX2VjM2A+n7JiWwGx3mk4KC02NPg5DYnqyfqqsYQeviuxqW3D2wfv07Bwb6dH
         +YcCm+yYwDVl0d/ZFI/4ROS3c4j11o9mo8tSb5RXpeMbz6efcfdblFkyoIDhOL/5/ePf
         1YWFMXfp1XaLM8mGP6K03cTPtkyEzbk5uau2srO87D3/leR4WWV1Zhott0Drbwb3qNK/
         20nsHLGKf8Py5g1THPcglZ/LtW1U+DKPRiQlUlsVN4eWE+tzyNoMhfx+m7VK/vV78PG5
         2BJKv1C4HuXZFiED+CteMbJ/tK7TzfEzCnPuNOdEhlY3mXJ5eCTLV/FJFRZUHKaElPJq
         R4oQ==
X-Forwarded-Encrypted: i=1; AJvYcCW5pXkDA5JN4lWkbhJdtXsVgVkTHERPL+1GF9Bsd5QVavRTzC1kCG7BmPIGj36l4qrIp+8lPCaitt3h/wM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxz7rpRkKfNAY5sJ43J9dY14ut0d5malpN0r5eLBAFXToC/Xzwd
	TDZ31R9XwyEtcr0ucoUMgKXBRYz6P4T8OJbmLQvaKGQeIfQWFvW+3qoAlRdGDvsJ3m0gTIeniQ2
	ekxTk3A==
X-Google-Smtp-Source: AGHT+IG70cC7/9/HY6VikCXuI7HvG41zz0dwmnGwg49FScHQV6NUBU4vLAoVuey9Je+QNc+0eMbb6g==
X-Received: by 2002:a05:6512:ad5:b0:536:54bd:8374 with SMTP id 2adb3069b0e04-5367ff399dfmr15353378e87.60.1726755715770;
        Thu, 19 Sep 2024 07:21:55 -0700 (PDT)
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com. [209.85.208.176])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5368704671esm1845998e87.49.2024.09.19.07.21.53
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Sep 2024 07:21:55 -0700 (PDT)
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2f761461150so12505431fa.0
        for <linux-kernel@vger.kernel.org>; Thu, 19 Sep 2024 07:21:53 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVBmwyNaX7PBcidRTfMmLRQWX/Q3Mn04LC8UxZyJ72LucmfTbC9xIUK6d6BGSiKWM6u9gnKEUXqZJf6ZHE=@vger.kernel.org
X-Received: by 2002:a05:651c:543:b0:2ef:17ee:62a2 with SMTP id
 38308e7fff4ca-2f791906358mr165636051fa.14.1726755713557; Thu, 19 Sep 2024
 07:21:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240917143402.930114-1-boqun.feng@gmail.com> <CAHk-=wi76E2xxvOaZtgN2FK9YKmbK1ru_1atL8eBCs34z7UigA@mail.gmail.com>
 <Zuwx409kgivi1G5T@infradead.org>
In-Reply-To: <Zuwx409kgivi1G5T@infradead.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 19 Sep 2024 16:21:36 +0200
X-Gmail-Original-Message-ID: <CAHk-=wgLrENN2JFZf8j9TDXcfmnZ8BNU_u=6QrEOti-s6aMrbg@mail.gmail.com>
Message-ID: <CAHk-=wgLrENN2JFZf8j9TDXcfmnZ8BNU_u=6QrEOti-s6aMrbg@mail.gmail.com>
Subject: Re: [RFC PATCH 0/4] Add hazard pointers to kernel
To: Christoph Hellwig <hch@infradead.org>
Cc: Boqun Feng <boqun.feng@gmail.com>, linux-kernel@vger.kernel.org, rcu@vger.kernel.org, 
	linux-mm@kvack.org, lkmm@vger.kernel.org, 
	"Paul E. McKenney" <paulmck@kernel.org>, Frederic Weisbecker <frederic@kernel.org>, 
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>, Joel Fernandes <joel@joelfernandes.org>, 
	Josh Triplett <josh@joshtriplett.org>, Uladzislau Rezki <urezki@gmail.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Lai Jiangshan <jiangshanlai@gmail.com>, Zqiang <qiang.zhang1211@gmail.com>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>, 
	Waiman Long <longman@redhat.com>, Mark Rutland <mark.rutland@arm.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Kent Overstreet <kent.overstreet@gmail.com>, 
	Vlastimil Babka <vbabka@suse.cz>, maged.michael@gmail.com
Content-Type: text/plain; charset="UTF-8"

On Thu, 19 Sept 2024 at 16:15, Christoph Hellwig <hch@infradead.org> wrote:
>
> Agreed.  From the description this would seem like a good fit for
> q_usage_counter in the block layer, which currently makes creative use
> of percpu counters.

Yes, if this actually could simplify code that currently used percpu
counters, that might be lovely.

The percpu counters often perform very well, but then have huge pain
in either managing the percpu allocation, or in trying to synchronize
across CPU's.

I'd be a lot more interested in "we can fix complex code" than in "we
have crappy code in bad subsystems where we can hide the performance
impact of the subsystem not having been done right".

               Linus

