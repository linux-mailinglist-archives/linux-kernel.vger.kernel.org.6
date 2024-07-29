Return-Path: <linux-kernel+bounces-265186-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 543A193EDB7
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 08:57:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0AD0E1F22167
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 06:57:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5706784FA0;
	Mon, 29 Jul 2024 06:57:45 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF6FD2119
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 06:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722236264; cv=none; b=kpTCPfxiqGdW3NGeOFePX/CdMdoUMdQzWd/S0X5tCTBGQsqNp6mpqdb3UnYy4/9B4XkLpiVpAp/leoNGSK9xutijAktyXZBGDkpL/HRDKW/WHy98o8y2tEOaGYaoWDl88XRhV/cLb2tSWvlvsVTL02JyYHWBBbC6al1Q+QMRMpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722236264; c=relaxed/simple;
	bh=/iqyysy/rTjDouQo1CLuY4iDF0GK5hSsOCm8rEgNPl4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PbKXi1I2uJC8PjFxBpNfppQY3PoMpOEG0ObwsCe9IBGbFnuKXjsHSui4IDA6/FxpGSSyO/SkVikfe7CE/eTROhCSyv1tOjk0u3GtO0atNXnS+YVWZi6N9IJIV7H6mxMplqaZwgZGn8I7FupWUuQmcxY3bYUKjt2BSzlTlN63+uU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C3503FEC;
	Sun, 28 Jul 2024 23:58:07 -0700 (PDT)
Received: from [10.162.41.10] (a077893.blr.arm.com [10.162.41.10])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0EE283F64C;
	Sun, 28 Jul 2024 23:57:39 -0700 (PDT)
Message-ID: <f71502d2-d216-4377-965f-21583dd7dc31@arm.com>
Date: Mon, 29 Jul 2024 12:27:36 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm/sparse: return right away if sparsemap_buf is null
To: Mike Rapoport <rppt@kernel.org>, Leesoo Ahn <lsahn@ooseel.net>
Cc: Leesoo Ahn <lsahn@wewakecorp.com>,
 Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
References: <20240726071023.4078055-1-lsahn@wewakecorp.com>
 <ZqY81pf9dvl6mvg9@kernel.org>
Content-Language: en-US
From: Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <ZqY81pf9dvl6mvg9@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 7/28/24 18:13, Mike Rapoport wrote:
> On Fri, Jul 26, 2024 at 04:10:23PM +0900, Leesoo Ahn wrote:
>> sparse_buffer_fini(..) takes the following actions even though the value of
>> sparsemap_buf is NULL,
>> 1. calculate size of sparsemap buffer (which is meaningless).
>> 2. set sparsemap_buf variable to NULL (although it is already NULL).
>>
>> These steps are unnecessary if the variable, sparsemap_buf is NULL.
>>
>> Refactor the function to return right away if the variable is NULL.
>> Hence, it doesn't need to take further actions.
> 
> sparse_buffer_fini() is called a few times on init so saving a jump (if at
> all) does not worth the churn.

Agreed, this is not worth the churn given there could be just a single
call instance for sparse_buffer_fini(), either in normal or error path
in sparse_init_nid().

>  
>> Signed-off-by: Leesoo Ahn <lsahn@ooseel.net>
>> ---
>>  mm/sparse.c | 8 ++++++--
>>  1 file changed, 6 insertions(+), 2 deletions(-)
>>
>> diff --git a/mm/sparse.c b/mm/sparse.c
>> index e4b830091d13..091e4bc2f72c 100644
>> --- a/mm/sparse.c
>> +++ b/mm/sparse.c
>> @@ -469,9 +469,13 @@ static void __init sparse_buffer_init(unsigned long size, int nid)
>>  
>>  static void __init sparse_buffer_fini(void)
>>  {
>> -	unsigned long size = sparsemap_buf_end - sparsemap_buf;
>> +	unsigned long size;
>>  
>> -	if (sparsemap_buf && size > 0)
>> +	if (!sparsemap_buf)
>> +		return;
>> +
>> +	size = sparsemap_buf_end - sparsemap_buf;
>> +	if (size > 0)
>>  		sparse_buffer_free(size);
>>  	sparsemap_buf = NULL;
>>  }
>> -- 
>> 2.34.1
>>
>>
> 

