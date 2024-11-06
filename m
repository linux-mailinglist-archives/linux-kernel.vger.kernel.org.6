Return-Path: <linux-kernel+bounces-397589-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 999019BDDB6
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 04:40:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 28BCC284E39
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 03:40:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6209A190499;
	Wed,  6 Nov 2024 03:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="osFozrZ4"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5997B190468
	for <linux-kernel@vger.kernel.org>; Wed,  6 Nov 2024 03:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730864443; cv=none; b=VhU7tbeHBETaYATz04Yg5s32H/lsvKV1EeZLT9iDoXbf8dwYepIkrkZbx56Y1ZVrJ6oGUWiPhYmjxwcADbDkkHlVhc7Ry0fdOcj8s8xIYrrVlxS7HHMMGwscxUW0wVO3HsrrIGX5K0FYSuKTweUOFWWQBI6CzTdHZm9PM1pzxok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730864443; c=relaxed/simple;
	bh=CMQ76uKI1FEpDkwvFQyA0kPM9eXSHdq8hIlxtAz4vQA=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=KWqOqFgt0GD/EM77EsFZ3fn3YbQB5Dcpj4n0Jpkdqf8VLEz1VVi/+WRzl3yA8dhlcW/53eHIWMqyDGlL59Sex1I/BMCM8d1Paz6VBaQBaMqGj5OklTHir+BkkTFqurMdrxeBgBQnDhxJM9gHA2Xn/7EQJyb+qyOlwM19nHUhcvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jsperbeck.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=osFozrZ4; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jsperbeck.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6ea8a5e83a3so66348047b3.2
        for <linux-kernel@vger.kernel.org>; Tue, 05 Nov 2024 19:40:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730864441; x=1731469241; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=LplVTGJVvGJFvhtTV6mcwx8iPQDI2scKmqd+ot8fMsw=;
        b=osFozrZ4fRRdbnpx21dSCPnFkfbAyJQBT5sS9E9BHyQLY1lhn+iHBdu3R2h99tlUva
         zQzeBN6MOf1M48V+4MqlkOQh8naoZaW/cioPiDnSkNSnI4mjYGKC9GBodMHiOQgsIIMK
         aFUiGb572Av1HqXsjuPhXU8EWtpLV3MIiJTA27gdfWsDP/UZnJEoYoxyDyOAgUitfxV2
         fqTKoOF2se6ApRH/+qoLLltX0oKhSPiYy+7dSmi2q/uNnobUEo11UzrgotMdb4dNaGmr
         KvtxaT8IyqJQ4F60W4ghIcAM/2ffin85slLbqVQDiwUkY0nKhngb1UT13Nah/S9a3KjH
         YuEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730864441; x=1731469241;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LplVTGJVvGJFvhtTV6mcwx8iPQDI2scKmqd+ot8fMsw=;
        b=KZJuAR7rTtl48HebPfVWEM7/vAO3H807zTVS1U3jsVmjhJvdtSScfC9xCg22yupKyR
         l5ljbYSMRMc6EDjgwondPlW5fiXTgvqMhdW5nSAYICggx2jc0KBAjdvHLIHh2gWwvjgB
         9iYgE44MFfOVK/IcDZGIMoeo/9WuJKRrPkeLLHl1knfzSi9AnLxhAhjo7qMMZBRPyx0B
         NxCtJViHd8pJMKJa9ry5oEXzEGAt43qKo8+e6/zvKPeFNIySwtNgZW2rFCHgnVzeVgmA
         Ia7tAqvG8y4zd5rAPR97/CNKnyYjWdqH9QilJ9GvGTl994tqTtHovuVxoJjpbhU+ItCx
         9a2Q==
X-Forwarded-Encrypted: i=1; AJvYcCVQP3f212O3J/yq795jtjuN5Zu+imENjDH/WN/8+TnXfCkFBCnIRQ/SkEbeZF7GR9yU53IpUZg2YTIajws=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJwkF5/w2yNPF3+HYdMSj/RSuEW+hiAWe3guBTLfRAbyQeyfEg
	ym5LpIiK/MPyyt28RiXADxI0yzayUZbFSeEnYIG+Cr4xoalV0gZO/gB5vZQHvLcHUEUrcta5a3R
	ijrLsFSwTIJRTSg==
X-Google-Smtp-Source: AGHT+IGzB+ojrRUXG2iLAlNNLqDQ7VKHBuH5SLcr3K23iMUurWN3UCPuphjmVaHR+inkaEx7vzmb8A5IqZO0L4g=
X-Received: from jsperbeck7.c.googlers.com ([fda3:e722:ac3:cc00:59:977b:ac1c:3a1d])
 (user=jsperbeck job=sendgmr) by 2002:a05:690c:4c09:b0:6e7:e493:2db6 with SMTP
 id 00721157ae682-6ea3b951361mr2818897b3.3.1730864440817; Tue, 05 Nov 2024
 19:40:40 -0800 (PST)
Date: Tue,  5 Nov 2024 19:40:31 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.0.277.g8800431eea-goog
Message-ID: <20241106034031.503291-1-jsperbeck@google.com>
Subject: [PATCH] KVM: selftests: use X86_MEMTYPE_WB instead of VMX_BASIC_MEM_TYPE_WB
From: John Sperbeck <jsperbeck@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	John Sperbeck <jsperbeck@google.com>
Content-Type: text/plain; charset="UTF-8"

In 08a7d2525511 ("tools arch x86: Sync the msr-index.h copy with the
kernel sources"), VMX_BASIC_MEM_TYPE_WB was removed.  Use X86_MEMTYPE_WB
instead.

Fixes: 08a7d2525511 ("tools arch x86: Sync the msr-index.h copy with the
kernel sources")
Signed-off-by: John Sperbeck <jsperbeck@google.com>
---
 tools/testing/selftests/kvm/lib/x86_64/vmx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/kvm/lib/x86_64/vmx.c b/tools/testing/selftests/kvm/lib/x86_64/vmx.c
index 089b8925b6b2..d7ac122820bf 100644
--- a/tools/testing/selftests/kvm/lib/x86_64/vmx.c
+++ b/tools/testing/selftests/kvm/lib/x86_64/vmx.c
@@ -200,7 +200,7 @@ static inline void init_vmcs_control_fields(struct vmx_pages *vmx)
 	if (vmx->eptp_gpa) {
 		uint64_t ept_paddr;
 		struct eptPageTablePointer eptp = {
-			.memory_type = VMX_BASIC_MEM_TYPE_WB,
+			.memory_type = X86_MEMTYPE_WB,
 			.page_walk_length = 3, /* + 1 */
 			.ad_enabled = ept_vpid_cap_supported(VMX_EPT_VPID_CAP_AD_BITS),
 			.address = vmx->eptp_gpa >> PAGE_SHIFT_4K,
-- 
2.47.0.277.g8800431eea-goog


