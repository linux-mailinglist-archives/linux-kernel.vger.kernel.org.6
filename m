Return-Path: <linux-kernel+bounces-210778-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C95D90488E
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 03:50:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 120061F2324B
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 01:50:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73B614C94;
	Wed, 12 Jun 2024 01:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Jp0ollvH"
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DCF54696
	for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 01:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718157038; cv=none; b=DJSJUchpaBu58T3ge4p/nIFPoodazjt8e9Inm2ZOtlqztWqtez4WozNCRwOrgL8OvcptZxPN1o1H4g6DF0GmrEYjs9IbGQ8RqWpJ79zmqJtUx4mO5cbglE9GilOWGvpZpCW4HO+bLlXVOjSS4Yeq5JnKosXb38uBTl+l5oxoqS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718157038; c=relaxed/simple;
	bh=CKzAUUkEhigDiFfq9f0v9aKgqgAE2xEgqzhO+uzIlyc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=gJc1DY/6Tki4XVFwDfOKdJk3ypI6KSFR1+sYpE5ry7lWAgLYBoo7En74KeFQrQsH3kp5vIiv/yBmwMdkCAdXMdkyQ/sqw9iaDMMqZk9Vw568r5v6wCNh9qcqMV2ULO8s+i0iqeA0vMTP7sh5eLrxDQu0bDAyhmqU07rLq/Xn9Oo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Jp0ollvH; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-6ea5a4fd129so2831919a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 18:50:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1718157037; x=1718761837; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=IKtpIL6U7kg1fAPfAGw1LfrxkdIqOyyJ+814b5HJ4FE=;
        b=Jp0ollvHUpiko7V82fF7TufxCkNgoTT9Iq1uoSQuGxoNv58MBxhm4Bz8uE3pLTymKP
         o4WeKa8/nQVwvIBQuI2Arw87enea8qnNt2hpTqjvuy/FB4iDwGNf34vvkhPhroniR0Jl
         I4emDrjfdI40Rm2YiE0OmJp4j4n7e5T/RK1U8O7k3rrVpUweZPI93Huzw3KfnL9zzftJ
         4gtMEXoZXTyUfF8SPmg3p41eniyUvMsdovlDvOjrPcrZ6MwiJ+v9cD143FpYStfrUl+S
         eZN9eYsmMJn+RrUzFcmdoGFuUGiZ8fT/AQZTIn2AdcSY5djZh89uuo7CvOY3Fh0GMJe6
         SisQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718157037; x=1718761837;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IKtpIL6U7kg1fAPfAGw1LfrxkdIqOyyJ+814b5HJ4FE=;
        b=J4+IP7yz4MBwZ610jo0+zJMnwXjh96hxMmg2H2GTPjhsMU9OlK0LqB1K1GSpP6h0CF
         sJez+KLdi4ZpLnI7C3bKHQTMN4JOXWyPvdOT8AS2PbsVSgMqFV++Dt2w5fA+VOetENs0
         fsuGlyTYkVnPeiMPbaQnxyu4CfLvHe6JjGmzB9aMGr5o4f8BSConH0TfUjrU9SRATQGh
         dqryjZeI+O7U3Q+KaRyXqxnNh1vylYZY0Fp+IjfBVGQPHbrYRda2CF0BPIpfDHFJk3vK
         9LjfcxdUtmb/yHxnDMRFtf+h51v0crHhcMHoyJhK7ioLwMGyB3s7U52UUb9N0hF8YbMF
         5q3w==
X-Forwarded-Encrypted: i=1; AJvYcCUkbcJP6567l6n45hofjyU8InQGxZheur1kUddUOESZ0H7OyLWjWXGJsky8iIf3mWS7zNn1vUsoW4Sqau7KRHw3sZMNf2ugNybasrKn
X-Gm-Message-State: AOJu0Yyu1j8geiie3rvDHH1grET1bIk+MasRcvyBEez7M8QXl8g1sanJ
	AwZtJpYJoQwPrrUiDm50QeDYANTGDDQ5YyQoGKr30L61Jwz59fQk2iaaoPlSwcGhk+FVedZbft0
	+YA==
X-Google-Smtp-Source: AGHT+IH+xKZzaonjaJ1DrCmOckVUlkP3Oe7TZbZOhcwldGcFb1yYxQPimTUv78mDfgKG+TfCv49u+GahTv4=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6a02:8c1:b0:6e5:f498:250a with SMTP id
 41be03b00d2f7-6fae76010c6mr926a12.12.1718157036530; Tue, 11 Jun 2024 18:50:36
 -0700 (PDT)
Date: Wed, 12 Jun 2024 01:50:35 +0000
In-Reply-To: <Zmj+I2jtZLkFGgpd@yzhao56-desk.sh.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240605224527.2907272-1-seanjc@google.com> <171803644297.3355626.18364027225741935056.b4-ty@google.com>
 <Zmj+I2jtZLkFGgpd@yzhao56-desk.sh.intel.com>
Message-ID: <Zmj-6wyzIFHuQw-4@google.com>
Subject: Re: [PATCH 0/2] nVMX: Ensure host's PAT stays sane
From: Sean Christopherson <seanjc@google.com>
To: Yan Zhao <yan.y.zhao@intel.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, linux-kernel@vger.kernel.org, 
	Xiangfei Ma <xiangfeix.ma@intel.com>
Content-Type: text/plain; charset="us-ascii"

On Wed, Jun 12, 2024, Yan Zhao wrote:
> On Tue, Jun 11, 2024 at 06:18:40PM -0700, Sean Christopherson wrote:
> > On Wed, 05 Jun 2024 15:45:25 -0700, Sean Christopherson wrote:
> > > Fix a bug(s) where test_load_host_pat clobbers PAT and causes all
> > > subsequent tests to effectively run with all memory mapped as UC.  Xiangfei
> > > first noticed that this caused rdtsc_vmexit_diff_test to fail, but it can
> > > also lead to timeouts if more tests are added, i.e. if more stuff runs after
> > > test_load_host_pat.
> > > 
> > > Sean Christopherson (2):
> > >   nVMX: Ensure host's PAT is loaded at the end of all VMX tests
> > >   nVMX: Verify KVM actually loads the value in HOST_PAT into the PAT MSR
> > > 
> > > [...]
> > 
> > Applied to kvm-x86 next, thanks!
> > 
> > [1/2] nVMX: Ensure host's PAT is loaded at the end of all VMX tests
> >       https://github.com/kvm-x86/kvm-unit-tests/commit/8cbb8d3cbca9
> This is also good, though I thought you would fix the theoretical one as
> https://lore.kernel.org/all/ZmesywdpFG3qDIkZ@google.com/ :)

Doh, I did squash that, I just forgot to update the "thanks" email with the
correct hashes.

[1/2] nVMX: Ensure host's PAT is loaded at the end of all VMX tests
      https://github.com/kvm-x86/kvm-unit-tests/commit/184ee0d5
[2/2] nVMX: Verify KVM actually loads the value in HOST_PAT into the PAT MSR
      https://github.com/kvm-x86/kvm-unit-tests/commit/ee1d79c3

