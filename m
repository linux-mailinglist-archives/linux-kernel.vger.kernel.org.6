Return-Path: <linux-kernel+bounces-517267-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CE890A37E75
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 10:30:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8C55118886C6
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 09:30:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05CF7215187;
	Mon, 17 Feb 2025 09:30:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="V65RbTl1"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 843B421507E
	for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 09:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739784645; cv=none; b=COtiezdD9p9k1r2me0LXv4lLjh9PVO5DOMmnC6cokITm7aa7jgMWmDCd3Rbz5smrvHW12cumSjcbGkFvxGQhsm0nECizVdYNVUg1WTJLVCW1+SR7kksOS773HH7XUZJKHqzxqssmetpqZLcCpLtTbbQDcpI5bWhbMh4qL+sNDj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739784645; c=relaxed/simple;
	bh=TmN75xgUON5G4PfUE77goYHqQ/xQM8RgcMTBK3DsOzw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uLtuaQ/DjiWuFl4vGKaP79qVmmsJbC4RIr25XqH/MaxYjMtegGBInzsc1rpqy6ZK03RsOLNqC9pMKCx7O2Xp6O0H6PZ0WNxGMnoDzPkSuYpHiH2Rvu7em1z1fVDpUBxF73Z+WIDgPovbrjczOOhozrIUQrJOaa1Go+/NQa3tBQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=V65RbTl1; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739784642;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=DQMR/fADtVbSBPPwd01Xw99f5NYlXC5yZS7SkQWeIc4=;
	b=V65RbTl1soP2Yuxf53VlmOBdzBIBsPBWSWce7FABuAmWIm7pf/foulJxzlIfQa/2xKdBdw
	jJtK3OQwe+Zn4u0Z/Kixm5f3ZjsN8quCXjGrZmQjOdi29dZNMQmFzGGvVlcO4rJyTfGGmS
	qwhrkGPVTEE1MvHgn1aa5T5XK/apaJ8=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-94-ymrmI9N2NEuObZtw4a9x3A-1; Mon, 17 Feb 2025 04:30:40 -0500
X-MC-Unique: ymrmI9N2NEuObZtw4a9x3A-1
X-Mimecast-MFC-AGG-ID: ymrmI9N2NEuObZtw4a9x3A_1739784639
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-38dfede57feso2302727f8f.2
        for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 01:30:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739784639; x=1740389439;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=DQMR/fADtVbSBPPwd01Xw99f5NYlXC5yZS7SkQWeIc4=;
        b=Ln0ZNeXa9T/YfZBTL/mjSskOFvIH4mjzz+ll34pfqAAUSeADF7WH6DpBaPTxuUCRn5
         6arLCB1OHkQwpxe071eASIHW2I8Fi9leJNWiuhqwCq6icGGbczRld/+X9WnScwZZB1eE
         kBMlzTkI0aiz7WJbyVIbvSGdaZORXX2TJ45/nUreXiFmqA9ExA4AoG8lFoEn9vMkibmZ
         UVgstHAAD/wuxSKc4Jcf8Sk3qtkFCxOBqPh9eymkFE8KqqfwdnFyH7YntFhjkj7Oq9N7
         qk3AoWGJ8WxFQ3pRitG8z8BYzz+Z6tVw2ZH/H8rGeKBflW4fAp7sqgr2EY1wDfTPkssI
         AMJg==
X-Forwarded-Encrypted: i=1; AJvYcCVLx3vBp7mJwL8kMLsojVyeXIrcOlz8CrplI5LevG4guL7rDivGiTcRmiqJr/R8gXTfC+GsWITM5E4S6v8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yznivo/iPAkeF0xk4mSgBBjgsoafdPwlkEaBi26Q76rXWw8Mr6r
	++V2HKBXxdJJzc6Y+/9xnAllX/5dPB7fnK4EyE7UiB2PrJZS1ZIl3Jpd0XqZ7rQOqabSluzn3gt
	9S8dexNpsNYq75YF8Bgd6txYZMmrey+h9E+xyIigGx2/F9Dl+PK6H+IYsmrzfag==
X-Gm-Gg: ASbGncvEAFHsXTv+TZxq/ikQ33sLuxxi8x6j6TUKdHcrv2gl76pW7gdEWODdco6pYhH
	2dGFGbZ6/MT46BLHWeitMod0y692UUyaEUE6DbvnU4kLlozGXqZQNYTfwH7wPWT1gKT/zhG2rX1
	5xDGnFrAZ7PPaV/Irv0A8sEE2n4cMFsxXUibrHytKHV0rpDGQZnVyvRuhkH4RGfdzNJ67nI5e+9
	oEzu9kRWS+GGMrybPBzSpMa3/q4egq0skkB4OZbKzQ8Ym2tFFFUrPUuzylxlAR8807Q+nTbWUem
	R1ZP8ysn/s9HeZOG0dppkPoqxsPVAaGP1oCBo//1Ym+c+5W/VAj91uj8OljtwqWSDxNpI7+ewIp
	EnXppbxRdHDvKI8/LsGbMXpu8PrAG
X-Received: by 2002:a5d:6d86:0:b0:38d:da11:df22 with SMTP id ffacd0b85a97d-38f33f43709mr6921303f8f.37.1739784639482;
        Mon, 17 Feb 2025 01:30:39 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHzQem8SDfS/ZvSrlOTLgwy6hXjdD72EYQbeWLdcuIX9+g88j62/tG8U2ja9LR9xp+cV1i4RQ==
X-Received: by 2002:a5d:6d86:0:b0:38d:da11:df22 with SMTP id ffacd0b85a97d-38f33f43709mr6921274f8f.37.1739784639117;
        Mon, 17 Feb 2025 01:30:39 -0800 (PST)
Received: from ?IPV6:2003:cb:c739:900:900f:3c9e:2f7b:5d0a? (p200300cbc7390900900f3c9e2f7b5d0a.dip0.t-ipconnect.de. [2003:cb:c739:900:900f:3c9e:2f7b:5d0a])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38f259f85c2sm12124991f8f.91.2025.02.17.01.30.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Feb 2025 01:30:38 -0800 (PST)
Message-ID: <2db40a7f-9463-49af-8600-73d735fd78bd@redhat.com>
Date: Mon, 17 Feb 2025 10:30:36 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/3] mm: memory-hotplug: check folio ref count first in
 do_migrate_range
To: Wupeng Ma <mawupeng1@huawei.com>, akpm@linux-foundation.org,
 osalvador@suse.de, nao.horiguchi@gmail.com, linmiaohe@huawei.com,
 mhocko@suse.com
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20250217014329.3610326-1-mawupeng1@huawei.com>
 <20250217014329.3610326-3-mawupeng1@huawei.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20250217014329.3610326-3-mawupeng1@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 17.02.25 02:43, Wupeng Ma wrote:
> From: Ma Wupeng <mawupeng1@huawei.com>
> 
> If a folio has an increased reference count, folio_try_get() will acquire
> it, perform necessary operations, and then release it. In the case of a
> poisoned folio without an elevated reference count (which is unlikely for
> memory-failure), folio_try_get() will simply bypass it.
> 
> Therefore, relocate the folio_try_get() function, responsible for checking
> and acquiring this reference count at first.
> 
> Signed-off-by: Ma Wupeng <mawupeng1@huawei.com>
> ---

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb


