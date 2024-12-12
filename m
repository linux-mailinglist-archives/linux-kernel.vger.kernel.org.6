Return-Path: <linux-kernel+bounces-443671-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6469B9EFA91
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 19:16:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5644316FE2A
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 18:14:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A83322966B;
	Thu, 12 Dec 2024 18:06:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fN04fh/u"
Received: from mail-ej1-f73.google.com (mail-ej1-f73.google.com [209.85.218.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9C5423FA12
	for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 18:06:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734026785; cv=none; b=ts7W5vi8a4dXjqmPwxjOfEYcVYDKn+b+0r/x2sWWDjrHwlP+vCNel/FDgH5gICQKJPCKRoTZtEGQhzbOyRwaFITMLEUBHWHbkgyqTjSjHR6BMoxbnL3qm4OePkhm5O7tREDFqRFAr8Tsf0xYrjX4gTNEEjQbd2rRPHqgWrCUVt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734026785; c=relaxed/simple;
	bh=KBex4nSvV8st4JIwyXj9uqMSukyDo5x+//eUZ7ElLyI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=owe55tSoQ2qqyqx2Paqc3B8JdOgd/dp6f+z+gNWgMCZ9N6jwzw+6XAHq1EYj2KzMz8FIqP4f7uWxkPAajOrKRaISR03Qa/mw2XRgXOw/Y881flkoe0Jj3FFs8D9TPck9TnXkLo3vTSkVUe5nJJDWpMJSkL3IwTmlPSmPIka0o4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fN04fh/u; arc=none smtp.client-ip=209.85.218.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com
Received: by mail-ej1-f73.google.com with SMTP id a640c23a62f3a-aa65d975c40so70908266b.0
        for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 10:06:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1734026782; x=1734631582; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=oA4flaYxQ5BGtfLZd9pc3kG1NLnmtH/l93s5ei2WXOY=;
        b=fN04fh/uJbS/hppFen5v1bzlIu9qFec4jiWsEVC4lkkzNFcFG+6Ar9t7Em6Qk4TPo1
         CzM/K0hC+iUxvyNobYKS91qRX6X5De+gebYQCnEKbM1Sw1VSrJgMSMUsLuvUgukicqUN
         pvC5rnhJLw0cvu+Q2V7u4g28dfQkeMtvwn1JrKcZyVFWbkU2KiFtBWZIEi99TUpPiwid
         ch8EUnKnEpTZ8w3+QyctYnEfETBTjnZJWzbnZjcvc9c7ykqgH5vqdrmU7V9AnVWO5IyR
         Ur3nyYIIJHMPGQsI/7SMgafBzwxQn9hOcV36S6t5F2b2WGz98hQOwaQpKygC6dWPgig4
         Djqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734026782; x=1734631582;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oA4flaYxQ5BGtfLZd9pc3kG1NLnmtH/l93s5ei2WXOY=;
        b=vtIm3afgMxgj6zZ974cKUlZUo35DhhQj11wdUzyz8Z1Y+N4vyLO0R+c0R9RFY8DQtu
         db9NrgHWa81jHCjVxcPhvnirL7QxYJXiBZkRa9FYPS6mYkPr02FDACRZc5q9K69wGopz
         jy57gDrmfrv624EqTl9qNWSGoy8btELTS/BXMDjHxIT2Y1GeG2TMqVu20l20Ve6y0pn4
         FuJopbg9lrXQqmQwkkilhxseiYHJ39ZHNzWrqhCPTB/4JPEOQv/1iZm1hS4t8bXKz2Lq
         cCLeIsr6SKPfF9fNFVv1DeybnDdLwNqsxqO5zErLeYHu2uNgtM90h7j70TE7NxWOlV7U
         XZdw==
X-Forwarded-Encrypted: i=1; AJvYcCVeRa3hzhK0z2Fz6eqJAbSsbK+2M3Cx3DZUm9XNgWu+UzWasQxnEpckNSVgwUod2KFm0vICsSskb6HVwnU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxmRI2phLizuAz+Ko6WV+/7WFpYd5Y/XNV7hLLvmS+bMT+zFlQP
	RzVQPXjv6thy3fG13IG6l/F6DYhg5F7/DmMGIOy+CRoGJUzasZ+esEE7YCRL8x2QPjoSgMe/ydH
	pxR27AhtvYw==
X-Google-Smtp-Source: AGHT+IH16CwAGQZdlZ+j17KujE/o9PMEBvOMuLsm290SY8dsLy1Bla7B610srDL7eN2tped3VnaOKpJ7Tllo2w==
X-Received: from ejxj19.prod.google.com ([2002:a17:906:8313:b0:aa6:a222:16c7])
 (user=smostafa job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:907:15c3:b0:aa6:8a1b:8b84 with SMTP id a640c23a62f3a-aa6c1d26981mr510164566b.57.1734026782147;
 Thu, 12 Dec 2024 10:06:22 -0800 (PST)
Date: Thu, 12 Dec 2024 18:04:11 +0000
In-Reply-To: <20241212180423.1578358-1-smostafa@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241212180423.1578358-1-smostafa@google.com>
X-Mailer: git-send-email 2.47.1.613.gc27f4b7a9f-goog
Message-ID: <20241212180423.1578358-48-smostafa@google.com>
Subject: [RFC PATCH v2 47/58] KVM: arm64: Add macro for SMCCC call with all returns
From: Mostafa Saleh <smostafa@google.com>
To: iommu@lists.linux.dev, kvmarm@lists.linux.dev, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: catalin.marinas@arm.com, will@kernel.org, maz@kernel.org, 
	oliver.upton@linux.dev, joey.gouly@arm.com, suzuki.poulose@arm.com, 
	yuzenghui@huawei.com, robdclark@gmail.com, joro@8bytes.org, 
	robin.murphy@arm.com, jean-philippe@linaro.org, jgg@ziepe.ca, 
	nicolinc@nvidia.com, vdonnefort@google.com, qperret@google.com, 
	tabba@google.com, danielmentz@google.com, tzukui@google.com, 
	Mostafa Saleh <smostafa@google.com>
Content-Type: text/plain; charset="UTF-8"

Add a macro that returns SMCCC returns from a hypercall.

Signed-off-by: Mostafa Saleh <smostafa@google.com>
---
 arch/arm64/include/asm/kvm_host.h | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
index 59a23828bd0e..3cdc99ebdd0d 100644
--- a/arch/arm64/include/asm/kvm_host.h
+++ b/arch/arm64/include/asm/kvm_host.h
@@ -1248,7 +1248,18 @@ void kvm_arm_resume_guest(struct kvm *kvm);
 #define vcpu_has_run_once(vcpu)	!!rcu_access_pointer((vcpu)->pid)
 
 #ifndef __KVM_NVHE_HYPERVISOR__
-#define kvm_call_hyp_nvhe(f, ...)						\
+#define kvm_call_hyp_nvhe_smccc(f, ...)					\
+	({								\
+		struct arm_smccc_res res;				\
+									\
+		arm_smccc_1_1_hvc(KVM_HOST_SMCCC_FUNC(f),		\
+				  ##__VA_ARGS__, &res);			\
+		WARN_ON(res.a0 != SMCCC_RET_SUCCESS);			\
+									\
+		res;							\
+	})
+
+#define kvm_call_hyp_nvhe(f, ...)					\
 	({								\
 		struct arm_smccc_res res;				\
 									\
-- 
2.47.0.338.g60cca15819-goog


