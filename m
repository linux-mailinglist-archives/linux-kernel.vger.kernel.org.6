Return-Path: <linux-kernel+bounces-209638-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 172729038C1
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 12:23:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 27F101C23482
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 10:23:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29E87176FAB;
	Tue, 11 Jun 2024 10:22:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="M4d9YhnP"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1814714D2A4
	for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 10:22:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718101372; cv=none; b=DQ2BzJzzA9BrAlCzJ4VmRNZ07PDmMxUjjs8ntZ1SXZg++hBssvi7MCoKDHya2dHmAlf3vz2y2McVHe7/c5+hqf22jIJ7Z/+O7Tv/UIFIsMCAgyvXZsXwBGoer7SG9YsDH2yE3Cm/C4i0czn8nX1BzRAS01qWfPGNSXgvYOjBEbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718101372; c=relaxed/simple;
	bh=WT0gl6k9k3gVajA2mjXf9a2LUHhg6bhqE2LOXdj1SIs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=eJt1RSeDl9L/IKDHCXnsMis8oc1vr68H5u+OTfhGh8mH/eMWkqUi1sCzhvEVxN5QLCr0E5oECERLxXVNcb+9Gmhes40gUe/E2kQ/axB0QtmpdwfUKqL0kzR9U+dapaa1vyQV2y8TQ+zv9aJ5Z6Jj6DaNMzKl3PLmHAUCXbyuu4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=M4d9YhnP; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718101370;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=1R7i0rHLd6UEBvReX1fikUv9t87pEq723UjlWQdzxfI=;
	b=M4d9YhnP576E/xmV31NGHUWh3qzLFdz+UqfgfJ+McmC+6MwI2ii4z5md+RqBbstTS/B6cz
	KtTpmmOrSBaQw0W6YJAGPmMYXCnVnQWj6+QsWUqPbrwxYywLujAb17EdnjKX+2opcNIQcn
	iubJvb0AU7XGoExgMbce3+phGtGAgPw=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-359-T9BpuxgnPUqeRheswzeS9w-1; Tue,
 11 Jun 2024 06:22:46 -0400
X-MC-Unique: T9BpuxgnPUqeRheswzeS9w-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 42D9719560AF;
	Tue, 11 Jun 2024 10:22:45 +0000 (UTC)
Received: from virtlab1023.lab.eng.rdu2.redhat.com (virtlab1023.lab.eng.rdu2.redhat.com [10.8.1.187])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 42FA230000C4;
	Tue, 11 Jun 2024 10:22:44 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Cc: Isaku Yamahata <isaku.yamahata@intel.com>,
	Michael Roth <michael.roth@amd.com>
Subject: [PATCH] KVM: interrupt kvm_gmem_populate() on signals
Date: Tue, 11 Jun 2024 06:22:43 -0400
Message-ID: <20240611102243.47904-1-pbonzini@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

kvm_gmem_populate() is a potentially lengthy operation that can involve
multiple calls to the firmware.  Interrupt it if a signal arrives.

Fixes: 1f6c06b177513 ("KVM: guest_memfd: Add interface for populating gmem pages with user data")
Cc: Isaku Yamahata <isaku.yamahata@intel.com>
Cc: Michael Roth <michael.roth@amd.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 virt/kvm/guest_memfd.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
index 9714add38852..3bfe1824ec2d 100644
--- a/virt/kvm/guest_memfd.c
+++ b/virt/kvm/guest_memfd.c
@@ -629,6 +629,11 @@ long kvm_gmem_populate(struct kvm *kvm, gfn_t start_gfn, void __user *src, long
 		gfn_t gfn = start_gfn + i;
 		kvm_pfn_t pfn;
 
+		if (signal_pending(current)) {
+			ret = -EINTR;
+			break;
+		}
+
 		ret = __kvm_gmem_get_pfn(file, slot, gfn, &pfn, &max_order, false);
 		if (ret)
 			break;
-- 
2.43.0


