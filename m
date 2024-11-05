Return-Path: <linux-kernel+bounces-396555-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AD109BCED5
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 15:14:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9CC661C226BC
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 14:14:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08FEC1D8A1D;
	Tue,  5 Nov 2024 14:14:03 +0000 (UTC)
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAEC21D86C4
	for <linux-kernel@vger.kernel.org>; Tue,  5 Nov 2024 14:14:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730816042; cv=none; b=P7LtNrNcPs1zWOdFUKTaj5C5LVuGuTYjp7qqJI1OIs30FL8fePiLFouHe57VM2zJbtWFGxI+aIBDILKSdOMo1eWcPDMzZQM4Wh3s0chdeEv7BBQ1nYSAOZnCqzRuP10OXyIN53oFW0PsjVUrL05BzXxmeOaE4zNZlaTAbJfoHgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730816042; c=relaxed/simple;
	bh=u8D7LSEeZaJ0qn7OIxNJcNR3b4S4GaLFk4aIVMNQSh4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=NCcCUCmXCrrYtFBdtH5a1G4NIxLBVRyEAEmcPl1hzVBcewQGoJYk6ykL/KlEDzr92DN9VObIZWFImNJTCR5mONNR7oCuUpqtDSNNN24JiEtagkmhf0HeNIDKY2zLtym4PZrHt+Y+2KrwV1i6aLrFfDcR3GZhddVmrK3/opNUMLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.44])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4XjVdt0jJfz2Fb4S;
	Tue,  5 Nov 2024 22:12:18 +0800 (CST)
Received: from kwepemd200012.china.huawei.com (unknown [7.221.188.145])
	by mail.maildlp.com (Postfix) with ESMTPS id 11EDE1401F4;
	Tue,  5 Nov 2024 22:13:58 +0800 (CST)
Received: from huawei.com (10.67.175.84) by kwepemd200012.china.huawei.com
 (7.221.188.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.34; Tue, 5 Nov
 2024 22:13:56 +0800
From: Zicheng Qu <quzicheng@huawei.com>
To: <harry.wentland@amd.com>, <sunpeng.li@amd.com>,
	<Rodrigo.Siqueira@amd.com>, <alexander.deucher@amd.com>,
	<christian.koenig@amd.com>, <Xinhui.Pan@amd.com>, <airlied@gmail.com>,
	<simona@ffwll.ch>, <Alvin.Lee2@amd.com>, <chiahsuan.chung@amd.com>,
	<alex.hung@amd.com>, <wenjing.liu@amd.com>, <Dillon.Varone@amd.com>,
	<george.shen@amd.com>, <mwen@igalia.com>, <yi-lchen@amd.com>,
	<martin.leung@amd.com>, <yongqiang.sun@amd.com>, <tony.cheng@amd.com>,
	<amd-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
	<linux-kernel@vger.kernel.org>
CC: <tanghui20@huawei.com>, <zhangqiao22@huawei.com>,
	<judy.chenhui@huawei.com>, <quzicheng@huawei.com>
Subject: [PATCH 0/2] drm/amd/display: Fix Power Gating Configuration
Date: Tue, 5 Nov 2024 14:02:54 +0000
Message-ID: <20241105140256.2465614-1-quzicheng@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemd200012.china.huawei.com (7.221.188.145)

Hi all,

I am submitting two patches to correct power gating configurations in
the AMD display driver.

1. Patch 1/2 (Fixes: 46825fcfbe16): Corrects DOMAIN10_PG_CONFIG to use
DOMAIN10_POWER_FORCEON.
2. Patch 2/2 (Fixes: 46825fcfbe16): Corrects DOMAIN11_PG_CONFIG to use
DOMAIN11_POWER_FORCEON.

Thanks for reviewing!

Zicheng Qu (2):
  drm/amd/display: Fix incorrect power gating configuration for DOMAIN10
  drm/amd/display: Fix incorrect power gating configuration for DOMAIN11

 drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

-- 
2.34.1


