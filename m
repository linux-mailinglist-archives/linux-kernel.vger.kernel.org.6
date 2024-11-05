Return-Path: <linux-kernel+bounces-396550-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E4319BCECB
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 15:13:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 446E21C220FE
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 14:13:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBEF71D90A7;
	Tue,  5 Nov 2024 14:12:49 +0000 (UTC)
Received: from szxga06-in.huawei.com (szxga06-in.huawei.com [45.249.212.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F06F61D86C7
	for <linux-kernel@vger.kernel.org>; Tue,  5 Nov 2024 14:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730815969; cv=none; b=RAqvsx+WaenUsVBcS31IxhzIUwboEkh1LkXFWP5VkoDcAuKORoawoiYQ5XKNeTkc+HqGLHZsZpuTdEWElLFOE1Q2G/iDJ2j36VQeDa3OZ4JfBneAGl6i9GhPULqWZ5oP4Ti5W9eVvtSzFU8JNfsG+UC1XF1BMKAvNH802WMzl1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730815969; c=relaxed/simple;
	bh=BE+ESe3tBxvC7Xu214BQePZUrRg5V2mWVsaXtr4zdsM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=AqmNlBqMOTykex35jILPC6Fyg3oO1BaV/dWKC2E5i8V9OqMSWFTD73VOXHiyzNPfndhe3bhrmS+N/gCDPwT18svV045KaN1CQDBr9gfDuJs0o32BItsOj5pq/weqVB9/V1jsKR6y1ryLi2WK3OWggaQf86uUO0SIV0TBp4ML8+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4XjVfS4Zn5z1ypGd;
	Tue,  5 Nov 2024 22:12:48 +0800 (CST)
Received: from kwepemd200012.china.huawei.com (unknown [7.221.188.145])
	by mail.maildlp.com (Postfix) with ESMTPS id ABACB1A0188;
	Tue,  5 Nov 2024 22:12:38 +0800 (CST)
Received: from huawei.com (10.67.175.84) by kwepemd200012.china.huawei.com
 (7.221.188.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.34; Tue, 5 Nov
 2024 22:12:37 +0800
From: Zicheng Qu <quzicheng@huawei.com>
To: <harry.wentland@amd.com>, <sunpeng.li@amd.com>,
	<Rodrigo.Siqueira@amd.com>, <alexander.deucher@amd.com>,
	<christian.koenig@amd.com>, <Xinhui.Pan@amd.com>, <airlied@gmail.com>,
	<simona@ffwll.ch>, <Dillon.Varone@amd.com>, <Alvin.Lee2@amd.com>,
	<nicholas.kazlauskas@amd.com>, <alex.hung@amd.com>,
	<aurabindo.pillai@amd.com>, <relja.vojvodic@amd.com>,
	<chiahsuan.chung@amd.com>, <wenjing.liu@amd.com>, <george.shen@amd.com>,
	<mwen@igalia.com>, <yi-lchen@amd.com>, <martin.leung@amd.com>,
	<srinivasan.shanmugam@amd.com>, <stylon.wang@amd.com>, <jun.lei@amd.com>,
	<amd-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
	<linux-kernel@vger.kernel.org>
CC: <tanghui20@huawei.com>, <zhangqiao22@huawei.com>,
	<judy.chenhui@huawei.com>, <quzicheng@huawei.com>
Subject: [PATCH 0/2] drm/amd/display: Fix Null Pointer Dereference Issues
Date: Tue, 5 Nov 2024 14:01:35 +0000
Message-ID: <20241105140137.2465572-1-quzicheng@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemd200012.china.huawei.com (7.221.188.145)

Hi all,

I am submitting two patches to fix null pointer dereference issues in
the AMD display driver.

1. Patch 1/2 (Fixes: 8e4ed3cf1642): Add null checks in
dcn20_program_pipe() to prevent potential crashes when accessing
plane_state.

2. Patch 2/2 (Fixes: 0baae6246307): Ensures pipe_ctx->plane_state is
checked in hwss_setup_dpp() to improve function stability.

Thanks for reviewing!

Zicheng Qu (2):
  drm/amd/display: Fix null check for pipe_ctx->plane_state in
    dcn20_program_pipe
  drm/amd/display: Fix null check for pipe_ctx->plane_state in
    hwss_setup_dpp

 drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c   | 3 +++
 drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c | 6 +++---
 2 files changed, 6 insertions(+), 3 deletions(-)

-- 
2.34.1


