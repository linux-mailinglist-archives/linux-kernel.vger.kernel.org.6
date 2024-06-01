Return-Path: <linux-kernel+bounces-197653-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C5848D6D88
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jun 2024 04:40:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1B88A1F216F5
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jun 2024 02:40:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05AD3B64B;
	Sat,  1 Jun 2024 02:40:26 +0000 (UTC)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F35B6FA8;
	Sat,  1 Jun 2024 02:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717209625; cv=none; b=pBo2kVoKimFzNhJgnfzHvPvylfXOwOQDwqti0E8os1VEuuRzCnLDv9aKXTSxmNX8ZofRoclSasFWD6uxq99KLmltbFsk3UzMl76LCKuMxsAku3TzNqbfrw4rsVAs+JeOja2ysssJWbjhJnLz5llHLsfPvpRxa7ndk42mcwIkFQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717209625; c=relaxed/simple;
	bh=Qfgl0Biv0aP0AfSr2hL0ISOr/2WJn7Y3CpP9bolN+HY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=I/htj5jEXGSSvEsfkI91NSwx/F3n1/K3fytqfDwhcp97ENReUDaUc5yrn4Fga0CsvRz1o768Xb2GBgLzaRL9hfvgbRPeyLGT81ryXFSVLK4gQPIa5quGYnhW0boaSCHeBddh2dXD5Hhg4ZDXZib5ENeWSPeV55c3Gsbk+0mOe7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4VrkdR6f9QzxNfm;
	Sat,  1 Jun 2024 10:36:27 +0800 (CST)
Received: from kwepemi500025.china.huawei.com (unknown [7.221.188.170])
	by mail.maildlp.com (Postfix) with ESMTPS id EB330180AA4;
	Sat,  1 Jun 2024 10:40:19 +0800 (CST)
Received: from localhost.huawei.com (10.90.30.45) by
 kwepemi500025.china.huawei.com (7.221.188.170) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Sat, 1 Jun 2024 10:40:19 +0800
From: Chenghai Huang <huangchenghai2@huawei.com>
To: <herbert@gondor.apana.org.au>, <davem@davemloft.net>
CC: <linux-kernel@vger.kernel.org>, <linux-crypto@vger.kernel.org>,
	<shenyang39@huawei.com>, <liulongfang@huawei.com>, <qianweili@huawei.com>
Subject: [PATCH V2 0/2] crypto: hisilicon - adjust vf configuration sequence and optimize zip reg offset
Date: Sat, 1 Jun 2024 10:40:13 +0800
Message-ID: <20240601024016.1598391-1-huangchenghai2@huawei.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemi500025.china.huawei.com (7.221.188.170)

The VF enabling and disabling issues are fixed, and the ZIP address
offset calculation is optimized.

Chenghai Huang (2):
  crypto: hisilicon/qm - adjust the internal processing sequence of the
    vf enable and disable
  crypto: hisilicon/zip - optimize the address offset of the reg query
    function

 drivers/crypto/hisilicon/qm.c           | 11 ++----
 drivers/crypto/hisilicon/zip/zip_main.c | 48 +++++++++++--------------
 2 files changed, 23 insertions(+), 36 deletions(-)

-- 
2.33.0


