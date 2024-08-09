Return-Path: <linux-kernel+bounces-281502-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 022C694D78D
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 21:45:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9D7F61F24FE0
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 19:45:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87C9616D4F7;
	Fri,  9 Aug 2024 19:43:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uho2lfO3"
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BAA316A95A
	for <linux-kernel@vger.kernel.org>; Fri,  9 Aug 2024 19:43:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723232628; cv=none; b=S0Qif9KKTOYpgnu/isdRBMVDVhxJ9+3sGcYB12d+U2mT9XB6hmk76rck8jmXx3AQrAHjWGiWYWEfPYiEUZUIOrPKBWN7SwPhClS1cKeN9ZNtAvBXx02p8BSzsHEsiUocGLbCYbksvwaENvQUyNVvoXfxk9L1w+mbVhttp+PbLnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723232628; c=relaxed/simple;
	bh=2ubMLB5DYODq+qnXHnLMuf0I7PP+FeHp7xjE64E2dt8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=IMzy3cgsWpbxB5RAse6aSLQeQoWdOvdmq9LgoEqkKwekbiHKP3iyPui0rFfuVRAF8+ju0bp+jQQ22BalazNRwssb3nyd3KJqYf4j8K8diLHbtF7TT03I6OF/EO/6urMPRmtUeTm/djy/v40zeaIV11CQPl6CCCQNzGo8S4oCaX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uho2lfO3; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-7106fcb5543so2040728b3a.2
        for <linux-kernel@vger.kernel.org>; Fri, 09 Aug 2024 12:43:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723232627; x=1723837427; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=RH8NStSlBVyK9g+UsmyXuI40nq9wzYPRU0gcFL0VkzM=;
        b=uho2lfO3JEKa3BYwurP6bC28fXllFmtwsLtKqkYwXKuVhG9iGLmF2aaPR5Odju1Ebl
         Z9NS24VN5EgBnwC8jBTgeHCFw2AsVyYNmazjHtqug5NluFgb9zdsyV3lRidSK7IbdXzO
         SCBUzgu7UERbgaLMluS8YD20m2GpAIJeCkYKVxXWoViB3+m1ymd9pJ3TY9AQlWsLi3mG
         ukBmfSIkISSc7wZvKIuD2A98IXIKxXMdV0Wo3kFxs+Vue5h2yajrz24/2pvUgYvrWhhP
         qXu6rPM4PbVbmOA+Q0UCHXc5EYZRTr0eYAybkGBmS0e7gFq+rVkpau1v/mDziY9M4tpz
         B86g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723232627; x=1723837427;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RH8NStSlBVyK9g+UsmyXuI40nq9wzYPRU0gcFL0VkzM=;
        b=WMn6mb/ECl1OZGfxHXAdlHG4lQ3EQZKl+HmQlYqYo7Oez7FH9+hFpGsb0CJhS1gUky
         BfAsGTn3z9wSgkx0hmqJydWfHLgq2k7+Uxf0rVnb8EaeQIvxw4moCAyao3FWFPfVytBn
         bDn69W4G/qetMIV6Zq0YlldM9fyX/veSn7aQHeh2oVarheIiN/RkSY3OHaMoafFT7qsk
         vkjORLdtLkDcNP1AounxZGtDq+NSfwARPDWjVsitzpSgvMm88jmErpP+HwD/4P1DmDTw
         H7LR51EGm5i9wEyienHJrcvy9gmM239FlQTVXYPW/vAx6Txd3zSzkUz6gg6F/MEJRTXU
         nGJw==
X-Forwarded-Encrypted: i=1; AJvYcCW+/fIG0GNKe6ZJg9W1syf7k1desAxOZaYcZNkwlzOS1JV6IKO+7Ii+jj7t7+MsNYwU605z4hYYXTzQ0CiCry6pimLfakERL1G75KDj
X-Gm-Message-State: AOJu0YzTsWS5Y8sxIAYKALPzn2zzRW674th49gWt82rhUrBaDJ6VrA8W
	2fSKzPfma5WYJb1nGveddA+yRfpw9hHwOoiFKgoRycW/ZVL+Y1Nj5VYKWEN5eL2hqz8FiJpIKdn
	U6w==
X-Google-Smtp-Source: AGHT+IFF/ikXFYmI7zWUXbZoAyAwoVgAHirCcT99AraR5wR32CSYiy6TQQF1iEJF/4Gcjt4kmzWk21e9a/Y=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6a00:6f12:b0:70d:30a8:abaa with SMTP id
 d2e1a72fcca58-710dcb31a13mr28290b3a.5.1723232626683; Fri, 09 Aug 2024
 12:43:46 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri,  9 Aug 2024 12:43:16 -0700
In-Reply-To: <20240809194335.1726916-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240809194335.1726916-1-seanjc@google.com>
X-Mailer: git-send-email 2.46.0.76.ge559c4bf1a-goog
Message-ID: <20240809194335.1726916-5-seanjc@google.com>
Subject: [PATCH 04/22] KVM: selftests: Compute number of extra pages needed in mmu_stress_test
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Oliver Upton <oliver.upton@linux.dev>, Marc Zyngier <maz@kernel.org>, Peter Xu <peterx@redhat.com>, 
	James Houghton <jthoughton@google.com>
Content-Type: text/plain; charset="UTF-8"

Create mmu_stress_tests's VM with the correct number of extra pages needed
to map all of memory in the guest.  The bug hasn't been noticed before as
the test currently runs only on x86, which maps guest memory with 1GiB
pages, i.e. doesn't need much memory in the guest for page tables.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 tools/testing/selftests/kvm/mmu_stress_test.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/kvm/mmu_stress_test.c b/tools/testing/selftests/kvm/mmu_stress_test.c
index 847da23ec1b1..5467b12f5903 100644
--- a/tools/testing/selftests/kvm/mmu_stress_test.c
+++ b/tools/testing/selftests/kvm/mmu_stress_test.c
@@ -209,7 +209,13 @@ int main(int argc, char *argv[])
 	vcpus = malloc(nr_vcpus * sizeof(*vcpus));
 	TEST_ASSERT(vcpus, "Failed to allocate vCPU array");
 
-	vm = vm_create_with_vcpus(nr_vcpus, guest_code, vcpus);
+	vm = __vm_create_with_vcpus(VM_SHAPE_DEFAULT, nr_vcpus,
+#ifdef __x86_64__
+				    max_mem / SZ_1G,
+#else
+				    max_mem / vm_guest_mode_params[VM_MODE_DEFAULT].page_size,
+#endif
+				    guest_code, vcpus);
 
 	max_gpa = vm->max_gfn << vm->page_shift;
 	TEST_ASSERT(max_gpa > (4 * slot_size), "MAXPHYADDR <4gb ");
-- 
2.46.0.76.ge559c4bf1a-goog


