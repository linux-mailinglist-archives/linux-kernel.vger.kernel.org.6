Return-Path: <linux-kernel+bounces-396762-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DC389BD1A9
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 17:07:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 153FC1F2508E
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 16:07:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F07E1552F6;
	Tue,  5 Nov 2024 16:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B+Es4OV1"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F016214A611
	for <linux-kernel@vger.kernel.org>; Tue,  5 Nov 2024 16:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730822557; cv=none; b=ByDIENQMU8AwEr9JcZzOrvXMcbYN8XdQIjoMf7C7kqzZMV4SWG9m3eZRqGWAlAgkxFYI0v8Xh6qGX4LrhjCVTsV77OacfJFIFp9mrz18gcluPIF6L0decMbMn36Hv2JjHjWbzn/Gl2y61r7h+y52FRIhzTFdMkOfWGe76SeCYpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730822557; c=relaxed/simple;
	bh=+wjTb5EAf83BU1XBVX7cxBJ5K+SZjCVgKtHkbTvoOM4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dQu6BJKwFg6o5OcpYqSrQw3lb3DcTEoLgExpn68y62GftWmD2l71p+IoCfPmVNKJm857MeBIwzsiQdYlFBJLxyMfMWpJoPU42x4JbaXug03Ll6a/CS5HaoNFJbslfIRWbvqL9ywdNbjw6WvvmX0zktoBzcqa62UthNboT1yIn1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B+Es4OV1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65AB0C4CECF;
	Tue,  5 Nov 2024 16:02:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730822556;
	bh=+wjTb5EAf83BU1XBVX7cxBJ5K+SZjCVgKtHkbTvoOM4=;
	h=From:To:Cc:Subject:Date:From;
	b=B+Es4OV1gaz1oJtjLLDBR0mjLgzTwLOBIlL4uDqZmi+QB+qRUvpF87rJmryqjexGN
	 biA5D+8NMwJvdOLR46rsoe6bp3GKGb89f6VHtFtOLgroc8dr+s4kVy0hhiJ7thOx+9
	 3TWxmuwS1eDUe9yDAabHUpziDI9AG1Mic8ybnnw693lMIzROrfWNU8JZAsBEuxr0fg
	 qAcS1N7RereO73dJu5AUF+52dklcI5vfAxG2k8a31Wz+JMbqiGGz6eG0MD9J+/efvb
	 Y/b+QWJ9BWjHBu2sui9594ZFUneFKixFk79mYwOB1dGBjWwj1LI6P4EmIZMHVpnLyL
	 mq1usV0HO1ciw==
From: Mario Limonciello <superm1@kernel.org>
To: Borislav Petkov <bp@alien8.de>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org (maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)),
	"H . Peter Anvin" <hpa@zytor.com>,
	Nikolay Borisov <nik.borisov@suse.com>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Brijesh Singh <brijesh.singh@amd.com>,
	linux-kernel@vger.kernel.org (open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)),
	Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH] x86/CPU/AMD: Clear virtualized VMLOAD/VMSAVE on Zen4 client
Date: Tue,  5 Nov 2024 10:02:34 -0600
Message-ID: <20241105160234.1300702-1-superm1@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mario Limonciello <mario.limonciello@amd.com>

A number of Zen4 client SoCs advertise the ability to use virtualized
VMLOAD/VMSAVE, but using these instructions is reported to be a cause
of a random host reboot.

These instructions aren't intended to be advertised on Zen4 client
so clear the capability.

Cc: stable@vger.kernel.org
Link: https://bugzilla.kernel.org/show_bug.cgi?id=219009
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 arch/x86/kernel/cpu/amd.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/x86/kernel/cpu/amd.c b/arch/x86/kernel/cpu/amd.c
index 015971adadfc7..ecd42c2b3242e 100644
--- a/arch/x86/kernel/cpu/amd.c
+++ b/arch/x86/kernel/cpu/amd.c
@@ -924,6 +924,17 @@ static void init_amd_zen4(struct cpuinfo_x86 *c)
 {
 	if (!cpu_has(c, X86_FEATURE_HYPERVISOR))
 		msr_set_bit(MSR_ZEN4_BP_CFG, MSR_ZEN4_BP_CFG_SHARED_BTB_FIX_BIT);
+
+	/*
+	 * These Zen4 SoCs advertise support for virtualized VMLOAD/VMSAVE
+	 * in some BIOS versions but they can lead to random host reboots.
+	 */
+	switch (c->x86_model) {
+	case 0x18 ... 0x1f:
+	case 0x60 ... 0x7f:
+		clear_cpu_cap(c, X86_FEATURE_V_VMSAVE_VMLOAD);
+		break;
+	}
 }
 
 static void init_amd_zen5(struct cpuinfo_x86 *c)
-- 
2.43.0


