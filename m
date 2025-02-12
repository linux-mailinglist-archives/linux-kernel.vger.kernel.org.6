Return-Path: <linux-kernel+bounces-511662-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 78A38A32DF6
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 18:54:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0B1773A700B
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 17:54:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8713725C70E;
	Wed, 12 Feb 2025 17:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cufW9tya"
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CBA0256C70
	for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 17:54:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739382850; cv=none; b=PAQ5mwiJNHlIrv4Q7zeUl1dh4GhNyYRzi3828mAH2QjTan/afsS8vssmnyrBwM2H0gekibwyr2kzXISeYvL4Qt9HCmJ7PyMWGcceKEL7Zqw8WUNYo/uXfxsQRrPfqxZU5TxruWLSJCInJIrwZfr+bDQuLHWQ7jWWZE3JZqnhMO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739382850; c=relaxed/simple;
	bh=WWpXpHggCcPdhs4VuTxxTZKC9R3iRUIwcK6EeIbV+QQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lnFkD6lfCt4DkGu09lXESQkC85WQ8RctUwUA1S/aRkkvkfM2V7VfH0Xmdj/b8ky3i9vxmpLI2K+HqvDoco+fKVI5XDlVuoiiLzBNU4pzvyUp0LC1M1hvPt+ZTwop6iqWMUoI9hPOM7bJmvib3PG2fk9z23361ZKK/paC3BHPuOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cufW9tya; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-545061c740aso625648e87.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 09:54:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739382847; x=1739987647; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uuI5Z03zLDZiJXA9fnZE8eRXvdvS2QYxe0ggSv4hyho=;
        b=cufW9tya5+G01jvzMpUPozLOVERFZKYniPjrQoWw/eUepIKLFfkl0bjOPdSRYHubLx
         Gtx3AOqeN+1+tKYdfCF7R+FxDzQ6+pM3bdbu7jw13fWKhUzRjtio95aHno25P+/vOb5L
         l/K+GdpIrR206ExRnQu3u3JBfO68adjp9aWzRjeT1xEOZCX8Yg4ig6TIfE3X2AWD9jOb
         wrA8KbrFRrBz5dDMUHlhkfhbVTV6DSoatTBLTHyIwPkb6Eb5iEJt++MNpYkDEHh2V5pL
         k2j+tVH4aaXH73TmyTKgiPOF9cFmwS7LdCNufx21BGx2QloKdFqsJViHDIyZgfEJqY+R
         4B1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739382847; x=1739987647;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uuI5Z03zLDZiJXA9fnZE8eRXvdvS2QYxe0ggSv4hyho=;
        b=n9+zmMfpV7z5U5O/oi2aL5zevPp2K4H0hdWDJmq1JU6uVyllt5yWbPzR6em1iDc2z3
         3Yeu7H5F2d3oUIxurfOyxht0oFdCgCOR3sPYUmKkpy7i9VlZ6h60Jr97NMMs6eMU/zlY
         WKA2w5W7Cu0M5e1YPlwx+y5bulkKC8Z/uuuONv2jJbxF8VbqFbu9TYNzy+uGp6jZ99sS
         tt+RtTHe6O5bZGDoy8LzQuVHhKPSZZ4db+uewRynFxzjoSvHKIEPA5DMX4HSAKFezH7G
         WPjVn02CcyikFrMd5DaJL0qnrC9W1tXie21gBAhUmQB/JOOy9s1zRtFt/JXNrOc0XLFW
         MO1w==
X-Forwarded-Encrypted: i=1; AJvYcCW2L3ho4XAD7Iy0u1n23iPsjEW4L+T0PvV/zZFyCUtKxK+c/dnKVShuiPnZLJ1YPyim3pI1cVsEBsLoJAE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwbdLqu2w12KuwanMqX/3jicf7GjIrYIaLuKtVhtstmVZofvvgE
	WKMnJBBCdbeIdLhReOlWsOumacHxlT9E56jwTY7vkjd9EmZkr3Xg
X-Gm-Gg: ASbGncsiCKy9W251Ukbm1ZOJxvcAXnD2j5uzN9wAqJODoZ5R3bzMx9j0xiS77KoMLLE
	OVg7hsOjnCV6sRv00tvvJKCBhBZ5YCQe6j0G65KJrTaI7ywR+GRIXv+9yYTPqHtzR9G0mNfqp3+
	Pg5uPPjRpSlQ0hKL6/LY5gwx9mXbJBM+9F+ARfhmB2rG3/LmZMObqXUz0J7qsQxc7K1GsAt9J9u
	tScPJYW7gTJqmpzWPQJTsyGD+ymNCrg1stS9FLkeEy9QbSHf3dBZwUhP6FDK7P7sot50160DaJZ
	IiD100mfVYY7hGoi/P/uNA==
X-Google-Smtp-Source: AGHT+IGTf6/o1ewcGEUKre1zdVC8k6x+Y98jsCPQ4p9R3TflTMIiLyianinhYrX/Lsh2+4Tk7SDv5A==
X-Received: by 2002:a05:6512:124e:b0:545:8a1:536d with SMTP id 2adb3069b0e04-545180ddfadmr473410e87.2.1739382847092;
        Wed, 12 Feb 2025 09:54:07 -0800 (PST)
Received: from [10.214.35.248] ([80.93.240.68])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-54410555a60sm1976613e87.87.2025.02.12.09.54.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Feb 2025 09:54:06 -0800 (PST)
Message-ID: <d0d2c78d-9ea6-43c6-8413-97d21ff77bdd@gmail.com>
Date: Wed, 12 Feb 2025 18:54:02 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] kasan: Don't call find_vm_area() in RT kernel
To: Waiman Long <longman@redhat.com>, Alexander Potapenko
 <glider@google.com>, Andrey Konovalov <andreyknvl@gmail.com>,
 Dmitry Vyukov <dvyukov@google.com>,
 Vincenzo Frascino <vincenzo.frascino@arm.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Clark Williams <clrkwllms@kernel.org>, Steven Rostedt <rostedt@goodmis.org>
Cc: kasan-dev@googlegroups.com, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev,
 Nico Pache <npache@redhat.com>
References: <20250212162151.1599059-1-longman@redhat.com>
Content-Language: en-US
From: Andrey Ryabinin <ryabinin.a.a@gmail.com>
In-Reply-To: <20250212162151.1599059-1-longman@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2/12/25 5:21 PM, Waiman Long wrote:
> The following bug report appeared with a test run in a RT debug kernel.
> 
> [ 3359.353842] BUG: sleeping function called from invalid context at kernel/locking/spinlock_rt.c:48
> [ 3359.353848] in_atomic(): 1, irqs_disabled(): 1, non_block: 0, pid: 140605, name: kunit_try_catch
> [ 3359.353853] preempt_count: 1, expected: 0
>   :
> [ 3359.353933] Call trace:
>   :
> [ 3359.353955]  rt_spin_lock+0x70/0x140
> [ 3359.353959]  find_vmap_area+0x84/0x168
> [ 3359.353963]  find_vm_area+0x1c/0x50
> [ 3359.353966]  print_address_description.constprop.0+0x2a0/0x320
> [ 3359.353972]  print_report+0x108/0x1f8
> [ 3359.353976]  kasan_report+0x90/0xc8
> [ 3359.353980]  __asan_load1+0x60/0x70
> 
> Commit e30a0361b851 ("kasan: make report_lock a raw spinlock")
> changes report_lock to a raw_spinlock_t to avoid a similar RT problem.
> The print_address_description() function is called with report_lock
> acquired and interrupt disabled.  However, the find_vm_area() function
> still needs to acquire a spinlock_t which becomes a sleeping lock in
> the RT kernel. IOW, we can't call find_vm_area() in a RT kernel and
> changing report_lock to a raw_spinlock_t is not enough to completely
> solve this RT kernel problem.
> 
> Fix this bug report by skipping the find_vm_area() call in this case
> and just print out the address as is.
> 
> For !RT kernel, follow the example set in commit 0cce06ba859a
> ("debugobjects,locking: Annotate debug_object_fill_pool() wait type
> violation") and use DEFINE_WAIT_OVERRIDE_MAP() to avoid a spinlock_t
> inside raw_spinlock_t warning.
> 
> Fixes: e30a0361b851 ("kasan: make report_lock a raw spinlock")
> Signed-off-by: Waiman Long <longman@redhat.com>
> ---
>  mm/kasan/report.c | 47 ++++++++++++++++++++++++++++++++++-------------
>  1 file changed, 34 insertions(+), 13 deletions(-)
> 
>  [v2] Encapsulate the change into a new
>       kasan_print_vmalloc_info_ret_page() helper
> 

Not exactly what I had i mind, but this way is fine too.

Acked-by: Andrey Ryabinin <ryabinin.a.a@gmail.com>

