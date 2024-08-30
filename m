Return-Path: <linux-kernel+bounces-308002-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A2B996560F
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 05:59:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3D82C1C21ED6
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 03:59:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 016CD14D711;
	Fri, 30 Aug 2024 03:58:39 +0000 (UTC)
Received: from szxga07-in.huawei.com (szxga07-in.huawei.com [45.249.212.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAC6114884F
	for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 03:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724990318; cv=none; b=FBLPGfWnOBiK8AGpBBXIMd6CCce26SqQu1a9fkYp4Nvo50zzitELIZ2n/apSGptwz0sHO7Se6zqj32gd95c6I6owRog9RRbSLNewuuBpWw9ySSlth8A5/4zlMrc86B8MOP6MKoSVGiGRihyAd7g3ymjo6bx2F3KXWHtzYO0EbTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724990318; c=relaxed/simple;
	bh=qqbxNRB4wpcerzKbhKxGvoWfhSeeKHVL+7I4Jm0hxlk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=LvEcacyu/81IrZdvN8gRYJVZgNg1/1urbV0/DykhmBQP0yxAoJAMOTgaMqKYRt55HlGa5CDyfwI1O9RGLnN8tptbbTX1Yb0kL1PH0y1ivxq96DKTksDtCC879Km3/cPUhAxvOZoqTvAWY+XQZ55Cc4FGvDLjEU5E3tSLGxXHNgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4Ww4BH0P3mz1S9TT;
	Fri, 30 Aug 2024 11:58:15 +0800 (CST)
Received: from kwepemh500013.china.huawei.com (unknown [7.202.181.146])
	by mail.maildlp.com (Postfix) with ESMTPS id 2B4C81400F4;
	Fri, 30 Aug 2024 11:58:29 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemh500013.china.huawei.com
 (7.202.181.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Fri, 30 Aug
 2024 11:58:28 +0800
From: Jinjie Ruan <ruanjinjie@huawei.com>
To: <herve.codina@bootlin.com>, <qiang.zhao@nxp.com>,
	<christophe.leroy@csgroup.eu>, <linuxppc-dev@lists.ozlabs.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<krzk@kernel.org>, <jic23@kernel.org>
CC: <ruanjinjie@huawei.com>
Subject: [PATCH -next v2 0/4] soc: fsl: cpm1: Simplify with scoped for each OF child loop and dev_err_probe()
Date: Fri, 30 Aug 2024 12:06:32 +0800
Message-ID: <20240830040636.3508679-1-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemh500013.china.huawei.com (7.202.181.146)

Use for_each_child_of_node_scoped() and dev_err_probe() to simplify code.

Changes in v2:
- Split from the whole soc patch set.
- Update the commit message.

Jinjie Ruan (4):
  soc: fsl: cpm1: Simplify with scoped for each OF child loop
  soc: fsl: cpm1: Simplify with dev_err_probe()
  soc: fsl: cpm1: qmc: Simplify with scoped for each OF child
  soc: fsl: cpm1: qmc: Simplify with dev_err_probe()

 drivers/soc/fsl/qe/qmc.c | 66 ++++++++++-------------------
 drivers/soc/fsl/qe/tsa.c | 90 ++++++++++++----------------------------
 2 files changed, 50 insertions(+), 106 deletions(-)

-- 
2.34.1


