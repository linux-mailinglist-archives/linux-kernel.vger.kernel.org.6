Return-Path: <linux-kernel+bounces-394719-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D20D9BB325
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 12:26:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 51A5E284F64
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 11:26:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9541D1BC073;
	Mon,  4 Nov 2024 11:16:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="WZDz9AaA"
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B95C41AA78E;
	Mon,  4 Nov 2024 11:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730719009; cv=none; b=iJiwZglw40xOXC2E3RhYUt9Y31y61bkiEHZojPuYXqx+MisAIM+5dvcqk/Mp76cyQtBpWMBOyc7WyIW8GryWQFhM0EE71GuUkCbQfW9VFYTXb8eDK7mBjdyRLbyaCrWOfUZIakN8NdAOyslHheSuzWwukIuOkxmie2IBOVNpqpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730719009; c=relaxed/simple;
	bh=asl+bz8+CwiXw9CFavFPKpnA44+FONT9NATCJBSmHF0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GE31bW2Jkc5lOw9cSp3dchwbwcqaZY5i8zNTVAgwHd2RcWIvhmRRdYQwbjCjiLx7TL/umYqQ2sCerM829zXRyxX5GyrjcjUrAwMBwa1u2xyCGvi04kHMwo2Ashl60WwnlQ5ScGPHlFs0hVxDOhjhRRkQlSe4o05MhaO+WTYgFXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=WZDz9AaA; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=y9ExVeNjKF0SfMQEmzTjWWX5US8Priue+XLniaZh+Qs=; b=WZDz9AaASfdZwB+BONRbuqU3Wv
	QNpbAAt+sTh/U7VGjUC7WCNg/pCt4bq6dqjddhX15WsAKGPT0XTFc9mggSyeJofShH3kNxIHSMDR7
	NyyVndtl8U9meMwJeff94rSB9tqQ0VQw7FYmJiv7TJuVYlqZ7q37NhUNc4VBajprhXAl9An00HU9a
	PhkS85FDtvp9p4DH1e30Ibe0V3bgPblSlcOh9MZnUD+gefH2t8n9ZXRShMEGxsbYyWCSZDdypIQyM
	Hj0zggcvqYoBJeAYCdX4uXsmFwFblS1R1iZ/AAFxCL5jvCysNYQPBRZzEQkrCgMcGTfRyLA0GdK4z
	90eb4IsA==;
Received: from [187.36.213.55] (helo=[192.168.1.103])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1t7v46-001WwT-Gt; Mon, 04 Nov 2024 12:16:10 +0100
Message-ID: <06b96a7f-c9bb-4a65-8077-ba10e0ea1e7d@igalia.com>
Date: Mon, 4 Nov 2024 08:16:02 -0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 3/5] mm: move ``get_order_from_str()`` to internal.h
To: Baolin Wang <baolin.wang@linux.alibaba.com>,
 Jonathan Corbet <corbet@lwn.net>, Andrew Morton <akpm@linux-foundation.org>,
 Hugh Dickins <hughd@google.com>, Barry Song <baohua@kernel.org>,
 David Hildenbrand <david@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>,
 Lance Yang <ioworker0@gmail.com>
Cc: linux-mm@kvack.org, dri-devel@lists.freedesktop.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 kernel-dev@igalia.com
References: <20241101165719.1074234-2-mcanal@igalia.com>
 <20241101165719.1074234-5-mcanal@igalia.com>
 <9d5ce0af-6fca-422f-b1f8-650879f8ff5a@linux.alibaba.com>
Content-Language: en-US
From: =?UTF-8?Q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>
In-Reply-To: <9d5ce0af-6fca-422f-b1f8-650879f8ff5a@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Baolin,

On 03/11/24 23:25, Baolin Wang wrote:
> 
> 
> On 2024/11/2 00:54, Maíra Canal wrote:
>> In order to implement a kernel parameter similar to ``thp_anon=`` for
>> shmem, we'll need the function ``get_order_from_str()``.
>>
>> Instead of duplicating the function, move the function to a shared
>> header, in which both mm/shmem.c and mm/huge_memory.c will be able to
>> use it.
>>
>> Signed-off-by: Maíra Canal <mcanal@igalia.com>
>> ---
>>   mm/huge_memory.c | 38 +++++++++++++++-----------------------
>>   mm/internal.h    | 22 ++++++++++++++++++++++
>>   2 files changed, 37 insertions(+), 23 deletions(-)
>>
>> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
>> index f92068864469..a6edbd8c4f49 100644
>> --- a/mm/huge_memory.c
>> +++ b/mm/huge_memory.c
>> @@ -958,26 +958,6 @@ static int __init setup_transparent_hugepage(char 
>> *str)
>>   }
>>   __setup("transparent_hugepage=", setup_transparent_hugepage);
>> -static inline int get_order_from_str(const char *size_str)
>> -{
>> -    unsigned long size;
>> -    char *endptr;
>> -    int order;
>> -
>> -    size = memparse(size_str, &endptr);
>> -
>> -    if (!is_power_of_2(size))
>> -        goto err;
>> -    order = get_order(size);
>> -    if (BIT(order) & ~THP_ORDERS_ALL_ANON)
>> -        goto err;
>> -
>> -    return order;
>> -err:
>> -    pr_err("invalid size %s in thp_anon boot parameter\n", size_str);
>> -    return -EINVAL;
>> -}
>> -
>>   static char str_dup[PAGE_SIZE] __initdata;
>>   static int __init setup_thp_anon(char *str)
>>   {
>> @@ -1007,10 +987,22 @@ static int __init setup_thp_anon(char *str)
>>                   start_size = strsep(&subtoken, "-");
>>                   end_size = subtoken;
>> -                start = get_order_from_str(start_size);
>> -                end = get_order_from_str(end_size);
>> +                start = get_order_from_str(start_size, 
>> THP_ORDERS_ALL_ANON);
>> +                end = get_order_from_str(end_size, THP_ORDERS_ALL_ANON);
>>               } else {
>> -                start = end = get_order_from_str(subtoken);
>> +                start_size = end_size = subtoken;
>> +                start = end = get_order_from_str(subtoken,
>> +                                 THP_ORDERS_ALL_ANON);
>> +            }
>> +
>> +            if (start == -EINVAL) {
>> +                pr_err("invalid size %s in thp_anon boot 
>> parameter\n", start_size);
>> +                goto err;
>> +            }
>> +
>> +            if (end == -EINVAL) {
>> +                pr_err("invalid size %s in thp_anon boot 
>> parameter\n", end_size);
>> +                goto err;
>>               }
> 
> There are already checks for ‘start’ and ‘end’ below, and will print 
> error messages if error occurs. So I suspect whether these repeated 
> checks and error infor are helpful.

The idea is to explicitly show to the user which part of the kernel
parameter is broke. Instead of saying that something is broken, it is
going to return that, for example, "33K" is invalid.

Best Regards,
- Maíra

> 
> Anyway, I don't have a strong preference.
> Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>


