Return-Path: <linux-kernel+bounces-396181-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D37389BC90C
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 10:23:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CD0A4282E96
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 09:23:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B71A91CFEDB;
	Tue,  5 Nov 2024 09:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tw2q7T0j"
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD0991D096F
	for <linux-kernel@vger.kernel.org>; Tue,  5 Nov 2024 09:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730798610; cv=none; b=YOP/hB4FTi+eQdndwtNLJVVQPX7mczIVuUM7cLA+xj7adukYvrS8emo3JxyQ+l42OT9XX/cmCtfkkbr/9+51yaX8zrPGWGD/CMdCNv2FVL2gzfp2/Y9+8mAJUpueB0sfoIXtCnH95NJHPAc/a6FAyG4oGpB4A0gCtSc4/gjyWy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730798610; c=relaxed/simple;
	bh=ZdfrPdUPNGoog6Ndxomrc7QnMMuWaqWXqD47+NdPzQw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KIdGSpH1EyH/aZgMN1epjZsCG11M4qKBU5YzsqZ7i2uVzSCMwjXM0rQgfOADTJWrmSJVkfFGOMhm37A2nEERXqPpGdFN5yJqcou9IpUNf4HJzDUxJW03qsI+9K1dgzl9sx/kSHl3DDnpEA1gIdfIGhpQSNqF10hGV6Pcwv5UGEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tw2q7T0j; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-71e70c32cd7so4621616b3a.1
        for <linux-kernel@vger.kernel.org>; Tue, 05 Nov 2024 01:23:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730798608; x=1731403408; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ZdfrPdUPNGoog6Ndxomrc7QnMMuWaqWXqD47+NdPzQw=;
        b=tw2q7T0j89IWatiymbxP8oTIosR6HtE215xHDPU4yhM9+wC2MnUdDeFIlTxwwLIrKq
         JrbFCjjA1cHzJnSRdGqALYhMBvzn3PkCa7XveR3AbOtkUagTnpAQJnMvTYioQmmPVr0W
         J9cQ3PbAf1g55BTMycXFq1wKLEDdlEWsH6/LI5V2UoH03WIDc4cpDYU6Gafq9A48ziAh
         lbHLeHOcZhlKuwUHSsA5dJxj2kbWz05jSraQ0VhbnQyEiBkUNYYBt8jfIqVeC59gaQsZ
         Fm11vC5Pb224AMXAPf/BaYwIj9iBuwazSA8xSJLM0k769t5afAAz93BLhotOgAhBSocY
         XcSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730798608; x=1731403408;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZdfrPdUPNGoog6Ndxomrc7QnMMuWaqWXqD47+NdPzQw=;
        b=Zt5zSPub/USLOw5kX4/uRiBVGhrFO8Mro53dudKszF/hKbmsSkw+jg/PfgNF2FTkyt
         6zsGB+uB0h0gSc1HEj6jggnTx5A+JPD/+s5PMSE+rH/9O0fpRRjoQb0zO/SrUSJMso+p
         Zowd+++EPnhiAuwGHG8raa5BXYtxQrP/C0v+l/arBBATy1ahSbrMuWpXfP2Y9wCd39um
         gOgA7Ih0EAHjpHrqJNZuU9NFL/hoTLSLPE5ZUbyRB2MSZBksGgKQbYeh8xgt4moGrBlv
         w7v2HjM2W2s2Od/eI4qoRrs2w8cPLqTZGDeUnKH7RYOXRnM+W+T5BCKanOrKW1eN/JAZ
         Vf/w==
X-Forwarded-Encrypted: i=1; AJvYcCXaRwq/axm3Okc7EPoKdDXkvaKd3Ha3XWZjpcmvT2+uT/6BD8ulBBAg6RPGFeHsJ7P1gyzawMgXilbsk5o=@vger.kernel.org
X-Gm-Message-State: AOJu0YxsT1eoKrTi0ZFR4f13kCWmeB1aGXlmKLWQl8kPKD2D5qhZR1Cc
	J7UeP/ZgYGms/6fyc3OmwVydzKfrQcFxWUCDJwBYIudY8FwjWte+FpQfgeazl01aAaVy0Z6viZf
	vFWOHgNQ4qx+jCL9hSQsoETmxjavdylv5IBJO
X-Google-Smtp-Source: AGHT+IFsbOkIRMlIXRYOjSf+YW/ReW1Dnhhy8DxL1p03ybgQfhY/UDIdWGScK8OGMbaTEzKUKZbdnxHkOSmX45MPr+0=
X-Received: by 2002:a05:6a20:1d98:b0:1d4:e68c:2eb9 with SMTP id
 adf61e73a8af0-1d9a83cfa9amr47833528637.20.1730798607856; Tue, 05 Nov 2024
 01:23:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241104161910.780003-1-elver@google.com> <20241104161910.780003-3-elver@google.com>
In-Reply-To: <20241104161910.780003-3-elver@google.com>
From: Marco Elver <elver@google.com>
Date: Tue, 5 Nov 2024 10:22:51 +0100
Message-ID: <CANpmjNNBo6SvESFxo6Kk2v4_HOa=CeAVR_unTJvQEP8UZQG6gg@mail.gmail.com>
Subject: Re: [PATCH v2 2/5] time/sched_clock: Broaden sched_clock()'s
 instrumentation coverage
To: elver@google.com, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Will Deacon <will@kernel.org>, Waiman Long <longman@redhat.com>, Boqun Feng <boqun.feng@gmail.com>
Cc: "Paul E. McKenney" <paulmck@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, 
	Mark Rutland <mark.rutland@arm.com>, Dmitry Vyukov <dvyukov@google.com>, kasan-dev@googlegroups.com, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Oops, typo'd the commit message:

On Mon, 4 Nov 2024 at 17:19, Marco Elver <elver@google.com> wrote:
>
> Most of sched_clock()'s implementation is ineligible for instrumentation
> due to relying on sched_clock_noinstr().
>
> Split the implementation off into an __always_inline function
> __sched_clock(), which is then used by the noinstr and instrumentable
> version, to allow more of sched_clock() to be covered by various
> instrumentation.
>
> This will allow instrumentation with the various sanitizers (KASAN,
> KCSAN, KMSAN, UBSAN). For KCSAN, we know that raw seqcount_latch usage
> without annotations will result in false positive reports: tell it that
> all of __sched_clock() is "atomic" for the latch writer; later changes

s/writer/reader/

> in this series will take care of the readers.

s/readers/writers/

... might be less confusing. If you apply, kindly fix up the commit
message, so that future people will be less confused. The code comment
is correct.

Thanks,
-- Marco

