Return-Path: <linux-kernel+bounces-392745-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F0FFF9B97AC
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 19:36:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9C8131F2304B
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 18:36:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 722411CF2BC;
	Fri,  1 Nov 2024 18:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iqqvtpmi"
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7218D1CEE8C
	for <linux-kernel@vger.kernel.org>; Fri,  1 Nov 2024 18:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730486161; cv=none; b=u7iYOzmsHwwwne+PLmxuP7yw8ATgDAfewL0ALphRq8/MFvEzG5bGDdyGrq4qDsk3lDPrGSjfkcOvlodKmIZbMrPyRivfmBRuVvg1559Pea1MYa583GQsM7KptzyhsseD5jldj6iIhOGQZTudGotJBgu3GVeqqjgRP6iVhU8WdZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730486161; c=relaxed/simple;
	bh=GthnIBzx9iijyVZUANBkchjX+hZXG4UWjfuYUeGfwps=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=isecvOaxv+4zb8lvOmyUjgnIADHE7AJ6gg4S+iKlDX/x7xzrfy3fnyd2pXHXaWeazAo5XqhKgBIV+Me1JURIKMh3jsNORWYROaZAnHheidSewusRuFICGoNa8W7eL0jlE4xPj4kSAEj74IhMKyl+pvy3v7pkAOZ9nLagrYfCzX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=iqqvtpmi; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-7ea69eeb659so2449726a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 01 Nov 2024 11:36:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730486160; x=1731090960; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=qVWIo3tvorcfd9vZ45ZC5Hm+N0sYYOu19bKF2QN63SQ=;
        b=iqqvtpmithxzTSFB0KhCn/cf15yMVYssppD+h4ZQ0s83vUf+3CTvsE2ZYxk7N/uwCm
         vadb4yNcVXb1DYGlUyYybPicrVpoYk8Wz4CErKlr3gZ8aajpR0WpGtUXbhkCEZY4g1HF
         XSJKWOgsK1sWUxdki1ZiAqfPjsbgv9vraHt5HnPSOc3v2vyoOPnODm4Bm3LOj/E8vF4C
         x0lgZOWYWXWuEjcgP/2/xgLEwP2JFTb5ODi+aCqkF1ovwFVM3ASTsxbVMWXdexyWbqgk
         wpayYECA33Qh/OZhqAXX3x4ScMdScRr7SY1FTVGKybIh0ZZcr8qzG04ErtuNRneU+A0B
         n8DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730486160; x=1731090960;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qVWIo3tvorcfd9vZ45ZC5Hm+N0sYYOu19bKF2QN63SQ=;
        b=toQlm6IJ0P4kdCiXQpt88RNBcHj7FA4Cpc58QRIl+Itb4U8vBlLrNNdkvUbIBzKvBr
         Ahka/6jEEDWZp23VHxroORebTfouBRpAwNRUCCPiybrnAvhAu2bV7dUIJ7iTqcl73rRe
         4R2dfek3dxxfdgeg51IH3CmJisc3wToTXzKDTmD/6VOhhuXnRbuA53Xycfa+rqpEKzQk
         64fvJbWLw+wu1AuhkfMkXo8tAxBtAxJvIOXQaw3CFbHegP+mdoeK668eMSCvvCjxvi0Q
         5V66GiOSPsvbiilnM4RdV1TxsQZt8bF4sMU7ruejtTvk9dZ7jxCxFb/ssBWLMl+CXmWr
         7LgA==
X-Forwarded-Encrypted: i=1; AJvYcCXj9GOyBSi0OAwKCXPca07TJzHOJ+2XI8mOfET1jlPDTxJCgKrysKyTYYYAupuTIxrSD4VG9FaDpF+Re/4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwtTCnICCNsmLJ55nTBNpAcZohYnsrCiFoIxhAZH4i+0is9ZjQn
	5Wz9C0niymuk5ZkANnQdQB2Dlc+UI65SjnYX5zkBvQvac2+08CG6BZAsK49G/OiQTSFODVAMPg5
	InA==
X-Google-Smtp-Source: AGHT+IHktkXZ3RvXifEjmjETa4vTjpVmQp9Hs4/ZkuOBFXaF0+ekg7ATFuDxNEhzDH/TUjSiGZFcgQgAWKs=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:9d:3983:ac13:c240])
 (user=seanjc job=sendgmr) by 2002:a63:5556:0:b0:7a1:6633:6a07 with SMTP id
 41be03b00d2f7-7ee4107c403mr8192a12.2.1730486159703; Fri, 01 Nov 2024 11:35:59
 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri,  1 Nov 2024 11:35:47 -0700
In-Reply-To: <20241101183555.1794700-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241101183555.1794700-1-seanjc@google.com>
X-Mailer: git-send-email 2.47.0.163.g1226f6d8fa-goog
Message-ID: <20241101183555.1794700-2-seanjc@google.com>
Subject: [PATCH v2 1/9] KVM: x86: Short-circuit all kvm_lapic_set_base() if
 MSR value isn't changing
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Kai Huang <kai.huang@intel.com>
Content-Type: text/plain; charset="UTF-8"

Do nothing in kvm_lapic_set_base() if the APIC base MSR value is the same
as the current value.  All flows except the handling of the base address
explicitly take effect if and only if relevant bits are changing.

For the base address, invoking kvm_lapic_set_base() before KVM initializes
the base to APIC_DEFAULT_PHYS_BASE during vCPU RESET would be a KVM bug,
i.e. KVM _must_ initialize apic->base_address before exposing the vCPU (to
userspace or KVM at-large).

Note, the inhibit is intended to be set if the base address is _changed_
from the default, i.e. is also covered by the RESET behavior.

Reviewed-by: Kai Huang <kai.huang@intel.com>
Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
Link: https://lore.kernel.org/r/20241009181742.1128779-2-seanjc@google.com
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/lapic.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/x86/kvm/lapic.c b/arch/x86/kvm/lapic.c
index 65412640cfc7..8fe63f719254 100644
--- a/arch/x86/kvm/lapic.c
+++ b/arch/x86/kvm/lapic.c
@@ -2582,6 +2582,9 @@ void kvm_lapic_set_base(struct kvm_vcpu *vcpu, u64 value)
 	u64 old_value = vcpu->arch.apic_base;
 	struct kvm_lapic *apic = vcpu->arch.apic;
 
+	if (old_value == value)
+		return;
+
 	vcpu->arch.apic_base = value;
 
 	if ((old_value ^ value) & MSR_IA32_APICBASE_ENABLE)
-- 
2.47.0.163.g1226f6d8fa-goog


