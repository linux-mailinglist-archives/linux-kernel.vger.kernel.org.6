Return-Path: <linux-kernel+bounces-403538-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CED8B9C36FC
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 04:23:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 872132819BC
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 03:23:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BACE14658F;
	Mon, 11 Nov 2024 03:23:12 +0000 (UTC)
Received: from smtpbg150.qq.com (smtpbg150.qq.com [18.132.163.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B7372C18C
	for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2024 03:23:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.132.163.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731295391; cv=none; b=EMTMRDox4GE6xL+Ou0OMrerkWt+KoQf4Hh+8bIUclGpnMd+8y3Slq7d0ZpVQEoX6Kq8u6gNYnwvv1HJST5Izs+V+5p4mpR24Tg6H+q7vohLcCOfRj6tru5wCy9pBm7qjB4iEQH7jLvrBptOZ45BByiI2wcb78+AB0hcfYeQSG8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731295391; c=relaxed/simple;
	bh=n66PREUZe5sBsGJvC/ADrLsD+s0ZPK7C/kcYlrLntdY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hGnNK55/amw41agJbdf3/AmDspuiNBdg2Ruu4N6O2leGhRlklPcqhMPWb4/7ca002Xka/jqWuhR2reyF+0gGWbKXxJNbLlrBptun8qQ4UKJp1p/CuOf6TPGf9Umpb5jgV+b4+S0VclVMa9scHWstkNycdMHvfF2x5I3Qofm1/Ck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shingroup.cn; spf=pass smtp.mailfrom=shingroup.cn; arc=none smtp.client-ip=18.132.163.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shingroup.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shingroup.cn
X-QQ-mid: bizesmtpsz5t1731295321typ3e2q
X-QQ-Originating-IP: ofFtZ1fxMvOEsrfXFBQDQFF1hbpHJHJxVxCs/vPXlOc=
Received: from HX09040029.powercore.com.cn ( [116.233.136.127])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 11 Nov 2024 11:21:46 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 1828540669171451381
From: Luming Yu <luming.yu@shingroup.cn>
To: linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	mpe@ellerman.id.au,
	npiggin@gmail.com,
	christophe.leroy@csgroup.eu,
	luming.yu@gmail.com
Cc: Luming Yu <luming.yu@shingroup.cn>
Subject: [PATCH v2 4/8] powerpc/debug: hook to user return notifier infrastructure
Date: Mon, 11 Nov 2024 11:19:32 +0800
Message-ID: <C6F501DF61F2B5B0+20241111031934.1579-8-luming.yu@shingroup.cn>
X-Mailer: git-send-email 2.42.0.windows.2
In-Reply-To: <20241111031934.1579-2-luming.yu@shingroup.cn>
References: <20241111031934.1579-2-luming.yu@shingroup.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtpsz:shingroup.cn:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: Macl0gWiWu4ePjFBT404aWJMhJ/w32LwXi3H18Zl9fH1DSw5ayl/UCzJ
	oYDFFCJhfU1iVJ5mermE3b1zSAvlpvksDkvHfTFpcnTBtn0HwlWMxXZKptHPArIaAyX6pc2
	JdHU9RqSxMi6bDVPT7DYgN+H9q3mW/cvQ1mrD1krvfVXcw1KtwExuf28Qw9qPoegH75850H
	GLSYE30mRkGofaeO1gSn3/RT6c4IyOcz8wb1KejFSHz4MB3argHth/Un5Zaq0hZRvXnGk4t
	wCp738exAmJG1Z+2WtYXVA8kaNHA184w8t8gz8uQCDfTAQD9thRpxBT4DldpRsIvM+ZYZ8Q
	uGHuRxGHzW82k0eoiIcXqzSfOK9K+jL5/xqvs/78hGdfrusFAaIA+xbsRapmUk/HLvQMBxM
	7RT0N5sSRjCXH1GsAY2MI9QkMguFAPt3oK3X5X4BxSbN8c4VsQFCZA3F+m0jcmnTAugkzCC
	FlBkhfNQ/JnE6ImllitPTfYMaMh7y1hNfACQjFjyiMVdUmLTy+ro4fVdcZlks5MWeXUJpK7
	PwvpaOT90WH/0iAgk7LqMC+XghZzX4NCmPIuZYkJtNcELFqq6uuRdGb3n58fdLv2voRB8r9
	sk1XvKNP8WHpxl9y56eU7OCXNWsdzdQPXuSo1RNGKj6CyH8fOE87oEZuyzhUn8eOZ1X36Fd
	Gaoky3W90TiF5Diz1fdhMcNMmT5lYVrofiI/mxXQjo/ZcO5y7vYrt3Vm8bVMw91zPlDwL11
	oGE62ejdBSb4GVgc7kU1/Ld59cD3so9iwlUERBj/X3VkJtTNriAcG1kYBZt/TrU7z7wz3F5
	NON5oEcyRhdnUT7QlXC9F9ZmLojMvygHHV8VC64mkaB40ksxQDQ9nJNw9RaNyhL5j68mto5
	tmlbT4UpMU0avasAyqKdVt3qK0NSOxFPQoAiJlEGIp4xc1VzYBVnuTQXed09M3KU2TCmAXk
	nqxOLB3Ohtoe0jpqfeZQGXFXIoVSDTFhIIM7fRXm8rjN520JsWKpk0jQF
X-QQ-XMRINFO: OD9hHCdaPRBwq3WW+NvGbIU=
X-QQ-RECHKSPAM: 0

calls back to all registered user return notifier functions.

Signed-off-by: Luming Yu <luming.yu@shingroup.cn>
---
 arch/powerpc/kernel/interrupt.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/powerpc/kernel/interrupt.c b/arch/powerpc/kernel/interrupt.c
index 8c532cecbc60..609ba48034de 100644
--- a/arch/powerpc/kernel/interrupt.c
+++ b/arch/powerpc/kernel/interrupt.c
@@ -19,6 +19,7 @@
 #include <asm/time.h>
 #include <asm/tm.h>
 #include <asm/unistd.h>
+#include <asm/entry-common.h>
 
 #if defined(CONFIG_PPC_ADV_DEBUG_REGS) && defined(CONFIG_PPC32)
 unsigned long global_dbcr0[NR_CPUS];
@@ -245,6 +246,8 @@ interrupt_exit_user_prepare_main(unsigned long ret, struct pt_regs *regs)
 	/* Restore user access locks last */
 	kuap_user_restore(regs);
 
+	arch_exit_to_user_mode_prepare(regs, ti_flags);
+
 	return ret;
 }
 
-- 
2.42.0.windows.2


