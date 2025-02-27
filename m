Return-Path: <linux-kernel+bounces-535417-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D4F2AA47262
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 03:25:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CDBE23A9D45
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 02:24:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB22B1FF5E3;
	Thu, 27 Feb 2025 02:19:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WLccEHwF"
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B6BB1EFF9E
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 02:19:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740622773; cv=none; b=NcJYJr9+fvExLyj3jURvpqijMFB3xmr3GxDOE2PsVzSAUXXFpbC+8NnvRcbrNvbP0cwo8sc8cE8DBC5HszGVp1y0noXSpaJDWvSfhtYj58+g8JpFJlweeYzaQ0crabO8Tv1qUAGH4RN9+4bb58fdi2Jp+jSBTaNIq9od29OLS3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740622773; c=relaxed/simple;
	bh=Ct4a9oRRcb4uCHXZ3lSQwfqmCTAwLfdRFXjQ6iMkxFY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=l9wZfO9IgdxCNbqJ7BtS31af8jbSgW20i2x9xvjACAGnX/GgKkRvedPmbpmxWzZZEueS9uRdUT6JaAchoonBECjpv8Vle+FbGLRZ8q7ADGXavtfFRusouWKueQFv3sHgnMFGUd98swjOEZ+ukOK1tMgeWWI2Ze2D/7vKtHXN3gQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WLccEHwF; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-2fc43be27f8so1571029a91.1
        for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 18:19:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740622771; x=1741227571; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=Cdk6AVEMbYJ/6Avsp+2Egdk5E71fbrI/hFT7BN4L+X8=;
        b=WLccEHwFFmO1MV/Sx2o9uqoN4m/rnZV4iLX37pdEs5bXz0rgQ4vXgUq2/rLOUh1+oI
         cgbeDiBarE5LltOCTUEdyqVovJfe88UflAY3dbiRJ1MkUtlTiW9pKU84Y+WjDhA0HrkX
         nlUkRBI1tI1jKoC7zFN5rKNmoPL38BzvEfE8izv48MQuwfoOHObXX51lSh0v3pG5vK40
         rhRbvu3uCCTBiv6nDMlZ3z4XRP7YeLVabhCqNNkQu4MW8kDpZnjkk+/tP02ML9+85/yq
         LuaY/eX4+szxEMqugecY4mopoDqZTXH41KtN7f4Ih/JMnoG8bsXtNfa8TrPVX/nnwnND
         qNrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740622771; x=1741227571;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Cdk6AVEMbYJ/6Avsp+2Egdk5E71fbrI/hFT7BN4L+X8=;
        b=Z8YbssMH9tKhGmy16LUFWycBT2DCupWRpZnIOJQkF7Zc7VBD+kVk9slDYOWPe3x0+O
         KTlmsAE6vy4GQvc8hMdoK1QMjIOlM6W8wQj3AO584ZguAcDwtF4b5pGr3ViQ12NBT60g
         Oz1JmWzNlnYQWXoZJnVLuVcXCexoTaJBKoR2Ff4CiVBxx75HRVmm9uanmAqPKJz8ybOh
         YERo3B1HNhiG5JA563Xt0U+ri3u5nFdT3EidwqMtTwhcfd3pSkBQbfpuXqbpzHJ4Gwvc
         kWcXyQh0lB+aRK1guLiUuotDgUfhIm/A4XkjOkk51GYrGYZE+Ok34KFd9Q8s0P0NbxPp
         w36A==
X-Gm-Message-State: AOJu0Yye9afoNZ70Jbe/AUal06r9V25MNC4NuDcz7R3mgA0QQNaC4yLi
	Dpsh1VkmIEW2DdcXg+lT2V4X9Zf5YYLF32PZjH2+zbM/ObWFWErrsjKZLfFYcD/ZWsDD7DRa5X+
	ddA==
X-Google-Smtp-Source: AGHT+IGFILkiLdlR4RAAXuJxcaVfe/0bxh03RUlKL7+1zFXEwiB1qD3NnSdVhpPB8u60HxzWl62A5c233Wg=
X-Received: from pjbdb4.prod.google.com ([2002:a17:90a:d644:b0:2fc:2ee0:d385])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:5688:b0:2ee:a4f2:b307
 with SMTP id 98e67ed59e1d1-2fe7e2eaca6mr8295061a91.4.1740622771119; Wed, 26
 Feb 2025 18:19:31 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Wed, 26 Feb 2025 18:18:32 -0800
In-Reply-To: <20250227021855.3257188-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250227021855.3257188-1-seanjc@google.com>
X-Mailer: git-send-email 2.48.1.711.g2feabab25a-goog
Message-ID: <20250227021855.3257188-17-seanjc@google.com>
Subject: [PATCH v2 16/38] x86/vmware: Nullify save/restore hooks when using
 VMware's sched_clock
From: Sean Christopherson <seanjc@google.com>
To: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Sean Christopherson <seanjc@google.com>, Juergen Gross <jgross@suse.com>, 
	"K. Y. Srinivasan" <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, 
	Dexuan Cui <decui@microsoft.com>, Ajay Kaher <ajay.kaher@broadcom.com>, 
	Jan Kiszka <jan.kiszka@siemens.com>, Andy Lutomirski <luto@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, 
	John Stultz <jstultz@google.com>
Cc: linux-kernel@vger.kernel.org, linux-coco@lists.linux.dev, 
	kvm@vger.kernel.org, virtualization@lists.linux.dev, 
	linux-hyperv@vger.kernel.org, xen-devel@lists.xenproject.org, 
	Tom Lendacky <thomas.lendacky@amd.com>, Nikunj A Dadhania <nikunj@amd.com>
Content-Type: text/plain; charset="UTF-8"

Nullify the sched_clock save/restore hooks when using VMware's version of
sched_clock.  This will allow extending paravirt_set_sched_clock() to set
the save/restore hooks, without having to simultaneously change the
behavior of VMware guests.

Note, it's not at all obvious that it's safe/correct for VMware guests to
do nothing on suspend/resume, but that's a pre-existing problem.  Leave it
for a VMware expert to sort out.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kernel/cpu/vmware.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/vmware.c b/arch/x86/kernel/cpu/vmware.c
index d6f079a75f05..d6eadb5b37fd 100644
--- a/arch/x86/kernel/cpu/vmware.c
+++ b/arch/x86/kernel/cpu/vmware.c
@@ -344,8 +344,11 @@ static void __init vmware_paravirt_ops_setup(void)
 
 	vmware_cyc2ns_setup();
 
-	if (vmw_sched_clock)
+	if (vmw_sched_clock) {
 		paravirt_set_sched_clock(vmware_sched_clock);
+		x86_platform.save_sched_clock_state = NULL;
+		x86_platform.restore_sched_clock_state = NULL;
+	}
 
 	if (vmware_is_stealclock_available()) {
 		has_steal_clock = true;
-- 
2.48.1.711.g2feabab25a-goog


