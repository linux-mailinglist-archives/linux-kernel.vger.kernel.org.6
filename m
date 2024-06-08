Return-Path: <linux-kernel+bounces-206845-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 04B58900EB1
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jun 2024 02:08:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 164F41C2161C
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jun 2024 00:08:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28CC41CD2C;
	Sat,  8 Jun 2024 00:06:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GE40QlRU"
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 397241B970
	for <linux-kernel@vger.kernel.org>; Sat,  8 Jun 2024 00:06:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717805215; cv=none; b=HAL2ndBs0ujFp/q77snwJf9UqGuhMNKZoapepzaKgXOdenp5Yiu7uIajfAGa6zERUV6n85J4WUr6OEuUNjQxP/q2uQHdKiT0HU3u09r1syvDeXyepnFvwmm16hr8mB7CTK1wIXN3cWK1VdGDL3USxjUatxK7Mn+J1Ws6LWxJNtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717805215; c=relaxed/simple;
	bh=+Rgd0uG8zFVDeMbiPveKaoIB6ed40a/lydcxeYv2SLU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=rqPBN40czZOYjk7+3xyHqch2zchrLWEHELsQUVyHl5c4c50Xwzvbu3mRfD6Btr0TCD97mjgP11tuz5nEeHGmngZBntLCHNpBh7VYWgf3/ZuFyZnNn3712E5HVj8mKzbZGYe02lMsmRTE/S2g6tY+9ySj+2N6DxvKr4750ZNUIhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GE40QlRU; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-6c380e03048so2468424a12.3
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jun 2024 17:06:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1717805213; x=1718410013; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=9BJaexKSfJJd6oXZEzTDtIkjFffas2FF3vn5yJVMfK8=;
        b=GE40QlRUVmPsTczYGSoz45viAD2CaY7vIiJgOmq1+8pUqqbKP4r4GFb0eYZd3oYtUp
         PZV/H15eLMiLjWEfvtSDXhIXlqLPJSXIu2pOtfuPWWxMpM+fydK2bU0IFlhT2NuCmlGz
         UGzAHGgOKAovBZstw7mf07nks4GQUjDXx/Cw2EFEjXS98oeBXLqT6lmMt4RssHKjrX8k
         uMQE/Y610Z8vKh2P7IA/q8JIf4QIOk33JL/avVKK7qWDDfAwsb5xUU3Le3G529ZyWLAo
         +9323joRiIW+w7bfhIPm2eR+VSiHixiK+WxoZ6+ao50jrimj1UJbQrMYzouvHMPqchiK
         8k1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717805213; x=1718410013;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9BJaexKSfJJd6oXZEzTDtIkjFffas2FF3vn5yJVMfK8=;
        b=h7xRuFcnXn6mA8BQ9hwtBW0VAJOlGSgHAONjFYclw8uwhF0qsWVPCVoHehFxDclhVV
         DOm9AmFrezujz4s0nqpeJ6wa8BRn2UBwOFtX0y0OmA79HDwdWswqsEY0uGkJoua666fS
         CpwbM+l91vm/M1PXvHKejMxOGJEt8yzeS95MKOQzxj6HfBCDE5gzBvvjGnlmNF6eu9Et
         jWJttbSWaiei628abEydEW5Fnq7U1UU56cS3P77WhP7abHtuS01RUV9fqs3Zcrfhgj8v
         UdN+hahd+lUkjVa97/mURtbukjd6JMFFO4pf+WDrzeEPV+DMg/xSPNBVQGtHDq2hA8fo
         pNNQ==
X-Forwarded-Encrypted: i=1; AJvYcCW4yj8368uxRDc4JQyu3MTVxrJiiSsSMi5aQOk8i9v76lL+xXG0rnNeLSbzlkUM3OSFcj0A2nqx+E/SPVAWBzJ8O8b/X6OBdS2u/60D
X-Gm-Message-State: AOJu0YyXl7ayhNj4N3OKwPc15KzHyxvByDV9qwgdBLuRv4SREHo9xv8J
	4cVv7O/xnYHuFSOMp792ycNsIpPIPxJH3qkicRAKdxPiYKnQ0vtSSs9pz2OpoGkd7gf3HSP0bAf
	cyA==
X-Google-Smtp-Source: AGHT+IGSWWVQPTwJRta7zJEdra8ZC8/nCqaYH3EjnTjLAbAgOrfQRgAJ3ikjR3Fon2AfI2+l6m4fHLN4sa8=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:90a:6309:b0:2c0:122d:c534 with SMTP id
 98e67ed59e1d1-2c2bcc5f046mr9783a91.7.1717805213214; Fri, 07 Jun 2024 17:06:53
 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri,  7 Jun 2024 17:06:37 -0700
In-Reply-To: <20240608000639.3295768-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240608000639.3295768-1-seanjc@google.com>
X-Mailer: git-send-email 2.45.2.505.gda0bf45e8d-goog
Message-ID: <20240608000639.3295768-7-seanjc@google.com>
Subject: [PATCH v3 6/8] x86/reboot: Unconditionally define cpu_emergency_virt_cb
 typedef
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Sean Christopherson <seanjc@google.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Chao Gao <chao.gao@intel.com>, Kai Huang <kai.huang@intel.com>
Content-Type: text/plain; charset="UTF-8"

Define cpu_emergency_virt_cb even if the kernel is being built without KVM
support so that KVM can reference the typedef in asm/kvm_host.h without
needing yet more #ifdefs.

No functional change intended.

Acked-by: Kai Huang <kai.huang@intel.com>
Reviewed-by: Chao Gao <chao.gao@intel.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/include/asm/reboot.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/reboot.h b/arch/x86/include/asm/reboot.h
index 6536873f8fc0..d0ef2a678d66 100644
--- a/arch/x86/include/asm/reboot.h
+++ b/arch/x86/include/asm/reboot.h
@@ -25,8 +25,8 @@ void __noreturn machine_real_restart(unsigned int type);
 #define MRR_BIOS	0
 #define MRR_APM		1
 
-#if IS_ENABLED(CONFIG_KVM_INTEL) || IS_ENABLED(CONFIG_KVM_AMD)
 typedef void (cpu_emergency_virt_cb)(void);
+#if IS_ENABLED(CONFIG_KVM_INTEL) || IS_ENABLED(CONFIG_KVM_AMD)
 void cpu_emergency_register_virt_callback(cpu_emergency_virt_cb *callback);
 void cpu_emergency_unregister_virt_callback(cpu_emergency_virt_cb *callback);
 void cpu_emergency_disable_virtualization(void);
-- 
2.45.2.505.gda0bf45e8d-goog


