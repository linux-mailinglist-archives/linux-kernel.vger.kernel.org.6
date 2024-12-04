Return-Path: <linux-kernel+bounces-430584-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BB859E3337
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 06:41:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E28F3283DB1
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 05:41:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10CCC18452C;
	Wed,  4 Dec 2024 05:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="iWNxx13a"
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B197D2F22
	for <linux-kernel@vger.kernel.org>; Wed,  4 Dec 2024 05:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733290887; cv=none; b=W2ojiFE3+B4+N0L1IhL10cPV21C2mYxHCXskmxgj+kTaxmqvvxV9u5F6EaCSDfNftDqCN0lhtFFX6/kURTK06EQTK0qA28iAaMaf5Kdo04oEqdcZ34vhSQdtKkg1YTdXkrMWWP//ameLIpl42THkBFb8N1Ex42fxbl783IvWhk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733290887; c=relaxed/simple;
	bh=txgP/WDyf6EloOO9JeAgUeTximuAKBibO8nbFxqa1vw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VB9jf2Yarb0aCVj9B1+yyu2QIU+IS909mTItrguc6d0qx0wNyZEMW8MERlvk+b1BsEA4u5/6jds69nGi5kucL8LyZOtjjdcr9JgRaWJdBsLe+jytbQ3kz5+6nS1vqY7/dM3vKJNbvtdpJ3Vi1JQsIab3TIl66K78AZ3HUIg9Nmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=iWNxx13a; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=Wxk4D9G1KSJy90rYKxSNVVWV6ZEUKKzXnYrKDuf3apQ=; b=iWNxx13aQcGit2EsaNdzsecAaI
	PmNHEPEUQNSyFBOp+H0XooRDjzFmwgIs+z2xRZhaygYzabV+Y2kMvk7kahlHdVyw8NZqqtYr/PaeW
	jYGwkUV+i2SjFQcpTgfTOiImyz7RZK71UDktDfJMvQc3T1/LJUWOhBJsTUi5UBx5+alqdT0euaWPx
	fWzViz/l3W+DT64M+2rw/C9YbBDZBV8ZQy1ydjKUTf2nVTB43TTXZOvRQBG9OrhbYCcGKcQp1x+YK
	N2Pr8c7zd1hzxtNRFSH08OBtKzaE7+Xzzq3No3TDf+qSe4ENskVmd6TslAx9Z7KeE0OsTj/HNe73e
	aUAliRLQ==;
Received: from [58.29.143.236] (helo=[192.168.1.6])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1tIi8O-00GNEk-IF; Wed, 04 Dec 2024 06:41:12 +0100
Message-ID: <30f6b59b-f288-4923-9d06-25e0138cfe29@igalia.com>
Date: Wed, 4 Dec 2024 14:41:07 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 5/5] sched_ext: Replace bpf_ktime_get_ns() to
 scx_bpf_clock_get_ns()
To: Tejun Heo <tj@kernel.org>, Changwoo Min <multics69@gmail.com>
Cc: void@manifault.com, mingo@redhat.com, peterz@infradead.org,
 kernel-dev@igalia.com, linux-kernel@vger.kernel.org
References: <20241203142802.36305-1-changwoo@igalia.com>
 <20241203142802.36305-6-changwoo@igalia.com>
 <Z0-W4CxeuInz-dX7@slm.duckdns.org>
From: Changwoo Min <changwoo@igalia.com>
Content-Language: en-US, ko-KR, en-US-large, ko
In-Reply-To: <Z0-W4CxeuInz-dX7@slm.duckdns.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hello,

On 24. 12. 4. 08:40, Tejun Heo wrote:
> On Tue, Dec 03, 2024 at 11:28:02PM +0900, Changwoo Min wrote:
>> @@ -245,7 +245,7 @@ void BPF_STRUCT_OPS(central_running, struct task_struct *p)
>>   	s32 cpu = scx_bpf_task_cpu(p);
>>   	u64 *started_at = ARRAY_ELEM_PTR(cpu_started_at, cpu, nr_cpu_ids);
>>   	if (started_at)
>> -		*started_at = bpf_ktime_get_ns() ?: 1;	/* 0 indicates idle */
>> +		*started_at = scx_bpf_clock_get_ns() ?: 1;	/* 0 indicates idle */
> 
> Not from this commit, but how about scx_bpf_now_ns() for the name?
> 
> Thanks.
> 

That sounds good. I will change the function name in the next version.

Regards,
Changwoo Min

