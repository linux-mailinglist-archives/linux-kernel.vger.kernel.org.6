Return-Path: <linux-kernel+bounces-200620-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A0BC18FB277
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 14:42:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 04449B23B02
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 12:42:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB797146004;
	Tue,  4 Jun 2024 12:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hcIwl54q"
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5F003236
	for <linux-kernel@vger.kernel.org>; Tue,  4 Jun 2024 12:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717504950; cv=none; b=NZJN/GRhN/2rVHhqR+Cc1GV/0srbz3e1O0zkH0AUV7KO1ZFsLbvllzKMkfC2ItfQhvRnXyO7VJzGetq09U+KcFGyMVHqmnNi++vSZ3ImCgywhWyQ/UJ3GZBx4JScojKsQ1JCic6rC9Jxu4iPMpZPQOFAgm8YrEYDBt100yBgtQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717504950; c=relaxed/simple;
	bh=BMnlfEJlTS0IQ6FzNJfbrm417QDYt9wsDIxW3CbVFbI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=h6vvfNaNAtMaZVzCJhZ4g62DrR2EBbmyCqMjjzBTJ7lK9XbbxPrYvGnLNUOwJdUhFolH5D+K6iK8OZh5M2Kla4iCcjKylAhM4ZxseRlBjvt7SQq0X9ViWdKbxxVA6OgaCRW0NOJCbgNjEbqzGuwv9j/mZe/tcbIbPopvDlvwJBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hcIwl54q; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-57a2ed9af7dso6037515a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jun 2024 05:42:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717504947; x=1718109747; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=E/n7qDUO8vNDyhk1OfOnQdEu1R0VNUdXXI3i796MnfM=;
        b=hcIwl54qMejb37KcacGTkApKY/Mhpz8Pp9IdTqAXbQ2WPvOIsFP3jP8GnAtyzxDHix
         Cy8Kwp0nCFeSNaTEscUK+kHvn/C5qF++E3KX/ujEuOJlj2Lky5XOUq1otC/NUuO706p+
         fBQLa6emKS8nGT69EacCDgCEiMSuIYa30zdXE/PgDjNc2HqXIgW48PuMoTxTHNL+mJt7
         pQRPG7bPcdK66dYGxCWmNQgOiRU6akl0m4+t19zcqg7rropTvuMH7B9P5Dnn8BZOlzK+
         nVuHeQzCAvkHfzATlRHCPahb4VfY2H7xx2XfUeyt1luswiXBekWbcmGThx5PMoOLRuOt
         PCBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717504947; x=1718109747;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=E/n7qDUO8vNDyhk1OfOnQdEu1R0VNUdXXI3i796MnfM=;
        b=bgibbynm3TXuYIEzFNZZY/0xLu+gKcd9JudsN/S59QN+2HbcTkF0XBYKvSdtIrG1QZ
         usI9RVvQVOfXyZ8LvL2LGVz+V8gQ8BoCbwUfBwKIEIrKorz336pflNZ+ApXt+FT1xETf
         99Iluw2p2EPQH8xDSF36FGF1vlvbefOG7XGvK5B2Jz+PuWIBQWuhT5YsmRBu6AZWSfpt
         lv7rgqI1II/xglk5pfBLIANW2UuT/P4Rvd3pPrKVMwYKDEvZn1ScH2mfHW+2AMiOHLIp
         hNf3zEmatgbsHwJzFZCVGHspUDkDL7qiynp9wIvvcRqaKYPv4RTMYU2+cNH0G5zbT6e2
         vUgQ==
X-Forwarded-Encrypted: i=1; AJvYcCWCBc8o00nXszFt65BZfdYSOTDTT31e1KqtX+PqlyVlbzzzpD78gA5VcHGap0qAgL0Kc0sCBc/EA/Ld6vynYPwXd2iUDPVfEx8shqJl
X-Gm-Message-State: AOJu0Yy58OJWokyktH2y2wqXrYhg/5RqCiKlYDKZloF2D1BqkQ8c+KmO
	LTECGycXMHJJ4gCaypnaEPMD9flfDG92GzXgQb1JX+fbv6jkBWQD
X-Google-Smtp-Source: AGHT+IG1f3N8E8h8dd5RXfWarq1rkORxg30YgDuAutOa3Hlj7zfGb3DMFpeDTx0wjEmdM/jgwBqo+g==
X-Received: by 2002:a17:906:ecb6:b0:a68:2d37:fb5a with SMTP id a640c23a62f3a-a682d37fd6amr799648866b.4.1717504946805;
        Tue, 04 Jun 2024 05:42:26 -0700 (PDT)
Received: from ?IPV6:2a03:83e0:1126:4:eb:d0d0:c7fd:c82c? ([2620:10d:c092:500::5:89fc])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a68f2d64203sm367906666b.212.2024.06.04.05.42.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Jun 2024 05:42:26 -0700 (PDT)
Message-ID: <7253d276-1bbc-47a8-a5c3-c7c8ec43bab0@gmail.com>
Date: Tue, 4 Jun 2024 13:42:25 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] mm: clear pte for folios that are zero filled
To: Matthew Wilcox <willy@infradead.org>
Cc: akpm@linux-foundation.org, hannes@cmpxchg.org, yosryahmed@google.com,
 nphamcs@gmail.com, chengming.zhou@linux.dev, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, kernel-team@meta.com
References: <20240604105950.1134192-1-usamaarif642@gmail.com>
 <20240604105950.1134192-2-usamaarif642@gmail.com>
 <Zl8GDlOSh56VgRtj@casper.infradead.org>
Content-Language: en-US
From: Usama Arif <usamaarif642@gmail.com>
In-Reply-To: <Zl8GDlOSh56VgRtj@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 04/06/2024 13:18, Matthew Wilcox wrote:
> On Tue, Jun 04, 2024 at 11:58:24AM +0100, Usama Arif wrote:
>> +++ b/mm/rmap.c
>> @@ -1819,96 +1819,101 @@ static bool try_to_unmap_one(struct folio *folio, struct vm_area_struct *vma,
>>   			 */
>>   			dec_mm_counter(mm, mm_counter(folio));
>>   		} else if (folio_test_anon(folio)) {
>> -			swp_entry_t entry = page_swap_entry(subpage);
>> -			pte_t swp_pte;
>> -			/*
>> -			 * Store the swap location in the pte.
>> -			 * See handle_pte_fault() ...
>> -			 */
>> -			if (unlikely(folio_test_swapbacked(folio) !=
>> -					folio_test_swapcache(folio))) {
>> +			if (flags & TTU_ZERO_FOLIO) {
>> +				pte_clear(mm, address, pvmw.pte);
>> +				dec_mm_counter(mm, MM_ANONPAGES);
>> +			} else {
> This is very hard to review.  Is what you've done the same as:
>
> 			if (flags & TTU_ZERO_FOLIO) {
> 				pte_clear(mm, address, pvmw.pte);
> 				dec_mm_counter(mm, MM_ANONPAGES);
> 				goto discard;
> 			}
>
> ?  I genuinely can't tell.
>
Yes, thats what I am doing, will switch to above in next revision, Thanks!

