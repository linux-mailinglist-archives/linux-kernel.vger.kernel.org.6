Return-Path: <linux-kernel+bounces-441997-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 321C69ED69B
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 20:38:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AB7D228174B
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 19:38:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 255FC22966C;
	Wed, 11 Dec 2024 19:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Bvn/pJOF"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBB7F2288DC
	for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 19:37:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733945843; cv=none; b=tkCF3hCSKoMTIPglTjvXLcNj7YGbaAQ8M1KM7g1SJgMjEcZ45Nga5TJGDvNYlr3hUwSOIrsBnRcuQAdBaw2fVe7deJr2UPxbDyVHct1m9Ttx3GhOQ3MywO5EcAmlaJVpFTy8Az/aaZqhMnrAdJ7ZAxj/I8XLCmg7/SGFziDqjqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733945843; c=relaxed/simple;
	bh=SS7Zhi5P3a/TDcOuudOGTzMCPtZ3Yq/HAFx0V6V1fTM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=P3rTaoM2CbMcCIj0CtAOieFK4qej0LgDm+2dd9k9t+e+/xyPcwfsm8aJylV1hg58WShCcOdc+UXl0UTVYS0CwX7sxkq/GQYtJvtTmTognKfKdEfBBsE9PoCOFS0FQB99Vr43XAwXwXNSDjw39Qrm1G9adzbAfzrP76+vs/Z9dJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Bvn/pJOF; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733945840;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eHOQXpYW6L1pN5tyT+YAhgYu/OtoJUuGc/mmebEs6pw=;
	b=Bvn/pJOFsZ/WrsYVoISUjkR1iXu/MEqCmnzSOoE09AonrRM8OZvr+I8oKOK4t7BL6FzkLJ
	5YsoYDBMd+V8n++ZiwXyf4q0QeP7ugqQ7I2opL69BJEke4OcItuuExxIOQ30D7fO5ef4LB
	WgczTrSvQ7Fqw6BgHgROqaf4n2m34OU=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-517-ovgfeWSdNi--CCja2vZx1g-1; Wed,
 11 Dec 2024 14:37:15 -0500
X-MC-Unique: ovgfeWSdNi--CCja2vZx1g-1
X-Mimecast-MFC-AGG-ID: ovgfeWSdNi--CCja2vZx1g
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A354D195606B;
	Wed, 11 Dec 2024 19:37:14 +0000 (UTC)
Received: from starship.lan (unknown [10.22.82.46])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 414EC1956048;
	Wed, 11 Dec 2024 19:37:13 +0000 (UTC)
From: Maxim Levitsky <mlevitsk@redhat.com>
To: kvm@vger.kernel.org
Cc: linux-kselftest@vger.kernel.org,
	Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	linux-kernel@vger.kernel.org,
	x86@kernel.org,
	Maxim Levitsky <mlevitsk@redhat.com>
Subject: [PATCH 3/4] KVM: selftests: dirty_log_test: run the guest until some dirty ring entries were harvested
Date: Wed, 11 Dec 2024 14:37:05 -0500
Message-Id: <20241211193706.469817-4-mlevitsk@redhat.com>
In-Reply-To: <20241211193706.469817-1-mlevitsk@redhat.com>
References: <20241211193706.469817-1-mlevitsk@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

When the dirty_log_test is run nested, due to very slow nature of
the environment, it is possible to reach a situation in which no entries were
harvested from the dirty ring and that breaks the test logic.

Detect this case and just let the guest run a bit more until test obtains
some entries from the dirty ring.

Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
---
 tools/testing/selftests/kvm/dirty_log_test.c | 25 +++++++++++++-------
 1 file changed, 17 insertions(+), 8 deletions(-)

diff --git a/tools/testing/selftests/kvm/dirty_log_test.c b/tools/testing/selftests/kvm/dirty_log_test.c
index f60e2aceeae0..a9428076a681 100644
--- a/tools/testing/selftests/kvm/dirty_log_test.c
+++ b/tools/testing/selftests/kvm/dirty_log_test.c
@@ -227,19 +227,21 @@ static void clear_log_create_vm_done(struct kvm_vm *vm)
 	vm_enable_cap(vm, KVM_CAP_MANUAL_DIRTY_LOG_PROTECT2, manual_caps);
 }
 
-static void dirty_log_collect_dirty_pages(struct kvm_vcpu *vcpu, int slot,
+static bool dirty_log_collect_dirty_pages(struct kvm_vcpu *vcpu, int slot,
 					  void *bitmap, uint32_t num_pages,
 					  uint32_t *unused)
 {
 	kvm_vm_get_dirty_log(vcpu->vm, slot, bitmap);
+	return true;
 }
 
-static void clear_log_collect_dirty_pages(struct kvm_vcpu *vcpu, int slot,
+static bool clear_log_collect_dirty_pages(struct kvm_vcpu *vcpu, int slot,
 					  void *bitmap, uint32_t num_pages,
 					  uint32_t *unused)
 {
 	kvm_vm_get_dirty_log(vcpu->vm, slot, bitmap);
 	kvm_vm_clear_dirty_log(vcpu->vm, slot, bitmap, 0, num_pages);
+	return true;
 }
 
 /* Should only be called after a GUEST_SYNC */
@@ -350,7 +352,7 @@ static void dirty_ring_continue_vcpu(void)
 	sem_post(&sem_vcpu_cont);
 }
 
-static void dirty_ring_collect_dirty_pages(struct kvm_vcpu *vcpu, int slot,
+static bool dirty_ring_collect_dirty_pages(struct kvm_vcpu *vcpu, int slot,
 					   void *bitmap, uint32_t num_pages,
 					   uint32_t *ring_buf_idx)
 {
@@ -373,6 +375,10 @@ static void dirty_ring_collect_dirty_pages(struct kvm_vcpu *vcpu, int slot,
 				       slot, bitmap, num_pages,
 				       ring_buf_idx);
 
+	/* Retry if no entries were collected */
+	if (count == 0)
+		return false;
+
 	cleared = kvm_vm_reset_dirty_ring(vcpu->vm);
 
 	/*
@@ -389,6 +395,7 @@ static void dirty_ring_collect_dirty_pages(struct kvm_vcpu *vcpu, int slot,
 	}
 
 	pr_info("Iteration %ld collected %u pages\n", iteration, count);
+	return true;
 }
 
 static void dirty_ring_after_vcpu_run(struct kvm_vcpu *vcpu, int ret, int err)
@@ -424,7 +431,7 @@ struct log_mode {
 	/* Hook when the vm creation is done (before vcpu creation) */
 	void (*create_vm_done)(struct kvm_vm *vm);
 	/* Hook to collect the dirty pages into the bitmap provided */
-	void (*collect_dirty_pages) (struct kvm_vcpu *vcpu, int slot,
+	bool (*collect_dirty_pages)(struct kvm_vcpu *vcpu, int slot,
 				     void *bitmap, uint32_t num_pages,
 				     uint32_t *ring_buf_idx);
 	/* Hook to call when after each vcpu run */
@@ -488,7 +495,7 @@ static void log_mode_create_vm_done(struct kvm_vm *vm)
 		mode->create_vm_done(vm);
 }
 
-static void log_mode_collect_dirty_pages(struct kvm_vcpu *vcpu, int slot,
+static bool log_mode_collect_dirty_pages(struct kvm_vcpu *vcpu, int slot,
 					 void *bitmap, uint32_t num_pages,
 					 uint32_t *ring_buf_idx)
 {
@@ -496,7 +503,7 @@ static void log_mode_collect_dirty_pages(struct kvm_vcpu *vcpu, int slot,
 
 	TEST_ASSERT(mode->collect_dirty_pages != NULL,
 		    "collect_dirty_pages() is required for any log mode!");
-	mode->collect_dirty_pages(vcpu, slot, bitmap, num_pages, ring_buf_idx);
+	return mode->collect_dirty_pages(vcpu, slot, bitmap, num_pages, ring_buf_idx);
 }
 
 static void log_mode_after_vcpu_run(struct kvm_vcpu *vcpu, int ret, int err)
@@ -783,9 +790,11 @@ static void run_test(enum vm_guest_mode mode, void *arg)
 	while (iteration < p->iterations) {
 		/* Give the vcpu thread some time to dirty some pages */
 		usleep(p->interval * 1000);
-		log_mode_collect_dirty_pages(vcpu, TEST_MEM_SLOT_INDEX,
+
+		if (!log_mode_collect_dirty_pages(vcpu, TEST_MEM_SLOT_INDEX,
 					     bmap, host_num_pages,
-					     &ring_buf_idx);
+					     &ring_buf_idx))
+			continue;
 
 		/*
 		 * See vcpu_sync_stop_requested definition for details on why
-- 
2.26.3


