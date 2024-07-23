Return-Path: <linux-kernel+bounces-259876-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A1C5939E9C
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 12:12:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8BD891F22E6B
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 10:12:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9962014EC57;
	Tue, 23 Jul 2024 10:12:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PdQknqTH"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E0A514EC47
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2024 10:12:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721729537; cv=none; b=eec+T6tZcECMgr+pzUo0CVoeSpXLlseg1qUrhB3xZCFeYJGKnwuoLMwJka/x1g75pRMIExYytRSkQfX5MnMMRI3wn3HgkuUgBdRoyZvYVAJxhLeGgoaMvM0LAQbyghpWRvlUP2q2Bak11QUzltXnCfGlVFH/upnNE2oGC4M7iQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721729537; c=relaxed/simple;
	bh=itl1BX28HKdGQXXxJvtLtVN7uHwH3jOcmXGakq6ld9k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sqpB+vDfZzFfp4EO0kiCMfHHz1bTKhLUTEe+g4ggajSPjXps15s5BpeJIKuFuUx9dFSmFtnOia/UBGT962d3TFwSDWuteQzNRpOFdcxweffGK+/jP5srJUnptRrbb35J7dnQhhZdxFx+mNT9hyO74Fm2w7Na5p27GGaEi02fbmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PdQknqTH; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721729535;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Xzuyk5RPlpL9t0A/8o4faeOblpZCzvEu932Ng83fGMs=;
	b=PdQknqTH1zFPPyUaaBuikFqwxy2g2vL4DJIVfY7MXBatmP88pWXYFl2zJ6/YxEqGy7f7ye
	aCebBd/Jt/OF29w2WjwHNijmW6lFfkphoLs7or/XET/rd8aPAiu+TLh/ZZ3Z539Ts8bKun
	yRkeFxTuXlDIUSB823oYCbWcpp9gt7Y=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-101-EoCeDWnVN56TGYZDwjzBsA-1; Tue, 23 Jul 2024 06:12:13 -0400
X-MC-Unique: EoCeDWnVN56TGYZDwjzBsA-1
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-79f19f19b11so743201385a.0
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2024 03:12:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721729533; x=1722334333;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Xzuyk5RPlpL9t0A/8o4faeOblpZCzvEu932Ng83fGMs=;
        b=MDvtWjEe2YumGu/A+tCAnethXq9Y6ZvGgX+eiWKsVI/BtU8oP1E5Tnba5+KnB5M3Kh
         Io9wHauq7AEhLXsjJLOyF58xYliZ2eWbJLn+yqdsOyTHJV/0MWWTmR/s3EqTiC9wbAjj
         wNvWfQz+MfUWrvf5NCmfY2uIivxNoDDCBNtRcFMWc+W6fVqllWWfLw2WEjw3nO0GqS6u
         mjkCk9pauePfweb19glBRdTjft8IctIdSkpHywILWOwOyIMYbhYOpFTw6D6IbkPNZlVo
         ic3mdGLm1TnmmbQHVzt42BWlFWh6jwS/n9pRpJ+pErUCsnFBlP596pK4/UIipmeFUJVB
         VWlg==
X-Forwarded-Encrypted: i=1; AJvYcCXnv9pUvKv0itgkUH+6uh4GTGo6b+ytUWd1sAByc87O1k6TNHt+tEjX9FAVmShRXUNIKvZ5m0lhLQC715ImZhh25OkU7CyqmuWffO7d
X-Gm-Message-State: AOJu0YyqZyRUuCEMtOREjX4rVqX8XMQQaAwKDQGo+aTnEcuRFXssAgLL
	Nya5KsCLX4X1JuY26C8QpBDnYuDYPLrY6Ty/uDpGxEBC5yKcH0KhtJYaArIT0IWcpI3NgxriU8P
	+/4Yithap0dUeqIVICsnxdysTCVoijT7SQwEJLN0zU2/I/orNT5g/opQJnczptQ==
X-Received: by 2002:a05:620a:394a:b0:79f:16c8:b04a with SMTP id af79cd13be357-7a1c06bc41fmr275051585a.26.1721729533205;
        Tue, 23 Jul 2024 03:12:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHvx7LA7H50ASsJ8L06HMjDMhwLdP2mNIndsn8L+inHJpH2PTr3YecDjb7uZQ/0eEz1EtS9Fw==
X-Received: by 2002:a05:620a:394a:b0:79f:16c8:b04a with SMTP id af79cd13be357-7a1c06bc41fmr275049785a.26.1721729532879;
        Tue, 23 Jul 2024 03:12:12 -0700 (PDT)
Received: from rh.redhat.com (p200300c93f45e50062e5f8c654844c9a.dip0.t-ipconnect.de. [2003:c9:3f45:e500:62e5:f8c6:5484:4c9a])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a1990063f2sm463780085a.64.2024.07.23.03.12.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jul 2024 03:12:12 -0700 (PDT)
From: Sebastian Ott <sebott@redhat.com>
To: linux-arm-kernel@lists.infradead.org,
	kvmarm@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: Marc Zyngier <maz@kernel.org>,
	Oliver Upton <oliver.upton@linux.dev>,
	James Morse <james.morse@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Zenghui Yu <yuzenghui@huawei.com>,
	Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH v2 1/3] KVM: arm64: fix override-init warnings in W=1 builds
Date: Tue, 23 Jul 2024 12:12:02 +0200
Message-ID: <20240723101204.7356-2-sebott@redhat.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240723101204.7356-1-sebott@redhat.com>
References: <20240723101204.7356-1-sebott@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add -Wno-override-init to the build flags for sys_regs.c,
handle_exit.c, and switch.c to fix warnings like the following:

arch/arm64/kvm/hyp/vhe/switch.c:271:43: warning: initialized field overwritten [-Woverride-init]
  271 |         [ESR_ELx_EC_CP15_32]            = kvm_hyp_handle_cp15_32,
      |

Signed-off-by: Sebastian Ott <sebott@redhat.com>
---
 arch/arm64/kvm/Makefile          | 3 +++
 arch/arm64/kvm/hyp/nvhe/Makefile | 2 ++
 arch/arm64/kvm/hyp/vhe/Makefile  | 2 ++
 3 files changed, 7 insertions(+)

diff --git a/arch/arm64/kvm/Makefile b/arch/arm64/kvm/Makefile
index a6497228c5a8..86a629aaf0a1 100644
--- a/arch/arm64/kvm/Makefile
+++ b/arch/arm64/kvm/Makefile
@@ -10,6 +10,9 @@ include $(srctree)/virt/kvm/Makefile.kvm
 obj-$(CONFIG_KVM) += kvm.o
 obj-$(CONFIG_KVM) += hyp/
 
+CFLAGS_sys_regs.o += -Wno-override-init
+CFLAGS_handle_exit.o += -Wno-override-init
+
 kvm-y += arm.o mmu.o mmio.o psci.o hypercalls.o pvtime.o \
 	 inject_fault.o va_layout.o handle_exit.o \
 	 guest.o debug.o reset.o sys_regs.o stacktrace.o \
diff --git a/arch/arm64/kvm/hyp/nvhe/Makefile b/arch/arm64/kvm/hyp/nvhe/Makefile
index 782b34b004be..b43426a493df 100644
--- a/arch/arm64/kvm/hyp/nvhe/Makefile
+++ b/arch/arm64/kvm/hyp/nvhe/Makefile
@@ -20,6 +20,8 @@ HOST_EXTRACFLAGS += -I$(objtree)/include
 lib-objs := clear_page.o copy_page.o memcpy.o memset.o
 lib-objs := $(addprefix ../../../lib/, $(lib-objs))
 
+CFLAGS_switch.nvhe.o += -Wno-override-init
+
 hyp-obj-y := timer-sr.o sysreg-sr.o debug-sr.o switch.o tlb.o hyp-init.o host.o \
 	 hyp-main.o hyp-smp.o psci-relay.o early_alloc.o page_alloc.o \
 	 cache.o setup.o mm.o mem_protect.o sys_regs.o pkvm.o stacktrace.o ffa.o
diff --git a/arch/arm64/kvm/hyp/vhe/Makefile b/arch/arm64/kvm/hyp/vhe/Makefile
index 3b9e5464b5b3..afc4aed9231a 100644
--- a/arch/arm64/kvm/hyp/vhe/Makefile
+++ b/arch/arm64/kvm/hyp/vhe/Makefile
@@ -6,6 +6,8 @@
 asflags-y := -D__KVM_VHE_HYPERVISOR__
 ccflags-y := -D__KVM_VHE_HYPERVISOR__
 
+CFLAGS_switch.o += -Wno-override-init
+
 obj-y := timer-sr.o sysreg-sr.o debug-sr.o switch.o tlb.o
 obj-y += ../vgic-v3-sr.o ../aarch32.o ../vgic-v2-cpuif-proxy.o ../entry.o \
 	 ../fpsimd.o ../hyp-entry.o ../exception.o
-- 
2.42.0


