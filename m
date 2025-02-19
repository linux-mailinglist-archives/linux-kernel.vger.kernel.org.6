Return-Path: <linux-kernel+bounces-520759-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B263BA3AEDC
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 02:27:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B87A5188D9BB
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 01:27:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF44D84D0F;
	Wed, 19 Feb 2025 01:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OPcDgQX9"
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C451D5336D
	for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 01:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739928430; cv=none; b=StJt8eG8Jkiwq4UEAeE1cVfVeIHJ6IGhUf4n8mpWBNEWR0D1EpB4TJK8HZc84e2t4yIzkRKt8qCkoDHRZQUwhlj04KCLfKMfFkq4BWu01PfYio0HtUpITps/6mYRgpB8pURr1uHGwwXJb5e8nprUY3LH3qbupg5Lxe9bzSLh2CE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739928430; c=relaxed/simple;
	bh=exShF3Jms5ap2aAuImaKw8KZckFL9+mG6aZKRU3W4nM=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=r79SG1A1aIqZE+DxTeZ6WC+9cRyjXStmYIGMuKAZyRoN/Kf08QwSTR8K2FPPi/Atc2lICnVJlEfeIdIXuRfDd0ZbVqzreg3nxAh4O+BlJ7O/+B6yGpMQtA/joDEICQhBPqhpRZ0hLEsrElyob8+DrQUy53IGa+6ZSFX8a7Z+cEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OPcDgQX9; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-220e04e67e2so161920675ad.2
        for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 17:27:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739928428; x=1740533228; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oMOZDM8xcXZ3hDCyKFDMjTBZKyrAQ3OwkqnB3/wSmXw=;
        b=OPcDgQX963cGTdytohRI/LhPr7bw1tD/rqlNlAspb1XTTAslJvyQN+CLOcGKlfQzmm
         UVKbbnJFNy9rQjRH3Y+5PrC7Jn3jzDAUVryV8evixGx9YQLUIRPDZntjPvFfw6wnGaul
         jghe6DfNoNsKrFggdEMx12bkW7OD1Gu36S16PTItd14KLHl0twVIqvMoth9Bo8HuvFPQ
         UblNX5EM70pBs2Mg6LNH5nzVV/X0UeAmwnUHq/Jxy5ZHDmo3pTNuzFNfq8RHu++OT3VF
         W1okUK9kjLm6d7G83kxRH7u3bxH97qKkUsrRUYv2RwgeeBuAFgcmH9mdRyQ8QGl5SJbf
         /a+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739928428; x=1740533228;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oMOZDM8xcXZ3hDCyKFDMjTBZKyrAQ3OwkqnB3/wSmXw=;
        b=szAXSgyA27UbQ89EpjpBlSNk7zWtYtNDC+VjtsB+HH8KqgequRsLE7XVWs3CxTZsW/
         zXZV6ukC3xiVXM9kw1dqSzNSH6TuGT82yy7frlcg7mxN8sltGfQp32h6lSTBfJg9kWBH
         t3kSiqdeXB7LgEiCxDOLIn4+EYRWkwNYg/gpju27UTVbC2Ywf+Nvu7PrnXacVti1wV+R
         KI1JdKOr0/tX9i9RU/YH72K8/+kdarhdQCut98hRXMgPTtME7+EEJKnOnlQi9KwzfgKy
         BkBO/wktDGT2QrhgQn5MiRNJrW8x1IF6WNtudytSHbFSZ6JnbY/xoqA1EsxAvf9BaofI
         CbKA==
X-Forwarded-Encrypted: i=1; AJvYcCUSHLqw9xhYrnjdf8X1Nw/s/QLg8eO8Dimb1xck+G4CLxOgcXMGFkxcJxcJcGTdwNpbgP/pqdKb5GKh6P8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxVVKrbmavBBknNIlbCP3dKrmFJEYkAcDlr9TvRIFArRFIfIBng
	0u0Iao0wzHnNdfBBmx2FJUiPCfGgiyKYm1vGsoKdJdHFCxjDAC9bUXIuEPuRpe3FPVEVjJFR+Ur
	b2w==
X-Google-Smtp-Source: AGHT+IGg4/+Z632vwDAzljKVNGaUy1dvH4zOerOMi3O3noRyOOumQGKZoWK0rtlraamdCnEjOsGhZJgMx44=
X-Received: from pjbrs16.prod.google.com ([2002:a17:90b:2b90:b0:2fc:1e77:d6b6])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:ea08:b0:220:ef79:ac9d
 with SMTP id d9443c01a7336-2217098bff3mr25912075ad.31.1739928428089; Tue, 18
 Feb 2025 17:27:08 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Tue, 18 Feb 2025 17:26:55 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.48.1.601.g30ceb7b040-goog
Message-ID: <20250219012705.1495231-1-seanjc@google.com>
Subject: [PATCH 00/10] KVM: SVM: Attempt to cleanup SEV_FEATURES
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Naveen N Rao <naveen@kernel.org>, Kim Phillips <kim.phillips@amd.com>, 
	Tom Lendacky <thomas.lendacky@amd.com>, Alexey Kardashevskiy <aik@amd.com>
Content-Type: text/plain; charset="UTF-8"

This is a hastily thrown together series, barely above RFC, to try and
address the worst of the issues that arise with guest controlled SEV
features (thanks AP creation)[1].

In addition to the initial flaws with DebugSwap, I came across a variety
of issues when trying to figure out how best to handle SEV features in
general.  E.g. AFAICT, KVM doesn't guard against userspace manually making
a vCPU RUNNABLE after it has been DESTROYED (or after a failed CREATE).

This is essentially compile-tested only, as I don't have easy access to a
system with SNP enabled.  I ran the SEV-ES selftests, but that's not much
in the way of test coverage.

AMD folks, I would greatly appreciate reviews, testing, and most importantly,
confirmation that all of this actually works the way I think it does.

[1] https://lore.kernel.org/all/Z7TSef290IQxQhT2@google.com

Sean Christopherson (10):
  KVM: SVM: Save host DR masks but NOT DRs on CPUs with DebugSwap
  KVM: SVM: Don't rely on DebugSwap to restore host DR0..DR3
  KVM: SVM: Terminate the VM if a SEV-ES+ guest is run with an invalid
    VMSA
  KVM: SVM: Don't change target vCPU state on AP Creation VMGEXIT error
  KVM: SVM: Require AP's "requested" SEV_FEATURES to match KVM's view
  KVM: SVM: Simplify request+kick logic in SNP AP Creation handling
  KVM: SVM: Use guard(mutex) to simplify SNP AP Creation error handling
  KVM: SVM: Mark VMCB dirty before processing incoming snp_vmsa_gpa
  KVM: SVM: Use guard(mutex) to simplify SNP vCPU state updates
  KVM: SVM: Invalidate "next" SNP VMSA GPA even on failure

 arch/x86/kvm/svm/sev.c | 218 +++++++++++++++++++----------------------
 arch/x86/kvm/svm/svm.c |   7 +-
 arch/x86/kvm/svm/svm.h |   2 +-
 3 files changed, 106 insertions(+), 121 deletions(-)


base-commit: fed48e2967f402f561d80075a20c5c9e16866e53
-- 
2.48.1.601.g30ceb7b040-goog


