Return-Path: <linux-kernel+bounces-256074-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC0629348AB
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 09:21:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 97AE4282C73
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 07:21:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9B29762D0;
	Thu, 18 Jul 2024 07:20:51 +0000 (UTC)
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6685F487A5
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2024 07:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721287251; cv=none; b=cP8fKadeWdY/eL6gmgq+GTuHtKZFIBrCPvs+QFAouuQPHq7dPNfpjQU9w0+rC7OY9aFLTaGyADGOVCNAdIASRq+xeJMrYqnn/IfVAd+N43gxVoD8QeA6YVl5R53nT/0rYHO0goEMPE38TxNo7twMM829N2CdUhDUFuy1cNOUQ3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721287251; c=relaxed/simple;
	bh=cK/LKWC1zV65NipRe04Ma6g3v7FawPb4FUG0+9u53UA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=QrPozq11t4aukIlJDCR1F2DoKhmY2obehggtovaJ63A0oFDQRw+teK4H0xEYMGLa5C0PH4oajNx8o9AnVo3/4ySkEXlpXXIqMrN3S7OO145hJhIkrGtP6B25xKZ7TDII4js1dcBeCO0Qv5lPnqZ30EAalHm4tRM6omum5RnyRf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4WPkfr1BZBz1HFLl;
	Thu, 18 Jul 2024 15:18:12 +0800 (CST)
Received: from kwepemm600004.china.huawei.com (unknown [7.193.23.242])
	by mail.maildlp.com (Postfix) with ESMTPS id 900471A0188;
	Thu, 18 Jul 2024 15:20:46 +0800 (CST)
Received: from localhost.localdomain (10.28.79.22) by
 kwepemm600004.china.huawei.com (7.193.23.242) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 18 Jul 2024 15:20:46 +0800
From: Huisong Li <lihuisong@huawei.com>
To: <xuwei5@hisilicon.com>
CC: <linux-kernel@vger.kernel.org>, <soc@kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <Jonathan.Cameron@Huawei.com>,
	<liuyonglong@huawei.com>, <lihuisong@huawei.com>
Subject: [PATCH 0/5] Add some features and bugfix for kunpeng_hccs
Date: Thu, 18 Jul 2024 15:11:29 +0800
Message-ID: <20240718071134.31155-1-lihuisong@huawei.com>
X-Mailer: git-send-email 2.22.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemm600004.china.huawei.com (7.193.23.242)

This series are intended to support the low power feature for specified
HCCS and add used HCCS type sysfs. In addition, fix a PCC typo and add the
verification for die and port number.

Huisong Li (5):
  soc: hisilicon: kunpeng_hccs: fix a PCC typo
  soc: hisilicon: kunpeng_hccs: return failure on having not die or port
    information
  soc: hisilicon: kunpeng_hccs: add used HCCS type sysfs on platform
  soc: hisilicon: kunpeng_hccs: support low power feature for specified
    HCCS
  doc: soc: hisilicon: kunpeng_hccs: add low power interface description
    for HCCS

 .../sysfs-devices-platform-kunpeng_hccs       |  26 +
 drivers/soc/hisilicon/Kconfig                 |   7 +-
 drivers/soc/hisilicon/kunpeng_hccs.c          | 489 +++++++++++++++++-
 drivers/soc/hisilicon/kunpeng_hccs.h          |  29 ++
 4 files changed, 545 insertions(+), 6 deletions(-)

-- 
2.22.0


