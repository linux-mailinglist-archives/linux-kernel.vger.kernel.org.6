Return-Path: <linux-kernel+bounces-383471-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8ACFE9B1C35
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Oct 2024 06:08:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B85EC1C20EBB
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Oct 2024 05:08:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6B1B4204B;
	Sun, 27 Oct 2024 05:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jL8aof0t"
Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56BD23FB0E
	for <linux-kernel@vger.kernel.org>; Sun, 27 Oct 2024 05:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730005710; cv=none; b=dpUW90E7Wl252oM+Sco+4gnmCGrYrS9zPs827/gYHrhorSLG66HPNhwlEflH+gluo19zLwghWCCKXUcUFNJzs1Vv1Hw3Y+bQb5bBEpwIhT2yddCFCcytciT3BS63DBcMeYDDMbz1ThXaPr0w79y43yrq187rC3KwYs4R43TKw5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730005710; c=relaxed/simple;
	bh=dp66j1umkefnkG2UdqRts5LKxZZ7fwfaz2ENwKC3Lao=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=B4T6Gm0WLA1n4t1hZm4+FXUVSgqmtCVlNeB2lVezGNCq+S5IGFPeuqqZ/yBj5nfLorTT0TWOmWrTzYAWYw/LJV18syMlRJpILS56/933kjO8639YGYgBzNJY8oAiGqXh4dW0297S2OVahlzEZj02fV2nxYsXjWj8d4nnQABTtCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jL8aof0t; arc=none smtp.client-ip=209.85.210.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-718123ec383so1872015a34.3
        for <linux-kernel@vger.kernel.org>; Sat, 26 Oct 2024 22:08:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730005706; x=1730610506; darn=vger.kernel.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=W8OblH46z3viSEcwlc9hpu71gThmqui1kydso5kdQnc=;
        b=jL8aof0tdHq8PIPqoCPrJFwWej5mwdkFyP6ezjsS7AxoXUwWyJbImOuc820wu4hhpw
         43ViLUcmMVWE0oNQCjTIGeMc/FfuFoKHftrf+OsZ1pJESUftLQvhpGMrPd+t/GmDSOCG
         qLKNE/e86M4l1CGxQlL7a70z5iszU7tbMpbwEFx42Iexfj/A6FOJabWQ7NJVEZ093WQP
         XK+NUGE5CVfbnXJS4oGd1HJfcQ91mC8psTuxVKf549ckjcYhJntt8kkHblInhTB1zaix
         muEETYd8xZ8HocAGjdN7k/g2C5YVIt9+esxbkXOO/8buaDmUlZytXr6b1bcbIILGsEUm
         pWmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730005706; x=1730610506;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=W8OblH46z3viSEcwlc9hpu71gThmqui1kydso5kdQnc=;
        b=jMpjz5lL4Qf8aVIi8pK5KD6Vc1/Wi/J0xfaJ5Yl1QKG1/pB4bKxfUCxINRrb1rUZzQ
         DMSw+kWDOkehWTiooucGVGmm6WN+WyAGkiVTNHrLhICqrc7gmTzuhqO+/zc7FUMLatgr
         tJhk2hHFmYdRs2pV+6GASS1nC96AHTMGm4veUH6kNduV/tHKUHmfCeJ8/KHJHhvonnxF
         63eCZ7pffe7S73OnCVCibVT8PdhkuNbdkd9f0UjnO3ZJ+cAzPfS8zoc1oOWuGzMXBlGE
         vhMEJHlf3I/SqR1Kv6K3O/lCHJifKDmhdnkpAz3vf0kavyYkwVmlXvg3N0HY0wF3BZAx
         rqGw==
X-Forwarded-Encrypted: i=1; AJvYcCWrtlCx5pib0+GMiRv6JCvGAjmZwQkSQOmEvRiplAkUa7UDKV/cx60St1vedn4bJwkey+TUSV7GVtwmt1c=@vger.kernel.org
X-Gm-Message-State: AOJu0YxmYZDPQpZkl9Rg/J5S2MK+JEucnStakoVQyOX8uPTyS8hz9X5E
	QLGl7Sktamvh9+tXfu5CWWXIlquOuqJNtLzuNl323z3nwNB8cyUk76s5zP0OXQ==
X-Google-Smtp-Source: AGHT+IE1m1v5pF0d5usmCN9rKf27XN9GdvVqGi89h/b7QxHBIDEx7ry5hqLmUQWWtWQeoIQyauq4fw==
X-Received: by 2002:a05:6830:8d1:b0:718:167f:7f1c with SMTP id 46e09a7af769-7186821f6b5mr3335672a34.13.1730005706274;
        Sat, 26 Oct 2024 22:08:26 -0700 (PDT)
Received: from darker.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-718615068f1sm1001454a34.8.2024.10.26.22.08.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Oct 2024 22:08:25 -0700 (PDT)
Date: Sat, 26 Oct 2024 22:08:13 -0700 (PDT)
From: Hugh Dickins <hughd@google.com>
To: Yang Shi <shy828301@gmail.com>
cc: Zi Yan <ziy@nvidia.com>, Hugh Dickins <hughd@google.com>, 
    Andrew Morton <akpm@linux-foundation.org>, 
    Usama Arif <usamaarif642@gmail.com>, Wei Yang <richard.weiyang@gmail.com>, 
    "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, 
    Matthew Wilcox <willy@infradead.org>, David Hildenbrand <david@redhat.com>, 
    Johannes Weiner <hannes@cmpxchg.org>, 
    Baolin Wang <baolin.wang@linux.alibaba.com>, 
    Barry Song <baohua@kernel.org>, Kefeng Wang <wangkefeng.wang@huawei.com>, 
    Ryan Roberts <ryan.roberts@arm.com>, Nhat Pham <nphamcs@gmail.com>, 
    Chris Li <chrisl@kernel.org>, linux-kernel@vger.kernel.org, 
    linux-mm@kvack.org
Subject: Re: [PATCH hotfix 1/2] mm/thp: fix deferred split queue not
 partially_mapped
In-Reply-To: <CAHbLzkqEhbw89HMh7h-r6M1xM5vw7bUZDNO7KEgPyaguO32d-Q@mail.gmail.com>
Message-ID: <5d28df34-f073-dec5-730e-a3073f14d849@google.com>
References: <760237a3-69d6-9197-432d-0306d52c048a@google.com> <3A1E5353-D8C5-4D38-A3FF-BFC671FC25CE@nvidia.com> <966a4aff-f587-c4bb-1e10-2673734c2aa0@google.com> <E5A75697-55C7-4335-8D86-EE5CB6A99C4F@nvidia.com>
 <CAHbLzkqEhbw89HMh7h-r6M1xM5vw7bUZDNO7KEgPyaguO32d-Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Fri, 25 Oct 2024, Yang Shi wrote:
> 
> The other subtle thing is folio->_deferred_list is reused when the
> folio is moved to the local on-stack list. And some

Yes.

> list_empty(deferred_list) checks return true even though the folio is
> actually on the local on-stack list. Some code may depend on or

The code definitely depends on that behaviour: that's how folios get
unqueued when refcount reaches 0, whether they are on the public list
or on the local list at that time.

> inadvertently depend on this behavior. Using folio_batch may break
> some assumptions, but depending on this subtle behavior is definitely
> not reliable IMHO.

