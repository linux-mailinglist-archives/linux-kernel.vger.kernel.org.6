Return-Path: <linux-kernel+bounces-447540-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01E0C9F33F3
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 16:03:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 422C71677CA
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 15:03:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3549132139;
	Mon, 16 Dec 2024 15:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="nW8h8pYn"
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 113F23BBF2
	for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 15:03:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734361403; cv=none; b=h/+9UuDpiQM5e2ba8JE7OFeQYiEmlxjrWuNOG9q+5EWLbXmczPlx53ASRl0ajQ7yHbAQmY1venGDqWkA1Vk2s18qW27ffKKh62EpPHmUksFAk99BIbKdAk2mSkLTtxd4FzCP6Afo1pIx2rJvR7s9JExSxtdGb9TZybQZYzvruX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734361403; c=relaxed/simple;
	bh=F3+VJ2ov/lCjL6DAzFNTu1n2wSKid+JnAZqHmoZtcAk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XXxVbmNWtaBy9uLMAnnG2tI0MdWf2DWaChZsz5QS7JDrpkXCfOkWUXWjD10tYRr3KTiPuNcWreqp/7oFKGEHI4NnXhJ37FCeZBBULIj0lLmwP4ld/SnuM9pZ+++myHcOwFMpBJEc6oHzi/NUBUZtSOR4HuU/Vu0esxc0FaIiPfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=nW8h8pYn; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=RWy/l+pIqnkICVEwQjLLtGaE1doaNAg3RcAZGMxZIyg=; b=nW8h8pYn6RzbO+tjVlfbOjbCNP
	zsbROmnAPgVOzguYSWrHv3Bh76D/6h1kNJ6cAuLUXhaDpReCX3mKbqv5XjqoyKgWy8e+lnUy/gcOV
	rXUn7RYsvCN1KrPjjIr4a5dh+AwNxe9Wd3leXkbTYo7XNAcUAIO68hrOcAUWPy36/SqO1uA47lsqR
	Y8Q5AqdeJdOpRgbc0Ssz8CHqMdO/gMjh0khDOuQDJoTzfZGRz6F3kNzbo1VRAJ8zJ+H8xPBONy1tQ
	N/qPxYXK/6CX9SImNdJYU6myk31EP2rAyD6mIdyh2Fa7q5WW+cjxAu2qaA85WBERzM9rqe/X0+y6J
	hOzM8WxQ==;
Received: from [58.29.143.236] (helo=[192.168.1.6])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1tNCcV-003p0O-9A; Mon, 16 Dec 2024 16:02:51 +0100
Message-ID: <df48db50-54dd-4ad4-a92b-3df6d7b8f8a6@igalia.com>
Date: Tue, 17 Dec 2024 00:02:45 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 4/6] sched_ext: Add time helpers for BPF schedulers
To: Andrea Righi <arighi@nvidia.com>, Changwoo Min <multics69@gmail.com>
Cc: tj@kernel.org, void@manifault.com, mingo@redhat.com,
 peterz@infradead.org, kernel-dev@igalia.com, linux-kernel@vger.kernel.org
References: <20241216031144.98097-1-changwoo@igalia.com>
 <20241216031144.98097-5-changwoo@igalia.com> <Z1_Yh7V_4EEXswkY@gpd3>
From: Changwoo Min <changwoo@igalia.com>
Content-Language: en-US, ko-KR, en-US-large, ko
In-Reply-To: <Z1_Yh7V_4EEXswkY@gpd3>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hello,

On 24. 12. 16. 16:36, Andrea Righi wrote:
> Hi Changwoo,
> 
> On Mon, Dec 16, 2024 at 12:11:42PM +0900, Changwoo Min wrote:
>> The following functions are added for BPF schedulers:
>> - vtime_delta(after, before)
>> - vtime_after(a, b)
>> - vtime_before(a, b)
>> - vtime_after_eq(a, b)
>> - vtime_before_eq(a, b)
>> - vtime_in_range(a, b, c)
>> - vtime_in_range_open(a, b, c)
> 
> Considering that we sync these headers and sched examples from the scx repo
> (see https://github.com/sched-ext/scx/blob/main/scheds/sync-to-kernel.sh),
> maybe we could have a corresponding change there as well and include a link
> to the PR here (as "Link: ...").
> 
> Moreover, tis particular change doesn't require to have the rest of the
> patch set applied to the kernel, so a PR can be created even now. In this
> way we don't risk to get out of sync.
> 
> What do you think?

Thanks for the suggestion! As soon as there is a consensus,
I will submit a PR on the scx repo for the common.bpf.h and the
affected scx schedulers.

Regards,
Changwoo Min

