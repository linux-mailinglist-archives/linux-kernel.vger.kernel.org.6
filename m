Return-Path: <linux-kernel+bounces-274171-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 55F82947464
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 06:36:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 870861C20C3A
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 04:36:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0FEC13D882;
	Mon,  5 Aug 2024 04:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HmefFldx"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7CF2A3B
	for <linux-kernel@vger.kernel.org>; Mon,  5 Aug 2024 04:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722832581; cv=none; b=oC1Gn+G/XNd7Zp4ORQl64zE8Bi6ZrKrHj/+SDEVE3y6rZ3lM0rSqSygjmA7MZsALbFR9XuA6wb6Td/rDQ3JvHacOuHghab14ZyCAjFkVfw36FRY3bWhatNZhYXSdiJlWpF8t7Ke799m6W9sEGX84yI3uqnvC7ESVzzJueDlhfcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722832581; c=relaxed/simple;
	bh=YKf0uDYZkq/XliA/mL1A7/KFwft19KC0N1wMSVIpcls=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jCt0KPK/GnZW9bncWQ6s2Kdd+XIo1W3e5Nn8C6K4Ao5u49gtYc4SB05tpWaL05GaObkPnKfyodny/LeTHlAlDDsOlSQfKF+SNL62UYgt0kziIr2MFvhVyLQsJzcyIkf23/GT+hhofIg+gXEMGorf9fh9/66v/soerX0CysXUU0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HmefFldx; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1fd9e6189d5so78496085ad.3
        for <linux-kernel@vger.kernel.org>; Sun, 04 Aug 2024 21:36:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722832579; x=1723437379; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kOxlQunikQ059i6w7JRrp9bCiv4VNbsqEC/n9/DP9YA=;
        b=HmefFldx90rlqXvA8vZzTJWrxn/20Ga/3HG2o5QPgRfyNc2Zwl9VnkEgsPYsaitXYs
         DplETEjH4kfRt3p41putsYuGxv5TRH78lC5vzE28xAADZsJnH05JPHBwg9BPop/RVhY5
         lPmFXCPMR929njoP7o+yrLRlCp/6HXweZPyDcs65dX4OmZMl47Ztdiof+AazQ5600Ho0
         oAfgEgFuX2kYXqtemk61Wq9hezzF8nykXYuZ1mEWWB+7sXgwdosE/lep64/zgRsGInPG
         FRaKztalW9XlrvCUDLmJVgYjk5TANP9oQGeA3gABbBSm2oDcgDFKcJ8Xm6ya7xVx/OhW
         q4cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722832579; x=1723437379;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kOxlQunikQ059i6w7JRrp9bCiv4VNbsqEC/n9/DP9YA=;
        b=MXICygyVTN44UUyBlW21Jll2mWuDRg8yz7vR6qEbX6+Alh8FHJ9PB2wRmaeH3N3xtT
         dbODGaRSYqYiScs7WCxIRGr0hG1afhtL36EuMZScm9M/nvlLEWPvsLOsbIVF5CEE0hgr
         p6X3Sx38//f38W/4liTiZFg2G7arp8rTp5+YjtxTJii7SyJp0WBSYE/RjBkDQzmCp/0x
         Tukxxb26Ckpa+wZ3Q6KDx/yhCzlmUIZshWCq3c8McjWnVf4Y1qBAYVvgP5bbsh0EIePP
         nLCE/LDNlWX0PsQR2KMmZ2AExV7tLQlxmS96aB1WTbfRUMA8WSIpPUQ4Qsh1I2fBc47F
         fgww==
X-Forwarded-Encrypted: i=1; AJvYcCV0rTbkGzcC8aVcYKGdSKB52BAJSM8apjt7+/tEFKNuiifTnrEMUq1RSqRur95VyoDSKuxG4qocyVzz9NdZsR4LNNdcpl/tZar9Sh9C
X-Gm-Message-State: AOJu0Yxmg+36W2UveoS0WPgt0Uu449OEecwB97QO9RQMCQHuoDoj90W1
	cALKIwRIgp8Qel+Rb7lWvCL1V1oFM1MZ2OMCx7KtnkyCP9MEMNmR
X-Google-Smtp-Source: AGHT+IGGT5intRMOfnhm0exeQaOKBEaPd5C4Gkjx72sEtjCD8hI7OoWXDfTnUevxm1yGazGfFWBk7g==
X-Received: by 2002:a17:903:18e:b0:1fd:69d6:856d with SMTP id d9443c01a7336-1ff57281a30mr102618735ad.17.1722832578946;
        Sun, 04 Aug 2024 21:36:18 -0700 (PDT)
Received: from [192.168.255.10] ([43.132.141.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ff59058512sm57338255ad.135.2024.08.04.21.36.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 04 Aug 2024 21:36:18 -0700 (PDT)
Message-ID: <86e97328-a784-4320-b634-c582d5a10aff@gmail.com>
Date: Mon, 5 Aug 2024 12:36:14 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 01/22] mm/zsmalloc: add zpdesc memory descriptor for
 zswap.zpool
To: Matthew Wilcox <willy@infradead.org>, alexs@kernel.org
Cc: Vitaly Wool <vitaly.wool@konsulko.com>, Miaohe Lin
 <linmiaohe@huawei.com>, Andrew Morton <akpm@linux-foundation.org>,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, minchan@kernel.org,
 senozhatsky@chromium.org, david@redhat.com, 42.hyeyoo@gmail.com,
 Yosry Ahmed <yosryahmed@google.com>, nphamcs@gmail.com
References: <20240729112534.3416707-1-alexs@kernel.org>
 <20240729112534.3416707-2-alexs@kernel.org>
 <Zq0zucMFsOwATsAC@casper.infradead.org>
Content-Language: en-US
From: Alex Shi <seakeel@gmail.com>
In-Reply-To: <Zq0zucMFsOwATsAC@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 8/3/24 3:30 AM, Matthew Wilcox wrote:
> On Mon, Jul 29, 2024 at 07:25:13PM +0800, alexs@kernel.org wrote:
>> +/*
>> + * struct zpdesc -	Memory descriptor for zpool memory, now is for zsmalloc
>> + * @flags:		Page flags, PG_private: identifies the first component page
>> + * @lru:		Indirectly used by page migration
>> + * @mops:		Used by page migration
>> + * @next:		Next zpdesc in a zspage in zsmalloc zpool
>> + * @handle:		For huge zspage in zsmalloc zpool
>> + * @zspage:		Pointer to zspage in zsmalloc
>> + * @memcg_data:		Memory Control Group data.
>> + *
>> + * This struct overlays struct page for now. Do not modify without a good
>> + * understanding of the issues.
>> + */
>> +struct zpdesc {
>> +	unsigned long flags;
>> +	struct list_head lru;
>> +	struct movable_operations *mops;
>> +	union {
>> +		/* Next zpdescs in a zspage in zsmalloc zpool */
>> +		struct zpdesc *next;
>> +		/* For huge zspage in zsmalloc zpool */
>> +		unsigned long handle;
>> +	};
>> +	struct zspage *zspage;
>> +	unsigned long _zp_pad_1;
>> +#ifdef CONFIG_MEMCG
>> +	unsigned long memcg_data;
>> +#endif
>> +};
> 
> Before we do a v5, what's the plan for a shrunk struct page?  It feels
> like a lot of what's going on here is just "because we can".  But if you
> actually had to allocate the memory, would you?
> 
> That is, if we get to
> 
> struct page {
> 	unsigned long memdesc;
> };
> 

Yes, we still have a huge gap between this target. 

> what do you put in the 60  bits of information?  Do you allocate a
> per-page struct zpdesc, and have each one pointing to a zspage?  Or do
> you extend the current contents of zspage to describe the pages allocated
> to it, and make each struct page point to the zspage?

I am not very clear the way to get there. The easy path for me, I guess, 
would move struct zpdesc members out to zspage, like 2nd way of your suggestion.

I believe you has much more idea of the ways to memdesc. 
Is there some references or detailed info which I could learn from you?

Many thanks!
Alex
 
> 
> I don't know your code, so I'm not trying to choose for you.  I'm just
> trying to make sure we're walking in the right direction.

