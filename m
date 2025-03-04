Return-Path: <linux-kernel+bounces-543738-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A8DC9A4D92A
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 10:49:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C34297A7BC1
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 09:47:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C8E81FDE1A;
	Tue,  4 Mar 2025 09:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hwb942xG"
Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B1D01FDE20
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 09:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741081685; cv=none; b=WxSPwQ0qjhg+qxeMXy3kNNkna6lLVyT694RO7DHdayGs0w39Y7Q19g1LK1gtUbomB/6YOyB6hbsuMq9s4+wpPeOzndwgwbOQGQRvmf0EiRrTpVN+1b9e1NU35/4fBozTZ7Qoub+I/MyM9iIrQU6aVa6Hizdj4LwmoF4vGxnVyRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741081685; c=relaxed/simple;
	bh=2r3By0fXJsZQEawsgDkxqe42VQpAHpb0s0vqWGd1zPM=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=QUstW0A5D9brehkjgzQUD1uJrW7paPw0HhKaLMukGE4r4ADjN/aiE5Q2Zn8JEcPdFls1s43E2gdOZ5vylCqWmNuZ/ggR1ncGiskCozFtcVltiFpTc/Chl5kPovPOMdOkGhWeyJVWhbvj/WuSpY00Q7T2Qp3jHhv2TV+XO4Q/Iwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hwb942xG; arc=none smtp.client-ip=209.85.210.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-72a164cb607so222933a34.0
        for <linux-kernel@vger.kernel.org>; Tue, 04 Mar 2025 01:48:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741081683; x=1741686483; darn=vger.kernel.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=8HOHs5ZstfJ5o568Xa5zyB7db/o03y3YlavBZxWfyZQ=;
        b=hwb942xGVaaPN07SDla2T5DrP41e63Ut8XryPC6zyu459GdopxH10O5E9uOPfeoix7
         lYCMr7O4fXM0iFZY58KJej1K9WztuuCc5nHm/Y4W6OX8U68cuHWo6YY46h08UwmVhc/h
         /oHvCULfSd93/XUPTuVaBAOe5TGCgBQUp6CROL8T2s/cn0QPlsIN2nXH9ioZEpPod4uV
         F9jaM4xuQ4FPvK+bn1EZ1mIligLAeLgKEMmm4GDgviPltM7K9Kbdkt1SoIHzlFBqwaS2
         vs3G4XF+P1/yFfzYbhkqwqI2RJD2mLqsF8wDSxpCOcaeGSuFrPZ3/4I1XD2hJ4w96jJ1
         o+lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741081683; x=1741686483;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8HOHs5ZstfJ5o568Xa5zyB7db/o03y3YlavBZxWfyZQ=;
        b=l9or1V4gxP0Pkf5cfpLLkEuhKjh/fUEoUQae4Y8UyK74z3iFFB2cv4cFz3K1Qd9mlw
         0+RpCjcszdsgBA9gPqOdaiR9+3PDNOM7fedwrXCgL58PRNdLebW7/fQ9+1jmLKQ/0eWK
         lUej4zRa8iESOIGDrI3L3vpYHcm59BvLo41OqENsfaaN4AuvBeXH3RjXoX0sQKHnVSvz
         oqkhQZEzG/hHFvC95HU2zGVmzuyUcJQIYk0dhn1YbM3ngi3QFAW0hIXa40rgYkDU6tX7
         smvA5eUxi7gTxz88UDsCpMli42feLVHdUP6P50dmcZcXN8zyPIHKPJtsTDWZxBmNTFW5
         coUA==
X-Forwarded-Encrypted: i=1; AJvYcCVzeabouH8uwRz/im63afrvP05RV3cbgj7dvEU6UkHYxzYWT38womMhO9fkiU84yiqXVEp9lJ5HZAhd+B8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxM9ZMxG/X01DXzRKCOKeeFex7ZIsscsDtcDNC3yLscBeCrhDEb
	dT6hBm5jkJDX9hBdyMx0dkPprEOrI+1V3o1ssiW8GHDhYjtfvrZyxTOHYH6MFw==
X-Gm-Gg: ASbGnct+N7Kz8EXtgXNbtbtT/WOqaAV/8BheJAp32QRqZ4d5YcBy8Il6o7gHuw6aePt
	uz0RxgZBkFUWOjfmLhtLANetzYwLiJZcCV35rl+zTEMABKfBeGusiPB9fPqlLAGsqFhU/z2taPb
	prDBVBB0ZL9o9Q/4j7cVESkfFJEVWhN4IMopvTMqlc02RI6aa5wyRmWZtzGPWDD3586eug34Ks2
	10aJLsETYUk8pJh3E44oJbiVx6ZzHkhA4V7hYNxc6aYpKOcaEoWh4AwvHNwjCNbl5kHUq9PgNtN
	xyBUjZc13UBvBy/fhXZSU17FYJePTJ9ImidD9pwT1XC3N5azZB6gRkkzmXYf7bx9oiKB6wdHSSD
	mScqOyScJFJpOY2i6MzXqGkX1b//j
X-Google-Smtp-Source: AGHT+IGdMEBMjK0xYYVwrNxOf6XqwE8AYZxLYxN/SKUpsg+bPBtoAzbZx90I3qdmj2oNt7FksMqoPQ==
X-Received: by 2002:a05:6830:91f:b0:728:b9d3:4330 with SMTP id 46e09a7af769-72a14efd17bmr1806518a34.1.1741081682851;
        Tue, 04 Mar 2025 01:48:02 -0800 (PST)
Received: from darker.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-728afd0061dsm2071715a34.27.2025.03.04.01.47.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Mar 2025 01:48:01 -0800 (PST)
Date: Tue, 4 Mar 2025 01:47:46 -0800 (PST)
From: Hugh Dickins <hughd@google.com>
To: Zi Yan <ziy@nvidia.com>
cc: Liu Shixin <liushixin2@huawei.com>, 
    Baolin Wang <baolin.wang@linux.alibaba.com>, linux-mm@kvack.org, 
    Andrew Morton <akpm@linux-foundation.org>, Barry Song <baohua@kernel.org>, 
    David Hildenbrand <david@redhat.com>, 
    Kefeng Wang <wangkefeng.wang@huawei.com>, Lance Yang <ioworker0@gmail.com>, 
    Ryan Roberts <ryan.roberts@arm.com>, Matthew Wilcox <willy@infradead.org>, 
    Hugh Dickins <hughd@google.com>, 
    Charan Teja Kalla <quic_charante@quicinc.com>, 
    linux-kernel@vger.kernel.org, Shivank Garg <shivankg@amd.com>
Subject: Re: [PATCH v2] mm/migrate: fix shmem xarray update during
 migration
In-Reply-To: <20250228174953.2222831-1-ziy@nvidia.com>
Message-ID: <23d65532-859a-e88f-9c24-06a6c7ff4006@google.com>
References: <20250228174953.2222831-1-ziy@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Fri, 28 Feb 2025, Zi Yan wrote:

> Pagecache uses multi-index entries for large folio, so does shmem. Only
> swap cache still stores multiple entries for a single large folio.
> Commit fc346d0a70a1 ("mm: migrate high-order folios in swap cache correctly")
> fixed swap cache but got shmem wrong by storing multiple entries for
> a large shmem folio. Fix it by storing a single entry for a shmem
> folio.
> 
> Fixes: fc346d0a70a1 ("mm: migrate high-order folios in swap cache correctly")
> Reported-by: Liu Shixin <liushixin2@huawei.com>
> Closes: https://lore.kernel.org/all/28546fb4-5210-bf75-16d6-43e1f8646080@huawei.com/
> Signed-off-by: Zi Yan <ziy@nvidia.com>
> Reviewed-by: Shivank Garg <shivankg@amd.com>

It's a great find (I think), and your commit message is okay:
but unless I'm much mistaken, NAK to the patch itself.

First, I say "(I think)" there, because I don't actually know what the
loop writing the same folio nr times to the multi-index entry does to
the xarray: I can imagine it as being completely harmless, just nr
times more work than was needed.

But I guess it does something bad, since Matthew was horrified,
and we have all found that your patch appears to improve behaviour
(or at least improve behaviour in the context of your folio_split()
series: none of us noticed a problem before that, but it may be
that your new series is widening our exposure to existing bugs).

Maybe your orginal patch, with the shmem_mapping(mapping) check there,
was good, and it's only wrong when changed to !folio_test_anon(folio);
but TBH I find it too confusing, with the conditionals the way they are.
See my preferred alternative below.

The vital point is that multi-index entries are not used in swap cache:
whether the folio in question orginates from anon or from shmem.  And
it's easier to understand once you remember that a shmem folio is never
in both page cache and swap cache at the same time (well, there may be an
instant of transition from one to other while that folio is held locked) -
once it's in swap cache, folio->mapping is NULL and it's no longer
recognizable as from a shmem mapping.

The way I read your patch originally, I thought it meant that shmem
folios go into the swap cache as multi-index, but anon folios do not;
which seemed a worrying mixture to me.  But crashes on the
VM_BUG_ON_PAGE(entry != folio, entry) in __delete_from_swap_cache()
yesterday (with your patch in) led me to see how add_to_swap_cache()
inserts multiple non-multi-index entries, whether for anon or for shmem.

If this patch really is needed in old releases, then I suspect that
mm/huge_memory.c needs correction there too; but let me explain in
a response to your folio_split() series.

> ---
>  mm/migrate.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/mm/migrate.c b/mm/migrate.c
> index 365c6daa8d1b..2c9669135a38 100644
> --- a/mm/migrate.c
> +++ b/mm/migrate.c
> @@ -524,7 +524,11 @@ static int __folio_migrate_mapping(struct address_space *mapping,
>  			folio_set_swapcache(newfolio);
>  			newfolio->private = folio_get_private(folio);
>  		}
> -		entries = nr;
> +		/* shmem uses high-order entry */
> +		if (!folio_test_anon(folio))
> +			entries = 1;
> +		else
> +			entries = nr;
>  	} else {
>  		VM_BUG_ON_FOLIO(folio_test_swapcache(folio), folio);
>  		entries = 1;
> -- 
> 2.47.2

NAK to that patch above, here's how I think it should be:

Signed-off-by: Hugh Dickins <hughd@google.com>
---
 mm/migrate.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/mm/migrate.c b/mm/migrate.c
index fb19a18892c8..822776819ca6 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -518,12 +518,12 @@ static int __folio_migrate_mapping(struct address_space *mapping,
 	if (folio_test_anon(folio) && folio_test_large(folio))
 		mod_mthp_stat(folio_order(folio), MTHP_STAT_NR_ANON, 1);
 	folio_ref_add(newfolio, nr); /* add cache reference */
-	if (folio_test_swapbacked(folio)) {
+	if (folio_test_swapbacked(folio))
 		__folio_set_swapbacked(newfolio);
-		if (folio_test_swapcache(folio)) {
-			folio_set_swapcache(newfolio);
-			newfolio->private = folio_get_private(folio);
-		}
+
+	if (folio_test_swapcache(folio)) {
+		folio_set_swapcache(newfolio);
+		newfolio->private = folio_get_private(folio);
 		entries = nr;
 	} else {
 		VM_BUG_ON_FOLIO(folio_test_swapcache(folio), folio);
-- 
2.43.0

