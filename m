Return-Path: <linux-kernel+bounces-197265-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 562C98D6868
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 19:46:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 06A4A1F28B79
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 17:46:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2A6317C9EE;
	Fri, 31 May 2024 17:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DxUCrQCc"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BC4336B11
	for <linux-kernel@vger.kernel.org>; Fri, 31 May 2024 17:46:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717177609; cv=none; b=Vc8Vl2xkGHY2WtWUBijvqg0vipI0YIqKcbBqmx7Ii5RpGtE/J7oBpF6lwD1GhlWhVGCZqYZQA5lDTUg6B7USWMfbZYo7BIekyp8ClYuEn3ihnvuNnA4KIscr39cQhN7FRXFDn0RxtPK0P05BISNWJExa1suPT5xJ0hm5bv5lypg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717177609; c=relaxed/simple;
	bh=mlY035+nOIiycwD3JGVb0o5bgfKibo7U33O9gnjT0VM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mfqs0+yEGauu+JEscoNA5OPSh5jJ6m8My/kec1+qzNT6A94EFlJB03+kCG9zy9sLp37WTT7lsqNH8KaQd5qONzc9AYGh9khdVc8VMKtorGZC5DyrV+2hAnB+7CjHgAP3cXXA7SUIrR2T5r8cZ4+2VE7EKicamUOCJP6T9WdjdVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DxUCrQCc; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717177606;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=a1fq5u2Uv/jhpAmOMhgb6AcykR228pl7Ui+mLl+ARFQ=;
	b=DxUCrQCcmagnptRWZUdSth62AZIPXEkoJWWn7p1+f6qtnlv7JdWBDhGBWC8mPwQmVu/695
	uiSPGPlx8LaGlb7U5U91NUskQSqT8OyCP275JucnLB4tvVi7l+mXfBvUF2sfx+ZosUKumP
	4+QY30khoCV6jz20ZIUOG0b+oOlcqTM=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-153-0ObZrwsDNTmQ7OPIIbGiLA-1; Fri, 31 May 2024 13:46:44 -0400
X-MC-Unique: 0ObZrwsDNTmQ7OPIIbGiLA-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-42110ebbd0fso17747985e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 31 May 2024 10:46:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717177603; x=1717782403;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=a1fq5u2Uv/jhpAmOMhgb6AcykR228pl7Ui+mLl+ARFQ=;
        b=GUEbPejjmvEHI5HI8S+WLDqot3bly7ziLdAUcHWNkpKSCci7gfeEFnRQWD7Du7XDzm
         0N+yxV0dfjeEgT6x6V8es0oFZk95G8jpc5ZKANKMdivBgjCJ3PgGwIRYmJHKvE/sEWhq
         WSLIL5ex0wyfDa+XZ/iqiUbDZjjQs63Rf/3W0DfDGFdVxDemHmOQEZ5mYy8u68WfVnVM
         Y+RfucEdDOhqMxTzLeICyK6dg2Og6S3V7Mi1EqiQoPN5MG6Q9kEC6WBD8wAqtkzHb1Xl
         4AhWX7rVSR6DSJAaObUg4hvNOK5lEtfzNc3/T1WGWrpNj7bNywuhRDN7Dobq0ltK4Ui+
         rIsw==
X-Forwarded-Encrypted: i=1; AJvYcCX+7QcwG/V/FfHdZuIH1JPogBe9bglAmgl9ZO0iKKD4UOV/4znL0COAmsClFHuLXRm7z9r3/YlTQ9qHQYTCFFiL7uZyBErgzq3BVKXy
X-Gm-Message-State: AOJu0Yxk1sFd0youNf/SHkpSyfRdhEi+OQixFdQhtdAtlccVzu88KPRZ
	8t7MBratsMgj9IbFVVyeXb0Igl+teikNezy0pNA5I8HS2b50BrJtKeySYROHnjGMS1MLbm/kJAY
	L7pNqe0enaoDP8M3yd+14zY3104JOLPPHv8RNReUdMPK2/giYetP9ICv38q/aAg==
X-Received: by 2002:a05:600c:4684:b0:420:2a22:bd3e with SMTP id 5b1f17b1804b1-4212e075641mr22424775e9.18.1717177603366;
        Fri, 31 May 2024 10:46:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHs18RxxcGCy9EFxbER9iLoqJC/2KwoQ4QwwX5uBVf2gu7EBHWSYPMWkiWRqlbJHCMNPBBxbQ==
X-Received: by 2002:a05:600c:4684:b0:420:2a22:bd3e with SMTP id 5b1f17b1804b1-4212e075641mr22424585e9.18.1717177602878;
        Fri, 31 May 2024 10:46:42 -0700 (PDT)
Received: from ?IPV6:2003:cb:c717:a000:d4df:4b8f:37d4:59e4? (p200300cbc717a000d4df4b8f37d459e4.dip0.t-ipconnect.de. [2003:cb:c717:a000:d4df:4b8f:37d4:59e4])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4212705515bsm62714235e9.1.2024.05.31.10.46.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 31 May 2024 10:46:42 -0700 (PDT)
Message-ID: <890e5a79-8574-4a24-90ab-b9888968d5e5@redhat.com>
Date: Fri, 31 May 2024 19:46:41 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [linus:master] [mm] efa7df3e3b:
 kernel_BUG_at_include/linux/page_ref.h
To: Yang Shi <shy828301@gmail.com>, kernel test robot
 <oliver.sang@intel.com>, Peter Xu <peterx@redhat.com>,
 Jason Gunthorpe <jgg@nvidia.com>, Peter Xu <peterx@redhat.com>,
 Vivek Kasireddy <vivek.kasireddy@intel.com>
Cc: Rik van Riel <riel@surriel.com>, oe-lkp@lists.linux.dev, lkp@intel.com,
 linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
 Matthew Wilcox <willy@infradead.org>, Christopher Lameter <cl@linux.com>,
 linux-mm@kvack.org
References: <202405311534.86cd4043-lkp@intel.com>
 <CAHbLzkpMhEuGkQDGWrK1LhvZ-ZxTJkV1xjmn-nRGZMH4U+F5ZA@mail.gmail.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <CAHbLzkpMhEuGkQDGWrK1LhvZ-ZxTJkV1xjmn-nRGZMH4U+F5ZA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 31.05.24 18:50, Yang Shi wrote:
> On Fri, May 31, 2024 at 1:24 AM kernel test robot <oliver.sang@intel.com> wrote:
>>
>>
>>
>> Hello,
>>
>> kernel test robot noticed "kernel_BUG_at_include/linux/page_ref.h" on:
>>
>> commit: efa7df3e3bb5da8e6abbe37727417f32a37fba47 ("mm: align larger anonymous mappings on THP boundaries")
>> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
>>
>> [test failed on linus/master      e0cce98fe279b64f4a7d81b7f5c3a23d80b92fbc]
>> [test failed on linux-next/master 6dc544b66971c7f9909ff038b62149105272d26a]
>>
>> in testcase: trinity
>> version: trinity-x86_64-6a17c218-1_20240527
>> with following parameters:
>>
>>          runtime: 300s
>>          group: group-00
>>          nr_groups: 5
>>
>>
>>
>> compiler: gcc-13
>> test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 16G
>>
>> (please refer to attached dmesg/kmsg for entire log/backtrace)
>>
>>
>> we noticed the issue does not always happen. 34 times out of 50 runs as below.
>> the parent is clean.
>>
>> 1803d0c5ee1a3bbe efa7df3e3bb5da8e6abbe377274
>> ---------------- ---------------------------
>>         fail:runs  %reproduction    fail:runs
>>             |             |             |
>>             :50          68%          34:50    dmesg.Kernel_panic-not_syncing:Fatal_exception
>>             :50          68%          34:50    dmesg.RIP:try_get_folio
>>             :50          68%          34:50    dmesg.invalid_opcode:#[##]
>>             :50          68%          34:50    dmesg.kernel_BUG_at_include/linux/page_ref.h
>>
>>
>>
>> If you fix the issue in a separate patch/commit (i.e. not just a new version of
>> the same patch/commit), kindly add following tags
>> | Reported-by: kernel test robot <oliver.sang@intel.com>
>> | Closes: https://lore.kernel.org/oe-lkp/202405311534.86cd4043-lkp@intel.com
>>
>>
>> [  275.267158][ T4335] ------------[ cut here ]------------
>> [  275.267949][ T4335] kernel BUG at include/linux/page_ref.h:275!
>> [  275.268526][ T4335] invalid opcode: 0000 [#1] KASAN PTI
>> [  275.269001][ T4335] CPU: 0 PID: 4335 Comm: trinity-c3 Not tainted 6.7.0-rc4-00061-gefa7df3e3bb5 #1
>> [  275.269787][ T4335] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
>> [ 275.270679][ T4335] RIP: 0010:try_get_folio (include/linux/page_ref.h:275 (discriminator 3) mm/gup.c:79 (discriminator 3))
>> [ 275.271159][ T4335] Code: c3 cc cc cc cc 44 89 e6 48 89 df e8 e4 54 11 00 eb ae 90 0f 0b 90 31 db eb d5 9c 58 0f 1f 40 00 f6 c4 02 0f 84 46 ff ff ff 90 <0f> 0b 48 c7 c6 a0 54 d2 87 48 89 df e8 a9 e9 ff ff 90 0f 0b be 04
> 
> If I read this BUG correctly, it is:
> 
> VM_BUG_ON(!in_atomic() && !irqs_disabled());
>

Yes, that seems to be the one.
  
> try_grab_folio() actually assumes it is in an atomic context (irq
> disabled or preempt disabled) for this call path. This is achieved by
> disabling irq in gup fast or calling it in rcu critical section in
> page cache lookup path

try_grab_folio()->try_get_folio()->folio_ref_try_add_rcu()

Is called (mm-unstable) from:

(1) gup_fast function, here IRQs are disable
(2) gup_hugepte(), possibly problematic
(3) memfd_pin_folios(), possibly problematic
(4) __get_user_pages(), likely problematic

(1) should be fine.

(2) is possibly problematic on the !fast path. If so, due to commit
     a12083d721d7 ("mm/gup: handle hugepd for follow_page()") ? CCing Peter.

(3) is possibly wrong. CCing Vivek.

(4) is what we hit here

> 
> And try_grab_folio() is used when the folio is a large folio. The


We come via process_vm_rw()->pin_user_pages_remote()->__get_user_pages()->try_grab_folio()

That code was added in

commit 57edfcfd3419b4799353d8cbd6ce49da075cfdbd
Author: Peter Xu <peterx@redhat.com>
Date:   Wed Jun 28 17:53:07 2023 -0400

     mm/gup: accelerate thp gup even for "pages != NULL"
     
     The acceleration of THP was done with ctx.page_mask, however it'll be
     ignored if **pages is non-NULL.


Likely the try_grab_folio() in __get_user_pages() is wrong?

As documented, we already hold a refcount. Likely we should better do a
folio_ref_add() and sanity check the refcount.


In essence, I think: try_grab_folio() should only be called from GUP-fast where
IRQs are disabled.

(2), (3) and (4) are possible offenders of that.


Or am I getting it all wrong? :)

-- 
Cheers,

David / dhildenb


