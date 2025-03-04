Return-Path: <linux-kernel+bounces-543248-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 199EFA4D333
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 06:58:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E311E7A675D
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 05:57:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D6AA1F461A;
	Tue,  4 Mar 2025 05:58:49 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BFDA1F1911
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 05:58:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741067928; cv=none; b=JpO3kd+lrCWUCQJ9oNGqLiBk3nV9C8WmdxC+SatGlKScaOzgYuEfsf3vvM58IQl9dXpSUHaDGxQWmvUPEEdr1eSGqkUfH0s80asJRXFu7YCyIKF8XuWG8xmGVtkK2VRcyUNwHY2dyy73Bu3Ty/1VL70+SPe9pLAhmcqPM0/qlhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741067928; c=relaxed/simple;
	bh=PLhlFlasGVF1dfFP5lwcSRLgj2MqcjZL3KxVTGXQsTQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OLWj6DTCpQXq7xyzDcSkFrxEbw6Ytkp7RmGoiEqOeyLMiWFefVhDHe7BQd5ROIh+uh7yFKs3bVwTeQDvhwL1G5yAKrl1bBSxgdwGKYQ6G5blejBue42/oEAW+ieNmevygXNaaAS5LhbN/q/dPuiqAEXPXSkHuLoEcf8gHWEUZts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8B70B1063;
	Mon,  3 Mar 2025 21:58:59 -0800 (PST)
Received: from [10.162.42.65] (K4MQJ0H1H2.blr.arm.com [10.162.42.65])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 986CA3F5A1;
	Mon,  3 Mar 2025 21:58:43 -0800 (PST)
Message-ID: <921fb496-ae14-4b6d-86a5-a18c492872f9@arm.com>
Date: Tue, 4 Mar 2025 11:28:40 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] Optimize __vmalloc_node_range_noprof function.
To: Uladzislau Rezki <urezki@gmail.com>, Liu Ye <liuye@kylinos.cn>
Cc: akpm@linux-foundation.org, hch@infradead.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
References: <20250303094410.437985-1-liuye@kylinos.cn>
 <Z8XUP10G3cTJlbuw@pc636>
Content-Language: en-US
From: Dev Jain <dev.jain@arm.com>
In-Reply-To: <Z8XUP10G3cTJlbuw@pc636>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 03/03/25 9:39 pm, Uladzislau Rezki wrote:
> On Mon, Mar 03, 2025 at 05:44:06PM +0800, Liu Ye wrote:
>> The use of variables real_size and real_align in function
>> __vmalloc_node_range_noprof is unreadable. Optimize it in four patches.
>>
>> Liu Ye (4):
>>    mm/vmalloc: Remove unnecessary size ALIGN in
>>      __vmalloc_node_range_noprof
>>    mm/vmalloc: Size should be used instead of real_size in
>>      __vmalloc_node_range_noprof
>>    mm/vmalloc: Remove the real_size variable to simplify the code in
>>      __vmalloc_node_range_noprof
>>    mm/vmalloc: Rename the variable real_align to original_align to
>>      prevent misunderstanding
>>
>>   mm/vmalloc.c | 20 ++++++++------------
>>   1 file changed, 8 insertions(+), 12 deletions(-)
>>
>> -- 
> Let me double check it. Quick question, this series does not
> introduce any functional change?

Yeah, the cover letter subject is misleading. IMHO it should be more 
like "Refactor" instead of "Optimize".
> 
> --
> Uladzislau Rezki
> 


