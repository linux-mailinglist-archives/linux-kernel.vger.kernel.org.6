Return-Path: <linux-kernel+bounces-531188-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ADEC7A43D59
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 12:21:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 610723B31FA
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 11:15:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C0D226772F;
	Tue, 25 Feb 2025 11:15:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1JdV71WP"
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 156B02676FD
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 11:15:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740482110; cv=none; b=kB01N1VWGO912cvzKkrld7VMwr4VSkqd8IpKS6Mb7ZijP1JqnOc/wEKGSr8CHtBwYYle1k0LEaTd7Rk1NjXG/UuOgqmppvSZh+fCy2FrsOCq2Mquas6uwDZbJISu7zMPE644d9uP7f+L3Qkufu8rJsdjIjIGxzP3T2cq3AiZRko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740482110; c=relaxed/simple;
	bh=ObW0ySAp2NYqfEvC+jiKAOzw8shS/kdjO9OS0VOsQjo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kiQBrIZgKhOjEGWKdkAQy8bXL9clSEhsEWcPeaA2oxOMsnJlMotk3wSEURJI4iQi3W1KfsaWgdDAMrhACO3fT7v7HHwFdBF87OZKf56HQxke9obfsH3kVJMrRjw89TsXB/DGr6yFANUXxAwnFNBI32yB4DWtbQ6DgI5cK1r0aUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1JdV71WP; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-471f1dd5b80so170881cf.1
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 03:15:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740482108; x=1741086908; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Xc5yW/4rgg5KqhOxif21KGnv89ZFaMc+1AokhRRA/h0=;
        b=1JdV71WPJItk2UzfZN5cVoCUbpJYLgUscOOOUnTbvtLEbbaIf0TMz7pBCZOcsfjphT
         p/XRQyd+GOSSAU8KMVwkNltZpktjbow5gQkcv/9U5LNjcMRvBDrxgTE/Y2lgM/Ri4ioc
         9Q/AILPOLcqMKXI6n8AdyWr1XuWtsUaS/l3KVhmvbmzwiggMff6clrfi5xVLLBsJLbbI
         5L8HEC+AKVeVGG8Tnk03O7TFq5upTyHdsIROkhrCEQhwNJQN22CkfPS2i9CmhSkABBRI
         yLBfK6FXJr9GGU7wxSG6tiN18PWyVzvw+W4VyaJSAJs5s5B0hgjkdozq1izK0axayq9a
         03AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740482108; x=1741086908;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Xc5yW/4rgg5KqhOxif21KGnv89ZFaMc+1AokhRRA/h0=;
        b=qwSf3Auw20AAOw1vfBs9sPZg1Dn3ICcSfnRZCvnA3PLyVMeSbpU1QgKLEmxjYxNFK7
         d/4Wrunr1yMpEOVOkOz0mp8ha5P6bPlSgK+0BD7NHJJxThCXDqdKhhKBueXvRsvkbJrW
         sEcjjvPVXA/zUf5Osc/A04NuM9qg2zEdntVHaMMSlrCAuOEYw3+Vf2JSKExm2n1HkitI
         MBVKHY3+/G9dCBgC8ycQIzGrSd9LEqk4v/wqA5yJ32UNGaQ8yeUELZX3o9RhalM+zBXc
         U8fjhY1WijPI9O8nujtvKu9lReZoKJJ2ppAw+lNZ+itS6hX+s4FMXcnuOEHsHQJ3WTtO
         375g==
X-Forwarded-Encrypted: i=1; AJvYcCUlCchs8FTeFukfdwnUrCjvVpXbCNPY1nJXJgB0u569XOrytptvu8oy84/OlH1mK7YMJJzm73Pb5xOIpSg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6qE9HOFjmc8nY3T1N65KTc31GEZ772p1dX1XnIAYPLQrCfilx
	5p6V4wjjeRYRLMoEQU5OJtPsVTd5gVA4b2JBIPcUBCav86iw6KnZJLIv2fQ+P/MShZ1AQH6ibFc
	AczmNIqY0nXCgPHRblktr192RqnVOv+jVLLNO
X-Gm-Gg: ASbGnctiH9V20VYQFVWIfG1VKcTbXhaKhTXh0m6vZ+Las6PyY1wFbb7RJvWbXPNZ4Ep
	8QhKaxodbrBqe1r4N9lENRkSdSfBBCW+Rqg5wBnfUwzYc+hR00QrioM12eZ0VhhEukZdFe1XAlA
	kKXkKBBRkLcy4pDkqzJNYxsUJuvNeU9iLfsPaK7Q==
X-Google-Smtp-Source: AGHT+IF293xeVyj4/wAp5kXWhSXHvlqZ+hGOq5jwSu7o+tmHkKY22JHmZitJTtCcPuuUlKFOv+HkABOvq5lh90WmCTc=
X-Received: by 2002:ac8:7c48:0:b0:471:fb3a:5bfb with SMTP id
 d75a77b69052e-47376e5de43mr4324371cf.1.1740482107770; Tue, 25 Feb 2025
 03:15:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250224-page-alloc-kunit-v1-0-d337bb440889@google.com>
 <20250224-page-alloc-kunit-v1-4-d337bb440889@google.com> <Z7y5vK1M5IOizIWR@google.com>
In-Reply-To: <Z7y5vK1M5IOizIWR@google.com>
From: Brendan Jackman <jackmanb@google.com>
Date: Tue, 25 Feb 2025 12:14:56 +0100
X-Gm-Features: AQ5f1Jr2V__EQDgXK12d3od3hg4EIBPZN4EogawQjt_yGI4eSiDAQDJGxAHmIjU
Message-ID: <CA+i-1C1KL9uJALuU=ZND0U0HQoqihzyH6HoZhdKmmTQP25qDuw@mail.gmail.com>
Subject: Re: [PATCH RFC 4/4] mm/page_alloc_test: Add smoke-test for page allocation
To: Yosry Ahmed <yosry.ahmed@linux.dev>
Cc: Brendan Higgins <brendan.higgins@linux.dev>, David Gow <davidgow@google.com>, 
	Rae Moar <rmoar@google.com>, Andrew Morton <akpm@linux-foundation.org>, 
	David Hildenbrand <david@redhat.com>, Oscar Salvador <osalvador@suse.de>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Vlastimil Babka <vbabka@suse.cz>, 
	Michal Hocko <mhocko@kernel.org>, linux-kselftest@vger.kernel.org, 
	kunit-dev@googlegroups.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 24 Feb 2025 at 19:26, Yosry Ahmed <yosry.ahmed@linux.dev> wrote:
> > +static void action_nodemask_free(void *ctx)
> > +{
> > +     NODEMASK_FREE(ctx);
> > +}
> > +
> > +/*
> > + * Call __alloc_pages_noprof with a nodemask containing only the nid.
> > + *
> > + * Never returns NULL.
> > + */
> > +static inline struct page *alloc_pages_force_nid(struct kunit *test,
> > +                                              gfp_t gfp, int order, int nid)
> > +{
> > +     NODEMASK_ALLOC(nodemask_t, nodemask, GFP_KERNEL);
>
> For the sake of the test can't we just put the nodemask on the stack?

Hm, I think whether or not it's test code is irrelevant to whether we
can put it on the stack. Presumably the nodemask code is written as it
is because nodemasks can be massive, so we can overflow the stack here
just as easily and confusingly as anywhere else.

(I think we're not in a very deep stack here right now but KUnit could
easily change that).

FWIW I think when using the mm/.kunitconfig provided in this series it
does actually go on the stack.

> > +     struct page *page;
> > +
> > +     KUNIT_ASSERT_NOT_NULL(test, nodemask);
> > +     kunit_add_action(test, action_nodemask_free, &nodemask);
>
> Why aren't we just freeing the nodemask after using it, before we make
> any assertions?

I guess that's just a philosophical question, I usually default to
writing KUnit code such that you can throw an assertion in ~anywhere
and things just work.

But, I'm not passionate about it, I would also be fine with freeing it
directly (it would certainly save quite a few lines of code).

> > +/* Generate test cases as the cross product of orders and alloc_fresh_gfps.  */
> > +static const void *alloc_fresh_gen_params(const void *prev, char *desc)
> > +{
> > +     /* Buffer to avoid allocations. */
> > +     static struct alloc_fresh_test_case tc;
> > +
> > +     if (!prev) {
> > +             /* First call */
> > +             tc.order = 0;
> > +             tc.gfp_idx = 0;
> > +             return &tc;
> > +     }
>
> We need to set 'tc' here to whatever 'prev' is pointing at, right?

prev always points at tc (or is NULL). Sounds like it needs a comment
to that effect!

(Note tc is static).

Ack to everything else, thanks for the review!

