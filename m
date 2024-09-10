Return-Path: <linux-kernel+bounces-324025-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 78A0F9746ED
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 01:56:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 37F5D283EF4
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 23:56:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 793D81C32EE;
	Tue, 10 Sep 2024 23:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XCVC0DPY"
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BCB51C2DBB
	for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2024 23:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726011933; cv=none; b=ZqfiKcnSH+eGPdJShLx4fUeEh5zRIGDMrTTyldLCYaYhQUsd+Tvobxdz0iun8cUrDo+CHH05FZJg0G69b6wnFx5B3PT4Y9zefzXPWC/Sr+U6asrZ0SpJzvT9rh1ULhvUKtTu0Ie1KcpreLUl0b4RvUgJxnzCIu1kYu6Zwg8vo8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726011933; c=relaxed/simple;
	bh=iM0jj8S3VKYKj12HU0Sug/HTfaVLGaHYStfmhvHzgm0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=OD3ygR6l0rUMV+0SZtt9cm3fPsXft+iXHxch3WjUtK7HlYPYfGlzR7wPCHZJNfF9csEAKWPhcXORaK5bC55wV21kYIEVXhmaSZt+4YHnlX+VGlic8u4BYMhlDppp3GPnK+nJjxL5bfcXlF0yZAV8azNj1GDgYRmuorfxW7cYlCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XCVC0DPY; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-718dedf3615so1498102b3a.1
        for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2024 16:45:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1726011932; x=1726616732; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=AYJem9uK2cy9PiRW4XqF1AVoy187cj8pbxn6tsiytpU=;
        b=XCVC0DPYnM33AnLjbbAdn960pEa8qXpOSY3DLkgnNQ31m5/hsUia+5fxEifie4GArS
         Jew+A+/rskLpbRo9txVq4LtmGFcRuYKaFlxgHDtexf/2OGi2syYrAtOQl6oxrFRmcIU0
         SwGFcqCrzSTEux8Yrf/4ePSnthLl4Hbns4DurCCaPQFjRRMT6JeEdl11rcwL5xYdsee+
         RP62YB5I2MrCCTFiLq8TaOEfp+JqJlWi24taGtSMjYwr1nI8RF9YvdV5qbVfuOQbBqev
         IpThbkFsCVWwlTYniRsvBcw53i7Fj+qAF8m8jmd2byDxR9aepbRPaXACEAoONf4nYGpb
         ATqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726011932; x=1726616732;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AYJem9uK2cy9PiRW4XqF1AVoy187cj8pbxn6tsiytpU=;
        b=SW+JjZOJx446Nh2lqPFrUOI7WTnGmI78Ti1Pl21y/WmFssFWbpVcuisrq+ECzFsWnF
         MI3RDhYCl8JdIg1IsKAVT2bHunY6Fu3gGb3k+pEwOtKZlqj1yBYay86w7U9bP4wS/C0x
         oDJPkyNad3M4lqFzB3Lir5w7HmncdWeaP+vPgjk83DlJlfYFgkWlpqcnWF6Ci14v4ROB
         YDRYHHZ7d0HpzzMzRfzW8VdAPB+UgoWZHLG9WzPuDGlelhzSALxUBnRNNeCEWEr/Sz1P
         OmOWtIVADYmSogwKCIQBb9157h1iqZ1XzDSCamAjTW4ZNPXo0CUdGwfczDyKR/kQEbnX
         eAsg==
X-Forwarded-Encrypted: i=1; AJvYcCV/MsWit6n+RuHMgC05MHnrc/iCFoSbiQhMquUDEIBzRafbDjfnLmIHqwTddTJaac1iwtbiGwXBVr+mxng=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQIro/NU9c+iwE+HhYn1f5nA2ViAx76wKgIMhhp2aPY0Tb7xmw
	c8g8SvZJbxLYp6KlbhnCyM4GivOk6zmMtejTl9UBehHxrxeZn8Ean0rYpYeT7zKhnMSykFUsD1w
	d4KkmvnzBGOk/2N4q21G71g==
X-Google-Smtp-Source: AGHT+IHaymwmA0a5qHgrrgMyaOagseBsBxvzMqXn3tRr1+SR9wD08VNMmkUJlj2d4F4z5ptyADsmNrcNJBVUlk0nKg==
X-Received: from ackerleytng-ctop.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:13f8])
 (user=ackerleytng job=sendgmr) by 2002:aa7:9390:0:b0:706:3153:978a with SMTP
 id d2e1a72fcca58-7191722c371mr2134b3a.6.1726011931559; Tue, 10 Sep 2024
 16:45:31 -0700 (PDT)
Date: Tue, 10 Sep 2024 23:44:05 +0000
In-Reply-To: <cover.1726009989.git.ackerleytng@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1726009989.git.ackerleytng@google.com>
X-Mailer: git-send-email 2.46.0.598.g6f2099f65c-goog
Message-ID: <0ea30ee1128f7e6d033783034b6bc48dfbabb5db.1726009989.git.ackerleytng@google.com>
Subject: [RFC PATCH 34/39] KVM: selftests: Add notes in private_mem_kvm_exits_test
 for mmap-able guest_memfd
From: Ackerley Tng <ackerleytng@google.com>
To: tabba@google.com, quic_eberman@quicinc.com, roypat@amazon.co.uk, 
	jgg@nvidia.com, peterx@redhat.com, david@redhat.com, rientjes@google.com, 
	fvdl@google.com, jthoughton@google.com, seanjc@google.com, 
	pbonzini@redhat.com, zhiquan1.li@intel.com, fan.du@intel.com, 
	jun.miao@intel.com, isaku.yamahata@intel.com, muchun.song@linux.dev, 
	mike.kravetz@oracle.com
Cc: erdemaktas@google.com, vannapurve@google.com, ackerleytng@google.com, 
	qperret@google.com, jhubbard@nvidia.com, willy@infradead.org, 
	shuah@kernel.org, brauner@kernel.org, bfoster@redhat.com, 
	kent.overstreet@linux.dev, pvorel@suse.cz, rppt@kernel.org, 
	richard.weiyang@gmail.com, anup@brainfault.org, haibo1.xu@intel.com, 
	ajones@ventanamicro.com, vkuznets@redhat.com, maciej.wieczor-retman@intel.com, 
	pgonda@google.com, oliver.upton@linux.dev, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, kvm@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-fsdevel@kvack.org
Content-Type: text/plain; charset="UTF-8"

Note in comments why madvise() is not needed before setting memory to
private.

Signed-off-by: Ackerley Tng <ackerleytng@google.com>
---
 .../selftests/kvm/x86_64/private_mem_kvm_exits_test.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/kvm/x86_64/private_mem_kvm_exits_test.c b/tools/testing/selftests/kvm/x86_64/private_mem_kvm_exits_test.c
index 13e72fcec8dd..f8bcfc897f6a 100644
--- a/tools/testing/selftests/kvm/x86_64/private_mem_kvm_exits_test.c
+++ b/tools/testing/selftests/kvm/x86_64/private_mem_kvm_exits_test.c
@@ -62,7 +62,11 @@ static void test_private_access_memslot_deleted(void)
 
 	virt_map(vm, EXITS_TEST_GVA, EXITS_TEST_GPA, EXITS_TEST_NPAGES);
 
-	/* Request to access page privately */
+	/*
+	 * Request to access page privately. madvise(MADV_DONTNEED) not required
+	 * since memory was never mmap()-ed from guest_memfd. Anonymous memory
+	 * was used instead for this memslot's userspace_addr.
+	 */
 	vm_mem_set_private(vm, EXITS_TEST_GPA, EXITS_TEST_SIZE);
 
 	pthread_create(&vm_thread, NULL,
@@ -98,7 +102,10 @@ static void test_private_access_memslot_not_private(void)
 
 	virt_map(vm, EXITS_TEST_GVA, EXITS_TEST_GPA, EXITS_TEST_NPAGES);
 
-	/* Request to access page privately */
+	/*
+	 * Request to access page privately. madvise(MADV_DONTNEED) not required
+	 * since the affected memslot doesn't use guest_memfd.
+	 */
 	vm_mem_set_private(vm, EXITS_TEST_GPA, EXITS_TEST_SIZE);
 
 	exit_reason = run_vcpu_get_exit_reason(vcpu);
-- 
2.46.0.598.g6f2099f65c-goog


