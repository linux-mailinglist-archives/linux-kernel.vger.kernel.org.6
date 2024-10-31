Return-Path: <linux-kernel+bounces-391202-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E1B1A9B83C4
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 20:55:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6CA9EB216AD
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 19:55:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BC1C1CCEE2;
	Thu, 31 Oct 2024 19:54:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rTD1TBDg"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB8AC1CC162
	for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 19:54:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730404492; cv=none; b=Wwfk5djoRPGIdCw/KcKfk03anY/P4M0rTWOXqFAVucRVI6G0FH7gNKdqNUik2x9M/9IpAd/KUHnXX+tx8FkM/0FKTUaBLvWzmv/UMVy0/tvt7vYFQFfVYsAn369FBIv1xbawFR05f7Fu1ikrJHEH3gJLsenyxKyX27l3X28rJMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730404492; c=relaxed/simple;
	bh=ji1ZGggslDNLPdyPAEHksUOY3esBFrCQXJ+WzXWowTE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=QW9uF9Gj8pQHiPR5MxRy7iQSkbei4qk6YzRUfJPFOzD+MzmJIVjt3hfge78ISSWtCoi6fQaGE7cOL6L02nxfAI4f+TlbxohCvORJPSIXKPfVN464NW3+w6zgHYuRdQK5PcE0yK/oONtmLox2gnMR0UrBRJ4X8fivQldOzTDvPQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rTD1TBDg; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e2e3321aae0so2131156276.1
        for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 12:54:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730404489; x=1731009289; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=1hoGCK8+4LjEMDCBa93UaXD3fiD3DB3Wb4hPONNe9Rc=;
        b=rTD1TBDgYaGoB+PSOHZXxODSYrERhTN3pWkTQQS2D10wHKdrtmqda0ST6JLMqno4w8
         haCJ2CXp5Nvjzmdgd6CjQjE64MOsgGZIm5jtzaWViFueBCgzSF1pm2yXqfZv7PjRybL/
         85mGthLcZgAb3vopyCV+9xf3hxMc1oNluclebwRISTJwzn9OmC2+vmNWHFI9cRxaHENE
         ONB6jLg3j/YJMZf34S0atf9+x7peL2Q7HvlaczthL+kMsYIOrdNyyS69DkLnoRUMg0f0
         jfdQqXnu4VJgIM165l9enK4ilQ7sor17vAksD4Gti/niHauXHqBMFNbopaYHmZ42fc4P
         8Kpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730404489; x=1731009289;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1hoGCK8+4LjEMDCBa93UaXD3fiD3DB3Wb4hPONNe9Rc=;
        b=dzsxSjpo7Q7aWQGesXp0mT6lD1lDxHRE5kr1W0aN+G3oc/ps0UplTK099VReqqUu4A
         KZihZY+KAssunTZ19HcZUYT00/WMWV8AsaiY26wEqVLSYznbx8dvDpd6e8HQrnLOL3GR
         3CeHU0O+EDk2t7H9qlBElWf253TvvpSNUF1ZOo7M0AG4skaythDHB9V1WGfXcwfVUL6Y
         PE7u6YFnC0vcOFbdgcRrchrbAk4/tLovs12WgcxqBXy8+/wAULeEhoCATObSDWyAsAdF
         sB0+vUCbvAVFESjFWKhETxLzxN3jwcGqYtdgCwbxFLZuCkE/T6SOa9N/YTFSyydmqwcS
         PRXg==
X-Forwarded-Encrypted: i=1; AJvYcCU3Y4sky63+VlDy5S+O96q++BJk53g04i/MOK9tbN9lWcFHXP83Wh2tnrJIR+tauZ7gKG0jDAvcaelgRy0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6RyL62gyKXTMKx22/8KzMeSszobUswNR3JZGq5f4/a2lofs0u
	xz/96gA8kMIG1DGU7hvE7IbLs5pYJHPD50ClK6qfPACf5pWNAw4LMPRiFwp5MicKLT37RKe7DEz
	WlA==
X-Google-Smtp-Source: AGHT+IGx+dhXZZpZ1cMRDtZ0KNVGD2joed8AnfGFL98nEBItFp6t4i1krvCt4NoKfJwx2ah7sw+/LPgM/gY=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:9d:3983:ac13:c240])
 (user=seanjc job=sendgmr) by 2002:a25:3054:0:b0:e30:d445:a7c with SMTP id
 3f1490d57ef6-e30e5a03f4bmr2444276.1.1730404488923; Thu, 31 Oct 2024 12:54:48
 -0700 (PDT)
Date: Thu, 31 Oct 2024 12:51:39 -0700
In-Reply-To: <20240802185511.305849-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240802185511.305849-1-seanjc@google.com>
X-Mailer: git-send-email 2.47.0.163.g1226f6d8fa-goog
Message-ID: <173039507944.1509256.3272782345564937862.b4-ty@google.com>
Subject: Re: [PATCH 0/9] KVM: x86: Add a quirk for feature MSR initialization
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"

On Fri, 02 Aug 2024 11:55:02 -0700, Sean Christopherson wrote:
> The primary goal of this series to fix an issue where KVM's initialization
> of feature MSRs during vCPU creation results in a failed save/restore of
> PERF_CAPABILITIES.  If userspace configures the VM to _not_ have a PMU,
> because KVM initializes the vCPU's PERF_CAPABILTIIES, trying to save/restore
> the non-zero value will be rejected by the destination.
> 
> The secondary goal is to try and avoid such goofs in the future, by making
> it explicitly clear that userspace owns the vCPU model.
> 
> [...]

Applied to kvm-x86 misc, thanks!

[1/9] KVM: x86: Co-locate initialization of feature MSRs in kvm_arch_vcpu_create()
      https://github.com/kvm-x86/linux/commit/383383cfd202
[2/9] KVM: x86: Disallow changing MSR_PLATFORM_INFO after vCPU has run
      https://github.com/kvm-x86/linux/commit/d76a5e78f16d
[3/9] KVM: x86: Quirk initialization of feature MSRs to KVM's max configuration
      https://github.com/kvm-x86/linux/commit/088b8eeb25ec
[4/9] KVM: x86: Reject userspace attempts to access PERF_CAPABILITIES w/o PDCM
      https://github.com/kvm-x86/linux/commit/c2eb2d0318c0
[5/9] KVM: VMX: Remove restriction that PMU version > 0 for PERF_CAPABILITIES
      https://github.com/kvm-x86/linux/commit/bae593b20e92
[6/9] KVM: x86: Reject userspace attempts to access ARCH_CAPABILITIES w/o support
      https://github.com/kvm-x86/linux/commit/83a5fe6cf1eb
[7/9] KVM: x86: Remove ordering check b/w MSR_PLATFORM_INFO and MISC_FEATURES_ENABLES
      https://github.com/kvm-x86/linux/commit/9d2dcfb82db1
[8/9] KVM: selftests: Verify get/set PERF_CAPABILITIES w/o guest PDMC behavior
      https://github.com/kvm-x86/linux/commit/6a4511f8602f
[9/9] KVM: selftests: Add a testcase for disabling feature MSRs init quirk
      https://github.com/kvm-x86/linux/commit/58a7368f104d

--
https://github.com/kvm-x86/linux/tree/next

