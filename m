Return-Path: <linux-kernel+bounces-432046-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D5DE9E4540
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 21:02:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9A419B31D98
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 19:14:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F8741F03D0;
	Wed,  4 Dec 2024 19:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LZbQ8zsy"
Received: from mail-oo1-f74.google.com (mail-oo1-f74.google.com [209.85.161.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC1051C3C01
	for <linux-kernel@vger.kernel.org>; Wed,  4 Dec 2024 19:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733339659; cv=none; b=NHPtpARQOOQtbOWIgIPMEVgxnOS/UB7KSkYsQv5vOfmbapOGLb+7/SzOPVMvYLId+RbL0RfU6aCeHIu/b5HdrVinJZ/4OaPeoak6FmPqnsiokgA9et9otv++ifJvxgC5Uu+CrhXeUVTBWOriRsY7dK+Gjm4SMMGl+jYHrcEtTlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733339659; c=relaxed/simple;
	bh=Pe5YIDGyVsJn3IDNSsuwg/PtWitlNtJM3kxtfZFGD8o=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=NoYZPdSmmWEPE2cCOhs961hVeHS3mlNVDcwnkKN8F+MYfaeEKZE9Ca9+Ae4j7CUvZu7xmIQKn3Ap9VYFTGRk38I4Y2fN5r352N1TQQNJUwyzP039f3+RmtDwfqJeT7NA+H9M5YLnsoiWoGzrnV/248O/NkfFzzFz1KIDTEykHko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jthoughton.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LZbQ8zsy; arc=none smtp.client-ip=209.85.161.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jthoughton.bounces.google.com
Received: by mail-oo1-f74.google.com with SMTP id 006d021491bc7-5f2033c97cfso118212eaf.3
        for <linux-kernel@vger.kernel.org>; Wed, 04 Dec 2024 11:14:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733339657; x=1733944457; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ifppD8XOVrlj0Y18bnChdCi7ngFpMAIfTyMrOgFm5Gc=;
        b=LZbQ8zsySnHzNTQwM+VYSwJ6n8soxGXUC9vCnCQUk5lKbQNVoE3sTTxnOM2THOP1VL
         O0WHxpLOsLUFz8VujjNK9tNV13Z/b+2mW9BOkt19LNy/bJaylC9on3CsLy568FKjERQL
         XnwZocCV9Ry4o2oc2obKLOVMp0nlxZT7gPB0oKHMZGhafgBMmVt7Zlp8sQGNGPNd7gmv
         ACjVkigeuxs1deI3ZX2UN7C6xIN+tv9saq8ykSBZCzsb3qh7lm3hwr1yppmUU+dEVKbm
         aLbxh1kDQ72CNQPEQRyEJQtZfbPvqZAr51sidUOZ9MZ8mErDeiz8/kceHYkwvMF6u2BN
         kgHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733339657; x=1733944457;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ifppD8XOVrlj0Y18bnChdCi7ngFpMAIfTyMrOgFm5Gc=;
        b=VsBObgfWdtfOSUmhMajvLcUtnJYP7IhZPMHXG8YESlPZqheQ1bePI+auT1/ZhIdqnJ
         TvvtZuLF77eDPa4kpi7CzicrfybT5srypSgedrBWFtr20z9IM2AC11RcIBL8fthBA5Tw
         RcKPKBcRSLf+24BWHuLfcmhEkcY/kh7zDBmHN37KN9BasvNsmd1mo+HzWSl0SjA3yeQ1
         I4pnj7JoWh5ZGMuW11vPrsQf33wc57g7OQ5Wy+/If/marD6J3trLj7pmzm5tlUbbtj/B
         4MAIv+JVnqPsnc5mIgrL5Vl4rkmF4VeZc+DvV8NJs/tb6rg0MAWPyvtH3qE/auUw1Z2w
         +UwQ==
X-Forwarded-Encrypted: i=1; AJvYcCV66ojL0zXyaEuXBDypNLiBKzxHJVHcx8XQ4dlWQfytfBBkfsHVhE5ABtEOjRzrblF71yBzNCP18nUp27A=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywobdc+m7RV9rTVtR6Xl/TtSFPTWxMHT3Kj+Tv7uTiiLiYoKwQh
	DoKZiacJFwOBZcQ6Q5blb0w8WlxJ4BRLSI1zVgMMisY9ZPVREEEgGxQa7wSex3MroUtfSPcsHeo
	+BJClSXZsAFetMl0krg==
X-Google-Smtp-Source: AGHT+IGqVM1yUneXF0DiEvK0H0RPVa3NLvh9Vv5/V4X8bp9PJGOl+SW8n3O2HwvzvAHA/QzfxuBonL+2sIMiSocO
X-Received: from uaf26.prod.google.com ([2002:a05:6130:6d1a:b0:850:15b2:33d7])
 (user=jthoughton job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6359:230b:b0:1c3:94:8ffa with SMTP id e5c5f4694b2df-1caeabc2133mr709229655d.22.1733339656984;
 Wed, 04 Dec 2024 11:14:16 -0800 (PST)
Date: Wed,  4 Dec 2024 19:13:37 +0000
In-Reply-To: <20241204191349.1730936-1-jthoughton@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241204191349.1730936-1-jthoughton@google.com>
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
Message-ID: <20241204191349.1730936-3-jthoughton@google.com>
Subject: [PATCH v1 02/13] KVM: Add KVM_MEMORY_EXIT_FLAG_USERFAULT
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

This flag is used for vCPU memory faults caused by KVM Userfault; i.e.,
the bit in `userfault_bitmap` corresponding to the faulting gfn was set.

Signed-off-by: James Houghton <jthoughton@google.com>
---
 include/uapi/linux/kvm.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
index 94be7e8b46a4..641a2e580441 100644
--- a/include/uapi/linux/kvm.h
+++ b/include/uapi/linux/kvm.h
@@ -444,6 +444,7 @@ struct kvm_run {
 		/* KVM_EXIT_MEMORY_FAULT */
 		struct {
 #define KVM_MEMORY_EXIT_FLAG_PRIVATE	(1ULL << 3)
+#define KVM_MEMORY_EXIT_FLAG_USERFAULT	(1ULL << 4)
 			__u64 flags;
 			__u64 gpa;
 			__u64 size;
-- 
2.47.0.338.g60cca15819-goog


