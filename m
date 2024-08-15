Return-Path: <linux-kernel+bounces-288733-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B328E953E18
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 01:53:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6E74B2844AD
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 23:53:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CA7C156F3B;
	Thu, 15 Aug 2024 23:53:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="HQaiSkJj"
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3138F4AEF5
	for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2024 23:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723765996; cv=none; b=eUBCK5BRtobmhIO1vQchpQuug5/WpzvdxAkhSa9t/ZxuHg4x682KwF4cvCC+HqXtrbuOR9NgVO6Z1uT4Ir13mdQ/n1LekjZFm5mMjIUBnKScWt3AHmyR9hVRDNqrlY0t1tjHYGrjAJUheXJ/xHpQArcfh+lggwCCJpelWZo09No=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723765996; c=relaxed/simple;
	bh=LwOB566dtP6iRZ/PRNhmquNN3Lyoz+ETk3sAEqaNH6M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=aLtB0ce34H1vutFpR22+l7XKTX6amflQLpz2Ev/nACmXH7aBmAD0pmbb6UyX4V/xuXjZIKXmnh6kEmIyKJ3uc5Ok474+Hskbx1frgpD9Ykoh6ZySGypm1w2U647Hl6oyJ3vYnHAryrlBenzzBP7Bl31+5ijHNKTMkPSPVd0Z5V8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=HQaiSkJj; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-7a1d3e93cceso244534785a.1
        for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2024 16:53:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1723765994; x=1724370794; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UMmHtGDxLP15DSwvGW0oZzm4yIn7Z3SZOYyZ/cXfFzU=;
        b=HQaiSkJjqN9AgQHTpMGohnHifP+kMMKK/aAiviaFsftuxymEPffUAKxq0B9ljKt/nn
         QOCbXBwjb5RL0kAsDr78gvhoNCpz71WjOqVopzaPnYvbIzdMcPpUFhQk8zfQtPaglhEh
         924atGUnp6ycnyNrmxqrpYKZF3YNN7POl0ENE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723765994; x=1724370794;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UMmHtGDxLP15DSwvGW0oZzm4yIn7Z3SZOYyZ/cXfFzU=;
        b=djatzQiqmNgi7/mVb9SkMnEGQpi9XCMLeFPp50QlX6qSCSZnJOzQwXXkl350DJnS8A
         VoE4PyUYzVm0jvOQ9Rcg/3zClBQ9VjRb2b5xpVt2uKXuJB8QVKwRIRgwwYtT92yvkBzk
         a9sFSUloDzsQiH9DweQT4/UBIYlsgm/wTrJskNme0rO+Ub6p1APQLjjzXYmwV6hom2Bo
         aMpA0ZvTl7OKjCvLtOsrZupf9ON1sNgXzJj/tjBZcGtrcIBWwbcODi6Yl0yD5DzhzNtJ
         buGt3fEz2oeu4fvG2B7Wfrg2/JzKO+u9UKXySkhjVbHctVa9UCECfLIieu/p7ExvZIBt
         vr/A==
X-Gm-Message-State: AOJu0YxOk7WMkhGdhSygB0JlQ1gBQ8ndgAWgDhCDFiqD1hotFGTV/WNT
	0OIpMLdF3BgLMA8PbW+5uABEkIJT7vjUYUv/OTt2FJ/GuinbvjrOceOeOjxbqSjNZUbj1cQrvKS
	r3wJTEPoBnUkCXGUJZGjClWgObzrzLHo7jQe3ttZ57bYn0milEgc6geOQL8KoUhJc35nisXcc+h
	ebz0HahH6788vrGfPXbBtEG3QEE4AlH8iQhic0DnDoFH5/VInUnorA
X-Google-Smtp-Source: AGHT+IFqiX06nF1pNMk7dYe8eZHjyfLcc0SwlXL8916skbzdi+3d1cwROPT64eYGuDiUUO1ovmbeCw==
X-Received: by 2002:a05:6214:4198:b0:6af:33ed:87de with SMTP id 6a1803df08f44-6bf7d5b1021mr15618336d6.20.1723765993660;
        Thu, 15 Aug 2024 16:53:13 -0700 (PDT)
Received: from amakhalov-build-vm.eng.vmware.com ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6bf6fdd8880sm11277296d6.22.2024.08.15.16.53.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Aug 2024 16:53:13 -0700 (PDT)
From: Alexey Makhalov <alexey.makhalov@broadcom.com>
To: linux-kernel@vger.kernel.org,
	virtualization@lists.linux.dev,
	bp@alien8.de,
	hpa@zytor.com,
	dave.hansen@linux.intel.com,
	mingo@redhat.com,
	tglx@linutronix.de
Cc: x86@kernel.org,
	ajay.kaher@broadcom.com,
	bo.gan@broadcom.com,
	bcm-kernel-feedback-list@broadcom.com,
	Alexey Makhalov <alexey.makhalov@broadcom.com>
Subject: [PATCH v2 2/2] x86/vmware: Fix steal time clock under SEV
Date: Thu, 15 Aug 2024 16:52:46 -0700
Message-Id: <20240815235246.806522-1-alexey.makhalov@broadcom.com>
X-Mailer: git-send-email 2.39.4
In-Reply-To: <20240814210731.761010-2-alexey.makhalov@broadcom.com>
References: <20240814210731.761010-2-alexey.makhalov@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Shared memory containing steal time counter should be set to
decrypted when SEV is active.

Co-developed-by: Bo Gan <bo.gan@broadcom.com>
Signed-off-by: Bo Gan <bo.gan@broadcom.com>
Signed-off-by: Alexey Makhalov <alexey.makhalov@broadcom.com>
---
 arch/x86/kernel/cpu/vmware.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/arch/x86/kernel/cpu/vmware.c b/arch/x86/kernel/cpu/vmware.c
index 9883766715fe..b4e57d6ec2f5 100644
--- a/arch/x86/kernel/cpu/vmware.c
+++ b/arch/x86/kernel/cpu/vmware.c
@@ -36,6 +36,7 @@
 #include <asm/apic.h>
 #include <asm/vmware.h>
 #include <asm/svm.h>
+#include <asm/coco.h>
 
 #undef pr_fmt
 #define pr_fmt(fmt)	"vmware: " fmt
@@ -306,9 +307,30 @@ static struct notifier_block vmware_pv_reboot_nb = {
 	.notifier_call = vmware_pv_reboot_notify,
 };
 
+static void __init sev_map_percpu_data(void)
+{
+	int cpu;
+
+	if (cc_vendor != CC_VENDOR_AMD ||
+	    !cc_platform_has(CC_ATTR_GUEST_MEM_ENCRYPT))
+		return;
+
+	for_each_possible_cpu(cpu) {
+		early_set_memory_decrypted(
+			(unsigned long)&per_cpu(vmw_steal_time, cpu),
+			sizeof(vmw_steal_time));
+	}
+}
+
 #ifdef CONFIG_SMP
 static void __init vmware_smp_prepare_boot_cpu(void)
 {
+	/*
+	 * Map the per-cpu variables as decrypted before vmware_guest_cpu_init()
+	 * shares the guest physical address with the hypervisor.
+	 */
+	sev_map_percpu_data();
+
 	vmware_guest_cpu_init();
 	native_smp_prepare_boot_cpu();
 }
@@ -371,6 +393,7 @@ static void __init vmware_paravirt_ops_setup(void)
 					      vmware_cpu_down_prepare) < 0)
 			pr_err("vmware_guest: Failed to install cpu hotplug callbacks\n");
 #else
+		sev_map_percpu_data();
 		vmware_guest_cpu_init();
 #endif
 	}
-- 
2.39.4


