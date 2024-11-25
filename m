Return-Path: <linux-kernel+bounces-420739-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B25B9D830E
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 11:08:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 36EFEB2444A
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 09:45:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1643191499;
	Mon, 25 Nov 2024 09:45:38 +0000 (UTC)
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A18D19049A;
	Mon, 25 Nov 2024 09:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732527938; cv=none; b=NJmyZZsmrrLpKQYwyrf6Kmm1IPb1B8Qdoy0BiZMVr7KqH3EBPUKropHCZBM9YVS9dgCfOiH8TMRYdOLOtYqAvzmEp+0yIY6HJdsy9JKLIRKSsZH2FYCQkZsGuDAMev6EoJ8dNPdGPVwMM8Y5Nbxw6EMK8P7loNA17PGJ9Xws0zU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732527938; c=relaxed/simple;
	bh=8ZKnedC2e8890+y8R6lNCHG4yWNiwGF63jBe/nZTkiw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=DzfgIz8l+DNfOCiN1UUbpb1505yJkLgS5AdHm4Ica1w7cZzR4W7GzHMD8D1mu+xQ+ZWMI/lGA6mUBJ0GtwNtvsNS092kkoYleAq7xTSaBRWc9B9IyatrOavVA/i2XBq1+2VXF1AjFzb2nfJh2TuDV1i7GdeJi5IsqopJH04AuKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4Xxgl939wyzRhrS;
	Mon, 25 Nov 2024 17:44:05 +0800 (CST)
Received: from dggemv703-chm.china.huawei.com (unknown [10.3.19.46])
	by mail.maildlp.com (Postfix) with ESMTPS id 31085140120;
	Mon, 25 Nov 2024 17:45:33 +0800 (CST)
Received: from kwepemn100009.china.huawei.com (7.202.194.112) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 25 Nov 2024 17:45:32 +0800
Received: from localhost.localdomain (10.28.79.22) by
 kwepemn100009.china.huawei.com (7.202.194.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 25 Nov 2024 17:45:32 +0800
From: Huisong Li <lihuisong@huawei.com>
To: <linux-hwmon@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <linux@roeck-us.net>, <jdelvare@suse.com>, <liuyonglong@huawei.com>,
	<zhanjie9@hisilicon.com>, <zhenglifeng1@huawei.com>, <lihuisong@huawei.com>
Subject: [PATCH v1 0/4] hwmon: (acpi_power_meter) Some trival optimizations
Date: Mon, 25 Nov 2024 17:34:11 +0800
Message-ID: <20241125093415.21719-1-lihuisong@huawei.com>
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
 kwepemn100009.china.huawei.com (7.202.194.112)

I get an issue that the 'power1_alarm' attribute shows wrong if
we doesn't query the 'power1_average' and 'power1_cap' first.
So fix it and do some trival optimizations for acpi_power_meter
by the way. 

Huisong Li (4):
  hwmon: (acpi_power_meter) Fix using uninitialized variables
  hwmon: (acpi_power_meter) Fix update the power trip points on failure
  hwmon: (acpi_power_meter) Remove redundant 'sensors_valid' variable
  hwmon: (acpi_power_meter) Add the print of no notification that
    hardware limit is enforced

 drivers/hwmon/acpi_power_meter.c | 35 ++++++++++++++++++++++++--------
 1 file changed, 26 insertions(+), 9 deletions(-)

-- 
2.22.0


