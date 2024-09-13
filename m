Return-Path: <linux-kernel+bounces-327906-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6964B977C7C
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 11:45:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 148BD1F28824
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 09:45:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 492DA1D6DCD;
	Fri, 13 Sep 2024 09:45:08 +0000 (UTC)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 530511D798B
	for <linux-kernel@vger.kernel.org>; Fri, 13 Sep 2024 09:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726220707; cv=none; b=W8B0MVzjLHdWUJmjQpkAiH4ebLg66gDAjrHAo/b47FwTsNHgrSdf2ETuPWoj51q66tRnUOTu+78JBeL+5YGsfBYIIAN6xPbCgTdxpqsgTB1uIhRNmS6ybo1v3AavQkbkKDyjYNeDY+1d4USlN1DvQ2KY97UGXOn36yb4oZ6MoIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726220707; c=relaxed/simple;
	bh=CRukpNiaS1+ZF0v6XbbCV6D0SdH8QXNiaPbDb9iR1MM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=swBfx/tuw/XGuEzfejtIxu6AoDrvcCt84jEO61NV6uFsah9PWQURRtzrqWccbFsN7wiizI9VM8dRdyYHyp5J7GVoTvO/W/5S28z84bgsGBNAkbXxGQniImA7rw22Xr3JpzmSlqmHP+M1jVpdWsUVOFMNR0Nd0/aZDNWZ4/IAtrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.254])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4X4q9S3TTzzfc6y;
	Fri, 13 Sep 2024 17:42:52 +0800 (CST)
Received: from kwepemf500004.china.huawei.com (unknown [7.202.181.242])
	by mail.maildlp.com (Postfix) with ESMTPS id EB267180106;
	Fri, 13 Sep 2024 17:45:03 +0800 (CST)
Received: from lihuafei.huawei.com (10.90.53.74) by
 kwepemf500004.china.huawei.com (7.202.181.242) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 13 Sep 2024 17:45:03 +0800
From: Li Huafei <lihuafei1@huawei.com>
To: <tglx@linutronix.de>, <peterz@infradead.org>
CC: <akpm@linux-foundation.org>, <linux@weissschuh.net>, <song@kernel.org>,
	<dianders@chromium.org>, <j.granados@samsung.com>,
	<liusong@linux.alibaba.com>, <lizhe.67@bytedance.com>,
	<yaoma@linux.alibaba.com>, <dzickus@redhat.com>, <mingo@kernel.org>,
	<linux-kernel@vger.kernel.org>, <lihuafei1@huawei.com>
Subject: [PATCH 2/2] watchdog/hardlockup/perf: Warn if watchdog_ev is overwritten
Date: Sat, 14 Sep 2024 01:45:54 +0800
Message-ID: <20240913174554.2759064-2-lihuafei1@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240913174554.2759064-1-lihuafei1@huawei.com>
References: <20240913174554.2759064-1-lihuafei1@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemf500004.china.huawei.com (7.202.181.242)

When we create a new perf_event, it should not happen that the old
perf_event is not released. If it does, make a warning to sense the
problem in time.

Signed-off-by: Li Huafei <lihuafei1@huawei.com>
---
 kernel/watchdog_perf.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/watchdog_perf.c b/kernel/watchdog_perf.c
index 2fdb96eaf493..09236586b8c3 100644
--- a/kernel/watchdog_perf.c
+++ b/kernel/watchdog_perf.c
@@ -144,6 +144,7 @@ static int hardlockup_detector_event_create(void)
 			 PTR_ERR(evt));
 		return PTR_ERR(evt);
 	}
+	WARN_ON(this_cpu_read(watchdog_ev));
 	this_cpu_write(watchdog_ev, evt);
 	return 0;
 }
-- 
2.25.1


