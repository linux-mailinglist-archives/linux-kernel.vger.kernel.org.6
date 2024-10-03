Return-Path: <linux-kernel+bounces-348578-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 582EE98E951
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 07:17:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 66BA61C2140A
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 05:17:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76B503EA83;
	Thu,  3 Oct 2024 05:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E9sfGp4q"
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D8B62110E
	for <linux-kernel@vger.kernel.org>; Thu,  3 Oct 2024 05:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727932632; cv=none; b=jqVjyCLL+cIGUDjAEd/CL19VCMxIo1DjTc+LBzI1NqSVjvKFPQFW9fuFjWiPnptExLUnoJ0HBGhQRmp7XhIOhDmq+qCkKaqZESTYjceGIjQY6HuZTSbaJ3HbclkvdPH0mMGLl41hkQm8y49zMt7b1bNqIeGGLxiWYps4kHdNCIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727932632; c=relaxed/simple;
	bh=++JRRUP7EGtJ3T4CE/4Axh2kJYrdwnW5zD98f1H4SDw=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References; b=j7kI9juhGNjWIKfE6YAunf51tlBzlgPvWQA9tOIQreuyMYI8bLHR4D7lNL+Z3qRa10zsvxeVdPJWYESlwuTHdhzc68sUnii0yOXLTFMnXoXO4bnvb9IVkSNVdO/zhdaMairDFnxXcXjQnulmCVh/F0dQUd/MvPSI1zSZ1lHk108=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E9sfGp4q; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-718e285544fso468922b3a.1
        for <linux-kernel@vger.kernel.org>; Wed, 02 Oct 2024 22:17:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727932631; x=1728537431; darn=vger.kernel.org;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=P61WjNBevRMtAfuGcNIvU5lX9OAgdg1UBpDmxbARpHY=;
        b=E9sfGp4qls/8gsqGCuaPeH9QG63Mkgk1Yxo90pn6yDzBKSStpHlhGlT5OeJGZuxEK4
         10yf75R23ktqCHbRvX42Z1OW+/1wryri/v5xw0jVXLeUQ3lEohrOq3fNPK8f7Nnb9geF
         690posNEZ9MSQH0vmrDOZAoELSHGTN/7bKrUeRv6zqcjqTCs1Jvc3v/PcZM9jKpoIsMZ
         KHNakpfv8qqCdjCaIAOyEhNSs0ToCp+3EyyYehBxx99LChTjEdrxvbf3+IYzqccyoNFH
         sZVgfEVKxdIv+eyN3PYF9MxRiLOx4ZTs+VIBccBdPYt+804oCCwpkCptqexGsgkB4w+5
         +D8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727932631; x=1728537431;
        h=references:message-id:date:in-reply-to:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=P61WjNBevRMtAfuGcNIvU5lX9OAgdg1UBpDmxbARpHY=;
        b=aRTnI7GgQbLGhIBlVaL201z1bCPkw4UQhlQmhe1PE6n7erLWZD6IAx1otsMCMgolvM
         tzJ+owwPa4saKqHTMiZqUEMyElWSSNBsQ1vUakuR6oG5ViebWdPGUPulQumb2UFuQDPb
         pT2qOnWjmEer36S6pTbHMkrYxZnd8ItaEm6/gd8QHnvEvqt9X4YKYHrtZuNmAtglGqcH
         2lYKs0JOLyzQ8/o/fzsvy+JbGCSa1MURdybMJ5Y5nK9Yyy9UBmtNIsxHrOSdpWuL2bLJ
         zlyF+lG66pZtt87n7LvaFGQxa+d4AcBiCYfg97wFkpmGL1LpxlsZWEozo3FA6TQn7Ltz
         Q4dA==
X-Forwarded-Encrypted: i=1; AJvYcCWYiimNjit6avHlUn/hh++b/kkxdB3ZdAj3CxEMXCkvrHfficvF7qOmHLSwGKVLuu2a2k4a+uYY2ZCZ9d4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxPvfWWa+innF4ygndaB0jAkR5K2O5ii279sf4u42yasMrcXONs
	L3CUBpph8QzLDjvzRCpdriEyayu03J2JmmqgMlkYWA+NgpvLj0Jv
X-Google-Smtp-Source: AGHT+IGSqOhDYBnasu93qnl5wHf+ezCb1CmvK8YGFgZJKvwFslVJPTu8jAGM36pLvWJ19ve2joTQMQ==
X-Received: by 2002:a05:6a00:1915:b0:717:8489:6318 with SMTP id d2e1a72fcca58-71dc5c6756bmr8301952b3a.10.1727932630532;
        Wed, 02 Oct 2024 22:17:10 -0700 (PDT)
Received: from dw-tp ([171.76.83.199])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71dd9d7e54csm444461b3a.67.2024.10.02.22.17.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Oct 2024 22:17:09 -0700 (PDT)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: linuxppc-dev@lists.ozlabs.org, kasan-dev@googlegroups.com
Cc: Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, Madhavan Srinivasan <maddy@linux.ibm.com>, Christophe Leroy <christophe.leroy@csgroup.eu>, Hari Bathini <hbathini@linux.ibm.com>, "Aneesh Kumar K . V" <aneesh.kumar@kernel.org>, Donet Tom <donettom@linux.vnet.ibm.com>, Pavithra Prakash <pavrampu@linux.vnet.ibm.com>, Nirjhar Roy <nirjhar@linux.ibm.com>, LKML <linux-kernel@vger.kernel.org>, Alexander Potapenko <glider@google.com>, linux-mm@kvack.org, Heiko Carstens <hca@linux.ibm.com>
Subject: Re: [RFC v2 01/13] mm/kfence: Add a new kunit test test_use_after_free_read_nofault()
In-Reply-To: <a8ca8bd5eb4114304b34dd8bac7a6280d358c728.1726571179.git.ritesh.list@gmail.com>
Date: Thu, 03 Oct 2024 10:36:08 +0530
Message-ID: <87cykhydvj.fsf@gmail.com>
References: <cover.1726571179.git.ritesh.list@gmail.com> <a8ca8bd5eb4114304b34dd8bac7a6280d358c728.1726571179.git.ritesh.list@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>


Hello Kasan/kfence-devs, 

Wanted your inputs on this kfence kunit test [PATCH-1] and it's respective
powerpc fix [Patch-2]. The commit msgs has a good description of it. I
see that the same problem was noticed on s390 as well [1] a while ago.
So that makes me believe that maybe we should have a kunit test for the
same to make sure all architectures handles this properly. 

Thoughts?

[1]: https://lore.kernel.org/all/20230213183858.1473681-1-hca@linux.ibm.com/

-ritesh


"Ritesh Harjani (IBM)" <ritesh.list@gmail.com> writes:

> From: Nirjhar Roy <nirjhar@linux.ibm.com>
>
> Faults from copy_from_kernel_nofault() needs to be handled by fixup
> table and should not be handled by kfence. Otherwise while reading
> /proc/kcore which uses copy_from_kernel_nofault(), kfence can generate
> false negatives. This can happen when /proc/kcore ends up reading an
> unmapped address from kfence pool.
>
> Let's add a testcase to cover this case.
>
> Co-developed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
> Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
> Signed-off-by: Nirjhar Roy <nirjhar@linux.ibm.com>
> Cc: kasan-dev@googlegroups.com
> Cc: Alexander Potapenko <glider@google.com>
> Cc: linux-mm@kvack.org
> ---
>  mm/kfence/kfence_test.c | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
>
> diff --git a/mm/kfence/kfence_test.c b/mm/kfence/kfence_test.c
> index 00fd17285285..f65fb182466d 100644
> --- a/mm/kfence/kfence_test.c
> +++ b/mm/kfence/kfence_test.c
> @@ -383,6 +383,22 @@ static void test_use_after_free_read(struct kunit *test)
>  	KUNIT_EXPECT_TRUE(test, report_matches(&expect));
>  }
>
> +static void test_use_after_free_read_nofault(struct kunit *test)
> +{
> +	const size_t size = 32;
> +	char *addr;
> +	char dst;
> +	int ret;
> +
> +	setup_test_cache(test, size, 0, NULL);
> +	addr = test_alloc(test, size, GFP_KERNEL, ALLOCATE_ANY);
> +	test_free(addr);
> +	/* Use after free with *_nofault() */
> +	ret = copy_from_kernel_nofault(&dst, addr, 1);
> +	KUNIT_EXPECT_EQ(test, ret, -EFAULT);
> +	KUNIT_EXPECT_FALSE(test, report_available());
> +}
> +
>  static void test_double_free(struct kunit *test)
>  {
>  	const size_t size = 32;
> @@ -780,6 +796,7 @@ static struct kunit_case kfence_test_cases[] = {
>  	KFENCE_KUNIT_CASE(test_out_of_bounds_read),
>  	KFENCE_KUNIT_CASE(test_out_of_bounds_write),
>  	KFENCE_KUNIT_CASE(test_use_after_free_read),
> +	KFENCE_KUNIT_CASE(test_use_after_free_read_nofault),
>  	KFENCE_KUNIT_CASE(test_double_free),
>  	KFENCE_KUNIT_CASE(test_invalid_addr_free),
>  	KFENCE_KUNIT_CASE(test_corruption),
> --
> 2.46.0

