Return-Path: <linux-kernel+bounces-575275-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EBDEA6FAC9
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 13:11:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6415D16DBA7
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 12:11:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15566256C74;
	Tue, 25 Mar 2025 12:11:35 +0000 (UTC)
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DADFC254B1B
	for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 12:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742904694; cv=none; b=NWWHcCASN6sPCWL/Xm66pkL01m3NxxD+na3S1UILmKTHbwMW8qUiOi9/o7v5dK2Vnxz+pUr9hSlH1ZDC8SO26bER7j10WRZ1JgPvQn9KEOk3XiYYTI1EqMXyGE2rSY8oKcThUvjCW4rz8BRDPdSXjAipgJU5THVDTVellk3iGpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742904694; c=relaxed/simple;
	bh=DEC5ifR+Mt8gyk9Zce/fh7iv6TUCsXEt+U7XN+jEuvU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=s0SHgN9DdMbUve/QeVS+g58Vg4wb3YH5UZ4cyT388ArEEtu6rxWdoM1Am7Euq4J3B1TNOxzF98HTBz+192YvLADQ2lwQI3US0k9osL1/toQ37u7mIzZI01r8g1spyfoKGL6wKI2W2gZxpzZErX1ZJ9raIWR3ZrTTVj1H4b3z5ro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4ZMTG54bqgzHrFd;
	Tue, 25 Mar 2025 20:08:13 +0800 (CST)
Received: from kwepemg100001.china.huawei.com (unknown [7.202.181.18])
	by mail.maildlp.com (Postfix) with ESMTPS id 72AC618006C;
	Tue, 25 Mar 2025 20:11:30 +0800 (CST)
Received: from huawei.com (10.50.165.33) by kwepemg100001.china.huawei.com
 (7.202.181.18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 25 Mar
 2025 20:11:29 +0800
From: Jinqian Yang <yangjinqian1@huawei.com>
To: <maz@kernel.org>, <oliver.upton@linux.dev>, <yuzenghui@huawei.com>
CC: <linux-arm-kernel@lists.infradead.org>, <kvmarm@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <wangzhou1@hisilicon.com>,
	<shameerali.kolothum.thodi@huawei.com>, <liuyonglong@huawei.com>,
	<jiangkunkun@huawei.com>, <yangjinqian1@huawei.com>
Subject: [PATCH] KVM: arm64: Make HCX writable from userspace
Date: Tue, 25 Mar 2025 20:11:26 +0800
Message-ID: <20250325121126.1380681-1-yangjinqian1@huawei.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemg100001.china.huawei.com (7.202.181.18)

Allow userspace to modify guest visible value for HCX in
ID_AA64MMFR1_EL1.

Signed-off-by: Jinqian Yang <yangjinqian1@huawei.com>
---
 arch/arm64/kvm/sys_regs.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
index 82430c1e1dd0..b105f156bdf6 100644
--- a/arch/arm64/kvm/sys_regs.c
+++ b/arch/arm64/kvm/sys_regs.c
@@ -2666,7 +2666,6 @@ static const struct sys_reg_desc sys_reg_descs[] = {
 					ID_AA64MMFR0_EL1_TGRAN16_2 |
 					ID_AA64MMFR0_EL1_ASIDBITS)),
 	ID_WRITABLE(ID_AA64MMFR1_EL1, ~(ID_AA64MMFR1_EL1_RES0 |
-					ID_AA64MMFR1_EL1_HCX |
 					ID_AA64MMFR1_EL1_TWED |
 					ID_AA64MMFR1_EL1_XNX |
 					ID_AA64MMFR1_EL1_VH |
-- 
2.33.0


