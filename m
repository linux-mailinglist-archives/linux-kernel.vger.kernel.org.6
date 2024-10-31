Return-Path: <linux-kernel+bounces-391212-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B431E9B83DE
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 20:58:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 668061F227D7
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 19:58:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 303141A2562;
	Thu, 31 Oct 2024 19:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gbDkIVX8"
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FBBD1CC8AD
	for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 19:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730404689; cv=none; b=IG0+Whxdv8V3VqxPMQY2Q8zuAYqK2t23ZRe5yqWf+pwS55dlajx6wBmblp08w7xuWzySwCcc4mzTgQflpG7UXHAHyx19ZiJUCs/W1uBy7kDPOve/g2An1oeSLN6uNs/JeMscYYAOE5O7tCZE+6k39qK5Tjd9p9BcQLsVkdyCg70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730404689; c=relaxed/simple;
	bh=Ene4XBpjeGsq36rc0IQrdysqTlwlDeZGDAKixhoHnFI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=sA4nnfiAbcmLCz0NXfNgOM+EWX+tqiBIYbNUtAE9oLhBcRfhQmm9OD/QoYgW4Dm57xHtz/cCZ7IhhDoXK1KmFnrz12zXJRB2ULZ0kezQB8aGW9KBaZWA2nsCtOkCSZBMRgt3SYaknF09AzOLYSmiKcw1Xbap90f6YUj+l1d7XF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gbDkIVX8; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-2e2ca403f5dso1266758a91.1
        for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 12:58:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730404687; x=1731009487; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=RD5TkR246EsKLWEa1qebyIvoAMqqwjYwsx4rtMlmzqs=;
        b=gbDkIVX8qof538jOX50Lp3LSbtZV/vdTHARgziJsbcxP5WnpWex4sE7edfpw1UYzOT
         twO5jvXqoQCeff6Ipw78VI3zKdVkZBmUAyl6ANCT8y5pGXZyYBOm77cts4srun5tY9k2
         COB350YolbfYJpwzgkj0ejtrvArdQvMJTiDiVQ0oeletdgnqGMinNsZCxEEY8kEzRzpk
         jqp7VIar4w0b5ySiYZQ9T2UybQe5BbL20RzBH13JJjI56DzH1qAgpw99l88p2eoWM92i
         lwm0AOIhXLs3g8aqJdEdD9rdkfcVrIeCLtcNn3c+BimPcLFIGQZBIvQhtXLTe4YoMkei
         p5fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730404687; x=1731009487;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RD5TkR246EsKLWEa1qebyIvoAMqqwjYwsx4rtMlmzqs=;
        b=saoX/Qz4l53F1KUQFA+wza9vugImk/45BgNcqXB4jSJ7UKzB/zwmber31tyD42ELrI
         blCrfCfE3Mxr75MPiHAseYDR1fPwpw+ex/5mThA7SJ0qmOx4XQ7r2/rpyPOu5ZCUJe76
         1YqTv1cOzALJZJyMWn6737o/Kyhc+Pthairr3rspiajSrk7NLEVfq3ILYVWtFPA8EUQH
         lI+bOOVDOB4zyebBFBZsAMxm1C19qKPAV4slgAdO2lWj484xMypwpnfsRNasGMRq+dmi
         ylMD8RzaT3cj5S9SGuyLasNbiNa8/pfnDaA2sC8j4sHpIFyTrOf4r5Umq1Rq0nv/RozY
         r84Q==
X-Forwarded-Encrypted: i=1; AJvYcCV79qnUwmji5sXJUNi1rL97zouMShGb3g9y8E1p0JhS7cj2CpsF8llWJtD32OlNJyeO6IXoxszG67ExQ7k=@vger.kernel.org
X-Gm-Message-State: AOJu0YyWTzHoFxNaz0qKIe7VAU4wo+X0pT5UQb30Uvn5kS2ViSIwsy5a
	3RUkyPxNuA9H4i3UMMbGkh0XdrjLHG6JLDii8Sw3NO66AxoH5EP/J1JYm0eJg/XFMxZjpQrAiF+
	dDw==
X-Google-Smtp-Source: AGHT+IF7vPMCnsf289NsrnjjyCJ2jg68bo1NjMnBqv1ndlVw/EyDldgRRbbWWMUr551ln7/BYp8yDv7S73k=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:9d:3983:ac13:c240])
 (user=seanjc job=sendgmr) by 2002:a17:90a:2c4a:b0:2e2:d3dc:d3ca with SMTP id
 98e67ed59e1d1-2e8f0d4bd47mr35478a91.0.1730404686850; Thu, 31 Oct 2024
 12:58:06 -0700 (PDT)
Date: Thu, 31 Oct 2024 12:51:56 -0700
In-Reply-To: <20241009154953.1073471-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241009154953.1073471-1-seanjc@google.com>
X-Mailer: git-send-email 2.47.0.163.g1226f6d8fa-goog
Message-ID: <173039503553.1508387.3074658713815866060.b4-ty@google.com>
Subject: Re: [PATCH v3 00/14] KVM: selftests: Morph max_guest_mem to mmu_stress
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Marc Zyngier <maz@kernel.org>, 
	Oliver Upton <oliver.upton@linux.dev>, Anup Patel <anup@brainfault.org>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Paolo Bonzini <pbonzini@redhat.com>, 
	Christian Borntraeger <borntraeger@linux.ibm.com>, Janosch Frank <frankja@linux.ibm.com>, 
	Claudio Imbrenda <imbrenda@linux.ibm.com>
Cc: linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, 
	kvm@vger.kernel.org, kvm-riscv@lists.infradead.org, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Andrew Jones <ajones@ventanamicro.com>, James Houghton <jthoughton@google.com>
Content-Type: text/plain; charset="utf-8"

On Wed, 09 Oct 2024 08:49:39 -0700, Sean Christopherson wrote:
> The main purpose of this series is to convert the max_guest_memory_test
> into a more generic mmu_stress_test.  The basic gist of the "conversion"
> is to have the test do mprotect() on guest memory while vCPUs are
> accessing said memory, e.g. to verify KVM and mmu_notifiers are working
> as intended.
> 
> Patches 1-4 are a somewhat unexpected side quest.  The original plan was
> that patch 3 would be a single patch, but things snowballed.
> 
> [...]

Applied to kvm-x86 selftests, with the typo fixup pointed out by James.  Thanks!

[01/14] KVM: Move KVM_REG_SIZE() definition to common uAPI header
        https://github.com/kvm-x86/linux/commit/5e07fd0bf516
[02/14] KVM: selftests: Disable strict aliasing
        https://github.com/kvm-x86/linux/commit/d1ce2bcd8d2e
[03/14] KVM: selftests: Return a value from vcpu_get_reg() instead of using an out-param
        https://github.com/kvm-x86/linux/commit/5c6c7b71a45c
[04/14] KVM: selftests: Assert that vcpu_{g,s}et_reg() won't truncate
        https://github.com/kvm-x86/linux/commit/6aa2df3eb90b
[05/14] KVM: selftests: Check for a potential unhandled exception iff KVM_RUN succeeded
        https://github.com/kvm-x86/linux/commit/be9f2746d20b
[06/14] KVM: selftests: Rename max_guest_memory_test to mmu_stress_test
        https://github.com/kvm-x86/linux/commit/06694f27cfcc
[07/14] KVM: selftests: Only muck with SREGS on x86 in mmu_stress_test
        https://github.com/kvm-x86/linux/commit/8556ce365a07
[08/14] KVM: selftests: Compute number of extra pages needed in mmu_stress_test
        https://github.com/kvm-x86/linux/commit/c7b7876ac5d4
[09/14] KVM: sefltests: Explicitly include ucall_common.h in mmu_stress_test.c
        https://github.com/kvm-x86/linux/commit/a657856469e1
[10/14] KVM: selftests: Enable mmu_stress_test on arm64
        https://github.com/kvm-x86/linux/commit/1e53cde06102
[11/14] KVM: selftests: Use vcpu_arch_put_guest() in mmu_stress_test
        https://github.com/kvm-x86/linux/commit/8630563012b9
[12/14] KVM: selftests: Precisely limit the number of guest loops in mmu_stress_test
        https://github.com/kvm-x86/linux/commit/3d4585c220dc
[13/14] KVM: selftests: Add a read-only mprotect() phase to mmu_stress_test
        https://github.com/kvm-x86/linux/commit/eaafeebca75a
[14/14] KVM: selftests: Verify KVM correctly handles mprotect(PROT_READ)
        https://github.com/kvm-x86/linux/commit/a3cd5c187742

--
https://github.com/kvm-x86/linux/tree/next

