Return-Path: <linux-kernel+bounces-534835-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 441A9A46BA6
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 21:00:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8FB633AC198
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 20:00:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B30C27291F;
	Wed, 26 Feb 2025 19:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WZm3tfiw"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52466271818
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 19:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740599767; cv=none; b=hIysdDkJWfe5de55NoKVcQoojU0lYEZQHpbz9pwhR2Mltz1n9HsQ8ZbtG0PZauBiDcgh55SC+xtZuaZ3qUKZ2kBNP49YSOtirTAy1qHejyvSzLqnTB27oS2kUif/oM6S7RJoM3E7DWIJGog5XiOz/AGlGr0jPzTOaTMdFceruXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740599767; c=relaxed/simple;
	bh=/XPldn7ZgVhJV/uqtLlh76ZEFcT9lBeODgTAYP8GdHI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TNOciCvsGO/F3VN+rjbW1CkPm3mLLoX012D9aFkLxdb/0Gjmlpp670uzF8b0x3osIlkg1pszuRka4uymoQJplUkisYi2eah8dI6+jPL0VqQJuZgKNf8Q70Wkluo7wiTYjeqjTR1rpbk5g+9rYIzbIkSFU12xz/joRAoXPmEVxEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WZm3tfiw; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740599764;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6zLlWivfIr+fpiRMtVJ1u/lyBL3DWGusbfiE0ScUkL0=;
	b=WZm3tfiwTLTGgregb3e6dwICJMg1xz+A66VuHThceXJwegb/csM08N2Z035HHDvPzibqpw
	zGqiyuIYVrIqv2DhLTgJMkw6frwWYX1jY0amzJoA+ZPSUSWQNNqk00tHr+h5vO3Qk4iR9r
	uObVkgtiZ58Lry4/R+qcF8cX9rCvh5w=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-467-SYtEzonXN-WZqbmMBdPqRQ-1; Wed,
 26 Feb 2025 14:55:59 -0500
X-MC-Unique: SYtEzonXN-WZqbmMBdPqRQ-1
X-Mimecast-MFC-AGG-ID: SYtEzonXN-WZqbmMBdPqRQ_1740599758
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6BF64180056F;
	Wed, 26 Feb 2025 19:55:58 +0000 (UTC)
Received: from virtlab1023.lab.eng.rdu2.redhat.com (virtlab1023.lab.eng.rdu2.redhat.com [10.8.1.187])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 6E05D19560AE;
	Wed, 26 Feb 2025 19:55:57 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Cc: seanjc@google.com,
	Yan Zhao <yan.y.zhao@intel.com>,
	Rick Edgecombe <rick.p.edgecombe@intel.com>
Subject: [PATCH 20/29] KVM: x86/mmu: Bail out kvm_tdp_map_page() when VM dead
Date: Wed, 26 Feb 2025 14:55:20 -0500
Message-ID: <20250226195529.2314580-21-pbonzini@redhat.com>
In-Reply-To: <20250226195529.2314580-1-pbonzini@redhat.com>
References: <20250226195529.2314580-1-pbonzini@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

From: Yan Zhao <yan.y.zhao@intel.com>

Bail out of the loop in kvm_tdp_map_page() when a VM is dead. Otherwise,
kvm_tdp_map_page() may get stuck in the kernel loop when there's only one
vCPU in the VM (or if the other vCPUs are not executing ioctls), even if
fatal errors have occurred.

kvm_tdp_map_page() is called by the ioctl KVM_PRE_FAULT_MEMORY or the TDX
ioctl KVM_TDX_INIT_MEM_REGION. It loops in the kernel whenever RET_PF_RETRY
is returned. In the TDP MMU, kvm_tdp_mmu_map() always returns RET_PF_RETRY,
regardless of the specific error code from tdp_mmu_set_spte_atomic(),
tdp_mmu_link_sp(), or tdp_mmu_split_huge_page(). While this is acceptable
in general cases where the only possible error code from these functions is
-EBUSY, TDX introduces an additional error code, -EIO, due to SEAMCALL
errors.

Since this -EIO error is also a fatal error, check for VM dead in the
kvm_tdp_map_page() to avoid unnecessary retries until a signal is pending.

The error -EIO is uncommon and has not been observed in real workloads.
Currently, it is only hypothetically triggered by bypassing the real
SEAMCALL and faking an error in the SEAMCALL wrapper.

Signed-off-by: Yan Zhao <yan.y.zhao@intel.com>
Message-ID: <20250220102728.24546-1-yan.y.zhao@intel.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 arch/x86/kvm/mmu/mmu.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index 48a7e6f32f7f..f4e18b33a21a 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -4700,6 +4700,10 @@ int kvm_tdp_map_page(struct kvm_vcpu *vcpu, gpa_t gpa, u64 error_code, u8 *level
 	do {
 		if (signal_pending(current))
 			return -EINTR;
+
+		if (kvm_check_request(KVM_REQ_VM_DEAD, vcpu))
+			return -EIO;
+
 		cond_resched();
 		r = kvm_mmu_do_page_fault(vcpu, gpa, error_code, true, NULL, level);
 	} while (r == RET_PF_RETRY);
-- 
2.43.5



