Return-Path: <linux-kernel+bounces-249431-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 39AEE92EB93
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 17:23:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E48561F2298C
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 15:23:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2921216B75C;
	Thu, 11 Jul 2024 15:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HZ55JdPF"
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E30A0148FE8
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 15:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720711414; cv=none; b=TWVUL9FV0UKhs2XYhuRG4AYYA4xTtnYc717E7XMOukAAttEdYZwdn1EvBoKKJvYoeE/LLmzYqQJKJet+JicqmJ71vKNmdvT3dDakDrILBM26UP3qKj5MPXfG0scoK8CGxqBR4cDRqKCeX6byLbUeByFEJC+R7QD63FnQP7LkTMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720711414; c=relaxed/simple;
	bh=3Wn/GxQ0NHfPCFbxjx3KlFCa+8NIG1RotlGrhinnev4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=W31aK3aCVMgCl2gusYkJe0CgV8H0hWATDO8UWwgf8lf1GuRRAj6djwL1RRa5ZiAi03tjuIGfSafde6OfoOTHXpebubzkiJE9h5G0ovM6gzX2XsBkgXmpgQw7+pRqoaRrnxv0XCLRXiICE2NY71M+sViRB6DOLV6R3bDopjGyNSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HZ55JdPF; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-58c0abd6b35so15901a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 08:23:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1720711411; x=1721316211; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=fBJvc8j2q1vfKURWwRE2Qa2GxAWgYuXKShoXDnQ45TU=;
        b=HZ55JdPFw7qbzYzb4Q6Xh8LCgdQ8oVU7WHRx8WDLcsJFhqMPmNihXmp2anpeAVIhK5
         kcttWuvFjuHeWU/Yqgr/pJ2j76k8cHGH7nMYS9Tq42WlqddTSWSKEgd8iUL+LgvXBfnw
         b7KUGhdSIqw+VvNyAgJO7ml+s/vPns+WbjcNn6vKezEl+IT4mf3MMc/CYrQr59dLsMS5
         Ti/6UUQZP5dX9ljO4Scl7fLlfXROYNqIXWOZD+CRnwy7Kb/xLbi5RtFMfQz2VRmLYH7L
         fFg59qe/zdRqqbixcZfiPgZYTtTSsj0cbdP3kx/6udWpD1/1dL7Zd9CsFXt9RHX4yJR+
         8HOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720711411; x=1721316211;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fBJvc8j2q1vfKURWwRE2Qa2GxAWgYuXKShoXDnQ45TU=;
        b=GDL2gwA4iWTouSE/3njJNLKe5NXtcP0bBBH7Gig3aYP9bwBAS/O7ZD39BR4ZiarxWR
         /dS7wy5u6Lt1SRA5T7s8zWVPBUit/ecz25EVj1gb6xlVQmjzV/XXBQh5gnFxBSeLqZnS
         3R2gL6Lh8er/BD6vrzQkyUmWrCTIFlyCUmxA709WhJw8pXm2RU6Rn0vZUdTp71/q2GtL
         slAu4erxDjFraa6Jn4PpaUKG30EP8qm9ojhwOhPvPPS9amrC0N1pERRU+sNxy9SdNWJ8
         W7Za0xp6Q07mU51kY8rzzo+F+v17qyZznnlTwFYoF5sK564Ar6E6l31sSr4QDFLOfwbf
         Hojw==
X-Forwarded-Encrypted: i=1; AJvYcCWLdKgQvP0h8Y2AkQz6p2O0hlYOQTDk7Rw+3qiIZU5VWNQNAzhQm6XxJ3b//rW3qagE+B4wUezZrET1NK2RWgWDcSJ+1ekxUlWBXOGR
X-Gm-Message-State: AOJu0Yy/EDTPWxogf9o1xYySU6yL0zLs4aNfI/q0ziils28769Ar69td
	EeODjvpi53qzdJxkBOO6lG7oDY48vp0nmKygoPtx0M0YgxUDpjRMe0Vyfms+uqOAPOMeMXd5Y9Q
	hVP9EfmkZ1s7R+asfzQD18O9ioQV4kC19u4Hv
X-Google-Smtp-Source: AGHT+IEOxeNUMoVtd5IuyGwu46w6e22QHj0Z3iAcvoNRcQXN/KEiL6s1GbkJ6jWVGOyatwv0RnPe6b30/vqNRJM8/xc=
X-Received: by 2002:a50:cd8c:0:b0:58b:93:b624 with SMTP id 4fb4d7f45d1cf-5984e03cb73mr185790a12.1.1720711411001;
 Thu, 11 Jul 2024 08:23:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240710220540.188239-1-pratikrajesh.sampat@amd.com> <20240710220540.188239-4-pratikrajesh.sampat@amd.com>
In-Reply-To: <20240710220540.188239-4-pratikrajesh.sampat@amd.com>
From: Peter Gonda <pgonda@google.com>
Date: Thu, 11 Jul 2024 09:23:19 -0600
Message-ID: <CAMkAt6qxaJwobxesMyg8vssgVDCH+fBLb_vW_vARxAcRFQQQ4g@mail.gmail.com>
Subject: Re: [RFC 3/5] selftests: KVM: SEV IOCTL test
To: "Pratik R. Sampat" <pratikrajesh.sampat@amd.com>
Cc: kvm@vger.kernel.org, shuah@kernel.org, thomas.lendacky@amd.com, 
	michael.roth@amd.com, seanjc@google.com, pbonzini@redhat.com, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> +
> +static void test_sev_launch(void *guest_code, uint32_t type, uint64_t policy)
> +{
> +       struct kvm_vcpu *vcpu;
> +       struct kvm_vm *vm;
> +       struct ucall uc;
> +       bool cond;
> +       int ret;
> +
> +       vm = vm_sev_create_with_one_vcpu(type, guest_code, &vcpu);
> +       ret = sev_vm_launch_start(vm, 0);
> +       cond = type == KVM_X86_SEV_VM ? !ret : ret;
> +       TEST_ASSERT(cond,
> +                   "KVM_SEV_LAUNCH_START should fail, invalid policy.");
> +
> +       ret = sev_vm_launch_update(vm, policy);
> +       cond = type == KVM_X86_SEV_VM ? !ret : ret;
> +       TEST_ASSERT(cond,
> +                   "KVM_SEV_LAUNCH_UPDATE should fail, invalid policy.");

Isn't the reason we expect all other calls to fail here because we
have not successfully called `sev_vm_launch_start()`?

> +       sev_guest_status_assert(vm, type);
> +
> +       ret = sev_vm_launch_measure(vm, alloca(256));

Should we free this buffer?

