Return-Path: <linux-kernel+bounces-183783-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6756D8C9E0C
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 15:21:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F0568B24394
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 13:21:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FDD2136664;
	Mon, 20 May 2024 13:20:49 +0000 (UTC)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50860135A46
	for <linux-kernel@vger.kernel.org>; Mon, 20 May 2024 13:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716211249; cv=none; b=HxJ71i4xCbfuxbOOOf/E/zG4d/Mpt3epXkzUKPQDtfrNiYJxYxTn+vuriSlZrRbMCa07e58vxrRaqTUtxAbwrNgDYTx1T3J1GJ5ft/sIXJnL6yAy9bp3R8q/eqMohAg9RF+X22IAlCcXRgJ1msQ0LW4ils7LNiC1FpAyEq319Ms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716211249; c=relaxed/simple;
	bh=Ohi1BUI+oUAqw309tNWF/kYN5L+Pt9fSMgIrzJRyzNU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=eev3d6/5qFXkQqtU87Y1OWiDCDJZqzezaGFrf1UTPay90rKS9zgm/9nOXGotZsPy0qMPh3EPuywEJclvb57Gw/ucNuR0nloFHgn5mamuz9nS6tKHMrIyjB1QfuSlgC060mjvHRf72iXkRJ8DpYiDshrBpFFRJspBdd8/65MZbyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4VjdPX234CzXgSg;
	Mon, 20 May 2024 21:16:32 +0800 (CST)
Received: from kwepemm600014.china.huawei.com (unknown [7.193.23.54])
	by mail.maildlp.com (Postfix) with ESMTPS id 5AEE9140159;
	Mon, 20 May 2024 21:20:41 +0800 (CST)
Received: from Linux-SUSE12SP5.huawei.com (10.67.136.233) by
 kwepemm600014.china.huawei.com (7.193.23.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 20 May 2024 21:20:40 +0800
From: <zhuqiuer1@huawei.com>
To: <anna-maria@linutronix.de>, <frederic@kernel.org>, <tglx@linutronix.de>,
	<linux-kernel@vger.kernel.org>
CC: <zhuqiuer1@huawei.com>
Subject: Question: One-jiffy latency from the checking in run_local_timers()
Date: Mon, 20 May 2024 21:20:40 +0800
Message-ID: <20240520132040.259477-1-zhuqiuer1@huawei.com>
X-Mailer: git-send-email 2.12.3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemm600014.china.huawei.com (7.193.23.54)

Hi there, the function "kernel/time/timer.c:run_local_timers" avoids raising a softirq when there are no timers set to expire at the current time.
It achieves this by comparing the current "jiffies" with "base->next_expiry". 
However, when working with SMP, it is possible that a few CPUs are reading the jiffies while it is being incremented.
These CPUs may read the old-jiffies value in "run_local_timers" and fail to invoke expired timers at this jiffy.
This results in a one-jiffy latency for the timers. Can we simply add 1 to the "jiffies" value when we compare it with next_expiry?
This may result in an unnecessary softirq being raised if a timer expires in the next jiffy, but can remove the one-jiffy latency. 
Not sure if this is a positive trade-off.

Below is the example that we found to
have a few cpus reading the old-jiffies value while cpu-0 is updating the jiffies:

<idle>-0       [000] d.h.   133.492480: do_timer: updated_jiffies: 4294950645
<idle>-0       [010] d.h.   133.492480: run_local_timers: base->next_expiry: 5368691712, jiffies: 4294950644
<idle>-0       [001] d.h.   133.492480: run_local_timers: base->next_expiry: 4294950645, jiffies: 4294950644
...
<idle>-0       [006] d.h.   133.492481: run_local_timers: base->next_expiry: 4294967808, jiffies: 4294950645
...

We found that in this case the timer on cpu-1 was invoked in next jiffy but not the one it is expected to.

