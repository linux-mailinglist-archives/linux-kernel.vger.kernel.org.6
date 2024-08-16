Return-Path: <linux-kernel+bounces-290068-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C0519954F10
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 18:41:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2903628467C
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 16:41:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 356421BE86C;
	Fri, 16 Aug 2024 16:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gsoCAE5u"
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A91CC1BDA94;
	Fri, 16 Aug 2024 16:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723826494; cv=none; b=d8/A2VCzwwfTYFi4qWYTCpd3bI3rueTrREHXQWdCPNqLDTkv4DfPtx4QB1YJMWTjyKpBBo15NJWGk9hwTHMJ+SfLC8+s8ILexOoGfhweKTjWJhdv1d+0O/ywGabFtRE/Sdg51TZPj11IEuX5cOGn4ep9EpRxTkKh2FzUZUkVbkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723826494; c=relaxed/simple;
	bh=4wDVbCUxEEouTq87ec/Yc4Xc02JyACfRxYSs0uwD6aY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PqDLfVKeeKRYuYB+7kr5WUTXSHR/AexTcEcgrtL02Qm3OzD97MPKNyZ9T+7FQlfSVzaT3XZ/o9pNUsHfVH26Ss02Qe1dzFBtnzRvA18/wDh++7sVvMtRfkEEK+oFgHj5TXt3CMeP9vixPL3gS8E+Sc7Aw9NBRtQb3EHaXRLTcuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gsoCAE5u; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2f025b94e07so24565661fa.0;
        Fri, 16 Aug 2024 09:41:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723826491; x=1724431291; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qE6cA2BiIxlbldsSPiTQqUrw5yO3Tuqe7RWvm18DClQ=;
        b=gsoCAE5uDQE8XgJupHYqfPG43DWSGejlaf695dtQeQqcinUzp0ZG3Y7q70xQJtkITc
         Q//aMdSblW8LZ7e/ussTj/DURiWs7z4ScM/+LBgvLgn0hWhix66KDMPCZyqbDUSY5+nF
         UtFEA40uQJQDAF/ef3fe0szsIHRy951Jvr9ULwna2PzSDPPx1sxz8VCJgfqzx3YQSK5Y
         O46Lj/vk7eDX3eTFKc5zqOcbUbaInH08tFrA8lf0N6ntOodvzFBZgskCaQUKLiOFcJhb
         CgIZsMrfJ9bwdUFa/p/C1RdWi0d6dQQjDVibWaJvhbHeK0C3FHgqDjqQu/aJGn8N0Grw
         87Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723826491; x=1724431291;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qE6cA2BiIxlbldsSPiTQqUrw5yO3Tuqe7RWvm18DClQ=;
        b=IcF+XO9QGH5ifi/hPGsxLQ/+FXGMliz2d1nzo7tWHPnsUafJ+HjQNnInhSFI9ptPZ4
         ZLVvjxBGFPkFQk7CaPO5CuV6TowMiXkWexXZt2hodAyiKrroZDoJ89srkLxvuapxEMv5
         BiF8kwErEVk9Xoi8rl5jdP1J2LO85JCO/AYtJZMTCAydr0d0QTAzIXXVKtrOJ7p5KSIN
         lnvYFkkXow/9EhhNgxAlvpV7SXYqByXeBhoUVFrpClzdncVbp1mMxNqhlLoKvH68eS3+
         uvWvohyAJLQliYvFDonrHX+c523wtdwWU0NnCJilAGQt5pgl91VpFJktiwB1ZBedemRo
         fcWA==
X-Forwarded-Encrypted: i=1; AJvYcCXa5mWhB/xCLcmxdOindFPbi5+vb0OPpDt7crNCHKiAFE8VpgjGxZYXu24/JItESHAYqyX2yUdKL8BQoXgz6PoWTSJjWAD6RLPnDD+itTgY6OApo8jxRuetXw940CNx7FvOdonoV/xO
X-Gm-Message-State: AOJu0YyiJkr27B+comUSYtwJRGrFgiufZC+niQSfouthtRwxjLLtZ/lJ
	b9tksahAIARab2QwEzR/MJZsIL8MY3ijAlb2zfimLMebNmAhVLnR
X-Google-Smtp-Source: AGHT+IErM6iIeQz6oNXeFWj28KSZ7kqw6rWe2ylu2if2FZyJGV/PBENVvmHmDB7O75KY3oLQcrdBmQ==
X-Received: by 2002:a05:6512:3045:b0:52b:9c8a:734f with SMTP id 2adb3069b0e04-5331c6e54a6mr2749231e87.50.1723826490101;
        Fri, 16 Aug 2024 09:41:30 -0700 (PDT)
Received: from ?IPV6:2a02:6b6f:e750:7600:c5:51ce:2b5:970b? ([2a02:6b6f:e750:7600:c5:51ce:2b5:970b])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-429ed79d9a7sm26703425e9.39.2024.08.16.09.41.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Aug 2024 09:41:29 -0700 (PDT)
Message-ID: <8fb9915b-73a1-4e39-bb30-c1c21b1b7650@gmail.com>
Date: Fri, 16 Aug 2024 17:41:29 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/6] mm: Introduce a pageflag for partially mapped
 folios
To: Matthew Wilcox <willy@infradead.org>
Cc: akpm@linux-foundation.org, linux-mm@kvack.org, hannes@cmpxchg.org,
 riel@surriel.com, shakeel.butt@linux.dev, roman.gushchin@linux.dev,
 yuzhao@google.com, david@redhat.com, baohua@kernel.org,
 ryan.roberts@arm.com, rppt@kernel.org, cerasuolodomenico@gmail.com,
 corbet@lwn.net, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 kernel-team@meta.com
References: <20240813120328.1275952-1-usamaarif642@gmail.com>
 <20240813120328.1275952-5-usamaarif642@gmail.com>
 <Zr9zx74W6-oRwKXB@casper.infradead.org>
 <7e9e209b-b6b4-485b-ad43-9e1efbd63a7d@gmail.com>
 <Zr9-PA8xBSJJzmdx@casper.infradead.org>
Content-Language: en-US
From: Usama Arif <usamaarif642@gmail.com>
In-Reply-To: <Zr9-PA8xBSJJzmdx@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 16/08/2024 17:28, Matthew Wilcox wrote:
> On Fri, Aug 16, 2024 at 05:08:35PM +0100, Usama Arif wrote:
>> On 16/08/2024 16:44, Matthew Wilcox wrote:
>>> On Tue, Aug 13, 2024 at 01:02:47PM +0100, Usama Arif wrote:
>>>> diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
>>>> index a0a29bd092f8..cecc1bad7910 100644
>>>> --- a/include/linux/page-flags.h
>>>> +++ b/include/linux/page-flags.h
>>>> @@ -182,6 +182,7 @@ enum pageflags {
>>>>  	/* At least one page in this folio has the hwpoison flag set */
>>>>  	PG_has_hwpoisoned = PG_active,
>>>>  	PG_large_rmappable = PG_workingset, /* anon or file-backed */
>>>> +	PG_partially_mapped, /* was identified to be partially mapped */
>>>
>>> No, you can't do this.  You have to be really careful when reusing page
>>> flags, you can't just take the next one.  What made you think it would
>>> be this easy?
>>>
>>> I'd suggest using PG_reclaim.  You also need to add PG_partially_mapped
>>> to PAGE_FLAGS_SECOND.  You might get away without that if you're
>>> guaranteeing it'll always be clear when you free the folio; I don't
>>> understand this series so I don't know if that's true or not.
>>
>> I am really not sure what the issue is over here.
> 
> You've made the code more fragile.  It might happen to work today, but
> you've either done something which is subtly broken today, or might
> break tomorrow when somebody else rearranges the flags without knowing
> about your fragility.
> 
>> >From what I see, bits 0-7 of folio->_flags_1 are used for storing folio order, bit 8 for PG_has_hwpoisoned and bit 9 for PG_large_rmappable.
>> Bits 10 and above of folio->_flags_1 are not used any anywhere in the kernel. I am not reusing a page flag of folio->_flags_1, just taking an unused one.
> 
> No, wrong.  PG_anon_exclusive is used on every page, including tail
> pages, and that's above bit 10.
> 
>> Please have a look at the next few lines of the patch. I have defined the functions as FOLIO_FLAG(partially_mapped, FOLIO_SECOND_PAGE). I believe thats what you are saying in your second paragraph?
>> I am not sure what you meant by using PG_reclaim.
> 
> I mean:
> 
> -	PG_usama_new_thing,
> +	PG_usama_new_thing = PG_reclaim,
> 

Ah ok, Thanks. The flags below PG_reclaim are either marked as PF_ANY or are arch dependent. So eventhough they might not be used currently for _flags_1, they could be in the future.

I will use PG_partially_mapped = PG_reclaim in the next revision.

Thanks

