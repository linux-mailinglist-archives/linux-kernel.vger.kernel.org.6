Return-Path: <linux-kernel+bounces-201650-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CA3A8FC15C
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 03:35:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 213591F2359E
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 01:35:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AA274EB55;
	Wed,  5 Jun 2024 01:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="pFoh1fj5"
Received: from m16.mail.126.com (m16.mail.126.com [220.197.31.6])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C8348F44
	for <linux-kernel@vger.kernel.org>; Wed,  5 Jun 2024 01:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717551327; cv=none; b=ijhrXZD2OUoiiwvJb5FgDXvZ0lz37fTn3zAhLhZ3+gj3I2QiYfC3DqQU8B68PrKiqIfC1xWXCOkmhOiMCuaDhSDVMTQMt7PMVxRXR5WDGVnziyHazRylep6hiXMA6WD45lDwJuNNazoUMSDC0Bo5EIusJvFed7bDtghwZoiTTZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717551327; c=relaxed/simple;
	bh=5fyKHdGKG1mTxB7nJ7EFX6bjUuDwMA88Vxme/x1HbiU=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=YUUY00pkIsO7S0gCbRmlU+piyRwZj6hNa6vQ2s117wjYnFwPH+BJMlJYNB13wFjGrf9GzXnoTGlUv32xu6zAPQVFF/Vh3jQrr6bg+Ikjfu/j9TYi4suRJVoKUgynsqwBc8Tu6hw+rEDmeHfSt7wSNxbDI6kn/HCCdPxvpkPw4Mo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com; spf=pass smtp.mailfrom=126.com; dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b=pFoh1fj5; arc=none smtp.client-ip=220.197.31.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=Subject:From:Message-ID:Date:MIME-Version:
	Content-Type; bh=XqtLqw5329DmSQfIZ97wQcsPfrI3RrJ1xo0vGF5vAKA=;
	b=pFoh1fj5y+mAh6u0Re9hvnRfG8mQP4A+VCS8o8oatud3SM4lxHVK3p4jtVdAd/
	f7Ba/2Z+uPIbY6qa6Q0u8xT7K604BYH80LaTjSD3lcN13c2dp2xPC7uN4SnsP5Q4
	jVQ1XcBBQpTtrwWjkK2WTCMrpTECtuO4thb8W2uGJwQss=
Received: from [172.21.21.216] (unknown [118.242.3.34])
	by gzga-smtp-mta-g1-1 (Coremail) with SMTP id _____wD3nzTOvF9mJD+PAg--.13775S2;
	Wed, 05 Jun 2024 09:18:07 +0800 (CST)
Subject: Re: [PATCH] mm/gup: don't check page lru flag before draining it
To: David Hildenbrand <david@redhat.com>, akpm@linux-foundation.org
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 baolin.wang@linux.alibaba.com, liuzixing@hygon.cn
References: <1717498121-20926-1-git-send-email-yangge1116@126.com>
 <0d7a4405-9a2e-4bd1-ba89-a31486155233@redhat.com>
From: yangge1116 <yangge1116@126.com>
Message-ID: <dc7a0b61-8d3f-7205-2f6d-c2b12500947a@126.com>
Date: Wed, 5 Jun 2024 09:18:06 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <0d7a4405-9a2e-4bd1-ba89-a31486155233@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3nzTOvF9mJD+PAg--.13775S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxJr1rCrWxuFyDJry3ZF45GFg_yoW8XF1Dpr
	W8KwnxKrsrKFWakrZrX3s8ZryFy3ySyF48tF13Wr129FsxXw1jkr1Ika13uay3Gry5u3Z2
	9a15JF1vvFs0vaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07boDGrUUUUU=
X-CM-SenderInfo: 51dqwwjhrrila6rslhhfrp/1tbiWR70G2VLajynIwABsV



在 2024/6/4 下午9:47, David Hildenbrand 写道:
> On 04.06.24 12:48, yangge1116@126.com wrote:
>> From: yangge <yangge1116@126.com>
>>
>> If a page is added in pagevec, its ref count increases one, remove
>> the page from pagevec decreases one. Page migration requires the
>> page is not referenced by others except page mapping. Before
>> migrating a page, we should try to drain the page from pagevec in
>> case the page is in it, however, folio_test_lru() is not sufficient
>> to tell whether the page is in pagevec or not, if the page is in
>> pagevec, the migration will fail.
>>
>> Remove the condition and drain lru once to ensure the page is not
>> referenced by pagevec.
> 
> What you are saying is that we might have a page on which 
> folio_test_lru() succeeds, that was added to one of the cpu_fbatches, 
> correct?

Yes

> 
> Can you describe under which circumstances that happens?
> 

If we call folio_activate() to move a page from inactive LRU list to 
active LRU list, the page is not only in LRU list, but also in one of 
the cpu_fbatches.

void folio_activate(struct folio *folio)
{
     if (folio_test_lru(folio) && !folio_test_active(folio) &&
         !folio_test_unevictable(folio)) {
         struct folio_batch *fbatch;

         folio_get(folio);
         //After this, folio is in LRU list, and its ref count have 
increased one.

         local_lock(&cpu_fbatches.lock);
         fbatch = this_cpu_ptr(&cpu_fbatches.activate);
         folio_batch_add_and_move(fbatch, folio, folio_activate_fn);
         local_unlock(&cpu_fbatches.lock);
     }
}


