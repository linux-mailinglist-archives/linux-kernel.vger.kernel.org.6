Return-Path: <linux-kernel+bounces-390384-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6DC39B7929
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 11:56:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8B744285CB4
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 10:56:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9908119AD4F;
	Thu, 31 Oct 2024 10:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="AGmG8ygU"
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B70BF13A25F;
	Thu, 31 Oct 2024 10:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730372172; cv=none; b=oFNzizW1rBhySRuzK7AGwCdfHiGgGQL2DsCh8W/j9M2GrO5snDIKhNYkzI66DEfgTEJIqG5AX0qrZk87Y6/3o5T0/nKcfo8szeJeLdEzK/vuAtOVBC0sFXuHLhqMYx9A6XftRcgr4f0g3znnIbx0cbJFb/fwnzv88trAWlYuH7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730372172; c=relaxed/simple;
	bh=jLofZIwivoLG+7s6ZAAzJLv64dhFLgAvPyWSQFGY6Ms=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kYQl32ifrIdD4tCpuwS57i4UvCVouehuiZX5B+lrNDxZLiSOJR1aSgpugVEGHNvuJYRaaV9dx60eLjPHt2XKlb2EsgKgZlrXL7W/Namy0cBDWmnFiT/3be6Q/pI6glt7mS3N2dhuCJMH2rO9N17o4ewrCO5lZMfCPFAky+L8q2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=AGmG8ygU; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=1e1Pem+qp2w/Akjj6dWKUEh4AeuCe5dpoYvS12Rnvgk=; b=AGmG8ygUmt9zRxbe2HYj47fYd2
	EiRCxeRBJhijKoPrVolQe3tPVfysPtMjYtfTkYC0HlELl1ad+sr4YTi26PSK3Pq6lXHeCk4BHRDyF
	Z6KZ5gMf6p+XnvldU6r/AUir8KBGsjcuWD8L8fk1fW+Y7Bpg7j6ENGCB+QC0B8LbUC6gY1Gg+QhXk
	ldArIjA3eFO430UEK26691k2vzg+aqSImfJBCTfeNHNiaGw2sEcSyz2PD8lmYdGjbzRjYtmFwKYXu
	mpTp9wyEzy+y5aKhz/x/O19EIGbFgEiLCMAvsiDxRE96AMCONwG34ZmhgPp8JtkVSwn0MlrqiU6F6
	RnFAcbFQ==;
Received: from [187.36.213.55] (helo=[192.168.1.103])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1t6SqD-00HZkr-Lv; Thu, 31 Oct 2024 11:55:50 +0100
Message-ID: <b31bd54c-400c-4432-8b4b-0ba12bcf8011@igalia.com>
Date: Thu, 31 Oct 2024 07:55:42 -0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/4] mm: huge_memory: Use strscpy() instead of strcpy()
To: Barry Song <baohua@kernel.org>
Cc: Jonathan Corbet <corbet@lwn.net>,
 Andrew Morton <akpm@linux-foundation.org>, Hugh Dickins <hughd@google.com>,
 David Hildenbrand <david@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>, Lance Yang
 <ioworker0@gmail.com>, linux-mm@kvack.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, kernel-dev@igalia.com
References: <20241030130308.1066299-1-mcanal@igalia.com>
 <20241030130308.1066299-5-mcanal@igalia.com>
 <CAGsJ_4zMppHY29XXepOVTdEu2-1U6mGyZ8FqXZfP_in+2T3NAA@mail.gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>
In-Reply-To: <CAGsJ_4zMppHY29XXepOVTdEu2-1U6mGyZ8FqXZfP_in+2T3NAA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Barry,

On 30/10/24 20:07, Barry Song wrote:
> On Thu, Oct 31, 2024 at 2:03 AM Maíra Canal <mcanal@igalia.com> wrote:
>>
>> Replace strcpy() with strscpy() in mm/huge_memory.c
>>
>> strcpy() has been deprecated because it is generally unsafe, so help to
>> eliminate it from the kernel source.
>>
>> Link: https://github.com/KSPP/linux/issues/88
>> Signed-off-by: Maíra Canal <mcanal@igalia.com>
>> ---
>>   mm/huge_memory.c | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
>> index f92068864469..8f41a694433c 100644
>> --- a/mm/huge_memory.c
>> +++ b/mm/huge_memory.c
>> @@ -989,7 +989,7 @@ static int __init setup_thp_anon(char *str)
>>
>>          if (!str || strlen(str) + 1 > PAGE_SIZE)
>>                  goto err;
>> -       strcpy(str_dup, str);
>> +       strscpy(str_dup, str);
> 
> What is the difference between strcpy and strscpy without a size parameter?
> 
> we have already a check and goto err. strcpy() is entirely safe.
>           if (!str || strlen(str) + 1 > PAGE_SIZE)
>                   goto err;
> 
> My understanding is that we don't need this patch.

strcpy() is a deprecated interface [1]. From the GitHub issue I linked
in the commit description, Kees states: "A lot of kernel code is still
using strcpy(). While the CONFIG_FORTIFY_SOURCE wrapper macros tend to
make its use mostly safe, it would be nice to eliminate the function
from the kernel entirely."

[1] https://www.kernel.org/doc/html/latest/process/deprecated.html#strcpy

Best Regards,
- Maíra

> 
>>
>>          always = huge_anon_orders_always;
>>          madvise = huge_anon_orders_madvise;
>> @@ -4175,7 +4175,7 @@ static ssize_t split_huge_pages_write(struct file *file, const char __user *buf,
>>
>>                  tok = strsep(&buf, ",");
>>                  if (tok) {
>> -                       strcpy(file_path, tok);
>> +                       strscpy(file_path, tok);
>>                  } else {
>>                          ret = -EINVAL;
>>                          goto out;
>> --
>> 2.46.2
>>
> 
> Thanks
> barry


