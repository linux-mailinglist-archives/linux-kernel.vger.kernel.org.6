Return-Path: <linux-kernel+bounces-511661-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 62163A32DF1
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 18:52:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BB5EC1888590
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 17:53:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCECB25C70E;
	Wed, 12 Feb 2025 17:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qs2UPlFZ"
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B7BE25C6EB
	for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 17:52:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739382768; cv=none; b=K/UDmpdiv8ii7arm2KMGvWeyI8kVch3ocvw6s92ZId/Gv1KGRoJexlCLINt+oLj57C88a2K1yJMRBze5Rm192ZGfkH4L3hGWwxw2rpuEP9rv3g38A4bm6FTSTSR9WNIuaXTmsO+euOZl9NL8Xph4AbIuMh/PH4Em+SkEdVKgQ+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739382768; c=relaxed/simple;
	bh=56WC7pYL8vor2Oapd7V3UkUIsRX1QwbakQlGQJWbKSA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PACNO2V1D9wxu/Ss7VzC9zrrUm5eCE4DxJ77sXthru4QbFUOAOq1CKeXkeS2adI2c6IcWQvwhyeh51873BXx5dGyHPR/2BG+6F7A0DG7fTvUuPs/5ngPMO8hVCHpjnT6Cwlu6xnbGhDv/YxJGKadqVcYWAw8UNpRXJyrI8aEW18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qs2UPlFZ; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-308e65891e4so4082541fa.2
        for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 09:52:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739382764; x=1739987564; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=C/kS06FLerC2Af3s6b6Rf5nvMZaz+z4sBVLyAweX+ok=;
        b=Qs2UPlFZN0AbUDb1s4TWl9mMJ3PITa04ZIcqLi1OqAo1wrq94byMvRQ5X2L1SriYRz
         OJXQ0LYXMYkkSKztFUnzNO3mH0W6aFSbclWTdKqwZQxsZKNKiyVWEoCFrbq93Bxp7Nf4
         S8AjdHxBfo6P3xgptVf3bfJjCwd9A/4gwRyYC4Q4rtyIP7S2jJkfBF/3/dD4pVCwc1ki
         bg8Pt1LP1n+Jb4DG17MYTNKKIK0ZTjWPnRYjyMfS90yPgHtlt84vNqOFemhLooqiUOgb
         br3lNa034ckP54hIcILvGq1430oaY1QRvp8KvueZ8YiAa9dnoZVsdnVoP6+PbkmjRh1a
         NWjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739382764; x=1739987564;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=C/kS06FLerC2Af3s6b6Rf5nvMZaz+z4sBVLyAweX+ok=;
        b=lj734bxsbM4T3M8nsBBuS/dP/NQrU7y0I2Z9tDd8ABflalfd4kJO42XgyGMzKZk4+0
         ZPeTTVgS7frzprrTsWVe9nc4Js2Wzw8xDqYENLARF+4PjvEvZ+QbfVqJEi/LtHyoVSjn
         5qWGMp8j9dqChUt5MgA4nz2+9lHGAZgOcLtz5XHKZHBkyWieQcXd2COUTW1WOJqLvL1E
         IDcIQ++eINBNfAbo68EeT97K4Tu1MJ8FaG2CFqlzKcnFk6XF8lhzlGoPMJgjQeivC8d+
         ZrasDGpfyFF1rzvDrLmzlq6uEd34Z2JGvKIc5+3mrCWiu+ABSTcjKkbbGA6EKRGlvN1p
         AQ8w==
X-Forwarded-Encrypted: i=1; AJvYcCWZVh1cskJ0/EbcAJgNzj/HvwPeTjGv7u/3+7+AT7NjJuGaDGiDJbQqHe6oqtV/EDW7lD38X41Y6opKqgg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwbTgSo48nfe3eGbiw+f84KQOM1NPqZLq80cp7KbaPOZsFGgmZh
	JziuG94TgTQJlLYeXVTt55OCPtJpK03bnGG2yAitY98WAiMiMSpE
X-Gm-Gg: ASbGnculAcqRXEvwzUqp9ufNCqTqQEx7WnUqU11k1kEJLnDfiZ4SMenMlbXxOEWLFQf
	HFTytt6F76SVSg+lkVBA9Ge2TLU9JI+2dIQwDvJXMwe73CRXgMUvd71uD+2cXf0vJik3jr93ou0
	q+W+iiHKrg6hca4RrsNSM1Wm2TQgEdxqHchVRfPYt8q75Nm6vXn97VZg5vrFBd4ue/FgvhHSRP6
	iJXKMVAMLHMW1wTeGv60ZQ4ke0J7L+Pl2I0p10nVuR3OMz0efBUfa/TFfiDeWM6cGV9fw0P3ZFg
	C6w5fWf26QyUCDk6JoTOwA==
X-Google-Smtp-Source: AGHT+IGhAf9G/ZHnuARYEZ7FvPVEQiQFkKF3QjpnfizbwNgmuLoZolSmQ9I1VNR6kpuAh/gwQv5YZQ==
X-Received: by 2002:a05:651c:504:b0:302:3356:54e2 with SMTP id 38308e7fff4ca-30904664d33mr5547561fa.10.1739382763893;
        Wed, 12 Feb 2025 09:52:43 -0800 (PST)
Received: from [10.214.35.248] ([80.93.240.68])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-308d9e1fdfcsm15669701fa.31.2025.02.12.09.52.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Feb 2025 09:52:43 -0800 (PST)
Message-ID: <ef785e05-f52e-4a88-9377-b51b81b228ce@gmail.com>
Date: Wed, 12 Feb 2025 18:52:39 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] kasan: Don't call find_vm_area() in RT kernel
To: Waiman Long <llong@redhat.com>
Cc: Alexander Potapenko <glider@google.com>,
 Andrey Konovalov <andreyknvl@gmail.com>, Dmitry Vyukov <dvyukov@google.com>,
 Vincenzo Frascino <vincenzo.frascino@arm.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Clark Williams <clrkwllms@kernel.org>, Steven Rostedt <rostedt@goodmis.org>,
 kasan-dev@googlegroups.com, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev,
 Nico Pache <npache@redhat.com>
References: <20250211160750.1301353-1-longman@redhat.com>
 <CAPAsAGzk4h3B-LNQdedrk=2aRbPoOJeVv_tQF2QPgzwwUvirEw@mail.gmail.com>
 <cfe70f31-e650-4033-9281-baa4cdc40b96@redhat.com>
Content-Language: en-US
From: Andrey Ryabinin <ryabinin.a.a@gmail.com>
In-Reply-To: <cfe70f31-e650-4033-9281-baa4cdc40b96@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 2/12/25 2:34 PM, Waiman Long wrote:
> 
> On 2/12/25 6:59 AM, Andrey Ryabinin wrote:
>> On Tue, Feb 11, 2025 at 5:08 PM Waiman Long <longman@redhat.com> wrote:
>>> diff --git a/mm/kasan/report.c b/mm/kasan/report.c
>>> index 3fe77a360f1c..e1ee687966aa 100644
>>> --- a/mm/kasan/report.c
>>> +++ b/mm/kasan/report.c
>>> @@ -398,9 +398,20 @@ static void print_address_description(void *addr, u8 tag,
>>>                  pr_err("\n");
>>>          }
>>>
>>> -       if (is_vmalloc_addr(addr)) {
>>> -               struct vm_struct *va = find_vm_area(addr);
>>> +       if (!is_vmalloc_addr(addr))
>>> +               goto print_page;
>>>
>>> +       /*
>>> +        * RT kernel cannot call find_vm_area() in atomic context.
>>> +        * For !RT kernel, prevent spinlock_t inside raw_spinlock_t warning
>>> +        * by raising wait-type to WAIT_SLEEP.
>>> +        */
>>> +       if (!IS_ENABLED(CONFIG_PREEMPT_RT)) {
>>> +               static DEFINE_WAIT_OVERRIDE_MAP(vmalloc_map, LD_WAIT_SLEEP);
>>> +               struct vm_struct *va;
>>> +
>>> +               lock_map_acquire_try(&vmalloc_map);
>>> +               va = find_vm_area(addr);
>> Can we hide all this logic behind some function like
>> kasan_find_vm_area() which would return NULL for -rt?
> Sure. We can certainly do that.
>>
>>>                  if (va) {
>>>                          pr_err("The buggy address belongs to the virtual mapping at\n"
>>>                                 " [%px, %px) created by:\n"
>>> @@ -410,8 +421,13 @@ static void print_address_description(void *addr, u8 tag,
>>>
>>>                          page = vmalloc_to_page(addr);
>> Or does vmalloc_to_page() secretly take  some lock somewhere so we
>> need to guard it with this 'vmalloc_map' too?
>> So my suggestion above wouldn't be enough, if that's the case.
> 
> AFAICS, vmalloc_to_page() doesn't seem to take any lock.  Even if it takes another spinlock, it will still be under the vmalloc_map protection until lock_map_release() is called.
> 

I meant to do something like bellow, which would leave vmalloc_to_page() out of vmalloc_map scope.
That's why I raised this question.

---
 mm/kasan/report.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/mm/kasan/report.c b/mm/kasan/report.c
index 3fe77a360f1c..f3683215f4ca 100644
--- a/mm/kasan/report.c
+++ b/mm/kasan/report.c
@@ -370,6 +370,20 @@ static inline bool init_task_stack_addr(const void *addr)
 			sizeof(init_thread_union.stack));
 }
 
+static inline struct vm_struct *kasan_find_vm_area(void *addr)
+{
+	static DEFINE_WAIT_OVERRIDE_MAP(vmalloc_map, LD_WAIT_SLEEP);
+	struct vm_struct *va;
+
+	if (IS_ENABLED(CONFIG_PREEMPT_RT))
+		return NULL;
+
+	lock_map_acquire_try(&vmalloc_map);
+	va = find_vm_area(addr);
+	lock_map_release(&vmalloc_map);
+	return va;
+}
+
 static void print_address_description(void *addr, u8 tag,
 				      struct kasan_report_info *info)
 {
@@ -399,8 +413,7 @@ static void print_address_description(void *addr, u8 tag,
 	}
 
 	if (is_vmalloc_addr(addr)) {
-		struct vm_struct *va = find_vm_area(addr);
-
+		struct vm_area *va = kasan_find_vm_area(addr);
 		if (va) {
 			pr_err("The buggy address belongs to the virtual mapping at\n"
 			       " [%px, %px) created by:\n"
-- 
2.45.3



