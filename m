Return-Path: <linux-kernel+bounces-182444-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A4278C8B5E
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2024 19:43:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BFADC1F265DD
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2024 17:43:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9787914265E;
	Fri, 17 May 2024 17:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ddiUDC9P"
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80FC11419AD
	for <linux-kernel@vger.kernel.org>; Fri, 17 May 2024 17:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715967606; cv=none; b=GRUAOUTKPTiPSl8q9z+Ie2ETv8orP1yvC9je9FjE/XRyJHLhPKjBQLGymIK/Mf2P976SXAXPRFxqjrt71XvF33O70y7tEXOMBdRd4Ghj/+7wNaSuq2gLqhb9dyYSMn1a41ZjYS7yp7NtGVhZHXOwImKdYUPsi3AgQsrrHAEAeBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715967606; c=relaxed/simple;
	bh=zzIqDBRAgEIRt3fg5FrSfGxYl1fjerG/V7tHwfIOdIE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=el7/DKBzYFddhiyRZ+LCNNbw13tUGEYimvHexvIhJ2qqtcLzrouGXUNNB5TsaAdUgC9JbYzWj9ionI5GX7uROJUv5E0BDMfqZz7KplhyA1gW/UY3YMWQE0sqBTiWQL84cukhh+KMdZKwoSUG3pe5Z8rbcNhUiyxoIa09Zwc4n3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ddiUDC9P; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-5e4df21f22dso7570996a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 17 May 2024 10:40:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715967605; x=1716572405; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=/QhdGtxhJBxvqCSUNKLB6DvJjtt7mVPP3auKAb2NG/M=;
        b=ddiUDC9PuTC84wjc1Fi4CgPrVe29wdneoAG0CLbUjR1SQc7ufVFlm2QSIfBwWBXtQx
         SF++3fzsjJxZwJFtyNNPtIItaXvkL4NgXiPdOkymfY7jtLHBXTmeKuSN6xQ2vcYFXzGW
         shYU9jG4GRHOz/qaO8UK+eIuTsGs2Ru1rKV75A9EalLInml4mQWmIDQyD43+rmCfwkkC
         +JjUy9+daIOm3qnRg4f9ABYaoLuZMpxXfWIg+/pd3yzlsc+obpunYjwn71jxOdMafPV4
         zQMwyi+hYQZwVEHVx738VTf7y5ZjyLwVInbXogIjHiGT9jBOUrTkct5v1TDASp8622y9
         Vm7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715967605; x=1716572405;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/QhdGtxhJBxvqCSUNKLB6DvJjtt7mVPP3auKAb2NG/M=;
        b=omh75FNofxV0Nppoem5bAak5r8PCinNpqR34Y+4VfSG+frPBczmAdjHZQkJ+grGuNn
         dq0PEQaP8R5mtBIbBm88oIJOyf2QK+x4vaSoPCEx7ltsVL+k8FUyqsgYD1G/UUjMyBM3
         g9WHZ46Ht62PsSA2MNzQyi5XQ2ryOE41+iZ4c05j8/hyvH3pRxH1ZD3i9xLrW9sXkR2p
         cF0CIwVSc9KXAl5yHcsYMqF+97gAzwRbq/ElH1SZXKL1kLq6ZizzJQK0okzQekgYe4Gb
         w3aRwByzUlDVEmT0vh7Q4oV0T9kPFFkncx1RAwxL9bds4UOIJAL+08fb8u62UXzGynTn
         Kdjg==
X-Forwarded-Encrypted: i=1; AJvYcCV5AK+JCVBQbqTZtpo3xRchq6RsarZUIrxt7q/8/slA9xZtAccsXARYQj95n5x7eiK7u37Ne0A+5fv2YXKjmoU0QlR8SbyCkyH2DZO6
X-Gm-Message-State: AOJu0Yxfh5TkMgI97YJsoyNRxDcltPa0INMjfP9UJZRTgJL0lfirARR/
	7xBEM4nwQoklziMcez4WaTinl30b6UWgJ9YADrLT4h+Uq7JXJGzsOQOhnSCxmceY317/XepYQCQ
	m4w==
X-Google-Smtp-Source: AGHT+IGXqcyVYyfsrhvREnbdq6WGI4rUGu/X6D5dsKbIh4G7tVICZ2/7A3biOpPmKuH5H/rOeO18jjJySrY=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6a02:69a:b0:5f4:246c:1406 with SMTP id
 41be03b00d2f7-6331ae42ab2mr99526a12.3.1715967604889; Fri, 17 May 2024
 10:40:04 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 17 May 2024 10:38:48 -0700
In-Reply-To: <20240517173926.965351-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240517173926.965351-1-seanjc@google.com>
X-Mailer: git-send-email 2.45.0.215.g3402c0e53f-goog
Message-ID: <20240517173926.965351-12-seanjc@google.com>
Subject: [PATCH v2 11/49] KVM: x86: Disallow KVM_CAP_X86_DISABLE_EXITS after
 vCPU creation
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Sean Christopherson <seanjc@google.com>, 
	Vitaly Kuznetsov <vkuznets@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Hou Wenlong <houwenlong.hwl@antgroup.com>, Kechen Lu <kechenl@nvidia.com>, 
	Oliver Upton <oliver.upton@linux.dev>, Maxim Levitsky <mlevitsk@redhat.com>, 
	Binbin Wu <binbin.wu@linux.intel.com>, Yang Weijiang <weijiang.yang@intel.com>, 
	Robert Hoo <robert.hoo.linux@gmail.com>
Content-Type: text/plain; charset="UTF-8"

Reject KVM_CAP_X86_DISABLE_EXITS if vCPUs have been created, as disabling
PAUSE/MWAIT/HLT exits after vCPUs have been created is broken and useless,
e.g. except for PAUSE on SVM, the relevant intercepts aren't updated after
vCPU creation.  vCPUs may also end up with an inconsistent configuration
if exits are disabled between creation of multiple vCPUs.

Cc: Hou Wenlong <houwenlong.hwl@antgroup.com>
Link: https://lore.kernel.org/all/9227068821b275ac547eb2ede09ec65d2281fe07.1680179693.git.houwenlong.hwl@antgroup.com
Link: https://lore.kernel.org/all/20230121020738.2973-2-kechenl@nvidia.com
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 Documentation/virt/kvm/api.rst | 1 +
 arch/x86/kvm/x86.c             | 6 ++++++
 2 files changed, 7 insertions(+)

diff --git a/Documentation/virt/kvm/api.rst b/Documentation/virt/kvm/api.rst
index 6ab8b5b7c64e..884846282d06 100644
--- a/Documentation/virt/kvm/api.rst
+++ b/Documentation/virt/kvm/api.rst
@@ -7645,6 +7645,7 @@ branch to guests' 0x200 interrupt vector.
 :Architectures: x86
 :Parameters: args[0] defines which exits are disabled
 :Returns: 0 on success, -EINVAL when args[0] contains invalid exits
+          or if any vCPUs have already been created
 
 Valid bits in args[0] are::
 
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index bb34891d2f0a..4cb0c150a2f8 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -6568,6 +6568,10 @@ int kvm_vm_ioctl_enable_cap(struct kvm *kvm,
 		if (cap->args[0] & ~KVM_X86_DISABLE_VALID_EXITS)
 			break;
 
+		mutex_lock(&kvm->lock);
+		if (kvm->created_vcpus)
+			goto disable_exits_unlock;
+
 		if (cap->args[0] & KVM_X86_DISABLE_EXITS_PAUSE)
 			kvm->arch.pause_in_guest = true;
 
@@ -6589,6 +6593,8 @@ int kvm_vm_ioctl_enable_cap(struct kvm *kvm,
 		}
 
 		r = 0;
+disable_exits_unlock:
+		mutex_unlock(&kvm->lock);
 		break;
 	case KVM_CAP_MSR_PLATFORM_INFO:
 		kvm->arch.guest_can_read_msr_platform_info = cap->args[0];
-- 
2.45.0.215.g3402c0e53f-goog


