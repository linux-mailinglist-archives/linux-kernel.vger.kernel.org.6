Return-Path: <linux-kernel+bounces-386597-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 403469B459B
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 10:23:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E9EEE1F2190E
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 09:23:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C14F71E102D;
	Tue, 29 Oct 2024 09:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wmfor0SW"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 294351E0DE1
	for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 09:23:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730193815; cv=none; b=OuSib9mq/wosIqOUfGEqvn2n4noLvqpsma5lalOme+qHFZ1qHhQ4svCBHFeh8WMcwVxJuBMNDmyqWrUYOxAmYxiXoricPMrTWW828/W58001d3Ka3H1ZyD2y+qMBeB1oK0MJijLaAxXLrjJo0VMWv8PzPK2q0wVIJ9JMHgvg6wM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730193815; c=relaxed/simple;
	bh=0pDD/qKzHXHs+No9iGp2bHGSwuvI7K6vrHmd7+BRnZA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Srn4Iz4HuNIauWGKfnPkzGoC+g/XTFeOmkoatWcRV4QR9Ya7yDUyHBuDMhd8X9x+vkXypqo27XLOdgxLIfL4blJbAkKn0KqxjNxwi03K0Gn8s8KdkRn7YUmuVfyJ208k9g4/hF0OPsOaGxINUihZBLJa/20NqPg89JfmWYsPQjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wmfor0SW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB0CAC4CECD;
	Tue, 29 Oct 2024 09:23:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730193814;
	bh=0pDD/qKzHXHs+No9iGp2bHGSwuvI7K6vrHmd7+BRnZA=;
	h=From:To:Cc:Subject:Date:From;
	b=Wmfor0SWM9YB25lRSj9Vr9Azb8CUkxKzn4vlIf+alTGJKl1Mx/nqVaHAV6hwow05r
	 SpiGKPT+oFJyPmQiFlTIP+N/7Ur6vpA3D9nUz1iII5cmYnyNcjF3Uv1XHAiyrJRfdq
	 Qb7hDrLP02B3o8/pzKwvZXY07UgyI79C488lf6huDkfmJRWu/4F+poL8oVseStNOeT
	 6AAKP/yzCrqKR0qKyrsR4vrjDEQihCfltiVBTPM3F2JE2amMLIcn/H4L28smRb2KvQ
	 wlCDGuJBc6o6xHquc/oN4ZAXJwLjAjZsxr03f/jSC+AtWSYyIKVjhHRWjvL1FUp0FJ
	 2Vq5ll05iW07Q==
From: Arnd Bergmann <arnd@kernel.org>
To: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Yazen Ghannam <yazen.ghannam@amd.com>,
	Suma Hegde <suma.hegde@amd.com>,
	Naveen Krishna Chatradhi <naveenkrishna.chatradhi@amd.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] platform/x86/amd/hsmp: fix compile-testing without CONFiG_AMD_NB
Date: Tue, 29 Oct 2024 09:23:20 +0000
Message-Id: <20241029092329.3857004-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

node_to_amd_nb() is defined to NULL in non-AMD configs:

drivers/platform/x86/amd/hsmp/plat.c: In function 'init_platform_device':
drivers/platform/x86/amd/hsmp/plat.c:165:68: error: dereferencing 'void *' pointer [-Werror]
  165 |                 sock->root                      = node_to_amd_nb(i)->root;
      |                                                                    ^~
drivers/platform/x86/amd/hsmp/plat.c:165:68: error: request for member 'root' in something not a structure or union

Change the definition to something that builds. This does introduce a
NULL pointer dereference but the code is never called since the driver
won't probe successfully.

Fixes: 7d3135d16356 ("platform/x86/amd/hsmp: Create separate ACPI, plat and common drivers")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/x86/include/asm/amd_nb.h | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/amd_nb.h b/arch/x86/include/asm/amd_nb.h
index 6f3b6aef47ba..d0caac26533f 100644
--- a/arch/x86/include/asm/amd_nb.h
+++ b/arch/x86/include/asm/amd_nb.h
@@ -116,7 +116,10 @@ static inline bool amd_gart_present(void)
 
 #define amd_nb_num(x)		0
 #define amd_nb_has_feature(x)	false
-#define node_to_amd_nb(x)	NULL
+static inline struct amd_northbridge *node_to_amd_nb(int node)
+{
+	return NULL;
+}
 #define amd_gart_present(x)	false
 
 #endif
-- 
2.39.5


