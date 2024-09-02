Return-Path: <linux-kernel+bounces-310484-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 32EA3967D9E
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 03:57:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C92351F222A6
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 01:57:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A27F528DD1;
	Mon,  2 Sep 2024 01:57:05 +0000 (UTC)
Received: from szxga06-in.huawei.com (szxga06-in.huawei.com [45.249.212.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DBB522309
	for <linux-kernel@vger.kernel.org>; Mon,  2 Sep 2024 01:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725242225; cv=none; b=Y4AStjUdNRfRFDbcApfpj4nPiZypX3t19ZePe0TV2CMeZk5s5hkF2gNW4zQSBs0D9zzvofgWhB85OacHg418hhlgAlKITcn311GEayVPZzx661bghJnbZ/Ze/b2sQe74sdA0Za5++wkQlpibATNY7hyYJ6stYAtgwu5quBoun88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725242225; c=relaxed/simple;
	bh=YPyQe53uoB/79Y4Z+1bwmlKRj8KvOxRSJoVkFUlPcFI=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:CC:References:
	 In-Reply-To:Content-Type; b=EW8J40VAJ7IxXu5y4gph+9UYehTCtr1coAvKCwpi3mm9F9hZaJa9Eoms13K1GQtODlFowM8VUlMF1pXYqQ+0Z5szkMhgIzac5r96vfdh6Vz3w3qCeLW3H8gC5QEyYvHknYmmYW8HDXEnyh5FsYhmg2k+nLz4WQqpteGBqlRAL2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.163])
	by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4WxsJY4KSdz1xwfR;
	Mon,  2 Sep 2024 09:54:53 +0800 (CST)
Received: from kwepemd500019.china.huawei.com (unknown [7.221.188.86])
	by mail.maildlp.com (Postfix) with ESMTPS id 4DDE818002B;
	Mon,  2 Sep 2024 09:56:53 +0800 (CST)
Received: from [10.67.109.61] (10.67.109.61) by kwepemd500019.china.huawei.com
 (7.221.188.86) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 2 Sep
 2024 09:56:52 +0800
Message-ID: <3e68ccda-1606-9494-f57a-75be9668b83d@huawei.com>
Date: Mon, 2 Sep 2024 09:56:51 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: =?UTF-8?Q?=5bQuestion=5d_Include_isolated_cpu_to_ensure_that_tasks_?=
 =?UTF-8?Q?are_not_scheduled_to_isolated_cpu=ef=bc=9f?=
From: zhengzucheng <zhengzucheng@huawei.com>
To: <peterz@infradead.org>, <juri.lelli@redhat.com>,
	<vincent.guittot@linaro.org>, <dietmar.eggemann@arm.com>,
	<rostedt@goodmis.org>, <bsegall@google.com>, <mgorman@suse.de>,
	<bristot@redhat.com>, <vschneid@redhat.com>, <oleg@redhat.com>, Frederic
 Weisbecker <frederic@kernel.org>, <mingo@kernel.org>, <peterx@redhat.com>,
	<tj@kernel.org>, <longman@redhat.com>
CC: <linux-kernel@vger.kernel.org>
References: <20240725120315.212428-1-zhengzucheng@huawei.com>
In-Reply-To: <20240725120315.212428-1-zhengzucheng@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemd500019.china.huawei.com (7.221.188.86)

In a cpuset subsystem, cpuset.cpus contains isolated cpu and 
non-isolated cpu.
Is there any way to ensure that the task runs only on the non-isolated cpus?
eg：
isolcpus=1, cpusete.cpus=0-7. It is found that some tasks are scheduled 
to cpu1.

In addition, task run on isolated cpu cann't be scheduled to other cpu 
in the future.


Thanks!


