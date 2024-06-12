Return-Path: <linux-kernel+bounces-210757-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 14AFC904855
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 03:22:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9370B1F245ED
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 01:22:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7CCEF9E6;
	Wed, 12 Jun 2024 01:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uvd63oF1"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2B511FB5
	for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 01:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718155313; cv=none; b=aGh1zj5X3dUyxHHGXVYbqht2UA53h/slsmCh8qe9ZmJ7UfoQnnSygcQQMe8phPCN7QO8m6wtwOcP/vNXpJvxuQKn34l4ABoCCqf+5ONZY9WRxk3Nw8XXvHvlvrZC8ytKvTqNuIqdHW60XGkvbW1+0Rs6G+JujbEkeOyBOIp5e/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718155313; c=relaxed/simple;
	bh=n9HvR0Fh6De7r0wC9Lc5abygiywH9YF97/TIn0TNXAk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ANQCdPvhVSVeO19W/y38fPYjI0idYYy+iS7aNdVubPaL9/yb4Vm9eXGz22HtGGgVSF2/s6ueQehhjqr0pnSd4sPuh8mwTf4lmYm2+oZJEsAIwl4EBOPa+/yMVcUHbISLjMqIH67LtFdDX+ngdi9q7kJXIUjeEJTK8hxL8XBbKTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uvd63oF1; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dfb0acdf0c6so2841114276.3
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 18:21:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1718155310; x=1718760110; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=wTeXHTFINXFOM5V9b/wthjvuSyz/P2SlJCKXK2M6Lbc=;
        b=uvd63oF19V3yTS/3fz9pfPeykRZ3YdCUkfDAdj5SGhxrTgsku37urCwy3fJIqcLgmh
         MqhiCPIgVAxS5H4WLavbiEwJafMsTG6B5NssSbi9awLvXmjVXqChpbsNxq3kxQVKJwcJ
         wdq41aTQYW8P/5fQRe/SkDZC3Y7TIXuXSlMXBlD2V/M3UkVhnZ61bRvv9TG6vV//BSIa
         s5K3znVfX6TZrwmpwHjsG13o8kc2WGAhowBPyRDclGtwxMSmgqodNgsYo05qV2kCFWab
         t/5UcLcyOAJvNWsK+hZCw8rdr+v1d3BLalqPF82RCwoGw/+PzC36hW7sf+lqpyTu8aDt
         mVXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718155310; x=1718760110;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wTeXHTFINXFOM5V9b/wthjvuSyz/P2SlJCKXK2M6Lbc=;
        b=ZZ9RjFnKIa/wvp7Ca6TMTYStytCSuWirffbbXQ81q077offoeSSMksiQ47J5B4r9eM
         nrqTWY3cc/dAeHBLQt4bLQR3lA2T50FpW25RAoCtXniSC8FXW5S64kzOyB8NzkNvXhPJ
         e1/OZtx4Lzat3n+xACwY9b00KjpkND1SgpFsMoi0A//micPyqeQOIXDe0gQ323mcvPAf
         Bj5A72FgKTpLQwB2SjGxtZ3+lixdsIC1DWgtAgWQMa9f+gpMV7juDBPREu4632/AmZDi
         upoxwrbQcl+0jbjthTn8xM12iNMFZx+Oe8vIZWuB01/LNSwfbr2CfaM9pd129r763MnU
         fHGw==
X-Forwarded-Encrypted: i=1; AJvYcCUHlOWo5MSnZ02F8bLp+XaTZ3WWXWU6L0FrkXLZPHd4wMwy2hDe3RuKjTGW8ttCfbQosviQyQKUjWmDWx4qWWWHSx9XACytHp5LRP4o
X-Gm-Message-State: AOJu0YzOqTgEw4bU0qTagAcVrEZJPdMYfZRXH8RIGiPLgCg5QgofyNQK
	kBzor8/f7IzgElj9o7KHxDB2JpE7bSVW40IaLHdNwHtd/RMJau2kTfORJEoQHOZl4EkOYB1d9So
	4jA==
X-Google-Smtp-Source: AGHT+IFMeqGx9c8T48CAEG5bqbI82hBbJp1AulGJkEifZ3EJ9BnA1d5dqsuwTHg9s7H4swgRbO+t4SeBMIU=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6902:110d:b0:dcd:88e9:e508 with SMTP id
 3f1490d57ef6-dfe6656c01emr91937276.5.1718155310613; Tue, 11 Jun 2024 18:21:50
 -0700 (PDT)
Date: Tue, 11 Jun 2024 18:18:38 -0700
In-Reply-To: <20240405235603.1173076-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240405235603.1173076-1-seanjc@google.com>
X-Mailer: git-send-email 2.45.2.505.gda0bf45e8d-goog
Message-ID: <171814092212.327582.678141675142575232.b4-ty@google.com>
Subject: Re: [PATCH 00/10] KVM: x86: Fix LVTPC masking on AMD CPUs
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Sandipan Das <sandipan.das@amd.com>, Jim Mattson <jmattson@google.com>, 
	Like Xu <like.xu.linux@gmail.com>
Content-Type: text/plain; charset="utf-8"

On Fri, 05 Apr 2024 16:55:53 -0700, Sean Christopherson wrote:
> This is kinda sorta v2 of Sandipan's fix for KVM's incorrect setting of
> the MASK bit when delivering PMIs through the LVTPC.
> 
> It's a bit rushed, as I want to get Sandipan's fix applied early next
> week so that it can make its way to Linus' tree for -rc4.  And I didn't
> want to apply Sandipan's patch as-is, because I'm a little paranoid that
> the guest CPUID check could be noticeable slow, and it's easy to avoid.
> 
> [...]

Applied 3-10 to kvm-x86 misc (1-2 went into 6.9).

[01/10] KVM: x86: Snapshot if a vCPU's vendor model is AMD vs. Intel compatible
        (previously applied)
[02/10] KVM: x86/pmu: Do not mask LVTPC when handling a PMI on AMD platforms
        (previously applied)
[03/10] KVM: x86/pmu: Squash period for checkpointed events based on host HLE/RTM
        https://github.com/kvm-x86/linux/commit/5a4f8b3026fc
[04/10] KVM: x86: Apply Intel's TSC_AUX reserved-bit behavior to Intel compat vCPUs
        https://github.com/kvm-x86/linux/commit/6463e5e41842
[05/10] KVM: x86: Inhibit code #DBs in MOV-SS shadow for all Intel compat vCPUs
        https://github.com/kvm-x86/linux/commit/c092fc879f99
[06/10] KVM: x86: Use "is Intel compatible" helper to emulate SYSCALL in !64-bit
        https://github.com/kvm-x86/linux/commit/d99e4cb2ae2e
[07/10] KVM: SVM: Emulate SYSENTER RIP/RSP behavior for all Intel compat vCPUs
        https://github.com/kvm-x86/linux/commit/dc2b8b2b524a
[08/10] KVM: x86: Allow SYSENTER in Compatibility Mode for all Intel compat vCPUs
        https://github.com/kvm-x86/linux/commit/4067c2395e80
[09/10] KVM: x86: Open code vendor_intel() in string_registers_quirk()
        https://github.com/kvm-x86/linux/commit/bdaff4f92bce
[10/10] KVM: x86: Bury guest_cpuid_is_amd_or_hygon() in cpuid.c
        https://github.com/kvm-x86/linux/commit/1028893a73fe

--
https://github.com/kvm-x86/linux/tree/next

