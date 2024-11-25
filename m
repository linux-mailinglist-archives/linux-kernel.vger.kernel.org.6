Return-Path: <linux-kernel+bounces-420366-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 058029D7990
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 01:58:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4707FB21771
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 00:58:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07C7E4A31;
	Mon, 25 Nov 2024 00:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WEc7qweS"
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0734B4A06
	for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2024 00:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732496292; cv=none; b=TR3LDhage+ybN9MZECoI/W4tMBTmh2v6Mu+0i/PFl6e07LLeNucNQLdrXuf835vpB7N3B31XWTiNMB0pIO3iG1wyoRvSZispiRVDW/0dgS4zy/5AKnmKYw3tMCcQp7O+MI4F8eKJC9XLUUvqZgZwYiQ9UmV3dbu3HLDAjZYDai8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732496292; c=relaxed/simple;
	bh=hQy9Yhk5Or/3MeZjPxPf/nv/s11PQYd4TkBCf154X2w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gGYLYa6bn+XTJSZg13+LxuH4Li5QOkofEVcF45oUTVMh6ioJ3MzT9wxPuQ/mYnhgMwR4YHrapka4a+XGGJJ2bMMNf2z3Aayjmn69nmdcQ36p9QxANtSgoUPEYYNQsUY+nXVRudLLDwUJnt8Dnw7YHigUOBUVxrofdUm0JmzhpiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WEc7qweS; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a9e8522445dso563917666b.1
        for <linux-kernel@vger.kernel.org>; Sun, 24 Nov 2024 16:58:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732496288; x=1733101088; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4++2V+4pp+6krcoDtGZ3GMLgtvyUslsfGVETpmRjikI=;
        b=WEc7qweSdBzGYJGM5JfQL/zEupH6f36xlQ2p9TSUNvzqQrTLIzPa5mh+vDmnNg7btS
         E5v6F6e/A1J1yDngwCCwDzjo6u+T5gZiIOH3gPLR6jm+2x7qn2L8wqFta0FHJrEtxH4W
         s8DwqkVSV+UcOGZe3EwFbJRQhyxCM9Di0X8PwrJw/b3f51yDNTXicNipwqLAXf1TK1Bd
         IVX1pps+DGfIWl33lvY8eJsw9gwkS5XHvfCqxi2s0qhCC29KV4IbWXNYSu7NBeHTyvM3
         QGLzSKUEiURVj/7jDMcTD/NWdpw2sqMVA1d/bAfTtfkHvlIZzAIoVq/uFBLwjgyBb95r
         fO5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732496288; x=1733101088;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4++2V+4pp+6krcoDtGZ3GMLgtvyUslsfGVETpmRjikI=;
        b=ZVjbz9G02SZbqd/rspPIEfRsKu6RUHd1zH6oR2+7akq9ucdRXqgx03hstvt+aqAjO1
         YpWpnkGJ89bKCSbDvsB2b5A1ZQsNRUugGyOtj505HgzfIMsKlSsCEPaGFy/LOfaTFacC
         z4hZ6C1r61Mb2KhKGZrh/4WqkfwPMU4hEAJ52rlFoz+FDUdgl51RUvScSBZRl3tRJLbV
         VjwI+bPBuJSg5ILvrMjE1X4kQVc1XfInB4urf67DRTeBUxunjrYOwE2FawctJ/3VO4O9
         gm3sHl7ChGj328Krn1d21GXNiJ9hA+XZriBp7d/vPSx0Oa/Ero3gvmhzm3l7HSWgWnmH
         gXqQ==
X-Forwarded-Encrypted: i=1; AJvYcCUbYsIKu7lMTxr5KSFepWMm6NLc+ue+WARyEaNGJvX3C9ro2E4R1ACzHNi0EmsLjomWj3PtkGGsLkFGN1k=@vger.kernel.org
X-Gm-Message-State: AOJu0YybK+bScaKMDNINU7ClvjwiAmtL08Aa/aE0lAmeBqWRMgpazmWY
	hAFjA89WKgGcxNBWkK3qVJLOcL7Q7iT0FjtxfHuvL3HWpIkskNk+
X-Gm-Gg: ASbGnct0aAbSjnSdHx/x790AR/31E7QcZl0+S6B1LpYokVQ8HezMAgjM/FhAPukb0AO
	fWSSAQ9Fug3PwHfvbELOvCvSkF5dkNSWKgeJvnbzzcVBD8reiilsCKjmqHkrbee1CYHNzMGSRQT
	N0rT5WqjmklCvqeMR2kuenScdQLzuVLpRG5zJISdIrswgvAhMYOeZS2xOl83MVfd9WA0apSlUWN
	5kj+xdc6DJrOYy3Dn44XdI+30bdpj6gJWHwJIF2P9+6+7BAMw==
X-Google-Smtp-Source: AGHT+IHgILroKnOIdPX6/xPhKJncU/rWhtdKGU788sGXJR2BN/QcoziaTgUVtnCf/gLcENHr2z8KMQ==
X-Received: by 2002:a17:907:7781:b0:aa5:3c28:e0ae with SMTP id a640c23a62f3a-aa53c28e13amr502050566b.15.1732496288024;
        Sun, 24 Nov 2024 16:58:08 -0800 (PST)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa50b52fcf9sm396492266b.118.2024.11.24.16.58.04
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 24 Nov 2024 16:58:06 -0800 (PST)
Date: Mon, 25 Nov 2024 00:58:04 +0000
From: Wei Yang <richard.weiyang@gmail.com>
To: Suren Baghdasaryan <surenb@google.com>
Cc: akpm@linux-foundation.org, peterz@infradead.org, andrii@kernel.org,
	jannh@google.com, Liam.Howlett@oracle.com,
	lorenzo.stoakes@oracle.com, vbabka@suse.cz, mhocko@kernel.org,
	shakeel.butt@linux.dev, hannes@cmpxchg.org, david@redhat.com,
	willy@infradead.org, brauner@kernel.org, oleg@redhat.com,
	arnd@arndb.de, richard.weiyang@gmail.com,
	zhangpeng.00@bytedance.com, linmiaohe@huawei.com,
	viro@zeniv.linux.org.uk, hca@linux.ibm.com, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 3/3] mm: introduce
 mmap_lock_speculate_{try_begin|retry}
Message-ID: <20241125005804.libwzfcz6d5zeyi4@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20241122174416.1367052-1-surenb@google.com>
 <20241122174416.1367052-3-surenb@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241122174416.1367052-3-surenb@google.com>
User-Agent: NeoMutt/20170113 (1.7.2)

On Fri, Nov 22, 2024 at 09:44:16AM -0800, Suren Baghdasaryan wrote:
>Add helper functions to speculatively perform operations without
>read-locking mmap_lock, expecting that mmap_lock will not be
>write-locked and mm is not modified from under us.
>
>Suggested-by: Peter Zijlstra <peterz@infradead.org>
>Signed-off-by: Suren Baghdasaryan <surenb@google.com>
>Reviewed-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
>---
>Changes since v2 [1]
>- Added SOB, per Liam Howlett
>
>[1] https://lore.kernel.org/all/20241121162826.987947-3-surenb@google.com/
>
> include/linux/mmap_lock.h | 33 +++++++++++++++++++++++++++++++--
> 1 file changed, 31 insertions(+), 2 deletions(-)
>
>diff --git a/include/linux/mmap_lock.h b/include/linux/mmap_lock.h
>index 9715326f5a85..8ac3041df053 100644
>--- a/include/linux/mmap_lock.h
>+++ b/include/linux/mmap_lock.h
>@@ -71,6 +71,7 @@ static inline void mmap_assert_write_locked(const struct mm_struct *mm)
> }
> 
> #ifdef CONFIG_PER_VMA_LOCK
>+
> static inline void mm_lock_seqcount_init(struct mm_struct *mm)
> {
> 	seqcount_init(&mm->mm_lock_seq);
>@@ -87,11 +88,39 @@ static inline void mm_lock_seqcount_end(struct mm_struct *mm)
> 	do_raw_write_seqcount_end(&mm->mm_lock_seq);
> }
> 
>-#else
>+static inline bool mmap_lock_speculate_try_begin(struct mm_struct *mm, unsigned int *seq)
>+{
>+	/*
>+	 * Since mmap_lock is a sleeping lock, and waiting for it to become
>+	 * unlocked is more or less equivalent with taking it ourselves, don't
>+	 * bother with the speculative path if mmap_lock is already write-locked
>+	 * and take the slow path, which takes the lock.
>+	 */
>+	return raw_seqcount_try_begin(&mm->mm_lock_seq, *seq);
>+}
>+
>+static inline bool mmap_lock_speculate_retry(struct mm_struct *mm, unsigned int seq)
>+{
>+	return do_read_seqcount_retry(&mm->mm_lock_seq, seq);

Just curious why we don't use read_seqcount_retry().

Looks this is the only user outside seqlock.h.

>+}
>+
>+#else /* CONFIG_PER_VMA_LOCK */
>+
> static inline void mm_lock_seqcount_init(struct mm_struct *mm) {}
> static inline void mm_lock_seqcount_begin(struct mm_struct *mm) {}
> static inline void mm_lock_seqcount_end(struct mm_struct *mm) {}
>-#endif
>+
>+static inline bool mmap_lock_speculate_try_begin(struct mm_struct *mm, unsigned int *seq)
>+{
>+	return false;
>+}
>+
>+static inline bool mmap_lock_speculate_retry(struct mm_struct *mm, unsigned int seq)
>+{
>+	return true;
>+}
>+
>+#endif /* CONFIG_PER_VMA_LOCK */
> 
> static inline void mmap_init_lock(struct mm_struct *mm)
> {
>-- 
>2.47.0.371.ga323438b13-goog

-- 
Wei Yang
Help you, Help me

