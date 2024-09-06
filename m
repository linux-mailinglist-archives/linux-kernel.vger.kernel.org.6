Return-Path: <linux-kernel+bounces-318120-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 23FD396E8AB
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 06:35:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 50FD11C236B1
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 04:35:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E9D413957C;
	Fri,  6 Sep 2024 04:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FUPefJP/"
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 809FD86250
	for <linux-kernel@vger.kernel.org>; Fri,  6 Sep 2024 04:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725597264; cv=none; b=CsCZI2yG8zB/3IdVUNSygspPRVh9fAoeX79jqkU5Gh37UWlSBbKooGMkW+z78Mbertf+ASEydIr6dNb4Evk3gbD7dOGOAON7AYTyKNNhbACNi9CMrlPbOTmjuYlPNsZPo4b4MzXkugKlgpH5jafEe7MVaOaF68Pd2zrdq1PkLfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725597264; c=relaxed/simple;
	bh=vUO7vGmYGYbyr6uF29dDmJSIjGj15xrKsxlgZD+fbfg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=i3j2W891NqIjPCEVXMb0s4G6KUlR9ym/aLmSkxFIMG+zZK7nyKZOxLVizvAxY/TLuKKpk0tGgOWgGUlEpLYVBWoeTJtdt0lUinDB7SNu21oEjSPX2VsbTcYQOgrHDGjll0AcXoXUcQIH7iSqnTyEHPJgbVPf1/gau4VnKy+eids=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FUPefJP/; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-7cd7614d826so3289237a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 05 Sep 2024 21:34:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1725597263; x=1726202063; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=vgikLRROm580u43MLI6MsYbRQEvUit5RnsfmT63jtwE=;
        b=FUPefJP/mkwt7ASgqON3SD6fgvjFdLDCw9mLfc8r2DxQjNQT3Y0uu/K+G+KTwUsijd
         qCues+6mUfE5EtMqwGhcGBnj4oMKTYKTrgQTJiK3YcFC3QX/sW76yM0FsjHZcn73es1I
         1osHDH++r5teDW1cB4uOXvpZDZ02NdblZMixcbyPg6muPZenSDfjF9WpyiaOi8D3iJsw
         Gp7p7+0l2fPQ26TTTSQdsbwVGeoi2tw4+KeahFw2/YophgQgjIQzAL6G1OcKLt6zdBAQ
         vWMJRLaVAbDh7DrxWX4o4Hvtd+NXuAnUP19ZKNLgLPDFHS/kIdLvjTGNijavviUkdQK+
         vbAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725597263; x=1726202063;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vgikLRROm580u43MLI6MsYbRQEvUit5RnsfmT63jtwE=;
        b=NYM8UAV04pL7T4qhs4grceBPwDowdQujt6HQMwWlR3s58ccI8LRN8yJe+tAh7Zj/Fl
         Ych1IUmKyp1S5hv6xWUcHdJ43EAvNkyel6sIJv2SIIM9+qYD/jdE75T2vZlMQEGQgrXe
         jQnTdDkRMA8mlxETI8t/ye2h5cbxuxuQDm9Krxv1UhiJobajkR5AtknGxYlZETbZs7k2
         b7IMawamsgTW4ApTNR1fPIuf+b2O17p2vuX+d4KDvg8R5jA8CSRD2J6rDm4H7D7Wp5vQ
         ddLHubOAssOklm7L1gndbrpQ896DetHBVtooyIKC3zDHqeXtrUE3xF3npYQGjiIHFQx4
         Dpnw==
X-Forwarded-Encrypted: i=1; AJvYcCUx2epWPqEkDCtdAGNZ8jKq4sXOPEDoijku2PSWJ5I8Pt+HZJ/qGI8eeXn4Rtae6XUki+15FDWjBwt0FKQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyrMzu/wzPDVoINLwQSb+KJRn2zP6KOfWc6D6BWGbGQ2DEfrtbL
	rk/kT7t4QiEtv9XPvcnQvyIuoAqyja+4rklxq2arnuWjcMFTgqLgNw+E5NzJtNYBEMB1BCdej6+
	g9Q==
X-Google-Smtp-Source: AGHT+IEyEFfjoRDNJyVIEZ+IVKjmpudL0fgn44x8C5JkT3Kr/DFcFMcxqut3wtjuTeyUVblYq49w0HSFXXU=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:903:1c5:b0:206:8dca:1b1d with SMTP id
 d9443c01a7336-206eeba5a3dmr964925ad.4.1725597262568; Thu, 05 Sep 2024
 21:34:22 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu,  5 Sep 2024 21:34:09 -0700
In-Reply-To: <20240906043413.1049633-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240906043413.1049633-1-seanjc@google.com>
X-Mailer: git-send-email 2.46.0.469.g59c65b2a67-goog
Message-ID: <20240906043413.1049633-4-seanjc@google.com>
Subject: [PATCH v2 3/7] KVM: nVMX: Suppress external interrupt VM-Exit
 injection if there's no IRQ
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Nathan Chancellor <nathan@kernel.org>, Chao Gao <chao.gao@intel.com>, 
	Zeng Guang <guang.zeng@intel.com>
Content-Type: text/plain; charset="UTF-8"

In the should-be-impossible scenario that kvm_cpu_get_interrupt() doesn't
return a valid vector after checking kvm_cpu_has_interrupt(), skip VM-Exit
injection to reduce the probability of crashing/confusing L1.  Now that
KVM gets the IRQ _before_ calling nested_vmx_vmexit(), squashing the
VM-Exit injection is trivial since there are no actions that need to be
undone.

Reviewed-by: Chao Gao <chao.gao@intel.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/vmx/nested.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
index e6af5f1d3b61..6b7e0ab0e45e 100644
--- a/arch/x86/kvm/vmx/nested.c
+++ b/arch/x86/kvm/vmx/nested.c
@@ -4304,7 +4304,8 @@ static int vmx_check_nested_events(struct kvm_vcpu *vcpu)
 		}
 
 		irq = kvm_apic_has_interrupt(vcpu);
-		WARN_ON_ONCE(irq < 0);
+		if (WARN_ON_ONCE(irq < 0))
+			goto no_vmexit;
 
 		nested_vmx_vmexit(vcpu, EXIT_REASON_EXTERNAL_INTERRUPT,
 				  INTR_INFO_VALID_MASK | INTR_TYPE_EXT_INTR | irq, 0);
-- 
2.46.0.469.g59c65b2a67-goog


