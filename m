Return-Path: <linux-kernel+bounces-515948-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9320FA36AB8
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Feb 2025 02:15:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E931B3B0310
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Feb 2025 01:15:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBEE318892D;
	Sat, 15 Feb 2025 01:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Rwzn+S4h"
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC3C41624C8
	for <linux-kernel@vger.kernel.org>; Sat, 15 Feb 2025 01:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739582088; cv=none; b=XONTVSp8CVwFipkcyrcu93nU6NCe4jrMbDWQkYGlEZbgQdeAfgVsUkabFJedOKBSyi+0uqofbxOYt13FORQ7ZeqY5w0pQSjzkqcrK6b3UEqEDt/v0qDUnmvEMWZK6fsVAc9oX55HkvNW/xDO6stjWJ/IZgWytrZzwzGgAEFXjOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739582088; c=relaxed/simple;
	bh=V20/5Zcwsh3LkusvwxipaeAPlQmSrKGd8beRUUCMKWc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=q1eNZ1W7NEfn/RcCh0a4iYCeFozGYrlV1HeftxsKe1//iVeyOZWM4MqwTXMNsRO1VTlUIqc2ys4Ds3879GU6LYqW6FnpvYPU/ZcPYQ/EGeN7qcorP3OlRD/BZuNbzWdkFjiw/NbOK83Vqsb99hiwdIFDYb2NgUeWtu7LMn3+Ibg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Rwzn+S4h; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-220e1593b85so40385075ad.3
        for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 17:14:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739582086; x=1740186886; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=j7vKBoevqSd0YmMKIcf2UgJa+X4zyjdi3hzZRBAtboE=;
        b=Rwzn+S4hIGg4lO+DfRTiSY4efs3/Y/cAxBcBhKr9SwwN1IJ4OS4hNcxNLrJkkLTJJn
         h0Pw3yE5+U31JfWy4pqYUivC/JYuAnWowf/fHtZeFgB2jbPJQW8le9TLU1MXxOWyRDBz
         2NtUvHAXmXllWtXHYWM21FkVpO2ZRJEJsfOHv8NAQGsGNnl1hOVrCBuzn+PHqf0wqryY
         /DHO4z0b6E74WWN4bvUgshv6r4UdeKKthM7TzNLYG0HX15xlNHXMf+s6o8u/knZizIdY
         JyLzF17t18bsC7ykkLFm+zjVqeOv2YgOTGBCTyihitMLmGvXBOhQ0qTgGK+Ny6CvYGcZ
         e2vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739582086; x=1740186886;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=j7vKBoevqSd0YmMKIcf2UgJa+X4zyjdi3hzZRBAtboE=;
        b=iBvwKRA1PW45iy0rcfG8644+fUsmRsBY0cOpSXd7YOuWzZ7Tpfwcl/W2f1zRUCKSjT
         mdYjhbfI4Aud/iOBhf0HJq/xA2HrIbwFHoYXVdzieNudhxpVerW1ru8uIZMieZJofexH
         pTUiJWYMpVvJQVZVGHeCKymOXYYRJh/jo8eO5+EFnrF4i1A8WjugUvIzrzFP68jmKD54
         W/WY9otSSz62mWQ9NtEvDc6q4AIU9V2hBJlB4BuyFmy0ReEExMDtYuy8AppULwGBPDL+
         po83dUftJ/bcep/3otAyhmPoFVnlPDigw5vUAsCcKGnFAZIHXghrZEFRTFOQyopefBuf
         GU2g==
X-Forwarded-Encrypted: i=1; AJvYcCUl7EbM6elCyBVIG1ZTkiDFqc3fN5FVJyXB2/92AFCS1fN8d9hUs9yPJns6pFjw3N6ewwIRo27DPT+OP1M=@vger.kernel.org
X-Gm-Message-State: AOJu0YxaEgFhaBoetVAb8TivdCSRLWPaIUM/U8NQGXRDeTZsSdzScB3W
	xrV60/ojVmHwz6Kk6us3iqRkzK67FITBG5lijlaEFai1n/HjKRgJqbqxh7/0h4djt44yY9k5H6L
	xYg==
X-Google-Smtp-Source: AGHT+IGtO3LhcclmaxlBOzDhlZWiTA4X0kQhu9BMoJyJBJrBPP1akoMVuWrkGmqqeaspC7bpVglvyuzDJl4=
X-Received: from pgfp3.prod.google.com ([2002:a63:ab03:0:b0:add:f880:2c5b])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:e8c:b0:1eb:48e2:2c2f
 with SMTP id adf61e73a8af0-1ee8cbc1ea9mr3069398637.30.1739582086175; Fri, 14
 Feb 2025 17:14:46 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 14 Feb 2025 17:14:36 -0800
In-Reply-To: <20250215011437.1203084-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250215011437.1203084-1-seanjc@google.com>
X-Mailer: git-send-email 2.48.1.601.g30ceb7b040-goog
Message-ID: <20250215011437.1203084-5-seanjc@google.com>
Subject: [PATCH v2 4/5] KVM: x86/xen: Bury xen_hvm_config behind CONFIG_KVM_XEN=y
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	David Woodhouse <dwmw2@infradead.org>, Paul Durrant <paul@xen.org>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Joao Martins <joao.m.martins@oracle.com>, David Woodhouse <dwmw@amazon.co.uk>
Content-Type: text/plain; charset="UTF-8"

Now that all references to kvm_vcpu_arch.xen_hvm_config are wrapped with
CONFIG_KVM_XEN #ifdefs, bury the field itself behind CONFIG_KVM_XEN=y.

No functional change intended.

Reviewed-by: David Woodhouse <dwmw@amazon.co.uk>
Reviewed-by: Paul Durrant <paul@xen.org>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/include/asm/kvm_host.h | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index b15cde0a9b5c..f31fca4c4968 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -1410,8 +1410,6 @@ struct kvm_arch {
 	struct delayed_work kvmclock_update_work;
 	struct delayed_work kvmclock_sync_work;
 
-	struct kvm_xen_hvm_config xen_hvm_config;
-
 	/* reads protected by irq_srcu, writes by irq_lock */
 	struct hlist_head mask_notifier_list;
 
@@ -1421,6 +1419,7 @@ struct kvm_arch {
 
 #ifdef CONFIG_KVM_XEN
 	struct kvm_xen xen;
+	struct kvm_xen_hvm_config xen_hvm_config;
 #endif
 
 	bool backwards_tsc_observed;
-- 
2.48.1.601.g30ceb7b040-goog


