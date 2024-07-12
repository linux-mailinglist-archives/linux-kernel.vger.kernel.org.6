Return-Path: <linux-kernel+bounces-251247-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BF4293029A
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jul 2024 01:59:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B457E1F225A5
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 23:59:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83A3413C68E;
	Fri, 12 Jul 2024 23:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hG1bihRk"
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A23613C9AE
	for <linux-kernel@vger.kernel.org>; Fri, 12 Jul 2024 23:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720828643; cv=none; b=KVWmPC+3irnM5rBqspgVGR9WTYqS9H2Sy7EoYdrrO6OLare9voO7kauFruqe5nmXkmJwmhnMLH11LUBcKpTtX5Aufwod6rQaKDbUOd4khPUY8moxt0YMB3CX8L8lyKErst5uTzoA7Id5HpLjh8G5Bs89YkoYFDoff+4HWFb9gyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720828643; c=relaxed/simple;
	bh=p11QpoRvsIKvJqP1fnQdOFZ4Tob+FZZ5L9KMK41U41o=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=sEBzcAOlP6q77fv3Wuuq2FMexIZn4gdRo/bHn6k3AX+g5VlFwSpdVCQYBfoXvDDrJBeU0tNu1LeTyz95RvMqigoEqciq7OLwFdLJjI8MGr4ffEqW8ezktl76F7inOoasMeMqCIP33AJr1zRE1Y9JAvwVu4IWiWN6TzeYGkDeUx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hG1bihRk; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-1fb90d7a4c3so20259645ad.1
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jul 2024 16:57:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1720828642; x=1721433442; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=qiVWRvv1F8e3dUvL1Y2M8rT+xfhgXW0ORg8RyR//qdc=;
        b=hG1bihRkHZ41SeVCT3lSdohxgYdDELi/uQfrzmth5ZiVsZSqoN+zraECIc6j7JEVyL
         q5IyWiajFTU8QPcxfKmPw7s+kgf1WcHfrfvLUPycG6ilMdRswwW6auniFAOti2bQhX6q
         lVq88Tuyylkwql13eY1IpEhy6B/tB4yoqgnnWgO3Uu1IjORUMvEwxjfuNoyJZ6iN+xM1
         RNcHwWrf/44Dj1LUTaGX+ULL+iQLBpk/B/T709EYwIjxhdm2Mbe82xlBuJ45r7BTelZY
         0IdxTgMvisZBZDKmO/b0lIX4v02yFgVcmnoj4LXIGHSiimu5Nyf5q+syZr5wNrv4V0Wj
         fGqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720828642; x=1721433442;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qiVWRvv1F8e3dUvL1Y2M8rT+xfhgXW0ORg8RyR//qdc=;
        b=X1kkQLRue7yD+eiZaP+0SwCU9E35Gi2iY1CqJH8svyGw2VKmwNe11zWYH1E/FCgGgd
         trzqjX6Jqt/kTsD/TZy2uWYGFWeif5F9LNFM5IfGpDKVb2lI0TdQs8OXqwoad45fy1Oa
         Og0J/DsoXkOMqQut6UdyULmGVSxD6ubsTvzcClNsWw8sPNLu1a1qxGYxK+fuQ99DJipN
         9YwyG0lvMMKFslBYiDS2BWdndroPmrIYHlBRDh2YZYxwfr1VK4MyZwTkQ+JNVsksC97b
         oiE1VoHlWJCvHcPwP+9aTFxf8iTnzvqaDgXYfpeXUvEGGvVn0wYnFhtzrEVI1oRUDTnJ
         mYWg==
X-Forwarded-Encrypted: i=1; AJvYcCW45oJmQv22vdJ310OPB0CdUXwrhkxFH7jpHv6h6gtdKkzV8YrVsH3FZdnHVWsKyRjl+7HE3h5n5u0Q8pI0fMHW/MCxknTKB3QUzHzr
X-Gm-Message-State: AOJu0YzrFHIpIN0AqTa+CJorrD5MgvVfhZyVy7IP0Er7EkJXknADQTtf
	mSno9NzVM9p86LOJHyER8KGGR1Rr9HNzfctrBXwkrFeAkIUbnfhF7JRUT940uKdvDpNmBIQGIzj
	OkA==
X-Google-Smtp-Source: AGHT+IHPGZpyXCcBFMuLXhSVmPz5d91R37FEN+a4UtSf2JWGbSD75qYm1YYZE9baRXQPgTH07m7NoTEPXyM=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:903:1109:b0:1fb:4b87:6ea4 with SMTP id
 d9443c01a7336-1fbb6cf0feemr6807315ad.6.1720828641744; Fri, 12 Jul 2024
 16:57:21 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 12 Jul 2024 16:56:59 -0700
In-Reply-To: <20240712235701.1458888-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240712235701.1458888-1-seanjc@google.com>
X-Mailer: git-send-email 2.45.2.993.g49e7a77208-goog
Message-ID: <20240712235701.1458888-10-seanjc@google.com>
Subject: [GIT PULL] KVM: x86: SVM changes for 6.11
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Sean Christopherson <seanjc@google.com>
Content-Type: text/plain; charset="UTF-8"

Another small pull request.  Embarrasingly, I'm pretty sure Google has been
carrying a patch to make the per-CPU allocation NUMA-aware for many years :-(

The following changes since commit c3f38fa61af77b49866b006939479069cd451173:

  Linux 6.10-rc2 (2024-06-02 15:44:56 -0700)

are available in the Git repository at:

  https://github.com/kvm-x86/linux.git tags/kvm-x86-svm-6.11

for you to fetch changes up to 704ec48fc2fbd4e41ec982662ad5bf1eee33eeb2:

  KVM: SVM: Use sev_es_host_save_area() helper when initializing tsc_aux (2024-06-28 08:53:00 -0700)

----------------------------------------------------------------
KVM SVM changes for 6.11

 - Make per-CPU save_area allocations NUMA-aware.

 - Force sev_es_host_save_area() to be inlined to avoid calling into an
   instrumentable function from noinstr code.

----------------------------------------------------------------
Li RongQing (3):
      KVM: SVM: remove useless input parameter in snp_safe_alloc_page
      KVM: SVM: not account memory allocation for per-CPU svm_data
      KVM: SVM: Consider NUMA affinity when allocating per-CPU save_area

Sean Christopherson (2):
      KVM: SVM: Force sev_es_host_save_area() to be inlined (for noinstr usage)
      KVM: SVM: Use sev_es_host_save_area() helper when initializing tsc_aux

 arch/x86/kvm/svm/nested.c |  2 +-
 arch/x86/kvm/svm/sev.c    |  6 +++---
 arch/x86/kvm/svm/svm.c    | 23 ++++++++++-------------
 arch/x86/kvm/svm/svm.h    | 18 +++++++++++++++---
 4 files changed, 29 insertions(+), 20 deletions(-)

