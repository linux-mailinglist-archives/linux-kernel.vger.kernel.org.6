Return-Path: <linux-kernel+bounces-577042-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D3DE9A7179F
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 14:36:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 26D807A46D7
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 13:34:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 931331EA7E5;
	Wed, 26 Mar 2025 13:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="VFG1W4wY"
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04B021E51F4
	for <linux-kernel@vger.kernel.org>; Wed, 26 Mar 2025 13:35:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742996156; cv=none; b=d9zqfkwGgk4/u8r15HrQIok4/pw3KcYAof6Z9PDa86TbkCYxMQfVW6OTL0wxIK2HW/bgLHyvWiGaXaOcjMswNC+Qjq9ABLIgFmGAVWUHDil+FmQsyMuNV3T2nbM9CvLKkwaeVaFctJSDMQbNPiX5GijQCP1mr00MOFPGKRBnHKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742996156; c=relaxed/simple;
	bh=QvyNPIKC6h7CfTVAQdKtHp20GHfUmZER2oeO6mERLeo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sXZ7OVSPliezEY/pbt+RQd/i+Fsijt2dmyD8DPHhpIbINOJoLttIM90+MdFuEVgjy2b7VWK/ToOk87EfZwF/BDw74nyoNex87Rz1SbLO41U/XsEXY8kgmjaJZea0m1OccLQcOW3ZkxvVRg6CmWOPFehqJmC5RzLQvJJjvVhbPV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=VFG1W4wY; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:
	Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=8iaf9ro/LaoaqS0DXSj6YpmMhISALf3u5gefIdzEOO8=; b=VFG1W4wY9CohezqY6dqQJKgcgf
	vaddf2QGhhZodLX8lwBWM60J9IKaR+A1FT+ytvDlDnzo1jqxEPfM9/ciEJd/yxc4dHTjB8K6w2EMY
	pYhfGNYFeSiKwhDHRYqL9GXlIazCmLgwngUaivHI4cMPIgmJ+Lme1JDQt414cJPv3jqD2G+91hSIi
	6sBKrO3ud5GlF+7+FlTssFG5RfOF32qqY1vRkl4xE3SZlJpSl9FuPYaZpD3DdorH9lOCkXIN+9j4D
	3nHhHO2d+fycJFOdMtOTNDuSdygDNYfIEF2LvsS404O8AxAwLPTI5F6O6p2tvDa+H2crG7Oj/9ZZ9
	xzmaaxXA==;
Received: from i59f7adba.versanet.de ([89.247.173.186] helo=localhost.localdomain)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1txQuu-006mop-6e; Wed, 26 Mar 2025 14:35:36 +0100
From: Angelos Oikonomopoulos <angelos@igalia.com>
To: linux-arm-kernel@lists.infradead.org
Cc: catalin.marinas@arm.com,
	will@kernel.org,
	linux-kernel@vger.kernel.org,
	kernel-dev@igalia.com,
	Angelos Oikonomopoulos <angelos@igalia.com>
Subject: [PATCH] arm64: Don't call NULL in do_compat_alignment_fixup
Date: Wed, 26 Mar 2025 14:35:21 +0100
Message-ID: <20250326133521.13637-1-angelos@igalia.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

do_alignment_t32_to_handler only fixes up alignment faults for specific
instructions; it returns NULL otherwise. When that's the case, signal to
the caller that it needs to proceed with the regular alignment fault
handling (i.e. SIGBUS).

Signed-off-by: Angelos Oikonomopoulos <angelos@igalia.com>
---
 arch/arm64/kernel/compat_alignment.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/kernel/compat_alignment.c b/arch/arm64/kernel/compat_alignment.c
index deff21bfa680..76cf1c1b5bc6 100644
--- a/arch/arm64/kernel/compat_alignment.c
+++ b/arch/arm64/kernel/compat_alignment.c
@@ -34,7 +34,7 @@
 
 #define REGMASK_BITS(i)	(i & 0xffff)
 
-#define BAD_INSTR 	0xdeadc0de
+#define BAD_INSTR	0xdeadc0de
 
 /* Thumb-2 32 bit format per ARMv7 DDI0406A A6.3, either f800h,e800h,f800h */
 #define IS_T32(hi16) \
@@ -368,6 +368,8 @@ int do_compat_alignment_fixup(unsigned long addr, struct pt_regs *regs)
 		return 1;
 	}
 
+	if (!handler)
+		return 1;
 	type = handler(addr, instr, regs);
 
 	if (type == TYPE_ERROR || type == TYPE_FAULT)
-- 
2.49.0


