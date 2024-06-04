Return-Path: <linux-kernel+bounces-200340-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA2CE8FAE9D
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 11:20:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 83A1F288B1E
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 09:20:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4844214387B;
	Tue,  4 Jun 2024 09:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="Ffp5j4SO"
Received: from m16.mail.126.com (m16.mail.126.com [220.197.31.8])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5B021411F2
	for <linux-kernel@vger.kernel.org>; Tue,  4 Jun 2024 09:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717492810; cv=none; b=bpCWhNFZUOZspV+bnUgfLeh4cY543rZS0AjHNHiTL021pJ5QRQES0GHFXxKDZo9H8d6lfzul61l3bUd+2/A2DhGIxd962Lnk/3dXzRyrfzZqM9HmY4CsGLVBxk1aY5K5wxtL1oXfC05RDHvXGccqT+1EHlAYY/lfWR5Sni9lZMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717492810; c=relaxed/simple;
	bh=Hz2rMUH8vA9k6/j33y8lOnekyhAYp/1aXHtW+lwvvI8=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=ietG/IRD5DsUm7O8GLRUnNZka9Mq2qFNux4NCFCqrAzGZyVT1d7AzSMRush7kCS+YxciVHgBBSmucRo3ThB7Ot/Ex1JTwDr89Mf/+mBOt9w/TMu2Q7c+V0BdVOf4N0Hr4v/8UGuVntgW0ISUqYWwxJo2Dr+yv9ul3aSbXe1pJak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com; spf=pass smtp.mailfrom=126.com; dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b=Ffp5j4SO; arc=none smtp.client-ip=220.197.31.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=Subject:From:Message-ID:Date:MIME-Version:
	Content-Type; bh=2DDm8l35/Bltp4qP4Zdve1JaiaMBihsWKQJn9UAiG0g=;
	b=Ffp5j4SOSR1KmXVfar+nho8Ored+FDSzLLOrOVU6PFc97UDqBWN3jA3zxDK+Tx
	CgS1VBrlaD7WC4odK4/phw+03DwNgWNXaDLiesH8Srm61Xeyq8pm2BtK+zEnEi4+
	T1FWjOLyGyFWzb4IoIcH5px8NTn52sIxEDWfFOqojcFdQ=
Received: from [172.21.21.216] (unknown [118.242.3.34])
	by gzga-smtp-mta-g1-5 (Coremail) with SMTP id _____wD33y0B3F5mbUi8Cw--.59253S2;
	Tue, 04 Jun 2024 17:18:58 +0800 (CST)
Subject: Re: [PATCH] mm/gup: don't check page lru flag before draining it
To: Baolin Wang <baolin.wang@linux.alibaba.com>, akpm@linux-foundation.org
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, liuzixing@hygon.cn
References: <1717488551-18053-1-git-send-email-yangge1116@126.com>
 <89bd659b-a85f-48f2-98ce-f7522cdb95da@linux.alibaba.com>
From: yangge1116 <yangge1116@126.com>
Message-ID: <b61ee830-0833-e8ca-4c23-f83823b04d2e@126.com>
Date: Tue, 4 Jun 2024 17:18:57 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <89bd659b-a85f-48f2-98ce-f7522cdb95da@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD33y0B3F5mbUi8Cw--.59253S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7Ww4xXr18ZF48Xr18Kr17ZFb_yoW8GF4kpF
	18KF1YkFZFqryvy3W2qa95ZF90yrWqvr48Kr43JFy5CwnxWryUtr42qrn7u3Z5CrWUAa1a
	yrWYq3WI9F4qka7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07bOWlgUUUUU=
X-CM-SenderInfo: 51dqwwjhrrila6rslhhfrp/1tbiGAjzG2VLblcTcgAAsO



在 2024/6/4 下午4:56, Baolin Wang 写道:
> 
> 
> On 2024/6/4 16:09, yangge1116@126.com wrote:
>> From: yangge <yangge1116@126.com>
>>
>> If a page is added in pagevec, its ref count increases one, remove
>> the page from pagevec decreases one. Page migration requires the
>> page is not referrened by others except page mapping. Before
>> migrating a page, we should try to drain the page from pagevec in
>> case the page is in it, however, folio_test_lru() is not sufficient
>> to tell whether the page is in pagevec or not, if the page is in
>> pagevec, the migration will fail.
>>
>> Remove the condition and drain lru once to ensure the page is not
>> referrenced by pagevec.
> 
> This looks sane to me and seems a simple way to fix.
> 
>> Signed-off-by: yangge <yangge1116@126.com>
>> ---
>>   mm/gup.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/mm/gup.c b/mm/gup.c
>> index ca0f5ce..890dcbc 100644
>> --- a/mm/gup.c
>> +++ b/mm/gup.c
>> @@ -2411,7 +2411,7 @@ static unsigned long 
>> collect_longterm_unpinnable_pages(
>>               continue;
>>           }
>> -        if (!folio_test_lru(folio) && drain_allow) {
>> +        if (drain_allow) {
>>               lru_add_drain_all();
>>               drain_allow = false;
>>           }
> 
> You should rebase your code on the latest mm-unstable branch, as 
> collect_longterm_unpinnable_pages() in the upstream has been replaced 
> with collect_longterm_unpinnable_folios().
Ok, thanks


