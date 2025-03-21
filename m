Return-Path: <linux-kernel+bounces-571160-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 078AEA6B9E2
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 12:27:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3A39817B20A
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 11:27:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F525223321;
	Fri, 21 Mar 2025 11:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="T4FIth9q"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3660D2AE6A
	for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 11:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742556470; cv=none; b=rOYv/964kbHISK/O4GDx6Vu63m8OEfDmDvAHkohVL0yIMrYb+Lx+QFnvpOHaYjbRfFtVEt6bua5UYlUdnmUuVUnZFznK+lhMmjH+VXJoyxxLl0yVKoRN/ZwrHy2YijN+WXqni96/H/sGY2lUjkYIt8rYxRdjKOqZEgW7PZeOGg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742556470; c=relaxed/simple;
	bh=/aVDzxiZ2+ANvAFebEVu+eDxw/XpQ3t9Xw/mg5ze3xE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lDCWuv+DkNVjB4Y2GKbbWz6oJsDthUU49Mkfr/a3VPiqF+EFmyEQaCZ/VPsFoCNf0kFIPVGjn+koA9m6sz4642zt0KMpe6vQzGBN4nHMAx8ygmdezHTHhhALtBICGNTpWnkdlTTwcze3w4f9ppaa/ptav98agUJC+PW64qykhg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=T4FIth9q; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742556468;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=FjH3y9m0H0aFP2lC6btVV389x+pkCbjvtz6kIzJXcCI=;
	b=T4FIth9qC80djx3m3RJ4Ma6gwHzdVOxWDK1bg+V4BlpdBW2bFzZ1HjdDnGp4xF/X2QevLx
	NZDWoLaYT0F5fJdlvdkgF1v+YYVMTxbTLHy6/Z7ffcto5Tn/ZrCsjIdzbMgRLWp170KLjx
	AV3MJmRYvoT1TNyloZcHK3eskwegEME=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-21-1eiHmOaiNY-iTjwGS1ZC2Q-1; Fri, 21 Mar 2025 07:27:46 -0400
X-MC-Unique: 1eiHmOaiNY-iTjwGS1ZC2Q-1
X-Mimecast-MFC-AGG-ID: 1eiHmOaiNY-iTjwGS1ZC2Q_1742556466
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3912fc9861cso814316f8f.1
        for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 04:27:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742556465; x=1743161265;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FjH3y9m0H0aFP2lC6btVV389x+pkCbjvtz6kIzJXcCI=;
        b=nwYELlknAMtf7MhPw0JqmDuG+y10CUDrQp9HjckGtoR8+AjWKep+zasC9SsAGtcXhX
         6VVepjEGQL9Gji6rZapotWWcrI0lY/5k+j2Phhxcaj6HfHmyE5+tZOnomWPCcOERo1gv
         LCwMlYCJuUePzXYPUu9TYxTW1twVo0IMxud1D5q3QkxGawDRo3GfAu+kRXOeFn/fgEtL
         L53Ckz0bFMpOEV/jADmgL/U/BiKcvBbJpQ0vJrcKcexbkbCSBYsQYDBSb3CufdQHDIaM
         3DRjQeXg5R0Rl6a+9D5CEu6uMBdBF3t9MOjy7ZdIyl1xKcdKZdnyh673BgpAxGakCbi3
         tXZw==
X-Gm-Message-State: AOJu0YwcCzytLOWtm85vZ+BhkkyQcHhDOrkYRwPxxljNL0Dzc9Sv8XvN
	ToGNgzrzKVwhZmtoglILRH1gGeyA3yOBgAfVs8PPD8PRbDPr9sblwDOgiZqfDPVBUdSnCV9GMuV
	6XtgQCi+TOwGtJ+Sc2RmA6yM/n6xtME4MfTN55L2ztw6tOwK5vfnE/5Xk7ackHw==
X-Gm-Gg: ASbGncuJyIkLxqAsQ1ARgSPYI9I2oGCbL1oagaU8J87kbOk3uYP69uyIg1gtbXbB/xP
	gA5OLIDhGN44kJiODaR+cqV86wbOylPv2FbHTXSO/nR0IGTL0Ex1NUf1iGMhnIc64fP/YyJTGbh
	dDcG4Kxeudk5eS7LkK3jgPnZvvFtpHZcd9VJxb4Tmbg25RK+UrqsJXf1CB2t0lXUqare6Dc4yTU
	Z6hgKw4+xVRPr+SNZs4KNRRS7IHKjjMCVwkwoaFxiMHZeqD87dCGKPDH+agxw46HIqnDObH8lgF
	O9rvGQtSLIz7ZIGQ3VBoCOftLpojJm5FNRTJwW5elL8zvJL8vjKYhWzgk5sm5p4Cd3rjX8xuJfZ
	vY9wlUw/X8oAzX8bYAXEelyu+IFl729uXn62a0v8pCSM=
X-Received: by 2002:a05:6000:2a4:b0:391:ba6:c066 with SMTP id ffacd0b85a97d-3997f932dc7mr2725586f8f.35.1742556465501;
        Fri, 21 Mar 2025 04:27:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFg/cuQvIRoNR4MVFuFpo9AxwX7/33cG0EGBmH4EhjfBtCVl+4Nqdi6+/ZaZIp51gTXMF/EQA==
X-Received: by 2002:a05:6000:2a4:b0:391:ba6:c066 with SMTP id ffacd0b85a97d-3997f932dc7mr2725566f8f.35.1742556465005;
        Fri, 21 Mar 2025 04:27:45 -0700 (PDT)
Received: from ?IPV6:2003:cb:c72a:9100:23d2:3800:cdcc:90f0? (p200300cbc72a910023d23800cdcc90f0.dip0.t-ipconnect.de. [2003:cb:c72a:9100:23d2:3800:cdcc:90f0])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3997f9a3428sm2142972f8f.26.2025.03.21.04.27.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Mar 2025 04:27:44 -0700 (PDT)
Message-ID: <ad33344d-e289-4c93-a29a-c85b6cdcd204@redhat.com>
Date: Fri, 21 Mar 2025 12:27:43 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] Fix parameter passed to page_mapcount_is_type()
To: Gavin Shan <gshan@redhat.com>, Vlastimil Babka <vbabka@suse.cz>,
 linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
 willy@infradead.org, osalvador@suse.de, gehao@kylinos.cn,
 shan.gavin@gmail.com
References: <20250321053148.1434076-1-gshan@redhat.com>
 <b9e1269e-e79b-446b-9483-4fdbc1ee42f4@suse.cz>
 <0d096764-302f-4b80-a867-22f5302b8045@redhat.com>
 <5ec97dd6-6561-4687-ac94-41c63ffc82cf@redhat.com>
Content-Language: en-US
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <5ec97dd6-6561-4687-ac94-41c63ffc82cf@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 21.03.25 12:25, Gavin Shan wrote:
> On 3/21/25 8:11 PM, David Hildenbrand wrote:
>> On 21.03.25 10:23, Vlastimil Babka wrote:
>>> On 3/21/25 06:31, Gavin Shan wrote:
>>>> Found by code inspection. There are two places where the parameter
>>>> passed to page_mapcount_is_type() is (page->__mapcount), which is
>>>> correct since it should be one more than the value, as explained in
>>>> the comments to page_mapcount_is_type(): (a) page_has_type() in
>>>> page-flags.h (b) __dump_folio() in mm/debug.c
>>>
>>> IIUC you are right. Luckily thanks to the the PGTY_mapcount_underflow limit,
>>> this off-by-one error doesn't currently cause visible issues i.e.
>>> misclassifications legitimate mapcount as page type and vice versa, right?
>>> We'd have to have a mapcount underflown severely right to the limit to make
>>> that off-by-one error cross it?
>>
>> Agreed. Likely not stable material because it isn't actually fixing anything (because of the safety gaps).
>>
> 
> Yes, it shouldn't cause any visible impacts so far due to the gap.
> I just found the issue by code inspection. Lets drop the fix tags
> in v2.
> 
>>>
>>> I wonder if a more future-proof solution would be to redefine
>>> page_mapcount_is_type() instead to not subtract. But I'll leave that to willy.
>>
>> With upcoming changes around that, likely best to leave that alone. I expect page_mapcount_is_type() to completely vanish.
>>
> 
> +1 to remove page_mapcount_is_type(). After Willy confirms, I can post
> an extra series to do it if needed.

I think we should only do that one Willy splits struct folio off from, 
struct page, storing the type elsewhere. For now, we should likely just 
leave it as is.

-- 
Cheers,

David / dhildenb


