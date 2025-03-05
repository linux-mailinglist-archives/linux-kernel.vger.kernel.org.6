Return-Path: <linux-kernel+bounces-546752-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AC44A4FE4E
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 13:13:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 382D93A53CC
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 12:12:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76A84242932;
	Wed,  5 Mar 2025 12:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="L1yDgyy0"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DA4A1F418C
	for <linux-kernel@vger.kernel.org>; Wed,  5 Mar 2025 12:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741176768; cv=none; b=nERMQ2k6uEIJiJx6lDLj2KL8YFHKr9iLWXU99F3mIy63qt7Mf8XABpZUpOgVxHGhWiRCcZbW1NZW3X9Suh3Jkk52iPteQ13w/MwWzO50u9d0OImm0VECgFAD1VL669uYkLilMJjH7cbSJLy4dUVNzdprL+9a2K7ZZQxaiCw69L8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741176768; c=relaxed/simple;
	bh=IROa3Is4hJKU+3lfjNXme19IbGp3S5jDv3YTHYsnS+Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Dw98Q6To3FkH6BMItZPtTb7X/jtAedofnm/THYnbmmFAIlFDMc7WDLl0rQsgjrHv6q8nnYc02Fnz9g5ySk9XpRDULp+NBA/+gEEBkujDM6Rza38X33dR+OE9aBpz8XAMZRVefez99bEBor6k+c/ntLe4ZUHI+vQX5VgqBL3AEMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=L1yDgyy0; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741176766;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/X9P/s4Dq9sJrjMJgrTANUbR03RwYaO7C6c7l2By4eI=;
	b=L1yDgyy0Nxa6c4F6mKmi2UooPCsHuyt0WFaIuXLCizPQJ98BkQzW8eGXTIH6uoEEgu32qA
	DO0uF08Xp2NWPJaMGYITRuhTg3ih2LNUNlksTEyUcToz85cItC+AKGlYu9ZlhCHsOGYp6b
	sgSQouilJ5K10SUSe4D5o4FVKMj17/I=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-627-Rnmuzc0-MKyRaSN9jQ-piA-1; Wed, 05 Mar 2025 07:12:29 -0500
X-MC-Unique: Rnmuzc0-MKyRaSN9jQ-piA-1
X-Mimecast-MFC-AGG-ID: Rnmuzc0-MKyRaSN9jQ-piA_1741176749
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-6e2378169a4so145251836d6.2
        for <linux-kernel@vger.kernel.org>; Wed, 05 Mar 2025 04:12:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741176749; x=1741781549;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/X9P/s4Dq9sJrjMJgrTANUbR03RwYaO7C6c7l2By4eI=;
        b=NF4HgodLoj9zJ0TyZPBHDOBJIgm/ADC/WR7WPHWRyWQkWoxQFBRrzp49iEPFrp2WmC
         lBttAIJOzropx2HZg2t81XrOwZeISp++/qjBhgbtJIRCy/RFojU2kFg8GUZKaJoABchq
         cK9QGZ7YuAOOPU8lDpDEqztNvTwhQXanr9scMZ84wiU2K/NRuHSNtkhMN8X2+z3riCPC
         nc4qoLRpmiT/eDgx8+lMXGz57I1+sdL8X+KURtca0DlW6WgbI11qnSQWGdM/yGB1diKS
         yX1cKlUC++9THtslMDjY7DThso8U+xFNOwY8+5DIp0WSdFjpqjN4gku0vVn0D4DL3r29
         9JNg==
X-Forwarded-Encrypted: i=1; AJvYcCUGV0MwCe8gTJfE1JbxclnLqZHpTC5E9E0NebnPm74feLyfN1ORG3ZZZ/MzbzjLeKHozJGmT6z8jqZX3SM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/MFWUCBMR3FFwVOCoDgOk2HUq6yJI4fh0J2wVCHzeXQXLnsID
	DsWomWEQMon3hEA55v19NjoWTeQNEvDNaWQPFR9N5HlqCO4ZukPtDS7fDFpDQQIWb/iQk4P8AZ3
	RLGHacES7rEsovl3tMEpNqnUFTmzx0AjfOVwn890h7kPtSRzvPXUZCm+0tzWnDw==
X-Gm-Gg: ASbGnct5q8EUtotCCLwAiAbhF0pfCpZ2y7hqexnEdjsvn2NAfc09+S3psyAcLPkM/G7
	/ifaie5Qm93a2lcsUvYfYOiks9pEnYCfS/JEJJA7IlkWFVyO4nYDtplSIIACA4QTYLr4I/9r7oU
	o7RMyZlqRSw7l53qps2GYSIaZZw5GGfRiR5H4I+Y/ebmMDNeaDIXDL0/KTadgQQamuZ5BV2hajT
	oFx2oCbH1lX6uF6JDOhBs4tAEgEEeAGwGCs2SKbGy4IifQRWuYVq02zrcmgQHm2mACmcEBVTeIy
	PBG+77Y=
X-Received: by 2002:ad4:5aa9:0:b0:6e6:61f1:457f with SMTP id 6a1803df08f44-6e8e6d5a105mr46186206d6.18.1741176749510;
        Wed, 05 Mar 2025 04:12:29 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEQO4t4Tj8larLxjQ1Jm8FQEf5julhPob7NsZXxbaxzAxUJ5Kqr85sR2gKZuyq2cpDI5Bbhrw==
X-Received: by 2002:ad4:5aa9:0:b0:6e6:61f1:457f with SMTP id 6a1803df08f44-6e8e6d5a105mr46185966d6.18.1741176749170;
        Wed, 05 Mar 2025 04:12:29 -0800 (PST)
Received: from x1.local ([85.131.185.92])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e8f19290a7sm733116d6.72.2025.03.05.04.12.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Mar 2025 04:12:28 -0800 (PST)
Date: Wed, 5 Mar 2025 07:12:25 -0500
From: Peter Xu <peterx@redhat.com>
To: Liu Shixin <liushixin2@huawei.com>
Cc: Muchun Song <muchun.song@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@redhat.com>,
	Oscar Salvador <osalvador@suse.de>,
	Kefeng Wang <wangkefeng.wang@huawei.com>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] mm/hugetlb: update nr_huge_pages and
 surplus_huge_pages together
Message-ID: <Z8g_qclqlqkKkz7K@x1.local>
References: <20250305035409.2391344-1-liushixin2@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250305035409.2391344-1-liushixin2@huawei.com>

On Wed, Mar 05, 2025 at 11:54:09AM +0800, Liu Shixin wrote:
> In alloc_surplus_hugetlb_folio(), we increase nr_huge_pages and
> surplus_huge_pages separately. In the middle window, if we set
> nr_hugepages to smaller and satisfy count < persistent_huge_pages(h),
> the surplus_huge_pages will be increased by adjust_pool_surplus().
> 
> After adding delay in the middle window, we can reproduce the problem
> easily by following step:
> 
>  1. echo 3 > /proc/sys/vm/nr_overcommit_hugepages
>  2. mmap two hugepages. When nr_huge_pages=2 and surplus_huge_pages=1,
>     goto step 3.
>  3. echo 0 > /proc/sys/vm/nr_huge_pages
> 
> Finally, nr_huge_pages is less than surplus_huge_pages.
> 
> To fix the problem, call only_alloc_fresh_hugetlb_folio() instead and
> move down __prep_account_new_huge_page() into the hugetlb_lock.
> 
> Fixes: 0c397daea1d4 ("mm, hugetlb: further simplify hugetlb allocation API")
> Signed-off-by: Liu Shixin <liushixin2@huawei.com>

Acked-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


