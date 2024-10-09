Return-Path: <linux-kernel+bounces-357387-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CA5A9970BA
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 18:11:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C1FF3B23F80
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 16:11:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DB5B201251;
	Wed,  9 Oct 2024 15:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KdUXTV9p"
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81BB8201104
	for <linux-kernel@vger.kernel.org>; Wed,  9 Oct 2024 15:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728489005; cv=none; b=u2hwvaV7fPCUh+dQKVM4L37YuBrNWykYtbgTrpwnq5FX8Fdj7oyzPd0FXzPjN4p2xOSle86YolFVLdEI5IkQwfxLkgX9LhCtpYhQImp43VuLkorquvmfYdoYP7H1fQ9i9DzD8GITUf/qh2swH6SsFZB/tAYIkDw8Akk8hE9op6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728489005; c=relaxed/simple;
	bh=yMjqrBBrs5fD7ztP9Hd+ZjDB2ceAdIl8KOqv0sYfMVY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Os5VuQIORrteeubDNZRScGtj5NEjPJA7uPKtulmd7RQX+YKCybPbasoXM3MC1Gy4JhNi5WnW+4/HdvG2NeINPcsqbrY/i2oo5GK7kG9Vu/mqUF/wKhfF/QBhAhaWPPfYChhqo60yjTewwozjJ4AUhmhrXsdlJDSIUEY1+LGBqcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KdUXTV9p; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-71dfeda9ac0so3701089b3a.1
        for <linux-kernel@vger.kernel.org>; Wed, 09 Oct 2024 08:50:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728489004; x=1729093804; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=x0cgmo92qPc8MR1y7gAJGg1sCyN/CNSLMfDMg1eW/5U=;
        b=KdUXTV9p3IjcpOSmHzQFFPIOx+QacZMhGzbwcxZB1x7gfMmdjM0rel2+OfkCYqAjb0
         Q1jjQpw7rA/mxrn6z+c6xk8rgoDJsOvqdj0pDu+Ei1h05+0mZo4SPji+CbqbqqVgqgQz
         1OtH3aCz+ICOzTChlVDlBSFhxPNz5vbMVDEQnUD9MnTfoUOTbXF7phJHcOSiCq6rjWFD
         cBRpG3p0aTW1D0EC2/zxOjJTGL0JTkykRX0yC3DU1TMx2w6hU5FYq43wp0+YzTae9Ms0
         FHBURjiQ3gVtdEBUwk5gIiqucB5amQeNy1B2nSr92ghdV4lz3z4LiHkLfhDGHWXhsQPX
         EPXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728489004; x=1729093804;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=x0cgmo92qPc8MR1y7gAJGg1sCyN/CNSLMfDMg1eW/5U=;
        b=Citd0cgr6eOY+9SMwreYDoA0BhIJRopuAZv/c9XoDgJBD1bjhKUaoetRSiZMI/VgCh
         7Ze8LmVzUIDqh1YimHQbLwPyGuiCE0U+kC3ca6EZ0x9x8BNGtxp9Do/WDR1BLTyntSa2
         MCpELFk8zF02Q0ioXIX/XUcqwOzZSyXYXwydpSOhoYgwo5SkYeiHKnCJlzNsIisLCELU
         D8y1m4JY5HeZZAZQG27rz6L1YQPur5BSvLyG3YBGXv7xZ343PXZozgZW93OajLzJXYvm
         cGeaNIsLq47lkZRbZ+7OigqnIrgxfJoBGLRCq0sOKJGNhIrNgG/s6VTCsT0UpAcWEMMo
         o1Pw==
X-Forwarded-Encrypted: i=1; AJvYcCVIXLtZ2447noG5+AFT3Pvy+rKgXObRTxpRTY3cGzH3YuqKSsucElbKZxZfsYQSqK8zY4xsIYVws98fvRM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwvUNS7mLaLnxmA8JECLubWj2+ldADBSrNTbTMuBP4aMSYtSXyJ
	fk48pxZnXYnpcaQQJ6M+yYWktHHfKljvwZf0fpd/SVFYBKr3XiBS6mpDaHkm53j06nQmpAw7gxz
	cwQ==
X-Google-Smtp-Source: AGHT+IERUBPfneULnJ59z0o0A04D0VCwsGKXUdX4SfWVGxtKdYKWNTs8AEtFgRMkbcfSQG42khoM/WAQWlQ=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:9d:3983:ac13:c240])
 (user=seanjc job=sendgmr) by 2002:a05:6a00:4fcf:b0:71d:fb06:e79b with SMTP id
 d2e1a72fcca58-71e1daa9410mr6141b3a.0.1728489003716; Wed, 09 Oct 2024 08:50:03
 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Wed,  9 Oct 2024 08:49:43 -0700
In-Reply-To: <20241009154953.1073471-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241009154953.1073471-1-seanjc@google.com>
X-Mailer: git-send-email 2.47.0.rc0.187.ge670bccf7e-goog
Message-ID: <20241009154953.1073471-5-seanjc@google.com>
Subject: [PATCH v3 04/14] KVM: selftests: Assert that vcpu_{g,s}et_reg() won't truncate
From: Sean Christopherson <seanjc@google.com>
To: Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>, 
	Anup Patel <anup@brainfault.org>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Paolo Bonzini <pbonzini@redhat.com>, Christian Borntraeger <borntraeger@linux.ibm.com>, 
	Janosch Frank <frankja@linux.ibm.com>, Claudio Imbrenda <imbrenda@linux.ibm.com>
Cc: linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, 
	kvm@vger.kernel.org, kvm-riscv@lists.infradead.org, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Sean Christopherson <seanjc@google.com>, Andrew Jones <ajones@ventanamicro.com>, 
	James Houghton <jthoughton@google.com>
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
2.47.0.rc0.187.ge670bccf7e-goog


