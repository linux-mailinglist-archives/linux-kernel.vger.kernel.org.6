Return-Path: <linux-kernel+bounces-390469-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A222C9B7A4E
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 13:12:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3B0F5B212F9
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 12:12:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8092B19C553;
	Thu, 31 Oct 2024 12:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="DUqKM+eU"
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B62B191F65;
	Thu, 31 Oct 2024 12:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730376744; cv=none; b=rvQfBv3RmEblAkcZHGY2qzzUFStAudhWo2CaPPn0kGPcrMLuK5Bq0uQoEK5fLpOzulZ+zAvthl/wS73fc5S52hPB017O5dmXoxML1rsgyJ3yWJUU07MdW5bohYOPsWgHFScCE3XueJpDCAkzY4ntJGsKG1oSCuGGQsTYg3R+D0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730376744; c=relaxed/simple;
	bh=rn0aWTTY0KMqfLPWnH+E/QS8/fTDFhq3wxJYiBjO97k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hINYQfOXR/jvgOGhnOiJXIaqCjsPVSYx4nwnfXjKVZAX/ScUBe6f42YX3HPAonm5FUSWQr8SUssa7JzpR3EHijWmqnOrVJSiR9Ut5GxQ/hAuVScRHnsXNk3/3VnrwC8eORKFw43MMYqJWKfQM8wpFU1SjxlZphFJTdfu3yvBde0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=DUqKM+eU; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=TOQW25mPDvS9JYuVAn2I5kSOsF/BA7sQILr6dKumHd4=; b=DUqKM+eUK2OqqeWbA+h6k90pKj
	G0gZ26I/zbHoWKFGqBJXoFtz/L6ongHy928Am/6rt4c+c6o1T0O6cHOF5TR3/zx9DpIgCqKW+0FQO
	aC6ITTWca5gEklq2JiMaX6GdVBUVY+yFSynG2ziYLqakdewuic4Mk2gdcroApT6A3HPpo22QQyx0w
	NJPP9imkeQhGxipk5BvKCuynetHu2ZW/LPNgY+XZjcrYhkPleXD/C2WVyvEYsw07mZzDT0DQbjpiz
	+ESZsxuIaw40ZbC5DAQAbLdHNo8zAvY67DJpbjPH1TrpXHvUt/VzMiym6r2+rsfXSWtyovI9xBobJ
	muSM5W3w==;
Received: from [187.36.213.55] (helo=[192.168.1.103])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1t6U20-0000Ej-F2; Thu, 31 Oct 2024 13:12:04 +0100
Message-ID: <d3549d00-3f58-4f62-8903-4b7b8b3a42b1@igalia.com>
Date: Thu, 31 Oct 2024 09:11:56 -0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/4] mm: huge_memory: Use strscpy() instead of strcpy()
To: Barry Song <21cnbao@gmail.com>
Cc: Jonathan Corbet <corbet@lwn.net>,
 Andrew Morton <akpm@linux-foundation.org>, Hugh Dickins <hughd@google.com>,
 David Hildenbrand <david@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>, Lance Yang
 <ioworker0@gmail.com>, linux-mm@kvack.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, kernel-dev@igalia.com, kees@kernel.org
References: <20241030130308.1066299-1-mcanal@igalia.com>
 <20241030130308.1066299-5-mcanal@igalia.com>
 <CAGsJ_4zMppHY29XXepOVTdEu2-1U6mGyZ8FqXZfP_in+2T3NAA@mail.gmail.com>
 <b31bd54c-400c-4432-8b4b-0ba12bcf8011@igalia.com>
 <CAGsJ_4wKdCq8HnH=R3dWefZAqbLjyX06WdJ4T_UMogFZDS7Wqg@mail.gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>
In-Reply-To: <CAGsJ_4wKdCq8HnH=R3dWefZAqbLjyX06WdJ4T_UMogFZDS7Wqg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

+cc Kees Cook

Hi Barry,

On 31/10/24 09:01, Barry Song wrote:
> On Thu, Oct 31, 2024 at 6:55 PM Maíra Canal <mcanal@igalia.com> wrote:
>>
>> Hi Barry,
>>
>> On 30/10/24 20:07, Barry Song wrote:
>>> On Thu, Oct 31, 2024 at 2:03 AM Maíra Canal <mcanal@igalia.com> wrote:
>>>>
>>>> Replace strcpy() with strscpy() in mm/huge_memory.c
>>>>
>>>> strcpy() has been deprecated because it is generally unsafe, so help to
>>>> eliminate it from the kernel source.
>>>>
>>>> Link: https://github.com/KSPP/linux/issues/88
>>>> Signed-off-by: Maíra Canal <mcanal@igalia.com>
>>>> ---
>>>>    mm/huge_memory.c | 4 ++--
>>>>    1 file changed, 2 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
>>>> index f92068864469..8f41a694433c 100644
>>>> --- a/mm/huge_memory.c
>>>> +++ b/mm/huge_memory.c
>>>> @@ -989,7 +989,7 @@ static int __init setup_thp_anon(char *str)
>>>>
>>>>           if (!str || strlen(str) + 1 > PAGE_SIZE)
>>>>                   goto err;
>>>> -       strcpy(str_dup, str);
>>>> +       strscpy(str_dup, str);
>>>
>>> What is the difference between strcpy and strscpy without a size parameter?
>>>
>>> we have already a check and goto err. strcpy() is entirely safe.
>>>            if (!str || strlen(str) + 1 > PAGE_SIZE)
>>>                    goto err;
>>>
>>> My understanding is that we don't need this patch.
>>
>> strcpy() is a deprecated interface [1]. From the GitHub issue I linked
>> in the commit description, Kees states: "A lot of kernel code is still
>> using strcpy(). While the CONFIG_FORTIFY_SOURCE wrapper macros tend to
>> make its use mostly safe, it would be nice to eliminate the function
>> from the kernel entirely."
> 
> I don't see any value added here since strscpy() has no size parameter and

As `str_dup` is a sized buffer, we don't need to specify the size
parameter.

> we have checked strlen(str) + 1 > PAGE_SIZE to avoid parsing any pointless
> bootcmd longer than PAGE_SIZE.

 From my point of view, this is an extra layer of safety. A developer
could change `str_dup` to SZ_4K and leave PAGE_SIZE in the check. This
could pass by in a review and we would have a check that allows strings
bigger than the destination buffer in systems using 16KB pages.

But see that `split_huge_pages_write` uses `strcpy` without any checks.

I can remove the internal check from `setup_thp_anon` if you feel it
would be more suitable.

Best Regards,
- Maíra

 > > But I have no objection to this patch if other people like it.
> 
>>
>> [1] https://www.kernel.org/doc/html/latest/process/deprecated.html#strcpy
>>
>> Best Regards,
>> - Maíra
>>
>>>
>>>>
>>>>           always = huge_anon_orders_always;
>>>>           madvise = huge_anon_orders_madvise;
>>>> @@ -4175,7 +4175,7 @@ static ssize_t split_huge_pages_write(struct file *file, const char __user *buf,
>>>>
>>>>                   tok = strsep(&buf, ",");
>>>>                   if (tok) {
>>>> -                       strcpy(file_path, tok);
>>>> +                       strscpy(file_path, tok);
>>>>                   } else {
>>>>                           ret = -EINVAL;
>>>>                           goto out;
>>>> --
>>>> 2.46.2
>>>>
>>>
> Thanks
> barry


