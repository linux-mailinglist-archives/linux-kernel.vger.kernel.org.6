Return-Path: <linux-kernel+bounces-392828-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 915E79B9896
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 20:29:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 553C62825FA
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 19:29:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 015A11E47BC;
	Fri,  1 Nov 2024 19:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PqIdcb4O"
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 141211DED61
	for <linux-kernel@vger.kernel.org>; Fri,  1 Nov 2024 19:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730489284; cv=none; b=R38/WP5qhUek9IntgLSEWE+AtoU9joeuWM0yapHB1d7Gd9TgJ61+5BGMZR7IHHJJQ+v1nyG2UxodHUxYUjo4+oznhrOUvxFRH0/MBYqzPeJskHxyd/Ce7924pOED9nzf2O0xaZ2ckTiJVJ7Y9GYR0GWatdwUlqrw6iCpDWpOBLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730489284; c=relaxed/simple;
	bh=QfIr9ZgH3YxeRaReqTzxBk0Rd+0/zCA8wPNGyqKn06s=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=rJf737QrRjVv+nAc4lLXERHEL3HqAlYzFmM2tLKW1Bl/lKjIHBTAPmkMgLNZiomgbj83bPVgIJgbUMQXnwSWf0ph9uUWOKSmPuPXsdNjfsGxveGO9/k/r2zihN+vGPubLRb38Lvws/OuClxfee9zoo6gWGOGQbUmNa/tTtS6spE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PqIdcb4O; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-7ee3c2a2188so2189084a12.3
        for <linux-kernel@vger.kernel.org>; Fri, 01 Nov 2024 12:28:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730489282; x=1731094082; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Rnat+5Qxwr1RPbjlAmK89ke8+3RGlYZMlzw2sHBOBts=;
        b=PqIdcb4OucZ4terzZ1farjTEofIPaUkdVTiw05hJcZ16lNKif6J3DDJgr0gSOzoej1
         gIAxgtQ71B9oagkOVtZ0t1HAnzinDyg+nStv9QULfV69g8fYcpusJhoYK0cvvcnOKnC3
         /pY8DIMBhJXC5umHci4Msp1TDCSuQQCCeaEpWhtNo0xMMJl3L7t82X1a0y8Hq14CsvrM
         AIQm4IutrnunTGaqRofldjhVl6SVCaqg5VzJjT1p+aT706oUqBtr7Rvr9wT+eOy/jd8C
         AGYc43hV3z5rmHX8l7gnjt/1JZAZYP6diQeArt67NU3hZ4MPYeQMeAgIuB5ymO4tXoTP
         hbFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730489282; x=1731094082;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Rnat+5Qxwr1RPbjlAmK89ke8+3RGlYZMlzw2sHBOBts=;
        b=lyq/sYXQgsa4zH7HicrfeVnJUSoWFQaxbSpv6jlJRLTu+uqvt6SlpJw2WiZxa2cLO1
         tuBGPntCDbOV+YgpZL7Oi1RvCeQ4hE58GxnWQt9PrFbG0P0crP6N6jjWnKx5e7wnrIMR
         3Wb3KTegYT3GWRUWhyFaY6bzH2toV8TF8IHv0MDSu3f9UUZFSU8WMthDdZylJESerbwa
         FP5rpYRRbDegCwa33r/2XZ3QtqXqB/rNziMNr1uJ6iSIRTkx61Oiw8lzIy9/NukcukSf
         I92mZ9n6m8iiQ5Er0nhQ2iNS/NY/M2prkoSSFQnEwgty+n3NwI/kMry7IBKm3f1dfRsA
         Hdyg==
X-Forwarded-Encrypted: i=1; AJvYcCXC76gCmLauy3mlK6xPEzgeF1yzhmQN5lDmiLM6x2pufGmZ9T6P5PMgFNWnEXmic0eqsl/sQ3fXU6hG3FI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzS+v5Jz94gVdys/bU5YeLGgOHMJMa8oxNBJAbvG5QsyWnoLj7d
	3GhAYiF+FnLhDpDpi5BtUNeKpiF3txA3Pqf+EPYOZUQmBnPQVaFFh73DRE2M1S23bWTTPMnIcag
	S4Q==
X-Google-Smtp-Source: AGHT+IHxYslOCg/T95KMqV+JPinrVR9r+LFGKVQKpD+ikNIYIwK5kDmVLHevRdtBah8bHC64lZuVIWi5mmA=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:9d:3983:ac13:c240])
 (user=seanjc job=sendgmr) by 2002:a17:90b:1943:b0:2e2:af52:a7b4 with SMTP id
 98e67ed59e1d1-2e8f11d0128mr40947a91.8.1730489282274; Fri, 01 Nov 2024
 12:28:02 -0700 (PDT)
Date: Fri, 1 Nov 2024 12:28:00 -0700
In-Reply-To: <173039501630.1508013.8131245116314575241.b4-ty@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241009175002.1118178-1-seanjc@google.com> <173039501630.1508013.8131245116314575241.b4-ty@google.com>
Message-ID: <ZyUrwCeIyaNE310v@google.com>
Subject: Re: [PATCH v4 0/4] KVM: x86: Fix and harden reg caching from !TASK context
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Maxim Levitsky <mlevitsk@redhat.com>
Content-Type: text/plain; charset="us-ascii"

On Thu, Oct 31, 2024, Sean Christopherson wrote:
> On Wed, 09 Oct 2024 10:49:58 -0700, Sean Christopherson wrote:
> > Fix a (VMX only) bug reported by Maxim where KVM caches a stale SS.AR_BYTES
> > when involuntary preemption schedules out a vCPU during vmx_vcpu_rest(), and
> > ultimately clobbers the VMCS's SS.AR_BYTES if userspace does KVM_GET_SREGS
> > => KVM_SET_SREGS, i.e. if userspace writes the stale value back into KVM.
> > 
> > v4, as this is a spiritual successor to Maxim's earlier series.
> > 
> > [...]
> 
> Applied 1 and 3-4 to kvm-x86 misc.  Patch 2 went into 6.12.  Thanks!
> 
> [1/4] KVM: x86: Bypass register cache when querying CPL from kvm_sched_out()
>       https://github.com/kvm-x86/linux/commit/8c8e90f79c56
> [2/4] KVM: VMX: reset the segment cache after segment init in vmx_vcpu_reset()
>       (no commit info)
> [3/4] KVM: x86: Add lockdep-guarded asserts on register cache usage
>       https://github.com/kvm-x86/linux/commit/21abefc6958d
> [4/4] KVM: x86: Use '0' for guest RIP if PMI encounters protected guest state
>       https://github.com/kvm-x86/linux/commit/a395d143ef40

FYI, I rebased misc to v6.12-rc5, as patches in another series had already been
taken through the tip tree.  New hashes:

[1/4] KVM: x86: Bypass register cache when querying CPL from kvm_sched_out()
      https://github.com/kvm-x86/linux/commit/f0e7012c4b93
...

[3/4] KVM: x86: Add lockdep-guarded asserts on register cache usage
      https://github.com/kvm-x86/linux/commit/1c932fc7620d
[4/4] KVM: x86: Use '0' for guest RIP if PMI encounters protected guest state
      https://github.com/kvm-x86/linux/commit/eecf3985459a

