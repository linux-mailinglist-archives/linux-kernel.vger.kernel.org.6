Return-Path: <linux-kernel+bounces-530619-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BA753A435D9
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 07:57:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B70AE179943
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 06:57:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13FBC2580D7;
	Tue, 25 Feb 2025 06:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="LEugYbsC"
Received: from out30-111.freemail.mail.aliyun.com (out30-111.freemail.mail.aliyun.com [115.124.30.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87F79126C10
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 06:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740466620; cv=none; b=YRTxC6WjeOkC6g4qMQNzqIhkQBkOE9FETiuP8TjYxq75681sYy83f/nMgfPpNaHt75k3XI3wgV8NI+PrixW1B0l14SuNvVPkLL55J492Lc9W63eIU4KuIsNmb9w2atOjnTuSdg0RN7ry+oIenLzIq7PA7OGZpTg5FEwDbBgsM38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740466620; c=relaxed/simple;
	bh=e3+aNYTnbKWJivg+q+Hi3DtLQsrRb9Bk6wUzOAsG45k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iPnIIHVBMLXbvqZq5gdOUbjXNj3LoUvbsa6QNKte8NJ8CHr7zGg84KwzwfyBK0s/lsySHgxqSK44PcKSwqTp1LQLio/sskrXzHfWwCyUcuQatH3ehXlUBfpniUozBKE/nHnxpEA52br4xZ3aW4Z7zF7s6nfVKo9nG9cXVIl6HPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=LEugYbsC; arc=none smtp.client-ip=115.124.30.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1740466614; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=T6xkjDjtY7QYfVEzscO1gyxYmDDVuGprPC6v4IGloFQ=;
	b=LEugYbsCrtVyzRn+C6sFG2K3TxyoIlpDw1T+a94fj9BDPoulJ4/1LtFTj5fbYi1NH31HvTbTViTT1ork+d0nN3+mzwsGnc5Fh7FLdZBLIQZs6sqb7dzKnPF+tGkSG3cvZXy7/UIcrPNwsVHpSEC007/6M3UfXDkYtNKzU8S+jCs=
Received: from 30.74.130.67(mailfrom:dtcccc@linux.alibaba.com fp:SMTPD_---0WQDcYiu_1740466603 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 25 Feb 2025 14:56:53 +0800
Message-ID: <61589e0e-a3d7-490c-8bba-a1ce25f585c3@linux.alibaba.com>
Date: Tue, 25 Feb 2025 14:56:52 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH 2/2] sched/fair: Fix premature check of WAKEUP_PREEMPTION
To: Vincent Guittot <vincent.guittot@linaro.org>
Cc: Madadi Vineeth Reddy <vineethr@linux.ibm.com>,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Juri Lelli <juri.lelli@redhat.com>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
 Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>,
 Josh Don <joshdon@google.com>,
 "open list:SCHEDULER" <linux-kernel@vger.kernel.org>,
 Abel Wu <wuyun.abel@bytedance.com>
References: <20250221111226.64455-1-wuyun.abel@bytedance.com>
 <20250221111226.64455-3-wuyun.abel@bytedance.com>
 <CAKfTPtBzsX6GKZP_NGTONrkp96qx9uOHr0+XG7tC6ELy4tbHBg@mail.gmail.com>
 <6097164a-aa99-4869-b666-9dc7018c1f96@bytedance.com>
 <e1cfabab-1326-4cd8-a8a4-4b3fc4c1f7ec@linux.ibm.com>
 <9d9d7432-9a5d-4216-ac53-a0f333a35d8f@bytedance.com>
 <d1237acd-9e3c-4ab9-8628-31d98fcf7638@linux.ibm.com>
 <83f8b833-af79-4d77-a179-5065aec994dc@bytedance.com>
 <CAKfTPtBL4aPbEDOa8jJ+h2wQ9CLU80=0mQdrc07vfqBVswzAsg@mail.gmail.com>
Content-Language: en-US
From: Tianchen Ding <dtcccc@linux.alibaba.com>
In-Reply-To: <CAKfTPtBL4aPbEDOa8jJ+h2wQ9CLU80=0mQdrc07vfqBVswzAsg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2/24/25 9:47 PM, Vincent Guittot wrote:
[...]
> 
> Or we should just remove it. I'm curious to know who used it during
> the last couple of years ? Having in mind that lazy preemption adds
> another level as check_preempt_wakeup_fair()  uses it so sched-idle
> tasks might not always be immediately preempted anyway.
> 

I just remembered that I've mentioned this issue in another thread[1] 
before. Can we do preempt SCHED_IDLE immediately even in PREEMPT_LAZY? (to 
achieve better response time for SCHED_NORMAL)

[1] 
https://lore.kernel.org/all/8e6f02a0-2bd0-4e75-9055-2cb7c508ce4e@linux.alibaba.com/

