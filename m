Return-Path: <linux-kernel+bounces-226878-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3527091452B
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 10:43:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 648561C22102
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 08:43:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE4CE79B6F;
	Mon, 24 Jun 2024 08:43:17 +0000 (UTC)
Received: from SHSQR01.spreadtrum.com (mx1.unisoc.com [222.66.158.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7D526A33C
	for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 08:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=222.66.158.135
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719218597; cv=none; b=L9f4tBGAqT2RzlhOFomQCO64ujowqrpKNz/SRfssmvk1KGUxx+o9GgSd2/wWUmrHJ/TP7ZaK2jL7MsFDLP1bqfFUNrr8mJ1Rff0Rx8UyGBEFwPPKuier+uDM3rMZJ9K2pY7Zp6jntBDZhZ4phYuoBZ7QB0a2kmY1BSJAZt/x+sg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719218597; c=relaxed/simple;
	bh=u6kFgdu2wOllDMdne7q4OF76kshH6mJXK2hlSxtUcA8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=lRlcvrihmta8YCnIYY3UzSIKydsawoTXgCVnovSFI2UHzXFtGrVqzPC+cNsniIaRc/1/amMoLAtp1kuBM1kHrEgUMsoIu3umyRiq7RnhgJxUoiVNPzZQ/bdE6sBPeXTyvXGiwlvuW7DaaMzP/2Iqlh5haKg4XqBTIPcw1X7lJc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unisoc.com; spf=pass smtp.mailfrom=unisoc.com; arc=none smtp.client-ip=222.66.158.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unisoc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=unisoc.com
Received: from SHSQR01.spreadtrum.com (localhost [127.0.0.2] (may be forged))
	by SHSQR01.spreadtrum.com with ESMTP id 45O8L8qY020435
	for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 16:21:08 +0800 (+08)
	(envelope-from Xuewen.Yan@unisoc.com)
Received: from dlp.unisoc.com ([10.29.3.86])
	by SHSQR01.spreadtrum.com with ESMTP id 45O8KiLq017962;
	Mon, 24 Jun 2024 16:20:44 +0800 (+08)
	(envelope-from Xuewen.Yan@unisoc.com)
Received: from SHDLP.spreadtrum.com (bjmbx01.spreadtrum.com [10.0.64.7])
	by dlp.unisoc.com (SkyGuard) with ESMTPS id 4W714j55fnz2SwTfL;
	Mon, 24 Jun 2024 16:16:05 +0800 (CST)
Received: from BJ10918NBW01.spreadtrum.com (10.0.73.73) by
 BJMBX01.spreadtrum.com (10.0.64.7) with Microsoft SMTP Server (TLS) id
 15.0.1497.23; Mon, 24 Jun 2024 16:20:40 +0800
From: Xuewen Yan <xuewen.yan@unisoc.com>
To: <vincent.guittot@linaro.org>, <dietmar.eggemann@arm.com>,
        <mingo@redhat.com>, <peterz@infradead.org>, <juri.lelli@redhat.com>,
        <qyousef@layalina.io>
CC: <rostedt@goodmis.org>, <bsegall@google.com>, <mgorman@suse.de>,
        <bristot@redhat.com>, <vschneid@redhat.com>,
        <christian.loehle@arm.com>, <vincent.donnefort@arm.com>,
        <ke.wang@unisoc.com>, <di.shen@unisoc.com>, <xuewen.yan94@gmail.com>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH V2 0/2] sched/fair: Some improvements to feec()
Date: Mon, 24 Jun 2024 16:20:09 +0800
Message-ID: <20240624082011.4990-1-xuewen.yan@unisoc.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SHCAS01.spreadtrum.com (10.0.1.201) To
 BJMBX01.spreadtrum.com (10.0.64.7)
X-MAIL:SHSQR01.spreadtrum.com 45O8KiLq017962

Patch 1 clamp the util with per-CPU instand of per-PD when calc pd_busy_time.

Patch 2 use actual_cpu_capacity when judging util_fits_cpu to cover the case
which rq-uclamp-max would cause some corner case wrong.

Changelog:
V1:
https://lore.kernel.org/all/20240606070645.3295-1-xuewen.yan@unisoc.com/

v2: 
(1) remove the eenv->pd_cap capping in eenv_pd_busy_time() for patch-1;
(2) change commit-message for patch-1;
(3) add patch 2.

Xuewen Yan (2):
  sched/fair: Prevent cpu_busy_time from exceeding actual_cpu_capacity
  sched/fair: Use actual_cpu_capacity everywhere in util_fits_cpu()

 kernel/sched/fair.c | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

-- 
2.25.1


