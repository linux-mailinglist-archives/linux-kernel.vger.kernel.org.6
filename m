Return-Path: <linux-kernel+bounces-542403-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E322A4C9BD
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 18:36:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 57E303A1C8C
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 17:17:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF6BF23C384;
	Mon,  3 Mar 2025 17:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FTb0xTLF"
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B156C23BFA9
	for <linux-kernel@vger.kernel.org>; Mon,  3 Mar 2025 17:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741021283; cv=none; b=OYe/fI8K3id+23u8tgMfxkGKZ/w/0hvmXJ0ZFqXq7xRA2Id4O2pwypr0Y2LEyrEDHTIgqcZn4r2GeG7PnSqENrxSBtN6Qd/egnvlf4FTJO9NNXjHQOSEpgPaozhoHs5q+6sBTLFcJ+wtIBl0k7q9YeLBSsiT426RzUky0NVpbh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741021283; c=relaxed/simple;
	bh=9RFMsXYF5lITbRUYlY+rrlpT968InQ/qdSFxN9iNh3E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ongcTX2nWWoMp6zU+6zLR4FfBce/j6jPvILEr0lMlNBxcx+isKZzvucZ2BZiSfesSp7p8WQ1FQ2epLz1ZXO6lwpwHsqiLsFE73rO+cNVwwUsNJ1qis/nLlk12tWpy/s1AcnF990IUWeSGZldAEVfT3ofV3XdUpJdzGYmWbtkir8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FTb0xTLF; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-471f4909650so42554861cf.2
        for <linux-kernel@vger.kernel.org>; Mon, 03 Mar 2025 09:01:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741021280; x=1741626080; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=BszVR+knp6l10F1gCL1VwbIsGUikHke733K0y1CaPEg=;
        b=FTb0xTLFuAJL4mnKoCspEKt6a6HJJ8yRWCKGeeTNVdaVnsxKlg0tLw36tLrlJdIFyP
         HxmXM9yep+ZCv8yd1QVdqWBkeTfjg8IVhZpgFG54kIO/slY6bz+S5C3uhCn8W7hfVUc1
         uLRq6IEC/DwUAsXqoiev9JjdFykFt6RYaHu/C9cRMXGY4l5tBfayysVtwQmkMf60R0jz
         nPqApVMSw0AVkHa45F1eEKFU201wNxVCZsqqxcqQ+JKFzronYl1nlqs7OWRkD2TXisFI
         nrfJlnlB2X+Cz+skdfLOHklX4AbOB6rbdUuDd1nM3F7rtERSfaHu0xNpwU7yA48Mw5jx
         1VZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741021280; x=1741626080;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BszVR+knp6l10F1gCL1VwbIsGUikHke733K0y1CaPEg=;
        b=QtEwJchQv88h33cKb3XmvGk66XBGf7AqF3R6LirLmmEqMYNv7QzaAnYcSwHGjMg6zm
         JV92HhKgqpDBZPzpy6asNUguKRF0n/9dRsC7PDAQWBdm2F9GzO7dtMnr/d2nQeTppk6j
         d8zu4IS89+Ag9Ki42+Kp8qLngwyB94B/jrMnIBkIrybOl+SuJ1Q3V2xGKaHZdL8IUR5u
         f2vy3ntil26VO0Qqlaj396mfK8mutEP3P+3fQ4VZM+MYpc1K5oEPebUaaxiMdlJCZ/Gk
         vZi0SjoSIgbGXBEqaYUY2NwnSdnp8++Q6imCiI1FM3xIJIUpsPQzEXsdP2vsnBaqW07E
         SS5g==
X-Gm-Message-State: AOJu0YwmmFm22M/icyv2uAZHyPXL/oG/H2JHTGXIWgU6uC85Xv6wqy8y
	9WrDXhCOaEgY7VLnsoN2Fj0bqIEPL8fYKSSvweEIEcIfB8d1cSdZa2Ip
X-Gm-Gg: ASbGncvU++5tEFgRCfltU3sgwbsh5G/yPyvCBYbO7OfHw7OT7O86ti6iof8IO9n833t
	1QAq8GM6MvJokNWdNjnrOLEw1ePnTO49kFdVLcCRFj/ahpGcXNL13F36qia+y/l7S9hHVVioCwV
	GwmtOMjHBIbuHcvo1Wf3tNH53XIbb/eLuFn0/s/u2i0gxVVvXCDCN9EjWT1YF6RDH0Mg+8Nr11l
	9+A9W0AOj0NvrSNZqpr7RsiWsf60C+oPI19ncHidav98aon559/U3Teuf8JNGcSnCaLQNNHwz4L
	XIFwu6teJoh1CaWwwSWzAHn1/Q==
X-Google-Smtp-Source: AGHT+IFJK132tfPNQUhJvBjdmIlr4P+ByF4POByNjfzZlZPL81Lfu185Vhb4JQgXfSgJ77VJq6wcsg==
X-Received: by 2002:ac8:59cd:0:b0:472:dff:37fa with SMTP id d75a77b69052e-474bc116912mr209589461cf.47.1741021280164;
        Mon, 03 Mar 2025 09:01:20 -0800 (PST)
Received: from citadel.lan ([2600:6c4a:4d3f:6d5c::1019])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-474724310acsm60168151cf.78.2025.03.03.09.01.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Mar 2025 09:01:19 -0800 (PST)
From: Brian Gerst <brgerst@gmail.com>
To: linux-kernel@vger.kernel.org,
	x86@kernel.org
Cc: Ingo Molnar <mingo@kernel.org>,
	"H . Peter Anvin" <hpa@zytor.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Borislav Petkov <bp@alien8.de>,
	Brian Gerst <brgerst@gmail.com>
Subject: [PATCH] x86/smp/32: Remove safe_smp_processor_id()
Date: Mon,  3 Mar 2025 12:01:15 -0500
Message-ID: <20250303170115.2176553-1-brgerst@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This function was originally implemented in commit dc2bc768a009 ("stack
overflow safe kdump: safe_smp_processor_id()") to mitigate the CPU
number corruption on a stack overflow.  At the time, x86-32 stored the
CPU number in thread_struct, which was located at the bottom of the task
stack and thus vulnerable to an overflow.  The CPU number is now located
in percpu memory, so this workaround is no longer needed.

Signed-off-by: Brian Gerst <brgerst@gmail.com>
---
 arch/x86/include/asm/cpu.h |  1 -
 arch/x86/include/asm/smp.h |  6 ------
 arch/x86/kernel/apic/ipi.c | 30 ------------------------------
 arch/x86/kernel/crash.c    |  2 +-
 arch/x86/kernel/reboot.c   |  2 +-
 5 files changed, 2 insertions(+), 39 deletions(-)

diff --git a/arch/x86/include/asm/cpu.h b/arch/x86/include/asm/cpu.h
index 0c8ec62789a1..ad235dda1ded 100644
--- a/arch/x86/include/asm/cpu.h
+++ b/arch/x86/include/asm/cpu.h
@@ -12,7 +12,6 @@
 #ifndef CONFIG_SMP
 #define cpu_physical_id(cpu)			boot_cpu_physical_apicid
 #define cpu_acpi_id(cpu)			0
-#define safe_smp_processor_id()			0
 #endif /* CONFIG_SMP */
 
 #ifdef CONFIG_HOTPLUG_CPU
diff --git a/arch/x86/include/asm/smp.h b/arch/x86/include/asm/smp.h
index c8508d78ef3e..abf84e3bcb09 100644
--- a/arch/x86/include/asm/smp.h
+++ b/arch/x86/include/asm/smp.h
@@ -137,12 +137,6 @@ __visible void smp_call_function_single_interrupt(struct pt_regs *r);
 #define raw_smp_processor_id()  this_cpu_read(pcpu_hot.cpu_number)
 #define __smp_processor_id() __this_cpu_read(pcpu_hot.cpu_number)
 
-#ifdef CONFIG_X86_32
-extern int safe_smp_processor_id(void);
-#else
-# define safe_smp_processor_id()	smp_processor_id()
-#endif
-
 static inline struct cpumask *cpu_llc_shared_mask(int cpu)
 {
 	return per_cpu(cpu_llc_shared_map, cpu);
diff --git a/arch/x86/kernel/apic/ipi.c b/arch/x86/kernel/apic/ipi.c
index 942168da7195..98a57cb4aa86 100644
--- a/arch/x86/kernel/apic/ipi.c
+++ b/arch/x86/kernel/apic/ipi.c
@@ -288,34 +288,4 @@ void default_send_IPI_mask_logical(const struct cpumask *cpumask, int vector)
 	__default_send_IPI_dest_field(mask, vector, APIC_DEST_LOGICAL);
 	local_irq_restore(flags);
 }
-
-#ifdef CONFIG_SMP
-static int convert_apicid_to_cpu(u32 apic_id)
-{
-	int i;
-
-	for_each_possible_cpu(i) {
-		if (per_cpu(x86_cpu_to_apicid, i) == apic_id)
-			return i;
-	}
-	return -1;
-}
-
-int safe_smp_processor_id(void)
-{
-	u32 apicid;
-	int cpuid;
-
-	if (!boot_cpu_has(X86_FEATURE_APIC))
-		return 0;
-
-	apicid = read_apic_id();
-	if (apicid == BAD_APICID)
-		return 0;
-
-	cpuid = convert_apicid_to_cpu(apicid);
-
-	return cpuid >= 0 ? cpuid : 0;
-}
-#endif
 #endif
diff --git a/arch/x86/kernel/crash.c b/arch/x86/kernel/crash.c
index 340af8155658..0be61c45400c 100644
--- a/arch/x86/kernel/crash.c
+++ b/arch/x86/kernel/crash.c
@@ -140,7 +140,7 @@ void native_machine_crash_shutdown(struct pt_regs *regs)
 	x86_platform.guest.enc_kexec_begin();
 	x86_platform.guest.enc_kexec_finish();
 
-	crash_save_cpu(regs, safe_smp_processor_id());
+	crash_save_cpu(regs, smp_processor_id());
 }
 
 #if defined(CONFIG_KEXEC_FILE) || defined(CONFIG_CRASH_HOTPLUG)
diff --git a/arch/x86/kernel/reboot.c b/arch/x86/kernel/reboot.c
index 9aaac1f9f45b..964f6b0a3d68 100644
--- a/arch/x86/kernel/reboot.c
+++ b/arch/x86/kernel/reboot.c
@@ -921,7 +921,7 @@ void nmi_shootdown_cpus(nmi_shootdown_cb callback)
 		return;
 
 	/* Make a note of crashing cpu. Will be used in NMI callback. */
-	crashing_cpu = safe_smp_processor_id();
+	crashing_cpu = smp_processor_id();
 
 	shootdown_callback = callback;
 

base-commit: 693c8502970a533363e9ece482c80bb6db0c12a5
-- 
2.48.1


