Return-Path: <linux-kernel+bounces-515923-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3ABA4A36A87
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Feb 2025 02:05:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A8D2B170C75
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Feb 2025 01:03:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8942A1FF60C;
	Sat, 15 Feb 2025 00:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nL+GAmby"
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D2B01AAA1E
	for <linux-kernel@vger.kernel.org>; Sat, 15 Feb 2025 00:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739581000; cv=none; b=G58btzYueJVTIsCg64f4Vyn0xfqdVwlIzpG3sSlj9FpLtY5VtXfcZaNPByPvbIMYT2Qyn4hcB+iVtA5W3ZG0demBXfVfaagvVibxdXVHJGbuFxwdOcpuRVzHfQW+3cfVhsOzSsfe0dOTttIp4GuCDP9XyDbrEz4WTwcSkivaEA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739581000; c=relaxed/simple;
	bh=t5fBXrvCr67phNEupZpwrfY2MdXvaC6HpdmBwzxxlCs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=cmW2ui+9bnC8v33r5pjJrzitmFo0UIDcup1832IJO8GkHmOvifVNTGscXfAAtdLJXfKYAkYUD0uYpr8Ab06XOW2SDSYS70xIbA3ZmThCYqQWuS506H1g2nIMDw+0wnyJecw9lGrQYqe+oECrTcJQ8rIOY9ioeIOBgDClFTgQllo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nL+GAmby; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-2fc1eabf4f7so4000785a91.1
        for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 16:56:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739580999; x=1740185799; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=clvSOaTIwEa9bgc9cdZpN3zTDEuSaQ80Bs4rjxPQt4M=;
        b=nL+GAmbyl9+9b3JYVKnM1ePBqRerMj8dIIY90BfUL35ojuW11jBe7z8AO05vQTsHt0
         rFOYsupumEGRaMx6/9MM4SQKbTsQGqa9m8gUWLV5Osk6B6XKL1H+bNT2EdFEROxNUPC7
         P0muIsdtFrMDY2/nhyERy/vtucM1m9p6ikJoUw0ERruK4fkv8KUnAurhq4N87CQcA66x
         9/2L3HCc0TI8GbWQmH+ftwNyPy6yvvzgJL6XIwv86CyBkOwvBkYboFJ1OgJNH37t6MKc
         Fhzd4Lkv6MDjzRuW9Hw2/tmHvH7vYrBQ5u/raQx7VnWv7yKCZ9gN6xoHDt4VeHiXHH5h
         JCPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739580999; x=1740185799;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=clvSOaTIwEa9bgc9cdZpN3zTDEuSaQ80Bs4rjxPQt4M=;
        b=qFp8VDBVOy9QKafY/OLyvz8Wb78Prce/WJ7cqHMyrfhO4YDHmlh07hf181TFSA8RXf
         spPRkVwBiYAOGOYgugOBOrByBa2QE7KWv7ePFElBG+iXMjKu4XkpYXjnji3yqp323kqe
         Hm8crJ4+Il2Ku9F4W2aLs/CGm2gYbzktVqWTeBkZZbLsNelvqvpOoCmrVDEy8dweBNga
         QG7lE9hoKCM2k1rMrUR8E6tidkruzoxU9zSxsyBWztaq42UK+lTldawoCxOMpWq9hBh/
         +gl8HMbMfm0SPkWQ19/bd0zvhU3AMBup44eLrHhASXZ9bLv361hgYEvsJvlzxqoS4sOn
         hDSw==
X-Forwarded-Encrypted: i=1; AJvYcCUrlr5RYoHnSceE49r0+DEYVy1WXayosq5MlribINcKeovsvSn2KTp/iw09rW0vBq7bxKGjYBFKhmNp3dE=@vger.kernel.org
X-Gm-Message-State: AOJu0YygYI3H0ZdW+olTfea74CLXwtCOhMW/PUDxGeTfUz47hk42354v
	RofoMZMj+PzaaR4lCQMq51dPFHs/FylTGNVmBiG4nKEzIqhrj4iEagjuYwreol1ZXnOn3Ifq2hY
	FXQ==
X-Google-Smtp-Source: AGHT+IEDBkpXU3G4/lKZrs/PoISbfgAX1w1fyvpk5cFq3/CN1zXVNsLI9tdZL04a2XEND4anIVs8+UjqyEg=
X-Received: from pjbsp4.prod.google.com ([2002:a17:90b:52c4:b0:2ef:8055:93d9])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:4a49:b0:2ea:aa56:499
 with SMTP id 98e67ed59e1d1-2fc40d13e61mr1911642a91.1.1739580998875; Fri, 14
 Feb 2025 16:56:38 -0800 (PST)
Date: Fri, 14 Feb 2025 16:50:35 -0800
In-Reply-To: <20250111005049.1247555-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250111005049.1247555-1-seanjc@google.com>
X-Mailer: git-send-email 2.48.1.601.g30ceb7b040-goog
Message-ID: <173958028389.1189761.4728178272323667525.b4-ty@google.com>
Subject: Re: [PATCH v2 0/9] KVM: selftests: Binary stats fixes and infra updates
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Marc Zyngier <maz@kernel.org>, 
	Oliver Upton <oliver.upton@linux.dev>, Anup Patel <anup@brainfault.org>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Christian Borntraeger <borntraeger@linux.ibm.com>, 
	Janosch Frank <frankja@linux.ibm.com>, Claudio Imbrenda <imbrenda@linux.ibm.com>, 
	Paolo Bonzini <pbonzini@redhat.com>
Cc: linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, 
	kvm@vger.kernel.org, kvm-riscv@lists.infradead.org, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"

On Fri, 10 Jan 2025 16:50:40 -0800, Sean Christopherson wrote:
> Fix a handful of bugs in the binary stats infrastructure, expand support
> to vCPU-scoped stats, enumerate all KVM stats in selftests, and use the
> enumerated stats to assert at compile-time that {vm,vcpu}_get_stat() is
> getting a stat that actually exists.
> 
> Most of the bugs are benign, and AFAICT, none actually cause problems in
> the current code base.  The worst of the bugs is lack of validation that
> the requested stat actually exists, which is quite annoying if someone
> fat fingers a stat name, tries to get a vCPU stat on a VM FD, etc.
> 
> [...]

Applied to kvm-x86 selftests (attempt #2).  Like the previous attempt, I skipped
the compile-time assertions.

[1/9] KVM: selftests: Fix mostly theoretical leak of VM's binary stats FD
      https://github.com/kvm-x86/linux/commit/fd546aba1967
[2/9] KVM: selftests: Close VM's binary stats FD when releasing VM
      https://github.com/kvm-x86/linux/commit/f7f232a01f3d
[3/9] KVM: selftests: Assert that __vm_get_stat() actually finds a stat
      https://github.com/kvm-x86/linux/commit/eead13d493af
[4/9] KVM: selftests: Macrofy vm_get_stat() to auto-generate stat name string
      https://github.com/kvm-x86/linux/commit/b0c3f5df9291
[5/9] KVM: selftests: Add struct and helpers to wrap binary stats cache
      https://github.com/kvm-x86/linux/commit/e65faf71bd54
[6/9] KVM: selftests: Get VM's binary stats FD when opening VM
      https://github.com/kvm-x86/linux/commit/ea7179f99514
[7/9] KVM: selftests: Adjust number of files rlimit for all "standard" VMs
      https://github.com/kvm-x86/linux/commit/9b56532b8a59
[8/9] KVM: selftests: Add infrastructure for getting vCPU binary stats
      https://github.com/kvm-x86/linux/commit/16fc7cb406a5
[9/9] KVM: selftests: Add compile-time assertions to guard against stats typos
      (no commit info)

--
https://github.com/kvm-x86/linux/tree/next

