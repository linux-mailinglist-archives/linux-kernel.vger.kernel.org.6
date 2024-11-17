Return-Path: <linux-kernel+bounces-412156-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9137D9D048F
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Nov 2024 16:48:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 56F9C28230A
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Nov 2024 15:48:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D6801D9A67;
	Sun, 17 Nov 2024 15:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="KI+HA7yF"
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 738DA1CCEED
	for <linux-kernel@vger.kernel.org>; Sun, 17 Nov 2024 15:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731858533; cv=none; b=BghuPFo4LPlHBgm3hXxjX90Tz9QtDN+3sCZ1n6Iv0SHvdF5oZBVlx29Te2ShT/YTY00mwb/CEN5ntbt0lWmzo4dfb4UWx/hIj/HK1m53S5vjvB8saWZUR3VAkqgVMENQ6xMEIYoTb0NV2kr5GnaOM+nd5t5BlfLXbck57ZzD2v0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731858533; c=relaxed/simple;
	bh=R/YxH+YIXt1qpyupOvDwiHCZXj259Zfcqib56gCuWxs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JdYsEqoLiThC4HFZvfOvmVkD7BtcgYowYWqVe73+5/EP3/bCnvxyaMsJzquTKSN5/n7W5PnVsed05EouVozhwhtNeJKx4TBYrChVxHfZo3NENrIQSeng22vIpbYaslb6M01kEo4akOxy6yt+JOIBoTmllHCvAsTCXSsqITY7yR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=KI+HA7yF; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=R/YxH+YIXt1qpyupOvDwiHCZXj259Zfcqib56gCuWxs=; b=KI+HA7yFBhjL8uL55w8WtsdWiO
	a/x2zBn8tLAxXModxV9nxV7UW3+AH+TW4b+1cKnSrZm2no5uFaxTkJ08Zk95L6PWP7bMgdaEbgc0e
	m9vVI7F6PesHpR21uy56/gThUU3OnFYlacm9JmfdOATGPB2oms1MINxRkeB5cE4rK2Nuh+PijcktD
	QsWu1GB4GfiqfSqOQh/V76gKbbdQT7bXo1acZwTEVCMFHC/jeFL+hiDmnP6x1QJ1H6jLmI5bNF9pi
	xUYU9LphqvKILoYvYYSvVfPdUi7CErMZU02mfhpVRnp5A6rQeKywg1kjp4cp57IGXjhpiRx/czINb
	CILfZTnQ==;
Received: from [58.29.143.236] (helo=[192.168.1.6])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1tChVw-00885E-5l; Sun, 17 Nov 2024 16:48:40 +0100
Message-ID: <cd08dc10-1763-415f-b9b9-54c0ebc5e32b@igalia.com>
Date: Mon, 18 Nov 2024 00:48:35 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/5] sched_ext: Implement scx_bpf_clock_get_ns()
To: Peter Zijlstra <peterz@infradead.org>
Cc: tj@kernel.org, void@manifault.com, mingo@redhat.com,
 kernel-dev@igalia.com, linux-kernel@vger.kernel.org,
 Changwoo Min <changwoo@igalia.com>
References: <20241116160126.29454-1-changwoo@igalia.com>
 <20241116160126.29454-4-changwoo@igalia.com>
 <20241116193123.GP22801@noisy.programming.kicks-ass.net>
From: Changwoo Min <changwoo@igalia.com>
Content-Language: en-US, ko-KR, en-US-large, ko
In-Reply-To: <20241116193123.GP22801@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hello,

On 24. 11. 17. 04:31, Peter Zijlstra wrote:
> Have you seen the insides of kernel/sched/clock.c ?

Of course. :-) It would be super helpful if you could let me know
specific questions or comments.

I didn't extend (or piggyback) on the clock.c because, as
I explained in the other email, I think it is overkill, creating
dependencies between clock.c and the sched_ext code.

Regards,
Changwoo Min

