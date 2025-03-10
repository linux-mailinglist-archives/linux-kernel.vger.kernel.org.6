Return-Path: <linux-kernel+bounces-554086-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 061ADA592C5
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 12:32:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A81B33A78B2
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 11:32:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2F0321E086;
	Mon, 10 Mar 2025 11:32:36 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E81A5215F49
	for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 11:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741606356; cv=none; b=XG23rzIy8GLx7v9zvGN78NJnuSnoxmysifgDARZ6bzoSp1anfr5BTVwxmvg8vTixtJfg4dHmEfyfszSb4gHyovqBrugcQys3no2wJM6GI0Qz2Gl2SfdOegti/C5IHO69Ci8d3Cn9zE+WfWsh4W0H21TjB2E1Yvs0bLcPDJtgshg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741606356; c=relaxed/simple;
	bh=JagBzIBQNhpz5CZMHw94+92WYsZ3sjIZ7fTM9v801Go=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZxF8SZ4e5NH8iZUdlPXjiKGdEjvk9lPHtfLrEeOFseVNSWKfZVhvTOKzWNu22dmzk7Bj8LCPzAWX+sHzf9s6JEN13MyVCBrHPgd19YxEKIVhEiA5SQBXF7YtvSZkAPqYrh9JJiaxM7g7/c5HAXkCOXLxN/9HGniDzcjvTP4pmDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B2CB61516;
	Mon, 10 Mar 2025 04:32:45 -0700 (PDT)
Received: from ewhatever.cambridge.arm.com (ewhatever.cambridge.arm.com [10.1.197.1])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id BB21B3F5A1;
	Mon, 10 Mar 2025 04:32:32 -0700 (PDT)
From: Suzuki K Poulose <suzuki.poulose@arm.com>
To: mike.leach@linaro.org,
	james.clark@linaro.org,
	alexander.shishkin@linux.intel.com,
	bigeasy@linutronix.de,
	clrkwllms@kernel.org,
	rostedt@goodmis.org,
	Yeoreum Yun <yeoreum.yun@arm.com>
Cc: Suzuki K Poulose <suzuki.poulose@arm.com>,
	coresight@lists.linaro.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-rt-devel@lists.linux.dev
Subject: Re: [PATCH v6 0/9] coresight: change some driver' spinlock type to raw_spinlock_t
Date: Mon, 10 Mar 2025 11:32:05 +0000
Message-ID: <174160625284.2197960.9649186230571551042.b4-ty@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250306121110.1647948-1-yeoreum.yun@arm.com>
References: <20250306121110.1647948-1-yeoreum.yun@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Thu, 06 Mar 2025 12:11:01 +0000, Yeoreum Yun wrote:
> In some coresight drivers, drvdata->spinlock can be held during __schedule()
> by perf_event_task_sched_out()/in().
> 
> Since drvdata->spinlock type is spinlock_t and
> perf_event_task_sched_out()/in() is called after acquiring rq_lock,
> which is raw_spinlock_t (an unsleepable lock),
> this poses an issue in PREEMPT_RT kernel where spinlock_t is sleepable.
> 
> [...]

Applied, thanks!

[1/9] coresight: change coresight_device lock type to raw_spinlock_t
      https://git.kernel.org/coresight/c/26f060c1
[2/9] coresight-etm4x: change etmv4_drvdata spinlock type to raw_spinlock_t
      https://git.kernel.org/coresight/c/743c5a97
[3/9] coresight: change coresight_trace_id_map's lock type to raw_spinlock_t
      https://git.kernel.org/coresight/c/4cf364ca
[4/9] coresight-cti: change cti_drvdata spinlock's type to raw_spinlock_t
      https://git.kernel.org/coresight/c/e3044065
[5/9] coresight-etb10: change etb_drvdata spinlock's type to raw_spinlock_t
      https://git.kernel.org/coresight/c/6b80c0ab
[6/9] coresight-funnel: change funnel_drvdata spinlock's type to raw_spinlock_t
      https://git.kernel.org/coresight/c/56eb02f0
[7/9] coresight-replicator: change replicator_drvdata spinlock's type to raw_spinlock_t
      https://git.kernel.org/coresight/c/982d0a0e
[8/9] coresight-tmc: change tmc_drvdata spinlock's type to raw_spinlock_t
      https://git.kernel.org/coresight/c/db11f75b
[9/9] coresight/ultrasoc: change smb_drv_data spinlock's type to raw_spinlock_t
      https://git.kernel.org/coresight/c/d11eb31d

Best regards,
-- 
Suzuki K Poulose <suzuki.poulose@arm.com>

