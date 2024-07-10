Return-Path: <linux-kernel+bounces-248035-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A70892D791
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 19:36:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BBE551C226D4
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 17:36:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F237E195805;
	Wed, 10 Jul 2024 17:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="qpZQ71Rc"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 324DC1957F2
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 17:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720632973; cv=none; b=BmbVJ1KNADse97fiXYVuCyxcLZD71pkaKOeJV0VbcXE3RhB5kQxh7pUi0Ajy8Ch0AbDN27NrWZ1PaS/TEDxBbj4Vdph+K0TKDjlKrcUdo8PlcqZRFdJS3KBK7oIagb8RzMRzzZApcqTrFQgpXGEckKYEc8Giq/9tKiIZTi2fkGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720632973; c=relaxed/simple;
	bh=qxj7/GfbAzJhv+yT4uusdh/k5PHvVnAEDliZ3yufpvQ=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=SoPptUBl1VcHeET5VRlidveovoc7abYrdNQVRP9bZA9e0+cPAoeDrahhOmfw++LidRuGIUaMUby+yh+b03KTGg/A19xWsty+PgeWGSzyJ2/t/fUyIJJNOwYF86kqbep2wnAcGlHLyKN8VONxRfPJ9Tue7S2DZiYOeCa3RVB10II=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=qpZQ71Rc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A5C1C32781;
	Wed, 10 Jul 2024 17:36:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1720632972;
	bh=qxj7/GfbAzJhv+yT4uusdh/k5PHvVnAEDliZ3yufpvQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=qpZQ71Rc19JiZFDIK4eX07L9kOWG8E7UYV9NpPhQ/gfpFcrhbhDEwjmKIrZHo37EP
	 wDLFZfVc3hWOPavhTEPRKBn+zNspNaxcM9z8qISWLefw+Dbrvdh2QlGrGgjOH1h/gm
	 SLRTlvEORAzzJwM2nGdI/AgXRfVz8C8bSsqgaRFg=
Date: Wed, 10 Jul 2024 10:36:11 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: zhangchun <zhang.chuna@h3c.com>
Cc: <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
 <jiaoxupo@h3c.com>, <zhang.zhengming@h3c.com>, <zhang.zhansheng@h3c.com>,
 <shaohaojize@126.com>
Subject: Re: [PATCH v2] mm: Give kmap_lock before call =?UTF-8?B?Zmx1c2hf?=
 =?UTF-8?B?dGxiX2tlcm5lbF9yYW5n77yMYXZvaWQ=?= kmap_high deadlock.
Message-Id: <20240710103611.809895ff809df9ed411bfaa8@linux-foundation.org>
In-Reply-To: <1720614028-2260-1-git-send-email-zhang.chuna@h3c.com>
References: <1720614028-2260-1-git-send-email-zhang.chuna@h3c.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Wed, 10 Jul 2024 20:20:28 +0800 zhangchun <zhang.chuna@h3c.com> wrote:

> Use kmap_high and kmap_XXX or kumap_xxx among differt cores at the same
> time may cause deadlock. The issue is like this：


What is kmap_XXX?

>  CPU 0:                                                 CPU 1:
>  kmap_high(){                                           kmap_xxx() {
>                ...                                        irq_disable();
>         spin_lock(&kmap_lock)
>                ...
>         map_new_virtual                                     ...
>            flush_all_zero_pkmaps
>               flush_tlb_kernel_range         /* CPU0 holds the kmap_lock */
>                       smp_call_function_many         spin_lock(&kmap_lock)
>                       ...                                   ....
>         spin_unlock(&kmap_lock)
>                ...
> 
> CPU 0 holds the kmap_lock, waiting for CPU 1 respond to IPI. But CPU 1
> has disabled irqs, waiting for kmap_lock, cannot answer the IPI. Fix
> this by releasing  kmap_lock before call flush_tlb_kernel_range,
> avoid kmap_lock deadlock.
> 
> Fixes: 3297e760776a ("highmem: atomic highmem kmap page pinning")

Wow, that's 15 years old.  Has the deadlock been observed?

> --- a/mm/highmem.c
> +++ b/mm/highmem.c
> @@ -220,8 +220,11 @@ static void flush_all_zero_pkmaps(void)
>  		set_page_address(page, NULL);
>  		need_flush = 1;
>  	}
> -	if (need_flush)
> +	if (need_flush) {
> +		unlock_kmap();
>  		flush_tlb_kernel_range(PKMAP_ADDR(0), PKMAP_ADDR(LAST_PKMAP));
> +		lock_kmap();
> +	}
>  }

Why is dropping the lock like this safe?  What data is it protecting
and why is it OK to leave that data unprotected here?


