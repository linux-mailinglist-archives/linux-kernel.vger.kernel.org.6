Return-Path: <linux-kernel+bounces-287193-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2505495247B
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 23:08:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CE1F7286BCC
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 21:08:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4225D1C8FD1;
	Wed, 14 Aug 2024 21:08:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Wwi2d6Pu"
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F68C1C7B78
	for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 21:08:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723669687; cv=none; b=FgUGcgZaIyXe1PmwSh4Wlt+lJTQvSwx+iQWtYE91g7sHsqPrOrhVQ9zlsExWTaZzVvwX/CQLvaLnWYunaJBbKcKckjq1McnMHm3JcCqemfzmJPmdxaIlWLoWTEuTnAfx60LGBgoqIotGtZAVn7Cz6CxJDE61iBpPUFxzH6GZ2r4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723669687; c=relaxed/simple;
	bh=XQNLMLHB8Bq6urDZ7RRKnhgvnEBtv3VWmll28dAOMf4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MZ72EyClLcXJNTJjo71LAzljzluy5aIFHAf8Tqk6wPcG19hvxbQU/p8YB+AfY/6FfuITSP+RurGX+jAz+FglBM9tfUZBvRHLZE1JKuT2/t/eXjjCyCk1K6w4OlYauZp2DHxEUu6IU2kt49vD+C0iy9tEGuJ1EiTHvxd7VwXlTgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=Wwi2d6Pu; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-6b797a2384cso1724246d6.0
        for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 14:08:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1723669683; x=1724274483; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8sHW2F3yGzQtos1f5meNnseSubKzvRLxPjBnQoi7yoI=;
        b=Wwi2d6PuBVTgmA66CO+JynwmEoMJ9DEvOjPJJmDPrChSysStpOGDOlR/RMazuBHFtV
         ovZZAvk5fCBb75v3zl97MUr0mz4BNz/oNh1u92t99tYshrqQjqeVquWf9H1Sbm7zT0gh
         Y2yULr8FbunIZ40eFlsvtSBVEHJg792g8GVTk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723669683; x=1724274483;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8sHW2F3yGzQtos1f5meNnseSubKzvRLxPjBnQoi7yoI=;
        b=NXOeFnrX/KWWd3INm79uZHa8LiONrt1StnXWwb7R+ujD8tgMaEGGB+WkyYmP1nhJaV
         /7q/n6wLuESbkzqbeUXYLIscsdMS+0dPNhaIdUuZGkSRv5FmCGjn9U+EByfmvd4Vt5Y4
         KxxrIk2YuJvBFnucGnikT31Lwf2uKcIhgrnOLIif9AH9qL18zElt7clnqHUOrEOVwOkQ
         S9DU+EGmozIum55d3NzyDJIWZBgV4OHBfhj6qgAUQvqBaHxe/O30zmfEoRONi3eWyMGA
         b65gTzvUII36/D6ksFBjVI+AUzrrIYs96u90vWG6O8KnE1dBY8C4HBPZu+JIeXIPejB+
         X4mg==
X-Gm-Message-State: AOJu0YwR17lQqeKKYgy9yMoCw0z05wSnNaKIMtJ8D6xZiLhCrWGmZojE
	PB4nXlm/jPBnIRcvhzsMoosVB+oxBNZ8NFmSjpCzms8NSU3MjZoCco0jNleIh0DkK8zI7yotFGC
	fzubKPLKaGFC89+24vB2COHs+VcYLsi4ZznWI7RR6Gflfg06DPYxQFRonJ22C3uBLYCQK30Fq93
	093pYkFOyUJZQ5KL+CDH7yPPymQ378IimhM9K8h/IIr4wfoRpdrWwu
X-Google-Smtp-Source: AGHT+IFIMpLE+58fX37ApJWrzeiVS1CLUDddwvO8oWStXYZRlBPnDD5/J1dS9XGvC5TERyHE3wXqFA==
X-Received: by 2002:a05:6214:4303:b0:6b7:abe7:5665 with SMTP id 6a1803df08f44-6bf5d22a952mr54358836d6.22.1723669682933;
        Wed, 14 Aug 2024 14:08:02 -0700 (PDT)
Received: from amakhalov-build-vm.eng.vmware.com ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6bf6fef3845sm414526d6.125.2024.08.14.14.08.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Aug 2024 14:08:02 -0700 (PDT)
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
Subject: [PATCH 2/2] x86/vmware: Fix steal time clock under SEV
Date: Wed, 14 Aug 2024 14:07:31 -0700
Message-Id: <20240814210731.761010-2-alexey.makhalov@broadcom.com>
X-Mailer: git-send-email 2.39.4
In-Reply-To: <20240814210731.761010-1-alexey.makhalov@broadcom.com>
References: <20240814210731.761010-1-alexey.makhalov@broadcom.com>
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
 arch/x86/kernel/cpu/vmware.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/arch/x86/kernel/cpu/vmware.c b/arch/x86/kernel/cpu/vmware.c
index 9883766715fe..f20bdc3128f3 100644
--- a/arch/x86/kernel/cpu/vmware.c
+++ b/arch/x86/kernel/cpu/vmware.c
@@ -306,9 +306,30 @@ static struct notifier_block vmware_pv_reboot_nb = {
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
@@ -371,6 +392,7 @@ static void __init vmware_paravirt_ops_setup(void)
 					      vmware_cpu_down_prepare) < 0)
 			pr_err("vmware_guest: Failed to install cpu hotplug callbacks\n");
 #else
+		sev_map_percpu_data();
 		vmware_guest_cpu_init();
 #endif
 	}
-- 
2.39.4


