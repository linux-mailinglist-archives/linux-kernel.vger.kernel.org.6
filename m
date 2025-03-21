Return-Path: <linux-kernel+bounces-572036-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 06969A6C5B9
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 23:16:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4F9E31B62216
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 22:15:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F01A7231A3F;
	Fri, 21 Mar 2025 22:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vJuJtnCx"
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F39D628E7
	for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 22:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742595302; cv=none; b=sIvePI+A1bnXyKNt25J66WJjprMzsXJfHepgWKOfIjoDXgyZhVtox4X2CKB3ceS6F+nw6JaErbUTzgw+HWesyyt5OtJuIduv9w2WXBdJdIAlPV7tiVydw2kfKfAu4dIno1qQMJDFmEHOzaoaKfXhoNW1OgkCJ7l7thIb6/Q77kQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742595302; c=relaxed/simple;
	bh=NPx5hgwLn/mzDYrm99FpYVYQnE7Gcf2Lkd9dI+JFYfA=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=VRjeuxPapU/m6l088uqTA670Esr863YFDl0z7ahCsvSJJqcMO3B9Sy3dtHcrTeK2tsX3X4plR0xNpd1k3bY+gj6AiNy9eL3V/NCxTwVsixFlaVB1ak1kPVXcvlajTDVOaJThUrwwsTmCJiTcIzNW8PcBkQ7oBHI2XTWD/kGc6M0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jmattson.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vJuJtnCx; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jmattson.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-2ff53a4754aso6545889a91.2
        for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 15:15:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742595300; x=1743200100; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=gder4ZBeakmzoOVPhL4CX5O/w/7AtN56Adx2b1zHtms=;
        b=vJuJtnCxqUYXZ/2mT1OG47xJpsbWCQomg2qZ4IGKbu3fTWsLkh5Axw5bcXHMtUvFpM
         8j+xGCwlAWr+TOUV9tKW5S3DcsrXVJxI9rSPmvOSXz5iPBw7EOsKjg6wvmNN6+FxHwmZ
         vMKEKLTEB6B4zOi5Jgx4Jg+vc9CtdfWv24CanHBNL+ozWGxQxqv4yPLmMeVufQ14xt3r
         hWfY13cT4h7q7KXyoRLcjmmu6eokMTguhIwvWKr8UAr26MBqnBgTOQ51KPCv6KqAyv3x
         f+bDfedC/xuEe8BlR2743QgyLWObODXlhIt4hZhoSj+8O7fbD287TJRb3k6pRfjUFErp
         CXmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742595300; x=1743200100;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gder4ZBeakmzoOVPhL4CX5O/w/7AtN56Adx2b1zHtms=;
        b=bLxA7A260pEUzOufr/0jX26dbc6T9l5xcAvZCBFuTS25KfAiAorMckNa4yyS874yyp
         Do0Qeqw8bgRyMzjQwZdSQhTYN+iCjt3C559dYQMBGqPyj6ZYMN5yTFlqZg0MAGmSFiWd
         QjzLhEPVaTBV7bqPmAz9lLWOiKiRoriWs4JoFroKoHHAm14eSN02RPozeKT8a5LUVa8u
         LlniHac52NB7xFf2WYBAwa78N1w4PK1dJv+uSopCw3DGJzTTZrQVSI0Hc0KkXwVbqU5s
         rBHI5/C3tYyV5GKaxGZlwDKhK3ilzZoqe96+BW6KTt6JTFmsMs4rcCclAJOY+fS1vjkr
         OYFA==
X-Gm-Message-State: AOJu0YzEEL+LI1GTVV2Y4sKe23zm/P2SKjeSCu9PNdxXZv4x0GzxPuZA
	TaFGBSl94xqzIqdZD2FEusrjQVQvOl5NYSytQCcbbz3Z/aftKChxJdh66YC7yh10bfjBHicnmEX
	VnqkTviRvWoKdyiadXntz1u1CnQuMi3vR2XirHZF9J7vOrdCttuDsxXaYlO472h71XwKZRyoMDE
	NlguW0sogVlmrZiDQpxVkoCwVT5CJEops355Y3BR/ilUUcfY5hJjo=
X-Google-Smtp-Source: AGHT+IF5w0t2qfhlsv5r6Ydy0x+ymrJUxEI6TT+RPvL+KWo7KyBDAXfDTqZ2P8K5xXqmj3lr2SY2M/S6ki5lzg==
X-Received: from pjbsc4.prod.google.com ([2002:a17:90b:5104:b0:2fc:2e92:6cf])
 (user=jmattson job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:2747:b0:301:1bce:c258 with SMTP id 98e67ed59e1d1-3030feeb4c6mr6805659a91.22.1742595300337;
 Fri, 21 Mar 2025 15:15:00 -0700 (PDT)
Date: Fri, 21 Mar 2025 15:14:29 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.49.0.395.g12beb8f557-goog
Message-ID: <20250321221444.2449974-1-jmattson@google.com>
Subject: [PATCH v3 0/2] KVM: x86: Provide a capability to disable APERF/MPERF
 read intercepts
From: Jim Mattson <jmattson@google.com>
To: linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: Jim Mattson <jmattson@google.com>
Content-Type: text/plain; charset="UTF-8"

Allow guest reads of IA32_APERF and IA32_MPERF, so that it can
determine the effective frequency multiplier for the physical LPU.

Commit b51700632e0e ("KVM: X86: Provide a capability to disable cstate
msr read intercepts") allowed the userspace VMM to grant a guest read
access to four core C-state residency MSRs. Do the same for IA32_APERF
and IA32_MPERF.

While this isn't sufficient to claim support for
CPUID.6:ECX.APERFMPERF[bit 0], it may suffice in a sufficiently
restricted environment (i.e. vCPUs pinned to LPUs, no TSC multiplier,
and no suspend/resume).

v1 -> v2: Add {IA32_APERF,IA32_MPERF} to vmx_possible_passthrough_msrs[]
v2 -> v3: Add a selftest

Jim Mattson (2):
  KVM: x86: Provide a capability to disable APERF/MPERF read intercepts
  KVM: selftests: Test behavior of KVM_X86_DISABLE_EXITS_APERFMPERF

 Documentation/virt/kvm/api.rst                |   1 +
 arch/x86/include/asm/kvm_host.h               |   1 +
 arch/x86/kvm/svm/svm.c                        |   7 +
 arch/x86/kvm/svm/svm.h                        |   2 +-
 arch/x86/kvm/vmx/vmx.c                        |   6 +
 arch/x86/kvm/vmx/vmx.h                        |   2 +-
 arch/x86/kvm/x86.c                            |   8 +-
 arch/x86/kvm/x86.h                            |   5 +
 include/uapi/linux/kvm.h                      |   1 +
 tools/include/uapi/linux/kvm.h                |   4 +-
 tools/testing/selftests/kvm/Makefile.kvm      |   1 +
 .../selftests/kvm/x86/aperfmperf_test.c       | 162 ++++++++++++++++++
 12 files changed, 196 insertions(+), 4 deletions(-)
 create mode 100644 tools/testing/selftests/kvm/x86/aperfmperf_test.c

-- 
2.49.0.395.g12beb8f557-goog


