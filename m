Return-Path: <linux-kernel+bounces-362074-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 21CE999B091
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Oct 2024 06:00:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D837228375F
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Oct 2024 04:00:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 940B7126C02;
	Sat, 12 Oct 2024 04:00:53 +0000 (UTC)
Received: from smtpbg154.qq.com (smtpbg154.qq.com [15.184.224.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5560583A17
	for <linux-kernel@vger.kernel.org>; Sat, 12 Oct 2024 04:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=15.184.224.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728705653; cv=none; b=PW/O3gHSIf33Q9g1uVhlm+V58k2jm0ckeW4ZCxsz3dZVrHEAWMPwdmoWl5pmO9D9bHxeSjY4BxAT/7mPlTLkWAn8qzjStVh5s6EouepIzYw/EVXS0+JRHze7DON8Jyd67UhMsCe+IpgC6ZSaH7Fnc4pG1LiQVPSPnosvZCq2waA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728705653; c=relaxed/simple;
	bh=n66PREUZe5sBsGJvC/ADrLsD+s0ZPK7C/kcYlrLntdY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AH9Vod2rhXjIcnV0YhsZNG4YP5sws4pW5omVvq7ExwdQ8R+kYF76MptVuPCZWm82zvLxhABs9k5LZSVZcEHiwnFrnZdiaTzaS1wzJ6Jtkzg85yY52eh96py4Y6l05or4tcUo0wczUH0r+CtuzPK5Lscj5ZXUcIrgBeGF2v88aYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shingroup.cn; spf=pass smtp.mailfrom=shingroup.cn; arc=none smtp.client-ip=15.184.224.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shingroup.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shingroup.cn
X-QQ-mid: bizesmtpsz3t1728705582tk7m42q
X-QQ-Originating-IP: nay6J2rnSh8/fr9ad6cH/OzGHRpt+W0/xSrLa82pQw8=
Received: from HX09040029.powercore.com.cn ( [180.171.104.254])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Sat, 12 Oct 2024 11:59:41 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 6882828675209662917
From: Luming Yu <luming.yu@shingroup.cn>
To: linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	mpe@ellerman.id.au,
	npiggin@gmail.com,
	christophe.leroy@csgroup.eu,
	jialong.yang@shingroup.cn,
	luming.yu@gmail.com
Cc: Luming Yu <luming.yu@shingroup.cn>
Subject: [PATCH 4/7] powerpc/debug: hook to user return notifier infrastructure
Date: Sat, 12 Oct 2024 11:56:18 +0800
Message-ID: <557E9D5F2DDB7601+20241012035621.1245-6-luming.yu@shingroup.cn>
X-Mailer: git-send-email 2.42.0.windows.2
In-Reply-To: <20241012035621.1245-3-luming.yu@shingroup.cn>
References: <20241012035621.1245-3-luming.yu@shingroup.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtpsz:shingroup.cn:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: NMGzQWUSIfvTBNmgq298LwTJNBU4hR70Xkg0x2ylvLYoEQCMsw9ueXM7
	ym7lVkc/kI0G+6tgujj7ivyQcdnrjO0G9U99b/LlrVyHhaKJUIZmxvdDEzGVzoaYInkycc0
	LoSpyG9If6hcN/4ye/xnxfhSzbEF30B3nVsf8x4rtB/4RGHm+0j7KqFfs5JINp4gR6YFoBG
	g+wDTN6uCMXYPXlo4IPVcPegwrbYZoZOFGqxZZwNUoPAJtrXg5XmM1Q1jZFyZd/7OjZfQqy
	w48orhfcMNYAq4Nnsv5aQM/bzNaOiFshFaS9mrwb1oO8+VtaX7oYqN0XTMuj03uK7dpcXwp
	SK3dXFsbSc1IX1V+ae0Txl+ZIhdnGl/AcROxu+ANP59x5aGPGKm3smdG9D6H/P8b86FRZUM
	av4fftUN5paBkc7V4ISvS7BoHJFDw4eNfrutPP48MCC0BmaTEdlNGCZkR1wVlMPzfhPNJd3
	o0Efnm1dub4UUu5GddbNUpkXBe7PFRT+KeK3VTpncIaRu3E8AZ7qi+JN53JhLAB/sAZaBrY
	j5HonQowZcE0utOPxNJIcFnQAYuQ3+SoBkvJBGPFuexmm0sksfdnnjyWyEn15CRihBUqDKb
	+f3vU1dKeMP6FpfiymECdcybULv2Qwb0g7mq9i78l59+B8LO3kGeuDEGD4LOX7ZxoJ3E9Dh
	vtsGglwh5Z0g/ESZHByKBetXsWdW70eplaaHMPsPtH1A5fX2s3c0zfFdamLPDhJ+qsxfkMT
	MTq43jzw6NHBMcxHumCYIBWuyOE1KXUkSMjVEHnMmsDo33Wr6foUIiVMX0NsCtzHqaaJRap
	pwwJn8YfG4QOwF7H7OOqPLdzodTUKFZ8Tp/hOWoKsz0ccWu5ptxBLII41sb/t8RksxeqL3e
	C4xOKUOzxEzdygluXPcxUXtUkd1EQxtxrsOqKpJWNJJXb2GZ2lhRLTfzQgT60neYPYGvzA2
	Yy9tluX495W3XFL/1CcP8lKwoOrZV7AdRYzjGDS6MId6UEQ==
X-QQ-XMRINFO: MSVp+SPm3vtS1Vd6Y4Mggwc=
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


