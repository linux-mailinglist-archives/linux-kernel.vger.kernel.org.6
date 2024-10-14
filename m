Return-Path: <linux-kernel+bounces-364290-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A66E899D0B2
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 17:06:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 495CEB26DEF
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 15:06:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 011271AB517;
	Mon, 14 Oct 2024 15:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RWW5+EhV"
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC7ED1798C
	for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 15:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728918364; cv=none; b=mwn0oXXqw2zIu3BtSIf6wwu8CBWEcziBbi2XLzHXwUR9zvtmSgrh7OL9nDUpErHffyRKZ9kezEjDtEKxSfuARwz2V/rrThDgeW4aJl7dpKwalGmggdlzMzkrH+tZeTMghJAu1G8znfdiKaCNHaRjYBFSsh3Uhdwtb8e5TaOUu3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728918364; c=relaxed/simple;
	bh=mMmhr4RKssIEE7LeeD7/kZyTtGQ91du+EhSO9491zvM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BEr+WYzjT7YZY1yMqZlaBqfQJAwc8DHB7XgP6yvB31g466GqpDuX6S6rvSom2zG02ucDPVce6VDSWENmx62hEDtIGq07moWFm+QrMzl5s28XnyLl2raXqqZIjxREnGgnuFrguaGpCI7CIbZtGab6HeH50QzKZTHZAYyRXP7LyFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RWW5+EhV; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-2e2b4110341so784229a91.1
        for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 08:06:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728918362; x=1729523162; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Xc/MY3utwq++TumE+kg0BgRHpsSHoagJmtSGPnXPBdw=;
        b=RWW5+EhVZl6lV4CuAq9acmfWUaFogMZ3mapCFelGZAjE6xSIHyQkiOOd524kg8pinU
         hkknvG5ILEORH+9hskEq/m5EidO7tU00agYAscnvo64Ley3Jf6A6sQAF8rxZpNFWRByN
         FAumMvE07pJMxHo5q+5E5OKqJAlSILAh+TPYMAI0JlcMBS4fhDgon9niiV7xYP8C/zbq
         PiuXNOjJ6xdrIQ3nai645VhRzrENGIIz158SUldSgxwBfqzPiUt+8KaUz9D0fnxf31W8
         Xd97ZrEKEeJXHp4QmmyRigV35NkXM/mr6CQ8EpnpEwhjtBE0QobPJzSGVEccN7p2MRsB
         EI1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728918362; x=1729523162;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Xc/MY3utwq++TumE+kg0BgRHpsSHoagJmtSGPnXPBdw=;
        b=cm7ndo6sPjgP7WSt4G5RxKU7JLslXW4AvqZcNcVYZRwKrs8aGLOtbdk4J+rqvCeqGE
         832QYDc07TaM+iLVSad7921KA2LemceXEVvlnAvR54KBcvoD7qH7TbCaxqZtixxIPVk/
         VovjvinhsUqHq0bn9AaDaj83Cu6eH1YW8fRAeoCECPvBlGZ8yyyy2lJtvuR591WiveHB
         u3xydGRvCji+pV/TJRNd6290gamFRQI1FMIo/BMp3uIXVMgEt+7ueULGKofofBCete/7
         rRBVkppmWFtgExZYECZQTn/4PzmWkSDGFmyCeaQvTPKaDaFrBYJeTS1XjW0hOfsKD/L9
         xVLg==
X-Forwarded-Encrypted: i=1; AJvYcCX3rVY2Eav0gdLPN3uds0yinAGkqjzS55nsUAndDT27CzGEDGsEgHV9gsvSkxvkIccFOAO0h9Ge6zi6dd8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwOQMNhzF4JJ0hiaHlpXOmlVgH4HdN0U9+/hER3V84+w1FNos8t
	/fLRIvuBgLw3t+Up3TuJxPQFN/NaoO7eeyKQ/qk0W8schZFGDaf/
X-Google-Smtp-Source: AGHT+IEh+03XEiMqqry8FUshMBqgkfrf1RSIoqUMOizfeEEK1dQF3s6/BBgO7zm3R3vKt4nsjoIx9w==
X-Received: by 2002:a17:90a:7c0b:b0:2e2:d562:6b42 with SMTP id 98e67ed59e1d1-2e2f0a2ab4fmr5981947a91.3.1728918362003;
        Mon, 14 Oct 2024 08:06:02 -0700 (PDT)
Received: from [192.168.1.17] ([171.76.87.218])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e2e922a8dcsm3538236a91.0.2024.10.14.08.05.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Oct 2024 08:06:01 -0700 (PDT)
Message-ID: <ef2eac3f-5a26-4397-9bcd-e0d7d652b282@gmail.com>
Date: Mon, 14 Oct 2024 20:35:56 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] kasan: add kunit tests for kmalloc_track_caller,
 kmalloc_node_track_caller
To: Andrey Konovalov <andreyknvl@gmail.com>
Cc: ryabinin.a.a@gmail.com, dvyukov@google.com, skhan@linuxfoundation.org,
 kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org
References: <20241014041130.1768674-1-niharchaithanya@gmail.com>
 <CA+fCnZex_+2JVfUgAepbWm+TRzwMNkje6cXhCE_xEDesTq1Zfw@mail.gmail.com>
Content-Language: en-US
From: Nihar Chaithanya <niharchaithanya@gmail.com>
In-Reply-To: <CA+fCnZex_+2JVfUgAepbWm+TRzwMNkje6cXhCE_xEDesTq1Zfw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 14/10/24 18:19, Andrey Konovalov wrote:
> On Mon, Oct 14, 2024 at 6:32 AM Nihar Chaithanya
> <niharchaithanya@gmail.com> wrote:
>> The Kunit tests for kmalloc_track_caller and kmalloc_node_track_caller
>> were missing in kasan_test_c.c, which check that these functions poison
>> the memory properly.
>>
>> Add a Kunit test:
>> -> kmalloc_tracker_caller_oob_right(): This includes out-of-bounds
>>     access test for kmalloc_track_caller and kmalloc_node_track_caller.
>>
>> Signed-off-by: Nihar Chaithanya <niharchaithanya@gmail.com>
>> Fixes: https://bugzilla.kernel.org/show_bug.cgi?id=216509
>> ---
>> v1->v2: Simplified the three separate out-of-bounds tests to a single test for
>> kmalloc_track_caller.
>>
>> Link to v1: https://lore.kernel.org/all/20241013172912.1047136-1-niharchaithanya@gmail.com/
>>
>>   mm/kasan/kasan_test_c.c | 32 ++++++++++++++++++++++++++++++++
>>   1 file changed, 32 insertions(+)
>>
>> diff --git a/mm/kasan/kasan_test_c.c b/mm/kasan/kasan_test_c.c
>> index a181e4780d9d..62efc1ee9612 100644
>> --- a/mm/kasan/kasan_test_c.c
>> +++ b/mm/kasan/kasan_test_c.c
>> @@ -213,6 +213,37 @@ static void kmalloc_node_oob_right(struct kunit *test)
>>          kfree(ptr);
>>   }
>>
>> +static void kmalloc_track_caller_oob_right(struct kunit *test)
>> +{
>> +       char *ptr;
>> +       size_t size = 128 - KASAN_GRANULE_SIZE;
>> +
>> +       /*
>> +        * Check that KASAN detects out-of-bounds access for object allocated via
>> +        * kmalloc_track_caller().
>> +        */
>> +       ptr = kmalloc_track_caller(size, GFP_KERNEL);
>> +       KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ptr);
>> +
>> +       OPTIMIZER_HIDE_VAR(ptr);
>> +       KUNIT_EXPECT_KASAN_FAIL(test, ptr[size] = 'y');
>> +
>> +       kfree(ptr);
>> +
>> +       /*
>> +        * Check that KASAN detects out-of-bounds access for object allocated via
>> +        * kmalloc_node_track_caller().
>> +        */
>> +       size = 4096;
>> +       ptr = kmalloc_node_track_caller(size, GFP_KERNEL, 0);
>> +       KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ptr);
>> +
>> +       OPTIMIZER_HIDE_VAR(ptr);
>> +       KUNIT_EXPECT_KASAN_FAIL(test, ptr[size] = 'y');
> What you had here before (ptr[0] = ptr[size]) was better. ptr[size] =
> 'y' with size == 4096 does an out-of-bounds write access, which
> corrupts uncontrolled memory for the tag-based KASAN modes, which do
> not use redzones. We try to avoid corrupting memory in KASAN tests, as
> the kernel might crash otherwise before all tests complete.
>
> So let's either change this back to ptr[0] = ptr[size] or just reuse
> the same size for both test cases (or does kmalloc_node_track_caller
> require size >= 4K?).

We can reuse the same test for both cases without changing the size, I ran
the test without changing the size (i.e., size == 128 - KASAN_GRANULE_SIZE),
the KASAN report was generated. I found instances (drm/tiny) where the size
passed to the kmalloc_node_track_caller is < 4k.

>> +
>> +       kfree(ptr);
>> +}
>> +
>>   /*
>>    * Check that KASAN detects an out-of-bounds access for a big object allocated
>>    * via kmalloc(). But not as big as to trigger the page_alloc fallback.
>> @@ -1958,6 +1989,7 @@ static struct kunit_case kasan_kunit_test_cases[] = {
>>          KUNIT_CASE(kmalloc_oob_right),
>>          KUNIT_CASE(kmalloc_oob_left),
>>          KUNIT_CASE(kmalloc_node_oob_right),
>> +       KUNIT_CASE(kmalloc_track_caller_oob_right),
>>          KUNIT_CASE(kmalloc_big_oob_right),
>>          KUNIT_CASE(kmalloc_large_oob_right),
>>          KUNIT_CASE(kmalloc_large_uaf),
>> --
>> 2.34.1
>>

