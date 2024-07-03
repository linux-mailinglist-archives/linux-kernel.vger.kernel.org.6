Return-Path: <linux-kernel+bounces-240100-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 12F28926924
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 21:50:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C0E932866B8
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 19:50:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2A9C18C324;
	Wed,  3 Jul 2024 19:49:58 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4787217DA39
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jul 2024 19:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720036198; cv=none; b=CbKh6Ok8n8jqdnNPMdjN9MiPuiKpg4nl/dfF3m2PcOCtqHCYnxdqjOIisBOIbPovsfR3t9A8cH9iJNA5uTUCRH8czjC6nFGN4Qa04xx9PS6ecDscFlq6Yv345BGkMi0OHx8WBDOZEXpFIZoxEHfCnqTibYHI+Ht7IdzxYPq8hiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720036198; c=relaxed/simple;
	bh=N4cgWtM+7SQiHfzl70vtIq9YTMJEFhQaGSZKSV+WuFc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=drt8hYIsKRm2sO4ceHenB4n/MJ+dXnqEFhPvG+iUdLTrLXnCVvGZCIz6IJa6tcNlPEnFsm1R8DT9TrJgYQlMBAHCnmB7rbjjYuXFpSvdkjxUWRFZ4OpRccRsdyhl+Qdk6OZBnRdlVikEBm+0k+L0mn03n2m7HtEtIRRA5xUjAgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 34D8B367;
	Wed,  3 Jul 2024 12:50:19 -0700 (PDT)
Received: from [192.168.1.88] (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A6B5D3F73B;
	Wed,  3 Jul 2024 12:49:53 -0700 (PDT)
Message-ID: <11cf1fb4-2f8b-4bcb-a270-c698afbcd20e@arm.com>
Date: Wed, 3 Jul 2024 20:49:51 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] sched/ext: Add BPF functions for uclamp inc and dec
To: Tejun Heo <tj@kernel.org>
Cc: linux-kernel@vger.kernel.org
References: <cover.1719999165.git.hongyan.xia2@arm.com>
 <34f3e33aa236445d677ea2b48d2d556178c1ac34.1719999165.git.hongyan.xia2@arm.com>
 <ZoWVKQ7sD5uz66w5@slm.duckdns.org>
Content-Language: en-US
From: Hongyan Xia <hongyan.xia2@arm.com>
In-Reply-To: <ZoWVKQ7sD5uz66w5@slm.duckdns.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 03/07/2024 19:15, Tejun Heo wrote:
> Hello.
> 
> On Wed, Jul 03, 2024 at 11:07:48AM +0100, Hongyan Xia wrote:
>> +__bpf_kfunc void scx_bpf_uclamp_rq_inc(s32 cpu, struct task_struct *p)
>> +{
>> +	uclamp_rq_inc(cpu_rq(cpu), p);
>> +}
>> +
>> +__bpf_kfunc void scx_bpf_uclamp_rq_dec(s32 cpu, struct task_struct *p)
>> +{
>> +	uclamp_rq_dec(cpu_rq(cpu), p);
>> +}
> 
> So, I don't think we can expose these functions directly to the BPF
> scheduler. The BPF schedulers shouldn't be able to break system integrity no
> matter what they do and with the above it'd be trivial to get the bucket
> counters unbalanced, right?

You are right.

Actually, avoiding double enqueue or dequeue is easy and might be just a 
one-line change. The real concern is when the BPF scheduler somehow 
still has tasks on uclamp buckets when it's unloaded. Then, unloading 
the scheduler needs to do uclamp_dec().

I'll see what I can do.

