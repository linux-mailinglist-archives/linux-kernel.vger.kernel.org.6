Return-Path: <linux-kernel+bounces-238583-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 90CE9924C64
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 01:50:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3B8311F21F05
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 23:50:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5012517DA00;
	Tue,  2 Jul 2024 23:49:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mYkL/A+V"
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE52517A597
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jul 2024 23:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719964175; cv=none; b=m+0cy2hl6i6mZfBKOPBZIYhWkaF4o1YfGx5yEc8i7elSha7IzbqKqryHcufY21+N2sU0WsRR5SnP6t2yKp2j0LJM1sIDmM0sXNfrzcimenuFuTlyWkp7y7vqnlO4DljvVX4FxOJMiROWxTDxf16cemhj8JizkYxk7rS6bAzqffw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719964175; c=relaxed/simple;
	bh=+F1st/afbgQs2ScuVZ7ReABEjaYtbA7R1Oh7M3zh/6w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MyrwEnk/vR7/F8rFsXIFClgD/RiM+tGKm/3wdf2X6YCSTHZ278FgAnH/qQb/6LiEDpkmdNyML1GD7TH89Zl5Mwbjk2wx3rP85KISV/cFf0JEQvklK8Re38Ho3MmRJHh24Mm8ND8Sf0AyL5QpMRag4ug3CclEWzSPF3PH6arQQzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mYkL/A+V; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-52e9380add2so1375330e87.3
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jul 2024 16:49:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719964172; x=1720568972; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FYjTQJHP9Z7MRMopyD8WvbEYBhQzbd65vJfHWed8Lwc=;
        b=mYkL/A+VNn30WRpH6L1X5/JELKgSNiIMQ9oBqb0PpzGpcBgsk7eMkrgvalkzT/xmT3
         1JN8OBz8dG3kSf1+YtdTowfWDIzECAXoHpqQoyRFU0XyukeN6Z8vQMGCwSImJXX9p1Wx
         tUqkNO3X/39p/9FlfQR+WctdrSewa9Fx2h1rYCqulMGBBp9U55xCNOGcuYAmfsZSHf+l
         RN5JEPA9Kbp93WmYFf3X9D7foIrSeY4uHLomfJ3ZffgJv2m2boUvRj1zcCHSV5FCgEZz
         kIShC5UsOvhIG6dSdBrtjpBRl9jsfAWMgPzhXwDnTrvyWXWRtglQ/3KLmrIKz04YnWAE
         yLAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719964172; x=1720568972;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=FYjTQJHP9Z7MRMopyD8WvbEYBhQzbd65vJfHWed8Lwc=;
        b=cf/aIsuQeBcthm3YThaQWoNqY92Y4jX6RJWiRi/Hj0eMlueiMxlEbWzQ4eitctol4r
         ICvQTvT+pebbY88oCRUITU7313uWLt9UuqoPiOUmW4hlKxrhCdUBhv4++2/mjbwLyLhF
         378aryWB0HxgqvzrIgsf29IH0Vilad6RsPJbb2yJyM4m8ietJgQWLPRKUrCdPZBVw9Bn
         A9787LXize9w5lVXGY6SpxuUvjM9t6VPOgibIcVPe8dhRSOwXWzLSF64EL8lXIDJ/q0m
         UrxZnCFsb2+ztdp3bQBc88XgPbpYPijYiGqYnnH8K2QmbmXALV+8c1UVSHWmckx3beXu
         rS4w==
X-Forwarded-Encrypted: i=1; AJvYcCUcYoIX3MaCJPQ9BUTExvbWfXH3HdtYIq2JmtGTnkz00qtYlxbxtpKD5zKHgdeIdDX4qJmJJAZjXyZr8BEXIB9tJ/1HlSwTDS88jFOh
X-Gm-Message-State: AOJu0YwhriPTQXG1/QOH+ETbkLWy5N1AlEx0Z+V6PkQIwWGVSosfjb8C
	w/d6QQwZHLA3MkTCAjfGL+yoWhmZOBqLFm/+b0fB/ZsCItTVdkO6W7Dhs0d/
X-Google-Smtp-Source: AGHT+IEn5nOfll/JCGMY6X/PgeaArvLJbetgatNODck9q45ecZ0Sms1OpnhVRL/ZQAxXwh1wLwk9RQ==
X-Received: by 2002:ac2:4c41:0:b0:52c:df8e:a367 with SMTP id 2adb3069b0e04-52e82705afemr9096512e87.53.1719964171843;
        Tue, 02 Jul 2024 16:49:31 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a72ab06567esm454719066b.119.2024.07.02.16.49.31
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 02 Jul 2024 16:49:31 -0700 (PDT)
Date: Tue, 2 Jul 2024 23:49:30 +0000
From: Wei Yang <richard.weiyang@gmail.com>
To: David Hildenbrand <david@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Wei Yang <richard.weiyang@gmail.com>, brauner@kernel.org,
	oleg@redhat.com, mjguzik@gmail.com, tandersen@netflix.com,
	linux-kernel@vger.kernel.org, Mike Rapoport <rppt@kernel.org>
Subject: Re: [PATCH v2 1/2] kernel/fork.c: get totalram_pages from memblock
 to calculate max_threads
Message-ID: <20240702234930.flwbtga3iege66jr@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20240701013410.17260-1-richard.weiyang@gmail.com>
 <20240701212611.a0a977160c892818a7057615@linux-foundation.org>
 <69998ace-77d9-44df-8820-d584dfab7199@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <69998ace-77d9-44df-8820-d584dfab7199@redhat.com>
User-Agent: NeoMutt/20170113 (1.7.2)

On Tue, Jul 02, 2024 at 09:02:31AM +0200, David Hildenbrand wrote:
>On 02.07.24 06:26, Andrew Morton wrote:
>> On Mon,  1 Jul 2024 01:34:09 +0000 Wei Yang <richard.weiyang@gmail.com> wrote:
>> 
>> > Since we plan to move the accounting into __free_pages_core(),
>> > totalram_pages may not represent the total usable pages on system
>> > at this point when defer_init is enabled.
>> 
>> Yes, things like totalram_pages() are very old, and were a good idea at the
>> time, but things moved on.
>> 
>> > Instead we can get the total usable pages from memblock directly.
>> > 
>> > --- a/kernel/fork.c
>> > +++ b/kernel/fork.c
>> > @@ -44,6 +44,7 @@
>> >   #include <linux/fs.h>
>> >   #include <linux/mm.h>
>> >   #include <linux/mm_inline.h>
>> > +#include <linux/memblock.h>
>> >   #include <linux/nsproxy.h>
>> >   #include <linux/capability.h>
>> >   #include <linux/cpu.h>
>> > @@ -999,7 +1000,7 @@ void __init __weak arch_task_cache_init(void) { }
>> >   static void set_max_threads(unsigned int max_threads_suggested)
>> >   {
>> >   	u64 threads;
>> > -	unsigned long nr_pages = totalram_pages();
>> > +	unsigned long nr_pages = PHYS_PFN(memblock_phys_mem_size() - memblock_reserved_size());
>> 
>> The result of this subtraction has meaning.  Even if it is only used
>> once, I suspect it should be in a standalone function which has
>> documentation which describes that meaning.  Having fork.c make an
>> open-coded poke into memblock internals seems wrong, no?

Agree, this is not a good practise.

>
>I was just about the comment the same thing:
>
>I'm starting to wonder if we should have a helper like
>
>memblock_estimated_nr_pages()
>
>or sth like that that abstracts this?

Hmm... not good at naming, I am ok with this. 

I would prepare v2 with this. If someone have a better idea, I would change
it.

>
>-- 
>Cheers,
>
>David / dhildenb

-- 
Wei Yang
Help you, Help me

