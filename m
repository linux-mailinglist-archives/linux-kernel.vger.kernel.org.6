Return-Path: <linux-kernel+bounces-287191-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E6B22952478
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 23:08:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 17B991C21A12
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 21:08:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8512D1C8232;
	Wed, 14 Aug 2024 21:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="OHsxZShY"
Received: from mail-oo1-f44.google.com (mail-oo1-f44.google.com [209.85.161.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3B0F1C7B70
	for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 21:08:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723669684; cv=none; b=bEDdRiO38NgF3mRmafQbuIjBFcMmMSOXFtL7J6Jh8Mr4yzvAv3KBMWxiRSy+d3ng1TnQ4akFqnqTTu5WXnQNqWadftAF6UiZ8oGX4o91JrlyNvI/xLHfqgBfiXv95lzdsjkg8injLC0zXZR3BAq43m0wcH6awnPgu0JbTjpZl4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723669684; c=relaxed/simple;
	bh=B6S1kKZ2LAB1sgj4bCOpBS2b3utcOlnq6gsW7Ydsghc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=fid7qLVoOXdoTw5oc3DBNsUU+4pKqQK8of85aEXX1S9o0908Nr8dc7Ybb7EshxsvpNFq1WftkriVocGwCL4zEklzJrxqQSKNpfcKiDJCeFIrQcpFBFs78qqh7cOCX0W8/iDZLrAHjA9E6IKKKSA81xYVsbxM4frgDr3QRBcaLwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=OHsxZShY; arc=none smtp.client-ip=209.85.161.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-oo1-f44.google.com with SMTP id 006d021491bc7-5d5c8c1006eso213981eaf.3
        for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 14:08:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1723669681; x=1724274481; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=aVlMPR+z4FDqtMhoza2ty5rltEW8xk2p7itsGBcy47c=;
        b=OHsxZShY6oK5ZkdhDIL/bpl7evCK617fwheXfF6ICpN0jv4X6qWG8zTKnDa8xk+kZr
         OvRhRvNF7ExBqB0SsNHd9oHyz5u4ksd+3uBekdR2p5ivzWu/LFOiMdWAH/E2TxYmLePC
         9yZqqDfnJ+xIX5V3lcNDps56xLyv1bcpmVOsI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723669681; x=1724274481;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aVlMPR+z4FDqtMhoza2ty5rltEW8xk2p7itsGBcy47c=;
        b=YTpoqQl+xKOQfBJZnJlVjTdVqQQcyEJlbilhh2YVsJ6+VBpIizTwYIdZ60tO8L8YzT
         TCE0puI/wpHf9NEUjLg/04EJeogZW43RoV3MboDYmDptiyhmJzMdUkIX/0KCaUGgnfFR
         L1TEJc86nce49RprGVPPDTBNXmnVHxQwFDBD6FSrI1uAihA5b8zPbXrmchY2XguqXeiY
         1zkzRDrF6rq2GxajsPbdLbJpquvMCqWxr3oEojbybQ0tzkVgtFmPUuCEoFMiBUZ1dU8N
         FDsSLCCwrdioqqiqaoj1J5RAM+gthYQhFqQvPIrqGGpEqjQInl0Oh+lSNukhWWcj7EVZ
         JLtA==
X-Gm-Message-State: AOJu0YzpYWDSakNqD06GmXU4ms811NNKn1npi9jTa3cebyglM+igh1Fy
	+lWcOuOXC1pzB4obH3MD65dRjZuBc8Wn7DzJtp8mmUK4zAvdleSrmjzWPTGeQzitMAOtEFOBqhN
	cakaAOe0qfMqovDYgPcDFLYdSqMKwWUvrURY1gcskpntN5ag0VAQuSs85FSi1C/tv+g+YKFKnVf
	iPfuh3T2PGZN8teqIPnhgaTQNA3EDpCINRQmSRTYQsQImnJ111zv2c
X-Google-Smtp-Source: AGHT+IGWZNBv22+iBD24zWCccBL8LYQgDxNIVA2leAHVpJHFl+T6eU6KwdB2TtE3EL2ADO9a+CEZCw==
X-Received: by 2002:a05:6359:4c0c:b0:1b1:a677:6453 with SMTP id e5c5f4694b2df-1b1aab4dfb9mr468220855d.8.1723669680542;
        Wed, 14 Aug 2024 14:08:00 -0700 (PDT)
Received: from amakhalov-build-vm.eng.vmware.com ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6bf6fef3845sm414526d6.125.2024.08.14.14.07.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Aug 2024 14:08:00 -0700 (PDT)
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
Subject: [PATCH 1/2] x86/vmware: Log kmsg dump on panic
Date: Wed, 14 Aug 2024 14:07:30 -0700
Message-Id: <20240814210731.761010-1-alexey.makhalov@broadcom.com>
X-Mailer: git-send-email 2.39.4
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Improve debugability of VMware Linux guests by dumping
kernel messages during a panic to VM log file (vmware.log).

Co-developed-by: Bo Gan <bo.gan@broadcom.com>
Signed-off-by: Bo Gan <bo.gan@broadcom.com>
Signed-off-by: Alexey Makhalov <alexey.makhalov@broadcom.com>
---
 arch/x86/include/asm/vmware.h |   1 +
 arch/x86/kernel/cpu/vmware.c  | 132 ++++++++++++++++++++++++++++++++++
 2 files changed, 133 insertions(+)

diff --git a/arch/x86/include/asm/vmware.h b/arch/x86/include/asm/vmware.h
index c9cf43d5ef23..433755b41a27 100644
--- a/arch/x86/include/asm/vmware.h
+++ b/arch/x86/include/asm/vmware.h
@@ -57,6 +57,7 @@
 #define VMWARE_HYPERVISOR_MAGIC		0x564d5868U
 
 #define VMWARE_CMD_GETVERSION		10
+#define VMWARE_CMD_MESSAGE		30
 #define VMWARE_CMD_GETHZ		45
 #define VMWARE_CMD_GETVCPU_INFO		68
 #define VMWARE_CMD_STEALCLOCK		91
diff --git a/arch/x86/kernel/cpu/vmware.c b/arch/x86/kernel/cpu/vmware.c
index 00189cdeb775..9883766715fe 100644
--- a/arch/x86/kernel/cpu/vmware.c
+++ b/arch/x86/kernel/cpu/vmware.c
@@ -28,6 +28,7 @@
 #include <linux/cpu.h>
 #include <linux/reboot.h>
 #include <linux/static_call.h>
+#include <linux/kmsg_dump.h>
 #include <asm/div64.h>
 #include <asm/x86_init.h>
 #include <asm/hypervisor.h>
@@ -139,6 +140,13 @@ static unsigned long vmware_get_tsc_khz(void)
 	return vmware_tsc_khz;
 }
 
+static void kmsg_dumper_vmware_log(struct kmsg_dumper *dumper,
+				enum kmsg_dump_reason reason);
+
+static struct kmsg_dumper kmsg_dumper = {
+	.dump = kmsg_dumper_vmware_log
+};
+
 #ifdef CONFIG_PARAVIRT
 static struct cyc2ns_data vmware_cyc2ns __ro_after_init;
 static bool vmw_sched_clock __initdata = true;
@@ -436,6 +444,8 @@ static void __init vmware_platform_setup(void)
 #endif
 
 	vmware_set_capabilities();
+
+	kmsg_dump_register(&kmsg_dumper);
 }
 
 static u8 __init vmware_select_hypercall(void)
@@ -587,3 +597,125 @@ const __initconst struct hypervisor_x86 x86_hyper_vmware = {
 	.runtime.sev_es_hcall_finish	= vmware_sev_es_hcall_finish,
 #endif
 };
+
+#define VMWARE_HB_CMD_MESSAGE	0
+#define MESSAGE_STATUS_SUCCESS	(0x01 << 16)
+#define MESSAGE_STATUS_CPT	(0x10 << 16)
+#define MESSAGE_STATUS_HB	(0x80 << 16)
+
+#define RPCI_PROTOCOL_NUM	0x49435052 /* 'RPCI' */
+#define GUESTMSG_FLAG_COOKIE	0x80000000
+
+#define MESSAGE_TYPE_OPEN	(0 << 16)
+#define MESSAGE_TYPE_SENDSIZE	(1 << 16)
+#define MESSAGE_TYPE_SEND	(2 << 16)
+#define MESSAGE_TYPE_CLOSE	(6 << 16)
+
+struct vmw_msg {
+	u32 id;
+	u32 cookie_high;
+	u32 cookie_low;
+};
+
+static int
+vmware_log_open(struct vmw_msg *msg)
+{
+	u32 info;
+
+	vmware_hypercall6(VMWARE_CMD_MESSAGE | MESSAGE_TYPE_OPEN,
+			  RPCI_PROTOCOL_NUM | GUESTMSG_FLAG_COOKIE,
+			  0, &info, &msg->id, &msg->cookie_high,
+			  &msg->cookie_low);
+
+	if ((info & MESSAGE_STATUS_SUCCESS) == 0)
+		return 1;
+
+	msg->id &= 0xffff0000UL;
+	return 0;
+}
+
+static int
+vmware_log_close(struct vmw_msg *msg)
+{
+	u32 info;
+
+	vmware_hypercall5(VMWARE_CMD_MESSAGE | MESSAGE_TYPE_CLOSE, 0, msg->id,
+			  msg->cookie_high, msg->cookie_low, &info);
+
+	if ((info & MESSAGE_STATUS_SUCCESS) == 0)
+		return 1;
+	return 0;
+}
+
+static int
+vmware_log_send(struct vmw_msg *msg, const char *string)
+{
+	u32 info;
+	u32 len = strlen(string);
+
+retry:
+	vmware_hypercall5(VMWARE_CMD_MESSAGE | MESSAGE_TYPE_SENDSIZE, len,
+			  msg->id, msg->cookie_high, msg->cookie_low, &info);
+
+	if (!(info & MESSAGE_STATUS_SUCCESS))
+		return 1;
+
+	/* HB port can't access encrypted memory. */
+	if (!cc_platform_has(CC_ATTR_MEM_ENCRYPT) && (info & MESSAGE_STATUS_HB)) {
+		vmware_hypercall_hb_out(
+			VMWARE_HB_CMD_MESSAGE | MESSAGE_STATUS_SUCCESS,
+			len, msg->id, (uintptr_t) string, msg->cookie_low,
+			msg->cookie_high, &info);
+	} else {
+		do {
+			u32 word;
+			size_t s = min_t(u32, len, sizeof(word));
+
+			memcpy(&word, string, s);
+			len -= s;
+			string += s;
+
+			vmware_hypercall5(VMWARE_CMD_MESSAGE | MESSAGE_TYPE_SEND,
+					  word, msg->id, msg->cookie_high,
+					  msg->cookie_low, &info);
+		} while (len && (info & MESSAGE_STATUS_SUCCESS));
+	}
+
+	if ((info & MESSAGE_STATUS_SUCCESS) == 0) {
+		if (info & MESSAGE_STATUS_CPT)
+			/* A checkpoint occurred. Retry. */
+			goto retry;
+		return 1;
+	}
+	return 0;
+}
+STACK_FRAME_NON_STANDARD(vmware_log_send);
+
+/**
+ * kmsg_dumper_vmware_log - dumps kmsg to vmware.log file on the host
+ */
+static void kmsg_dumper_vmware_log(struct kmsg_dumper *dumper,
+				enum kmsg_dump_reason reason)
+{
+	struct vmw_msg msg;
+	struct kmsg_dump_iter iter;
+	static char line[1024];
+	size_t len = 0;
+
+	/* Line prefix to send to VM log file. */
+	line[0] = 'l';
+	line[1] = 'o';
+	line[2] = 'g';
+	line[3] = ' ';
+
+	kmsg_dump_rewind(&iter);
+	while (kmsg_dump_get_line(&iter, true, line + 4, sizeof(line) - 4,
+				  &len)) {
+		line[len + 4] = '\0';
+		if (vmware_log_open(&msg))
+			return;
+		if (vmware_log_send(&msg, line))
+			return;
+		vmware_log_close(&msg);
+	}
+}
-- 
2.39.4


