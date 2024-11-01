Return-Path: <linux-kernel+bounces-392813-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 90E049B986A
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 20:24:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B55991C21C78
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 19:24:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 027051D0140;
	Fri,  1 Nov 2024 19:23:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HVzNRB+l"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B42D21CFED5
	for <linux-kernel@vger.kernel.org>; Fri,  1 Nov 2024 19:23:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730489018; cv=none; b=lxbg4r3rcOcWm5ZPLzVfCwoOwHZh7vVJrVX8GSKW5JBOeUpiMQsH9NhdU/D5g4xmOKRxiDyaqWRdOicskSe/OIlRyczAb0cGiBelEl0aob1+P+fARufgFxPq1OWUvq2A7LLAkmUGIKkRusWvD64IisRCYwRCxGhCZd60AwTJTwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730489018; c=relaxed/simple;
	bh=sveYKeM2yme+ujHJArRxhj9ybxkYoK9gDsio43V6pw4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=SoEf9LPD+mg29QHE4XBMS+gly20mV3pBqRgfrpJnaIm/a4EbiaNKGA3dQvcgFeIVSCX4clA1/17/ySBPRNVvjSRFClJ25l/WVccxEWzDrrGPQw77WVLvEokHTBAGQrCVvMUiMukM4uWC+FUW8hdLaFM8Rid+5wnYl6oF3cfqo7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HVzNRB+l; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e2939e25402so4110746276.2
        for <linux-kernel@vger.kernel.org>; Fri, 01 Nov 2024 12:23:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730489015; x=1731093815; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=EMTZyxqf0e0xSkcUnGLZuVUXmROHi5jZ4VSvoQqdHYk=;
        b=HVzNRB+lYdNwSEzVNkT8ZokueYfd9fzZE8KN6Ipw1vgI6CoFl5LY0YzsoM5xsebLrE
         ehiPpmH64Vn2UTv44epj4yI8Bwgy17eAEHrj4gA84QduiHntr/0fg03Yb+3s4lvpUKZ0
         8Xk/qCKczn770/TjuxHKk0dYyhX5Cif9iybtcF4dVA0iNiy5rWlHGnSb5Hht1MLI+S6t
         dmRSHeXIlGqpDvQSJsAxm3AJH+pg3WgW37VqyFZAuan45Mr4LlgfJI0q9hYL0iIk+Nyk
         UkhItMpaWf/ubIEC6lEP8CdBtVzrtW96G6VXZsD/5AZ00ZrtvYeYivPSwA3Mdq/D5Fiu
         aNHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730489016; x=1731093816;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EMTZyxqf0e0xSkcUnGLZuVUXmROHi5jZ4VSvoQqdHYk=;
        b=VGx9xhz8jgOchDq6lk77eBRf6jfLo2Nifx49i3MU4h/vvNhkGnthKjUnXFtp8mXmzA
         xy/aybkCOxSntIBA25jAs+cVeQeWLP2zm20b5PKsq3DiyZBs/fhCYhQngIRl6DhUI5Mm
         kXxtMIgSIPXsTmrip57uWoNYKMNPPIWoe8+Q6+e5CqSFYr+0zFIdZnpg+VKtg15U6Zzw
         0kg4bzl96ChsOLwX/XDbr7EUVQlDWH3rij409D6wdfH2STNDd9+ILfyDDhhdT6G5aUVV
         2UyC+rHLQfdXK+r6wgX1KFy6dmRgfzuo3D1xDn5gECZtBuVlhM92dlaUlshJL4H3NB8R
         Q2vQ==
X-Forwarded-Encrypted: i=1; AJvYcCWdG5DwyWIKef2vSgWdUCvO99GGM340FQYwfmyrldvheF+dRHe45tQolGoL2Svand7k07P5pPhDLyDZnoM=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywmloz3NQKx2LR7t+EFg+OhV/swvtsRsbpM9pqk6BfanI8GAFqu
	ckbUty7SMGa/7MH855bFXq9N8xt1Uz940Gf/Ah24NE3EGK3mn8eTcH9R+bioWTIVV58UbiEIDu9
	q4g==
X-Google-Smtp-Source: AGHT+IEPCxiGIildz/DMTJPZo+wbCpIsJ5qyYnWMb2i3RD+UzoO0m8EKAROcnxs4q3uYl284xuC1iof4Xhw=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:9d:3983:ac13:c240])
 (user=seanjc job=sendgmr) by 2002:a25:6844:0:b0:e03:53a4:1a7 with SMTP id
 3f1490d57ef6-e330268d7c8mr3045276.10.1730489015632; Fri, 01 Nov 2024 12:23:35
 -0700 (PDT)
Date: Fri, 1 Nov 2024 12:23:34 -0700
In-Reply-To: <173039507944.1509256.3272782345564937862.b4-ty@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240802185511.305849-1-seanjc@google.com> <173039507944.1509256.3272782345564937862.b4-ty@google.com>
Message-ID: <ZyUqtis_QI_otazX@google.com>
Subject: Re: [PATCH 0/9] KVM: x86: Add a quirk for feature MSR initialization
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Thu, Oct 31, 2024, Sean Christopherson wrote:
> On Fri, 02 Aug 2024 11:55:02 -0700, Sean Christopherson wrote:
> > The primary goal of this series to fix an issue where KVM's initialization
> > of feature MSRs during vCPU creation results in a failed save/restore of
> > PERF_CAPABILITIES.  If userspace configures the VM to _not_ have a PMU,
> > because KVM initializes the vCPU's PERF_CAPABILTIIES, trying to save/restore
> > the non-zero value will be rejected by the destination.
> > 
> > The secondary goal is to try and avoid such goofs in the future, by making
> > it explicitly clear that userspace owns the vCPU model.
> > 
> > [...]
> 
> Applied to kvm-x86 misc, thanks!
> 
> [1/9] KVM: x86: Co-locate initialization of feature MSRs in kvm_arch_vcpu_create()
>       https://github.com/kvm-x86/linux/commit/383383cfd202
> [2/9] KVM: x86: Disallow changing MSR_PLATFORM_INFO after vCPU has run
>       https://github.com/kvm-x86/linux/commit/d76a5e78f16d
> [3/9] KVM: x86: Quirk initialization of feature MSRs to KVM's max configuration
>       https://github.com/kvm-x86/linux/commit/088b8eeb25ec
> [4/9] KVM: x86: Reject userspace attempts to access PERF_CAPABILITIES w/o PDCM
>       https://github.com/kvm-x86/linux/commit/c2eb2d0318c0
> [5/9] KVM: VMX: Remove restriction that PMU version > 0 for PERF_CAPABILITIES
>       https://github.com/kvm-x86/linux/commit/bae593b20e92
> [6/9] KVM: x86: Reject userspace attempts to access ARCH_CAPABILITIES w/o support
>       https://github.com/kvm-x86/linux/commit/83a5fe6cf1eb
> [7/9] KVM: x86: Remove ordering check b/w MSR_PLATFORM_INFO and MISC_FEATURES_ENABLES
>       https://github.com/kvm-x86/linux/commit/9d2dcfb82db1
> [8/9] KVM: selftests: Verify get/set PERF_CAPABILITIES w/o guest PDMC behavior
>       https://github.com/kvm-x86/linux/commit/6a4511f8602f
> [9/9] KVM: selftests: Add a testcase for disabling feature MSRs init quirk
>       https://github.com/kvm-x86/linux/commit/58a7368f104d

FYI, I rebased misc to v6.12-rc5, as patches in another series had already been
taken through the tip tree.  New hashes:

[1/9] KVM: x86: Co-locate initialization of feature MSRs in kvm_arch_vcpu_create()
      https://github.com/kvm-x86/linux/commit/2142ac663a6a
[2/9] KVM: x86: Disallow changing MSR_PLATFORM_INFO after vCPU has run
      https://github.com/kvm-x86/linux/commit/bc2ca3680b30
[3/9] KVM: x86: Quirk initialization of feature MSRs to KVM's max configuration
      https://github.com/kvm-x86/linux/commit/dcb988cdac85
[4/9] KVM: x86: Reject userspace attempts to access PERF_CAPABILITIES w/o PDCM
      https://github.com/kvm-x86/linux/commit/d75cac366f44
[5/9] KVM: VMX: Remove restriction that PMU version > 0 for PERF_CAPABILITIES
      https://github.com/kvm-x86/linux/commit/a1039111192b
[6/9] KVM: x86: Reject userspace attempts to access ARCH_CAPABILITIES w/o support
      https://github.com/kvm-x86/linux/commit/a5d563890b8f
[7/9] KVM: x86: Remove ordering check b/w MSR_PLATFORM_INFO and MISC_FEATURES_ENABLES
      https://github.com/kvm-x86/linux/commit/1ded7a57b805
[8/9] KVM: selftests: Verify get/set PERF_CAPABILITIES w/o guest PDMC behavior
      https://github.com/kvm-x86/linux/commit/b799e3e7da2c
[9/9] KVM: selftests: Add a testcase for disabling feature MSRs init quirk
      https://github.com/kvm-x86/linux/commit/0581dfbad954

