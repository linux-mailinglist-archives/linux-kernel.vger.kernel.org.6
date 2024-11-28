Return-Path: <linux-kernel+bounces-424113-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 912209DB0C5
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 02:34:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 11A2CB22713
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 01:34:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1462045C14;
	Thu, 28 Nov 2024 01:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4C3zKq/e"
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BCCF29406
	for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2024 01:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732757676; cv=none; b=W9keFsxz9QXjpRrV5uN5uED4Tk0qf0TBO4Ifrs+vMK2feUgGei2675CzcaK12xgUhOIT7zAbLNzJwDPe6HEC/AgGPB3VfXv1Ro5mu8ppuvolYjdtGKA3XgIShaB+v20QZlc58eynw6g0+vwE0fouKkGtaUSscgidXCxaWQRstWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732757676; c=relaxed/simple;
	bh=qUOOQRdxqzW0iWtWBhZyxD40r+KxBbQyVzxJr0TNPM8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=GS7bUgHid/CFXH550ffFcQlmy+6RW5nyHKMG/Bb4bMgMjOQUdMZ/+p2nM2QS7kNpMWJTmwxYDBCdhC5S8GQEcOd5/VS7Z3D6FAOIjU9VdO+INyxoiQXKKNJ0D6SFHOCONjqArrnm2DkSR50Ekvb2ep21kAgJzQypvbCZggm9/Qo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=4C3zKq/e; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-2eaf1a11078so452773a91.1
        for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2024 17:34:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1732757674; x=1733362474; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=8PwmW/45ueQJahzHJJm7h5RjQBp4aZ3CpfBvMjYYokI=;
        b=4C3zKq/eL8aNPiGlFpon+1a7IxPxMNZtRN5E4LhXA/A99YMJU50nPSeh+Zy+CUsIMB
         8/GTHMcPH/DCcKPbCcbE/V6vYwMSXTnUD+5vZlu5+E1Y9X3KfLVudNXZl0pf/rgrEEGe
         FJ5PDtV7Y690RD66ezgHlhOK+PFRKJZeMRK3P6hk/3sw8npIYlVvI3c5RZyvk4qMEpN3
         3XbPfiMxfqlV2OIBjc1ZyEBYgrfQ7L1W6oz+LSgaFVJDpK3PO/Iar/FiohsDh4fsOjh6
         GvVj0ZKdM06n67tF/ahUpGGnXJN7bXqMf+qZLlcPBWdxGA0OGryUdFzWAzsbndjkgX/t
         eznA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732757674; x=1733362474;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8PwmW/45ueQJahzHJJm7h5RjQBp4aZ3CpfBvMjYYokI=;
        b=KZvpdGNG/oThlFtnLDJ2R5XOMSLZxtRIRm5Rw3qoAI02oCqjivJ8/lmEeaajTWt6Nh
         ql4Y2ABHP551GpShoKgH9WeBvF97DtDAKNbjHQMeAAzsUoqhQawSdyL9FbEdR0XnW4QS
         8FTtE0P8ojKRKVka41JPZMMaV41jqHFOJ6VBA6gtgmLiPA23KnIFC6bjP17B4zKIyxrS
         mFZwkV59i89YPlKzWEjtPBoSVGCalgvD6/bL1pjS7Jt9QcWH/JVNr1nPOibhfggBU0hQ
         DsgPRm34G+8rjrK6fwnBoGKRx3hjQOI+51dN0L+ztYg5oLC5sskFcLjqJsum3HdntYva
         WsJw==
X-Forwarded-Encrypted: i=1; AJvYcCUNWivYqZG3zGAomv2eD+7GmBr/EezSBKgX6y6NLuT00kpod9Kk0vaXJO+moA94eLjVfZN4SHPcptAR6Tk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzX6fw+PBpjGfiChFRT7yr4eMx8Os+rn/sOvTtVcUZewaDEYwRr
	dX6exnxL4faVys/ybweEyH27NYzFp8T+NMDZGYxAYRRhj/NGQGr04XYqaFvwT4C9kz1B2C2l4Of
	uzA==
X-Google-Smtp-Source: AGHT+IHpXO85otaKd+k0LVF4CVKFisDTeercgU4ixevU+UUIJ0Tx7jcVkyEwl+8jlB2oryYpavN1dvJ2J/A=
X-Received: from pjbqj4.prod.google.com ([2002:a17:90b:28c4:b0:2ea:839b:bb])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:35c9:b0:2ea:77d9:6345
 with SMTP id 98e67ed59e1d1-2ee08ed4430mr5846693a91.22.1732757673761; Wed, 27
 Nov 2024 17:34:33 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Wed, 27 Nov 2024 17:33:28 -0800
In-Reply-To: <20241128013424.4096668-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241128013424.4096668-1-seanjc@google.com>
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
Message-ID: <20241128013424.4096668-2-seanjc@google.com>
Subject: [PATCH v3 01/57] KVM: x86: Use feature_bit() to clear CONSTANT_TSC
 when emulating CPUID
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Sean Christopherson <seanjc@google.com>, 
	Vitaly Kuznetsov <vkuznets@redhat.com>, Jarkko Sakkinen <jarkko@kernel.org>
Cc: kvm@vger.kernel.org, linux-sgx@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Maxim Levitsky <mlevitsk@redhat.com>, 
	Hou Wenlong <houwenlong.hwl@antgroup.com>, Xiaoyao Li <xiaoyao.li@intel.com>, 
	Kechen Lu <kechenl@nvidia.com>, Oliver Upton <oliver.upton@linux.dev>, 
	Binbin Wu <binbin.wu@linux.intel.com>, Yang Weijiang <weijiang.yang@intel.com>, 
	Robert Hoo <robert.hoo.linux@gmail.com>
Content-Type: text/plain; charset="UTF-8"

When clearing CONSTANT_TSC during CPUID emulation due to a Hyper-V quirk,
use feature_bit() instead of SF() to ensure the bit is actually cleared.
SF() evaluates to zero if the _host_ doesn't support the feature.  I.e.
KVM could keep the bit set if userspace advertised CONSTANT_TSC despite
it not being supported in hardware.

Note, translating from a scattered feature to a the hardware version is
done by __feature_translate(), not SF().  The sole purpose of SF() is to
check kernel support for the scattered feature, *before* translation.

Cc: Vitaly Kuznetsov <vkuznets@redhat.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/cpuid.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
index 097bdc022d0f..776f24408fa3 100644
--- a/arch/x86/kvm/cpuid.c
+++ b/arch/x86/kvm/cpuid.c
@@ -1630,7 +1630,7 @@ bool kvm_cpuid(struct kvm_vcpu *vcpu, u32 *eax, u32 *ebx,
 				*ebx &= ~(F(RTM) | F(HLE));
 		} else if (function == 0x80000007) {
 			if (kvm_hv_invtsc_suppressed(vcpu))
-				*edx &= ~SF(CONSTANT_TSC);
+				*edx &= ~feature_bit(CONSTANT_TSC);
 		}
 	} else {
 		*eax = *ebx = *ecx = *edx = 0;
-- 
2.47.0.338.g60cca15819-goog


