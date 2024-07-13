Return-Path: <linux-kernel+bounces-251366-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 96717930411
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jul 2024 08:14:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 402581F22762
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jul 2024 06:14:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 146444204F;
	Sat, 13 Jul 2024 06:13:45 +0000 (UTC)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FBE329401
	for <linux-kernel@vger.kernel.org>; Sat, 13 Jul 2024 06:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720851224; cv=none; b=PZla5VmpPadHmZaDOZB1bgikbMV0BSqwRJy6LR7IV0pyn/hIyc543kHv92H+m9ylG+UT00feLRrdtOTRBsIq5LeDRd8NurtVM10sEinjH3RH14fs1vBWyM6T0vGNJxwNVVr282wZ4GMHR5f/mB0xhj/3/MeIAiy7fN0S2et7FsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720851224; c=relaxed/simple;
	bh=R3cNbPzF01zPW0Agt3jSGRYoa07FzhA5IpSkLVXcA1w=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=H7CXPHDSCrT9Iwj+2EeuUIhxA3ynhW/JJmEL3mqRmuwf8wL/t/rxERGyYfmJHrdN3eQkZvp8f4DHIZwj4pJQf6xiOnom/ovVsvJuEaJ5xp5JD6I/oRHAA+VjpKsq9qadUxFrjC6do6dDH78TsxWMcIXFk0bbpMIfNN604nUPZWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.105])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4WLdM22zNpzxSSM;
	Sat, 13 Jul 2024 14:08:46 +0800 (CST)
Received: from kwepemf100008.china.huawei.com (unknown [7.202.181.222])
	by mail.maildlp.com (Postfix) with ESMTPS id CD532140136;
	Sat, 13 Jul 2024 14:13:32 +0800 (CST)
Received: from huawei.com (10.175.103.91) by kwepemf100008.china.huawei.com
 (7.202.181.222) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Sat, 13 Jul
 2024 14:13:32 +0800
From: Zeng Heng <zengheng4@huawei.com>
To: <james.morse@arm.com>
CC: <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v6.10-rc1 0/4] arm_mpam: Fix several minor issues
Date: Sat, 13 Jul 2024 14:09:40 +0800
Message-ID: <20240713060944.2725647-1-zengheng4@huawei.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemf100008.china.huawei.com (7.202.181.222)

After completing the MPAM related test, several bugs are discovered and
attempt to fix them. Now it's time to send them to the community for
review.

It's first time to send patch to this repository, if any rules should be
realized, please let me know. Hope to submit more patches in the future.

Zeng Heng (4):
  arm_mpam: Correct MBA granularity calculation
  arm_mpam: Fix the range calculation of the implemented bits
  arm_mpam: Correct the judgment condition of the CMAX feature
  arm_mpam: Fix typo about mbw_min controls

 drivers/platform/arm64/mpam/mpam_devices.c  | 8 +++++---
 drivers/platform/arm64/mpam/mpam_internal.h | 1 +
 drivers/platform/arm64/mpam/mpam_resctrl.c  | 4 ++--
 3 files changed, 8 insertions(+), 5 deletions(-)

--
2.25.1


