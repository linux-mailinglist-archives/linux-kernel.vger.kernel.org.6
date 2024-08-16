Return-Path: <linux-kernel+bounces-288956-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C124F9540A2
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 06:33:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5A7031F24454
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 04:33:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D755A77111;
	Fri, 16 Aug 2024 04:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iZQ52Jaq"
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8AB9846D
	for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2024 04:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723782785; cv=none; b=TJ4flHk62jbev2tqDpJr+wq7ixbdOI90udZ22XrsNsozoimLLVuWRF5stu3ovNs40VKVweOX0lmH/SYxpcz1GCxWfFxpPepjRNsP2OvAQksJ78gXrF0i7UeCIfQhAcx5I79UfG2lWyfpINCvxOKIZKsLsaH7xZxrVVjnHPS6gVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723782785; c=relaxed/simple;
	bh=gKYcw8BFgqyCG9U8fSFU4vcznAROy4MCcrvxbpOoMf8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=GTBh4XO8Z1D0Kr30r+bTMpghBenSYut6qsA02DkNVP4aXD5taKQd4dthS0n/nLM8u7JRmTw8LYaNJHVB2/P9JcIfbnYLdulaYsOhMeu8ze2UVW5Du0hiaYeaff7cPw7J/CuOkBpgk25CaHdYLBRU1G+fUS8iaArLygDUWSPdvbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=iZQ52Jaq; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-201e24bd4d9so18018865ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2024 21:33:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723782783; x=1724387583; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=oAY+2mnkmDOyE0/LDnygIPe0uyeLZUFD8yCrWWXulvA=;
        b=iZQ52JaqU0h2XDD9kTGwW2H96ai/m2b2BDE+zRVKxNkK63hkduLx4kS35y/EI4hu8C
         Xg+g96Ij2dOUhCSzb4Ws6fqtpDmvzNGUYKRS50s6lffYYifqS6PQ+GMoJPwB0TWcts6D
         PazoAlvFpEDbWbTH8ztc1E4MMvMAOAfyACW+x+B4hcrEJqqX/LGWaBXhQnPzWt+93jxg
         s/kPh2leL5+Sg6zzUUZJnIGJ+KlrC+UjZgzH6p5YpSoi+Oi2kYdibQKOXVujtAqN5Cze
         70b2hGpbLP1jAAWfwAyVtePtTHeIP3Ph3c/jX9HqQg+2wLBPAek1j9jQ9Vt9YjwY+qoz
         sd7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723782783; x=1724387583;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oAY+2mnkmDOyE0/LDnygIPe0uyeLZUFD8yCrWWXulvA=;
        b=FPk+dGavf3mrILk4dLOScMQ7cPiW4NUAnrHZnXVCTOGL2zplpqkwW+QkmFNqDc1ko9
         yHuQMQfEY013+5BeikLMTVyGzJ10b6s92dP7gyll8jXRw/3F6u+0tP/skoUWIDmCSwuV
         bIVMKxrayrFLqzpP0FceEA4fsB2tXGL2x8XzQlAfOYJpIVWwUzzQPIEynkbaZjt+kIJc
         aGCMadHDSd4j3l0CjyX6irc5jDdGcFM99NtFjHcU00lZjF00iEMZJRo0XPs3dCitpvzt
         9koVYAp4PCvi1jqdg+QzkRtxqse6dXb4QV9DZ4259HkckEyD9IhYXmdznZbtL8SZcH+r
         BJBA==
X-Forwarded-Encrypted: i=1; AJvYcCXRKn0anjnNTxlvwh+d7HoHx2CXxb6tOuGvfcfOabVW05wtEb/iPidUERcCCTNpvMBcXn3kd3nP92eE2gn5pa/txvOU0Vl4cd4raVG3
X-Gm-Message-State: AOJu0Yxd2LPQLtuBnu8vVLtb3RQd6PVEYFIZMbjiQGsm7qFpdw6Bqris
	FrH35mPhNExza6yKWjymBhypX4JPIohrudvW//RhFLqbMSkbQSzT8o02+jSf/Kiqr4iGXNTpuZ/
	elw==
X-Google-Smtp-Source: AGHT+IGfamVttf9aqtEoBOPzlIFrtjRPALYYklisneGw/z9Eb5n0QP2E9U6LZwfDLsshphmMuB6L9EZEGXA=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:902:ca05:b0:1fb:a38b:c59d with SMTP id
 d9443c01a7336-20203f391ffmr58715ad.7.1723782783028; Thu, 15 Aug 2024 21:33:03
 -0700 (PDT)
Date: Thu, 15 Aug 2024 21:33:01 -0700
In-Reply-To: <20240522001817.619072-20-dwmw2@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240522001817.619072-1-dwmw2@infradead.org> <20240522001817.619072-20-dwmw2@infradead.org>
Message-ID: <Zr7WfbCBPhoNMukJ@google.com>
Subject: Re: [RFC PATCH v3 19/21] KVM: x86: Avoid periodic KVM clock updates
 in master clock mode
From: Sean Christopherson <seanjc@google.com>
To: David Woodhouse <dwmw2@infradead.org>
Cc: kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>, 
	Jonathan Corbet <corbet@lwn.net>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Paul Durrant <paul@xen.org>, Peter Zijlstra <peterz@infradead.org>, 
	Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>, 
	Dietmar Eggemann <dietmar.eggemann@arm.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
	Daniel Bristot de Oliveira <bristot@redhat.com>, Valentin Schneider <vschneid@redhat.com>, Shuah Khan <shuah@kernel.org>, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	jalliste@amazon.co.uk, sveith@amazon.de, zide.chen@intel.com, 
	Dongli Zhang <dongli.zhang@oracle.com>, Chenyi Qiang <chenyi.qiang@intel.com>
Content-Type: text/plain; charset="us-ascii"

On Wed, May 22, 2024, David Woodhouse wrote:
> From: David Woodhouse <dwmw@amazon.co.uk>
> 
> When the KVM clock is in master clock mode, updating the KVM clock is
> pointless.

Please explain why it's pointless.  I almost feel bad asking you to elaborate
since you've written wonderful changelogs for so many other patches, but far too
many of the (historical) kvmclock commits assume the reader is some omniscient
being, and it's definitely contributed to things getting into such a mess state.

> Let the periodic work 'expire', and start it running again
> from kvm_end_pvclock_update() if the master clock mode is ever turned
> off again.

