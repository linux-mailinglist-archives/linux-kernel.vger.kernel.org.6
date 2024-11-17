Return-Path: <linux-kernel+bounces-412154-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F36729D048B
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Nov 2024 16:47:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8749B1F21B56
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Nov 2024 15:47:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55DA71D90BD;
	Sun, 17 Nov 2024 15:47:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="lv/s2TN3"
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87449A937
	for <linux-kernel@vger.kernel.org>; Sun, 17 Nov 2024 15:47:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731858431; cv=none; b=GNG9r2f7bIye6vfqCUtFKAMmMB9ol80IA4rSmQ9P8ew3rRBqVZ1oQ1aKIMXbNQn2rfy72Q76+xmSASlftMaGQ3fawMyiGg5TgC3JWikNF+MFpugxjr2sEDeAF/GsEVH6GvhEQM44Vw9pPGmrM4tYJeQB1WhPde9ytbtfysW9SvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731858431; c=relaxed/simple;
	bh=v9TPUeQPRGYGn83wtrL7nF7EJUL//cfYSomM10FDQ9E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OD1JDPrgBXotWWDBCGqV9lxN/IzmJ+nRQOmZVjJ83jjRX7wbGGGxUWtobUa0aXsxrjgvJIC4Kk8w2rRNDaglN581LSxefJTUBRSBdmge9ixiaYKRRRvrxkEUCR+Rs/M1lM2ujuWGPjMCAfP4hZjH9HHiOwEBamteXESx5UjWVDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=lv/s2TN3; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=v9TPUeQPRGYGn83wtrL7nF7EJUL//cfYSomM10FDQ9E=; b=lv/s2TN3tEsKeyeN7xlk6r/auo
	Xb+5fVawKngVA0Jx4GXsqAME4/9jiZOcJyDLC9KE0CD282rvD0QAPFg9/Kr+tUDUY85oQQLIXtjVx
	YNCUw888sPOZjkRQjetxoDklhRYt4J0zPtDleCNBEuFyNR3sDQOiqCa3Bhzoz1vcy+6P2YVaf53ho
	dHXLJE6wlUSGlKqzPHnGqixmUIOniAEnEUcZg2Bagy5FT09Wa+HUKO4p0eonVeNhJ8d11SMJA5LF9
	ERMRHHbve4xsnrgfD9F5R+v4y7Ib8oX6c74aJmJrEZGi+V7tFdRcevESUT+zL3EquImbNuPf58CqN
	6zZaBClQ==;
Received: from [58.29.143.236] (helo=[192.168.1.6])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1tChTy-00883Y-BH; Sun, 17 Nov 2024 16:46:38 +0100
Message-ID: <494b8851-ba5b-4205-bea0-dc504c2ffa33@igalia.com>
Date: Mon, 18 Nov 2024 00:46:32 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/5] sched_ext: Manage the validity of scx_rq_clock
To: Peter Zijlstra <peterz@infradead.org>
Cc: tj@kernel.org, void@manifault.com, mingo@redhat.com,
 kernel-dev@igalia.com, linux-kernel@vger.kernel.org,
 Changwoo Min <changwoo@igalia.com>
References: <20241116160126.29454-1-changwoo@igalia.com>
 <20241116160126.29454-3-changwoo@igalia.com>
 <20241116193235.GQ22801@noisy.programming.kicks-ass.net>
From: Changwoo Min <changwoo@igalia.com>
Content-Language: en-US, ko-KR, en-US-large, ko
In-Reply-To: <20241116193235.GQ22801@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hello,

On 24. 11. 17. 04:32, Peter Zijlstra wrote:
> It is not at all clear why you think you need to keep a second copy of
> that value. You like cache misses?

Of course not. :-) I always try to avoid cache misses whenever
possible.

The main reason to keep the second copy (rq->scx.clock) is that
a BPF scheduler can call scx_bpf_clock_get_ns() at almost any
time in any context, including any of sched_ext operations, BPF
timer callbacks, BPF syscalls, kprobes, and so on.

However, the rq->clock is supposed to be updated while holding
the rq lock (lockdep_assert_rq_held), which is not always the
case in a BPF scheduler. Also, rq->clock is also used in other
places (e.g., PELT), so updating rq->clock in arbitrary points by
a BPF scheduler will create unnecessary dependencies.

Another approach would be to extend struct sched_clock_data (in
kernel/sched/clock.c) to store the update flag
(SCX_RQ_CLK_UPDATED). This would be the best regarding the number
of cache line accesses. However, that would be an overkill since
now sched_clock_data stores the sched_ext-specific data.
I thought it would be better to keep sched_ext specific data in
one place, struct scx_rq, for managibility.

Regards,
Changwoo Min

