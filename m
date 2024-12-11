Return-Path: <linux-kernel+bounces-442209-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EA279ED954
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 23:06:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 497D9161D32
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 22:06:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39A8D1F0E49;
	Wed, 11 Dec 2024 22:06:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Auj4CTDk"
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34EEC1E9B16
	for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 22:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733954776; cv=none; b=j0XfaBTLi9H6WRGGQR0klrdMf3RIdihBviPmJ6xzKLDwasqpkpfLgcJinCFcRz2T8DWniZwH6rsCK1DdGJ3RJG/UGyM/JkY9ihUGOimaNC3b3a2AERDZ0jBEBLyxhV4BjwPFliXZNzP4fPdDpAEEG3U6Ib74bHZ0dLlCzSE8qoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733954776; c=relaxed/simple;
	bh=dc04m6m7A0zBx/3GsGuHlwEymHutsumTTMAD3LQrhZQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=dac8iXWEmwInW7lS2wf6H/5hDEY8WdKF6na2q7SJDRxsgRNI6xMqO8beaYTWEc+d/7DOvJ37/+C1L1IJwZmcp4Qt7LWC3aV7kq+jkGywiAR5RmK/howkOBUoJPwUYtL2CllI2otQ4DRJEPJLFWtvKQqUHctlihVOU87L0NA2iuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Auj4CTDk; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-21681a2c0d5so16172025ad.2
        for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 14:06:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733954774; x=1734559574; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=uTDUEy5ndzyMUOmAANu+2Q5dKv5CytQeXy0bYdZM4AE=;
        b=Auj4CTDkhS7LzhaNcAPn5mYq6OF8PgwSK7WQQhbEOpT7tWIDubpIezmPMNuoe9GMHz
         7CdRufWp+F4w+gfK1zolvBvlL8W8bwpE7sC80wV044hKSeuT+mVVpKuc3SkhUkBYUlb8
         9xt6kN3ge476OS9hpEPCVj5ADX4iduN+WRYgWRaQ4e67e0QxTeWp3iOhe14oPwTIS0Dc
         bOkRSsk2649RXCsMZ/8F2scbDivSabuOgqLPoQDtiCTd1271HrBHvvNJ2cdVPPoPDD5n
         18lLyYrZhbOztthodbfPp40xsTKktCeJQiQIOTunZCXbWnOOvhLiaIRQGLjUZZngUh26
         ztvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733954774; x=1734559574;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uTDUEy5ndzyMUOmAANu+2Q5dKv5CytQeXy0bYdZM4AE=;
        b=f3nUmzOxT7VQTVGx7M6egxJ54z9HkQ4iiB4KiyJD3ZaDqyowB0NU3NtaAvFC4g6CV0
         JnMmsrr5BuZqk6DpP4rGXIH3oIxW0N/JYbqsOTflBaKBHc8SApRz3dkgB73Fn6nse5/b
         RDs1JVqs8N81ls2Zhu0v3LtTrs84IPNabMuxPGXbSEhsCFib1xOxPJ1poREI0VK4w5Iv
         OWAfhgVxRdVyZAB4M4CVUd9hUZVE0bmQdf1oHcDkTSj/aNBPBFAdHRKbPzLV1+cC4on+
         CgA2p5eG8zyJLsA5Cd6s6HR16SlPD7KzvdYZsIYjl9oXkMsEH5BXkovFkaE0rwi5WDIU
         yEgQ==
X-Forwarded-Encrypted: i=1; AJvYcCXUkL3PV8lX8FZpKmgvjGincKYSxSpnEnEyntE6dZhf4UHD9n5uPkl6ef5ENRhUO96uoTXXeS8sTvj2V8U=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQGSZqmxke3aAth18Y11wFAFuKZcO/8XgJ61f/LtUB4JlA+8ra
	1lNS/uIMS45A1paxLtia+xYPBJFVEw0c6xDKjyz8nq7f2nvJ/QxDOjcUn1UjMZrhxLTc+3g9pne
	B3g==
X-Google-Smtp-Source: AGHT+IHFSnyjPEDTcWJnAvaiGma2JfY/srzHSvKplMJ9OueXQOEiKTtjMmaF+b36NOyPghd7X0ZdCPZjbkA=
X-Received: from plgn1.prod.google.com ([2002:a17:902:f601:b0:216:499e:dadb])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:db04:b0:215:44fe:163e
 with SMTP id d9443c01a7336-21778397514mr77377935ad.1.1733954774653; Wed, 11
 Dec 2024 14:06:14 -0800 (PST)
Date: Wed, 11 Dec 2024 14:06:12 -0800
In-Reply-To: <20240910152207.38974-15-nikwip@amazon.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240910152207.38974-1-nikwip@amazon.de> <20240910152207.38974-15-nikwip@amazon.de>
Message-ID: <Z1oM1HQqXrIr1tij@google.com>
Subject: Re: [PATCH 14/15] KVM: x86: Implement KVM_TRANSLATE2
From: Sean Christopherson <seanjc@google.com>
To: Nikolas Wipper <nikwip@amazon.de>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Vitaly Kuznetsov <vkuznets@redhat.com>, 
	Nicolas Saenz Julienne <nsaenz@amazon.com>, Alexander Graf <graf@amazon.de>, James Gowans <jgowans@amazon.com>, 
	nh-open-source@amazon.com, Thomas Gleixner <tglx@linutronix.de>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, linux-kernel@vger.kernel.org, 
	kvm@vger.kernel.org, x86@kernel.org, linux-doc@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, kvmarm@lists.linux.dev, 
	kvm-riscv@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"

On Tue, Sep 10, 2024, Nikolas Wipper wrote:
> +int kvm_arch_vcpu_ioctl_translate2(struct kvm_vcpu *vcpu,
> +				    struct kvm_translation2 *tr)
> +{
> +	int idx, set_bit_mode = 0, access = 0;
> +	struct x86_exception exception = { };
> +	gva_t vaddr = tr->linear_address;
> +	u16 status = 0;
> +	gpa_t gpa;
> +
> +	if (tr->flags & KVM_TRANSLATE_FLAGS_SET_ACCESSED)
> +		set_bit_mode |= PWALK_SET_ACCESSED;
> +	if (tr->flags & KVM_TRANSLATE_FLAGS_SET_DIRTY)
> +		set_bit_mode |= PWALK_SET_DIRTY;
> +	if (tr->flags & KVM_TRANSLATE_FLAGS_FORCE_SET_ACCESSED)
> +		set_bit_mode |= PWALK_FORCE_SET_ACCESSED;
> +
> +	if (tr->access & KVM_TRANSLATE_ACCESS_WRITE)
> +		access |= PFERR_WRITE_MASK;
> +	if (tr->access & KVM_TRANSLATE_ACCESS_USER)
> +		access |= PFERR_USER_MASK;
> +	if (tr->access & KVM_TRANSLATE_ACCESS_EXEC)
> +		access |= PFERR_FETCH_MASK;

WRITE and FETCH accesses need to be mutually exclusive.

