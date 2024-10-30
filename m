Return-Path: <linux-kernel+bounces-389546-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FF6E9B6E44
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 22:00:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5FA2F282039
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 21:00:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBD8F20E31C;
	Wed, 30 Oct 2024 21:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XVOmN5SL"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D28EA1BD9EB;
	Wed, 30 Oct 2024 21:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730322026; cv=none; b=QSOgWRCBmRbVHleAX6vYsvfpkGQNMDGjnweFhl7t8fydUwbEEeR3aTDDwjLe0ojQVzAJOYYor624u/FR4AOBLn8V3HNWP9MtZ4MFOknHwaJhf5boipQ006VCI3vRGT2Vij7SCWdAF5PALJy/z57dceoGSliMaE+pmAcez4/jsz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730322026; c=relaxed/simple;
	bh=Y6ysv2k+BH2dTSZSiE4N+FmjfTTGzWnshyJjrzYt8aI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=BApzFq6f+AMU7xdsdrRepHyASqeknaQkC9U9AAJu7rZ+nz3a0wLDuBHWNp40p4KwiOi1EpFoIL9pxVzyboCpH3yPwK5LTjCtEiQs+YOtKCxFbXg7dap4NSBcUHbpquEub/4OvkIv1Ht1jKv3/jSC/F2eTIeRwsM62DqVRjr7jVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XVOmN5SL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 509C2C4CED1;
	Wed, 30 Oct 2024 21:00:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730322026;
	bh=Y6ysv2k+BH2dTSZSiE4N+FmjfTTGzWnshyJjrzYt8aI=;
	h=From:To:Cc:Subject:Date:From;
	b=XVOmN5SLbyMwSC4uqrjIfHrTuDe3e7Lh5NeXEPkr/eCJz0zamenJn10PDS37W6S7d
	 w1xTXnZ4vVTUGsHBTYtwKwO4Nnef1HFPIW+AYPeu806aLuesrFcNlop57ykOr/8fZ/
	 9kcmN8wU8WQKAZD4V0j8BrNeV1kuEfOXL0AquDYmZjWeKSZOT/PZ88WOdT/VXPbG6d
	 D0yJnflTXMBmnJu5iFiNaEK5B0da8DUO4BR6wXh6xPaH8By8RwVMKNIgny2+64Ty+0
	 /9EFPV9F+WPIlicaP1ZrDqM1tfNUGdfGdwDlYrIj3Y6p8KoYvndDNKgcEtTcO7pd52
	 zIhVxt3aLaPxA==
From: Arnd Bergmann <arnd@kernel.org>
To: Hans de Goede <hdegoede@redhat.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Naveen Krishna Chatradhi <naveenkrishna.chatradhi@amd.com>,
	Carlos Bilbao <carlos.bilbao.osdev@gmail.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Suma Hegde <suma.hegde@amd.com>,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] [v2] platform/x86/amd/hsmp: move hsmp_msg_desc_table[] to hsmp.c
Date: Wed, 30 Oct 2024 22:00:03 +0100
Message-Id: <20241030210019.2858358-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

After the file got split, there are now W=1 warnings for users that
include it without referencing hsmp_msg_desc_table:

In file included from arch/x86/include/asm/amd_hsmp.h:6,
                 from drivers/platform/x86/amd/hsmp/plat.c:12:
arch/x86/include/uapi/asm/amd_hsmp.h:91:35: error: 'hsmp_msg_desc_table' defined but not used [-Werror=unused-const-variable=]
   91 | static const struct hsmp_msg_desc hsmp_msg_desc_table[] = {
      |                                   ^~~~~~~~~~~~~~~~~~~

The array was never meant to be used by userspace code, but was
left in the header as a reference for userspace programmers.

Move the contents of the array into the one file that actually needs
it, and instead leave the URL of the new location in the uapi header
in case anyone is looking for it.

Fixes: e47c018a0ee6 ("platform/x86/amd/hsmp: Move platform device specific code to plat.c")
Suggested-by: Hans de Goede <hdegoede@redhat.com>
Link: https://lore.kernel.org/lkml/046687d8-1e2d-435b-adcb-26897bfd29f7@redhat.com/
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/x86/include/uapi/asm/amd_hsmp.h | 255 ++-------------------------
 drivers/platform/x86/amd/hsmp/hsmp.c | 245 +++++++++++++++++++++++++
 2 files changed, 255 insertions(+), 245 deletions(-)

diff --git a/arch/x86/include/uapi/asm/amd_hsmp.h b/arch/x86/include/uapi/asm/amd_hsmp.h
index e5d182c7373c..dfa6aa985ac4 100644
--- a/arch/x86/include/uapi/asm/amd_hsmp.h
+++ b/arch/x86/include/uapi/asm/amd_hsmp.h
@@ -1,5 +1,15 @@
 /* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
 
+/*
+ * See hsmp_msg_desc_table[] in:
+ * https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/platform/x86/amd/hsmp.c
+ *
+ * for some information on number of input- and output arguments
+ * for the various functions.
+ *
+ * Please find the supported list of messages and message definition
+ * in the HSMP chapter of respective family/model PPR.
+ */
 #ifndef _UAPI_ASM_X86_AMD_HSMP_H_
 #define _UAPI_ASM_X86_AMD_HSMP_H_
 
@@ -81,251 +91,6 @@ struct hsmp_msg_desc {
 	enum hsmp_msg_type type;
 };
 
-/*
- * User may use these comments as reference, please find the
- * supported list of messages and message definition in the
- * HSMP chapter of respective family/model PPR.
- *
- * Not supported messages would return -ENOMSG.
- */
-static const struct hsmp_msg_desc hsmp_msg_desc_table[] = {
-	/* RESERVED */
-	{0, 0, HSMP_RSVD},
-
-	/*
-	 * HSMP_TEST, num_args = 1, response_sz = 1
-	 * input:  args[0] = xx
-	 * output: args[0] = xx + 1
-	 */
-	{1, 1, HSMP_GET},
-
-	/*
-	 * HSMP_GET_SMU_VER, num_args = 0, response_sz = 1
-	 * output: args[0] = smu fw ver
-	 */
-	{0, 1, HSMP_GET},
-
-	/*
-	 * HSMP_GET_PROTO_VER, num_args = 0, response_sz = 1
-	 * output: args[0] = proto version
-	 */
-	{0, 1, HSMP_GET},
-
-	/*
-	 * HSMP_GET_SOCKET_POWER, num_args = 0, response_sz = 1
-	 * output: args[0] = socket power in mWatts
-	 */
-	{0, 1, HSMP_GET},
-
-	/*
-	 * HSMP_SET_SOCKET_POWER_LIMIT, num_args = 1, response_sz = 0
-	 * input: args[0] = power limit value in mWatts
-	 */
-	{1, 0, HSMP_SET},
-
-	/*
-	 * HSMP_GET_SOCKET_POWER_LIMIT, num_args = 0, response_sz = 1
-	 * output: args[0] = socket power limit value in mWatts
-	 */
-	{0, 1, HSMP_GET},
-
-	/*
-	 * HSMP_GET_SOCKET_POWER_LIMIT_MAX, num_args = 0, response_sz = 1
-	 * output: args[0] = maximuam socket power limit in mWatts
-	 */
-	{0, 1, HSMP_GET},
-
-	/*
-	 * HSMP_SET_BOOST_LIMIT, num_args = 1, response_sz = 0
-	 * input: args[0] = apic id[31:16] + boost limit value in MHz[15:0]
-	 */
-	{1, 0, HSMP_SET},
-
-	/*
-	 * HSMP_SET_BOOST_LIMIT_SOCKET, num_args = 1, response_sz = 0
-	 * input: args[0] = boost limit value in MHz
-	 */
-	{1, 0, HSMP_SET},
-
-	/*
-	 * HSMP_GET_BOOST_LIMIT, num_args = 1, response_sz = 1
-	 * input: args[0] = apic id
-	 * output: args[0] = boost limit value in MHz
-	 */
-	{1, 1, HSMP_GET},
-
-	/*
-	 * HSMP_GET_PROC_HOT, num_args = 0, response_sz = 1
-	 * output: args[0] = proc hot status
-	 */
-	{0, 1, HSMP_GET},
-
-	/*
-	 * HSMP_SET_XGMI_LINK_WIDTH, num_args = 1, response_sz = 0
-	 * input: args[0] = min link width[15:8] + max link width[7:0]
-	 */
-	{1, 0, HSMP_SET},
-
-	/*
-	 * HSMP_SET_DF_PSTATE, num_args = 1, response_sz = 0
-	 * input: args[0] = df pstate[7:0]
-	 */
-	{1, 0, HSMP_SET},
-
-	/* HSMP_SET_AUTO_DF_PSTATE, num_args = 0, response_sz = 0 */
-	{0, 0, HSMP_SET},
-
-	/*
-	 * HSMP_GET_FCLK_MCLK, num_args = 0, response_sz = 2
-	 * output: args[0] = fclk in MHz, args[1] = mclk in MHz
-	 */
-	{0, 2, HSMP_GET},
-
-	/*
-	 * HSMP_GET_CCLK_THROTTLE_LIMIT, num_args = 0, response_sz = 1
-	 * output: args[0] = core clock in MHz
-	 */
-	{0, 1, HSMP_GET},
-
-	/*
-	 * HSMP_GET_C0_PERCENT, num_args = 0, response_sz = 1
-	 * output: args[0] = average c0 residency
-	 */
-	{0, 1, HSMP_GET},
-
-	/*
-	 * HSMP_SET_NBIO_DPM_LEVEL, num_args = 1, response_sz = 0
-	 * input: args[0] = nbioid[23:16] + max dpm level[15:8] + min dpm level[7:0]
-	 */
-	{1, 0, HSMP_SET},
-
-	/*
-	 * HSMP_GET_NBIO_DPM_LEVEL, num_args = 1, response_sz = 1
-	 * input: args[0] = nbioid[23:16]
-	 * output: args[0] = max dpm level[15:8] + min dpm level[7:0]
-	 */
-	{1, 1, HSMP_GET},
-
-	/*
-	 * HSMP_GET_DDR_BANDWIDTH, num_args = 0, response_sz = 1
-	 * output: args[0] = max bw in Gbps[31:20] + utilised bw in Gbps[19:8] +
-	 * bw in percentage[7:0]
-	 */
-	{0, 1, HSMP_GET},
-
-	/*
-	 * HSMP_GET_TEMP_MONITOR, num_args = 0, response_sz = 1
-	 * output: args[0] = temperature in degree celsius. [15:8] integer part +
-	 * [7:5] fractional part
-	 */
-	{0, 1, HSMP_GET},
-
-	/*
-	 * HSMP_GET_DIMM_TEMP_RANGE, num_args = 1, response_sz = 1
-	 * input: args[0] = DIMM address[7:0]
-	 * output: args[0] = refresh rate[3] + temperature range[2:0]
-	 */
-	{1, 1, HSMP_GET},
-
-	/*
-	 * HSMP_GET_DIMM_POWER, num_args = 1, response_sz = 1
-	 * input: args[0] = DIMM address[7:0]
-	 * output: args[0] = DIMM power in mW[31:17] + update rate in ms[16:8] +
-	 * DIMM address[7:0]
-	 */
-	{1, 1, HSMP_GET},
-
-	/*
-	 * HSMP_GET_DIMM_THERMAL, num_args = 1, response_sz = 1
-	 * input: args[0] = DIMM address[7:0]
-	 * output: args[0] = temperature in degree celsius[31:21] + update rate in ms[16:8] +
-	 * DIMM address[7:0]
-	 */
-	{1, 1, HSMP_GET},
-
-	/*
-	 * HSMP_GET_SOCKET_FREQ_LIMIT, num_args = 0, response_sz = 1
-	 * output: args[0] = frequency in MHz[31:16] + frequency source[15:0]
-	 */
-	{0, 1, HSMP_GET},
-
-	/*
-	 * HSMP_GET_CCLK_CORE_LIMIT, num_args = 1, response_sz = 1
-	 * input: args[0] = apic id [31:0]
-	 * output: args[0] = frequency in MHz[31:0]
-	 */
-	{1, 1, HSMP_GET},
-
-	/*
-	 * HSMP_GET_RAILS_SVI, num_args = 0, response_sz = 1
-	 * output: args[0] = power in mW[31:0]
-	 */
-	{0, 1, HSMP_GET},
-
-	/*
-	 * HSMP_GET_SOCKET_FMAX_FMIN, num_args = 0, response_sz = 1
-	 * output: args[0] = fmax in MHz[31:16] + fmin in MHz[15:0]
-	 */
-	{0, 1, HSMP_GET},
-
-	/*
-	 * HSMP_GET_IOLINK_BANDWITH, num_args = 1, response_sz = 1
-	 * input: args[0] = link id[15:8] + bw type[2:0]
-	 * output: args[0] = io bandwidth in Mbps[31:0]
-	 */
-	{1, 1, HSMP_GET},
-
-	/*
-	 * HSMP_GET_XGMI_BANDWITH, num_args = 1, response_sz = 1
-	 * input: args[0] = link id[15:8] + bw type[2:0]
-	 * output: args[0] = xgmi bandwidth in Mbps[31:0]
-	 */
-	{1, 1, HSMP_GET},
-
-	/*
-	 * HSMP_SET_GMI3_WIDTH, num_args = 1, response_sz = 0
-	 * input: args[0] = min link width[15:8] + max link width[7:0]
-	 */
-	{1, 0, HSMP_SET},
-
-	/*
-	 * HSMP_SET_PCI_RATE, num_args = 1, response_sz = 1
-	 * input: args[0] = link rate control value
-	 * output: args[0] = previous link rate control value
-	 */
-	{1, 1, HSMP_SET},
-
-	/*
-	 * HSMP_SET_POWER_MODE, num_args = 1, response_sz = 0
-	 * input: args[0] = power efficiency mode[2:0]
-	 */
-	{1, 0, HSMP_SET},
-
-	/*
-	 * HSMP_SET_PSTATE_MAX_MIN, num_args = 1, response_sz = 0
-	 * input: args[0] = min df pstate[15:8] + max df pstate[7:0]
-	 */
-	{1, 0, HSMP_SET},
-
-	/*
-	 * HSMP_GET_METRIC_TABLE_VER, num_args = 0, response_sz = 1
-	 * output: args[0] = metrics table version
-	 */
-	{0, 1, HSMP_GET},
-
-	/*
-	 * HSMP_GET_METRIC_TABLE, num_args = 0, response_sz = 0
-	 */
-	{0, 0, HSMP_GET},
-
-	/*
-	 * HSMP_GET_METRIC_TABLE_DRAM_ADDR, num_args = 0, response_sz = 2
-	 * output: args[0] = lower 32 bits of the address
-	 * output: args[1] = upper 32 bits of the address
-	 */
-	{0, 2, HSMP_GET},
-};
-
 /* Metrics table (supported only with proto version 6) */
 struct hsmp_metric_table {
 	__u32 accumulation_counter;
diff --git a/drivers/platform/x86/amd/hsmp/hsmp.c b/drivers/platform/x86/amd/hsmp/hsmp.c
index 82d8ba2e1204..5d21bc8b2fd7 100644
--- a/drivers/platform/x86/amd/hsmp/hsmp.c
+++ b/drivers/platform/x86/amd/hsmp/hsmp.c
@@ -37,6 +37,251 @@
 
 static struct hsmp_plat_device hsmp_pdev;
 
+/*
+ * User may use these comments as reference, please find the
+ * supported list of messages and message definition in the
+ * HSMP chapter of respective family/model PPR.
+ *
+ * Not supported messages would return -ENOMSG.
+ */
+static const struct hsmp_msg_desc hsmp_msg_desc_table[] = {
+	/* RESERVED */
+	{0, 0, HSMP_RSVD},
+
+	/*
+	 * HSMP_TEST, num_args = 1, response_sz = 1
+	 * input:  args[0] = xx
+	 * output: args[0] = xx + 1
+	 */
+	{1, 1, HSMP_GET},
+
+	/*
+	 * HSMP_GET_SMU_VER, num_args = 0, response_sz = 1
+	 * output: args[0] = smu fw ver
+	 */
+	{0, 1, HSMP_GET},
+
+	/*
+	 * HSMP_GET_PROTO_VER, num_args = 0, response_sz = 1
+	 * output: args[0] = proto version
+	 */
+	{0, 1, HSMP_GET},
+
+	/*
+	 * HSMP_GET_SOCKET_POWER, num_args = 0, response_sz = 1
+	 * output: args[0] = socket power in mWatts
+	 */
+	{0, 1, HSMP_GET},
+
+	/*
+	 * HSMP_SET_SOCKET_POWER_LIMIT, num_args = 1, response_sz = 0
+	 * input: args[0] = power limit value in mWatts
+	 */
+	{1, 0, HSMP_SET},
+
+	/*
+	 * HSMP_GET_SOCKET_POWER_LIMIT, num_args = 0, response_sz = 1
+	 * output: args[0] = socket power limit value in mWatts
+	 */
+	{0, 1, HSMP_GET},
+
+	/*
+	 * HSMP_GET_SOCKET_POWER_LIMIT_MAX, num_args = 0, response_sz = 1
+	 * output: args[0] = maximuam socket power limit in mWatts
+	 */
+	{0, 1, HSMP_GET},
+
+	/*
+	 * HSMP_SET_BOOST_LIMIT, num_args = 1, response_sz = 0
+	 * input: args[0] = apic id[31:16] + boost limit value in MHz[15:0]
+	 */
+	{1, 0, HSMP_SET},
+
+	/*
+	 * HSMP_SET_BOOST_LIMIT_SOCKET, num_args = 1, response_sz = 0
+	 * input: args[0] = boost limit value in MHz
+	 */
+	{1, 0, HSMP_SET},
+
+	/*
+	 * HSMP_GET_BOOST_LIMIT, num_args = 1, response_sz = 1
+	 * input: args[0] = apic id
+	 * output: args[0] = boost limit value in MHz
+	 */
+	{1, 1, HSMP_GET},
+
+	/*
+	 * HSMP_GET_PROC_HOT, num_args = 0, response_sz = 1
+	 * output: args[0] = proc hot status
+	 */
+	{0, 1, HSMP_GET},
+
+	/*
+	 * HSMP_SET_XGMI_LINK_WIDTH, num_args = 1, response_sz = 0
+	 * input: args[0] = min link width[15:8] + max link width[7:0]
+	 */
+	{1, 0, HSMP_SET},
+
+	/*
+	 * HSMP_SET_DF_PSTATE, num_args = 1, response_sz = 0
+	 * input: args[0] = df pstate[7:0]
+	 */
+	{1, 0, HSMP_SET},
+
+	/* HSMP_SET_AUTO_DF_PSTATE, num_args = 0, response_sz = 0 */
+	{0, 0, HSMP_SET},
+
+	/*
+	 * HSMP_GET_FCLK_MCLK, num_args = 0, response_sz = 2
+	 * output: args[0] = fclk in MHz, args[1] = mclk in MHz
+	 */
+	{0, 2, HSMP_GET},
+
+	/*
+	 * HSMP_GET_CCLK_THROTTLE_LIMIT, num_args = 0, response_sz = 1
+	 * output: args[0] = core clock in MHz
+	 */
+	{0, 1, HSMP_GET},
+
+	/*
+	 * HSMP_GET_C0_PERCENT, num_args = 0, response_sz = 1
+	 * output: args[0] = average c0 residency
+	 */
+	{0, 1, HSMP_GET},
+
+	/*
+	 * HSMP_SET_NBIO_DPM_LEVEL, num_args = 1, response_sz = 0
+	 * input: args[0] = nbioid[23:16] + max dpm level[15:8] + min dpm level[7:0]
+	 */
+	{1, 0, HSMP_SET},
+
+	/*
+	 * HSMP_GET_NBIO_DPM_LEVEL, num_args = 1, response_sz = 1
+	 * input: args[0] = nbioid[23:16]
+	 * output: args[0] = max dpm level[15:8] + min dpm level[7:0]
+	 */
+	{1, 1, HSMP_GET},
+
+	/*
+	 * HSMP_GET_DDR_BANDWIDTH, num_args = 0, response_sz = 1
+	 * output: args[0] = max bw in Gbps[31:20] + utilised bw in Gbps[19:8] +
+	 * bw in percentage[7:0]
+	 */
+	{0, 1, HSMP_GET},
+
+	/*
+	 * HSMP_GET_TEMP_MONITOR, num_args = 0, response_sz = 1
+	 * output: args[0] = temperature in degree celsius. [15:8] integer part +
+	 * [7:5] fractional part
+	 */
+	{0, 1, HSMP_GET},
+
+	/*
+	 * HSMP_GET_DIMM_TEMP_RANGE, num_args = 1, response_sz = 1
+	 * input: args[0] = DIMM address[7:0]
+	 * output: args[0] = refresh rate[3] + temperature range[2:0]
+	 */
+	{1, 1, HSMP_GET},
+
+	/*
+	 * HSMP_GET_DIMM_POWER, num_args = 1, response_sz = 1
+	 * input: args[0] = DIMM address[7:0]
+	 * output: args[0] = DIMM power in mW[31:17] + update rate in ms[16:8] +
+	 * DIMM address[7:0]
+	 */
+	{1, 1, HSMP_GET},
+
+	/*
+	 * HSMP_GET_DIMM_THERMAL, num_args = 1, response_sz = 1
+	 * input: args[0] = DIMM address[7:0]
+	 * output: args[0] = temperature in degree celsius[31:21] + update rate in ms[16:8] +
+	 * DIMM address[7:0]
+	 */
+	{1, 1, HSMP_GET},
+
+	/*
+	 * HSMP_GET_SOCKET_FREQ_LIMIT, num_args = 0, response_sz = 1
+	 * output: args[0] = frequency in MHz[31:16] + frequency source[15:0]
+	 */
+	{0, 1, HSMP_GET},
+
+	/*
+	 * HSMP_GET_CCLK_CORE_LIMIT, num_args = 1, response_sz = 1
+	 * input: args[0] = apic id [31:0]
+	 * output: args[0] = frequency in MHz[31:0]
+	 */
+	{1, 1, HSMP_GET},
+
+	/*
+	 * HSMP_GET_RAILS_SVI, num_args = 0, response_sz = 1
+	 * output: args[0] = power in mW[31:0]
+	 */
+	{0, 1, HSMP_GET},
+
+	/*
+	 * HSMP_GET_SOCKET_FMAX_FMIN, num_args = 0, response_sz = 1
+	 * output: args[0] = fmax in MHz[31:16] + fmin in MHz[15:0]
+	 */
+	{0, 1, HSMP_GET},
+
+	/*
+	 * HSMP_GET_IOLINK_BANDWITH, num_args = 1, response_sz = 1
+	 * input: args[0] = link id[15:8] + bw type[2:0]
+	 * output: args[0] = io bandwidth in Mbps[31:0]
+	 */
+	{1, 1, HSMP_GET},
+
+	/*
+	 * HSMP_GET_XGMI_BANDWITH, num_args = 1, response_sz = 1
+	 * input: args[0] = link id[15:8] + bw type[2:0]
+	 * output: args[0] = xgmi bandwidth in Mbps[31:0]
+	 */
+	{1, 1, HSMP_GET},
+
+	/*
+	 * HSMP_SET_GMI3_WIDTH, num_args = 1, response_sz = 0
+	 * input: args[0] = min link width[15:8] + max link width[7:0]
+	 */
+	{1, 0, HSMP_SET},
+
+	/*
+	 * HSMP_SET_PCI_RATE, num_args = 1, response_sz = 1
+	 * input: args[0] = link rate control value
+	 * output: args[0] = previous link rate control value
+	 */
+	{1, 1, HSMP_SET},
+
+	/*
+	 * HSMP_SET_POWER_MODE, num_args = 1, response_sz = 0
+	 * input: args[0] = power efficiency mode[2:0]
+	 */
+	{1, 0, HSMP_SET},
+
+	/*
+	 * HSMP_SET_PSTATE_MAX_MIN, num_args = 1, response_sz = 0
+	 * input: args[0] = min df pstate[15:8] + max df pstate[7:0]
+	 */
+	{1, 0, HSMP_SET},
+
+	/*
+	 * HSMP_GET_METRIC_TABLE_VER, num_args = 0, response_sz = 1
+	 * output: args[0] = metrics table version
+	 */
+	{0, 1, HSMP_GET},
+
+	/*
+	 * HSMP_GET_METRIC_TABLE, num_args = 0, response_sz = 0
+	 */
+	{0, 0, HSMP_GET},
+
+	/*
+	 * HSMP_GET_METRIC_TABLE_DRAM_ADDR, num_args = 0, response_sz = 2
+	 * output: args[0] = lower 32 bits of the address
+	 * output: args[1] = upper 32 bits of the address
+	 */
+	{0, 2, HSMP_GET},
+};
+
 /*
  * Send a message to the HSMP port via PCI-e config space registers
  * or by writing to MMIO space.
-- 
2.39.5


