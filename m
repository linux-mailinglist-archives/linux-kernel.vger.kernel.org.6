Return-Path: <linux-kernel+bounces-521453-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 16933A3BD84
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 12:55:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A122F1892DDB
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 11:55:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C39601DF265;
	Wed, 19 Feb 2025 11:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="LRBPD+9C"
Received: from smtpbgau2.qq.com (smtpbgau2.qq.com [54.206.34.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EFB3286291
	for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 11:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.206.34.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739966145; cv=none; b=SNFPweUWuQD9p0Qvh28X9v2i2sidvUYTvcci7E3NoCWxcD5iAR6ms1soQcBHwR7KCyFE1LSyspvQwEKuSGbpDBfv8/AGdx0ReFXfnN30JK1rFvQydCOAB3/4PldKbwstOSfEc2edIGwYVIVV6MlKTCLF9kYLs3suaG01AHM3xHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739966145; c=relaxed/simple;
	bh=cmcwUjQoopYu+8HGY2X8Lh2p1aPjgwBlSxNxgvGqn20=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uocPBZweyftcTLGybI645MaqTQf/J1z1ADRQclpT6UaZFly2vgJyrw1qT+xoB1c4EtyDhxI2NL6n/0cxigH/BTuC2tTD3obiwPcTJrSTX2+WcvMhuocNczKy6qj/pmNA1SlLvimCUgcH+/FUgOVBIcQZFEddCd+CMZ9p5+ZTOK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=LRBPD+9C; arc=none smtp.client-ip=54.206.34.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1739966091;
	bh=7WqapH9hkRwnBXqdTtOxByg0Cq2hNow9/HDGmqbIlgQ=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=LRBPD+9Cti7CUZrezgucsc6t2zS9BTcK7IK+eoERjM05vbD5swV2yXFK7mSoYGj96
	 sARCsjzNf66slTW509g59LqVOCm9e6E9kpoBwhUnh1zJLzr77BhlsYw/pmGwKtri/k
	 qgpQg72HbjHOc+BQOERJH6FOB5F393Ch1Lxqj7MI=
X-QQ-mid: bizesmtpip3t1739966045tgjfcps
X-QQ-Originating-IP: O7SsgWhzKwnrxZounFROXcK2a+thI6ETPZgTVaPWgs4=
Received: from localhost.localdomain ( [localhost])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 19 Feb 2025 19:54:03 +0800 (CST)
X-QQ-SSF: 0002000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 15418192173615449267
From: WangYuli <wangyuli@uniontech.com>
To: chenhuacai@kernel.org,
	kernel@xen0n.name
Cc: wangyuli@uniontech.com,
	maobibo@loongson.cn,
	guanwentao@uniontech.com,
	loongarch@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	zhanjun@uniontech.com,
	niecheng1@uniontech.com,
	chenlinxuan@uniontech.com
Subject: [PATCH] LoongArch: acpi: Conditional apic_id vs CONFIG_NR_CPUS comparison
Date: Wed, 19 Feb 2025 19:53:07 +0800
Message-ID: <C2885DC275589FDD+20250219115307.194770-1-wangyuli@uniontech.com>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtpip:uniontech.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: MRw/zKT/0BpPPS3mn+aFxUhlbq4zQw3/pyxz5UKRwFGOtJ0HZicqf658
	LJix2s5YER5IAMms3tjrRkw0SqYjX+4ENvtgNMX1BRCXhsI52XUsdvKvv1KZ+AsPpMv2k0o
	GSN2GZqhJTRFg+XA/72/9wLxGXikE/gbeewZsCkjcz8f+JTmVGpz0w1dKW84EH5uaeQrqqp
	SyzWi4lKbOiJGwjYZOtbKkOaEKSlQ+pF/WaCnCfulUZc+w48gDxOcJeux5QTDvKJrB1EIyn
	BpS0gqKk+rxJyBC/6Ut9fUAx8p+1Dm3Ypk4sRFUNmbEVkPWlEnpa0KjQwldIvp/ho7Y2gxS
	ZFX0tyB3ymeTQQuDGqdnfPg76Jhzn+eQs0WZMbWUaTu47TDES47oVPA+5wFN5JnPKRbInPH
	H7w9dgx198wsoNE5/Y/HN5BeNYMN4NGjf8QeaM4+Li+s1e9BWCpnzHxDmuonsyVIhygM4oH
	GTl2p1wGzrh7guCeyOVx5yz/KPyc6Pm/tTMc6Ek8CkncZB0is3oHfGGLcIk9CZPwRqVeXU/
	bXacKVJ5g3oowDsnoTyrVvdzSYiRSHO5YZCT8oJU8e6HRdcntEkctUxF3Ncz+/L++vTi+oG
	1E/EZsNtUYj3QjMkHWkSWHBW2EcQjEz3dUcuq/jOkZtBL5sJXaOPeY6/dY42/s3jItz15Wo
	hmBypzCTtoUve526/EJm2hO23ZitSWj6szJt0B3EMXCZ7ftbjT/5P4yeVqcsBUQ3Fk5U/py
	fG799frSgViJ1yrY66FRQamPb66ld9hRhswMOEBES8aIrVpsUz7jifqSQT57lGtCHeX6/dT
	eY5p/Se89KZlnd0/DGgCnWGZqGwWtL9nWGuet6yFmfLfyAgJTTEFM4PyVFFhS4YfKS6A/TC
	CiMHb1Yq1MujFKMlrmN1raD1jn4wPqb0418ngMbrk2FZxbV7QO6HC+0U7QaQC3MpO5E/HG3
	e/LbrXuHgK2Udd75YNnQAjz8I5x8DYgjfh+BcLIo8U+g4c1XyHSQ7NzK0Si1NHOvSvI3mUV
	/AkhMXU4Fc0rUg1qHDfMwuc/Tw6h8hMHBaEu06WuG2ZuX4QoEW4fzt3yjbHUQ=
X-QQ-XMRINFO: NI4Ajvh11aEj8Xl/2s1/T8w=
X-QQ-RECHKSPAM: 0

The apic_id here, as declared as a u8 (unsigned char) in struct
acpi_srat_cpu_affinity of acpi/actbl3.h, has a range up to 255.

Evidently, if CONFIG_NR_CPUS becomes 256 or more, the check
"apic_id >= CONFIG_NR_CPUS" will always be false, which will produce
a compiler warning.

Only compile this code if CONFIG_NR_CPUS is at most 255 consequently.

Fix follow error with clang-18 when W=1e:

arch/loongarch/kernel/acpi.c:302:18: error: result of comparison of constant 256 with expression of type 'u8' (aka 'unsigned char') is always false [-Werror,-Wtautological-constant-out-of-range-compare]
  302 |         if (pa->apic_id >= CONFIG_NR_CPUS) {
      |             ~~~~~~~~~~~ ^  ~~~~~~~~~~~~~~
1 error generated.

Signed-off-by: Yuli Wang <wangyuli@uniontech.com>
---
 arch/loongarch/kernel/acpi.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/loongarch/kernel/acpi.c b/arch/loongarch/kernel/acpi.c
index 2bb3bc42e6ed..ee471a80763e 100644
--- a/arch/loongarch/kernel/acpi.c
+++ b/arch/loongarch/kernel/acpi.c
@@ -299,11 +299,17 @@ acpi_numa_processor_affinity_init(struct acpi_srat_cpu_affinity *pa)
 		return;
 	}
 
+/*
+ * apic_id's type is u8.
+ * Conditionally skip this check to silence compiler warnings.
+ */
+#if CONFIG_NR_CPUS < 256
 	if (pa->apic_id >= CONFIG_NR_CPUS) {
 		pr_info("SRAT: PXM %u -> CPU 0x%02x -> Node %u skipped apicid that is too big\n",
 				pxm, pa->apic_id, node);
 		return;
 	}
+#endif /* CONFIG_NR_CPUS < 256 */
 
 	early_numa_add_cpu(pa->apic_id, node);
 
-- 
2.47.2


