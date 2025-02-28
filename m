Return-Path: <linux-kernel+bounces-537789-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 96298A490DB
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 06:22:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A174016DE5C
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 05:21:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE06E1BD9C5;
	Fri, 28 Feb 2025 05:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="S5kESYEQ"
Received: from smtpbguseast2.qq.com (smtpbguseast2.qq.com [54.204.34.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 305CE1BCA0C
	for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 05:21:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.204.34.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740720115; cv=none; b=KKkRYIUvqBDTn49A9m3IcEWJoOj7Q+S/v0yJyDv34zjc3OvKZ02PMbGDmGn0dRBYY8L8PMbM4NrqOF2jIS+ZQURzMXCuHpaXi3RvCpuoWCCmV8obyAz9hE0MgBds0MIHomNuXoz89nTASoM8hPVQUk1AvVeext0nQzBWCLjjme0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740720115; c=relaxed/simple;
	bh=Q/l3cX4hhsmIp3gU6O9JiApDRNBOKFnPY7oyWOnQ2eA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=dSiq4XSyFv5DWaZNMl5OsMeygsKF7bagbD3UW9G2v40yMWIOGzvaw6DyuY+8qPxaZ2dLZbEazKnGD9QCb/J0tgzpzIPngH56wyqOayDb7pR35GrCQoB/R/vgt0lIK/LODxMjlomP0NAEsMQlBHR2XmYjA6qr8yzcUS6A69kHNYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=S5kESYEQ; arc=none smtp.client-ip=54.204.34.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1740719996;
	bh=NFX92DKn7l5oFMSy9LZKme5rrsk2p3w4GB7kNrg8upw=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=S5kESYEQG3RuSVBSpvuR76YkAfwL5sHNvAlHIz38uPnxhK348XKcSNM74B0T4Vazw
	 DWhxz9U8xky5B9ql9v2ix3/TAO0FmiakOr/xlnjjO5dmH6iD/fcHDxI2Lhsqz5fha4
	 toCffKcdyz4iST8T0YXPwBJTGF9Tj9OG/xKf3hLQ=
X-QQ-mid: bizesmtpip3t1740719946tyalcva
X-QQ-Originating-IP: BQ3upcRjLhJfUkRuYZGoADXAE1vBfzV3sSe4EpYSAqg=
Received: from localhost.localdomain ( [localhost])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 28 Feb 2025 13:19:04 +0800 (CST)
X-QQ-SSF: 0002000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 8574307554378089718
From: WangYuli <wangyuli@uniontech.com>
To: dave.hansen@linux.intel.com,
	luto@kernel.org,
	peterz@infradead.org,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	x86@kernel.org,
	hpa@zytor.com
Cc: linux-kernel@vger.kernel.org,
	zhanjun@uniontech.com,
	niecheng1@uniontech.com,
	chenlinxuan@uniontech.com,
	WangYuli <wangyuli@uniontech.com>,
	Huacai Chen <chenhuacai@loongson.cn>,
	Wentao Guan <guanwentao@uniontech.com>
Subject: [PATCH] x86/srat: Conditional apic_id vs MAX_LOCAL_APIC comparison
Date: Fri, 28 Feb 2025 13:18:47 +0800
Message-ID: <E053FB6951F019A2+20250228051847.50002-1-wangyuli@uniontech.com>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtpip:uniontech.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: Of+SSFCKeSEZm79OFpjWRC8R9VrCYVat8EvIqUxzAuUBUBU2QrKDYZR8
	n7bDgIJ4j5T0gbH2khm7yTG5VaP+rFh45RrT5PFCeFjNpXy42eJfDwq2Yf1jaYaqBppzxFR
	r2YP83CVc9J6l7mCD6EVn4GklJiAJfRcUb9k8RJS+ib3Zs27SVi5adVkCTkZrPS9XiADmBf
	C3ZX5Z5HhNyRVb5hk6gepV0bAb2KwpwbdMPBYtHcNmCcsrSdvWJD0XyosfxMaMpdlL0W+4Q
	pnLL821iPdJSNNDfODRk75UmFxYpMqTNdphbpOfzgXRLOEATmfwSYBcrsxC8p3yaiI7eDyO
	/0JMB918jzEQ+9UINLRz3x6QgFcM8ZCxcWYc4RFVE4Ouy3dIPpUWFrUlDKuBlCX2Ahl05n/
	fzHpFVmzYayvW3b8F4U/BPQiJ2E3qzjWVPVH/33l53D7mgOhij6XdGsE6+mYfWZ7TnvK/4i
	pYBLEwGUxzaUxRFQuZCEP3TJnUCcBAvTqzvR0kja0UckNBY34IZrv67zIW7KjyjzW+oZ+Qo
	P83DTk/OwbNygYBIYPFt2jNOaWQXf9e4kVZ9HlBSt1xXyztE3VT4Bnvhglsp0QCB6nLcUho
	QbKQxzF28AEa69LWuRN+TIasxtJtBC2lg727bzsoGuw3SAypQFKKe4+ouCyXI+JKndl/V5A
	+G9XA3UOUvD9R5pwIbeuA1aqCvb67iV6ntkLuJTPGmZxL6CT9wB6UeUpcUTuG6a98XnXg5M
	mFAlX3gCmmTdC2x4aT/VvyR5ts9PDssyq3RVwN5LnkmIumAtz/+Mxz/5wyUNfLuyFPI0a9n
	q1j2NrnlEVbapR/HPfu/bJPo6lZu5ZpOC8QczJQcESEBuenm3aNf+KqA1OZzD/W1h8bjZUH
	77UMwuoYFrzCa/s91nyDxleiYP/o9h8jYKM2guC4QyMi1Hhu0mLcmnYsykCNKhFPW76O9/7
	k9yHnz5USrURc0HW4T8vfmscVem4NjhaUz+cThaPMlpFzrbKxpm6Mo0gSGq8qcZWs3algrf
	YZE+ecOwgLB3/E+F5IPqQjcn1Jt1g=
X-QQ-XMRINFO: Nq+8W0+stu50PRdwbJxPCL0=
X-QQ-RECHKSPAM: 0

The apic_id employed within the acpi_numa_processor_affinity_init()
function is derived from the acpi_srat_cpu_affinity structure defined
in acpi/actbl3.h.

When CONFIG_X86_X2APIC is not enabled, its maximum value is limited
to 255. It is only capable of exceeding 256 and 32768 —  which
corresponds to the definition of MAX_LOCAL_APIC — when CONFIG_X86_X2APIC
is activated.

Consequently, with CONFIG_X86_X2APIC disabled, this code segment will
elicit the compiler's "-Wtautological-constant-out-of-range-compare"
warning, as a variable capped at 255 can never satisfy a condition
requiring it to be greater than or equal to 256 or 32768.

Compiling the kernel with the W=1e flag will, in this scenario, lead
to compilation failure.

Suggested-by: Huacai Chen <chenhuacai@loongson.cn>
Co-developed-by: Wentao Guan <guanwentao@uniontech.com>
Signed-off-by: Wentao Guan <guanwentao@uniontech.com>
Signed-off-by: WangYuli <wangyuli@uniontech.com>
---
 arch/x86/mm/srat.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/x86/mm/srat.c b/arch/x86/mm/srat.c
index 6f8e0f21c710..93e5bcc58ead 100644
--- a/arch/x86/mm/srat.c
+++ b/arch/x86/mm/srat.c
@@ -90,10 +90,12 @@ acpi_numa_processor_affinity_init(struct acpi_srat_cpu_affinity *pa)
 	else
 		apic_id = pa->apic_id;
 
+#ifdef CONFIG_X86_X2APIC
 	if (apic_id >= MAX_LOCAL_APIC) {
 		printk(KERN_INFO "SRAT: PXM %u -> APIC 0x%02x -> Node %u skipped apicid that is too big\n", pxm, apic_id, node);
 		return;
 	}
+#endif /* CONFIG_X86_X2APIC */
 
 	set_apicid_to_node(apic_id, node);
 	node_set(node, numa_nodes_parsed);
-- 
2.47.2


