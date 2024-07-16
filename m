Return-Path: <linux-kernel+bounces-253864-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C5CD932810
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 16:15:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9E11C1F230BC
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 14:15:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4980C19B3C9;
	Tue, 16 Jul 2024 14:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=flygoat.com header.i=@flygoat.com header.b="HAM/oXwj";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="p0l9jdZo"
Received: from fhigh5-smtp.messagingengine.com (fhigh5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5136D19ADBB
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2024 14:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721139312; cv=none; b=nEgsxNpjLOCF+Wgd9aKfVr1PiZjVP6C3lSvyjPcmu4OnW+q7/xoIWHjuOqrXbFEQCMxVu1Pd7KIFptU+i6+bhw90D0wTkirdZVyfq9jCeFchIEwepVYc3Gt9NW9F7g+A3T0y3ZqhFrVCVNiy3WaNFaYrbTCC3qQPLXJszmQ8Zuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721139312; c=relaxed/simple;
	bh=tk5TMmuul2lboVBVIaOCJWUBH1Nrg+wwCKaNSNGbwcM=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=li5DiIQNb+oelsE8y+YP0bDriR7myp4CZJ7yr20/tXmNGM/8x1NBS7kWCcJuCaUewEcbEg7iUz/o4D31dPYQSMv0SFtO56Fb7VxDfxjVULByFEJL3unB4GB8z4SZCazE2BNGCRvkHOogGK3tt02sZAIyQ/coVR6s1Ysa4bNIYEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=flygoat.com; spf=pass smtp.mailfrom=flygoat.com; dkim=pass (2048-bit key) header.d=flygoat.com header.i=@flygoat.com header.b=HAM/oXwj; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=p0l9jdZo; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flygoat.com
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 7A06B11480A5;
	Tue, 16 Jul 2024 10:15:08 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Tue, 16 Jul 2024 10:15:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:message-id:mime-version:reply-to
	:subject:subject:to:to; s=fm3; t=1721139308; x=1721225708; bh=IN
	JyV6lCgUK9JMf7AobUOIZXv0ZhcOYphpMoAPpaOlw=; b=HAM/oXwjEQcav6UbEb
	GO8a9OaHrpF60lAOu34ZY40VHl06S0xt41/DVlrDdjP22gm6zMMRG5kmlpMvNwQu
	joT4Cexz8ulU2DT6fx78dVlGrvpEuWL4rLPg90DpdverljOmEsa9aISSYoSuY6kV
	0TPIUbJj0SycsT6p7l5nw4XFmThfoU61isaPkuRdAC1rpv4x2OfvNjvrVWlQLiUQ
	cNsJIagb6nhZacf5zSHn/+1quF9NffVLvxme17/W09doidZ8ej+SKYN+Uz7O2Noy
	09LSVk1bHQtxFXZXON2GT/fojnZxhSBLh20bhpQPkESEMVwvJVYCtVv+cdc5KCRU
	y1PQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm2; t=1721139308; x=1721225708; bh=INJyV6lCgUK9J
	Mf7AobUOIZXv0ZhcOYphpMoAPpaOlw=; b=p0l9jdZoTQUNIaUlS5oJDG0xQy4J5
	7l0McLMVUmLiGe2HVFV314lo+/WEfk/xoNV1EqK7tOTWLXJo+8j3XhKwaMCntr32
	ZcGCsfpTWyKVOiO4RLE0FoZ1LcmuWAHjw7b24WRmBN5R2O92Tv6rJfZfqLQdTpQv
	lrnOVy4/8hZTFkjZe//q2UAp6SFLN6WaJNp2NVrE1VsPik7OjwuilLMWLD+wf04q
	0rC9UZSXmrVtssLbGPTNBmMCPx0g/Q/sq3Mn00vTp2eY9iW3o8CfxdQCwHqz6rvT
	SEQjZ9uEEwQYnVS+ltZwjqNluL7OQAdunqlltvgSatC44J7KtglukVqeA==
X-ME-Sender: <xms:aoCWZjROUzFXkXkg_cJCuJ_Z6xOzbx3qohZ-dNbnnCGwyKODityeaA>
    <xme:aoCWZkwgoVDSONIpNE0F9987HGeacX8n0AqDowYP9YY7ch8yo_EbuXmOUHH4G2rMB
    iqxWleUeAlTYRmRcqE>
X-ME-Received: <xmr:aoCWZo1gD73GfitUq9ISMrLLwC7SzhfUcEjufPcXdMmSWIY_HK1UPvTy3PWSE7rcsubr>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrgeeggdejfecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhufffkfggtgfgvfevofesthejredtredtjeenucfhrhhomheplfhirgiguhhn
    ucgjrghnghcuoehjihgrgihunhdrhigrnhhgsehflhihghhorghtrdgtohhmqeenucggtf
    frrghtthgvrhhnpefgveffjeetgeejfeelgfekteelkefhuefggedvueeujeekjeetkeek
    vdffffefudenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuih
    iivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepjhhirgiguhhnrdihrghnghesfhhl
    hihgohgrthdrtghomh
X-ME-Proxy: <xmx:aoCWZjA2Kt1i1LlR-rft3xVpJ3QpmXhxwd_vGWrYgTOz3MAZPh7PyA>
    <xmx:aoCWZsj2K-g6sWsQig46RY3SGC7Fke2ZTtriM6TBIo3S6Jno3krTwQ>
    <xmx:aoCWZnpftsuAG1Px7KyI0GcNP8B_l6VjkTXrsckWFDET7rxwKXXMsQ>
    <xmx:aoCWZnjUg9mR5m-qq9j-Iy9f5gTfyz32bKL0TSdB67RFRt7ET-u0nQ>
    <xmx:bICWZohVA9CDlCE4FTkC5Nc0LFWmuEeH9GTfZMfDnYPCcyqEwzU2KZby>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 16 Jul 2024 10:15:04 -0400 (EDT)
From: Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: [PATCH v3 0/3] LoongArch: CPU parallel bring up
Date: Tue, 16 Jul 2024 22:14:57 +0800
Message-Id: <20240716-loongarch-hotplug-v3-0-af59b3bb35c8@flygoat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAGKAlmYC/23N3wqDIBiH4VsJj+fw39J2tPsYOzA1FVqGNllE9
 z4LBht0+P7ge74FJBO9SeBaLSCa7JMPQwl6qoBycrAGel0aEEQY4ojBPoTByqgcdGEa+5eFtBO
 C1K0QklFQ7sZoOv/ezfujtPNpCnHeX2S8rV/tcqBlDBGsuW4U46iRsrl1/WyDnM4qPMHmZfJj4
 EODFINrLFqqWd1i/G+s6/oBQe/8lvgAAAA=
To: Thomas Gleixner <tglx@linutronix.de>, 
 Peter Zijlstra <peterz@infradead.org>, Huacai Chen <chenhuacai@kernel.org>, 
 WANG Xuerui <kernel@xen0n.name>
Cc: linux-kernel@vger.kernel.org, loongarch@lists.linux.dev, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1397;
 i=jiaxun.yang@flygoat.com; h=from:subject:message-id;
 bh=tk5TMmuul2lboVBVIaOCJWUBH1Nrg+wwCKaNSNGbwcM=;
 b=owGbwMvMwCXmXMhTe71c8zDjabUkhrRpDelMPqdMJ7xzzXl/9+e04z15ZXfltuxp072yaN/65
 zwvpjl1dZSyMIhxMciKKbKECCj1bWi8uOD6g6w/MHNYmUCGMHBxCsBEJrIxMmyZ8Fk1v1o7uLeC
 pcXkS+jz0hMbHIu/8DxTPOi42EzXLZyR4ca+KN3pM2PCOVj5TpaszWde6OTDWdt9c/ZJZo2WyvN
 RrAA=
X-Developer-Key: i=jiaxun.yang@flygoat.com; a=openpgp;
 fpr=980379BEFEBFBF477EA04EF9C111949073FC0F67

Hi all,

This series implemented CPU parallel bring up for LoongArch.

Being the first non-x86 arch enabling that we need to fix some
infra in patch 1 and 2, then implement everything in patch 3.

Please review.
Thanks

Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
---
Changes in v3:
- Commit message improvemente
- Remove unnecessary indirection
- Link to v2: https://lore.kernel.org/r/20240715-loongarch-hotplug-v2-0-7d18b3d46b11@flygoat.com

Changes in v2:
- Use stub functions (tglx)
- Link to v1: https://lore.kernel.org/r/20240705-loongarch-hotplug-v1-0-67d9c4709aa9@flygoat.com

---
Jiaxun Yang (3):
      cpu/hotplug: Make HOTPLUG_PARALLEL independent of HOTPLUG_SMT
      cpu/hotplug: Weak fallback for arch_cpuhp_init_parallel_bringup
      LoongArch: SMP: Implement parallel CPU bring up

 arch/loongarch/Kconfig              |  1 +
 arch/loongarch/include/asm/smp.h    |  6 -----
 arch/loongarch/kernel/asm-offsets.c | 10 ---------
 arch/loongarch/kernel/head.S        |  7 +++---
 arch/loongarch/kernel/smp.c         | 44 ++++++++-----------------------------
 kernel/cpu.c                        | 16 ++++++++++++++
 6 files changed, 30 insertions(+), 54 deletions(-)
---
base-commit: 82e4255305c554b0bb18b7ccf2db86041b4c8b6e
change-id: 20240704-loongarch-hotplug-3f8826b88a43

Best regards,
-- 
Jiaxun Yang <jiaxun.yang@flygoat.com>


