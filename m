Return-Path: <linux-kernel+bounces-223815-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 630AA911880
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 04:30:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 938691C21FBA
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 02:30:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 936A884A32;
	Fri, 21 Jun 2024 02:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="LFaaQHuF"
Received: from out-176.mta1.migadu.com (out-176.mta1.migadu.com [95.215.58.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49C1484DF3
	for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2024 02:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718937040; cv=none; b=l5+qQfI0YRgRPd1DJvn5Nuab5CNfp48wMSagaKpRUTIG6c8LQ0Od9V0aZR+DmsPHx03ywVYu+6Odvltl7MVguQXFsmpwQmM6C/1PWIdWSnOCIAFPQ1ipBs8HzDGta5+SR1y1o/QsGCnXCvNT9doteo+/YmADVUBQXZf59Q1ZAdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718937040; c=relaxed/simple;
	bh=IvUahLdkAWsT0DyMoo0nWfRIE82JlJ4RiyiCi1JbJIA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AZ2ZdYYkWf+T25sx38IibW/O8ZnvbLMbWOfVi8sQDdtoQIzlwVliGH7qZnfsbwAAELjaKs5iz5291JgsKIGx8tpg6DEeCDfQRF5rXQmfH1QFlAi5SlnjsN17QHxtZrKSim4UgACQWHkMiHGOL3nHW1JjwiozbNzFwZnMG5RM3jw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=LFaaQHuF; arc=none smtp.client-ip=95.215.58.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: david@redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1718937035;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HJJW6TUqMjLFLQtgjZhVZ17u48+rsfSnvst6a4mvURc=;
	b=LFaaQHuF1F5v89s/+sweoMkcHWWX5cImYb3O9dUCuBuZSArq+34Y1Fo1ifWMEUyTQowSsp
	Tywpo9TTBxjaHU79PcH4sIBxeWlytJNLgrrJmFBhpGGVzZrO4rRVpHpOMO7k4o0IpCEj/H
	xRYTbwz+dtF7LTvlPxfJTCIRaSEiTLY=
X-Envelope-To: sfoon.kim@samsung.com
X-Envelope-To: akpm@linux-foundation.org
X-Envelope-To: linux-mm@kvack.org
X-Envelope-To: linux-kernel@vger.kernel.org
X-Envelope-To: sungguk.na@samsung.com
X-Envelope-To: sw0312.kim@samsung.com
X-Envelope-To: sebuns@gmail.com
Message-ID: <9e4bba64-c13f-4157-9258-c9b647ba9dd2@linux.dev>
Date: Fri, 21 Jun 2024 10:30:22 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v2] mm: ksm: Consider the number of ksm_mm_slot in the
 general_profit calculation
To: David Hildenbrand <david@redhat.com>, Sung-hun Kim
 <sfoon.kim@samsung.com>, akpm@linux-foundation.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
Cc: sungguk.na@samsung.com, sw0312.kim@samsung.com, sebuns@gmail.com
References: <CGME20240620043920epcas1p1b57dce789304aa96fd83e5b2b194d244@epcas1p1.samsung.com>
 <20240620043914.249768-1-sfoon.kim@samsung.com>
 <254bf3e0-0056-4593-94ee-8431a1bfc430@redhat.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Chengming Zhou <chengming.zhou@linux.dev>
In-Reply-To: <254bf3e0-0056-4593-94ee-8431a1bfc430@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 2024/6/21 03:38, David Hildenbrand wrote:
> On 20.06.24 06:39, Sung-hun Kim wrote:
>> The current version of KSM does not take into account the number of
>> used ksm_mm_slot. Therefore, when users want to obtain profits of
>> KSM, KSM omits the memory used for allocating ksm_mm_slots.
>>
>> This patch introduces a new variable to keep track of the number of
>> allocated ksm_mm_slots. By doing so, KSM will be able to provide a
>> more accurate number of the gains made.
> 
> If you take a look at the calculation explained in 
> Documentation/admin-guide/mm/ksm.rst, we only care about rmap_items, 
> which can grow rather substantially in size.
> 
> We also don't consider other metadata, such as the size of the stable 
> nodes etc. So why should the ksm_mm_slots matter that much that we 
> should track them and account them?

BTW, the size of stable_nodes should be more than these mm_slots,
we have one stable_nodes for each KSM page now.

But agree, we only care about the rmap_items, which is the majority
of used memory resource in KSM.


