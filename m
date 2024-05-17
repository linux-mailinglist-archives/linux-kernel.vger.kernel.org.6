Return-Path: <linux-kernel+bounces-182464-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6200C8C8B8C
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2024 19:49:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E0F461F211D1
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2024 17:49:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44EA7154C15;
	Fri, 17 May 2024 17:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kXhKVBRP"
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 249A115445D
	for <linux-kernel@vger.kernel.org>; Fri, 17 May 2024 17:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715967644; cv=none; b=Co3M3Sp+iVd/5LzjK2IwkU1VymxlIQq8h5BWtcpCxhT4kOYe710ZngmfknF+gKxSTdIhEysLz3Cl96dzOgLQxpE5x3gpQkRf1LwHOuwV+ub8lbIvWDnmZnG6rzLIhRaskOOGooNPaqMhr9Ir5nLGyOpvulB+eeMqE3bzzsPqaBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715967644; c=relaxed/simple;
	bh=kg0XQmVXTF7zWpc7zfBmMEfoHYByvyMTPJF15P3dX+s=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=TMuFZ/AptBmmFnnA98YT8cBWcLwZeR8W283RZlxVACiXwz8DNz7NT40TtFMcmfyO+Dr/eB+qeiNuOYUPsNTX/s41a8uu87fI+iwf1Eug2DWQZgWUhLdwXpnvSO75ouRZB8sxPHihZL9n2WlnUr8Ha7NGQnS2o87V8N0UjIzJEWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kXhKVBRP; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-1e2bbb6049eso85153865ad.0
        for <linux-kernel@vger.kernel.org>; Fri, 17 May 2024 10:40:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715967642; x=1716572442; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=W9vbUGR+ZudSgxxnkuWHpd6w+0NtOufsj8EL4oL6crU=;
        b=kXhKVBRP+2U0il4E/5Lx/qkjPjFmGzDdVa0o6WT/g3Sfa1CA1sJJGNTxTBZsztHSo7
         ep/Qqzqc5bup1GstNZE4NO8ScePXa2ISon2zKO7zo4KknXr1rTdU6fXYQXmKEU3gImn3
         cuBJPi6Sg0SSC+/aoBnx0F+IdR9pCkM/oJOBw2xIIgHnguc7dO4L3rVMOcmFgFrDa0hb
         xnwhfYbONU/EG4BOk507fBwdsf3z6dVKCPqh3N8SeovqnmkAUTYpl1BA8/heprGxf0DX
         8ZkLDrxObspS/YT7/lc6XILj+6HlHz/IgZFJvpuDO2MuHUUlagKV4c05ENcPFV9x705x
         O7YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715967642; x=1716572442;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=W9vbUGR+ZudSgxxnkuWHpd6w+0NtOufsj8EL4oL6crU=;
        b=Te/Q9KiZkSgSD40RwF/MnPYvgCr64KRS8/eJr4YsT/t3L0DS+DJozkrznTykx6/6iJ
         U6KN3blJFORpXurzRblBDVFbY+sukHQ7IVd89k9az75GIYcKyUeYIGmgeipF7PHl+jQM
         C4keQ72QmvA86TlxLvN77JZ2PNb8VAQzQtOyjlZNN6y9KVRCFl5ctgQgol3oxn8u8xrI
         4yx4Nsa9YtsVjc5pNB2T69CPgq9KaCZ+12HPKs3YI+jTfV4zqDh9/IGZWdXFCZk1gliD
         2shU+mgFMtrzd1zlQ2+5hOxkLI92DIbaw7k0rysLL1nAnLKs7eIXOP5C4xWzgS+liXog
         UMbA==
X-Forwarded-Encrypted: i=1; AJvYcCX4xSZOeO+J7b/I0ucFfMLUKf9VamArS0Enh17VLogqaL+XGNITosvDvhMXHoSbbb83hfGaHu4YPVShJhr0qo+MjoWOpFmpvxF1RYce
X-Gm-Message-State: AOJu0YyxtwDMhh4oJq30qF6w+zlRsmlZH8Z+wxps7TEIjDjuBWMMmmu0
	NbkmhmXDoy9REm5Xxd3tT2pzsvniEZW9puV4ghIPt3myCw8xbR8m/SGhJ3Lcu6PWL8IW+C89Fyx
	npQ==
X-Google-Smtp-Source: AGHT+IFmfjSwU/iAGqUQTbte+5tbw5KSaUYFsk2JVUFZezEGwqexIShDTtskVdPpfVucIRH0PNFvIZkouO4=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:902:f550:b0:1e4:3269:8c32 with SMTP id
 d9443c01a7336-1ef433d9969mr1683465ad.0.1715967642396; Fri, 17 May 2024
 10:40:42 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 17 May 2024 10:39:08 -0700
In-Reply-To: <20240517173926.965351-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240517173926.965351-1-seanjc@google.com>
X-Mailer: git-send-email 2.45.0.215.g3402c0e53f-goog
Message-ID: <20240517173926.965351-32-seanjc@google.com>
Subject: [PATCH v2 31/49] KVM: x86: Move kvm_find_cpuid_entry{,_index}() up
 near cpuid_entry2_find()
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Sean Christopherson <seanjc@google.com>, 
	Vitaly Kuznetsov <vkuznets@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Hou Wenlong <houwenlong.hwl@antgroup.com>, Kechen Lu <kechenl@nvidia.com>, 
	Oliver Upton <oliver.upton@linux.dev>, Maxim Levitsky <mlevitsk@redhat.com>, 
	Binbin Wu <binbin.wu@linux.intel.com>, Yang Weijiang <weijiang.yang@intel.com>, 
	Robert Hoo <robert.hoo.linux@gmail.com>
Content-Type: text/plain; charset="UTF-8"

Move kvm_find_cpuid_entry{,_index}() "up" in cpuid.c so that they are
colocated with cpuid_entry2_find(), e.g. to make it easier to see the
effective guts of the helpers without having to bounce around cpuid.c.

No functional change intended.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/cpuid.c | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
index 0526f25a7c80..d7390ade1c29 100644
--- a/arch/x86/kvm/cpuid.c
+++ b/arch/x86/kvm/cpuid.c
@@ -175,6 +175,20 @@ static struct kvm_cpuid_entry2 *cpuid_entry2_find(struct kvm_vcpu *vcpu,
 	return NULL;
 }
 
+struct kvm_cpuid_entry2 *kvm_find_cpuid_entry_index(struct kvm_vcpu *vcpu,
+						    u32 function, u32 index)
+{
+	return cpuid_entry2_find(vcpu, function, index);
+}
+EXPORT_SYMBOL_GPL(kvm_find_cpuid_entry_index);
+
+struct kvm_cpuid_entry2 *kvm_find_cpuid_entry(struct kvm_vcpu *vcpu,
+					      u32 function)
+{
+	return cpuid_entry2_find(vcpu, function, KVM_CPUID_INDEX_NOT_SIGNIFICANT);
+}
+EXPORT_SYMBOL_GPL(kvm_find_cpuid_entry);
+
 static int kvm_check_cpuid(struct kvm_vcpu *vcpu)
 {
 	struct kvm_cpuid_entry2 *best;
@@ -1511,20 +1525,6 @@ int kvm_dev_ioctl_get_cpuid(struct kvm_cpuid2 *cpuid,
 	return r;
 }
 
-struct kvm_cpuid_entry2 *kvm_find_cpuid_entry_index(struct kvm_vcpu *vcpu,
-						    u32 function, u32 index)
-{
-	return cpuid_entry2_find(vcpu, function, index);
-}
-EXPORT_SYMBOL_GPL(kvm_find_cpuid_entry_index);
-
-struct kvm_cpuid_entry2 *kvm_find_cpuid_entry(struct kvm_vcpu *vcpu,
-					      u32 function)
-{
-	return cpuid_entry2_find(vcpu, function, KVM_CPUID_INDEX_NOT_SIGNIFICANT);
-}
-EXPORT_SYMBOL_GPL(kvm_find_cpuid_entry);
-
 /*
  * Intel CPUID semantics treats any query for an out-of-range leaf as if the
  * highest basic leaf (i.e. CPUID.0H:EAX) were requested.  AMD CPUID semantics
-- 
2.45.0.215.g3402c0e53f-goog


