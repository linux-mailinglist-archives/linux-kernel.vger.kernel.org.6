Return-Path: <linux-kernel+bounces-424084-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3876F9DB074
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 01:57:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 74C89B20EC1
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 00:57:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C40D83CD2;
	Thu, 28 Nov 2024 00:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IAY2caXQ"
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38CC04CDEC
	for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2024 00:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732755360; cv=none; b=RhMP4c1tkNgGZrOCM934LS4+Vbn2xGyt3IUMRfaAdEOsqpDP2XOMF84m3nA8WUWm0cR99Egy+DScgh1XxNV8k2viX6gyAm0aRcyPL3dD0y90QXRhhGOTZeIWmwvnTSm2PQYsbXiblQ3nN3M79LcWrsqUVAkXPBx+cWSIw+Lx/vI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732755360; c=relaxed/simple;
	bh=6/wTQsGJs8irAo/psByDX9+eFhZ+LD4ILASalomr9Cw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=t9rnTGhJlMkBUV+FRgbC4HFjqM+pju3VPrrh4r8kZcLQbaTLxqPzltgtVlSrk7k0ybpRuAjHt91uIqgO/lZFKo1gyIXYXcmHM4orgkSFCwj5Keu7TuVDVsTppxmnapFQhv9dFZgEJmfb0KptASe464wzvXLrPMxvZtEJ9kH9qnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IAY2caXQ; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-724fc3f60c1so413444b3a.2
        for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2024 16:55:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1732755359; x=1733360159; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=Qp0x5jmf6wCt1OmSFixie+OQOct6OMtePnY0hHC3FqE=;
        b=IAY2caXQY2aOj41whTKMWqYPhfetl6lY7LeQQOWuJtul7PCFYaT6r2l9DRvZnDG1n0
         0oHEEatyuoK0VXCyyYDaMGTGohJsin6k3ZlvJqMi3DXxX7OXwMy+JPsdZYt+rsZVtSjV
         2fbLZm2l1RRAzvvrcJA+kFjGGQHW+D1iEziBMhGOCsQxfPUGkk5Lstip3A8IwL8MtZcS
         SeWOmeGYjpzq6po3Le20nXfaDMM6LcIwIClCQmIvC3N9u2TgCrKHf5P7JroYQY0nidYo
         lNbcqsWSLK3aQSVyJZ4UeuSDbfF6OHVhBCqW5WyaK+E1x9LX56Mlrf8qXhYHq8UDISbK
         2l2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732755359; x=1733360159;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Qp0x5jmf6wCt1OmSFixie+OQOct6OMtePnY0hHC3FqE=;
        b=qjlHoayGvdI8NfVOm/k+9ntL4nQmYKHs1si/3Jb7xcigc0GjHmfzHXDHmG9ZUCf/CL
         EbVmCENUY+lPjBXFJhKM5UME6YWj0BR1kxm1FnRJogVUqrMiypcuWggC/POna0iDXuqk
         MgNlDvql9HSHd1JiTJFKqvKe+9KA3PZFaSh1sx8PZe0z7yK9bayJ2wUpSa0vpDg3rFSt
         qeNxMZRjHRmkX1MqRdKyZF1bNXlbWp9WYmtOc40i3MSuwAhsCxJcvSqm8HS0SvPlnFoo
         yT+VAs7oE7MK4et7w2UVjvvsayigqe+cGwBhbiDuRRDwoopz1sf2qwiar2GwFf2DpXKU
         BsIQ==
X-Forwarded-Encrypted: i=1; AJvYcCVtvZY9dHb4zPe67PN50FxmCZN0ZLxe9MkUyqKDiPC2RfRW/a4P7NmjUqsTnXg9E5qzwbwQ2l/1lODMJaw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwcmOLXdELihpwNxlL6LK2qwWpZzvcs0NVUJUHb9MrADO30je8e
	YBYwqWztFz0lq5l9F4SlfkCBgFaocqzQGpOTS3RQwG6SZU46n5wlpxcYZyKD1ameM/Sxq4+RZm9
	WHA==
X-Google-Smtp-Source: AGHT+IHRct+tg9si6FXkj3XDfvATucfZZx/pmM1rsyJ2yuaIieXkck617uTZGF3kPo5jFFwMAZ2X8QIv/Kc=
X-Received: from pfbjo14.prod.google.com ([2002:a05:6a00:908e:b0:725:325e:59d5])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:1492:b0:724:f404:7101
 with SMTP id d2e1a72fcca58-7252ffcbf80mr6785726b3a.1.1732755358707; Wed, 27
 Nov 2024 16:55:58 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Wed, 27 Nov 2024 16:55:36 -0800
In-Reply-To: <20241128005547.4077116-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241128005547.4077116-1-seanjc@google.com>
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
Message-ID: <20241128005547.4077116-6-seanjc@google.com>
Subject: [PATCH v4 05/16] KVM: selftests: Rename max_guest_memory_test to mmu_stress_test
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

Rename max_guest_memory_test to mmu_stress_test so that the name isn't
horribly misleading when future changes extend the test to verify things
like mprotect() interactions, and because the test is useful even when its
configured to populate far less than the maximum amount of guest memory.

Reviewed-by: James Houghton <jthoughton@google.com>
Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 tools/testing/selftests/kvm/Makefile                            | 2 +-
 .../kvm/{max_guest_memory_test.c => mmu_stress_test.c}          | 0
 2 files changed, 1 insertion(+), 1 deletion(-)
 rename tools/testing/selftests/kvm/{max_guest_memory_test.c => mmu_stress_test.c} (100%)

diff --git a/tools/testing/selftests/kvm/Makefile b/tools/testing/selftests/kvm/Makefile
index 41593d2e7de9..4384e5f45c36 100644
--- a/tools/testing/selftests/kvm/Makefile
+++ b/tools/testing/selftests/kvm/Makefile
@@ -140,7 +140,7 @@ TEST_GEN_PROGS_x86_64 += guest_print_test
 TEST_GEN_PROGS_x86_64 += hardware_disable_test
 TEST_GEN_PROGS_x86_64 += kvm_create_max_vcpus
 TEST_GEN_PROGS_x86_64 += kvm_page_table_test
-TEST_GEN_PROGS_x86_64 += max_guest_memory_test
+TEST_GEN_PROGS_x86_64 += mmu_stress_test
 TEST_GEN_PROGS_x86_64 += memslot_modification_stress_test
 TEST_GEN_PROGS_x86_64 += memslot_perf_test
 TEST_GEN_PROGS_x86_64 += rseq_test
diff --git a/tools/testing/selftests/kvm/max_guest_memory_test.c b/tools/testing/selftests/kvm/mmu_stress_test.c
similarity index 100%
rename from tools/testing/selftests/kvm/max_guest_memory_test.c
rename to tools/testing/selftests/kvm/mmu_stress_test.c
-- 
2.47.0.338.g60cca15819-goog


