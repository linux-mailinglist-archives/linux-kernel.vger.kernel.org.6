Return-Path: <linux-kernel+bounces-432056-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C84F09E46B6
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 22:32:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 58931BA6836
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 19:17:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBBD4207DE8;
	Wed,  4 Dec 2024 19:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ijNsiXfs"
Received: from mail-vs1-f74.google.com (mail-vs1-f74.google.com [209.85.217.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04F5D206F12
	for <linux-kernel@vger.kernel.org>; Wed,  4 Dec 2024 19:14:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733339669; cv=none; b=RIO0jAFC2zHaJr5TrNdacfrrANbXqQtt6gPqu7ngXYNijC1RPK2NxfcpVP8mmCP2D398RsBuM1zO3mSO2IoFs432pz7T3RVvejUN9bzrf7mJ6hQ2kv8yMszW9Awt6BlrYlOAVMnrp7FOWcgHxqMaOuVWfRA1dvFEcfHpADpb3TM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733339669; c=relaxed/simple;
	bh=DB3D34LMo76wSyQOQTjLpchEbwFt3tbBmtNUE1453so=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=cI9ZUD2ZHusiuEVrPzOMhmnXPUSZi1aLgSXrGrC0DxaIMYVjIx0oY5VzqCbdkcUpR4KhneuDwbbhRGA+MWbGZZEhDynlTbvKE4utFCF23dioU66psUQcOLUFGPrZmMszsEjnkiTLBSAPMVS4OJIBYSy3LiXFj2aP7EDb5apsxOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jthoughton.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ijNsiXfs; arc=none smtp.client-ip=209.85.217.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jthoughton.bounces.google.com
Received: by mail-vs1-f74.google.com with SMTP id ada2fe7eead31-4af5824e449so10935137.1
        for <linux-kernel@vger.kernel.org>; Wed, 04 Dec 2024 11:14:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733339666; x=1733944466; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=s5zlVcABwgcAqDrk/hYCqATZ71WnZcE4eWZqt1Al9mM=;
        b=ijNsiXfsLfCRNzBTKUenbeOgOV2tUuKXfdYd1oOBhqHioD0Qnawgu04ON6s4hsMikI
         T1sRcnx8zWtIS/tWSRdENTKv6znXli6x5xjq0w9r6EfUdkXppkPTcWv+2+MDAjOddhv2
         +kNCLzT0JVklDYJ8WDM8Me75cm0q3FNxkntVQ2HHuMkIjjZmUCpWxuyS3XCyq2xCRoef
         i15paCYU1Rc3AeZiOGDHDel0+3WhfxFT55NFpymO6wEtDYKN/pjfppVvw7Jme8PgWz6X
         BOEv+KWCre4XIIBInE2e/KWSADD4pnOsnv+1/qFP7tPenYZjLcPoPzM5yHVYx2tjTih/
         SiUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733339666; x=1733944466;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=s5zlVcABwgcAqDrk/hYCqATZ71WnZcE4eWZqt1Al9mM=;
        b=SE8BhGZxSb9t1J+gCzWpIwQJVkRtRJHq7n3eQ6wHODIGFT4k1j/alFyy0oIfn2iGf5
         JAhiNhAwa1MrdfyjefBWOfSkHHNQNbm2Ol1bMRNDwgEunHRcTi8LsWmB4A3g7yoQ+AYY
         c4n2Q3Q3fHBNNFaRcmWDnPaosN1ZN6hccHQ1TBFS/4ouNaQxmgKyfRR5/LPdK3Lys+Fk
         +7kyNi7j8tTeLrMTbKGj1u9UqHE4hCsTfLTcQZcmD0Ug7G83Re8B2onsT6ElPh2VgJ5I
         gAoc7FCJGxvzLBN9f9JGyUx6Y1om8cDcZZOiICJNooB4Ny2dvphLdPWiFYk0O79t2jy+
         mMcA==
X-Forwarded-Encrypted: i=1; AJvYcCWp/4/izI8RYDCb5RT0ROU9Rarp80Vc+k0XFYTImJpfr4RqR9Iqp1RzAEopRoLVhGBpmN0ihtA92tO8zJ8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxF7srOkPCSsxW7SWx1VVuYykdAQN7xfmno1tKg+ThaeBcliX+q
	rDVYI3P+RnAgvXXU7s4tOWFtasMH1hcVx9zsp3XrCSAogd1jKVbPkWZqLiuZwRRU16I6lzto1V6
	OPweiZbQfxYGX9ES4jA==
X-Google-Smtp-Source: AGHT+IF2FEM1OG8guhI8P1BVhXWIFhfslfAcmBKz5oOAxjNRJSTj9A5XfYD8J6BgPkOCk8O5eB0FX2IaOdHwSH+I
X-Received: from vsvj20.prod.google.com ([2002:a05:6102:3e14:b0:4af:5a9b:90bd])
 (user=jthoughton job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6102:3ed0:b0:4a3:ab95:9637 with SMTP id ada2fe7eead31-4af97243dc7mr11657456137.12.1733339666111;
 Wed, 04 Dec 2024 11:14:26 -0800 (PST)
Date: Wed,  4 Dec 2024 19:13:46 +0000
In-Reply-To: <20241204191349.1730936-1-jthoughton@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241204191349.1730936-1-jthoughton@google.com>
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
Message-ID: <20241204191349.1730936-12-jthoughton@google.com>
Subject: [PATCH v1 11/13] KVM: selftests: Inform set_memory_region_test of KVM_MEM_USERFAULT
From: James Houghton <jthoughton@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Sean Christopherson <seanjc@google.com>
Cc: Jonathan Corbet <corbet@lwn.net>, Marc Zyngier <maz@kernel.org>, 
	Oliver Upton <oliver.upton@linux.dev>, Yan Zhao <yan.y.zhao@intel.com>, 
	James Houghton <jthoughton@google.com>, Nikita Kalyazin <kalyazin@amazon.com>, 
	Anish Moorthy <amoorthy@google.com>, Peter Gonda <pgonda@google.com>, Peter Xu <peterx@redhat.com>, 
	David Matlack <dmatlack@google.com>, Wang@google.com, Wei W <wei.w.wang@intel.com>, 
	kvm@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

The KVM_MEM_USERFAULT flag is supported iff KVM_CAP_USERFAULT is
available.

Signed-off-by: James Houghton <jthoughton@google.com>
---
 tools/testing/selftests/kvm/set_memory_region_test.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/testing/selftests/kvm/set_memory_region_test.c b/tools/testing/selftests/kvm/set_memory_region_test.c
index a8267628e9ed..d233cdfb0241 100644
--- a/tools/testing/selftests/kvm/set_memory_region_test.c
+++ b/tools/testing/selftests/kvm/set_memory_region_test.c
@@ -364,6 +364,9 @@ static void test_invalid_memory_region_flags(void)
 	if (kvm_check_cap(KVM_CAP_MEMORY_ATTRIBUTES) & KVM_MEMORY_ATTRIBUTE_PRIVATE)
 		supported_flags |= KVM_MEM_GUEST_MEMFD;
 
+	if (kvm_check_cap(KVM_CAP_USERFAULT))
+		supported_flags |= KVM_MEM_USERFAULT;
+
 	for (i = 0; i < 32; i++) {
 		if ((supported_flags & BIT(i)) && !(v2_only_flags & BIT(i)))
 			continue;
-- 
2.47.0.338.g60cca15819-goog


