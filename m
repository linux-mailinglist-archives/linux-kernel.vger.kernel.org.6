Return-Path: <linux-kernel+bounces-325602-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 88512975BEA
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 22:43:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1E368284575
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 20:43:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9850A1BC074;
	Wed, 11 Sep 2024 20:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Xud0G2mH"
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5A231514CC
	for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 20:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726087351; cv=none; b=bXOFztSpiFlz4mupq95WMqaPCv0WjnO0tG4qFNc3yB/7jJY5w8ERK16COTQsbqYsgaWEof+/5//PIe1VSwWSo/bUDrrT4z6oVyRj6TqBBu3yaaB6rbnlIZsxNUmtzdWwi5reIR4/de5kmmLO2DrsjjRjh0LddEu0EqBpCuEK680=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726087351; c=relaxed/simple;
	bh=p49LU2Zhb7gbb5LKY/h5ptEGGa6l2hQP4h0k8idJ1n8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=hKn9VOIferMhh0ixTEgRXo+cZhUcR+qlG4zpMFgUHHbUFnBpLL2p3ntvbyFI8WnPNPgiGI7s5qDVVVHhzTe+HbKKiecOh1gpZ23yy3H6lLc0oj9594arNGPfYl9ezoyJ+qCS3vjKbTT5A58GtBNb1GaEITBOkrxlrFUZRm9hkFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Xud0G2mH; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2070daaf8f1so4096835ad.2
        for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 13:42:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1726087349; x=1726692149; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=ZSI8dsTyNYYmZluhAXeYyfAeB1n1NlxlB5JW+pr40RY=;
        b=Xud0G2mHqvfYlq090tPyYw3FTwe/ZLNLnXKVWI0gQzPsLZQlDFwEhssLnl9cKwqK4F
         zVFw+deX6Lx0woM6v3RQinh/veLQSNdNAoTLT7nnTa+sfmH1dm2hJl5aelts9HjXW8PZ
         nEglB1x9z8vUOwHjbDluU5O4qsLGbfpp5JROMhTpw26z5NfWQVtN2MUEy/qJbGWMZBqh
         ueu5Ve4J8Dr6Oqzh47IMx/TVb6fPfrue3ZExfOpks1kokPVjkaz/zkHjLxgKBqcmX/Z+
         mvuOUZfBbsA8aadKq29mB5oahdBOPDBFaY+p1bVuyXZff3IIaoDvtBdT3n756QkXuLhs
         r5eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726087349; x=1726692149;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZSI8dsTyNYYmZluhAXeYyfAeB1n1NlxlB5JW+pr40RY=;
        b=g9ppNk1YyT8p8blnums/jLM9L+FDvoeDz6wGAihnZuMjaO2Nr3WdIc78W/V5Zf99W7
         BFKgbj2mokZp3Jz+UkGE90FH4QPGxSrZ1QhAYnsh8k9LOBLnrrvkZh6A9X+R02dsVMII
         5MVJrk6he09cHny4BYPRgqMeiBQl4Xs4LN5Odv2KJ/UAm7xofZb4UZmCA2ZUxs2SjmB1
         GOVjhtE9p9RnjQo5jplDPN461TiRAGi4ONbKusx9vlIdspxtfm4K1K3tkg8yjNLuuadM
         TS6YGvzDhGQiPc7DiVyk/viCoQmJ7yFrPOjSVxCkY8djLISidMmHRuRQ/R2UR8Un1xL9
         psGA==
X-Forwarded-Encrypted: i=1; AJvYcCXl49I4QKvspfJqzu9IK1YZcLzzGXAYYexnbdMfHIqP8A3gRZcanYz2oybYizmmpbGiDJhH/r6ECoMR8Mg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQt3Y4T5RrE2scFI1GAaURf/oKe5iULP8OxVdcJsgJKtdxAYJ7
	ZLOYQ4wzZuAEinzjRxQPpy9cViDPqiSQGvvItSQw43a6R2eix91KUfXtT9fSTTHefdOwweioDqW
	vKw==
X-Google-Smtp-Source: AGHT+IFVhcOXMpYuiCLKMEBjF0GLRF0droi6YIr05t4juUD0iWZSecyCNUnHqr+/fAL8PrR1+nheHNVoid8=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:903:41d1:b0:206:99b3:52de with SMTP id
 d9443c01a7336-2076e47cc2dmr175945ad.10.1726087348954; Wed, 11 Sep 2024
 13:42:28 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Wed, 11 Sep 2024 13:41:49 -0700
In-Reply-To: <20240911204158.2034295-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240911204158.2034295-1-seanjc@google.com>
X-Mailer: git-send-email 2.46.0.598.g6f2099f65c-goog
Message-ID: <20240911204158.2034295-5-seanjc@google.com>
Subject: [PATCH v2 04/13] KVM: selftests: Assert that vcpu_{g,s}et_reg() won't truncate
From: Sean Christopherson <seanjc@google.com>
To: Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>, 
	Anup Patel <anup@brainfault.org>, Paolo Bonzini <pbonzini@redhat.com>, 
	Christian Borntraeger <borntraeger@linux.ibm.com>, Janosch Frank <frankja@linux.ibm.com>, 
	Claudio Imbrenda <imbrenda@linux.ibm.com>
Cc: linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, 
	kvm@vger.kernel.org, kvm-riscv@lists.infradead.org, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Sean Christopherson <seanjc@google.com>, James Houghton <jthoughton@google.com>
Content-Type: text/plain; charset="UTF-8"

Assert that the the register being read/written by vcpu_{g,s}et_reg() is
no larger than a uint64_t, i.e. that a selftest isn't unintentionally
truncating the value being read/written.

Ideally, the assert would be done at compile-time, but that would limit
the checks to hardcoded accesses and/or require fancier compile-time
assertion infrastructure to filter out dynamic usage.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 tools/testing/selftests/kvm/include/kvm_util.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/testing/selftests/kvm/include/kvm_util.h b/tools/testing/selftests/kvm/include/kvm_util.h
index 429a7f003fe3..80230e49e35f 100644
--- a/tools/testing/selftests/kvm/include/kvm_util.h
+++ b/tools/testing/selftests/kvm/include/kvm_util.h
@@ -683,6 +683,8 @@ static inline uint64_t vcpu_get_reg(struct kvm_vcpu *vcpu, uint64_t id)
 	uint64_t val;
 	struct kvm_one_reg reg = { .id = id, .addr = (uint64_t)&val };
 
+	TEST_ASSERT(KVM_REG_SIZE(id) <= sizeof(val), "Reg %lx too big", id);
+
 	vcpu_ioctl(vcpu, KVM_GET_ONE_REG, &reg);
 	return val;
 }
@@ -690,6 +692,8 @@ static inline void vcpu_set_reg(struct kvm_vcpu *vcpu, uint64_t id, uint64_t val
 {
 	struct kvm_one_reg reg = { .id = id, .addr = (uint64_t)&val };
 
+	TEST_ASSERT(KVM_REG_SIZE(id) <= sizeof(val), "Reg %lx too big", id);
+
 	vcpu_ioctl(vcpu, KVM_SET_ONE_REG, &reg);
 }
 
-- 
2.46.0.598.g6f2099f65c-goog


