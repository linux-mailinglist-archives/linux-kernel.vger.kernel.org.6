Return-Path: <linux-kernel+bounces-301115-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 614E295EC87
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 10:58:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C8F628161A
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 08:58:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A592914431C;
	Mon, 26 Aug 2024 08:57:41 +0000 (UTC)
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFDC213D8B8;
	Mon, 26 Aug 2024 08:57:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.255
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724662661; cv=none; b=Jf2BoPfZDSCwlM6MT0RJlL+ewqR0giIWrOLlwwI8y3Daoqzj1o40OMY9XGSDQUxZR3RH0ADTM/p59KwC261xFSuaJvrrjYC8ZWAC93OX69UumWG8XDLgH7IXq2aS5NIloORTUoArDe2BgVImTx+LkTvib0ilX2QvO5sUMuUCMiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724662661; c=relaxed/simple;
	bh=07YHEvvzJ+ri63RFfz6j3YSCckGbtMiGXtm3i6eRbLo=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Wj310d+reumngEN/knx0jdzNK+tXxr4x3Ip16jsj1xvrdtzo8vQII2cV2R2fL4kP9Q9LylKnvpC4L2iADeSJ2Ak6AxXP0e9TU8QjwqCTKvrrf81OHwTB/TyHhSczyK+ntUB1Cyy4vkmSbzVTXX/PIj3Otd7tFsbWsoOedPwgny8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.255
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4Wsl0d6f9jz14Dk8;
	Mon, 26 Aug 2024 16:56:49 +0800 (CST)
Received: from dggpemm500020.china.huawei.com (unknown [7.185.36.49])
	by mail.maildlp.com (Postfix) with ESMTPS id 5DCEE1800A7;
	Mon, 26 Aug 2024 16:57:35 +0800 (CST)
Received: from huawei.com (10.67.174.77) by dggpemm500020.china.huawei.com
 (7.185.36.49) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Mon, 26 Aug
 2024 16:57:35 +0800
From: Liao Chen <liaochen4@huawei.com>
To: <linux-sound@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<alsa-devel@alsa-project.org>
CC: <lgirdwood@gmail.com>, <broonie@kernel.org>, <perex@perex.cz>,
	<tiwai@suse.com>, <cezary.rojewski@intel.com>,
	<pierre-louis.bossart@linux.intel.com>, <peter.ujfalusi@linux.intel.com>,
	<yung-chuan.liao@linux.intel.com>, <ranjani.sridharan@linux.intel.com>,
	<kai.vehmanen@linux.intel.com>, <liaochen4@huawei.com>,
	<u.kleine-koenig@pengutronix.de>, <andy.shevchenko@gmail.com>,
	<kuninori.morimoto.gx@renesas.com>, <robh@kernel.org>
Subject: [PATCH -next 0/4] ASoC: fix module autoloading
Date: Mon, 26 Aug 2024 08:49:20 +0000
Message-ID: <20240826084924.368387-1-liaochen4@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpemm500020.china.huawei.com (7.185.36.49)

Hi all,

This patchset aims to enable autoloading of some use modules.
By registering MDT, the kernel is allowed to automatically bind 
modules to devices that match the specified compatible strings.

Liao Chen (4):
  ASoC: intel: fix module autoloading
  ASoC: google: fix module autoloading
  ASoC: tda7419: fix module autoloading
  ASoC: fix module autoloading

 sound/soc/codecs/chv3-codec.c          | 1 +
 sound/soc/codecs/tda7419.c             | 1 +
 sound/soc/google/chv3-i2s.c            | 1 +
 sound/soc/intel/keembay/kmb_platform.c | 1 +
 4 files changed, 4 insertions(+)

-- 
2.34.1


