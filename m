Return-Path: <linux-kernel+bounces-518990-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B09E9A396D6
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 10:20:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 43CB6169FEF
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 09:19:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D836F22FAF4;
	Tue, 18 Feb 2025 09:19:52 +0000 (UTC)
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96CB922DF91
	for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 09:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739870392; cv=none; b=O+hSJjpgtfO53z4xs4EspCZgynSD+J/4Co04UPjBHUOYkWgLHFicfAOD7EqFXJIIrvhYpWFCn6jmrrAR7oQ8tnqTYgA3rTNCUajLuYTvZvrhexNT+rtwYay5KBQopyb59dfVGCxP2f7EnrJHO+8rLGuvRMs2dgQVaNCB2UluiUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739870392; c=relaxed/simple;
	bh=1jGp3oCUgZYPtCmy6uC7seQ+tq/ufBmb1K6m3PKDDVE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nZSWQjnubw5gDERjOi0qFhXz/urHpOJF53HW5dFfJpLNYOH0Iw/ZfDJqIiketAfmBZC/odXtCW5mQgyqQIJe5Xw8JTfxEl7pKDe9Y3cjZoXpKOYJCLQhTikxqBxEaVRDiN/0Ux2ZXRzGuDA09yeKC2VYF2ugac1OjIRv4px7Sw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.163])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4Yxv5Q411vz2JYYK;
	Tue, 18 Feb 2025 17:15:54 +0800 (CST)
Received: from kwepemd200014.china.huawei.com (unknown [7.221.188.8])
	by mail.maildlp.com (Postfix) with ESMTPS id 04855180214;
	Tue, 18 Feb 2025 17:19:48 +0800 (CST)
Received: from localhost.localdomain (10.50.165.33) by
 kwepemd200014.china.huawei.com (7.221.188.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Tue, 18 Feb 2025 17:19:47 +0800
From: Yicong Yang <yangyicong@huawei.com>
To: <will@kernel.org>, <mark.rutland@arm.com>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
CC: <jonathan.cameron@huawei.com>, <prime.zeng@hisilicon.com>,
	<linuxarm@huawei.com>, <yangyicong@hisilicon.com>, <wangyushan12@huawei.com>
Subject: [PATCH 1/9] drivers/perf: hisi: Extend struct hisi_pmu_dev_info
Date: Tue, 18 Feb 2025 17:19:52 +0800
Message-ID: <20250218092000.41641-2-yangyicong@huawei.com>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20250218092000.41641-1-yangyicong@huawei.com>
References: <20250218092000.41641-1-yangyicong@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemd200014.china.huawei.com (7.221.188.8)

From: Junhao He <hejunhao3@huawei.com>

The counter bits and event range may differ from versions of a
certain uncore PMU. Make this device specific information into
struct hisi_pmu_dev_info. This will help to simplify the
initialization process by using a list of struct hisi_pmu_dev_info
rather than checking the version.

Signed-off-by: Junhao He <hejunhao3@huawei.com>
Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
---
 drivers/perf/hisilicon/hisi_uncore_pmu.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/perf/hisilicon/hisi_uncore_pmu.h b/drivers/perf/hisilicon/hisi_uncore_pmu.h
index f4fed2544877..777675838b80 100644
--- a/drivers/perf/hisilicon/hisi_uncore_pmu.h
+++ b/drivers/perf/hisilicon/hisi_uncore_pmu.h
@@ -72,6 +72,8 @@ struct hisi_uncore_ops {
 struct hisi_pmu_dev_info {
 	const char *name;
 	const struct attribute_group **attr_groups;
+	u32 counter_bits;
+	u32 check_event;
 	void *private;
 };
 
-- 
2.24.0


