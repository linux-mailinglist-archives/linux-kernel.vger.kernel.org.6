Return-Path: <linux-kernel+bounces-209845-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC5EF903BC2
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 14:21:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 53024B231AC
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 12:21:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BED4C17C201;
	Tue, 11 Jun 2024 12:21:18 +0000 (UTC)
Received: from szxga06-in.huawei.com (szxga06-in.huawei.com [45.249.212.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 885C117623D
	for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 12:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718108478; cv=none; b=VJigLO2t/xffqahVX6ZbCefxGR1JW9mVXCyRsXybgoDyjMJ+VGKAgtOcN5YaEH8yaXlyIEun28fhSdqQfhpVl+kUz19Px8j9HQeLOOAR3ZL+MOohWqYw1S4OI1Bm1sPw7pwiSGhbm3HQt1sR11RWfgZIW9rTXJcjcOUqxmm0yuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718108478; c=relaxed/simple;
	bh=j2kFCTc+IqtiC8E0F9sbwks2G9uj4Xig7u/w2y6v2i0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=MkAPPxemRYFveyzYEfdmRCAKJ9onEmAHA4tPwPRj6iPpiK7qVHrDn8KTVGCeDr+u74LaDvdlITr4MncRBY/2n1cwC47NVX4+Z465zmItl8degD0BJZiE4R+Nd7+GX6rPFjAAf6Qp4SlhoDfw+vZR94DHaZY4UEBlYbOp9i35NSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4Vz75r2PLZz29dsF;
	Tue, 11 Jun 2024 20:19:44 +0800 (CST)
Received: from kwepemd500014.china.huawei.com (unknown [7.221.188.63])
	by mail.maildlp.com (Postfix) with ESMTPS id 3114814022E;
	Tue, 11 Jun 2024 20:21:07 +0800 (CST)
Received: from 228-1616.huawei.com (10.67.246.68) by
 kwepemd500014.china.huawei.com (7.221.188.63) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Tue, 11 Jun 2024 20:21:06 +0800
From: Nianyao Tang <tangnianyao@huawei.com>
To: <maz@kernel.org>, <catalin.marinas@arm.com>, <will@kernel.org>,
	<mark.rutland@arm.com>, <oliver.upton@linux.dev>, <broonie@kernel.org>,
	<ardb@kernel.org>, <joey.gouly@arm.com>, <ryan.roberts@arm.com>,
	<jeremy.linton@arm.com>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>
CC: <tangnianyao@huawei.com>, <guoyang2@huawei.com>
Subject: [PATCH] arm64/cpufeatures/kvm: Add ARMv8.9 FEAT_ECBHB bits in ID_AA64MMFR1 register
Date: Tue, 11 Jun 2024 12:20:49 +0000
Message-ID: <20240611122049.2758600-1-tangnianyao@huawei.com>
X-Mailer: git-send-email 2.30.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemd500014.china.huawei.com (7.221.188.63)

Enable ECBHB bits in ID_AA64MMFR1 register as per ARM DDI 0487K.a
specification.

When guest OS read ID_AA64MMFR1_EL1, kvm emulate this reg using
ftr_id_aa64mmfr1 and always return ID_AA64MMFR1_EL1.ECBHB=0 to guest.
It results in guest syscall jump to tramp ventry, which is not needed
in implementation with ID_AA64MMFR1_EL1.ECBHB=1.
Let's make the guest syscall process the same as the host.

Signed-off-by: Nianyao Tang <tangnianyao@huawei.com>
---
 arch/arm64/kernel/cpufeature.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index 48e7029f1054..c3913c90797e 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -429,6 +429,7 @@ static const struct arm64_ftr_bits ftr_id_aa64mmfr0[] = {
 };
 
 static const struct arm64_ftr_bits ftr_id_aa64mmfr1[] = {
+	ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_LOWER_SAFE, ID_AA64MMFR1_EL1_ECBHB_SHIFT, 4, 0),
 	ARM64_FTR_BITS(FTR_HIDDEN, FTR_NONSTRICT, FTR_LOWER_SAFE, ID_AA64MMFR1_EL1_TIDCP1_SHIFT, 4, 0),
 	ARM64_FTR_BITS(FTR_VISIBLE, FTR_STRICT, FTR_LOWER_SAFE, ID_AA64MMFR1_EL1_AFP_SHIFT, 4, 0),
 	ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_LOWER_SAFE, ID_AA64MMFR1_EL1_HCX_SHIFT, 4, 0),
-- 
2.30.0


