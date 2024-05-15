Return-Path: <linux-kernel+bounces-180206-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A0E228C6B6F
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 19:24:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D1D2E1C23B9C
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 17:24:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DED2E43AD4;
	Wed, 15 May 2024 17:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="F6H06BBm"
Received: from mail-wr1-f73.google.com (mail-wr1-f73.google.com [209.85.221.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96A2F156C5E
	for <linux-kernel@vger.kernel.org>; Wed, 15 May 2024 17:23:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715793798; cv=none; b=ufNXCG3kg+83CTrsnf66oBu131d2Qir1B+FNCA7E8/zC/tYykmGpSASHrPnvILitCnGYt4Tvxpzsi8EcBWqPmFvlDGcxIsL4DJE1eUP/5IfClNREKuAtiLWl7qqqPAIlfSznlfPlJFsKG1YfxDfLtd9TiLyJb1cPRHasQ8rJ+DI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715793798; c=relaxed/simple;
	bh=27Ez01frh80qv0dCLE2nqGawXWJ0QpQYbc9jTyic+yQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Do3p64NrTAlqsZBYqinPMSsfgEjnHJT0GinbgCgjYP8aVs3rvRBpkuag1HWlUYFgdk5KeNolDQtt9XakdFN7qCMqukiZTGU4gYT/lSpGXqjezXhrTN9BtVuyv2LA25wYOoLg7Ge7ukqvg6nYCl8wP65wNo4UFTa6ziUNCaQQj9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--sebastianene.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=F6H06BBm; arc=none smtp.client-ip=209.85.221.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--sebastianene.bounces.google.com
Received: by mail-wr1-f73.google.com with SMTP id ffacd0b85a97d-351c67dbc8dso1280406f8f.2
        for <linux-kernel@vger.kernel.org>; Wed, 15 May 2024 10:23:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715793795; x=1716398595; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=B0DAehK5iEGC7D6F2LaIGrwd7yaT6oZGo7c2srRK8ao=;
        b=F6H06BBmgGJtySJAGTI9CstNC2TckiLx4wv3qBKhisv2fNSudkvaWQgxh0BE3k9xfK
         f5pMf3YT9VuyfyA7UedpYgZmYsUOAqSh2AAvkL4EnutSsesyaYEm5omxYTdir/WXXs8+
         6GW1e/b6HvA9aBd0HiN2QQjwP6olXAwyCGn8hEDqon4pl/8U2v07F+3bA6qA3yrQuOyZ
         IzYyIwOu4EGkq3QX4IP9DGql0vhF6Bx6+2qLygLT2k3NycNpf9q/9yKNq6UFFsXLjIVW
         GRp7q8Bmokkkw1JZHxByoG2vuJKDatbrFsbpBVMM9o2Rxk84KMYoaMWYzw58EOSCQpHa
         65kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715793795; x=1716398595;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=B0DAehK5iEGC7D6F2LaIGrwd7yaT6oZGo7c2srRK8ao=;
        b=l/ycjB3o0KMxxZUxNvlPzQFVliaXCEYfwo8aCnuNx/qzn4KzkEEnA3WvpxTy+FiA5B
         E17Ub4+MHgIJ5gWYAwCpm06hHLaasXC0U/EuF/hdikxbxPv9xPQf5eInmcoRru1hOd+F
         JUovF/0rTA2r5/S5lORGsjjtpIhYFnQkJUFTP3A1KVFOKn5gZkpak63Gz/azXXr25qUx
         HxDJR0sSbtYk6IPPiV509IGtNIsEJYjr8VE2af1TOQ2chvwKeSQ0fAXDqOpqQb4mqjk1
         xlIXl/L4C1fPw121IyiN+aMETL8kPUeq7kXtTqTx8SUKHt6aFp3qgW+g2e+gPHw0MGvf
         6Ehg==
X-Forwarded-Encrypted: i=1; AJvYcCW4wWghVB7o5ozx7azYhoaj+Ey+XVGeGiGeEaBZVqCwNcYJO+Q4V9EaKrwsLZ03a6CboUeapm8iQiWxAqnGDSMMODgutbqkWMaflioO
X-Gm-Message-State: AOJu0YwTdhuntMA2xAw64z4LrTRU33K4ohqOLbHLbC8aTl9HakVQORfp
	G3KJCBx2tfWbWwiJj8vQVI2UXxpFnlqt3ydBa4bHCa2k5Wes9mWGHYnvwvofhFEeNtth0+QKMm5
	hfWhVVTXu8g9wcTQUZz2NfC5EbQ==
X-Google-Smtp-Source: AGHT+IH03ZoGLJfBqC8Eh4MTyJx29qZ/mRDItFO9N0niAZcln5o7llsonWFoglyUwHcG4HXvFRo52sD+v+QqQnvnw4k=
X-Received: from sebkvm.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:cd5])
 (user=sebastianene job=sendgmr) by 2002:a5d:4750:0:b0:34d:a979:e99b with SMTP
 id ffacd0b85a97d-3504a10f83dmr32508f8f.0.1715793794931; Wed, 15 May 2024
 10:23:14 -0700 (PDT)
Date: Wed, 15 May 2024 17:22:57 +0000
In-Reply-To: <20240515172258.1680881-1-sebastianene@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240515172258.1680881-1-sebastianene@google.com>
X-Mailer: git-send-email 2.45.0.rc1.225.g2a3ae87e7f-goog
Message-ID: <20240515172258.1680881-4-sebastianene@google.com>
Subject: [PATCH v2 3/4] KVM: arm64: Fix the identification range for the FF-A smcs
From: Sebastian Ene <sebastianene@google.com>
To: catalin.marinas@arm.com, james.morse@arm.com, jean-philippe@linaro.org, 
	maz@kernel.org, oliver.upton@linux.dev, qperret@google.com, 
	qwandor@google.com, sudeep.holla@arm.com, suzuki.poulose@arm.com, 
	tabba@google.com, will@kernel.org, yuzenghui@huawei.com, 
	lpieralisi@kernel.org
Cc: kvmarm@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, kernel-team@android.com, 
	Sebastian Ene <sebastianene@google.com>
Content-Type: text/plain; charset="UTF-8"

The FF-A spec 1.2 reserves the following ranges for identifying FF-A
calls:
0x84000060-0x840000FF: FF-A 32-bit calls
0xC4000060-0xC40000FF: FF-A 64-bit calls.

Use the range identification according to the spec and allow calls that
are currently out of the range(eg. FFA_MSG_SEND_DIRECT_REQ2) to be
identified correctly.

Acked-by: Will Deacon <will@kernel.org>
Signed-off-by: Sebastian Ene <sebastianene@google.com>
---
 arch/arm64/kvm/hyp/include/nvhe/ffa.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/kvm/hyp/include/nvhe/ffa.h b/arch/arm64/kvm/hyp/include/nvhe/ffa.h
index d9fd5e6c7d3c..146e0aebfa1c 100644
--- a/arch/arm64/kvm/hyp/include/nvhe/ffa.h
+++ b/arch/arm64/kvm/hyp/include/nvhe/ffa.h
@@ -9,7 +9,7 @@
 #include <asm/kvm_host.h>
 
 #define FFA_MIN_FUNC_NUM 0x60
-#define FFA_MAX_FUNC_NUM 0x7F
+#define FFA_MAX_FUNC_NUM 0xFF
 
 int hyp_ffa_init(void *pages);
 bool kvm_host_ffa_handler(struct kvm_cpu_context *host_ctxt, u32 func_id);
-- 
2.45.0.rc1.225.g2a3ae87e7f-goog


