Return-Path: <linux-kernel+bounces-354872-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C6AE9943CF
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 11:13:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 896B7283BB1
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 09:13:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5D5F16C854;
	Tue,  8 Oct 2024 09:12:01 +0000 (UTC)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 721BB770FE;
	Tue,  8 Oct 2024 09:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728378721; cv=none; b=JwXAPYPUVpeXTKLDSJxsw2Qict7aKckgTwALo5ZK5L3TRxIExGrXnwvpWsljWRgeAp555jTkoCPfMnrzTlgQcSN1JwhTQfxO3OYGaF2PRJgIqMQ6rVeUFyZ0T4p7/UoCcVVY3PRRVVpes2oIoa1siA+km+eSQlIBHCZCVD/vBVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728378721; c=relaxed/simple;
	bh=thM8o2wwoVtpiiqBr3Q2+keyw5/klH6p0n/fmAStSik=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=i8ZMR8G3tWORADH6TdSd0R+hjehDAWjixvWztwtbxI3pgCxOesmmDsg03LSxz+AHvKXuvStMLMCk8qrXeuAcGYlcLDLadnILgZwUNmjWX63J9YDVjRT+P20JryZKMhfbMTvKFCv9pVFcgZtzL9goWbOJ12EEQaowQYtkb6TpVSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4XN9FS5Q27zfd8R;
	Tue,  8 Oct 2024 17:09:32 +0800 (CST)
Received: from kwepemh500013.china.huawei.com (unknown [7.202.181.146])
	by mail.maildlp.com (Postfix) with ESMTPS id 03E02140202;
	Tue,  8 Oct 2024 17:11:56 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemh500013.china.huawei.com
 (7.202.181.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 8 Oct
 2024 17:11:55 +0800
From: Jinjie Ruan <ruanjinjie@huawei.com>
To: <bryan.whitehead@microchip.com>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<anna-maria@linutronix.de>, <frederic@kernel.org>, <tglx@linutronix.de>,
	<richardcochran@gmail.com>, <johnstul@us.ibm.com>,
	<UNGLinuxDriver@microchip.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: <ruanjinjie@huawei.com>
Subject: [PATCH v5 0/2] posix-clock: Fix missing timespec64 check for PTP clock
Date: Tue, 8 Oct 2024 17:10:59 +0800
Message-ID: <20241008091101.713898-1-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemh500013.china.huawei.com (7.202.181.146)

Check timespec64 in pc_clock_settime() for PTP clock as
the man manual of clock_settime() said.

Changes in v5:
- Use timespec64_valid_strict() instead of timespec64_valid()
  as Thomas suggested.
- Add fix tag.
- Update the commit message.

Changes in v4:
- Check it in pc_clock_settime() for PTP clock.
- Update the commit message.

Changes in v3:
- Check it before call clock_set().
- Update the commit message.

Jinjie Ruan (2):
  posix-clock: Fix missing timespec64 check in pc_clock_settime()
  net: lan743x: Remove duplicate check

 drivers/net/ethernet/microchip/lan743x_ptp.c | 35 ++++++++------------
 kernel/time/posix-clock.c                    |  3 ++
 2 files changed, 17 insertions(+), 21 deletions(-)

-- 
2.34.1


