Return-Path: <linux-kernel+bounces-268494-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4496894254D
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 06:15:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D5203B243D1
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 04:14:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF3801B964;
	Wed, 31 Jul 2024 04:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P8JfWHLu"
Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5A42D51C
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 04:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722399290; cv=none; b=Umd9Pg2Q9J3/9caBVAMLZY7+LZ/2NdvCdA5U5q+PEMct2tVkB50TwMjryjUpJ1cb6hjaMFdNLfGvD+KVFTnYFMPoqg/eSZ/fhyUqHdpNO9/iTkxi6i7DWuyLCrDxg6IhbvPGw/kr9Y9zowgBlzVjR6KWr3PklyYVZWtAAydSIwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722399290; c=relaxed/simple;
	bh=iWf9tURr24PLvKdM/gsrZGW46AiQA+Nol1wnwIHK64w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WWOjQ8o9VJ4dZvTR/N5S8MUAGnfFDZpKlHx1KVtODmerGUYlI0JPMkcS222CjyS4ESgwMXtZRgOUnpuij1twghuTjaIo44J6F2lEw7cYepZ65vUI+710DAjpl1qTN30j1WhdCjutRFfz35DO7yT4E+dtZSdpOUWtOBGbkyuj7kk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P8JfWHLu; arc=none smtp.client-ip=209.85.210.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-709346604a7so2100163a34.1
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 21:14:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722399288; x=1723004088; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DNL7NFkFF5FUxcfpExxj2V2R2UfPEnaSrY2fTx/MR1s=;
        b=P8JfWHLux9mH95ISVtfzjkV71P0uPJN5zXHCMFeMfDa5bTS2oxrhoROOJweVHRa1JM
         P8VjASx2uxXnrTzIgAw2kxTDoOZ1pkLblP3KLrLwb6qVWSXPtYifG4I55XLur0oTO98o
         l+7VULcQ4+Y8EUs8soV4AcYBZb/ayHFKAW77I+KF6TH0HYxBe69GwGyuAV2LBJNRZQd9
         hMLKv9ByJjAjcP2cl/HM/tD+dEctlhwpcq7jKZvtx2ZXHWF+aMzNFT8MFLeOomerXTzt
         S7e2kUWgr2xzrDpb7HhPkN9TymRmsOT/kjdzevuWiAA5Nrj/aHJXtpSzWHLNHdcpH3MM
         bDtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722399288; x=1723004088;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DNL7NFkFF5FUxcfpExxj2V2R2UfPEnaSrY2fTx/MR1s=;
        b=PEBGX+e41yniJ2W4ba5xkuzWzn752DaTZhEdbLoovmoL1j2OfSsgx2zb9kFZWoqEPm
         pbu0nroQgssrZLQ1bCF991P2YXy1btjgXc7q4/SED1IhJYhgh1fHS5R0aNHeVBqrU6vD
         KT37KJyLb91dj0oB31rGrkfdrsj+KO0e7zC9AQ8OO5VsS7d90SSmQqNgM4WSEO+IX0qM
         68C/4C5NbIk6mGxtzDohqieYzUwyCHz/vXBH71RTaFBjI8MKRuMvV4E36U+icUf+UY7l
         TV1eHPipEQogViDmLqMm5fUny+3ExpJeNiq9xz4n+4NhFXwta1TlKcHL5+hCmUFeCvej
         suvw==
X-Forwarded-Encrypted: i=1; AJvYcCVNdtbICj193ulBQ6sfSyh4PNrRTCvYEVqtpixxdqyfIzBRVVdfJlZYEcEORWjlNANzpF/B4sQcUbrbqh8o+yl3mn2XPN+CjwpjU6t/
X-Gm-Message-State: AOJu0YzSoDtfpOkcyDKWqZ6vj6g7YMPHyDaZBG43ONWG+/QMyOrq5yw8
	A7HIZAyoSJ2qY8O5g6OeIeI/bFuPKS8ciqe09rcSF6ktz5BuDLCm
X-Google-Smtp-Source: AGHT+IEX1prPmIFIeqrORL9JH3Dud7a2tNptrr6Vggd45C+iXglyBbfvs5ramvLw9JlVo4nqcrEEtw==
X-Received: by 2002:a9d:5f09:0:b0:703:fdda:fe2b with SMTP id 46e09a7af769-70940c0e09amr14129305a34.11.1722399287720;
        Tue, 30 Jul 2024 21:14:47 -0700 (PDT)
Received: from [192.168.255.10] ([43.132.141.21])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70ead8aa702sm9107977b3a.215.2024.07.30.21.14.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Jul 2024 21:14:47 -0700 (PDT)
Message-ID: <c614ec0c-ff5c-4ef6-8542-53ee5308f62a@gmail.com>
Date: Wed, 31 Jul 2024 12:14:42 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 22/22] mm/zsmalloc: update comments for page->zpdesc
 changes
To: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: alexs@kernel.org, Vitaly Wool <vitaly.wool@konsulko.com>,
 Miaohe Lin <linmiaohe@huawei.com>, Andrew Morton
 <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, minchan@kernel.org, willy@infradead.org,
 david@redhat.com, 42.hyeyoo@gmail.com, Yosry Ahmed <yosryahmed@google.com>,
 nphamcs@gmail.com
References: <20240729112534.3416707-1-alexs@kernel.org>
 <20240729112534.3416707-23-alexs@kernel.org>
 <20240730093726.GB16599@google.com>
 <8fc7939b-416a-4328-9df2-488f17783543@gmail.com>
 <20240731021619.GD16599@google.com>
Content-Language: en-US
From: Alex Shi <seakeel@gmail.com>
In-Reply-To: <20240731021619.GD16599@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 7/31/24 10:16 AM, Sergey Senozhatsky wrote:
> On (24/07/30 19:45), Alex Shi wrote:
>> On 7/30/24 5:37 PM, Sergey Senozhatsky wrote:
>>> On (24/07/29 19:25), alexs@kernel.org wrote:
>>>>
>>>> From: Alex Shi <alexs@kernel.org>
>>>>
>>>
>>> Usually some simple commit message is still expected.
>>
>> Uh, my fault. Just forgive this part, is the following log fine?
>>
>>     After the page to zpdesc conversion, there still left few comments or
>>     function named with page not zpdesc, let's update the comments and
>>     rename function create_page_chain() as create_zpdesc_chain().
> 
> A bit of a different thing, still documentation related tho: do
> we want to do something about comments that mention page_lock in
> zsmalloc.c?

Good question!

There are some comments mentioned about the page_lock in the file, but missed
in the header of file, so how about the following adding:

diff --git a/mm/zsmalloc.c b/mm/zsmalloc.c
index 731055ccef23..eac110edbff0 100644
--- a/mm/zsmalloc.c
+++ b/mm/zsmalloc.c
@@ -25,6 +25,8 @@
  *
  * Usage of struct zpdesc(page) flags:
  *     PG_private: identifies the first component page
+ *     PG_lock: lock all component pages for a zspage free, serialize with
+ *              migration
  */
 
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt

Thanks a lot!

