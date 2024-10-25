Return-Path: <linux-kernel+bounces-380906-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C5F79AF7A0
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 04:48:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A59B11F22CCB
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 02:48:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32EFF433CB;
	Fri, 25 Oct 2024 02:48:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QxwaCY+B"
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2975333FE
	for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 02:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729824510; cv=none; b=T5JElwZxNGBk248hl1r2nr/acPwl2sjQV3PTX/b2IxAsPao0XAnVwT+hBKU4oF/wKWIfNy3UqxTJqiBujzG9tVGS2tmiYHipHr7yDM9W1IweW9xPMkdl+YGZqgQdsVhePHEoiGcQS0qhD1cpgOh3TuGTAwwFONXpc/9lb8FnOJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729824510; c=relaxed/simple;
	bh=PtpxnSU0qVSoxD4SoZ6h/OQYusffgtI9p43lh/qUh3g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=b4BnX9i6RTDlszKWX3X04/tcKQjNntzNFLgZM70qJTBokLloFQYLPqoYP0fDwE0dC2le1hf0dTQXnZUjp8PxuX2K+o7dcWKj3ImeE//o8Pn/ihtRFEpdwRCi0xoy4PL/gn2gI13FzWVIiCDRhOu3HP3o1qy555raDoPokHwXNjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QxwaCY+B; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-7c3d8105646so157233a12.2
        for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 19:48:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729824507; x=1730429307; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IMlkAz1rGfXdC3YuTmyO/PA2KhdShJ1qEJ3uVonYBbY=;
        b=QxwaCY+Bd/dIOp441BQ8HdkBJ75cI3CKMc4AGR5z4vAmXYDQI+7AT9FDAu2RXLnIRu
         cmXRSM1pFR54KwUnbCJkTooPrpoTKZOX7Wv7uNpLZz8pRe9xW7tbe4gWWk12wtfTB0Yi
         jA4jC4x+TZ/qnQUDhx/MGzMpOCHwTkUaRzp11DgbhMkLBPgIRvEuu/+J7m4WuLWiKKfD
         sMHY+BXWFjjV9P/B74kFvi54dp034RBPsZHXNO5eUKY6+2CEs4S5JrdZZeSSd3CfBuKG
         PaaXOkjqADdS45+H140AKmI+Yr0Qk9TPfgBdaev6CjUVxIiwuonrfXxMig9rda9ToMoI
         DQjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729824507; x=1730429307;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IMlkAz1rGfXdC3YuTmyO/PA2KhdShJ1qEJ3uVonYBbY=;
        b=cuPg7TfL6h0Gv+yb62EpZbFXwYQ4zDdTPEk7z54IZOGChIGTQt0ebyOuCQMSh/70dv
         6Qu8faPCffEdQzulAUhHTO9MXZxUZbOVyj7MC8PwINl77TaqPrGLk5HVCRhebSZ0MEfl
         NwJOnbMjheSHZ+uzDVREy+SeKyEZv1jZKHJrTrvT1d6V2BFmvtTNcZd1BvPrm7LHK3w7
         sK+SHqjGbLkdQR+UoDL2qzSRmJcjhh6XNxZfJHoyZC6IH62bnS0op4qFjzcWFbHBIgDw
         j6/HayQpaP1k215t3Eu9CMyY3Boko6o+CTlWmt26Mg3Jl9a+EB1G1mh8KxKWuRePg1IG
         e0Wg==
X-Forwarded-Encrypted: i=1; AJvYcCW1Vij0llcwr2UPF8GQAPo7z61iyPUvfaZceNxiQ9LjrgN7VQ5Je8HEqzcBsyKcCmi8gLuBXAn1unrMzi0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzq3flYdn4vTrppiSwnuUdFJaNAP/VT6NcI3Qk4IDQHwRIq+GFa
	eAJ5s5H5+tb6yHlAMfoz+KzsSn8PvBeY94ARMGPyFyOTEEcIwa/I
X-Google-Smtp-Source: AGHT+IG9R2GA/rVfqo4fMp75MiaJRFDgJJGvLI99U+vpM7cok67wtmZJese7UrezU1PMHtKm3/hjiQ==
X-Received: by 2002:a05:6a00:2d1a:b0:71e:66ed:7bd4 with SMTP id d2e1a72fcca58-72030a5183bmr5084342b3a.1.1729824506922;
        Thu, 24 Oct 2024 19:48:26 -0700 (PDT)
Received: from [192.168.1.17] ([171.76.80.180])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7edc8698e30sm97594a12.52.2024.10.24.19.48.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Oct 2024 19:48:26 -0700 (PDT)
Message-ID: <f26691b2-fe26-4e13-a34f-c4a2a995f25f@gmail.com>
Date: Fri, 25 Oct 2024 08:18:21 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] kasan:report: filter out kasan related stack entries
To: Andrey Konovalov <andreyknvl@gmail.com>, elver@google.com
Cc: ryabinin.a.a@gmail.com, glider@google.com, dvyukov@google.com,
 skhan@linuxfoundation.org, kasan-dev@googlegroups.com,
 linux-kernel@vger.kernel.org
References: <20241021195714.50473-1-niharchaithanya@gmail.com>
 <CA+fCnZf7sX2-H_jRMcJhiYxYZ=5f5oQ7iO__pQnjEXDLUS+fkg@mail.gmail.com>
Content-Language: en-US
From: Nihar Chaithanya <niharchaithanya@gmail.com>
In-Reply-To: <CA+fCnZf7sX2-H_jRMcJhiYxYZ=5f5oQ7iO__pQnjEXDLUS+fkg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 23/10/24 19:30, Andrey Konovalov wrote:
> On Mon, Oct 21, 2024 at 9:58 PM Nihar Chaithanya
> <niharchaithanya@gmail.com> wrote:
> Let's change the patch name prefix to "kasan: report:" (i.e. add an
> extra space between "kasan:" and "report:").
>
>> The reports of KASAN include KASAN related stack frames which are not
>> the point of interest in the stack-trace. KCSAN report filters out such
>> internal frames providing relevant stack trace. Currently, KASAN reports
>> are generated by dump_stack_lvl() which prints the entire stack.
>>
>> Add functionality to KASAN reports to save the stack entries and filter
>> out the kasan related stack frames in place of dump_stack_lvl() and
>> stack_depot_print().
>>
>> Within this new functionality:
>>          - A function kasan_dump_stack_lvl() in place of dump_stack_lvl() is
>>            created which contains functionality for saving, filtering and
>>            printing the stack-trace.
>>          - A function kasan_stack_depot_print() in place of
>>            stack_depot_print() is created which contains functionality for
>>            filtering and printing the stack-trace.
>>          - The get_stack_skipnr() function is included to get the number of
>>            stack entries to be skipped for filtering the stack-trace.
>>
>> Signed-off-by: Nihar Chaithanya <niharchaithanya@gmail.com>
>> Fixes: https://bugzilla.kernel.org/show_bug.cgi?id=215756
>> ---
>> Changes in v2:
>>          - Changed the function name from save_stack_lvl_kasan() to
>>            kasan_dump_stack_lvl().
>>          - Added filtering of stack frames for print_track() with
>>            kasan_stack_depot_print().
>>          - Removed redundant print_stack_trace(), and instead using
>>            stack_trace_print() directly.
>>          - Removed sanitize_stack_entries() and replace_stack_entry()
>>            functions.
>>          - Increased the buffer size in get_stack_skipnr to 128.
>>
>> Note:
>> When using sanitize_stack_entries() the output was innacurate for free and
>> alloc tracks, because of the missing ip value in print_track().
>> The buffer size in get_stack_skipnr() is increase as it was too small when
>> testing with some KASAN uaf bugs which included free and alloc tracks.
>>
>>   mm/kasan/report.c | 62 ++++++++++++++++++++++++++++++++++++++++++-----
>>   1 file changed, 56 insertions(+), 6 deletions(-)
>>
>> diff --git a/mm/kasan/report.c b/mm/kasan/report.c
>> index b48c768acc84..e00cf764693c 100644
>> --- a/mm/kasan/report.c
>> +++ b/mm/kasan/report.c
>> @@ -261,6 +261,59 @@ static void print_error_description(struct kasan_report_info *info)
>>                          info->access_addr, current->comm, task_pid_nr(current));
>>   }
>>
>> +/* Helper to skip KASAN-related functions in stack-trace. */
>> +static int get_stack_skipnr(const unsigned long stack_entries[], int num_entries)
>> +{
>> +       char buf[128];
>> +       int len, skip;
>> +
>> +       for (skip = 0; skip < num_entries; ++skip) {
>> +               len = scnprintf(buf, sizeof(buf), "%ps", (void *)stack_entries[skip]);
>> +
>> +               /* Never show  kasan_* functions. */
>> +               if (strnstr(buf, "kasan_", len) == buf)
>> +                       continue;
> Also check for "__kasan_" prefix: Right now, for the very first KASAN
> test, we get this alloc stack trace:
>
> [    1.799579] Allocated by task 63:
> [    1.799935]  __kasan_kmalloc+0x8b/0x90
> [    1.800353]  kmalloc_oob_right+0x95/0x6c0
> [    1.800801]  kunit_try_run_case+0x16e/0x280
> [    1.801267]  kunit_generic_run_threadfn_adapter+0x77/0xe0
> [    1.801863]  kthread+0x296/0x350
> [    1.802224]  ret_from_fork+0x2b/0x70
> [    1.802652]  ret_from_fork_asm+0x1a/0x30
>
> The __kasan_kmalloc frame is a part of KASAN internals and we want to
> skip that. kmalloc_oob_right is the function where the allocation
> happened, and that should be the first stack trace frame.
>
> (I suspect we'll have to adapt more of these from KFENCE, but let's do
> that after resolving the other issues.)
>
>> +               /*
>> +                * No match for runtime functions -- @skip entries to skip to
>> +                * get to first frame of interest.
>> +                */
>> +               break;
>> +       }
>> +
>> +       return skip;
>> +}
>> +
>> +/*
>> + * Use in place of stack_dump_lvl to filter KASAN related functions in
>> + * stack_trace.
> "Use in place of dump_stack() to filter out KASAN-related frames in
> the stack trace."
>
>> + */
>> +static void kasan_dump_stack_lvl(void)
> No need for the "_lvl" suffix - you removed the lvl argument.
>
>> +{
>> +       unsigned long stack_entries[KASAN_STACK_DEPTH] = { 0 };
>> +       int num_stack_entries = stack_trace_save(stack_entries, KASAN_STACK_DEPTH, 1);
>> +       int skipnr = get_stack_skipnr(stack_entries, num_stack_entries);
> For printing the access stack trace, we still want to keep the
> ip-based skipping (done via sanitize_stack_entries() in v1) - it's
> more precise than pattern-based matching in get_stack_skipnr(). But
> for alloc/free stack traces, we can only use get_stack_skipnr().
>
> However, I realized I don't fully get the point of replacing a stack
> trace entry when doind the ip-based skipping. Marco, is this something
> KCSAN-specific? I see that this is used for reodered_to thing.
When I included ip-based skipping for filtering access stack trace the 
output was
inconsistent where the Freed track was not fully printed and it also 
triggered
the following warning a few times:

[    6.467470][ T4653] Freed by task 511183648:
[    6.467792][ T4653] ------------[ cut here ]------------
[    6.468194][ T4653] pool index 100479 out of bounds (466) for stack 
id ffff8880
[    6.468862][ T4653] WARNING: CPU: 1 PID: 4653 at lib/stackdepot.c:452 
depot_fetch_stack+0x86/0xb0

This was not present when using pattern based skipping. Does modifying 
access
stack trace when using sanitize_stack_entries() modify the free and 
alloc tracks
as well? In that case shall we just use pattern based skipping.
>> +
>> +       dump_stack_print_info(KERN_ERR);
>> +       stack_trace_print(stack_entries + skipnr, num_stack_entries - skipnr, 0);
>> +       pr_err("\n");
>> +}
>> +
>> +/*
>> + * Use in place of stack_depot_print to filter KASAN related functions in
>> + * stack_trace.
> "Use in place of stack_depot_print() to filter out KASAN-related
> frames in the stack trace."
>
>> + */
>> +static void kasan_stack_depot_print(depot_stack_handle_t stack)
>> +{
>> +       unsigned long *entries;
>> +       unsigned int nr_entries;
>> +
>> +       nr_entries = stack_depot_fetch(stack, &entries);
>> +       int skipnr = get_stack_skipnr(entries, nr_entries);
>> +
>> +       if (nr_entries > 0)
>> +               stack_trace_print(entries + skipnr, nr_entries - skipnr, 0);
>> +}
>> +
>>   static void print_track(struct kasan_track *track, const char *prefix)
>>   {
>>   #ifdef CONFIG_KASAN_EXTRA_INFO
>> @@ -277,7 +330,7 @@ static void print_track(struct kasan_track *track, const char *prefix)
>>          pr_err("%s by task %u:\n", prefix, track->pid);
>>   #endif /* CONFIG_KASAN_EXTRA_INFO */
>>          if (track->stack)
>> -               stack_depot_print(track->stack);
>> +               kasan_stack_depot_print(track->stack);
>>          else
>>                  pr_err("(stack is not available)\n");
>>   }
>> @@ -374,9 +427,6 @@ static void print_address_description(void *addr, u8 tag,
>>   {
>>          struct page *page = addr_to_page(addr);
>>
>> -       dump_stack_lvl(KERN_ERR);
>> -       pr_err("\n");
> This new line we want to keep.
>
>> -
>>          if (info->cache && info->object) {
>>                  describe_object(addr, info);
>>                  pr_err("\n");
>> @@ -484,11 +534,11 @@ static void print_report(struct kasan_report_info *info)
>>                  kasan_print_tags(tag, info->first_bad_addr);
>>          pr_err("\n");
>>
>> +       kasan_dump_stack_lvl();
>> +
>>          if (addr_has_metadata(addr)) {
>>                  print_address_description(addr, tag, info);
>>                  print_memory_metadata(info->first_bad_addr);
>> -       } else {
>> -               dump_stack_lvl(KERN_ERR);
>>          }
>>   }
>>
>> --
>> 2.34.1
>>
> Thank you!

