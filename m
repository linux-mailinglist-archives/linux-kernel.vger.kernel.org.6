Return-Path: <linux-kernel+bounces-211438-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F75B9051A0
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 13:52:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C433DB2392E
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 11:52:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD66516F823;
	Wed, 12 Jun 2024 11:51:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MqOqwi/1"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82CDB16F28A
	for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 11:51:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718193105; cv=none; b=XIsOyX6yQ2VHE7dc9ct4uyZkIOwjgK6Rp8kpQysX8QrjIVmvZxvru+WQ09p8OtGC6+Iz4tlIjfNYvV7/P8nEbIew1gyC6S0oI9sYZmHMq483fiX8059n8PWm7v8N7UewKJ2kOfnjBc0HxhU4LL0gFBQA5OUSTJsKBoirLTfAJpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718193105; c=relaxed/simple;
	bh=Iap+yq/UFPMhzwMJN1/W29xopjf+UPCfBHcc+afOI+A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PbuUurd7su/ZpJo4aYRStSEGEO7sWYo3Ri34SEj2XDOkZYxKEx/OMg267P7QlBVg6Ws2k2yjX/HPPtJwflnuuur0YXjREud04N6e9dhErQGAYkIPmcU2sS0byfGOu/LTUndIPYC3AwZYqdwJ/kpS3PZKRvAmTKRemWp46O6870k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=MqOqwi/1; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-42178999284so16785875e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 04:51:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718193102; x=1718797902; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ts2smytxY9xlqDn06N5ZqiAGp4oK5EeYYIBFYgm141E=;
        b=MqOqwi/12tRyx06FZsWZCfP1wvIWGqsOsevlrnRo/kDCrABrJasNNoHqyOnHXG9nAy
         fNAy8KlYwCoymLcuS5OBYJNOXqLYvppe7k0SVSjiRfMZmtLkwaQKHb+Ri89zwnjaMCXz
         2TzCRRooM4fN1as7wdzUcAOuxNnQXz4TyjlLUEL+P16cdLza1ZgJiDpKU8srCeW59GBP
         qPI8SgFm4L3uPBxv3jVevR+ZY/s3bCuEuACv9/1SY+tGAM598YxNyPSL8bCppk7gY0Kp
         gG7KnR3usgr6XsK+uuj3FCQPcGzi8m+RDYdtDsVIB5i2+9xw1EZUPnGLnJnQP1jv6N7p
         lq2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718193102; x=1718797902;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ts2smytxY9xlqDn06N5ZqiAGp4oK5EeYYIBFYgm141E=;
        b=AYLZjhE6mghBHy04aFTMtVIaogYbqRft2bZEDnKdCip5GHkhdUmibicbzd6IWeJ2jO
         8F0cGaoXoiCVAWbuoYws2lu7YkyAvNK8H1ja5c/4zPtu1716/eFUfRJdL7pmonqXTgmx
         oAujeG3NHXtNqN7j04yqmftABwW5mdN+q7c/3BlnAqu9S/DzDR+IZmbmToUKVLjuhNvT
         uH0f3+l8H8kieRmGTs1pn5/6hxV1vj3rlZxC6kQo8e2W8ZNnqU4FfJm40CdzVLGpHGjh
         xxEfZeXN9dm5r9OHKzuNERXwZIsL4Pe/EPFZpGjowhplkonsjfYQTrJDdk4TLVNvZ+Qe
         baNA==
X-Forwarded-Encrypted: i=1; AJvYcCUaC0JcEt72ypmD4K2mHKRq/D3H2PAYZ8wo92huWZz3B2gqRTyWB1dXwldmV1c7amT6n8X57J6pvGPb5ZfrVHRmLnem9aLUr3ym2P97
X-Gm-Message-State: AOJu0YxB4B9cJ3aUWGMW1/pXdvrLEcuQirafPo5JkzFAKeCmkZxahiMN
	Hb10alqfECSpE30FuL0OzxHSISgkhwe99AoAmS/RCd6LqOYVU4ZoB0oQkVK9tpU=
X-Google-Smtp-Source: AGHT+IGB21Kf+Yq70AofnMnKtJ/sAErPjS2QGuOdCNlXD6VJnixK2VEnojOvLWIJ653dzNytJ5zyZA==
X-Received: by 2002:a05:6000:196c:b0:35f:1c6b:2b24 with SMTP id ffacd0b85a97d-35fe88c9498mr1167357f8f.29.1718193101706;
        Wed, 12 Jun 2024 04:51:41 -0700 (PDT)
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-35f23fe7a64sm8174762f8f.89.2024.06.12.04.51.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jun 2024 04:51:41 -0700 (PDT)
From: Dan Carpenter <dan.carpenter@linaro.org>
To: error27@gmail.com,
	Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Brijesh Singh <brijesh.singh@amd.com>,
	Michael Roth <michael.roth@amd.com>,
	Ashish Kalra <ashish.kalra@amd.com>
Cc: Dan Carpenter <dan.carpenter@linaro.org>,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] KVM: SVM: Fix an error code in sev_gmem_post_populate()
Date: Wed, 12 Jun 2024 14:50:39 +0300
Message-ID: <20240612115040.2423290-4-dan.carpenter@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240612115040.2423290-2-dan.carpenter@linaro.org>
References: <20240612115040.2423290-2-dan.carpenter@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The copy_from_user() function returns the number of bytes which it
was not able to copy.  Return -EFAULT instead.

Fixes: dee5a47cc7a4 ("KVM: SEV: Add KVM_SEV_SNP_LAUNCH_UPDATE command")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 arch/x86/kvm/svm/sev.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
index 70d8d213d401..14bb52ebd65a 100644
--- a/arch/x86/kvm/svm/sev.c
+++ b/arch/x86/kvm/svm/sev.c
@@ -2220,9 +2220,10 @@ static int sev_gmem_post_populate(struct kvm *kvm, gfn_t gfn_start, kvm_pfn_t pf
 		if (src) {
 			void *vaddr = kmap_local_pfn(pfn + i);
 
-			ret = copy_from_user(vaddr, src + i * PAGE_SIZE, PAGE_SIZE);
-			if (ret)
+			if (copy_from_user(vaddr, src + i * PAGE_SIZE, PAGE_SIZE)) {
+				ret = -EFAULT;
 				goto err;
+			}
 			kunmap_local(vaddr);
 		}
 
-- 
2.43.0


