Return-Path: <linux-kernel+bounces-403379-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ED8F79C34C5
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Nov 2024 22:23:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5952B1F21427
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Nov 2024 21:23:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4966156661;
	Sun, 10 Nov 2024 21:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XwtUn9hR"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEC85DDD9
	for <linux-kernel@vger.kernel.org>; Sun, 10 Nov 2024 21:22:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731273775; cv=none; b=eXeAeQiu55T9V62xXkLn5To8+xsQd5Jw4hO8UbQZHvDW0fRA/dUEsg6FLz/3ZDBa1ohFdIow7V06to4jRciEah7lT+vggHwsTAjCs1D4Ww4OpBue9kH4t3d/LcdXsqFo2TXb2Gx+CqxIeBT6KpEmkQT8I4h+g8fohMYBUOpG0yM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731273775; c=relaxed/simple;
	bh=zqUQJ2Pu6i5ume09EW6ICqKQUFgVIvevgWfXdVJyCjM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XrM2GcmglPB0k6n9/cFsJgeNLpEzQ2MxoTM04p+kfA5Hfcv0712YJbBW589NWQRLDYod0n4UjNidLicRqLbb+sqg74R+ZhErkj2GBTG/bM+/HGNk8UxJG7B3qIWzomkWqxMo3I9tsKnMAdFJPBkRuqSSL7bsf2rXkSkIN5mt1lc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XwtUn9hR; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-431695fa98bso29520235e9.3
        for <linux-kernel@vger.kernel.org>; Sun, 10 Nov 2024 13:22:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731273772; x=1731878572; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RUakL32jpYP2PR6je8V0wbYzXZCA/i3ZS8OutJHFp68=;
        b=XwtUn9hRCmWkhpedhK17BYBmfNNSX9edyy6kbJDbSSFaqz/L4u4pQ0Q6Kn2Otnm3/j
         sPPCDd1bfWa6ftQLgO82asQOS2oagj0FrRhxTMArlyX6jy88Wjyp6U66T/K1ZZgMNJuh
         PDLFJBiW8waFD3VSOGdfnW6QVJakk2Jx7k74E/DvZ/9GqqAOkUdWLqa6769M/ZbiK6dK
         Ut+BfBJ7/vLhvH0HUDeo9vRKmveOTcuCTqVFBV+/eMIEAsW+ziF0AVbhg5rWbVxKEFVq
         6iZa6u0hzkpagwUAVTBPh2T5iPZFFjiCXEFeI77ER7sFHlEyvQ3Y1alc8pYMCFePVmT8
         c03w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731273772; x=1731878572;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RUakL32jpYP2PR6je8V0wbYzXZCA/i3ZS8OutJHFp68=;
        b=wjVIAqS93XzJWVduQUbMs0b2vmXujT0JFsjCZyWdQSPp5Nlo2imIlpsxy9JX77w+JM
         xY+FqPr2WnvNseBMIc7kZidKxybxp2ROXn/e4I0TbfM6vW97ovp5YvbBYQxhKwy8DRY3
         UE8RBz2B84+OgpxAE7r2+Z9ViCxUk1qZdLP/RqEkOPnY+guVDY9YCKgUBOjHEYR3Sl54
         67qc8a3fr+RivryAHWZkf5Eizs0xcRaRvZKWD+ngrIl0tVFo6490a/UynkDgDr6aG8eB
         U0zAGXK4wVko80VLPd3b6nLD670qPNj09rBM28jGu9DZe/cA37BUODU1pfzaVj5Pu50C
         NnLA==
X-Forwarded-Encrypted: i=1; AJvYcCWEbsrtlIUAMiDCeGNunw2KBPtwNhV24P3X6HVjbEIGXEsUzGzxvpiWMaLQ+MPJAbjogSgcBoGEHrGwLYU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxjRZrGMlXdGgxY3qtKrspLCeVJzsuP7rECI/Tw37JRnzddRZJm
	sWftPRbKYK+bwuSzDJiPsKaSK3RQrP05KKhrpz7jZpVFmFfLAyKE
X-Google-Smtp-Source: AGHT+IHWsg9yrWJD0rDrDbcpxEIgDdeLHT6gO7kg1qaZ7WeHwCRSkPsGRGxM7KR3w+353itlR+hYQg==
X-Received: by 2002:a5d:6d85:0:b0:37d:4e9d:233f with SMTP id ffacd0b85a97d-381f186b5eemr9487326f8f.24.1731273771766;
        Sun, 10 Nov 2024 13:22:51 -0800 (PST)
Received: from ?IPV6:2a02:6b67:d751:7400:c2b:f323:d172:e42a? ([2a02:6b67:d751:7400:c2b:f323:d172:e42a])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-381ed97c6b6sm11081641f8f.24.2024.11.10.13.22.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 10 Nov 2024 13:22:51 -0800 (PST)
Message-ID: <683dc253-8dd0-4990-944c-e20a3f79074c@gmail.com>
Date: Sun, 10 Nov 2024 21:22:50 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH hotfix] mm/thp: fix deferred split queue not
 partially_mapped: fix
To: Hugh Dickins <hughd@google.com>, Andrew Morton <akpm@linux-foundation.org>
Cc: Zi Yan <ziy@nvidia.com>, Yang Shi <shy828301@gmail.com>,
 Wei Yang <richard.weiyang@gmail.com>,
 "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
 Matthew Wilcox <willy@infradead.org>, David Hildenbrand <david@redhat.com>,
 Johannes Weiner <hannes@cmpxchg.org>,
 Baolin Wang <baolin.wang@linux.alibaba.com>, Barry Song <baohua@kernel.org>,
 Kefeng Wang <wangkefeng.wang@huawei.com>, Ryan Roberts
 <ryan.roberts@arm.com>, Nhat Pham <nphamcs@gmail.com>,
 Chris Li <chrisl@kernel.org>, Shakeel Butt <shakeel.butt@linux.dev>,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <81e34a8b-113a-0701-740e-2135c97eb1d7@google.com>
 <C4ECCA8C-FBF6-41AA-9877-4376EC94E021@nvidia.com>
 <6fcaaa72-4ef6-ebda-cf37-b6f49874d966@google.com>
 <3c995a30-31ce-0998-1b9f-3a2cb9354c91@google.com>
Content-Language: en-US
From: Usama Arif <usamaarif642@gmail.com>
In-Reply-To: <3c995a30-31ce-0998-1b9f-3a2cb9354c91@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 10/11/2024 21:11, Hugh Dickins wrote:
> Though even more elusive than before, list_del corruption has still been
> seen on THP's deferred split queue.
> 
> The idea in commit e66f3185fa04 was right, but its implementation wrong.
> The context omitted an important comment just before the critical test:
> "split_folio() removes folio from list on success."  In ignoring that
> comment, when a THP split succeeded, the code went on to release the
> preceding safe folio, preserving instead an irrelevant (formerly head)
> folio: which gives no safety because it's not on the list. Fix the logic.
> 
> Fixes: e66f3185fa04 ("mm/thp: fix deferred split queue not partially_mapped")
> Signed-off-by: Hugh Dickins <hughd@google.com>

Acked-by: Usama Arif <usamaarif642@gmail.com>


> ---
>  mm/huge_memory.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index 03fd4bc39ea1..5734d5d5060f 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -3790,7 +3790,9 @@ static unsigned long deferred_split_scan(struct shrinker *shrink,
>  		 * in the case it was underused, then consider it used and
>  		 * don't add it back to split_queue.
>  		 */
> -		if (!did_split && !folio_test_partially_mapped(folio)) {
> +		if (did_split) {
> +			; /* folio already removed from list */
> +		} else if (!folio_test_partially_mapped(folio)) {
>  			list_del_init(&folio->_deferred_list);
>  			removed++;
>  		} else {


