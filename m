Return-Path: <linux-kernel+bounces-327891-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CE491977C55
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 11:39:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9447828539A
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 09:39:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 199671D7E58;
	Fri, 13 Sep 2024 09:38:57 +0000 (UTC)
Received: from szxga06-in.huawei.com (szxga06-in.huawei.com [45.249.212.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0459A1D7E31
	for <linux-kernel@vger.kernel.org>; Fri, 13 Sep 2024 09:38:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726220336; cv=none; b=T4aZzItN/Fhi5Q1uTleGrZ6xMPu1EAE8H7MR4Az+gn7k30yaa0azuPlRK6AfAVc2/ONnDovkILw9fzEbQEzH9ZMVtmm/fA9iA26JRUEgam5pZ6Zldk+v8UflERPw2OPtfWjVhwnC3oHYIGmdJ2D2RYvpwf3SA6c/SZGb42nu1Rc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726220336; c=relaxed/simple;
	bh=CRukpNiaS1+ZF0v6XbbCV6D0SdH8QXNiaPbDb9iR1MM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FiBYhsjDXeaFVRlZAGqFjRFzzQu41yYD0yTju80cBEfQVKRsERME4s0CjJfI0/05Hd5scw+b7A1/LfASdCw2EqnGax+pdka9zoPBfYSUHpbi4vryrVZbLZm+6OKlw614h0xSpm84ltwuAkETo4e/CwK068Etj+qFXdZfdHmOOYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4X4q4p541hz1xx90;
	Fri, 13 Sep 2024 17:38:50 +0800 (CST)
Received: from kwepemf500004.china.huawei.com (unknown [7.202.181.242])
	by mail.maildlp.com (Postfix) with ESMTPS id 843841402CE;
	Fri, 13 Sep 2024 17:38:51 +0800 (CST)
Received: from lihuafei.huawei.com (10.90.53.74) by
 kwepemf500004.china.huawei.com (7.202.181.242) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 13 Sep 2024 17:38:50 +0800
From: Li Huafei <lihuafei1@huawei.com>
To: <tglx@linutronix.de>, <peterz@infradead.org>
CC: <akpm@linux-foundation.org>, <linux@weissschuh.net>, <song@kernel.org>,
	<dianders@chromium.org>, <j.granados@samsung.com>,
	<liusong@linux.alibaba.com>, <lizhe.67@bytedance.com>,
	<yaoma@linux.alibaba.com>, <dzickus@redhat.com>, <mingo@kernel.org>,
	<linux-kernel@vger.kernel.org>, <lihuafei1@huawei.com>
Subject: [PATCH v4 -next 2/2] watchdog/hardlockup/perf: Warn if watchdog_ev is overwritten
Date: Sat, 14 Sep 2024 01:39:41 +0800
Message-ID: <20240913173941.2758596-2-lihuafei1@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240913173941.2758596-1-lihuafei1@huawei.com>
References: <20240913173941.2758596-1-lihuafei1@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
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


