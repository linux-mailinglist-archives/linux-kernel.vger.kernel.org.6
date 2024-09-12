Return-Path: <linux-kernel+bounces-327240-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC2EC9772B8
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 22:31:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6BDF2B23BB2
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 20:31:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18C721BF81C;
	Thu, 12 Sep 2024 20:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IuUxudrt"
Received: from mail-io1-f73.google.com (mail-io1-f73.google.com [209.85.166.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28DE813CFB7
	for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 20:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726173063; cv=none; b=ijG313qLF79TZaZ9BoVcAkePzMrRkwGtDnGWyjXkwt+xqHi+rPbcxGRiDK257HciQnajcgTRTZ/ywJIfgzMgVdldCNut50NeArBVvQjMhHUhdTZi5pHaqcM4k10seChzNsNhd6mkMiW+VxM/mDic2RqFKuClkjQ02G00yGAprmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726173063; c=relaxed/simple;
	bh=u3+xTKiDZ6CgDyqF+o7xgUFgxz+T2D6SLtwRNZRyVS8=;
	h=Date:In-Reply-To:Mime-Version:Message-ID:Subject:From:To:Cc:
	 Content-Type; b=gV7v83lO56FIlGwY3bIVJ93IH9e1txpVyisUscwkW7PV1CBy22cS85q8s8C8r8wQuPAfxKoKgIVAsxsvJxoBqSXfRzX7N6mOrAymSqXCCtoX4drWj/AGLCATZ/1H7iuNgmg5dinYksxVZUR3/79I0W6N9fa2P/CxeNGbHc6/Aco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IuUxudrt; arc=none smtp.client-ip=209.85.166.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com
Received: by mail-io1-f73.google.com with SMTP id ca18e2360f4ac-82cf28c74efso214836739f.1
        for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 13:31:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1726173061; x=1726777861; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=yLPhhW7Y6mbWdZPPRUIkvARITfuZTEZkDii7oKKU+Ek=;
        b=IuUxudrtlEScnPVJtdJIZL653Kzmq2KrkAJZPlos0BCzQ/d8bWSAWJkoHNmSMMvpzX
         baaUwY3pLIG5Q8FPiRzMLdlaTS1hNSet+8xvdak+omyblP51OedpMqboDXfBWT0v/rVB
         8tE537sMMR+gUfLWoUy5+xEH3z5fAzERmA5v7Bnw//1jsFw9/0TOahkCJLsXQUMYBNCF
         Z7SN5Rf/20K6pfJRiIHgQgYVJWfu587IeXQtEjx6LZFw64K0kp+5b+DQsRaFTes86bRV
         JGLk+EEFNQwUgbXyYligdHmcQnfPazUUNlbGOws4Mz15dOUCrjTI4NOM0+BbnvSbHhZB
         lcPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726173061; x=1726777861;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yLPhhW7Y6mbWdZPPRUIkvARITfuZTEZkDii7oKKU+Ek=;
        b=uVE9n31t4Z3vLwgyiTYOj+oRKVIY5FFC+c4v1rJSz4MT86cVn2royW/IYF9slDS6c7
         1D4qGanuOPAR52Ak5+ean0Cl9UH2c71snImpEpBcM0HgqbuLvfK3XdB+u2jJKVzMNksK
         Xr4JSs4wNal8BnxGm1ZcaO2tBwaDHG9c0PvO+u2stYp4wEUxNgxmELzSUDMevI6RP+z3
         XHPgqAXZjTvdlZ2tUjdsXdtqi4eNLXKkR70fighRuo3fCKqw5hbsOr1A8PN7bk7Nj3gC
         QbafTacoZDB5J9yklPqHhY4Ub8mIMZVWbkPJ1LP1koHPQFGXky9EUXHDAgYdd9e8Z5hl
         iD8Q==
X-Forwarded-Encrypted: i=1; AJvYcCUX/M5b7IMOTlA+yG6b9N0vPf0WCf8FgF4tumdPUcLrI+myh1ajWcqOuUgBhnwJ4QaccK88fXqT2HrXCyg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4rKVLlx7mPHoic8Z9AujwJPb9b4Dy/fwcVqDmwHL/x2g3csq2
	49wU3k8TVBEHnY1k0Vz4IxA90tJvXaNhP72IuNjX+qQCvEwgCUtFIUvrgR3IHjBAtdaBtJtdyTn
	37fC7o13F3RHz4vxTwx8y7A==
X-Google-Smtp-Source: AGHT+IEvNBP56SW+DzYGXpGSQjGH7l5m6WCB475tagf/GqT0PVTompxQRWYnVlmUdK8417EDaVC+g6P+CB3gV00+3Q==
X-Received: from coltonlewis-kvm.c.googlers.com ([fda3:e722:ac3:cc00:11b:3898:ac11:fa18])
 (user=coltonlewis job=sendgmr) by 2002:a05:6638:1412:b0:4c0:8165:c391 with
 SMTP id 8926c6da1cb9f-4d36136b75dmr162015173.4.1726173061371; Thu, 12 Sep
 2024 13:31:01 -0700 (PDT)
Date: Thu, 12 Sep 2024 20:31:00 +0000
In-Reply-To: <ZuIgE2-GElzSGztH@google.com> (message from Sean Christopherson
 on Wed, 11 Sep 2024 15:56:19 -0700)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Message-ID: <gsntldzwd37f.fsf@coltonlewis-kvm.c.googlers.com>
Subject: Re: [PATCH v2 5/5] perf: Correct perf sampling with guest VMs
From: Colton Lewis <coltonlewis@google.com>
To: Sean Christopherson <seanjc@google.com>
Cc: kvm@vger.kernel.org, oliver.upton@linux.dev, peterz@infradead.org, 
	mingo@redhat.com, acme@kernel.org, namhyung@kernel.org, mark.rutland@arm.com, 
	alexander.shishkin@linux.intel.com, jolsa@kernel.org, irogers@google.com, 
	adrian.hunter@intel.com, kan.liang@linux.intel.com, will@kernel.org, 
	linux@armlinux.org.uk, catalin.marinas@arm.com, mpe@ellerman.id.au, 
	npiggin@gmail.com, christophe.leroy@csgroup.eu, naveen@kernel.org, 
	hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com, 
	borntraeger@linux.ibm.com, svens@linux.ibm.com, tglx@linutronix.de, 
	bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org, 
	linux-s390@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes

Sean Christopherson <seanjc@google.com> writes:

> On Wed, Sep 11, 2024, Colton Lewis wrote:
>> Previously any PMU overflow interrupt that fired while a VCPU was
>> loaded was recorded as a guest event whether it truly was or not. This
>> resulted in nonsense perf recordings that did not honor
>> perf_event_attr.exclude_guest and recorded guest IPs where it should
>> have recorded host IPs.

>> Rework the sampling logic to only record guest samples for events with
>> exclude_guest clear. This way any host-only events with exclude_guest
>> set will never see unexpected guest samples. The behaviour of events
>> with exclude_guest clear is unchanged.

> Nit, "with exclude_guest clear" is easy to misread as simply "with  
> exclude_guest"
> (I did so at least three times).  Maybe

>    The behavior of exclude_guest=0 events is unchanged.

> or

>    The behavior of events without exclude_guest is unchanged.

> I think it's also worth explicitly calling out that events that are  
> configured
> to sample both host and guest may still be prone to misattributing a PMI  
> that
> arrived in the host as a guest event, depending on the KVM arch and/or  
> vendor
> behavior.

Done

