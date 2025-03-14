Return-Path: <linux-kernel+bounces-560979-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BA539A60BEB
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 09:40:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0A2F117F388
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 08:40:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E40B1C5D59;
	Fri, 14 Mar 2025 08:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="pjRS/BGI"
Received: from out-174.mta1.migadu.com (out-174.mta1.migadu.com [95.215.58.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CDC51953A2
	for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 08:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741941620; cv=none; b=WWsffoXqs/vFt/lIV6RjY0xO0fcQNsb6SRpV7GHzkVIXZ9To98BKeawnlBuje24NfI12QaTBGmPpypOT/21ZACNL0g3HOQcamtUvYfNKhvPH5ox8Sc+Tlkj9UrA0Xz2Z3Vl5gzk+UjFp/+IUKQ6SktDgdGcqav4a8PGkClBsw4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741941620; c=relaxed/simple;
	bh=dXgnNy4EdAhxq4P7gd1/J2JyVUqF4eHwfpEv6G3uglY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TGLOaIjJwNKN7gU2IoImYYJrh1bakYOnJRLgDHTVWdsCYFWp9AURTJvpy4IF9tPTlAH4gbCL9X3OIWz+gmHn61fJoSKnQEbul+12ogdPYO19qKkc0r5XXyMnwIRruSTPZcONnfuWb6uWsKL5lhpiZuk57ZFVOJ+FjTDNMt/AcWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=pjRS/BGI; arc=none smtp.client-ip=95.215.58.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <58e0515a-ed67-4d1a-825f-bfc2b31d1d18@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1741941612;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=owwBGvf1dyRl5XBQtxTZM8guZgh1Q0AjJIbpGLqdE+Q=;
	b=pjRS/BGIHRmzQP4nW9+fgfobQMVbxGyjBcx8T107VbkC+7NQ5lwUsO/P0hAwWw+EBeEpKe
	FDS0o2nG3hjUqtUhsE3ArAnWYE6wgnqAKeCk337OuMBa2D9hp3Hk7fl0R4DhwywEetsM2V
	CTnJN+va8+PyVUiKvazbBT0deOd6Xa8=
Date: Fri, 14 Mar 2025 16:39:41 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [RFC PATCH 2/7] sched/fair: Handle throttle path for task based
 throttle
To: Aaron Lu <ziqianlu@bytedance.com>,
 Valentin Schneider <vschneid@redhat.com>, Ben Segall <bsegall@google.com>,
 K Prateek Nayak <kprateek.nayak@amd.com>,
 Peter Zijlstra <peterz@infradead.org>, Josh Don <joshdon@google.com>,
 Ingo Molnar <mingo@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>
Cc: linux-kernel@vger.kernel.org, Juri Lelli <juri.lelli@redhat.com>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Steven Rostedt <rostedt@goodmis.org>, Mel Gorman <mgorman@suse.de>,
 Chuyi Zhou <zhouchuyi@bytedance.com>
References: <20250313072030.1032893-1-ziqianlu@bytedance.com>
 <CANCG0GcFF7cnR4rCbU5MmY1Gq3M+r4gPXv39QPXXC=Cdr6sRww@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Chengming Zhou <chengming.zhou@linux.dev>
In-Reply-To: <CANCG0GcFF7cnR4rCbU5MmY1Gq3M+r4gPXv39QPXXC=Cdr6sRww@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 2025/3/13 15:21, Aaron Lu wrote:
> From: Valentin Schneider <vschneid@redhat.com>
> 
> Once a cfs_rq gets throttled, for all tasks belonging to this cfs_rq,
> add a task work to them so that when those tasks return to user, the
> actual throttle/dequeue can happen.
> 
> Note that since the throttle/dequeue always happens on a task basis when
> it returns to user, it's no longer necessary for check_cfs_rq_runtime()
> to return a value and pick_task_fair() acts differently according to that
> return value, so check_cfs_rq_runtime() is changed to not return a
> value.

Previously with the per-cfs_rq throttling, we use update_curr() -> put() path
to throttle the cfs_rq and dequeue it from the cfs_rq tree.

Now with your per-task throttling, maybe things can become simpler. That we
can just throttle_cfs_rq() (cfs_rq subtree) when curr accouting to mark these
throttled.

Then then if we pick a task from a throttled cfs_rq subtree, we can setup task work
for it, so we don't botter with the delayed_dequeue task case that Prateek mentioned.

WDYT?

Thanks.

