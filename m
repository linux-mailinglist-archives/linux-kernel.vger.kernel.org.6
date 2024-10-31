Return-Path: <linux-kernel+bounces-391205-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A47E9B83CD
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 20:56:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 036DFB2274F
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 19:56:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC4521CCEC3;
	Thu, 31 Oct 2024 19:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RoShhWas"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFDD71CBE8D
	for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 19:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730404548; cv=none; b=EoNO8cI1EJVmwGeGucNPvsE+hud5TKpS2288AiHe/m0F1aJJiXvVqa3lPsYXgB1Igq5EtphZTmThjBlYrmeLXPCqBhRKehjUUU6PR+6FPDXDko1+1DVGDOFYwoNZ3aueXERN1OMJ3eKoVcBgZQV60fMI9T/b62b99VCM55RJxic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730404548; c=relaxed/simple;
	bh=JIuKZte/KWDp0u3PEseHuVJAQKETV1NshrdQcivIQaw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=IgMTvM+l0C5yDXZ0mmGpThLy9LOvrqUpW1EfgCuE/t88kWCHdqM/uShb24WQjgxkO/KT7EKDdisnqrM+ooFZ96BIIFWKov3lLzr0AQ3h+jZVJ7Gtvf2CK9meamK4FNc4lx4ovNUyCAOdLXLacIfEqQikrM5hwlTVDGYT/2kB9Ag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RoShhWas; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6e35a643200so29361307b3.0
        for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 12:55:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730404544; x=1731009344; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=f0/oR659VY2W8KZYWHDyQb/k0R5l7UZuyfkJK3fpV6U=;
        b=RoShhWasXVJzCTRC5ZsyYrWqYWZSHxjTlr+5UYnNSqsnzW2zJDOjNqRywxr+gKiaAC
         QR3r1Rov4/p+mJt/7R4eVv/2o+k1jpDBlbMjPK5Ujfq5QdKviwVGHKwn5WiqEbBI1zzp
         TCnSqcfzoKtGFOwlakkYHKMMU9cE7Iiv2d81g7JbOke/wO1VkE87HAtS3MZQszXU6xGr
         X2pouTbgZ1e6Pjd8o/yLVjANvSc2KKhtk75emAncxh8r37fOcJcYVRF546y79g3dUi5w
         OLq7AFUqK4qqD/Duu2cDd1pxbiiiLH7UD+C2ODwkLYdcUnxyfZxGIzD4QDmpmNlBitC2
         6ulg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730404544; x=1731009344;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=f0/oR659VY2W8KZYWHDyQb/k0R5l7UZuyfkJK3fpV6U=;
        b=bgw5uGRmEfMtPF4QjzvMWTK2bARXzKdFlTxtNDotyBVPIqMJk9WG2XrEEByc82BF77
         YrcvOcV4oglwmJbdXmoPgsdRXe4zNw4Lu51dy+N4ub4kYjIhKexgwUUhEK/cYJBk/+0m
         l+3ggZYy5KLxExEpbyr0YOWi5nxYBdHHum+m/GeHJYdbwQ5rhkezW5VP1xz0aNTkm6mA
         5yuKJ2a1NQQ3GwVFg4clgQWm5H44BSx3r4Z/RLEehC+5eul6RPoKqdwv5TN/Xh+Rbhgq
         pJTHvJ/ayq3oKhbmHiAXQDPOty/cuSI11CMLIKsVmmX9Rf3gf36Ky5ljmhlaizEXrmkU
         dVZA==
X-Forwarded-Encrypted: i=1; AJvYcCXWgt3KoRzXWOOpTKijk/U4zmsgjhGUm9111aqYUHupyeoY7jwLsJIWb0ZV0I/db6dX1TRb/UJOWCxWcFk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2oUYAOmL1aWD5lMiVOzkshhAg5FBDZK2vhTo3m5gbLSP0D//e
	n3oA35L3+etWYxwF8TocAGrgYZjxdr/H0KPTKljl7HSc17lDvCwnahg1qjF2Z2OZeWdGqnQxpGf
	XzA==
X-Google-Smtp-Source: AGHT+IGFyWNtS3LxS1sbvinW/tnRcG6q4cNMH3IbMweReCN5sAKq2SwnuczE7aSWqqVeI7xwI0JVItWfbrE=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:9d:3983:ac13:c240])
 (user=seanjc job=sendgmr) by 2002:a05:690c:67ca:b0:6e3:d670:f62a with SMTP id
 00721157ae682-6ea52518e31mr104197b3.3.1730404543886; Thu, 31 Oct 2024
 12:55:43 -0700 (PDT)
Date: Thu, 31 Oct 2024 12:51:46 -0700
In-Reply-To: <20241009175002.1118178-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241009175002.1118178-1-seanjc@google.com>
X-Mailer: git-send-email 2.47.0.163.g1226f6d8fa-goog
Message-ID: <173039501630.1508013.8131245116314575241.b4-ty@google.com>
Subject: Re: [PATCH v4 0/4] KVM: x86: Fix and harden reg caching from !TASK context
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Maxim Levitsky <mlevitsk@redhat.com>
Content-Type: text/plain; charset="utf-8"

On Wed, 09 Oct 2024 10:49:58 -0700, Sean Christopherson wrote:
> Fix a (VMX only) bug reported by Maxim where KVM caches a stale SS.AR_BYTES
> when involuntary preemption schedules out a vCPU during vmx_vcpu_rest(), and
> ultimately clobbers the VMCS's SS.AR_BYTES if userspace does KVM_GET_SREGS
> => KVM_SET_SREGS, i.e. if userspace writes the stale value back into KVM.
> 
> v4, as this is a spiritual successor to Maxim's earlier series.
> 
> [...]

Applied 1 and 3-4 to kvm-x86 misc.  Patch 2 went into 6.12.  Thanks!

[1/4] KVM: x86: Bypass register cache when querying CPL from kvm_sched_out()
      https://github.com/kvm-x86/linux/commit/8c8e90f79c56
[2/4] KVM: VMX: reset the segment cache after segment init in vmx_vcpu_reset()
      (no commit info)
[3/4] KVM: x86: Add lockdep-guarded asserts on register cache usage
      https://github.com/kvm-x86/linux/commit/21abefc6958d
[4/4] KVM: x86: Use '0' for guest RIP if PMI encounters protected guest state
      https://github.com/kvm-x86/linux/commit/a395d143ef40

--
https://github.com/kvm-x86/linux/tree/next

