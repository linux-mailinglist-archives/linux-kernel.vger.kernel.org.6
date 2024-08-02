Return-Path: <linux-kernel+bounces-273062-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BD8894642F
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 22:01:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CC4651C218CC
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 20:01:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76BFF6E5FD;
	Fri,  2 Aug 2024 20:01:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iY4aMvDW"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBC311ABEC2
	for <linux-kernel@vger.kernel.org>; Fri,  2 Aug 2024 20:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722628902; cv=none; b=rGlogFkg37gkIQo16ewH/WkKT0sqUm7mdLOZonp4YbIATLyLZNL6Gsaua95GhkQL4EqHxf1uk1zVI3nUwzHFNX0/mXUD36ccoHjDquTYH5PjUkhpzTKAnHeRnV6I2JIUEGGvXlVF+e4qh4maVIxH8VQb/4f7US7WwwwTJ084Cek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722628902; c=relaxed/simple;
	bh=g97mdCp4arIit1LwToTZXmazYyh6y72jv1vjtPPZOik=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=SrLg3HG4Z7RrVS1q4nZN2lzP1jLMuqnmJaGhg5Z7/5cCt0eyI1gkoe4ECqyhXlTMX5H21tYKNnnZdzDPhdj1sxx1SaLb8R/CwFadhM4ME9N+rjnVcOvLOLUtSW5/th5GKACiNGZxvYdRRMBUmJfwIqJCenKR2goejLG6YfBph8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=iY4aMvDW; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e03a544b9c8so12040495276.2
        for <linux-kernel@vger.kernel.org>; Fri, 02 Aug 2024 13:01:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1722628900; x=1723233700; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ykPdpt4afpZ3jpFw7YSK1YDxe3tZo0sfBfoXskTzJEA=;
        b=iY4aMvDWAEYYGlFPUmAiQcMvzMN+X6yDNL3xTNmuoI23jA/NeADMpTZJn9dsRKoZq4
         q5wEfMOO1rHT5p7dQa12LjWaSVisJNfkgTzIq1LtWiBHoySEA3Ruhsvrrc4cgAqsyIgB
         PXBU1N2hi+o0I1CR3dA4Uz403bPAT5EGJE0RwTkD64ZbtG+f3gB64NzOiiGNgJ9IybbL
         9glEylqWfJVe+w0GZD4Wfr49MPMAP7ncIzCmcl5d3ggvLy/nnggCXpQKBqpxDMsRTrgS
         pibEdqC5fkHhqyf+rtlZYw3zcnbaySX0TXHtWPTPQ6fHYBR3622WjTzp3aTLuSBV8cU6
         1CpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722628900; x=1723233700;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ykPdpt4afpZ3jpFw7YSK1YDxe3tZo0sfBfoXskTzJEA=;
        b=K0JvA+VsceOuoJf+FVrdFn4ix9y9tIAniYZ5zVC2ontwq3lCQwkWDimRxmCiRd1xBZ
         6wq1GW6osgbFdrCjZpKERDTacbf7JNq161ZyQVc+fJUfxrZUOjLf0RV3Q13OiVN4gsxN
         C3ZZzndO3k+PbjRSnQuoIgNYIiKOUeOupHRyePJ9hqdwTaP4T3Zbb4xzZ2h9XPYqqdc8
         yUNIjnN+1nm+/OSOQS056z9urd5cd2YxcHa7m5Yf+R+PzfTSfs/YkJTqGjQNRSKpP829
         yrDI3+27FopTI8pGIUmvJbvtFFCfof/9A2Qjlj+uqNvw+c9UnWGqFbeK5C0ci5dgSp5A
         TnaA==
X-Forwarded-Encrypted: i=1; AJvYcCXGEUngLws9y3jAxg1WKsq2k1f7TBGpBnE/cGgn7jMwcqEvO7+N/I/9ZicVLs1E3zc6eOIKpIq+QmRSgdSUzK2vBI4VF95iQWIlP51z
X-Gm-Message-State: AOJu0YxGWtqU17PWrNtFjw2Xy5w5Xie9jGFTd6Vugfuh66kqMQ7pVR+s
	duXHEwhTF8AglaQQAQK2vg3Y1OP/DkylXO6MGGHKVGxX42UD2zT1hkCgx6UBog+eyp5gkG8l/r/
	6Tw==
X-Google-Smtp-Source: AGHT+IFmEjE0twSlJTivyvNHNugTEVFQQZk8biWQMQbekPfidDKP6UgVbg8OwPEN3Johcfln+K3aJZ+eKcI=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a25:8601:0:b0:e05:f1ad:a139 with SMTP id
 3f1490d57ef6-e0bde435653mr6717276.11.1722628899703; Fri, 02 Aug 2024 13:01:39
 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri,  2 Aug 2024 13:01:34 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.46.0.rc2.264.g509ed76dc8-goog
Message-ID: <20240802200136.329973-1-seanjc@google.com>
Subject: [PATCH 0/2] KVM: Protect vCPU's PID with a rwlock
From: Sean Christopherson <seanjc@google.com>
To: Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>, 
	Paolo Bonzini <pbonzini@redhat.com>
Cc: linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, 
	kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Sean Christopherson <seanjc@google.com>, Steve Rutherford <srutherford@google.com>
Content-Type: text/plain; charset="UTF-8"

Protect vcpu->pid with a rwlock instead of RCU, so that running a vCPU
with a different task doesn't require a full RCU synchronization, which
can introduce a non-trivial amount of jitter, especially on large systems.

I've had this mini-series sitting around for ~2 years, pretty much as-is.
I could have sworn past me thought there was a flaw in using a rwlock, and
so I never posted it, but for the life of me I can't think of any issues.

Extra eyeballs would be much appreciated.

Sean Christopherson (2):
  KVM: Return '0' directly when there's no task to yield to
  KVM: Protect vCPU's "last run PID" with rwlock, not RCU

 arch/arm64/include/asm/kvm_host.h |  2 +-
 include/linux/kvm_host.h          |  3 ++-
 virt/kvm/kvm_main.c               | 36 +++++++++++++++++--------------
 3 files changed, 23 insertions(+), 18 deletions(-)


base-commit: 332d2c1d713e232e163386c35a3ba0c1b90df83f
-- 
2.46.0.rc2.264.g509ed76dc8-goog


