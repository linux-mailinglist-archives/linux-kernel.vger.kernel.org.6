Return-Path: <linux-kernel+bounces-424087-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE1519DB07A
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 01:57:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4A601B2326D
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 00:57:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77AEF13F42F;
	Thu, 28 Nov 2024 00:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ren8luT0"
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F0D013A24D
	for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2024 00:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732755365; cv=none; b=hwn4NU7YxptlSfiWRT0saj8zgqWJSm5w1AC09hkqs0p+1k8TAdJbPKRfkN7RFJR7VEHGjkecE128K/+UIwSDRm6oY3AhBJ8wOTy4hY5HUMx4EvoDjINIdEs8OKjuPIxicf+dpGXj9N1YvLpP8OigkUdMeL0T17AyjPDDR5ejjcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732755365; c=relaxed/simple;
	bh=UOHD8P5jAo/tu9DZeP+a1DmnkO+B67XGDTnvDmQDwR8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=AfEw+zb96dbtqrvSPlTrWPbMsaxuMSXWSkK3TYZlAyA08b9VNpXOMsk5JDAAdUWrFGkXFvjUEg39Rav3+wW6Y3zPh2L+fl1Q5B93P3RqMJycmAlzEk90YAyyPVcfEKsEfqeGFQ6yV8FIJoa0W9Ks3bCpYD0c+l8F3uIjwHZ8ZJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ren8luT0; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-20d15285c87so2592375ad.3
        for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2024 16:56:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1732755364; x=1733360164; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=ysvaIdmMpR/VmHKwcGzTb4HtexOKJ4Ghx7ZOeauEtvk=;
        b=ren8luT097x+yMTLNnr2h+Aq0eFfU7344rbVXAxh6GR3/wR6SgbXCv8upO3F9dd6Tn
         1sCZD9r2wNP8gIZAspKoycsfW/GHdjyJJkK9AhQJbbKLtP75E/fQVg83mJWFu1nMMBeS
         l1y8rzWk5az2kpjv80rv+vJl6NfdnPxIMoDSotd+PT9nozU6BvRqcPitkCFq+1IwpMGc
         2wHVLwlRmogTC6JCW0txzc/l/MLio6yiK0cp2g+xFB5mGatB5thgp9ggu2b0TgdQbuhw
         cWF/nba4JMvwdtK2BtqVwKDBroj9Xx5ZrTCEgbCVMu1D6j5/m2xAIOzF0r9014YToNrg
         eobg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732755364; x=1733360164;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ysvaIdmMpR/VmHKwcGzTb4HtexOKJ4Ghx7ZOeauEtvk=;
        b=Yz+XuLsrhprwHbe4mU+qazwrC9Gc1DttMo/Dq0GqxC8sm3P0wJefR/hKZAgRL3RCJO
         huIRSbLgHg8ZaN9w/1oeLor5Hl/x3IJoWLUyUhi0vAV8C4AayPF7lqEOjDmrUgYBtnNq
         R1dSG3WvCi0TWS4TTv5cGUCofjnmJa9ka7qE1/VFcV0DOPjlXzPMh/OFF+n5Iaz7A10x
         hsXIxjIDcUaDzgaSS7vTaWhDkYOgdKwCCEXNcuZgpO9KFJmWLK4SwRfYDwteiO3JGCtt
         9lyvEvsITOL7TjoAj+9glvx+Qs5kmnHrtx6738c03f8QXGPkVcVSeHhBnjC58+OLtou4
         VTjA==
X-Forwarded-Encrypted: i=1; AJvYcCXzp/wdOmLIF8j1klbdhldQBs71DbFFVoNb227lTFo1hZ2hwpb0PfXbJgzuXSeq0wB/wWIPIqwBUfwtYK0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yypco+Qe1Mb5nfr4NL6GzyhpS4N0H9/KewEUAoQ/EPgoz0K8LoJ
	E+6sPKyYkMnmdEJw2MzHHTBbCLcnR9YNM/jPxlTvjRl0hw2HX5UEUi76CHcPn92fgrHW0lJqCaH
	q1g==
X-Google-Smtp-Source: AGHT+IE+ChL1KLorT8CIkfmIr19XCryd//IzNWr5z8aQi0CF/Qf3ZQTw4qD7deHM4fsaQ6e/45gZiVf87tA=
X-Received: from plbmb7.prod.google.com ([2002:a17:903:987:b0:211:b7e:ba7d])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:e84f:b0:212:618a:461f
 with SMTP id d9443c01a7336-21501b5aed2mr63134555ad.41.1732755363732; Wed, 27
 Nov 2024 16:56:03 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Wed, 27 Nov 2024 16:55:39 -0800
In-Reply-To: <20241128005547.4077116-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241128005547.4077116-1-seanjc@google.com>
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
Message-ID: <20241128005547.4077116-9-seanjc@google.com>
Subject: [PATCH v4 08/16] KVM: sefltests: Explicitly include ucall_common.h in mmu_stress_test.c
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

Explicitly include ucall_common.h in the MMU stress test, as unlike arm64
and x86-64, RISC-V doesn't include ucall_common.h in its processor.h, i.e.
this will allow enabling the test on RISC-V.

Reported-by: Andrew Jones <ajones@ventanamicro.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 tools/testing/selftests/kvm/mmu_stress_test.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/kvm/mmu_stress_test.c b/tools/testing/selftests/kvm/mmu_stress_test.c
index 5467b12f5903..fbb693428a82 100644
--- a/tools/testing/selftests/kvm/mmu_stress_test.c
+++ b/tools/testing/selftests/kvm/mmu_stress_test.c
@@ -15,6 +15,7 @@
 #include "test_util.h"
 #include "guest_modes.h"
 #include "processor.h"
+#include "ucall_common.h"
 
 static void guest_code(uint64_t start_gpa, uint64_t end_gpa, uint64_t stride)
 {
-- 
2.47.0.338.g60cca15819-goog


