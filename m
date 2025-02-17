Return-Path: <linux-kernel+bounces-518460-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A668EA38F84
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 00:18:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 96A0D1890960
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 23:18:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 393121AF0C0;
	Mon, 17 Feb 2025 23:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hVjsIu+Z"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 950901AE01C;
	Mon, 17 Feb 2025 23:18:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739834283; cv=none; b=BYxkVbd7uDs/B286EPqmLt7R75XJuyBXmNjUIRtGN1TTBoHdaideVnVbb4fZT4zYXyiu+xyqOQ+HrXtPKQaWV9kAPgaPT7NByLlhiGu7Iu2yrhWYvo15TodBDN81b4Hx1syJvK6Oq/iPva90PShttg/yEXZesSpsm9/v0XayYNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739834283; c=relaxed/simple;
	bh=euxvD6yIxhjBOEu1HF06JzVE8wLldDYNfDpJHlqO/58=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Bo6O98z0GrGo/veKhCF1NzwH/JCjuTP/+BeM3JXv9x+Ict9943JmUjAy4nvHR0COCKNhTQ2XN+rWuEjOQlKSPSDQ0lVKAzBl6MHbjCF7VE2OEBZ9e2UvHM9XMklUQwpaj05k11RyYYSQ+o72VjIFX0UG6noUmgHSe49pHRZJiUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hVjsIu+Z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1E4AC4CEE8;
	Mon, 17 Feb 2025 23:18:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739834283;
	bh=euxvD6yIxhjBOEu1HF06JzVE8wLldDYNfDpJHlqO/58=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hVjsIu+ZThFc1+tad0AKiQVaRUAKG6+ePgdobuBw5FGsE55GBVCZJHeT43N8eERaY
	 OEafDR7c3o9p4eT/4z4s9xdOK6APLO+t6ljLEbATgoP43Mo8CF0iAiW4F3g/qcpiR1
	 sT2v8OOt3G/e8wTWnlvv9fOCHxDc7lM+jjE4LZY9y9mB4NV5XNuZXbuxMPBl3Y3OoV
	 zvgods4PpId6LAKHqEqUx5XE8gGSjXz9p5T8JVye6Wwi0oQg+21f6fHrpXrly95HXD
	 1tj1piKxYE9pYbva0dOClP6RPgP8F6bT5LpBJpfRt99C17LYpzJeZ3lZJBg08QqqJa
	 5BtTyAki+T0Zg==
From: Mario Limonciello <superm1@kernel.org>
To: Yazen Ghannam <yazen.ghannam@amd.com>,
	Borislav Petkov <bp@alien8.de>,
	Mark Brown <broonie@kernel.org>
Cc: Mario Limonciello <mario.limonciello@amd.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org (maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)),
	"H . Peter Anvin" <hpa@zytor.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
	Bard Liao <yung-chuan.liao@linux.intel.com>,
	Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
	Daniel Baluta <daniel.baluta@nxp.com>,
	Kai Vehmanen <kai.vehmanen@linux.intel.com>,
	Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>,
	Vijendar Mukunda <Vijendar.Mukunda@amd.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Jeff Johnson <quic_jjohnson@quicinc.com>,
	Venkata Prasad Potturu <venkataprasad.potturu@amd.com>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	linux-kernel@vger.kernel.org (open list:AMD NODE DRIVER),
	linux-sound@vger.kernel.org (open list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM...),
	sound-open-firmware@alsa-project.org (moderated list:SOUND - SOUND OPEN FIRMWARE (SOF) DRIVERS)
Subject: [PATCH 1/7] x86/amd_node: Add a helper for use with `read_poll_timeout`
Date: Mon, 17 Feb 2025 17:17:41 -0600
Message-ID: <20250217231747.1656228-2-superm1@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250217231747.1656228-1-superm1@kernel.org>
References: <20250217231747.1656228-1-superm1@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mario Limonciello <mario.limonciello@amd.com>

Some of the ACP drivers will poll registers through SMN using
`read_poll_timeout` which requires returning the result of the register
read as the argument.

Add a helper to do just that.

Tested by: Venkata Prasad Potturu <venkataprasad.potturu@amd.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 arch/x86/include/asm/amd_node.h | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/x86/include/asm/amd_node.h b/arch/x86/include/asm/amd_node.h
index 113ad3e8ee40a..9f3f613366f7d 100644
--- a/arch/x86/include/asm/amd_node.h
+++ b/arch/x86/include/asm/amd_node.h
@@ -33,4 +33,15 @@ static inline u16 amd_num_nodes(void)
 int __must_check amd_smn_read(u16 node, u32 address, u32 *value);
 int __must_check amd_smn_write(u16 node, u32 address, u32 value);
 
+/* helper for use with read_poll_timeout */
+static inline int smn_read_register(u32 reg)
+{
+	int data, rc;
+
+	rc = amd_smn_read(0, reg, &data);
+	if (rc)
+		return rc;
+
+	return data;
+}
 #endif /*_ASM_X86_AMD_NODE_H_*/
-- 
2.43.0


