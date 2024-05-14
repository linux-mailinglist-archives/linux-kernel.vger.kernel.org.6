Return-Path: <linux-kernel+bounces-178450-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F3C28C4DE0
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 10:44:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6FC281C214C7
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 08:44:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A13841F956;
	Tue, 14 May 2024 08:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="DGLG51Lz"
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BB7721379
	for <linux-kernel@vger.kernel.org>; Tue, 14 May 2024 08:44:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715676277; cv=none; b=iKPFyq+oiievpquFReCCc4QtkvOAf5iCMfwQrXqFfBMXbTbdgzXKEiA7j5LqlrY4fW6WxeDw/F3FGVZiHPscAUTsbRkPBqHtGnQfp7CWB7n8ygYzmz9HQwgB8f1J7wLnG2ZwV3zVx+OFkJSGJmK6x+nbx9K0SZdYZ2Kjd4rnfuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715676277; c=relaxed/simple;
	bh=uzGeiWBQByNTaIZA/4ANF82aVF6I0/7sMdOK/0ExNDU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hreT6NFFrlwseK5RwGCYyxWGYg+21ATA+nOqMeHcWR6Wy3O8AxKHPd3MD94rRgGBq28FgKSY9Pt6xLBFX80Wx5MFgeI4eRP/hEFYeKEayjJd7ZA4kp1qyipy3w+ql1yiPrVUmfK2iwfonY6ZcbG6R6lOGjSCCZ5TqE5/zRtvocQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=DGLG51Lz; arc=none smtp.client-ip=117.135.210.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=zMthe
	3F+nHLXtPDyBFu2zGfONUkQQkqGspEWCphGXS4=; b=DGLG51LzOEEqGOR3TMbqR
	J/Co3y5/mdBC3+kobT+FY5p6hwnzR44gyH9KRVcf6L9jpnVXqicJUyZtUZkGD9W0
	A2BzK+cfFD+cRLo528++PXZDb14Ea29OL63co0N/6VkjVZibSDvmtqwz+nBBfpvY
	rnKCfy8VsGf+XlHhrbgJSg=
Received: from localhost.localdomain (unknown [193.203.214.57])
	by gzga-smtp-mta-g3-4 (Coremail) with SMTP id _____wB3L7ZUJENm_AduAg--.60110S4;
	Tue, 14 May 2024 16:44:06 +0800 (CST)
From: ran xiaokai <ranxiaokai627@163.com>
To: david@redhat.com
Cc: ran.xiaokai@zte.com.cn,
	akpm@linux-foundation.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	shy828301@gmail.com,
	willy@infradead.org,
	xu.xin16@zte.com.cn,
	ziy@nvidia.com
Subject: Re: [PATCH linux-next] mm/huge_memory: mark racy access on huge_anon_orders_always
Date: Tue, 14 May 2024 08:44:03 +0000
Message-Id: <20240514084403.661740-1-ranxiaokai627@163.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <10529556-e22d-4afa-803d-c75511ce8425@redhat.com>
References: <10529556-e22d-4afa-803d-c75511ce8425@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wB3L7ZUJENm_AduAg--.60110S4
X-Coremail-Antispam: 1Uf129KBjvJXoW7Ar45JF4UXr13Jr4kCF4Uurg_yoW8GrWrpF
	97GF1xAFy8Zr9IyrW7Za17Ar48XrZxGa4Uur1Sg3ZFyasrtwn2yr1q934ak3Z8Zry7Ka1f
	uryUWa9Ykws8XF7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UOYFZUUUUU=
X-CM-SenderInfo: xudq5x5drntxqwsxqiywtou0bp/1tbiMxneTGXAlNIP9QAAsh

Hi, David

Thanks for taking time to review!

>> From: Ran Xiaokai <ran.xiaokai@zte.com.cn>
>> 
>> huge_anon_orders_always and huge_anon_orders_always are accessed
>
> "huge_anon_orders_always" mentioned twice.

yes, my mistake.

>> lockless, it is better to use the READ_ONCE() wrapper.
>> This is not fixing any visible bug, hopefully this can cease some
>> KCSAN complains in the future.
>> Also do that for huge_anon_orders_madvise.
>> 
>> Signed-off-by: Ran Xiaokai <ran.xiaokai@zte.com.cn>
>> ---
>>   include/linux/huge_mm.h | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>> 
>> diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
>> index de0c89105076..6573430ea600 100644
>> --- a/include/linux/huge_mm.h
>> +++ b/include/linux/huge_mm.h
>> @@ -122,8 +122,8 @@ static inline bool hugepage_flags_enabled(void)
>>   	 * So we don't need to look at huge_anon_orders_inherit.
>>   	 */
>>   	return hugepage_global_enabled() ||
>> -	       huge_anon_orders_always ||
>> -	       huge_anon_orders_madvise;
>> +			READ_ONCE(huge_anon_orders_always) ||
>> +			READ_ONCE(huge_anon_orders_madvise);
>
> Don't mess up the alignment please.

yes.

I will wait for other feedbacks and then send out a v2 version.

>>   }
>> 
>>   static inline int highest_order(unsigned long orders)
>
> Acked-by: David Hildenbrand <david@redhat.com>


