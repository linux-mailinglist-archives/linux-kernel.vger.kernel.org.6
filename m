Return-Path: <linux-kernel+bounces-405129-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C20F29C4D44
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 04:25:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 780E41F24093
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 03:25:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69339207A14;
	Tue, 12 Nov 2024 03:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="NBM/8WaC"
Received: from out30-100.freemail.mail.aliyun.com (out30-100.freemail.mail.aliyun.com [115.124.30.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 041C1205E07
	for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 03:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731381907; cv=none; b=KGtZcWN1gXKfa9x9ovEsC5QiMyWGotbwZ0O7wpVopH6UJoC5FaETaSNfEYYkQS9DVO1/c3eRyefyQC9TxfJmzxh6PH1Wp8ZQHUNNhZjpMv6Q/QIoVaXl0pLVWmjl7gaEsKhg9q+Fi3gHAC9yN88GwmPZ/d7NDZNW/i2B9wAos/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731381907; c=relaxed/simple;
	bh=kn1gYXO/v1bfdr2ZPQMn9W/jEO1M6DNSL2gX4zpbMpY=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=FqxT8f7oN/cL3uCRG3tQ8MjMngq36Z6XybOnkG91uu7yV+RukjrXYf1g3C9ah8u8T+FiqRmdGTFtrU4xHBuNP7Doj0vd1UYStZXRVaFroFACI5G/OmpwuQpZlRQ0iVJw77W6qXvV7PQwdhcYDTnlzSSzFkGskKl4DR6jR9n3bPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=NBM/8WaC; arc=none smtp.client-ip=115.124.30.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1731381902; h=Message-ID:Date:MIME-Version:From:Subject:To:Content-Type;
	bh=KgIRNYDhY9EAh9fPUL3XskT47uBrOTIW3SDCyZ15hLI=;
	b=NBM/8WaCLTU87+7um8aoAO8rVSqGo8UlNu1qkpTvPgcsRW2e5gLv+zjnZrbyW7dNLQVJ+NC/lyDCSemG92CeBQElJbFrXzrdChgOWPMzi6Yq2Y6HpQf8/uxg8upMgKTtsW6Rl/hG+p6QK1QXBY7vCy9AdYP5x7IV+3Qw7ZAfjYQ=
Received: from 30.74.129.181(mailfrom:dtcccc@linux.alibaba.com fp:SMTPD_---0WJFTR4w_1731381900 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 12 Nov 2024 11:25:01 +0800
Message-ID: <2c4654d1-f212-43ac-abf9-de6d08c85387@linux.alibaba.com>
Date: Tue, 12 Nov 2024 11:25:00 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Tianchen Ding <dtcccc@linux.alibaba.com>
Subject: Re: [PATCH v2] sched/eevdf: Force propagating min_slice of cfs_rq
 when a task changing slice
To: linux-kernel@vger.kernel.org
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 Juri Lelli <juri.lelli@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
 Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>
References: <20241028063313.8039-2-dtcccc@linux.alibaba.com>
 <20241031094822.30531-1-dtcccc@linux.alibaba.com>
Content-Language: en-US
In-Reply-To: <20241031094822.30531-1-dtcccc@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024/10/31 17:48, Tianchen Ding wrote:
> When a task changes slice and its cgroup se is already on_rq, the cgroup
> se will not be enqueued again, and hence the root->min_slice leaves
> unchanged.
> 
> Force propagating it when se doesn't need to be enqueued (or dequeued).
> Ensure the se hierarchy always get the latest min_slice.
> 
> Fixes: aef6987d8954 ("sched/eevdf: Propagate min_slice up the cgroup hierarchy")
> Signed-off-by: Tianchen Ding <dtcccc@linux.alibaba.com>

ping for this fix.

