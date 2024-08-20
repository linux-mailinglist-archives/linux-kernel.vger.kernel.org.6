Return-Path: <linux-kernel+bounces-293657-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DAFEA9582CE
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 11:38:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 818201F21A70
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 09:38:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97F0B18C92A;
	Tue, 20 Aug 2024 09:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="BIUUqygJ"
Received: from out30-111.freemail.mail.aliyun.com (out30-111.freemail.mail.aliyun.com [115.124.30.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84FBD18E024
	for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 09:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724146637; cv=none; b=dasXxKDmqhm6tF71EeRG8RVROcb0UBpeQf4lB9CXtR51sq5ah44R1l4xFcQkKWCQY9i7WBzMUZLh19u5+O/oDA9K6J621TTL5SV7lW90Uuc/fatjtyNHIDfyTLEhswImx8XcXKW6BQ2mAN3erucaQ4gj5jaDgrgzZs6T6B51h0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724146637; c=relaxed/simple;
	bh=c0+Cpp2MEiJrYS849mGqNWpqtLBFu8w0Hu72h4/iaOY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mDen/q3E5Wi8yurRxgdPXd+LiutPt9tOtn2+prb5kzf53BT6juATNdx5Lr5o//ENe+DuzRBXLzjKLHIrZvS7J3kJUzcd/LUBtzUbu5qrqL1o82QS3qhDTTMsuBrUaElh5t52MorYh0K1smzLnVZF6Ykh7JZhh7P0E7BmsjruX/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=BIUUqygJ; arc=none smtp.client-ip=115.124.30.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1724146626; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=l2+jDibFcpxXd+8JTIGUgTimQc0/BrFrXtvpGWrXZNI=;
	b=BIUUqygJonJKevlVRZzaD/QP2Qd7scNjm8QPtz93TrZXe9iSbE48vkTW1GkDqH13+j3F9hJcHyjFSobdT1zbT9ZUZp6/nUmo2ohlObumQFrSojTVpNy4rRrayBbT4J++k8g6SFlq8atsTKjsk1YkS6ONMmNMtH99fO/lWADzP00=
Received: from 30.221.130.129(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WDI3eJo_1724146624)
          by smtp.aliyun-inc.com;
          Tue, 20 Aug 2024 17:37:05 +0800
Message-ID: <4130fe2b-59eb-47ac-9e14-0274bffdefc0@linux.alibaba.com>
Date: Tue, 20 Aug 2024 17:37:04 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] erofs: allow large folios for compressed files
To: Barry Song <21cnbao@gmail.com>
Cc: linux-erofs@lists.ozlabs.org, Chao Yu <chao@kernel.org>,
 LKML <linux-kernel@vger.kernel.org>, Matthew Wilcox <willy@infradead.org>
References: <20240819025207.3808649-1-hsiangkao@linux.alibaba.com>
 <CAGsJ_4yQMN+j2UMWO3ycRqiwh16sOQoSQSMatNg667Qzr=QmPQ@mail.gmail.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <CAGsJ_4yQMN+j2UMWO3ycRqiwh16sOQoSQSMatNg667Qzr=QmPQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2024/8/20 17:29, Barry Song wrote:
> On Mon, Aug 19, 2024 at 2:52 PM Gao Xiang <hsiangkao@linux.alibaba.com> wrote:
>>
>> As commit 2e6506e1c4ee ("mm/migrate: fix deadlock in
>> migrate_pages_batch() on large folios") already landed upstream,
>> large folios can be safely enabled for compressed inodes since all
>> prerequisites already landed in 6.11-rc1.
>>
>> Stress tests has been working on my fleet for > 20 days without any
>> regression.  Besides, users [1] has requested it for months.  Let's
>> allow large folios for EROFS full cases upstream now for wider testing.
>>
>> [1] https://lore.kernel.org/r/CAGsJ_4wtE8OcpinuqVwG4jtdx6Qh5f+TON6wz+4HMCq=A2qFcA@mail.gmail.com
>> Cc: Barry Song <21cnbao@gmail.com>
>> Cc: Matthew Wilcox (Oracle) <willy@infradead.org>
>> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
> 
> Thank you, Xiang! We'll run some tests and update you with our findings.

Yeah, findings and patches are welcome as always.

Thanks,
Gao Xiang

