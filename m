Return-Path: <linux-kernel+bounces-448253-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F0079F3DA1
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 23:33:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E6E8B1884BAC
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 22:33:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA6B41D89F1;
	Mon, 16 Dec 2024 22:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bUgJRyml"
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 128701D63F0
	for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 22:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734388408; cv=none; b=nahdPho6F1UpzcLQmHlbotbyUHbV4Vpok1gMOV7BZDQcbprd8WZ3bPQV9K8H2DiNqXldtwG+mchzB0w+CdsFJ6F7acJimMTJa1jC5aLMUGET8icyFBZ9Nx2Q3bzFK9rsHMJ3zE12YMnXcjR/Wgp4THehJxKZoBg+k01iyCdTz9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734388408; c=relaxed/simple;
	bh=AQ6L0FE4N7ae+Cg2Eu7wbgOie9mHJiVhQr34moiqfqI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=RVBr1YMstbHizWKDqlM28A9i/DGildA+WpkE3jw0GK7r4ZU0d4So8iP6wA/H6Qzc2xAahlVfQ25X7NBQSbUolXh5K7HEQclx7MwI/yWO/Ny4/9+IECTEKrjPQXaKsSRJrYQd3yTTCQWHLKy6mDlrCGjz7/ufmTOZW3X6/QrOKm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bUgJRyml; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-2eedd15c29eso4065636a91.3
        for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 14:33:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1734388406; x=1734993206; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9jJCzoGzQp+cdjga58qGUwc3ffJR9vhNALvR1f7QLKI=;
        b=bUgJRymlxUYtLkubw2seHPAskoB6hY8bgUddpHzw1r6UwGxxMKD3Jtf8AfaAPrIu1n
         73jHT+y6D8Z8QfDC2wqSVn9L0nSFBnhkO2HK0lrmhwkuGBpM10ecYCQN+aVg3Bh9q81n
         4jyfGxceCKVMKZw0LirEBk+iYusKf5bFAzigNM+Nuq8vZAhEWEZIRomgUHhLpmy0njKT
         Ga6kWyQZ95nn6fp0gbU4IUIDDStPM1ol56mXtBY4tHpkXrFdKK/trrddUY1VyU8nMQ3R
         xWUAz9PiZeGC6gxn0N1pd+f9jrh8uYyvrkeqEedR2+S4NkWh3AcYHL/mcAiQf0cTkfuD
         eLuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734388406; x=1734993206;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9jJCzoGzQp+cdjga58qGUwc3ffJR9vhNALvR1f7QLKI=;
        b=p3ysIBAeT2j1azhebZOYqG70WN8NiCyyjxAsVDFfspmlaKr/cd7DWl1kPbhAW7PbK/
         8p1aQpDoanipfWQVhfhmKrairyXvdWcAamgneXtwDOBfcQ10+oAkmq4aKam02LhmyLMj
         WQ3UrnePEP+61F0JidP2gsrU5Jyntbgo7V0GC3r3PpOk9AU7bAthrx+jwcvWwcHxAiWH
         dI6Auk0v+/AbQaUjZKmmBVE/6x0e+j1quTcI2+AZYERaR8M8iJmUrqVBA9MA1DIUpS10
         nZ+lAiDZJ027k0iqRqBoCAS4E4w3luFegzAR6FPfnspNhIFKCXBR0SVORv14JVeKr4AH
         Tucw==
X-Forwarded-Encrypted: i=1; AJvYcCV5nLf8RkVEENcJl7nWNUPRiNPjQqvYx3IUycMXJHbiX4BQIhjRGLTcjdMEQe3uB5nNOXnEdpTWzMhZReE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyUSRPyva/9YFUkB4gQ5fPGxwPSRgoiXbQ5NyyOFRABRJRLUDfn
	0hCJqnnRrsAcXx9iCvCAuhNxhAHB/e/xf8+mdCh64Prnk35h2usfRevXRcTER5Mt9y3LjD9c6OF
	Kzw==
X-Google-Smtp-Source: AGHT+IHhtWHdid0XDbI59B1aoA+CN7rFIH/zmVAk3APPQqAwY7oJZB6TaL0aH/5JThWes+dWQrGdtB7EGl0=
X-Received: from pjd5.prod.google.com ([2002:a17:90b:54c5:b0:2ef:8eb8:e4eb])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90a:c887:b0:2ee:6e22:bfd0
 with SMTP id 98e67ed59e1d1-2f2d7eece80mr1530327a91.21.1734388406334; Mon, 16
 Dec 2024 14:33:26 -0800 (PST)
Date: Mon, 16 Dec 2024 14:33:24 -0800
In-Reply-To: <20241128005547.4077116-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241128005547.4077116-1-seanjc@google.com>
Message-ID: <Z2CqtL1R0-368hO-@google.com>
Subject: Re: [PATCH v4 00/16] KVM: selftests: "tree" wide overhauls
From: Sean Christopherson <seanjc@google.com>
To: Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>, 
	Anup Patel <anup@brainfault.org>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Paolo Bonzini <pbonzini@redhat.com>, Christian Borntraeger <borntraeger@linux.ibm.com>, 
	Janosch Frank <frankja@linux.ibm.com>, Claudio Imbrenda <imbrenda@linux.ibm.com>, 
	linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, 
	kvm@vger.kernel.org, kvm-riscv@lists.infradead.org, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Andrew Jones <ajones@ventanamicro.com>, James Houghton <jthoughton@google.com>, 
	Muhammad Usama Anjum <usama.anjum@collabora.com>
Content-Type: text/plain; charset="us-ascii"

On Wed, Nov 27, 2024, Sean Christopherson wrote:
> Two separate series (mmu_stress_test[1] and $ARCH[2]), posted as one to
> avoid unpleasant conflicts, and because I hope to land both in kvm/next
> shortly after 6.12-rc1 since they impact all of KVM selftests.
> 
> mmu_stress_test
> ---------------
> Convert the max_guest_memory_test into a more generic mmu_stress_test.
> The basic gist of the "conversion" is to have the test do mprotect() on
> guest memory while vCPUs are accessing said memory, e.g. to verify KVM
> and mmu_notifiers are working as intended.
> 
> The original plan was that patch 3 would be a single patch, but things
> snowballed in order to rework vcpu_get_reg() to return a value instead
> of using an out-param.  Having to define a variable just to bump the
> program counter on arm64 annoyed me.
> 
> $ARCH
> -----
> Play nice with treewrite builds of unsupported architectures, e.g. arm
> (32-bit), as KVM selftests' Makefile doesn't do anything to ensure the
> target architecture is actually one KVM selftests supports.
> 
> The last two patches are opportunistic changes (since the above Makefile
> change will generate conflicts everywhere) to switch to using $(ARCH)
> instead of the target triple for arch specific directories, e.g. arm64
> instead of aarch64, mainly so as not to be different from the rest of
> the kernel.

Paolo,

Unless you or someone else have concerns, can you apply this to kvm/next sooner
than later?  I'd like to start applying selftests changes for 6.14 and don't want
generate conflicts, and I really don't want to have to rebase and push this series
out again.

Thanks!

