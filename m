Return-Path: <linux-kernel+bounces-188261-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D1F1F8CDFD4
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 05:38:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E76E41C221D6
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 03:38:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AFBD2E3EB;
	Fri, 24 May 2024 03:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="yos1vmi+"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19947BA42
	for <linux-kernel@vger.kernel.org>; Fri, 24 May 2024 03:38:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716521904; cv=none; b=ebNtlWWSW4HOSzFCoVwxPPUANS6j0/pxgfS1Xh4pOyZcGSp/Ou9l2bOP2r+VWWnoD8AfTtEpQWImI0p9WD3I4KfuDGWqbXyu+p8+JfbNG20wcWMbrUCsBPpVq+0eFSWD9DY4nmR9j4YDVUvrgL5zdPXflgrt51TstW9elvSsr7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716521904; c=relaxed/simple;
	bh=exhF/SvxNADH57vyw5NwLtdjR21ol3cvOjacKXgQOXA=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=d31kkxmUUlW/AdUu277adZ83hWjDI5aXWuNxAZ7l9dY+wsNJBGemPjlIwSY0u+OHr0SgfYbyBpEyq2GyX9w5xcQezezwaMKA+9qW69xBj0Tuc7KRLoRIzrqdGGKaGuYtuSgKlGvQ4zdmHuezKHGJ0huW3gz19VqQXCx9KKdJgCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--yosryahmed.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=yos1vmi+; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--yosryahmed.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-627e7f0ca54so51168297b3.3
        for <linux-kernel@vger.kernel.org>; Thu, 23 May 2024 20:38:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1716521902; x=1717126702; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=c6RztChgfOm/HvAmhxH4gX1dCxuVITCX+fCVI13JQXo=;
        b=yos1vmi+kc9/8+9wt/DAPpM8lROZkMB+87IDtjodS7cqQKz4HmBL3IlaA4iG3H0vHH
         RFhvi+C/k7kyk2aI+S8wQ4rmmfbhrXlFV21pDxempMl1466F3Zx1njdpIB7X0CbYNzwY
         gkuv0dWVh5zEW/dr7ssQX2ExM/kzhT5gqRqDVHdPPdoNVk+sPoZ3trFG/BTtsK1NUzRP
         qGIX6YOH382hoMmffyn35stvy/5CIu6/CO5z+liJxWEcvCtKdHXTaTD57C9M/vCGSJwz
         +7lMI6MapfaEe//5zYnHZrjlyZWdvGX+Wa0zUnGF6ef0VvJtrXpEo92oqoMge3nzjJMg
         0fJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716521902; x=1717126702;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=c6RztChgfOm/HvAmhxH4gX1dCxuVITCX+fCVI13JQXo=;
        b=YUgPr+Y86jWHrrJodUYPWPfANvwPP1ONLU/lJRsyAFKxDzyI737XrQ9AgSzMcfVt76
         LfNrBxn4AWSHpomkQqfjUX+d/6T9vDmitGMeAZr+3WJOVqVaTjjQogyYZwujXCVVAaSH
         3ejK2KaAWlxM9nuDWtpWMqiQit6mlQWSAUovtzS1tERPcE85BXLbwdUA+5g/m8yLzcD2
         DOS8RiB/g6F2ZsPUS8Z0lftqew5Z+xGPM7DOBChdqtbS4HMDXlVDUeHQZKjm+PEG/O8F
         Hh7cERm57Z2oKCO3Ibc+55Roti98A2hJWjjFe0dO+XjJJpnZNcLl29xKofBa79QXCPzM
         fk5Q==
X-Forwarded-Encrypted: i=1; AJvYcCW67MjqKtUQSVLgou7UWgsxphwVH5dIak1kSVAuL/wyzquTqPw0JO2wAXdcF4GCSmup7Zd0EtSlAyV27VeLMqAmGcYjyoZTVsVHxkXJ
X-Gm-Message-State: AOJu0Yy4/TBitG5GeQfMfpn/8qOp1MhznvBHfV0Lcj+Qed2wcj0Evb5W
	OOBNBSklvTHjX0DrqlcteUs6rJF2Q9hPi7FzkiDY0bvRHo9Xq9Znu4AnA2GnYr/awxh3/KArKvC
	ZBpWEtajj8VFOwp+iow==
X-Google-Smtp-Source: AGHT+IEplun7o3mqZedFSn0QqQ8XWW2EegcnZ7FYhw/xvSnovDyoGDS2OZkMs6NYdwglbvHK79b+ghmibqX2BphK
X-Received: from yosry.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:29b4])
 (user=yosryahmed job=sendgmr) by 2002:a05:690c:6486:b0:61d:3304:c25e with
 SMTP id 00721157ae682-62a08eeb028mr2893387b3.7.1716521902025; Thu, 23 May
 2024 20:38:22 -0700 (PDT)
Date: Fri, 24 May 2024 03:38:15 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.45.1.288.g0e0cd299f1-goog
Message-ID: <20240524033819.1953587-1-yosryahmed@google.com>
Subject: [PATCH 0/3] mm: zswap: trivial folio conversions
From: Yosry Ahmed <yosryahmed@google.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>, Nhat Pham <nphamcs@gmail.com>, 
	Chengming Zhou <chengming.zhou@linux.dev>, Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, Yosry Ahmed <yosryahmed@google.com>
Content-Type: text/plain; charset="UTF-8"

Some trivial folio conversions in zswap code.

The mean reason I included a cover letter is that I wanted to get
feedback on what other trivial conversions can/should be done in
mm/zswap.c (keeping in mind that only order-0 folios are supported
anyway).  These are the things I came across while searching for 'page'
in mm/zswap.c, and chose not to do anything about for now:

1. zswap_max_pages(), zswap_accept_thr_pages(), zswap_total_pages():
  - We can use 'size' instead of 'pages' and shift the return by
    PAGE_SHIFT. This adds an unnecessary shift, but I doubt it matters
    at all. The motivation is to get rid of 'page' to find things that
    should be converted more easily.

2. Counters names: zswap_stored_pages, zswap_written_back_pages, etc.

3. Comments all over the place reference 'page' instead of 'folio'.

4. shrink_memcg_cb(), zswap_shrinker_scan():
  - Rename encountered_page_in_swap_cache to
    encounterd_folio_in_swap_cache, or even better: folio_eexist or
    hit_swap_cache.

5. entry_to_nid():
  - It's tempting to try to use folio_to_nid(virt_to_folio()), but I
    think this adds an unnecessary call to compound_head(). It may not
    matter in practice though because the page is always a head page.

Yosry Ahmed (3):
  mm: zswap: use sg_set_folio() in zswap_{compress/decompress}()
  mm :zswap: use kmap_local_folio() in zswap_load()
  mm: zswap: make same_filled functions folio-friendly

 mm/zswap.c | 41 ++++++++++++++++++-----------------------
 1 file changed, 18 insertions(+), 23 deletions(-)

-- 
2.45.1.288.g0e0cd299f1-goog


