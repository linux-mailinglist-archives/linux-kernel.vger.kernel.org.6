Return-Path: <linux-kernel+bounces-573525-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57D8AA6D8A9
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 11:51:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 287D13A7336
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 10:51:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D935025DD0A;
	Mon, 24 Mar 2025 10:51:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="t6Tsjqmr"
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F68A25D55A
	for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 10:51:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742813496; cv=none; b=UNtX3RzS+o7AGTwns/Xda2K0vd8M8g5aef9UGk1kO0kfmFsKbqQ9ayhcNgXnj/9etk+A/AJiDjp/xNQ9HiTiBozp9SfjZETXebHVhTDcpi66w3CuCUbk+Yj+3H4sHBNEPKJJHCjEXgphW7q34jg2YN5aEAwcMP+YRo92ge24NA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742813496; c=relaxed/simple;
	bh=DcUNwbRdPnow83kHtle77XVYOEVPg7rrZhWsXAiAdvQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=axZp2V7myi6OvJwN019QrguLHiaJ+vRY3Ql1Ddo4UR8YJBt9V+LCJta0h7jXyMs40JBnOyCQ/s+qU+vDa1xUufBrV05FZfeN+hJB6acO0/3ddd8a+acdsrOLQIKxKR8sFB3s690ZRL2lsMGdOpsW9Nro/mjozPUq3PO2v7Oi2nM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=t6Tsjqmr; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-3912c09be7dso2724141f8f.1
        for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 03:51:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1742813491; x=1743418291; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9XBugaXb0XfXOq/Pw2aaFS10qYW8sYB+YovrYm1of0M=;
        b=t6TsjqmraRQZ1DQ8ONd6zW7pki7uVKNfXUwsL437JhTlQwqIq0RMdRbyNy4xytvPEl
         7oD41CupVEoD0yVlTN+zsc8lDK4JSZv03fEa5+YyTQECNbuIalkO8qgUidVKQ8XhrUjq
         iWtf2yOs/xKPqby6UBGvZye3JN/RFVOpTHpp++r/ObWVy0T/5zqtBlLXT2sU5LQvIAaQ
         9YrQc8qipWXkSlMOUMTv/Yxp7skz/IE+me6yF4s3M9SIgPOsm700JAY5gGsm2XORpbNd
         DTtgSbybDr1T8zFKoS7NcXg6xD17e7tDcaPBS8OmNU8EiXT8qubAlBCljZwucTpnPWL0
         WbCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742813491; x=1743418291;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9XBugaXb0XfXOq/Pw2aaFS10qYW8sYB+YovrYm1of0M=;
        b=LSCoh841/4iiJClSn4Gw0ojfNCa7LM11G1ySro80t8L1mUZOgfTPYp/3HcuGgRSH12
         Sf0FEfY8/BrZZBN2IYO11IJoUTigbja9ECUiX5YuejvLyMsIIj0VQi+B/Vrz1UH0v/+r
         sSwJJxyzmRJeMsltpNTLbE8uX0Y03jeDDAgA5Vfmvpo0iFBojGrxN6Xiw3wdh4BRm0qV
         21uug0+RRgb00WHk4GjBhocABdEJ3Jhqo4locJbwyrwby7VMI4JnRDb0n1Gmx85YH0Ku
         OU3n9oOJqdGlikWkAh7koVGsenjnRPEJUuMv7KSw0eU4dwJmBaYeLMpw4oSwYb3A2Kf7
         SSVg==
X-Forwarded-Encrypted: i=1; AJvYcCX8jJDROZewfd7f1TfYSLsRAr0j3ow6lkHHMjcds8qziyyfa6XjTTXkZG+cJPb4yYxHwAI7MiF7I+utBkk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyj1R4fOIIv+J5Tr1RZVbElcNO/reGow7mJrvjvec9kWgkrd8AD
	sB2YtEox/Fcj+FyW1WyHKGqx3GDevmsS3rpw2Pw0ZxYU2lwmxtlIuHduNGAW5KM=
X-Gm-Gg: ASbGncud8xwYtJHW88W85d5lDoFkiUMLfvnqlYzIo6mL2qD53J3cXaGqmb/q8WJrD4q
	bdzR2KyOWq6zGRsEDZ7a4xcqqL8c4SPwCgcA1C1JukDhW7NdA8eekjlGEE+oCf7Dr6vsWoO/Hp3
	r3DMyXNVmAO56jJgD6//fDPwxBDONieYVnLe+Ky3sHfBYpiVClASAZgLsD+CrLJoXKLL+3NlzQW
	IRC+7HSULVoOs1Go5CdOhu1P1c912sI9fmWeKYkY5VpKBl1F0eOm8Qs6u2R+ybAvokIKDEc5tz0
	KHYrT57gOomCFys7dhReymA5mCgLDYa8cf4lyHYrGYfaX6syzg==
X-Google-Smtp-Source: AGHT+IExcAE5hR9WRBPjbbJe1A3tT2LgZRn6kn5d7CfZGvAe25QU3/LL5pLa+ilmFxLgUVsdLqKbPg==
X-Received: by 2002:a5d:64cb:0:b0:391:42f2:5c7b with SMTP id ffacd0b85a97d-3997f8fea8bmr12460729f8f.16.1742813491455;
        Mon, 24 Mar 2025 03:51:31 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3997f9e65casm10745004f8f.69.2025.03.24.03.51.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Mar 2025 03:51:30 -0700 (PDT)
Date: Mon, 24 Mar 2025 13:51:28 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Sean Christopherson <seanjc@google.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Pankaj Gupta <pankaj.gupta@amd.com>, kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH next] KVM: x86: Check that the high 32bits are clear in
 kvm_arch_vcpu_ioctl_run()
Message-ID: <ec25aad1-113e-4c6e-8941-43d432251398@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

The "kvm_run->kvm_valid_regs" and "kvm_run->kvm_dirty_regs" variables are
u64 type.  We are only using the lowest 3 bits but we want to ensure that
the users are not passing invalid bits so that we can use the remaining
bits in the future.

However "sync_valid_fields" and kvm_sync_valid_fields() are u32 type so
the check only ensures that the lower 32 bits are clear.  Fix this by
changing the types to u64.

Fixes: 74c1807f6c4f ("KVM: x86: block KVM_CAP_SYNC_REGS if guest state is protected")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 arch/x86/kvm/x86.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index c841817a914a..c734ec0d809b 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -4597,7 +4597,7 @@ static bool kvm_is_vm_type_supported(unsigned long type)
 	return type < 32 && (kvm_caps.supported_vm_types & BIT(type));
 }
 
-static inline u32 kvm_sync_valid_fields(struct kvm *kvm)
+static inline u64 kvm_sync_valid_fields(struct kvm *kvm)
 {
 	return kvm && kvm->arch.has_protected_state ? 0 : KVM_SYNC_X86_VALID_FIELDS;
 }
@@ -11492,7 +11492,7 @@ int kvm_arch_vcpu_ioctl_run(struct kvm_vcpu *vcpu)
 {
 	struct kvm_queued_exception *ex = &vcpu->arch.exception;
 	struct kvm_run *kvm_run = vcpu->run;
-	u32 sync_valid_fields;
+	u64 sync_valid_fields;
 	int r;
 
 	r = kvm_mmu_post_init_vm(vcpu->kvm);
-- 
2.47.2


