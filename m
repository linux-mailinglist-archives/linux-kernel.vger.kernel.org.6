Return-Path: <linux-kernel+bounces-182448-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CC93A8C8B66
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2024 19:44:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 87AEA288184
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2024 17:44:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7437143C72;
	Fri, 17 May 2024 17:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="s+9kuIVP"
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3D58143880
	for <linux-kernel@vger.kernel.org>; Fri, 17 May 2024 17:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715967614; cv=none; b=nhMRkD08O6JFp+nURh+wCTB3N9130FwoNzBHppy1gdl1yKd9cQhf/u/zl8Jbmc1aSQtMPI8yNXlaH/LsgrgUTaEveSKANfzQ3vFAWVwQI+cN+2Yx+6GzL9q0g2v0lvg+RDJSl2dYmxnpUI8jdv78o0hG7kQe1IYPWtA26j+OFoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715967614; c=relaxed/simple;
	bh=JWFYm3hzYs3OhfFjHKQqDUvFKX5QGqdvk4KVBkOltW8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=iJaHWle3/1JRNRUsF8aTD2nOYpNkXfLf0ltvSxqVvp6VepxJNojJcOAMqrEzFvYvY0UGYfepUOrQ8woLaD/PuwUtDrNxh+nOmNVptzaQVDIIKckZRQby8+L7R2KRcrZKJV50XYLBbn3KvMo/1KNy9lVrZGYyrnICwjfGB68mLD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=s+9kuIVP; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-6f44e0a2756so7724590b3a.1
        for <linux-kernel@vger.kernel.org>; Fri, 17 May 2024 10:40:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715967612; x=1716572412; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=+xzcZH1oX82o+qOCBsf3LxtdbYVe7tXAJ4CjGFkhZ1E=;
        b=s+9kuIVPvj7qjbEf5NbiNyiqCOlCCPfuNSmvSaafb3/N/d9trIE9IsKqTxPGVBnf0B
         h9t2gVrPJDvnBATNw1Wvb7V0RzUPKrCM3wI6Q84jpeiVxHYgB8Xdv/k58HLvmjaMZJCb
         YHAsxhlB1RDJEznXSjEdrXFFzK+YeWX8A8fdLxSrfK5/7HYjo7o/KvX7j+idKeX3KRei
         8vq8ijyGJbb1XUZHWNnAYSrP2ykBBBGu9xEfT6nyVIazzYnPILudcQYMosFlPfznbh7M
         Hf7h5ZDdhcF3C9/WjpdsPb8bAqF9aWDaqw1IB+2wpt4EfReiMQLJiiRE3SERNGkhAQvH
         oxgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715967612; x=1716572412;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+xzcZH1oX82o+qOCBsf3LxtdbYVe7tXAJ4CjGFkhZ1E=;
        b=i6xYhvq/IIHqLJkq8WFcNPvjUvJf/1ughRfMDv/j72hIKat3dGdFyTil9zh8HHmb7B
         Tc4iVH/9Hdv9wyO33HCfeLvyJhJZqOk09DSZKBFnhLbzksrA7KPr4QIWecbOviN0X+ZN
         XHtAnuU30T6yko4QsViWPV044pagIA5Xh1CSJvWuSinyEfiIKlK2BqpUb/JxDBvMmj5k
         8ic0wf6NgbtAnfftmrVMt5Z9cXWD8CWkEFjZNAQbSqOvskUtG81tv9E3mOl6p1mmtO0U
         np44H0GOpXHr4mVro8k/EiBQDbUNQdYDPhy9cH1h0kurQ9LwTxLpPjUZGZ8yDhzCHxT9
         d5iw==
X-Forwarded-Encrypted: i=1; AJvYcCXI0NoEBXVq11VuUWcSDQsJuZ1jtu2kru+NipAQQazM1zFkOVBz8LL/AVPlYxx93G73F8rOak+m3abWXyp9XwJ8cVAGp8k92nv5uk9A
X-Gm-Message-State: AOJu0Yx5+fQh8sF+aps12GUeIaqmDzTsPvGMydDhPLvsx3r9nKAqhDq/
	Edlpw3rSh782sTaGWLGXcTQ3VN/NnLqVwFwbpixfMPR6i/tXlQHcf8+a6/BTMH5FEmdBL5MzhYa
	Y/g==
X-Google-Smtp-Source: AGHT+IGsN6Qh61VqtBf96frE+hd3CwAur9vrPpJuALwxwHlbxVPzVF/y8P8dpbLdPI8ksAq7YkoDW5FYIR8=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6a00:390d:b0:6eb:1d5:a3a with SMTP id
 d2e1a72fcca58-6f4df3b1c35mr975367b3a.1.1715967612089; Fri, 17 May 2024
 10:40:12 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 17 May 2024 10:38:52 -0700
In-Reply-To: <20240517173926.965351-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240517173926.965351-1-seanjc@google.com>
X-Mailer: git-send-email 2.45.0.215.g3402c0e53f-goog
Message-ID: <20240517173926.965351-16-seanjc@google.com>
Subject: [PATCH v2 15/49] KVM: x86: Zero out PV features cache when the CPUID
 leaf is not present
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Sean Christopherson <seanjc@google.com>, 
	Vitaly Kuznetsov <vkuznets@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Hou Wenlong <houwenlong.hwl@antgroup.com>, Kechen Lu <kechenl@nvidia.com>, 
	Oliver Upton <oliver.upton@linux.dev>, Maxim Levitsky <mlevitsk@redhat.com>, 
	Binbin Wu <binbin.wu@linux.intel.com>, Yang Weijiang <weijiang.yang@intel.com>, 
	Robert Hoo <robert.hoo.linux@gmail.com>
Content-Type: text/plain; charset="UTF-8"

Clear KVM's PV feature cache prior when processing a new guest CPUID so
that KVM doesn't keep a stale cache entry if userspace does KVM_SET_CPUID2
multiple times, once with a PV features entry, and a second time without.

Fixes: 66570e966dd9 ("kvm: x86: only provide PV features if enabled in guest's CPUID")
Cc: Oliver Upton <oliver.upton@linux.dev>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/cpuid.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
index f756a91a3f2f..be1c8f43e090 100644
--- a/arch/x86/kvm/cpuid.c
+++ b/arch/x86/kvm/cpuid.c
@@ -246,6 +246,8 @@ void kvm_update_pv_runtime(struct kvm_vcpu *vcpu)
 {
 	struct kvm_cpuid_entry2 *best = kvm_find_kvm_cpuid_features(vcpu);
 
+	vcpu->arch.pv_cpuid.features = 0;
+
 	/*
 	 * save the feature bitmap to avoid cpuid lookup for every PV
 	 * operation
-- 
2.45.0.215.g3402c0e53f-goog


