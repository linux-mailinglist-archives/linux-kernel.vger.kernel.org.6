Return-Path: <linux-kernel+bounces-321106-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 27C8297148D
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 11:58:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D9BD5284547
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 09:58:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73AEA1B375C;
	Mon,  9 Sep 2024 09:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V2IMOYNi"
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4448E175D21
	for <linux-kernel@vger.kernel.org>; Mon,  9 Sep 2024 09:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725875901; cv=none; b=VPYnIgPGUwARJTWqPR66F9wrPh+FvA9Ma+S7F36HFYWBcQhNNvUQDr3ltwX6ygroEYzmCsWAFd3grXt5mDzaGhWvu6ledSGHed0PKemtTMLgsThJRiwpqovj1u7pHLWr6e3C827/P3oYsRKOBDtetavRMwHPPo7EkpeXoI+2ins=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725875901; c=relaxed/simple;
	bh=NJjKbzRM2yCmU+PrxVDaflH+UlhgGlDSjmYfSMr5ZgM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FjxvNrYiiKZJCgz7P8zpjUBiC1OwK2L92r5BCLOeGg9H9sKAZiigkMmd/JHRU66ZRsOpBzLk0+voIkFf8SwFbLyjXxhLpzsWdEvZQ/RFcGTlsa3oDHb3InJWINiAoluk+Pb8b6UA5klFSgXGr1Sd3A2PFX4tKB2lst7QpBURdkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V2IMOYNi; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2f762de00e5so15668141fa.3
        for <linux-kernel@vger.kernel.org>; Mon, 09 Sep 2024 02:58:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725875898; x=1726480698; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ld5vF7G5s/YIKEme3qj0NjE0DuhNgDeghoh45npdQQM=;
        b=V2IMOYNi7lr9PI+JoRrS3A7u6siSi7oaeUOtlTUCuYnfLSpeXITMfyrDqBRlZnK5uq
         22vf72x2i5wEgYh9Oud8nwgt15efNhzeTOE5epL1RN5AOCVFplCtbLV3LRS170nSivmk
         1cVowUHbdAsesfOc5TT/Q7dod7j+1EG05ZluMuTnqiCzE+cmYARh9SpGL0jQTr+3zRp/
         X2lVnvUvasw7JAEos57xvbhO9Qfj4YydIXu8cPEYOkLtc8fHQa8h/Gk82ywDHeI4vMl3
         YcdB3Qdyg02zIkthJ0Q/RRoitK4BflXHoM+bFb9SYwsKmgUGPz/RJdJX5JtvJjk+QoQs
         kBlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725875898; x=1726480698;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ld5vF7G5s/YIKEme3qj0NjE0DuhNgDeghoh45npdQQM=;
        b=hI5clDu7J2o/3swoyCYkfeGnIb9ILRDX0tcKxYU+0DMizab1VCwC6Pzg7EGOHkNHqu
         ninBYJVAA14gAWhm1eA+l7DvqWjreX1YpdLhSq5IIB5I0Cyylm0Xi21Z8iHq7ewolwz+
         h9L8jkjMhhmJETlocVTwYYzZCAiHJttb60AuOsrPnmzo7oyqP3g+T0Bl4bk2hawmvhqK
         zLL1TzkhVWUSIWIu6ujewHW3D4V9kkJ09sqvbG8/OEkWkKnwZwnQJdSuynTdn4DhkMHl
         oovjE3yTccfIVCsH72WYQJIlNTykJlVCYaXviEzTGrGBgI4jt1zmJOhKhhFGaeH2EkDv
         BrCg==
X-Forwarded-Encrypted: i=1; AJvYcCX2dEvtyyLlyhc5zWfz1iXdYrHF6f2qEXrAbXbMmn1NnqpWCpDpx8aK6f6KYyRBGx8QJETBd/DXc+EAw9U=@vger.kernel.org
X-Gm-Message-State: AOJu0YwxGnZT1moTBkZeJHp8ea84+vnAZwqHqiKwXnjmKzUcHMnDkiyl
	WsSX7ZM2+pGi43ksnAPvJsHZ/fyn9VB4b1QUMmKZDOLW1p/ZydKV
X-Google-Smtp-Source: AGHT+IF3EorqKcfzSFCQLTZxSpzb+WcqiU3BXbha8cob9NJAjnrimyGP1pMO9scA+dt5nqO6NnieEQ==
X-Received: by 2002:a05:651c:1507:b0:2f7:6664:f295 with SMTP id 38308e7fff4ca-2f76664f61dmr28234151fa.27.1725875897332;
        Mon, 09 Sep 2024 02:58:17 -0700 (PDT)
Received: from ?IPV6:2a03:83e0:1126:4:eb:d0d0:c7fd:c82c? ([2620:10d:c092:500::6:952a])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c3ebd41ce2sm2816569a12.19.2024.09.09.02.58.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Sep 2024 02:58:17 -0700 (PDT)
Message-ID: <cc70998e-1b7c-4ffc-835a-c5d492c64881@gmail.com>
Date: Mon, 9 Sep 2024 10:58:16 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 1/3] mm: Fix swap_read_folio_zeromap() for large folios
 with partial zeromap
To: Barry Song <21cnbao@gmail.com>, akpm@linux-foundation.org,
 linux-mm@kvack.org
Cc: baolin.wang@linux.alibaba.com, chrisl@kernel.org, david@redhat.com,
 hanchuanhua@oppo.com, hannes@cmpxchg.org, hch@infradead.org,
 hughd@google.com, kaleshsingh@google.com, kasong@tencent.com,
 linux-kernel@vger.kernel.org, mhocko@suse.com, minchan@kernel.org,
 nphamcs@gmail.com, ryan.roberts@arm.com, ryncsn@gmail.com,
 senozhatsky@chromium.org, shakeel.butt@linux.dev, shy828301@gmail.com,
 surenb@google.com, v-songbaohua@oppo.com, willy@infradead.org,
 xiang@kernel.org, ying.huang@intel.com, yosryahmed@google.com
References: <20240908232119.2157-1-21cnbao@gmail.com>
 <20240908232119.2157-2-21cnbao@gmail.com>
Content-Language: en-US
From: Usama Arif <usamaarif642@gmail.com>
In-Reply-To: <20240908232119.2157-2-21cnbao@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 09/09/2024 00:21, Barry Song wrote:
> From: Barry Song <v-songbaohua@oppo.com>
> 
> There could be a corner case where the first entry is non-zeromap,
> but a subsequent entry is zeromap. In this case, we should not
> let swap_read_folio_zeromap() return false since we will still
> read corrupted data.
> 
> Additionally, the iteration of test_bit() is unnecessary and
> can be replaced with bitmap operations, which are more efficient.
> 
> We can adopt the style of swap_pte_batch() and folio_pte_batch() to
> introduce swap_zeromap_batch() which seems to provide the greatest
> flexibility for the caller. This approach allows the caller to either
> check if the zeromap status of all entries is consistent or determine
> the number of contiguous entries with the same status.
> 
> Since swap_read_folio() can't handle reading a large folio that's
> partially zeromap and partially non-zeromap, we've moved the code
> to mm/swap.h so that others, like those working on swap-in, can
> access it.
> 
> Fixes: 0ca0c24e3211 ("mm: store zero pages to be swapped out in a bitmap")
> Cc: Usama Arif <usamaarif642@gmail.com>
> Reviewed-by: Yosry Ahmed <yosryahmed@google.com>
> Signed-off-by: Barry Song <v-songbaohua@oppo.com>

Reviewed-by: Usama Arif <usamaarif642@gmail.com>


