Return-Path: <linux-kernel+bounces-424081-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B60F79DB070
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 01:56:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C481281F39
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 00:56:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 140873CF73;
	Thu, 28 Nov 2024 00:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UgCmZ9iZ"
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E851F1DFFB
	for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2024 00:55:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732755357; cv=none; b=UTRKqoyL59Ti8qLwy5xZ7gamr8+QwJa6QhN3L2iv8i37htT827DlZ+1ah5n1zJbIuysPXBSbYBJRynYWXEMA/Gm7J+C/aH3GB8OzNc59nCJec/LM0xhgA5AY2nOhsMnQ1vvizwsy8TcF4AwJDPUEe8JAUg2w1VW7ZSgKGCXpcso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732755357; c=relaxed/simple;
	bh=/I1QDhTu7A4uX6aQjK9uL6OFtLwJ4Jmbm1md8fy4gPw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=oSXWecEIBh/Y2AxJJlxPuSvb+sJrxBROb2qXGsTeGPEszAFiez7WhdY//CQWRUxHmbbTVBdvBd2NFX4YXDnyDLbgPCtEF9dN9B/oE2sqT9afMgZH0jl3W0zflq7ALai4j+GdkSbWSGq39nNc1gCeY43aRiJTbK4lmRJz/1ticww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UgCmZ9iZ; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-2ee0f8ecd88so333965a91.1
        for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2024 16:55:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1732755355; x=1733360155; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=qVBMujG2OTqdwJQgPPGju5b8tNjOmRcixGV2iZuWWwY=;
        b=UgCmZ9iZ4JA7nZC57i4q8YFvqd4pfMTFRWrZY5Smb0SfHVQOWhfGZHmJ8pxTdfmbmZ
         qIr6bKBWxZiaz8iNZblUSLnJvOw88WQD6DSJG4mWkYlTIVQ35f5wMIakY0yclU1VTdkL
         si3YDnSQ1C6qeDFTaS2vtiK7S45VaaJmVZUaJzEjdPytg7SP/l1mxYQUj1oxmC+UQsmh
         jHr3bBkLC2akZbDN7w4uKKf5xvvHdC9AnZzrLYsNydKAXWlBpaySbstWwhAkn/s5yYRe
         z6nPSQu4R012rvR/P8ICe2CLzXDc9LAhk61YMrwR4VYrWimvF623jQmG6mD5oSsDRXX2
         W4Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732755355; x=1733360155;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qVBMujG2OTqdwJQgPPGju5b8tNjOmRcixGV2iZuWWwY=;
        b=h2QbEaZula7THyQkuuGHeqNR3je2kRgk3nM/KAIxLVp9HsDla4fBpLp24wxDcWUJaW
         v3ezvtZN6C1gNQI7xsR72c6kXopKtYhqdHP8bTc4T5NSFEAHJw0RAy6CTcxyeeK5Islw
         eR9RW3ch6V/jTW0AREZ2oCYJW7lPvOiWVgPUrmPkWrly8xbXidCvYcVTxlJcfQODMGS4
         2XvZaxIH1hDSIwHFp/vfBALk4PALEzgNIUvw13NsTc6+ko2HMPvuztOenOckngvQHm8E
         CwF42V5FfMaz/KC3LELbHy8iE5nNBdN3Qap2BYGP5vN8Ef5wZLORT46MrVXc6ZE5ORKQ
         RRKA==
X-Forwarded-Encrypted: i=1; AJvYcCWEe6PtktUi54HemdhX94VX7JNE2QHMTKiV2SmbFsK0V0E68Wl7UCId2MHhCc7KOG8eCCbmt0uY9Q9Glx8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxOWQUhY6MNHhw7qsQXSvejrxnj8u2B/0OJHCSeEN/P+e3qRJ+h
	wh7KEzhWKnpQ4tZcCrfuEqAi1C8EKGY+7w0HqknLJlYqMgfAKwNmpK+Qgg38x0zMESLg7SwOx7n
	rSw==
X-Google-Smtp-Source: AGHT+IH+xlYFxzyyjYgkHwbv9v8SXpOlp7wHMGVgiCiV61K5VskA6YHcas7fec5b54n5jx+SjDlTSzyBffA=
X-Received: from pjbmf12.prod.google.com ([2002:a17:90b:184c:b0:2d8:8d32:2ea3])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:388b:b0:2ea:7329:4d
 with SMTP id 98e67ed59e1d1-2ee097ca9damr5929096a91.34.1732755355263; Wed, 27
 Nov 2024 16:55:55 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Wed, 27 Nov 2024 16:55:34 -0800
In-Reply-To: <20241128005547.4077116-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241128005547.4077116-1-seanjc@google.com>
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
Message-ID: <20241128005547.4077116-4-seanjc@google.com>
Subject: [PATCH v4 03/16] KVM: selftests: Assert that vcpu_{g,s}et_reg() won't truncate
From: Sean Christopherson <seanjc@google.com>
To: Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>, 
	Anup Patel <anup@brainfault.org>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Paolo Bonzini <pbonzini@redhat.com>, Christian Borntraeger <borntraeger@linux.ibm.com>, 
	Janosch Frank <frankja@linux.ibm.com>, Claudio Imbrenda <imbrenda@linux.ibm.com>, 
	Sean Christopherson <seanjc@google.com>
Cc: linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, 
	kvm@vger.kernel.org, kvm-riscv@lists.infradead.org, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Andrew Jones <ajones@ventanamicro.com>, James Houghton <jthoughton@google.com>, 
	Muhammad Usama Anjum <usama.anjum@collabora.com>
Content-Type: text/plain; charset="UTF-8"

Assert that the register being read/written by vcpu_{g,s}et_reg() is no
larger than a uint64_t, i.e. that a selftest isn't unintentionally
truncating the value being read/written.

Ideally, the assert would be done at compile-time, but that would limit
the checks to hardcoded accesses and/or require fancier compile-time
assertion infrastructure to filter out dynamic usage.

Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 tools/testing/selftests/kvm/include/kvm_util.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/testing/selftests/kvm/include/kvm_util.h b/tools/testing/selftests/kvm/include/kvm_util.h
index 287a3ec06df4..4c4e5a847f67 100644
--- a/tools/testing/selftests/kvm/include/kvm_util.h
+++ b/tools/testing/selftests/kvm/include/kvm_util.h
@@ -707,6 +707,8 @@ static inline uint64_t vcpu_get_reg(struct kvm_vcpu *vcpu, uint64_t id)
 	uint64_t val;
 	struct kvm_one_reg reg = { .id = id, .addr = (uint64_t)&val };
 
+	TEST_ASSERT(KVM_REG_SIZE(id) <= sizeof(val), "Reg %lx too big", id);
+
 	vcpu_ioctl(vcpu, KVM_GET_ONE_REG, &reg);
 	return val;
 }
@@ -714,6 +716,8 @@ static inline void vcpu_set_reg(struct kvm_vcpu *vcpu, uint64_t id, uint64_t val
 {
 	struct kvm_one_reg reg = { .id = id, .addr = (uint64_t)&val };
 
+	TEST_ASSERT(KVM_REG_SIZE(id) <= sizeof(val), "Reg %lx too big", id);
+
 	vcpu_ioctl(vcpu, KVM_SET_ONE_REG, &reg);
 }
 
-- 
2.47.0.338.g60cca15819-goog


