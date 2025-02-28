Return-Path: <linux-kernel+bounces-539624-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BD788A4A6A5
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Mar 2025 00:41:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CDDAF176B56
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 23:41:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C61C1DF984;
	Fri, 28 Feb 2025 23:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="yL3slS6D"
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 871CC1DEFF5
	for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 23:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740786047; cv=none; b=CmfRK+tcjjeHOqO6stRDtoTn8l5er+ozMV4T/rYTX6hi/GK1tSnoYHdpJG5mpyVzcQWQTZHO80wICoMWCTxWD2FaGOAJnZQealGnm4UEMWWKHbQ2OR687+3HNC2sCqR7N6zSO322WTJSBJXuE5UJfbfMuwPXPHLymVGpOYHIPfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740786047; c=relaxed/simple;
	bh=AC8XMwbHhFmSqKXKyWlsiqDHWqJtawunV0ZZMBm/Dvs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=RDZQKNRQabP66zp5ZQGzO3i/BgvwkJAhUnqIHkLRu8M9D1Ekr7SzOKod+dbOht7AZwJJ/oB0LRemgvg3g43mWudjGQrT+y4iP9/IoVSzYX3H0FlJkmU0MxIsz/1Atcu84m902YxiY/mUu53qtpUWHcQwB+sD7s29W9/F1JijGf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=yL3slS6D; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-2fec3e38b60so1853685a91.0
        for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 15:40:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740786046; x=1741390846; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=nhj/DtnCZqWyMiCJ2hDRA2ltZsX5aezPM1p9WPWXep8=;
        b=yL3slS6Do2UYVDywR5cJvA3Ox/E+rmS1XbB4UzqyVoLrsomlPRClDhHR6CMqBBBtdv
         ZjunGk/NjdJAYq2xSk40YQK+kUI2/V3JrzslfwSxX08ET9I4U6V6Da6Stk3YfxOKYH07
         TfFS4xKbkfc6Kt5v2mh0uUKO4PpNssZh2+/iWYArWlirupT+Rb83cYHWHEH/0YDE9xX5
         didlsu68o4uNIGMi9eX8Ee2OMnGOWaJE2f4bRRf7IABIpQf9vLd7FfE5Xs7ajQHt24Po
         KXEbfdnfWurJdkcmFmj5Bt3EYP+1AGiTGcx82LgpEelXdJHpn2MW3kPa94twsLRK7uoM
         mTfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740786046; x=1741390846;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nhj/DtnCZqWyMiCJ2hDRA2ltZsX5aezPM1p9WPWXep8=;
        b=bWmMevbdpnnD0pbxM/YeWiqJ42+hqyH+SU+ZRHD63Vh8QbiYD6RNeaskhC0k0uiWGq
         Gs6pYq9KIxu4NoylBiOqfSOg6Nxzqd6Qoojromv7O0MmKPQ7+/mJno4L1y4Dd1FUm/lJ
         PGs+ZNgT9o1TyXtlIGsrAElfJVCwpO+KTp4MJYxrCzdt3OP2UtvQJpQ3frzQF5wsfpJf
         XcIKKE0MCw05M2AK7n5vZ/4V5uS6L2a7JrrgfAo+lZT5CCfdcl2f6J1eixts2paTlnV9
         JHsguLibu1tW/4YjpgYkTzZtL1HBbZ7UNvZtoNhrBeyYBA7TiXRltx8/nEjPukwxT2Y/
         BB6w==
X-Forwarded-Encrypted: i=1; AJvYcCXhrk9HIpz3w6oVWD7Y8dQ0Ev2gb/BlN4kpUcP9c8uEozCcM4vttbrMf5rbNTuv56+rkshnBL8OT3e61mc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1/7BcNVJpgnopIwuYSSSvDHIcq+EEhK3FujLnihWsO43WVmWm
	dF4mugB3lbiBIlxuN7lnhLhZaNvzS9E97WRuE4u2ZHJOgJSEJhfgOOVeegIdzbLCtuSREtyGFES
	zIg==
X-Google-Smtp-Source: AGHT+IEwv9xhwXFRCrRQZGEHmQLY5UzTCyaeZd4zJ/2+Pfvr4VcycsfIrpJJ0cy9aWIqXOvAKH39F1WW0B8=
X-Received: from pjbkl3.prod.google.com ([2002:a17:90b:4983:b0:2fa:a101:743])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:1a86:b0:2fe:ac91:4667
 with SMTP id 98e67ed59e1d1-2febabe1e66mr8401773a91.29.1740786045807; Fri, 28
 Feb 2025 15:40:45 -0800 (PST)
Date: Fri, 28 Feb 2025 15:40:26 -0800
In-Reply-To: <20250227222411.3490595-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250227222411.3490595-1-seanjc@google.com>
X-Mailer: git-send-email 2.48.1.711.g2feabab25a-goog
Message-ID: <174076309891.3738888.4256715219490842859.b4-ty@google.com>
Subject: Re: [PATCH v3 0/6] KVM: SVM: Fix DEBUGCTL bugs
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Ravi Bangoria <ravi.bangoria@amd.com>, Xiaoyao Li <xiaoyao.li@intel.com>, rangemachine@gmail.com, 
	whanos@sergal.fun
Content-Type: text/plain; charset="utf-8"

On Thu, 27 Feb 2025 14:24:05 -0800, Sean Christopherson wrote:
> Fix a long-lurking bug in SVM where KVM runs the guest with the host's
> DEBUGCTL if LBR virtualization is disabled.  AMD CPUs rather stupidly
> context switch DEBUGCTL if and only if LBR virtualization is enabled (not
> just supported, but fully enabled).
> 
> The bug has gone unnoticed because until recently, the only bits that
> KVM would leave set were things like BTF, which are guest visible but
> won't cause functional problems unless guest software is being especially
> particular about #DBs.
> 
> [...]

Applied 1-5 to kvm-x86 fixes (for 6.14).  I'm going to hold off on making
DEBUGCTL[5:2] reserved until at least 6.15.

[1/6] KVM: SVM: Drop DEBUGCTL[5:2] from guest's effective value
      https://github.com/kvm-x86/linux/commit/ee89e8013383
[2/6] KVM: SVM: Suppress DEBUGCTL.BTF on AMD
      https://github.com/kvm-x86/linux/commit/d0eac42f5cec
[3/6] KVM: x86: Snapshot the host's DEBUGCTL in common x86
      https://github.com/kvm-x86/linux/commit/fb71c7959356
[4/6] KVM: SVM: Manually context switch DEBUGCTL if LBR virtualization is disabled
      https://github.com/kvm-x86/linux/commit/433265870ab3
[5/6] KVM: x86: Snapshot the host's DEBUGCTL after disabling IRQs
      https://github.com/kvm-x86/linux/commit/189ecdb3e112
[6/6] KVM: SVM: Treat DEBUGCTL[5:2] as reserved
      (no commit info)

--
https://github.com/kvm-x86/linux/tree/next

