Return-Path: <linux-kernel+bounces-218680-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AC13490C3AC
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 08:35:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C49C91C210A3
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 06:35:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C0724D11D;
	Tue, 18 Jun 2024 06:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Tb1A7BqI"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E557F2E40D
	for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 06:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718692534; cv=none; b=rfOp3Z/6hxbNwSNYiEPHszgKuuFTrjyYR3ywXpw4cKYJ51pomd9+EbmWlz6dcE5ZFgtvU8BV9XLCBLIAUBZmZHOh7rxn1jYH8n1kYaNaeAStSMBGTfoi8K2YauS2kD7oHQpYR9hTbzL8J/Pz1Q08qYkAPYaU3r5Z6G4JxE9JqFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718692534; c=relaxed/simple;
	bh=75EzXSlIOr3eCHGyDlfdqxPM1qXslIc+io1cCCwt9+g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gla9Oz4exKY3NvqhqbtrD2PEykLjxFXIoiEWO85aOXHg4swvomnWRGdTP/bp0zYBDqThO8NE55lnmFE3nkeynq65mwB3bAcTyg1Re7UX04m3Zh9Q54RJrF2Yy9d/J1/0NWBA+AVbOkP2pTKsoDSLaN+dh2i0KTijWyyR1scRBAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Tb1A7BqI; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718692531;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=75uo9YHVDFDNzO2TP5t8b5ORyU7MVa6C97VletJyJ/A=;
	b=Tb1A7BqIz2H8EQBiHgZfdCjO1L9fLuPIOqGj/OA73D27PYwKSd/W9IiDtb88zRllP+bb36
	gm/d84xBstQsuqBS5mIVp9iqBkn7m1X4JSrbUrZPmKm5taqCtNrudSxqKJf/XnCMRKD6y7
	ooiIiJx1lMVLBOzTra11aJQEqTVGojs=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-433-e3JkgvvSN_CJ1a6ZegtGcQ-1; Tue, 18 Jun 2024 02:35:30 -0400
X-MC-Unique: e3JkgvvSN_CJ1a6ZegtGcQ-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-421759c3556so30338625e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2024 23:35:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718692529; x=1719297329;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=75uo9YHVDFDNzO2TP5t8b5ORyU7MVa6C97VletJyJ/A=;
        b=jQdGH/LdHV9+Sm/bYaLLL4613u4fy8R5PXR2S4/2oGqKsZdzu+W8gLKJL5VI5MxK7w
         8aW06ocms6+5gf3wgbR2RTp4rWahV40JhPtG10Zlq2egyZUb5jp7tNNIv7PWy3pn14zC
         KpnDR9Pdb1xhwFoJHkrqm5gmT/SxY5wZ5qHKPGBTF4COTpMrjaJZVIAfjeYY4ZTN895b
         ILj/Lgj53waIEqtXMNdVzzRaoGpCOo+pjOkrNg3fxY8mWqoPr2snGyEiXWuDrmnXC7/B
         wiM4eCJZ9U5U3zPEtPnwJ2uXTtCkV2NWap23nv1kyOwdHfOr2bRtrZshguujnW+o0dCL
         blUA==
X-Forwarded-Encrypted: i=1; AJvYcCXzPJjTehq1VbhlQhR4RuIZ3QaeoMoqV+VY6yzus3GntG/t2ZFfH7A46OtF4ti5lI0yWo/6UzLNGeVS/t+7DkF1bfXPi5pH89dnMllw
X-Gm-Message-State: AOJu0Yyt0gN7VAXa60uKHrTx4RU+n0FyEDDwzFaAInRFvcOqVgPPfqmv
	ed67jLxTjxAJrEC5FyR3JHuOwuF2BF0TkKIEj8pM5n8RmhdfPFvQEU91i2CR0m5LW/cu//f+AZD
	hCwHR+a70Dxhn1kIBwIAnj76zz8z3L6nZVJEyibgT1Sp7wB+8hTJxhinEfj8Q3g==
X-Received: by 2002:a05:600c:3781:b0:422:12bf:27be with SMTP id 5b1f17b1804b1-4246f597c94mr13379005e9.11.1718692529252;
        Mon, 17 Jun 2024 23:35:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHYqMY9BBToQN3U/9HKkUTz0jJk1GTJFCpqtXngA8tUYs0G7ByLGIcrApkEe/BxGWj5go1BSA==
X-Received: by 2002:a05:600c:3781:b0:422:12bf:27be with SMTP id 5b1f17b1804b1-4246f597c94mr13378755e9.11.1718692528724;
        Mon, 17 Jun 2024 23:35:28 -0700 (PDT)
Received: from ?IPV6:2003:cb:c705:1400:78ba:c2d2:22a1:8858? (p200300cbc705140078bac2d222a18858.dip0.t-ipconnect.de. [2003:cb:c705:1400:78ba:c2d2:22a1:8858])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3608accd8b3sm7966387f8f.71.2024.06.17.23.35.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Jun 2024 23:35:28 -0700 (PDT)
Message-ID: <dc8467bf-4f27-4aac-b7a2-a0aaff6a3eaa@redhat.com>
Date: Tue, 18 Jun 2024 08:35:27 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] mm: convert page type macros to enum
To: Andrew Morton <akpm@linux-foundation.org>,
 Stephen Brennan <stephen.s.brennan@oracle.com>
Cc: linux-mm@kvack.org, Vlastimil Babka <vbabka@suse.cz>,
 "Vishal Moola (Oracle)" <vishal.moola@gmail.com>,
 Omar Sandoval <osandov@osandov.com>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>, Hao Ge <gehao@kylinos.cn>,
 linux-debuggers@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240607202954.1198180-1-stephen.s.brennan@oracle.com>
 <20240607212738.bf55318aebd7172fadaa11c5@linux-foundation.org>
 <87ikygo1yb.fsf@oracle.com> <87bk3z1f76.fsf@oracle.com>
 <20240617142951.08a9cdc791c8edeeca50509b@linux-foundation.org>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20240617142951.08a9cdc791c8edeeca50509b@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 17.06.24 23:29, Andrew Morton wrote:
> On Mon, 17 Jun 2024 13:34:21 -0700 Stephen Brennan <stephen.s.brennan@oracle.com> wrote:
> 
>>>>> Fixes: 46df8e73a4a3 ("mm: free up PG_slab")
>>>>
>>>> Should we backport this into 6.9.x?
>>>
>>> Hi Andrew,
>>>
>>> Looks like commit 46df8e73a4a3 ("mm: free up PG_slab") is introduced in
>>> the v6.10-rc's, and not backported to 6.9. So PG_slab is still part of
>>
>> Hi Andrew,
>>
>> I saw that you've merged this into mm-unstable, thank you!
>>
>> Since 46df8e73a4a3 ("mm: free up PG_slab") is part of the current 6.10
>> RC, it would be great if this patch could be part of the 6.10 release so
>> we don't release a kernel missing the PG_slab info.
>>
>> Can you confirm if mm-unstable will get merged in this release cycle? Or
>> else, would it be possible to include it in a branch that will?
> 
> Turns out the patch as sent was based on David's "mm: allow reuse of
> the lower 16 bit of the page type with an actual type", which changed
> the page flags a lot,  I redid this patch thusly:
> 
> --- a/include/linux/page-flags.h~mm-convert-page-type-macros-to-enum
> +++ a/include/linux/page-flags.h
> @@ -944,15 +944,22 @@ PAGEFLAG_FALSE(HasHWPoisoned, has_hwpois
>    * mistaken for a page type value.
>    */
>   
> -#define PAGE_TYPE_BASE	0xf0000000
> -/* Reserve		0x0000007f to catch underflows of _mapcount */
> -#define PAGE_MAPCOUNT_RESERVE	-128
> -#define PG_buddy	0x00000080
> -#define PG_offline	0x00000100
> -#define PG_table	0x00000200
> -#define PG_guard	0x00000400
> -#define PG_hugetlb	0x00000800
> -#define PG_slab		0x00001000
> +enum pagetype {
> +	/*
> +	 * Reserve 0xffff0000 - 0xfffffffe to catch _mapcount underflows and
> +	 * allow owners that set a type to reuse the lower 16 bit for their own
> +	 * purposes.
> +	 */

As noted, we better maintain the original comment here.

> +	PG_buddy	= 0x00000080,
> +	PG_offline	= 0x00000100,
> +	PG_table	= 0x00000200,
> +	PG_guard	= 0x00000400,
> +	PG_hugetlb	= 0x00000800,
> +	PG_slab		= 0x00001000,
> +
> +	PAGE_TYPE_BASE	= 0xf0000000,
> +	PAGE_MAPCOUNT_RESERVE	= -128,
> +};
>   
>   #define PageType(page, flag)						\
>   	((page->page_type & (PAGE_TYPE_BASE | flag)) == PAGE_TYPE_BASE)
> _
>

Apart from that LGTM.


> (please check carefully)
> 
> and David's later "mm: allow reuse of the lower 16 bit of the page type
> with an actual type" becomes
> 
>   include/linux/mm_types.h   |    5 +++++
>   include/linux/page-flags.h |   16 ++++++++--------
>   2 files changed, 13 insertions(+), 8 deletions(-)
> 
> --- a/include/linux/mm_types.h~mm-allow-reuse-of-the-lower-16-bit-of-the-page-type-with-an-actual-type
> +++ a/include/linux/mm_types.h
> @@ -157,6 +157,11 @@ struct page {
>   		 *
>   		 * See page-flags.h for a list of page types which are currently
>   		 * stored here.
> +		 *
> +		 * Owners of typed folios may reuse the lower 16 bit of the
> +		 * head page page_type field after setting the page type,
> +		 * but must reset these 16 bit to -1 before clearing the
> +		 * page type.
>   		 */
>   		unsigned int page_type;
>   
> --- a/include/linux/page-flags.h~mm-allow-reuse-of-the-lower-16-bit-of-the-page-type-with-an-actual-type
> +++ a/include/linux/page-flags.h
> @@ -951,15 +951,15 @@ enum pagetype {
>   	 * allow owners that set a type to reuse the lower 16 bit for their own
>   	 * purposes.
>   	 */
> -	PG_buddy	= 0x00000080,
> -	PG_offline	= 0x00000100,
> -	PG_table	= 0x00000200,
> -	PG_guard	= 0x00000400,
> -	PG_hugetlb	= 0x00000800,
> -	PG_slab		= 0x00001000,
> +	PG_buddy	= 0x40000000,
> +	PG_offline	= 0x20000000,
> +	PG_table	= 0x10000000,
> +	PG_guard	= 0x08000000,
> +	PG_hugetlb	= 0x04008000,
> +	PG_slab		= 0x02000000,
>   
> -	PAGE_TYPE_BASE	= 0xf0000000,
> -	PAGE_MAPCOUNT_RESERVE	= -128,
> +	PAGE_TYPE_BASE	= 0x80000000,
> +	PAGE_MAPCOUNT_RESERVE	=  (~0x0000ffff),
>   };
>   
>   #define PageType(page, flag)						\
> _
> 
> and that patch's fixup becomes
> 
> --- a/include/linux/page-flags.h~mm-allow-reuse-of-the-lower-16-bit-of-the-page-type-with-an-actual-type-fix
> +++ a/include/linux/page-flags.h
> @@ -955,7 +955,7 @@ enum pagetype {
>   	PG_offline	= 0x20000000,
>   	PG_table	= 0x10000000,
>   	PG_guard	= 0x08000000,
> -	PG_hugetlb	= 0x04008000,
> +	PG_hugetlb	= 0x04000000,
>   	PG_slab		= 0x02000000,
>   
>   	PAGE_TYPE_BASE	= 0x80000000,
> _
> 
> and "mm/zsmalloc: use a proper page type" becomes, in part,
> 
> --- a/include/linux/page-flags.h~mm-zsmalloc-use-a-proper-page-type
> +++ a/include/linux/page-flags.h
> @@ -957,6 +957,7 @@ enum pagetype {
>   	PG_guard	= 0x08000000,
>   	PG_hugetlb	= 0x04000000,
>   	PG_slab		= 0x02000000,
> +	PG_zsmalloc	= 0x01000000,
>   
>   	PAGE_TYPE_BASE	= 0x80000000,
>   	PAGE_MAPCOUNT_RESERVE	=  (~0x0000ffff),
> 
> 
> 
> and the end result is identical to yesterday's mm-everything so that's
> all good.

Looks good.

> 
> However I wouldn't want to send the altered version of "mm: convert
> page type macros to enum" into 6.10-rcX because it gets so altered by
> David's mm-unstable changes for the next merge window.  The new version
> of the hotfixes patch won't have had any valid testing on its own.
> 
> So I'll temporarily drop David's "mm: page_type, zsmalloc and
> page_mapcount_reset()" series from mm-unstable.  To permit the new "mm:
> convert page type macros to enum" to get some linux-next exposure.
> David, please remind me to restore that series in a week or so?

I'll be on vacation next week, but will try to think of it. If you want 
a resend based on the new mm-unstable state with that hotfix, let me know.

-- 
Cheers,

David / dhildenb


