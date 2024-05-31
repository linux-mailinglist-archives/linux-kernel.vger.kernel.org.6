Return-Path: <linux-kernel+bounces-196805-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 582FF8D61FB
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 14:40:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E92211F2238A
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 12:40:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F059D15AACD;
	Fri, 31 May 2024 12:38:22 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59C32158206
	for <linux-kernel@vger.kernel.org>; Fri, 31 May 2024 12:38:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717159102; cv=none; b=Awdz5lVxzDJyo/8RGx8YcIiQt/TfF0XpFVnzizxtMVZrZrH6iAKebebeYNNDqKOHSeDwKo2u9T3XiOWZ9tSdJJsVV7IDsXgQy4kBVbsctNjaAExP2RI9KhznpSqt+ejeHuKKs0Fa7MqpzpSrvpymIjP5ZiaP1R6Y2B1CvRz6K5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717159102; c=relaxed/simple;
	bh=7BKfN6/AoLY4VubHJyLreI/VATH/d4iqbNxSWMuyoOs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rimOHn7+jusL5nhrKvFcki75wXAiNWA1ZHyhV8n1N2s6c9sqNIHXC37qzanFhI+sU8OqCeRkubrW582HLoSIRr7N3nAWWSgU1eHKrNzX4ur+nxvXX8aceeHm8kM+4vj7Y9eq+s/FWIeunmM2XeH5LNs2F3lSuBkSrs6G7MuzRFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B32661424;
	Fri, 31 May 2024 05:38:43 -0700 (PDT)
Received: from [10.162.41.15] (e116581.arm.com [10.162.41.15])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E1F043F792;
	Fri, 31 May 2024 05:38:17 -0700 (PDT)
Message-ID: <7be21e02-9ddc-4fea-9301-6f80eed5ad0e@arm.com>
Date: Fri, 31 May 2024 18:08:14 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [External] Re: [QUESTION] mm: Redundant const parameter?
To: Chengming Zhou <zhouchengming@bytedance.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 Anshuman.Khandual@arm.com
References: <e5f01ffe-de51-4079-a87f-2886788422f9@arm.com>
 <e6b7858b-39cd-432d-9206-4ccbd153baa2@arm.com>
 <7f7c3bbe-e250-420d-a7d5-89508d881f0b@bytedance.com>
Content-Language: en-US
From: Dev Jain <dev.jain@arm.com>
In-Reply-To: <7f7c3bbe-e250-420d-a7d5-89508d881f0b@bytedance.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Yes; Matthew just did a wider fix:

https://lore.kernel.org/all/20240531122904.2790052-1-willy@infradead.org/


On 5/31/24 18:00, Chengming Zhou wrote:
> On 2024/5/31 19:31, Dev Jain wrote:
>> I guess it would be better if I send this as a patch and wait for comments.
> Ah, you're right. I think it should be:
>
> 	return folio_test_workingset(slab_folio(slab));
>
> Right? Don't notice there isn't any build warning about this "const" discard.
>
> Thanks.
>
>> On 5/31/24 16:42, Dev Jain wrote:
>>> Hi Chengming,
>>>
>>> In mm/slub.c, you had defined slab_test_node_partial() to take a const parameter.
>>>
>>> Is there any point of taking in a const, when you are anyways typecasting it to
>>>
>>> a (struct folio *) from (const struct folio *) ? In fact, at the place where you call
>>>
>>> slab_test_node_partial(), the struct slab *slab is not const.
>>>
>>> Please comment.
>>>
>>>
>>> Thanks
>>>
>>> DJ
>>>
>>>
>>>
>>>

