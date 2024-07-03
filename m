Return-Path: <linux-kernel+bounces-238747-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C922924F7B
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 05:24:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE74328B3AF
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 03:24:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFF49629E4;
	Wed,  3 Jul 2024 03:19:54 +0000 (UTC)
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AABBC5A4D5
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jul 2024 03:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719976794; cv=none; b=drjhlUXBcVisy4RNVbH5VQikXrGypZc052IVUgEnGj/R+rvvZqxGBmMi4XJM9jR+vpsOH3NTyj99Mqn1xMRxrLIslu7Imx1VQMdKAxpZ/5dDGptQnjHoUntrnqD2Vp9KIP9hpmpkpHCjFD1sBImoCbrvqStPZDwNfa3TrACsEFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719976794; c=relaxed/simple;
	bh=oiCyzvhVWFsxF5gVagxoONKhnuv5P6LsvPzbT9fU8Hw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=qXhPQm3hJz4VESIHdbLK1iBoNVc8sf06m8x6s6Tvct5zZFY//8AMWb0kgjCK/bF6JZPzcTjnOxBLd47RFvGKZjsnBvuACfTl7UECS4KuN4yUzbCY/eGHXv1XRuDAzY4HLFVq23jBLtIgDIrnTriOv/kCVQ02lF/qkAiw6pe7TZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4WDQ4N24Zlz4f3jRD
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jul 2024 11:19:32 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id 7DF541A016E
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jul 2024 11:19:43 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.103.91])
	by APP2 (Coremail) with SMTP id Syh0CgBn0YZHw4Rm+T8VBA--.56302S4;
	Wed, 03 Jul 2024 11:19:43 +0800 (CST)
From: Yang Yingliang <yangyingliang@huaweicloud.com>
To: linux-kernel@vger.kernel.org
Cc: mingo@redhat.com,
	peterz@infradead.org,
	juri.lelli@redhat.com,
	vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com,
	rostedt@goodmis.org,
	bsegall@google.com,
	mgorman@suse.de,
	bristot@redhat.com,
	vschneid@redhat.com,
	tglx@linutronix.de,
	yu.c.chen@intel.com,
	tim.c.chen@linux.intel.com,
	yangyingliang@huawei.com,
	liwei391@huawei.com
Subject: [PATCH 0/4] sched/smt: Fix error handling in sched_cpu_deactivate()
Date: Wed,  3 Jul 2024 11:16:06 +0800
Message-Id: <20240703031610.587047-1-yangyingliang@huaweicloud.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:Syh0CgBn0YZHw4Rm+T8VBA--.56302S4
X-Coremail-Antispam: 1UD129KBjvdXoWrCr13Gr15Aw1DWr1xXr4DCFg_yoWxWFX_Ca
	4fGFWUJr1ktFnIgFZxKr47Jryv9FWUuF13KF48CrW7AF1xWwnrWr1qqFWkurn8XrsrWr1f
	trWvvF4Syw1DCjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUb28YFVCjjxCrM7AC8VAFwI0_Xr0_Wr1l1xkIjI8I6I8E6xAIw20E
	Y4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwV
	A0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x02
	67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r106r15McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1l42xK82IY
	c2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s
	026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5MIIYrxkI7VAKI48JMIIF
	0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0x
	vE42xK8VAvwI8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2
	jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07UdxhLUUUUU=
X-CM-SenderInfo: 51dqw5xlqjzxhdqjqx5xdzvxpfor3voofrz/

From: Yang Yingliang <yangyingliang@huawei.com>

sched_smt_present decrement and set_rq_offline() is called before
cpuset_cpu_inactive(), if cpuset_cpu_inactive() fails, these two
things need be rollback.

Yang Yingliang (4):
  sched/smt: Introduce sched_smt_present_inc/dec() helper
  sched/smt: fix unbalance sched_smt_present dec/inc
  sched/core: Introduce sched_set_rq_on/offline() helper
  sched/core: fix unbalance set_rq_online/offline() in
    sched_cpu_deactivate()

 kernel/sched/core.c | 68 +++++++++++++++++++++++++++++++--------------
 1 file changed, 47 insertions(+), 21 deletions(-)

-- 
2.25.1


