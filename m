Return-Path: <linux-kernel+bounces-374189-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9482E9A6693
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 13:29:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 400B11F22EB8
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 11:29:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF51E1E6DFE;
	Mon, 21 Oct 2024 11:29:20 +0000 (UTC)
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3D20198E6F
	for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2024 11:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729510160; cv=none; b=nEDDQ4mgWfjUncWUWCs27DckJCF/oea3bR7dReg2IbH2KUBOMwXa0CciRzPUp1FtfvS/gL1UXNUdvEyIBxsetAltBXKPFwzyKTMb6dyF0whRjxdYfu3qY40h3YlMTjytcFvF0pVLt30n6ultfUX4zSHAtaUV+7PqLWJhJw1BeqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729510160; c=relaxed/simple;
	bh=MFnHqhiYcgFdWTxIUbSwgDAUeksZyFX9gIUi8PfmW50=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UP2JQSbx4EzqwtWf4sT4rXua5ekzZ+jv3d8FAX5KHyJoOjytBxyEHgFgyrDplv4jVM4+kOQE+64INhTVz7iAhRCxxchU9Gc+/y/sA7eKWrvIIPC8YQ4+A8jP3+YGO5TM3R3Ri7M1wQKnAPXp1FXpsm76vNL7ptUNtIT/onepJUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.44])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4XXCj66w1cz1jBBx;
	Mon, 21 Oct 2024 19:27:54 +0800 (CST)
Received: from kwepemf500004.china.huawei.com (unknown [7.202.181.242])
	by mail.maildlp.com (Postfix) with ESMTPS id 6A68B1402D0;
	Mon, 21 Oct 2024 19:29:15 +0800 (CST)
Received: from lihuafei.huawei.com (10.90.53.74) by
 kwepemf500004.china.huawei.com (7.202.181.242) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 21 Oct 2024 19:29:14 +0800
From: Li Huafei <lihuafei1@huawei.com>
To: <tglx@linutronix.de>, <peterz@infradead.org>
CC: <akpm@linux-foundation.org>, <linux@weissschuh.net>, <song@kernel.org>,
	<dianders@chromium.org>, <j.granados@samsung.com>,
	<liusong@linux.alibaba.com>, <lizhe.67@bytedance.com>,
	<yaoma@linux.alibaba.com>, <dzickus@redhat.com>, <mingo@kernel.org>,
	<linux-kernel@vger.kernel.org>, <lihuafei1@huawei.com>
Subject: [PATCH RESEND 2/2] watchdog/hardlockup/perf: Warn if watchdog_ev is overwritten
Date: Tue, 22 Oct 2024 03:30:04 +0800
Message-ID: <20241021193004.308303-2-lihuafei1@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241021193004.308303-1-lihuafei1@huawei.com>
References: <20241021193004.308303-1-lihuafei1@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemf500004.china.huawei.com (7.202.181.242)

When creating a new perf_event, it should not happen that the old
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


