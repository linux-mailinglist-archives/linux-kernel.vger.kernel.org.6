Return-Path: <linux-kernel+bounces-169861-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 059098BCEAB
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 15:03:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3758E1C23B6A
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 13:03:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED7F77640D;
	Mon,  6 May 2024 13:03:15 +0000 (UTC)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA8A644C66
	for <linux-kernel@vger.kernel.org>; Mon,  6 May 2024 13:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715000595; cv=none; b=AfzKvA38ExsF/2nfOZsbQK1ruZXRI4qD3c02p4oRWO87V+zbx/bVlNLklxvLCqdI+isrnKX0/7LQOrel9xUg8Kujlcr688V821Ht7iBhwcWfSW9XcQR5mbWjoXPStPUzFOjSE9p2fxPdPA86AOMdzK3mv8QgzAuaVNgSC6JP+ig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715000595; c=relaxed/simple;
	bh=gwzOxPBdF5rxVG7uYDhrCz5bnRPot0fU5v6oUNhszQo=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=DylRyEzPxUCVqOMuuY+IqMoXEEQR4AzFmT7XsW/Jm9iVW4yFr8MO4ADT3M3CxaQoO8bo6EatLnhvp0BeM8rezsD4DWMQd4054zkaoVPzd5Ga3BLOX9dCRd01b9nTWLExLeagF47FrMLWIziM/BQcKyUyz5aAVSXL25X/mBX80Kc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4VY1hb6RJjztTBc
	for <linux-kernel@vger.kernel.org>; Mon,  6 May 2024 20:59:43 +0800 (CST)
Received: from kwepemi500008.china.huawei.com (unknown [7.221.188.139])
	by mail.maildlp.com (Postfix) with ESMTPS id D3866180065
	for <linux-kernel@vger.kernel.org>; Mon,  6 May 2024 21:03:07 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemi500008.china.huawei.com
 (7.221.188.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Mon, 6 May
 2024 21:03:07 +0800
From: Jinjie Ruan <ruanjinjie@huawei.com>
To: <tglx@linutronix.de>, <linux-kernel@vger.kernel.org>
CC: <ruanjinjie@huawei.com>
Subject: [PATCH 0/5] genirq/irqdomain: Clean up the irqdomain code
Date: Mon, 6 May 2024 21:02:18 +0800
Message-ID: <20240506130223.317265-1-ruanjinjie@huawei.com>
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
 kwepemi500008.china.huawei.com (7.221.188.139)

Clean up some irqdomain code to make it more readable.

Jinjie Ruan (5):
  genirq/irqdomain: Clean up for irq_create_fwspec_mapping()
  genirq/irqdomain: Simplify the checks for irq_default_domain
  genirq/irqdomain: Clean code for irq_create_direct_mapping()
  genirq/irqdomain: Simplify the checks for irq_domain_push/pop_irq()
  genirq/irqdomain: Clean up for irq_domain_xlate_*

 kernel/irq/irqdomain.c | 168 +++++++++++++++++++++--------------------
 1 file changed, 85 insertions(+), 83 deletions(-)

-- 
2.34.1


