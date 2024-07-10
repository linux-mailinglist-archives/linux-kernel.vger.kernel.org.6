Return-Path: <linux-kernel+bounces-248427-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6576992DD0D
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 01:47:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1C9871F225CD
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 23:47:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1604016D9D9;
	Wed, 10 Jul 2024 23:42:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Xxpa8ncT"
Received: from mail-vs1-f74.google.com (mail-vs1-f74.google.com [209.85.217.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DC4F16CD16
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 23:42:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720654978; cv=none; b=q4PgXiBKRwZw6XDAhtmHi9U31waoaVllEzD6w/8DO4yMRHbRtOf48xlstwkDaZHn6Ix6fetusMhH789uGOzaPRNKWzJoHExkr8yhG8AGl6ZcIAv7p+uwizFL+7juKKVajpqd80AuWwCGM/S0AI0wZHhWLtvBQfhF+JFzYqLb0D4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720654978; c=relaxed/simple;
	bh=8593VQW+qY6IG/jYYpHCncdh+HTnZZx/ZSFesd4ewL0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=djvVN03B6xljQnhPKXpxuZnx5UpJPl3EnM2bpk19nmkEl62ozjrMfKcZmmiorIWJXQj18ozXHgNyIk+6dJ8sMP3eczWwzGIjL0/hfmN8s9Ep/OvFDA+k9ltbXs13cphEpK+H7k3iv5hqICIsseiENdGFoeFGS1T9uD/juwYCVAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jthoughton.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Xxpa8ncT; arc=none smtp.client-ip=209.85.217.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jthoughton.bounces.google.com
Received: by mail-vs1-f74.google.com with SMTP id ada2fe7eead31-48feb0d1abdso103703137.0
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 16:42:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1720654974; x=1721259774; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=KrWHeRDFVlfzCLm2guf0VTYM9h/W1rUjUnfwvHRBaDY=;
        b=Xxpa8ncTdgyuNQ996Gw0ta5/yYEut2AJIhDg3+yQwm/UPIA274rODqe0+bAvn++daV
         z7pi3hj55R3y+anqcc1egnqgM1VMRqWyqqUXTzM8b04EKorwb2qPzLgmC2S0VOer6rEM
         uvewnx3ThRcFoOhqtBy9P74tgDmnyIlu+hRI9NiGwBP3hx2dD1l2Kf4MkfoiA9nkMdmy
         b2EUeR3mUD+MdNVZ5jpEZ4S4W/XYdjha7U1FQuxb1YxTdERolyRmzr5+yCz8Y+9tXEO+
         jYEPOhQ6Xq/JHeaih7VRmfmZJsmkJdH122A6LrAUVw5ULn81szmZKaXUkiwNmeAhOaJH
         r09w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720654974; x=1721259774;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KrWHeRDFVlfzCLm2guf0VTYM9h/W1rUjUnfwvHRBaDY=;
        b=xAblK57fghjbfQtYLrflhwuDvtCgKInEBte0UlbfJl/w2/wMc795CfX5ik7mHg6I1e
         f3ZpWntutXvaTWJpmmLw7r7qUcu/+EZWgU4X8HEJZOlfanMUCpih4xLwIfFICPpx3Lbv
         w2g9WXg3rkSLtbNGfjANw6tutdL98rG3qQ7U0NfJrYXZQxlSF1UalG5e/pDRGCeL7jxo
         qxiWPeUbbvQ78SOuVaaEUxp4FpjYXByxl5cg6l62tbnnW1FrKQEu+fO5+SgiOIFhZ8FZ
         m1YaAz5LRRyOtxatBGLFbfLITc/xLQVWETM6brNj6MS6oA/GDvMKJnEus2vsmrWZHxNv
         eJFg==
X-Forwarded-Encrypted: i=1; AJvYcCWAXf7JS161SAlbFjrJpQKWMRD9mXW9O1g6lIJS1hREdKvz4xcTsQXsVNwIRfmmvfv2BbRIPfJws07gZ1Gtr/oAZwrxYc6Mcjmqqxt0
X-Gm-Message-State: AOJu0YzMBRbXPdUseZWZE2X0YnvpGBw6NW5mSjlXHihnPekaUL1QzMHR
	4NqkAU5PBEeCUvRYtQEPofT/k3OTa7Ypd5dAGrPCYu+gBgUdQRae8EhJQCC7ZKzJ+AqJpow1vDx
	eCC5d88dvZSi0+Sgmag==
X-Google-Smtp-Source: AGHT+IEk1FL65vqiK6UE5KirHXI/3mEOw3BUqoQ0HFsCZaEXrmaSc1CqWM95u18pik8VbBJeKyVeyhW9FRI1OD+8
X-Received: from jthoughton.c.googlers.com ([fda3:e722:ac3:cc00:14:4d90:c0a8:2a4f])
 (user=jthoughton job=sendgmr) by 2002:a05:6102:5490:b0:48d:89b6:85d2 with
 SMTP id ada2fe7eead31-49031dbea2dmr435474137.0.1720654973979; Wed, 10 Jul
 2024 16:42:53 -0700 (PDT)
Date: Wed, 10 Jul 2024 23:42:20 +0000
In-Reply-To: <20240710234222.2333120-1-jthoughton@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240710234222.2333120-1-jthoughton@google.com>
X-Mailer: git-send-email 2.45.2.993.g49e7a77208-goog
Message-ID: <20240710234222.2333120-17-jthoughton@google.com>
Subject: [RFC PATCH 16/18] KVM: Advertise KVM_CAP_USERFAULT in KVM_CHECK_EXTENSION
From: James Houghton <jthoughton@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>, 
	James Morse <james.morse@arm.com>, Suzuki K Poulose <suzuki.poulose@arm.com>, 
	Zenghui Yu <yuzenghui@huawei.com>, Sean Christopherson <seanjc@google.com>, Shuah Khan <shuah@kernel.org>, 
	Peter Xu <peterx@redhat.org>, Axel Rasmussen <axelrasmussen@google.com>, 
	David Matlack <dmatlack@google.com>, James Houghton <jthoughton@google.com>, kvm@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Advertise support for KVM_CAP_USERFAULT when CONFIG_KVM_USERFAULT is
enabled.

Signed-off-by: James Houghton <jthoughton@google.com>
---
 virt/kvm/kvm_main.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index d2ca16ddcaa1..90ce6b8ff0ab 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -4916,6 +4916,10 @@ static int kvm_vm_ioctl_check_extension_generic(struct kvm *kvm, long arg)
 #ifdef CONFIG_KVM_PRIVATE_MEM
 	case KVM_CAP_GUEST_MEMFD:
 		return !kvm || kvm_arch_has_private_mem(kvm);
+#endif
+#ifdef CONFIG_KVM_USERFAULT
+	case KVM_CAP_USERFAULT:
+		return 1;
 #endif
 	default:
 		break;
-- 
2.45.2.993.g49e7a77208-goog


