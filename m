Return-Path: <linux-kernel+bounces-435401-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 86AFB9E7709
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 18:24:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4554C28793F
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 17:24:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8528721AA11;
	Fri,  6 Dec 2024 17:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jmMNnMdl"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78F1420457E
	for <linux-kernel@vger.kernel.org>; Fri,  6 Dec 2024 17:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733505688; cv=none; b=d56YbGcJ3I+Hv0tPeJoSSQrEwd554ukOGICktDlCsaEqIR7zsZwAF6le+VStH6Cd1OdfFffs7ToIJ03XBg9feFQRhwINfjhih+frrC5T9ZQESK/gjaKOqwBqVvl4tscwGRfmYpdj58jg8CHl2V12KqJ25usPQ44RPdJ5Ovkq4Ts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733505688; c=relaxed/simple;
	bh=eNJ0L18CqakPOsgyzdzaKDzBHHjkiPmCHmVgcT+mZFs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jlxxN0GSUpRfEhMk6of+4t1GkDCJtfUfs+G/j1ujTwECAKUKRX9Pz3KYNoQ84nqHFEPzc/10+DRw6hSjW3c9+oD8q0k6SegcUY53IGnfPQOGqLg9O7Ce61JrcFKqAW2zM1m797l7PnqAUODqypSbr+3Wuegt/E8rJ9L25a0CO2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jmMNnMdl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB5C4C19422;
	Fri,  6 Dec 2024 17:21:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733505688;
	bh=eNJ0L18CqakPOsgyzdzaKDzBHHjkiPmCHmVgcT+mZFs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jmMNnMdlvruwYpyvgGKjmcJpccfhK2n1ouuVaFQqxzazOJAhsVo3uZkUFCOMx2AiW
	 Qw9Q8rlDhbdqlp3ThXZmDrc6r57SAVbdpXWo7P/js6gy1KL6/i2bnH+l7ddiH0/eV0
	 XHKZspY+10ujwXrNEuXnJNwlwjOWptUfeUWpnRrz28fcaJcT282xcitsVx/8T+fEl1
	 m8Hb6V6j7aagwoFF9LuKn6Xx3LtnBlb/VDmCKetydB9T5oMv+VN75DQDL8W/sJ/D/p
	 VMJlN5B6xpDfEH7dRWLjXwQGHt9tFlyi9m8flAXuyYHtPrMyKQM2AjhOsHZBCWc+AB
	 /b32giTFAswgQ==
Received: from mchehab by mail.kernel.org with local (Exim 4.98)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1tJc18-00000005RL4-0ZHL;
	Fri, 06 Dec 2024 18:21:26 +0100
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: "Michael S . Tsirkin" <mst@redhat.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Shiju Jose <shiju.jose@huawei.com>,
	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	Peter Maydell <peter.maydell@linaro.org>,
	linux-kernel@vger.kernel.org,
	qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 24/31] target/arm: add an experimental mpidr arm cpu property object
Date: Fri,  6 Dec 2024 18:12:46 +0100
Message-ID: <5ad2755ea045bdc6700ff063b717136da0941f39.1733504943.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <cover.1733504943.git.mchehab+huawei@kernel.org>
References: <cover.1733504943.git.mchehab+huawei@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

Accurately injecting an ARM Processor error ACPI/APEI GHES
error record requires the value of the ARM Multiprocessor
Affinity Register (mpidr).

While ARM implements it, this is currently not visible.

Add a field at CPU storing it, and place it at arm_cpu_properties
as experimental, thus allowing it to be queried via QMP using
qom-get function.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 target/arm/cpu.c    |  1 +
 target/arm/cpu.h    |  1 +
 target/arm/helper.c | 10 ++++++++--
 3 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 6938161b9541..aec9ea5000a0 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -2636,6 +2636,7 @@ static ObjectClass *arm_cpu_class_by_name(const char *cpu_model)
 
 static Property arm_cpu_properties[] = {
     DEFINE_PROP_UINT64("midr", ARMCPU, midr, 0),
+    DEFINE_PROP_UINT64("x-mpidr", ARMCPU, mpidr, 0),
     DEFINE_PROP_UINT64("mp-affinity", ARMCPU,
                         mp_affinity, ARM64_AFFINITY_INVALID),
     DEFINE_PROP_INT32("node-id", ARMCPU, node_id, CPU_UNSET_NUMA_NODE_ID),
diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index d86e641280d4..1ccd2d6b0c3c 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -1035,6 +1035,7 @@ struct ArchCPU {
         uint64_t reset_pmcr_el0;
     } isar;
     uint64_t midr;
+    uint64_t mpidr;
     uint32_t revidr;
     uint32_t reset_fpsid;
     uint64_t ctr;
diff --git a/target/arm/helper.c b/target/arm/helper.c
index f38eb054c06b..5b0ea8ba5fb8 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -4700,7 +4700,7 @@ static uint64_t mpidr_read_val(CPUARMState *env)
     return mpidr;
 }
 
-static uint64_t mpidr_read(CPUARMState *env, const ARMCPRegInfo *ri)
+static uint64_t mpidr_read(CPUARMState *env)
 {
     unsigned int cur_el = arm_current_el(env);
 
@@ -4710,6 +4710,11 @@ static uint64_t mpidr_read(CPUARMState *env, const ARMCPRegInfo *ri)
     return mpidr_read_val(env);
 }
 
+static uint64_t mpidr_read_ri(CPUARMState *env, const ARMCPRegInfo *ri)
+{
+    return mpidr_read(env);
+}
+
 static const ARMCPRegInfo lpae_cp_reginfo[] = {
     /* NOP AMAIR0/1 */
     { .name = "AMAIR0", .state = ARM_CP_STATE_BOTH,
@@ -9741,7 +9746,7 @@ void register_cp_regs_for_features(ARMCPU *cpu)
             { .name = "MPIDR_EL1", .state = ARM_CP_STATE_BOTH,
               .opc0 = 3, .crn = 0, .crm = 0, .opc1 = 0, .opc2 = 5,
               .fgt = FGT_MPIDR_EL1,
-              .access = PL1_R, .readfn = mpidr_read, .type = ARM_CP_NO_RAW },
+              .access = PL1_R, .readfn = mpidr_read_ri, .type = ARM_CP_NO_RAW },
         };
 #ifdef CONFIG_USER_ONLY
         static const ARMCPRegUserSpaceInfo mpidr_user_cp_reginfo[] = {
@@ -9751,6 +9756,7 @@ void register_cp_regs_for_features(ARMCPU *cpu)
         modify_arm_cp_regs(mpidr_cp_reginfo, mpidr_user_cp_reginfo);
 #endif
         define_arm_cp_regs(cpu, mpidr_cp_reginfo);
+        cpu->mpidr = mpidr_read(env);
     }
 
     if (arm_feature(env, ARM_FEATURE_AUXCR)) {
-- 
2.47.1


